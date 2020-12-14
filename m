Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7AA62D9210
	for <lists+linux-fpga@lfdr.de>; Mon, 14 Dec 2020 04:41:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726339AbgLNDl0 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 13 Dec 2020 22:41:26 -0500
Received: from mga02.intel.com ([134.134.136.20]:46083 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725877AbgLNDl0 (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Sun, 13 Dec 2020 22:41:26 -0500
IronPort-SDR: LW+UkHlBMeGcQtGpRronGWml9CbeB2FfKDEcLlCv0D1kE/OJ1OcR9El+RVxnSlPsUuwbl5ijHg
 71MnlUCVpbrQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9834"; a="161700351"
X-IronPort-AV: E=Sophos;i="5.78,417,1599548400"; 
   d="scan'208";a="161700351"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2020 19:40:45 -0800
IronPort-SDR: Wedw6dpPDtEBG3sUAsmJDvp92dYlHojO/JzS0BXp9PwDSQIz3SpftygbXwKQDife0ky0+L8RrN
 8oiNvHDRJ9/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,417,1599548400"; 
   d="scan'208";a="331723388"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.141])
  by fmsmga008.fm.intel.com with ESMTP; 13 Dec 2020 19:40:43 -0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, trix@redhat.com, lgoncalv@redhat.com,
        yilun.xu@intel.com, hao.wu@intel.com
Subject: [PATCH v2 1/2] fpga: dfl: add the userspace I/O device support for DFL devices
Date:   Mon, 14 Dec 2020 11:36:20 +0800
Message-Id: <1607916981-14782-2-git-send-email-yilun.xu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1607916981-14782-1-git-send-email-yilun.xu@intel.com>
References: <1607916981-14782-1-git-send-email-yilun.xu@intel.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

This patch supports the DFL drivers be written in userspace. This is
realized by exposing the userspace I/O device interfaces.

The driver leverages the uio_pdrv_genirq, it adds the uio_pdrv_genirq
platform device with the DFL device's resources, and let the generic UIO
platform device driver provide support to userspace access to kernel
interrupts and memory locations.

The driver matches DFL devices in a different way. It has no device id
table, instead it matches any DFL device which could not be handled by
other DFL drivers. For this purpose, a match() ops is added to the dfl
driver, to allow dfl drivers have their own matching algorithem instead
of the standard id_table matching.

Signed-off-by: Xu Yilun <yilun.xu@intel.com>
---
v2: switch to the new matching algorithem. It matches DFL devices which
     could not be handled by other DFL drivers.
    refacor the code about device resources filling.
    fix some comments.
---
 drivers/fpga/Kconfig        |  10 ++++
 drivers/fpga/Makefile       |   1 +
 drivers/fpga/dfl-uio-pdev.c | 108 ++++++++++++++++++++++++++++++++++++++++++++
 drivers/fpga/dfl.c          |  22 +++++++--
 include/linux/dfl.h         |   7 +++
 5 files changed, 143 insertions(+), 5 deletions(-)
 create mode 100644 drivers/fpga/dfl-uio-pdev.c

diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
index 5d7f0ae..eb8a616 100644
--- a/drivers/fpga/Kconfig
+++ b/drivers/fpga/Kconfig
@@ -202,6 +202,16 @@ config FPGA_DFL_NIOS_INTEL_PAC_N3000
 	  the card. It also instantiates the SPI master (spi-altera) for
 	  the card's BMC (Board Management Controller).
 
+config FPGA_DFL_UIO_PDEV
+	tristate "FPGA DFL Driver for Userspace I/O platform devices"
+	depends on FPGA_DFL && UIO_PDRV_GENIRQ
+	help
+	  Enable this to allow some DFL drivers be written in userspace. It
+	  adds the uio_pdrv_genirq platform device with the DFL device's
+	  resources, and lets the generic UIO platform device driver provide
+	  support to userspace access to kernel interrupts and memory
+	  locations.
+
 config FPGA_DFL_PCI
 	tristate "FPGA DFL PCIe Device Driver"
 	depends on PCI && FPGA_DFL
diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
index 18dc9885..e07b3d5 100644
--- a/drivers/fpga/Makefile
+++ b/drivers/fpga/Makefile
@@ -45,6 +45,7 @@ dfl-afu-objs := dfl-afu-main.o dfl-afu-region.o dfl-afu-dma-region.o
 dfl-afu-objs += dfl-afu-error.o
 
 obj-$(CONFIG_FPGA_DFL_NIOS_INTEL_PAC_N3000)	+= dfl-n3000-nios.o
+obj-$(CONFIG_FPGA_DFL_UIO_PDEV)	+= dfl-uio-pdev.o
 
 # Drivers for FPGAs which implement DFL
 obj-$(CONFIG_FPGA_DFL_PCI)		+= dfl-pci.o
diff --git a/drivers/fpga/dfl-uio-pdev.c b/drivers/fpga/dfl-uio-pdev.c
new file mode 100644
index 0000000..68ede04
--- /dev/null
+++ b/drivers/fpga/dfl-uio-pdev.c
@@ -0,0 +1,108 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * DFL driver for Userspace I/O platform devices
+ *
+ * Copyright (C) 2020 Intel Corporation, Inc.
+ */
+#include <linux/dfl.h>
+#include <linux/errno.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/uio_driver.h>
+
+#define DRIVER_NAME "dfl-uio-pdev"
+
+static struct dfl_driver dfl_uio_pdev_driver;
+
+static int check_for_other_drv_match(struct device_driver *drv, void *data)
+{
+	struct dfl_driver *ddrv = to_dfl_drv(drv);
+	struct dfl_device *ddev = data;
+
+	/* skip myself */
+	if (ddrv == &dfl_uio_pdev_driver)
+		return 0;
+
+	return dfl_match_device(ddev, ddrv);
+}
+
+static int dfl_uio_pdev_match(struct dfl_device *ddev)
+{
+	/*
+	 * If any other driver wants the device, leave the device to this other
+	 * driver.
+	 */
+	if (bus_for_each_drv(&dfl_bus_type, NULL, ddev, check_for_other_drv_match))
+		return 0;
+
+	return 1;
+}
+
+static int dfl_uio_pdev_probe(struct dfl_device *ddev)
+{
+	struct device *dev = &ddev->dev;
+	struct platform_device_info pdevinfo = { 0 };
+	struct uio_info uio_pdata = { 0 };
+	struct platform_device *uio_pdev;
+	struct resource *res;
+	int i;
+
+	pdevinfo.name = "uio_pdrv_genirq";
+
+	res = kcalloc(ddev->num_irqs + 1, sizeof(*res), GFP_KERNEL);
+	if (!res)
+		return -ENOMEM;
+
+	res[0].parent = &ddev->mmio_res;
+	res[0].flags = IORESOURCE_MEM;
+	res[0].start = ddev->mmio_res.start;
+	res[0].end = ddev->mmio_res.end;
+
+	/* then add irq resource */
+	for (i = 0; i < ddev->num_irqs; i++) {
+		res[i + 1].flags = IORESOURCE_IRQ;
+		res[i + 1].start = ddev->irqs[i];
+		res[i + 1].end = ddev->irqs[i];
+	}
+
+	uio_pdata.name = DRIVER_NAME;
+	uio_pdata.version = "0";
+
+	pdevinfo.res = res;
+	pdevinfo.num_res = ddev->num_irqs + 1;
+	pdevinfo.parent = &ddev->dev;
+	pdevinfo.id = PLATFORM_DEVID_AUTO;
+	pdevinfo.data = &uio_pdata;
+	pdevinfo.size_data = sizeof(uio_pdata);
+
+	uio_pdev = platform_device_register_full(&pdevinfo);
+	if (!IS_ERR(uio_pdev))
+		dev_set_drvdata(dev, uio_pdev);
+
+	kfree(res);
+
+	return PTR_ERR_OR_ZERO(uio_pdev);
+}
+
+static void dfl_uio_pdev_remove(struct dfl_device *ddev)
+{
+	struct platform_device *uio_pdev = dev_get_drvdata(&ddev->dev);
+
+	platform_device_unregister(uio_pdev);
+}
+
+static struct dfl_driver dfl_uio_pdev_driver = {
+	.drv	= {
+		.name       = DRIVER_NAME,
+	},
+	.match	= dfl_uio_pdev_match,
+	.probe	= dfl_uio_pdev_probe,
+	.remove	= dfl_uio_pdev_remove,
+};
+module_dfl_driver(dfl_uio_pdev_driver);
+
+MODULE_DESCRIPTION("DFL driver for Userspace I/O platform devices");
+MODULE_AUTHOR("Intel Corporation");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
index 511b20f..dd90111 100644
--- a/drivers/fpga/dfl.c
+++ b/drivers/fpga/dfl.c
@@ -256,12 +256,13 @@ dfl_match_one_device(const struct dfl_device_id *id, struct dfl_device *ddev)
 	return NULL;
 }
 
-static int dfl_bus_match(struct device *dev, struct device_driver *drv)
+int dfl_match_device(struct dfl_device *ddev, struct dfl_driver *ddrv)
 {
-	struct dfl_device *ddev = to_dfl_dev(dev);
-	struct dfl_driver *ddrv = to_dfl_drv(drv);
 	const struct dfl_device_id *id_entry;
 
+	if (ddrv->match)
+		return ddrv->match(ddev);
+
 	id_entry = ddrv->id_table;
 	if (id_entry) {
 		while (id_entry->feature_id) {
@@ -275,6 +276,15 @@ static int dfl_bus_match(struct device *dev, struct device_driver *drv)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(dfl_match_device);
+
+static int dfl_bus_match(struct device *dev, struct device_driver *drv)
+{
+	struct dfl_device *ddev = to_dfl_dev(dev);
+	struct dfl_driver *ddrv = to_dfl_drv(drv);
+
+	return dfl_match_device(ddev, ddrv);
+}
 
 static int dfl_bus_probe(struct device *dev)
 {
@@ -328,7 +338,7 @@ static struct attribute *dfl_dev_attrs[] = {
 };
 ATTRIBUTE_GROUPS(dfl_dev);
 
-static struct bus_type dfl_bus_type = {
+struct bus_type dfl_bus_type = {
 	.name		= "dfl",
 	.match		= dfl_bus_match,
 	.probe		= dfl_bus_probe,
@@ -336,6 +346,7 @@ static struct bus_type dfl_bus_type = {
 	.uevent		= dfl_bus_uevent,
 	.dev_groups	= dfl_dev_groups,
 };
+EXPORT_SYMBOL_GPL(dfl_bus_type);
 
 static void release_dfl_dev(struct device *dev)
 {
@@ -469,7 +480,8 @@ static int dfl_devs_add(struct dfl_feature_platform_data *pdata)
 
 int __dfl_driver_register(struct dfl_driver *dfl_drv, struct module *owner)
 {
-	if (!dfl_drv || !dfl_drv->probe || !dfl_drv->id_table)
+	if (!dfl_drv || !dfl_drv->probe ||
+	    (!dfl_drv->id_table && !dfl_drv->match))
 		return -EINVAL;
 
 	dfl_drv->drv.owner = owner;
diff --git a/include/linux/dfl.h b/include/linux/dfl.h
index 6cc1098..7bd97ec 100644
--- a/include/linux/dfl.h
+++ b/include/linux/dfl.h
@@ -11,6 +11,8 @@
 #include <linux/device.h>
 #include <linux/mod_devicetable.h>
 
+extern struct bus_type dfl_bus_type;
+
 /**
  * enum dfl_id_type - define the DFL FIU types
  */
@@ -51,6 +53,8 @@ struct dfl_device {
  * @drv: driver model structure.
  * @id_table: pointer to table of device IDs the driver is interested in.
  *	      { } member terminated.
+ * @match: returns a positive value if given device can be handled by the
+ *	   driver and zero otherwise. If NULL, matching is based on id_table.
  * @probe: mandatory callback for device binding.
  * @remove: callback for device unbinding.
  */
@@ -58,6 +62,7 @@ struct dfl_driver {
 	struct device_driver drv;
 	const struct dfl_device_id *id_table;
 
+	int (*match)(struct dfl_device *dfl_dev);
 	int (*probe)(struct dfl_device *dfl_dev);
 	void (*remove)(struct dfl_device *dfl_dev);
 };
@@ -65,6 +70,8 @@ struct dfl_driver {
 #define to_dfl_dev(d) container_of(d, struct dfl_device, dev)
 #define to_dfl_drv(d) container_of(d, struct dfl_driver, drv)
 
+int dfl_match_device(struct dfl_device *ddev, struct dfl_driver *ddrv);
+
 /*
  * use a macro to avoid include chaining to get THIS_MODULE.
  */
-- 
2.7.4

