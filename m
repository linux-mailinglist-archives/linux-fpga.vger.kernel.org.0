Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B483C453DA0
	for <lists+linux-fpga@lfdr.de>; Wed, 17 Nov 2021 02:21:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232678AbhKQBYe (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 16 Nov 2021 20:24:34 -0500
Received: from mga17.intel.com ([192.55.52.151]:25280 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232498AbhKQBY1 (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 16 Nov 2021 20:24:27 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10170"; a="214580729"
X-IronPort-AV: E=Sophos;i="5.87,239,1631602800"; 
   d="scan'208";a="214580729"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2021 17:21:29 -0800
X-IronPort-AV: E=Sophos;i="5.87,239,1631602800"; 
   d="scan'208";a="494710461"
Received: from rhweight-mobl.amr.corp.intel.com (HELO rhweight-mobl.ra.intel.com) ([10.209.15.48])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2021 17:21:28 -0800
From:   Russ Weight <russell.h.weight@intel.com>
To:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, lgoncalv@redhat.com, yilun.xu@intel.com,
        hao.wu@intel.com, matthew.gerlach@intel.com,
        Russ Weight <russell.h.weight@intel.com>
Subject: [PATCH v13 1/3] fpga: mgr: Use standard dev_release for class driver
Date:   Tue, 16 Nov 2021 17:21:20 -0800
Message-Id: <20211117012122.60141-2-russell.h.weight@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211117012122.60141-1-russell.h.weight@intel.com>
References: <20211117012122.60141-1-russell.h.weight@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

The FPGA manager class driver data structure is being treated as a
managed resource instead of using the standard dev_release call-back
function to release the class data structure. This change removes
the managed resource code for the freeing of the class data structure
and combines the create() and register() functions into a single
register() or register_full() function.

The register_full() function accepts an info data structure to provide
flexibility in passing optional parameters. The register() function
supports the current parameter list for users that don't require the
use of optional parameters.

The devm_fpga_mgr_register() function is retained, and the
devm_fpga_mgr_register_full() function is added.

Signed-off-by: Russ Weight <russell.h.weight@intel.com>
Reviewed-by: Xu Yilun <yilun.xu@intel.com>
Acked-by: Xu Yilun <yilun.xu@intel.com>
---
v13:
  - Add Acked-by tag
v12:
  - Made the requisite changes to the new versal-fpga driver
v11:
  - Rebased to latest linux-next
  - Resolved a single conflict with associated with  wrapper function:
    fpga_mgr_state(mgr)
v10:
  - Fixed commit message to reference register_full() instead of
    register_simple().
  - Updated documentation to reference the fpga_manager_info structure
v9:
  - Cleaned up documentation for the FPGA Manager register functions
  - Renamed fpga_mgr_register() to fpga_mgr_register_full()
  - Renamed fpga_mgr_register_simple() to fpga_mgr_register()
  - Renamed devm_fpga_mgr_register() to devm_fpga_mgr_register_full()
  - Renamed devm_fpga_mgr_register_simple() to devm_fpga_mgr_register()
v8:
  - Added reviewed-by tag.
  - Updated Documentation/driver-api/fpga/fpga-mgr.rst documentation.
v7:
  - Update the commit message to describe the new parameters for the
    *fpga_mgr_register() functions and to mention the
    *fpga_mgr_register_simple() functions.
  - Fix function prototypes in header file to rename dev to parent.
  - Make use of the PTR_ERR_OR_ZERO() macro when possible.
  - Some cleanup of comments.
  - Update function definitions/prototypes to apply const to the new info
    parameter.
v6:
  - Moved FPGA manager optional parameters out of the ops structure and
    back into the FPGA manager structure.
  - Changed fpga_mgr_register()/devm_fpga_mgr_register() parameters to
    accept an info data structure to provide flexibility in passing optional
    parameters.
  - Added fpga_mgr_register_simple()/devm_fpga_mgr_register_simple()
    functions to support current parameters for users that don't require
    the use of optional parameters.
v5:
  - Rebased on top of recently accepted patches.
  - Removed compat_id from the fpga_mgr_register() parameter list
    and added it to the fpga_manager_ops structure. This also required
    dynamically allocating the dfl-fme-ops structure in order to add
    the appropriate compat_id.
v4:
  - Added the compat_id parameter to fpga_mgr_register() and
    devm_fpga_mgr_register() to ensure that the compat_id is set before
    the device_register() call.
v3:
  - Cleaned up comment header for fpga_mgr_register()
  - Fix error return on ida_simple_get() failure
v2:
  - Restored devm_fpga_mgr_register() functionality, adapted for the combined
    create/register functionality.
  - All previous callers of devm_fpga_mgr_register() will continue to call
    devm_fpga_mgr_register().
  - replaced unnecessary ternary operators in return statements with standard
    if conditions.
---
 Documentation/driver-api/fpga/fpga-mgr.rst |  38 +++-
 drivers/fpga/altera-cvp.c                  |  12 +-
 drivers/fpga/altera-pr-ip-core.c           |   7 +-
 drivers/fpga/altera-ps-spi.c               |   9 +-
 drivers/fpga/dfl-fme-mgr.c                 |  22 +--
 drivers/fpga/fpga-mgr.c                    | 215 +++++++++------------
 drivers/fpga/ice40-spi.c                   |   9 +-
 drivers/fpga/machxo2-spi.c                 |   9 +-
 drivers/fpga/socfpga-a10.c                 |  16 +-
 drivers/fpga/socfpga.c                     |   9 +-
 drivers/fpga/stratix10-soc.c               |  16 +-
 drivers/fpga/ts73xx-fpga.c                 |   9 +-
 drivers/fpga/versal-fpga.c                 |   9 +-
 drivers/fpga/xilinx-spi.c                  |  11 +-
 drivers/fpga/zynq-fpga.c                   |  16 +-
 drivers/fpga/zynqmp-fpga.c                 |   9 +-
 include/linux/fpga/fpga-mgr.h              |  62 ++++--
 17 files changed, 217 insertions(+), 261 deletions(-)

diff --git a/Documentation/driver-api/fpga/fpga-mgr.rst b/Documentation/driver-api/fpga/fpga-mgr.rst
index 4d926b452cb3..42c01f396dce 100644
--- a/Documentation/driver-api/fpga/fpga-mgr.rst
+++ b/Documentation/driver-api/fpga/fpga-mgr.rst
@@ -24,7 +24,7 @@ How to support a new FPGA device
 --------------------------------
 
 To add another FPGA manager, write a driver that implements a set of ops.  The
-probe function calls fpga_mgr_register(), such as::
+probe function calls fpga_mgr_register() or fpga_mgr_register_full(), such as::
 
 	static const struct fpga_manager_ops socfpga_fpga_ops = {
 		.write_init = socfpga_fpga_ops_configure_init,
@@ -49,14 +49,14 @@ probe function calls fpga_mgr_register(), such as::
 		 * them in priv
 		 */
 
-		mgr = devm_fpga_mgr_create(dev, "Altera SOCFPGA FPGA Manager",
-					   &socfpga_fpga_ops, priv);
-		if (!mgr)
-			return -ENOMEM;
+		mgr = fpga_mgr_register(dev, "Altera SOCFPGA FPGA Manager",
+					&socfpga_fpga_ops, priv);
+		if (IS_ERR(mgr))
+			return PTR_ERR(mgr);
 
 		platform_set_drvdata(pdev, mgr);
 
-		return fpga_mgr_register(mgr);
+		return 0;
 	}
 
 	static int socfpga_fpga_remove(struct platform_device *pdev)
@@ -68,6 +68,11 @@ probe function calls fpga_mgr_register(), such as::
 		return 0;
 	}
 
+Alternatively, the probe function could call one of the resource managed
+register functions, devm_fpga_mgr_register() or devm_fpga_mgr_register_full().
+When these functions are used, the parameter syntax is the same, but the call
+to fpga_mgr_unregister() should be removed. In the above example, the
+socfpga_fpga_remove() function would not be required.
 
 The ops will implement whatever device specific register writes are needed to
 do the programming sequence for this particular FPGA.  These ops return 0 for
@@ -104,8 +109,14 @@ API for implementing a new FPGA Manager driver
 * ``fpga_mgr_states`` -  Values for :c:expr:`fpga_manager->state`.
 * struct fpga_manager -  the FPGA manager struct
 * struct fpga_manager_ops -  Low level FPGA manager driver ops
-* devm_fpga_mgr_create() -  Allocate and init a manager struct
-* fpga_mgr_register() -  Register an FPGA manager
+* struct fpga_manager_info -  Parameter structure for fpga_mgr_register_full()
+* fpga_mgr_register_full() -  Create and register an FPGA manager using the
+  fpga_mgr_info structure to provide the full flexibility of options
+* fpga_mgr_register() -  Create and register an FPGA manager using standard
+  arguments
+* devm_fpga_mgr_register_full() -  Resource managed version of
+  fpga_mgr_register_full()
+* devm_fpga_mgr_register() -  Resource managed version of fpga_mgr_register()
 * fpga_mgr_unregister() -  Unregister an FPGA manager
 
 .. kernel-doc:: include/linux/fpga/fpga-mgr.h
@@ -117,11 +128,20 @@ API for implementing a new FPGA Manager driver
 .. kernel-doc:: include/linux/fpga/fpga-mgr.h
    :functions: fpga_manager_ops
 
+.. kernel-doc:: include/linux/fpga/fpga-mgr.h
+   :functions: fpga_manager_info
+
 .. kernel-doc:: drivers/fpga/fpga-mgr.c
-   :functions: devm_fpga_mgr_create
+   :functions: fpga_mgr_register_full
 
 .. kernel-doc:: drivers/fpga/fpga-mgr.c
    :functions: fpga_mgr_register
 
+.. kernel-doc:: drivers/fpga/fpga-mgr.c
+   :functions: devm_fpga_mgr_register_full
+
+.. kernel-doc:: drivers/fpga/fpga-mgr.c
+   :functions: devm_fpga_mgr_register
+
 .. kernel-doc:: drivers/fpga/fpga-mgr.c
    :functions: fpga_mgr_unregister
diff --git a/drivers/fpga/altera-cvp.c b/drivers/fpga/altera-cvp.c
index ccf4546eff29..4ffb9da537d8 100644
--- a/drivers/fpga/altera-cvp.c
+++ b/drivers/fpga/altera-cvp.c
@@ -652,19 +652,15 @@ static int altera_cvp_probe(struct pci_dev *pdev,
 	snprintf(conf->mgr_name, sizeof(conf->mgr_name), "%s @%s",
 		 ALTERA_CVP_MGR_NAME, pci_name(pdev));
 
-	mgr = devm_fpga_mgr_create(&pdev->dev, conf->mgr_name,
-				   &altera_cvp_ops, conf);
-	if (!mgr) {
-		ret = -ENOMEM;
+	mgr = fpga_mgr_register(&pdev->dev, conf->mgr_name,
+				&altera_cvp_ops, conf);
+	if (IS_ERR(mgr)) {
+		ret = PTR_ERR(mgr);
 		goto err_unmap;
 	}
 
 	pci_set_drvdata(pdev, mgr);
 
-	ret = fpga_mgr_register(mgr);
-	if (ret)
-		goto err_unmap;
-
 	return 0;
 
 err_unmap:
diff --git a/drivers/fpga/altera-pr-ip-core.c b/drivers/fpga/altera-pr-ip-core.c
index dfdf21ed34c4..be0667968d33 100644
--- a/drivers/fpga/altera-pr-ip-core.c
+++ b/drivers/fpga/altera-pr-ip-core.c
@@ -191,11 +191,8 @@ int alt_pr_register(struct device *dev, void __iomem *reg_base)
 		(val & ALT_PR_CSR_STATUS_MSK) >> ALT_PR_CSR_STATUS_SFT,
 		(int)(val & ALT_PR_CSR_PR_START));
 
-	mgr = devm_fpga_mgr_create(dev, dev_name(dev), &alt_pr_ops, priv);
-	if (!mgr)
-		return -ENOMEM;
-
-	return devm_fpga_mgr_register(dev, mgr);
+	mgr = devm_fpga_mgr_register(dev, dev_name(dev), &alt_pr_ops, priv);
+	return PTR_ERR_OR_ZERO(mgr);
 }
 EXPORT_SYMBOL_GPL(alt_pr_register);
 
diff --git a/drivers/fpga/altera-ps-spi.c b/drivers/fpga/altera-ps-spi.c
index 23bfd4d1ad0f..5e1e009dba89 100644
--- a/drivers/fpga/altera-ps-spi.c
+++ b/drivers/fpga/altera-ps-spi.c
@@ -302,12 +302,9 @@ static int altera_ps_probe(struct spi_device *spi)
 	snprintf(conf->mgr_name, sizeof(conf->mgr_name), "%s %s",
 		 dev_driver_string(&spi->dev), dev_name(&spi->dev));
 
-	mgr = devm_fpga_mgr_create(&spi->dev, conf->mgr_name,
-				   &altera_ps_ops, conf);
-	if (!mgr)
-		return -ENOMEM;
-
-	return devm_fpga_mgr_register(&spi->dev, mgr);
+	mgr = devm_fpga_mgr_register(&spi->dev, conf->mgr_name,
+				     &altera_ps_ops, conf);
+	return PTR_ERR_OR_ZERO(mgr);
 }
 
 static const struct spi_device_id altera_ps_spi_ids[] = {
diff --git a/drivers/fpga/dfl-fme-mgr.c b/drivers/fpga/dfl-fme-mgr.c
index 313420405d5e..af0785783b52 100644
--- a/drivers/fpga/dfl-fme-mgr.c
+++ b/drivers/fpga/dfl-fme-mgr.c
@@ -276,7 +276,7 @@ static void fme_mgr_get_compat_id(void __iomem *fme_pr,
 static int fme_mgr_probe(struct platform_device *pdev)
 {
 	struct dfl_fme_mgr_pdata *pdata = dev_get_platdata(&pdev->dev);
-	struct fpga_compat_id *compat_id;
+	struct fpga_manager_info info = { 0 };
 	struct device *dev = &pdev->dev;
 	struct fme_mgr_priv *priv;
 	struct fpga_manager *mgr;
@@ -296,20 +296,16 @@ static int fme_mgr_probe(struct platform_device *pdev)
 			return PTR_ERR(priv->ioaddr);
 	}
 
-	compat_id = devm_kzalloc(dev, sizeof(*compat_id), GFP_KERNEL);
-	if (!compat_id)
+	info.name = "DFL FME FPGA Manager";
+	info.mops = &fme_mgr_ops;
+	info.priv = priv;
+	info.compat_id = devm_kzalloc(dev, sizeof(*info.compat_id), GFP_KERNEL);
+	if (!info.compat_id)
 		return -ENOMEM;
 
-	fme_mgr_get_compat_id(priv->ioaddr, compat_id);
-
-	mgr = devm_fpga_mgr_create(dev, "DFL FME FPGA Manager",
-				   &fme_mgr_ops, priv);
-	if (!mgr)
-		return -ENOMEM;
-
-	mgr->compat_id = compat_id;
-
-	return devm_fpga_mgr_register(dev, mgr);
+	fme_mgr_get_compat_id(priv->ioaddr, info.compat_id);
+	mgr = devm_fpga_mgr_register_full(dev, &info);
+	return PTR_ERR_OR_ZERO(mgr);
 }
 
 static struct platform_driver fme_mgr_driver = {
diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
index aa30889e2320..d49a9ce34568 100644
--- a/drivers/fpga/fpga-mgr.c
+++ b/drivers/fpga/fpga-mgr.c
@@ -592,49 +592,49 @@ void fpga_mgr_unlock(struct fpga_manager *mgr)
 EXPORT_SYMBOL_GPL(fpga_mgr_unlock);
 
 /**
- * fpga_mgr_create - create and initialize an FPGA manager struct
+ * fpga_mgr_register_full - create and register an FPGA Manager device
  * @parent:	fpga manager device from pdev
- * @name:	fpga manager name
- * @mops:	pointer to structure of fpga manager ops
- * @priv:	fpga manager private data
+ * @info:	parameters for fpga manager
  *
- * The caller of this function is responsible for freeing the struct with
- * fpga_mgr_free().  Using devm_fpga_mgr_create() instead is recommended.
+ * The caller of this function is responsible for calling fpga_mgr_unregister().
+ * Using devm_fpga_mgr_register_full() instead is recommended.
  *
- * Return: pointer to struct fpga_manager or NULL
+ * Return: pointer to struct fpga_manager pointer or ERR_PTR()
  */
-struct fpga_manager *fpga_mgr_create(struct device *parent, const char *name,
-				     const struct fpga_manager_ops *mops,
-				     void *priv)
+struct fpga_manager *
+fpga_mgr_register_full(struct device *parent, const struct fpga_manager_info *info)
 {
+	const struct fpga_manager_ops *mops = info->mops;
 	struct fpga_manager *mgr;
 	int id, ret;
 
 	if (!mops) {
 		dev_err(parent, "Attempt to register without fpga_manager_ops\n");
-		return NULL;
+		return ERR_PTR(-EINVAL);
 	}
 
-	if (!name || !strlen(name)) {
+	if (!info->name || !strlen(info->name)) {
 		dev_err(parent, "Attempt to register with no name!\n");
-		return NULL;
+		return ERR_PTR(-EINVAL);
 	}
 
 	mgr = kzalloc(sizeof(*mgr), GFP_KERNEL);
 	if (!mgr)
-		return NULL;
+		return ERR_PTR(-ENOMEM);
 
 	id = ida_simple_get(&fpga_mgr_ida, 0, 0, GFP_KERNEL);
-	if (id < 0)
+	if (id < 0) {
+		ret = id;
 		goto error_kfree;
+	}
 
 	mutex_init(&mgr->ref_mutex);
 
-	mgr->name = name;
-	mgr->mops = mops;
-	mgr->priv = priv;
+	mgr->name = info->name;
+	mgr->mops = info->mops;
+	mgr->priv = info->priv;
+	mgr->compat_id = info->compat_id;
 
-	device_initialize(&mgr->dev);
 	mgr->dev.class = fpga_mgr_class;
 	mgr->dev.groups = mops->groups;
 	mgr->dev.parent = parent;
@@ -645,6 +645,19 @@ struct fpga_manager *fpga_mgr_create(struct device *parent, const char *name,
 	if (ret)
 		goto error_device;
 
+	/*
+	 * Initialize framework state by requesting low level driver read state
+	 * from device.  FPGA may be in reset mode or may have been programmed
+	 * by bootloader or EEPROM.
+	 */
+	mgr->state = fpga_mgr_state(mgr);
+
+	ret = device_register(&mgr->dev);
+	if (ret) {
+		put_device(&mgr->dev);
+		return ERR_PTR(ret);
+	}
+
 	return mgr;
 
 error_device:
@@ -652,96 +665,36 @@ struct fpga_manager *fpga_mgr_create(struct device *parent, const char *name,
 error_kfree:
 	kfree(mgr);
 
-	return NULL;
+	return ERR_PTR(ret);
 }
-EXPORT_SYMBOL_GPL(fpga_mgr_create);
+EXPORT_SYMBOL_GPL(fpga_mgr_register_full);
 
 /**
- * fpga_mgr_free - free an FPGA manager created with fpga_mgr_create()
- * @mgr:	fpga manager struct
- */
-void fpga_mgr_free(struct fpga_manager *mgr)
-{
-	ida_simple_remove(&fpga_mgr_ida, mgr->dev.id);
-	kfree(mgr);
-}
-EXPORT_SYMBOL_GPL(fpga_mgr_free);
-
-static void devm_fpga_mgr_release(struct device *dev, void *res)
-{
-	struct fpga_mgr_devres *dr = res;
-
-	fpga_mgr_free(dr->mgr);
-}
-
-/**
- * devm_fpga_mgr_create - create and initialize a managed FPGA manager struct
+ * fpga_mgr_register - create and register an FPGA Manager device
  * @parent:	fpga manager device from pdev
  * @name:	fpga manager name
  * @mops:	pointer to structure of fpga manager ops
  * @priv:	fpga manager private data
  *
- * This function is intended for use in an FPGA manager driver's probe function.
- * After the manager driver creates the manager struct with
- * devm_fpga_mgr_create(), it should register it with fpga_mgr_register().  The
- * manager driver's remove function should call fpga_mgr_unregister().  The
- * manager struct allocated with this function will be freed automatically on
- * driver detach.  This includes the case of a probe function returning error
- * before calling fpga_mgr_register(), the struct will still get cleaned up.
+ * The caller of this function is responsible for calling fpga_mgr_unregister().
+ * Using devm_fpga_mgr_register() instead is recommended. This simple
+ * version of the register function should be sufficient for most users. The
+ * fpga_mgr_register_full() function is available for users that need to pass
+ * additional, optional parameters.
  *
- * Return: pointer to struct fpga_manager or NULL
+ * Return: pointer to struct fpga_manager pointer or ERR_PTR()
  */
-struct fpga_manager *devm_fpga_mgr_create(struct device *parent, const char *name,
-					  const struct fpga_manager_ops *mops,
-					  void *priv)
+struct fpga_manager *
+fpga_mgr_register(struct device *parent, const char *name,
+		  const struct fpga_manager_ops *mops, void *priv)
 {
-	struct fpga_mgr_devres *dr;
+	struct fpga_manager_info info = { 0 };
 
-	dr = devres_alloc(devm_fpga_mgr_release, sizeof(*dr), GFP_KERNEL);
-	if (!dr)
-		return NULL;
+	info.name = name;
+	info.mops = mops;
+	info.priv = priv;
 
-	dr->mgr = fpga_mgr_create(parent, name, mops, priv);
-	if (!dr->mgr) {
-		devres_free(dr);
-		return NULL;
-	}
-
-	devres_add(parent, dr);
-
-	return dr->mgr;
-}
-EXPORT_SYMBOL_GPL(devm_fpga_mgr_create);
-
-/**
- * fpga_mgr_register - register an FPGA manager
- * @mgr: fpga manager struct
- *
- * Return: 0 on success, negative error code otherwise.
- */
-int fpga_mgr_register(struct fpga_manager *mgr)
-{
-	int ret;
-
-	/*
-	 * Initialize framework state by requesting low level driver read state
-	 * from device.  FPGA may be in reset mode or may have been programmed
-	 * by bootloader or EEPROM.
-	 */
-	mgr->state = fpga_mgr_state(mgr);
-
-	ret = device_add(&mgr->dev);
-	if (ret)
-		goto error_device;
-
-	dev_info(&mgr->dev, "%s registered\n", mgr->name);
-
-	return 0;
-
-error_device:
-	ida_simple_remove(&fpga_mgr_ida, mgr->dev.id);
-
-	return ret;
+	return fpga_mgr_register_full(parent, &info);
 }
 EXPORT_SYMBOL_GPL(fpga_mgr_register);
 
@@ -765,14 +718,6 @@ void fpga_mgr_unregister(struct fpga_manager *mgr)
 }
 EXPORT_SYMBOL_GPL(fpga_mgr_unregister);
 
-static int fpga_mgr_devres_match(struct device *dev, void *res,
-				 void *match_data)
-{
-	struct fpga_mgr_devres *dr = res;
-
-	return match_data == dr->mgr;
-}
-
 static void devm_fpga_mgr_unregister(struct device *dev, void *res)
 {
 	struct fpga_mgr_devres *dr = res;
@@ -781,45 +726,67 @@ static void devm_fpga_mgr_unregister(struct device *dev, void *res)
 }
 
 /**
- * devm_fpga_mgr_register - resource managed variant of fpga_mgr_register()
- * @dev: managing device for this FPGA manager
- * @mgr: fpga manager struct
+ * devm_fpga_mgr_register_full - resource managed variant of fpga_mgr_register()
+ * @parent:	fpga manager device from pdev
+ * @info:	parameters for fpga manager
  *
- * This is the devres variant of fpga_mgr_register() for which the unregister
+ * This is the devres variant of fpga_mgr_register_full() for which the unregister
  * function will be called automatically when the managing device is detached.
  */
-int devm_fpga_mgr_register(struct device *dev, struct fpga_manager *mgr)
+struct fpga_manager *
+devm_fpga_mgr_register_full(struct device *parent, const struct fpga_manager_info *info)
 {
 	struct fpga_mgr_devres *dr;
-	int ret;
-
-	/*
-	 * Make sure that the struct fpga_manager * that is passed in is
-	 * managed itself.
-	 */
-	if (WARN_ON(!devres_find(dev, devm_fpga_mgr_release,
-				 fpga_mgr_devres_match, mgr)))
-		return -EINVAL;
+	struct fpga_manager *mgr;
 
 	dr = devres_alloc(devm_fpga_mgr_unregister, sizeof(*dr), GFP_KERNEL);
 	if (!dr)
-		return -ENOMEM;
+		return ERR_PTR(-ENOMEM);
 
-	ret = fpga_mgr_register(mgr);
-	if (ret) {
+	mgr = fpga_mgr_register_full(parent, info);
+	if (IS_ERR(mgr)) {
 		devres_free(dr);
-		return ret;
+		return mgr;
 	}
 
 	dr->mgr = mgr;
-	devres_add(dev, dr);
+	devres_add(parent, dr);
 
-	return 0;
+	return mgr;
+}
+EXPORT_SYMBOL_GPL(devm_fpga_mgr_register_full);
+
+/**
+ * devm_fpga_mgr_register - resource managed variant of fpga_mgr_register()
+ * @parent:	fpga manager device from pdev
+ * @name:	fpga manager name
+ * @mops:	pointer to structure of fpga manager ops
+ * @priv:	fpga manager private data
+ *
+ * This is the devres variant of fpga_mgr_register() for which the
+ * unregister function will be called automatically when the managing
+ * device is detached.
+ */
+struct fpga_manager *
+devm_fpga_mgr_register(struct device *parent, const char *name,
+		       const struct fpga_manager_ops *mops, void *priv)
+{
+	struct fpga_manager_info info = { 0 };
+
+	info.name = name;
+	info.mops = mops;
+	info.priv = priv;
+
+	return devm_fpga_mgr_register_full(parent, &info);
 }
 EXPORT_SYMBOL_GPL(devm_fpga_mgr_register);
 
 static void fpga_mgr_dev_release(struct device *dev)
 {
+	struct fpga_manager *mgr = to_fpga_manager(dev);
+
+	ida_simple_remove(&fpga_mgr_ida, mgr->dev.id);
+	kfree(mgr);
 }
 
 static int __init fpga_mgr_class_init(void)
diff --git a/drivers/fpga/ice40-spi.c b/drivers/fpga/ice40-spi.c
index 029d3cdb918d..7cbb3558b844 100644
--- a/drivers/fpga/ice40-spi.c
+++ b/drivers/fpga/ice40-spi.c
@@ -178,12 +178,9 @@ static int ice40_fpga_probe(struct spi_device *spi)
 		return ret;
 	}
 
-	mgr = devm_fpga_mgr_create(dev, "Lattice iCE40 FPGA Manager",
-				   &ice40_fpga_ops, priv);
-	if (!mgr)
-		return -ENOMEM;
-
-	return devm_fpga_mgr_register(dev, mgr);
+	mgr = devm_fpga_mgr_register(dev, "Lattice iCE40 FPGA Manager",
+				     &ice40_fpga_ops, priv);
+	return PTR_ERR_OR_ZERO(mgr);
 }
 
 static const struct of_device_id ice40_fpga_of_match[] = {
diff --git a/drivers/fpga/machxo2-spi.c b/drivers/fpga/machxo2-spi.c
index ea2ec3c6815c..905607992a12 100644
--- a/drivers/fpga/machxo2-spi.c
+++ b/drivers/fpga/machxo2-spi.c
@@ -370,12 +370,9 @@ static int machxo2_spi_probe(struct spi_device *spi)
 		return -EINVAL;
 	}
 
-	mgr = devm_fpga_mgr_create(dev, "Lattice MachXO2 SPI FPGA Manager",
-				   &machxo2_ops, spi);
-	if (!mgr)
-		return -ENOMEM;
-
-	return devm_fpga_mgr_register(dev, mgr);
+	mgr = devm_fpga_mgr_register(dev, "Lattice MachXO2 SPI FPGA Manager",
+				     &machxo2_ops, spi);
+	return PTR_ERR_OR_ZERO(mgr);
 }
 
 #ifdef CONFIG_OF
diff --git a/drivers/fpga/socfpga-a10.c b/drivers/fpga/socfpga-a10.c
index 573d88bdf730..ac8e89b8a5cc 100644
--- a/drivers/fpga/socfpga-a10.c
+++ b/drivers/fpga/socfpga-a10.c
@@ -508,19 +508,15 @@ static int socfpga_a10_fpga_probe(struct platform_device *pdev)
 		return -EBUSY;
 	}
 
-	mgr = devm_fpga_mgr_create(dev, "SoCFPGA Arria10 FPGA Manager",
-				   &socfpga_a10_fpga_mgr_ops, priv);
-	if (!mgr)
-		return -ENOMEM;
-
-	platform_set_drvdata(pdev, mgr);
-
-	ret = fpga_mgr_register(mgr);
-	if (ret) {
+	mgr = fpga_mgr_register(dev, "SoCFPGA Arria10 FPGA Manager",
+				&socfpga_a10_fpga_mgr_ops, priv);
+	if (IS_ERR(mgr)) {
 		clk_disable_unprepare(priv->clk);
-		return ret;
+		return PTR_ERR(mgr);
 	}
 
+	platform_set_drvdata(pdev, mgr);
+
 	return 0;
 }
 
diff --git a/drivers/fpga/socfpga.c b/drivers/fpga/socfpga.c
index 1f467173fc1f..7e0741f99696 100644
--- a/drivers/fpga/socfpga.c
+++ b/drivers/fpga/socfpga.c
@@ -571,12 +571,9 @@ static int socfpga_fpga_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	mgr = devm_fpga_mgr_create(dev, "Altera SOCFPGA FPGA Manager",
-				   &socfpga_fpga_ops, priv);
-	if (!mgr)
-		return -ENOMEM;
-
-	return devm_fpga_mgr_register(dev, mgr);
+	mgr = devm_fpga_mgr_register(dev, "Altera SOCFPGA FPGA Manager",
+				     &socfpga_fpga_ops, priv);
+	return PTR_ERR_OR_ZERO(mgr);
 }
 
 #ifdef CONFIG_OF
diff --git a/drivers/fpga/stratix10-soc.c b/drivers/fpga/stratix10-soc.c
index 047fd7f23706..737d14c6e0de 100644
--- a/drivers/fpga/stratix10-soc.c
+++ b/drivers/fpga/stratix10-soc.c
@@ -419,18 +419,11 @@ static int s10_probe(struct platform_device *pdev)
 
 	init_completion(&priv->status_return_completion);
 
-	mgr = fpga_mgr_create(dev, "Stratix10 SOC FPGA Manager",
-			      &s10_ops, priv);
-	if (!mgr) {
-		dev_err(dev, "unable to create FPGA manager\n");
-		ret = -ENOMEM;
-		goto probe_err;
-	}
-
-	ret = fpga_mgr_register(mgr);
-	if (ret) {
+	mgr = fpga_mgr_register(dev, "Stratix10 SOC FPGA Manager",
+				&s10_ops, priv);
+	if (IS_ERR(mgr)) {
 		dev_err(dev, "unable to register FPGA manager\n");
-		fpga_mgr_free(mgr);
+		ret = PTR_ERR(mgr);
 		goto probe_err;
 	}
 
@@ -448,7 +441,6 @@ static int s10_remove(struct platform_device *pdev)
 	struct s10_priv *priv = mgr->priv;
 
 	fpga_mgr_unregister(mgr);
-	fpga_mgr_free(mgr);
 	stratix10_svc_free_channel(priv->chan);
 
 	return 0;
diff --git a/drivers/fpga/ts73xx-fpga.c b/drivers/fpga/ts73xx-fpga.c
index 167abb0b08d4..8e6e9c840d9d 100644
--- a/drivers/fpga/ts73xx-fpga.c
+++ b/drivers/fpga/ts73xx-fpga.c
@@ -116,12 +116,9 @@ static int ts73xx_fpga_probe(struct platform_device *pdev)
 	if (IS_ERR(priv->io_base))
 		return PTR_ERR(priv->io_base);
 
-	mgr = devm_fpga_mgr_create(kdev, "TS-73xx FPGA Manager",
-				   &ts73xx_fpga_ops, priv);
-	if (!mgr)
-		return -ENOMEM;
-
-	return devm_fpga_mgr_register(kdev, mgr);
+	mgr = devm_fpga_mgr_register(kdev, "TS-73xx FPGA Manager",
+				     &ts73xx_fpga_ops, priv);
+	return PTR_ERR_OR_ZERO(mgr);
 }
 
 static struct platform_driver ts73xx_fpga_driver = {
diff --git a/drivers/fpga/versal-fpga.c b/drivers/fpga/versal-fpga.c
index 5b0dda304bd2..e1601b3a345b 100644
--- a/drivers/fpga/versal-fpga.c
+++ b/drivers/fpga/versal-fpga.c
@@ -54,12 +54,9 @@ static int versal_fpga_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	mgr = devm_fpga_mgr_create(dev, "Xilinx Versal FPGA Manager",
-				   &versal_fpga_ops, NULL);
-	if (!mgr)
-		return -ENOMEM;
-
-	return devm_fpga_mgr_register(dev, mgr);
+	mgr = devm_fpga_mgr_register(dev, "Xilinx Versal FPGA Manager",
+				     &versal_fpga_ops, NULL);
+	return PTR_ERR_OR_ZERO(mgr);
 }
 
 static const struct of_device_id versal_fpga_of_match[] = {
diff --git a/drivers/fpga/xilinx-spi.c b/drivers/fpga/xilinx-spi.c
index b6bcf1d9233d..e1a227e7ff2a 100644
--- a/drivers/fpga/xilinx-spi.c
+++ b/drivers/fpga/xilinx-spi.c
@@ -247,13 +247,10 @@ static int xilinx_spi_probe(struct spi_device *spi)
 		return dev_err_probe(&spi->dev, PTR_ERR(conf->done),
 				     "Failed to get DONE gpio\n");
 
-	mgr = devm_fpga_mgr_create(&spi->dev,
-				   "Xilinx Slave Serial FPGA Manager",
-				   &xilinx_spi_ops, conf);
-	if (!mgr)
-		return -ENOMEM;
-
-	return devm_fpga_mgr_register(&spi->dev, mgr);
+	mgr = devm_fpga_mgr_register(&spi->dev,
+				     "Xilinx Slave Serial FPGA Manager",
+				     &xilinx_spi_ops, conf);
+	return PTR_ERR_OR_ZERO(mgr);
 }
 
 #ifdef CONFIG_OF
diff --git a/drivers/fpga/zynq-fpga.c b/drivers/fpga/zynq-fpga.c
index 9b75bd4f93d8..426aa34c6a0d 100644
--- a/drivers/fpga/zynq-fpga.c
+++ b/drivers/fpga/zynq-fpga.c
@@ -609,20 +609,16 @@ static int zynq_fpga_probe(struct platform_device *pdev)
 
 	clk_disable(priv->clk);
 
-	mgr = devm_fpga_mgr_create(dev, "Xilinx Zynq FPGA Manager",
-				   &zynq_fpga_ops, priv);
-	if (!mgr)
-		return -ENOMEM;
-
-	platform_set_drvdata(pdev, mgr);
-
-	err = fpga_mgr_register(mgr);
-	if (err) {
+	mgr = fpga_mgr_register(dev, "Xilinx Zynq FPGA Manager",
+				&zynq_fpga_ops, priv);
+	if (IS_ERR(mgr)) {
 		dev_err(dev, "unable to register FPGA manager\n");
 		clk_unprepare(priv->clk);
-		return err;
+		return PTR_ERR(mgr);
 	}
 
+	platform_set_drvdata(pdev, mgr);
+
 	return 0;
 }
 
diff --git a/drivers/fpga/zynqmp-fpga.c b/drivers/fpga/zynqmp-fpga.c
index 7d3d5650c322..c60f20949c47 100644
--- a/drivers/fpga/zynqmp-fpga.c
+++ b/drivers/fpga/zynqmp-fpga.c
@@ -95,12 +95,9 @@ static int zynqmp_fpga_probe(struct platform_device *pdev)
 
 	priv->dev = dev;
 
-	mgr = devm_fpga_mgr_create(dev, "Xilinx ZynqMP FPGA Manager",
-				   &zynqmp_fpga_ops, priv);
-	if (!mgr)
-		return -ENOMEM;
-
-	return devm_fpga_mgr_register(dev, mgr);
+	mgr = devm_fpga_mgr_register(dev, "Xilinx ZynqMP FPGA Manager",
+				     &zynqmp_fpga_ops, priv);
+	return PTR_ERR_OR_ZERO(mgr);
 }
 
 #ifdef CONFIG_OF
diff --git a/include/linux/fpga/fpga-mgr.h b/include/linux/fpga/fpga-mgr.h
index 474c1f506307..0f9468771bb9 100644
--- a/include/linux/fpga/fpga-mgr.h
+++ b/include/linux/fpga/fpga-mgr.h
@@ -105,6 +105,36 @@ struct fpga_image_info {
 #endif
 };
 
+/**
+ * struct fpga_compat_id - id for compatibility check
+ *
+ * @id_h: high 64bit of the compat_id
+ * @id_l: low 64bit of the compat_id
+ */
+struct fpga_compat_id {
+	u64 id_h;
+	u64 id_l;
+};
+
+/**
+ * struct fpga_manager_info - collection of parameters for an FPGA Manager
+ * @name: fpga manager name
+ * @compat_id: FPGA manager id for compatibility check.
+ * @mops: pointer to structure of fpga manager ops
+ * @priv: fpga manager private data
+ *
+ * fpga_manager_info contains parameters for the register_full function.
+ * These are separated into an info structure because they some are optional
+ * others could be added to in the future. The info structure facilitates
+ * maintaining a stable API.
+ */
+struct fpga_manager_info {
+	const char *name;
+	struct fpga_compat_id *compat_id;
+	const struct fpga_manager_ops *mops;
+	void *priv;
+};
+
 /**
  * struct fpga_manager_ops - ops for low level fpga manager drivers
  * @initial_header_size: Maximum number of bytes that should be passed into write_init
@@ -143,17 +173,6 @@ struct fpga_manager_ops {
 #define FPGA_MGR_STATUS_IP_PROTOCOL_ERR		BIT(3)
 #define FPGA_MGR_STATUS_FIFO_OVERFLOW_ERR	BIT(4)
 
-/**
- * struct fpga_compat_id - id for compatibility check
- *
- * @id_h: high 64bit of the compat_id
- * @id_l: low 64bit of the compat_id
- */
-struct fpga_compat_id {
-	u64 id_h;
-	u64 id_l;
-};
-
 /**
  * struct fpga_manager - fpga manager structure
  * @name: name of low level fpga manager
@@ -191,17 +210,18 @@ struct fpga_manager *fpga_mgr_get(struct device *dev);
 
 void fpga_mgr_put(struct fpga_manager *mgr);
 
-struct fpga_manager *fpga_mgr_create(struct device *dev, const char *name,
-				     const struct fpga_manager_ops *mops,
-				     void *priv);
-void fpga_mgr_free(struct fpga_manager *mgr);
-int fpga_mgr_register(struct fpga_manager *mgr);
-void fpga_mgr_unregister(struct fpga_manager *mgr);
+struct fpga_manager *
+fpga_mgr_register_full(struct device *parent, const struct fpga_manager_info *info);
 
-int devm_fpga_mgr_register(struct device *dev, struct fpga_manager *mgr);
+struct fpga_manager *
+fpga_mgr_register(struct device *parent, const char *name,
+		  const struct fpga_manager_ops *mops, void *priv);
+void fpga_mgr_unregister(struct fpga_manager *mgr);
 
-struct fpga_manager *devm_fpga_mgr_create(struct device *dev, const char *name,
-					  const struct fpga_manager_ops *mops,
-					  void *priv);
+struct fpga_manager *
+devm_fpga_mgr_register_full(struct device *parent, const struct fpga_manager_info *info);
+struct fpga_manager *
+devm_fpga_mgr_register(struct device *parent, const char *name,
+		       const struct fpga_manager_ops *mops, void *priv);
 
 #endif /*_LINUX_FPGA_MGR_H */
-- 
2.25.1

