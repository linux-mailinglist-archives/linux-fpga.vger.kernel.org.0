Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8055538D1C0
	for <lists+linux-fpga@lfdr.de>; Sat, 22 May 2021 01:00:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbhEUXBf (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 21 May 2021 19:01:35 -0400
Received: from mga14.intel.com ([192.55.52.115]:20217 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229548AbhEUXBf (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Fri, 21 May 2021 19:01:35 -0400
IronPort-SDR: ZBVVQw62ihuAK83SZ0OYAJVzi44+nu2Y/ER1VN7EE5NDQcxTC3UDDp8fJpXZUZYEH5jYTKrz7W
 EPSB58Q0Of2w==
X-IronPort-AV: E=McAfee;i="6200,9189,9991"; a="201301381"
X-IronPort-AV: E=Sophos;i="5.82,319,1613462400"; 
   d="scan'208";a="201301381"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2021 16:00:11 -0700
IronPort-SDR: VodzetKo3tZdHmiO4RoIkgwxzNtoY0ulVt90rOi86BEBAeQbyFVFdps/RpQJtZTQaYoE+KXUk4
 S1jQu757dZHA==
X-IronPort-AV: E=Sophos;i="5.82,319,1613462400"; 
   d="scan'208";a="613408194"
Received: from rhweight-mobl2.amr.corp.intel.com (HELO rhweight-mobl2.ra.intel.com) ([10.209.115.175])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2021 16:00:10 -0700
From:   Russ Weight <russell.h.weight@intel.com>
To:     mdf@kernel.org, linux-fpga@vger.kernel.org
Cc:     trix@redhat.com, lgoncalv@redhat.com, yilun.xu@intel.com,
        hao.wu@intel.com, matthew.gerlach@intel.com,
        richard.gong@intel.com, Russ Weight <russell.h.weight@intel.com>
Subject: [PATCH v2 3/3] fpga: region: Use standard dev_release for class driver
Date:   Fri, 21 May 2021 16:00:05 -0700
Message-Id: <20210521230005.663650-4-russell.h.weight@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210521230005.663650-1-russell.h.weight@intel.com>
References: <20210521230005.663650-1-russell.h.weight@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

The FPGA region class driver data structure is being treated as a
managed resource instead of using standard dev_release call-back
to release the class data structure. This change removes the
managed resource code and combines the create() and register()
functions into a single register() function.

Signed-off-by: Russ Weight <russell.h.weight@intel.com>
---
v2:
  - No changes
---
 drivers/fpga/dfl-fme-region.c    | 10 +---
 drivers/fpga/dfl.c               | 10 +---
 drivers/fpga/fpga-region.c       | 97 ++++++--------------------------
 drivers/fpga/of-fpga-region.c    | 10 +---
 include/linux/fpga/fpga-region.h | 12 +---
 5 files changed, 28 insertions(+), 111 deletions(-)

diff --git a/drivers/fpga/dfl-fme-region.c b/drivers/fpga/dfl-fme-region.c
index 1eeb42af1012..631c8ce160e3 100644
--- a/drivers/fpga/dfl-fme-region.c
+++ b/drivers/fpga/dfl-fme-region.c
@@ -39,9 +39,9 @@ static int fme_region_probe(struct platform_device *pdev)
 	if (IS_ERR(mgr))
 		return -EPROBE_DEFER;
 
-	region = devm_fpga_region_create(dev, mgr, fme_region_get_bridges);
-	if (!region) {
-		ret = -ENOMEM;
+	region = fpga_region_register(dev, mgr, fme_region_get_bridges);
+	if (IS_ERR(region)) {
+		ret = PTR_ERR(region);
 		goto eprobe_mgr_put;
 	}
 
@@ -49,10 +49,6 @@ static int fme_region_probe(struct platform_device *pdev)
 	region->compat_id = mgr->compat_id;
 	platform_set_drvdata(pdev, region);
 
-	ret = fpga_region_register(region);
-	if (ret)
-		goto eprobe_mgr_put;
-
 	dev_dbg(dev, "DFL FME FPGA Region probed\n");
 
 	return 0;
diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
index 511b20ff35a3..2fb3a5bfe4df 100644
--- a/drivers/fpga/dfl.c
+++ b/drivers/fpga/dfl.c
@@ -1400,9 +1400,9 @@ dfl_fpga_feature_devs_enumerate(struct dfl_fpga_enum_info *info)
 	if (!cdev)
 		return ERR_PTR(-ENOMEM);
 
-	cdev->region = devm_fpga_region_create(info->dev, NULL, NULL);
-	if (!cdev->region) {
-		ret = -ENOMEM;
+	cdev->region = fpga_region_register(info->dev, NULL, NULL);
+	if (IS_ERR(cdev->region)) {
+		ret = PTR_ERR(cdev->region);
 		goto free_cdev_exit;
 	}
 
@@ -1410,10 +1410,6 @@ dfl_fpga_feature_devs_enumerate(struct dfl_fpga_enum_info *info)
 	mutex_init(&cdev->lock);
 	INIT_LIST_HEAD(&cdev->port_dev_list);
 
-	ret = fpga_region_register(cdev->region);
-	if (ret)
-		goto free_cdev_exit;
-
 	/* create and init build info for enumeration */
 	binfo = devm_kzalloc(info->dev, sizeof(*binfo), GFP_KERNEL);
 	if (!binfo) {
diff --git a/drivers/fpga/fpga-region.c b/drivers/fpga/fpga-region.c
index c3134b89c3fe..622b9d598758 100644
--- a/drivers/fpga/fpga-region.c
+++ b/drivers/fpga/fpga-region.c
@@ -185,23 +185,18 @@ ATTRIBUTE_GROUPS(fpga_region);
  * @mgr: manager that programs this region
  * @get_bridges: optional function to get bridges to a list
  *
- * The caller of this function is responsible for freeing the resulting region
- * struct with fpga_region_free().  Using devm_fpga_region_create() instead is
- * recommended.
- *
- * Return: struct fpga_region or NULL
+ * Returns a struct fpga_region pointer on success, or ERR_PTR() on error.
  */
-struct fpga_region
-*fpga_region_create(struct device *dev,
-		    struct fpga_manager *mgr,
-		    int (*get_bridges)(struct fpga_region *))
+struct fpga_region *
+fpga_region_register(struct device *dev, struct fpga_manager *mgr,
+		     int (*get_bridges)(struct fpga_region *))
 {
 	struct fpga_region *region;
 	int id, ret = 0;
 
 	region = kzalloc(sizeof(*region), GFP_KERNEL);
 	if (!region)
-		return NULL;
+		return ERR_PTR(-ENOMEM);
 
 	id = ida_simple_get(&fpga_region_ida, 0, 0, GFP_KERNEL);
 	if (id < 0)
@@ -212,7 +207,6 @@ struct fpga_region
 	mutex_init(&region->mutex);
 	INIT_LIST_HEAD(&region->bridge_list);
 
-	device_initialize(&region->dev);
 	region->dev.class = fpga_region_class;
 	region->dev.parent = dev;
 	region->dev.of_node = dev->of_node;
@@ -222,6 +216,12 @@ struct fpga_region
 	if (ret)
 		goto err_remove;
 
+	ret = device_register(&region->dev);
+	if (ret) {
+		put_device(&region->dev);
+		return ERR_PTR(ret);
+	}
+
 	return region;
 
 err_remove:
@@ -229,76 +229,7 @@ struct fpga_region
 err_free:
 	kfree(region);
 
-	return NULL;
-}
-EXPORT_SYMBOL_GPL(fpga_region_create);
-
-/**
- * fpga_region_free - free a FPGA region created by fpga_region_create()
- * @region: FPGA region
- */
-void fpga_region_free(struct fpga_region *region)
-{
-	ida_simple_remove(&fpga_region_ida, region->dev.id);
-	kfree(region);
-}
-EXPORT_SYMBOL_GPL(fpga_region_free);
-
-static void devm_fpga_region_release(struct device *dev, void *res)
-{
-	struct fpga_region *region = *(struct fpga_region **)res;
-
-	fpga_region_free(region);
-}
-
-/**
- * devm_fpga_region_create - create and initialize a managed FPGA region struct
- * @dev: device parent
- * @mgr: manager that programs this region
- * @get_bridges: optional function to get bridges to a list
- *
- * This function is intended for use in a FPGA region driver's probe function.
- * After the region driver creates the region struct with
- * devm_fpga_region_create(), it should register it with fpga_region_register().
- * The region driver's remove function should call fpga_region_unregister().
- * The region struct allocated with this function will be freed automatically on
- * driver detach.  This includes the case of a probe function returning error
- * before calling fpga_region_register(), the struct will still get cleaned up.
- *
- * Return: struct fpga_region or NULL
- */
-struct fpga_region
-*devm_fpga_region_create(struct device *dev,
-			 struct fpga_manager *mgr,
-			 int (*get_bridges)(struct fpga_region *))
-{
-	struct fpga_region **ptr, *region;
-
-	ptr = devres_alloc(devm_fpga_region_release, sizeof(*ptr), GFP_KERNEL);
-	if (!ptr)
-		return NULL;
-
-	region = fpga_region_create(dev, mgr, get_bridges);
-	if (!region) {
-		devres_free(ptr);
-	} else {
-		*ptr = region;
-		devres_add(dev, ptr);
-	}
-
-	return region;
-}
-EXPORT_SYMBOL_GPL(devm_fpga_region_create);
-
-/**
- * fpga_region_register - register a FPGA region
- * @region: FPGA region
- *
- * Return: 0 or -errno
- */
-int fpga_region_register(struct fpga_region *region)
-{
-	return device_add(&region->dev);
+	return ERR_PTR(ret);
 }
 EXPORT_SYMBOL_GPL(fpga_region_register);
 
@@ -316,6 +247,10 @@ EXPORT_SYMBOL_GPL(fpga_region_unregister);
 
 static void fpga_region_dev_release(struct device *dev)
 {
+	struct fpga_region *region = to_fpga_region(dev);
+
+	ida_simple_remove(&fpga_region_ida, region->dev.id);
+	kfree(region);
 }
 
 /**
diff --git a/drivers/fpga/of-fpga-region.c b/drivers/fpga/of-fpga-region.c
index e405309baadc..466e083654ae 100644
--- a/drivers/fpga/of-fpga-region.c
+++ b/drivers/fpga/of-fpga-region.c
@@ -405,16 +405,12 @@ static int of_fpga_region_probe(struct platform_device *pdev)
 	if (IS_ERR(mgr))
 		return -EPROBE_DEFER;
 
-	region = devm_fpga_region_create(dev, mgr, of_fpga_region_get_bridges);
-	if (!region) {
-		ret = -ENOMEM;
+	region = fpga_region_register(dev, mgr, of_fpga_region_get_bridges);
+	if (IS_ERR(region)) {
+		ret = PTR_ERR(region);
 		goto eprobe_mgr_put;
 	}
 
-	ret = fpga_region_register(region);
-	if (ret)
-		goto eprobe_mgr_put;
-
 	of_platform_populate(np, fpga_region_of_match, NULL, &region->dev);
 	platform_set_drvdata(pdev, region);
 
diff --git a/include/linux/fpga/fpga-region.h b/include/linux/fpga/fpga-region.h
index 27cb706275db..ca793f43af14 100644
--- a/include/linux/fpga/fpga-region.h
+++ b/include/linux/fpga/fpga-region.h
@@ -37,15 +37,9 @@ struct fpga_region *fpga_region_class_find(
 
 int fpga_region_program_fpga(struct fpga_region *region);
 
-struct fpga_region
-*fpga_region_create(struct device *dev, struct fpga_manager *mgr,
-		    int (*get_bridges)(struct fpga_region *));
-void fpga_region_free(struct fpga_region *region);
-int fpga_region_register(struct fpga_region *region);
+struct fpga_region *
+fpga_region_register(struct device *dev, struct fpga_manager *mgr,
+		     int (*get_bridges)(struct fpga_region *));
 void fpga_region_unregister(struct fpga_region *region);
 
-struct fpga_region
-*devm_fpga_region_create(struct device *dev, struct fpga_manager *mgr,
-			int (*get_bridges)(struct fpga_region *));
-
 #endif /* _FPGA_REGION_H */
-- 
2.25.1

