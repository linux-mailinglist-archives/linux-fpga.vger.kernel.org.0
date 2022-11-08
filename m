Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F067D621731
	for <lists+linux-fpga@lfdr.de>; Tue,  8 Nov 2022 15:47:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234351AbiKHOpY (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 8 Nov 2022 09:45:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234528AbiKHOoc (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 8 Nov 2022 09:44:32 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69117113D;
        Tue,  8 Nov 2022 06:44:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667918671; x=1699454671;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kApF2AMmIg44tyVdRjtNe54f7jKbByLeGmN3RDTTCSQ=;
  b=JaU0rfe60oifERVjxUYow6AMuCFD4KGz2K5inWwQxhgwrZPc1P0XXuXY
   GoQ0b9cv1nQz07vuq2RX/XeuDUBcvZhgIbOYf+GTQNl+9CFyRbcEUxYXR
   AH/4h+HK7N8/WiSM9RHTBFHGJSXOwe+1XU/zcJgvScWajOci6hJyMzTw5
   XKXr6mDWOo+mK8w69Di06BVLT6yC6bkw88Ui+23VvPXUGWMa6nfQvN6vg
   YVkLad+pkgM5W44LHFNclmP6/q8++N87wjTAVc6Y+1mO7gRkFOINiZdG2
   Ph5osZoW03HvW+iRmpdQ5CkOA5m88EM4JqyvVqbaouMHpW0hhuR/kAElM
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="312498003"
X-IronPort-AV: E=Sophos;i="5.96,148,1665471600"; 
   d="scan'208";a="312498003"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2022 06:44:07 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="638809898"
X-IronPort-AV: E=Sophos;i="5.96,148,1665471600"; 
   d="scan'208";a="638809898"
Received: from ppkrause-mobl.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.249.44.73])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2022 06:44:04 -0800
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-fpga@vger.kernel.org, Xu Yilun <yilun.xu@intel.com>,
        Wu Hao <hao.wu@intel.com>, Tom Rix <trix@redhat.com>,
        Moritz Fischer <mdf@kernel.org>, Lee Jones <lee@kernel.org>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        Russ Weight <russell.h.weight@intel.com>,
        Tianfei zhang <tianfei.zhang@intel.com>,
        Mark Brown <broonie@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 10/12] mfd: intel-m10-bmc: Add PMCI driver
Date:   Tue,  8 Nov 2022 16:43:03 +0200
Message-Id: <20221108144305.45424-11-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221108144305.45424-1-ilpo.jarvinen@linux.intel.com>
References: <20221108144305.45424-1-ilpo.jarvinen@linux.intel.com>
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

Adding an mfd driver for the PMCI-based interface of Intel MAX10 BMC
controller.

Co-developed-by: Tianfei zhang <tianfei.zhang@intel.com>
Signed-off-by: Tianfei zhang <tianfei.zhang@intel.com>
Co-developed-by: Russ Weight <russell.h.weight@intel.com>
Signed-off-by: Russ Weight <russell.h.weight@intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 .../ABI/testing/sysfs-driver-intel-m10-bmc    |   8 +-
 drivers/mfd/Kconfig                           |  12 ++
 drivers/mfd/Makefile                          |   1 +
 drivers/mfd/intel-m10-bmc-pmci.c              | 154 ++++++++++++++++++
 include/linux/mfd/intel-m10-bmc.h             |   1 +
 5 files changed, 172 insertions(+), 4 deletions(-)
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
index a09d4ac60dc7..38d53f6c4d7b 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -2238,6 +2238,18 @@ config MFD_INTEL_M10_BMC_SPI
           additional drivers must be enabled in order to use the functionality
           of the device.
 
+config MFD_INTEL_M10_BMC_PMCI
+	tristate "Intel MAX 10 Board Management Controller with PMCI"
+	depends on FPGA_DFL
+	select MFD_INTEL_M10_BMC_CORE
+	select REGMAP_INDIRECT
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
index f32276cdd0c2..7559362cb438 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -275,6 +275,7 @@ obj-$(CONFIG_MFD_SIMPLE_MFD_I2C)	+= simple-mfd-i2c.o
 intel-m10-bmc-objs             := intel-m10-bmc-core.o
 obj-$(CONFIG_MFD_INTEL_M10_BMC_CORE)   += intel-m10-bmc.o
 obj-$(CONFIG_MFD_INTEL_M10_BMC_SPI)   += intel-m10-bmc-spi.o
+obj-$(CONFIG_MFD_INTEL_M10_BMC_PMCI)  += intel-m10-bmc-pmci.o
 
 obj-$(CONFIG_MFD_ATC260X)	+= atc260x-core.o
 obj-$(CONFIG_MFD_ATC260X_I2C)	+= atc260x-i2c.o
diff --git a/drivers/mfd/intel-m10-bmc-pmci.c b/drivers/mfd/intel-m10-bmc-pmci.c
new file mode 100644
index 000000000000..918378a78bdb
--- /dev/null
+++ b/drivers/mfd/intel-m10-bmc-pmci.c
@@ -0,0 +1,154 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * PMCI-based interface to MAX10 BMC
+ *
+ * Copyright (C) 2020-2022 Intel Corporation, Inc.
+ *
+ */
+
+#include <linux/dfl.h>
+#include <linux/mfd/core.h>
+#include <linux/mfd/intel-m10-bmc.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+
+#define M10BMC_PMCI_INDIRECT_BASE	0x400
+
+#define M10BMC_PMCI_SYS_BASE		0x0
+#define M10BMC_PMCI_SYS_END		0xfff
+
+#define M10BMC_PMCI_DOORBELL		0x1c0
+#define M10BMC_PMCI_AUTH_RESULT		0x1c4
+
+/* Telemetry registers */
+#define M10BMC_PMCI_TELEM_START		0x400
+#define M10BMC_PMCI_TELEM_END		0x78c
+
+#define M10BMC_PMCI_BUILD_VER		0x0
+#define NIOS2_PMCI_FW_VERSION		0x4
+#define M10BMC_PMCI_MAC_LOW		0x20
+#define M10BMC_PMCI_MAC_HIGH		(M10BMC_PMCI_MAC_LOW + 4)
+
+/* Addresses for security related data in FLASH */
+#define PMCI_BMC_REH_ADDR		0x7ffc004
+#define PMCI_BMC_PROG_ADDR		0x7ffc000
+#define PMCI_BMC_PROG_MAGIC		0x5746
+
+#define PMCI_SR_REH_ADDR		0x7ffd004
+#define PMCI_SR_PROG_ADDR		0x7ffd000
+#define PMCI_SR_PROG_MAGIC		0x5253
+
+#define PMCI_PR_REH_ADDR		0x7ffe004
+#define PMCI_PR_PROG_ADDR		0x7ffe000
+#define PMCI_PR_PROG_MAGIC		0x5250
+
+#define PMCI_STAGING_FLASH_COUNT	0x7ff5000
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
+static const struct regmap_indirect_cfg indirect_cfg = {
+	INTEL_M10_REGMAP_INDIRECT_CFG,
+};
+
+static struct regmap_config m10bmc_pmci_regmap_config = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.wr_table = &m10_access_table,
+	.rd_table = &m10_access_table,
+	.max_register = M10BMC_PMCI_SYS_END,
+	.indirect_cfg = &indirect_cfg,
+};
+
+static struct mfd_cell m10bmc_n6000_bmc_subdevs[] = {
+	{ .name = "n6000bmc-hwmon" },
+};
+
+static const struct m10bmc_csr_map m10bmc_pmci_csr_map = {
+	.base = M10BMC_PMCI_SYS_BASE,
+	.build_version = M10BMC_PMCI_BUILD_VER,
+	.fw_version = NIOS2_PMCI_FW_VERSION,
+	.mac_low = M10BMC_PMCI_MAC_LOW,
+	.mac_high = M10BMC_PMCI_MAC_HIGH,
+	.doorbell = M10BMC_PMCI_DOORBELL,
+	.auth_result = M10BMC_PMCI_AUTH_RESULT,
+	.bmc_prog_addr = PMCI_BMC_PROG_ADDR,
+	.bmc_reh_addr = PMCI_BMC_REH_ADDR,
+	.bmc_magic = PMCI_BMC_PROG_MAGIC,
+	.sr_prog_addr = PMCI_SR_PROG_ADDR,
+	.sr_reh_addr = PMCI_SR_REH_ADDR,
+	.sr_magic = PMCI_SR_PROG_MAGIC,
+	.pr_prog_addr = PMCI_PR_PROG_ADDR,
+	.pr_reh_addr = PMCI_PR_REH_ADDR,
+	.pr_magic = PMCI_PR_PROG_MAGIC,
+	.rsu_update_counter = PMCI_STAGING_FLASH_COUNT,
+};
+
+static const struct intel_m10bmc_platform_info m10bmc_m10_n6000 = {
+	.type = M10_N6000,
+	.cells = m10bmc_n6000_bmc_subdevs,
+	.n_cells = ARRAY_SIZE(m10bmc_n6000_bmc_subdevs),
+	.csr_map = &m10bmc_pmci_csr_map,
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
+
+	pmci->base = devm_ioremap_resource(dev, &ddev->mmio_res);
+	if (IS_ERR(pmci->base))
+		return PTR_ERR(pmci->base);
+
+	pmci->m10bmc.regmap =
+		devm_regmap_init_indirect(dev,
+					  pmci->base + M10BMC_PMCI_INDIRECT_BASE,
+					  &m10bmc_pmci_regmap_config);
+	if (IS_ERR(pmci->m10bmc.regmap))
+		return PTR_ERR(pmci->m10bmc.regmap);
+
+	return m10bmc_dev_init(&pmci->m10bmc, &m10bmc_m10_n6000);
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
index 1b907c1a176f..90f2a691ef46 100644
--- a/include/linux/mfd/intel-m10-bmc.h
+++ b/include/linux/mfd/intel-m10-bmc.h
@@ -13,6 +13,7 @@ enum m10bmc_type {
 	M10_N3000,
 	M10_D5005,
 	M10_N5010,
+	M10_N6000,
 };
 
 #define INTEL_M10_REGMAP_INDIRECT_CFG	\
-- 
2.30.2

