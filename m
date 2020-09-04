Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76DC925E460
	for <lists+linux-fpga@lfdr.de>; Sat,  5 Sep 2020 01:54:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728355AbgIDXyD (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 4 Sep 2020 19:54:03 -0400
Received: from mga06.intel.com ([134.134.136.31]:64696 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726277AbgIDXxT (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Fri, 4 Sep 2020 19:53:19 -0400
IronPort-SDR: KVRTl1KTa+AfHSdVnyDc+TY5rlGqVncyNBjqW4ptBCJgqmpIDP3/5f1DmyCK8MMlZC0LDQROK4
 G+xmUPNPoV5A==
X-IronPort-AV: E=McAfee;i="6000,8403,9734"; a="219386192"
X-IronPort-AV: E=Sophos;i="5.76,391,1592895600"; 
   d="scan'208";a="219386192"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2020 16:53:16 -0700
IronPort-SDR: YLqLc/x7mHM0QumtFzNG/L8YGrZeq3wayJFuQry1c5Y+sZ2K2flDetyBWcgOmFOE4bkfpM14Db
 +D0QjgpS89HA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,391,1592895600"; 
   d="scan'208";a="284656215"
Received: from rhweight-mobl2.amr.corp.intel.com (HELO rhweight-mobl2.ra.intel.com) ([10.251.151.80])
  by fmsmga008.fm.intel.com with ESMTP; 04 Sep 2020 16:53:15 -0700
From:   Russ Weight <russell.h.weight@intel.com>
To:     mdf@kernel.org, lee.jones@linaro.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, lgoncalv@redhat.com, yilun.xu@intel.com,
        hao.wu@intel.com, matthew.gerlach@intel.com,
        Russ Weight <russell.h.weight@intel.com>
Subject: [PATCH v1 04/12] fpga: expose max10 canceled keys in sysfs
Date:   Fri,  4 Sep 2020 16:52:57 -0700
Message-Id: <20200904235305.6254-5-russell.h.weight@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200904235305.6254-1-russell.h.weight@intel.com>
References: <20200904235305.6254-1-russell.h.weight@intel.com>
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Extend the MAX10 BMC Security Engine driver to provide a
handler to expose the canceled code signing key (CSK) bit
vectors. These use the standard bitmap list format
(e.g. 1,2-6,9).

Signed-off-by: Russ Weight <russell.h.weight@intel.com>
Reviewed-by: Wu Hao <hao.wu@intel.com>
---
 drivers/fpga/intel-m10-bmc-secure.c | 60 +++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/drivers/fpga/intel-m10-bmc-secure.c b/drivers/fpga/intel-m10-bmc-secure.c
index b824790e43aa..46cd49a08be0 100644
--- a/drivers/fpga/intel-m10-bmc-secure.c
+++ b/drivers/fpga/intel-m10-bmc-secure.c
@@ -130,14 +130,74 @@ static int get_qspi_flash_count(struct ifpga_sec_mgr *imgr)
 	return ret ? : cnt;
 }
 
+#define CSK_BIT_LEN			128U
+#define CSK_32ARRAY_SIZE(_nbits)	DIV_ROUND_UP(_nbits, 32)
+
+#define SYSFS_GET_CSK_CANCEL_NBITS(_name) \
+static int get_##_name##_csk_cancel_nbits(struct ifpga_sec_mgr *imgr) \
+{ \
+	return (int)CSK_BIT_LEN; \
+}
+
+SYSFS_GET_CSK_CANCEL_NBITS(bmc)
+SYSFS_GET_CSK_CANCEL_NBITS(sr)
+SYSFS_GET_CSK_CANCEL_NBITS(pr)
+
+static int get_csk_vector(struct ifpga_sec_mgr *imgr, u32 addr,
+			  unsigned long *csk_map, unsigned int nbits)
+{
+	unsigned int i, arr_size = CSK_32ARRAY_SIZE(nbits);
+	struct m10bmc_sec *sec = imgr->priv;
+	u32 *csk32;
+	int ret;
+
+	csk32 = vmalloc(arr_size);
+	if (!csk32)
+		return -ENOMEM;
+
+	ret = m10bmc_raw_bulk_read(sec->m10bmc, addr, csk32, arr_size);
+	if (ret) {
+		dev_err(sec->dev, "%s failed to read %d\n", __func__, ret);
+		goto vfree_exit;
+	}
+
+	for (i = 0; i < arr_size; i++)
+		csk32[i] = le32_to_cpu(csk32[i]);
+
+	bitmap_from_arr32(csk_map, csk32, nbits);
+	bitmap_complement(csk_map, csk_map, nbits);
+
+vfree_exit:
+	vfree(csk32);
+	return ret;
+}
+
+#define SYSFS_GET_CSK_VEC(_name, _addr) \
+static int get_##_name##_canceled_csks(struct ifpga_sec_mgr *imgr, \
+				       unsigned long *csk_map, \
+				       unsigned int nbits) \
+{ return get_csk_vector(imgr, _addr, csk_map, nbits); }
+
+#define CSK_VEC_OFFSET 0x34
+
+SYSFS_GET_CSK_VEC(bmc, BMC_PROG_ADDR + CSK_VEC_OFFSET)
+SYSFS_GET_CSK_VEC(sr, SR_PROG_ADDR + CSK_VEC_OFFSET)
+SYSFS_GET_CSK_VEC(pr, PR_PROG_ADDR + CSK_VEC_OFFSET)
+
 static const struct ifpga_sec_mgr_ops m10bmc_iops = {
 	.user_flash_count = get_qspi_flash_count,
 	.bmc_root_entry_hash = get_bmc_root_entry_hash,
 	.sr_root_entry_hash = get_sr_root_entry_hash,
 	.pr_root_entry_hash = get_pr_root_entry_hash,
+	.bmc_canceled_csks = get_bmc_canceled_csks,
+	.sr_canceled_csks = get_sr_canceled_csks,
+	.pr_canceled_csks = get_pr_canceled_csks,
 	.bmc_reh_size = get_bmc_reh_size,
 	.sr_reh_size = get_sr_reh_size,
 	.pr_reh_size = get_pr_reh_size,
+	.bmc_canceled_csk_nbits = get_bmc_csk_cancel_nbits,
+	.sr_canceled_csk_nbits = get_sr_csk_cancel_nbits,
+	.pr_canceled_csk_nbits = get_pr_csk_cancel_nbits
 };
 
 static void ifpga_sec_mgr_uinit(struct m10bmc_sec *sec)
-- 
2.17.1

