Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB07B3D82FE
	for <lists+linux-fpga@lfdr.de>; Wed, 28 Jul 2021 00:31:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233086AbhG0WbW (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 27 Jul 2021 18:31:22 -0400
Received: from mga04.intel.com ([192.55.52.120]:63083 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232575AbhG0WbU (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 27 Jul 2021 18:31:20 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10058"; a="210653479"
X-IronPort-AV: E=Sophos;i="5.84,275,1620716400"; 
   d="scan'208";a="210653479"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2021 15:31:16 -0700
X-IronPort-AV: E=Sophos;i="5.84,275,1620716400"; 
   d="scan'208";a="437502398"
Received: from rhweight-mobl2.amr.corp.intel.com (HELO rhweight-mobl2.ra.intel.com) ([10.209.69.186])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2021 15:31:14 -0700
From:   Russ Weight <russell.h.weight@intel.com>
To:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, lgoncalv@redhat.com, yilun.xu@intel.com,
        hao.wu@intel.com, matthew.gerlach@intel.com,
        richard.gong@intel.com, Russ Weight <russell.h.weight@intel.com>
Subject: [PATCH v14 1/6] fpga: sec-mgr: fpga security manager class driver
Date:   Tue, 27 Jul 2021 15:31:00 -0700
Message-Id: <20210727223105.152142-2-russell.h.weight@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210727223105.152142-1-russell.h.weight@intel.com>
References: <20210727223105.152142-1-russell.h.weight@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Create the FPGA Security Manager class driver. The security
manager provides interfaces to manage secure updates for the
FPGA and BMC images that are stored in FLASH. The driver can
also be used to update root entry hashes and to cancel code
signing keys. The image type is encoded in the image file
and is decoded by the HW/FW secure update engine.

Signed-off-by: Russ Weight <russell.h.weight@intel.com>
Signed-off-by: Xu Yilun <yilun.xu@intel.com>
Reviewed-by: Tom Rix <trix@redhat.com>
---
v14:
 - Updated copyright to 2021
 - Removed the name sysfs entry
 - Removed MAINTAINERS reference to
   Documentation/ABI/testing/sysfs-class-fpga-sec-mgr
 - Use xa_alloc() instead of ida_simple_get()
 - Rename dev to parent for parent devices
 - Remove fpga_sec_mgr_create(), devm_fpga_sec_mgr_create(), and
   fpga_sec_mgr_free() functions and update the fpga_sec_mgr_register()
   function to both create and register a new security manager.
 - Populate the fpga_sec_mgr_dev_release() function.
v13:
  - No change
v12:
  - Updated Date and KernelVersion fields in ABI documentation
v11:
  - No change
v10:
  - Rebased to 5.12-rc2 next
  - Updated Date and KernelVersion in ABI documentation
v9:
  - Updated Date and KernelVersion in ABI documentation
v8:
  - Fixed grammatical error in Documentation/fpga/fpga-sec-mgr.rst
v7:
  - Changed Date in documentation file to December 2020
v6:
  - Removed sysfs support and documentation for the display of the
    flash count, root entry hashes, and code-signing-key cancelation
    vectors.
v5:
  - Added the devm_fpga_sec_mgr_unregister() function, following recent
    changes to the fpga_manager() implementation.
  - Changed some *_show() functions to use sysfs_emit() instead of sprintf(
v4:
  - Changed from "Intel FPGA Security Manager" to FPGA Security Manager"
    and removed unnecessary references to "Intel".
  - Changed: iops -> sops, imgr -> smgr, IFPGA_ -> FPGA_, ifpga_ to fpga_
v3:
  - Modified sysfs handler check in check_sysfs_handler() to make
    it more readable.
v2:
  - Bumped documentation dates and versions
  - Added Documentation/fpga/ifpga-sec-mgr.rst
  - Removed references to bmc_flash_count & smbus_flash_count (not supported)
  - Split ifpga_sec_mgr_register() into create() and register() functions
  - Added devm_ifpga_sec_mgr_create()
  - Removed typedefs for imgr ops
---
 Documentation/fpga/fpga-sec-mgr.rst |  44 ++++++++++
 Documentation/fpga/index.rst        |   1 +
 MAINTAINERS                         |   8 ++
 drivers/fpga/Kconfig                |  10 +++
 drivers/fpga/Makefile               |   3 +
 drivers/fpga/fpga-sec-mgr.c         | 125 ++++++++++++++++++++++++++++
 include/linux/fpga/fpga-sec-mgr.h   |  35 ++++++++
 7 files changed, 226 insertions(+)
 create mode 100644 Documentation/fpga/fpga-sec-mgr.rst
 create mode 100644 drivers/fpga/fpga-sec-mgr.c
 create mode 100644 include/linux/fpga/fpga-sec-mgr.h

diff --git a/Documentation/fpga/fpga-sec-mgr.rst b/Documentation/fpga/fpga-sec-mgr.rst
new file mode 100644
index 000000000000..9f74c29fe63d
--- /dev/null
+++ b/Documentation/fpga/fpga-sec-mgr.rst
@@ -0,0 +1,44 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+========================================
+FPGA Security Manager Class Driver
+========================================
+
+The FPGA Security Manager class driver provides a common
+API for user-space tools to manage updates for secure FPGA
+devices. Device drivers that instantiate the Security
+Manager class driver will interact with a HW secure update
+engine in order to transfer new FPGA and BMC images to FLASH so
+that they will be automatically loaded when the FPGA card reboots.
+
+A significant difference between the FPGA Manager and the FPGA
+Security Manager is that the FPGA Manager does a live update (Partial
+Reconfiguration) to a device, whereas the FPGA Security Manager
+updates the FLASH images for the Static Region and the BMC so that
+they will be loaded the next time the FPGA card boots. Security is
+enforced by hardware and firmware. The security manager interacts
+with the firmware to initiate an update, pass in the necessary data,
+and collect status on the update.
+
+In addition to managing secure updates of the FPGA and BMC images,
+the FPGA Security Manager update process may also be used to
+program root entry hashes and cancellation keys for the FPGA static
+region, the FPGA partial reconfiguration region, and the BMC.
+
+Secure updates make use of the request_firmware framework, which
+requires that image files are accessible under /lib/firmware. A request
+for a secure update returns immediately, while the update itself
+proceeds in the context of a kernel worker thread. Sysfs files provide
+a means for monitoring the progress of a secure update and for
+retrieving error information in the event of a failure.
+
+Sysfs Attributes
+================
+
+The API includes a sysfs entry *name* to export the name of the parent
+driver. It also includes an *update* sub-directory that can be used to
+instantiate and monitor a secure update.
+
+See `<../ABI/testing/sysfs-class-fpga-sec-mgr>`__ for a full
+description of the sysfs attributes for the FPGA Security
+Manager.
diff --git a/Documentation/fpga/index.rst b/Documentation/fpga/index.rst
index f80f95667ca2..0b2f427042af 100644
--- a/Documentation/fpga/index.rst
+++ b/Documentation/fpga/index.rst
@@ -8,6 +8,7 @@ fpga
     :maxdepth: 1
 
     dfl
+    fpga-sec-mgr
 
 .. only::  subproject and html
 
diff --git a/MAINTAINERS b/MAINTAINERS
index 0f548b498eb0..59bfd0681baf 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7287,6 +7287,14 @@ F:	Documentation/fpga/
 F:	drivers/fpga/
 F:	include/linux/fpga/
 
+FPGA SECURITY MANAGER DRIVERS
+M:	Russ Weight <russell.h.weight@intel.com>
+L:	linux-fpga@vger.kernel.org
+S:	Maintained
+F:	Documentation/fpga/fpga-sec-mgr.rst
+F:	drivers/fpga/fpga-sec-mgr.c
+F:	include/linux/fpga/fpga-sec-mgr.h
+
 FPU EMULATOR
 M:	Bill Metzenthen <billm@melbpc.org.au>
 S:	Maintained
diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
index 16793bfc2bb4..fd18bd659120 100644
--- a/drivers/fpga/Kconfig
+++ b/drivers/fpga/Kconfig
@@ -243,4 +243,14 @@ config FPGA_MGR_VERSAL_FPGA
 	  configure the programmable logic(PL).
 
 	  To compile this as a module, choose M here.
+
+config FPGA_SEC_MGR
+	tristate "FPGA Security Manager"
+	help
+	  The Security Manager class driver presents a common
+	  user API for managing secure updates for FPGA
+	  devices, including flash images for the FPGA static
+	  region and for the BMC. Select this option to enable
+	  updates for secure FPGA devices.
+
 endif # FPGA
diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
index 0bff783d1b61..4612b7261434 100644
--- a/drivers/fpga/Makefile
+++ b/drivers/fpga/Makefile
@@ -22,6 +22,9 @@ obj-$(CONFIG_FPGA_MGR_VERSAL_FPGA)      += versal-fpga.o
 obj-$(CONFIG_ALTERA_PR_IP_CORE)         += altera-pr-ip-core.o
 obj-$(CONFIG_ALTERA_PR_IP_CORE_PLAT)    += altera-pr-ip-core-plat.o
 
+# FPGA Security Manager Framework
+obj-$(CONFIG_FPGA_SEC_MGR)		+= fpga-sec-mgr.o
+
 # FPGA Bridge Drivers
 obj-$(CONFIG_FPGA_BRIDGE)		+= fpga-bridge.o
 obj-$(CONFIG_SOCFPGA_FPGA_BRIDGE)	+= altera-hps2fpga.o altera-fpga2sdram.o
diff --git a/drivers/fpga/fpga-sec-mgr.c b/drivers/fpga/fpga-sec-mgr.c
new file mode 100644
index 000000000000..7ffce1211d98
--- /dev/null
+++ b/drivers/fpga/fpga-sec-mgr.c
@@ -0,0 +1,125 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * FPGA Security Manager
+ *
+ * Copyright (C) 2019-2021 Intel Corporation, Inc.
+ */
+
+#include <linux/fpga/fpga-sec-mgr.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/vmalloc.h>
+
+#define SEC_MGR_XA_LIMIT	XA_LIMIT(0, INT_MAX)
+static DEFINE_XARRAY_ALLOC(fpga_sec_mgr_xa);
+
+static struct class *fpga_sec_mgr_class;
+
+#define to_sec_mgr(d) container_of(d, struct fpga_sec_mgr, dev)
+
+/**
+ * fpga_sec_mgr_register - create and register an FPGA
+ *			   Security Manager device
+ *
+ * @dev:  fpga security manager device from pdev
+ * @sops: pointer to a structure of fpga callback functions
+ * @priv: fpga security manager private data
+ *
+ * Returns a struct fpga_sec_mgr pointer on success, or ERR_PTR() on
+ * error. The caller of this function is responsible for calling
+ * fpga_sec_mgr_unregister().
+ */
+struct fpga_sec_mgr *
+fpga_sec_mgr_register(struct device *parent,
+		      const struct fpga_sec_mgr_ops *sops, void *priv)
+{
+	struct fpga_sec_mgr *smgr;
+	int id, ret;
+
+	smgr = kzalloc(sizeof(*smgr), GFP_KERNEL);
+	if (!smgr)
+		return NULL;
+
+	ret = xa_alloc(&fpga_sec_mgr_xa, &smgr->dev.id, smgr, SEC_MGR_XA_LIMIT,
+		       GFP_KERNEL);
+	if (ret)
+		goto error_kfree;
+
+	mutex_init(&smgr->lock);
+
+	smgr->priv = priv;
+	smgr->sops = sops;
+
+	smgr->dev.class = fpga_sec_mgr_class;
+	smgr->dev.parent = parent;
+
+	ret = dev_set_name(&smgr->dev, "fpga_sec%d", id);
+	if (ret) {
+		dev_err(parent, "Failed to set device name: fpga_sec%d\n", id);
+		goto error_device;
+	}
+
+	ret = device_register(&smgr->dev);
+	if (ret) {
+		put_device(&smgr->dev);
+		return ERR_PTR(ret);
+	}
+
+	return smgr;
+
+error_device:
+	xa_erase(&fpga_sec_mgr_xa, smgr->dev.id);
+
+error_kfree:
+	kfree(smgr);
+
+	return ERR_PTR(ret);
+}
+EXPORT_SYMBOL_GPL(fpga_sec_mgr_register);
+
+/**
+ * fpga_sec_mgr_unregister - unregister an FPGA security manager
+ *
+ * @mgr: fpga manager struct
+ *
+ * This function is intended for use in an FPGA security manager
+ * driver's remove() function.
+ */
+void fpga_sec_mgr_unregister(struct fpga_sec_mgr *smgr)
+{
+	device_unregister(&smgr->dev);
+}
+EXPORT_SYMBOL_GPL(fpga_sec_mgr_unregister);
+
+static void fpga_sec_mgr_dev_release(struct device *dev)
+{
+	struct fpga_sec_mgr *smgr = to_sec_mgr(dev);
+
+	xa_erase(&fpga_sec_mgr_xa, smgr->dev.id);
+	kfree(smgr);
+}
+
+static int __init fpga_sec_mgr_class_init(void)
+{
+	pr_info("FPGA Security Manager\n");
+
+	fpga_sec_mgr_class = class_create(THIS_MODULE, "fpga_sec_mgr");
+	if (IS_ERR(fpga_sec_mgr_class))
+		return PTR_ERR(fpga_sec_mgr_class);
+
+	fpga_sec_mgr_class->dev_release = fpga_sec_mgr_dev_release;
+
+	return 0;
+}
+
+static void __exit fpga_sec_mgr_class_exit(void)
+{
+	class_destroy(fpga_sec_mgr_class);
+	WARN_ON(!xa_empty(&fpga_sec_mgr_xa));
+}
+
+MODULE_DESCRIPTION("FPGA Security Manager Driver");
+MODULE_LICENSE("GPL v2");
+
+subsys_initcall(fpga_sec_mgr_class_init);
+module_exit(fpga_sec_mgr_class_exit)
diff --git a/include/linux/fpga/fpga-sec-mgr.h b/include/linux/fpga/fpga-sec-mgr.h
new file mode 100644
index 000000000000..9ce10b2b2556
--- /dev/null
+++ b/include/linux/fpga/fpga-sec-mgr.h
@@ -0,0 +1,35 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Header file for FPGA Security Manager
+ *
+ * Copyright (C) 2019-2021 Intel Corporation, Inc.
+ */
+#ifndef _LINUX_FPGA_SEC_MGR_H
+#define _LINUX_FPGA_SEC_MGR_H
+
+#include <linux/device.h>
+#include <linux/mutex.h>
+#include <linux/types.h>
+
+struct fpga_sec_mgr;
+
+/**
+ * struct fpga_sec_mgr_ops - device specific operations
+ */
+struct fpga_sec_mgr_ops {
+};
+
+struct fpga_sec_mgr {
+	struct device dev;
+	const struct fpga_sec_mgr_ops *sops;
+	struct mutex lock;		/* protect data structure contents */
+	void *priv;
+};
+
+struct fpga_sec_mgr *
+fpga_sec_mgr_register(struct device *dev,
+		      const struct fpga_sec_mgr_ops *sops, void *priv);
+
+void fpga_sec_mgr_unregister(struct fpga_sec_mgr *smgr);
+
+#endif
-- 
2.25.1

