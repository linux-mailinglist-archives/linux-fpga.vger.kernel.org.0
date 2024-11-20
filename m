Return-Path: <linux-fpga+bounces-968-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 150069D31CC
	for <lists+linux-fpga@lfdr.de>; Wed, 20 Nov 2024 02:15:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65744B24517
	for <lists+linux-fpga@lfdr.de>; Wed, 20 Nov 2024 01:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC01C155A59;
	Wed, 20 Nov 2024 01:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="axUrv6da"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA3214B08A;
	Wed, 20 Nov 2024 01:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732065114; cv=none; b=dWSABovz7RTgbtzhvNu7A5437WLOS9CZ49umSofBWImS9hUh9seeOVJGa3usm8Z0TzbC10wloPH+Ev3NHrNJBnJVQ0ibgjHAhoUweGk1GgeqQvcWWa+V2tobYYIs8F030xDX4H4eA92sgUTDTeP6fblxSF0k/arz8z2V+05ktvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732065114; c=relaxed/simple;
	bh=hOUbRA5gOcZEcufXcx6zy9jhH9eo+LXdrTu5kqFXAI8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EAl8xG6kUQVm0sO99QwuZWdav2wvvMIEB9nP5efl2auUeUzf0fhIebTGAoRWAQ9pfHdUKYFm0IOCr/vblzvftDdnlseKXxKUYnZ5vVAl2qq8WzWETQXpEMLI94/pkf7m+JsjwkT52JJ4BZHp5AVcKEbm+D+bXi32RCtnAV6TfUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=axUrv6da; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732065111; x=1763601111;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hOUbRA5gOcZEcufXcx6zy9jhH9eo+LXdrTu5kqFXAI8=;
  b=axUrv6day13ninnk12Jfd39bS3dti251WLpu0l1F1UvsaQZ9eJfdWACE
   Mu43tNbCEOZ7BN/6iatVeH+/hMHJdrO5drWR68FrHDOPkd1RDhPKO2ZYR
   M4sOduqAyAIs61M71G+RlUlX++KQZNvl1qYUdJK204lzBObbf8bjechpZ
   XIsF30pX6Z/uD+jnm6qeYbOMi5lSQzO0EKj8I44Fhnr1lM45FXIpYRyIS
   BOCThS6UFRwWKqLfwk3W+JMglFfkn5ShfXhXKMgsJ+dglTYPzfFA2DEUd
   Dk8A3VY7fG00jZOGh1NN/EHrV0sdSgsLW9Rcse+4LS9o6Z5NFmtabbfFv
   g==;
X-CSE-ConnectionGUID: Ba8TFe0QSOizcFErX4BUeQ==
X-CSE-MsgGUID: Xs4vqVDVT5mwSCXPmbBnSQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11261"; a="42613031"
X-IronPort-AV: E=Sophos;i="6.12,168,1728975600"; 
   d="scan'208";a="42613031"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2024 17:11:41 -0800
X-CSE-ConnectionGUID: eqOUF6HPQI+zYCyWtWp8pw==
X-CSE-MsgGUID: Q/ccikOhTwuYIDhVPh8Lzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,168,1728975600"; 
   d="scan'208";a="93813612"
Received: from sj-4150-psse-sw-opae-dev3.sj.altera.com ([10.244.138.109])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2024 17:11:40 -0800
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
	Basheer Ahmed Muddebihal <basheer.ahmed.muddebihal@linux.intel.com>,
	Peter Colberg <peter.colberg@intel.com>
Subject: [PATCH v5 15/18] fpga: dfl: allocate platform device after feature device data
Date: Tue, 19 Nov 2024 20:10:31 -0500
Message-ID: <20241120011035.230574-16-peter.colberg@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241120011035.230574-1-peter.colberg@intel.com>
References: <20241120011035.230574-1-peter.colberg@intel.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Delay calling platform_device_alloc() from build_info_create_dev() to
feature_dev_register(), now that the feature device data contains all
necessary data to create the feature device. This completes the new
function feature_dev_register(), which will be reused in a subsequent
commit to fully recreate the feature device when assigning a port.

In the function feature_dev_unregister(), reset the device pointer in
the feature data to NULL to signal that the platform device has been
destroyed. This will substitute device_is_registered() in a subsequent
commit. Reset the device pointer of each sub feature for consistency.

Convert is_feature_dev_detected() to check whether binfo->type is not
DFL_ID_MAX for deciding whether a feature device was detected during
feature parsing, instead of checking binfo->feature_dev for non-NULL.

Signed-off-by: Peter Colberg <peter.colberg@intel.com>
Reviewed-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
Reviewed-by: Basheer Ahmed Muddebihal <basheer.ahmed.muddebihal@linux.intel.com>
---
Changes since v4:
- Merge patch "convert is_feature_dev_detected() to use FIU type".
  After the former patch was applied but not yet this patch, there
  was a window between binfo->type already holding a valid DFL id but
  binfo->feature_dev still NULL, where is_feature_dev_detected() would
  yield a different result, e.g., when build_info_create_dev() failed.
- Move reset of device pointer in feature data to NULL in the function
  feature_dev_unregister() from the patch "fpga: dfl: factor out feature
  device registration" to this patch, which contains the corresponding
  initialization of the device pointer in feature_dev_register().
- In the function feature_dev_unregister(), reset the device pointer of
  each sub feature to NULL for consistency.

Changes since v3:
- New patch extracted from last patch of v3 series.
---
 drivers/fpga/dfl.c | 72 ++++++++++++++++++++++------------------------
 1 file changed, 34 insertions(+), 38 deletions(-)

diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
index aeae5befc6c6..91f12272da3e 100644
--- a/drivers/fpga/dfl.c
+++ b/drivers/fpga/dfl.c
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
@@ -750,7 +748,6 @@ static void dfl_id_free_action(void *arg)
 static struct dfl_feature_dev_data *
 binfo_create_feature_dev_data(struct build_feature_devs_info *binfo)
 {
-	struct platform_device *fdev = binfo->feature_dev;
 	enum dfl_id_type type = binfo->type;
 	struct dfl_feature_info *finfo, *p;
 	struct dfl_feature_dev_data *fdata;
@@ -773,7 +770,6 @@ binfo_create_feature_dev_data(struct build_feature_devs_info *binfo)
 	if (!fdata->resources)
 		return ERR_PTR(-ENOMEM);
 
-	fdata->dev = fdev;
 	fdata->type = type;
 
 	fdata->pdev_id = dfl_id_alloc(type, binfo->dev);
@@ -784,8 +780,6 @@ binfo_create_feature_dev_data(struct build_feature_devs_info *binfo)
 	if (ret)
 		return ERR_PTR(ret);
 
-	fdev->id = fdata->pdev_id;
-
 	fdata->pdev_name = dfl_devs[type].name;
 	fdata->num = binfo->feature_num;
 	fdata->dfl_cdev = binfo->cdev;
@@ -809,7 +803,6 @@ binfo_create_feature_dev_data(struct build_feature_devs_info *binfo)
 		unsigned int i;
 
 		/* save resource information for each feature */
-		feature->dev = fdev;
 		feature->id = finfo->fid;
 		feature->revision = finfo->revision;
 		feature->dfh_version = finfo->dfh_version;
@@ -868,18 +861,6 @@ binfo_create_feature_dev_data(struct build_feature_devs_info *binfo)
 static int
 build_info_create_dev(struct build_feature_devs_info *binfo)
 {
-	enum dfl_id_type type = binfo->type;
-	struct platform_device *fdev;
-
-	/*
-	 * we use -ENODEV as the initialization indicator which indicates
-	 * whether the id need to be reclaimed
-	 */
-	fdev = platform_device_alloc(dfl_devs[type].name, -ENODEV);
-	if (!fdev)
-		return -ENOMEM;
-
-	binfo->feature_dev = fdev;
 	binfo->feature_num = 0;
 
 	INIT_LIST_HEAD(&binfo->sub_features);
@@ -895,32 +876,59 @@ build_info_create_dev(struct build_feature_devs_info *binfo)
 static int feature_dev_register(struct dfl_feature_dev_data *fdata)
 {
 	struct dfl_feature_platform_data pdata = {};
-	struct platform_device *fdev = fdata->dev;
+	struct platform_device *fdev;
+	struct dfl_feature *feature;
 	int ret;
 
+	fdev = platform_device_alloc(fdata->pdev_name, fdata->pdev_id);
+	if (!fdev)
+		return -ENOMEM;
+
+	fdata->dev = fdev;
+
 	fdev->dev.parent = &fdata->dfl_cdev->region->dev;
 	fdev->dev.devt = dfl_get_devt(dfl_devs[fdata->type].devt_type, fdev->id);
 
+	dfl_fpga_dev_for_each_feature(fdata, feature)
+		feature->dev = fdev;
+
 	ret = platform_device_add_resources(fdev, fdata->resources,
 					    fdata->resource_num);
 	if (ret)
-		return ret;
+		goto err_put_dev;
 
 	pdata.fdata = fdata;
 	ret = platform_device_add_data(fdev, &pdata, sizeof(pdata));
 	if (ret)
-		return ret;
+		goto err_put_dev;
 
 	ret = platform_device_add(fdev);
 	if (ret)
-		return ret;
+		goto err_put_dev;
 
 	return 0;
+
+err_put_dev:
+	platform_device_put(fdev);
+
+	fdata->dev = NULL;
+
+	dfl_fpga_dev_for_each_feature(fdata, feature)
+		feature->dev = NULL;
+
+	return ret;
 }
 
 static void feature_dev_unregister(struct dfl_feature_dev_data *fdata)
 {
+	struct dfl_feature *feature;
+
 	platform_device_unregister(fdata->dev);
+
+	fdata->dev = NULL;
+
+	dfl_fpga_dev_for_each_feature(fdata, feature)
+		feature->dev = NULL;
 }
 
 static int build_info_commit_dev(struct build_feature_devs_info *binfo)
@@ -939,16 +947,7 @@ static int build_info_commit_dev(struct build_feature_devs_info *binfo)
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
@@ -965,8 +964,6 @@ static void build_info_free(struct build_feature_devs_info *binfo)
 		kfree(finfo);
 	}
 
-	platform_device_put(binfo->feature_dev);
-
 	devm_kfree(binfo->dev, binfo);
 }
 
@@ -1247,7 +1244,7 @@ static int parse_feature_port_afu(struct build_feature_devs_info *binfo,
 	return create_feature_instance(binfo, ofst, size, FEATURE_ID_AFU);
 }
 
-#define is_feature_dev_detected(binfo) (!!(binfo)->feature_dev)
+#define is_feature_dev_detected(binfo) ((binfo)->type != DFL_ID_MAX)
 
 static int parse_feature_afu(struct build_feature_devs_info *binfo,
 			     resource_size_t ofst)
@@ -1261,8 +1258,7 @@ static int parse_feature_afu(struct build_feature_devs_info *binfo,
 	case PORT_ID:
 		return parse_feature_port_afu(binfo, ofst);
 	default:
-		dev_info(binfo->dev, "AFU belonging to FIU %s is not supported yet.\n",
-			 binfo->feature_dev->name);
+		dev_info(binfo->dev, "AFU belonging to FIU is not supported yet.\n");
 	}
 
 	return 0;
-- 
2.47.0


