Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E6A9735E08
	for <lists+linux-fpga@lfdr.de>; Mon, 19 Jun 2023 21:59:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbjFST5i (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 19 Jun 2023 15:57:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjFST5h (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 19 Jun 2023 15:57:37 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39A6A106;
        Mon, 19 Jun 2023 12:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687204656; x=1718740656;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NjOonhgv6kRqKYJYsh94+vyKxX8XtR0LJuZNpxoQawo=;
  b=DY9SV6k49fJEnhMBBSRjcNtVDyZg6Oyvd9gbmF9pa8Dadi8lADXAsNlN
   7IgwnvLAmyThnFwfz5FcfvNchOxKIRZ58RGwEblAXY3MlRGLDrdP55AB/
   hHw0HuMYj2lIXRFGX+JyR0JGwPZYqRnGoLqMJj4iZpTVTZsqmB1vEYxZX
   kENF1CIPSLZvCJj6t+qfJPu+aqhMqmZemenI81WAs7yYF+7LNdo6HX8Mq
   1MqfXQKglkyfl4X30KHNXUM9/UoP6FrOE9eBtV6ItXX5y4Y6C3UWuaPcI
   ncPpBAGRqtIZVo2eN9IuXke8DaA2KQx7jaLYWM6lbn9OMif9DUBCanHki
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10746"; a="446081600"
X-IronPort-AV: E=Sophos;i="6.00,255,1681196400"; 
   d="scan'208";a="446081600"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2023 12:57:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10746"; a="713808239"
X-IronPort-AV: E=Sophos;i="6.00,255,1681196400"; 
   d="scan'208";a="713808239"
Received: from scc823097.zsc7.intel.com ([10.148.153.229])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2023 12:57:13 -0700
From:   Peter Colberg <peter.colberg@intel.com>
To:     hao.wu@intel.com, yilun.xu@intel.com, gregkh@linuxfoundation.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     aaron.j.grier@intel.com, tianfei.zhang@intel.com,
        russell.h.weight@intel.com, matthew.gerlach@linux.intel.com,
        marpagan@redhat.com, lgoncalv@redhat.com,
        Peter Colberg <peter.colberg@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2] fpga: dfl: afu: use PFN_DOWN() and PFN_PHYS() helper macros
Date:   Mon, 19 Jun 2023 15:56:34 -0400
Message-Id: <20230619195634.11366-1-peter.colberg@intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <2023061908-subscribe-persuader-9b9f@gregkh>
References: <2023061908-subscribe-persuader-9b9f@gregkh>
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

Replace all shifts by PAGE_SHIFT with PFN_DOWN() and PFN_PHYS() helper
macros to convert between physical addresses and page frame numbers.

These changes are cosmetic only; no functional changes.

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Peter Colberg <peter.colberg@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2:
- Comment in commit message that changes are cosmetic only
---
 drivers/fpga/dfl-afu-dma-region.c | 7 ++++---
 drivers/fpga/dfl-afu-main.c       | 5 +++--
 2 files changed, 7 insertions(+), 5 deletions(-)

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
diff --git a/drivers/fpga/dfl-afu-main.c b/drivers/fpga/dfl-afu-main.c
index 7f621e96d3b8..048c9b418c8b 100644
--- a/drivers/fpga/dfl-afu-main.c
+++ b/drivers/fpga/dfl-afu-main.c
@@ -16,6 +16,7 @@
 
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/pfn.h>
 #include <linux/uaccess.h>
 #include <linux/fpga-dfl.h>
 
@@ -816,7 +817,7 @@ static int afu_mmap(struct file *filp, struct vm_area_struct *vma)
 
 	pdata = dev_get_platdata(&pdev->dev);
 
-	offset = vma->vm_pgoff << PAGE_SHIFT;
+	offset = PFN_PHYS(vma->vm_pgoff);
 	ret = afu_mmio_region_get_by_offset(pdata, offset, size, &region);
 	if (ret)
 		return ret;
@@ -837,7 +838,7 @@ static int afu_mmap(struct file *filp, struct vm_area_struct *vma)
 	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
 
 	return remap_pfn_range(vma, vma->vm_start,
-			(region.phys + (offset - region.offset)) >> PAGE_SHIFT,
+			PFN_DOWN(region.phys + (offset - region.offset)),
 			size, vma->vm_page_prot);
 }
 
-- 
2.28.0

