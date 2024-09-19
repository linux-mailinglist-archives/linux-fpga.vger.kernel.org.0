Return-Path: <linux-fpga+bounces-717-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A290897CE81
	for <lists+linux-fpga@lfdr.de>; Thu, 19 Sep 2024 22:35:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E4601F23C4A
	for <lists+linux-fpga@lfdr.de>; Thu, 19 Sep 2024 20:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 986C11553A2;
	Thu, 19 Sep 2024 20:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IX6ub0Ey"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA18714F121;
	Thu, 19 Sep 2024 20:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726778109; cv=none; b=VYQrFdjTJ0BudG2uEO3tm3m4qDqIckTOGUd2Fk2C/Jr7EVTNiJeHbEB0psXPyL2i+8ooEmDJ6QJzBYaoVwYSkcv8tCgA1FfnnAM/v/ypYPsUCuK8YmIme8EP8i27TvhvcsVEPDmU/8nMUctWSGq2eABE54J0R+QxfpSYTyJbPko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726778109; c=relaxed/simple;
	bh=NBxG8GVowO+/ltoZfBNUn6rpu+2/75XZuoxcwmZNy+0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A0YjVAlAO6exNCMdp8t9bV0loAEgtQkjMrdV8xr1bsot7rwGERGmx1kSLLumtt39AtrZooGDEebkpxd3OnC/Kw1Q2SNKzBRn0gfHVStizEZR/09Rl5m7FM3AOYhkMJPZrc3duj7kmCRngcWMGe7PM/dKrkbWbY/B+miJiCWHxYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IX6ub0Ey; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726778108; x=1758314108;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NBxG8GVowO+/ltoZfBNUn6rpu+2/75XZuoxcwmZNy+0=;
  b=IX6ub0EymzI8tcY+Xh1LC46LIIYHAKA+0wp5vk4yVG0slrggyE/5qjlA
   VKcpu+Zz50lHLeEy7K9IJg2i4b9CNc2eKWdxogJwOKzKpIAjFt/O3Ry/l
   NC+lE5GDoW7gTJZQ8jSP1XlRL3QRVL6+kjAHIjiromhpyENnTRkpkut9F
   7ETJPf9SPPgD8e0TNjovwuuzzqZuScNI8UIsnwiG/MQ5qc5h1wdRIVv2f
   V91YXZeBhLkAAdzbr2ZJX8m+gR7CCqbXsYevAaP5yLPVa1VaLx62dZRcK
   9IgrxjWEuvPrezfSNZQCKPBCS76FBxu95WKaUEb7YoWH5ldAe31kbEN2O
   A==;
X-CSE-ConnectionGUID: 0Po3nZYBTkOFTxB1fA9qTg==
X-CSE-MsgGUID: CG/Xh+RKSmWxxUbkxT27eg==
X-IronPort-AV: E=McAfee;i="6700,10204,11200"; a="25912951"
X-IronPort-AV: E=Sophos;i="6.10,242,1719903600"; 
   d="scan'208";a="25912951"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2024 13:35:06 -0700
X-CSE-ConnectionGUID: 4EEtWJ+qThywobTPs4qNxw==
X-CSE-MsgGUID: hcIgbAzLSA2YxDZOzImvUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,242,1719903600"; 
   d="scan'208";a="93338327"
Received: from sj-4150-psse-sw-opae-dev3.sj.altera.com ([10.244.138.109])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2024 13:35:05 -0700
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
Subject: [PATCH v3 4/9] fpga: dfl: afu: define local pointer to feature device
Date: Thu, 19 Sep 2024 16:34:25 -0400
Message-ID: <20240919203430.1278067-5-peter.colberg@intel.com>
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

Define local pointer to pdata->dev->dev to avoid repetition.

Signed-off-by: Peter Colberg <peter.colberg@intel.com>
Reviewed-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
---
 drivers/fpga/dfl-afu-dma-region.c | 9 +++++----
 drivers/fpga/dfl-afu-region.c     | 5 +++--
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/fpga/dfl-afu-dma-region.c b/drivers/fpga/dfl-afu-dma-region.c
index 02b60fde0430..814191e623e1 100644
--- a/drivers/fpga/dfl-afu-dma-region.c
+++ b/drivers/fpga/dfl-afu-dma-region.c
@@ -301,6 +301,7 @@ afu_dma_region_find_iova(struct dfl_feature_platform_data *pdata, u64 iova)
 int afu_dma_map_region(struct dfl_feature_platform_data *pdata,
 		       u64 user_addr, u64 length, u64 *iova)
 {
+	struct device *dev = &pdata->dev->dev;
 	struct dfl_afu_dma_region *region;
 	int ret;
 
@@ -325,13 +326,13 @@ int afu_dma_map_region(struct dfl_feature_platform_data *pdata,
 	/* Pin the user memory region */
 	ret = afu_dma_pin_pages(pdata, region);
 	if (ret) {
-		dev_err(&pdata->dev->dev, "failed to pin memory region\n");
+		dev_err(dev, "failed to pin memory region\n");
 		goto free_region;
 	}
 
 	/* Only accept continuous pages, return error else */
 	if (!afu_dma_check_continuous_pages(region)) {
-		dev_err(&pdata->dev->dev, "pages are not continuous\n");
+		dev_err(dev, "pages are not continuous\n");
 		ret = -EINVAL;
 		goto unpin_pages;
 	}
@@ -342,7 +343,7 @@ int afu_dma_map_region(struct dfl_feature_platform_data *pdata,
 				    region->length,
 				    DMA_BIDIRECTIONAL);
 	if (dma_mapping_error(dfl_fpga_pdata_to_parent(pdata), region->iova)) {
-		dev_err(&pdata->dev->dev, "failed to map for dma\n");
+		dev_err(dev, "failed to map for dma\n");
 		ret = -EFAULT;
 		goto unpin_pages;
 	}
@@ -353,7 +354,7 @@ int afu_dma_map_region(struct dfl_feature_platform_data *pdata,
 	ret = afu_dma_region_add(pdata, region);
 	mutex_unlock(&pdata->lock);
 	if (ret) {
-		dev_err(&pdata->dev->dev, "failed to add dma region\n");
+		dev_err(dev, "failed to add dma region\n");
 		goto unmap_dma;
 	}
 
diff --git a/drivers/fpga/dfl-afu-region.c b/drivers/fpga/dfl-afu-region.c
index 2e7b41629406..8f0e9485214a 100644
--- a/drivers/fpga/dfl-afu-region.c
+++ b/drivers/fpga/dfl-afu-region.c
@@ -50,11 +50,12 @@ static struct dfl_afu_mmio_region *get_region_by_index(struct dfl_afu *afu,
 int afu_mmio_region_add(struct dfl_feature_platform_data *pdata,
 			u32 region_index, u64 region_size, u64 phys, u32 flags)
 {
+	struct device *dev = &pdata->dev->dev;
 	struct dfl_afu_mmio_region *region;
 	struct dfl_afu *afu;
 	int ret = 0;
 
-	region = devm_kzalloc(&pdata->dev->dev, sizeof(*region), GFP_KERNEL);
+	region = devm_kzalloc(dev, sizeof(*region), GFP_KERNEL);
 	if (!region)
 		return -ENOMEM;
 
@@ -85,7 +86,7 @@ int afu_mmio_region_add(struct dfl_feature_platform_data *pdata,
 	return 0;
 
 exit:
-	devm_kfree(&pdata->dev->dev, region);
+	devm_kfree(dev, region);
 	return ret;
 }
 
-- 
2.46.1


