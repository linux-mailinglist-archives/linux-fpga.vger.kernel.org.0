Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4E87287FE3
	for <lists+linux-fpga@lfdr.de>; Fri,  9 Oct 2020 03:14:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730418AbgJIBOh (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 8 Oct 2020 21:14:37 -0400
Received: from mga17.intel.com ([192.55.52.151]:13075 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730285AbgJIBOc (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 8 Oct 2020 21:14:32 -0400
IronPort-SDR: 13CYQu0t6OMjEFK0gk6NCP7/XpifvDmlL8wBTKjbyBgUrCn219Ie44+9pgArtqqcJXzCunt8R0
 1hoN3xGiFO4w==
X-IronPort-AV: E=McAfee;i="6000,8403,9768"; a="145294139"
X-IronPort-AV: E=Sophos;i="5.77,353,1596524400"; 
   d="scan'208";a="145294139"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2020 18:14:31 -0700
IronPort-SDR: vOy4a/S+LnRuwVTvhdv6Nflr610SqpiC/gJ+Naa3xQ4trmb5Kp6EJ5zHePk2xPXCfw+4zmC81P
 +Hlk1dk/Mwgg==
X-IronPort-AV: E=Sophos;i="5.77,353,1596524400"; 
   d="scan'208";a="462002360"
Received: from rhweight-mobl2.amr.corp.intel.com (HELO rhweight-mobl2.ra.intel.com) ([10.254.33.152])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2020 18:14:30 -0700
From:   Russ Weight <russell.h.weight@intel.com>
To:     mdf@kernel.org, lee.jones@linaro.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, lgoncalv@redhat.com, yilun.xu@intel.com,
        hao.wu@intel.com, matthew.gerlach@intel.com,
        Russ Weight <russell.h.weight@intel.com>
Subject: [PATCH v3 4/6] fpga: m10bmc-sec: expose max10 canceled keys in sysfs
Date:   Thu,  8 Oct 2020 18:14:21 -0700
Message-Id: <20201009011423.22741-5-russell.h.weight@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201009011423.22741-1-russell.h.weight@intel.com>
References: <20201009011423.22741-1-russell.h.weight@intel.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Extend the MAX10 BMC Secure Update driver to provide a
handler to expose the canceled code signing key (CSK) bit
vectors in sysfs. These use the standard bitmap list format
(e.g. 1,2-6,9).

Signed-off-by: Russ Weight <russell.h.weight@intel.com>
Reviewed-by: Tom Rix <trix@redhat.com>
---
v3:
  - Changed: iops -> sops, imgr -> smgr, IFPGA_ -> FPGA_, ifpga_ to fpga_
  - Changed "MAX10 BMC Secure Engine driver" to "MAX10 BMC Secure Update
    driver"
  - Removed wrapper functions (m10bmc_raw_*, m10bmc_sys_*). The
    underlying functions are now called directly.
  - Renamed get_csk_vector() to m10bmc_csk_vector()
v2:
  - Replaced small function-creation macros for explicit function
    declarations.
  - Fixed get_csk_vector() function to properly apply the stride
    variable in calls to m10bmc_raw_bulk_read()
  - Added m10bmc_ prefix to functions in m10bmc_iops structure
---
 drivers/fpga/intel-m10-bmc-secure.c | 73 +++++++++++++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/drivers/fpga/intel-m10-bmc-secure.c b/drivers/fpga/intel-m10-bmc-secure.c
index e1fb7f7aa3e2..6dca28292567 100644
--- a/drivers/fpga/intel-m10-bmc-secure.c
+++ b/drivers/fpga/intel-m10-bmc-secure.c
@@ -138,14 +138,87 @@ static int m10bmc_user_flash_count(struct fpga_sec_mgr *smgr)
 	return ret;
 }
 
+#define CSK_BIT_LEN			128U
+#define CSK_32ARRAY_SIZE(_nbits)	DIV_ROUND_UP(_nbits, 32)
+
+static int m10bmc_csk_cancel_nbits(struct fpga_sec_mgr *smgr)
+{
+	return (int)CSK_BIT_LEN;
+}
+
+static int m10bmc_csk_vector(struct fpga_sec_mgr *smgr, u32 addr,
+			     unsigned long *csk_map, unsigned int nbits)
+{
+	unsigned int i, size, arr_size = CSK_32ARRAY_SIZE(nbits);
+	struct m10bmc_sec *sec = smgr->priv;
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
+	ret = regmap_bulk_read(sec->m10bmc->regmap, addr, csk32, size / stride);
+	if (ret) {
+		dev_err(sec->dev, "failed to read CSK vector: %x cnt %x: %d\n",
+			addr, size / stride, ret);
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
+static int m10bmc_bmc_canceled_csks(struct fpga_sec_mgr *smgr,
+				    unsigned long *csk_map,
+				    unsigned int nbits)
+{
+	return m10bmc_csk_vector(smgr, BMC_PROG_ADDR + CSK_VEC_OFFSET,
+				 csk_map, nbits);
+}
+
+static int m10bmc_sr_canceled_csks(struct fpga_sec_mgr *smgr,
+				   unsigned long *csk_map,
+				   unsigned int nbits)
+{
+	return m10bmc_csk_vector(smgr, SR_PROG_ADDR + CSK_VEC_OFFSET,
+				 csk_map, nbits);
+}
+
+static int m10bmc_pr_canceled_csks(struct fpga_sec_mgr *smgr,
+				   unsigned long *csk_map,
+				   unsigned int nbits)
+{
+	return m10bmc_csk_vector(smgr, PR_PROG_ADDR + CSK_VEC_OFFSET,
+				 csk_map, nbits);
+}
+
 static const struct fpga_sec_mgr_ops m10bmc_sops = {
 	.user_flash_count = m10bmc_user_flash_count,
 	.bmc_root_entry_hash = m10bmc_bmc_reh,
 	.sr_root_entry_hash = m10bmc_sr_reh,
 	.pr_root_entry_hash = m10bmc_pr_reh,
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

