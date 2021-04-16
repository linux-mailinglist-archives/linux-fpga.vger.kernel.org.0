Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7395A362619
	for <lists+linux-fpga@lfdr.de>; Fri, 16 Apr 2021 18:55:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237713AbhDPQ4Q (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 16 Apr 2021 12:56:16 -0400
Received: from mga01.intel.com ([192.55.52.88]:11721 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236504AbhDPQ4P (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Fri, 16 Apr 2021 12:56:15 -0400
IronPort-SDR: gQwN+Jv028jRFmeTn74CivghbJfq5aALZul+jhsuR+u1d7kCx8SXXfkgUakWVyn/Ld1D249mVc
 h5FSEiPlIWDg==
X-IronPort-AV: E=McAfee;i="6200,9189,9956"; a="215606435"
X-IronPort-AV: E=Sophos;i="5.82,226,1613462400"; 
   d="scan'208";a="215606435"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2021 09:55:50 -0700
IronPort-SDR: SoiJjiSyL9QI8NgTY1I0ojJTmGG0VntA2BvzNCh4v+qzyeJXoq/EeeQDKJi57E4iN7+0pKehl3
 kWmSyR5ugsIw==
X-IronPort-AV: E=Sophos;i="5.82,226,1613462400"; 
   d="scan'208";a="425655938"
Received: from rhweight-wrk1.ra.intel.com ([137.102.106.42])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2021 09:55:49 -0700
From:   matthew.gerlach@linux.intel.com
To:     hao.wu@intel.com, trix@redhat.com, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, yilun.xu@intel.com,
        russell.h.weight@intel.com, broonie@kernel.org,
        linux-spi@vger.kernel.org
Cc:     Matthew Gerlach <matthew.gerlach@linux.intel.com>
Subject: [PATCH v3 2/2] spi: altera: Add DFL bus driver for Altera API Controller
Date:   Fri, 16 Apr 2021 09:57:20 -0700
Message-Id: <20210416165720.554144-3-matthew.gerlach@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210416165720.554144-1-matthew.gerlach@linux.intel.com>
References: <20210416165720.554144-1-matthew.gerlach@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Matthew Gerlach <matthew.gerlach@linux.intel.com>

This patch adds a Device Feature List (DFL) bus driver for the
Altera SPI Master controller.  The SPI master is connected to an
Intel SPI Slave to Avalon Bridge inside an Intel MAX10
BMC Chip.

Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
---
v3: Instantiate SPI device instead of creating a sub-platform device.
    Changed comment style as per Mark Brown.

v2: moved drivers/fpga/dfl-spi-altera.c to drivers/spi/spi-altera-dfl.c
---
 drivers/spi/Kconfig          |   9 ++
 drivers/spi/Makefile         |   1 +
 drivers/spi/spi-altera-dfl.c | 204 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 214 insertions(+)
 create mode 100644 drivers/spi/spi-altera-dfl.c

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index e59f548..8b161ec 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -70,6 +70,15 @@ config SPI_ALTERA_CORE
 	help
 	  "The core code for the Altera SPI Controller"
 
+config SPI_ALTERA_DFL
+	tristate "DFL bus driver for Altera SPI Controller"
+	depends on FPGA_DFL
+	select SPI_ALTERA_CORE
+	help
+	  This is a Device Feature List (DFL) bus driver for the
+	  Altera SPI master controller.  The SPI master is connected
+	  to a SPI slave to Avalon bridge in a Intel MAX BMC.
+
 config SPI_AR934X
 	tristate "Qualcomm Atheros AR934X/QCA95XX SPI controller driver"
 	depends on ATH79 || COMPILE_TEST
diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
index e6be348..13e54c4 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -16,6 +16,7 @@ obj-$(CONFIG_SPI_LOOPBACK_TEST)		+= spi-loopback-test.o
 # SPI master controller drivers (bus)
 obj-$(CONFIG_SPI_ALTERA)		+= spi-altera-platform.o
 obj-$(CONFIG_SPI_ALTERA_CORE)		+= spi-altera-core.o
+obj-$(CONFIG_SPI_ALTERA_DFL)		+= spi-altera-dfl.o
 obj-$(CONFIG_SPI_AR934X)		+= spi-ar934x.o
 obj-$(CONFIG_SPI_ARMADA_3700)		+= spi-armada-3700.o
 obj-$(CONFIG_SPI_ATMEL)			+= spi-atmel.o
diff --git a/drivers/spi/spi-altera-dfl.c b/drivers/spi/spi-altera-dfl.c
new file mode 100644
index 0000000..3e32e4f
--- /dev/null
+++ b/drivers/spi/spi-altera-dfl.c
@@ -0,0 +1,204 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// DFL bus driver for Altera SPI Master
+//
+// Copyright (C) 2020 Intel Corporation, Inc.
+//
+// Authors:
+//   Matthew Gerlach <matthew.gerlach@linux.intel.com>
+//
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
+#define FME_FEATURE_ID_MAX10_SPI	0xe
+#define FME_FEATURE_REV_MAX10_SPI_N5010	0x1
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
+	void __iomem *base = context;
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
+	void __iomem *base = context;
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
+	.max_register = 24,
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
+static void config_spi_master(void __iomem *base, struct spi_master *master)
+{
+	u64 v;
+
+	v = readq(base + SPI_CORE_PARAMETER);
+
+	master->mode_bits = SPI_CS_HIGH;
+	if (FIELD_GET(CLK_POLARITY, v))
+		master->mode_bits |= SPI_CPOL;
+	if (FIELD_GET(CLK_PHASE, v))
+		master->mode_bits |= SPI_CPHA;
+
+	master->num_chipselect = FIELD_GET(NUM_CHIPSELECT, v);
+	master->bits_per_word_mask =
+		SPI_BPW_RANGE_MASK(1, FIELD_GET(DATA_WIDTH, v));
+}
+
+static int dfl_spi_altera_probe(struct dfl_device *dfl_dev)
+{
+	struct device *dev = &dfl_dev->dev;
+	struct spi_master *master;
+	struct altera_spi *hw;
+	void __iomem *base;
+	int err = -ENODEV;
+
+	master = spi_alloc_master(dev, sizeof(struct altera_spi));
+	if (!master)
+		return -ENOMEM;
+
+	master->bus_num = dfl_dev->id;
+
+	hw = spi_master_get_devdata(master);
+
+	hw->dev = dev;
+
+	base = devm_ioremap_resource(dev, &dfl_dev->mmio_res);
+
+	if (IS_ERR(base)) {
+		dev_err(dev, "%s get mem resource fail!\n", __func__);
+		return PTR_ERR(base);
+	}
+
+	config_spi_master(base, master);
+	dev_dbg(dev, "%s cs %u bpm 0x%x mode 0x%x\n", __func__,
+		master->num_chipselect, master->bits_per_word_mask,
+		master->mode_bits);
+
+	hw->regmap = devm_regmap_init(dev, NULL, base, &indirect_regbus_cfg);
+	if (IS_ERR(hw->regmap))
+		return PTR_ERR(hw->regmap);
+
+	hw->irq = -EINVAL;
+
+	altera_spi_init_master(master);
+
+	err = devm_spi_register_master(dev, master);
+	if (err) {
+		dev_err(dev, "%s failed to register spi master %d\n", __func__, err);
+		goto exit;
+	}
+
+	if (!spi_new_device(master,  &m10_bmc_info)) {
+		dev_err(dev, "%s failed to create SPI device: %s\n",
+			__func__, m10_bmc_info.modalias);
+	}
+
+	return 0;
+exit:
+	spi_master_put(master);
+	return err;
+}
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

