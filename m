Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23998277777
	for <lists+linux-fpga@lfdr.de>; Thu, 24 Sep 2020 19:07:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728640AbgIXRHl (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 24 Sep 2020 13:07:41 -0400
Received: from mga18.intel.com ([134.134.136.126]:15601 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728670AbgIXRHl (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 24 Sep 2020 13:07:41 -0400
IronPort-SDR: riJRdjxE1BBviu18c3x2cNAbEIl+I7q02UUgUIYvfFN2AHW8xdEkML25GqKS7N3MjtTqCqM3xg
 dYnYiP7elNWw==
X-IronPort-AV: E=McAfee;i="6000,8403,9754"; a="149026711"
X-IronPort-AV: E=Sophos;i="5.77,298,1596524400"; 
   d="scan'208";a="149026711"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2020 10:05:07 -0700
IronPort-SDR: 4iaK4ebLhma+L+/BIlqCOwpFZxzTkFCo585wWKRY0z2HnIO7o7aTL9cPfGc/pIQjwyflRuuEx2
 Ix7Mf5J9aSXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,298,1596524400"; 
   d="scan'208";a="511697354"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.141])
  by fmsmga006.fm.intel.com with ESMTP; 24 Sep 2020 10:05:01 -0700
From:   Xu Yilun <yilun.xu@intel.com>
To:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, lgoncalv@redhat.com, yilun.xu@intel.com,
        hao.wu@intel.com
Subject: [PATCH v3 5/5] fpga: dfl: move fpga dfl bus related APIs to include/linux/fpga/dfl.h
Date:   Fri, 25 Sep 2020 01:00:01 +0800
Message-Id: <1600966801-30586-6-git-send-email-yilun.xu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1600966801-30586-1-git-send-email-yilun.xu@intel.com>
References: <1600966801-30586-1-git-send-email-yilun.xu@intel.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Now the fpga dfl drivers could be made as independent modules and put
in different folders according to their functionalities. In order for
scattered fpga dfl device drivers to include fpga dfl bus APIs, move the
fpga dfl bus APIs to a new header file in the public folder.

[mdf@kernel.org: Fixed up MAINTAINERS entry merge]
Signed-off-by: Xu Yilun <yilun.xu@intel.com>
Reviewed-by: Tom Rix <trix@redhat.com>
Acked-by: Wu Hao <hao.wu@intel.com>
Signed-off-by: Moritz Fischer <mdf@kernel.org>
---
v2: updated the MAINTAINERS under FPGA DFL DRIVERS
    improve the comments
    rename the dfl-bus.h to dfl.h
v3: rebase the patch for previous changes
---
 MAINTAINERS              |  1 +
 drivers/fpga/dfl.c       |  1 +
 drivers/fpga/dfl.h       | 73 ----------------------------------------
 include/linux/fpga/dfl.h | 87 ++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 89 insertions(+), 73 deletions(-)
 create mode 100644 include/linux/fpga/dfl.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 48c0859..01c3c84 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6842,6 +6842,7 @@ S:	Maintained
 F:	Documentation/ABI/testing/sysfs-bus-fpga-dfl
 F:	Documentation/fpga/dfl.rst
 F:	drivers/fpga/dfl*
+F:	include/linux/fpga/dfl.h
 F:	include/uapi/linux/fpga-dfl.h
 
 FPGA MANAGER FRAMEWORK
diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
index a906fa7..d045344b 100644
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
index 4a42d26..97a81b6 100644
--- a/drivers/fpga/dfl.h
+++ b/drivers/fpga/dfl.h
@@ -517,77 +517,4 @@ long dfl_feature_ioctl_set_irq(struct platform_device *pdev,
 			       struct dfl_feature *feature,
 			       unsigned long arg);
 
-/**
- * enum fpga_dfl_id_type - define the FPGA DFL FIU types
- */
-enum fpga_dfl_id_type {
-	FPGA_DFL_FME_ID = 0,
-	FPGA_DFL_PORT_ID = 1,
-	FPGA_DFL_ID_MAX,
-};
-
-/**
- * struct fpga_dfl_device - represent an fpga dfl device on fpga dfl bus
- *
- * @dev: generic device interface.
- * @id: id of the fpga dfl device.
- * @type: FPGA DFL FIU type of the device, see enum fpga_dfl_id_type.
- * @feature_id: feature identifier local to its FPGA DFL FIU type.
- * @mmio_res: mmio resource of this fpga dfl device.
- * @irqs: list of Linux IRQ numbers of this fpga dfl device.
- * @num_irqs: number of IRQs supported by this fpga dfl device.
- * @cdev: pointer to DFL FPGA container device this fpga dfl device belongs to.
- * @id_entry: matched id entry in fpga dfl driver's id table.
- */
-struct fpga_dfl_device {
-	struct device dev;
-	int id;
-	u16 type;
-	u16 feature_id;
-	struct resource mmio_res;
-	int *irqs;
-	unsigned int num_irqs;
-	struct dfl_fpga_cdev *cdev;
-	const struct fpga_dfl_device_id *id_entry;
-};
-
-/**
- * struct fpga_dfl_driver - represent a fpga dfl device driver
- *
- * @drv: driver model structure.
- * @id_table: pointer to table of device IDs the driver is interested in.
- *	      { } member terminated.
- * @probe: mandatory callback for device binding.
- * @remove: callback for device unbinding.
- */
-struct fpga_dfl_driver {
-	struct device_driver drv;
-	const struct fpga_dfl_device_id *id_table;
-
-	int (*probe)(struct fpga_dfl_device *fddev);
-	void (*remove)(struct fpga_dfl_device *fddev);
-};
-
-#define to_fpga_dfl_dev(d) container_of(d, struct fpga_dfl_device, dev)
-#define to_fpga_dfl_drv(d) container_of(d, struct fpga_dfl_driver, drv)
-
-/*
- * use a macro to avoid include chaining to get THIS_MODULE.
- */
-#define fpga_dfl_driver_register(drv) \
-	__fpga_dfl_driver_register(drv, THIS_MODULE)
-int __fpga_dfl_driver_register(struct fpga_dfl_driver *fddrv,
-			       struct module *owner);
-void fpga_dfl_driver_unregister(struct fpga_dfl_driver *fddrv);
-
-/*
- * module_fpga_dfl_driver() - Helper macro for drivers that don't do
- * anything special in module init/exit.  This eliminates a lot of
- * boilerplate.  Each module may only use this macro once, and
- * calling it replaces module_init() and module_exit().
- */
-#define module_fpga_dfl_driver(__fpga_dfl_driver) \
-	module_driver(__fpga_dfl_driver, fpga_dfl_driver_register, \
-		      fpga_dfl_driver_unregister)
-
 #endif /* __FPGA_DFL_H */
diff --git a/include/linux/fpga/dfl.h b/include/linux/fpga/dfl.h
new file mode 100644
index 0000000..0715d0a
--- /dev/null
+++ b/include/linux/fpga/dfl.h
@@ -0,0 +1,87 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Header file for FPGA DFL driver and device API
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
+ * enum fpga_dfl_id_type - define the FPGA DFL FIU types
+ */
+enum fpga_dfl_id_type {
+	FPGA_DFL_FME_ID = 0,
+	FPGA_DFL_PORT_ID = 1,
+	FPGA_DFL_ID_MAX,
+};
+
+/**
+ * struct fpga_dfl_device - represent an fpga dfl device on fpga dfl bus
+ *
+ * @dev: generic device interface.
+ * @id: id of the fpga dfl device.
+ * @type: FPGA DFL FIU type of the device, see enum fpga_dfl_id_type.
+ * @feature_id: feature identifier local to its FPGA DFL FIU type.
+ * @mmio_res: mmio resource of this fpga dfl device.
+ * @irqs: list of Linux IRQ numbers of this fpga dfl device.
+ * @num_irqs: number of IRQs supported by this fpga dfl device.
+ * @cdev: pointer to DFL FPGA container device this fpga dfl device belongs to.
+ * @id_entry: matched id entry in fpga dfl driver's id table.
+ */
+struct fpga_dfl_device {
+	struct device dev;
+	int id;
+	u16 type;
+	u16 feature_id;
+	struct resource mmio_res;
+	int *irqs;
+	unsigned int num_irqs;
+	struct dfl_fpga_cdev *cdev;
+	const struct fpga_dfl_device_id *id_entry;
+};
+
+/**
+ * struct fpga_dfl_driver - represent a fpga dfl device driver
+ *
+ * @drv: driver model structure.
+ * @id_table: pointer to table of device IDs the driver is interested in.
+ *	      { } member terminated.
+ * @probe: mandatory callback for device binding.
+ * @remove: callback for device unbinding.
+ */
+struct fpga_dfl_driver {
+	struct device_driver drv;
+	const struct fpga_dfl_device_id *id_table;
+
+	int (*probe)(struct fpga_dfl_device *fddev);
+	void (*remove)(struct fpga_dfl_device *fddev);
+};
+
+#define to_fpga_dfl_dev(d) container_of(d, struct fpga_dfl_device, dev)
+#define to_fpga_dfl_drv(d) container_of(d, struct fpga_dfl_driver, drv)
+
+/*
+ * use a macro to avoid include chaining to get THIS_MODULE.
+ */
+#define fpga_dfl_driver_register(drv) \
+	__fpga_dfl_driver_register(drv, THIS_MODULE)
+int __fpga_dfl_driver_register(struct fpga_dfl_driver *fddrv,
+			       struct module *owner);
+void fpga_dfl_driver_unregister(struct fpga_dfl_driver *fddrv);
+
+/*
+ * module_fpga_dfl_driver() - Helper macro for drivers that don't do
+ * anything special in module init/exit.  This eliminates a lot of
+ * boilerplate.  Each module may only use this macro once, and
+ * calling it replaces module_init() and module_exit().
+ */
+#define module_fpga_dfl_driver(__fpga_dfl_driver) \
+	module_driver(__fpga_dfl_driver, fpga_dfl_driver_register, \
+		      fpga_dfl_driver_unregister)
+
+#endif /* __LINUX_FPGA_DFL_H */
-- 
2.7.4

