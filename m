Return-Path: <linux-fpga+bounces-899-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF2D29B12C8
	for <lists+linux-fpga@lfdr.de>; Sat, 26 Oct 2024 00:38:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A36A3282CF6
	for <lists+linux-fpga@lfdr.de>; Fri, 25 Oct 2024 22:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAD0C21621A;
	Fri, 25 Oct 2024 22:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OLAiIaiI"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556AD215C55;
	Fri, 25 Oct 2024 22:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729895863; cv=none; b=G8ggjS9ce3ZylsBhJ6ywBeZoAjHHOQ6A3u0tl0Nn5ZaB2oMWDe9PQUEaw45Nv1X/dwcnMpYWxR4Q6YtKnV2UjvEy6QBZPm+hbiZ7YVthIOq2DLIjhWDLb8zUDeWHrsykZGT9JLw3KbJ4cXToBtiEt+HLhLOWnvbk9tTOrcDHQ2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729895863; c=relaxed/simple;
	bh=tp62J7XWQ63M0Wxps50kozrkGXN+M8YuJV3s90auLx8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CtrzsOTe+wJzRnkafkemgxbLA0Zz3VwdAbSOS9u9KBB0gw3D2kwKqJpINCI+jZXgyyHB6CdBV8ETO1tsCvav27ebnAPAr16Qktd3tAd79XvXDx1yJ1wZBuGM092DTEBOAwgjHuuq5ayvXSKsb/k83sUwJwd9X62aAIgQh4UXjkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OLAiIaiI; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729895861; x=1761431861;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tp62J7XWQ63M0Wxps50kozrkGXN+M8YuJV3s90auLx8=;
  b=OLAiIaiI1/ZHF+SunvnYzkijVXg3tppUUiufuQPoBpYgOSiGZoOoRmyL
   2GywEIgkCbuLRhibKaHF5LOabTKrFhySj1M2sCjhID/zAx2uv9pfsVAFI
   NIWOx5uLdWBBoQISR6srThM2mhGDHTdkCDbJm0+yrpVoTzG05NSuNTgb9
   7OzLswA0SDiPYKGo1hjaU2NeSHupt2mpAWAOUgMjjap7kS8Rcmz0DRE7h
   VqnhO/R0kX/wCtrbSpd5nWT7r5Ok8SOLqacn3H/rF1/NrcQNXlFOws1m8
   NY/CHNtUDjvXWNle2fJeirCq1GO5XEJ1lOt3+bDdwvWcTFBTnOV/92iny
   A==;
X-CSE-ConnectionGUID: UWnimcU4Rcm3lJxLGpTdcA==
X-CSE-MsgGUID: MGtGjmZIQ6iNxsPio9hBDA==
X-IronPort-AV: E=McAfee;i="6700,10204,11236"; a="29474642"
X-IronPort-AV: E=Sophos;i="6.11,233,1725346800"; 
   d="scan'208";a="29474642"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 15:37:37 -0700
X-CSE-ConnectionGUID: Tkk7BLINQ/6lULdP2czpLw==
X-CSE-MsgGUID: VieHLxe3TWiiwUeYXmnTdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,233,1725346800"; 
   d="scan'208";a="85596149"
Received: from sj-4150-psse-sw-opae-dev3.sj.altera.com ([10.244.138.109])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 15:37:37 -0700
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
Subject: [PATCH v4 06/19] fpga: dfl: factor out feature data creation from build_info_commit_dev()
Date: Fri, 25 Oct 2024 18:37:01 -0400
Message-ID: <20241025223714.394533-7-peter.colberg@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241025223714.394533-1-peter.colberg@intel.com>
References: <20241025223714.394533-1-peter.colberg@intel.com>
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
---
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


