Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A73A866BB63
	for <lists+linux-fpga@lfdr.de>; Mon, 16 Jan 2023 11:13:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbjAPKLI (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 16 Jan 2023 05:11:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbjAPKKI (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 16 Jan 2023 05:10:08 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E2111A950;
        Mon, 16 Jan 2023 02:09:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673863781; x=1705399781;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7c1a48yT3IRJocNE0jaidz3h/FgyEDVK6hdeXFQmnnA=;
  b=JL5Vwgc5IkcQduxtFQbmVvTnUY5FBSfEPDnpCmetx72gzkWwOgzwzM/8
   j0kdHCN6VFIdKsxtIXxgw79CR+RFJ/pTiOkj1p2SZRfbhVmNqNF/peFFj
   nYv6lfITh6zGAw+K9L0nrDLNpsY2K6mvuThfTEbJ1m8ugzj+UVXM0YdCg
   BkytwUQwvrwiBg3qRPq3IVA7lODZZBj0WJqIPmN+o1iHq9NSI6bVtTRii
   KzfFSUBDsB7/qX6jie6/IXiVa2RoVolDLM65w3TXHG9EyWwcvckt972uL
   lLCBZBfECR6FBVLTtOtLLP3k8h9GVYq6KdezgMBT5rRsLLT0OCv/gmlfO
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10591"; a="326489361"
X-IronPort-AV: E=Sophos;i="5.97,220,1669104000"; 
   d="scan'208";a="326489361"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2023 02:09:41 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10591"; a="832785842"
X-IronPort-AV: E=Sophos;i="5.97,220,1669104000"; 
   d="scan'208";a="832785842"
Received: from xsanroma-mobl.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.252.39.155])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2023 02:09:37 -0800
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-fpga@vger.kernel.org, Xu Yilun <yilun.xu@intel.com>,
        Wu Hao <hao.wu@intel.com>, Tom Rix <trix@redhat.com>,
        Moritz Fischer <mdf@kernel.org>, Lee Jones <lee@kernel.org>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        Russ Weight <russell.h.weight@intel.com>,
        Tianfei zhang <tianfei.zhang@intel.com>,
        Mark Brown <broonie@kernel.org>,
        Marco Pagani <marpagan@redhat.com>,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v6 09/11] fpga: m10bmc-sec: Make rsu status type specific
Date:   Mon, 16 Jan 2023 12:08:43 +0200
Message-Id: <20230116100845.6153-10-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230116100845.6153-1-ilpo.jarvinen@linux.intel.com>
References: <20230116100845.6153-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

The rsu status field moves from the doorbell register to the auth
result register in the PMCI implementation of the MAX10 BMC. In order
to prepare for that, refactor the sec update driver code to have a type
specific ops that provides ->rsu_status().

Co-developed-by: Tianfei zhang <tianfei.zhang@intel.com>
Signed-off-by: Tianfei zhang <tianfei.zhang@intel.com>
Co-developed-by: Russ Weight <russell.h.weight@intel.com>
Signed-off-by: Russ Weight <russell.h.weight@intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/fpga/intel-m10-bmc-sec-update.c | 109 +++++++++++++++++-------
 include/linux/mfd/intel-m10-bmc.h       |   1 -
 2 files changed, 78 insertions(+), 32 deletions(-)

diff --git a/drivers/fpga/intel-m10-bmc-sec-update.c b/drivers/fpga/intel-m10-bmc-sec-update.c
index 6e58a463619c..47c0d5c6a4a3 100644
--- a/drivers/fpga/intel-m10-bmc-sec-update.c
+++ b/drivers/fpga/intel-m10-bmc-sec-update.c
@@ -14,6 +14,12 @@
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 
+struct m10bmc_sec;
+
+struct m10bmc_sec_ops {
+	int (*rsu_status)(struct m10bmc_sec *sec);
+};
+
 struct m10bmc_sec {
 	struct device *dev;
 	struct intel_m10bmc *m10bmc;
@@ -21,6 +27,7 @@ struct m10bmc_sec {
 	char *fw_name;
 	u32 fw_name_id;
 	bool cancel_request;
+	const struct m10bmc_sec_ops *ops;
 };
 
 static DEFINE_XARRAY_ALLOC(fw_upload_xa);
@@ -251,12 +258,25 @@ static void log_error_regs(struct m10bmc_sec *sec, u32 doorbell)
 	const struct m10bmc_csr_map *csr_map = sec->m10bmc->info->csr_map;
 	u32 auth_result;
 
-	dev_err(sec->dev, "RSU error status: 0x%08x\n", doorbell);
+	dev_err(sec->dev, "Doorbell: 0x%08x\n", doorbell);
 
 	if (!m10bmc_sys_read(sec->m10bmc, csr_map->auth_result, &auth_result))
 		dev_err(sec->dev, "RSU auth result: 0x%08x\n", auth_result);
 }
 
+static int m10bmc_sec_n3000_rsu_status(struct m10bmc_sec *sec)
+{
+	const struct m10bmc_csr_map *csr_map = sec->m10bmc->info->csr_map;
+	u32 doorbell;
+	int ret;
+
+	ret = m10bmc_sys_read(sec->m10bmc, csr_map->doorbell, &doorbell);
+	if (ret)
+		return ret;
+
+	return FIELD_GET(DRBL_RSU_STATUS, doorbell);
+}
+
 static bool rsu_status_ok(u32 status)
 {
 	return (status == RSU_STAT_NORMAL ||
@@ -279,6 +299,26 @@ static bool rsu_progress_busy(u32 progress)
 		progress == RSU_PROG_PROGRAM_KEY_HASH);
 }
 
+static int m10bmc_sec_progress_status(struct m10bmc_sec *sec, u32 *doorbell_reg,
+				      u32 *progress, u32 *status)
+{
+	const struct m10bmc_csr_map *csr_map = sec->m10bmc->info->csr_map;
+	int ret;
+
+	ret = m10bmc_sys_read(sec->m10bmc, csr_map->doorbell, doorbell_reg);
+	if (ret)
+		return ret;
+
+	ret = sec->ops->rsu_status(sec);
+	if (ret < 0)
+		return ret;
+
+	*status = ret;
+	*progress = rsu_prog(*doorbell_reg);
+
+	return 0;
+}
+
 static enum fw_upload_err rsu_check_idle(struct m10bmc_sec *sec)
 {
 	const struct m10bmc_csr_map *csr_map = sec->m10bmc->info->csr_map;
@@ -297,18 +337,14 @@ static enum fw_upload_err rsu_check_idle(struct m10bmc_sec *sec)
 	return FW_UPLOAD_ERR_NONE;
 }
 
-static inline bool rsu_start_done(u32 doorbell)
+static inline bool rsu_start_done(u32 doorbell_reg, u32 progress, u32 status)
 {
-	u32 status, progress;
-
-	if (doorbell & DRBL_RSU_REQUEST)
+	if (doorbell_reg & DRBL_RSU_REQUEST)
 		return false;
 
-	status = rsu_stat(doorbell);
 	if (status == RSU_STAT_ERASE_FAIL || status == RSU_STAT_WEAROUT)
 		return true;
 
-	progress = rsu_prog(doorbell);
 	if (!rsu_progress_done(progress))
 		return true;
 
@@ -318,8 +354,8 @@ static inline bool rsu_start_done(u32 doorbell)
 static enum fw_upload_err rsu_update_init(struct m10bmc_sec *sec)
 {
 	const struct m10bmc_csr_map *csr_map = sec->m10bmc->info->csr_map;
-	u32 doorbell, status;
-	int ret;
+	u32 doorbell_reg, progress, status;
+	int ret, err;
 
 	ret = regmap_update_bits(sec->m10bmc->regmap,
 				 csr_map->base + csr_map->doorbell,
@@ -330,26 +366,25 @@ static enum fw_upload_err rsu_update_init(struct m10bmc_sec *sec)
 	if (ret)
 		return FW_UPLOAD_ERR_RW_ERROR;
 
-	ret = regmap_read_poll_timeout(sec->m10bmc->regmap,
-				       csr_map->base + csr_map->doorbell,
-				       doorbell,
-				       rsu_start_done(doorbell),
-				       NIOS_HANDSHAKE_INTERVAL_US,
-				       NIOS_HANDSHAKE_TIMEOUT_US);
+	ret = read_poll_timeout(m10bmc_sec_progress_status, err,
+				err < 0 || rsu_start_done(doorbell_reg, progress, status),
+				NIOS_HANDSHAKE_INTERVAL_US,
+				NIOS_HANDSHAKE_TIMEOUT_US,
+				false,
+				sec, &doorbell_reg, &progress, &status);
 
 	if (ret == -ETIMEDOUT) {
-		log_error_regs(sec, doorbell);
+		log_error_regs(sec, doorbell_reg);
 		return FW_UPLOAD_ERR_TIMEOUT;
-	} else if (ret) {
+	} else if (err) {
 		return FW_UPLOAD_ERR_RW_ERROR;
 	}
 
-	status = rsu_stat(doorbell);
 	if (status == RSU_STAT_WEAROUT) {
 		dev_warn(sec->dev, "Excessive flash update count detected\n");
 		return FW_UPLOAD_ERR_WEAROUT;
 	} else if (status == RSU_STAT_ERASE_FAIL) {
-		log_error_regs(sec, doorbell);
+		log_error_regs(sec, doorbell_reg);
 		return FW_UPLOAD_ERR_HW_ERROR;
 	}
 
@@ -393,7 +428,7 @@ static enum fw_upload_err rsu_prog_ready(struct m10bmc_sec *sec)
 static enum fw_upload_err rsu_send_data(struct m10bmc_sec *sec)
 {
 	const struct m10bmc_csr_map *csr_map = sec->m10bmc->info->csr_map;
-	u32 doorbell;
+	u32 doorbell_reg, status;
 	int ret;
 
 	ret = regmap_update_bits(sec->m10bmc->regmap,
@@ -406,40 +441,45 @@ static enum fw_upload_err rsu_send_data(struct m10bmc_sec *sec)
 
 	ret = regmap_read_poll_timeout(sec->m10bmc->regmap,
 				       csr_map->base + csr_map->doorbell,
-				       doorbell,
-				       rsu_prog(doorbell) != RSU_PROG_READY,
+				       doorbell_reg,
+				       rsu_prog(doorbell_reg) != RSU_PROG_READY,
 				       NIOS_HANDSHAKE_INTERVAL_US,
 				       NIOS_HANDSHAKE_TIMEOUT_US);
 
 	if (ret == -ETIMEDOUT) {
-		log_error_regs(sec, doorbell);
+		log_error_regs(sec, doorbell_reg);
 		return FW_UPLOAD_ERR_TIMEOUT;
 	} else if (ret) {
 		return FW_UPLOAD_ERR_RW_ERROR;
 	}
 
-	if (!rsu_status_ok(rsu_stat(doorbell))) {
-		log_error_regs(sec, doorbell);
+	ret = sec->ops->rsu_status(sec);
+	if (ret < 0)
+		return ret;
+	status = ret;
+
+	if (!rsu_status_ok(status)) {
+		log_error_regs(sec, doorbell_reg);
 		return FW_UPLOAD_ERR_HW_ERROR;
 	}
 
 	return FW_UPLOAD_ERR_NONE;
 }
 
-static int rsu_check_complete(struct m10bmc_sec *sec, u32 *doorbell)
+static int rsu_check_complete(struct m10bmc_sec *sec, u32 *doorbell_reg)
 {
-	const struct m10bmc_csr_map *csr_map = sec->m10bmc->info->csr_map;
+	u32 progress, status;
 
-	if (m10bmc_sys_read(sec->m10bmc, csr_map->doorbell, doorbell))
+	if (m10bmc_sec_progress_status(sec, doorbell_reg, &progress, &status))
 		return -EIO;
 
-	if (!rsu_status_ok(rsu_stat(*doorbell)))
+	if (!rsu_status_ok(status))
 		return -EINVAL;
 
-	if (rsu_progress_done(rsu_prog(*doorbell)))
+	if (rsu_progress_done(progress))
 		return 0;
 
-	if (rsu_progress_busy(rsu_prog(*doorbell)))
+	if (rsu_progress_busy(progress))
 		return -EAGAIN;
 
 	return -EINVAL;
@@ -592,6 +632,10 @@ static const struct fw_upload_ops m10bmc_ops = {
 	.cleanup = m10bmc_sec_cleanup,
 };
 
+static const struct m10bmc_sec_ops m10sec_n3000_ops = {
+	.rsu_status = m10bmc_sec_n3000_rsu_status,
+};
+
 #define SEC_UPDATE_LEN_MAX 32
 static int m10bmc_sec_probe(struct platform_device *pdev)
 {
@@ -607,6 +651,7 @@ static int m10bmc_sec_probe(struct platform_device *pdev)
 
 	sec->dev = &pdev->dev;
 	sec->m10bmc = dev_get_drvdata(pdev->dev.parent);
+	sec->ops = (struct m10bmc_sec_ops *)platform_get_device_id(pdev)->driver_data;
 	dev_set_drvdata(&pdev->dev, sec);
 
 	ret = xa_alloc(&fw_upload_xa, &sec->fw_name_id, sec,
@@ -654,9 +699,11 @@ static int m10bmc_sec_remove(struct platform_device *pdev)
 static const struct platform_device_id intel_m10bmc_sec_ids[] = {
 	{
 		.name = "n3000bmc-sec-update",
+		.driver_data = (kernel_ulong_t)&m10sec_n3000_ops,
 	},
 	{
 		.name = "d5005bmc-sec-update",
+		.driver_data = (kernel_ulong_t)&m10sec_n3000_ops,
 	},
 	{ }
 };
diff --git a/include/linux/mfd/intel-m10-bmc.h b/include/linux/mfd/intel-m10-bmc.h
index 470dc3773c01..1f75b33240ad 100644
--- a/include/linux/mfd/intel-m10-bmc.h
+++ b/include/linux/mfd/intel-m10-bmc.h
@@ -91,7 +91,6 @@
 #define HOST_STATUS_ABORT_RSU		0x2
 
 #define rsu_prog(doorbell)	FIELD_GET(DRBL_RSU_PROGRESS, doorbell)
-#define rsu_stat(doorbell)	FIELD_GET(DRBL_RSU_STATUS, doorbell)
 
 /* interval 100ms and timeout 5s */
 #define NIOS_HANDSHAKE_INTERVAL_US	(100 * 1000)
-- 
2.30.2

