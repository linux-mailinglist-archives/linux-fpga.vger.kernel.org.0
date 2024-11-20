Return-Path: <linux-fpga+bounces-960-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4D719D31BD
	for <lists+linux-fpga@lfdr.de>; Wed, 20 Nov 2024 02:13:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BEA60B24117
	for <lists+linux-fpga@lfdr.de>; Wed, 20 Nov 2024 01:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13937146A6B;
	Wed, 20 Nov 2024 01:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VjZTN+ld"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B6E12AAE2;
	Wed, 20 Nov 2024 01:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732065109; cv=none; b=pUjKuHm1jugQMroJUgRc4XH7XZIeHQkPH0DplaxPs9JsZV/dH7vet1knB/YoF4sUj2xWDxYhLi3JDoNW1cZb7izui9vzvjldC99dpC0P+K5oHZKwSHTavUJPCR/N9XwCfTRz1V+6Ud33nLVetvu/OK2e7knDGgE6udGvFYAjC30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732065109; c=relaxed/simple;
	bh=sNXXHqFchWNC6mrepd6nnWUfIEKr0naD0G0YbJ0UoD0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F+yKChmjEOjere0JxnBdb4UEe1tNT7zV6KttfevL6kViHC8588h1y6jo88FY4omzpDhmOdfoL4FBDcDBPDWRF7Uif0g6NDIF0H+oWTjWMgjg7EfBPL2Z8FsqgRjqfl/Fsy30w3pcl6jpZiRBk2n8z2c1RfszEZFEn4ZPj7ot4gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VjZTN+ld; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732065103; x=1763601103;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sNXXHqFchWNC6mrepd6nnWUfIEKr0naD0G0YbJ0UoD0=;
  b=VjZTN+ldJhut/8Kdj5c5lZM4UU+zosoMh5b5Z2GiAnFuFAu9IPkotzmu
   EkFM6Q3S/iSRmyqL1WKd8zkDyOehYwB5xEv88MrSehvysLYkR93fHLPAF
   Oweje8Y7getB8az2hy7AmU2FMSkQzSZOJacT+4mQac3p1Bu3o/M6YYGy9
   opAPjnsRm9uCRO6Yu++z6butZvvvGUgOwEILnQ9yGMoB1QDRAqq1FExiE
   86kjluUNncgG0vpP+lXr7r+qkd916wdcrtsbpSv679rW4hV8lvFOykuLr
   M60V/jxbcUPic7LJLchVyg/6H/Izw5RGL92VpmUGqbXYuVhtC0KiTIGuM
   A==;
X-CSE-ConnectionGUID: cvZ/lFPxReuWue4/78fY/Q==
X-CSE-MsgGUID: 89XRslJZSmqoXsH6eURwrw==
X-IronPort-AV: E=McAfee;i="6700,10204,11261"; a="42612994"
X-IronPort-AV: E=Sophos;i="6.12,168,1728975600"; 
   d="scan'208";a="42612994"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2024 17:11:40 -0800
X-CSE-ConnectionGUID: 0aAiJBoHQtKQmyPHgECdYg==
X-CSE-MsgGUID: Vk9apZwNTG6m40mzlZK0/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,168,1728975600"; 
   d="scan'208";a="93813589"
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
Subject: [PATCH v5 08/18] fpga: dfl: refactor internal DFL APIs to take/return feature device data
Date: Tue, 19 Nov 2024 20:10:24 -0500
Message-ID: <20241120011035.230574-9-peter.colberg@intel.com>
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

This change prepares a subsequent commit which factors out the DFL
enumeration info from the structure dfl_feature_platform_data into
a new structure dfl_feature_dev_data, whose lifetime is independent
of the feature device which will be destroyed during port release.

Add an alias dfl_feature_dev_data for dfl_feature_platform_data, and an
alias to_dfl_feature_dev_data() for dev_get_platdata(), and refactor
internal DFL APIs to take/return dfl_feature_dev_data instead. The
aliases will be replaced with implementations in a subsequent commit.

This change does not introduce any functional changes.

Signed-off-by: Peter Colberg <peter.colberg@intel.com>
Reviewed-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
Reviewed-by: Basheer Ahmed Muddebihal <basheer.ahmed.muddebihal@linux.intel.com>
Acked-by: Xu Yilun <yilun.xu@intel.com>
---
Changes since v4:
- No changes.

Changes since v3:
- Add "pdata" -> "fdata" substitution when looping over ports in
  dfl_fpga_feature_devs_remove(). This is now needed since the last
  patch of the v3 series has been broken up into many smaller patches,
  which retain and successively modify the loop until its final removal
  in the new, significantly smaller last patch.
- Replace "infos" with "info" in description.
- Replace "may be destroyed" with "will be destroyed" (during port
  release) in description.
- Replace generic "functions" with "internal DFL APIs" in description.

Changes since v2:
- New patch extracted from monolithic v1 patch.
---
 drivers/fpga/dfl-afu-dma-region.c | 110 ++++++------
 drivers/fpga/dfl-afu-error.c      |  60 +++----
 drivers/fpga/dfl-afu-main.c       | 276 +++++++++++++++---------------
 drivers/fpga/dfl-afu-region.c     |  48 +++---
 drivers/fpga/dfl-afu.h            |  26 +--
 drivers/fpga/dfl-fme-br.c         |  22 +--
 drivers/fpga/dfl-fme-error.c      | 102 +++++------
 drivers/fpga/dfl-fme-main.c       |  98 +++++------
 drivers/fpga/dfl-fme-pr.c         |  84 ++++-----
 drivers/fpga/dfl.c                | 182 ++++++++++----------
 drivers/fpga/dfl.h                |  77 +++++----
 11 files changed, 544 insertions(+), 541 deletions(-)

diff --git a/drivers/fpga/dfl-afu-dma-region.c b/drivers/fpga/dfl-afu-dma-region.c
index 814191e623e1..5aa7b8884374 100644
--- a/drivers/fpga/dfl-afu-dma-region.c
+++ b/drivers/fpga/dfl-afu-dma-region.c
@@ -16,26 +16,26 @@
 
 #include "dfl-afu.h"
 
-void afu_dma_region_init(struct dfl_feature_platform_data *pdata)
+void afu_dma_region_init(struct dfl_feature_dev_data *fdata)
 {
-	struct dfl_afu *afu = dfl_fpga_pdata_get_private(pdata);
+	struct dfl_afu *afu = dfl_fpga_fdata_get_private(fdata);
 
 	afu->dma_regions = RB_ROOT;
 }
 
 /**
  * afu_dma_pin_pages - pin pages of given dma memory region
- * @pdata: feature device platform data
+ * @fdata: feature dev data
  * @region: dma memory region to be pinned
  *
  * Pin all the pages of given dfl_afu_dma_region.
  * Return 0 for success or negative error code.
  */
-static int afu_dma_pin_pages(struct dfl_feature_platform_data *pdata,
+static int afu_dma_pin_pages(struct dfl_feature_dev_data *fdata,
 			     struct dfl_afu_dma_region *region)
 {
 	int npages = region->length >> PAGE_SHIFT;
-	struct device *dev = &pdata->dev->dev;
+	struct device *dev = &fdata->dev->dev;
 	int ret, pinned;
 
 	ret = account_locked_vm(current->mm, npages, true);
@@ -73,17 +73,17 @@ static int afu_dma_pin_pages(struct dfl_feature_platform_data *pdata,
 
 /**
  * afu_dma_unpin_pages - unpin pages of given dma memory region
- * @pdata: feature device platform data
+ * @fdata: feature dev data
  * @region: dma memory region to be unpinned
  *
  * Unpin all the pages of given dfl_afu_dma_region.
  * Return 0 for success or negative error code.
  */
-static void afu_dma_unpin_pages(struct dfl_feature_platform_data *pdata,
+static void afu_dma_unpin_pages(struct dfl_feature_dev_data *fdata,
 				struct dfl_afu_dma_region *region)
 {
 	long npages = region->length >> PAGE_SHIFT;
-	struct device *dev = &pdata->dev->dev;
+	struct device *dev = &fdata->dev->dev;
 
 	unpin_user_pages(region->pages, npages);
 	kfree(region->pages);
@@ -133,20 +133,20 @@ static bool dma_region_check_iova(struct dfl_afu_dma_region *region,
 
 /**
  * afu_dma_region_add - add given dma region to rbtree
- * @pdata: feature device platform data
+ * @fdata: feature dev data
  * @region: dma region to be added
  *
  * Return 0 for success, -EEXIST if dma region has already been added.
  *
- * Needs to be called with pdata->lock heold.
+ * Needs to be called with fdata->lock held.
  */
-static int afu_dma_region_add(struct dfl_feature_platform_data *pdata,
+static int afu_dma_region_add(struct dfl_feature_dev_data *fdata,
 			      struct dfl_afu_dma_region *region)
 {
-	struct dfl_afu *afu = dfl_fpga_pdata_get_private(pdata);
+	struct dfl_afu *afu = dfl_fpga_fdata_get_private(fdata);
 	struct rb_node **new, *parent = NULL;
 
-	dev_dbg(&pdata->dev->dev, "add region (iova = %llx)\n",
+	dev_dbg(&fdata->dev->dev, "add region (iova = %llx)\n",
 		(unsigned long long)region->iova);
 
 	new = &afu->dma_regions.rb_node;
@@ -177,50 +177,50 @@ static int afu_dma_region_add(struct dfl_feature_platform_data *pdata,
 
 /**
  * afu_dma_region_remove - remove given dma region from rbtree
- * @pdata: feature device platform data
+ * @fdata: feature dev data
  * @region: dma region to be removed
  *
- * Needs to be called with pdata->lock heold.
+ * Needs to be called with fdata->lock held.
  */
-static void afu_dma_region_remove(struct dfl_feature_platform_data *pdata,
+static void afu_dma_region_remove(struct dfl_feature_dev_data *fdata,
 				  struct dfl_afu_dma_region *region)
 {
 	struct dfl_afu *afu;
 
-	dev_dbg(&pdata->dev->dev, "del region (iova = %llx)\n",
+	dev_dbg(&fdata->dev->dev, "del region (iova = %llx)\n",
 		(unsigned long long)region->iova);
 
-	afu = dfl_fpga_pdata_get_private(pdata);
+	afu = dfl_fpga_fdata_get_private(fdata);
 	rb_erase(&region->node, &afu->dma_regions);
 }
 
 /**
  * afu_dma_region_destroy - destroy all regions in rbtree
- * @pdata: feature device platform data
+ * @fdata: feature dev data
  *
- * Needs to be called with pdata->lock heold.
+ * Needs to be called with fdata->lock held.
  */
-void afu_dma_region_destroy(struct dfl_feature_platform_data *pdata)
+void afu_dma_region_destroy(struct dfl_feature_dev_data *fdata)
 {
-	struct dfl_afu *afu = dfl_fpga_pdata_get_private(pdata);
+	struct dfl_afu *afu = dfl_fpga_fdata_get_private(fdata);
 	struct rb_node *node = rb_first(&afu->dma_regions);
 	struct dfl_afu_dma_region *region;
 
 	while (node) {
 		region = container_of(node, struct dfl_afu_dma_region, node);
 
-		dev_dbg(&pdata->dev->dev, "del region (iova = %llx)\n",
+		dev_dbg(&fdata->dev->dev, "del region (iova = %llx)\n",
 			(unsigned long long)region->iova);
 
 		rb_erase(node, &afu->dma_regions);
 
 		if (region->iova)
-			dma_unmap_page(dfl_fpga_pdata_to_parent(pdata),
+			dma_unmap_page(dfl_fpga_fdata_to_parent(fdata),
 				       region->iova, region->length,
 				       DMA_BIDIRECTIONAL);
 
 		if (region->pages)
-			afu_dma_unpin_pages(pdata, region);
+			afu_dma_unpin_pages(fdata, region);
 
 		node = rb_next(node);
 		kfree(region);
@@ -229,7 +229,7 @@ void afu_dma_region_destroy(struct dfl_feature_platform_data *pdata)
 
 /**
  * afu_dma_region_find - find the dma region from rbtree based on iova and size
- * @pdata: feature device platform data
+ * @fdata: feature dev data
  * @iova: address of the dma memory area
  * @size: size of the dma memory area
  *
@@ -239,14 +239,14 @@ void afu_dma_region_destroy(struct dfl_feature_platform_data *pdata)
  *   [@iova, @iova+size)
  * If nothing is matched returns NULL.
  *
- * Needs to be called with pdata->lock held.
+ * Needs to be called with fdata->lock held.
  */
 struct dfl_afu_dma_region *
-afu_dma_region_find(struct dfl_feature_platform_data *pdata, u64 iova, u64 size)
+afu_dma_region_find(struct dfl_feature_dev_data *fdata, u64 iova, u64 size)
 {
-	struct dfl_afu *afu = dfl_fpga_pdata_get_private(pdata);
+	struct dfl_afu *afu = dfl_fpga_fdata_get_private(fdata);
 	struct rb_node *node = afu->dma_regions.rb_node;
-	struct device *dev = &pdata->dev->dev;
+	struct device *dev = &fdata->dev->dev;
 
 	while (node) {
 		struct dfl_afu_dma_region *region;
@@ -276,20 +276,20 @@ afu_dma_region_find(struct dfl_feature_platform_data *pdata, u64 iova, u64 size)
 
 /**
  * afu_dma_region_find_iova - find the dma region from rbtree by iova
- * @pdata: feature device platform data
+ * @fdata: feature dev data
  * @iova: address of the dma region
  *
- * Needs to be called with pdata->lock held.
+ * Needs to be called with fdata->lock held.
  */
 static struct dfl_afu_dma_region *
-afu_dma_region_find_iova(struct dfl_feature_platform_data *pdata, u64 iova)
+afu_dma_region_find_iova(struct dfl_feature_dev_data *fdata, u64 iova)
 {
-	return afu_dma_region_find(pdata, iova, 0);
+	return afu_dma_region_find(fdata, iova, 0);
 }
 
 /**
  * afu_dma_map_region - map memory region for dma
- * @pdata: feature device platform data
+ * @fdata: feature dev data
  * @user_addr: address of the memory region
  * @length: size of the memory region
  * @iova: pointer of iova address
@@ -298,10 +298,10 @@ afu_dma_region_find_iova(struct dfl_feature_platform_data *pdata, u64 iova)
  * of the memory region via @iova.
  * Return 0 for success, otherwise error code.
  */
-int afu_dma_map_region(struct dfl_feature_platform_data *pdata,
+int afu_dma_map_region(struct dfl_feature_dev_data *fdata,
 		       u64 user_addr, u64 length, u64 *iova)
 {
-	struct device *dev = &pdata->dev->dev;
+	struct device *dev = &fdata->dev->dev;
 	struct dfl_afu_dma_region *region;
 	int ret;
 
@@ -324,7 +324,7 @@ int afu_dma_map_region(struct dfl_feature_platform_data *pdata,
 	region->length = length;
 
 	/* Pin the user memory region */
-	ret = afu_dma_pin_pages(pdata, region);
+	ret = afu_dma_pin_pages(fdata, region);
 	if (ret) {
 		dev_err(dev, "failed to pin memory region\n");
 		goto free_region;
@@ -338,11 +338,11 @@ int afu_dma_map_region(struct dfl_feature_platform_data *pdata,
 	}
 
 	/* As pages are continuous then start to do DMA mapping */
-	region->iova = dma_map_page(dfl_fpga_pdata_to_parent(pdata),
+	region->iova = dma_map_page(dfl_fpga_fdata_to_parent(fdata),
 				    region->pages[0], 0,
 				    region->length,
 				    DMA_BIDIRECTIONAL);
-	if (dma_mapping_error(dfl_fpga_pdata_to_parent(pdata), region->iova)) {
+	if (dma_mapping_error(dfl_fpga_fdata_to_parent(fdata), region->iova)) {
 		dev_err(dev, "failed to map for dma\n");
 		ret = -EFAULT;
 		goto unpin_pages;
@@ -350,9 +350,9 @@ int afu_dma_map_region(struct dfl_feature_platform_data *pdata,
 
 	*iova = region->iova;
 
-	mutex_lock(&pdata->lock);
-	ret = afu_dma_region_add(pdata, region);
-	mutex_unlock(&pdata->lock);
+	mutex_lock(&fdata->lock);
+	ret = afu_dma_region_add(fdata, region);
+	mutex_unlock(&fdata->lock);
 	if (ret) {
 		dev_err(dev, "failed to add dma region\n");
 		goto unmap_dma;
@@ -361,10 +361,10 @@ int afu_dma_map_region(struct dfl_feature_platform_data *pdata,
 	return 0;
 
 unmap_dma:
-	dma_unmap_page(dfl_fpga_pdata_to_parent(pdata),
+	dma_unmap_page(dfl_fpga_fdata_to_parent(fdata),
 		       region->iova, region->length, DMA_BIDIRECTIONAL);
 unpin_pages:
-	afu_dma_unpin_pages(pdata, region);
+	afu_dma_unpin_pages(fdata, region);
 free_region:
 	kfree(region);
 	return ret;
@@ -372,34 +372,34 @@ int afu_dma_map_region(struct dfl_feature_platform_data *pdata,
 
 /**
  * afu_dma_unmap_region - unmap dma memory region
- * @pdata: feature device platform data
+ * @fdata: feature dev data
  * @iova: dma address of the region
  *
  * Unmap dma memory region based on @iova.
  * Return 0 for success, otherwise error code.
  */
-int afu_dma_unmap_region(struct dfl_feature_platform_data *pdata, u64 iova)
+int afu_dma_unmap_region(struct dfl_feature_dev_data *fdata, u64 iova)
 {
 	struct dfl_afu_dma_region *region;
 
-	mutex_lock(&pdata->lock);
-	region = afu_dma_region_find_iova(pdata, iova);
+	mutex_lock(&fdata->lock);
+	region = afu_dma_region_find_iova(fdata, iova);
 	if (!region) {
-		mutex_unlock(&pdata->lock);
+		mutex_unlock(&fdata->lock);
 		return -EINVAL;
 	}
 
 	if (region->in_use) {
-		mutex_unlock(&pdata->lock);
+		mutex_unlock(&fdata->lock);
 		return -EBUSY;
 	}
 
-	afu_dma_region_remove(pdata, region);
-	mutex_unlock(&pdata->lock);
+	afu_dma_region_remove(fdata, region);
+	mutex_unlock(&fdata->lock);
 
-	dma_unmap_page(dfl_fpga_pdata_to_parent(pdata),
+	dma_unmap_page(dfl_fpga_fdata_to_parent(fdata),
 		       region->iova, region->length, DMA_BIDIRECTIONAL);
-	afu_dma_unpin_pages(pdata, region);
+	afu_dma_unpin_pages(fdata, region);
 	kfree(region);
 
 	return 0;
diff --git a/drivers/fpga/dfl-afu-error.c b/drivers/fpga/dfl-afu-error.c
index ad6ea19faaa0..0f392d1f6d45 100644
--- a/drivers/fpga/dfl-afu-error.c
+++ b/drivers/fpga/dfl-afu-error.c
@@ -28,36 +28,36 @@
 #define ERROR_MASK		GENMASK_ULL(63, 0)
 
 /* mask or unmask port errors by the error mask register. */
-static void __afu_port_err_mask(struct dfl_feature_platform_data *pdata, bool mask)
+static void __afu_port_err_mask(struct dfl_feature_dev_data *fdata, bool mask)
 {
 	void __iomem *base;
 
-	base = dfl_get_feature_ioaddr_by_id(pdata, PORT_FEATURE_ID_ERROR);
+	base = dfl_get_feature_ioaddr_by_id(fdata, PORT_FEATURE_ID_ERROR);
 
 	writeq(mask ? ERROR_MASK : 0, base + PORT_ERROR_MASK);
 }
 
 static void afu_port_err_mask(struct device *dev, bool mask)
 {
-	struct dfl_feature_platform_data *pdata = dev_get_platdata(dev);
+	struct dfl_feature_dev_data *fdata = to_dfl_feature_dev_data(dev);
 
-	mutex_lock(&pdata->lock);
-	__afu_port_err_mask(pdata, mask);
-	mutex_unlock(&pdata->lock);
+	mutex_lock(&fdata->lock);
+	__afu_port_err_mask(fdata, mask);
+	mutex_unlock(&fdata->lock);
 }
 
 /* clear port errors. */
 static int afu_port_err_clear(struct device *dev, u64 err)
 {
-	struct dfl_feature_platform_data *pdata = dev_get_platdata(dev);
+	struct dfl_feature_dev_data *fdata = to_dfl_feature_dev_data(dev);
 	void __iomem *base_err, *base_hdr;
 	int enable_ret = 0, ret = -EBUSY;
 	u64 v;
 
-	base_err = dfl_get_feature_ioaddr_by_id(pdata, PORT_FEATURE_ID_ERROR);
-	base_hdr = dfl_get_feature_ioaddr_by_id(pdata, PORT_FEATURE_ID_HEADER);
+	base_err = dfl_get_feature_ioaddr_by_id(fdata, PORT_FEATURE_ID_ERROR);
+	base_hdr = dfl_get_feature_ioaddr_by_id(fdata, PORT_FEATURE_ID_HEADER);
 
-	mutex_lock(&pdata->lock);
+	mutex_lock(&fdata->lock);
 
 	/*
 	 * clear Port Errors
@@ -79,12 +79,12 @@ static int afu_port_err_clear(struct device *dev, u64 err)
 	}
 
 	/* Halt Port by keeping Port in reset */
-	ret = __afu_port_disable(pdata);
+	ret = __afu_port_disable(fdata);
 	if (ret)
 		goto done;
 
 	/* Mask all errors */
-	__afu_port_err_mask(pdata, true);
+	__afu_port_err_mask(fdata, true);
 
 	/* Clear errors if err input matches with current port errors.*/
 	v = readq(base_err + PORT_ERROR);
@@ -101,28 +101,28 @@ static int afu_port_err_clear(struct device *dev, u64 err)
 	}
 
 	/* Clear mask */
-	__afu_port_err_mask(pdata, false);
+	__afu_port_err_mask(fdata, false);
 
 	/* Enable the Port by clearing the reset */
-	enable_ret = __afu_port_enable(pdata);
+	enable_ret = __afu_port_enable(fdata);
 
 done:
-	mutex_unlock(&pdata->lock);
+	mutex_unlock(&fdata->lock);
 	return enable_ret ? enable_ret : ret;
 }
 
 static ssize_t errors_show(struct device *dev, struct device_attribute *attr,
 			   char *buf)
 {
-	struct dfl_feature_platform_data *pdata = dev_get_platdata(dev);
+	struct dfl_feature_dev_data *fdata = to_dfl_feature_dev_data(dev);
 	void __iomem *base;
 	u64 error;
 
-	base = dfl_get_feature_ioaddr_by_id(pdata, PORT_FEATURE_ID_ERROR);
+	base = dfl_get_feature_ioaddr_by_id(fdata, PORT_FEATURE_ID_ERROR);
 
-	mutex_lock(&pdata->lock);
+	mutex_lock(&fdata->lock);
 	error = readq(base + PORT_ERROR);
-	mutex_unlock(&pdata->lock);
+	mutex_unlock(&fdata->lock);
 
 	return sprintf(buf, "0x%llx\n", (unsigned long long)error);
 }
@@ -145,15 +145,15 @@ static DEVICE_ATTR_RW(errors);
 static ssize_t first_error_show(struct device *dev,
 				struct device_attribute *attr, char *buf)
 {
-	struct dfl_feature_platform_data *pdata = dev_get_platdata(dev);
+	struct dfl_feature_dev_data *fdata = to_dfl_feature_dev_data(dev);
 	void __iomem *base;
 	u64 error;
 
-	base = dfl_get_feature_ioaddr_by_id(pdata, PORT_FEATURE_ID_ERROR);
+	base = dfl_get_feature_ioaddr_by_id(fdata, PORT_FEATURE_ID_ERROR);
 
-	mutex_lock(&pdata->lock);
+	mutex_lock(&fdata->lock);
 	error = readq(base + PORT_FIRST_ERROR);
-	mutex_unlock(&pdata->lock);
+	mutex_unlock(&fdata->lock);
 
 	return sprintf(buf, "0x%llx\n", (unsigned long long)error);
 }
@@ -163,16 +163,16 @@ static ssize_t first_malformed_req_show(struct device *dev,
 					struct device_attribute *attr,
 					char *buf)
 {
-	struct dfl_feature_platform_data *pdata = dev_get_platdata(dev);
+	struct dfl_feature_dev_data *fdata = to_dfl_feature_dev_data(dev);
 	void __iomem *base;
 	u64 req0, req1;
 
-	base = dfl_get_feature_ioaddr_by_id(pdata, PORT_FEATURE_ID_ERROR);
+	base = dfl_get_feature_ioaddr_by_id(fdata, PORT_FEATURE_ID_ERROR);
 
-	mutex_lock(&pdata->lock);
+	mutex_lock(&fdata->lock);
 	req0 = readq(base + PORT_MALFORMED_REQ0);
 	req1 = readq(base + PORT_MALFORMED_REQ1);
-	mutex_unlock(&pdata->lock);
+	mutex_unlock(&fdata->lock);
 
 	return sprintf(buf, "0x%016llx%016llx\n",
 		       (unsigned long long)req1, (unsigned long long)req0);
@@ -189,15 +189,15 @@ static struct attribute *port_err_attrs[] = {
 static umode_t port_err_attrs_visible(struct kobject *kobj,
 				      struct attribute *attr, int n)
 {
-	struct dfl_feature_platform_data *pdata;
 	struct device *dev = kobj_to_dev(kobj);
+	struct dfl_feature_dev_data *fdata;
 
-	pdata = dev_get_platdata(dev);
+	fdata = to_dfl_feature_dev_data(dev);
 	/*
 	 * sysfs entries are visible only if related private feature is
 	 * enumerated.
 	 */
-	if (!dfl_get_feature_by_id(pdata, PORT_FEATURE_ID_ERROR))
+	if (!dfl_get_feature_by_id(fdata, PORT_FEATURE_ID_ERROR))
 		return 0;
 
 	return attr->mode;
diff --git a/drivers/fpga/dfl-afu-main.c b/drivers/fpga/dfl-afu-main.c
index c86d01f49633..2049dadf2ee2 100644
--- a/drivers/fpga/dfl-afu-main.c
+++ b/drivers/fpga/dfl-afu-main.c
@@ -26,7 +26,7 @@
 
 /**
  * __afu_port_enable - enable a port by clear reset
- * @pdata: feature device platform data
+ * @fdata: port feature dev data.
  *
  * Enable Port by clear the port soft reset bit, which is set by default.
  * The AFU is unable to respond to any MMIO access while in reset.
@@ -35,17 +35,17 @@
  *
  * The caller needs to hold lock for protection.
  */
-int __afu_port_enable(struct dfl_feature_platform_data *pdata)
+int __afu_port_enable(struct dfl_feature_dev_data *fdata)
 {
 	void __iomem *base;
 	u64 v;
 
-	WARN_ON(!pdata->disable_count);
+	WARN_ON(!fdata->disable_count);
 
-	if (--pdata->disable_count != 0)
+	if (--fdata->disable_count != 0)
 		return 0;
 
-	base = dfl_get_feature_ioaddr_by_id(pdata, PORT_FEATURE_ID_HEADER);
+	base = dfl_get_feature_ioaddr_by_id(fdata, PORT_FEATURE_ID_HEADER);
 
 	/* Clear port soft reset */
 	v = readq(base + PORT_HDR_CTRL);
@@ -59,7 +59,7 @@ int __afu_port_enable(struct dfl_feature_platform_data *pdata)
 	if (readq_poll_timeout(base + PORT_HDR_CTRL, v,
 			       !(v & PORT_CTRL_SFTRST_ACK),
 			       RST_POLL_INVL, RST_POLL_TIMEOUT)) {
-		dev_err(pdata->dfl_cdev->parent,
+		dev_err(fdata->dfl_cdev->parent,
 			"timeout, failure to enable device\n");
 		return -ETIMEDOUT;
 	}
@@ -69,21 +69,21 @@ int __afu_port_enable(struct dfl_feature_platform_data *pdata)
 
 /**
  * __afu_port_disable - disable a port by hold reset
- * @pdata: feature device platform data
+ * @fdata: port feature dev data.
  *
  * Disable Port by setting the port soft reset bit, it puts the port into reset.
  *
  * The caller needs to hold lock for protection.
  */
-int __afu_port_disable(struct dfl_feature_platform_data *pdata)
+int __afu_port_disable(struct dfl_feature_dev_data *fdata)
 {
 	void __iomem *base;
 	u64 v;
 
-	if (pdata->disable_count++ != 0)
+	if (fdata->disable_count++ != 0)
 		return 0;
 
-	base = dfl_get_feature_ioaddr_by_id(pdata, PORT_FEATURE_ID_HEADER);
+	base = dfl_get_feature_ioaddr_by_id(fdata, PORT_FEATURE_ID_HEADER);
 
 	/* Set port soft reset */
 	v = readq(base + PORT_HDR_CTRL);
@@ -98,7 +98,7 @@ int __afu_port_disable(struct dfl_feature_platform_data *pdata)
 	if (readq_poll_timeout(base + PORT_HDR_CTRL, v,
 			       v & PORT_CTRL_SFTRST_ACK,
 			       RST_POLL_INVL, RST_POLL_TIMEOUT)) {
-		dev_err(pdata->dfl_cdev->parent,
+		dev_err(fdata->dfl_cdev->parent,
 			"timeout, failure to disable device\n");
 		return -ETIMEDOUT;
 	}
@@ -118,34 +118,34 @@ int __afu_port_disable(struct dfl_feature_platform_data *pdata)
  * (disabled). Any attempts on MMIO access to AFU while in reset, will
  * result errors reported via port error reporting sub feature (if present).
  */
-static int __port_reset(struct dfl_feature_platform_data *pdata)
+static int __port_reset(struct dfl_feature_dev_data *fdata)
 {
 	int ret;
 
-	ret = __afu_port_disable(pdata);
+	ret = __afu_port_disable(fdata);
 	if (ret)
 		return ret;
 
-	return __afu_port_enable(pdata);
+	return __afu_port_enable(fdata);
 }
 
 static int port_reset(struct platform_device *pdev)
 {
-	struct dfl_feature_platform_data *pdata = dev_get_platdata(&pdev->dev);
+	struct dfl_feature_dev_data *fdata = to_dfl_feature_dev_data(&pdev->dev);
 	int ret;
 
-	mutex_lock(&pdata->lock);
-	ret = __port_reset(pdata);
-	mutex_unlock(&pdata->lock);
+	mutex_lock(&fdata->lock);
+	ret = __port_reset(fdata);
+	mutex_unlock(&fdata->lock);
 
 	return ret;
 }
 
-static int port_get_id(struct dfl_feature_platform_data *pdata)
+static int port_get_id(struct dfl_feature_dev_data *fdata)
 {
 	void __iomem *base;
 
-	base = dfl_get_feature_ioaddr_by_id(pdata, PORT_FEATURE_ID_HEADER);
+	base = dfl_get_feature_ioaddr_by_id(fdata, PORT_FEATURE_ID_HEADER);
 
 	return FIELD_GET(PORT_CAP_PORT_NUM, readq(base + PORT_HDR_CAP));
 }
@@ -153,8 +153,8 @@ static int port_get_id(struct dfl_feature_platform_data *pdata)
 static ssize_t
 id_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
-	struct dfl_feature_platform_data *pdata = dev_get_platdata(dev);
-	int id = port_get_id(pdata);
+	struct dfl_feature_dev_data *fdata = to_dfl_feature_dev_data(dev);
+	int id = port_get_id(fdata);
 
 	return scnprintf(buf, PAGE_SIZE, "%d\n", id);
 }
@@ -163,15 +163,15 @@ static DEVICE_ATTR_RO(id);
 static ssize_t
 ltr_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
-	struct dfl_feature_platform_data *pdata = dev_get_platdata(dev);
+	struct dfl_feature_dev_data *fdata = to_dfl_feature_dev_data(dev);
 	void __iomem *base;
 	u64 v;
 
-	base = dfl_get_feature_ioaddr_by_id(pdata, PORT_FEATURE_ID_HEADER);
+	base = dfl_get_feature_ioaddr_by_id(fdata, PORT_FEATURE_ID_HEADER);
 
-	mutex_lock(&pdata->lock);
+	mutex_lock(&fdata->lock);
 	v = readq(base + PORT_HDR_CTRL);
-	mutex_unlock(&pdata->lock);
+	mutex_unlock(&fdata->lock);
 
 	return sprintf(buf, "%x\n", (u8)FIELD_GET(PORT_CTRL_LATENCY, v));
 }
@@ -180,7 +180,7 @@ static ssize_t
 ltr_store(struct device *dev, struct device_attribute *attr,
 	  const char *buf, size_t count)
 {
-	struct dfl_feature_platform_data *pdata = dev_get_platdata(dev);
+	struct dfl_feature_dev_data *fdata = to_dfl_feature_dev_data(dev);
 	void __iomem *base;
 	bool ltr;
 	u64 v;
@@ -188,14 +188,14 @@ ltr_store(struct device *dev, struct device_attribute *attr,
 	if (kstrtobool(buf, &ltr))
 		return -EINVAL;
 
-	base = dfl_get_feature_ioaddr_by_id(pdata, PORT_FEATURE_ID_HEADER);
+	base = dfl_get_feature_ioaddr_by_id(fdata, PORT_FEATURE_ID_HEADER);
 
-	mutex_lock(&pdata->lock);
+	mutex_lock(&fdata->lock);
 	v = readq(base + PORT_HDR_CTRL);
 	v &= ~PORT_CTRL_LATENCY;
 	v |= FIELD_PREP(PORT_CTRL_LATENCY, ltr ? 1 : 0);
 	writeq(v, base + PORT_HDR_CTRL);
-	mutex_unlock(&pdata->lock);
+	mutex_unlock(&fdata->lock);
 
 	return count;
 }
@@ -204,15 +204,15 @@ static DEVICE_ATTR_RW(ltr);
 static ssize_t
 ap1_event_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
-	struct dfl_feature_platform_data *pdata = dev_get_platdata(dev);
+	struct dfl_feature_dev_data *fdata = to_dfl_feature_dev_data(dev);
 	void __iomem *base;
 	u64 v;
 
-	base = dfl_get_feature_ioaddr_by_id(pdata, PORT_FEATURE_ID_HEADER);
+	base = dfl_get_feature_ioaddr_by_id(fdata, PORT_FEATURE_ID_HEADER);
 
-	mutex_lock(&pdata->lock);
+	mutex_lock(&fdata->lock);
 	v = readq(base + PORT_HDR_STS);
-	mutex_unlock(&pdata->lock);
+	mutex_unlock(&fdata->lock);
 
 	return sprintf(buf, "%x\n", (u8)FIELD_GET(PORT_STS_AP1_EVT, v));
 }
@@ -221,18 +221,18 @@ static ssize_t
 ap1_event_store(struct device *dev, struct device_attribute *attr,
 		const char *buf, size_t count)
 {
-	struct dfl_feature_platform_data *pdata = dev_get_platdata(dev);
+	struct dfl_feature_dev_data *fdata = to_dfl_feature_dev_data(dev);
 	void __iomem *base;
 	bool clear;
 
 	if (kstrtobool(buf, &clear) || !clear)
 		return -EINVAL;
 
-	base = dfl_get_feature_ioaddr_by_id(pdata, PORT_FEATURE_ID_HEADER);
+	base = dfl_get_feature_ioaddr_by_id(fdata, PORT_FEATURE_ID_HEADER);
 
-	mutex_lock(&pdata->lock);
+	mutex_lock(&fdata->lock);
 	writeq(PORT_STS_AP1_EVT, base + PORT_HDR_STS);
-	mutex_unlock(&pdata->lock);
+	mutex_unlock(&fdata->lock);
 
 	return count;
 }
@@ -242,15 +242,15 @@ static ssize_t
 ap2_event_show(struct device *dev, struct device_attribute *attr,
 	       char *buf)
 {
-	struct dfl_feature_platform_data *pdata = dev_get_platdata(dev);
+	struct dfl_feature_dev_data *fdata = to_dfl_feature_dev_data(dev);
 	void __iomem *base;
 	u64 v;
 
-	base = dfl_get_feature_ioaddr_by_id(pdata, PORT_FEATURE_ID_HEADER);
+	base = dfl_get_feature_ioaddr_by_id(fdata, PORT_FEATURE_ID_HEADER);
 
-	mutex_lock(&pdata->lock);
+	mutex_lock(&fdata->lock);
 	v = readq(base + PORT_HDR_STS);
-	mutex_unlock(&pdata->lock);
+	mutex_unlock(&fdata->lock);
 
 	return sprintf(buf, "%x\n", (u8)FIELD_GET(PORT_STS_AP2_EVT, v));
 }
@@ -259,18 +259,18 @@ static ssize_t
 ap2_event_store(struct device *dev, struct device_attribute *attr,
 		const char *buf, size_t count)
 {
-	struct dfl_feature_platform_data *pdata = dev_get_platdata(dev);
+	struct dfl_feature_dev_data *fdata = to_dfl_feature_dev_data(dev);
 	void __iomem *base;
 	bool clear;
 
 	if (kstrtobool(buf, &clear) || !clear)
 		return -EINVAL;
 
-	base = dfl_get_feature_ioaddr_by_id(pdata, PORT_FEATURE_ID_HEADER);
+	base = dfl_get_feature_ioaddr_by_id(fdata, PORT_FEATURE_ID_HEADER);
 
-	mutex_lock(&pdata->lock);
+	mutex_lock(&fdata->lock);
 	writeq(PORT_STS_AP2_EVT, base + PORT_HDR_STS);
-	mutex_unlock(&pdata->lock);
+	mutex_unlock(&fdata->lock);
 
 	return count;
 }
@@ -279,15 +279,15 @@ static DEVICE_ATTR_RW(ap2_event);
 static ssize_t
 power_state_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
-	struct dfl_feature_platform_data *pdata = dev_get_platdata(dev);
+	struct dfl_feature_dev_data *fdata = to_dfl_feature_dev_data(dev);
 	void __iomem *base;
 	u64 v;
 
-	base = dfl_get_feature_ioaddr_by_id(pdata, PORT_FEATURE_ID_HEADER);
+	base = dfl_get_feature_ioaddr_by_id(fdata, PORT_FEATURE_ID_HEADER);
 
-	mutex_lock(&pdata->lock);
+	mutex_lock(&fdata->lock);
 	v = readq(base + PORT_HDR_STS);
-	mutex_unlock(&pdata->lock);
+	mutex_unlock(&fdata->lock);
 
 	return sprintf(buf, "0x%x\n", (u8)FIELD_GET(PORT_STS_PWR_STATE, v));
 }
@@ -297,18 +297,18 @@ static ssize_t
 userclk_freqcmd_store(struct device *dev, struct device_attribute *attr,
 		      const char *buf, size_t count)
 {
-	struct dfl_feature_platform_data *pdata = dev_get_platdata(dev);
+	struct dfl_feature_dev_data *fdata = to_dfl_feature_dev_data(dev);
 	u64 userclk_freq_cmd;
 	void __iomem *base;
 
 	if (kstrtou64(buf, 0, &userclk_freq_cmd))
 		return -EINVAL;
 
-	base = dfl_get_feature_ioaddr_by_id(pdata, PORT_FEATURE_ID_HEADER);
+	base = dfl_get_feature_ioaddr_by_id(fdata, PORT_FEATURE_ID_HEADER);
 
-	mutex_lock(&pdata->lock);
+	mutex_lock(&fdata->lock);
 	writeq(userclk_freq_cmd, base + PORT_HDR_USRCLK_CMD0);
-	mutex_unlock(&pdata->lock);
+	mutex_unlock(&fdata->lock);
 
 	return count;
 }
@@ -318,18 +318,18 @@ static ssize_t
 userclk_freqcntrcmd_store(struct device *dev, struct device_attribute *attr,
 			  const char *buf, size_t count)
 {
-	struct dfl_feature_platform_data *pdata = dev_get_platdata(dev);
+	struct dfl_feature_dev_data *fdata = to_dfl_feature_dev_data(dev);
 	u64 userclk_freqcntr_cmd;
 	void __iomem *base;
 
 	if (kstrtou64(buf, 0, &userclk_freqcntr_cmd))
 		return -EINVAL;
 
-	base = dfl_get_feature_ioaddr_by_id(pdata, PORT_FEATURE_ID_HEADER);
+	base = dfl_get_feature_ioaddr_by_id(fdata, PORT_FEATURE_ID_HEADER);
 
-	mutex_lock(&pdata->lock);
+	mutex_lock(&fdata->lock);
 	writeq(userclk_freqcntr_cmd, base + PORT_HDR_USRCLK_CMD1);
-	mutex_unlock(&pdata->lock);
+	mutex_unlock(&fdata->lock);
 
 	return count;
 }
@@ -339,15 +339,15 @@ static ssize_t
 userclk_freqsts_show(struct device *dev, struct device_attribute *attr,
 		     char *buf)
 {
-	struct dfl_feature_platform_data *pdata = dev_get_platdata(dev);
+	struct dfl_feature_dev_data *fdata = to_dfl_feature_dev_data(dev);
 	u64 userclk_freqsts;
 	void __iomem *base;
 
-	base = dfl_get_feature_ioaddr_by_id(pdata, PORT_FEATURE_ID_HEADER);
+	base = dfl_get_feature_ioaddr_by_id(fdata, PORT_FEATURE_ID_HEADER);
 
-	mutex_lock(&pdata->lock);
+	mutex_lock(&fdata->lock);
 	userclk_freqsts = readq(base + PORT_HDR_USRCLK_STS0);
-	mutex_unlock(&pdata->lock);
+	mutex_unlock(&fdata->lock);
 
 	return sprintf(buf, "0x%llx\n", (unsigned long long)userclk_freqsts);
 }
@@ -357,15 +357,15 @@ static ssize_t
 userclk_freqcntrsts_show(struct device *dev, struct device_attribute *attr,
 			 char *buf)
 {
-	struct dfl_feature_platform_data *pdata = dev_get_platdata(dev);
+	struct dfl_feature_dev_data *fdata = to_dfl_feature_dev_data(dev);
 	u64 userclk_freqcntrsts;
 	void __iomem *base;
 
-	base = dfl_get_feature_ioaddr_by_id(pdata, PORT_FEATURE_ID_HEADER);
+	base = dfl_get_feature_ioaddr_by_id(fdata, PORT_FEATURE_ID_HEADER);
 
-	mutex_lock(&pdata->lock);
+	mutex_lock(&fdata->lock);
 	userclk_freqcntrsts = readq(base + PORT_HDR_USRCLK_STS1);
-	mutex_unlock(&pdata->lock);
+	mutex_unlock(&fdata->lock);
 
 	return sprintf(buf, "0x%llx\n",
 		       (unsigned long long)userclk_freqcntrsts);
@@ -388,13 +388,13 @@ static struct attribute *port_hdr_attrs[] = {
 static umode_t port_hdr_attrs_visible(struct kobject *kobj,
 				      struct attribute *attr, int n)
 {
-	struct dfl_feature_platform_data *pdata;
 	struct device *dev = kobj_to_dev(kobj);
+	struct dfl_feature_dev_data *fdata;
 	umode_t mode = attr->mode;
 	void __iomem *base;
 
-	pdata = dev_get_platdata(dev);
-	base = dfl_get_feature_ioaddr_by_id(pdata, PORT_FEATURE_ID_HEADER);
+	fdata = to_dfl_feature_dev_data(dev);
+	base = dfl_get_feature_ioaddr_by_id(fdata, PORT_FEATURE_ID_HEADER);
 
 	if (dfl_feature_revision(base) > 0) {
 		/*
@@ -459,21 +459,21 @@ static const struct dfl_feature_ops port_hdr_ops = {
 static ssize_t
 afu_id_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
-	struct dfl_feature_platform_data *pdata = dev_get_platdata(dev);
+	struct dfl_feature_dev_data *fdata = to_dfl_feature_dev_data(dev);
 	void __iomem *base;
 	u64 guidl, guidh;
 
-	base = dfl_get_feature_ioaddr_by_id(pdata, PORT_FEATURE_ID_AFU);
+	base = dfl_get_feature_ioaddr_by_id(fdata, PORT_FEATURE_ID_AFU);
 
-	mutex_lock(&pdata->lock);
-	if (pdata->disable_count) {
-		mutex_unlock(&pdata->lock);
+	mutex_lock(&fdata->lock);
+	if (fdata->disable_count) {
+		mutex_unlock(&fdata->lock);
 		return -EBUSY;
 	}
 
 	guidl = readq(base + GUID_L);
 	guidh = readq(base + GUID_H);
-	mutex_unlock(&pdata->lock);
+	mutex_unlock(&fdata->lock);
 
 	return scnprintf(buf, PAGE_SIZE, "%016llx%016llx\n", guidh, guidl);
 }
@@ -487,15 +487,15 @@ static struct attribute *port_afu_attrs[] = {
 static umode_t port_afu_attrs_visible(struct kobject *kobj,
 				      struct attribute *attr, int n)
 {
-	struct dfl_feature_platform_data *pdata;
 	struct device *dev = kobj_to_dev(kobj);
+	struct dfl_feature_dev_data *fdata;
 
-	pdata = dev_get_platdata(dev);
+	fdata = to_dfl_feature_dev_data(dev);
 	/*
 	 * sysfs entries are visible only if related private feature is
 	 * enumerated.
 	 */
-	if (!dfl_get_feature_by_id(pdata, PORT_FEATURE_ID_AFU))
+	if (!dfl_get_feature_by_id(fdata, PORT_FEATURE_ID_AFU))
 		return 0;
 
 	return attr->mode;
@@ -509,10 +509,10 @@ static const struct attribute_group port_afu_group = {
 static int port_afu_init(struct platform_device *pdev,
 			 struct dfl_feature *feature)
 {
-	struct dfl_feature_platform_data *pdata = dev_get_platdata(&pdev->dev);
+	struct dfl_feature_dev_data *fdata = to_dfl_feature_dev_data(&pdev->dev);
 	struct resource *res = &pdev->resource[feature->resource_index];
 
-	return afu_mmio_region_add(pdata,
+	return afu_mmio_region_add(fdata,
 				   DFL_PORT_REGION_INDEX_AFU,
 				   resource_size(res), res->start,
 				   DFL_PORT_REGION_MMAP | DFL_PORT_REGION_READ |
@@ -531,10 +531,10 @@ static const struct dfl_feature_ops port_afu_ops = {
 static int port_stp_init(struct platform_device *pdev,
 			 struct dfl_feature *feature)
 {
-	struct dfl_feature_platform_data *pdata = dev_get_platdata(&pdev->dev);
+	struct dfl_feature_dev_data *fdata = to_dfl_feature_dev_data(&pdev->dev);
 	struct resource *res = &pdev->resource[feature->resource_index];
 
-	return afu_mmio_region_add(pdata,
+	return afu_mmio_region_add(fdata,
 				   DFL_PORT_REGION_INDEX_STP,
 				   resource_size(res), res->start,
 				   DFL_PORT_REGION_MMAP | DFL_PORT_REGION_READ |
@@ -602,18 +602,18 @@ static struct dfl_feature_driver port_feature_drvs[] = {
 
 static int afu_open(struct inode *inode, struct file *filp)
 {
-	struct dfl_feature_platform_data *pdata = dfl_fpga_inode_to_feature_dev_data(inode);
-	struct platform_device *fdev = pdata->dev;
+	struct dfl_feature_dev_data *fdata = dfl_fpga_inode_to_feature_dev_data(inode);
+	struct platform_device *fdev = fdata->dev;
 	int ret;
 
-	mutex_lock(&pdata->lock);
-	ret = dfl_feature_dev_use_begin(pdata, filp->f_flags & O_EXCL);
+	mutex_lock(&fdata->lock);
+	ret = dfl_feature_dev_use_begin(fdata, filp->f_flags & O_EXCL);
 	if (!ret) {
 		dev_dbg(&fdev->dev, "Device File Opened %d Times\n",
-			dfl_feature_dev_use_count(pdata));
+			dfl_feature_dev_use_count(fdata));
 		filp->private_data = fdev;
 	}
-	mutex_unlock(&pdata->lock);
+	mutex_unlock(&fdata->lock);
 
 	return ret;
 }
@@ -621,29 +621,29 @@ static int afu_open(struct inode *inode, struct file *filp)
 static int afu_release(struct inode *inode, struct file *filp)
 {
 	struct platform_device *pdev = filp->private_data;
-	struct dfl_feature_platform_data *pdata;
+	struct dfl_feature_dev_data *fdata;
 	struct dfl_feature *feature;
 
 	dev_dbg(&pdev->dev, "Device File Release\n");
 
-	pdata = dev_get_platdata(&pdev->dev);
+	fdata = to_dfl_feature_dev_data(&pdev->dev);
 
-	mutex_lock(&pdata->lock);
-	dfl_feature_dev_use_end(pdata);
+	mutex_lock(&fdata->lock);
+	dfl_feature_dev_use_end(fdata);
 
-	if (!dfl_feature_dev_use_count(pdata)) {
-		dfl_fpga_dev_for_each_feature(pdata, feature)
+	if (!dfl_feature_dev_use_count(fdata)) {
+		dfl_fpga_dev_for_each_feature(fdata, feature)
 			dfl_fpga_set_irq_triggers(feature, 0,
 						  feature->nr_irqs, NULL);
-		__port_reset(pdata);
-		afu_dma_region_destroy(pdata);
+		__port_reset(fdata);
+		afu_dma_region_destroy(fdata);
 	}
-	mutex_unlock(&pdata->lock);
+	mutex_unlock(&fdata->lock);
 
 	return 0;
 }
 
-static long afu_ioctl_check_extension(struct dfl_feature_platform_data *pdata,
+static long afu_ioctl_check_extension(struct dfl_feature_dev_data *fdata,
 				      unsigned long arg)
 {
 	/* No extension support for now */
@@ -651,7 +651,7 @@ static long afu_ioctl_check_extension(struct dfl_feature_platform_data *pdata,
 }
 
 static long
-afu_ioctl_get_info(struct dfl_feature_platform_data *pdata, void __user *arg)
+afu_ioctl_get_info(struct dfl_feature_dev_data *fdata, void __user *arg)
 {
 	struct dfl_fpga_port_info info;
 	struct dfl_afu *afu;
@@ -665,12 +665,12 @@ afu_ioctl_get_info(struct dfl_feature_platform_data *pdata, void __user *arg)
 	if (info.argsz < minsz)
 		return -EINVAL;
 
-	mutex_lock(&pdata->lock);
-	afu = dfl_fpga_pdata_get_private(pdata);
+	mutex_lock(&fdata->lock);
+	afu = dfl_fpga_fdata_get_private(fdata);
 	info.flags = 0;
 	info.num_regions = afu->num_regions;
 	info.num_umsgs = afu->num_umsgs;
-	mutex_unlock(&pdata->lock);
+	mutex_unlock(&fdata->lock);
 
 	if (copy_to_user(arg, &info, sizeof(info)))
 		return -EFAULT;
@@ -678,7 +678,7 @@ afu_ioctl_get_info(struct dfl_feature_platform_data *pdata, void __user *arg)
 	return 0;
 }
 
-static long afu_ioctl_get_region_info(struct dfl_feature_platform_data *pdata,
+static long afu_ioctl_get_region_info(struct dfl_feature_dev_data *fdata,
 				      void __user *arg)
 {
 	struct dfl_fpga_port_region_info rinfo;
@@ -694,7 +694,7 @@ static long afu_ioctl_get_region_info(struct dfl_feature_platform_data *pdata,
 	if (rinfo.argsz < minsz || rinfo.padding)
 		return -EINVAL;
 
-	ret = afu_mmio_region_get_by_index(pdata, rinfo.index, &region);
+	ret = afu_mmio_region_get_by_index(fdata, rinfo.index, &region);
 	if (ret)
 		return ret;
 
@@ -709,7 +709,7 @@ static long afu_ioctl_get_region_info(struct dfl_feature_platform_data *pdata,
 }
 
 static long
-afu_ioctl_dma_map(struct dfl_feature_platform_data *pdata, void __user *arg)
+afu_ioctl_dma_map(struct dfl_feature_dev_data *fdata, void __user *arg)
 {
 	struct dfl_fpga_port_dma_map map;
 	unsigned long minsz;
@@ -723,16 +723,16 @@ afu_ioctl_dma_map(struct dfl_feature_platform_data *pdata, void __user *arg)
 	if (map.argsz < minsz || map.flags)
 		return -EINVAL;
 
-	ret = afu_dma_map_region(pdata, map.user_addr, map.length, &map.iova);
+	ret = afu_dma_map_region(fdata, map.user_addr, map.length, &map.iova);
 	if (ret)
 		return ret;
 
 	if (copy_to_user(arg, &map, sizeof(map))) {
-		afu_dma_unmap_region(pdata, map.iova);
+		afu_dma_unmap_region(fdata, map.iova);
 		return -EFAULT;
 	}
 
-	dev_dbg(&pdata->dev->dev, "dma map: ua=%llx, len=%llx, iova=%llx\n",
+	dev_dbg(&fdata->dev->dev, "dma map: ua=%llx, len=%llx, iova=%llx\n",
 		(unsigned long long)map.user_addr,
 		(unsigned long long)map.length,
 		(unsigned long long)map.iova);
@@ -741,7 +741,7 @@ afu_ioctl_dma_map(struct dfl_feature_platform_data *pdata, void __user *arg)
 }
 
 static long
-afu_ioctl_dma_unmap(struct dfl_feature_platform_data *pdata, void __user *arg)
+afu_ioctl_dma_unmap(struct dfl_feature_dev_data *fdata, void __user *arg)
 {
 	struct dfl_fpga_port_dma_unmap unmap;
 	unsigned long minsz;
@@ -754,33 +754,33 @@ afu_ioctl_dma_unmap(struct dfl_feature_platform_data *pdata, void __user *arg)
 	if (unmap.argsz < minsz || unmap.flags)
 		return -EINVAL;
 
-	return afu_dma_unmap_region(pdata, unmap.iova);
+	return afu_dma_unmap_region(fdata, unmap.iova);
 }
 
 static long afu_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 {
 	struct platform_device *pdev = filp->private_data;
-	struct dfl_feature_platform_data *pdata;
+	struct dfl_feature_dev_data *fdata;
 	struct dfl_feature *f;
 	long ret;
 
 	dev_dbg(&pdev->dev, "%s cmd 0x%x\n", __func__, cmd);
 
-	pdata = dev_get_platdata(&pdev->dev);
+	fdata = to_dfl_feature_dev_data(&pdev->dev);
 
 	switch (cmd) {
 	case DFL_FPGA_GET_API_VERSION:
 		return DFL_FPGA_API_VERSION;
 	case DFL_FPGA_CHECK_EXTENSION:
-		return afu_ioctl_check_extension(pdata, arg);
+		return afu_ioctl_check_extension(fdata, arg);
 	case DFL_FPGA_PORT_GET_INFO:
-		return afu_ioctl_get_info(pdata, (void __user *)arg);
+		return afu_ioctl_get_info(fdata, (void __user *)arg);
 	case DFL_FPGA_PORT_GET_REGION_INFO:
-		return afu_ioctl_get_region_info(pdata, (void __user *)arg);
+		return afu_ioctl_get_region_info(fdata, (void __user *)arg);
 	case DFL_FPGA_PORT_DMA_MAP:
-		return afu_ioctl_dma_map(pdata, (void __user *)arg);
+		return afu_ioctl_dma_map(fdata, (void __user *)arg);
 	case DFL_FPGA_PORT_DMA_UNMAP:
-		return afu_ioctl_dma_unmap(pdata, (void __user *)arg);
+		return afu_ioctl_dma_unmap(fdata, (void __user *)arg);
 	default:
 		/*
 		 * Let sub-feature's ioctl function to handle the cmd
@@ -788,7 +788,7 @@ static long afu_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 		 * handled in this sub feature, and returns 0 and other
 		 * error code if cmd is handled.
 		 */
-		dfl_fpga_dev_for_each_feature(pdata, f)
+		dfl_fpga_dev_for_each_feature(fdata, f)
 			if (f->ops && f->ops->ioctl) {
 				ret = f->ops->ioctl(pdev, f, cmd, arg);
 				if (ret != -ENODEV)
@@ -808,8 +808,8 @@ static const struct vm_operations_struct afu_vma_ops = {
 static int afu_mmap(struct file *filp, struct vm_area_struct *vma)
 {
 	struct platform_device *pdev = filp->private_data;
-	struct dfl_feature_platform_data *pdata;
 	u64 size = vma->vm_end - vma->vm_start;
+	struct dfl_feature_dev_data *fdata;
 	struct dfl_afu_mmio_region region;
 	u64 offset;
 	int ret;
@@ -817,10 +817,10 @@ static int afu_mmap(struct file *filp, struct vm_area_struct *vma)
 	if (!(vma->vm_flags & VM_SHARED))
 		return -EINVAL;
 
-	pdata = dev_get_platdata(&pdev->dev);
+	fdata = to_dfl_feature_dev_data(&pdev->dev);
 
 	offset = vma->vm_pgoff << PAGE_SHIFT;
-	ret = afu_mmio_region_get_by_offset(pdata, offset, size, &region);
+	ret = afu_mmio_region_get_by_offset(fdata, offset, size, &region);
 	if (ret)
 		return ret;
 
@@ -854,45 +854,45 @@ static const struct file_operations afu_fops = {
 
 static int afu_dev_init(struct platform_device *pdev)
 {
-	struct dfl_feature_platform_data *pdata = dev_get_platdata(&pdev->dev);
+	struct dfl_feature_dev_data *fdata = to_dfl_feature_dev_data(&pdev->dev);
 	struct dfl_afu *afu;
 
 	afu = devm_kzalloc(&pdev->dev, sizeof(*afu), GFP_KERNEL);
 	if (!afu)
 		return -ENOMEM;
 
-	mutex_lock(&pdata->lock);
-	dfl_fpga_pdata_set_private(pdata, afu);
-	afu_mmio_region_init(pdata);
-	afu_dma_region_init(pdata);
-	mutex_unlock(&pdata->lock);
+	mutex_lock(&fdata->lock);
+	dfl_fpga_fdata_set_private(fdata, afu);
+	afu_mmio_region_init(fdata);
+	afu_dma_region_init(fdata);
+	mutex_unlock(&fdata->lock);
 
 	return 0;
 }
 
 static int afu_dev_destroy(struct platform_device *pdev)
 {
-	struct dfl_feature_platform_data *pdata = dev_get_platdata(&pdev->dev);
+	struct dfl_feature_dev_data *fdata = to_dfl_feature_dev_data(&pdev->dev);
 
-	mutex_lock(&pdata->lock);
-	afu_mmio_region_destroy(pdata);
-	afu_dma_region_destroy(pdata);
-	dfl_fpga_pdata_set_private(pdata, NULL);
-	mutex_unlock(&pdata->lock);
+	mutex_lock(&fdata->lock);
+	afu_mmio_region_destroy(fdata);
+	afu_dma_region_destroy(fdata);
+	dfl_fpga_fdata_set_private(fdata, NULL);
+	mutex_unlock(&fdata->lock);
 
 	return 0;
 }
 
-static int port_enable_set(struct dfl_feature_platform_data *pdata, bool enable)
+static int port_enable_set(struct dfl_feature_dev_data *fdata, bool enable)
 {
 	int ret;
 
-	mutex_lock(&pdata->lock);
+	mutex_lock(&fdata->lock);
 	if (enable)
-		ret = __afu_port_enable(pdata);
+		ret = __afu_port_enable(fdata);
 	else
-		ret = __afu_port_disable(pdata);
-	mutex_unlock(&pdata->lock);
+		ret = __afu_port_disable(fdata);
+	mutex_unlock(&fdata->lock);
 
 	return ret;
 }
diff --git a/drivers/fpga/dfl-afu-region.c b/drivers/fpga/dfl-afu-region.c
index 8f0e9485214a..b11a5b21e666 100644
--- a/drivers/fpga/dfl-afu-region.c
+++ b/drivers/fpga/dfl-afu-region.c
@@ -12,11 +12,11 @@
 
 /**
  * afu_mmio_region_init - init function for afu mmio region support
- * @pdata: afu platform device's pdata.
+ * @fdata: afu feature dev data
  */
-void afu_mmio_region_init(struct dfl_feature_platform_data *pdata)
+void afu_mmio_region_init(struct dfl_feature_dev_data *fdata)
 {
-	struct dfl_afu *afu = dfl_fpga_pdata_get_private(pdata);
+	struct dfl_afu *afu = dfl_fpga_fdata_get_private(fdata);
 
 	INIT_LIST_HEAD(&afu->regions);
 }
@@ -39,7 +39,7 @@ static struct dfl_afu_mmio_region *get_region_by_index(struct dfl_afu *afu,
 /**
  * afu_mmio_region_add - add a mmio region to given feature dev.
  *
- * @pdata: afu platform device's pdata.
+ * @fdata: afu feature dev data
  * @region_index: region index.
  * @region_size: region size.
  * @phys: region's physical address of this region.
@@ -47,10 +47,10 @@ static struct dfl_afu_mmio_region *get_region_by_index(struct dfl_afu *afu,
  *
  * Return: 0 on success, negative error code otherwise.
  */
-int afu_mmio_region_add(struct dfl_feature_platform_data *pdata,
+int afu_mmio_region_add(struct dfl_feature_dev_data *fdata,
 			u32 region_index, u64 region_size, u64 phys, u32 flags)
 {
-	struct device *dev = &pdata->dev->dev;
+	struct device *dev = &fdata->dev->dev;
 	struct dfl_afu_mmio_region *region;
 	struct dfl_afu *afu;
 	int ret = 0;
@@ -64,13 +64,13 @@ int afu_mmio_region_add(struct dfl_feature_platform_data *pdata,
 	region->phys = phys;
 	region->flags = flags;
 
-	mutex_lock(&pdata->lock);
+	mutex_lock(&fdata->lock);
 
-	afu = dfl_fpga_pdata_get_private(pdata);
+	afu = dfl_fpga_fdata_get_private(fdata);
 
 	/* check if @index already exists */
 	if (get_region_by_index(afu, region_index)) {
-		mutex_unlock(&pdata->lock);
+		mutex_unlock(&fdata->lock);
 		ret = -EEXIST;
 		goto exit;
 	}
@@ -81,7 +81,7 @@ int afu_mmio_region_add(struct dfl_feature_platform_data *pdata,
 
 	afu->region_cur_offset += region_size;
 	afu->num_regions++;
-	mutex_unlock(&pdata->lock);
+	mutex_unlock(&fdata->lock);
 
 	return 0;
 
@@ -92,26 +92,26 @@ int afu_mmio_region_add(struct dfl_feature_platform_data *pdata,
 
 /**
  * afu_mmio_region_destroy - destroy all mmio regions under given feature dev.
- * @pdata: afu platform device's pdata.
+ * @fdata: afu feature dev data
  */
-void afu_mmio_region_destroy(struct dfl_feature_platform_data *pdata)
+void afu_mmio_region_destroy(struct dfl_feature_dev_data *fdata)
 {
-	struct dfl_afu *afu = dfl_fpga_pdata_get_private(pdata);
+	struct dfl_afu *afu = dfl_fpga_fdata_get_private(fdata);
 	struct dfl_afu_mmio_region *tmp, *region;
 
 	list_for_each_entry_safe(region, tmp, &afu->regions, node)
-		devm_kfree(&pdata->dev->dev, region);
+		devm_kfree(&fdata->dev->dev, region);
 }
 
 /**
  * afu_mmio_region_get_by_index - find an afu region by index.
- * @pdata: afu platform device's pdata.
+ * @fdata: afu feature dev data
  * @region_index: region index.
  * @pregion: ptr to region for result.
  *
  * Return: 0 on success, negative error code otherwise.
  */
-int afu_mmio_region_get_by_index(struct dfl_feature_platform_data *pdata,
+int afu_mmio_region_get_by_index(struct dfl_feature_dev_data *fdata,
 				 u32 region_index,
 				 struct dfl_afu_mmio_region *pregion)
 {
@@ -119,8 +119,8 @@ int afu_mmio_region_get_by_index(struct dfl_feature_platform_data *pdata,
 	struct dfl_afu *afu;
 	int ret = 0;
 
-	mutex_lock(&pdata->lock);
-	afu = dfl_fpga_pdata_get_private(pdata);
+	mutex_lock(&fdata->lock);
+	afu = dfl_fpga_fdata_get_private(fdata);
 	region = get_region_by_index(afu, region_index);
 	if (!region) {
 		ret = -EINVAL;
@@ -128,14 +128,14 @@ int afu_mmio_region_get_by_index(struct dfl_feature_platform_data *pdata,
 	}
 	*pregion = *region;
 exit:
-	mutex_unlock(&pdata->lock);
+	mutex_unlock(&fdata->lock);
 	return ret;
 }
 
 /**
  * afu_mmio_region_get_by_offset - find an afu mmio region by offset and size
  *
- * @pdata: afu platform device's pdata.
+ * @fdata: afu feature dev data
  * @offset: region offset from start of the device fd.
  * @size: region size.
  * @pregion: ptr to region for result.
@@ -145,7 +145,7 @@ int afu_mmio_region_get_by_index(struct dfl_feature_platform_data *pdata,
  *
  * Return: 0 on success, negative error code otherwise.
  */
-int afu_mmio_region_get_by_offset(struct dfl_feature_platform_data *pdata,
+int afu_mmio_region_get_by_offset(struct dfl_feature_dev_data *fdata,
 				  u64 offset, u64 size,
 				  struct dfl_afu_mmio_region *pregion)
 {
@@ -153,8 +153,8 @@ int afu_mmio_region_get_by_offset(struct dfl_feature_platform_data *pdata,
 	struct dfl_afu *afu;
 	int ret = 0;
 
-	mutex_lock(&pdata->lock);
-	afu = dfl_fpga_pdata_get_private(pdata);
+	mutex_lock(&fdata->lock);
+	afu = dfl_fpga_fdata_get_private(fdata);
 	for_each_region(region, afu)
 		if (region->offset <= offset &&
 		    region->offset + region->size >= offset + size) {
@@ -163,6 +163,6 @@ int afu_mmio_region_get_by_offset(struct dfl_feature_platform_data *pdata,
 		}
 	ret = -EINVAL;
 exit:
-	mutex_unlock(&pdata->lock);
+	mutex_unlock(&fdata->lock);
 	return ret;
 }
diff --git a/drivers/fpga/dfl-afu.h b/drivers/fpga/dfl-afu.h
index 6d1e79240c70..03be4f0969c7 100644
--- a/drivers/fpga/dfl-afu.h
+++ b/drivers/fpga/dfl-afu.h
@@ -76,27 +76,27 @@ struct dfl_afu {
 	struct rb_root dma_regions;
 };
 
-/* hold pdata->lock when call __afu_port_enable/disable */
-int __afu_port_enable(struct dfl_feature_platform_data *pdata);
-int __afu_port_disable(struct dfl_feature_platform_data *pdata);
+/* hold fdata->lock when call __afu_port_enable/disable */
+int __afu_port_enable(struct dfl_feature_dev_data *fdata);
+int __afu_port_disable(struct dfl_feature_dev_data *fdata);
 
-void afu_mmio_region_init(struct dfl_feature_platform_data *pdata);
-int afu_mmio_region_add(struct dfl_feature_platform_data *pdata,
+void afu_mmio_region_init(struct dfl_feature_dev_data *fdata);
+int afu_mmio_region_add(struct dfl_feature_dev_data *fdata,
 			u32 region_index, u64 region_size, u64 phys, u32 flags);
-void afu_mmio_region_destroy(struct dfl_feature_platform_data *pdata);
-int afu_mmio_region_get_by_index(struct dfl_feature_platform_data *pdata,
+void afu_mmio_region_destroy(struct dfl_feature_dev_data *fdata);
+int afu_mmio_region_get_by_index(struct dfl_feature_dev_data *fdata,
 				 u32 region_index,
 				 struct dfl_afu_mmio_region *pregion);
-int afu_mmio_region_get_by_offset(struct dfl_feature_platform_data *pdata,
+int afu_mmio_region_get_by_offset(struct dfl_feature_dev_data *fdata,
 				  u64 offset, u64 size,
 				  struct dfl_afu_mmio_region *pregion);
-void afu_dma_region_init(struct dfl_feature_platform_data *pdata);
-void afu_dma_region_destroy(struct dfl_feature_platform_data *pdata);
-int afu_dma_map_region(struct dfl_feature_platform_data *pdata,
+void afu_dma_region_init(struct dfl_feature_dev_data *fdata);
+void afu_dma_region_destroy(struct dfl_feature_dev_data *fdata);
+int afu_dma_map_region(struct dfl_feature_dev_data *fdata,
 		       u64 user_addr, u64 length, u64 *iova);
-int afu_dma_unmap_region(struct dfl_feature_platform_data *pdata, u64 iova);
+int afu_dma_unmap_region(struct dfl_feature_dev_data *fdata, u64 iova);
 struct dfl_afu_dma_region *
-afu_dma_region_find(struct dfl_feature_platform_data *pdata,
+afu_dma_region_find(struct dfl_feature_dev_data *fdata,
 		    u64 iova, u64 size);
 
 extern const struct dfl_feature_ops port_err_ops;
diff --git a/drivers/fpga/dfl-fme-br.c b/drivers/fpga/dfl-fme-br.c
index c19ddb02a161..5c60a38ec76c 100644
--- a/drivers/fpga/dfl-fme-br.c
+++ b/drivers/fpga/dfl-fme-br.c
@@ -22,34 +22,34 @@
 struct fme_br_priv {
 	struct dfl_fme_br_pdata *pdata;
 	struct dfl_fpga_port_ops *port_ops;
-	struct dfl_feature_platform_data *port_pdata;
+	struct dfl_feature_dev_data *port_fdata;
 };
 
 static int fme_bridge_enable_set(struct fpga_bridge *bridge, bool enable)
 {
-	struct dfl_feature_platform_data *port_pdata;
 	struct fme_br_priv *priv = bridge->priv;
+	struct dfl_feature_dev_data *port_fdata;
 	struct dfl_fpga_port_ops *ops;
 
-	if (!priv->port_pdata) {
-		port_pdata = dfl_fpga_cdev_find_port_data(priv->pdata->cdev,
+	if (!priv->port_fdata) {
+		port_fdata = dfl_fpga_cdev_find_port_data(priv->pdata->cdev,
 							  &priv->pdata->port_id,
 							  dfl_fpga_check_port_id);
-		if (!port_pdata)
+		if (!port_fdata)
 			return -ENODEV;
 
-		priv->port_pdata = port_pdata;
+		priv->port_fdata = port_fdata;
 	}
 
-	if (priv->port_pdata && !priv->port_ops) {
-		ops = dfl_fpga_port_ops_get(priv->port_pdata);
+	if (priv->port_fdata && !priv->port_ops) {
+		ops = dfl_fpga_port_ops_get(priv->port_fdata);
 		if (!ops || !ops->enable_set)
 			return -ENOENT;
 
 		priv->port_ops = ops;
 	}
 
-	return priv->port_ops->enable_set(priv->port_pdata, enable);
+	return priv->port_ops->enable_set(priv->port_fdata, enable);
 }
 
 static const struct fpga_bridge_ops fme_bridge_ops = {
@@ -85,8 +85,8 @@ static void fme_br_remove(struct platform_device *pdev)
 
 	fpga_bridge_unregister(br);
 
-	if (priv->port_pdata)
-		put_device(&priv->port_pdata->dev->dev);
+	if (priv->port_fdata)
+		put_device(&priv->port_fdata->dev->dev);
 	if (priv->port_ops)
 		dfl_fpga_port_ops_put(priv->port_ops);
 }
diff --git a/drivers/fpga/dfl-fme-error.c b/drivers/fpga/dfl-fme-error.c
index 39b8e3b450d7..f00d949efe69 100644
--- a/drivers/fpga/dfl-fme-error.c
+++ b/drivers/fpga/dfl-fme-error.c
@@ -42,15 +42,15 @@
 static ssize_t pcie0_errors_show(struct device *dev,
 				 struct device_attribute *attr, char *buf)
 {
-	struct dfl_feature_platform_data *pdata = dev_get_platdata(dev);
+	struct dfl_feature_dev_data *fdata = to_dfl_feature_dev_data(dev);
 	void __iomem *base;
 	u64 value;
 
-	base = dfl_get_feature_ioaddr_by_id(pdata, FME_FEATURE_ID_GLOBAL_ERR);
+	base = dfl_get_feature_ioaddr_by_id(fdata, FME_FEATURE_ID_GLOBAL_ERR);
 
-	mutex_lock(&pdata->lock);
+	mutex_lock(&fdata->lock);
 	value = readq(base + PCIE0_ERROR);
-	mutex_unlock(&pdata->lock);
+	mutex_unlock(&fdata->lock);
 
 	return sprintf(buf, "0x%llx\n", (unsigned long long)value);
 }
@@ -59,7 +59,7 @@ static ssize_t pcie0_errors_store(struct device *dev,
 				  struct device_attribute *attr,
 				  const char *buf, size_t count)
 {
-	struct dfl_feature_platform_data *pdata = dev_get_platdata(dev);
+	struct dfl_feature_dev_data *fdata = to_dfl_feature_dev_data(dev);
 	void __iomem *base;
 	int ret = 0;
 	u64 v, val;
@@ -67,9 +67,9 @@ static ssize_t pcie0_errors_store(struct device *dev,
 	if (kstrtou64(buf, 0, &val))
 		return -EINVAL;
 
-	base = dfl_get_feature_ioaddr_by_id(pdata, FME_FEATURE_ID_GLOBAL_ERR);
+	base = dfl_get_feature_ioaddr_by_id(fdata, FME_FEATURE_ID_GLOBAL_ERR);
 
-	mutex_lock(&pdata->lock);
+	mutex_lock(&fdata->lock);
 	writeq(GENMASK_ULL(63, 0), base + PCIE0_ERROR_MASK);
 
 	v = readq(base + PCIE0_ERROR);
@@ -79,7 +79,7 @@ static ssize_t pcie0_errors_store(struct device *dev,
 		ret = -EINVAL;
 
 	writeq(0ULL, base + PCIE0_ERROR_MASK);
-	mutex_unlock(&pdata->lock);
+	mutex_unlock(&fdata->lock);
 	return ret ? ret : count;
 }
 static DEVICE_ATTR_RW(pcie0_errors);
@@ -87,15 +87,15 @@ static DEVICE_ATTR_RW(pcie0_errors);
 static ssize_t pcie1_errors_show(struct device *dev,
 				 struct device_attribute *attr, char *buf)
 {
-	struct dfl_feature_platform_data *pdata = dev_get_platdata(dev);
+	struct dfl_feature_dev_data *fdata = to_dfl_feature_dev_data(dev);
 	void __iomem *base;
 	u64 value;
 
-	base = dfl_get_feature_ioaddr_by_id(pdata, FME_FEATURE_ID_GLOBAL_ERR);
+	base = dfl_get_feature_ioaddr_by_id(fdata, FME_FEATURE_ID_GLOBAL_ERR);
 
-	mutex_lock(&pdata->lock);
+	mutex_lock(&fdata->lock);
 	value = readq(base + PCIE1_ERROR);
-	mutex_unlock(&pdata->lock);
+	mutex_unlock(&fdata->lock);
 
 	return sprintf(buf, "0x%llx\n", (unsigned long long)value);
 }
@@ -104,7 +104,7 @@ static ssize_t pcie1_errors_store(struct device *dev,
 				  struct device_attribute *attr,
 				  const char *buf, size_t count)
 {
-	struct dfl_feature_platform_data *pdata = dev_get_platdata(dev);
+	struct dfl_feature_dev_data *fdata = to_dfl_feature_dev_data(dev);
 	void __iomem *base;
 	int ret = 0;
 	u64 v, val;
@@ -112,9 +112,9 @@ static ssize_t pcie1_errors_store(struct device *dev,
 	if (kstrtou64(buf, 0, &val))
 		return -EINVAL;
 
-	base = dfl_get_feature_ioaddr_by_id(pdata, FME_FEATURE_ID_GLOBAL_ERR);
+	base = dfl_get_feature_ioaddr_by_id(fdata, FME_FEATURE_ID_GLOBAL_ERR);
 
-	mutex_lock(&pdata->lock);
+	mutex_lock(&fdata->lock);
 	writeq(GENMASK_ULL(63, 0), base + PCIE1_ERROR_MASK);
 
 	v = readq(base + PCIE1_ERROR);
@@ -124,7 +124,7 @@ static ssize_t pcie1_errors_store(struct device *dev,
 		ret = -EINVAL;
 
 	writeq(0ULL, base + PCIE1_ERROR_MASK);
-	mutex_unlock(&pdata->lock);
+	mutex_unlock(&fdata->lock);
 	return ret ? ret : count;
 }
 static DEVICE_ATTR_RW(pcie1_errors);
@@ -132,10 +132,10 @@ static DEVICE_ATTR_RW(pcie1_errors);
 static ssize_t nonfatal_errors_show(struct device *dev,
 				    struct device_attribute *attr, char *buf)
 {
-	struct dfl_feature_platform_data *pdata = dev_get_platdata(dev);
+	struct dfl_feature_dev_data *fdata = to_dfl_feature_dev_data(dev);
 	void __iomem *base;
 
-	base = dfl_get_feature_ioaddr_by_id(pdata, FME_FEATURE_ID_GLOBAL_ERR);
+	base = dfl_get_feature_ioaddr_by_id(fdata, FME_FEATURE_ID_GLOBAL_ERR);
 
 	return sprintf(buf, "0x%llx\n",
 		       (unsigned long long)readq(base + RAS_NONFAT_ERROR));
@@ -145,10 +145,10 @@ static DEVICE_ATTR_RO(nonfatal_errors);
 static ssize_t catfatal_errors_show(struct device *dev,
 				    struct device_attribute *attr, char *buf)
 {
-	struct dfl_feature_platform_data *pdata = dev_get_platdata(dev);
+	struct dfl_feature_dev_data *fdata = to_dfl_feature_dev_data(dev);
 	void __iomem *base;
 
-	base = dfl_get_feature_ioaddr_by_id(pdata, FME_FEATURE_ID_GLOBAL_ERR);
+	base = dfl_get_feature_ioaddr_by_id(fdata, FME_FEATURE_ID_GLOBAL_ERR);
 
 	return sprintf(buf, "0x%llx\n",
 		       (unsigned long long)readq(base + RAS_CATFAT_ERROR));
@@ -158,15 +158,15 @@ static DEVICE_ATTR_RO(catfatal_errors);
 static ssize_t inject_errors_show(struct device *dev,
 				  struct device_attribute *attr, char *buf)
 {
-	struct dfl_feature_platform_data *pdata = dev_get_platdata(dev);
+	struct dfl_feature_dev_data *fdata = to_dfl_feature_dev_data(dev);
 	void __iomem *base;
 	u64 v;
 
-	base = dfl_get_feature_ioaddr_by_id(pdata, FME_FEATURE_ID_GLOBAL_ERR);
+	base = dfl_get_feature_ioaddr_by_id(fdata, FME_FEATURE_ID_GLOBAL_ERR);
 
-	mutex_lock(&pdata->lock);
+	mutex_lock(&fdata->lock);
 	v = readq(base + RAS_ERROR_INJECT);
-	mutex_unlock(&pdata->lock);
+	mutex_unlock(&fdata->lock);
 
 	return sprintf(buf, "0x%llx\n",
 		       (unsigned long long)FIELD_GET(INJECT_ERROR_MASK, v));
@@ -176,7 +176,7 @@ static ssize_t inject_errors_store(struct device *dev,
 				   struct device_attribute *attr,
 				   const char *buf, size_t count)
 {
-	struct dfl_feature_platform_data *pdata = dev_get_platdata(dev);
+	struct dfl_feature_dev_data *fdata = to_dfl_feature_dev_data(dev);
 	void __iomem *base;
 	u8 inject_error;
 	u64 v;
@@ -187,14 +187,14 @@ static ssize_t inject_errors_store(struct device *dev,
 	if (inject_error & ~INJECT_ERROR_MASK)
 		return -EINVAL;
 
-	base = dfl_get_feature_ioaddr_by_id(pdata, FME_FEATURE_ID_GLOBAL_ERR);
+	base = dfl_get_feature_ioaddr_by_id(fdata, FME_FEATURE_ID_GLOBAL_ERR);
 
-	mutex_lock(&pdata->lock);
+	mutex_lock(&fdata->lock);
 	v = readq(base + RAS_ERROR_INJECT);
 	v &= ~INJECT_ERROR_MASK;
 	v |= FIELD_PREP(INJECT_ERROR_MASK, inject_error);
 	writeq(v, base + RAS_ERROR_INJECT);
-	mutex_unlock(&pdata->lock);
+	mutex_unlock(&fdata->lock);
 
 	return count;
 }
@@ -203,15 +203,15 @@ static DEVICE_ATTR_RW(inject_errors);
 static ssize_t fme_errors_show(struct device *dev,
 			       struct device_attribute *attr, char *buf)
 {
-	struct dfl_feature_platform_data *pdata = dev_get_platdata(dev);
+	struct dfl_feature_dev_data *fdata = to_dfl_feature_dev_data(dev);
 	void __iomem *base;
 	u64 value;
 
-	base = dfl_get_feature_ioaddr_by_id(pdata, FME_FEATURE_ID_GLOBAL_ERR);
+	base = dfl_get_feature_ioaddr_by_id(fdata, FME_FEATURE_ID_GLOBAL_ERR);
 
-	mutex_lock(&pdata->lock);
+	mutex_lock(&fdata->lock);
 	value = readq(base + FME_ERROR);
-	mutex_unlock(&pdata->lock);
+	mutex_unlock(&fdata->lock);
 
 	return sprintf(buf, "0x%llx\n", (unsigned long long)value);
 }
@@ -220,7 +220,7 @@ static ssize_t fme_errors_store(struct device *dev,
 				struct device_attribute *attr,
 				const char *buf, size_t count)
 {
-	struct dfl_feature_platform_data *pdata = dev_get_platdata(dev);
+	struct dfl_feature_dev_data *fdata = to_dfl_feature_dev_data(dev);
 	void __iomem *base;
 	u64 v, val;
 	int ret = 0;
@@ -228,9 +228,9 @@ static ssize_t fme_errors_store(struct device *dev,
 	if (kstrtou64(buf, 0, &val))
 		return -EINVAL;
 
-	base = dfl_get_feature_ioaddr_by_id(pdata, FME_FEATURE_ID_GLOBAL_ERR);
+	base = dfl_get_feature_ioaddr_by_id(fdata, FME_FEATURE_ID_GLOBAL_ERR);
 
-	mutex_lock(&pdata->lock);
+	mutex_lock(&fdata->lock);
 	writeq(GENMASK_ULL(63, 0), base + FME_ERROR_MASK);
 
 	v = readq(base + FME_ERROR);
@@ -242,7 +242,7 @@ static ssize_t fme_errors_store(struct device *dev,
 	/* Workaround: disable MBP_ERROR if feature revision is 0 */
 	writeq(dfl_feature_revision(base) ? 0ULL : MBP_ERROR,
 	       base + FME_ERROR_MASK);
-	mutex_unlock(&pdata->lock);
+	mutex_unlock(&fdata->lock);
 	return ret ? ret : count;
 }
 static DEVICE_ATTR_RW(fme_errors);
@@ -250,15 +250,15 @@ static DEVICE_ATTR_RW(fme_errors);
 static ssize_t first_error_show(struct device *dev,
 				struct device_attribute *attr, char *buf)
 {
-	struct dfl_feature_platform_data *pdata = dev_get_platdata(dev);
+	struct dfl_feature_dev_data *fdata = to_dfl_feature_dev_data(dev);
 	void __iomem *base;
 	u64 value;
 
-	base = dfl_get_feature_ioaddr_by_id(pdata, FME_FEATURE_ID_GLOBAL_ERR);
+	base = dfl_get_feature_ioaddr_by_id(fdata, FME_FEATURE_ID_GLOBAL_ERR);
 
-	mutex_lock(&pdata->lock);
+	mutex_lock(&fdata->lock);
 	value = readq(base + FME_FIRST_ERROR);
-	mutex_unlock(&pdata->lock);
+	mutex_unlock(&fdata->lock);
 
 	return sprintf(buf, "0x%llx\n", (unsigned long long)value);
 }
@@ -267,15 +267,15 @@ static DEVICE_ATTR_RO(first_error);
 static ssize_t next_error_show(struct device *dev,
 			       struct device_attribute *attr, char *buf)
 {
-	struct dfl_feature_platform_data *pdata = dev_get_platdata(dev);
+	struct dfl_feature_dev_data *fdata = to_dfl_feature_dev_data(dev);
 	void __iomem *base;
 	u64 value;
 
-	base = dfl_get_feature_ioaddr_by_id(pdata, FME_FEATURE_ID_GLOBAL_ERR);
+	base = dfl_get_feature_ioaddr_by_id(fdata, FME_FEATURE_ID_GLOBAL_ERR);
 
-	mutex_lock(&pdata->lock);
+	mutex_lock(&fdata->lock);
 	value = readq(base + FME_NEXT_ERROR);
-	mutex_unlock(&pdata->lock);
+	mutex_unlock(&fdata->lock);
 
 	return sprintf(buf, "0x%llx\n", (unsigned long long)value);
 }
@@ -296,15 +296,15 @@ static struct attribute *fme_global_err_attrs[] = {
 static umode_t fme_global_err_attrs_visible(struct kobject *kobj,
 					    struct attribute *attr, int n)
 {
-	struct dfl_feature_platform_data *pdata;
 	struct device *dev = kobj_to_dev(kobj);
+	struct dfl_feature_dev_data *fdata;
 
-	pdata = dev_get_platdata(dev);
+	fdata = to_dfl_feature_dev_data(dev);
 	/*
 	 * sysfs entries are visible only if related private feature is
 	 * enumerated.
 	 */
-	if (!dfl_get_feature_by_id(pdata, FME_FEATURE_ID_GLOBAL_ERR))
+	if (!dfl_get_feature_by_id(fdata, FME_FEATURE_ID_GLOBAL_ERR))
 		return 0;
 
 	return attr->mode;
@@ -318,12 +318,12 @@ const struct attribute_group fme_global_err_group = {
 
 static void fme_err_mask(struct device *dev, bool mask)
 {
-	struct dfl_feature_platform_data *pdata = dev_get_platdata(dev);
+	struct dfl_feature_dev_data *fdata = to_dfl_feature_dev_data(dev);
 	void __iomem *base;
 
-	base = dfl_get_feature_ioaddr_by_id(pdata, FME_FEATURE_ID_GLOBAL_ERR);
+	base = dfl_get_feature_ioaddr_by_id(fdata, FME_FEATURE_ID_GLOBAL_ERR);
 
-	mutex_lock(&pdata->lock);
+	mutex_lock(&fdata->lock);
 
 	/* Workaround: keep MBP_ERROR always masked if revision is 0 */
 	if (dfl_feature_revision(base))
@@ -336,7 +336,7 @@ static void fme_err_mask(struct device *dev, bool mask)
 	writeq(mask ? ERROR_MASK : 0, base + RAS_NONFAT_ERROR_MASK);
 	writeq(mask ? ERROR_MASK : 0, base + RAS_CATFAT_ERROR_MASK);
 
-	mutex_unlock(&pdata->lock);
+	mutex_unlock(&fdata->lock);
 }
 
 static int fme_global_err_init(struct platform_device *pdev,
diff --git a/drivers/fpga/dfl-fme-main.c b/drivers/fpga/dfl-fme-main.c
index 4964e15e910b..0c2f259c7025 100644
--- a/drivers/fpga/dfl-fme-main.c
+++ b/drivers/fpga/dfl-fme-main.c
@@ -28,11 +28,11 @@
 static ssize_t ports_num_show(struct device *dev,
 			      struct device_attribute *attr, char *buf)
 {
-	struct dfl_feature_platform_data *pdata = dev_get_platdata(dev);
+	struct dfl_feature_dev_data *fdata = to_dfl_feature_dev_data(dev);
 	void __iomem *base;
 	u64 v;
 
-	base = dfl_get_feature_ioaddr_by_id(pdata, FME_FEATURE_ID_HEADER);
+	base = dfl_get_feature_ioaddr_by_id(fdata, FME_FEATURE_ID_HEADER);
 
 	v = readq(base + FME_HDR_CAP);
 
@@ -48,11 +48,11 @@ static DEVICE_ATTR_RO(ports_num);
 static ssize_t bitstream_id_show(struct device *dev,
 				 struct device_attribute *attr, char *buf)
 {
-	struct dfl_feature_platform_data *pdata = dev_get_platdata(dev);
+	struct dfl_feature_dev_data *fdata = to_dfl_feature_dev_data(dev);
 	void __iomem *base;
 	u64 v;
 
-	base = dfl_get_feature_ioaddr_by_id(pdata, FME_FEATURE_ID_HEADER);
+	base = dfl_get_feature_ioaddr_by_id(fdata, FME_FEATURE_ID_HEADER);
 
 	v = readq(base + FME_HDR_BITSTREAM_ID);
 
@@ -67,11 +67,11 @@ static DEVICE_ATTR_RO(bitstream_id);
 static ssize_t bitstream_metadata_show(struct device *dev,
 				       struct device_attribute *attr, char *buf)
 {
-	struct dfl_feature_platform_data *pdata = dev_get_platdata(dev);
+	struct dfl_feature_dev_data *fdata = to_dfl_feature_dev_data(dev);
 	void __iomem *base;
 	u64 v;
 
-	base = dfl_get_feature_ioaddr_by_id(pdata, FME_FEATURE_ID_HEADER);
+	base = dfl_get_feature_ioaddr_by_id(fdata, FME_FEATURE_ID_HEADER);
 
 	v = readq(base + FME_HDR_BITSTREAM_MD);
 
@@ -82,11 +82,11 @@ static DEVICE_ATTR_RO(bitstream_metadata);
 static ssize_t cache_size_show(struct device *dev,
 			       struct device_attribute *attr, char *buf)
 {
-	struct dfl_feature_platform_data *pdata = dev_get_platdata(dev);
+	struct dfl_feature_dev_data *fdata = to_dfl_feature_dev_data(dev);
 	void __iomem *base;
 	u64 v;
 
-	base = dfl_get_feature_ioaddr_by_id(pdata, FME_FEATURE_ID_HEADER);
+	base = dfl_get_feature_ioaddr_by_id(fdata, FME_FEATURE_ID_HEADER);
 
 	v = readq(base + FME_HDR_CAP);
 
@@ -98,11 +98,11 @@ static DEVICE_ATTR_RO(cache_size);
 static ssize_t fabric_version_show(struct device *dev,
 				   struct device_attribute *attr, char *buf)
 {
-	struct dfl_feature_platform_data *pdata = dev_get_platdata(dev);
+	struct dfl_feature_dev_data *fdata = to_dfl_feature_dev_data(dev);
 	void __iomem *base;
 	u64 v;
 
-	base = dfl_get_feature_ioaddr_by_id(pdata, FME_FEATURE_ID_HEADER);
+	base = dfl_get_feature_ioaddr_by_id(fdata, FME_FEATURE_ID_HEADER);
 
 	v = readq(base + FME_HDR_CAP);
 
@@ -114,11 +114,11 @@ static DEVICE_ATTR_RO(fabric_version);
 static ssize_t socket_id_show(struct device *dev,
 			      struct device_attribute *attr, char *buf)
 {
-	struct dfl_feature_platform_data *pdata = dev_get_platdata(dev);
+	struct dfl_feature_dev_data *fdata = to_dfl_feature_dev_data(dev);
 	void __iomem *base;
 	u64 v;
 
-	base = dfl_get_feature_ioaddr_by_id(pdata, FME_FEATURE_ID_HEADER);
+	base = dfl_get_feature_ioaddr_by_id(fdata, FME_FEATURE_ID_HEADER);
 
 	v = readq(base + FME_HDR_CAP);
 
@@ -141,10 +141,10 @@ static const struct attribute_group fme_hdr_group = {
 	.attrs = fme_hdr_attrs,
 };
 
-static long fme_hdr_ioctl_release_port(struct dfl_feature_platform_data *pdata,
+static long fme_hdr_ioctl_release_port(struct dfl_feature_dev_data *fdata,
 				       unsigned long arg)
 {
-	struct dfl_fpga_cdev *cdev = pdata->dfl_cdev;
+	struct dfl_fpga_cdev *cdev = fdata->dfl_cdev;
 	int port_id;
 
 	if (get_user(port_id, (int __user *)arg))
@@ -153,10 +153,10 @@ static long fme_hdr_ioctl_release_port(struct dfl_feature_platform_data *pdata,
 	return dfl_fpga_cdev_release_port(cdev, port_id);
 }
 
-static long fme_hdr_ioctl_assign_port(struct dfl_feature_platform_data *pdata,
+static long fme_hdr_ioctl_assign_port(struct dfl_feature_dev_data *fdata,
 				      unsigned long arg)
 {
-	struct dfl_fpga_cdev *cdev = pdata->dfl_cdev;
+	struct dfl_fpga_cdev *cdev = fdata->dfl_cdev;
 	int port_id;
 
 	if (get_user(port_id, (int __user *)arg))
@@ -169,13 +169,13 @@ static long fme_hdr_ioctl(struct platform_device *pdev,
 			  struct dfl_feature *feature,
 			  unsigned int cmd, unsigned long arg)
 {
-	struct dfl_feature_platform_data *pdata = dev_get_platdata(&pdev->dev);
+	struct dfl_feature_dev_data *fdata = to_dfl_feature_dev_data(&pdev->dev);
 
 	switch (cmd) {
 	case DFL_FPGA_FME_PORT_RELEASE:
-		return fme_hdr_ioctl_release_port(pdata, arg);
+		return fme_hdr_ioctl_release_port(fdata, arg);
 	case DFL_FPGA_FME_PORT_ASSIGN:
-		return fme_hdr_ioctl_assign_port(pdata, arg);
+		return fme_hdr_ioctl_assign_port(fdata, arg);
 	}
 
 	return -ENODEV;
@@ -417,14 +417,14 @@ static int power_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
 static int power_hwmon_write(struct device *dev, enum hwmon_sensor_types type,
 			     u32 attr, int channel, long val)
 {
-	struct dfl_feature_platform_data *pdata = dev_get_platdata(dev->parent);
+	struct dfl_feature_dev_data *fdata = to_dfl_feature_dev_data(dev->parent);
 	struct dfl_feature *feature = dev_get_drvdata(dev);
 	int ret = 0;
 	u64 v;
 
 	val = clamp_val(val / MICRO, 0, PWR_THRESHOLD_MAX);
 
-	mutex_lock(&pdata->lock);
+	mutex_lock(&fdata->lock);
 
 	switch (attr) {
 	case hwmon_power_max:
@@ -444,7 +444,7 @@ static int power_hwmon_write(struct device *dev, enum hwmon_sensor_types type,
 		break;
 	}
 
-	mutex_unlock(&pdata->lock);
+	mutex_unlock(&fdata->lock);
 
 	return ret;
 }
@@ -595,7 +595,7 @@ static struct dfl_feature_driver fme_feature_drvs[] = {
 	},
 };
 
-static long fme_ioctl_check_extension(struct dfl_feature_platform_data *pdata,
+static long fme_ioctl_check_extension(struct dfl_feature_dev_data *fdata,
 				      unsigned long arg)
 {
 	/* No extension support for now */
@@ -604,46 +604,46 @@ static long fme_ioctl_check_extension(struct dfl_feature_platform_data *pdata,
 
 static int fme_open(struct inode *inode, struct file *filp)
 {
-	struct dfl_feature_platform_data *pdata = dfl_fpga_inode_to_feature_dev_data(inode);
-	struct platform_device *fdev = pdata->dev;
+	struct dfl_feature_dev_data *fdata = dfl_fpga_inode_to_feature_dev_data(inode);
+	struct platform_device *fdev = fdata->dev;
 	int ret;
 
-	mutex_lock(&pdata->lock);
-	ret = dfl_feature_dev_use_begin(pdata, filp->f_flags & O_EXCL);
+	mutex_lock(&fdata->lock);
+	ret = dfl_feature_dev_use_begin(fdata, filp->f_flags & O_EXCL);
 	if (!ret) {
 		dev_dbg(&fdev->dev, "Device File Opened %d Times\n",
-			dfl_feature_dev_use_count(pdata));
-		filp->private_data = pdata;
+			dfl_feature_dev_use_count(fdata));
+		filp->private_data = fdata;
 	}
-	mutex_unlock(&pdata->lock);
+	mutex_unlock(&fdata->lock);
 
 	return ret;
 }
 
 static int fme_release(struct inode *inode, struct file *filp)
 {
-	struct dfl_feature_platform_data *pdata = filp->private_data;
-	struct platform_device *pdev = pdata->dev;
+	struct dfl_feature_dev_data *fdata = filp->private_data;
+	struct platform_device *pdev = fdata->dev;
 	struct dfl_feature *feature;
 
 	dev_dbg(&pdev->dev, "Device File Release\n");
 
-	mutex_lock(&pdata->lock);
-	dfl_feature_dev_use_end(pdata);
+	mutex_lock(&fdata->lock);
+	dfl_feature_dev_use_end(fdata);
 
-	if (!dfl_feature_dev_use_count(pdata))
-		dfl_fpga_dev_for_each_feature(pdata, feature)
+	if (!dfl_feature_dev_use_count(fdata))
+		dfl_fpga_dev_for_each_feature(fdata, feature)
 			dfl_fpga_set_irq_triggers(feature, 0,
 						  feature->nr_irqs, NULL);
-	mutex_unlock(&pdata->lock);
+	mutex_unlock(&fdata->lock);
 
 	return 0;
 }
 
 static long fme_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 {
-	struct dfl_feature_platform_data *pdata = filp->private_data;
-	struct platform_device *pdev = pdata->dev;
+	struct dfl_feature_dev_data *fdata = filp->private_data;
+	struct platform_device *pdev = fdata->dev;
 	struct dfl_feature *f;
 	long ret;
 
@@ -653,7 +653,7 @@ static long fme_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 	case DFL_FPGA_GET_API_VERSION:
 		return DFL_FPGA_API_VERSION;
 	case DFL_FPGA_CHECK_EXTENSION:
-		return fme_ioctl_check_extension(pdata, arg);
+		return fme_ioctl_check_extension(fdata, arg);
 	default:
 		/*
 		 * Let sub-feature's ioctl function to handle the cmd.
@@ -661,7 +661,7 @@ static long fme_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 		 * handled in this sub feature, and returns 0 or other
 		 * error code if cmd is handled.
 		 */
-		dfl_fpga_dev_for_each_feature(pdata, f) {
+		dfl_fpga_dev_for_each_feature(fdata, f) {
 			if (f->ops && f->ops->ioctl) {
 				ret = f->ops->ioctl(pdev, f, cmd, arg);
 				if (ret != -ENODEV)
@@ -675,27 +675,27 @@ static long fme_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 
 static int fme_dev_init(struct platform_device *pdev)
 {
-	struct dfl_feature_platform_data *pdata = dev_get_platdata(&pdev->dev);
+	struct dfl_feature_dev_data *fdata = to_dfl_feature_dev_data(&pdev->dev);
 	struct dfl_fme *fme;
 
 	fme = devm_kzalloc(&pdev->dev, sizeof(*fme), GFP_KERNEL);
 	if (!fme)
 		return -ENOMEM;
 
-	mutex_lock(&pdata->lock);
-	dfl_fpga_pdata_set_private(pdata, fme);
-	mutex_unlock(&pdata->lock);
+	mutex_lock(&fdata->lock);
+	dfl_fpga_fdata_set_private(fdata, fme);
+	mutex_unlock(&fdata->lock);
 
 	return 0;
 }
 
 static void fme_dev_destroy(struct platform_device *pdev)
 {
-	struct dfl_feature_platform_data *pdata = dev_get_platdata(&pdev->dev);
+	struct dfl_feature_dev_data *fdata = to_dfl_feature_dev_data(&pdev->dev);
 
-	mutex_lock(&pdata->lock);
-	dfl_fpga_pdata_set_private(pdata, NULL);
-	mutex_unlock(&pdata->lock);
+	mutex_lock(&fdata->lock);
+	dfl_fpga_fdata_set_private(fdata, NULL);
+	mutex_unlock(&fdata->lock);
 }
 
 static const struct file_operations fme_fops = {
diff --git a/drivers/fpga/dfl-fme-pr.c b/drivers/fpga/dfl-fme-pr.c
index 97fc0e402edf..b878b260af38 100644
--- a/drivers/fpga/dfl-fme-pr.c
+++ b/drivers/fpga/dfl-fme-pr.c
@@ -65,7 +65,7 @@ static struct fpga_region *dfl_fme_region_find(struct dfl_fme *fme, int port_id)
 
 static int fme_pr(struct platform_device *pdev, unsigned long arg)
 {
-	struct dfl_feature_platform_data *pdata = dev_get_platdata(&pdev->dev);
+	struct dfl_feature_dev_data *fdata = to_dfl_feature_dev_data(&pdev->dev);
 	void __user *argp = (void __user *)arg;
 	struct dfl_fpga_fme_port_pr port_pr;
 	struct fpga_image_info *info;
@@ -87,7 +87,7 @@ static int fme_pr(struct platform_device *pdev, unsigned long arg)
 		return -EINVAL;
 
 	/* get fme header region */
-	fme_hdr = dfl_get_feature_ioaddr_by_id(pdata, FME_FEATURE_ID_HEADER);
+	fme_hdr = dfl_get_feature_ioaddr_by_id(fdata, FME_FEATURE_ID_HEADER);
 
 	/* check port id */
 	v = readq(fme_hdr + FME_HDR_CAP);
@@ -122,8 +122,8 @@ static int fme_pr(struct platform_device *pdev, unsigned long arg)
 
 	info->flags |= FPGA_MGR_PARTIAL_RECONFIG;
 
-	mutex_lock(&pdata->lock);
-	fme = dfl_fpga_pdata_get_private(pdata);
+	mutex_lock(&fdata->lock);
+	fme = dfl_fpga_fdata_get_private(fdata);
 	/* fme device has been unregistered. */
 	if (!fme) {
 		ret = -EINVAL;
@@ -155,7 +155,7 @@ static int fme_pr(struct platform_device *pdev, unsigned long arg)
 
 	put_device(&region->dev);
 unlock_exit:
-	mutex_unlock(&pdata->lock);
+	mutex_unlock(&fdata->lock);
 free_exit:
 	vfree(buf);
 	return ret;
@@ -163,16 +163,16 @@ static int fme_pr(struct platform_device *pdev, unsigned long arg)
 
 /**
  * dfl_fme_create_mgr - create fpga mgr platform device as child device
+ * @fdata: fme feature dev data
  * @feature: sub feature info
- * @pdata: fme platform_device's pdata
  *
  * Return: mgr platform device if successful, and error code otherwise.
  */
 static struct platform_device *
-dfl_fme_create_mgr(struct dfl_feature_platform_data *pdata,
+dfl_fme_create_mgr(struct dfl_feature_dev_data *fdata,
 		   struct dfl_feature *feature)
 {
-	struct platform_device *mgr, *fme = pdata->dev;
+	struct platform_device *mgr, *fme = fdata->dev;
 	struct dfl_fme_mgr_pdata mgr_pdata;
 	int ret = -ENOMEM;
 
@@ -208,11 +208,11 @@ dfl_fme_create_mgr(struct dfl_feature_platform_data *pdata,
 
 /**
  * dfl_fme_destroy_mgr - destroy fpga mgr platform device
- * @pdata: fme platform device's pdata
+ * @fdata: fme feature dev data
  */
-static void dfl_fme_destroy_mgr(struct dfl_feature_platform_data *pdata)
+static void dfl_fme_destroy_mgr(struct dfl_feature_dev_data *fdata)
 {
-	struct dfl_fme *priv = dfl_fpga_pdata_get_private(pdata);
+	struct dfl_fme *priv = dfl_fpga_fdata_get_private(fdata);
 
 	platform_device_unregister(priv->mgr);
 }
@@ -220,15 +220,15 @@ static void dfl_fme_destroy_mgr(struct dfl_feature_platform_data *pdata)
 /**
  * dfl_fme_create_bridge - create fme fpga bridge platform device as child
  *
- * @pdata: fme platform device's pdata
+ * @fdata: fme feature dev data
  * @port_id: port id for the bridge to be created.
  *
  * Return: bridge platform device if successful, and error code otherwise.
  */
 static struct dfl_fme_bridge *
-dfl_fme_create_bridge(struct dfl_feature_platform_data *pdata, int port_id)
+dfl_fme_create_bridge(struct dfl_feature_dev_data *fdata, int port_id)
 {
-	struct device *dev = &pdata->dev->dev;
+	struct device *dev = &fdata->dev->dev;
 	struct dfl_fme_br_pdata br_pdata;
 	struct dfl_fme_bridge *fme_br;
 	int ret = -ENOMEM;
@@ -237,7 +237,7 @@ dfl_fme_create_bridge(struct dfl_feature_platform_data *pdata, int port_id)
 	if (!fme_br)
 		return ERR_PTR(ret);
 
-	br_pdata.cdev = pdata->dfl_cdev;
+	br_pdata.cdev = fdata->dfl_cdev;
 	br_pdata.port_id = port_id;
 
 	fme_br->br = platform_device_alloc(DFL_FPGA_FME_BRIDGE,
@@ -273,11 +273,11 @@ static void dfl_fme_destroy_bridge(struct dfl_fme_bridge *fme_br)
 
 /**
  * dfl_fme_destroy_bridges - destroy all fpga bridge platform device
- * @pdata: fme platform device's pdata
+ * @fdata: fme feature dev data
  */
-static void dfl_fme_destroy_bridges(struct dfl_feature_platform_data *pdata)
+static void dfl_fme_destroy_bridges(struct dfl_feature_dev_data *fdata)
 {
-	struct dfl_fme *priv = dfl_fpga_pdata_get_private(pdata);
+	struct dfl_fme *priv = dfl_fpga_fdata_get_private(fdata);
 	struct dfl_fme_bridge *fbridge, *tmp;
 
 	list_for_each_entry_safe(fbridge, tmp, &priv->bridge_list, node) {
@@ -289,7 +289,7 @@ static void dfl_fme_destroy_bridges(struct dfl_feature_platform_data *pdata)
 /**
  * dfl_fme_create_region - create fpga region platform device as child
  *
- * @pdata: fme platform device's pdata
+ * @fdata: fme feature dev data
  * @mgr: mgr platform device needed for region
  * @br: br platform device needed for region
  * @port_id: port id
@@ -297,12 +297,12 @@ static void dfl_fme_destroy_bridges(struct dfl_feature_platform_data *pdata)
  * Return: fme region if successful, and error code otherwise.
  */
 static struct dfl_fme_region *
-dfl_fme_create_region(struct dfl_feature_platform_data *pdata,
+dfl_fme_create_region(struct dfl_feature_dev_data *fdata,
 		      struct platform_device *mgr,
 		      struct platform_device *br, int port_id)
 {
 	struct dfl_fme_region_pdata region_pdata;
-	struct device *dev = &pdata->dev->dev;
+	struct device *dev = &fdata->dev->dev;
 	struct dfl_fme_region *fme_region;
 	int ret = -ENOMEM;
 
@@ -352,11 +352,11 @@ static void dfl_fme_destroy_region(struct dfl_fme_region *fme_region)
 
 /**
  * dfl_fme_destroy_regions - destroy all fme regions
- * @pdata: fme platform device's pdata
+ * @fdata: fme feature dev data
  */
-static void dfl_fme_destroy_regions(struct dfl_feature_platform_data *pdata)
+static void dfl_fme_destroy_regions(struct dfl_feature_dev_data *fdata)
 {
-	struct dfl_fme *priv = dfl_fpga_pdata_get_private(pdata);
+	struct dfl_fme *priv = dfl_fpga_fdata_get_private(fdata);
 	struct dfl_fme_region *fme_region, *tmp;
 
 	list_for_each_entry_safe(fme_region, tmp, &priv->region_list, node) {
@@ -368,7 +368,7 @@ static void dfl_fme_destroy_regions(struct dfl_feature_platform_data *pdata)
 static int pr_mgmt_init(struct platform_device *pdev,
 			struct dfl_feature *feature)
 {
-	struct dfl_feature_platform_data *pdata = dev_get_platdata(&pdev->dev);
+	struct dfl_feature_dev_data *fdata = to_dfl_feature_dev_data(&pdev->dev);
 	struct dfl_fme_region *fme_region;
 	struct dfl_fme_bridge *fme_br;
 	struct platform_device *mgr;
@@ -377,17 +377,17 @@ static int pr_mgmt_init(struct platform_device *pdev,
 	int ret = -ENODEV, i = 0;
 	u64 fme_cap, port_offset;
 
-	fme_hdr = dfl_get_feature_ioaddr_by_id(pdata, FME_FEATURE_ID_HEADER);
+	fme_hdr = dfl_get_feature_ioaddr_by_id(fdata, FME_FEATURE_ID_HEADER);
 
-	mutex_lock(&pdata->lock);
-	priv = dfl_fpga_pdata_get_private(pdata);
+	mutex_lock(&fdata->lock);
+	priv = dfl_fpga_fdata_get_private(fdata);
 
 	/* Initialize the region and bridge sub device list */
 	INIT_LIST_HEAD(&priv->region_list);
 	INIT_LIST_HEAD(&priv->bridge_list);
 
 	/* Create fpga mgr platform device */
-	mgr = dfl_fme_create_mgr(pdata, feature);
+	mgr = dfl_fme_create_mgr(fdata, feature);
 	if (IS_ERR(mgr)) {
 		dev_err(&pdev->dev, "fail to create fpga mgr pdev\n");
 		goto unlock;
@@ -403,7 +403,7 @@ static int pr_mgmt_init(struct platform_device *pdev,
 			continue;
 
 		/* Create bridge for each port */
-		fme_br = dfl_fme_create_bridge(pdata, i);
+		fme_br = dfl_fme_create_bridge(fdata, i);
 		if (IS_ERR(fme_br)) {
 			ret = PTR_ERR(fme_br);
 			goto destroy_region;
@@ -412,7 +412,7 @@ static int pr_mgmt_init(struct platform_device *pdev,
 		list_add(&fme_br->node, &priv->bridge_list);
 
 		/* Create region for each port */
-		fme_region = dfl_fme_create_region(pdata, mgr,
+		fme_region = dfl_fme_create_region(fdata, mgr,
 						   fme_br->br, i);
 		if (IS_ERR(fme_region)) {
 			ret = PTR_ERR(fme_region);
@@ -421,30 +421,30 @@ static int pr_mgmt_init(struct platform_device *pdev,
 
 		list_add(&fme_region->node, &priv->region_list);
 	}
-	mutex_unlock(&pdata->lock);
+	mutex_unlock(&fdata->lock);
 
 	return 0;
 
 destroy_region:
-	dfl_fme_destroy_regions(pdata);
-	dfl_fme_destroy_bridges(pdata);
-	dfl_fme_destroy_mgr(pdata);
+	dfl_fme_destroy_regions(fdata);
+	dfl_fme_destroy_bridges(fdata);
+	dfl_fme_destroy_mgr(fdata);
 unlock:
-	mutex_unlock(&pdata->lock);
+	mutex_unlock(&fdata->lock);
 	return ret;
 }
 
 static void pr_mgmt_uinit(struct platform_device *pdev,
 			  struct dfl_feature *feature)
 {
-	struct dfl_feature_platform_data *pdata = dev_get_platdata(&pdev->dev);
+	struct dfl_feature_dev_data *fdata = to_dfl_feature_dev_data(&pdev->dev);
 
-	mutex_lock(&pdata->lock);
+	mutex_lock(&fdata->lock);
 
-	dfl_fme_destroy_regions(pdata);
-	dfl_fme_destroy_bridges(pdata);
-	dfl_fme_destroy_mgr(pdata);
-	mutex_unlock(&pdata->lock);
+	dfl_fme_destroy_regions(fdata);
+	dfl_fme_destroy_bridges(fdata);
+	dfl_fme_destroy_mgr(fdata);
+	mutex_unlock(&fdata->lock);
 }
 
 static long fme_pr_ioctl(struct platform_device *pdev,
diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
index 86fcd3084b06..e8488a771337 100644
--- a/drivers/fpga/dfl.c
+++ b/drivers/fpga/dfl.c
@@ -150,7 +150,7 @@ static LIST_HEAD(dfl_port_ops_list);
  *
  * Please note that must dfl_fpga_port_ops_put after use the port_ops.
  */
-struct dfl_fpga_port_ops *dfl_fpga_port_ops_get(struct dfl_feature_platform_data *pdata)
+struct dfl_fpga_port_ops *dfl_fpga_port_ops_get(struct dfl_feature_dev_data *fdata)
 {
 	struct dfl_fpga_port_ops *ops = NULL;
 
@@ -160,7 +160,7 @@ struct dfl_fpga_port_ops *dfl_fpga_port_ops_get(struct dfl_feature_platform_data
 
 	list_for_each_entry(ops, &dfl_port_ops_list, node) {
 		/* match port_ops using the name of platform device */
-		if (!strcmp(pdata->dev->name, ops->name)) {
+		if (!strcmp(fdata->dev->name, ops->name)) {
 			if (!try_module_get(ops->owner))
 				ops = NULL;
 			goto done;
@@ -216,21 +216,21 @@ EXPORT_SYMBOL_GPL(dfl_fpga_port_ops_del);
  *
  * Return: 1 if port device matches with given port id, otherwise 0.
  */
-int dfl_fpga_check_port_id(struct dfl_feature_platform_data *pdata, void *pport_id)
+int dfl_fpga_check_port_id(struct dfl_feature_dev_data *fdata, void *pport_id)
 {
 	struct dfl_fpga_port_ops *port_ops;
 
-	if (pdata->id != FEATURE_DEV_ID_UNUSED)
-		return pdata->id == *(int *)pport_id;
+	if (fdata->id != FEATURE_DEV_ID_UNUSED)
+		return fdata->id == *(int *)pport_id;
 
-	port_ops = dfl_fpga_port_ops_get(pdata);
+	port_ops = dfl_fpga_port_ops_get(fdata);
 	if (!port_ops || !port_ops->get_id)
 		return 0;
 
-	pdata->id = port_ops->get_id(pdata);
+	fdata->id = port_ops->get_id(fdata);
 	dfl_fpga_port_ops_put(port_ops);
 
-	return pdata->id == *(int *)pport_id;
+	return fdata->id == *(int *)pport_id;
 }
 EXPORT_SYMBOL_GPL(dfl_fpga_check_port_id);
 
@@ -339,10 +339,10 @@ static void release_dfl_dev(struct device *dev)
 }
 
 static struct dfl_device *
-dfl_dev_add(struct dfl_feature_platform_data *pdata,
+dfl_dev_add(struct dfl_feature_dev_data *fdata,
 	    struct dfl_feature *feature)
 {
-	struct platform_device *pdev = pdata->dev;
+	struct platform_device *pdev = fdata->dev;
 	struct resource *parent_res;
 	struct dfl_device *ddev;
 	int id, i, ret;
@@ -368,11 +368,11 @@ dfl_dev_add(struct dfl_feature_platform_data *pdata,
 	if (ret)
 		goto put_dev;
 
-	ddev->type = pdata->type;
+	ddev->type = fdata->type;
 	ddev->feature_id = feature->id;
 	ddev->revision = feature->revision;
 	ddev->dfh_version = feature->dfh_version;
-	ddev->cdev = pdata->dfl_cdev;
+	ddev->cdev = fdata->dfl_cdev;
 	if (feature->param_size) {
 		ddev->params = kmemdup(feature->params, feature->param_size, GFP_KERNEL);
 		if (!ddev->params) {
@@ -423,11 +423,11 @@ dfl_dev_add(struct dfl_feature_platform_data *pdata,
 	return ERR_PTR(ret);
 }
 
-static void dfl_devs_remove(struct dfl_feature_platform_data *pdata)
+static void dfl_devs_remove(struct dfl_feature_dev_data *fdata)
 {
 	struct dfl_feature *feature;
 
-	dfl_fpga_dev_for_each_feature(pdata, feature) {
+	dfl_fpga_dev_for_each_feature(fdata, feature) {
 		if (feature->ddev) {
 			device_unregister(&feature->ddev->dev);
 			feature->ddev = NULL;
@@ -435,13 +435,13 @@ static void dfl_devs_remove(struct dfl_feature_platform_data *pdata)
 	}
 }
 
-static int dfl_devs_add(struct dfl_feature_platform_data *pdata)
+static int dfl_devs_add(struct dfl_feature_dev_data *fdata)
 {
 	struct dfl_feature *feature;
 	struct dfl_device *ddev;
 	int ret;
 
-	dfl_fpga_dev_for_each_feature(pdata, feature) {
+	dfl_fpga_dev_for_each_feature(fdata, feature) {
 		if (feature->ioaddr)
 			continue;
 
@@ -450,7 +450,7 @@ static int dfl_devs_add(struct dfl_feature_platform_data *pdata)
 			goto err;
 		}
 
-		ddev = dfl_dev_add(pdata, feature);
+		ddev = dfl_dev_add(fdata, feature);
 		if (IS_ERR(ddev)) {
 			ret = PTR_ERR(ddev);
 			goto err;
@@ -462,7 +462,7 @@ static int dfl_devs_add(struct dfl_feature_platform_data *pdata)
 	return 0;
 
 err:
-	dfl_devs_remove(pdata);
+	dfl_devs_remove(fdata);
 	return ret;
 }
 
@@ -492,12 +492,12 @@ EXPORT_SYMBOL(dfl_driver_unregister);
  */
 void dfl_fpga_dev_feature_uinit(struct platform_device *pdev)
 {
-	struct dfl_feature_platform_data *pdata = dev_get_platdata(&pdev->dev);
+	struct dfl_feature_dev_data *fdata = to_dfl_feature_dev_data(&pdev->dev);
 	struct dfl_feature *feature;
 
-	dfl_devs_remove(pdata);
+	dfl_devs_remove(fdata);
 
-	dfl_fpga_dev_for_each_feature(pdata, feature) {
+	dfl_fpga_dev_for_each_feature(fdata, feature) {
 		if (feature->ops) {
 			if (feature->ops->uinit)
 				feature->ops->uinit(pdev, feature);
@@ -566,13 +566,13 @@ static bool dfl_feature_drv_match(struct dfl_feature *feature,
 int dfl_fpga_dev_feature_init(struct platform_device *pdev,
 			      struct dfl_feature_driver *feature_drvs)
 {
-	struct dfl_feature_platform_data *pdata = dev_get_platdata(&pdev->dev);
+	struct dfl_feature_dev_data *fdata = to_dfl_feature_dev_data(&pdev->dev);
 	struct dfl_feature_driver *drv = feature_drvs;
 	struct dfl_feature *feature;
 	int ret;
 
 	while (drv->ops) {
-		dfl_fpga_dev_for_each_feature(pdata, feature) {
+		dfl_fpga_dev_for_each_feature(fdata, feature) {
 			if (dfl_feature_drv_match(feature, drv)) {
 				ret = dfl_feature_instance_init(pdev, feature, drv);
 				if (ret)
@@ -582,7 +582,7 @@ int dfl_fpga_dev_feature_init(struct platform_device *pdev,
 		drv++;
 	}
 
-	ret = dfl_devs_add(pdata);
+	ret = dfl_devs_add(fdata);
 	if (ret)
 		goto exit;
 
@@ -732,21 +732,21 @@ struct dfl_feature_info {
 };
 
 static void dfl_fpga_cdev_add_port_data(struct dfl_fpga_cdev *cdev,
-					struct dfl_feature_platform_data *pdata)
+					struct dfl_feature_dev_data *fdata)
 {
 	mutex_lock(&cdev->lock);
-	list_add(&pdata->node, &cdev->port_dev_list);
-	get_device(&pdata->dev->dev);
+	list_add(&fdata->node, &cdev->port_dev_list);
+	get_device(&fdata->dev->dev);
 	mutex_unlock(&cdev->lock);
 }
 
-static struct dfl_feature_platform_data *
+static struct dfl_feature_dev_data *
 binfo_create_feature_dev_data(struct build_feature_devs_info *binfo)
 {
 	struct platform_device *fdev = binfo->feature_dev;
-	struct dfl_feature_platform_data *pdata;
 	enum dfl_id_type type = binfo->type;
 	struct dfl_feature_info *finfo, *p;
+	struct dfl_feature_dev_data *fdata;
 	int index = 0, res_idx = 0;
 
 	if (WARN_ON_ONCE(type >= DFL_ID_MAX))
@@ -758,17 +758,17 @@ binfo_create_feature_dev_data(struct build_feature_devs_info *binfo)
 	 * it will be automatically freed by device's release() callback,
 	 * platform_device_release().
 	 */
-	pdata = kzalloc(struct_size(pdata, features, binfo->feature_num), GFP_KERNEL);
-	if (!pdata)
+	fdata = kzalloc(struct_size(fdata, features, binfo->feature_num), GFP_KERNEL);
+	if (!fdata)
 		return ERR_PTR(-ENOMEM);
 
-	pdata->dev = fdev;
-	pdata->type = type;
-	pdata->num = binfo->feature_num;
-	pdata->dfl_cdev = binfo->cdev;
-	pdata->id = FEATURE_DEV_ID_UNUSED;
-	mutex_init(&pdata->lock);
-	lockdep_set_class_and_name(&pdata->lock, &dfl_pdata_keys[type],
+	fdata->dev = fdev;
+	fdata->type = type;
+	fdata->num = binfo->feature_num;
+	fdata->dfl_cdev = binfo->cdev;
+	fdata->id = FEATURE_DEV_ID_UNUSED;
+	mutex_init(&fdata->lock);
+	lockdep_set_class_and_name(&fdata->lock, &dfl_pdata_keys[type],
 				   dfl_pdata_key_strings[type]);
 
 	/*
@@ -777,9 +777,9 @@ binfo_create_feature_dev_data(struct build_feature_devs_info *binfo)
 	 * works properly for port device.
 	 * and it should always be 0 for fme device.
 	 */
-	WARN_ON(pdata->disable_count);
+	WARN_ON(fdata->disable_count);
 
-	fdev->dev.platform_data = pdata;
+	fdev->dev.platform_data = fdata;
 
 	/* each sub feature has one MMIO resource */
 	fdev->num_resources = binfo->feature_num;
@@ -790,7 +790,7 @@ binfo_create_feature_dev_data(struct build_feature_devs_info *binfo)
 
 	/* fill features and resource information for feature dev */
 	list_for_each_entry_safe(finfo, p, &binfo->sub_features, node) {
-		struct dfl_feature *feature = &pdata->features[index++];
+		struct dfl_feature *feature = &fdata->features[index++];
 		struct dfl_feature_irq_ctx *ctx;
 		unsigned int i;
 
@@ -846,7 +846,7 @@ binfo_create_feature_dev_data(struct build_feature_devs_info *binfo)
 		kfree(finfo);
 	}
 
-	return pdata;
+	return fdata;
 }
 
 static int
@@ -880,19 +880,19 @@ build_info_create_dev(struct build_feature_devs_info *binfo)
 
 static int build_info_commit_dev(struct build_feature_devs_info *binfo)
 {
-	struct dfl_feature_platform_data *pdata;
+	struct dfl_feature_dev_data *fdata;
 	int ret;
 
-	pdata = binfo_create_feature_dev_data(binfo);
-	if (IS_ERR(pdata))
-		return PTR_ERR(pdata);
+	fdata = binfo_create_feature_dev_data(binfo);
+	if (IS_ERR(fdata))
+		return PTR_ERR(fdata);
 
 	ret = platform_device_add(binfo->feature_dev);
 	if (ret)
 		return ret;
 
 	if (binfo->type == PORT_ID)
-		dfl_fpga_cdev_add_port_data(binfo->cdev, pdata);
+		dfl_fpga_cdev_add_port_data(binfo->cdev, fdata);
 	else
 		binfo->cdev->fme_dev = get_device(&binfo->feature_dev->dev);
 
@@ -1515,13 +1515,13 @@ EXPORT_SYMBOL_GPL(dfl_fpga_enum_info_add_irq);
 
 static int remove_feature_dev(struct device *dev, void *data)
 {
-	struct dfl_feature_platform_data *pdata = dev_get_platdata(dev);
+	struct dfl_feature_dev_data *fdata = to_dfl_feature_dev_data(dev);
 	struct platform_device *pdev = to_platform_device(dev);
 	int id = pdev->id;
 
 	platform_device_unregister(pdev);
 
-	dfl_id_free(pdata->type, id);
+	dfl_id_free(fdata->type, id);
 
 	return 0;
 }
@@ -1615,22 +1615,22 @@ EXPORT_SYMBOL_GPL(dfl_fpga_feature_devs_enumerate);
  */
 void dfl_fpga_feature_devs_remove(struct dfl_fpga_cdev *cdev)
 {
-	struct dfl_feature_platform_data *pdata, *ptmp;
+	struct dfl_feature_dev_data *fdata, *ptmp;
 
 	mutex_lock(&cdev->lock);
 	if (cdev->fme_dev)
 		put_device(cdev->fme_dev);
 
-	list_for_each_entry_safe(pdata, ptmp, &cdev->port_dev_list, node) {
-		struct platform_device *port_dev = pdata->dev;
+	list_for_each_entry_safe(fdata, ptmp, &cdev->port_dev_list, node) {
+		struct platform_device *port_dev = fdata->dev;
 
 		/* remove released ports */
 		if (!device_is_registered(&port_dev->dev)) {
-			dfl_id_free(pdata->type, port_dev->id);
+			dfl_id_free(fdata->type, port_dev->id);
 			platform_device_put(port_dev);
 		}
 
-		list_del(&pdata->node);
+		list_del(&fdata->node);
 		put_device(&port_dev->dev);
 	}
 	mutex_unlock(&cdev->lock);
@@ -1656,15 +1656,15 @@ EXPORT_SYMBOL_GPL(dfl_fpga_feature_devs_remove);
  *
  * NOTE: you will need to drop the device reference with put_device() after use.
  */
-struct dfl_feature_platform_data *
+struct dfl_feature_dev_data *
 __dfl_fpga_cdev_find_port_data(struct dfl_fpga_cdev *cdev, void *data,
-			       int (*match)(struct dfl_feature_platform_data *, void *))
+			       int (*match)(struct dfl_feature_dev_data *, void *))
 {
-	struct dfl_feature_platform_data *pdata;
+	struct dfl_feature_dev_data *fdata;
 
-	list_for_each_entry(pdata, &cdev->port_dev_list, node) {
-		if (match(pdata, data) && get_device(&pdata->dev->dev))
-			return pdata;
+	list_for_each_entry(fdata, &cdev->port_dev_list, node) {
+		if (match(fdata, data) && get_device(&fdata->dev->dev))
+			return fdata;
 	}
 
 	return NULL;
@@ -1703,30 +1703,30 @@ static int __init dfl_fpga_init(void)
  */
 int dfl_fpga_cdev_release_port(struct dfl_fpga_cdev *cdev, int port_id)
 {
-	struct dfl_feature_platform_data *pdata;
+	struct dfl_feature_dev_data *fdata;
 	int ret = -ENODEV;
 
 	mutex_lock(&cdev->lock);
-	pdata = __dfl_fpga_cdev_find_port_data(cdev, &port_id,
+	fdata = __dfl_fpga_cdev_find_port_data(cdev, &port_id,
 					       dfl_fpga_check_port_id);
-	if (!pdata)
+	if (!fdata)
 		goto unlock_exit;
 
-	if (!device_is_registered(&pdata->dev->dev)) {
+	if (!device_is_registered(&fdata->dev->dev)) {
 		ret = -EBUSY;
 		goto put_dev_exit;
 	}
 
-	mutex_lock(&pdata->lock);
-	ret = dfl_feature_dev_use_begin(pdata, true);
-	mutex_unlock(&pdata->lock);
+	mutex_lock(&fdata->lock);
+	ret = dfl_feature_dev_use_begin(fdata, true);
+	mutex_unlock(&fdata->lock);
 	if (ret)
 		goto put_dev_exit;
 
-	platform_device_del(pdata->dev);
+	platform_device_del(fdata->dev);
 	cdev->released_port_num++;
 put_dev_exit:
-	put_device(&pdata->dev->dev);
+	put_device(&fdata->dev->dev);
 unlock_exit:
 	mutex_unlock(&cdev->lock);
 	return ret;
@@ -1746,31 +1746,31 @@ EXPORT_SYMBOL_GPL(dfl_fpga_cdev_release_port);
  */
 int dfl_fpga_cdev_assign_port(struct dfl_fpga_cdev *cdev, int port_id)
 {
-	struct dfl_feature_platform_data *pdata;
+	struct dfl_feature_dev_data *fdata;
 	int ret = -ENODEV;
 
 	mutex_lock(&cdev->lock);
-	pdata = __dfl_fpga_cdev_find_port_data(cdev, &port_id,
+	fdata = __dfl_fpga_cdev_find_port_data(cdev, &port_id,
 					       dfl_fpga_check_port_id);
-	if (!pdata)
+	if (!fdata)
 		goto unlock_exit;
 
-	if (device_is_registered(&pdata->dev->dev)) {
+	if (device_is_registered(&fdata->dev->dev)) {
 		ret = -EBUSY;
 		goto put_dev_exit;
 	}
 
-	ret = platform_device_add(pdata->dev);
+	ret = platform_device_add(fdata->dev);
 	if (ret)
 		goto put_dev_exit;
 
-	mutex_lock(&pdata->lock);
-	dfl_feature_dev_use_end(pdata);
-	mutex_unlock(&pdata->lock);
+	mutex_lock(&fdata->lock);
+	dfl_feature_dev_use_end(fdata);
+	mutex_unlock(&fdata->lock);
 
 	cdev->released_port_num--;
 put_dev_exit:
-	put_device(&pdata->dev->dev);
+	put_device(&fdata->dev->dev);
 unlock_exit:
 	mutex_unlock(&cdev->lock);
 	return ret;
@@ -1780,11 +1780,11 @@ EXPORT_SYMBOL_GPL(dfl_fpga_cdev_assign_port);
 static void config_port_access_mode(struct device *fme_dev, int port_id,
 				    bool is_vf)
 {
-	struct dfl_feature_platform_data *pdata = dev_get_platdata(fme_dev);
+	struct dfl_feature_dev_data *fdata = to_dfl_feature_dev_data(fme_dev);
 	void __iomem *base;
 	u64 v;
 
-	base = dfl_get_feature_ioaddr_by_id(pdata, FME_FEATURE_ID_HEADER);
+	base = dfl_get_feature_ioaddr_by_id(fdata, FME_FEATURE_ID_HEADER);
 
 	v = readq(base + FME_HDR_PORT_OFST(port_id));
 
@@ -1808,14 +1808,14 @@ static void config_port_access_mode(struct device *fme_dev, int port_id,
  */
 void dfl_fpga_cdev_config_ports_pf(struct dfl_fpga_cdev *cdev)
 {
-	struct dfl_feature_platform_data *pdata;
+	struct dfl_feature_dev_data *fdata;
 
 	mutex_lock(&cdev->lock);
-	list_for_each_entry(pdata, &cdev->port_dev_list, node) {
-		if (device_is_registered(&pdata->dev->dev))
+	list_for_each_entry(fdata, &cdev->port_dev_list, node) {
+		if (device_is_registered(&fdata->dev->dev))
 			continue;
 
-		config_port_pf_mode(cdev->fme_dev, pdata->id);
+		config_port_pf_mode(cdev->fme_dev, fdata->id);
 	}
 	mutex_unlock(&cdev->lock);
 }
@@ -1834,7 +1834,7 @@ EXPORT_SYMBOL_GPL(dfl_fpga_cdev_config_ports_pf);
  */
 int dfl_fpga_cdev_config_ports_vf(struct dfl_fpga_cdev *cdev, int num_vfs)
 {
-	struct dfl_feature_platform_data *pdata;
+	struct dfl_feature_dev_data *fdata;
 	int ret = 0;
 
 	mutex_lock(&cdev->lock);
@@ -1848,11 +1848,11 @@ int dfl_fpga_cdev_config_ports_vf(struct dfl_fpga_cdev *cdev, int num_vfs)
 		goto done;
 	}
 
-	list_for_each_entry(pdata, &cdev->port_dev_list, node) {
-		if (device_is_registered(&pdata->dev->dev))
+	list_for_each_entry(fdata, &cdev->port_dev_list, node) {
+		if (device_is_registered(&fdata->dev->dev))
 			continue;
 
-		config_port_vf_mode(cdev->fme_dev, pdata->id);
+		config_port_vf_mode(cdev->fme_dev, fdata->id);
 	}
 done:
 	mutex_unlock(&cdev->lock);
@@ -1985,7 +1985,7 @@ long dfl_feature_ioctl_set_irq(struct platform_device *pdev,
 			       struct dfl_feature *feature,
 			       unsigned long arg)
 {
-	struct dfl_feature_platform_data *pdata = dev_get_platdata(&pdev->dev);
+	struct dfl_feature_dev_data *fdata = to_dfl_feature_dev_data(&pdev->dev);
 	struct dfl_fpga_irq_set hdr;
 	s32 *fds;
 	long ret;
@@ -2005,9 +2005,9 @@ long dfl_feature_ioctl_set_irq(struct platform_device *pdev,
 	if (IS_ERR(fds))
 		return PTR_ERR(fds);
 
-	mutex_lock(&pdata->lock);
+	mutex_lock(&fdata->lock);
 	ret = dfl_fpga_set_irq_triggers(feature, hdr.start, hdr.count, fds);
-	mutex_unlock(&pdata->lock);
+	mutex_unlock(&fdata->lock);
 
 	kfree(fds);
 	return ret;
diff --git a/drivers/fpga/dfl.h b/drivers/fpga/dfl.h
index d3a8a8ef908b..bbd74e1744a8 100644
--- a/drivers/fpga/dfl.h
+++ b/drivers/fpga/dfl.h
@@ -208,6 +208,7 @@
 #define PORT_UINT_CAP_FST_VECT	GENMASK_ULL(23, 12)	/* First Vector */
 
 struct dfl_feature_platform_data;
+#define dfl_feature_dev_data dfl_feature_platform_data
 
 /**
  * struct dfl_fpga_port_ops - port ops
@@ -222,15 +223,15 @@ struct dfl_fpga_port_ops {
 	const char *name;
 	struct module *owner;
 	struct list_head node;
-	int (*get_id)(struct dfl_feature_platform_data *pdata);
-	int (*enable_set)(struct dfl_feature_platform_data *pdata, bool enable);
+	int (*get_id)(struct dfl_feature_dev_data *fdata);
+	int (*enable_set)(struct dfl_feature_dev_data *fdata, bool enable);
 };
 
 void dfl_fpga_port_ops_add(struct dfl_fpga_port_ops *ops);
 void dfl_fpga_port_ops_del(struct dfl_fpga_port_ops *ops);
-struct dfl_fpga_port_ops *dfl_fpga_port_ops_get(struct dfl_feature_platform_data *pdata);
+struct dfl_fpga_port_ops *dfl_fpga_port_ops_get(struct dfl_feature_dev_data *fdata);
 void dfl_fpga_port_ops_put(struct dfl_fpga_port_ops *ops);
-int dfl_fpga_check_port_id(struct dfl_feature_platform_data *pdata, void *pport_id);
+int dfl_fpga_check_port_id(struct dfl_feature_dev_data *fdata, void *pport_id);
 
 /**
  * struct dfl_feature_id - dfl private feature id
@@ -336,51 +337,51 @@ struct dfl_feature_platform_data {
 };
 
 static inline
-int dfl_feature_dev_use_begin(struct dfl_feature_platform_data *pdata,
+int dfl_feature_dev_use_begin(struct dfl_feature_dev_data *fdata,
 			      bool excl)
 {
-	if (pdata->excl_open)
+	if (fdata->excl_open)
 		return -EBUSY;
 
 	if (excl) {
-		if (pdata->open_count)
+		if (fdata->open_count)
 			return -EBUSY;
 
-		pdata->excl_open = true;
+		fdata->excl_open = true;
 	}
-	pdata->open_count++;
+	fdata->open_count++;
 
 	return 0;
 }
 
 static inline
-void dfl_feature_dev_use_end(struct dfl_feature_platform_data *pdata)
+void dfl_feature_dev_use_end(struct dfl_feature_dev_data *fdata)
 {
-	pdata->excl_open = false;
+	fdata->excl_open = false;
 
-	if (WARN_ON(pdata->open_count <= 0))
+	if (WARN_ON(fdata->open_count <= 0))
 		return;
 
-	pdata->open_count--;
+	fdata->open_count--;
 }
 
 static inline
-int dfl_feature_dev_use_count(struct dfl_feature_platform_data *pdata)
+int dfl_feature_dev_use_count(struct dfl_feature_dev_data *fdata)
 {
-	return pdata->open_count;
+	return fdata->open_count;
 }
 
 static inline
-void dfl_fpga_pdata_set_private(struct dfl_feature_platform_data *pdata,
+void dfl_fpga_fdata_set_private(struct dfl_feature_dev_data *fdata,
 				void *private)
 {
-	pdata->private = private;
+	fdata->private = private;
 }
 
 static inline
-void *dfl_fpga_pdata_get_private(struct dfl_feature_platform_data *pdata)
+void *dfl_fpga_fdata_get_private(struct dfl_feature_dev_data *fdata)
 {
-	return pdata->private;
+	return fdata->private;
 }
 
 struct dfl_feature_ops {
@@ -413,26 +414,26 @@ dfl_fpga_inode_to_feature_dev_data(struct inode *inode)
 	return pdata;
 }
 
-#define dfl_fpga_dev_for_each_feature(pdata, feature)			    \
-	for ((feature) = (pdata)->features;				    \
-	   (feature) < (pdata)->features + (pdata)->num; (feature)++)
+#define dfl_fpga_dev_for_each_feature(fdata, feature)			    \
+	for ((feature) = (fdata)->features;				    \
+	   (feature) < (fdata)->features + (fdata)->num; (feature)++)
 
-static inline
-struct dfl_feature *dfl_get_feature_by_id(struct dfl_feature_platform_data *pdata, u16 id)
+static inline struct dfl_feature *
+dfl_get_feature_by_id(struct dfl_feature_dev_data *fdata, u16 id)
 {
 	struct dfl_feature *feature;
 
-	dfl_fpga_dev_for_each_feature(pdata, feature)
+	dfl_fpga_dev_for_each_feature(fdata, feature)
 		if (feature->id == id)
 			return feature;
 
 	return NULL;
 }
 
-static inline
-void __iomem *dfl_get_feature_ioaddr_by_id(struct dfl_feature_platform_data *pdata, u16 id)
+static inline void __iomem *
+dfl_get_feature_ioaddr_by_id(struct dfl_feature_dev_data *fdata, u16 id)
 {
-	struct dfl_feature *feature = dfl_get_feature_by_id(pdata, id);
+	struct dfl_feature *feature = dfl_get_feature_by_id(fdata, id);
 
 	if (feature && feature->ioaddr)
 		return feature->ioaddr;
@@ -441,10 +442,12 @@ void __iomem *dfl_get_feature_ioaddr_by_id(struct dfl_feature_platform_data *pda
 	return NULL;
 }
 
+#define to_dfl_feature_dev_data dev_get_platdata
+
 static inline
-struct device *dfl_fpga_pdata_to_parent(struct dfl_feature_platform_data *pdata)
+struct device *dfl_fpga_fdata_to_parent(struct dfl_feature_dev_data *fdata)
 {
-	return pdata->dev->dev.parent->parent;
+	return fdata->dev->dev.parent->parent;
 }
 
 static inline bool dfl_feature_is_fme(void __iomem *base)
@@ -531,21 +534,21 @@ void dfl_fpga_feature_devs_remove(struct dfl_fpga_cdev *cdev);
  * device returned by __dfl_fpga_cdev_find_port and dfl_fpga_cdev_find_port
  * functions.
  */
-struct dfl_feature_platform_data *
+struct dfl_feature_dev_data *
 __dfl_fpga_cdev_find_port_data(struct dfl_fpga_cdev *cdev, void *data,
-			       int (*match)(struct dfl_feature_platform_data *, void *));
+			       int (*match)(struct dfl_feature_dev_data *, void *));
 
-static inline struct dfl_feature_platform_data *
+static inline struct dfl_feature_dev_data *
 dfl_fpga_cdev_find_port_data(struct dfl_fpga_cdev *cdev, void *data,
-			     int (*match)(struct dfl_feature_platform_data *, void *))
+			     int (*match)(struct dfl_feature_dev_data *, void *))
 {
-	struct dfl_feature_platform_data *pdata;
+	struct dfl_feature_dev_data *fdata;
 
 	mutex_lock(&cdev->lock);
-	pdata = __dfl_fpga_cdev_find_port_data(cdev, data, match);
+	fdata = __dfl_fpga_cdev_find_port_data(cdev, data, match);
 	mutex_unlock(&cdev->lock);
 
-	return pdata;
+	return fdata;
 }
 
 int dfl_fpga_cdev_release_port(struct dfl_fpga_cdev *cdev, int port_id);
-- 
2.47.0


