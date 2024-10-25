Return-Path: <linux-fpga+bounces-897-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A68BF9B12C5
	for <lists+linux-fpga@lfdr.de>; Sat, 26 Oct 2024 00:38:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35A631F21A21
	for <lists+linux-fpga@lfdr.de>; Fri, 25 Oct 2024 22:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CFD7215C50;
	Fri, 25 Oct 2024 22:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d1Jp6yr8"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E85320EA57;
	Fri, 25 Oct 2024 22:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729895861; cv=none; b=qKQ1Jk3wMs1wDci7fs2n8NIyfoOKgYaxaSFCzpfT0bR+hRYZrtDwhlpjM5459tWyLHrrOEerSqYjCLseENCHaJdL2vIiXddZmomRsrK6kSB1KiqnHylnaUiL+zhglENEDHdzBB9HJp9AbSvv/Yve6ZgNaE8t1CKwinOoPnld4IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729895861; c=relaxed/simple;
	bh=4EpIr/QbHAf5VSnHA+eoSdbqRod75X1ulEa3Hi5vx4U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hiq115eYs4Wc045eNeFTlby8REvgkcE64Wc3xpPZhxoy/z8DqkPuyyZ/8+nnZk0X+AXOh6w0gDEN08XyneJ15JObzMcVohf5m2vJ3eagZhkfJ6KkGBxBQjPbQgEVCaqw2t5WsQ4H7w7kdqKtE69iCNG1wuwcLgabWsaXWeF2OVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d1Jp6yr8; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729895859; x=1761431859;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4EpIr/QbHAf5VSnHA+eoSdbqRod75X1ulEa3Hi5vx4U=;
  b=d1Jp6yr89m/JXcOCdcWub/nGCqLhUmuL+6ifo3WLQp6yAO/kq0HjYm0v
   cOjbE2QnaLgaKMDBwa9m7F0dFI9u4SO9zmkOKmhpntm1nWv0OJrLBOssd
   tP5q/xHNCRb9VEQc+N47330XO0xh885W+YsDEdFVxye2dtXw4j7rhzW2f
   oI3O+s0drT1X3qeczUosPc+q4pMS/Ds/SxRJISHnhZNcNmnr8uxJYuPHs
   RfDBizIJyLcf0OuBClZt8DZC5/Lzh1PPxd92bzgzNdFQEO49zyF8odIsx
   6yjCvRnApnn55TiUpHVTl5hjGKzWAYdTbmgoznMLmL0s9TbQu9ZsPfnyw
   g==;
X-CSE-ConnectionGUID: jQ5ClB3cTFiPsMIn9IQvjQ==
X-CSE-MsgGUID: ez2fxgVGS7STST6s7NjlrQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11236"; a="29474632"
X-IronPort-AV: E=Sophos;i="6.11,233,1725346800"; 
   d="scan'208";a="29474632"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 15:37:37 -0700
X-CSE-ConnectionGUID: 0CyB29yATDiKLsDvmAkaLw==
X-CSE-MsgGUID: 83NTp/o1TIyCo+Mo4COcjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,233,1725346800"; 
   d="scan'208";a="85596143"
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
Subject: [PATCH v4 04/19] fpga: dfl: afu: define local pointer to feature device
Date: Fri, 25 Oct 2024 18:36:59 -0400
Message-ID: <20241025223714.394533-5-peter.colberg@intel.com>
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

Define local pointer to pdata->dev->dev to avoid repetition.

Signed-off-by: Peter Colberg <peter.colberg@intel.com>
Reviewed-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
Reviewed-by: Basheer Ahmed Muddebihal <basheer.ahmed.muddebihal@linux.intel.com>
---
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


