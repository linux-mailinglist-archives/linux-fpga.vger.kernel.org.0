Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AFDF2DCC37
	for <lists+linux-fpga@lfdr.de>; Thu, 17 Dec 2020 06:52:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727304AbgLQFtv (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 17 Dec 2020 00:49:51 -0500
Received: from mga02.intel.com ([134.134.136.20]:50406 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725882AbgLQFtu (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 17 Dec 2020 00:49:50 -0500
IronPort-SDR: 8GisvxIrJVhpCYnq4Kcl3deA4zW2HHthsHfFlZPWh/vfMpWzIOv4dFZPRB+jlF/aDlglTtxiSm
 014mivE/AVjQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9837"; a="162244240"
X-IronPort-AV: E=Sophos;i="5.78,425,1599548400"; 
   d="scan'208";a="162244240"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2020 21:49:09 -0800
IronPort-SDR: okhjWlRYqdeZO5FPitGwUgeFUd1WxmpnD6HPN4ETJ19JxAGZqDPoNzxmFRTqc+LPbxZ8NHJiFY
 mDRyFSK+Q//w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,425,1599548400"; 
   d="scan'208";a="339047187"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.141])
  by fmsmga008.fm.intel.com with ESMTP; 16 Dec 2020 21:49:08 -0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, trix@redhat.com, lgoncalv@redhat.com,
        yilun.xu@intel.com, hao.wu@intel.com
Subject: [PATCH v3 1/3] fpga: dfl: add the match() ops for dfl driver
Date:   Thu, 17 Dec 2020 13:44:39 +0800
Message-Id: <1608183881-18692-2-git-send-email-yilun.xu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1608183881-18692-1-git-send-email-yilun.xu@intel.com>
References: <1608183881-18692-1-git-send-email-yilun.xu@intel.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

The match ops allows dfl drivers have their own matching algorithem
instead of the standard id_table matching.

This is to support the DFL UIO driver. It intends to match any DFL
device which could not be handled by other DFL drivers.

Signed-off-by: Xu Yilun <yilun.xu@intel.com>
---
v3: this patch is splited out from DFL UIO patch.
    move the declarations of exported symbols from include/linux/dfl.h
     to driver/fpga/dfl.h
    fix some comments.
---
 drivers/fpga/dfl.c  | 22 +++++++++++++++++-----
 drivers/fpga/dfl.h  |  5 +++++
 include/linux/dfl.h |  3 +++
 3 files changed, 25 insertions(+), 5 deletions(-)

diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
index 511b20f..dd90111 100644
--- a/drivers/fpga/dfl.c
+++ b/drivers/fpga/dfl.c
@@ -256,12 +256,13 @@ dfl_match_one_device(const struct dfl_device_id *id, struct dfl_device *ddev)
 	return NULL;
 }
 
-static int dfl_bus_match(struct device *dev, struct device_driver *drv)
+int dfl_match_device(struct dfl_device *ddev, struct dfl_driver *ddrv)
 {
-	struct dfl_device *ddev = to_dfl_dev(dev);
-	struct dfl_driver *ddrv = to_dfl_drv(drv);
 	const struct dfl_device_id *id_entry;
 
+	if (ddrv->match)
+		return ddrv->match(ddev);
+
 	id_entry = ddrv->id_table;
 	if (id_entry) {
 		while (id_entry->feature_id) {
@@ -275,6 +276,15 @@ static int dfl_bus_match(struct device *dev, struct device_driver *drv)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(dfl_match_device);
+
+static int dfl_bus_match(struct device *dev, struct device_driver *drv)
+{
+	struct dfl_device *ddev = to_dfl_dev(dev);
+	struct dfl_driver *ddrv = to_dfl_drv(drv);
+
+	return dfl_match_device(ddev, ddrv);
+}
 
 static int dfl_bus_probe(struct device *dev)
 {
@@ -328,7 +338,7 @@ static struct attribute *dfl_dev_attrs[] = {
 };
 ATTRIBUTE_GROUPS(dfl_dev);
 
-static struct bus_type dfl_bus_type = {
+struct bus_type dfl_bus_type = {
 	.name		= "dfl",
 	.match		= dfl_bus_match,
 	.probe		= dfl_bus_probe,
@@ -336,6 +346,7 @@ static struct bus_type dfl_bus_type = {
 	.uevent		= dfl_bus_uevent,
 	.dev_groups	= dfl_dev_groups,
 };
+EXPORT_SYMBOL_GPL(dfl_bus_type);
 
 static void release_dfl_dev(struct device *dev)
 {
@@ -469,7 +480,8 @@ static int dfl_devs_add(struct dfl_feature_platform_data *pdata)
 
 int __dfl_driver_register(struct dfl_driver *dfl_drv, struct module *owner)
 {
-	if (!dfl_drv || !dfl_drv->probe || !dfl_drv->id_table)
+	if (!dfl_drv || !dfl_drv->probe ||
+	    (!dfl_drv->id_table && !dfl_drv->match))
 		return -EINVAL;
 
 	dfl_drv->drv.owner = owner;
diff --git a/drivers/fpga/dfl.h b/drivers/fpga/dfl.h
index 2b82c96..01c43d8 100644
--- a/drivers/fpga/dfl.h
+++ b/drivers/fpga/dfl.h
@@ -17,6 +17,7 @@
 #include <linux/bitfield.h>
 #include <linux/cdev.h>
 #include <linux/delay.h>
+#include <linux/dfl.h>
 #include <linux/eventfd.h>
 #include <linux/fs.h>
 #include <linux/interrupt.h>
@@ -517,4 +518,8 @@ long dfl_feature_ioctl_set_irq(struct platform_device *pdev,
 			       struct dfl_feature *feature,
 			       unsigned long arg);
 
+extern struct bus_type dfl_bus_type;
+
+int dfl_match_device(struct dfl_device *ddev, struct dfl_driver *ddrv);
+
 #endif /* __FPGA_DFL_H */
diff --git a/include/linux/dfl.h b/include/linux/dfl.h
index 6cc1098..cfd98a4 100644
--- a/include/linux/dfl.h
+++ b/include/linux/dfl.h
@@ -51,6 +51,8 @@ struct dfl_device {
  * @drv: driver model structure.
  * @id_table: pointer to table of device IDs the driver is interested in.
  *	      { } member terminated.
+ * @match: returns one if given device can be handled by the driver and zero
+ *	   otherwise. If NULL, matching is based on id_table.
  * @probe: mandatory callback for device binding.
  * @remove: callback for device unbinding.
  */
@@ -58,6 +60,7 @@ struct dfl_driver {
 	struct device_driver drv;
 	const struct dfl_device_id *id_table;
 
+	int (*match)(struct dfl_device *dfl_dev);
 	int (*probe)(struct dfl_device *dfl_dev);
 	void (*remove)(struct dfl_device *dfl_dev);
 };
-- 
2.7.4

