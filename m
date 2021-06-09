Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 890ED3A08A7
	for <lists+linux-fpga@lfdr.de>; Wed,  9 Jun 2021 02:49:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231535AbhFIAvb (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 8 Jun 2021 20:51:31 -0400
Received: from mga11.intel.com ([192.55.52.93]:53676 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231537AbhFIAv2 (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 8 Jun 2021 20:51:28 -0400
IronPort-SDR: ArkrkPy+6Gcx+suwUWUrrTx5KNZB1N/8zZbO7xSB6fZiGe0hm/hHS7JMjI2YDblu5oBuN1eCmg
 ICQ9csm/D3fg==
X-IronPort-AV: E=McAfee;i="6200,9189,10009"; a="201954220"
X-IronPort-AV: E=Sophos;i="5.83,259,1616482800"; 
   d="scan'208";a="201954220"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2021 17:49:32 -0700
IronPort-SDR: X8fqfgGsFUWFbi738zQjGA0rsKTNzYPROylBoH2rfei3WPaVZkRqOLtvh2c4SuZu8/HGn3PlMC
 NpaTBA3tsONw==
X-IronPort-AV: E=Sophos;i="5.83,259,1616482800"; 
   d="scan'208";a="449747488"
Received: from rhweight-mobl2.amr.corp.intel.com (HELO rhweight-mobl2.ra.intel.com) ([10.209.100.99])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2021 17:49:31 -0700
From:   Russ Weight <russell.h.weight@intel.com>
To:     mdf@kernel.org, linux-fpga@vger.kernel.org
Cc:     trix@redhat.com, lgoncalv@redhat.com, yilun.xu@intel.com,
        hao.wu@intel.com, matthew.gerlach@intel.com,
        richard.gong@intel.com, Russ Weight <russell.h.weight@intel.com>
Subject: [PATCH v1 5/5] fpga: region: Use standard dev_release for class driver
Date:   Tue,  8 Jun 2021 17:49:25 -0700
Message-Id: <20210609004925.238044-6-russell.h.weight@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210609004925.238044-1-russell.h.weight@intel.com>
References: <20210609004925.238044-1-russell.h.weight@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

The FPGA region class driver data structure is being treated as a managed
resource instead of using standard dev_release call-back to release the
class data structure. This change populates the class.dev_release function
and changes the fpga_region_free() function to call put_device().
It also changes fpga_region_unregister() to call device_del() instead
of device_unregister().

Signed-off-by: Russ Weight <russell.h.weight@intel.com>
---
 drivers/fpga/fpga-region.c | 46 +++++++++++++++++++-------------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/drivers/fpga/fpga-region.c b/drivers/fpga/fpga-region.c
index c3134b89c3fe..31836fba559b 100644
--- a/drivers/fpga/fpga-region.c
+++ b/drivers/fpga/fpga-region.c
@@ -181,7 +181,7 @@ ATTRIBUTE_GROUPS(fpga_region);
 
 /**
  * fpga_region_create - alloc and init a struct fpga_region
- * @dev: device parent
+ * @parent: device parent
  * @mgr: manager that programs this region
  * @get_bridges: optional function to get bridges to a list
  *
@@ -192,7 +192,7 @@ ATTRIBUTE_GROUPS(fpga_region);
  * Return: struct fpga_region or NULL
  */
 struct fpga_region
-*fpga_region_create(struct device *dev,
+*fpga_region_create(struct device *parent,
 		    struct fpga_manager *mgr,
 		    int (*get_bridges)(struct fpga_region *))
 {
@@ -204,8 +204,10 @@ struct fpga_region
 		return NULL;
 
 	id = ida_simple_get(&fpga_region_ida, 0, 0, GFP_KERNEL);
-	if (id < 0)
-		goto err_free;
+	if (id < 0) {
+		kfree(region);
+		return NULL;
+	}
 
 	region->mgr = mgr;
 	region->get_bridges = get_bridges;
@@ -214,22 +216,17 @@ struct fpga_region
 
 	device_initialize(&region->dev);
 	region->dev.class = fpga_region_class;
-	region->dev.parent = dev;
-	region->dev.of_node = dev->of_node;
+	region->dev.parent = parent;
+	region->dev.of_node = parent->of_node;
 	region->dev.id = id;
 
 	ret = dev_set_name(&region->dev, "region%d", id);
-	if (ret)
-		goto err_remove;
+	if (ret) {
+		put_device(&region->dev);
+		return NULL;
+	}
 
 	return region;
-
-err_remove:
-	ida_simple_remove(&fpga_region_ida, id);
-err_free:
-	kfree(region);
-
-	return NULL;
 }
 EXPORT_SYMBOL_GPL(fpga_region_create);
 
@@ -239,8 +236,7 @@ EXPORT_SYMBOL_GPL(fpga_region_create);
  */
 void fpga_region_free(struct fpga_region *region)
 {
-	ida_simple_remove(&fpga_region_ida, region->dev.id);
-	kfree(region);
+	put_device(&region->dev);
 }
 EXPORT_SYMBOL_GPL(fpga_region_free);
 
@@ -248,12 +244,12 @@ static void devm_fpga_region_release(struct device *dev, void *res)
 {
 	struct fpga_region *region = *(struct fpga_region **)res;
 
-	fpga_region_free(region);
+	put_device(&region->dev);
 }
 
 /**
  * devm_fpga_region_create - create and initialize a managed FPGA region struct
- * @dev: device parent
+ * @parent: device parent
  * @mgr: manager that programs this region
  * @get_bridges: optional function to get bridges to a list
  *
@@ -268,7 +264,7 @@ static void devm_fpga_region_release(struct device *dev, void *res)
  * Return: struct fpga_region or NULL
  */
 struct fpga_region
-*devm_fpga_region_create(struct device *dev,
+*devm_fpga_region_create(struct device *parent,
 			 struct fpga_manager *mgr,
 			 int (*get_bridges)(struct fpga_region *))
 {
@@ -278,12 +274,12 @@ struct fpga_region
 	if (!ptr)
 		return NULL;
 
-	region = fpga_region_create(dev, mgr, get_bridges);
+	region = fpga_region_create(parent, mgr, get_bridges);
 	if (!region) {
 		devres_free(ptr);
 	} else {
 		*ptr = region;
-		devres_add(dev, ptr);
+		devres_add(parent, ptr);
 	}
 
 	return region;
@@ -310,12 +306,16 @@ EXPORT_SYMBOL_GPL(fpga_region_register);
  */
 void fpga_region_unregister(struct fpga_region *region)
 {
-	device_unregister(&region->dev);
+	device_del(&region->dev);
 }
 EXPORT_SYMBOL_GPL(fpga_region_unregister);
 
 static void fpga_region_dev_release(struct device *dev)
 {
+	struct fpga_region *region = to_fpga_region(dev);
+
+	ida_simple_remove(&fpga_region_ida, region->dev.id);
+	kfree(region);
 }
 
 /**
-- 
2.25.1

