Return-Path: <linux-fpga+bounces-718-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2753497CE85
	for <lists+linux-fpga@lfdr.de>; Thu, 19 Sep 2024 22:36:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAE541F23D28
	for <lists+linux-fpga@lfdr.de>; Thu, 19 Sep 2024 20:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2BF116DEB4;
	Thu, 19 Sep 2024 20:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hxM8bE4x"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31DC11531E5;
	Thu, 19 Sep 2024 20:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726778110; cv=none; b=jZ5FzzVfaaoD0DVjTAWSvqmCbkYQ1OLgSKmsW2zf2tZWdaRt/JhA8b3kVil8zXno08XuvEm7ze3CBXyE4eYUBX+yrxk0AYTSOFtd4XfIC1yU/+JZDRaAx2nkw/luwa4SgkMRNoPLlaq+b0IVWQ/IEkGjt2YXc4Vmm2AOBzdZt7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726778110; c=relaxed/simple;
	bh=l/7QA3UzFE2REcetU5rCTyM/rEINSTEK7Pdw10iyKhk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yh2oscs6LAPjXjwwj11kKcKUSP+t7w7d59or4DtM53ZEKew4oiM6cOfmHo46gMQjzBsOaOnY52o97/0k6TTd9UZnm6v+uf+DXfHS6ni2Y02tL7Ew0xezFTT+BkTl8u9KHbnujk0sBDs8TDIUpEnVydOQYiQFQZtF96FgEXaLfmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hxM8bE4x; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726778109; x=1758314109;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=l/7QA3UzFE2REcetU5rCTyM/rEINSTEK7Pdw10iyKhk=;
  b=hxM8bE4xeutEyVqMcBRCqYqo8bUi1BB0lCJ0uf+knUQVahEgyY2fAgjc
   i1MZCetLji3MZ/stGdfOUJhI/sfNm0Ea7yr4DuZ9LYhXA1P4St+I4po+h
   aGw/2cmaDLnZSrV0YrxdSp9mMAMvOxqIXgs1koRPMH1LLpyVCakgou5o5
   dYs1XlWnw/6//Ucc61n8RIUXNGlBZLrNTaqN+EgGBU0Y/Zj7ePD9AuW+t
   UnP6SroRwng7XaZkOUL7aRKSgJxFvIttdty3/OdY1pjhKuz8M4qWq4L4p
   zCQwFwxVoRevZf4v22dwn5ra9/wYKHt+CzK1sltnEbGZuB94SwWJT6bmE
   g==;
X-CSE-ConnectionGUID: jjxYKl9eR+e76UBhh2wVdg==
X-CSE-MsgGUID: VVq2+1vETrGKla5w5T7anA==
X-IronPort-AV: E=McAfee;i="6700,10204,11200"; a="25912961"
X-IronPort-AV: E=Sophos;i="6.10,242,1719903600"; 
   d="scan'208";a="25912961"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2024 13:35:06 -0700
X-CSE-ConnectionGUID: poeOhiD0SrutCoUSn5MAtw==
X-CSE-MsgGUID: sMYkirkQTnGElwn4GWd63A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,242,1719903600"; 
   d="scan'208";a="93338334"
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
	Peter Colberg <peter.colberg@intel.com>
Subject: [PATCH v3 6/9] fpga: dfl: factor out feature data creation from build_info_commit_dev()
Date: Thu, 19 Sep 2024 16:34:27 -0400
Message-ID: <20240919203430.1278067-7-peter.colberg@intel.com>
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

Add a separate function binfo_create_feature_dev_data() which allocates
and populates the feature platform data, and call the function from
build_info_commit_dev() which registers the feature platform device.

Signed-off-by: Peter Colberg <peter.colberg@intel.com>
Reviewed-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
---
 drivers/fpga/dfl.c | 74 ++++++++++++++++++++++++++--------------------
 1 file changed, 42 insertions(+), 32 deletions(-)

diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
index 4c79d433d216..e644eb9fde39 100644
--- a/drivers/fpga/dfl.c
+++ b/drivers/fpga/dfl.c
@@ -749,12 +749,8 @@ static void dfl_fpga_cdev_add_port_data(struct dfl_fpga_cdev *cdev,
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
@@ -764,7 +760,7 @@ static int build_info_commit_dev(struct build_feature_devs_info *binfo)
 
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
@@ -834,8 +830,10 @@ static int build_info_commit_dev(struct build_feature_devs_info *binfo)
 			feature->ioaddr =
 				devm_ioremap_resource(binfo->dev,
 						      &finfo->mmio_res);
-			if (IS_ERR(feature->ioaddr))
-				return PTR_ERR(feature->ioaddr);
+			if (IS_ERR(feature->ioaddr)) {
+				ret = PTR_ERR(feature->ioaddr);
+				return ERR_PTR(ret);
+			}
 		} else {
 			feature->resource_index = res_idx;
 			fdev->resource[res_idx++] = finfo->mmio_res;
@@ -845,7 +843,7 @@ static int build_info_commit_dev(struct build_feature_devs_info *binfo)
 			ctx = devm_kcalloc(binfo->dev, finfo->nr_irqs,
 					   sizeof(*ctx), GFP_KERNEL);
 			if (!ctx)
-				return -ENOMEM;
+				return ERR_PTR(-ENOMEM);
 
 			for (i = 0; i < finfo->nr_irqs; i++)
 				ctx[i].irq =
@@ -859,25 +857,7 @@ static int build_info_commit_dev(struct build_feature_devs_info *binfo)
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
@@ -912,6 +892,36 @@ build_info_create_dev(struct build_feature_devs_info *binfo,
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
2.46.1


