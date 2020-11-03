Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9795F2A3D7B
	for <lists+linux-fpga@lfdr.de>; Tue,  3 Nov 2020 08:21:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727686AbgKCHV0 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 3 Nov 2020 02:21:26 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:40061 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725993AbgKCHV0 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 3 Nov 2020 02:21:26 -0500
Received: by mail-pl1-f195.google.com with SMTP id j5so8148620plk.7
        for <linux-fpga@vger.kernel.org>; Mon, 02 Nov 2020 23:21:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SBdjqSepf9b8NkBiN3+hl1ONOd5Sr5UVS9OwjhE/lMo=;
        b=nG2bhC3tzeSZt+gBBNO1kPn0vx94PS6Df78j1BFiuKiJSIpmjS6uVR8+zRsmaRxgo5
         D2cilsLEdV/S+tHjF6psHO6esKRyVphBxfXXTj/a5tx8Uallen8J6rm7sCxagpwHJgFx
         be5EMnRTWcFbvARwzm3DYlYAustw0llWCmpr/uwtwpQGViTk52BLjvYEKrXlb/PdVP1P
         kUTSS7CKhDk9OiwW6C8+rdRyqCP4ZsZbS3TIe/GtXeDNgoBFSQ3cucIsbryhDFrJK34O
         B+2DZBn61FVvmmlfaH9qLLmVGGRsZvu96xS5f+KLJenDdOjItwEvoa5FrLv37vhUg8mc
         vJcA==
X-Gm-Message-State: AOAM533ejc31BxyoabRPM8i8t2zKFtew8DnOVX6hIEnriXWaj+ivlYEZ
        5v6XtYooukgfJ4nPByxgElM=
X-Google-Smtp-Source: ABdhPJyYW3wRIF1jMpwYzcLRUSAA1hpG6tMnOvaoIXZ6fKkdUG+C7IcAj0YrzFAUqduTH4j8wULrmQ==
X-Received: by 2002:a17:902:6b88:b029:d3:e6c5:fa3c with SMTP id p8-20020a1709026b88b02900d3e6c5fa3cmr24412185plk.80.1604388083868;
        Mon, 02 Nov 2020 23:21:23 -0800 (PST)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id j12sm5550303pga.78.2020.11.02.23.21.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 23:21:23 -0800 (PST)
From:   Moritz Fischer <mdf@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-fpga@vger.kernel.org, Xu Yilun <yilun.xu@intel.com>,
        Tom Rix <trix@redhat.com>, Wu Hao <hao.wu@intel.com>,
        Moritz Fischer <mdf@kernel.org>
Subject: [PATCH 4/4] fpga: dfl: move dfl bus related APIs to include/linux/dfl.h
Date:   Mon,  2 Nov 2020 23:21:04 -0800
Message-Id: <20201103072104.12361-5-mdf@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201103072104.12361-1-mdf@kernel.org>
References: <20201103072104.12361-1-mdf@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Xu Yilun <yilun.xu@intel.com>

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
 MAINTAINERS         |  1 +
 drivers/fpga/dfl.c  |  1 +
 drivers/fpga/dfl.h  | 72 -------------------------------------
 include/linux/dfl.h | 86 +++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 88 insertions(+), 72 deletions(-)
 create mode 100644 include/linux/dfl.h

diff --git a/MAINTAINERS b/MAINTAINERS
index e73636b75f29..9bbb378308a8 100644
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
index 5a6ba3b2fa05..511b20ff35a3 100644
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
index 549c7900dcfd..2b82c96ba56c 100644
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
index 000000000000..6cc10982351a
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
2.29.2

