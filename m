Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 828F3282007
	for <lists+linux-fpga@lfdr.de>; Sat,  3 Oct 2020 03:24:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725813AbgJCBY3 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 2 Oct 2020 21:24:29 -0400
Received: from mga14.intel.com ([192.55.52.115]:5543 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725536AbgJCBYV (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Fri, 2 Oct 2020 21:24:21 -0400
IronPort-SDR: oJ6K9GMr9+Sw6oFJrjFBspQ7tkrmvnh3XgcyOUN8JxEQOXSohNr33bf9gnpbrDm7gHJCkOQsNd
 ENWoEkmIawFA==
X-IronPort-AV: E=McAfee;i="6000,8403,9762"; a="162363109"
X-IronPort-AV: E=Sophos;i="5.77,329,1596524400"; 
   d="scan'208";a="162363109"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2020 18:24:20 -0700
IronPort-SDR: C4UkmbtByggALfSI66COSHvl/FWhenHPdlCi5lZOiqrZIdGEZFTOug2Zt8qD2HdA3zu/FHDcI8
 WIStJDwias+Q==
X-IronPort-AV: E=Sophos;i="5.77,329,1596524400"; 
   d="scan'208";a="516097867"
Received: from rhweight-mobl2.amr.corp.intel.com (HELO rhweight-mobl2.ra.intel.com) ([10.254.5.53])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2020 18:24:19 -0700
From:   Russ Weight <russell.h.weight@intel.com>
To:     mdf@kernel.org, lee.jones@linaro.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, lgoncalv@redhat.com, yilun.xu@intel.com,
        hao.wu@intel.com, matthew.gerlach@intel.com,
        Russ Weight <russell.h.weight@intel.com>
Subject: [PATCH v2 4/6] fpga: m10bmc-sec: expose max10 canceled keys in sysfs
Date:   Fri,  2 Oct 2020 18:24:10 -0700
Message-Id: <20201003012412.16831-5-russell.h.weight@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201003012412.16831-1-russell.h.weight@intel.com>
References: <20201003012412.16831-1-russell.h.weight@intel.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Extend the MAX10 BMC Security Engine driver to provide a
handler to expose the canceled code signing key (CSK) bit
vectors in sysfs. These use the standard bitmap list format
(e.g. 1,2-6,9).

Signed-off-by: Russ Weight <russell.h.weight@intel.com>
---
v2:
  - Replaced small function-creation macros for explicit function
    declarations.
  - Fixed get_csk_vector() function to properly apply the stride
    variable in calls to m10bmc_raw_bulk_read()
  - Added m10bmc_ prefix to functions in m10bmc_iops structure
---
 drivers/fpga/intel-m10-bmc-secure.c | 72 +++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/drivers/fpga/intel-m10-bmc-secure.c b/drivers/fpga/intel-m10-bmc-secure.c
index da61cfda3c50..5bb45499b332 100644
--- a/drivers/fpga/intel-m10-bmc-secure.c
+++ b/drivers/fpga/intel-m10-bmc-secure.c
@@ -135,14 +135,86 @@ static int m10bmc_user_flash_count(struct ifpga_sec_mgr *imgr)
 	return ret;
 }
 
+#define CSK_BIT_LEN			128U
+#define CSK_32ARRAY_SIZE(_nbits)	DIV_ROUND_UP(_nbits, 32)
+
+static int m10bmc_csk_cancel_nbits(struct ifpga_sec_mgr *imgr)
+{
+	return (int)CSK_BIT_LEN;
+}
+
+static int get_csk_vector(struct ifpga_sec_mgr *imgr, u32 addr,
+			  unsigned long *csk_map, unsigned int nbits)
+{
+	unsigned int i, size, arr_size = CSK_32ARRAY_SIZE(nbits);
+	struct m10bmc_sec *sec = imgr->priv;
+	unsigned int stride;
+	u32 *csk32;
+	int ret;
+
+	stride = regmap_get_reg_stride(sec->m10bmc->regmap);
+	size = arr_size * sizeof(u32);
+	csk32 = vmalloc(size);
+	if (!csk32)
+		return -ENOMEM;
+
+	ret = m10bmc_raw_bulk_read(sec->m10bmc, addr, csk32, size / stride);
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
+#define CSK_VEC_OFFSET 0x34
+
+static int m10bmc_bmc_canceled_csks(struct ifpga_sec_mgr *imgr,
+				    unsigned long *csk_map,
+				    unsigned int nbits)
+{
+	return get_csk_vector(imgr, BMC_PROG_ADDR + CSK_VEC_OFFSET,
+			      csk_map, nbits);
+}
+
+static int m10bmc_sr_canceled_csks(struct ifpga_sec_mgr *imgr,
+				   unsigned long *csk_map,
+				   unsigned int nbits)
+{
+	return get_csk_vector(imgr, SR_PROG_ADDR + CSK_VEC_OFFSET,
+			      csk_map, nbits);
+}
+
+static int m10bmc_pr_canceled_csks(struct ifpga_sec_mgr *imgr,
+				   unsigned long *csk_map,
+				   unsigned int nbits)
+{
+	return get_csk_vector(imgr, PR_PROG_ADDR + CSK_VEC_OFFSET,
+			      csk_map, nbits);
+}
+
 static const struct ifpga_sec_mgr_ops m10bmc_iops = {
 	.user_flash_count = m10bmc_user_flash_count,
 	.bmc_root_entry_hash = m10bmc_bmc_root_entry_hash,
 	.sr_root_entry_hash = m10bmc_sr_root_entry_hash,
 	.pr_root_entry_hash = m10bmc_pr_root_entry_hash,
+	.bmc_canceled_csks = m10bmc_bmc_canceled_csks,
+	.sr_canceled_csks = m10bmc_sr_canceled_csks,
+	.pr_canceled_csks = m10bmc_pr_canceled_csks,
 	.bmc_reh_size = m10bmc_bmc_reh_size,
 	.sr_reh_size = m10bmc_sr_reh_size,
 	.pr_reh_size = m10bmc_pr_reh_size,
+	.bmc_canceled_csk_nbits = m10bmc_csk_cancel_nbits,
+	.sr_canceled_csk_nbits = m10bmc_csk_cancel_nbits,
+	.pr_canceled_csk_nbits = m10bmc_csk_cancel_nbits,
 };
 
 static int m10bmc_secure_probe(struct platform_device *pdev)
-- 
2.17.1

