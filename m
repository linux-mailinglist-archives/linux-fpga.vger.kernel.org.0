Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7FF528FE09
	for <lists+linux-fpga@lfdr.de>; Fri, 16 Oct 2020 08:07:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391810AbgJPGHp (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 16 Oct 2020 02:07:45 -0400
Received: from mga04.intel.com ([192.55.52.120]:40084 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390603AbgJPGHm (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Fri, 16 Oct 2020 02:07:42 -0400
IronPort-SDR: XSxIh64M2D5FE1aY9wBoluTJS8rONU2kQTKU1jd1pAPl1qNXrV/MPztJQnqJWfKEaYX8VQFZu0
 QuRJPicsmd2g==
X-IronPort-AV: E=McAfee;i="6000,8403,9775"; a="163917494"
X-IronPort-AV: E=Sophos;i="5.77,381,1596524400"; 
   d="scan'208";a="163917494"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2020 23:07:42 -0700
IronPort-SDR: rYMyRYjtVIYUhriRMffL19P3bGxRCIN4jB9p148eoS4N60B9ysrmfAPyiH1pQJ9fnYIuiEZVKz
 u7Lplr2rlm0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,381,1596524400"; 
   d="scan'208";a="464576904"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.141])
  by orsmga004.jf.intel.com with ESMTP; 15 Oct 2020 23:07:40 -0700
From:   Xu Yilun <yilun.xu@intel.com>
To:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, trix@redhat.com, lgoncalv@redhat.com,
        yilun.xu@intel.com, hao.wu@intel.com
Subject: [PATCH 1/2] fpga: dfl: add driver_override support
Date:   Fri, 16 Oct 2020 14:02:30 +0800
Message-Id: <1602828151-24784-2-git-send-email-yilun.xu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1602828151-24784-1-git-send-email-yilun.xu@intel.com>
References: <1602828151-24784-1-git-send-email-yilun.xu@intel.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Add support for overriding the default matching of a dfl device to a dfl
driver. It follows the same way that can be used for PCI and platform
devices. This patch adds the 'driver_override' sysfs file.

Signed-off-by: Xu Yilun <yilun.xu@intel.com>
---
 Documentation/ABI/testing/sysfs-bus-dfl | 28 ++++++++++++++---
 drivers/fpga/dfl.c                      | 54 ++++++++++++++++++++++++++++++++-
 include/linux/dfl.h                     |  2 ++
 3 files changed, 79 insertions(+), 5 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-dfl b/Documentation/ABI/testing/sysfs-bus-dfl
index 23543be..db7e8d3 100644
--- a/Documentation/ABI/testing/sysfs-bus-dfl
+++ b/Documentation/ABI/testing/sysfs-bus-dfl
@@ -1,15 +1,35 @@
 What:		/sys/bus/dfl/devices/dfl_dev.X/type
-Date:		Aug 2020
-KernelVersion:	5.10
+Date:		Oct 2020
+KernelVersion:	5.11
 Contact:	Xu Yilun <yilun.xu@intel.com>
 Description:	Read-only. It returns type of DFL FIU of the device. Now DFL
 		supports 2 FIU types, 0 for FME, 1 for PORT.
 		Format: 0x%x
 
 What:		/sys/bus/dfl/devices/dfl_dev.X/feature_id
-Date:		Aug 2020
-KernelVersion:	5.10
+Date:		Oct 2020
+KernelVersion:	5.11
 Contact:	Xu Yilun <yilun.xu@intel.com>
 Description:	Read-only. It returns feature identifier local to its DFL FIU
 		type.
 		Format: 0x%x
+
+What:           /sys/bus/dfl/devices/.../driver_override
+Date:           Oct 2020
+KernelVersion:  5.11
+Contact:        Xu Yilun <yilun.xu@intel.com>
+Description:    This file allows the driver for a device to be specified. When
+                specified, only a driver with a name matching the value written
+                to driver_override will have an opportunity to bind to the
+                device. The override is specified by writing a string to the
+                driver_override file (echo dfl-uio-pdev > driver_override) and
+                may be cleared with an empty string (echo > driver_override).
+                This returns the device to standard matching rules binding.
+                Writing to driver_override does not automatically unbind the
+                device from its current driver or make any attempt to
+                automatically load the specified driver.  If no driver with a
+                matching name is currently loaded in the kernel, the device
+                will not bind to any driver.  This also allows devices to
+                opt-out of driver binding using a driver_override name such as
+                "none".  Only a single driver may be specified in the override,
+                there is no support for parsing delimiters.
diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
index 511b20f..bc35750 100644
--- a/drivers/fpga/dfl.c
+++ b/drivers/fpga/dfl.c
@@ -262,6 +262,10 @@ static int dfl_bus_match(struct device *dev, struct device_driver *drv)
 	struct dfl_driver *ddrv = to_dfl_drv(drv);
 	const struct dfl_device_id *id_entry;
 
+	/* When driver_override is set, only bind to the matching driver */
+	if (ddev->driver_override)
+		return !strcmp(ddev->driver_override, drv->name);
+
 	id_entry = ddrv->id_table;
 	if (id_entry) {
 		while (id_entry->feature_id) {
@@ -303,6 +307,53 @@ static int dfl_bus_uevent(struct device *dev, struct kobj_uevent_env *env)
 			      ddev->type, ddev->feature_id);
 }
 
+static ssize_t driver_override_show(struct device *dev,
+				    struct device_attribute *attr, char *buf)
+{
+	struct dfl_device *ddev = to_dfl_dev(dev);
+	ssize_t len;
+
+	device_lock(dev);
+	len = sprintf(buf, "%s\n", ddev->driver_override);
+	device_unlock(dev);
+	return len;
+}
+
+static ssize_t driver_override_store(struct device *dev,
+				     struct device_attribute *attr,
+				     const char *buf, size_t count)
+{
+	struct dfl_device *ddev = to_dfl_dev(dev);
+	char *driver_override, *old, *cp;
+
+	/* We need to keep extra room for a newline */
+	if (count >= (PAGE_SIZE - 1))
+		return -EINVAL;
+
+	driver_override = kstrndup(buf, count, GFP_KERNEL);
+	if (!driver_override)
+		return -ENOMEM;
+
+	cp = strchr(driver_override, '\n');
+	if (cp)
+		*cp = '\0';
+
+	device_lock(dev);
+	old = ddev->driver_override;
+	if (strlen(driver_override)) {
+		ddev->driver_override = driver_override;
+	} else {
+		kfree(driver_override);
+		ddev->driver_override = NULL;
+	}
+	device_unlock(dev);
+
+	kfree(old);
+
+	return count;
+}
+static DEVICE_ATTR_RW(driver_override);
+
 static ssize_t
 type_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
@@ -324,6 +375,7 @@ static DEVICE_ATTR_RO(feature_id);
 static struct attribute *dfl_dev_attrs[] = {
 	&dev_attr_type.attr,
 	&dev_attr_feature_id.attr,
+	&dev_attr_driver_override.attr,
 	NULL,
 };
 ATTRIBUTE_GROUPS(dfl_dev);
@@ -469,7 +521,7 @@ static int dfl_devs_add(struct dfl_feature_platform_data *pdata)
 
 int __dfl_driver_register(struct dfl_driver *dfl_drv, struct module *owner)
 {
-	if (!dfl_drv || !dfl_drv->probe || !dfl_drv->id_table)
+	if (!dfl_drv || !dfl_drv->probe)
 		return -EINVAL;
 
 	dfl_drv->drv.owner = owner;
diff --git a/include/linux/dfl.h b/include/linux/dfl.h
index 7affba2f..e1b2471 100644
--- a/include/linux/dfl.h
+++ b/include/linux/dfl.h
@@ -32,6 +32,7 @@ enum dfl_id_type {
  * @num_irqs: number of IRQs supported by this dfl device.
  * @cdev: pointer to DFL FPGA container device this dfl device belongs to.
  * @id_entry: matched id entry in dfl driver's id table.
+ * @driver_override: driver name to force a match
  */
 struct dfl_device {
 	struct device dev;
@@ -43,6 +44,7 @@ struct dfl_device {
 	unsigned int num_irqs;
 	struct dfl_fpga_cdev *cdev;
 	const struct dfl_device_id *id_entry;
+	char *driver_override;
 };
 
 /**
-- 
2.7.4

