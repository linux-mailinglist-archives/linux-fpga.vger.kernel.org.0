Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10E35633035
	for <lists+linux-fpga@lfdr.de>; Tue, 22 Nov 2022 00:00:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231642AbiKUW6X (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 21 Nov 2022 17:58:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231887AbiKUW6T (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 21 Nov 2022 17:58:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E04B8A8C0E
        for <linux-fpga@vger.kernel.org>; Mon, 21 Nov 2022 14:58:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D8000614C0
        for <linux-fpga@vger.kernel.org>; Mon, 21 Nov 2022 22:58:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A2E3C433D7;
        Mon, 21 Nov 2022 22:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669071495;
        bh=W0P6xuHiS8NnEQpO48dULxDLoC9pWPPcAwXTPq05zj8=;
        h=From:To:Cc:Subject:Date:From;
        b=HDvKOLcGm4saXevRo1O60gTSte1s/Hd5fb7R1LiFJKXy4eBdwFGxuc4NPwnWIOy1i
         i1F+Zl5XjBhmOU/ZDuuYIGm+1S91N1AV+QVm4Ebglf3ZWK5cZQcbJ/qhhK4ZoT5U0K
         Bum4xbLVT0NNhvhvY91pSQRCr8vrxS2kWeCY6qhiDrPmGAH2Ox3TurAt94sO5JapHY
         PWNUv92DLzKlCjNn/386uWWDpk5TpIpgRlKMMjTbi8BZuIANOnb0Xgkga/Au77a8AV
         NVK5LPicfUZ3rshO2TkRA1CZp+9NCNn0WCjcibeN7wYCjy8upGLMkoVWZwwzp0c+qm
         rbTklacXVK1eQ==
From:   Conor Dooley <conor@kernel.org>
To:     linux-fpga@vger.kernel.org
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        Cyril Jean <cyril.jean@microchip.com>,
        Wu Hao <hao.wu@intel.com>, Xu Yilun <yilun.xu@intel.com>,
        Tom Rix <trix@redhat.com>, Moritz Fischer <mdf@kernel.org>,
        linux-riscv@lists.infradead.org
Subject: [RFC] fpga: add PolarFire SoC IAP support
Date:   Mon, 21 Nov 2022 22:57:49 +0000
Message-Id: <20221121225748.124900-1-conor@kernel.org>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Conor Dooley <conor.dooley@microchip.com>

Add support for "IAP" reprogramming of the FPGA fabric on PolarFire SoC.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---

Hey all,
RFC yadda yadda, but not asking people to look at the code per se -
really what I am sending this RFC to achieve is a bit of feedback on
what the re-programming "flow" looks like.

PolarFire and the SoC variants are flash FPGAs. All well and good for
PolarFire, but for PolarFire SoC in IAP mode it is re-programmed from
the on-board SoC. The spi-slave stuff that Ivan upstreamed recently
works too, but that's only when you have an external programmer.

IAP, or In Application Programming, a programming running on the cpu
cores writes the FPGA bitstream, or I suppose "firmware" in Linux land,
out to a flash chip which the system then will use to reprogram the
FPGA. When IAP is initiated, the system controller will take the FPGA
down completely & do the reprogramming. This means, once Linux (or some
other program) kicks off the re-programming (in write_complete() below)
the system will *immediately* power cycle, whether the reprogramming
passes or not. You can see in my write_complete() implementation, that I
do not expect the function to return, unless we catch an error case early.

From my cursory looking around, there doesnt appear to me to be all that
much info in-tree about what each FPGA does when you reprogram it, but
it doesn't appear that for other FPGAs the CPUs get shut down during
this kind of self-reprogramming?

The alternative approach would be to use the "auto update" mode, which
just installs an image that will not be used until the FPGA is rebooted
in the regular way. Then, on reboot, the system controller would pluck
the image from its flash chip and program the FPGA with it. From the
last time I looked at the documentation (and the implementations) it
seemed that people had custom (and out of tree) ways to initiate/handle
the programming, so perhaps I have the freedom to do the "auto update"
approach, even if it may be a little different to other implementations?

If I've missed something, please let me know. I hope I have!

I've only recently got a board capable of testing this & have not yet
tested my code here in anger etc, it's just the high level thoughts
about how to approach the re-programming in an FPGA manager friendly way
that I'm looking for comments on.

@LKP folks, if you happen to see this - you can disable building this
patch, it won't without some dependencies ;)

Thanks,
Conor.
---
 drivers/fpga/Kconfig         |   6 +
 drivers/fpga/Makefile        |   1 +
 drivers/fpga/microchip-iap.c | 350 +++++++++++++++++++++++++++++++++++
 3 files changed, 357 insertions(+)
 create mode 100644 drivers/fpga/microchip-iap.c

diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
index 6c416955da53..525d753a28a4 100644
--- a/drivers/fpga/Kconfig
+++ b/drivers/fpga/Kconfig
@@ -255,6 +255,12 @@ config FPGA_M10_BMC_SEC_UPDATE
 	  (BMC) and provides support for secure updates for the BMC image,
 	  the FPGA image, the Root Entry Hashes, etc.
 
+config FPGA_MGR_MICROCHIP_IAP
+	tristate "Microchip Polarfire IAP FPGA manager"
+	depends on POLARFIRE_SOC_SYS_CTRL
+	help
+	  NOP
+
 config FPGA_MGR_MICROCHIP_SPI
 	tristate "Microchip Polarfire SPI FPGA manager"
 	depends on SPI
diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
index 42ae8b58abce..df1dfb54046b 100644
--- a/drivers/fpga/Makefile
+++ b/drivers/fpga/Makefile
@@ -19,6 +19,7 @@ obj-$(CONFIG_FPGA_MGR_XILINX_SPI)	+= xilinx-spi.o
 obj-$(CONFIG_FPGA_MGR_ZYNQ_FPGA)	+= zynq-fpga.o
 obj-$(CONFIG_FPGA_MGR_ZYNQMP_FPGA)	+= zynqmp-fpga.o
 obj-$(CONFIG_FPGA_MGR_VERSAL_FPGA)	+= versal-fpga.o
+obj-$(CONFIG_FPGA_MGR_MICROCHIP_IAP)	+= microchip-iap.o
 obj-$(CONFIG_FPGA_MGR_MICROCHIP_SPI)	+= microchip-spi.o
 obj-$(CONFIG_ALTERA_PR_IP_CORE)		+= altera-pr-ip-core.o
 obj-$(CONFIG_ALTERA_PR_IP_CORE_PLAT)	+= altera-pr-ip-core-plat.o
diff --git a/drivers/fpga/microchip-iap.c b/drivers/fpga/microchip-iap.c
new file mode 100644
index 000000000000..10f25ec64d32
--- /dev/null
+++ b/drivers/fpga/microchip-iap.c
@@ -0,0 +1,350 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Microchip Polarfire SoC "IAP" FPGA reprogramming.
+ *
+ * Copyright (c) 2022 Microchip Corporation. All rights reserved.
+ *
+ * Author: Conor Dooley <conor.dooley@microchip.com>
+ */
+#include <linux/module.h>
+#include <linux/mtd/mtd.h>
+#include <linux/of_device.h>
+#include <linux/fpga/fpga-mgr.h>
+#include <soc/microchip/mpfs.h>
+
+#define IAP_DEFAULT_MBOX_OFFSET		0u
+#define IAP_DEFAULT_RESP_OFFSET		0u
+
+#define IAP_FEATURE_CMD_OPCODE		0x05
+#define IAP_FEATURE_CMD_DATA_SIZE	0u
+#define IAP_FEATURE_RESP_SIZE		33u
+#define IAP_FEATURE_CMD_DATA		NULL
+#define IAP_FEATURE_ENABLED		BIT(5)
+
+#define IAP_VERIFY_CMD_OPCODE		0x22
+#define IAP_VERIFY_CMD_DATA_SIZE	0u
+#define IAP_VERIFY_RESP_SIZE		1u
+#define IAP_VERIFY_CMD_DATA		NULL
+
+#define IAP_PROGRAM_CMD_OPCODE		0x42
+#define IAP_PROGRAM_CMD_DATA_SIZE	0u
+#define IAP_PROGRAM_RESP_SIZE		1u
+#define IAP_PROGRAM_CMD_DATA		NULL
+
+#define IAP_DIRECTORY_WIDTH		4u
+#define IAP_UPGRADE_INDEX		1u
+#define IAP_UPGRADE_DIRECTORY		(IAP_UPGRADE_INDEX * 0x4)
+#define IAP_IMAGE_INDEX			2u
+#define IAP_IMAGE_DIRECTORY		(IAP_IMAGE_INDEX * 0x4)
+#define IAP_IMAGE_ADDRESS		(IAP_IMAGE_INDEX * 0xA00000)
+
+struct mpf_iap_config {
+	u8 feature_response_size;
+};
+
+struct mpf_iap_priv {
+	struct mpfs_sys_controller *sys_controller;
+	struct device *dev;
+	struct fpga_region *region;
+	struct mpf_iap_config *config;
+	struct mtd_info *flash;
+};
+
+static enum fpga_mgr_states mpf_iap_state(struct fpga_manager *mgr)
+{
+	struct mpf_iap_priv *priv = mgr->priv;
+	struct mpfs_mss_response *response;
+	struct mpfs_mss_msg *message;
+	u32 *response_msg;
+	int ret;
+	enum fpga_mgr_states rc = FPGA_MGR_STATE_WRITE_INIT_ERR;
+
+	response_msg = devm_kzalloc(priv->dev,
+				    IAP_FEATURE_RESP_SIZE * sizeof(response_msg),
+				    GFP_KERNEL);
+	if (!response_msg)
+		return FPGA_MGR_STATE_WRITE_INIT_ERR;
+
+	response = devm_kzalloc(priv->dev, sizeof(struct mpfs_mss_response), GFP_KERNEL);
+	if (!response) {
+		devm_kfree(priv->dev, response_msg);
+		return FPGA_MGR_STATE_WRITE_INIT_ERR;
+	}
+
+	message = devm_kzalloc(priv->dev, sizeof(struct mpfs_mss_msg), GFP_KERNEL);
+	if (!response) {
+		devm_kfree(priv->dev, response_msg);
+		devm_kfree(priv->dev, response);
+		return FPGA_MGR_STATE_WRITE_INIT_ERR;
+	}
+
+	/*
+	 * To verify that IAP is possible, the "Query Security Service Request"
+	 * is performed. Bit 5 of byte 1 is "UL_IAP" & if it is set, IAP is not
+	 * possible.
+	 * This service has no command data & does not overload mbox_offset.
+	 * The size of the response varies between PolarFire & PolarFire SoC.
+	 */
+	response->resp_msg = response_msg;
+	response->resp_size = IAP_FEATURE_RESP_SIZE;
+	message->cmd_opcode = IAP_FEATURE_CMD_OPCODE;
+	message->cmd_data_size = IAP_FEATURE_CMD_DATA_SIZE;
+	message->response = response;
+	message->cmd_data = IAP_FEATURE_CMD_DATA;
+	message->mbox_offset = IAP_DEFAULT_MBOX_OFFSET;
+	message->resp_offset = IAP_DEFAULT_RESP_OFFSET;
+
+	ret = mpfs_blocking_transaction(priv->sys_controller, message);
+	if (ret | response->resp_status) {
+		rc = FPGA_MGR_STATE_UNKNOWN;
+		goto out;
+	}
+
+	if (!(response_msg[1] & IAP_FEATURE_ENABLED))
+		rc = FPGA_MGR_STATE_OPERATING;
+
+out:
+	devm_kfree(priv->dev, response_msg);
+	devm_kfree(priv->dev, response);
+	devm_kfree(priv->dev, message);
+
+	return rc;
+}
+
+static int mpf_iap_write_init(struct fpga_manager *mgr, struct fpga_image_info *info,
+			      const char *buf, size_t count)
+{
+	struct mpf_iap_priv *priv = mgr->priv;
+	size_t *bytes_read;
+	u32 upgrade_address;
+
+	priv->flash = mpfs_sys_controller_get_flash(priv->sys_controller);
+	if (!priv->flash)
+		return PTR_ERR(priv->flash);
+
+	/*
+	 * We need to read the "SPI DIRECTORY" in the first 1 KiB, to see if
+	 * the index 1 has an address in it. If it is non zero, IAP will fail.
+	 * As the system controller will initiate upgrade mode instead.
+	 */
+	int ret = mtd_read(priv->flash, IAP_UPGRADE_DIRECTORY, IAP_DIRECTORY_WIDTH,
+			   bytes_read, (u_char *) &upgrade_address);
+	if (ret)
+		return ret;
+
+	if (*bytes_read != IAP_DIRECTORY_WIDTH || upgrade_address)
+		return -EIO;
+
+	return 0;
+}
+
+static int mpf_iap_write(struct fpga_manager *mgr, const char *buf, size_t count)
+{
+	/*
+	 * No parsing etc of the bitstream is required. The system controller
+	 * will do all of that itself - including verifying that the bitstream
+	 * is valid.
+	 */
+	struct mpf_iap_priv *priv = mgr->priv;
+	size_t *bytes_written;
+	u32 image_address = IAP_IMAGE_ADDRESS;
+
+	/*
+	 * We need to write the "SPI DIRECTORY" to the first 1 KiB, telling
+	 * the system controller where to find the actual bitstream.
+	 */
+	int ret = mtd_write(priv->flash, IAP_IMAGE_DIRECTORY, IAP_DIRECTORY_WIDTH,
+			    bytes_written, (u_char *) &image_address);
+	if (ret)
+		return ret;
+
+	if (*bytes_written != IAP_DIRECTORY_WIDTH)
+		return -EIO;
+
+	ret = mtd_write(priv->flash, (loff_t) image_address, count, bytes_written, (u_char *) buf);
+	if (ret)
+		return ret;
+
+	if (*bytes_written != count)
+		return -EIO;
+
+	return 0;
+}
+
+static int mpf_iap_write_complete(struct fpga_manager *mgr, struct fpga_image_info *info)
+{
+	struct mpf_iap_priv *priv = mgr->priv;
+	struct mpfs_mss_response *response;
+	struct mpfs_mss_msg *message;
+	u32 *response_msg;
+	int ret = 0;
+
+	response_msg = devm_kzalloc(priv->dev,
+				    IAP_FEATURE_RESP_SIZE * sizeof(response_msg),
+				    GFP_KERNEL);
+	if (!response_msg)
+		return -ENOMEM;
+
+	response = devm_kzalloc(priv->dev, sizeof(struct mpfs_mss_response), GFP_KERNEL);
+	if (!response) {
+		devm_kfree(priv->dev, response_msg);
+		return -ENOMEM;
+	}
+
+	message = devm_kzalloc(priv->dev, sizeof(struct mpfs_mss_msg), GFP_KERNEL);
+	if (!response) {
+		devm_kfree(priv->dev, response_msg);
+		devm_kfree(priv->dev, response);
+		return -ENOMEM;
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
+	response->resp_size = IAP_VERIFY_RESP_SIZE;
+	message->cmd_opcode = IAP_VERIFY_CMD_OPCODE;
+	message->cmd_data_size = IAP_VERIFY_CMD_DATA_SIZE;
+	message->response = response;
+	message->cmd_data = IAP_VERIFY_CMD_DATA;
+	message->mbox_offset = IAP_IMAGE_INDEX;
+	message->resp_offset = IAP_DEFAULT_RESP_OFFSET;
+
+	pr_info("ran IAP_VERIFY_RESP_SIZE\n");
+	ret = mpfs_blocking_transaction(priv->sys_controller, message);
+	if (ret | response->resp_status) {
+		ret = ret ? ret : -EBADMSG;
+		goto out;
+	}
+
+	/*
+	 * If the validation has passed, initiate IAP.
+	 * This service has no command data and no response data. It overloads
+	 * mbox_offset with the image index in the flash's SPI directory where
+	 * the bitstream is located.
+	 * Once we attempt IAP either:
+	 * - it passes and the board reboots
+	 * - it fails and the board reboots to recover
+	 * - the system controller aborts and we exit "gracefully"
+	 * This function will never return 0.
+	 */
+	response->resp_msg = response_msg;
+	response->resp_size = IAP_PROGRAM_RESP_SIZE;
+	message->cmd_opcode = IAP_PROGRAM_CMD_OPCODE;
+	message->cmd_data_size = IAP_PROGRAM_CMD_DATA_SIZE;
+	message->response = response;
+	message->cmd_data = IAP_PROGRAM_CMD_DATA;
+	message->mbox_offset = IAP_IMAGE_INDEX;
+	message->resp_offset = IAP_DEFAULT_RESP_OFFSET;
+
+	pr_info("ran IAP_PROGRAM_CMD_OPCODE\n");
+	ret = mpfs_blocking_transaction(priv->sys_controller, message);
+	if (ret)
+		goto out;
+
+	/*
+	 * This return 0 is dead code. Either the IAP will fail, or it will pass
+	 * & the FPGA will be rebooted in which case mpfs_blocking_transaction()
+	 * will never return and Linux will die.
+	 */
+	return 0;
+
+out:
+	devm_kfree(priv->dev, response_msg);
+	devm_kfree(priv->dev, response);
+	devm_kfree(priv->dev, message);
+	return ret;
+}
+
+static const struct fpga_manager_ops mpf_iap_ops = {
+	.state = mpf_iap_state,
+	.write_init = mpf_iap_write_init,
+	.write = mpf_iap_write,
+	.write_complete = mpf_iap_write_complete,
+};
+
+static int mpf_iap_run(struct device *dev)
+{
+	struct fpga_manager *mgr;
+	struct fpga_image_info *info;
+	int ret;
+
+	printk("starting to test the fpga manager\n");
+
+	mgr = fpga_mgr_get(dev);
+	info = fpga_image_info_alloc(dev);
+
+	info->firmware_name = devm_kstrdup(dev, "pf_bitstream.fw", GFP_KERNEL);
+	ret = fpga_mgr_lock(mgr);
+	if (ret) {
+		dev_err(dev, "couldnt lock the manager\n");
+		return ret;
+	}
+
+	ret = fpga_mgr_load(mgr, info);
+	if (ret) {
+		dev_err(dev, "couldnt load the firmware\n");
+		return ret;
+	}
+
+	fpga_mgr_unlock(mgr);
+	fpga_mgr_put(mgr);
+	fpga_image_info_free(info);
+
+	dev_info(dev, "test complete\n");
+
+	return ret;
+}
+
+static int mpf_iap_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct mpf_iap_priv *priv;
+	struct fpga_manager *mgr;
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
+	mgr = devm_fpga_mgr_register(dev, "Microchip MPF(S) IAP FPGA Manager",
+				     &mpf_iap_ops, priv);
+	if (IS_ERR(mgr))
+		return dev_err_probe(dev, PTR_ERR(mgr),
+				     "Could not register FPGA manager.\n");
+
+	enum fpga_mgr_states state = mpf_iap_state(mgr);
+	//ret = mpf_iap_run(dev);
+	ret = 1;
+	if (ret)
+		dev_err_probe(dev, ret, "IAP failed");
+
+	dev_info(dev, "Registered Microchip MPF(S) IAP FPGA Manager %u\n", state);
+
+	return 0;
+}
+
+static struct platform_driver mpf_iap_driver = {
+	.driver = {
+		.name = "mpfs-iap",
+	},
+	.probe = mpf_iap_probe,
+};
+module_platform_driver(mpf_iap_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Conor Dooley <conor.dooley@microchip.com>");
+MODULE_DESCRIPTION("PolarFire SoC IAP FPGA reprogramming");
-- 
2.37.2

