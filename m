Return-Path: <linux-fpga+bounces-955-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A5D79D31B2
	for <lists+linux-fpga@lfdr.de>; Wed, 20 Nov 2024 02:12:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8D50B231B9
	for <lists+linux-fpga@lfdr.de>; Wed, 20 Nov 2024 01:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E68FC136E28;
	Wed, 20 Nov 2024 01:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PVCPe7Tx"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16FD374C14;
	Wed, 20 Nov 2024 01:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732065103; cv=none; b=ANakz38nFLw1rh44EoBlOV/nwDcBdT2tJaAdGbfI8F/DsCPx68NQQ/XAW52yjsDcfBY2eR29wns6ApShax8BE1aGnE6BagdQCRAJfUgVUhWs56V2Ya6qyXvcjTFMhi7ijSRqr4x1UqsYTl5XcR901aP50coZfnl+DyCCsiihPmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732065103; c=relaxed/simple;
	bh=SzQ9MsCK3IvY/ogi6ri7XaGysw8Fenuk1opsDdO6OkI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e2NjOtiTD+3dz7ckekWScNvq0kn7NXPSSn4SMBGqqQgPbU0sZHlv//W2hiVxKYdcHZkogGQ4opXQzMaeW/qbhAOyPqQmICKoVMmrN2nXAnM9VJpNZ2Xvk+noPv7j7Qwk196PXf/pY521oMN2QOdMBUwixtwK6UmnEHzskUta8s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PVCPe7Tx; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732065102; x=1763601102;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SzQ9MsCK3IvY/ogi6ri7XaGysw8Fenuk1opsDdO6OkI=;
  b=PVCPe7Txr4Xa/Z3UxdrM1nwaqkHqq8PNmD/2Pb/B5v7P9+9hJgzLiBiJ
   yInkwsnfSgqvlANWcRlY3/JGQ3wpdLWkzxhfkklTmIt0ghMWlXj8AybD4
   +Ipt0rJNRGrH0+lxNZwRrCA40Olz6fmjBleZ5aB02e/LuzZweXd5bS9fV
   ZiAfxfeu/qZ4DxJ8RJkhLNEulIm2pnXSwgnMDTNlibW86oOPaozOgL6An
   PYDi8OBMk9c9MFdfAY/PdByyPkfygRBqce6cUaEcMN9cA1K37xzHVWbGy
   NadcNc5/Wbq/uARxWsUNwciq9FvOMO2vHcAl3AR6EChsMmNcRn6vbMXYO
   w==;
X-CSE-ConnectionGUID: DRZN6iu4RDW4QvMuLeZ4tg==
X-CSE-MsgGUID: F5nEUOcBQaSJL+IDjKN7/w==
X-IronPort-AV: E=McAfee;i="6700,10204,11261"; a="42612986"
X-IronPort-AV: E=Sophos;i="6.12,168,1728975600"; 
   d="scan'208";a="42612986"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2024 17:11:40 -0800
X-CSE-ConnectionGUID: ACgXJOB3S4Cud0dqmM8PQg==
X-CSE-MsgGUID: LDUINnjVTGOdUxy3u2trtw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,168,1728975600"; 
   d="scan'208";a="93813581"
Received: from sj-4150-psse-sw-opae-dev3.sj.altera.com ([10.244.138.109])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2024 17:11:39 -0800
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
Subject: [PATCH v5 06/18] fpga: dfl: factor out feature data creation from build_info_commit_dev()
Date: Tue, 19 Nov 2024 20:10:22 -0500
Message-ID: <20241120011035.230574-7-peter.colberg@intel.com>
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

Add a separate function, binfo_create_feature_dev_data(), which allocates
and populates the feature platform data, and call the function from
build_info_commit_dev(), which registers the feature platform device.

Signed-off-by: Peter Colberg <peter.colberg@intel.com>
Reviewed-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
Reviewed-by: Basheer Ahmed Muddebihal <basheer.ahmed.muddebihal@linux.intel.com>
Acked-by: Xu Yilun <yilun.xu@intel.com>
---
Changes since v4:
- No changes.

Changes since v3:
- Replace ERR_PTR(PTR_ERR(feature->ioaddr) with feature->ioaddr and
  remove unneeded local variable ret.
- Add missing commas in description.

Changes since v2:
- New patch extracted from monolithic v1 patch.
---
 drivers/fpga/dfl.c | 72 +++++++++++++++++++++++++---------------------
 1 file changed, 40 insertions(+), 32 deletions(-)

diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
index 4c79d433d216..56a32f5146a3 100644
--- a/drivers/fpga/dfl.c
+++ b/drivers/fpga/dfl.c
@@ -749,22 +749,18 @@ static void dfl_fpga_cdev_add_port_data(struct dfl_fpga_cdev *cdev,
 	mutex_unlock(&cdev->lock);
 }
 
-/*
- * register current feature device, it is called when we need to switch to
- * another feature parsing or we have parsed all features on given device
- * feature list.
- */
-static int build_info_commit_dev(struct build_feature_devs_info *binfo)
+static struct dfl_feature_platform_data *
+binfo_create_feature_dev_data(struct build_feature_devs_info *binfo)
 {
 	struct platform_device *fdev = binfo->feature_dev;
 	struct dfl_feature_platform_data *pdata;
 	struct dfl_feature_info *finfo, *p;
 	enum dfl_id_type type;
-	int ret, index = 0, res_idx = 0;
+	int index = 0, res_idx = 0;
 
 	type = feature_dev_id_type(fdev);
 	if (WARN_ON_ONCE(type >= DFL_ID_MAX))
-		return -EINVAL;
+		return ERR_PTR(-EINVAL);
 
 	/*
 	 * we do not need to care for the memory which is associated with
@@ -774,7 +770,7 @@ static int build_info_commit_dev(struct build_feature_devs_info *binfo)
 	 */
 	pdata = kzalloc(struct_size(pdata, features, binfo->feature_num), GFP_KERNEL);
 	if (!pdata)
-		return -ENOMEM;
+		return ERR_PTR(-ENOMEM);
 
 	pdata->dev = fdev;
 	pdata->num = binfo->feature_num;
@@ -799,7 +795,7 @@ static int build_info_commit_dev(struct build_feature_devs_info *binfo)
 	fdev->resource = kcalloc(binfo->feature_num, sizeof(*fdev->resource),
 				 GFP_KERNEL);
 	if (!fdev->resource)
-		return -ENOMEM;
+		return ERR_PTR(-ENOMEM);
 
 	/* fill features and resource information for feature dev */
 	list_for_each_entry_safe(finfo, p, &binfo->sub_features, node) {
@@ -818,7 +814,7 @@ static int build_info_commit_dev(struct build_feature_devs_info *binfo)
 						       finfo->params, finfo->param_size,
 						       GFP_KERNEL);
 			if (!feature->params)
-				return -ENOMEM;
+				return ERR_PTR(-ENOMEM);
 
 			feature->param_size = finfo->param_size;
 		}
@@ -835,7 +831,7 @@ static int build_info_commit_dev(struct build_feature_devs_info *binfo)
 				devm_ioremap_resource(binfo->dev,
 						      &finfo->mmio_res);
 			if (IS_ERR(feature->ioaddr))
-				return PTR_ERR(feature->ioaddr);
+				return feature->ioaddr;
 		} else {
 			feature->resource_index = res_idx;
 			fdev->resource[res_idx++] = finfo->mmio_res;
@@ -845,7 +841,7 @@ static int build_info_commit_dev(struct build_feature_devs_info *binfo)
 			ctx = devm_kcalloc(binfo->dev, finfo->nr_irqs,
 					   sizeof(*ctx), GFP_KERNEL);
 			if (!ctx)
-				return -ENOMEM;
+				return ERR_PTR(-ENOMEM);
 
 			for (i = 0; i < finfo->nr_irqs; i++)
 				ctx[i].irq =
@@ -859,25 +855,7 @@ static int build_info_commit_dev(struct build_feature_devs_info *binfo)
 		kfree(finfo);
 	}
 
-	ret = platform_device_add(binfo->feature_dev);
-	if (!ret) {
-		if (type == PORT_ID)
-			dfl_fpga_cdev_add_port_data(binfo->cdev,
-						    pdata);
-		else
-			binfo->cdev->fme_dev =
-					get_device(&binfo->feature_dev->dev);
-		/*
-		 * reset it to avoid build_info_free() freeing their resource.
-		 *
-		 * The resource of successfully registered feature devices
-		 * will be freed by platform_device_unregister(). See the
-		 * comments in build_info_create_dev().
-		 */
-		binfo->feature_dev = NULL;
-	}
-
-	return ret;
+	return pdata;
 }
 
 static int
@@ -912,6 +890,36 @@ build_info_create_dev(struct build_feature_devs_info *binfo,
 	return 0;
 }
 
+static int build_info_commit_dev(struct build_feature_devs_info *binfo)
+{
+	struct dfl_feature_platform_data *pdata;
+	int ret;
+
+	pdata = binfo_create_feature_dev_data(binfo);
+	if (IS_ERR(pdata))
+		return PTR_ERR(pdata);
+
+	ret = platform_device_add(binfo->feature_dev);
+	if (ret)
+		return ret;
+
+	if (feature_dev_id_type(binfo->feature_dev) == PORT_ID)
+		dfl_fpga_cdev_add_port_data(binfo->cdev, pdata);
+	else
+		binfo->cdev->fme_dev = get_device(&binfo->feature_dev->dev);
+
+	/*
+	 * reset it to avoid build_info_free() freeing their resource.
+	 *
+	 * The resource of successfully registered feature devices
+	 * will be freed by platform_device_unregister(). See the
+	 * comments in build_info_create_dev().
+	 */
+	binfo->feature_dev = NULL;
+
+	return 0;
+}
+
 static void build_info_free(struct build_feature_devs_info *binfo)
 {
 	struct dfl_feature_info *finfo, *p;
-- 
2.47.0


