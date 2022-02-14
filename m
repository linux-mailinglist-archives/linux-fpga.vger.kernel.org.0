Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF37B4B534C
	for <lists+linux-fpga@lfdr.de>; Mon, 14 Feb 2022 15:29:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345342AbiBNO1t (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 14 Feb 2022 09:27:49 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233881AbiBNO1s (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 14 Feb 2022 09:27:48 -0500
X-Greylist: delayed 1815 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 14 Feb 2022 06:27:37 PST
Received: from mail.pr-group.ru (mail.pr-group.ru [178.18.215.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58A50DF2B;
        Mon, 14 Feb 2022 06:27:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
        d=metrotek.ru; s=mail;
        h=from:subject:date:message-id:to:cc:mime-version:content-transfer-encoding;
        bh=YBqBmfTUNMOSDsCwa37ezng4xrljInfkYc9e/d69sbY=;
        b=j2WFDmpcCPcpsWjN9ydjcqGH8DphrTMmMHaSsBZaW9AnH9EpVfZ/SvYTAOSWxMB6/XDlmCQjCtcI4
         OW7Vf6NkuUuv8u3VXGgm7rlxTkm8pVG/aXiUNsOEeHVt2eX/IASMVeqVgUcHYMgKWr7fyKRHFPYWkv
         0tReyax3eFe4OhhG/Y6SBk4sMGYLyZouEsH5EwBtyMAcuisC7TRJGv4jDbfXWu7Ec/RowNqFPL2vhR
         ohJ3jfbxzQyVedPzYDPwDQJEUqB1L+k5AUZmVQRHmXad2f1nX90M23AeSXtB5QVlWOYwKguWfJep4D
         tz25tgFqFxWuT/mHnaiYAzCPrCgt/Hg==
X-Kerio-Anti-Spam:  Build: [Engines: 2.16.1.1366, Stamp: 3], Multi: [Enabled, t: (0.000010,0.030719)], BW: [Enabled, t: (0.000024,0.000002)], RTDA: [Enabled, t: (0.067068), Hit: No, Details: v2.25.0; Id: 15.52k4n6.1frs8bldb.t9t1; mclb], total: 0(700)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Level: 
X-Footer: bWV0cm90ZWsucnU=
Received: from localhost.localdomain ([178.70.66.234])
        (authenticated user i.bornyakov@metrotek.ru)
        by mail.pr-group.ru with ESMTPSA
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits));
        Mon, 14 Feb 2022 16:57:05 +0300
From:   Ivan Bornyakov <i.bornyakov@metrotek.ru>
Cc:     mdf@kernel.org, hao.wu@intel.com, yilun.xu@intel.com,
        trix@redhat.com, linux-kernel@vger.kernel.org,
        linux-fpga@vger.kernel.org, system@metrotek.ru,
        Ivan Bornyakov <i.bornyakov@metrotek.ru>
Subject: [PATCH] fpga: microsemi-spi: add Microsemi FPGA manager
Date:   Mon, 14 Feb 2022 16:38:35 +0300
Message-Id: <20220214133835.25097-1-i.bornyakov@metrotek.ru>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Add support to the FPGA manager for programming Microsemi Polarfire
FPGAs over slave SPI interface.

Signed-off-by: Ivan Bornyakov <i.bornyakov@metrotek.ru>
---
 drivers/fpga/Kconfig         |   9 +
 drivers/fpga/Makefile        |   1 +
 drivers/fpga/microsemi-spi.c | 366 +++++++++++++++++++++++++++++++++++
 3 files changed, 376 insertions(+)
 create mode 100644 drivers/fpga/microsemi-spi.c

diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
index 991b3f361ec9..25c2631a387c 100644
--- a/drivers/fpga/Kconfig
+++ b/drivers/fpga/Kconfig
@@ -243,4 +243,13 @@ config FPGA_MGR_VERSAL_FPGA
 	  configure the programmable logic(PL).
 
 	  To compile this as a module, choose M here.
+
+config FPGA_MGR_MICROSEMI_SPI
+	tristate "Microsemi FPGA manager"
+	depends on SPI
+	select CRC_CCITT
+	help
+	  FPGA manager driver support for Microsemi Polarfire FPGAs
+	  programming over slave SPI interface.
+
 endif # FPGA
diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
index 0bff783d1b61..8b3d818546a6 100644
--- a/drivers/fpga/Makefile
+++ b/drivers/fpga/Makefile
@@ -19,6 +19,7 @@ obj-$(CONFIG_FPGA_MGR_XILINX_SPI)	+= xilinx-spi.o
 obj-$(CONFIG_FPGA_MGR_ZYNQ_FPGA)	+= zynq-fpga.o
 obj-$(CONFIG_FPGA_MGR_ZYNQMP_FPGA)	+= zynqmp-fpga.o
 obj-$(CONFIG_FPGA_MGR_VERSAL_FPGA)      += versal-fpga.o
+obj-$(CONFIG_FPGA_MGR_MICROSEMI_SPI)	+= microsemi-spi.o
 obj-$(CONFIG_ALTERA_PR_IP_CORE)         += altera-pr-ip-core.o
 obj-$(CONFIG_ALTERA_PR_IP_CORE_PLAT)    += altera-pr-ip-core-plat.o
 
diff --git a/drivers/fpga/microsemi-spi.c b/drivers/fpga/microsemi-spi.c
new file mode 100644
index 000000000000..02c3dc6d6b0d
--- /dev/null
+++ b/drivers/fpga/microsemi-spi.c
@@ -0,0 +1,366 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Microsemi Polarfire FPGA programming over slave SPI interface.
+ */
+
+#include <linux/module.h>
+#include <linux/spi/spi.h>
+#include <linux/of_device.h>
+#include <linux/fpga/fpga-mgr.h>
+#include <linux/delay.h>
+#include <linux/crc-ccitt.h>
+
+#define	SPI_ISC_ENABLE		0x0B
+#define	SPI_ISC_DISABLE		0x0C
+#define	SPI_READ_STATUS		0x00
+#define	SPI_READ_DATA		0x01
+#define	SPI_FRAME_INIT		0xAE
+#define	SPI_FRAME		0xEE
+#define	SPI_PRG_MODE		0x01
+#define	SPI_RELEASE		0x23
+
+#define	SPI_FRAME_SIZE	16
+
+#define	HEADER_SIZE_OFFSET		24
+#define	DATA_SIZE_OFFSET		55
+
+#define	LOOKUP_TABLE_RECORD_SIZE	9
+#define	LOOKUP_TABLE_BLOCK_ID_OFFSET	0
+#define	LOOKUP_TABLE_BLOCK_START_OFFSET	1
+
+#define	COMPONENTS_SIZE_ID	5
+#define	BITSTREAM_ID		8
+
+#define	BITS_PER_COMPONENT_SIZE	22
+
+#define	STATUS_POLL_TIMEOUT_MS	1000
+#define	STATUS_BUSY		BIT(0)
+#define	STATUS_READY		BIT(1)
+#define	STATUS_SPI_VIOLATION	BIT(2)
+#define	STATUS_SPI_ERROR	BIT(3)
+
+struct microsemi_fpga_priv {
+	struct spi_device *spi;
+	bool program_mode;
+};
+
+static enum fpga_mgr_states microsemi_fpga_ops_state(struct fpga_manager *mgr)
+{
+	struct microsemi_fpga_priv *priv = mgr->priv;
+	struct spi_device *spi = priv->spi;
+	bool program_mode = priv->program_mode;
+	ssize_t status;
+
+	status = spi_w8r8(spi, SPI_READ_STATUS);
+
+	if (!program_mode && !status)
+		return FPGA_MGR_STATE_OPERATING;
+
+	return FPGA_MGR_STATE_UNKNOWN;
+}
+
+static int poll_status_not_busy(struct spi_device *spi, u8 mask)
+{
+	ssize_t status, timeout = STATUS_POLL_TIMEOUT_MS;
+
+	while (timeout--) {
+		status = spi_w8r8(spi, SPI_READ_STATUS);
+		if (status < 0)
+			return status;
+
+		if (mask) {
+			if (!(status & STATUS_BUSY) && (status & mask))
+				return status;
+		} else {
+			if (!(status & STATUS_BUSY))
+				return status;
+		}
+
+		mdelay(1);
+	}
+
+	return -EBUSY;
+}
+
+static int microsemi_spi_write(struct spi_device *spi, const void *buf,
+			       size_t buf_size)
+{
+	int status = poll_status_not_busy(spi, 0);
+
+	if (status < 0)
+		return status;
+
+	return spi_write(spi, buf, buf_size);
+}
+
+static int microsemi_spi_write_then_read(struct spi_device *spi,
+					 const void *txbuf, size_t txbuf_size,
+					 void *rxbuf, size_t rxbuf_size)
+{
+	const u8 read_command[] = { SPI_READ_DATA };
+	int ret;
+
+	ret = microsemi_spi_write(spi, txbuf, txbuf_size);
+	if (ret)
+		return ret;
+
+	ret = poll_status_not_busy(spi, STATUS_READY);
+	if (ret < 0)
+		return ret;
+
+	return spi_write_then_read(spi, read_command, sizeof(read_command),
+				   rxbuf, rxbuf_size);
+}
+
+static int microsemi_fpga_ops_write_init(struct fpga_manager *mgr,
+					 struct fpga_image_info *info,
+					 const char *buf, size_t count)
+{
+	const u8 isc_en_command[] = { SPI_ISC_ENABLE };
+	const u8 program_mode[] = { SPI_FRAME_INIT, SPI_PRG_MODE };
+	struct microsemi_fpga_priv *priv = mgr->priv;
+	struct spi_device *spi = priv->spi;
+	struct device *dev = &mgr->dev;
+	u32 isc_ret;
+	int ret;
+
+	if (info->flags & FPGA_MGR_PARTIAL_RECONFIG) {
+		dev_err(dev, "Partial reconfiguration is not supported\n");
+
+		return -EOPNOTSUPP;
+	}
+
+	ret = microsemi_spi_write_then_read(spi, isc_en_command,
+					    sizeof(isc_en_command),
+					    &isc_ret, sizeof(isc_ret));
+	if (ret || isc_ret) {
+		dev_err(dev, "Failed to enable ISC: %d\n", ret ? ret : isc_ret);
+
+		return -EFAULT;
+	}
+
+	ret = microsemi_spi_write(spi, program_mode, sizeof(program_mode));
+	if (ret) {
+		dev_err(dev, "Failed to enter program mode: %d\n", ret);
+
+		return ret;
+	}
+
+	priv->program_mode = true;
+
+	return 0;
+}
+
+static ssize_t lookup_block_start(int id, const char *buf, size_t buf_size)
+{
+	u8 header_size, blocks_num, block_id;
+	u32 block_start, i;
+
+	header_size = *(buf + HEADER_SIZE_OFFSET);
+
+	if (header_size > buf_size)
+		return -EFAULT;
+
+	blocks_num = *(buf + header_size - 1);
+
+	if (header_size + blocks_num * LOOKUP_TABLE_RECORD_SIZE > buf_size)
+		return -EFAULT;
+
+	for (i = 0; i < blocks_num; i++) {
+		block_id = *(buf + header_size + LOOKUP_TABLE_RECORD_SIZE * i +
+			     LOOKUP_TABLE_BLOCK_ID_OFFSET);
+
+		if (block_id == id) {
+			memcpy(&block_start,
+			       buf + header_size +
+			       LOOKUP_TABLE_RECORD_SIZE * i +
+			       LOOKUP_TABLE_BLOCK_START_OFFSET,
+			       sizeof(block_start));
+
+			return le32_to_cpu(block_start);
+		}
+	}
+
+	return -EFAULT;
+}
+
+static ssize_t parse_bitstream_size(const char *buf, size_t buf_size)
+{
+	ssize_t	bitstream_size = 0, components_size_start = 0,
+		component_size_byte_num, component_size_byte_off, i;
+	u16 components_num;
+	u32 component_size;
+
+	memcpy(&components_num, buf + DATA_SIZE_OFFSET, sizeof(components_num));
+	components_num = le16_to_cpu(components_num);
+
+	components_size_start = lookup_block_start(COMPONENTS_SIZE_ID, buf,
+						   buf_size);
+	if (components_size_start < 0)
+		return components_size_start;
+
+	if (components_size_start +
+	    DIV_ROUND_UP(components_num * BITS_PER_COMPONENT_SIZE,
+			 BITS_PER_BYTE) > buf_size)
+		return -EFAULT;
+
+	for (i = 0; i < components_num; i++) {
+		component_size_byte_num =
+			(i * BITS_PER_COMPONENT_SIZE) / BITS_PER_BYTE;
+		component_size_byte_off =
+			(i * BITS_PER_COMPONENT_SIZE) % BITS_PER_BYTE;
+
+		memcpy(&component_size,
+		       buf + components_size_start + component_size_byte_num,
+		       sizeof(component_size));
+		component_size = le32_to_cpu(component_size);
+		component_size >>= component_size_byte_off;
+		component_size &= GENMASK(BITS_PER_COMPONENT_SIZE - 1, 0);
+
+		bitstream_size += component_size;
+	}
+
+	return bitstream_size;
+}
+
+static int microsemi_fpga_ops_write(struct fpga_manager *mgr, const char *buf,
+				    size_t count)
+{
+	ssize_t bitstream_start = 0, bitstream_size;
+	struct microsemi_fpga_priv *priv = mgr->priv;
+	struct spi_device *spi = priv->spi;
+	struct device *dev = &mgr->dev;
+	u8 tmp_buf[SPI_FRAME_SIZE + 1];
+	int ret, i;
+
+	if (crc_ccitt(0, buf, count)) {
+		dev_err(dev, "CRC error\n");
+
+		return -EINVAL;
+	}
+
+	bitstream_start = lookup_block_start(BITSTREAM_ID, buf, count);
+	if (bitstream_start < 0) {
+		dev_err(dev, "Failed to find bitstream start %d\n",
+			bitstream_start);
+
+		return bitstream_start;
+	}
+
+	bitstream_size = parse_bitstream_size(buf, count);
+	if (bitstream_size < 0) {
+		dev_err(dev, "Failed to parse bitstream size %d\n",
+			bitstream_size);
+
+		return bitstream_size;
+	}
+
+	if (bitstream_start + bitstream_size * SPI_FRAME_SIZE > count) {
+		dev_err(dev,
+			"Bitstram outruns firmware. Bitstream start %d, bitstream size %d, firmware size %d\n",
+			bitstream_start, bitstream_size * SPI_FRAME_SIZE, count);
+
+		return -EFAULT;
+	}
+
+	for (i = 0; i < bitstream_size; i++) {
+		tmp_buf[0] = SPI_FRAME;
+		memcpy(tmp_buf + 1, buf + bitstream_start + i * SPI_FRAME_SIZE,
+		       SPI_FRAME_SIZE);
+
+		ret = microsemi_spi_write(spi, tmp_buf, sizeof(tmp_buf));
+		if (ret) {
+			dev_err(dev,
+				"Failed to write bitstream frame number %d of %d\n",
+				i, bitstream_size);
+
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+static int microsemi_fpga_ops_write_complete(struct fpga_manager *mgr,
+					     struct fpga_image_info *info)
+{
+	const u8 isc_dis_command[] = { SPI_ISC_DISABLE };
+	const u8 release_command[] = { SPI_RELEASE };
+	struct microsemi_fpga_priv *priv = mgr->priv;
+	struct spi_device *spi = priv->spi;
+	struct device *dev = &mgr->dev;
+	int ret;
+
+	ret = microsemi_spi_write(spi, isc_dis_command,
+				  sizeof(isc_dis_command));
+	if (ret) {
+		dev_err(dev, "Failed to disable ISC: %d\n", ret);
+
+		return ret;
+	}
+
+	mdelay(1);
+
+	ret = microsemi_spi_write(spi, release_command,
+				  sizeof(release_command));
+	if (ret) {
+		dev_err(dev, "Failed to exit program mode: %d\n", ret);
+
+		return ret;
+	}
+
+	priv->program_mode = false;
+
+	return 0;
+}
+
+static const struct fpga_manager_ops microsemi_fpga_ops = {
+	.state = microsemi_fpga_ops_state,
+	.write_init = microsemi_fpga_ops_write_init,
+	.write = microsemi_fpga_ops_write,
+	.write_complete = microsemi_fpga_ops_write_complete,
+};
+
+static int microsemi_fpga_probe(struct spi_device *spi)
+{
+	struct microsemi_fpga_priv *priv;
+	struct device *dev = &spi->dev;
+	struct fpga_manager *mgr;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->spi = spi;
+
+	mgr = devm_fpga_mgr_register(dev, "Microsemi FPGA Manager",
+				     &microsemi_fpga_ops, priv);
+
+	return PTR_ERR_OR_ZERO(mgr);
+}
+
+static const struct spi_device_id microsemi_fpga_spi_ids[] = {
+	{ .name = "polarfire-fpga-mgr", },
+	{},
+};
+MODULE_DEVICE_TABLE(spi, microsemi_fpga_spi_ids);
+
+static const struct of_device_id microsemi_fpga_of_ids[] = {
+	{ .compatible = "mscc,polarfire-fpga-mgr" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, microsemi_fpga_of_ids);
+
+static struct spi_driver microsemi_fpga_driver = {
+	.probe = microsemi_fpga_probe,
+	.id_table = microsemi_fpga_spi_ids,
+	.driver = {
+		.name = "microsemi_fpga_manager",
+		.of_match_table = of_match_ptr(microsemi_fpga_of_ids),
+	},
+};
+
+module_spi_driver(microsemi_fpga_driver);
+
+MODULE_DESCRIPTION("Microsemi FPGA Manager");
+MODULE_LICENSE("GPL");
-- 
2.34.1


