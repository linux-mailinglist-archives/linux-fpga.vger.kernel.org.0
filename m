Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEEBB269C95
	for <lists+linux-fpga@lfdr.de>; Tue, 15 Sep 2020 05:32:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726145AbgIODco (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 14 Sep 2020 23:32:44 -0400
Received: from mga05.intel.com ([192.55.52.43]:64033 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726117AbgIODcl (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 14 Sep 2020 23:32:41 -0400
IronPort-SDR: m2w79clF5DILuIw13ZjLA5xt6zoaIJ2Tf2Biml4leINtsFVOExWxGAEWCrO4oZpPTWPxcjEsCY
 jnBoubjs/SdQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9744"; a="244026463"
X-IronPort-AV: E=Sophos;i="5.76,428,1592895600"; 
   d="scan'208";a="244026463"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2020 20:32:41 -0700
IronPort-SDR: NRIb17/shqeVFp+WvXpp1pfUWmkbdSKQGysUGcUnNWNep6+HGAB+zceiDlmARp0Y2ov4FGNf+K
 tJspF841chKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,428,1592895600"; 
   d="scan'208";a="482596445"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.141])
  by orsmga005.jf.intel.com with ESMTP; 14 Sep 2020 20:32:39 -0700
From:   Xu Yilun <yilun.xu@intel.com>
To:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, masahiroy@kernel.org
Cc:     trix@redhat.com, lgoncalv@redhat.com, Xu Yilun <yilun.xu@intel.com>
Subject: [PATCH v2 4/4] fpga: dfl: move dfl bus related APIs to include/linux/fpga/dfl.h
Date:   Tue, 15 Sep 2020 11:27:53 +0800
Message-Id: <1600140473-12351-5-git-send-email-yilun.xu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1600140473-12351-1-git-send-email-yilun.xu@intel.com>
References: <1600140473-12351-1-git-send-email-yilun.xu@intel.com>
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

The patch moves dfl-bus related APIs to include/linux/fpga/dfl.h

Now the DFL device drivers could be made as independent modules and put
in different folders according to their functionality. In order for
scattered DFL device drivers to include dfl bus APIs, move the dfl bus
APIs to a new header file in the public folder.

Signed-off-by: Xu Yilun <yilun.xu@intel.com>
Reviewed-by: Tom Rix <trix@redhat.com>
Acked-by: Wu Hao <hao.wu@intel.com>
---
v2: updated the MAINTAINERS under FPGA DFL DRIVERS
    improve the comments
    rename the dfl-bus.h to dfl.h
---
 MAINTAINERS                   |  1 +
 drivers/fpga/dfl-n3000-nios.c |  3 +-
 drivers/fpga/dfl.c            |  1 +
 drivers/fpga/dfl.h            | 72 ------------------------------------
 include/linux/fpga/dfl.h      | 86 +++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 89 insertions(+), 74 deletions(-)
 create mode 100644 include/linux/fpga/dfl.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 31c5165..fa46592 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6883,6 +6883,7 @@ S:	Maintained
 F:	Documentation/ABI/testing/sysfs-bus-dfl
 F:	Documentation/fpga/dfl.rst
 F:	drivers/fpga/dfl*
+F:	include/linux/fpga/dfl.h
 F:	include/uapi/linux/fpga-dfl.h
 
 FPGA MANAGER FRAMEWORK
diff --git a/drivers/fpga/dfl-n3000-nios.c b/drivers/fpga/dfl-n3000-nios.c
index 70b44c3..5088f8f 100644
--- a/drivers/fpga/dfl-n3000-nios.c
+++ b/drivers/fpga/dfl-n3000-nios.c
@@ -11,6 +11,7 @@
  */
 #include <linux/bitfield.h>
 #include <linux/errno.h>
+#include <linux/fpga/dfl.h>
 #include <linux/io.h>
 #include <linux/io-64-nonatomic-lo-hi.h>
 #include <linux/kernel.h>
@@ -22,8 +23,6 @@
 #include <linux/spi/spi.h>
 #include <linux/types.h>
 
-#include "dfl.h"
-
 static char *fec_mode = "rs";
 module_param(fec_mode, charp, 0444);
 MODULE_PARM_DESC(fec_mode, "FEC mode of the ethernet retimer on Intel PAC N3000");
diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
index b450870..8bf6e99 100644
--- a/drivers/fpga/dfl.c
+++ b/drivers/fpga/dfl.c
@@ -11,6 +11,7 @@
  *   Xiao Guangrong <guangrong.xiao@linux.intel.com>
  */
 #include <linux/fpga-dfl.h>
+#include <linux/fpga/dfl.h>
 #include <linux/module.h>
 #include <linux/uaccess.h>
 
diff --git a/drivers/fpga/dfl.h b/drivers/fpga/dfl.h
index d5e050a..2b82c96 100644
--- a/drivers/fpga/dfl.h
+++ b/drivers/fpga/dfl.h
@@ -517,76 +517,4 @@ long dfl_feature_ioctl_set_irq(struct platform_device *pdev,
 			       struct dfl_feature *feature,
 			       unsigned long arg);
 
-/**
- * enum dfl_id_type - define the DFL FIU types
- */
-enum dfl_id_type {
-	FME_ID,
-	PORT_ID,
-	DFL_ID_MAX,
-};
-
-/**
- * struct dfl_device - represent an dfl device on dfl bus
- *
- * @dev: generic device interface.
- * @id: id of the dfl device.
- * @type: contains 4 bits DFL FIU type of the device. See enum dfl_id_type.
- * @feature_id: contains 12 bits feature identifier local to its DFL FIU type.
- * @mmio_res: mmio resource of this dfl device.
- * @irqs: list of Linux IRQ numbers of this dfl device.
- * @num_irqs: number of IRQs supported by this dfl device.
- * @cdev: pointer to DFL FPGA container device this dfl device belongs to.
- * @id_entry: matched id entry in dfl driver's id table.
- */
-struct dfl_device {
-	struct device dev;
-	int id;
-	u8 type;
-	u16 feature_id;
-	struct resource mmio_res;
-	int *irqs;
-	unsigned int num_irqs;
-	struct dfl_fpga_cdev *cdev;
-	const struct dfl_device_id *id_entry;
-};
-
-/**
- * struct dfl_driver - represent an dfl device driver
- *
- * @drv: driver model structure.
- * @id_table: pointer to table of device IDs the driver is interested in.
- *	      { } member terminated.
- * @probe: mandatory callback for device binding.
- * @remove: callback for device unbinding.
- */
-struct dfl_driver {
-	struct device_driver drv;
-	const struct dfl_device_id *id_table;
-
-	int (*probe)(struct dfl_device *dfl_dev);
-	void (*remove)(struct dfl_device *dfl_dev);
-};
-
-#define to_dfl_dev(d) container_of(d, struct dfl_device, dev)
-#define to_dfl_drv(d) container_of(d, struct dfl_driver, drv)
-
-/*
- * use a macro to avoid include chaining to get THIS_MODULE.
- */
-#define dfl_driver_register(drv) \
-	__dfl_driver_register(drv, THIS_MODULE)
-int __dfl_driver_register(struct dfl_driver *dfl_drv, struct module *owner);
-void dfl_driver_unregister(struct dfl_driver *dfl_drv);
-
-/*
- * module_dfl_driver() - Helper macro for drivers that don't do
- * anything special in module init/exit.  This eliminates a lot of
- * boilerplate.  Each module may only use this macro once, and
- * calling it replaces module_init() and module_exit().
- */
-#define module_dfl_driver(__dfl_driver) \
-	module_driver(__dfl_driver, dfl_driver_register, \
-		      dfl_driver_unregister)
-
 #endif /* __FPGA_DFL_H */
diff --git a/include/linux/fpga/dfl.h b/include/linux/fpga/dfl.h
new file mode 100644
index 0000000..0d7806f
--- /dev/null
+++ b/include/linux/fpga/dfl.h
@@ -0,0 +1,86 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Header file for DFL driver and device API
+ *
+ * Copyright (C) 2020 Intel Corporation, Inc.
+ */
+
+#ifndef __LINUX_FPGA_DFL_H
+#define __LINUX_FPGA_DFL_H
+
+#include <linux/device.h>
+#include <linux/mod_devicetable.h>
+
+/**
+ * enum dfl_id_type - define the DFL FIU types
+ */
+enum dfl_id_type {
+	FME_ID,
+	PORT_ID,
+	DFL_ID_MAX,
+};
+
+/**
+ * struct dfl_device - represent an dfl device on dfl bus
+ *
+ * @dev: generic device interface.
+ * @id: id of the dfl device.
+ * @type: contains 4 bits DFL FIU type of the device. See enum dfl_id_type.
+ * @feature_id: contains 12 bits feature identifier local to its DFL FIU type.
+ * @mmio_res: mmio resource of this dfl device.
+ * @irqs: list of Linux IRQ numbers of this dfl device.
+ * @num_irqs: number of IRQs supported by this dfl device.
+ * @cdev: pointer to DFL FPGA container device this dfl device belongs to.
+ * @id_entry: matched id entry in dfl driver's id table.
+ */
+struct dfl_device {
+	struct device dev;
+	int id;
+	u8 type;
+	u16 feature_id;
+	struct resource mmio_res;
+	int *irqs;
+	unsigned int num_irqs;
+	struct dfl_fpga_cdev *cdev;
+	const struct dfl_device_id *id_entry;
+};
+
+/**
+ * struct dfl_driver - represent an dfl device driver
+ *
+ * @drv: driver model structure.
+ * @id_table: pointer to table of device IDs the driver is interested in.
+ *	      { } member terminated.
+ * @probe: mandatory callback for device binding.
+ * @remove: callback for device unbinding.
+ */
+struct dfl_driver {
+	struct device_driver drv;
+	const struct dfl_device_id *id_table;
+
+	int (*probe)(struct dfl_device *dfl_dev);
+	void (*remove)(struct dfl_device *dfl_dev);
+};
+
+#define to_dfl_dev(d) container_of(d, struct dfl_device, dev)
+#define to_dfl_drv(d) container_of(d, struct dfl_driver, drv)
+
+/*
+ * use a macro to avoid include chaining to get THIS_MODULE.
+ */
+#define dfl_driver_register(drv) \
+	__dfl_driver_register(drv, THIS_MODULE)
+int __dfl_driver_register(struct dfl_driver *dfl_drv, struct module *owner);
+void dfl_driver_unregister(struct dfl_driver *dfl_drv);
+
+/*
+ * module_dfl_driver() - Helper macro for drivers that don't do
+ * anything special in module init/exit.  This eliminates a lot of
+ * boilerplate.  Each module may only use this macro once, and
+ * calling it replaces module_init() and module_exit().
+ */
+#define module_dfl_driver(__dfl_driver) \
+	module_driver(__dfl_driver, dfl_driver_register, \
+		      dfl_driver_unregister)
+
+#endif /* __LINUX_FPGA_DFL_H */
-- 
2.7.4

