Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 904FC6D1875
	for <lists+linux-fpga@lfdr.de>; Fri, 31 Mar 2023 09:21:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231194AbjCaHTU (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 31 Mar 2023 03:19:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231139AbjCaHTL (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 31 Mar 2023 03:19:11 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 006051B7F0;
        Fri, 31 Mar 2023 00:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1680247143; x=1711783143;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rqsv7idTC/49WihFfW/y4x+Ev8rxS2Q5n4iNB5ovm4w=;
  b=WbvG1cVdFN5ju0esuA2tCQLjQpdOkwr82bonCRk5D+EmY32WRha3HDnT
   JnsRNyvspyJxfcq8PZ3phk0Tmh0o74rh5Pd2MxQzDppMbNrQrkQqKoumW
   PHOQy4jRQ0AOAN+MHdbEuHxS82gbvgL8hcjl3IiAtZtELx7iTnkDDAJoG
   LljK7jc4vjkP9/zIWjuBUbLdWGYqIdZflq5KHtI6P1PZa6JWCoU/IFalp
   dvG76WAl9Ypkxx/PJ0rqWo3xzqvfxVxBORANZLYJo0DMh1xfhVA830l0j
   Guicx+W5p6EBBqTkd5Ez4hBR86Y2F3IQpvMhM9AqIlAbbUNdFdTZlA7Mv
   w==;
X-IronPort-AV: E=Sophos;i="5.98,307,1673938800"; 
   d="scan'208";a="204349788"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 31 Mar 2023 00:19:00 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 31 Mar 2023 00:18:58 -0700
Received: from wendy.microchip.com (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.21 via Frontend
 Transport; Fri, 31 Mar 2023 00:18:56 -0700
From:   Conor Dooley <conor.dooley@microchip.com>
To:     <linux-fpga@vger.kernel.org>
CC:     <conor@kernel.org>, <conor.dooley@microchip.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
        <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 6/7] fpga: add PolarFire SoC Auto Update support
Date:   Fri, 31 Mar 2023 08:18:22 +0100
Message-ID: <20230331071823.956087-7-conor.dooley@microchip.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230331071823.956087-1-conor.dooley@microchip.com>
References: <20230331071823.956087-1-conor.dooley@microchip.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=19171; i=conor.dooley@microchip.com; h=from:subject; bh=rqsv7idTC/49WihFfW/y4x+Ev8rxS2Q5n4iNB5ovm4w=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDClqnVain2LPnrnDfulgvk5pfddiNtkZ5/fKT3+m2MH5qHOi etWSjlIWBjEOBlkxRZbE230tUuv/uOxw7nkLM4eVCWQIAxenAEzkdBMjw90Ksc2PzQ4axe384O21+L vwV+PNj061n75sqybotuNbshwjw3L5y8dex0zVebnnwiFNpfqns5Y1s6U4bTrEwvQwj31hIRcA
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Add support for Auto Update reprogramming of the FPGA fabric on
PolarFire SoC, using the fw_upload mechanism a la the
intel-m10-bmc-sec-update driver.

This driver only writes the image to the spi flash & performs
validation on it, as the entire FPGA becomes unusable during the actual
reprogramming of a bitstream. To initiate the reprogramming itself, a
device reset is required.
The SBI SRST extension's "cold reboot" can trigger such a device reset,
by means of a "Tamper Macro" in the FPGA fabric, provided corresponding
support has been enabled in the HSS (Hart Software Services).

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 drivers/fpga/Kconfig                 |  11 +
 drivers/fpga/Makefile                |   3 +-
 drivers/fpga/microchip-auto-update.c | 494 +++++++++++++++++++++++++++
 3 files changed, 507 insertions(+), 1 deletion(-)
 create mode 100644 drivers/fpga/microchip-auto-update.c

diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
index 0a00763b9f28..2838ce7ddafe 100644
--- a/drivers/fpga/Kconfig
+++ b/drivers/fpga/Kconfig
@@ -257,6 +257,17 @@ config FPGA_M10_BMC_SEC_UPDATE
 	  (BMC) and provides support for secure updates for the BMC image,
 	  the FPGA image, the Root Entry Hashes, etc.
 
+config FPGA_MICROCHIP_AUTO_UPDATE
+	tristate "Microchip PolarFire SoC AUTO UPDATE"
+	depends on POLARFIRE_SOC_SYS_CTRL
+	select FW_LOADER
+	select FW_UPLOAD
+	help
+	  FPGA manager driver support for reprogramming PolarFire SoC from
+	  within Linux, using the Auto Upgrade feature of the system controller.
+
+	  If built as a module, it will be called microchip-auto-update.
+
 config FPGA_MGR_MICROCHIP_SPI
 	tristate "Microchip Polarfire SPI FPGA manager"
 	depends on SPI
diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
index 72e554b4d2f7..0b1ba6db860d 100644
--- a/drivers/fpga/Makefile
+++ b/drivers/fpga/Makefile
@@ -25,8 +25,9 @@ obj-$(CONFIG_FPGA_MGR_LATTICE_SYSCONFIG_SPI)	+= lattice-sysconfig-spi.o
 obj-$(CONFIG_ALTERA_PR_IP_CORE)		+= altera-pr-ip-core.o
 obj-$(CONFIG_ALTERA_PR_IP_CORE_PLAT)	+= altera-pr-ip-core-plat.o
 
-# FPGA Secure Update Drivers
+# FPGA Firmware Upload Drivers
 obj-$(CONFIG_FPGA_M10_BMC_SEC_UPDATE)	+= intel-m10-bmc-sec-update.o
+obj-$(CONFIG_FPGA_MICROCHIP_AUTO_UPDATE)	+= microchip-auto-update.o
 
 # FPGA Bridge Drivers
 obj-$(CONFIG_FPGA_BRIDGE)		+= fpga-bridge.o
diff --git a/drivers/fpga/microchip-auto-update.c b/drivers/fpga/microchip-auto-update.c
new file mode 100644
index 000000000000..5fa920b659c6
--- /dev/null
+++ b/drivers/fpga/microchip-auto-update.c
@@ -0,0 +1,494 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Microchip Polarfire SoC "Auto Update" FPGA reprogramming.
+ *
+ * Documentation of this functionality is available in the "PolarFire® FPGA and
+ * PolarFire SoC FPGA Programming" User Guide.
+ *
+ * Copyright (c) 2022-2023 Microchip Corporation. All rights reserved.
+ *
+ * Author: Conor Dooley <conor.dooley@microchip.com>
+ */
+#include <linux/debugfs.h>
+#include <linux/firmware.h>
+#include <linux/math.h>
+#include <linux/module.h>
+#include <linux/mtd/mtd.h>
+#include <linux/of_device.h>
+#include <linux/sizes.h>
+
+#include <soc/microchip/mpfs.h>
+
+#define AUTO_UPDATE_DEFAULT_MBOX_OFFSET		0u
+#define AUTO_UPDATE_DEFAULT_RESP_OFFSET		0u
+
+#define AUTO_UPDATE_FEATURE_CMD_OPCODE		0x05u
+#define AUTO_UPDATE_FEATURE_CMD_DATA_SIZE	0u
+#define AUTO_UPDATE_FEATURE_RESP_SIZE		33u
+#define AUTO_UPDATE_FEATURE_CMD_DATA		NULL
+#define AUTO_UPDATE_FEATURE_ENABLED		BIT(5)
+
+#define AUTO_UPDATE_AUTHENTICATE_CMD_OPCODE	0x22u
+#define AUTO_UPDATE_AUTHENTICATE_CMD_DATA_SIZE	0u
+#define AUTO_UPDATE_AUTHENTICATE_RESP_SIZE	1u
+#define AUTO_UPDATE_AUTHENTICATE_CMD_DATA	NULL
+
+#define AUTO_UPDATE_PROGRAM_CMD_OPCODE		0x46u
+#define AUTO_UPDATE_PROGRAM_CMD_DATA_SIZE	0u
+#define AUTO_UPDATE_PROGRAM_RESP_SIZE		1u
+#define AUTO_UPDATE_PROGRAM_CMD_DATA		NULL
+
+/*
+ * SPI Flash layout example:
+ * |------------------------------| 0x0000000
+ * | 1 KiB                        |
+ * | SPI "directories"            |
+ * |------------------------------| 0x0000400
+ * | 1 MiB                        |
+ * | Reserved area                |
+ * | Used for bitstream info      |
+ * |------------------------------| 0x0100400
+ * | 20 MiB                       |
+ * | Golden Image                 |
+ * |------------------------------| 0x1500400
+ * | 20 MiB                       |
+ * | Auto Upgrade Image           |
+ * |------------------------------| 0x2900400
+ * | 20 MiB                       |
+ * | Reserved for multi-image IAP |
+ * | Unused for Auto Upgrade      |
+ * |------------------------------| 0x3D00400
+ * | ? B                          |
+ * | Unused                       |
+ * |------------------------------| 0x?
+ */
+#define AUTO_UPDATE_DIRECTORY_BASE	0u
+#define AUTO_UPDATE_DIRECTORY_WIDTH	4u
+#define AUTO_UPDATE_GOLDEN_INDEX	0u
+#define AUTO_UPDATE_UPGRADE_INDEX	1u
+#define AUTO_UPDATE_BLANK_INDEX		2u
+#define AUTO_UPDATE_GOLDEN_DIRECTORY	(AUTO_UPDATE_DIRECTORY_WIDTH * AUTO_UPDATE_GOLDEN_INDEX)
+#define AUTO_UPDATE_UPGRADE_DIRECTORY	(AUTO_UPDATE_DIRECTORY_WIDTH * AUTO_UPDATE_UPGRADE_INDEX)
+#define AUTO_UPDATE_BLANK_DIRECTORY	(AUTO_UPDATE_DIRECTORY_WIDTH * AUTO_UPDATE_BLANK_INDEX)
+#define AUTO_UPDATE_DIRECTORY_SIZE	SZ_1K
+#define AUTO_UPDATE_RESERVED_SIZE	SZ_1M
+#define AUTO_UPDATE_BITSTREAM_BASE	(AUTO_UPDATE_DIRECTORY_SIZE + AUTO_UPDATE_RESERVED_SIZE)
+
+#define AUTO_UPDATE_TIMEOUT_MS		60000
+
+struct mpfs_auto_update_priv {
+	struct mpfs_sys_controller *sys_controller;
+	struct device *dev;
+	struct mtd_info *flash;
+	struct fw_upload *fw_uploader;
+	struct completion programming_complete;
+	size_t size_per_bitstream;
+	bool cancel_request;
+};
+
+static enum fw_upload_err mpfs_auto_update_prepare(struct fw_upload *fw_uploader, const u8 *data,
+						   u32 size)
+{
+	struct mpfs_auto_update_priv *priv = fw_uploader->dd_handle;
+	size_t erase_size = AUTO_UPDATE_DIRECTORY_SIZE;
+
+	/*
+	 * Verifying the Golden Image is idealistic. It will be evaluated
+	 * against the currently programmed image and thus may fail - due to
+	 * either rollback protection (if its an older version than that in use)
+	 * or if the version is the same as that of the in-use image.
+	 * Extracting the information as to why a failure occurred is not
+	 * currently possible due to limitations of the system controller
+	 * driver. If those are fixed, verification of the Golden Image should
+	 * be added here.
+	 */
+
+	priv->flash = mpfs_sys_controller_get_flash(priv->sys_controller);
+	if (!priv->flash)
+		return FW_UPLOAD_ERR_HW_ERROR;
+
+	erase_size = round_up(erase_size, (u64)priv->flash->erasesize);
+
+	/*
+	 * We need to calculate if we have enough space in the flash for the
+	 * new image.
+	 * First, chop off the first 1 KiB as it's reserved for the directory.
+	 * The 1 MiB reserved for design info needs to be ignored also.
+	 * All that remains is carved into 3 & rounded down to the erasesize.
+	 * If this is smaller than the image size, we abort.
+	 * There's also no need to consume more than 20 MiB per image.
+	 */
+	priv->size_per_bitstream = priv->flash->size - SZ_1K - SZ_1M;
+	priv->size_per_bitstream = round_down(priv->size_per_bitstream / 3, erase_size);
+	if (priv->size_per_bitstream > 20 * SZ_1M)
+		priv->size_per_bitstream = 20 * SZ_1M;
+
+	if (priv->size_per_bitstream < size) {
+		dev_err(priv->dev,
+			"flash device has insufficient capacity to store this bitstream\n");
+		return FW_UPLOAD_ERR_INVALID_SIZE;
+	}
+
+	priv->cancel_request = false;
+
+	return FW_UPLOAD_ERR_NONE;
+}
+
+static void mpfs_auto_update_cancel(struct fw_upload *fw_uploader)
+{
+	struct mpfs_auto_update_priv *priv = fw_uploader->dd_handle;
+
+	priv->cancel_request = true;
+}
+
+static enum fw_upload_err mpfs_auto_update_poll_complete(struct fw_upload *fw_uploader)
+{
+	struct mpfs_auto_update_priv *priv = fw_uploader->dd_handle;
+	int ret;
+
+	/*
+	 * There is no meaningful way to get the status of the programming while
+	 * it is in progress, so attempting anything other than waiting for it
+	 * to complete would be misplaced.
+	 */
+	ret = wait_for_completion_timeout(&priv->programming_complete,
+					  msecs_to_jiffies(AUTO_UPDATE_TIMEOUT_MS));
+	if (ret)
+		return FW_UPLOAD_ERR_TIMEOUT;
+
+	return FW_UPLOAD_ERR_NONE;
+}
+
+static int mpfs_auto_update_verify_image(struct fw_upload *fw_uploader)
+{
+	struct mpfs_auto_update_priv *priv = fw_uploader->dd_handle;
+	struct mpfs_mss_response *response;
+	struct mpfs_mss_msg *message;
+	u32 *response_msg;
+	int ret;
+
+	response_msg = devm_kzalloc(priv->dev, AUTO_UPDATE_FEATURE_RESP_SIZE * sizeof(response_msg),
+				    GFP_KERNEL);
+	if (!response_msg)
+		return -ENOMEM;
+
+	response = devm_kzalloc(priv->dev, sizeof(struct mpfs_mss_response), GFP_KERNEL);
+	if (!response) {
+		ret = -ENOMEM;
+		goto free_response_msg;
+	}
+
+	message = devm_kzalloc(priv->dev, sizeof(struct mpfs_mss_msg), GFP_KERNEL);
+	if (!message) {
+		ret = -ENOMEM;
+		goto free_response;
+	}
+
+	/*
+	 * The system controller can verify that an image in the flash is valid.
+	 * Rather than duplicate the check in this driver, call the relevant
+	 * service from the system controller instead.
+	 * This service has no command data and no response data. It overloads
+	 * mbox_offset with the image index in the flash's SPI directory where
+	 * the bitstream is located.
+	 */
+	response->resp_msg = response_msg;
+	response->resp_size = AUTO_UPDATE_AUTHENTICATE_RESP_SIZE;
+	message->cmd_opcode = AUTO_UPDATE_AUTHENTICATE_CMD_OPCODE;
+	message->cmd_data_size = AUTO_UPDATE_AUTHENTICATE_CMD_DATA_SIZE;
+	message->response = response;
+	message->cmd_data = AUTO_UPDATE_AUTHENTICATE_CMD_DATA;
+	message->mbox_offset = AUTO_UPDATE_UPGRADE_INDEX;
+	message->resp_offset = AUTO_UPDATE_DEFAULT_RESP_OFFSET;
+
+	dev_info(priv->dev, "Running verification of Upgrade Image\n");
+	ret = mpfs_blocking_transaction(priv->sys_controller, message);
+	if (ret | response->resp_status) {
+		dev_warn(priv->dev, "Verification of Upgrade Image failed!\n");
+		ret = ret ? ret : -EBADMSG;
+	}
+
+	dev_info(priv->dev, "Verification of Upgrade Image passed!\n");
+
+	devm_kfree(priv->dev, message);
+free_response:
+	devm_kfree(priv->dev, response);
+free_response_msg:
+	devm_kfree(priv->dev, response_msg);
+
+	return ret;
+}
+
+static int mpfs_auto_update_set_image_address(struct mpfs_auto_update_priv *priv, char *buffer,
+					      u32 image_address, loff_t directory_address)
+{
+	struct erase_info erase;
+	size_t erase_size = AUTO_UPDATE_DIRECTORY_SIZE;
+	size_t bytes_written = 0, bytes_read = 0;
+	int ret;
+
+	erase_size = round_up(erase_size, (u64)priv->flash->erasesize);
+
+	erase.addr = AUTO_UPDATE_DIRECTORY_BASE;
+	erase.len = erase_size;
+
+	/*
+	 * We need to write the "SPI DIRECTORY" to the first 1 KiB, telling
+	 * the system controller where to find the actual bitstream. Since
+	 * this is spi-nor, we have to read the first eraseblock, erase that
+	 * portion of the flash, modify the data and then write it back.
+	 * There's no need to do this though if things are already the way they
+	 * should be, so check and save the write in that case.
+	 */
+	ret = mtd_read(priv->flash, AUTO_UPDATE_DIRECTORY_BASE, erase_size, &bytes_read,
+		       (u_char *)buffer);
+	if (ret)
+		return ret;
+
+	if (bytes_read != erase_size)
+		return -EIO;
+
+	if ((*(u32 *)(buffer + AUTO_UPDATE_UPGRADE_DIRECTORY) == image_address) &&
+	    !(*(u32 *)(buffer + AUTO_UPDATE_BLANK_DIRECTORY)))
+		return 0;
+
+	ret = mtd_erase(priv->flash, &erase);
+	if (ret)
+		return ret;
+
+	/*
+	 * Populate the image address and then zero out the next directory so
+	 * that the system controller doesn't complain if in "Single Image"
+	 * mode.
+	 */
+	memcpy(buffer + AUTO_UPDATE_UPGRADE_DIRECTORY, &image_address,
+	       AUTO_UPDATE_DIRECTORY_WIDTH);
+	memset(buffer + AUTO_UPDATE_BLANK_DIRECTORY, 0x0, AUTO_UPDATE_DIRECTORY_WIDTH);
+
+	dev_info(priv->dev, "Writing the image address (%x) to the flash directory (%llx)\n",
+		 image_address, directory_address);
+
+	ret = mtd_write(priv->flash, 0x0, erase_size, &bytes_written, (u_char *)buffer);
+	if (ret)
+		return ret;
+
+	if (bytes_written != erase_size)
+		return ret;
+
+	return 0;
+}
+
+static int mpfs_auto_update_write_bitstream(struct fw_upload *fw_uploader, const u8 *data,
+					    u32 offset, u32 size, u32 *written)
+{
+	struct mpfs_auto_update_priv *priv = fw_uploader->dd_handle;
+	struct erase_info erase;
+	char *buffer;
+	loff_t directory_address = AUTO_UPDATE_UPGRADE_DIRECTORY;
+	size_t erase_size = AUTO_UPDATE_DIRECTORY_SIZE;
+	size_t bytes_written = 0;
+	u32 image_address;
+	int ret;
+
+	erase_size = round_up(erase_size, (u64)priv->flash->erasesize);
+
+	image_address = AUTO_UPDATE_BITSTREAM_BASE +
+		AUTO_UPDATE_UPGRADE_INDEX * priv->size_per_bitstream;
+
+	buffer = devm_kzalloc(priv->dev, erase_size, GFP_KERNEL);
+	if (!buffer)
+		return -ENOMEM;
+
+	ret = mpfs_auto_update_set_image_address(priv, buffer, image_address, directory_address);
+	if (ret) {
+		dev_err(priv->dev, "failed to set image address in the SPI directory: %d\n", ret);
+		goto out;
+	}
+
+	/*
+	 * Now the .spi image itself can be written to the flash. Preservation
+	 * of contents here is not important here, unlike the spi "directory"
+	 * which must be RMWed.
+	 */
+	erase.len = round_up(size, (size_t)priv->flash->erasesize);
+	erase.addr = image_address;
+
+	dev_info(priv->dev, "Erasing the flash at address (%x)\n", image_address);
+	ret = mtd_erase(priv->flash, &erase);
+	if (ret)
+		goto out;
+
+	/*
+	 * No parsing etc of the bitstream is required. The system controller
+	 * will do all of that itself - including verifying that the bitstream
+	 * is valid.
+	 */
+	dev_info(priv->dev, "Writing the image to the flash at address (%x)\n", image_address);
+	ret = mtd_write(priv->flash, (loff_t)image_address, size, &bytes_written, data);
+	if (ret)
+		goto out;
+
+	if (bytes_written != size) {
+		ret = -EIO;
+		goto out;
+	}
+
+	*written = bytes_written;
+
+out:
+	devm_kfree(priv->dev, buffer);
+	return ret;
+}
+
+static enum fw_upload_err mpfs_auto_update_write(struct fw_upload *fw_uploader, const u8 *data,
+						 u32 offset, u32 size, u32 *written)
+{
+	struct mpfs_auto_update_priv *priv = fw_uploader->dd_handle;
+	enum fw_upload_err err = FW_UPLOAD_ERR_NONE;
+	int ret;
+
+	reinit_completion(&priv->programming_complete);
+
+	ret = mpfs_auto_update_write_bitstream(fw_uploader, data, offset, size, written);
+	if (ret) {
+		err = FW_UPLOAD_ERR_RW_ERROR;
+		goto out;
+	}
+
+	if (priv->cancel_request) {
+		err = FW_UPLOAD_ERR_CANCELED;
+		goto out;
+	}
+
+	ret = mpfs_auto_update_verify_image(fw_uploader);
+	if (ret)
+		err = FW_UPLOAD_ERR_HW_ERROR;
+
+out:
+	complete(&priv->programming_complete);
+
+	return err;
+}
+
+static const struct fw_upload_ops mpfs_auto_update_ops = {
+	.prepare = mpfs_auto_update_prepare,
+	.write = mpfs_auto_update_write,
+	.poll_complete = mpfs_auto_update_poll_complete,
+	.cancel = mpfs_auto_update_cancel,
+};
+
+static int mpfs_auto_update_available(struct mpfs_auto_update_priv *priv)
+{
+	struct mpfs_mss_response *response;
+	struct mpfs_mss_msg *message;
+	u32 *response_msg;
+	int ret;
+
+	response_msg = devm_kzalloc(priv->dev, AUTO_UPDATE_FEATURE_RESP_SIZE * sizeof(response_msg),
+				    GFP_KERNEL);
+	if (!response_msg)
+		return -ENOMEM;
+
+	response = devm_kzalloc(priv->dev, sizeof(struct mpfs_mss_response), GFP_KERNEL);
+	if (!response)
+		return -ENOMEM;
+
+	message = devm_kzalloc(priv->dev, sizeof(struct mpfs_mss_msg), GFP_KERNEL);
+	if (!message)
+		return -ENOMEM;
+
+	/*
+	 * To verify that Auto Update is possible, the "Query Security Service
+	 * Request" is performed.
+	 * This service has no command data & does not overload mbox_offset.
+	 */
+	response->resp_msg = response_msg;
+	response->resp_size = AUTO_UPDATE_FEATURE_RESP_SIZE;
+	message->cmd_opcode = AUTO_UPDATE_FEATURE_CMD_OPCODE;
+	message->cmd_data_size = AUTO_UPDATE_FEATURE_CMD_DATA_SIZE;
+	message->response = response;
+	message->cmd_data = AUTO_UPDATE_FEATURE_CMD_DATA;
+	message->mbox_offset = AUTO_UPDATE_DEFAULT_MBOX_OFFSET;
+	message->resp_offset = AUTO_UPDATE_DEFAULT_RESP_OFFSET;
+
+	ret = mpfs_blocking_transaction(priv->sys_controller, message);
+	if (ret)
+		return ret;
+
+	/*
+	 * Currently, the system controller's firmware does not generate any
+	 * interrupts for failed services, so mpfs_blocking_transaction() should
+	 * time out & therefore return an error.
+	 * Hitting this check is highly unlikely at present, but if the system
+	 * controller's behaviour changes so that it does generate interrupts
+	 * for failed services, it will be required.
+	 */
+	if (response->resp_status)
+		return -EIO;
+
+	/*
+	 * Bit 5 of byte 1 is "UL_Auto Update" & if it is set, Auto Update is
+	 * not possible.
+	 */
+	if (response_msg[1] & AUTO_UPDATE_FEATURE_ENABLED)
+		return -EPERM;
+
+	return 0;
+}
+
+static int mpfs_auto_update_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct mpfs_auto_update_priv *priv;
+	struct fw_upload *fw_uploader;
+	int ret;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->sys_controller = mpfs_sys_controller_get(dev);
+	if (IS_ERR(priv->sys_controller))
+		return dev_err_probe(dev, PTR_ERR(priv->sys_controller),
+				     "Could not register as a sub device of the system controller\n");
+
+	priv->dev = dev;
+	platform_set_drvdata(pdev, priv);
+
+	ret = mpfs_auto_update_available(priv);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "The current bitstream does not support auto-update\n");
+
+	init_completion(&priv->programming_complete);
+
+	fw_uploader = firmware_upload_register(THIS_MODULE, dev, "mpfs_bitstream",
+					       &mpfs_auto_update_ops, priv);
+	if (IS_ERR(fw_uploader))
+		return dev_err_probe(dev, PTR_ERR(fw_uploader),
+				     "Failed to register the bitstream uploader\n");
+
+	priv->fw_uploader = fw_uploader;
+
+	return 0;
+}
+
+static void mpfs_auto_update_remove(struct platform_device *pdev)
+{
+	struct mpfs_auto_update_priv *priv = platform_get_drvdata(pdev);
+
+	firmware_upload_unregister(priv->fw_uploader);
+}
+
+static struct platform_driver mpfs_auto_update_driver = {
+	.driver = {
+		.name = "mpfs-auto-update",
+	},
+	.probe = mpfs_auto_update_probe,
+	.remove_new = mpfs_auto_update_remove,
+};
+module_platform_driver(mpfs_auto_update_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Conor Dooley <conor.dooley@microchip.com>");
+MODULE_DESCRIPTION("PolarFire SoC Auto Update FPGA reprogramming");
-- 
2.39.2

