Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC63635497C
	for <lists+linux-fpga@lfdr.de>; Tue,  6 Apr 2021 01:52:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242171AbhDEXvx (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 5 Apr 2021 19:51:53 -0400
Received: from mga02.intel.com ([134.134.136.20]:3167 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242169AbhDEXvw (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 5 Apr 2021 19:51:52 -0400
IronPort-SDR: Thj7o9d5EwyUhqSxyKvOGip+pSN3aIceTD/LZI6RxlCgnnM27D96Ko1cRWPDqqhx0+o4CF1Yob
 aXXkI4wUXWFg==
X-IronPort-AV: E=McAfee;i="6000,8403,9945"; a="180076755"
X-IronPort-AV: E=Sophos;i="5.81,308,1610438400"; 
   d="scan'208";a="180076755"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2021 16:51:45 -0700
IronPort-SDR: t1isYr1DeOEP0rA9DRfxoF86sg4C6a6Hinh4B7pBymNGy9PC3TTfj6OON/ZsfR6y6PPklmYOrF
 4BgJ6uqMT/4A==
X-IronPort-AV: E=Sophos;i="5.81,308,1610438400"; 
   d="scan'208";a="414501847"
Received: from rhweight-wrk1.ra.intel.com ([137.102.106.42])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2021 16:51:44 -0700
From:   matthew.gerlach@linux.intel.com
To:     hao.wu@intel.com, trix@redhat.com, mdf@kernel.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        yilun.xu@intel.com, jdelvare@suse.com, linux@roeck-us.net,
        lee.jones@linaro.org, linux-hwmon@vger.kernel.org,
        russell.h.weight@linux.intel.com
Cc:     Matthew Gerlach <matthew.gerlach@linux.intel.com>
Subject: [PATCH 2/3] fpga: dfl: Add DFL bus driver for Altera SPI Master
Date:   Mon,  5 Apr 2021 16:53:00 -0700
Message-Id: <20210405235301.187542-3-matthew.gerlach@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210405235301.187542-1-matthew.gerlach@linux.intel.com>
References: <20210405235301.187542-1-matthew.gerlach@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Matthew Gerlach <matthew.gerlach@linux.intel.com>

This patch adds DFL bus driver for the Altera SPI Master
controller.  The SPI master is connected to an Intel SPI Slave to
Avalon Master Bridge, inside an Intel MAX10 BMC Chip.

Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
---
 drivers/fpga/Kconfig          |   9 ++
 drivers/fpga/Makefile         |   1 +
 drivers/fpga/dfl-spi-altera.c | 221 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 231 insertions(+)
 create mode 100644 drivers/fpga/dfl-spi-altera.c

diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
index d591dd9..0a86994 100644
--- a/drivers/fpga/Kconfig
+++ b/drivers/fpga/Kconfig
@@ -210,6 +210,15 @@ config FPGA_DFL_NIOS_INTEL_PAC_N3000
 	  the card. It also instantiates the SPI master (spi-altera) for
 	  the card's BMC (Board Management Controller).
 
+config FPGA_DFL_SPI_ALTERA
+	tristate "FPGA DFL Altera SPI Master Driver"
+	depends on FPGA_DFL
+	select REGMAP
+	help
+	  This is a DFL bus driver for the Altera SPI master controller.
+	  The SPI master is connected to a SPI slave to Avalon Master
+	  bridge in a Intel MAX BMC.
+
 config FPGA_DFL_PCI
 	tristate "FPGA DFL PCIe Device Driver"
 	depends on PCI && FPGA_DFL
diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
index 18dc9885..58a42ad 100644
--- a/drivers/fpga/Makefile
+++ b/drivers/fpga/Makefile
@@ -45,6 +45,7 @@ dfl-afu-objs := dfl-afu-main.o dfl-afu-region.o dfl-afu-dma-region.o
 dfl-afu-objs += dfl-afu-error.o
 
 obj-$(CONFIG_FPGA_DFL_NIOS_INTEL_PAC_N3000)	+= dfl-n3000-nios.o
+obj-$(CONFIG_FPGA_DFL_SPI_ALTERA)	+= dfl-spi-altera.o
 
 # Drivers for FPGAs which implement DFL
 obj-$(CONFIG_FPGA_DFL_PCI)		+= dfl-pci.o
diff --git a/drivers/fpga/dfl-spi-altera.c b/drivers/fpga/dfl-spi-altera.c
new file mode 100644
index 0000000..9bec25fd
--- /dev/null
+++ b/drivers/fpga/dfl-spi-altera.c
@@ -0,0 +1,221 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * DFL bus driver for Altera SPI Master
+ *
+ * Copyright (C) 2020 Intel Corporation, Inc.
+ *
+ * Authors:
+ *   Matthew Gerlach <matthew.gerlach@linux.intel.com>
+ */
+
+#include <linux/types.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/stddef.h>
+#include <linux/errno.h>
+#include <linux/platform_device.h>
+#include <linux/io.h>
+#include <linux/bitfield.h>
+#include <linux/io-64-nonatomic-lo-hi.h>
+#include <linux/regmap.h>
+#include <linux/spi/spi.h>
+#include <linux/spi/altera.h>
+#include <linux/dfl.h>
+
+struct dfl_altera_spi {
+	void __iomem *base;
+	struct regmap *regmap;
+	struct device *dev;
+	struct platform_device *altr_spi;
+};
+
+#define SPI_CORE_PARAMETER      0x8
+#define SHIFT_MODE              BIT_ULL(1)
+#define SHIFT_MODE_MSB          0
+#define SHIFT_MODE_LSB          1
+#define DATA_WIDTH              GENMASK_ULL(7, 2)
+#define NUM_CHIPSELECT          GENMASK_ULL(13, 8)
+#define CLK_POLARITY            BIT_ULL(14)
+#define CLK_PHASE               BIT_ULL(15)
+#define PERIPHERAL_ID           GENMASK_ULL(47, 32)
+#define SPI_CLK                 GENMASK_ULL(31, 22)
+#define SPI_INDIRECT_ACC_OFST   0x10
+
+#define INDIRECT_ADDR           (SPI_INDIRECT_ACC_OFST+0x0)
+#define INDIRECT_WR             BIT_ULL(8)
+#define INDIRECT_RD             BIT_ULL(9)
+#define INDIRECT_RD_DATA        (SPI_INDIRECT_ACC_OFST+0x8)
+#define INDIRECT_DATA_MASK      GENMASK_ULL(31, 0)
+#define INDIRECT_DEBUG          BIT_ULL(32)
+#define INDIRECT_WR_DATA        (SPI_INDIRECT_ACC_OFST+0x10)
+#define INDIRECT_TIMEOUT        10000
+
+static int indirect_bus_reg_read(void *context, unsigned int reg,
+				 unsigned int *val)
+{
+	struct dfl_altera_spi *aspi = context;
+	void __iomem *base = aspi->base;
+	int loops;
+	u64 v;
+
+	writeq((reg >> 2) | INDIRECT_RD, base + INDIRECT_ADDR);
+
+	loops = 0;
+	while ((readq(base + INDIRECT_ADDR) & INDIRECT_RD) &&
+	       (loops++ < INDIRECT_TIMEOUT))
+		cpu_relax();
+
+	if (loops >= INDIRECT_TIMEOUT) {
+		pr_err("%s timed out %d\n", __func__, loops);
+		return -ETIME;
+	}
+
+	v = readq(base + INDIRECT_RD_DATA);
+
+	*val = v & INDIRECT_DATA_MASK;
+
+	return 0;
+}
+
+static int indirect_bus_reg_write(void *context, unsigned int reg,
+				  unsigned int val)
+{
+	struct dfl_altera_spi *aspi = context;
+	void __iomem *base = aspi->base;
+	int loops;
+
+	writeq(val, base + INDIRECT_WR_DATA);
+	writeq((reg >> 2) | INDIRECT_WR, base + INDIRECT_ADDR);
+
+	loops = 0;
+	while ((readq(base + INDIRECT_ADDR) & INDIRECT_WR) &&
+	       (loops++ < INDIRECT_TIMEOUT))
+		cpu_relax();
+
+	if (loops >= INDIRECT_TIMEOUT) {
+		pr_err("%s timed out %d\n", __func__, loops);
+		return -ETIME;
+	}
+	return 0;
+}
+
+static const struct regmap_config indirect_regbus_cfg = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.fast_io = true,
+
+	.reg_write = indirect_bus_reg_write,
+	.reg_read = indirect_bus_reg_read,
+};
+
+static struct spi_board_info m10_bmc_info = {
+	.modalias = "m10-d5005",
+	.max_speed_hz = 12500000,
+	.bus_num = 0,
+	.chip_select = 0,
+};
+
+static struct platform_device *create_cntrl(struct device *dev,
+					    void __iomem *base,
+					    struct spi_board_info *m10_info)
+{
+	struct altera_spi_platform_data pdata;
+	struct platform_device_info pdevinfo;
+	u64 v;
+
+	v = readq(base + SPI_CORE_PARAMETER);
+
+	memset(&pdata, 0, sizeof(pdata));
+	pdata.mode_bits = SPI_CS_HIGH;
+	if (FIELD_GET(CLK_POLARITY, v))
+		pdata.mode_bits |= SPI_CPOL;
+	if (FIELD_GET(CLK_PHASE, v))
+		pdata.mode_bits |= SPI_CPHA;
+
+	pdata.num_chipselect = FIELD_GET(NUM_CHIPSELECT, v);
+	pdata.bits_per_word_mask =
+		SPI_BPW_RANGE_MASK(1, FIELD_GET(DATA_WIDTH, v));
+
+	pdata.num_devices = 1;
+	pdata.devices = m10_info;
+
+	dev_dbg(dev, "%s cs %u bpm 0x%x mode 0x%x\n", __func__,
+		pdata.num_chipselect, pdata.bits_per_word_mask,
+		pdata.mode_bits);
+
+	memset(&pdevinfo, 0, sizeof(pdevinfo));
+
+	pdevinfo.name = "subdev_spi_altera";
+	pdevinfo.id = PLATFORM_DEVID_AUTO;
+	pdevinfo.parent = dev;
+	pdevinfo.data = &pdata;
+	pdevinfo.size_data = sizeof(pdata);
+
+	return platform_device_register_full(&pdevinfo);
+}
+static int dfl_spi_altera_probe(struct dfl_device *dfl_dev)
+{
+	struct device *dev = &dfl_dev->dev;
+	struct dfl_altera_spi *aspi;
+
+	aspi = devm_kzalloc(dev, sizeof(*aspi), GFP_KERNEL);
+
+	if (!aspi)
+		return -ENOMEM;
+
+	dev_set_drvdata(dev, aspi);
+
+	aspi->dev = dev;
+
+	aspi->base = devm_ioremap_resource(dev, &dfl_dev->mmio_res);
+
+	if (IS_ERR(aspi->base)) {
+		dev_err(dev, "%s get mem resource fail!\n", __func__);
+		return PTR_ERR(aspi->base);
+	}
+
+	aspi->regmap = devm_regmap_init(dev, NULL, aspi, &indirect_regbus_cfg);
+	if (IS_ERR(aspi->regmap))
+		return PTR_ERR(aspi->regmap);
+
+	aspi->altr_spi = create_cntrl(dev, aspi->base, &m10_bmc_info);
+
+	if (IS_ERR(aspi->altr_spi)) {
+		dev_err(dev, "%s failed to create spi platform driver\n",
+			__func__);
+		return PTR_ERR(aspi->base);
+	}
+
+	return 0;
+}
+
+static void dfl_spi_altera_remove(struct dfl_device *dfl_dev)
+{
+	struct dfl_altera_spi *aspi = dev_get_drvdata(&dfl_dev->dev);
+
+	platform_device_unregister(aspi->altr_spi);
+}
+
+#define FME_FEATURE_ID_MAX10_SPI        0xe
+
+static const struct dfl_device_id dfl_spi_altera_ids[] = {
+	{ FME_ID, FME_FEATURE_ID_MAX10_SPI },
+	{ }
+};
+
+static struct dfl_driver dfl_spi_altera_driver = {
+	.drv	= {
+		.name       = "dfl-spi-altera",
+	},
+	.id_table = dfl_spi_altera_ids,
+	.probe   = dfl_spi_altera_probe,
+	.remove  = dfl_spi_altera_remove,
+};
+
+module_dfl_driver(dfl_spi_altera_driver);
+
+MODULE_DEVICE_TABLE(dfl, dfl_spi_altera_ids);
+MODULE_DESCRIPTION("DFL spi altera driver");
+MODULE_AUTHOR("Intel Corporation");
+MODULE_LICENSE("GPL v2");
-- 
1.8.3.1

