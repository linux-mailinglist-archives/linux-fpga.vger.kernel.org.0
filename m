Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80DA92E6D60
	for <lists+linux-fpga@lfdr.de>; Tue, 29 Dec 2020 03:52:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727990AbgL2Cv2 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 28 Dec 2020 21:51:28 -0500
Received: from mga02.intel.com ([134.134.136.20]:24906 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727696AbgL2Cv1 (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 28 Dec 2020 21:51:27 -0500
IronPort-SDR: JIPsjX1ceuZ+X6Vpycur6YDc0VJNXLqIdEm/+gQzOMMFGl7H/J2qjyHE6PPcRBxMHY6mr5RnSK
 amiyhonhMF8w==
X-IronPort-AV: E=McAfee;i="6000,8403,9848"; a="163512631"
X-IronPort-AV: E=Sophos;i="5.78,456,1599548400"; 
   d="scan'208";a="163512631"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2020 18:50:46 -0800
IronPort-SDR: FiA732+QKhVLA1VgMGFW1nFkQYAAorvSvDAnEGnK8NCVAhUBmXSGSMeLpLKo1IqUdZzEfarTxJ
 aajwoGiRjb8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,456,1599548400"; 
   d="scan'208";a="343926527"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.141])
  by orsmga003.jf.intel.com with ESMTP; 28 Dec 2020 18:50:43 -0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, trix@redhat.com, lgoncalv@redhat.com,
        yilun.xu@intel.com, hao.wu@intel.com
Subject: [PATCH v4 1/2] fpga: dfl: add the userspace I/O device support for DFL devices
Date:   Tue, 29 Dec 2020 10:42:55 +0800
Message-Id: <1609209776-7296-2-git-send-email-yilun.xu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1609209776-7296-1-git-send-email-yilun.xu@intel.com>
References: <1609209776-7296-1-git-send-email-yilun.xu@intel.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

This patch supports the DFL drivers be written in userspace. This is
realized by exposing the userspace I/O device interfaces.

The driver leverages the uio_pdrv_genirq, it adds the uio_pdrv_genirq
platform device with the DFL device's resources, and let the generic UIO
platform device driver provide support to userspace access to kernel
interrupts and memory locations.

The driver now supports the ether group feature. To support a new DFL
feature been directly accessed via UIO, its feature id should be added to
the driver's id_table.

Signed-off-by: Xu Yilun <yilun.xu@intel.com>
---
v2: switch to the new matching algorithem. It matches DFL devices which
     could not be handled by other DFL drivers.
    refacor the code about device resources filling.
    fix some comments.
v3: split the dfl.c changes out of this patch.
    some minor fixes
v4: drop the idea of a generic matching algorithem, instead we specify
     each matching device in id_table.
    to make clear that only one irq is supported, the irq handling code
     is refactored.
---
 drivers/fpga/Kconfig        |  10 +++++
 drivers/fpga/Makefile       |   1 +
 drivers/fpga/dfl-uio-pdev.c | 101 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 112 insertions(+)
 create mode 100644 drivers/fpga/dfl-uio-pdev.c

diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
index 5ff9438..61445be 100644
--- a/drivers/fpga/Kconfig
+++ b/drivers/fpga/Kconfig
@@ -203,6 +203,16 @@ config FPGA_DFL_NIOS_INTEL_PAC_N3000
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
index 0000000..1100434
--- /dev/null
+++ b/drivers/fpga/dfl-uio-pdev.c
@@ -0,0 +1,101 @@
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
+static int dfl_uio_pdev_probe(struct dfl_device *ddev)
+{
+	struct device *dev = &ddev->dev;
+	struct platform_device_info pdevinfo = { 0 };
+	struct uio_info uio_pdata = { 0 };
+	struct platform_device *uio_pdev;
+	unsigned int num_res = 1;
+	struct resource *res;
+
+	if (ddev->num_irqs > 1)
+		dev_warn(&ddev->dev,
+			 "%d irqs for %s, but UIO only supports the first one\n",
+			 ddev->num_irqs, dev_name(&ddev->dev));
+
+	pdevinfo.name = "uio_pdrv_genirq";
+
+	if (ddev->num_irqs)
+		num_res++;
+
+	res = kcalloc(num_res, sizeof(*res), GFP_KERNEL);
+	if (!res)
+		return -ENOMEM;
+
+	res[0].parent = &ddev->mmio_res;
+	res[0].flags = IORESOURCE_MEM;
+	res[0].start = ddev->mmio_res.start;
+	res[0].end = ddev->mmio_res.end;
+
+	/* then add irq resource */
+	if (num_res > 1) {
+		res[1].flags = IORESOURCE_IRQ;
+		res[1].start = ddev->irqs[0];
+		res[1].end = ddev->irqs[0];
+	}
+
+	uio_pdata.name = DRIVER_NAME;
+	uio_pdata.version = "0";
+
+	pdevinfo.res = res;
+	pdevinfo.num_res = num_res;
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
+#define FME_FEATURE_ID_ETH_GROUP	0x10
+
+static const struct dfl_device_id dfl_uio_pdev_ids[] = {
+	{ FME_ID, FME_FEATURE_ID_ETH_GROUP },
+
+	/* Add your new id entries here to support uio for more dfl features */
+
+	{ }
+};
+MODULE_DEVICE_TABLE(dfl, dfl_uio_pdev_ids);
+
+static struct dfl_driver dfl_uio_pdev_driver = {
+	.drv	= {
+		.name       = DRIVER_NAME,
+	},
+	.id_table = dfl_uio_pdev_ids,
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

