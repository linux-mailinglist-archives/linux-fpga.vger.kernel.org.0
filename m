Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 431A3526783
	for <lists+linux-fpga@lfdr.de>; Fri, 13 May 2022 18:52:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382510AbiEMQt5 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 13 May 2022 12:49:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233139AbiEMQtx (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 13 May 2022 12:49:53 -0400
Received: from mail.pr-group.ru (mail.pr-group.ru [178.18.215.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D13F527D9;
        Fri, 13 May 2022 09:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
        d=metrotek.ru; s=mail;
        h=from:subject:date:message-id:to:cc:mime-version:content-transfer-encoding:
         in-reply-to:references;
        bh=1Hvh4XpEqKJSVmZWcUQ3Y4APwjdHKBHhBhOg3XqN7Tc=;
        b=FJ2VhrcGtoGqkEqbr7iJGnPq/X4clP0csFCqwt3zzk2WWexGHKwI2lXi91B66Z1uKP2I2PaRmVghJ
         6/wieIwYvUOohZXzRebYUADszvpLYlhFriBKVTQgpzOKW9ATzut2ROSWuO498tGc7PdKFbx3V/m0lJ
         D4+ELPAY4zSwuBPyJbIjZ3kllsT2mnpCA5N5q1blOIk4lj6pdt6OygpedJMgSoL/P17RHD4DvxMDp8
         rFPKNixjsOx4NswKmRCvbr+CXj6wGt2mvdqpvfSQrEXBmneuHXWQDbLLGm1hVDqoK4mlsXwFU2QVnB
         /6UkKGn2VGCe8DHROE/jHFnMqXMZbOw==
X-Kerio-Anti-Spam:  Build: [Engines: 2.16.3.1424, Stamp: 3], Multi: [Enabled, t: (0.000010,0.034194)], BW: [Enabled, t: (0.000021,0.000001)], RTDA: [Enabled, t: (0.067318), Hit: No, Details: v2.39.0; Id: 15.52k56o.1g2v56ial.qakn; mclb], total: 0(700)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Level: 
X-Footer: bWV0cm90ZWsucnU=
Received: from localhost.localdomain ([178.70.36.174])
        (authenticated user i.bornyakov@metrotek.ru)
        by mail.pr-group.ru with ESMTPSA
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits));
        Fri, 13 May 2022 19:49:28 +0300
From:   Ivan Bornyakov <i.bornyakov@metrotek.ru>
Cc:     mdf@kernel.org, hao.wu@intel.com, yilun.xu@intel.com,
        trix@redhat.com, Conor.Dooley@microchip.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-fpga@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        system@metrotek.ru, Ivan Bornyakov <i.bornyakov@metrotek.ru>
Subject: [PATCH v12 2/3] fpga: microchip-spi: add Microchip MPF FPGA manager
Date:   Fri, 13 May 2022 19:27:54 +0300
Message-Id: <20220513162755.16201-3-i.bornyakov@metrotek.ru>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220513162755.16201-1-i.bornyakov@metrotek.ru>
References: <20220513162755.16201-1-i.bornyakov@metrotek.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Add support to the FPGA manager for programming Microchip Polarfire
FPGAs over slave SPI interface with .dat formatted bitsream image.

Signed-off-by: Ivan Bornyakov <i.bornyakov@metrotek.ru>
---
 drivers/fpga/Kconfig         |   9 +
 drivers/fpga/Makefile        |   1 +
 drivers/fpga/microchip-spi.c | 371 +++++++++++++++++++++++++++++++++++
 3 files changed, 381 insertions(+)
 create mode 100644 drivers/fpga/microchip-spi.c

diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
index 26025dbab353..75806ef5c9ea 100644
--- a/drivers/fpga/Kconfig
+++ b/drivers/fpga/Kconfig
@@ -248,4 +248,13 @@ config FPGA_MGR_VERSAL_FPGA
 	  configure the programmable logic(PL).
 
 	  To compile this as a module, choose M here.
+
+config FPGA_MGR_MICROCHIP_SPI
+	tristate "Microchip Polarfire SPI FPGA manager"
+	depends on SPI
+	help
+	  FPGA manager driver support for Microchip Polarfire FPGAs
+	  programming over slave SPI interface with .dat formatted
+	  bitstream image.
+
 endif # FPGA
diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
index e32bfa90f968..5425a15892df 100644
--- a/drivers/fpga/Makefile
+++ b/drivers/fpga/Makefile
@@ -19,6 +19,7 @@ obj-$(CONFIG_FPGA_MGR_XILINX_SPI)	+= xilinx-spi.o
 obj-$(CONFIG_FPGA_MGR_ZYNQ_FPGA)	+= zynq-fpga.o
 obj-$(CONFIG_FPGA_MGR_ZYNQMP_FPGA)	+= zynqmp-fpga.o
 obj-$(CONFIG_FPGA_MGR_VERSAL_FPGA)	+= versal-fpga.o
+obj-$(CONFIG_FPGA_MGR_MICROCHIP_SPI)	+= microchip-spi.o
 obj-$(CONFIG_ALTERA_PR_IP_CORE)		+= altera-pr-ip-core.o
 obj-$(CONFIG_ALTERA_PR_IP_CORE_PLAT)	+= altera-pr-ip-core-plat.o
 
diff --git a/drivers/fpga/microchip-spi.c b/drivers/fpga/microchip-spi.c
new file mode 100644
index 000000000000..cb59f43000a4
--- /dev/null
+++ b/drivers/fpga/microchip-spi.c
@@ -0,0 +1,371 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Microchip Polarfire FPGA programming over slave SPI interface.
+ */
+
+#include <asm/unaligned.h>
+#include <linux/delay.h>
+#include <linux/fpga/fpga-mgr.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/spi/spi.h>
+
+#define	MPF_SPI_ISC_ENABLE	0x0B
+#define	MPF_SPI_ISC_DISABLE	0x0C
+#define	MPF_SPI_READ_STATUS	0x00
+#define	MPF_SPI_READ_DATA	0x01
+#define	MPF_SPI_FRAME_INIT	0xAE
+#define	MPF_SPI_FRAME		0xEE
+#define	MPF_SPI_PRG_MODE	0x01
+#define	MPF_SPI_RELEASE		0x23
+
+#define	MPF_SPI_FRAME_SIZE	16
+
+#define	MPF_HEADER_SIZE_OFFSET	24
+#define	MPF_DATA_SIZE_OFFSET	55
+
+#define	MPF_LOOKUP_TABLE_RECORD_SIZE		9
+#define	MPF_LOOKUP_TABLE_BLOCK_ID_OFFSET	0
+#define	MPF_LOOKUP_TABLE_BLOCK_START_OFFSET	1
+
+#define	MPF_COMPONENTS_SIZE_ID	5
+#define	MPF_BITSTREAM_ID	8
+
+#define	MPF_BITS_PER_COMPONENT_SIZE	22
+
+#define	MPF_STATUS_POLL_TIMEOUT		10000
+#define	MPF_STATUS_BUSY			BIT(0)
+#define	MPF_STATUS_READY		BIT(1)
+#define	MPF_STATUS_SPI_VIOLATION	BIT(2)
+#define	MPF_STATUS_SPI_ERROR		BIT(3)
+
+struct mpf_priv {
+	struct spi_device *spi;
+	bool program_mode;
+};
+
+static int mpf_read_status(struct spi_device *spi)
+{
+	u8 status = 0, status_command = MPF_SPI_READ_STATUS;
+	struct spi_transfer xfers[] = {
+		[0 ... 1] = {
+			.tx_buf = &status_command,
+			.rx_buf = &status,
+			.len = 1,
+			.cs_change = 1,
+		}
+	};
+	int ret = spi_sync_transfer(spi, xfers, 2);
+
+	if ((status & MPF_STATUS_SPI_VIOLATION) ||
+	    (status & MPF_STATUS_SPI_ERROR))
+		ret = -EIO;
+
+	return ret ? : status;
+}
+
+static enum fpga_mgr_states mpf_ops_state(struct fpga_manager *mgr)
+{
+	struct mpf_priv *priv = mgr->priv;
+	struct spi_device *spi;
+	bool program_mode;
+	int status;
+
+	spi = priv->spi;
+	program_mode = priv->program_mode;
+	status = mpf_read_status(spi);
+
+	if (!program_mode && !status)
+		return FPGA_MGR_STATE_OPERATING;
+
+	return FPGA_MGR_STATE_UNKNOWN;
+}
+
+static int mpf_ops_parse_header(struct fpga_manager *mgr,
+				struct fpga_image_info *info,
+				const char *buf, size_t count)
+{
+	size_t component_size_byte_num, component_size_byte_off,
+	       components_size_start = 0, bitstream_start = 0,
+	       block_id_offset, block_start_offset, i;
+	u8 header_size, blocks_num, block_id;
+	u32 block_start, component_size;
+	u16 components_num;
+
+	if (!buf) {
+		dev_err(&mgr->dev, "Image buffer is not provided\n");
+		return -EINVAL;
+	}
+
+	header_size = *(buf + MPF_HEADER_SIZE_OFFSET);
+	if (header_size > count) {
+		info->header_size = header_size;
+		return -EAGAIN;
+	}
+
+	/*
+	 * Go through look-up table to find out where actual bitstream starts
+	 * and where sizes of components of the bitstream lies.
+	 */
+	blocks_num = *(buf + header_size - 1);
+	block_id_offset = header_size + MPF_LOOKUP_TABLE_BLOCK_ID_OFFSET;
+	block_start_offset = header_size + MPF_LOOKUP_TABLE_BLOCK_START_OFFSET;
+
+	header_size += blocks_num * MPF_LOOKUP_TABLE_RECORD_SIZE;
+	if (header_size > count) {
+		info->header_size = header_size;
+		return -EAGAIN;
+	}
+
+	while (blocks_num--) {
+		block_id = *(buf + block_id_offset);
+		block_start = get_unaligned_le32(buf + block_start_offset);
+
+		switch (block_id) {
+		case MPF_BITSTREAM_ID:
+			info->header_size = bitstream_start = block_start;
+			if (block_start > count)
+				return -EAGAIN;
+
+			break;
+		case MPF_COMPONENTS_SIZE_ID:
+			components_size_start = block_start;
+			break;
+		default:
+			break;
+		}
+
+		if (bitstream_start && components_size_start)
+			break;
+
+		block_id_offset += MPF_LOOKUP_TABLE_RECORD_SIZE;
+		block_start_offset += MPF_LOOKUP_TABLE_RECORD_SIZE;
+	}
+
+	if (!bitstream_start || !components_size_start) {
+		dev_err(&mgr->dev, "Failed to parse header look-up table\n");
+		return -EFAULT;
+	}
+
+	/*
+	 * Parse bitstream size.
+	 * Sizes of components of the bitstream are 22-bits long placed next
+	 * to each other. Image header should be extended by now up to where
+	 * actual bitstream starts, so no need for overflow check anymore.
+	 */
+	components_num = get_unaligned_le16(buf + MPF_DATA_SIZE_OFFSET);
+
+	for (i = 0; i < components_num; i++) {
+		component_size_byte_num =
+			(i * MPF_BITS_PER_COMPONENT_SIZE) / BITS_PER_BYTE;
+		component_size_byte_off =
+			(i * MPF_BITS_PER_COMPONENT_SIZE) % BITS_PER_BYTE;
+
+		component_size = get_unaligned_le32(buf +
+						    components_size_start +
+						    component_size_byte_num);
+		component_size >>= component_size_byte_off;
+		component_size &= GENMASK(MPF_BITS_PER_COMPONENT_SIZE - 1, 0);
+
+		info->data_size += component_size * MPF_SPI_FRAME_SIZE;
+	}
+
+	return 0;
+}
+
+static int poll_status_not_busy(struct spi_device *spi, u8 mask)
+{
+	int status, timeout = MPF_STATUS_POLL_TIMEOUT;
+
+	while (timeout--) {
+		status = mpf_read_status(spi);
+		if (status < 0 ||
+		    (!(status & MPF_STATUS_BUSY) && (!mask || (status & mask))))
+			return status;
+	}
+
+	return -EBUSY;
+}
+
+static int mpf_spi_write(struct spi_device *spi, const void *buf, size_t buf_size)
+{
+	int status = poll_status_not_busy(spi, 0);
+
+	if (status < 0)
+		return status;
+
+	return spi_write(spi, buf, buf_size);
+}
+
+static int mpf_spi_write_then_read(struct spi_device *spi,
+				   const void *txbuf, size_t txbuf_size,
+				   void *rxbuf, size_t rxbuf_size)
+{
+	const u8 read_command[] = { MPF_SPI_READ_DATA };
+	int ret;
+
+	ret = mpf_spi_write(spi, txbuf, txbuf_size);
+	if (ret)
+		return ret;
+
+	ret = poll_status_not_busy(spi, MPF_STATUS_READY);
+	if (ret < 0)
+		return ret;
+
+	return spi_write_then_read(spi, read_command, sizeof(read_command),
+				   rxbuf, rxbuf_size);
+}
+
+static int mpf_ops_write_init(struct fpga_manager *mgr,
+			      struct fpga_image_info *info, const char *buf,
+			      size_t count)
+{
+	const u8 program_mode[] = { MPF_SPI_FRAME_INIT, MPF_SPI_PRG_MODE };
+	const u8 isc_en_command[] = { MPF_SPI_ISC_ENABLE };
+	struct mpf_priv *priv = mgr->priv;
+	struct device *dev = &mgr->dev;
+	struct spi_device *spi;
+	u32 isc_ret;
+	int ret;
+
+	if (info->flags & FPGA_MGR_PARTIAL_RECONFIG) {
+		dev_err(dev, "Partial reconfiguration is not supported\n");
+		return -EOPNOTSUPP;
+	}
+
+	spi = priv->spi;
+
+	ret = mpf_spi_write_then_read(spi, isc_en_command, sizeof(isc_en_command),
+				      &isc_ret, sizeof(isc_ret));
+	if (ret || isc_ret) {
+		dev_err(dev, "Failed to enable ISC: %d\n", ret ? : isc_ret);
+		return -EFAULT;
+	}
+
+	ret = mpf_spi_write(spi, program_mode, sizeof(program_mode));
+	if (ret) {
+		dev_err(dev, "Failed to enter program mode: %d\n", ret);
+		return ret;
+	}
+
+	priv->program_mode = true;
+
+	return 0;
+}
+
+static int mpf_ops_write(struct fpga_manager *mgr, const char *buf, size_t count)
+{
+	u8 tmp_buf[MPF_SPI_FRAME_SIZE + 1] = { MPF_SPI_FRAME, };
+	struct mpf_priv *priv = mgr->priv;
+	struct device *dev = &mgr->dev;
+	struct spi_device *spi;
+	int ret, i;
+
+	if (count % MPF_SPI_FRAME_SIZE) {
+		dev_err(dev, "Bitstream size is not a multiple of %d\n",
+			MPF_SPI_FRAME_SIZE);
+		return -EINVAL;
+	}
+
+	spi = priv->spi;
+
+	for (i = 0; i < count / MPF_SPI_FRAME_SIZE; i++) {
+		memcpy(tmp_buf + 1, buf + i * MPF_SPI_FRAME_SIZE,
+		       MPF_SPI_FRAME_SIZE);
+
+		ret = mpf_spi_write(spi, tmp_buf, sizeof(tmp_buf));
+		if (ret) {
+			dev_err(dev, "Failed to write bitstream frame %d/%zd\n",
+				i, count / MPF_SPI_FRAME_SIZE);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+static int mpf_ops_write_complete(struct fpga_manager *mgr,
+				  struct fpga_image_info *info)
+{
+	const u8 isc_dis_command[] = { MPF_SPI_ISC_DISABLE };
+	const u8 release_command[] = { MPF_SPI_RELEASE };
+	struct mpf_priv *priv = mgr->priv;
+	struct device *dev = &mgr->dev;
+	struct spi_device *spi;
+	int ret;
+
+	spi = priv->spi;
+
+	ret = mpf_spi_write(spi, isc_dis_command, sizeof(isc_dis_command));
+	if (ret) {
+		dev_err(dev, "Failed to disable ISC: %d\n", ret);
+		return ret;
+	}
+
+	usleep_range(1000, 2000);
+
+	ret = mpf_spi_write(spi, release_command, sizeof(release_command));
+	if (ret) {
+		dev_err(dev, "Failed to exit program mode: %d\n", ret);
+		return ret;
+	}
+
+	priv->program_mode = false;
+
+	return 0;
+}
+
+static const struct fpga_manager_ops mpf_ops = {
+	.state = mpf_ops_state,
+	.initial_header_size = 71,
+	.parse_header = mpf_ops_parse_header,
+	.write_init = mpf_ops_write_init,
+	.write = mpf_ops_write,
+	.write_complete = mpf_ops_write_complete,
+};
+
+static int mpf_probe(struct spi_device *spi)
+{
+	struct device *dev = &spi->dev;
+	struct fpga_manager *mgr;
+	struct mpf_priv *priv;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->spi = spi;
+
+	mgr = devm_fpga_mgr_register(dev, "Microchip Polarfire SPI FPGA Manager",
+				     &mpf_ops, priv);
+
+	return PTR_ERR_OR_ZERO(mgr);
+}
+
+static const struct spi_device_id mpf_spi_ids[] = {
+	{ .name = "mpf-spi-fpga-mgr", },
+	{},
+};
+MODULE_DEVICE_TABLE(spi, mpf_spi_ids);
+
+#if IS_ENABLED(CONFIG_OF)
+static const struct of_device_id mpf_of_ids[] = {
+	{ .compatible = "microchip,mpf-spi-fpga-mgr" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, mpf_of_ids);
+#endif /* IS_ENABLED(CONFIG_OF) */
+
+static struct spi_driver mpf_driver = {
+	.probe = mpf_probe,
+	.id_table = mpf_spi_ids,
+	.driver = {
+		.name = "microchip_mpf_spi_fpga_mgr",
+		.of_match_table = of_match_ptr(mpf_of_ids),
+	},
+};
+
+module_spi_driver(mpf_driver);
+
+MODULE_DESCRIPTION("Microchip Polarfire SPI FPGA Manager");
+MODULE_LICENSE("GPL");
-- 
2.35.1


