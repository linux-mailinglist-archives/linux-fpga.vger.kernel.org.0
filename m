Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E3173B3832
	for <lists+linux-fpga@lfdr.de>; Thu, 24 Jun 2021 22:54:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232456AbhFXU4y (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 24 Jun 2021 16:56:54 -0400
Received: from mga14.intel.com ([192.55.52.115]:13250 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232029AbhFXU4y (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 24 Jun 2021 16:56:54 -0400
IronPort-SDR: 83s5D1H8cVIJzfj9vqAfFSIaVxIK1Nd8vmjyPXRZAncvtrEd0LRCXoRp7duA+HDCbHFbB6LZNC
 32pJ5Zb42eQQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10025"; a="207376318"
X-IronPort-AV: E=Sophos;i="5.83,297,1616482800"; 
   d="scan'208";a="207376318"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2021 13:54:34 -0700
IronPort-SDR: ENQ9QW6LHn1n8Rf9mlWvHbukbUIVynQOa4xYC41lF0CK8D4qkEyTnA4Kuqv7LdUOzskiG6FkuJ
 a7KE2cuZKg+w==
X-IronPort-AV: E=Sophos;i="5.83,297,1616482800"; 
   d="scan'208";a="624306691"
Received: from rhweight-mobl2.amr.corp.intel.com (HELO rhweight-mobl2.ra.intel.com) ([10.209.11.192])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2021 13:54:33 -0700
From:   Russ Weight <russell.h.weight@intel.com>
To:     mdf@kernel.org, linux-fpga@vger.kernel.org
Cc:     trix@redhat.com, lgoncalv@redhat.com, yilun.xu@intel.com,
        hao.wu@intel.com, matthew.gerlach@intel.com,
        richard.gong@intel.com, Russ Weight <russell.h.weight@intel.com>
Subject: [PATCH v8 1/3] fpga: mgr: Use standard dev_release for class driver
Date:   Thu, 24 Jun 2021 13:53:53 -0700
Message-Id: <20210624205355.517687-2-russell.h.weight@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210624205355.517687-1-russell.h.weight@intel.com>
References: <20210624205355.517687-1-russell.h.weight@intel.com>
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
register() or register_simple() function.

The register() function accepts an info data structure to provide
flexibility in passing optional parameters. The register_simple()
function supports the current parameter list for users that don't
require the use of optional parameters.

The devm_fpga_mgr_register() function is retained, and the
devm_fpga_mgr_register_simple() function is added.

Signed-off-by: Russ Weight <russell.h.weight@intel.com>
Reviewed-by: Xu Yilun <yilun.xu@intel.com>
---
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
  - Update function defintions/prototypes to apply const to the new info
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
 Documentation/driver-api/fpga/fpga-mgr.rst |  39 ++--
 drivers/fpga/altera-cvp.c                  |  12 +-
 drivers/fpga/altera-pr-ip-core.c           |   8 +-
 drivers/fpga/altera-ps-spi.c               |   9 +-
 drivers/fpga/dfl-fme-mgr.c                 |  22 +--
 drivers/fpga/fpga-mgr.c                    | 214 +++++++++------------
 drivers/fpga/ice40-spi.c                   |   9 +-
 drivers/fpga/machxo2-spi.c                 |  10 +-
 drivers/fpga/socfpga-a10.c                 |  16 +-
 drivers/fpga/socfpga.c                     |   9 +-
 drivers/fpga/stratix10-soc.c               |  16 +-
 drivers/fpga/ts73xx-fpga.c                 |   9 +-
 drivers/fpga/xilinx-spi.c                  |  11 +-
 drivers/fpga/zynq-fpga.c                   |  16 +-
 drivers/fpga/zynqmp-fpga.c                 |   9 +-
 include/linux/fpga/fpga-mgr.h              |  62 ++++--
 16 files changed, 204 insertions(+), 267 deletions(-)

diff --git a/Documentation/driver-api/fpga/fpga-mgr.rst b/Documentation/driver-api/fpga/fpga-mgr.rst
index 4d926b452cb3..fbb7f07cae9f 100644
--- a/Documentation/driver-api/fpga/fpga-mgr.rst
+++ b/Documentation/driver-api/fpga/fpga-mgr.rst
@@ -24,7 +24,8 @@ How to support a new FPGA device
 --------------------------------
 
 To add another FPGA manager, write a driver that implements a set of ops.  The
-probe function calls fpga_mgr_register(), such as::
+probe function calls devm_fpga_mgr_register() or
+devm_fpga_mgr_register_simple(), such as::
 
 	static const struct fpga_manager_ops socfpga_fpga_ops = {
 		.write_init = socfpga_fpga_ops_configure_init,
@@ -49,23 +50,9 @@ probe function calls fpga_mgr_register(), such as::
 		 * them in priv
 		 */
 
-		mgr = devm_fpga_mgr_create(dev, "Altera SOCFPGA FPGA Manager",
-					   &socfpga_fpga_ops, priv);
-		if (!mgr)
-			return -ENOMEM;
-
-		platform_set_drvdata(pdev, mgr);
-
-		return fpga_mgr_register(mgr);
-	}
-
-	static int socfpga_fpga_remove(struct platform_device *pdev)
-	{
-		struct fpga_manager *mgr = platform_get_drvdata(pdev);
-
-		fpga_mgr_unregister(mgr);
-
-		return 0;
+		mgr = devm_fpga_mgr_register_simple(dev, "Altera SOCFPGA FPGA Manager",
+						    &socfpga_fpga_ops, priv);
+		return PTR_ERR_OR_ZERO(mgr);
 	}
 
 
@@ -104,8 +91,10 @@ API for implementing a new FPGA Manager driver
 * ``fpga_mgr_states`` -  Values for :c:expr:`fpga_manager->state`.
 * struct fpga_manager -  the FPGA manager struct
 * struct fpga_manager_ops -  Low level FPGA manager driver ops
-* devm_fpga_mgr_create() -  Allocate and init a manager struct
-* fpga_mgr_register() -  Register an FPGA manager
+* fpga_mgr_register() -  Create and register an FPGA manager
+* fpga_mgr_register_simple() -  Create and register an FPGA manager
+* devm_fpga_mgr_register() -  Create and register an FPGA manager
+* devm_fpga_mgr_register_simple() -  Create and register an FPGA manager
 * fpga_mgr_unregister() -  Unregister an FPGA manager
 
 .. kernel-doc:: include/linux/fpga/fpga-mgr.h
@@ -118,10 +107,16 @@ API for implementing a new FPGA Manager driver
    :functions: fpga_manager_ops
 
 .. kernel-doc:: drivers/fpga/fpga-mgr.c
-   :functions: devm_fpga_mgr_create
+   :functions: fpga_mgr_register
 
 .. kernel-doc:: drivers/fpga/fpga-mgr.c
-   :functions: fpga_mgr_register
+   :functions: fpga_mgr_register_simple
+
+.. kernel-doc:: drivers/fpga/fpga-mgr.c
+   :functions: devm_fpga_mgr_register
+
+.. kernel-doc:: drivers/fpga/fpga-mgr.c
+   :functions: devm_fpga_mgr_register_simple
 
 .. kernel-doc:: drivers/fpga/fpga-mgr.c
    :functions: fpga_mgr_unregister
diff --git a/drivers/fpga/altera-cvp.c b/drivers/fpga/altera-cvp.c
index ccf4546eff29..ddf2ffe3f138 100644
--- a/drivers/fpga/altera-cvp.c
+++ b/drivers/fpga/altera-cvp.c
@@ -652,19 +652,15 @@ static int altera_cvp_probe(struct pci_dev *pdev,
 	snprintf(conf->mgr_name, sizeof(conf->mgr_name), "%s @%s",
 		 ALTERA_CVP_MGR_NAME, pci_name(pdev));
 
-	mgr = devm_fpga_mgr_create(&pdev->dev, conf->mgr_name,
-				   &altera_cvp_ops, conf);
-	if (!mgr) {
-		ret = -ENOMEM;
+	mgr = fpga_mgr_register_simple(&pdev->dev, conf->mgr_name,
+				       &altera_cvp_ops, conf);
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
index dfdf21ed34c4..e0baf3392b67 100644
--- a/drivers/fpga/altera-pr-ip-core.c
+++ b/drivers/fpga/altera-pr-ip-core.c
@@ -191,11 +191,9 @@ int alt_pr_register(struct device *dev, void __iomem *reg_base)
 		(val & ALT_PR_CSR_STATUS_MSK) >> ALT_PR_CSR_STATUS_SFT,
 		(int)(val & ALT_PR_CSR_PR_START));
 
-	mgr = devm_fpga_mgr_create(dev, dev_name(dev), &alt_pr_ops, priv);
-	if (!mgr)
-		return -ENOMEM;
-
-	return devm_fpga_mgr_register(dev, mgr);
+	mgr = devm_fpga_mgr_register_simple(dev, dev_name(dev),
+					    &alt_pr_ops, priv);
+	return PTR_ERR_OR_ZERO(mgr);
 }
 EXPORT_SYMBOL_GPL(alt_pr_register);
 
diff --git a/drivers/fpga/altera-ps-spi.c b/drivers/fpga/altera-ps-spi.c
index 23bfd4d1ad0f..f544de2a9f6b 100644
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
+	mgr = devm_fpga_mgr_register_simple(&spi->dev, conf->mgr_name,
+					    &altera_ps_ops, conf);
+	return PTR_ERR_OR_ZERO(mgr);
 }
 
 static const struct spi_device_id altera_ps_spi_ids[] = {
diff --git a/drivers/fpga/dfl-fme-mgr.c b/drivers/fpga/dfl-fme-mgr.c
index d5861d13b306..20b1cf3d957f 100644
--- a/drivers/fpga/dfl-fme-mgr.c
+++ b/drivers/fpga/dfl-fme-mgr.c
@@ -282,7 +282,7 @@ static void fme_mgr_get_compat_id(void __iomem *fme_pr,
 static int fme_mgr_probe(struct platform_device *pdev)
 {
 	struct dfl_fme_mgr_pdata *pdata = dev_get_platdata(&pdev->dev);
-	struct fpga_compat_id *compat_id;
+	struct fpga_manager_info info = { 0 };
 	struct device *dev = &pdev->dev;
 	struct fme_mgr_priv *priv;
 	struct fpga_manager *mgr;
@@ -302,20 +302,16 @@ static int fme_mgr_probe(struct platform_device *pdev)
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
+	mgr = devm_fpga_mgr_register(dev, &info);
+	return PTR_ERR_OR_ZERO(mgr);
 }
 
 static struct platform_driver fme_mgr_driver = {
diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
index ecb4c3c795fa..6bd65a1b84fb 100644
--- a/drivers/fpga/fpga-mgr.c
+++ b/drivers/fpga/fpga-mgr.c
@@ -550,21 +550,19 @@ void fpga_mgr_unlock(struct fpga_manager *mgr)
 EXPORT_SYMBOL_GPL(fpga_mgr_unlock);
 
 /**
- * fpga_mgr_create - create and initialize an FPGA manager struct
+ * fpga_mgr_register - create and register an FPGA Manager device
  * @parent:	fpga manager device from pdev
- * @name:	fpga manager name
- * @mops:	pointer to structure of fpga manager ops
- * @priv:	fpga manager private data
+ * @info:	parameters for fpga manager
  *
- * The caller of this function is responsible for freeing the struct with
- * fpga_mgr_free().  Using devm_fpga_mgr_create() instead is recommended.
+ * The caller of this function is responsible for calling fpga_mgr_unregister().
+ * Using devm_fpga_mgr_register() instead is recommended.
  *
- * Return: pointer to struct fpga_manager or NULL
+ * Return: pointer to struct fpga_manager pointer or ERR_PTR()
  */
-struct fpga_manager *fpga_mgr_create(struct device *parent, const char *name,
-				     const struct fpga_manager_ops *mops,
-				     void *priv)
+struct fpga_manager *
+fpga_mgr_register(struct device *parent, const struct fpga_manager_info *info)
 {
+	const struct fpga_manager_ops *mops = info->mops;
 	struct fpga_manager *mgr;
 	int id, ret;
 
@@ -572,29 +570,31 @@ struct fpga_manager *fpga_mgr_create(struct device *parent, const char *name,
 	    !mops->write_init || (!mops->write && !mops->write_sg) ||
 	    (mops->write && mops->write_sg)) {
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
@@ -605,6 +605,19 @@ struct fpga_manager *fpga_mgr_create(struct device *parent, const char *name,
 	if (ret)
 		goto error_device;
 
+	/*
+	 * Initialize framework state by requesting low level driver read state
+	 * from device.  FPGA may be in reset mode or may have been programmed
+	 * by bootloader or EEPROM.
+	 */
+	mgr->state = mgr->mops->state(mgr);
+
+	ret = device_register(&mgr->dev);
+	if (ret) {
+		put_device(&mgr->dev);
+		return ERR_PTR(ret);
+	}
+
 	return mgr;
 
 error_device:
@@ -612,98 +625,38 @@ struct fpga_manager *fpga_mgr_create(struct device *parent, const char *name,
 error_kfree:
 	kfree(mgr);
 
-	return NULL;
-}
-EXPORT_SYMBOL_GPL(fpga_mgr_create);
-
-/**
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
+	return ERR_PTR(ret);
 }
+EXPORT_SYMBOL_GPL(fpga_mgr_register);
 
 /**
- * devm_fpga_mgr_create - create and initialize a managed FPGA manager struct
+ * fpga_mgr_register_simple - create and register an FPGA Manager device
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
+ * Using devm_fpga_mgr_register_simple() instead is recommended. This simple
+ * version of the register function should be sufficient for most users. The
+ * fpga_mgr_register() function is available for users that need to pass
+ * additional, optional parameters.
  *
- * Return: pointer to struct fpga_manager or NULL
+ * Return: pointer to struct fpga_manager pointer or ERR_PTR()
  */
-struct fpga_manager *devm_fpga_mgr_create(struct device *parent, const char *name,
-					  const struct fpga_manager_ops *mops,
-					  void *priv)
+struct fpga_manager *
+fpga_mgr_register_simple(struct device *parent, const char *name,
+			 const struct fpga_manager_ops *mops, void *priv)
 {
-	struct fpga_mgr_devres *dr;
+	struct fpga_manager_info info = { 0 };
 
-	dr = devres_alloc(devm_fpga_mgr_release, sizeof(*dr), GFP_KERNEL);
-	if (!dr)
-		return NULL;
-
-	dr->mgr = fpga_mgr_create(parent, name, mops, priv);
-	if (!dr->mgr) {
-		devres_free(dr);
-		return NULL;
-	}
-
-	devres_add(parent, dr);
+	info.name = name;
+	info.mops = mops;
+	info.priv = priv;
 
-	return dr->mgr;
+	return fpga_mgr_register(parent, &info);
 }
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
-	mgr->state = mgr->mops->state(mgr);
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
-}
-EXPORT_SYMBOL_GPL(fpga_mgr_register);
+EXPORT_SYMBOL_GPL(fpga_mgr_register_simple);
 
 /**
  * fpga_mgr_unregister - unregister an FPGA manager
@@ -726,14 +679,6 @@ void fpga_mgr_unregister(struct fpga_manager *mgr)
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
@@ -743,44 +688,67 @@ static void devm_fpga_mgr_unregister(struct device *dev, void *res)
 
 /**
  * devm_fpga_mgr_register - resource managed variant of fpga_mgr_register()
- * @dev: managing device for this FPGA manager
- * @mgr: fpga manager struct
+ * @parent:	fpga manager device from pdev
+ * @info:	parameters for fpga manager
  *
  * This is the devres variant of fpga_mgr_register() for which the unregister
  * function will be called automatically when the managing device is detached.
  */
-int devm_fpga_mgr_register(struct device *dev, struct fpga_manager *mgr)
+struct fpga_manager *
+devm_fpga_mgr_register(struct device *parent, const struct fpga_manager_info *info)
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
+	mgr = fpga_mgr_register(parent, info);
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
 }
 EXPORT_SYMBOL_GPL(devm_fpga_mgr_register);
 
+/**
+ * devm_fpga_mgr_register_simple - resource managed variant of
+ *				   fpga_mgr_register_simple()
+ * @parent:	fpga manager device from pdev
+ * @name:	fpga manager name
+ * @mops:	pointer to structure of fpga manager ops
+ * @priv:	fpga manager private data
+ *
+ * This is the devres variant of fpga_mgr_register_simple() for which the
+ * unregister function will be called automatically when the managing
+ * device is detached.
+ */
+struct fpga_manager *
+devm_fpga_mgr_register_simple(struct device *parent, const char *name,
+			      const struct fpga_manager_ops *mops, void *priv)
+{
+	struct fpga_manager_info info = { 0 };
+
+	info.name = name;
+	info.mops = mops;
+	info.priv = priv;
+
+	return devm_fpga_mgr_register(parent, &info);
+}
+EXPORT_SYMBOL_GPL(devm_fpga_mgr_register_simple);
+
 static void fpga_mgr_dev_release(struct device *dev)
 {
+	struct fpga_manager *mgr = to_fpga_manager(dev);
+
+	ida_simple_remove(&fpga_mgr_ida, mgr->dev.id);
+	kfree(mgr);
 }
 
 static int __init fpga_mgr_class_init(void)
diff --git a/drivers/fpga/ice40-spi.c b/drivers/fpga/ice40-spi.c
index 69dec5af23c3..448eb6f4e509 100644
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
+	mgr = devm_fpga_mgr_register_simple(dev, "Lattice iCE40 FPGA Manager",
+					    &ice40_fpga_ops, priv);
+	return PTR_ERR_OR_ZERO(mgr);
 }
 
 static const struct of_device_id ice40_fpga_of_match[] = {
diff --git a/drivers/fpga/machxo2-spi.c b/drivers/fpga/machxo2-spi.c
index 114a64d2b7a4..77be11155402 100644
--- a/drivers/fpga/machxo2-spi.c
+++ b/drivers/fpga/machxo2-spi.c
@@ -366,12 +366,10 @@ static int machxo2_spi_probe(struct spi_device *spi)
 		return -EINVAL;
 	}
 
-	mgr = devm_fpga_mgr_create(dev, "Lattice MachXO2 SPI FPGA Manager",
-				   &machxo2_ops, spi);
-	if (!mgr)
-		return -ENOMEM;
-
-	return devm_fpga_mgr_register(dev, mgr);
+	mgr = devm_fpga_mgr_register_simple(dev,
+					    "Lattice MachXO2 SPI FPGA Manager",
+					    &machxo2_ops, spi);
+	return PTR_ERR_OR_ZERO(mgr);
 }
 
 static const struct of_device_id of_match[] = {
diff --git a/drivers/fpga/socfpga-a10.c b/drivers/fpga/socfpga-a10.c
index 573d88bdf730..5ffefaa3eb07 100644
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
+	mgr = fpga_mgr_register_simple(dev, "SoCFPGA Arria10 FPGA Manager",
+				       &socfpga_a10_fpga_mgr_ops, priv);
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
index 1f467173fc1f..9280db4364d4 100644
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
+	mgr = devm_fpga_mgr_register_simple(dev, "Altera SOCFPGA FPGA Manager",
+					    &socfpga_fpga_ops, priv);
+	return PTR_ERR_OR_ZERO(mgr);
 }
 
 #ifdef CONFIG_OF
diff --git a/drivers/fpga/stratix10-soc.c b/drivers/fpga/stratix10-soc.c
index a2cea500f7cc..fb84d88d4ce9 100644
--- a/drivers/fpga/stratix10-soc.c
+++ b/drivers/fpga/stratix10-soc.c
@@ -425,18 +425,11 @@ static int s10_probe(struct platform_device *pdev)
 
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
+	mgr = fpga_mgr_register_simple(dev, "Stratix10 SOC FPGA Manager",
+				       &s10_ops, priv);
+	if (IS_ERR(mgr)) {
 		dev_err(dev, "unable to register FPGA manager\n");
-		fpga_mgr_free(mgr);
+		ret = PTR_ERR(mgr);
 		goto probe_err;
 	}
 
@@ -454,7 +447,6 @@ static int s10_remove(struct platform_device *pdev)
 	struct s10_priv *priv = mgr->priv;
 
 	fpga_mgr_unregister(mgr);
-	fpga_mgr_free(mgr);
 	stratix10_svc_free_channel(priv->chan);
 
 	return 0;
diff --git a/drivers/fpga/ts73xx-fpga.c b/drivers/fpga/ts73xx-fpga.c
index 101f016c6ed8..009d5cfa1074 100644
--- a/drivers/fpga/ts73xx-fpga.c
+++ b/drivers/fpga/ts73xx-fpga.c
@@ -122,12 +122,9 @@ static int ts73xx_fpga_probe(struct platform_device *pdev)
 	if (IS_ERR(priv->io_base))
 		return PTR_ERR(priv->io_base);
 
-	mgr = devm_fpga_mgr_create(kdev, "TS-73xx FPGA Manager",
-				   &ts73xx_fpga_ops, priv);
-	if (!mgr)
-		return -ENOMEM;
-
-	return devm_fpga_mgr_register(kdev, mgr);
+	mgr = devm_fpga_mgr_register_simple(kdev, "TS-73xx FPGA Manager",
+					    &ts73xx_fpga_ops, priv);
+	return PTR_ERR_OR_ZERO(mgr);
 }
 
 static struct platform_driver ts73xx_fpga_driver = {
diff --git a/drivers/fpga/xilinx-spi.c b/drivers/fpga/xilinx-spi.c
index fee4d0abf6bf..6f568a757cf2 100644
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
+	mgr = devm_fpga_mgr_register_simple(&spi->dev,
+					    "Xilinx Slave Serial FPGA Manager",
+					    &xilinx_spi_ops, conf);
+	return PTR_ERR_OR_ZERO(mgr);
 }
 
 static const struct of_device_id xlnx_spi_of_match[] = {
diff --git a/drivers/fpga/zynq-fpga.c b/drivers/fpga/zynq-fpga.c
index 9b75bd4f93d8..a3de365aadc6 100644
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
+	mgr = fpga_mgr_register_simple(dev, "Xilinx Zynq FPGA Manager",
+				       &zynq_fpga_ops, priv);
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
index 125743c9797f..53a7b36f61e8 100644
--- a/drivers/fpga/zynqmp-fpga.c
+++ b/drivers/fpga/zynqmp-fpga.c
@@ -102,12 +102,9 @@ static int zynqmp_fpga_probe(struct platform_device *pdev)
 
 	priv->dev = dev;
 
-	mgr = devm_fpga_mgr_create(dev, "Xilinx ZynqMP FPGA Manager",
-				   &zynqmp_fpga_ops, priv);
-	if (!mgr)
-		return -ENOMEM;
-
-	return devm_fpga_mgr_register(dev, mgr);
+	mgr = devm_fpga_mgr_register_simple(dev, "Xilinx ZynqMP FPGA Manager",
+					    &zynqmp_fpga_ops, priv);
+	return PTR_ERR_OR_ZERO(mgr);
 }
 
 static const struct of_device_id zynqmp_fpga_of_match[] = {
diff --git a/include/linux/fpga/fpga-mgr.h b/include/linux/fpga/fpga-mgr.h
index 474c1f506307..9efe55be93bc 100644
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
+ * fpga_manager_info contains parameters for the register function. These
+ * are separated into an info structure because they some are optional
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
+fpga_mgr_register(struct device *parent, const struct fpga_manager_info *info);
 
-int devm_fpga_mgr_register(struct device *dev, struct fpga_manager *mgr);
+struct fpga_manager *
+fpga_mgr_register_simple(struct device *parent, const char *name,
+			 const struct fpga_manager_ops *mops, void *priv);
+void fpga_mgr_unregister(struct fpga_manager *mgr);
 
-struct fpga_manager *devm_fpga_mgr_create(struct device *dev, const char *name,
-					  const struct fpga_manager_ops *mops,
-					  void *priv);
+struct fpga_manager *
+devm_fpga_mgr_register(struct device *parent, const struct fpga_manager_info *info);
+struct fpga_manager *
+devm_fpga_mgr_register_simple(struct device *parent, const char *name,
+			      const struct fpga_manager_ops *mops, void *priv);
 
 #endif /*_LINUX_FPGA_MGR_H */
-- 
2.25.1

