Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1DB9656476
	for <lists+linux-fpga@lfdr.de>; Mon, 26 Dec 2022 19:03:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232157AbiLZSAO (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 26 Dec 2022 13:00:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232136AbiLZSAD (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 26 Dec 2022 13:00:03 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCDE22643;
        Mon, 26 Dec 2022 10:00:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672077602; x=1703613602;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QW562tPr60E5UZd8qI/9IQcDm+J+rd/OzDzKjHBfp8U=;
  b=gnJTtZKNec3DaZCtAiFOeY3kwtzI2k2JJjd/sjDpWuYfV3+bG0FpdIn3
   K8cDZYpT/3xROE5lzW7e/lzEc1IXwVASUJ+RfB1c94NojN2Q+28gULZV+
   3uS5Vf6cepLTQou34oSH7aQK9tvwvOuC1Pyg9FWyMYiJYlqW/hKbU+LH0
   IZxxEmSZZIeR/ZPpG9jUxsfaAfdg3xMuvzHX4tWk3z4erennAgxaeJAd9
   hk16gjU0WjXNBeCfbws9hHDV2uYA1OBfmi9FwuN0kXMR/j2o7AX/Mxcr3
   jHEGZkE6RanllI2DfTJqGqh6f1GYZZrrNa+Iuv8sXVAKZyZdaqPeYYjpS
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10572"; a="322571041"
X-IronPort-AV: E=Sophos;i="5.96,276,1665471600"; 
   d="scan'208";a="322571041"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Dec 2022 10:00:02 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10572"; a="654810219"
X-IronPort-AV: E=Sophos;i="5.96,276,1665471600"; 
   d="scan'208";a="654810219"
Received: from ptelkov-mobl2.ccr.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.249.41.4])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Dec 2022 09:59:57 -0800
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
Subject: [PATCH v5 09/10] mfd: intel-m10-bmc: Add PMCI driver
Date:   Mon, 26 Dec 2022 19:58:48 +0200
Message-Id: <20221226175849.13056-10-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221226175849.13056-1-ilpo.jarvinen@linux.intel.com>
References: <20221226175849.13056-1-ilpo.jarvinen@linux.intel.com>
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

Add the mfd driver for the Platform Management Component Interface
(PMCI) based interface of Intel MAX10 BMC controller.

PMCI is a software-visible interface, connected to card BMC which
provided the basic functionality of read/write BMC register. The access
to the register is done indirectly via a hardware controller/bridge
that handles read/write/clear commands and acknowledgments for the
commands.

Previously, intel-m10-bmc provided sysfs under
/sys/bus/spi/devices/... which is generalized in this change because
not all MAX10 BMC appear under SPI anymore.

Co-developed-by: Tianfei zhang <tianfei.zhang@intel.com>
Signed-off-by: Tianfei zhang <tianfei.zhang@intel.com>
Co-developed-by: Russ Weight <russell.h.weight@intel.com>
Signed-off-by: Russ Weight <russell.h.weight@intel.com>
Co-developed-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
Reviewed-by: Xu Yilun <yilun.xu@intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 .../ABI/testing/sysfs-driver-intel-m10-bmc    |   8 +-
 drivers/mfd/Kconfig                           |  12 +
 drivers/mfd/Makefile                          |   1 +
 drivers/mfd/intel-m10-bmc-pmci.c              | 253 ++++++++++++++++++
 4 files changed, 270 insertions(+), 4 deletions(-)
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
index a09d4ac60dc7..82f13614d98a 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -2238,6 +2238,18 @@ config MFD_INTEL_M10_BMC_SPI
           additional drivers must be enabled in order to use the functionality
           of the device.
 
+config MFD_INTEL_M10_BMC_PMCI
+	tristate "Intel MAX 10 Board Management Controller with PMCI"
+	depends on FPGA_DFL
+	select MFD_INTEL_M10_BMC_CORE
+	select REGMAP
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
index 5d1f308ee2a7..c90fb96cad2a 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -274,6 +274,7 @@ obj-$(CONFIG_MFD_SIMPLE_MFD_I2C)	+= simple-mfd-i2c.o
 
 obj-$(CONFIG_MFD_INTEL_M10_BMC_CORE)	+= intel-m10-bmc-core.o
 obj-$(CONFIG_MFD_INTEL_M10_BMC_SPI)	+= intel-m10-bmc-spi.o
+obj-$(CONFIG_MFD_INTEL_M10_BMC_PMCI)	+= intel-m10-bmc-pmci.o
 
 obj-$(CONFIG_MFD_ATC260X)	+= atc260x-core.o
 obj-$(CONFIG_MFD_ATC260X_I2C)	+= atc260x-i2c.o
diff --git a/drivers/mfd/intel-m10-bmc-pmci.c b/drivers/mfd/intel-m10-bmc-pmci.c
new file mode 100644
index 000000000000..63ec0f6aba8b
--- /dev/null
+++ b/drivers/mfd/intel-m10-bmc-pmci.c
@@ -0,0 +1,253 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * MFD driver for Platform Management Component Interface (PMCI) based
+ * interface to MAX10 BMC.
+ *
+ * Copyright (C) 2020-2022 Intel Corporation.
+ */
+
+#include <linux/device.h>
+#include <linux/dfl.h>
+#include <linux/mfd/core.h>
+#include <linux/mfd/intel-m10-bmc.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+
+#define M10BMC_PMCI_INDIRECT_BASE	0x400
+
+#define M10BMC_N6000_SYS_BASE		0x0
+#define M10BMC_N6000_SYS_END		0xfff
+
+#define M10BMC_N6000_DOORBELL		0x1c0
+#define M10BMC_N6000_AUTH_RESULT	0x1c4
+
+/* Telemetry registers */
+#define M10BMC_N6000_TELEM_START	0x400
+#define M10BMC_N6000_TELEM_END		0x78c
+
+#define M10BMC_N6000_BUILD_VER		0x0
+#define NIOS2_N6000_FW_VERSION		0x4
+#define M10BMC_N6000_MAC_LOW		0x20
+#define M10BMC_N6000_MAC_HIGH		(M10BMC_N6000_MAC_LOW + 4)
+
+/* Addresses for security related data in FLASH */
+#define M10BMC_N6000_BMC_REH_ADDR	0x7ffc004
+#define M10BMC_N6000_BMC_PROG_ADDR	0x7ffc000
+#define M10BMC_N6000_BMC_PROG_MAGIC	0x5746
+
+#define M10BMC_N6000_SR_REH_ADDR	0x7ffd004
+#define M10BMC_N6000_SR_PROG_ADDR	0x7ffd000
+#define M10BMC_N6000_SR_PROG_MAGIC	0x5253
+
+#define M10BMC_N6000_PR_REH_ADDR	0x7ffe004
+#define M10BMC_N6000_PR_PROG_ADDR	0x7ffe000
+#define M10BMC_N6000_PR_PROG_MAGIC	0x5250
+
+#define M10BMC_N6000_STAGING_FLASH_COUNT	0x7ff5000
+
+struct m10bmc_pmci_device {
+	void __iomem *base;
+	struct intel_m10bmc m10bmc;
+};
+
+/*
+ * Intel FGPA indirect register access via hardware controller/bridge.
+ */
+#define INDIRECT_CMD_OFF	0
+#define INDIRECT_CMD_CLR	0
+#define INDIRECT_CMD_RD		BIT(0)
+#define INDIRECT_CMD_WR		BIT(1)
+#define INDIRECT_CMD_ACK	BIT(2)
+
+#define INDIRECT_ADDR_OFF	0x4
+#define INDIRECT_RD_OFF		0x8
+#define INDIRECT_WR_OFF		0xc
+
+#define INDIRECT_INT_US		1
+#define INDIRECT_TIMEOUT_US	10000
+
+struct indirect_ctx {
+        void __iomem *base;
+        struct device *dev;
+};
+
+static int indirect_clear_cmd(struct indirect_ctx *ctx)
+{
+	unsigned int cmd;
+	int ret;
+
+	writel(INDIRECT_CMD_CLR, ctx->base + INDIRECT_CMD_OFF);
+
+	ret = readl_poll_timeout(ctx->base + INDIRECT_CMD_OFF, cmd,
+				 cmd == INDIRECT_CMD_CLR,
+				 INDIRECT_INT_US, INDIRECT_TIMEOUT_US);
+	if (ret)
+		dev_err(ctx->dev, "timed out waiting clear cmd (residual cmd=0x%x)\n", cmd);
+
+	return ret;
+}
+
+static int indirect_reg_read(void *context, unsigned int reg, unsigned int *val)
+{
+	struct indirect_ctx *ctx = context;
+	unsigned int cmd, ack, tmpval;
+	int ret;
+
+	cmd = readl(ctx->base + INDIRECT_CMD_OFF);
+	if (cmd != INDIRECT_CMD_CLR)
+		dev_warn(ctx->dev, "residual cmd 0x%x on read entry\n", cmd);
+
+	writel(reg, ctx->base + INDIRECT_ADDR_OFF);
+	writel(INDIRECT_CMD_RD, ctx->base + INDIRECT_CMD_OFF);
+
+	ret = readl_poll_timeout(ctx->base + INDIRECT_CMD_OFF, ack,
+				 (ack & INDIRECT_CMD_ACK) == INDIRECT_CMD_ACK,
+				 INDIRECT_INT_US, INDIRECT_TIMEOUT_US);
+	if (ret)
+		dev_err(ctx->dev, "read timed out on reg 0x%x ack 0x%x\n", reg, ack);
+	else
+		tmpval = readl(ctx->base + INDIRECT_RD_OFF);
+
+	if (indirect_clear_cmd(ctx)) {
+		if (!ret)
+			ret = -ETIMEDOUT;
+		goto out;
+	}
+
+	*val = tmpval;
+out:
+	return ret;
+}
+
+static int indirect_reg_write(void *context, unsigned int reg, unsigned int val)
+{
+	struct indirect_ctx *ctx = context;
+	unsigned int cmd, ack;
+	int ret;
+
+	cmd = readl(ctx->base + INDIRECT_CMD_OFF);
+	if (cmd != INDIRECT_CMD_CLR)
+		dev_warn(ctx->dev, "residual cmd 0x%x on write entry\n", cmd);
+
+	writel(val, ctx->base + INDIRECT_WR_OFF);
+	writel(reg, ctx->base + INDIRECT_ADDR_OFF);
+	writel(INDIRECT_CMD_WR, ctx->base + INDIRECT_CMD_OFF);
+
+	ret = readl_poll_timeout(ctx->base + INDIRECT_CMD_OFF, ack,
+				 (ack & INDIRECT_CMD_ACK) == INDIRECT_CMD_ACK,
+				 INDIRECT_INT_US, INDIRECT_TIMEOUT_US);
+	if (ret)
+		dev_err(ctx->dev, "write timed out on reg 0x%x ack 0x%x\n", reg, ack);
+
+	if (indirect_clear_cmd(ctx)) {
+		if (!ret)
+			ret = -ETIMEDOUT;
+	}
+
+	return ret;
+}
+
+static const struct regmap_range m10bmc_pmci_regmap_range[] = {
+	regmap_reg_range(M10BMC_N6000_SYS_BASE, M10BMC_N6000_SYS_END),
+};
+
+static const struct regmap_access_table m10bmc_pmci_access_table = {
+	.yes_ranges	= m10bmc_pmci_regmap_range,
+	.n_yes_ranges	= ARRAY_SIZE(m10bmc_pmci_regmap_range),
+};
+
+static struct regmap_config m10bmc_pmci_regmap_config = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.wr_table = &m10bmc_pmci_access_table,
+	.rd_table = &m10bmc_pmci_access_table,
+	.reg_read = &indirect_reg_read,
+	.reg_write = &indirect_reg_write,
+	.max_register = M10BMC_N6000_SYS_END,
+};
+
+static struct mfd_cell m10bmc_pmci_n6000_bmc_subdevs[] = {
+	{ .name = "n6000bmc-hwmon" },
+};
+
+static const struct m10bmc_csr_map m10bmc_n6000_csr_map = {
+	.base = M10BMC_N6000_SYS_BASE,
+	.build_version = M10BMC_N6000_BUILD_VER,
+	.fw_version = NIOS2_N6000_FW_VERSION,
+	.mac_low = M10BMC_N6000_MAC_LOW,
+	.mac_high = M10BMC_N6000_MAC_HIGH,
+	.doorbell = M10BMC_N6000_DOORBELL,
+	.auth_result = M10BMC_N6000_AUTH_RESULT,
+	.rsu_status = M10BMC_N6000_AUTH_RESULT,
+	.bmc_prog_addr = M10BMC_N6000_BMC_PROG_ADDR,
+	.bmc_reh_addr = M10BMC_N6000_BMC_REH_ADDR,
+	.bmc_magic = M10BMC_N6000_BMC_PROG_MAGIC,
+	.sr_prog_addr = M10BMC_N6000_SR_PROG_ADDR,
+	.sr_reh_addr = M10BMC_N6000_SR_REH_ADDR,
+	.sr_magic = M10BMC_N6000_SR_PROG_MAGIC,
+	.pr_prog_addr = M10BMC_N6000_PR_PROG_ADDR,
+	.pr_reh_addr = M10BMC_N6000_PR_REH_ADDR,
+	.pr_magic = M10BMC_N6000_PR_PROG_MAGIC,
+	.rsu_update_counter = M10BMC_N6000_STAGING_FLASH_COUNT,
+};
+
+static const struct intel_m10bmc_platform_info m10bmc_pmci_n6000 = {
+	.cells = m10bmc_pmci_n6000_bmc_subdevs,
+	.n_cells = ARRAY_SIZE(m10bmc_pmci_n6000_bmc_subdevs),
+	.csr_map = &m10bmc_n6000_csr_map,
+};
+
+static int m10bmc_pmci_probe(struct dfl_device *ddev)
+{
+	struct device *dev = &ddev->dev;
+	struct m10bmc_pmci_device *pmci;
+	struct indirect_ctx *ctx;
+
+	pmci = devm_kzalloc(dev, sizeof(*pmci), GFP_KERNEL);
+	if (!pmci)
+		return -ENOMEM;
+
+	pmci->m10bmc.dev = dev;
+
+	pmci->base = devm_ioremap_resource(dev, &ddev->mmio_res);
+	if (IS_ERR(pmci->base))
+		return PTR_ERR(pmci->base);
+
+	ctx = devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
+	if (!ctx)
+		return -ENOMEM;
+
+	ctx->base = pmci->base + M10BMC_PMCI_INDIRECT_BASE;
+	ctx->dev = dev;
+	indirect_clear_cmd(ctx);
+	pmci->m10bmc.regmap = devm_regmap_init(dev, NULL, ctx, &m10bmc_pmci_regmap_config);
+
+	if (IS_ERR(pmci->m10bmc.regmap))
+		return PTR_ERR(pmci->m10bmc.regmap);
+
+	return m10bmc_dev_init(&pmci->m10bmc, &m10bmc_pmci_n6000);
+}
+
+#define FME_FEATURE_ID_M10BMC_PMCI	0x12
+
+static const struct dfl_device_id m10bmc_pmci_ids[] = {
+	{ FME_ID, FME_FEATURE_ID_M10BMC_PMCI },
+	{ }
+};
+MODULE_DEVICE_TABLE(dfl, m10bmc_pmci_ids);
+
+static struct dfl_driver m10bmc_pmci_driver = {
+	.drv	= {
+		.name       = "intel-m10-bmc",
+		.dev_groups = m10bmc_dev_groups,
+	},
+	.id_table = m10bmc_pmci_ids,
+	.probe    = m10bmc_pmci_probe,
+};
+
+module_dfl_driver(m10bmc_pmci_driver);
+
+MODULE_DESCRIPTION("MAX10 BMC PMCI-based interface");
+MODULE_AUTHOR("Intel Corporation");
+MODULE_LICENSE("GPL");
-- 
2.30.2

