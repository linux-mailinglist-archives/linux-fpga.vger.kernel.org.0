Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71C43513F28
	for <lists+linux-fpga@lfdr.de>; Fri, 29 Apr 2022 01:41:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231478AbiD1XmB (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 28 Apr 2022 19:42:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353323AbiD1XlD (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 28 Apr 2022 19:41:03 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4DF62CCA1;
        Thu, 28 Apr 2022 16:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651189066; x=1682725066;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mtSGOVAHCKz39WSsyBVZL0q7glU0WOoJ5gVAttONJ10=;
  b=GJLFubZH7yHSeNBqTsciOPUHmIOm8dcoVKpWw8WPguMg6e1uuDl8oSV2
   ZIc9wiSOAs0pURzT/7KIH3pF/KY6A7srHWouktJ7DSUKDbrDBKmKnT4+X
   FRvhD090o/vIHAXHxrqIEDqwXCfnwooLfLYMrjpQSjWV62Do6AGzKi1kP
   bzI1LzeHRukcBuR2vFNKDUJwMotwlfa1elCCmIIsI+xFkCx3CSSGu2Rgb
   VLRos3AjRIx0Wm71o0FVagrgrFBrTutedBi9vZTL3v1twwT5lcrKVUIHH
   xYWytlGukuTB0BPs1mOzwP6qJBKDiGIgHFE/3ABZfr5bCrL/fNUmWXi0s
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10331"; a="265987672"
X-IronPort-AV: E=Sophos;i="5.91,296,1647327600"; 
   d="scan'208";a="265987672"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2022 16:37:45 -0700
X-IronPort-AV: E=Sophos;i="5.91,296,1647327600"; 
   d="scan'208";a="731766382"
Received: from rhweight-mobl.amr.corp.intel.com (HELO rhweight-mobl.ra.intel.com) ([10.212.153.220])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2022 16:37:44 -0700
From:   Russ Weight <russell.h.weight@intel.com>
To:     mdf@kernel.org, hao.wu@intel.com, yilun.xu@intel.com,
        lee.jones@linaro.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, marpagan@redhat.com, lgoncalv@redhat.com,
        matthew.gerlach@linux.intel.com,
        basheer.ahmed.muddebihal@intel.com, tianfei.zhang@intel.com,
        Russ Weight <russell.h.weight@intel.com>
Subject: [PATCH v17 5/5] fpga: cardbmc-sec: add card BMC secure update functions
Date:   Thu, 28 Apr 2022 16:37:32 -0700
Message-Id: <20220428233732.189425-6-russell.h.weight@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220428233732.189425-1-russell.h.weight@intel.com>
References: <20220428233732.189425-1-russell.h.weight@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Create firmware upload ops and call the Firmware Upload support of the
Firmware Loader subsystem to enable FPGA image uploads for secure
updates of BMC images, FPGA images, etc.

Signed-off-by: Russ Weight <russell.h.weight@intel.com>
---
v17:
  - Change "m10bmc" in symbol names to "cardbmc" to reflect the fact that the
    future devices will not necessarily use the MAX10.
  - Change from image_load class driver to the new firmware_upload 
    functionality of the firmware_loader.
  - fw_upload_ops functions will return "enum fw_upload_err" data types
    instead of integer values.
v16:
  - Use 0 instead of FPGA_IMAGE_ERR_NONE to indicate success.
  - The size alignment check was moved from the FPGA Image Load framework
    to the prepare() op.
  - Added cancel_request boolean flag to struct m10bmc_sec.
  - Moved the RSU cancellation logic from m10bmc_sec_cancel() to a new
    rsu_cancel() function.
  - The m10bmc_sec_cancel() function ONLY sets the cancel_request flag.
    The cancel_request flag is checked at the beginning of the
    m10bmc_sec_write() and m10bmc_sec_poll_complete() functions.
  - Adapt to changed prototypes for the prepare() and write() ops. The
    m10bmc_sec_write_blk() function has been renamed to
    m10bmc_sec_write().
  - Created a cleanup() op, m10bmc_sec_cleanup(), to attempt to cancel an
    ongoing op during when exiting the update process.
v15:
  - Adapted to changes in the FPGA Image Load framework:
    (1) All enum types (progress and errors) are now type u32
    (2) m10bmc_sec_write_blk() adds *blk_size and max_size parameters
        and uses *blk_size as provided by the caller.
    (3) m10bmc_sec_poll_complete() no long checks the driver_unload
        flag.
v14:
  - Changed symbol names to reflect the renaming of the Security Manager
    Class driver to FPGA Image Load.
v13:
  - No change
v12:
  - Updated Date and KernelVersion fields in ABI documentation
  - Removed size parameter from the write_blk() op. m10bmc_sec_write_blk()
    no longer has a size parameter, and the block size is determined
    in this (the lower-level) driver.
v11:
  - No change
v10:
  - No change
v9:
  - No change
v8:
  - Previously patch 5/6, otherwise no change
v7:
  - No change
v6:
  - Changed (size / stride) calculation to ((size + stride - 1) / stride)
    to ensure that the proper count is passed to regmap_bulk_write().
  - Removed unnecessary call to rsu_check_complete() in
    m10bmc_sec_poll_complete() and changed while loop to
    do/while loop.
v5:
  - No change
v4:
  - No change
v3:
  - Changed: iops -> sops, imgr -> smgr, IFPGA_ -> FPGA_, ifpga_ to fpga_
  - Changed "MAX10 BMC Secure Engine driver" to "MAX10 BMC Secure Update
    driver"
  - Removed wrapper functions (m10bmc_raw_*, m10bmc_sys_*). The
    underlying functions are now called directly.
  - Changed calling functions of functions that return "enum fpga_sec_err"
    to check for (ret != FPGA_SEC_ERR_NONE) instead of (ret)
v2:
  - Reworked the rsu_start_done() function to make it more readable
  - Reworked while-loop condition/content in rsu_prog_ready()
  - Minor code cleanup per review comments
  - Added a comment to the m10bmc_sec_poll_complete() function to
    explain the context (could take 30+ minutes to complete).
  - Added m10bmc_ prefix to functions in m10bmc_iops structure
  - Moved MAX10 BMC address and function definitions to a separate
    patch.
 drivers/fpga/intel-cardbmc-sec-update.c | 338 +++++++++++++++++++++++-
 1 file changed, 337 insertions(+), 1 deletion(-)

diff --git a/drivers/fpga/intel-cardbmc-sec-update.c b/drivers/fpga/intel-cardbmc-sec-update.c
index 0b268d925e0a..67e1c9c46080 100644
--- a/drivers/fpga/intel-cardbmc-sec-update.c
+++ b/drivers/fpga/intel-cardbmc-sec-update.c
@@ -19,6 +19,7 @@ struct bmc_sec {
 	struct fw_upload *fwl;
 	char *fw_name;
 	u32 fw_name_id;
+	bool cancel_request;
 };
 
 static DEFINE_XARRAY_ALLOC(fw_upload_xa);
@@ -185,7 +186,342 @@ static const struct attribute_group *bmc_sec_attr_groups[] = {
 	NULL,
 };
 
-static const struct fw_upload_ops cardbmc_ops = { };
+static void log_error_regs(struct bmc_sec *sec, u32 doorbell)
+{
+	u32 auth_result;
+
+	dev_err(sec->dev, "RSU error status: 0x%08x\n", doorbell);
+
+	if (!m10bmc_sys_read(sec->m10bmc, M10BMC_AUTH_RESULT, &auth_result))
+		dev_err(sec->dev, "RSU auth result: 0x%08x\n", auth_result);
+}
+
+static enum fw_upload_err rsu_check_idle(struct bmc_sec *sec)
+{
+	u32 doorbell;
+	int ret;
+
+	ret = m10bmc_sys_read(sec->m10bmc, M10BMC_DOORBELL, &doorbell);
+	if (ret)
+		return FW_UPLOAD_ERR_RW_ERROR;
+
+	if (rsu_prog(doorbell) != RSU_PROG_IDLE &&
+	    rsu_prog(doorbell) != RSU_PROG_RSU_DONE) {
+		log_error_regs(sec, doorbell);
+		return FW_UPLOAD_ERR_BUSY;
+	}
+
+	return FW_UPLOAD_ERR_NONE;
+}
+
+static inline bool rsu_start_done(u32 doorbell)
+{
+	u32 status, progress;
+
+	if (doorbell & DRBL_RSU_REQUEST)
+		return false;
+
+	status = rsu_stat(doorbell);
+	if (status == RSU_STAT_ERASE_FAIL || status == RSU_STAT_WEAROUT)
+		return true;
+
+	progress = rsu_prog(doorbell);
+	if (progress != RSU_PROG_IDLE && progress != RSU_PROG_RSU_DONE)
+		return true;
+
+	return false;
+}
+
+static enum fw_upload_err rsu_update_init(struct bmc_sec *sec)
+{
+	u32 doorbell, status;
+	int ret;
+
+	ret = regmap_update_bits(sec->m10bmc->regmap,
+				 M10BMC_SYS_BASE + M10BMC_DOORBELL,
+				 DRBL_RSU_REQUEST | DRBL_HOST_STATUS,
+				 DRBL_RSU_REQUEST |
+				 FIELD_PREP(DRBL_HOST_STATUS,
+					    HOST_STATUS_IDLE));
+	if (ret)
+		return FW_UPLOAD_ERR_RW_ERROR;
+
+	ret = regmap_read_poll_timeout(sec->m10bmc->regmap,
+				       M10BMC_SYS_BASE + M10BMC_DOORBELL,
+				       doorbell,
+				       rsu_start_done(doorbell),
+				       NIOS_HANDSHAKE_INTERVAL_US,
+				       NIOS_HANDSHAKE_TIMEOUT_US);
+
+	if (ret == -ETIMEDOUT) {
+		log_error_regs(sec, doorbell);
+		return FW_UPLOAD_ERR_TIMEOUT;
+	} else if (ret) {
+		return FW_UPLOAD_ERR_RW_ERROR;
+	}
+
+	status = rsu_stat(doorbell);
+	if (status == RSU_STAT_WEAROUT) {
+		dev_warn(sec->dev, "Excessive flash update count detected\n");
+		return FW_UPLOAD_ERR_WEAROUT;
+	} else if (status == RSU_STAT_ERASE_FAIL) {
+		log_error_regs(sec, doorbell);
+		return FW_UPLOAD_ERR_HW_ERROR;
+	}
+
+	return FW_UPLOAD_ERR_NONE;
+}
+
+static enum fw_upload_err rsu_prog_ready(struct bmc_sec *sec)
+{
+	unsigned long poll_timeout;
+	u32 doorbell, progress;
+	int ret;
+
+	ret = m10bmc_sys_read(sec->m10bmc, M10BMC_DOORBELL, &doorbell);
+	if (ret)
+		return FW_UPLOAD_ERR_RW_ERROR;
+
+	poll_timeout = jiffies + msecs_to_jiffies(RSU_PREP_TIMEOUT_MS);
+	while (rsu_prog(doorbell) == RSU_PROG_PREPARE) {
+		msleep(RSU_PREP_INTERVAL_MS);
+		if (time_after(jiffies, poll_timeout))
+			break;
+
+		ret = m10bmc_sys_read(sec->m10bmc, M10BMC_DOORBELL, &doorbell);
+		if (ret)
+			return FW_UPLOAD_ERR_RW_ERROR;
+	}
+
+	progress = rsu_prog(doorbell);
+	if (progress == RSU_PROG_PREPARE) {
+		log_error_regs(sec, doorbell);
+		return FW_UPLOAD_ERR_TIMEOUT;
+	} else if (progress != RSU_PROG_READY) {
+		log_error_regs(sec, doorbell);
+		return FW_UPLOAD_ERR_HW_ERROR;
+	}
+
+	return FW_UPLOAD_ERR_NONE;
+}
+
+static enum fw_upload_err rsu_send_data(struct bmc_sec *sec)
+{
+	u32 doorbell;
+	int ret;
+
+	ret = regmap_update_bits(sec->m10bmc->regmap,
+				 M10BMC_SYS_BASE + M10BMC_DOORBELL,
+				 DRBL_HOST_STATUS,
+				 FIELD_PREP(DRBL_HOST_STATUS,
+					    HOST_STATUS_WRITE_DONE));
+	if (ret)
+		return FW_UPLOAD_ERR_RW_ERROR;
+
+	ret = regmap_read_poll_timeout(sec->m10bmc->regmap,
+				       M10BMC_SYS_BASE + M10BMC_DOORBELL,
+				       doorbell,
+				       rsu_prog(doorbell) != RSU_PROG_READY,
+				       NIOS_HANDSHAKE_INTERVAL_US,
+				       NIOS_HANDSHAKE_TIMEOUT_US);
+
+	if (ret == -ETIMEDOUT) {
+		log_error_regs(sec, doorbell);
+		return FW_UPLOAD_ERR_TIMEOUT;
+	} else if (ret) {
+		return FW_UPLOAD_ERR_RW_ERROR;
+	}
+
+	switch (rsu_stat(doorbell)) {
+	case RSU_STAT_NORMAL:
+	case RSU_STAT_NIOS_OK:
+	case RSU_STAT_USER_OK:
+	case RSU_STAT_FACTORY_OK:
+		break;
+	default:
+		log_error_regs(sec, doorbell);
+		return FW_UPLOAD_ERR_HW_ERROR;
+	}
+
+	return FW_UPLOAD_ERR_NONE;
+}
+
+static int rsu_check_complete(struct bmc_sec *sec, u32 *doorbell)
+{
+	if (m10bmc_sys_read(sec->m10bmc, M10BMC_DOORBELL, doorbell))
+		return -EIO;
+
+	switch (rsu_stat(*doorbell)) {
+	case RSU_STAT_NORMAL:
+	case RSU_STAT_NIOS_OK:
+	case RSU_STAT_USER_OK:
+	case RSU_STAT_FACTORY_OK:
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	switch (rsu_prog(*doorbell)) {
+	case RSU_PROG_IDLE:
+	case RSU_PROG_RSU_DONE:
+		return 0;
+	case RSU_PROG_AUTHENTICATING:
+	case RSU_PROG_COPYING:
+	case RSU_PROG_UPDATE_CANCEL:
+	case RSU_PROG_PROGRAM_KEY_HASH:
+		return -EAGAIN;
+	default:
+		return -EINVAL;
+	}
+}
+
+static enum fw_upload_err rsu_cancel(struct bmc_sec *sec)
+{
+	u32 doorbell;
+	int ret;
+
+	ret = m10bmc_sys_read(sec->m10bmc, M10BMC_DOORBELL, &doorbell);
+	if (ret)
+		return FW_UPLOAD_ERR_RW_ERROR;
+
+	if (rsu_prog(doorbell) != RSU_PROG_READY)
+		return FW_UPLOAD_ERR_BUSY;
+
+	ret = regmap_update_bits(sec->m10bmc->regmap,
+				 M10BMC_SYS_BASE + M10BMC_DOORBELL,
+				 DRBL_HOST_STATUS,
+				 FIELD_PREP(DRBL_HOST_STATUS,
+					    HOST_STATUS_ABORT_RSU));
+	if (ret)
+		return FW_UPLOAD_ERR_RW_ERROR;
+
+	return FW_UPLOAD_ERR_CANCELED;
+}
+
+static enum fw_upload_err bmc_sec_prepare(struct fw_upload *fwl,
+					  const u8 *data, u32 size)
+{
+	struct bmc_sec *sec = fwl->dd_handle;
+	u32 ret;
+
+	sec->cancel_request = false;
+
+	if (!size || size & 0x3 || size > M10BMC_STAGING_SIZE)
+		return FW_UPLOAD_ERR_INVALID_SIZE;
+
+	ret = rsu_check_idle(sec);
+	if (ret != FW_UPLOAD_ERR_NONE)
+		return ret;
+
+	ret = rsu_update_init(sec);
+	if (ret != FW_UPLOAD_ERR_NONE)
+		return ret;
+
+	ret = rsu_prog_ready(sec);
+	if (ret != FW_UPLOAD_ERR_NONE)
+		return ret;
+
+	if (sec->cancel_request)
+		return rsu_cancel(sec);
+
+	return FW_UPLOAD_ERR_NONE;
+}
+
+#define WRITE_BLOCK_SIZE 0x4000	/* Default write-block size is 0x4000 bytes */
+
+static enum fw_upload_err bmc_sec_write(struct fw_upload *fwl, const u8 *data,
+					u32 offset, u32 size, u32 *written)
+{
+	struct bmc_sec *sec = fwl->dd_handle;
+	unsigned int stride = regmap_get_reg_stride(sec->m10bmc->regmap);
+	u32 blk_size, doorbell;
+	int ret;
+
+	if (sec->cancel_request)
+		return rsu_cancel(sec);
+
+	ret = m10bmc_sys_read(sec->m10bmc, M10BMC_DOORBELL, &doorbell);
+	if (ret) {
+		return FW_UPLOAD_ERR_RW_ERROR;
+	} else if (rsu_prog(doorbell) != RSU_PROG_READY) {
+		log_error_regs(sec, doorbell);
+		return FW_UPLOAD_ERR_HW_ERROR;
+	}
+
+	blk_size = min_t(u32, WRITE_BLOCK_SIZE, size);
+	ret = regmap_bulk_write(sec->m10bmc->regmap,
+				M10BMC_STAGING_BASE + offset,
+				(void *)data + offset,
+				(blk_size + stride - 1) / stride);
+
+	if (ret)
+		return FW_UPLOAD_ERR_RW_ERROR;
+
+	*written = blk_size;
+	return FW_UPLOAD_ERR_NONE;
+}
+
+static enum fw_upload_err bmc_sec_poll_complete(struct fw_upload *fwl)
+{
+	struct bmc_sec *sec = fwl->dd_handle;
+	unsigned long poll_timeout;
+	u32 doorbell, result;
+	int ret;
+
+	if (sec->cancel_request)
+		return rsu_cancel(sec);
+
+	result = rsu_send_data(sec);
+	if (result != FW_UPLOAD_ERR_NONE)
+		return result;
+
+	poll_timeout = jiffies + msecs_to_jiffies(RSU_COMPLETE_TIMEOUT_MS);
+	do {
+		msleep(RSU_COMPLETE_INTERVAL_MS);
+		ret = rsu_check_complete(sec, &doorbell);
+	} while (ret == -EAGAIN && !time_after(jiffies, poll_timeout));
+
+	if (ret == -EAGAIN) {
+		log_error_regs(sec, doorbell);
+		return FW_UPLOAD_ERR_TIMEOUT;
+	} else if (ret == -EIO) {
+		return FW_UPLOAD_ERR_RW_ERROR;
+	} else if (ret) {
+		log_error_regs(sec, doorbell);
+		return FW_UPLOAD_ERR_HW_ERROR;
+	}
+
+	return FW_UPLOAD_ERR_NONE;
+}
+
+/*
+ * bmc_sec_cancel() may be called asynchronously with an on-going update.
+ * All other functions are called sequentially in a single thread. To avoid
+ * contention on register accesses, bmc_sec_cancel() must only update
+ * the cancel_request flag. Other functions will check this flag and handle
+ * the cancel request synchronously.
+ */
+static void bmc_sec_cancel(struct fw_upload *fwl)
+{
+	struct bmc_sec *sec = fwl->dd_handle;
+
+	sec->cancel_request = true;
+}
+
+static void bmc_sec_cleanup(struct fw_upload *fwl)
+{
+	struct bmc_sec *sec = fwl->dd_handle;
+
+	(void)rsu_cancel(sec);
+}
+
+static const struct fw_upload_ops cardbmc_ops = {
+	.prepare = bmc_sec_prepare,
+	.write = bmc_sec_write,
+	.poll_complete = bmc_sec_poll_complete,
+	.cancel = bmc_sec_cancel,
+	.cleanup = bmc_sec_cleanup,
+};
 
 #define SEC_UPDATE_LEN_MAX 32
 static int bmc_sec_probe(struct platform_device *pdev)
-- 
2.25.1

