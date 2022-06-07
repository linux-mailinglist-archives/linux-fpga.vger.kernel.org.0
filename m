Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36AC753F498
	for <lists+linux-fpga@lfdr.de>; Tue,  7 Jun 2022 05:35:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbiFGDd1 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 6 Jun 2022 23:33:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236310AbiFGDcR (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 6 Jun 2022 23:32:17 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF8ED117;
        Mon,  6 Jun 2022 20:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654572729; x=1686108729;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QCNTP/W7WdxW5JLKrhRmbVfpz3y/Pa5S4cWZKUuqycU=;
  b=eUMuqbayO/CV66dheP8cw7U5OagTavST3lgU+YxY5w+157KgZlfMxgHC
   +RczxbzXgDrFvCbOdx7r4LbKOUmd3NlmAPdHxq8rAc7a3bKplp6WlIzsY
   hPNBG1442wxd92BuFDf6jBpI9zUFRY5SOq24mn8HUOaL2MevOp2T6vqch
   n+IZHI16mAf70VoshJFIn4ZBh9VKUF5hvn1RebmFSxVtY2bqrlNGdW/op
   yyfPGAtsak6mczex6qiBvHhLBySBH82TCKwQTo+n5lcxTWcD1hCEjBbfa
   89XXE5Ex8Ew19FzZagNjvafrMrBgeCsjfcH+LRPuiwRblaBI6r7ydTNvh
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10370"; a="337908397"
X-IronPort-AV: E=Sophos;i="5.91,282,1647327600"; 
   d="scan'208";a="337908397"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2022 20:32:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,282,1647327600"; 
   d="scan'208";a="826161236"
Received: from unknown (HELO localhost.localdomain.sh.intel.com) ([10.238.175.107])
  by fmsmga006.fm.intel.com with ESMTP; 06 Jun 2022 20:32:07 -0700
From:   Tianfei Zhang <tianfei.zhang@intel.com>
To:     yilun.xu@intel.com, lee.jones@linaro.org
Cc:     hao.wu@intel.com, trix@redhat.com, linux-kernel@vger.kernel.org,
        linux-fpga@vger.kernel.org, russell.h.weight@intel.com,
        matthew.gerlach@linux.intel.com,
        Tianfei Zhang <tianfei.zhang@intel.com>
Subject: [PATCH v1 3/4] mfd: intel-m10-bmc: add PMCI driver
Date:   Mon,  6 Jun 2022 23:28:32 -0400
Message-Id: <20220607032833.3482-4-tianfei.zhang@intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20220607032833.3482-1-tianfei.zhang@intel.com>
References: <20220607032833.3482-1-tianfei.zhang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
interface, conneted to card BMC which provided telemetry and mailbox
functionalities.

Signed-off-by: Tianfei Zhang <tianfei.zhang@intel.com>
Signed-off-by: Russ Weight <russell.h.weight@intel.com>
---
 .../ABI/testing/sysfs-driver-intel-m10-bmc    |  8 +-
 drivers/mfd/Kconfig                           | 12 +++
 drivers/mfd/Makefile                          |  1 +
 drivers/mfd/intel-m10-bmc-core.c              | 23 ++++-
 drivers/mfd/intel-m10-bmc-pmci.c              | 88 +++++++++++++++++++
 include/linux/mfd/intel-m10-bmc.h             |  8 ++
 6 files changed, 132 insertions(+), 8 deletions(-)
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
index f6dc549e1bc3..20796f0c4a20 100644
--- a/drivers/mfd/intel-m10-bmc-core.c
+++ b/drivers/mfd/intel-m10-bmc-core.c
@@ -10,6 +10,15 @@
 #include <linux/mfd/intel-m10-bmc.h>
 #include <linux/module.h>
 
+static struct mfd_cell m10bmc_n6000_bmc_subdevs[] = {
+	{ .name = "n6000bmc-hwmon" },
+	{ .name = "n6000bmc-sec-update" }
+};
+
+static const struct regmap_range n6000_fw_handshake_regs[] = {
+	regmap_reg_range(M10BMC_PMCI_TELEM_START, M10BMC_PMCI_TELEM_END),
+};
+
 static struct mfd_cell m10bmc_d5005_subdevs[] = {
 	{ .name = "d5005bmc-hwmon" },
 };
@@ -146,10 +155,12 @@ int m10bmc_dev_init(struct intel_m10bmc *m10bmc)
 
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
@@ -165,6 +176,10 @@ int m10bmc_dev_init(struct intel_m10bmc *m10bmc)
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
index 000000000000..319397774d6e
--- /dev/null
+++ b/drivers/mfd/intel-m10-bmc-pmci.c
@@ -0,0 +1,88 @@
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
+
+struct pmci_device {
+	void __iomem *base;
+	struct device *dev;
+	struct intel_m10bmc m10bmc;
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
+	pmci->m10bmc.regmap =
+		devm_regmap_init_indirect_register(dev,
+						   pmci->base + M10BMC_PMCI_INDIRECT_BASE,
+						   &m10bmc_pmci_regmap_config);
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
+		.name       = "intel-m10-bmc",
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

