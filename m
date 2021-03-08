Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 835BA3305C5
	for <lists+linux-fpga@lfdr.de>; Mon,  8 Mar 2021 03:05:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233620AbhCHCE7 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 7 Mar 2021 21:04:59 -0500
Received: from mga12.intel.com ([192.55.52.136]:2953 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233622AbhCHCE6 (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Sun, 7 Mar 2021 21:04:58 -0500
IronPort-SDR: d7AT5PE4mFuNi6nERqWgeJa4ZWRucsguDDg0HGHbVy0Gz5GsjvALmkvMEUpZ2T0xLx3g4O9zqN
 bFO6Omxktyew==
X-IronPort-AV: E=McAfee;i="6000,8403,9916"; a="167217230"
X-IronPort-AV: E=Sophos;i="5.81,231,1610438400"; 
   d="scan'208";a="167217230"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2021 18:04:58 -0800
IronPort-SDR: scC0DBN+SmwrmGqlteA/Ann2onymM6qrFzCpiwiPXCmF/Ods0C6OrDdEsI1URar3jJDTKKWAUe
 mrt7mia+CH4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,231,1610438400"; 
   d="scan'208";a="598675250"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.141])
  by fmsmga006.fm.intel.com with ESMTP; 07 Mar 2021 18:04:56 -0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     gregkh@linuxfoundation.org, mdf@kernel.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, lgoncalv@redhat.com, yilun.xu@intel.com,
        hao.wu@intel.com
Subject: [PATCH v12 1/2] uio: uio_dfl: add userspace i/o driver for DFL bus
Date:   Mon,  8 Mar 2021 09:59:35 +0800
Message-Id: <1615168776-8553-2-git-send-email-yilun.xu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1615168776-8553-1-git-send-email-yilun.xu@intel.com>
References: <1615168776-8553-1-git-send-email-yilun.xu@intel.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

This patch supports the DFL drivers be written in userspace. This is
realized by exposing the userspace I/O device interfaces.

The driver now only binds the ether group feature, which has no irq. So
the irq support is not implemented yet.

Signed-off-by: Xu Yilun <yilun.xu@intel.com>
Reviewed-by: Tom Rix <trix@redhat.com>
---
v9: switch to add a uio driver in drivers/uio
v10: add the source file in MAINTAINERS
     more descriptive Kconfig header
     add detailed path for opae uio example
v11: no change
v12: rebase to 5.12-rc2, no change
---
 MAINTAINERS           |  1 +
 drivers/uio/Kconfig   | 17 +++++++++++++
 drivers/uio/Makefile  |  1 +
 drivers/uio/uio_dfl.c | 66 +++++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 85 insertions(+)
 create mode 100644 drivers/uio/uio_dfl.c

diff --git a/MAINTAINERS b/MAINTAINERS
index d92f85c..b58a469 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6992,6 +6992,7 @@ S:	Maintained
 F:	Documentation/ABI/testing/sysfs-bus-dfl*
 F:	Documentation/fpga/dfl.rst
 F:	drivers/fpga/dfl*
+F:	drivers/uio/uio_dfl.c
 F:	include/linux/dfl.h
 F:	include/uapi/linux/fpga-dfl.h
 
diff --git a/drivers/uio/Kconfig b/drivers/uio/Kconfig
index 202ee81..5531f3a 100644
--- a/drivers/uio/Kconfig
+++ b/drivers/uio/Kconfig
@@ -165,4 +165,21 @@ config UIO_HV_GENERIC
 	  to network and storage devices from userspace.
 
 	  If you compile this as a module, it will be called uio_hv_generic.
+
+config UIO_DFL
+	tristate "Generic driver for DFL (Device Feature List) bus"
+	depends on FPGA_DFL
+	help
+	  Generic DFL (Device Feature List) driver for Userspace I/O devices.
+	  It is useful to provide direct access to DFL devices from userspace.
+	  A sample userspace application using this driver is available for
+	  download in a git repository:
+
+	    git clone https://github.com/OPAE/opae-sdk.git
+
+	  It could be found at:
+
+	    opae-sdk/tools/libopaeuio/
+
+	  If you compile this as a module, it will be called uio_dfl.
 endif
diff --git a/drivers/uio/Makefile b/drivers/uio/Makefile
index c285dd2..f2f416a1 100644
--- a/drivers/uio/Makefile
+++ b/drivers/uio/Makefile
@@ -11,3 +11,4 @@ obj-$(CONFIG_UIO_PRUSS)         += uio_pruss.o
 obj-$(CONFIG_UIO_MF624)         += uio_mf624.o
 obj-$(CONFIG_UIO_FSL_ELBC_GPCM)	+= uio_fsl_elbc_gpcm.o
 obj-$(CONFIG_UIO_HV_GENERIC)	+= uio_hv_generic.o
+obj-$(CONFIG_UIO_DFL)	+= uio_dfl.o
diff --git a/drivers/uio/uio_dfl.c b/drivers/uio/uio_dfl.c
new file mode 100644
index 0000000..89c0fc7
--- /dev/null
+++ b/drivers/uio/uio_dfl.c
@@ -0,0 +1,66 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Generic DFL driver for Userspace I/O devicess
+ *
+ * Copyright (C) 2021 Intel Corporation, Inc.
+ */
+#include <linux/dfl.h>
+#include <linux/errno.h>
+#include <linux/module.h>
+#include <linux/uio_driver.h>
+
+#define DRIVER_NAME "uio_dfl"
+
+static int uio_dfl_probe(struct dfl_device *ddev)
+{
+	struct resource *r = &ddev->mmio_res;
+	struct device *dev = &ddev->dev;
+	struct uio_info *uioinfo;
+	struct uio_mem *uiomem;
+	int ret;
+
+	uioinfo = devm_kzalloc(dev, sizeof(struct uio_info), GFP_KERNEL);
+	if (!uioinfo)
+		return -ENOMEM;
+
+	uioinfo->name = DRIVER_NAME;
+	uioinfo->version = "0";
+
+	uiomem = &uioinfo->mem[0];
+	uiomem->memtype = UIO_MEM_PHYS;
+	uiomem->addr = r->start & PAGE_MASK;
+	uiomem->offs = r->start & ~PAGE_MASK;
+	uiomem->size = (uiomem->offs + resource_size(r)
+			+ PAGE_SIZE - 1) & PAGE_MASK;
+	uiomem->name = r->name;
+
+	/* Irq is yet to be supported */
+	uioinfo->irq = UIO_IRQ_NONE;
+
+	ret = devm_uio_register_device(dev, uioinfo);
+	if (ret)
+		dev_err(dev, "unable to register uio device\n");
+
+	return ret;
+}
+
+#define FME_FEATURE_ID_ETH_GROUP	0x10
+
+static const struct dfl_device_id uio_dfl_ids[] = {
+	{ FME_ID, FME_FEATURE_ID_ETH_GROUP },
+	{ }
+};
+MODULE_DEVICE_TABLE(dfl, uio_dfl_ids);
+
+static struct dfl_driver uio_dfl_driver = {
+	.drv = {
+		.name = DRIVER_NAME,
+	},
+	.id_table	= uio_dfl_ids,
+	.probe		= uio_dfl_probe,
+};
+module_dfl_driver(uio_dfl_driver);
+
+MODULE_DESCRIPTION("Generic DFL driver for Userspace I/O devices");
+MODULE_AUTHOR("Intel Corporation");
+MODULE_LICENSE("GPL v2");
-- 
2.7.4

