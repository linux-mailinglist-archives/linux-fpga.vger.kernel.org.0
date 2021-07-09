Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5EDF3C1CDE
	for <lists+linux-fpga@lfdr.de>; Fri,  9 Jul 2021 02:42:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbhGIApK (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 8 Jul 2021 20:45:10 -0400
Received: from mga14.intel.com ([192.55.52.115]:39652 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229843AbhGIApK (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 8 Jul 2021 20:45:10 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10039"; a="209440820"
X-IronPort-AV: E=Sophos;i="5.84,225,1620716400"; 
   d="scan'208";a="209440820"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2021 17:42:27 -0700
X-IronPort-AV: E=Sophos;i="5.84,225,1620716400"; 
   d="scan'208";a="411619661"
Received: from rhweight-mobl2.amr.corp.intel.com (HELO rhweight-mobl2.ra.intel.com) ([10.251.14.230])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2021 17:42:27 -0700
From:   Russ Weight <russell.h.weight@intel.com>
To:     mdf@kernel.org, linux-fpga@vger.kernel.org
Cc:     trix@redhat.com, lgoncalv@redhat.com, yilun.xu@intel.com,
        hao.wu@intel.com, matthew.gerlach@intel.com,
        richard.gong@intel.com, Russ Weight <russell.h.weight@intel.com>
Subject: [PATCH v10 3/3] fpga: region: Use standard dev_release for class driver
Date:   Thu,  8 Jul 2021 17:42:06 -0700
Message-Id: <20210709004206.244607-4-russell.h.weight@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210709004206.244607-1-russell.h.weight@intel.com>
References: <20210709004206.244607-1-russell.h.weight@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

The FPGA region class driver data structure is being treated as a
managed resource instead of using the standard dev_release call-back
function to release the class data structure. This change removes the
managed resource code and combines the create() and register()
functions into a single register() or register_full() function.

The register_full() function accepts an info data structure to provide
flexibility in passing optional parameters. The register() function
supports the current parameter list for users that don't require the
use of optional parameters.

Signed-off-by: Russ Weight <russell.h.weight@intel.com>
Reviewed-by: Xu Yilun <yilun.xu@intel.com>
---
v10:
  - Fixed commit message to reference register_full() instead of
    register_simple().
  - Updated documentation to reference the fpga_region_info structure
v9:
  - Cleaned up documentation for the FPGA Region register functions
  - Renamed fpga_region_register() to fpga_region_register_full()
  - Renamed fpga_region_register_simple() to fpga_region_register()
v8:
  - Added reviewed-by tag.
  - Updated Documentation/driver-api/fpga/fpga-region.rst documentation.
v7:
  - Update the commit message to describe the new parameters for the
    fpga_region_register() function and to mention the
    fpga_region_register_simple() function.
  - Fix function prototypes in header file to rename dev to parent.
  - Some cleanup of comments.
  - Update function definitions/prototypes to apply const to the new info
    parameter.
  - Verify a non-null info pointer in the register() functions.
v6:
  - Moved FPGA manager optional parameters out of the ops structure and
    back into the FPGA Region structure.
  - Changed fpga_region_register() parameters to accept an info data
    structure to provide flexibility in passing optional parameters.
  - Added fpga_region_register_simple() functions to support current
    parameters for users that don't require the use of optional parameters.
v5:
  - Rebased on top of recently accepted patches.
  - Created the fpga_region_ops data structure which is optionally passed
    to fpga_region_register(). compat_id, the get_bridges() pointer, and
    the priv pointer are included in the fpga_region_ops structure.
v4:
  - Added the compat_id parameter to fpga_region_register() to ensure
    that the compat_id is set before the device_register() call.
  - Modified the dfl_fpga_feature_devs_enumerate() function to restore
    the fpga_region_register() call to the correct location.
v3:
  - Cleaned up comment header for fpga_region_register()
  - Fix fpga_region_register() error return on ida_simple_get() failure
v2:
  - No changes
---
 Documentation/driver-api/fpga/fpga-region.rst |  12 +-
 drivers/fpga/dfl-fme-region.c                 |  17 ++-
 drivers/fpga/dfl.c                            |  12 +-
 drivers/fpga/fpga-region.c                    | 119 +++++++-----------
 drivers/fpga/of-fpga-region.c                 |  10 +-
 include/linux/fpga/fpga-region.h              |  36 ++++--
 6 files changed, 95 insertions(+), 111 deletions(-)

diff --git a/Documentation/driver-api/fpga/fpga-region.rst b/Documentation/driver-api/fpga/fpga-region.rst
index 2636a27c11b2..dc55d60a0b4a 100644
--- a/Documentation/driver-api/fpga/fpga-region.rst
+++ b/Documentation/driver-api/fpga/fpga-region.rst
@@ -46,8 +46,11 @@ API to add a new FPGA region
 ----------------------------
 
 * struct fpga_region - The FPGA region struct
-* devm_fpga_region_create() - Allocate and init a region struct
-* fpga_region_register() -  Register an FPGA region
+* struct fpga_region_info - Parameter structure for fpga_region_register_full()
+* fpga_region_register_full() -  Create and register an FPGA region using the
+  fpga_region_info structure to provide the full flexibility of options
+* fpga_region_register() -  Create and register an FPGA region using standard
+  arguments
 * fpga_region_unregister() -  Unregister an FPGA region
 
 The FPGA region's probe function will need to get a reference to the FPGA
@@ -75,8 +78,11 @@ following APIs to handle building or tearing down that list.
 .. kernel-doc:: include/linux/fpga/fpga-region.h
    :functions: fpga_region
 
+.. kernel-doc:: include/linux/fpga/fpga-region.h
+   :functions: fpga_region_info
+
 .. kernel-doc:: drivers/fpga/fpga-region.c
-   :functions: devm_fpga_region_create
+   :functions: fpga_region_register_full
 
 .. kernel-doc:: drivers/fpga/fpga-region.c
    :functions: fpga_region_register
diff --git a/drivers/fpga/dfl-fme-region.c b/drivers/fpga/dfl-fme-region.c
index 1eeb42af1012..4aebde0a7f1c 100644
--- a/drivers/fpga/dfl-fme-region.c
+++ b/drivers/fpga/dfl-fme-region.c
@@ -30,6 +30,7 @@ static int fme_region_get_bridges(struct fpga_region *region)
 static int fme_region_probe(struct platform_device *pdev)
 {
 	struct dfl_fme_region_pdata *pdata = dev_get_platdata(&pdev->dev);
+	struct fpga_region_info info = { 0 };
 	struct device *dev = &pdev->dev;
 	struct fpga_region *region;
 	struct fpga_manager *mgr;
@@ -39,20 +40,18 @@ static int fme_region_probe(struct platform_device *pdev)
 	if (IS_ERR(mgr))
 		return -EPROBE_DEFER;
 
-	region = devm_fpga_region_create(dev, mgr, fme_region_get_bridges);
-	if (!region) {
-		ret = -ENOMEM;
+	info.mgr = mgr;
+	info.compat_id = mgr->compat_id;
+	info.get_bridges = fme_region_get_bridges;
+	info.priv = pdata;
+	region = fpga_region_register_full(dev, &info);
+	if (IS_ERR(region)) {
+		ret = PTR_ERR(region);
 		goto eprobe_mgr_put;
 	}
 
-	region->priv = pdata;
-	region->compat_id = mgr->compat_id;
 	platform_set_drvdata(pdev, region);
 
-	ret = fpga_region_register(region);
-	if (ret)
-		goto eprobe_mgr_put;
-
 	dev_dbg(dev, "DFL FME FPGA Region probed\n");
 
 	return 0;
diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
index 511b20ff35a3..3905995ef6d5 100644
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
+	cdev->region = fpga_region_register(info->dev, NULL, NULL);
+	if (IS_ERR(cdev->region)) {
+		ret = PTR_ERR(cdev->region);
 		goto free_cdev_exit;
+	}
 
 	/* create and init build info for enumeration */
 	binfo = devm_kzalloc(info->dev, sizeof(*binfo), GFP_KERNEL);
diff --git a/drivers/fpga/fpga-region.c b/drivers/fpga/fpga-region.c
index a4838715221f..b0ac18de4885 100644
--- a/drivers/fpga/fpga-region.c
+++ b/drivers/fpga/fpga-region.c
@@ -180,39 +180,42 @@ static struct attribute *fpga_region_attrs[] = {
 ATTRIBUTE_GROUPS(fpga_region);
 
 /**
- * fpga_region_create - alloc and init a struct fpga_region
+ * fpga_region_register_full - create and register an FPGA Region device
  * @parent: device parent
- * @mgr: manager that programs this region
- * @get_bridges: optional function to get bridges to a list
- *
- * The caller of this function is responsible for freeing the resulting region
- * struct with fpga_region_free().  Using devm_fpga_region_create() instead is
- * recommended.
+ * @info: parameters for FPGA Region
  *
- * Return: struct fpga_region or NULL
+ * Return: struct fpga_region or ERR_PTR()
  */
-struct fpga_region
-*fpga_region_create(struct device *parent,
-		    struct fpga_manager *mgr,
-		    int (*get_bridges)(struct fpga_region *))
+struct fpga_region *
+fpga_region_register_full(struct device *parent, const struct fpga_region_info *info)
 {
 	struct fpga_region *region;
 	int id, ret = 0;
 
+	if (!info) {
+		dev_err(parent,
+			"Attempt to register without required info structure\n");
+		return ERR_PTR(-EINVAL);
+	}
+
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
+
+	region->mgr = info->mgr;
+	region->compat_id = info->compat_id;
+	region->priv = info->priv;
+	region->get_bridges = info->get_bridges;
 
-	region->mgr = mgr;
-	region->get_bridges = get_bridges;
 	mutex_init(&region->mutex);
 	INIT_LIST_HEAD(&region->bridge_list);
 
-	device_initialize(&region->dev);
 	region->dev.class = fpga_region_class;
 	region->dev.parent = parent;
 	region->dev.of_node = parent->of_node;
@@ -222,6 +225,12 @@ struct fpga_region
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
@@ -229,76 +238,32 @@ struct fpga_region
 err_free:
 	kfree(region);
 
-	return NULL;
-}
-EXPORT_SYMBOL_GPL(fpga_region_create);
-
-/**
- * fpga_region_free - free an FPGA region created by fpga_region_create()
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
+	return ERR_PTR(ret);
 }
+EXPORT_SYMBOL_GPL(fpga_region_register_full);
 
 /**
- * devm_fpga_region_create - create and initialize a managed FPGA region struct
+ * fpga_region_register - create and register an FPGA Region device
  * @parent: device parent
  * @mgr: manager that programs this region
  * @get_bridges: optional function to get bridges to a list
  *
- * This function is intended for use in an FPGA region driver's probe function.
- * After the region driver creates the region struct with
- * devm_fpga_region_create(), it should register it with fpga_region_register().
- * The region driver's remove function should call fpga_region_unregister().
- * The region struct allocated with this function will be freed automatically on
- * driver detach.  This includes the case of a probe function returning error
- * before calling fpga_region_register(), the struct will still get cleaned up.
+ * This simple version of the register function should be sufficient for most users.
+ * The fpga_region_register_full() function is available for users that need to
+ * pass additional, optional parameters.
  *
- * Return: struct fpga_region or NULL
+ * Return: struct fpga_region or ERR_PTR()
  */
-struct fpga_region
-*devm_fpga_region_create(struct device *parent,
-			 struct fpga_manager *mgr,
-			 int (*get_bridges)(struct fpga_region *))
+struct fpga_region *
+fpga_region_register(struct device *parent, struct fpga_manager *mgr,
+		     int (*get_bridges)(struct fpga_region *))
 {
-	struct fpga_region **ptr, *region;
-
-	ptr = devres_alloc(devm_fpga_region_release, sizeof(*ptr), GFP_KERNEL);
-	if (!ptr)
-		return NULL;
+	struct fpga_region_info info = { 0 };
 
-	region = fpga_region_create(parent, mgr, get_bridges);
-	if (!region) {
-		devres_free(ptr);
-	} else {
-		*ptr = region;
-		devres_add(parent, ptr);
-	}
+	info.mgr = mgr;
+	info.get_bridges = get_bridges;
 
-	return region;
-}
-EXPORT_SYMBOL_GPL(devm_fpga_region_create);
-
-/**
- * fpga_region_register - register an FPGA region
- * @region: FPGA region
- *
- * Return: 0 or -errno
- */
-int fpga_region_register(struct fpga_region *region)
-{
-	return device_add(&region->dev);
+	return fpga_region_register_full(parent, &info);
 }
 EXPORT_SYMBOL_GPL(fpga_region_register);
 
@@ -316,6 +281,10 @@ EXPORT_SYMBOL_GPL(fpga_region_unregister);
 
 static void fpga_region_dev_release(struct device *dev)
 {
+	struct fpga_region *region = to_fpga_region(dev);
+
+	ida_simple_remove(&fpga_region_ida, region->dev.id);
+	kfree(region);
 }
 
 /**
diff --git a/drivers/fpga/of-fpga-region.c b/drivers/fpga/of-fpga-region.c
index e3c25576b6b9..9c662db1c508 100644
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
index 27cb706275db..ae111beeffba 100644
--- a/include/linux/fpga/fpga-region.h
+++ b/include/linux/fpga/fpga-region.h
@@ -7,6 +7,27 @@
 #include <linux/fpga/fpga-mgr.h>
 #include <linux/fpga/fpga-bridge.h>
 
+struct fpga_region;
+
+/**
+ * struct fpga_region_info - collection of parameters an FPGA Region
+ * @mgr: fpga region manager
+ * @compat_id: FPGA region id for compatibility check.
+ * @priv: fpga region private data
+ * @get_bridges: optional function to get bridges to a list
+ *
+ * fpga_region_info contains parameters for the register_full function.
+ * These are separated into an info structure because they some are optional
+ * others could be added to in the future. The info structure facilitates
+ * maintaining a stable API.
+ */
+struct fpga_region_info {
+	struct fpga_manager *mgr;
+	struct fpga_compat_id *compat_id;
+	void *priv;
+	int (*get_bridges)(struct fpga_region *region);
+};
+
 /**
  * struct fpga_region - FPGA Region structure
  * @dev: FPGA Region device
@@ -37,15 +58,12 @@ struct fpga_region *fpga_region_class_find(
 
 int fpga_region_program_fpga(struct fpga_region *region);
 
-struct fpga_region
-*fpga_region_create(struct device *dev, struct fpga_manager *mgr,
-		    int (*get_bridges)(struct fpga_region *));
-void fpga_region_free(struct fpga_region *region);
-int fpga_region_register(struct fpga_region *region);
-void fpga_region_unregister(struct fpga_region *region);
+struct fpga_region *
+fpga_region_register_full(struct device *parent, const struct fpga_region_info *info);
 
-struct fpga_region
-*devm_fpga_region_create(struct device *dev, struct fpga_manager *mgr,
-			int (*get_bridges)(struct fpga_region *));
+struct fpga_region *
+fpga_region_register(struct device *parent, struct fpga_manager *mgr,
+		     int (*get_bridges)(struct fpga_region *));
+void fpga_region_unregister(struct fpga_region *region);
 
 #endif /* _FPGA_REGION_H */
-- 
2.25.1

