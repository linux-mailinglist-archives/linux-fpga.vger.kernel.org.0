Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78020559699
	for <lists+linux-fpga@lfdr.de>; Fri, 24 Jun 2022 11:31:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231962AbiFXJ03 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 24 Jun 2022 05:26:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231963AbiFXJ0W (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 24 Jun 2022 05:26:22 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DEBB74E7D;
        Fri, 24 Jun 2022 02:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656062776; x=1687598776;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eQv/dw4/n7/ganVTszYRxHBRFKOU9D29W4CEPkqWRqA=;
  b=YVHHgy3alEeLpJRAo+s5DBxhzlYxQI5975pafL9Sn4/tRIVOSzxyKA7/
   vY9CshyuMV6A2Vqwreeo/pYfzEwyyypPTQ+hJlR16ut4xb8c26Ht0T04+
   OPPDxiIuRZkOlZgFknUFOhYx6UVAX4r+Ne2DnomoOK5h7vamG5wLsVr+v
   g4I4UHjkZLwVbu72hs0sALbHcEH+C52z2ZsmN+uh9w8VOTPUe5UIb4L/D
   Rjt/+Dxgl7kqyEUTpmF5r9vxVUU96I7QL3xUuzBrx20ZQa+WF+1MsE7oK
   AxnklVHp2tVvqoJbq9nu/YTgPZTzntQc7nBCx+qBRHdBOS5JQBTntyMVc
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10387"; a="261389193"
X-IronPort-AV: E=Sophos;i="5.92,218,1650956400"; 
   d="scan'208";a="261389193"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2022 02:26:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,218,1650956400"; 
   d="scan'208";a="691454957"
Received: from unknown (HELO localhost.localdomain.sh.intel.com) ([10.238.175.107])
  by fmsmga002.fm.intel.com with ESMTP; 24 Jun 2022 02:26:14 -0700
From:   Tianfei Zhang <tianfei.zhang@intel.com>
To:     yilun.xu@intel.com, lee.jones@linaro.org
Cc:     hao.wu@intel.com, trix@redhat.com, linux-kernel@vger.kernel.org,
        linux-fpga@vger.kernel.org, russell.h.weight@intel.com,
        matthew.gerlach@linux.intel.com,
        Tianfei Zhang <tianfei.zhang@intel.com>
Subject: [PATCH v3 2/3] mfd: intel-m10-bmc: add PMCI driver
Date:   Fri, 24 Jun 2022 05:22:28 -0400
Message-Id: <20220624092229.45854-3-tianfei.zhang@intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20220624092229.45854-1-tianfei.zhang@intel.com>
References: <20220624092229.45854-1-tianfei.zhang@intel.com>
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
interface, connected to card BMC which provided the basic functionality
of read/write BMC register. On the other hand, this driver leverages
the regmap APIs to support Intel specific Indirect Register Interface
for register read/write on PMCI.

Signed-off-by: Tianfei Zhang <tianfei.zhang@intel.com>
Signed-off-by: Russ Weight <russell.h.weight@intel.com>
Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
---
v3:
   - create a new driver for intel-m10-bmc-pmci driver
   - remove the regmap_access_table
   - create a new file for sysfs-driver-intel-m10-bmc-pmci ABI
v2:
   - fix compile warning reported by lkp
   - use regmap API for Indirect Register Interface.
---
 .../testing/sysfs-driver-intel-m10-bmc-pmci   |  36 +++
 drivers/mfd/Kconfig                           |  10 +
 drivers/mfd/Makefile                          |   1 +
 drivers/mfd/intel-m10-bmc-pmci.c              | 277 ++++++++++++++++++
 include/linux/mfd/intel-m10-bmc.h             |   8 +
 5 files changed, 332 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-pmci
 create mode 100644 drivers/mfd/intel-m10-bmc-pmci.c

diff --git a/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-pmci b/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-pmci
new file mode 100644
index 000000000000..03371b8022ae
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-pmci
@@ -0,0 +1,36 @@
+What:		/sys/bus/dfl/drivers/dfl-pmci-bmc/dfl_dev.X/bmc_version
+Date:		June 2022
+KernelVersion:	5.19
+Contact:	Tianfei Zhang <tianfei.zhang@intel.com>
+Description:	Read only. Returns the hardware build version of Intel
+		MAX10 BMC chip.
+		Format: "0x%x".
+
+What:		/sys/bus/dfl/drivers/dfl-pmci-bmc/dfl_dev.X/bmcfw_version
+Date:		June 2022
+KernelVersion:	5.19
+Contact:	Tianfei Zhang <tianfei.zhang@intel.com>
+Description:	Read only. Returns the firmware version of Intel MAX10
+		BMC chip.
+		Format: "0x%x".
+
+What:		/sys/bus/dfl/drivers/dfl-pmci-bmc/dfl_dev.X/mac_address
+Date:		June 2022
+KernelVersion:  5.19
+Contact:	Tianfei Zhang <tianfei.zhang@intel.com>
+Description:	Read only. Returns the first MAC address in a block
+		of sequential MAC addresses assigned to the board
+		that is managed by the Intel MAX10 BMC. It is stored in
+		FLASH storage and is mirrored in the MAX10 BMC register
+		space.
+		Format: "%02x:%02x:%02x:%02x:%02x:%02x".
+
+What:		/sys/bus/dfl/drivers/dfl-pmci-bmc/dfl_dev.X/mac_count
+Date:		June 2022
+KernelVersion:  5.19
+Contact:	Tianfei Zhang <tianfei.zhang@intel.com>
+Description:	Read only. Returns the number of sequential MAC
+		addresses assigned to the board managed by the Intel
+		MAX10 BMC. This value is stored in FLASH and is mirrored
+		in the MAX10 BMC register space.
+		Format: "%u".
diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 3b59456f5545..ee196c41a9db 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -2171,6 +2171,16 @@ config MFD_INTEL_M10_BMC
 	  additional drivers must be enabled in order to use the functionality
 	  of the device.
 
+config MFD_INTEL_M10_BMC_PMCI
+	tristate "Intel MAX 10 Board Management Controller with PMCI"
+	depends on FPGA_DFL
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
index 858cacf659d6..f737bd7b7d98 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -267,6 +267,7 @@ obj-$(CONFIG_MFD_QCOM_PM8008)	+= qcom-pm8008.o
 obj-$(CONFIG_SGI_MFD_IOC3)	+= ioc3.o
 obj-$(CONFIG_MFD_SIMPLE_MFD_I2C)	+= simple-mfd-i2c.o
 obj-$(CONFIG_MFD_INTEL_M10_BMC)   += intel-m10-bmc.o
+obj-$(CONFIG_MFD_INTEL_M10_BMC_PMCI)   += intel-m10-bmc-pmci.o
 
 obj-$(CONFIG_MFD_ATC260X)	+= atc260x-core.o
 obj-$(CONFIG_MFD_ATC260X_I2C)	+= atc260x-i2c.o
diff --git a/drivers/mfd/intel-m10-bmc-pmci.c b/drivers/mfd/intel-m10-bmc-pmci.c
new file mode 100644
index 000000000000..93eca4483ac7
--- /dev/null
+++ b/drivers/mfd/intel-m10-bmc-pmci.c
@@ -0,0 +1,277 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * PMCI-based interface to MAX10 BMC
+ *
+ * Copyright (C) 2020-2022 Intel Corporation, Inc.
+ *
+ */
+#include <linux/bitfield.h>
+#include <linux/dfl.h>
+#include <linux/mfd/intel-m10-bmc.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+#include <linux/mfd/core.h>
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
+static struct mfd_cell m10bmc_n6000_bmc_subdevs[] = {
+	{ .name = "n6000bmc-hwmon" },
+	{ .name = "n6000bmc-sec-update" }
+};
+
+static struct regmap_config m10bmc_pmci_regmap_config = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.max_register = M10BMC_PMCI_SYS_END,
+};
+
+static ssize_t bmc_version_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	struct intel_m10bmc *ddata = dev_get_drvdata(dev);
+	unsigned int val;
+	int ret;
+
+	ret = m10bmc_sys_read(ddata, M10BMC_PMCI_BUILD_VER, &val);
+	if (ret)
+		return ret;
+
+	return sprintf(buf, "0x%x\n", val);
+}
+static DEVICE_ATTR_RO(bmc_version);
+
+static ssize_t bmcfw_version_show(struct device *dev,
+				  struct device_attribute *attr, char *buf)
+{
+	struct intel_m10bmc *ddata = dev_get_drvdata(dev);
+	unsigned int val;
+	int ret;
+
+	ret = m10bmc_sys_read(ddata, NIOS2_PMCI_FW_VERSION, &val);
+	if (ret)
+		return ret;
+
+	return sprintf(buf, "0x%x\n", val);
+}
+static DEVICE_ATTR_RO(bmcfw_version);
+
+static ssize_t mac_address_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	struct intel_m10bmc *max10 = dev_get_drvdata(dev);
+	unsigned int macaddr_low, macaddr_high;
+	int ret;
+
+	ret = m10bmc_sys_read(max10, M10BMC_PMCI_MAC_LOW, &macaddr_low);
+	if (ret)
+		return ret;
+
+	ret = m10bmc_sys_read(max10, M10BMC_PMCI_MAC_HIGH, &macaddr_high);
+	if (ret)
+		return ret;
+
+	return sysfs_emit(buf, "%02x:%02x:%02x:%02x:%02x:%02x\n",
+			  (u8)FIELD_GET(M10BMC_MAC_BYTE1, macaddr_low),
+			  (u8)FIELD_GET(M10BMC_MAC_BYTE2, macaddr_low),
+			  (u8)FIELD_GET(M10BMC_MAC_BYTE3, macaddr_low),
+			  (u8)FIELD_GET(M10BMC_MAC_BYTE4, macaddr_low),
+			  (u8)FIELD_GET(M10BMC_MAC_BYTE5, macaddr_high),
+			  (u8)FIELD_GET(M10BMC_MAC_BYTE6, macaddr_high));
+}
+static DEVICE_ATTR_RO(mac_address);
+
+static ssize_t mac_count_show(struct device *dev,
+			      struct device_attribute *attr, char *buf)
+{
+	struct intel_m10bmc *max10 = dev_get_drvdata(dev);
+	unsigned int macaddr_high;
+	int ret;
+
+	ret = m10bmc_sys_read(max10, M10BMC_PMCI_MAC_HIGH, &macaddr_high);
+	if (ret)
+		return ret;
+
+	return sysfs_emit(buf, "%u\n",
+			  (u8)FIELD_GET(M10BMC_MAC_COUNT, macaddr_high));
+}
+static DEVICE_ATTR_RO(mac_count);
+
+static struct attribute *m10bmc_attrs[] = {
+	&dev_attr_bmc_version.attr,
+	&dev_attr_bmcfw_version.attr,
+	&dev_attr_mac_address.attr,
+	&dev_attr_mac_count.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(m10bmc);
+
+static int pmci_probe(struct dfl_device *ddev)
+{
+	struct device *dev = &ddev->dev;
+	struct mfd_cell *cells;
+	struct pmci_device *pmci;
+	int ret, n_cell;
+
+	pmci = devm_kzalloc(dev, sizeof(*pmci), GFP_KERNEL);
+	if (!pmci)
+		return -ENOMEM;
+
+	pmci->m10bmc.dev = dev;
+	pmci->dev = dev;
+
+	pmci->base = devm_ioremap_resource(dev, &ddev->mmio_res);
+	if (IS_ERR(pmci->base))
+		return PTR_ERR(pmci->base);
+
+	dev_set_drvdata(dev, &pmci->m10bmc);
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
+	cells = m10bmc_n6000_bmc_subdevs;
+	n_cell = ARRAY_SIZE(m10bmc_n6000_bmc_subdevs);
+
+	ret = devm_mfd_add_devices(dev, PLATFORM_DEVID_AUTO,
+				   cells, n_cell, NULL, 0, NULL);
+	if (ret)
+		dev_err(dev, "Failed to register sub-devices: %d\n",
+			ret);
+
+	return ret;
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
+		.dev_groups = m10bmc_groups,
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
index f0044b14136e..7b58af207b72 100644
--- a/include/linux/mfd/intel-m10-bmc.h
+++ b/include/linux/mfd/intel-m10-bmc.h
@@ -118,6 +118,14 @@
 /* Address of 4KB inverted bit vector containing staging area FLASH count */
 #define STAGING_FLASH_COUNT	0x17ffb000
 
+#define M10BMC_PMCI_SYS_BASE 0x0
+#define M10BMC_PMCI_SYS_END  0xfff
+
+#define M10BMC_PMCI_BUILD_VER   0x0
+#define NIOS2_PMCI_FW_VERSION   0x4
+#define M10BMC_PMCI_MAC_LOW     0x20
+#define M10BMC_PMCI_MAC_HIGH    0x24
+
 /**
  * struct intel_m10bmc - Intel MAX 10 BMC parent driver data structure
  * @dev: this device
-- 
2.26.2

