Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8001D2CCFAA
	for <lists+linux-fpga@lfdr.de>; Thu,  3 Dec 2020 07:42:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729640AbgLCGlm (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 3 Dec 2020 01:41:42 -0500
Received: from mga06.intel.com ([134.134.136.31]:46319 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728618AbgLCGlm (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 3 Dec 2020 01:41:42 -0500
IronPort-SDR: Y4PTYZ60Td++6M+UKAwl0t9A4HI9EAVYNvRL5l3KVMNsPjrc4wIDf3VtEm0KdSvIy5+76Jsnrr
 FssIO+Y7yUbg==
X-IronPort-AV: E=McAfee;i="6000,8403,9823"; a="234748805"
X-IronPort-AV: E=Sophos;i="5.78,388,1599548400"; 
   d="scan'208";a="234748805"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2020 22:40:56 -0800
IronPort-SDR: QKYK1rTFMyb3vc5NzOAvigIpwhZnxZQrvncHLxRQwqEIY2UYf5sk9z0a4bLPJL/SqYvRn1ciCZ
 x5/3B4ohroog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,388,1599548400"; 
   d="scan'208";a="335842332"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.141])
  by orsmga006.jf.intel.com with ESMTP; 02 Dec 2020 22:40:54 -0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     mdf@kernel.org, krzk@kernel.org, gregkh@linuxfoundation.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, lgoncalv@redhat.com, yilun.xu@intel.com,
        hao.wu@intel.com
Subject: [RESEND PATCH v13 4/6] fpga: dfl: move dfl bus related APIs to include/linux/dfl.h
Date:   Thu,  3 Dec 2020 14:35:58 +0800
Message-Id: <1606977360-4421-5-git-send-email-yilun.xu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1606977360-4421-1-git-send-email-yilun.xu@intel.com>
References: <1606977360-4421-1-git-send-email-yilun.xu@intel.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Now the dfl drivers could be made as independent modules and put in
different folders according to their functionalities. In order for
scattered dfl device drivers to include dfl bus APIs, move the
dfl bus APIs to a new header file in the public folder.

[mdf@kernel.org: Fixed up header guards to match filename]
Signed-off-by: Xu Yilun <yilun.xu@intel.com>
Reviewed-by: Tom Rix <trix@redhat.com>
Acked-by: Wu Hao <hao.wu@intel.com>
Signed-off-by: Moritz Fischer <mdf@kernel.org>
---
v2: updated the MAINTAINERS under FPGA DFL DRIVERS
    improve the comments
    rename the dfl-bus.h to dfl.h
v3: rebase the patch for previous changes
v9: rebase the patch for bus name changes back to "dfl"
v10: move the head file from inlude/linux/fpga to include/linux
v11: no change
v12: Fixed up header guards to match filename by Moritz
v13: no change
---
 MAINTAINERS         |  1 +
 drivers/fpga/dfl.c  |  1 +
 drivers/fpga/dfl.h  | 72 --------------------------------------------
 include/linux/dfl.h | 86 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 88 insertions(+), 72 deletions(-)
 create mode 100644 include/linux/dfl.h

diff --git a/MAINTAINERS b/MAINTAINERS
index e73636b..9bbb378 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6886,6 +6886,7 @@ S:	Maintained
 F:	Documentation/ABI/testing/sysfs-bus-dfl
 F:	Documentation/fpga/dfl.rst
 F:	drivers/fpga/dfl*
+F:	include/linux/dfl.h
 F:	include/uapi/linux/fpga-dfl.h
 
 FPGA MANAGER FRAMEWORK
diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
index 5a6ba3b..511b20f 100644
--- a/drivers/fpga/dfl.c
+++ b/drivers/fpga/dfl.c
@@ -10,6 +10,7 @@
  *   Wu Hao <hao.wu@intel.com>
  *   Xiao Guangrong <guangrong.xiao@linux.intel.com>
  */
+#include <linux/dfl.h>
 #include <linux/fpga-dfl.h>
 #include <linux/module.h>
 #include <linux/uaccess.h>
diff --git a/drivers/fpga/dfl.h b/drivers/fpga/dfl.h
index 549c790..2b82c96 100644
--- a/drivers/fpga/dfl.h
+++ b/drivers/fpga/dfl.h
@@ -517,76 +517,4 @@ long dfl_feature_ioctl_set_irq(struct platform_device *pdev,
 			       struct dfl_feature *feature,
 			       unsigned long arg);
 
-/**
- * enum dfl_id_type - define the DFL FIU types
- */
-enum dfl_id_type {
-	FME_ID = 0,
-	PORT_ID = 1,
-	DFL_ID_MAX,
-};
-
-/**
- * struct dfl_device - represent an dfl device on dfl bus
- *
- * @dev: generic device interface.
- * @id: id of the dfl device.
- * @type: type of DFL FIU of the device. See enum dfl_id_type.
- * @feature_id: feature identifier local to its DFL FIU type.
- * @mmio_res: mmio resource of this dfl device.
- * @irqs: list of Linux IRQ numbers of this dfl device.
- * @num_irqs: number of IRQs supported by this dfl device.
- * @cdev: pointer to DFL FPGA container device this dfl device belongs to.
- * @id_entry: matched id entry in dfl driver's id table.
- */
-struct dfl_device {
-	struct device dev;
-	int id;
-	u16 type;
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
diff --git a/include/linux/dfl.h b/include/linux/dfl.h
new file mode 100644
index 0000000..6cc1098
--- /dev/null
+++ b/include/linux/dfl.h
@@ -0,0 +1,86 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Header file for DFL driver and device API
+ *
+ * Copyright (C) 2020 Intel Corporation, Inc.
+ */
+
+#ifndef __LINUX_DFL_H
+#define __LINUX_DFL_H
+
+#include <linux/device.h>
+#include <linux/mod_devicetable.h>
+
+/**
+ * enum dfl_id_type - define the DFL FIU types
+ */
+enum dfl_id_type {
+	FME_ID = 0,
+	PORT_ID = 1,
+	DFL_ID_MAX,
+};
+
+/**
+ * struct dfl_device - represent an dfl device on dfl bus
+ *
+ * @dev: generic device interface.
+ * @id: id of the dfl device.
+ * @type: type of DFL FIU of the device. See enum dfl_id_type.
+ * @feature_id: feature identifier local to its DFL FIU type.
+ * @mmio_res: mmio resource of this dfl device.
+ * @irqs: list of Linux IRQ numbers of this dfl device.
+ * @num_irqs: number of IRQs supported by this dfl device.
+ * @cdev: pointer to DFL FPGA container device this dfl device belongs to.
+ * @id_entry: matched id entry in dfl driver's id table.
+ */
+struct dfl_device {
+	struct device dev;
+	int id;
+	u16 type;
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
+#endif /* __LINUX_DFL_H */
-- 
2.7.4

