Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B4324E2243
	for <lists+linux-fpga@lfdr.de>; Mon, 21 Mar 2022 09:33:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345283AbiCUIdd (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 21 Mar 2022 04:33:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345276AbiCUIda (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 21 Mar 2022 04:33:30 -0400
Received: from mail.pr-group.ru (mail.pr-group.ru [178.18.215.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0805160AB1;
        Mon, 21 Mar 2022 01:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
        d=metrotek.ru; s=mail;
        h=from:subject:date:message-id:to:cc:mime-version:content-transfer-encoding:
         in-reply-to:references;
        bh=5SxpFlj9HrPxT8frqb6qyvkc7UTkKG7i7TGDlpHvAyM=;
        b=loERsPGbjUBZI5I0pFA68v9I90JvtV51YtwWpMPsEpXSUD4gNTH1DpTJp18MdBPuPe02Gyje3gBMH
         RT5Izp3vLBLY0/rqoEFZRQGHM2KAE4dUWeuauwFshK2Zw05IaXNoPmFVv3dG6auBIS+csgthKM65eQ
         ypeaIm5Dkq3LhoxxCjQgaOuwa35jyOaMIUt3mzezygvyYbRWRNfSunazm1fQQAHlLVttJenQbVMkPp
         iGNDe5OZ9WVWN7FXX06YznL6oMn7OrReUuSfhzsPQjCFxThexeuNJQiviCG0AGQgIyn1w7RpCRL3kB
         KmOesxht3JedknmMHMJGwASUoXrrKeg==
X-Kerio-Anti-Spam:  Build: [Engines: 2.16.2.1410, Stamp: 3], Multi: [Enabled, t: (0.000014,0.035612)], BW: [Enabled, t: (0.000022,0.000001)], RTDA: [Enabled, t: (0.073431), Hit: No, Details: v2.28.0; Id: 15.52k424.1fulpl6i5.312q; mclb], total: 0(700)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Level: 
X-Footer: bWV0cm90ZWsucnU=
Received: from localhost.localdomain ([85.143.252.66])
        (authenticated user i.bornyakov@metrotek.ru)
        by mail.pr-group.ru with ESMTPSA
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits));
        Mon, 21 Mar 2022 11:31:48 +0300
From:   Ivan Bornyakov <i.bornyakov@metrotek.ru>
Cc:     Ivan Bornyakov <i.bornyakov@metrotek.ru>, mdf@kernel.org,
        hao.wu@intel.com, yilun.xu@intel.com, trix@redhat.com,
        conor.dooley@microchip.com, robh+dt@kernel.org, system@metrotek.ru,
        linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v5 1/2] fpga: microchip-spi: add Microchip MPF FPGA manager
Date:   Mon, 21 Mar 2022 11:11:59 +0300
Message-Id: <20220321081200.6912-2-i.bornyakov@metrotek.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220321081200.6912-1-i.bornyakov@metrotek.ru>
References: <20220321081200.6912-1-i.bornyakov@metrotek.ru>
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
 drivers/fpga/Kconfig         |  10 +
 drivers/fpga/Makefile        |   1 +
 drivers/fpga/microchip-spi.c | 448 +++++++++++++++++++++++++++++++++++
 3 files changed, 459 insertions(+)
 create mode 100644 drivers/fpga/microchip-spi.c

diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
index 26025dbab353..791ecf48503a 100644
--- a/drivers/fpga/Kconfig
+++ b/drivers/fpga/Kconfig
@@ -248,4 +248,14 @@ config FPGA_MGR_VERSAL_FPGA
 	  configure the programmable logic(PL).
 
 	  To compile this as a module, choose M here.
+
+config FPGA_MGR_MICROCHIP_SPI
+	tristate "Microchip Polarfire SPI FPGA manager"
+	depends on SPI
+	select CRC_CCITT
+	help
+	  FPGA manager driver support for Microchip Polarfire FPGAs
+	  programming over slave SPI interface with .dat formatted
+	  bitstream image.
+
 endif # FPGA
diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
index 4da5273948df..fcb389ca4873 100644
--- a/drivers/fpga/Makefile
+++ b/drivers/fpga/Makefile
@@ -19,6 +19,7 @@ obj-$(CONFIG_FPGA_MGR_XILINX_SPI)	+= xilinx-spi.o
 obj-$(CONFIG_FPGA_MGR_ZYNQ_FPGA)	+= zynq-fpga.o
 obj-$(CONFIG_FPGA_MGR_ZYNQMP_FPGA)	+= zynqmp-fpga.o
 obj-$(CONFIG_FPGA_MGR_VERSAL_FPGA)      += versal-fpga.o
+obj-$(CONFIG_FPGA_MGR_MICROCHIP_SPI)	+= microchip-spi.o
 obj-$(CONFIG_ALTERA_PR_IP_CORE)         += altera-pr-ip-core.o
 obj-$(CONFIG_ALTERA_PR_IP_CORE_PLAT)    += altera-pr-ip-core-plat.o
 obj-$(CONFIG_ECP5_FPGA_MGR)		+= stcmtk/grif/ecp5_fpga_mgr/
diff --git a/drivers/fpga/microchip-spi.c b/drivers/fpga/microchip-spi.c
new file mode 100644
index 000000000000..5e79677c29f4
--- /dev/null
+++ b/drivers/fpga/microchip-spi.c
@@ -0,0 +1,448 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Microchip Polarfire FPGA programming over slave SPI interface.
+ */
+
+#include <linux/crc-ccitt.h>
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
+#define	MPF_STATUS_POLL_TIMEOUT	1000
+#define	MPF_STATUS_BUSY		BIT(0)
+#define	MPF_STATUS_READY	BIT(1)
+
+struct mpf_priv {
+	struct spi_device *spi;
+	bool program_mode;
+};
+
+static enum fpga_mgr_states mpf_ops_state(struct fpga_manager *mgr)
+{
+	struct mpf_priv *priv = mgr->priv;
+	struct spi_device *spi;
+	bool program_mode;
+	ssize_t status;
+
+	program_mode = priv->program_mode;
+	spi = priv->spi;
+
+	status = spi_w8r8(spi, MPF_SPI_READ_STATUS);
+
+	if (!program_mode && !status)
+		return FPGA_MGR_STATE_OPERATING;
+
+	return FPGA_MGR_STATE_UNKNOWN;
+}
+
+static int poll_status_not_busy(struct spi_device *spi, u8 mask)
+{
+	ssize_t status, timeout = MPF_STATUS_POLL_TIMEOUT;
+
+	while (timeout--) {
+		status = spi_w8r8(spi, MPF_SPI_READ_STATUS);
+		if (status < 0)
+			return status;
+
+		if (!(status & MPF_STATUS_BUSY) && (!mask || (status & mask)))
+			return status;
+
+		usleep_range(1000, 2000);
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
+static int get_sgt_data(struct sg_table *sgt, size_t offset, void *data,
+			size_t data_size)
+{
+	struct sg_mapping_iter miter;
+	size_t remainder;
+
+	sg_miter_start(&miter, sgt->sgl, sgt->nents, SG_MITER_FROM_SG);
+	while (sg_miter_next(&miter)) {
+		if (offset < miter.length)
+			break;
+
+		offset -= miter.length;
+	}
+
+	if (!miter.addr) {
+		sg_miter_stop(&miter);
+		return -EFAULT;
+	}
+
+	remainder = max((ssize_t)0, (ssize_t)offset + (ssize_t)data_size -
+			(ssize_t)miter.length);
+
+	memcpy(data, miter.addr + offset, data_size - remainder);
+
+	while (remainder && sg_miter_next(&miter)) {
+		memcpy(data + data_size - remainder, miter.addr,
+		       min(remainder, miter.length));
+		remainder = max((ssize_t)0,
+				(ssize_t)remainder - (ssize_t)miter.length);
+	}
+	sg_miter_stop(&miter);
+
+	if (remainder)
+		return -EFAULT;
+
+	return 0;
+}
+
+static ssize_t lookup_block_start(struct sg_table *sgt, int id)
+{
+	size_t block_start_offset, block_id_offset, i;
+	u8 header_size, blocks_num, block_id;
+	u32 block_start;
+	int ret;
+
+	ret = get_sgt_data(sgt, MPF_HEADER_SIZE_OFFSET, &header_size,
+			   sizeof(header_size));
+	if (ret)
+		return ret;
+
+	ret = get_sgt_data(sgt, header_size - 1, &blocks_num,
+			   sizeof(blocks_num));
+	if (ret)
+		return ret;
+
+	for (i = 0; i < blocks_num; i++) {
+		block_id_offset = header_size +
+				  i * MPF_LOOKUP_TABLE_RECORD_SIZE +
+				  MPF_LOOKUP_TABLE_BLOCK_ID_OFFSET;
+
+		ret = get_sgt_data(sgt, block_id_offset, &block_id,
+				   sizeof(block_id));
+		if (ret)
+			return ret;
+
+		if (block_id == id) {
+			block_start_offset = header_size +
+					     i * MPF_LOOKUP_TABLE_RECORD_SIZE +
+					     MPF_LOOKUP_TABLE_BLOCK_START_OFFSET;
+
+			ret = get_sgt_data(sgt, block_start_offset, &block_start,
+					   sizeof(block_start));
+			if (ret)
+				return ret;
+
+			return le32_to_cpu(block_start);
+		}
+	}
+
+	return -EFAULT;
+}
+
+static ssize_t parse_bitstream_size(struct sg_table *sgt)
+{
+	size_t component_size_byte_num, component_size_byte_off,
+	       i, bitstream_size = 0;
+	ssize_t components_size_start;
+	u16 components_num;
+	u32 component_size;
+	int ret;
+
+	ret = get_sgt_data(sgt, MPF_DATA_SIZE_OFFSET, &components_num,
+			   sizeof(components_num));
+	if (ret)
+		return ret;
+
+	components_num = le16_to_cpu(components_num);
+
+	components_size_start = lookup_block_start(sgt, MPF_COMPONENTS_SIZE_ID);
+	if (components_size_start < 0)
+		return components_size_start;
+
+	for (i = 0; i < components_num; i++) {
+		component_size_byte_num =
+			(i * MPF_BITS_PER_COMPONENT_SIZE) / BITS_PER_BYTE;
+		component_size_byte_off =
+			(i * MPF_BITS_PER_COMPONENT_SIZE) % BITS_PER_BYTE;
+
+		ret = get_sgt_data(sgt, components_size_start +
+				   component_size_byte_num,
+				   &component_size, sizeof(component_size));
+		if (ret)
+			return ret;
+
+		component_size = le32_to_cpu(component_size);
+		component_size >>= component_size_byte_off;
+		component_size &= GENMASK(MPF_BITS_PER_COMPONENT_SIZE - 1, 0);
+
+		bitstream_size += component_size;
+	}
+
+	return bitstream_size;
+}
+
+static u16 crc_ccitt_sg(struct sg_table *sgt)
+{
+	struct sg_mapping_iter miter;
+	u16 crc = 0;
+
+	sg_miter_start(&miter, sgt->sgl, sgt->nents, SG_MITER_FROM_SG);
+	while (sg_miter_next(&miter))
+		crc = crc_ccitt(crc, miter.addr, miter.length);
+	sg_miter_stop(&miter);
+
+	return crc;
+}
+
+static int mpf_ops_write_sg(struct fpga_manager *mgr, struct sg_table *sgt)
+{
+	u8 tmp_buf[MPF_SPI_FRAME_SIZE + 1] = { MPF_SPI_FRAME, };
+	ssize_t bitstream_start, bitstream_size;
+	struct mpf_priv *priv = mgr->priv;
+	struct device *dev = &mgr->dev;
+	struct sg_mapping_iter miter;
+	struct spi_device *spi;
+	size_t remainder;
+	int ret, i;
+
+	if (crc_ccitt_sg(sgt)) {
+		dev_err(dev, "CRC error\n");
+		return -EINVAL;
+	}
+
+	bitstream_start = lookup_block_start(sgt, MPF_BITSTREAM_ID);
+	if (bitstream_start < 0) {
+		dev_err(dev, "Failed to find bitstream start %zd\n",
+			bitstream_start);
+		return bitstream_start;
+	}
+
+	bitstream_size = parse_bitstream_size(sgt);
+	if (bitstream_size < 0) {
+		dev_err(dev, "Failed to parse bitstream size %zd\n",
+			bitstream_size);
+		return bitstream_size;
+	}
+
+	spi = priv->spi;
+
+	sg_miter_start(&miter, sgt->sgl, sgt->nents, SG_MITER_FROM_SG);
+	for (i = 0; i < bitstream_size; i++) {
+		do {
+			if (bitstream_start < miter.length)
+				break;
+
+			bitstream_start -= miter.length;
+		} while (sg_miter_next(&miter));
+
+		remainder = max((ssize_t)0, bitstream_start +
+				(ssize_t)MPF_SPI_FRAME_SIZE -
+				(ssize_t)miter.length);
+
+		memcpy(tmp_buf + 1, miter.addr + bitstream_start,
+		       MPF_SPI_FRAME_SIZE - remainder);
+
+		while (remainder) {
+			bitstream_start -= miter.length;
+
+			if (sg_miter_next(&miter)) {
+				memcpy(tmp_buf + 1 + MPF_SPI_FRAME_SIZE -
+				       remainder, miter.addr,
+				       min(remainder, miter.length));
+				remainder = max((ssize_t)0, (ssize_t)remainder -
+						(ssize_t)miter.length);
+			} else {
+				dev_err(dev,
+					"Bitstream outruns firmware image. Frame %d of %zd\n",
+					i, bitstream_size);
+				sg_miter_stop(&miter);
+				return -EFAULT;
+			}
+		}
+
+		bitstream_start += MPF_SPI_FRAME_SIZE;
+
+		ret = mpf_spi_write(spi, tmp_buf, sizeof(tmp_buf));
+		if (ret) {
+			dev_err(dev,
+				"Failed to write bitstream frame number %d of %zd\n",
+				i, bitstream_size);
+			sg_miter_stop(&miter);
+			return ret;
+		}
+	}
+	sg_miter_stop(&miter);
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
+	.write_init = mpf_ops_write_init,
+	.write_sg = mpf_ops_write_sg,
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
2.34.1


