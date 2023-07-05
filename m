Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDCF2747BA1
	for <lists+linux-fpga@lfdr.de>; Wed,  5 Jul 2023 04:56:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230448AbjGECzP (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 4 Jul 2023 22:55:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230437AbjGECzO (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 4 Jul 2023 22:55:14 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E60BC10FB;
        Tue,  4 Jul 2023 19:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688525713; x=1720061713;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1Jl+5/3iICde90mhWtlEKUB3c1yzRXMoUe/SxfyPzYs=;
  b=mOc+cH68RubjJh9mCFEEGGpJCoP2Rr7Wl04dqEEOss+9194Z2Pc10OsH
   oM/8DI8Nb7ac80DvzlkJKUUrMPppTvhhLeqniPg11vLp8I+tXwvXXWjEb
   IMjPR3nQ2PRu0gVI3WAnm3RRR43zVYNp1S1NxGGMrIWOIkR1KGrFAy682
   lL0iGBk11of+fmaGYYxvvjVutLuhzbo8hU+ixSeeWtwQQOXdiVYztj6rG
   dOwbYl/weQerRLY3p0vOBCKH7O4hRft/Bvk89PLvAOn2a9XeurfGeaFsL
   Zjpk628N/x5VRQ/PAPT/37jfIfO1sVaeu3oa/RgmleYMELiSRZ1pq0nhz
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10761"; a="343567180"
X-IronPort-AV: E=Sophos;i="6.01,181,1684825200"; 
   d="scan'208";a="343567180"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2023 19:55:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10761"; a="754206085"
X-IronPort-AV: E=Sophos;i="6.01,181,1684825200"; 
   d="scan'208";a="754206085"
Received: from scc823097.zsc7.intel.com ([10.148.153.229])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2023 19:55:13 -0700
From:   Peter Colberg <peter.colberg@intel.com>
To:     Wu Hao <hao.wu@intel.com>, Tom Rix <trix@redhat.com>,
        Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        tianfei.zhang@intel.com, russell.h.weight@intel.com,
        matthew.gerlach@linux.intel.com, marpagan@redhat.com,
        lgoncalv@redhat.com, Peter Colberg <peter.colberg@intel.com>
Subject: [PATCH 2/2] fpga: dfl: omit unneeded casts of u64 values for dev_dbg()
Date:   Tue,  4 Jul 2023 22:54:51 -0400
Message-Id: <0cffb04a207a98148c61f512aa4dc90880e51251.1687301688.git.peter.colberg@intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1687301688.git.peter.colberg@intel.com>
References: <cover.1687301688.git.peter.colberg@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Omit unneeded casts of u64 values to unsigned long long for use with
printk() format specifier %llx. Unlike user space, the kernel defines
u64 as unsigned long long for all architectures; see commit 2a7930bd77fe
("Documentation/printk-formats.txt: No casts needed for u64/s64").

These changes are cosmetic only; no functional changes.

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Peter Colberg <peter.colberg@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/fpga/dfl-afu-dma-region.c | 14 ++++++--------
 drivers/fpga/dfl-afu-main.c       |  4 +---
 drivers/fpga/dfl-fme-mgr.c        |  5 ++---
 3 files changed, 9 insertions(+), 14 deletions(-)

diff --git a/drivers/fpga/dfl-afu-dma-region.c b/drivers/fpga/dfl-afu-dma-region.c
index 02b60fde0430..71ed9d394d07 100644
--- a/drivers/fpga/dfl-afu-dma-region.c
+++ b/drivers/fpga/dfl-afu-dma-region.c
@@ -146,8 +146,7 @@ static int afu_dma_region_add(struct dfl_feature_platform_data *pdata,
 	struct dfl_afu *afu = dfl_fpga_pdata_get_private(pdata);
 	struct rb_node **new, *parent = NULL;
 
-	dev_dbg(&pdata->dev->dev, "add region (iova = %llx)\n",
-		(unsigned long long)region->iova);
+	dev_dbg(&pdata->dev->dev, "add region (iova = %llx)\n", region->iova);
 
 	new = &afu->dma_regions.rb_node;
 
@@ -187,8 +186,7 @@ static void afu_dma_region_remove(struct dfl_feature_platform_data *pdata,
 {
 	struct dfl_afu *afu;
 
-	dev_dbg(&pdata->dev->dev, "del region (iova = %llx)\n",
-		(unsigned long long)region->iova);
+	dev_dbg(&pdata->dev->dev, "del region (iova = %llx)\n", region->iova);
 
 	afu = dfl_fpga_pdata_get_private(pdata);
 	rb_erase(&region->node, &afu->dma_regions);
@@ -210,7 +208,7 @@ void afu_dma_region_destroy(struct dfl_feature_platform_data *pdata)
 		region = container_of(node, struct dfl_afu_dma_region, node);
 
 		dev_dbg(&pdata->dev->dev, "del region (iova = %llx)\n",
-			(unsigned long long)region->iova);
+			region->iova);
 
 		rb_erase(node, &afu->dma_regions);
 
@@ -255,7 +253,7 @@ afu_dma_region_find(struct dfl_feature_platform_data *pdata, u64 iova, u64 size)
 
 		if (dma_region_check_iova(region, iova, size)) {
 			dev_dbg(dev, "find region (iova = %llx)\n",
-				(unsigned long long)region->iova);
+				region->iova);
 			return region;
 		}
 
@@ -268,8 +266,8 @@ afu_dma_region_find(struct dfl_feature_platform_data *pdata, u64 iova, u64 size)
 			break;
 	}
 
-	dev_dbg(dev, "region with iova %llx and size %llx is not found\n",
-		(unsigned long long)iova, (unsigned long long)size);
+	dev_dbg(dev, "region with iova %llx and size %llx is not found\n", iova,
+		size);
 
 	return NULL;
 }
diff --git a/drivers/fpga/dfl-afu-main.c b/drivers/fpga/dfl-afu-main.c
index 51fdbe8a2f26..f81b44767c31 100644
--- a/drivers/fpga/dfl-afu-main.c
+++ b/drivers/fpga/dfl-afu-main.c
@@ -729,9 +729,7 @@ afu_ioctl_dma_map(struct dfl_feature_platform_data *pdata, void __user *arg)
 	}
 
 	dev_dbg(&pdata->dev->dev, "dma map: ua=%llx, len=%llx, iova=%llx\n",
-		(unsigned long long)map.user_addr,
-		(unsigned long long)map.length,
-		(unsigned long long)map.iova);
+		map.user_addr, map.length, map.iova);
 
 	return 0;
 }
diff --git a/drivers/fpga/dfl-fme-mgr.c b/drivers/fpga/dfl-fme-mgr.c
index af0785783b52..7fb7a0aca1dc 100644
--- a/drivers/fpga/dfl-fme-mgr.c
+++ b/drivers/fpga/dfl-fme-mgr.c
@@ -150,7 +150,7 @@ static int fme_mgr_write_init(struct fpga_manager *mgr,
 	priv->pr_error = fme_mgr_pr_error_handle(fme_pr);
 	if (priv->pr_error)
 		dev_dbg(dev, "previous PR error detected %llx\n",
-			(unsigned long long)priv->pr_error);
+			priv->pr_error);
 
 	dev_dbg(dev, "set PR port ID\n");
 
@@ -242,8 +242,7 @@ static int fme_mgr_write_complete(struct fpga_manager *mgr,
 	dev_dbg(dev, "PR operation complete, checking status\n");
 	priv->pr_error = fme_mgr_pr_error_handle(fme_pr);
 	if (priv->pr_error) {
-		dev_dbg(dev, "PR error detected %llx\n",
-			(unsigned long long)priv->pr_error);
+		dev_dbg(dev, "PR error detected %llx\n", priv->pr_error);
 		return -EIO;
 	}
 
-- 
2.28.0

