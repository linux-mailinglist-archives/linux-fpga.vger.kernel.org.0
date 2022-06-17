Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EFD754EF1F
	for <lists+linux-fpga@lfdr.de>; Fri, 17 Jun 2022 04:10:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379637AbiFQCHx (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 16 Jun 2022 22:07:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230527AbiFQCHv (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 16 Jun 2022 22:07:51 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DBE721251;
        Thu, 16 Jun 2022 19:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655431669; x=1686967669;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QE6fNepvG+Tvh7mX82wm+jXyHbjPO4wXHip12ZTQGCE=;
  b=ERyxoqP+r6tDvqIm78411g0T8oi/NOp/sFvminog6HEjsZvDDoBH9ATx
   pzi2M2b827pkrXuyC3qveF8ek4xZF4Mg6WSLQffyOnV1cXlnaGMuUGtvH
   AT4QsjjusNfKu03qDbleAVfAjmCt5rENc+3jSSc1k+mw8tq1YkUiBmas7
   Lv8o6lG0NLM5WsIjM0kTLS+6mVSRY3oOqpgMtI/9Yf9gXytYZRTFfXENQ
   aAJJsq1dd668qP6WmuBsnBg2DV9qY0Hs/ZdWdbaqlFKpgJ3TZSsLf+QaK
   +dTV1NBZ4A0rzB/KYAT0P3AxoxG86fpqnjvP3vaC/QJ8sgAlJjQzUpY0w
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="365750330"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="365750330"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2022 19:07:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="831831724"
Received: from unknown (HELO localhost.localdomain.sh.intel.com) ([10.238.175.107])
  by fmsmga006.fm.intel.com with ESMTP; 16 Jun 2022 19:07:46 -0700
From:   Tianfei Zhang <tianfei.zhang@intel.com>
To:     yilun.xu@intel.com, lee.jones@linaro.org
Cc:     hao.wu@intel.com, trix@redhat.com, linux-kernel@vger.kernel.org,
        linux-fpga@vger.kernel.org, russell.h.weight@intel.com,
        matthew.gerlach@linux.intel.com,
        Tianfei Zhang <tianfei.zhang@intel.com>
Subject: [PATCH v2 3/4] mfd: intel-m10-bmc: add PMCI driver
Date:   Thu, 16 Jun 2022 22:04:04 -0400
Message-Id: <20220617020405.128352-4-tianfei.zhang@intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20220617020405.128352-1-tianfei.zhang@intel.com>
References: <20220617020405.128352-1-tianfei.zhang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Adding a driver for the PMCI-base interface of Intel MAX10
BMC controller.

PMCI(Platform Management Control Interface) is a software-visible
interface, connected to card BMC which provided telemetry and mailbox
functionalities. On the other hand, this driver leverages the regmap
APIs to support Intel specific Indirect Register Interface for register
read/write on PMCI.

Signed-off-by: Tianfei Zhang <tianfei.zhang@intel.com>
Signed-off-by: Russ Weight <russell.h.weight@intel.com>
Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
---
v2:
  - fix compile warning reported by lkp
  - use regmap API for Indirect Register Interface.
---
 .../ABI/testing/sysfs-driver-intel-m10-bmc    |   8 +-
 drivers/mfd/Kconfig                           |  12 ++
 drivers/mfd/Makefile                          |   1 +
 drivers/mfd/intel-m10-bmc-core.c              |  19 +-
 drivers/mfd/intel-m10-bmc-pmci.c              | 190 ++++++++++++++++++
 include/linux/mfd/intel-m10-bmc.h             |   8 +
 6 files changed, 230 insertions(+), 8 deletions(-)
 create mode 100644 drivers/mfd/intel-m10-bmc-pmci.c

diff --git a/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc b/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc
index 9773925138af..a8ab58035c95 100644
--- a/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc
+++ b/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc
@@ -1,4 +1,4 @@
-What:		/sys/bus/spi/devices/.../bmc_version
+What:		/sys/bus/.../drivers/intel-m10-bmc/.../bmc_version
 Date:		June 2020
 KernelVersion:	5.10
 Contact:	Xu Yilun <yilun.xu@intel.com>
@@ -6,7 +6,7 @@ Description:	Read only. Returns the hardware build version of Intel
 		MAX10 BMC chip.
 		Format: "0x%x".
 
-What:		/sys/bus/spi/devices/.../bmcfw_version
+What:		/sys/bus/.../drivers/intel-m10-bmc/.../bmcfw_version
 Date:		June 2020
 KernelVersion:	5.10
 Contact:	Xu Yilun <yilun.xu@intel.com>
@@ -14,7 +14,7 @@ Description:	Read only. Returns the firmware version of Intel MAX10
 		BMC chip.
 		Format: "0x%x".
 
-What:		/sys/bus/spi/devices/.../mac_address
+What:		/sys/bus/.../drivers/intel-m10-bmc/.../mac_address
 Date:		January 2021
 KernelVersion:  5.12
 Contact:	Russ Weight <russell.h.weight@intel.com>
@@ -25,7 +25,7 @@ Description:	Read only. Returns the first MAC address in a block
 		space.
 		Format: "%02x:%02x:%02x:%02x:%02x:%02x".
 
-What:		/sys/bus/spi/devices/.../mac_count
+What:		/sys/bus/.../drivers/intel-m10-bmc/.../mac_count
 Date:		January 2021
 KernelVersion:  5.12
 Contact:	Russ Weight <russell.h.weight@intel.com>
diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index ee8398b02321..7300efec3617 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -2177,6 +2177,18 @@ config MFD_INTEL_M10_BMC_SPI
           additional drivers must be enabled in order to use the functionality
           of the device.
 
+config MFD_INTEL_M10_BMC_PMCI
+	tristate "Intel MAX 10 Board Management Controller with PMCI"
+	depends on FPGA_DFL
+	select MFD_INTEL_M10_BMC_CORE
+	select REGMAP_INDIRECT_REGISTER
+	help
+	  Support for the Intel MAX 10 board management controller via PMCI.
+
+	  This driver provides common support for accessing the device,
+	  additional drivers must be enabled in order to use the functionality
+	  of the device.
+
 config MFD_RSMU_I2C
 	tristate "Renesas Synchronization Management Unit with I2C"
 	depends on I2C && OF
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index b5d3263c1205..a8ffdc223cf7 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -270,6 +270,7 @@ obj-$(CONFIG_MFD_SIMPLE_MFD_I2C)	+= simple-mfd-i2c.o
 intel-m10-bmc-objs             := intel-m10-bmc-core.o
 obj-$(CONFIG_MFD_INTEL_M10_BMC_CORE)   += intel-m10-bmc.o
 obj-$(CONFIG_MFD_INTEL_M10_BMC_SPI)   += intel-m10-bmc-spi.o
+obj-$(CONFIG_MFD_INTEL_M10_BMC_PMCI)  += intel-m10-bmc-pmci.o
 
 obj-$(CONFIG_MFD_ATC260X)	+= atc260x-core.o
 obj-$(CONFIG_MFD_ATC260X_I2C)	+= atc260x-i2c.o
diff --git a/drivers/mfd/intel-m10-bmc-core.c b/drivers/mfd/intel-m10-bmc-core.c
index f6dc549e1bc3..c6a1a4c28357 100644
--- a/drivers/mfd/intel-m10-bmc-core.c
+++ b/drivers/mfd/intel-m10-bmc-core.c
@@ -10,6 +10,11 @@
 #include <linux/mfd/intel-m10-bmc.h>
 #include <linux/module.h>
 
+static struct mfd_cell m10bmc_n6000_bmc_subdevs[] = {
+	{ .name = "n6000bmc-hwmon" },
+	{ .name = "n6000bmc-sec-update" }
+};
+
 static struct mfd_cell m10bmc_d5005_subdevs[] = {
 	{ .name = "d5005bmc-hwmon" },
 };
@@ -146,10 +151,12 @@ int m10bmc_dev_init(struct intel_m10bmc *m10bmc)
 
 	dev_set_drvdata(m10bmc->dev, m10bmc);
 
-	ret = check_m10bmc_version(m10bmc);
-	if (ret) {
-		dev_err(m10bmc->dev, "Failed to identify m10bmc hardware\n");
-		return ret;
+	if (type == M10_N3000 || type == M10_D5005 || type == M10_N5010) {
+		ret = check_m10bmc_version(m10bmc);
+		if (ret) {
+			dev_err(m10bmc->dev, "Failed to identify m10bmc hardware\n");
+			return ret;
+		}
 	}
 
 	switch (type) {
@@ -165,6 +172,10 @@ int m10bmc_dev_init(struct intel_m10bmc *m10bmc)
 		cells = m10bmc_n5010_subdevs;
 		n_cell = ARRAY_SIZE(m10bmc_n5010_subdevs);
 		break;
+	case M10_N6000:
+		cells = m10bmc_n6000_bmc_subdevs;
+		n_cell = ARRAY_SIZE(m10bmc_n6000_bmc_subdevs);
+		break;
 	default:
 		return -ENODEV;
 	}
diff --git a/drivers/mfd/intel-m10-bmc-pmci.c b/drivers/mfd/intel-m10-bmc-pmci.c
new file mode 100644
index 000000000000..249a2db5e742
--- /dev/null
+++ b/drivers/mfd/intel-m10-bmc-pmci.c
@@ -0,0 +1,190 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * PMCI-based interface to MAX10 BMC
+ *
+ * Copyright (C) 2020-2022 Intel Corporation, Inc.
+ *
+ */
+
+#include <linux/dfl.h>
+#include <linux/mfd/intel-m10-bmc.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+
+#define M10BMC_PMCI_INDIRECT_BASE 0x400
+#define INDIRECT_INT_US        1
+#define INDIRECT_TIMEOUT_US    10000
+
+#define INDIRECT_CMD_OFF	0x0
+#define INDIRECT_CMD_RD	BIT(0)
+#define INDIRECT_CMD_WR	BIT(1)
+#define INDIRECT_CMD_ACK	BIT(2)
+
+#define INDIRECT_ADDR_OFF	0x4
+#define INDIRECT_RD_OFF	0x8
+#define INDIRECT_WR_OFF	0xc
+
+struct indirect_ctx {
+	void __iomem *base;
+	struct device *dev;
+	unsigned long sleep_us;
+	unsigned long timeout_us;
+};
+
+struct pmci_device {
+	void __iomem *base;
+	struct device *dev;
+	struct intel_m10bmc m10bmc;
+	struct indirect_ctx ctx;
+};
+
+static int pmci_indirect_bus_clr_cmd(struct indirect_ctx *ctx)
+{
+	unsigned int cmd;
+	int ret;
+
+	writel(0, ctx->base + INDIRECT_CMD_OFF);
+	ret = readl_poll_timeout((ctx->base + INDIRECT_CMD_OFF), cmd,
+				 (!cmd), ctx->sleep_us, ctx->timeout_us);
+	if (ret)
+		dev_err(ctx->dev, "%s timed out on clearing cmd 0x%xn", __func__, cmd);
+
+	return ret;
+}
+
+static int pmci_indirect_bus_reg_read(void *context, unsigned int reg,
+				      unsigned int *val)
+{
+	struct indirect_ctx *ctx = context;
+	unsigned int cmd;
+	int ret;
+
+	cmd = readl(ctx->base + INDIRECT_CMD_OFF);
+	if (cmd)
+		dev_warn(ctx->dev, "%s non-zero cmd 0x%x\n", __func__, cmd);
+
+	writel(reg, ctx->base + INDIRECT_ADDR_OFF);
+	writel(INDIRECT_CMD_RD, ctx->base + INDIRECT_CMD_OFF);
+	ret = readl_poll_timeout((ctx->base + INDIRECT_CMD_OFF), cmd,
+				 (cmd & INDIRECT_CMD_ACK), ctx->sleep_us,
+				 ctx->timeout_us);
+	if (ret) {
+		dev_err(ctx->dev, "%s timed out on reg 0x%x cmd 0x%x\n", __func__, reg, cmd);
+		goto out;
+	}
+
+	*val = readl(ctx->base + INDIRECT_RD_OFF);
+
+	if (pmci_indirect_bus_clr_cmd(ctx))
+		ret = -ETIMEDOUT;
+
+out:
+	return ret;
+}
+
+static int pmci_indirect_bus_reg_write(void *context, unsigned int reg,
+				       unsigned int val)
+{
+	struct indirect_ctx *ctx = context;
+	unsigned int cmd;
+	int ret;
+
+	cmd = readl(ctx->base + INDIRECT_CMD_OFF);
+	if (cmd)
+		dev_warn(ctx->dev, "%s non-zero cmd 0x%x\n", __func__, cmd);
+
+	writel(val, ctx->base + INDIRECT_WR_OFF);
+	writel(reg, ctx->base + INDIRECT_ADDR_OFF);
+	writel(INDIRECT_CMD_WR, ctx->base + INDIRECT_CMD_OFF);
+	ret = readl_poll_timeout((ctx->base + INDIRECT_CMD_OFF), cmd,
+				 (cmd & INDIRECT_CMD_ACK), ctx->sleep_us,
+				 ctx->timeout_us);
+	if (ret) {
+		dev_err(ctx->dev, "%s timed out on reg 0x%x cmd 0x%x\n", __func__, reg, cmd);
+		goto out;
+	}
+
+	if (pmci_indirect_bus_clr_cmd(ctx))
+		ret = -ETIMEDOUT;
+
+out:
+	return ret;
+}
+
+static const struct regmap_bus pmci_indirect_bus = {
+	.reg_write = pmci_indirect_bus_reg_write,
+	.reg_read =  pmci_indirect_bus_reg_read,
+};
+
+static const struct regmap_range m10bmc_pmci_regmap_range[] = {
+	regmap_reg_range(M10BMC_PMCI_SYS_BASE, M10BMC_PMCI_SYS_END),
+};
+
+static const struct regmap_access_table m10_access_table = {
+	.yes_ranges	= m10bmc_pmci_regmap_range,
+	.n_yes_ranges	= ARRAY_SIZE(m10bmc_pmci_regmap_range),
+};
+
+static struct regmap_config m10bmc_pmci_regmap_config = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.wr_table = &m10_access_table,
+	.rd_table = &m10_access_table,
+	.max_register = M10BMC_PMCI_SYS_END,
+};
+
+static int pmci_probe(struct dfl_device *ddev)
+{
+	struct device *dev = &ddev->dev;
+	struct pmci_device *pmci;
+
+	pmci = devm_kzalloc(dev, sizeof(*pmci), GFP_KERNEL);
+	if (!pmci)
+		return -ENOMEM;
+
+	pmci->m10bmc.dev = dev;
+	pmci->dev = dev;
+	pmci->m10bmc.type = M10_N6000;
+
+	pmci->base = devm_ioremap_resource(dev, &ddev->mmio_res);
+	if (IS_ERR(pmci->base))
+		return PTR_ERR(pmci->base);
+
+	pmci->ctx.base = pmci->base + M10BMC_PMCI_INDIRECT_BASE;
+	pmci->ctx.sleep_us = INDIRECT_INT_US;
+	pmci->ctx.timeout_us = INDIRECT_TIMEOUT_US;
+	pmci->ctx.dev = dev;
+	pmci->m10bmc.regmap =
+		devm_regmap_init(dev,
+				 &pmci_indirect_bus,
+				 &pmci->ctx,
+				 &m10bmc_pmci_regmap_config);
+	if (IS_ERR(pmci->m10bmc.regmap))
+		return PTR_ERR(pmci->m10bmc.regmap);
+
+	return m10bmc_dev_init(&pmci->m10bmc);
+}
+
+#define FME_FEATURE_ID_PMCI_BMC	0x12
+
+static const struct dfl_device_id pmci_ids[] = {
+	{ FME_ID, FME_FEATURE_ID_PMCI_BMC },
+	{ }
+};
+MODULE_DEVICE_TABLE(dfl, pmci_ids);
+
+static struct dfl_driver pmci_driver = {
+	.drv	= {
+		.name       = "dfl-pmci-bmc",
+		.dev_groups = m10bmc_dev_groups,
+	},
+	.id_table = pmci_ids,
+	.probe    = pmci_probe,
+};
+
+module_dfl_driver(pmci_driver);
+
+MODULE_DESCRIPTION("MAX10 BMC PMCI-based interface");
+MODULE_AUTHOR("Intel Corporation");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/mfd/intel-m10-bmc.h b/include/linux/mfd/intel-m10-bmc.h
index dd81ffdcf168..83c4d3993dcb 100644
--- a/include/linux/mfd/intel-m10-bmc.h
+++ b/include/linux/mfd/intel-m10-bmc.h
@@ -118,11 +118,19 @@
 /* Address of 4KB inverted bit vector containing staging area FLASH count */
 #define STAGING_FLASH_COUNT	0x17ffb000
 
+#define M10BMC_PMCI_SYS_BASE 0x0
+#define M10BMC_PMCI_SYS_END  0xfff
+
+/* Telemetry registers */
+#define M10BMC_PMCI_TELEM_START		0x400
+#define M10BMC_PMCI_TELEM_END		0x78c
+
 /* Supported MAX10 BMC types */
 enum m10bmc_type {
 	M10_N3000,
 	M10_D5005,
 	M10_N5010,
+	M10_N6000
 };
 
 /**
-- 
2.26.2

