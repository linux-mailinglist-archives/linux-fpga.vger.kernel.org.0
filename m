Return-Path: <linux-fpga+bounces-962-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 215B69D31BF
	for <lists+linux-fpga@lfdr.de>; Wed, 20 Nov 2024 02:14:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3CD11F2386D
	for <lists+linux-fpga@lfdr.de>; Wed, 20 Nov 2024 01:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15E8C148838;
	Wed, 20 Nov 2024 01:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EvpFh0rh"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38034145B18;
	Wed, 20 Nov 2024 01:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732065110; cv=none; b=JWgFkgFCdKqoWtZd/SADuKdhIzS18VaNv/OkOFUo4oGSEywsFXQNL73eHhRORlF5rIAPJVi8kF0unRylkUNCpsBvEzAOncuzlBC2aEo7IemHnN7ACCob3eFiaXUfvpwI59ycVi5CrdFfz6mu6qgXlWizBl8Zac0Gox7FMZlUGWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732065110; c=relaxed/simple;
	bh=Pk9g8e5/ks8j2zFFTFyPo0YQPtP9Wrtdu2ahGNNfISY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XYTY0FRgaQwe3gGLRojCVOpeUkkrDgqbWgk3NizcCiLGHhOIEUYBjCDQ/+/+1WPQCSmIr29AStkoN6C2dXoV86xIOy1bS77zLYG0c8RHMHNB+nMqFk25Bsr2Mh7McicMkE3PsUT8LbA5d10RVTExYv3qX512jlM0Xx2j3t0J/i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EvpFh0rh; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732065108; x=1763601108;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Pk9g8e5/ks8j2zFFTFyPo0YQPtP9Wrtdu2ahGNNfISY=;
  b=EvpFh0rhscWQF8zIgBywzCIFLfeKrAEFpBj3DGLkJVbiwMkUONltVUVA
   t/ypJSmeG8CySfFHNeCqJCqGj1A+lYxu6xjCVYMs9NS1ylzZ7NTjyA7cn
   bsEzFRALWy3J8QE/Aq63Qb3y2iBPxdjqtS0JvsqQoTvpFvh538t1hnIDY
   GY8BIsZx/NNzZhpGcWpIJJi0D/vlNialUk57jivMzYiflAMP3CS+ZOJRT
   qhiuJ2qVAedWGB5KZts3PktE+YBueUnEP4CO/evhb4UOr8dEda4Ua1rCw
   4XJnHprXSrGTeB8amoCnlqQTcusLLWfSj4v+4AkSgnAuv2NYTQ1cADr0X
   w==;
X-CSE-ConnectionGUID: 0/cnNVHRRUa9L+mq0Qfuxw==
X-CSE-MsgGUID: 82IGuftVT1iMEi0Uob47Zg==
X-IronPort-AV: E=McAfee;i="6700,10204,11261"; a="42613016"
X-IronPort-AV: E=Sophos;i="6.12,168,1728975600"; 
   d="scan'208";a="42613016"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2024 17:11:41 -0800
X-CSE-ConnectionGUID: z9OPfEs5Q5GKGcSfdWVVcw==
X-CSE-MsgGUID: AhlHPMJFQ6GmcYjczWN3Mw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,168,1728975600"; 
   d="scan'208";a="93813601"
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
Subject: [PATCH v5 12/18] fpga: dfl: store MMIO resources in feature device data
Date: Tue, 19 Nov 2024 20:10:28 -0500
Message-ID: <20241120011035.230574-13-peter.colberg@intel.com>
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

Instead of directly copying the MMIO resource of each feature to the
feature device resources, add a new member to the feature device data
to store the resources and copy them to the feature device using
platform_device_add_resources(). This prepares a subsequent commit
which completely destroys and recreates the feature device when
releasing and reassigning the corresponding port, respectively.

Signed-off-by: Peter Colberg <peter.colberg@intel.com>
Reviewed-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
Reviewed-by: Basheer Ahmed Muddebihal <basheer.ahmed.muddebihal@linux.intel.com>
Acked-by: Xu Yilun <yilun.xu@intel.com>
---
Changes since v4:
- No changes.

Changes since v3:
- New patch extracted from last patch of v3 series.
---
 drivers/fpga/dfl.c | 21 +++++++++++++--------
 drivers/fpga/dfl.h |  4 ++++
 2 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
index bf2c7381eebd..5e9052b98c4a 100644
--- a/drivers/fpga/dfl.c
+++ b/drivers/fpga/dfl.c
@@ -761,6 +761,11 @@ binfo_create_feature_dev_data(struct build_feature_devs_info *binfo)
 	if (!fdata->features)
 		return ERR_PTR(-ENOMEM);
 
+	fdata->resources = devm_kcalloc(binfo->dev, binfo->feature_num,
+					sizeof(*fdata->resources), GFP_KERNEL);
+	if (!fdata->resources)
+		return ERR_PTR(-ENOMEM);
+
 	fdata->dev = fdev;
 	fdata->type = type;
 	fdata->num = binfo->feature_num;
@@ -778,13 +783,6 @@ binfo_create_feature_dev_data(struct build_feature_devs_info *binfo)
 	 */
 	WARN_ON(fdata->disable_count);
 
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
@@ -822,7 +820,7 @@ binfo_create_feature_dev_data(struct build_feature_devs_info *binfo)
 				return feature->ioaddr;
 		} else {
 			feature->resource_index = res_idx;
-			fdev->resource[res_idx++] = finfo->mmio_res;
+			fdata->resources[res_idx++] = finfo->mmio_res;
 		}
 
 		if (finfo->nr_irqs) {
@@ -843,6 +841,8 @@ binfo_create_feature_dev_data(struct build_feature_devs_info *binfo)
 		kfree(finfo);
 	}
 
+	fdata->resource_num = res_idx;
+
 	return fdata;
 }
 
@@ -886,6 +886,11 @@ static int feature_dev_register(struct dfl_feature_dev_data *fdata)
 	fdev->dev.parent = &fdata->dfl_cdev->region->dev;
 	fdev->dev.devt = dfl_get_devt(dfl_devs[fdata->type].devt_type, fdev->id);
 
+	ret = platform_device_add_resources(fdev, fdata->resources,
+					    fdata->resource_num);
+	if (ret)
+		return ret;
+
 	pdata.fdata = fdata;
 	ret = platform_device_add_data(fdev, &pdata, sizeof(pdata));
 	if (ret)
diff --git a/drivers/fpga/dfl.h b/drivers/fpga/dfl.h
index d2765555e109..921d946e4820 100644
--- a/drivers/fpga/dfl.h
+++ b/drivers/fpga/dfl.h
@@ -317,6 +317,8 @@ struct dfl_feature {
  * @num: number for sub features.
  * @private: ptr to feature dev private data.
  * @features: sub features for the feature dev.
+ * @resource_num: number of resources for the feature dev.
+ * @resources: resources for the feature dev.
  */
 struct dfl_feature_dev_data {
 	struct list_head node;
@@ -331,6 +333,8 @@ struct dfl_feature_dev_data {
 	void *private;
 	int num;
 	struct dfl_feature *features;
+	int resource_num;
+	struct resource *resources;
 };
 
 /**
-- 
2.47.0


