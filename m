Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 142B765646D
	for <lists+linux-fpga@lfdr.de>; Mon, 26 Dec 2022 19:01:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231698AbiLZR7l (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 26 Dec 2022 12:59:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232210AbiLZR72 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 26 Dec 2022 12:59:28 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D18C82AD1;
        Mon, 26 Dec 2022 09:59:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672077566; x=1703613566;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+YFRAeeq8quTU0aX3m1PrSUiUxOcEnMYYn/3dlz7RP0=;
  b=N/TQ0VhXO+Kh7N/m2QWkmDT/G+d07r+FcGkFys8CE0QaYGV+mlQRqJaj
   ROUZ3l9BYkOti3EI1yfnTKGVX35+xkP7gWiZ8Dtm66vwaGp0ktcSTEei+
   pleK3k5Zk9ANJJ1Gbq4NvsGT4UzFfSK1HbvRweMWSSWT7ZW0Wfa2dB1um
   T5TQnnroNYldby7YfolVWCoRmW/gAvNaxr464dROL2awVXsthx0RCG4VB
   QRDXlyQ8EpPW3AA6IR9haFcUanp1318LYASNc653CaEKSPQwzAs7PQk4X
   WjLnhXXm1JRD+P3Bf38HnLTRcfMTEuyk34QiegexPn9DruuZxYHg9n4sz
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10572"; a="322570986"
X-IronPort-AV: E=Sophos;i="5.96,276,1665471600"; 
   d="scan'208";a="322570986"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Dec 2022 09:59:26 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10572"; a="654810072"
X-IronPort-AV: E=Sophos;i="5.96,276,1665471600"; 
   d="scan'208";a="654810072"
Received: from ptelkov-mobl2.ccr.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.249.41.4])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Dec 2022 09:59:19 -0800
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-fpga@vger.kernel.org, Xu Yilun <yilun.xu@intel.com>,
        Wu Hao <hao.wu@intel.com>, Tom Rix <trix@redhat.com>,
        Moritz Fischer <mdf@kernel.org>, Lee Jones <lee@kernel.org>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        Russ Weight <russell.h.weight@intel.com>,
        Tianfei zhang <tianfei.zhang@intel.com>,
        Mark Brown <broonie@kernel.org>,
        Marco Pagani <marpagan@redhat.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v5 03/10] mfd: intel-m10-bmc: Split into core and spi specific parts
Date:   Mon, 26 Dec 2022 19:58:42 +0200
Message-Id: <20221226175849.13056-4-ilpo.jarvinen@linux.intel.com>
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

Split the common code from intel-m10-bmc driver into intel-m10-bmc-core
and move the SPI bus parts into an interface specific file.

intel-m10-bmc-core becomes the core MFD functions which can support
multiple bus interface like SPI bus.

Co-developed-by: Tianfei zhang <tianfei.zhang@intel.com>
Signed-off-by: Tianfei zhang <tianfei.zhang@intel.com>
Reviewed-by: Russ Weight <russell.h.weight@intel.com>
Acked-by: Guenter Roeck <linux@roeck-us.net> # hwmon
Reviewed-by: Xu Yilun <yilun.xu@intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 MAINTAINERS                                   |   2 +-
 drivers/fpga/Kconfig                          |   2 +-
 drivers/hwmon/Kconfig                         |   2 +-
 drivers/mfd/Kconfig                           |  30 ++--
 drivers/mfd/Makefile                          |   4 +-
 drivers/mfd/intel-m10-bmc-core.c              | 122 +++++++++++++++++
 .../{intel-m10-bmc.c => intel-m10-bmc-spi.c}  | 128 +++---------------
 include/linux/mfd/intel-m10-bmc.h             |   6 +
 8 files changed, 172 insertions(+), 124 deletions(-)
 create mode 100644 drivers/mfd/intel-m10-bmc-core.c
 rename drivers/mfd/{intel-m10-bmc.c => intel-m10-bmc-spi.c} (59%)

diff --git a/MAINTAINERS b/MAINTAINERS
index cf0f18502372..ddfa4f8b3c80 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10452,7 +10452,7 @@ S:	Maintained
 F:	Documentation/ABI/testing/sysfs-driver-intel-m10-bmc
 F:	Documentation/hwmon/intel-m10-bmc-hwmon.rst
 F:	drivers/hwmon/intel-m10-bmc-hwmon.c
-F:	drivers/mfd/intel-m10-bmc.c
+F:	drivers/mfd/intel-m10-bmc*
 F:	include/linux/mfd/intel-m10-bmc.h
 
 INTEL MENLOW THERMAL DRIVER
diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
index 6ce143dafd04..0a00763b9f28 100644
--- a/drivers/fpga/Kconfig
+++ b/drivers/fpga/Kconfig
@@ -246,7 +246,7 @@ config FPGA_MGR_VERSAL_FPGA
 
 config FPGA_M10_BMC_SEC_UPDATE
 	tristate "Intel MAX10 BMC Secure Update driver"
-	depends on MFD_INTEL_M10_BMC
+	depends on MFD_INTEL_M10_BMC_CORE
 	select FW_LOADER
 	select FW_UPLOAD
 	help
diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 7ac3daaf59ce..984a55e0f313 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -2321,7 +2321,7 @@ config SENSORS_XGENE
 
 config SENSORS_INTEL_M10_BMC_HWMON
 	tristate "Intel MAX10 BMC Hardware Monitoring"
-	depends on MFD_INTEL_M10_BMC
+	depends on MFD_INTEL_M10_BMC_CORE
 	help
 	  This driver provides support for the hardware monitoring functionality
 	  on Intel MAX10 BMC chip.
diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 8b93856de432..a09d4ac60dc7 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -2219,18 +2219,24 @@ config SGI_MFD_IOC3
 	  If you have an SGI Origin, Octane, or a PCI IOC3 card,
 	  then say Y. Otherwise say N.
 
-config MFD_INTEL_M10_BMC
-	tristate "Intel MAX 10 Board Management Controller"
-	depends on SPI_MASTER
-	select REGMAP_SPI_AVMM
-	select MFD_CORE
-	help
-	  Support for the Intel MAX 10 board management controller using the
-	  SPI interface.
-
-	  This driver provides common support for accessing the device,
-	  additional drivers must be enabled in order to use the functionality
-	  of the device.
+config MFD_INTEL_M10_BMC_CORE
+        tristate
+        select MFD_CORE
+        select REGMAP
+        default n
+
+config MFD_INTEL_M10_BMC_SPI
+        tristate "Intel MAX 10 Board Management Controller with SPI"
+        depends on SPI_MASTER
+        select MFD_INTEL_M10_BMC_CORE
+        select REGMAP_SPI_AVMM
+        help
+          Support for the Intel MAX 10 board management controller using the
+          SPI interface.
+
+          This driver provides common support for accessing the device,
+          additional drivers must be enabled in order to use the functionality
+          of the device.
 
 config MFD_RSMU_I2C
 	tristate "Renesas Synchronization Management Unit with I2C"
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index 7ed3ef4a698c..5d1f308ee2a7 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -271,7 +271,9 @@ obj-$(CONFIG_MFD_QCOM_PM8008)	+= qcom-pm8008.o
 
 obj-$(CONFIG_SGI_MFD_IOC3)	+= ioc3.o
 obj-$(CONFIG_MFD_SIMPLE_MFD_I2C)	+= simple-mfd-i2c.o
-obj-$(CONFIG_MFD_INTEL_M10_BMC)   += intel-m10-bmc.o
+
+obj-$(CONFIG_MFD_INTEL_M10_BMC_CORE)	+= intel-m10-bmc-core.o
+obj-$(CONFIG_MFD_INTEL_M10_BMC_SPI)	+= intel-m10-bmc-spi.o
 
 obj-$(CONFIG_MFD_ATC260X)	+= atc260x-core.o
 obj-$(CONFIG_MFD_ATC260X_I2C)	+= atc260x-i2c.o
diff --git a/drivers/mfd/intel-m10-bmc-core.c b/drivers/mfd/intel-m10-bmc-core.c
new file mode 100644
index 000000000000..6630b81b10c4
--- /dev/null
+++ b/drivers/mfd/intel-m10-bmc-core.c
@@ -0,0 +1,122 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Intel MAX 10 Board Management Controller chip - common code
+ *
+ * Copyright (C) 2018-2020 Intel Corporation. All rights reserved.
+ */
+
+#include <linux/bitfield.h>
+#include <linux/device.h>
+#include <linux/dev_printk.h>
+#include <linux/mfd/core.h>
+#include <linux/mfd/intel-m10-bmc.h>
+#include <linux/module.h>
+
+static ssize_t bmc_version_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	struct intel_m10bmc *ddata = dev_get_drvdata(dev);
+	unsigned int val;
+	int ret;
+
+	ret = m10bmc_sys_read(ddata, M10BMC_BUILD_VER, &val);
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
+	ret = m10bmc_sys_read(ddata, NIOS2_FW_VERSION, &val);
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
+	struct intel_m10bmc *ddata = dev_get_drvdata(dev);
+	unsigned int macaddr_low, macaddr_high;
+	int ret;
+
+	ret = m10bmc_sys_read(ddata, M10BMC_MAC_LOW, &macaddr_low);
+	if (ret)
+		return ret;
+
+	ret = m10bmc_sys_read(ddata, M10BMC_MAC_HIGH, &macaddr_high);
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
+	struct intel_m10bmc *ddata = dev_get_drvdata(dev);
+	unsigned int macaddr_high;
+	int ret;
+
+	ret = m10bmc_sys_read(ddata, M10BMC_MAC_HIGH, &macaddr_high);
+	if (ret)
+		return ret;
+
+	return sysfs_emit(buf, "%u\n", (u8)FIELD_GET(M10BMC_MAC_COUNT, macaddr_high));
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
+
+static const struct attribute_group m10bmc_group = {
+	.attrs = m10bmc_attrs,
+};
+
+const struct attribute_group *m10bmc_dev_groups[] = {
+	&m10bmc_group,
+	NULL,
+};
+EXPORT_SYMBOL_GPL(m10bmc_dev_groups);
+
+int m10bmc_dev_init(struct intel_m10bmc *m10bmc, const struct intel_m10bmc_platform_info *info)
+{
+	int ret;
+
+	m10bmc->info = info;
+	dev_set_drvdata(m10bmc->dev, m10bmc);
+
+	ret = devm_mfd_add_devices(m10bmc->dev, PLATFORM_DEVID_AUTO,
+				   info->cells, info->n_cells,
+				   NULL, 0, NULL);
+	if (ret)
+		dev_err(m10bmc->dev, "Failed to register sub-devices: %d\n", ret);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(m10bmc_dev_init);
+
+MODULE_DESCRIPTION("Intel MAX 10 BMC core MFD driver");
+MODULE_AUTHOR("Intel Corporation");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/mfd/intel-m10-bmc.c b/drivers/mfd/intel-m10-bmc-spi.c
similarity index 59%
rename from drivers/mfd/intel-m10-bmc.c
rename to drivers/mfd/intel-m10-bmc-spi.c
index 2c26203c4799..be1d4ddedabb 100644
--- a/drivers/mfd/intel-m10-bmc.c
+++ b/drivers/mfd/intel-m10-bmc-spi.c
@@ -5,29 +5,14 @@
  * Copyright (C) 2018-2020 Intel Corporation. All rights reserved.
  */
 #include <linux/bitfield.h>
+#include <linux/dev_printk.h>
 #include <linux/init.h>
 #include <linux/mfd/core.h>
 #include <linux/mfd/intel-m10-bmc.h>
 #include <linux/module.h>
-#include <linux/mutex.h>
 #include <linux/regmap.h>
 #include <linux/spi/spi.h>
 
-static struct mfd_cell m10bmc_d5005_subdevs[] = {
-	{ .name = "d5005bmc-hwmon" },
-	{ .name = "d5005bmc-sec-update" }
-};
-
-static struct mfd_cell m10bmc_pacn3000_subdevs[] = {
-	{ .name = "n3000bmc-hwmon" },
-	{ .name = "n3000bmc-retimer" },
-	{ .name = "n3000bmc-sec-update" },
-};
-
-static struct mfd_cell m10bmc_n5010_subdevs[] = {
-	{ .name = "n5010bmc-hwmon" },
-};
-
 static const struct regmap_range m10bmc_regmap_range[] = {
 	regmap_reg_range(M10BMC_LEGACY_BUILD_VER, M10BMC_LEGACY_BUILD_VER),
 	regmap_reg_range(M10BMC_SYS_BASE, M10BMC_SYS_END),
@@ -48,86 +33,6 @@ static struct regmap_config intel_m10bmc_regmap_config = {
 	.max_register = M10BMC_MEM_END,
 };
 
-static ssize_t bmc_version_show(struct device *dev,
-				struct device_attribute *attr, char *buf)
-{
-	struct intel_m10bmc *ddata = dev_get_drvdata(dev);
-	unsigned int val;
-	int ret;
-
-	ret = m10bmc_sys_read(ddata, M10BMC_BUILD_VER, &val);
-	if (ret)
-		return ret;
-
-	return sprintf(buf, "0x%x\n", val);
-}
-static DEVICE_ATTR_RO(bmc_version);
-
-static ssize_t bmcfw_version_show(struct device *dev,
-				  struct device_attribute *attr, char *buf)
-{
-	struct intel_m10bmc *ddata = dev_get_drvdata(dev);
-	unsigned int val;
-	int ret;
-
-	ret = m10bmc_sys_read(ddata, NIOS2_FW_VERSION, &val);
-	if (ret)
-		return ret;
-
-	return sprintf(buf, "0x%x\n", val);
-}
-static DEVICE_ATTR_RO(bmcfw_version);
-
-static ssize_t mac_address_show(struct device *dev,
-				struct device_attribute *attr, char *buf)
-{
-	struct intel_m10bmc *ddata = dev_get_drvdata(dev);
-	unsigned int macaddr_low, macaddr_high;
-	int ret;
-
-	ret = m10bmc_sys_read(ddata, M10BMC_MAC_LOW, &macaddr_low);
-	if (ret)
-		return ret;
-
-	ret = m10bmc_sys_read(ddata, M10BMC_MAC_HIGH, &macaddr_high);
-	if (ret)
-		return ret;
-
-	return sysfs_emit(buf, "%02x:%02x:%02x:%02x:%02x:%02x\n",
-			  (u8)FIELD_GET(M10BMC_MAC_BYTE1, macaddr_low),
-			  (u8)FIELD_GET(M10BMC_MAC_BYTE2, macaddr_low),
-			  (u8)FIELD_GET(M10BMC_MAC_BYTE3, macaddr_low),
-			  (u8)FIELD_GET(M10BMC_MAC_BYTE4, macaddr_low),
-			  (u8)FIELD_GET(M10BMC_MAC_BYTE5, macaddr_high),
-			  (u8)FIELD_GET(M10BMC_MAC_BYTE6, macaddr_high));
-}
-static DEVICE_ATTR_RO(mac_address);
-
-static ssize_t mac_count_show(struct device *dev,
-			      struct device_attribute *attr, char *buf)
-{
-	struct intel_m10bmc *ddata = dev_get_drvdata(dev);
-	unsigned int macaddr_high;
-	int ret;
-
-	ret = m10bmc_sys_read(ddata, M10BMC_MAC_HIGH, &macaddr_high);
-	if (ret)
-		return ret;
-
-	return sysfs_emit(buf, "%u\n",
-			  (u8)FIELD_GET(M10BMC_MAC_COUNT, macaddr_high));
-}
-static DEVICE_ATTR_RO(mac_count);
-
-static struct attribute *m10bmc_attrs[] = {
-	&dev_attr_bmc_version.attr,
-	&dev_attr_bmcfw_version.attr,
-	&dev_attr_mac_address.attr,
-	&dev_attr_mac_count.attr,
-	NULL,
-};
-ATTRIBUTE_GROUPS(m10bmc);
-
 static int check_m10bmc_version(struct intel_m10bmc *ddata)
 {
 	unsigned int v;
@@ -166,11 +71,9 @@ static int intel_m10_bmc_spi_probe(struct spi_device *spi)
 		return -ENOMEM;
 
 	info = (struct intel_m10bmc_platform_info *)id->driver_data;
-	ddata->info = info;
 	ddata->dev = dev;
 
-	ddata->regmap =
-		devm_regmap_init_spi_avmm(spi, &intel_m10bmc_regmap_config);
+	ddata->regmap = devm_regmap_init_spi_avmm(spi, &intel_m10bmc_regmap_config);
 	if (IS_ERR(ddata->regmap)) {
 		ret = PTR_ERR(ddata->regmap);
 		dev_err(dev, "Failed to allocate regmap: %d\n", ret);
@@ -185,15 +88,24 @@ static int intel_m10_bmc_spi_probe(struct spi_device *spi)
 		return ret;
 	}
 
-	ret = devm_mfd_add_devices(dev, PLATFORM_DEVID_AUTO,
-				   info->cells, info->n_cells,
-				   NULL, 0, NULL);
-	if (ret)
-		dev_err(dev, "Failed to register sub-devices: %d\n", ret);
-
-	return ret;
+	return m10bmc_dev_init(ddata, info);
 }
 
+static struct mfd_cell m10bmc_d5005_subdevs[] = {
+	{ .name = "d5005bmc-hwmon" },
+	{ .name = "d5005bmc-sec-update" },
+};
+
+static struct mfd_cell m10bmc_pacn3000_subdevs[] = {
+	{ .name = "n3000bmc-hwmon" },
+	{ .name = "n3000bmc-retimer" },
+	{ .name = "n3000bmc-sec-update" },
+};
+
+static struct mfd_cell m10bmc_n5010_subdevs[] = {
+	{ .name = "n5010bmc-hwmon" },
+};
+
 static const struct intel_m10bmc_platform_info m10bmc_spi_n3000 = {
 	.cells = m10bmc_pacn3000_subdevs,
 	.n_cells = ARRAY_SIZE(m10bmc_pacn3000_subdevs),
@@ -220,14 +132,14 @@ MODULE_DEVICE_TABLE(spi, m10bmc_spi_id);
 static struct spi_driver intel_m10bmc_spi_driver = {
 	.driver = {
 		.name = "intel-m10-bmc",
-		.dev_groups = m10bmc_groups,
+		.dev_groups = m10bmc_dev_groups,
 	},
 	.probe = intel_m10_bmc_spi_probe,
 	.id_table = m10bmc_spi_id,
 };
 module_spi_driver(intel_m10bmc_spi_driver);
 
-MODULE_DESCRIPTION("Intel MAX 10 BMC Device Driver");
+MODULE_DESCRIPTION("Intel MAX 10 BMC SPI bus interface");
 MODULE_AUTHOR("Intel Corporation");
 MODULE_LICENSE("GPL v2");
 MODULE_ALIAS("spi:intel-m10-bmc");
diff --git a/include/linux/mfd/intel-m10-bmc.h b/include/linux/mfd/intel-m10-bmc.h
index 725b51ea4aee..82e0820e146e 100644
--- a/include/linux/mfd/intel-m10-bmc.h
+++ b/include/linux/mfd/intel-m10-bmc.h
@@ -171,4 +171,10 @@ m10bmc_raw_read(struct intel_m10bmc *m10bmc, unsigned int addr,
 #define m10bmc_sys_read(m10bmc, offset, val) \
 	m10bmc_raw_read(m10bmc, M10BMC_SYS_BASE + (offset), val)
 
+/*
+ * MAX10 BMC Core support
+ */
+int m10bmc_dev_init(struct intel_m10bmc *m10bmc, const struct intel_m10bmc_platform_info *info);
+extern const struct attribute_group *m10bmc_dev_groups[];
+
 #endif /* __MFD_INTEL_M10_BMC_H */
-- 
2.30.2

