Return-Path: <linux-fpga+bounces-954-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3030D9D31B0
	for <lists+linux-fpga@lfdr.de>; Wed, 20 Nov 2024 02:12:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAD1A2832CF
	for <lists+linux-fpga@lfdr.de>; Wed, 20 Nov 2024 01:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1347126C05;
	Wed, 20 Nov 2024 01:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="avwRBza7"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A75056B8C;
	Wed, 20 Nov 2024 01:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732065102; cv=none; b=eBUdRgmbM9wCULaui5GmkRRF+VeuAv5eGHbNlraSaERxIl0DbRC7ReCCsbjSwusVfAq9rb8mRIsv/UEcKFqO3oOPYTZs7fi9tTPuR6HKgW4i8OTFZELQJ7ydwLDxqXLU5covtZh5cnJfZK6Shpzxh2LRyoA53ZAoMMLqDUalhhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732065102; c=relaxed/simple;
	bh=b0LhuUA2ME4PHwgIC1kzHTdJ6tObQVHDg6az3WoiTwA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V3T37eAWSS1rir8g4pPX65Z0wfNm6RaUgCL2vm6RjAWwKCv2h+f/eIvK8CBvBq07bevJ5PAFuFp7KkZ0nhw1bjguEogrdn4+wQGPBWNI+PwMFuLSPFrun9qcop+DWDs9HbEyGkcOCl8LEqr4PVnRLYaoMm8cyR52tvbBpJ6VbEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=avwRBza7; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732065101; x=1763601101;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=b0LhuUA2ME4PHwgIC1kzHTdJ6tObQVHDg6az3WoiTwA=;
  b=avwRBza7V8GwE07s/pyOGUa/mGg8uY9CCSwfw5c7Ce0XjPWxEDW1x+zk
   uFObnDuT1KZo2v5ERqSWPIXS5wm6drpnf4GK69bqEM4ibBDDbjn8XKDmE
   OHWMs7XPs+RZZa8tEReuJESYFnEn26rp8rYmO3Dxv9hxprjr18dCugjD3
   BVqcmGhyLh8RiAOEccw6uvTL6XHu6aCBAQELp1qXQsloiKKVTBvYuBgI9
   um06DQFBMspTsVptk6sT07jn2aW+iEedNa6Qh9/BIBXuOsMMOT308iQ5e
   O1jegB8zM6qJtBwb+4JK0fYKrPToViHb88Gu0hsFAeSd4bk2kb81DcsUx
   g==;
X-CSE-ConnectionGUID: QBMIHYkrTkS3IY2G1IN81g==
X-CSE-MsgGUID: SElnyAmXTf+OM6q/58w1oQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11261"; a="42612978"
X-IronPort-AV: E=Sophos;i="6.12,168,1728975600"; 
   d="scan'208";a="42612978"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2024 17:11:39 -0800
X-CSE-ConnectionGUID: D+u6w4JKS8Gsqg+pEOislQ==
X-CSE-MsgGUID: 4MADt0qQTKem5cMcVQGWqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,168,1728975600"; 
   d="scan'208";a="93813575"
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
Subject: [PATCH v5 04/18] fpga: dfl: afu: define local pointer to feature device
Date: Tue, 19 Nov 2024 20:10:20 -0500
Message-ID: <20241120011035.230574-5-peter.colberg@intel.com>
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

Define local pointer to pdata->dev->dev to avoid repetition.

Signed-off-by: Peter Colberg <peter.colberg@intel.com>
Reviewed-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
Reviewed-by: Basheer Ahmed Muddebihal <basheer.ahmed.muddebihal@linux.intel.com>
Acked-by: Xu Yilun <yilun.xu@intel.com>
---
Changes since v4:
- No changes.

Changes since v3:
- No changes.

Changes since v2:
- New patch extracted from monolithic v1 patch.
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
2.47.0


