Return-Path: <linux-fpga+bounces-721-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F44F97CE8B
	for <lists+linux-fpga@lfdr.de>; Thu, 19 Sep 2024 22:37:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71FD3B22D47
	for <lists+linux-fpga@lfdr.de>; Thu, 19 Sep 2024 20:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 891B1175D50;
	Thu, 19 Sep 2024 20:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kww4dJGh"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D8A616EBEC;
	Thu, 19 Sep 2024 20:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726778113; cv=none; b=ui2qEjqv+91NtqB4O7PMuPVYat0KIHjFAR530yuwtzYzDjeOs0Rgo/wtxjdguQ90f4EuePuRkeUxH2wznXu/G8O0fxiV04UUlpwDIJ/HRiNSc5+D2/UFp8DDQxWiGki8LvvNjygXArVM3o/CbmiDetW5WE9HVyfKR80huXyYhms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726778113; c=relaxed/simple;
	bh=1GIZqhXTyqPYBC1/f2REkzZ1Oa0PTQHR/ugy3WEUjsA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qoj8h5eEom6TlVzmfpd+hw4fffVKVEXJFQRSTcMUwPVwQVYqIVYdbHRy/tS314ACKD23oU5KIlzKJ3NcXnWu7goBAnPQ0SqRKURiaWA5HA0uVxAeYaXWVxSxDRckCIaRa55e6M9TPw0+bebq2Pji++XVhys/qCG+6uwX1qiY56Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kww4dJGh; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726778111; x=1758314111;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1GIZqhXTyqPYBC1/f2REkzZ1Oa0PTQHR/ugy3WEUjsA=;
  b=kww4dJGh9MWUEvESMB4iHjiQ5+rnzxb+//5kx91j47jhUpt8O3jqmDG4
   iVn7RZHyTTwDmcZ3GN6jAHQAt6msrirw9b1xZZTxX2KYUMUKwxnowg8jz
   BxSzOnUWb+cTr+m4YtAbO90mqdMliVYC46u03g6gOL7Bq01qkhn2UV9kb
   jZNc2pzwaTmQQFXPFrR0tzU+82ERQK67zDVnfmqKqmj8nViqnWpEncyS5
   qfOpne2VySdMjds1sEbY/iM8QpnOqjQ4BcaB/QSP6PZXBMpA6XWz04xej
   8KND4+Ag5QCcRobGOxv4b8+zLSyZBNToZl9kqdKs7L95docTJnb5hZMz2
   g==;
X-CSE-ConnectionGUID: befihsi4SaWrYBcC3cFP1w==
X-CSE-MsgGUID: E2cgqEfoTyKvWC6ga2v9pg==
X-IronPort-AV: E=McAfee;i="6700,10204,11200"; a="25912972"
X-IronPort-AV: E=Sophos;i="6.10,242,1719903600"; 
   d="scan'208";a="25912972"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2024 13:35:07 -0700
X-CSE-ConnectionGUID: Z0lRxfkoTvyRBxhID7AWhw==
X-CSE-MsgGUID: SIEmp8lGTO2XPqCPuotdsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,242,1719903600"; 
   d="scan'208";a="93338349"
Received: from sj-4150-psse-sw-opae-dev3.sj.altera.com ([10.244.138.109])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2024 13:35:06 -0700
From: Peter Colberg <peter.colberg@intel.com>
To: Wu Hao <hao.wu@intel.com>,
	Tom Rix <trix@redhat.com>,
	Moritz Fischer <mdf@kernel.org>,
	Xu Yilun <yilun.xu@intel.com>,
	linux-fpga@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Russ Weight <russ.weight@linux.dev>,
	Marco Pagani <marpagan@redhat.com>,
	Matthew Gerlach <matthew.gerlach@linux.intel.com>,
	Russ Weight <russell.h.weight@intel.com>,
	Peter Colberg <peter.colberg@intel.com>
Subject: [PATCH v3 9/9] fpga: dfl: fix kernel warning on port release/assign for SRIOV
Date: Thu, 19 Sep 2024 16:34:30 -0400
Message-ID: <20240919203430.1278067-10-peter.colberg@intel.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20240919203430.1278067-1-peter.colberg@intel.com>
References: <20240919203430.1278067-1-peter.colberg@intel.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Xu Yilun <yilun.xu@intel.com>

With the Intel FPGA PAC D5005, DFL ports are registered as platform
devices in PF mode. The port device must be removed from the host when
the user wants to configure the port as a VF for use by a user-space
driver, e.g., for pass-through to a virtual machine. The FME device
ioctls DFL_FPGA_FME_PORT_RELEASE/ASSIGN are assigned for this purpose.

In the previous implementation, the port platform device is not
completely destroyed on port release: it is removed from the system by
platform_device_del(), but the platform device instance is retained.
When DFL_FPGA_FME_PORT_ASSIGN is called, the platform device is added
back with platform_device_add(), which conflicts with this comment of
device_add(): "Do not call this routine more than once for any device
structure", and would previously cause a kernel warning at runtime.

This patch completely unregisters the port platform device on release
and registers a new device on assign. But the main work is to remove
the dependency on struct dfl_feature_platform_data for many internal DFL
APIs. This structure holds many DFL enumeration infos for feature
devices. Many DFL APIs are expected to work with these infos even when
the port platform device is unregistered. But after this change, the
platform_data will be freed on port release. Hence this patch introduces
a new structure dfl_feature_dev_data, which acts similarly to the
previous dfl_feature_platform_data. dfl_feature_platform_data then only
needs a pointer to dfl_feature_dev_data to query DFL enumeration infos.

Signed-off-by: Xu Yilun <yilun.xu@intel.com>
Signed-off-by: Russ Weight <russell.h.weight@intel.com>
Signed-off-by: Peter Colberg <peter.colberg@intel.com>
Reviewed-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
---
 drivers/fpga/dfl-fme-br.c |   2 -
 drivers/fpga/dfl.c        | 207 ++++++++++++++++++--------------------
 drivers/fpga/dfl.h        |  57 +++++++----
 3 files changed, 133 insertions(+), 133 deletions(-)

diff --git a/drivers/fpga/dfl-fme-br.c b/drivers/fpga/dfl-fme-br.c
index 5c60a38ec76c..a298a041877b 100644
--- a/drivers/fpga/dfl-fme-br.c
+++ b/drivers/fpga/dfl-fme-br.c
@@ -85,8 +85,6 @@ static void fme_br_remove(struct platform_device *pdev)
 
 	fpga_bridge_unregister(br);
 
-	if (priv->port_fdata)
-		put_device(&priv->port_fdata->dev->dev);
 	if (priv->port_ops)
 		dfl_fpga_port_ops_put(priv->port_ops);
 }
diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
index 52f58d029ca4..a77d7692b170 100644
--- a/drivers/fpga/dfl.c
+++ b/drivers/fpga/dfl.c
@@ -160,7 +160,7 @@ struct dfl_fpga_port_ops *dfl_fpga_port_ops_get(struct dfl_feature_dev_data *fda
 
 	list_for_each_entry(ops, &dfl_port_ops_list, node) {
 		/* match port_ops using the name of platform device */
-		if (!strcmp(fdata->dev->name, ops->name)) {
+		if (!strcmp(fdata->pdev_name, ops->name)) {
 			if (!try_module_get(ops->owner))
 				ops = NULL;
 			goto done;
@@ -681,7 +681,6 @@ EXPORT_SYMBOL_GPL(dfl_fpga_dev_ops_unregister);
  * @nr_irqs: number of irqs for all feature devices.
  * @irq_table: Linux IRQ numbers for all irqs, indexed by local irq index of
  *	       this device.
- * @feature_dev: current feature device.
  * @type: the current FIU type.
  * @ioaddr: header register region address of current FIU in enumeration.
  * @start: register resource start of current FIU.
@@ -695,7 +694,6 @@ struct build_feature_devs_info {
 	unsigned int nr_irqs;
 	int *irq_table;
 
-	struct platform_device *feature_dev;
 	enum dfl_id_type type;
 	void __iomem *ioaddr;
 	resource_size_t start;
@@ -736,7 +734,6 @@ static void dfl_fpga_cdev_add_port_data(struct dfl_fpga_cdev *cdev,
 {
 	mutex_lock(&cdev->lock);
 	list_add(&fdata->node, &cdev->port_dev_list);
-	get_device(&fdata->dev->dev);
 	mutex_unlock(&cdev->lock);
 }
 
@@ -744,7 +741,6 @@ static struct dfl_feature_dev_data *
 binfo_create_feature_dev_data(struct build_feature_devs_info *binfo)
 {
 	enum dfl_id_type type = binfo->type;
-	struct platform_device *fdev = binfo->feature_dev;
 	struct dfl_feature_info *finfo, *p;
 	struct dfl_feature_dev_data *fdata;
 	int ret, index = 0, res_idx = 0;
@@ -752,18 +748,27 @@ binfo_create_feature_dev_data(struct build_feature_devs_info *binfo)
 	if (WARN_ON_ONCE(type >= DFL_ID_MAX))
 		return ERR_PTR(-EINVAL);
 
-	/*
-	 * we do not need to care for the memory which is associated with
-	 * the platform device. After calling platform_device_unregister(),
-	 * it will be automatically freed by device's release() callback,
-	 * platform_device_release().
-	 */
-	fdata = kzalloc(struct_size(fdata, features, binfo->feature_num), GFP_KERNEL);
+	fdata = devm_kzalloc(binfo->dev, sizeof(*fdata), GFP_KERNEL);
 	if (!fdata)
 		return ERR_PTR(-ENOMEM);
 
-	fdata->dev = fdev;
+	fdata->features = devm_kcalloc(binfo->dev, binfo->feature_num,
+				       sizeof(*fdata->features), GFP_KERNEL);
+	if (!fdata->features)
+		return ERR_PTR(-ENOMEM);
+
+	fdata->resources = devm_kcalloc(binfo->dev, binfo->feature_num,
+					sizeof(*fdata->resources), GFP_KERNEL);
+	if (!fdata->resources)
+		return ERR_PTR(-ENOMEM);
+
 	fdata->type = type;
+
+	fdata->pdev_id = dfl_id_alloc(type, binfo->dev);
+	if (fdata->pdev_id < 0)
+		return ERR_PTR(fdata->pdev_id);
+
+	fdata->pdev_name = dfl_devs[type].name;
 	fdata->num = binfo->feature_num;
 	fdata->dfl_cdev = binfo->cdev;
 	fdata->id = FEATURE_DEV_ID_UNUSED;
@@ -779,15 +784,6 @@ binfo_create_feature_dev_data(struct build_feature_devs_info *binfo)
 	 */
 	WARN_ON(fdata->disable_count);
 
-	fdev->dev.platform_data = fdata;
-
-	/* each sub feature has one MMIO resource */
-	fdev->num_resources = binfo->feature_num;
-	fdev->resource = kcalloc(binfo->feature_num, sizeof(*fdev->resource),
-				 GFP_KERNEL);
-	if (!fdev->resource)
-		return ERR_PTR(-ENOMEM);
-
 	/* fill features and resource information for feature dev */
 	list_for_each_entry_safe(finfo, p, &binfo->sub_features, node) {
 		struct dfl_feature *feature = &fdata->features[index++];
@@ -795,7 +791,6 @@ binfo_create_feature_dev_data(struct build_feature_devs_info *binfo)
 		unsigned int i;
 
 		/* save resource information for each feature */
-		feature->dev = fdev;
 		feature->id = finfo->fid;
 		feature->revision = finfo->revision;
 		feature->dfh_version = finfo->dfh_version;
@@ -804,8 +799,10 @@ binfo_create_feature_dev_data(struct build_feature_devs_info *binfo)
 			feature->params = devm_kmemdup(binfo->dev,
 						       finfo->params, finfo->param_size,
 						       GFP_KERNEL);
-			if (!feature->params)
-				return ERR_PTR(-ENOMEM);
+			if (!feature->params) {
+				ret = -ENOMEM;
+				goto err_free_id;
+			}
 
 			feature->param_size = finfo->param_size;
 		}
@@ -823,19 +820,20 @@ binfo_create_feature_dev_data(struct build_feature_devs_info *binfo)
 						      &finfo->mmio_res);
 			if (IS_ERR(feature->ioaddr)) {
 				ret = PTR_ERR(feature->ioaddr);
-				return ERR_PTR(ret);
+				goto err_free_id;
 			}
 		} else {
 			feature->resource_index = res_idx;
-			fdev->resource[res_idx++] = finfo->mmio_res;
+			fdata->resources[res_idx++] = finfo->mmio_res;
 		}
 
 		if (finfo->nr_irqs) {
 			ctx = devm_kcalloc(binfo->dev, finfo->nr_irqs,
 					   sizeof(*ctx), GFP_KERNEL);
-			if (!ctx)
-				return ERR_PTR(-ENOMEM);
-
+			if (!ctx) {
+				ret = -ENOMEM;
+				goto err_free_id;
+			}
 			for (i = 0; i < finfo->nr_irqs; i++)
 				ctx[i].irq =
 					binfo->irq_table[finfo->irq_base + i];
@@ -848,36 +846,67 @@ binfo_create_feature_dev_data(struct build_feature_devs_info *binfo)
 		kfree(finfo);
 	}
 
+	fdata->resource_num = res_idx;
+
 	return fdata;
+
+err_free_id:
+	dfl_id_free(type, fdata->pdev_id);
+
+	return ERR_PTR(ret);
 }
 
-static int
-build_info_create_dev(struct build_feature_devs_info *binfo)
+/*
+ * register current feature device, it is called when we need to switch to
+ * another feature parsing or we have parsed all features on given device
+ * feature list.
+ */
+static int feature_dev_register(struct dfl_feature_dev_data *fdata)
 {
-	enum dfl_id_type type = binfo->type;
+	struct dfl_feature_platform_data pdata = {};
 	struct platform_device *fdev;
+	struct dfl_feature *feature;
+	int ret;
 
-	/*
-	 * we use -ENODEV as the initialization indicator which indicates
-	 * whether the id need to be reclaimed
-	 */
-	fdev = platform_device_alloc(dfl_devs[type].name, -ENODEV);
+	fdev = platform_device_alloc(fdata->pdev_name, fdata->pdev_id);
 	if (!fdev)
 		return -ENOMEM;
 
-	binfo->feature_dev = fdev;
-	binfo->feature_num = 0;
+	fdata->dev = fdev;
 
-	INIT_LIST_HEAD(&binfo->sub_features);
+	fdev->dev.parent = &fdata->dfl_cdev->region->dev;
+	fdev->dev.devt = dfl_get_devt(dfl_devs[fdata->type].devt_type, fdev->id);
 
-	fdev->id = dfl_id_alloc(type, &fdev->dev);
-	if (fdev->id < 0)
-		return fdev->id;
+	dfl_fpga_dev_for_each_feature(fdata, feature)
+		feature->dev = fdev;
+
+	ret = platform_device_add_resources(fdev, fdata->resources,
+					    fdata->resource_num);
+	if (ret)
+		goto err_put_dev;
 
-	fdev->dev.parent = &binfo->cdev->region->dev;
-	fdev->dev.devt = dfl_get_devt(dfl_devs[type].devt_type, fdev->id);
+	pdata.fdata = fdata;
+	ret = platform_device_add_data(fdev, &pdata, sizeof(pdata));
+	if (ret)
+		goto err_put_dev;
+
+	ret = platform_device_add(fdev);
+	if (ret)
+		goto err_put_dev;
 
 	return 0;
+
+err_put_dev:
+	platform_device_put(fdev);
+	fdata->dev = NULL;
+
+	return ret;
+}
+
+static void feature_dev_unregister(struct dfl_feature_dev_data *fdata)
+{
+	platform_device_unregister(fdata->dev);
+	fdata->dev = NULL;
 }
 
 static int build_info_commit_dev(struct build_feature_devs_info *binfo)
@@ -889,23 +918,14 @@ static int build_info_commit_dev(struct build_feature_devs_info *binfo)
 	if (IS_ERR(fdata))
 		return PTR_ERR(fdata);
 
-	ret = platform_device_add(binfo->feature_dev);
+	ret = feature_dev_register(fdata);
 	if (ret)
 		return ret;
 
 	if (binfo->type == PORT_ID)
 		dfl_fpga_cdev_add_port_data(binfo->cdev, fdata);
 	else
-		binfo->cdev->fme_dev = get_device(&binfo->feature_dev->dev);
-
-	/*
-	 * reset it to avoid build_info_free() freeing their resource.
-	 *
-	 * The resource of successfully registered feature devices
-	 * will be freed by platform_device_unregister(). See the
-	 * comments in build_info_create_dev().
-	 */
-	binfo->feature_dev = NULL;
+		binfo->cdev->fme_dev = get_device(&fdata->dev->dev);
 
 	/* reset the binfo for next FIU */
 	binfo->type = DFL_ID_MAX;
@@ -917,21 +937,11 @@ static void build_info_free(struct build_feature_devs_info *binfo)
 {
 	struct dfl_feature_info *finfo, *p;
 
-	/*
-	 * it is a valid id, free it. See comments in
-	 * build_info_create_dev()
-	 */
-	if (binfo->feature_dev && binfo->feature_dev->id >= 0) {
-		dfl_id_free(binfo->type, binfo->feature_dev->id);
-
-		list_for_each_entry_safe(finfo, p, &binfo->sub_features, node) {
-			list_del(&finfo->node);
-			kfree(finfo);
-		}
+	list_for_each_entry_safe(finfo, p, &binfo->sub_features, node) {
+		list_del(&finfo->node);
+		kfree(finfo);
 	}
 
-	platform_device_put(binfo->feature_dev);
-
 	devm_kfree(binfo->dev, binfo);
 }
 
@@ -1226,8 +1236,7 @@ static int parse_feature_afu(struct build_feature_devs_info *binfo,
 	case PORT_ID:
 		return parse_feature_port_afu(binfo, ofst);
 	default:
-		dev_info(binfo->dev, "AFU belonging to FIU %s is not supported yet.\n",
-			 binfo->feature_dev->name);
+		dev_info(binfo->dev, "AFU belonging to FIU is not supported yet.\n");
 	}
 
 	return 0;
@@ -1295,11 +1304,8 @@ static int parse_feature_fiu(struct build_feature_devs_info *binfo,
 		return -EINVAL;
 
 	binfo->type = type;
-
-	/* create platform device for dfl feature dev */
-	ret = build_info_create_dev(binfo);
-	if (ret)
-		return ret;
+	binfo->feature_num = 0;
+	INIT_LIST_HEAD(&binfo->sub_features);
 
 	ret = create_feature_instance(binfo, 0, 0, 0);
 	if (ret)
@@ -1518,12 +1524,9 @@ EXPORT_SYMBOL_GPL(dfl_fpga_enum_info_add_irq);
 static int remove_feature_dev(struct device *dev, void *data)
 {
 	struct dfl_feature_dev_data *fdata = to_dfl_feature_dev_data(dev);
-	struct platform_device *pdev = to_platform_device(dev);
-	int id = pdev->id;
 
-	platform_device_unregister(pdev);
-
-	dfl_id_free(fdata->type, id);
+	feature_dev_unregister(fdata);
+	dfl_id_free(fdata->type, fdata->pdev_id);
 
 	return 0;
 }
@@ -1617,24 +1620,10 @@ EXPORT_SYMBOL_GPL(dfl_fpga_feature_devs_enumerate);
  */
 void dfl_fpga_feature_devs_remove(struct dfl_fpga_cdev *cdev)
 {
-	struct dfl_feature_platform_data *pdata, *ptmp;
-
 	mutex_lock(&cdev->lock);
 	if (cdev->fme_dev)
 		put_device(cdev->fme_dev);
 
-	list_for_each_entry_safe(pdata, ptmp, &cdev->port_dev_list, node) {
-		struct platform_device *port_dev = pdata->dev;
-
-		/* remove released ports */
-		if (!device_is_registered(&port_dev->dev)) {
-			dfl_id_free(pdata->type, port_dev->id);
-			platform_device_put(port_dev);
-		}
-
-		list_del(&pdata->node);
-		put_device(&port_dev->dev);
-	}
 	mutex_unlock(&cdev->lock);
 
 	remove_feature_devs(cdev);
@@ -1665,7 +1654,7 @@ __dfl_fpga_cdev_find_port_data(struct dfl_fpga_cdev *cdev, void *data,
 	struct dfl_feature_dev_data *fdata;
 
 	list_for_each_entry(fdata, &cdev->port_dev_list, node) {
-		if (match(fdata, data) && get_device(&fdata->dev->dev))
+		if (match(fdata, data))
 			return fdata;
 	}
 
@@ -1714,21 +1703,19 @@ int dfl_fpga_cdev_release_port(struct dfl_fpga_cdev *cdev, int port_id)
 	if (!fdata)
 		goto unlock_exit;
 
-	if (!device_is_registered(&fdata->dev->dev)) {
+	if (!fdata->dev) {
 		ret = -EBUSY;
-		goto put_dev_exit;
+		goto unlock_exit;
 	}
 
 	mutex_lock(&fdata->lock);
 	ret = dfl_feature_dev_use_begin(fdata, true);
 	mutex_unlock(&fdata->lock);
 	if (ret)
-		goto put_dev_exit;
+		goto unlock_exit;
 
-	platform_device_del(fdata->dev);
+	feature_dev_unregister(fdata);
 	cdev->released_port_num++;
-put_dev_exit:
-	put_device(&fdata->dev->dev);
 unlock_exit:
 	mutex_unlock(&cdev->lock);
 	return ret;
@@ -1757,22 +1744,20 @@ int dfl_fpga_cdev_assign_port(struct dfl_fpga_cdev *cdev, int port_id)
 	if (!fdata)
 		goto unlock_exit;
 
-	if (device_is_registered(&fdata->dev->dev)) {
+	if (fdata->dev) {
 		ret = -EBUSY;
-		goto put_dev_exit;
+		goto unlock_exit;
 	}
 
-	ret = platform_device_add(fdata->dev);
+	ret = feature_dev_register(fdata);
 	if (ret)
-		goto put_dev_exit;
+		goto unlock_exit;
 
 	mutex_lock(&fdata->lock);
 	dfl_feature_dev_use_end(fdata);
 	mutex_unlock(&fdata->lock);
 
 	cdev->released_port_num--;
-put_dev_exit:
-	put_device(&fdata->dev->dev);
 unlock_exit:
 	mutex_unlock(&cdev->lock);
 	return ret;
@@ -1814,7 +1799,7 @@ void dfl_fpga_cdev_config_ports_pf(struct dfl_fpga_cdev *cdev)
 
 	mutex_lock(&cdev->lock);
 	list_for_each_entry(fdata, &cdev->port_dev_list, node) {
-		if (device_is_registered(&fdata->dev->dev))
+		if (fdata->dev)
 			continue;
 
 		config_port_pf_mode(cdev->fme_dev, fdata->id);
@@ -1851,7 +1836,7 @@ int dfl_fpga_cdev_config_ports_vf(struct dfl_fpga_cdev *cdev, int num_vfs)
 	}
 
 	list_for_each_entry(fdata, &cdev->port_dev_list, node) {
-		if (device_is_registered(&fdata->dev->dev))
+		if (fdata->dev)
 			continue;
 
 		config_port_vf_mode(cdev->fme_dev, fdata->id);
diff --git a/drivers/fpga/dfl.h b/drivers/fpga/dfl.h
index bbd74e1744a8..95539f1213cb 100644
--- a/drivers/fpga/dfl.h
+++ b/drivers/fpga/dfl.h
@@ -207,8 +207,7 @@
 #define PORT_UINT_CAP_INT_NUM	GENMASK_ULL(11, 0)	/* Interrupts num */
 #define PORT_UINT_CAP_FST_VECT	GENMASK_ULL(23, 12)	/* First Vector */
 
-struct dfl_feature_platform_data;
-#define dfl_feature_dev_data dfl_feature_platform_data
+struct dfl_feature_dev_data;
 
 /**
  * struct dfl_fpga_port_ops - port ops
@@ -304,28 +303,32 @@ struct dfl_feature {
 #define FEATURE_DEV_ID_UNUSED	(-1)
 
 /**
- * struct dfl_feature_platform_data - platform data for feature devices
+ * struct dfl_feature_dev_data - dfl enumeration data for dfl feature dev.
  *
- * @node: node to link feature devs to container device's port_dev_list.
- * @lock: mutex to protect platform data.
- * @cdev: cdev of feature dev.
- * @dev: ptr to platform device linked with this platform data.
+ * @node: node to link the data structure to container device's port_dev_list.
+ * @lock: mutex to protect feature dev data.
+ * @dev: ptr to the feature's platform device linked with this structure.
  * @type: type of DFL FIU for the feature dev. See enum dfl_id_type.
+ * @pdev_id: platform device id for the feature dev.
+ * @pdev_name: platform device name for the feature dev.
  * @dfl_cdev: ptr to container device.
- * @id: id used for this feature device.
+ * @id: id used for the feature device.
  * @disable_count: count for port disable.
  * @excl_open: set on feature device exclusive open.
  * @open_count: count for feature device open.
  * @num: number for sub features.
  * @private: ptr to feature dev private data.
- * @features: sub features of this feature dev.
+ * @features: sub features for the feature dev.
+ * @resource_num: number of resources for the feature dev.
+ * @resources: resources for the feature dev.
  */
-struct dfl_feature_platform_data {
+struct dfl_feature_dev_data {
 	struct list_head node;
 	struct mutex lock;
-	struct cdev cdev;
 	struct platform_device *dev;
 	enum dfl_id_type type;
+	int pdev_id;
+	const char *pdev_name;
 	struct dfl_fpga_cdev *dfl_cdev;
 	int id;
 	unsigned int disable_count;
@@ -333,7 +336,20 @@ struct dfl_feature_platform_data {
 	int open_count;
 	void *private;
 	int num;
-	struct dfl_feature features[];
+	struct dfl_feature *features;
+	int resource_num;
+	struct resource *resources;
+};
+
+/**
+ * struct dfl_feature_platform_data - platform data for feature devices
+ *
+ * @cdev: cdev of feature dev.
+ * @fdata: dfl enumeration data for the dfl feature device.
+ */
+struct dfl_feature_platform_data {
+	struct cdev cdev;
+	struct dfl_feature_dev_data *fdata;
 };
 
 static inline
@@ -404,14 +420,14 @@ int dfl_fpga_dev_ops_register(struct platform_device *pdev,
 			      struct module *owner);
 void dfl_fpga_dev_ops_unregister(struct platform_device *pdev);
 
-static inline struct dfl_feature_platform_data *
+static inline struct dfl_feature_dev_data *
 dfl_fpga_inode_to_feature_dev_data(struct inode *inode)
 {
 	struct dfl_feature_platform_data *pdata;
 
 	pdata = container_of(inode->i_cdev, struct dfl_feature_platform_data,
 			     cdev);
-	return pdata;
+	return pdata->fdata;
 }
 
 #define dfl_fpga_dev_for_each_feature(fdata, feature)			    \
@@ -442,7 +458,13 @@ dfl_get_feature_ioaddr_by_id(struct dfl_feature_dev_data *fdata, u16 id)
 	return NULL;
 }
 
-#define to_dfl_feature_dev_data dev_get_platdata
+static inline struct dfl_feature_dev_data *
+to_dfl_feature_dev_data(struct device *dev)
+{
+	struct dfl_feature_platform_data *pdata = dev_get_platdata(dev);
+
+	return pdata->fdata;
+}
 
 static inline
 struct device *dfl_fpga_fdata_to_parent(struct dfl_feature_dev_data *fdata)
@@ -529,11 +551,6 @@ struct dfl_fpga_cdev *
 dfl_fpga_feature_devs_enumerate(struct dfl_fpga_enum_info *info);
 void dfl_fpga_feature_devs_remove(struct dfl_fpga_cdev *cdev);
 
-/*
- * need to drop the device reference with put_device() after use port platform
- * device returned by __dfl_fpga_cdev_find_port and dfl_fpga_cdev_find_port
- * functions.
- */
 struct dfl_feature_dev_data *
 __dfl_fpga_cdev_find_port_data(struct dfl_fpga_cdev *cdev, void *data,
 			       int (*match)(struct dfl_feature_dev_data *, void *));
-- 
2.46.1


