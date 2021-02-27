Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC10E326D98
	for <lists+linux-fpga@lfdr.de>; Sat, 27 Feb 2021 16:32:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbhB0Pcm (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sat, 27 Feb 2021 10:32:42 -0500
Received: from mga17.intel.com ([192.55.52.151]:8554 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230104AbhB0Pcl (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Sat, 27 Feb 2021 10:32:41 -0500
IronPort-SDR: wfU0pBOz7pe6q4i+of40LdtsmSPF71iY1vvb1ApwsN3vqAAQ7cYdXE3YcfWPpRqaLkqnv4jI/n
 KvwwdnzUhyPA==
X-IronPort-AV: E=McAfee;i="6000,8403,9908"; a="165990410"
X-IronPort-AV: E=Sophos;i="5.81,211,1610438400"; 
   d="scan'208";a="165990410"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2021 07:31:59 -0800
IronPort-SDR: rPrHcb2FKvJajZZpz96MsrQbB/EMQOBPQtzVuBQ+y5Fae5b2ZVZesXImBVyiDsKwDBbODnCZnH
 9V8kZN5ELGmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,211,1610438400"; 
   d="scan'208";a="382370757"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.141])
  by orsmga002.jf.intel.com with ESMTP; 27 Feb 2021 07:31:57 -0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     gregkh@linuxfoundation.org, mdf@kernel.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, lgoncalv@redhat.com, yilun.xu@intel.com,
        hao.wu@intel.com
Subject: [RESEND PATCH v11 1/2] uio: uio_dfl: add userspace i/o driver for DFL bus
Date:   Sat, 27 Feb 2021 23:27:03 +0800
Message-Id: <1614439624-3946-2-git-send-email-yilun.xu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1614439624-3946-1-git-send-email-yilun.xu@intel.com>
References: <1614439624-3946-1-git-send-email-yilun.xu@intel.com>
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
---
 MAINTAINERS           |  1 +
 drivers/uio/Kconfig   | 17 +++++++++++++
 drivers/uio/Makefile  |  1 +
 drivers/uio/uio_dfl.c | 66 +++++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 85 insertions(+)
 create mode 100644 drivers/uio/uio_dfl.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 000fe0b..4dc0354 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6943,6 +6943,7 @@ S:	Maintained
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

