Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 116FA3822C3
	for <lists+linux-fpga@lfdr.de>; Mon, 17 May 2021 04:32:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233187AbhEQCeB (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 16 May 2021 22:34:01 -0400
Received: from mail-pg1-f181.google.com ([209.85.215.181]:38679 "EHLO
        mail-pg1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbhEQCeB (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sun, 16 May 2021 22:34:01 -0400
Received: by mail-pg1-f181.google.com with SMTP id 6so3630117pgk.5
        for <linux-fpga@vger.kernel.org>; Sun, 16 May 2021 19:32:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k57gZ29SV/KR0zdC2Ie93XnRc0lvguGCXFLVY5QtoJo=;
        b=Z+ITKdweth04UcvLYlJJgH2bkFG3dBBi5iGsD0cFjOYX3Mx8s8yDq4/pL2jFxYu2B/
         WHk3dHxfgcpt54RBJG04C9ecUA6yBUWwfxjPh6cRijW6dkB4bjWXOIdbiMWgKMWVR17O
         LbUpTMoLU5EciKldpenv+hRfW9NzQeWfP9LhVoT36CvgVnwHtGBM8tN82wKBsK+XbCjy
         l9+se2aI/6sOEgycEtDa+dnBuUUtcTseHKgY6X87mEG4NpOzBKf54uJyjWnF9geL/Y7a
         /o4Xf9ufoOmzQSu3X3ucocfEiSXk4GbwgI7Dw2Y+/alo5htdp558QsOSe+SrKuimHJSr
         EPdw==
X-Gm-Message-State: AOAM533P5iAQFmIctVRFWruG3w8TiQjVvEYoz5ALuPumY65LIFE50AP6
        A3A/eCK9fCG4rTVWOUvAmcw=
X-Google-Smtp-Source: ABdhPJzBhnUuQV/d6rH5s1htSL5iASeShfinvkRHuIEcyiXSwRp4e3uf/W2e9bOV9RavPah+Wn2UWg==
X-Received: by 2002:aa7:96ea:0:b029:28c:e131:f0f with SMTP id i10-20020aa796ea0000b029028ce1310f0fmr57964893pfq.11.1621218765863;
        Sun, 16 May 2021 19:32:45 -0700 (PDT)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id 85sm8823421pge.92.2021.05.16.19.32.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 May 2021 19:32:45 -0700 (PDT)
From:   Moritz Fischer <mdf@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-fpga@vger.kernel.org, moritzf@google.com,
        Moritz Fischer <mdf@kernel.org>,
        Russ Weight <russell.h.weight@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>
Subject: [PATCH 01/12] fpga: sec-mgr: fpga security manager class driver
Date:   Sun, 16 May 2021 19:31:49 -0700
Message-Id: <20210517023200.52707-2-mdf@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210517023200.52707-1-mdf@kernel.org>
References: <20210517023200.52707-1-mdf@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Russ Weight <russell.h.weight@intel.com>

Create the FPGA Security Manager class driver. The security
manager provides interfaces to manage secure updates for the
FPGA and BMC images that are stored in FLASH. The driver can
also be used to update root entry hashes and to cancel code
signing keys. The image type is encoded in the image file
and is decoded by the HW/FW secure update engine.

Signed-off-by: Russ Weight <russell.h.weight@intel.com>
Signed-off-by: Xu Yilun <yilun.xu@intel.com>
Reviewed-by: Tom Rix <trix@redhat.com>
Signed-off-by: Moritz Fischer <mdf@kernel.org>
---
 .../ABI/testing/sysfs-class-fpga-sec-mgr      |   5 +
 Documentation/fpga/fpga-sec-mgr.rst           |  44 +++
 Documentation/fpga/index.rst                  |   1 +
 MAINTAINERS                                   |   9 +
 drivers/fpga/Kconfig                          |   9 +
 drivers/fpga/Makefile                         |   3 +
 drivers/fpga/fpga-sec-mgr.c                   | 296 ++++++++++++++++++
 include/linux/fpga/fpga-sec-mgr.h             |  44 +++
 8 files changed, 411 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-class-fpga-sec-mgr
 create mode 100644 Documentation/fpga/fpga-sec-mgr.rst
 create mode 100644 drivers/fpga/fpga-sec-mgr.c
 create mode 100644 include/linux/fpga/fpga-sec-mgr.h

diff --git a/Documentation/ABI/testing/sysfs-class-fpga-sec-mgr b/Documentation/ABI/testing/sysfs-class-fpga-sec-mgr
new file mode 100644
index 000000000000..2498aef0ac51
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-class-fpga-sec-mgr
@@ -0,0 +1,5 @@
+What: 		/sys/class/fpga_sec_mgr/fpga_secX/name
+Date:		June 2021
+KernelVersion:	5.14
+Contact:	Russ Weight <russell.h.weight@intel.com>
+Description:	Name of low level fpga security manager driver.
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
index bd7aff0c120f..ac81adcd8579 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7136,6 +7136,15 @@ F:	Documentation/fpga/
 F:	drivers/fpga/
 F:	include/linux/fpga/
 
+FPGA SECURITY MANAGER DRIVERS
+M:	Russ Weight <russell.h.weight@intel.com>
+L:	linux-fpga@vger.kernel.org
+S:	Maintained
+F:	Documentation/ABI/testing/sysfs-class-fpga-sec-mgr
+F:	Documentation/fpga/fpga-sec-mgr.rst
+F:	drivers/fpga/fpga-sec-mgr.c
+F:	include/linux/fpga/fpga-sec-mgr.h
+
 FPU EMULATOR
 M:	Bill Metzenthen <billm@melbpc.org.au>
 S:	Maintained
diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
index 33e15058d0dc..09a8d915db26 100644
--- a/drivers/fpga/Kconfig
+++ b/drivers/fpga/Kconfig
@@ -234,4 +234,13 @@ config FPGA_MGR_ZYNQMP_FPGA
 	  to configure the programmable logic(PL) through PS
 	  on ZynqMP SoC.
 
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
index 18dc9885883a..22576d1a3996 100644
--- a/drivers/fpga/Makefile
+++ b/drivers/fpga/Makefile
@@ -21,6 +21,9 @@ obj-$(CONFIG_FPGA_MGR_ZYNQMP_FPGA)	+= zynqmp-fpga.o
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
index 000000000000..468379e0c825
--- /dev/null
+++ b/drivers/fpga/fpga-sec-mgr.c
@@ -0,0 +1,296 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * FPGA Security Manager
+ *
+ * Copyright (C) 2019-2020 Intel Corporation, Inc.
+ */
+
+#include <linux/fpga/fpga-sec-mgr.h>
+#include <linux/idr.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/vmalloc.h>
+
+static DEFINE_IDA(fpga_sec_mgr_ida);
+static struct class *fpga_sec_mgr_class;
+
+struct fpga_sec_mgr_devres {
+	struct fpga_sec_mgr *smgr;
+};
+
+#define to_sec_mgr(d) container_of(d, struct fpga_sec_mgr, dev)
+
+static ssize_t name_show(struct device *dev,
+			 struct device_attribute *attr, char *buf)
+{
+	struct fpga_sec_mgr *smgr = to_sec_mgr(dev);
+
+	return sysfs_emit(buf, "%s\n", smgr->name);
+}
+static DEVICE_ATTR_RO(name);
+
+static struct attribute *sec_mgr_attrs[] = {
+	&dev_attr_name.attr,
+	NULL,
+};
+
+static struct attribute_group sec_mgr_attr_group = {
+	.attrs = sec_mgr_attrs,
+};
+
+static const struct attribute_group *fpga_sec_mgr_attr_groups[] = {
+	&sec_mgr_attr_group,
+	NULL,
+};
+
+/**
+ * fpga_sec_mgr_create - create and initialize an FPGA
+ *			  security manager struct
+ *
+ * @dev:  fpga security manager device from pdev
+ * @name: fpga security manager name
+ * @sops: pointer to a structure of fpga callback functions
+ * @priv: fpga security manager private data
+ *
+ * The caller of this function is responsible for freeing the struct
+ * with ifpg_sec_mgr_free(). Using devm_fpga_sec_mgr_create() instead
+ * is recommended.
+ *
+ * Return: pointer to struct fpga_sec_mgr or NULL
+ */
+struct fpga_sec_mgr *
+fpga_sec_mgr_create(struct device *dev, const char *name,
+		    const struct fpga_sec_mgr_ops *sops, void *priv)
+{
+	struct fpga_sec_mgr *smgr;
+	int id, ret;
+
+	if (!name || !strlen(name)) {
+		dev_err(dev, "Attempt to register with no name!\n");
+		return NULL;
+	}
+
+	smgr = kzalloc(sizeof(*smgr), GFP_KERNEL);
+	if (!smgr)
+		return NULL;
+
+	id = ida_simple_get(&fpga_sec_mgr_ida, 0, 0, GFP_KERNEL);
+	if (id < 0)
+		goto error_kfree;
+
+	mutex_init(&smgr->lock);
+
+	smgr->name = name;
+	smgr->priv = priv;
+	smgr->sops = sops;
+
+	device_initialize(&smgr->dev);
+	smgr->dev.class = fpga_sec_mgr_class;
+	smgr->dev.parent = dev;
+	smgr->dev.id = id;
+
+	ret = dev_set_name(&smgr->dev, "fpga_sec%d", id);
+	if (ret) {
+		dev_err(dev, "Failed to set device name: fpga_sec%d\n", id);
+		goto error_device;
+	}
+
+	return smgr;
+
+error_device:
+	ida_simple_remove(&fpga_sec_mgr_ida, id);
+
+error_kfree:
+	kfree(smgr);
+
+	return NULL;
+}
+EXPORT_SYMBOL_GPL(fpga_sec_mgr_create);
+
+/**
+ * fpga_sec_mgr_free - free an FPGA security manager created
+ *			with fpga_sec_mgr_create()
+ *
+ * @smgr:	FPGA security manager structure
+ */
+void fpga_sec_mgr_free(struct fpga_sec_mgr *smgr)
+{
+	ida_simple_remove(&fpga_sec_mgr_ida, smgr->dev.id);
+	kfree(smgr);
+}
+EXPORT_SYMBOL_GPL(fpga_sec_mgr_free);
+
+static void devm_fpga_sec_mgr_release(struct device *dev, void *res)
+{
+	struct fpga_sec_mgr_devres *dr = res;
+
+	fpga_sec_mgr_free(dr->smgr);
+}
+
+/**
+ * devm_fpga_sec_mgr_create - create and initialize an FPGA
+ *			       security manager struct
+ *
+ * @dev:  fpga security manager device from pdev
+ * @name: fpga security manager name
+ * @sops: pointer to a structure of fpga callback functions
+ * @priv: fpga security manager private data
+ *
+ * This function is intended for use in a FPGA Security manager
+ * driver's probe function.  After the security manager driver creates
+ * the fpga_sec_mgr struct with devm_fpga_sec_mgr_create(), it should
+ * register it with devm_fpga_sec_mgr_register().
+ * The fpga_sec_mgr struct allocated with this function will be freed
+ * automatically on driver detach.
+ *
+ * Return: pointer to struct fpga_sec_mgr or NULL
+ */
+struct fpga_sec_mgr *
+devm_fpga_sec_mgr_create(struct device *dev, const char *name,
+			 const struct fpga_sec_mgr_ops *sops, void *priv)
+{
+	struct fpga_sec_mgr_devres *dr;
+
+	dr = devres_alloc(devm_fpga_sec_mgr_release, sizeof(*dr), GFP_KERNEL);
+	if (!dr)
+		return NULL;
+
+	dr->smgr = fpga_sec_mgr_create(dev, name, sops, priv);
+	if (!dr->smgr) {
+		devres_free(dr);
+		return NULL;
+	}
+
+	devres_add(dev, dr);
+
+	return dr->smgr;
+}
+EXPORT_SYMBOL_GPL(devm_fpga_sec_mgr_create);
+
+/**
+ * fpga_sec_mgr_register - register an FPGA security manager
+ *
+ * @smgr: fpga security manager struct
+ *
+ * Return: 0 on success, negative error code otherwise.
+ */
+int fpga_sec_mgr_register(struct fpga_sec_mgr *smgr)
+{
+	int ret;
+
+	ret = device_add(&smgr->dev);
+	if (ret)
+		goto error_device;
+
+	dev_info(&smgr->dev, "%s registered\n", smgr->name);
+
+	return 0;
+
+error_device:
+	ida_simple_remove(&fpga_sec_mgr_ida, smgr->dev.id);
+
+	return ret;
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
+	dev_info(&smgr->dev, "%s %s\n", __func__, smgr->name);
+
+	device_unregister(&smgr->dev);
+}
+EXPORT_SYMBOL_GPL(fpga_sec_mgr_unregister);
+
+static int fpga_sec_mgr_devres_match(struct device *dev, void *res,
+				     void *match_data)
+{
+	struct fpga_sec_mgr_devres *dr = res;
+
+	return match_data == dr->smgr;
+}
+
+static void devm_fpga_sec_mgr_unregister(struct device *dev, void *res)
+{
+	struct fpga_sec_mgr_devres *dr = res;
+
+	fpga_sec_mgr_unregister(dr->smgr);
+}
+
+/**
+ * devm_fpga_sec_mgr_register - resource managed variant of
+ *				fpga_sec_mgr_register()
+ *
+ * @dev: managing device for this FPGA security manager
+ * @smgr: fpga security manager struct
+ *
+ * This is the devres variant of fpga_sec_mgr_register() for which the
+ * unregister function will be called automatically when the managing
+ * device is detached.
+ */
+int devm_fpga_sec_mgr_register(struct device *dev, struct fpga_sec_mgr *smgr)
+{
+	struct fpga_sec_mgr_devres *dr;
+	int ret;
+
+	/*
+	 * Make sure that the struct fpga_sec_mgr * that is passed in is
+	 * managed itself.
+	 */
+	if (WARN_ON(!devres_find(dev, devm_fpga_sec_mgr_release,
+				 fpga_sec_mgr_devres_match, smgr)))
+		return -EINVAL;
+
+	dr = devres_alloc(devm_fpga_sec_mgr_unregister, sizeof(*dr), GFP_KERNEL);
+	if (!dr)
+		return -ENOMEM;
+
+	ret = fpga_sec_mgr_register(smgr);
+	if (ret) {
+		devres_free(dr);
+		return ret;
+	}
+
+	dr->smgr = smgr;
+	devres_add(dev, dr);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(devm_fpga_sec_mgr_register);
+
+static void fpga_sec_mgr_dev_release(struct device *dev)
+{
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
+	fpga_sec_mgr_class->dev_groups = fpga_sec_mgr_attr_groups;
+	fpga_sec_mgr_class->dev_release = fpga_sec_mgr_dev_release;
+
+	return 0;
+}
+
+static void __exit fpga_sec_mgr_class_exit(void)
+{
+	class_destroy(fpga_sec_mgr_class);
+	ida_destroy(&fpga_sec_mgr_ida);
+}
+
+MODULE_DESCRIPTION("FPGA Security Manager Driver");
+MODULE_LICENSE("GPL v2");
+
+subsys_initcall(fpga_sec_mgr_class_init);
+module_exit(fpga_sec_mgr_class_exit)
diff --git a/include/linux/fpga/fpga-sec-mgr.h b/include/linux/fpga/fpga-sec-mgr.h
new file mode 100644
index 000000000000..f85665b79b9d
--- /dev/null
+++ b/include/linux/fpga/fpga-sec-mgr.h
@@ -0,0 +1,44 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Header file for FPGA Security Manager
+ *
+ * Copyright (C) 2019-2020 Intel Corporation, Inc.
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
+	const char *name;
+	struct device dev;
+	const struct fpga_sec_mgr_ops *sops;
+	struct mutex lock;		/* protect data structure contents */
+	void *priv;
+};
+
+struct fpga_sec_mgr *
+fpga_sec_mgr_create(struct device *dev, const char *name,
+		    const struct fpga_sec_mgr_ops *sops, void *priv);
+
+struct fpga_sec_mgr *
+devm_fpga_sec_mgr_create(struct device *dev, const char *name,
+			 const struct fpga_sec_mgr_ops *sops, void *priv);
+
+int fpga_sec_mgr_register(struct fpga_sec_mgr *smgr);
+int devm_fpga_sec_mgr_register(struct device *dev,
+			       struct fpga_sec_mgr *smgr);
+void fpga_sec_mgr_unregister(struct fpga_sec_mgr *smgr);
+void fpga_sec_mgr_free(struct fpga_sec_mgr *smgr);
+
+#endif
-- 
2.31.1

