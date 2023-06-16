Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C84C4733C8F
	for <lists+linux-fpga@lfdr.de>; Sat, 17 Jun 2023 00:44:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbjFPWmv (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 16 Jun 2023 18:42:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233296AbjFPWmu (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 16 Jun 2023 18:42:50 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF1E0359D;
        Fri, 16 Jun 2023 15:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686955368; x=1718491368;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=WAHuZPkTpYdakcNyWlfRht9IrLNPfueKPRu2lmIxPy0=;
  b=XUnUqMez2KqQ0JlaMGnpRMilyQvwYOrfUnluP0iLTpxrnFjMGB+rkiRH
   h/hX8L0bwzDYlMclHJs/1bca4HXLxTZCBa4jUX80WK48oHQQyyGbNT+WJ
   fNyUVH35pjOpu4IRmvVL2ST+SdUX578LQphcl0ApQ6bua68SpkpSbt1SP
   mjl6NHr5beL7kSp0HYUKvOcpYEEPP9uuxx9Qiq1I6TKq1frQ7ySyImis2
   5P9uAiDNpsKy5b8k6jdfpu1oUKeodLFk5UvKiH1mybSZ49W91uzgUcXZu
   jb83sBxVujz4Cb67djbqfRdOVkP4drYaDXHH+sBvFbotxuTgjs0fOw1Y8
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10743"; a="349036930"
X-IronPort-AV: E=Sophos;i="6.00,248,1681196400"; 
   d="scan'208";a="349036930"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2023 15:42:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10743"; a="707251388"
X-IronPort-AV: E=Sophos;i="6.00,248,1681196400"; 
   d="scan'208";a="707251388"
Received: from scc823097.zsc7.intel.com ([10.148.153.229])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2023 15:42:47 -0700
From:   Peter Colberg <peter.colberg@intel.com>
To:     hao.wu@intel.com, yilun.xu@intel.com, gregkh@linuxfoundation.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     aaron.j.grier@intel.com, tianfei.zhang@intel.com,
        russell.h.weight@intel.com, matthew.gerlach@linux.intel.com,
        marpagan@redhat.com, lgoncalv@redhat.com,
        Peter Colberg <peter.colberg@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH] fpga: dfl: afu: use PFN_DOWN() and PFN_PHYS() helper macros
Date:   Fri, 16 Jun 2023 18:42:09 -0400
Message-Id: <20230616224209.20991-1-peter.colberg@intel.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Replace all shifts by PAGE_SHIFT with PFN_DOWN() and PFN_PHYS() helper
macros to convert between physical addresses and page frame numbers.

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Peter Colberg <peter.colberg@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
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

