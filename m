Return-Path: <linux-fpga+bounces-902-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 356969B12CF
	for <lists+linux-fpga@lfdr.de>; Sat, 26 Oct 2024 00:39:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3138282D00
	for <lists+linux-fpga@lfdr.de>; Fri, 25 Oct 2024 22:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 073A121744D;
	Fri, 25 Oct 2024 22:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OkVlqSsR"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC8B6216E01;
	Fri, 25 Oct 2024 22:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729895866; cv=none; b=RwSYYv7jyT5eHGtyPr3PTuquCAcjlx2bTT+Takv4KwcloDaVKJ3m2jD2tH5ZMGrcDq5X9qeYQ69vUxugBlPXx5KfBJyD0waHE1ZotuGh0154tpuFkchsgjVY6FdKzjwbdKIBqUJyDCv3ulyEx6TKqZXr7AKI/KSzTPvdg+DtKFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729895866; c=relaxed/simple;
	bh=eZuU5ssbG4GvwWXQo2VcNFPFRBHShENtKzR6jb4Z4kE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CDgGL+vu2cTWsAjmpOmUMdIWeOaXYJvtyVPOsdINMBOADTSQHvfl923ctbLZLFlYJo313NKFUCeJzJ46dd+SsYDvvtowPbfJviYu0Mi5eLhLFLt71FTWHF3jOhpA1/26GbFpiQXIhX3nf4TOmlmntsbSFRIOpomoOY+8+vI+YvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OkVlqSsR; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729895864; x=1761431864;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eZuU5ssbG4GvwWXQo2VcNFPFRBHShENtKzR6jb4Z4kE=;
  b=OkVlqSsRn9THFI+Ipw0IgfGOrP8juoTaLfS+JhLX07DRMP30jjTzT1V3
   hnokIMZ0bFC401ypZr0rZjF1/iHLiNRIs2aztKmqihIInQW9letbc4T8s
   bE3A/y6ad9HFMlIBIPzODerAHlulsdiRAJutvI7B0q+HutABEvLY4TRlw
   6Gpbc9w03K90BsKfhFM1qtYKOL9AWq5pYJ+CVAEP3Hgv4alTXIfiRQTPr
   N5hwsCCr/6pj0ieMErork8EaD455eo/lTWXfdy2z+L4WJqaU8+SMFPf6J
   Nf0P1SekKbnYNwk4ZfNIdzIaOY6W4JhsOpRzOvuLfLL9ixac/UGId/d54
   g==;
X-CSE-ConnectionGUID: Q2iyvYdETiWvp7inzuHzOA==
X-CSE-MsgGUID: RMmjgRbrQhKl+BbonFhSww==
X-IronPort-AV: E=McAfee;i="6700,10204,11236"; a="29474667"
X-IronPort-AV: E=Sophos;i="6.11,233,1725346800"; 
   d="scan'208";a="29474667"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 15:37:38 -0700
X-CSE-ConnectionGUID: UyIL4WgARsivMvck8Jw2Ww==
X-CSE-MsgGUID: AtuZGmQyR/S/TxEp3m/gQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,233,1725346800"; 
   d="scan'208";a="85596173"
Received: from sj-4150-psse-sw-opae-dev3.sj.altera.com ([10.244.138.109])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 15:37:38 -0700
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
Subject: [PATCH v4 12/19] fpga: dfl: store MMIO resources in feature device data
Date: Fri, 25 Oct 2024 18:37:07 -0400
Message-ID: <20241025223714.394533-13-peter.colberg@intel.com>
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

Instead of directly copying the MMIO resource of each feature to the
feature device resources, add a new member to the feature device data
to store the resources and copy them to the feature device using
platform_device_add_resources(). This prepares a subsequent commit
which completely destroys and recreates the feature device when
releasing and reassigning the corresponding port, respectively.

Signed-off-by: Peter Colberg <peter.colberg@intel.com>
Reviewed-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
Reviewed-by: Basheer Ahmed Muddebihal <basheer.ahmed.muddebihal@linux.intel.com>
---
Changes since v3:
- New patch extracted from last patch of v3 series.
---
 drivers/fpga/dfl.c | 21 +++++++++++++--------
 drivers/fpga/dfl.h |  4 ++++
 2 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
index 094bba647085..46c1b2534430 100644
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


