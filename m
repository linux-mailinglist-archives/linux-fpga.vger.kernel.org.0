Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DCA92DCC39
	for <lists+linux-fpga@lfdr.de>; Thu, 17 Dec 2020 06:52:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727328AbgLQFty (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 17 Dec 2020 00:49:54 -0500
Received: from mga02.intel.com ([134.134.136.20]:50408 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725882AbgLQFtx (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 17 Dec 2020 00:49:53 -0500
IronPort-SDR: TMlHjPd6sR2rRGGiEEihLJEodS7sDRWt97EshpoBqdPv6nU1MAqvmaZiTgrzP5+rDdCjGWpvRa
 JF80O4LCFfUA==
X-IronPort-AV: E=McAfee;i="6000,8403,9837"; a="162244244"
X-IronPort-AV: E=Sophos;i="5.78,425,1599548400"; 
   d="scan'208";a="162244244"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2020 21:49:12 -0800
IronPort-SDR: DmyKdsDMfJrQyNDnUj9XpUj5XIvCptxuZX5ZxX5P5Vjk74v01nIO8+uxosTjFwM4/nFKgEle6g
 D05tkCp6M4hg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,425,1599548400"; 
   d="scan'208";a="339047205"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.141])
  by fmsmga008.fm.intel.com with ESMTP; 16 Dec 2020 21:49:10 -0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, trix@redhat.com, lgoncalv@redhat.com,
        yilun.xu@intel.com, hao.wu@intel.com
Subject: [PATCH v3 2/3] fpga: dfl: add the userspace I/O device support for DFL devices
Date:   Thu, 17 Dec 2020 13:44:40 +0800
Message-Id: <1608183881-18692-3-git-send-email-yilun.xu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1608183881-18692-1-git-send-email-yilun.xu@intel.com>
References: <1608183881-18692-1-git-send-email-yilun.xu@intel.com>
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
other DFL drivers.

Signed-off-by: Xu Yilun <yilun.xu@intel.com>
---
v2: switch to the new matching algorithem. It matches DFL devices which
     could not be handled by other DFL drivers.
    refacor the code about device resources filling.
    fix some comments.
v3: split the dfl.c changes out of this patch.
    some minor fixes
---
 drivers/fpga/Kconfig        |  10 ++++
 drivers/fpga/Makefile       |   1 +
 drivers/fpga/dfl-uio-pdev.c | 110 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 121 insertions(+)
 create mode 100644 drivers/fpga/dfl-uio-pdev.c

diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
index 5d7f0ae..7a88af9 100644
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
+	  adds the uio_pdrv_genirq platform device with the DFL feature's
+	  resources, and lets the generic UIO platform device driver provide
+	  support for userspace access to kernel interrupts and memory
+	  locations.
+
 config FPGA_DFL_PCI
 	tristate "FPGA DFL PCIe Device Driver"
 	depends on PCI && FPGA_DFL
diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
index 18dc9885..8847fe0 100644
--- a/drivers/fpga/Makefile
+++ b/drivers/fpga/Makefile
@@ -45,6 +45,7 @@ dfl-afu-objs := dfl-afu-main.o dfl-afu-region.o dfl-afu-dma-region.o
 dfl-afu-objs += dfl-afu-error.o
 
 obj-$(CONFIG_FPGA_DFL_NIOS_INTEL_PAC_N3000)	+= dfl-n3000-nios.o
+obj-$(CONFIG_FPGA_DFL_UIO_PDEV)		+= dfl-uio-pdev.o
 
 # Drivers for FPGAs which implement DFL
 obj-$(CONFIG_FPGA_DFL_PCI)		+= dfl-pci.o
diff --git a/drivers/fpga/dfl-uio-pdev.c b/drivers/fpga/dfl-uio-pdev.c
new file mode 100644
index 0000000..8c57233
--- /dev/null
+++ b/drivers/fpga/dfl-uio-pdev.c
@@ -0,0 +1,110 @@
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
+#include "dfl.h"
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
-- 
2.7.4

