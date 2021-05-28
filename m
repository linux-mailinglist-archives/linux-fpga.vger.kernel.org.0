Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9043A39488F
	for <lists+linux-fpga@lfdr.de>; Sat, 29 May 2021 00:11:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbhE1WNM (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 28 May 2021 18:13:12 -0400
Received: from mga05.intel.com ([192.55.52.43]:43021 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229585AbhE1WNM (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Fri, 28 May 2021 18:13:12 -0400
IronPort-SDR: uQ6pDDngOQTG4O939FdhEijXUIDGO/LtNrnoqoYBPeUvehB7yQ4AC+D8IgdtS66Mdn+QPWdexU
 87V541vwWFCw==
X-IronPort-AV: E=McAfee;i="6200,9189,9998"; a="288643747"
X-IronPort-AV: E=Sophos;i="5.83,231,1616482800"; 
   d="scan'208";a="288643747"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2021 15:11:36 -0700
IronPort-SDR: eKV7yIpI/j+Z/me32dvrXsUmOozAFh4hpq3UJ+GcfSMrc7ZbXzS64Xk8c5vK2yN9r1hrz6cd8M
 w7Q7S5HkKwpw==
X-IronPort-AV: E=Sophos;i="5.83,231,1616482800"; 
   d="scan'208";a="548124253"
Received: from rhweight-mobl2.amr.corp.intel.com (HELO rhweight-mobl2.ra.intel.com) ([10.209.50.238])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2021 15:11:34 -0700
From:   Russ Weight <russell.h.weight@intel.com>
To:     mdf@kernel.org, linux-fpga@vger.kernel.org
Cc:     trix@redhat.com, lgoncalv@redhat.com, yilun.xu@intel.com,
        hao.wu@intel.com, matthew.gerlach@intel.com,
        richard.gong@intel.com, Russ Weight <russell.h.weight@intel.com>
Subject: [PATCH v4 3/3] fpga: region: Use standard dev_release for class driver
Date:   Fri, 28 May 2021 14:57:55 -0700
Message-Id: <20210528215755.839712-4-russell.h.weight@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210528215755.839712-1-russell.h.weight@intel.com>
References: <20210528215755.839712-1-russell.h.weight@intel.com>
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
v4:
  - Added the compat_id parameter to fpga_bridge_register() to ensure
    that the compat_id is set before the device_register() call.
  - Modified the dfl_fpga_feature_devs_enumerate() function to restore
    the fpga_region_register() call to the correct location.
v3:
  - Cleaned up comment header for fpga_region_register()
  - Fix fpga_region_register() error return on ida_simple_get() failure
v2:
  - No changes
---
 drivers/fpga/dfl-fme-region.c    |  12 ++--
 drivers/fpga/dfl.c               |  12 ++--
 drivers/fpga/fpga-region.c       | 106 +++++++------------------------
 drivers/fpga/of-fpga-region.c    |  10 +--
 include/linux/fpga/fpga-region.h |  13 ++--
 5 files changed, 38 insertions(+), 115 deletions(-)

diff --git a/drivers/fpga/dfl-fme-region.c b/drivers/fpga/dfl-fme-region.c
index 1eeb42af1012..9e44c623a5e9 100644
--- a/drivers/fpga/dfl-fme-region.c
+++ b/drivers/fpga/dfl-fme-region.c
@@ -39,20 +39,16 @@ static int fme_region_probe(struct platform_device *pdev)
 	if (IS_ERR(mgr))
 		return -EPROBE_DEFER;
 
-	region = devm_fpga_region_create(dev, mgr, fme_region_get_bridges);
-	if (!region) {
-		ret = -ENOMEM;
+	region = fpga_region_register(dev, mgr, mgr->compat_id,
+				      fme_region_get_bridges);
+	if (IS_ERR(region)) {
+		ret = PTR_ERR(region);
 		goto eprobe_mgr_put;
 	}
 
 	region->priv = pdata;
-	region->compat_id = mgr->compat_id;
 	platform_set_drvdata(pdev, region);
 
-	ret = fpga_region_register(region);
-	if (ret)
-		goto eprobe_mgr_put;
-
 	dev_dbg(dev, "DFL FME FPGA Region probed\n");
 
 	return 0;
diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
index 511b20ff35a3..6e628c07c1dc 100644
--- a/drivers/fpga/dfl.c
+++ b/drivers/fpga/dfl.c
@@ -1400,19 +1400,15 @@ dfl_fpga_feature_devs_enumerate(struct dfl_fpga_enum_info *info)
 	if (!cdev)
 		return ERR_PTR(-ENOMEM);
 
-	cdev->region = devm_fpga_region_create(info->dev, NULL, NULL);
-	if (!cdev->region) {
-		ret = -ENOMEM;
-		goto free_cdev_exit;
-	}
-
 	cdev->parent = info->dev;
 	mutex_init(&cdev->lock);
 	INIT_LIST_HEAD(&cdev->port_dev_list);
 
-	ret = fpga_region_register(cdev->region);
-	if (ret)
+	cdev->region = fpga_region_register(info->dev, NULL, NULL, NULL);
+	if (IS_ERR(cdev->region)) {
+		ret = PTR_ERR(cdev->region);
 		goto free_cdev_exit;
+	}
 
 	/* create and init build info for enumeration */
 	binfo = devm_kzalloc(info->dev, sizeof(*binfo), GFP_KERNEL);
diff --git a/drivers/fpga/fpga-region.c b/drivers/fpga/fpga-region.c
index c3134b89c3fe..3d28880bf1cc 100644
--- a/drivers/fpga/fpga-region.c
+++ b/drivers/fpga/fpga-region.c
@@ -180,39 +180,38 @@ static struct attribute *fpga_region_attrs[] = {
 ATTRIBUTE_GROUPS(fpga_region);
 
 /**
- * fpga_region_create - alloc and init a struct fpga_region
+ * fpga_region_register - create and register a FPGA Region device
  * @dev: device parent
  * @mgr: manager that programs this region
+ * @compat_id: FPGA manager id for compatibility check.
  * @get_bridges: optional function to get bridges to a list
  *
- * The caller of this function is responsible for freeing the resulting region
- * struct with fpga_region_free().  Using devm_fpga_region_create() instead is
- * recommended.
- *
- * Return: struct fpga_region or NULL
+ * Return struct fpga_region pointer on success, or ERR_PTR() on error.
  */
-struct fpga_region
-*fpga_region_create(struct device *dev,
-		    struct fpga_manager *mgr,
-		    int (*get_bridges)(struct fpga_region *))
+struct fpga_region *
+fpga_region_register(struct device *dev, struct fpga_manager *mgr,
+		     struct fpga_compat_id *compat_id,
+		     int (*get_bridges)(struct fpga_region *))
 {
 	struct fpga_region *region;
 	int id, ret = 0;
 
 	region = kzalloc(sizeof(*region), GFP_KERNEL);
 	if (!region)
-		return NULL;
+		return ERR_PTR(-ENOMEM);
 
 	id = ida_simple_get(&fpga_region_ida, 0, 0, GFP_KERNEL);
-	if (id < 0)
+	if (id < 0) {
+		ret = id;
 		goto err_free;
+	}
 
 	region->mgr = mgr;
+	region->compat_id = compat_id;
 	region->get_bridges = get_bridges;
 	mutex_init(&region->mutex);
 	INIT_LIST_HEAD(&region->bridge_list);
 
-	device_initialize(&region->dev);
 	region->dev.class = fpga_region_class;
 	region->dev.parent = dev;
 	region->dev.of_node = dev->of_node;
@@ -222,6 +221,12 @@ struct fpga_region
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
@@ -229,76 +234,7 @@ struct fpga_region
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
 
@@ -316,6 +252,10 @@ EXPORT_SYMBOL_GPL(fpga_region_unregister);
 
 static void fpga_region_dev_release(struct device *dev)
 {
+	struct fpga_region *region = to_fpga_region(dev);
+
+	ida_simple_remove(&fpga_region_ida, region->dev.id);
+	kfree(region);
 }
 
 /**
diff --git a/drivers/fpga/of-fpga-region.c b/drivers/fpga/of-fpga-region.c
index e405309baadc..c115e5fc0c62 100644
--- a/drivers/fpga/of-fpga-region.c
+++ b/drivers/fpga/of-fpga-region.c
@@ -405,16 +405,12 @@ static int of_fpga_region_probe(struct platform_device *pdev)
 	if (IS_ERR(mgr))
 		return -EPROBE_DEFER;
 
-	region = devm_fpga_region_create(dev, mgr, of_fpga_region_get_bridges);
-	if (!region) {
-		ret = -ENOMEM;
+	region = fpga_region_register(dev, mgr, NULL, of_fpga_region_get_bridges);
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
index 27cb706275db..1e4c2dc7a63b 100644
--- a/include/linux/fpga/fpga-region.h
+++ b/include/linux/fpga/fpga-region.h
@@ -37,15 +37,10 @@ struct fpga_region *fpga_region_class_find(
 
 int fpga_region_program_fpga(struct fpga_region *region);
 
-struct fpga_region
-*fpga_region_create(struct device *dev, struct fpga_manager *mgr,
-		    int (*get_bridges)(struct fpga_region *));
-void fpga_region_free(struct fpga_region *region);
-int fpga_region_register(struct fpga_region *region);
+struct fpga_region *
+fpga_region_register(struct device *dev, struct fpga_manager *mgr,
+		     struct fpga_compat_id *compat_id,
+		     int (*get_bridges)(struct fpga_region *));
 void fpga_region_unregister(struct fpga_region *region);
 
-struct fpga_region
-*devm_fpga_region_create(struct device *dev, struct fpga_manager *mgr,
-			int (*get_bridges)(struct fpga_region *));
-
 #endif /* _FPGA_REGION_H */
-- 
2.25.1

