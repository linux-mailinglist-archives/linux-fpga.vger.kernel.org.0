Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FFBC741CE1
	for <lists+linux-fpga@lfdr.de>; Thu, 29 Jun 2023 02:24:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbjF2AXP (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 28 Jun 2023 20:23:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbjF2AXN (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 28 Jun 2023 20:23:13 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1A091FE5;
        Wed, 28 Jun 2023 17:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687998192; x=1719534192;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NSIVlTxQFEP8tWo4aGIX3eAE9P84KZXLcEh9LxBzi54=;
  b=C8uXwh2iJblUjKMu/kVoYCyz48HTuGDMdcUA8nbDV2bZL0jAZz4XyOP1
   2gYcHBxyZFJm5GtQ+5SY33tVnRi5NUNiwfjvaG0oOyWcBIYeLKateIes/
   vH3qusoxD0sdxhRzWCyxpiU4H1XSGinYVXB6tC/ItqlR+F2vLZnA3q4+f
   FIVvG4FeBsP37WfslyK9ccgQp4TAC+us3o+F5tJ87TNCaZJRCRVgmbAgT
   2z/IciqehnrHHpoAHXRGQ20xmUltJkHRThadCffi/FyWt4svZoUUGxMWq
   w/xlIpDNfxu6dr47C3MrZd9nI/0WwOtKcUYSgBAOQ9y+RkY9jOoB+PEil
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10755"; a="425662788"
X-IronPort-AV: E=Sophos;i="6.01,166,1684825200"; 
   d="scan'208";a="425662788"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2023 17:23:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10755"; a="807122983"
X-IronPort-AV: E=Sophos;i="6.01,166,1684825200"; 
   d="scan'208";a="807122983"
Received: from scc823097.zsc7.intel.com ([10.148.153.229])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2023 17:23:11 -0700
From:   Peter Colberg <peter.colberg@intel.com>
To:     hao.wu@intel.com, yilun.xu@intel.com, gregkh@linuxfoundation.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     aaron.j.grier@intel.com, tianfei.zhang@intel.com,
        russell.h.weight@intel.com, matthew.gerlach@linux.intel.com,
        marpagan@redhat.com, lgoncalv@redhat.com,
        Peter Colberg <peter.colberg@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v3] fpga: dfl: afu: use PFN_DOWN() helper macro
Date:   Wed, 28 Jun 2023 20:22:55 -0400
Message-Id: <20230629002255.25262-1-peter.colberg@intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <ZJvLlHpJwr/tv3gq@yilunxu-OptiPlex-7050>
References: <ZJvLlHpJwr/tv3gq@yilunxu-OptiPlex-7050>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Replace right shifts by PAGE_SHIFT with PFN_DOWN() helper macro to convert
from physical addresses to page frame numbers.

These changes are cosmetic only; no functional changes.

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Peter Colberg <peter.colberg@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v3:
- Revert afu_mmap(), which calculates file offsets, not physical pages
v2:
- Comment in commit message that changes are cosmetic only
---
 drivers/fpga/dfl-afu-dma-region.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/fpga/dfl-afu-dma-region.c b/drivers/fpga/dfl-afu-dma-region.c
index 02b60fde0430..e8d54cfbb301 100644
--- a/drivers/fpga/dfl-afu-dma-region.c
+++ b/drivers/fpga/dfl-afu-dma-region.c
@@ -10,6 +10,7 @@
  */
 
 #include <linux/dma-mapping.h>
+#include <linux/pfn.h>
 #include <linux/sched/signal.h>
 #include <linux/uaccess.h>
 #include <linux/mm.h>
@@ -34,7 +35,7 @@ void afu_dma_region_init(struct dfl_feature_platform_data *pdata)
 static int afu_dma_pin_pages(struct dfl_feature_platform_data *pdata,
 			     struct dfl_afu_dma_region *region)
 {
-	int npages = region->length >> PAGE_SHIFT;
+	int npages = PFN_DOWN(region->length);
 	struct device *dev = &pdata->dev->dev;
 	int ret, pinned;
 
@@ -82,7 +83,7 @@ static int afu_dma_pin_pages(struct dfl_feature_platform_data *pdata,
 static void afu_dma_unpin_pages(struct dfl_feature_platform_data *pdata,
 				struct dfl_afu_dma_region *region)
 {
-	long npages = region->length >> PAGE_SHIFT;
+	long npages = PFN_DOWN(region->length);
 	struct device *dev = &pdata->dev->dev;
 
 	unpin_user_pages(region->pages, npages);
@@ -101,7 +102,7 @@ static void afu_dma_unpin_pages(struct dfl_feature_platform_data *pdata,
  */
 static bool afu_dma_check_continuous_pages(struct dfl_afu_dma_region *region)
 {
-	int npages = region->length >> PAGE_SHIFT;
+	int npages = PFN_DOWN(region->length);
 	int i;
 
 	for (i = 0; i < npages - 1; i++)
-- 
2.28.0

