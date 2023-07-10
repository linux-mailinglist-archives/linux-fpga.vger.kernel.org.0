Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6273A74CD3B
	for <lists+linux-fpga@lfdr.de>; Mon, 10 Jul 2023 08:39:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbjGJGiE (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 10 Jul 2023 02:38:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231435AbjGJGh7 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 10 Jul 2023 02:37:59 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4360CE73;
        Sun,  9 Jul 2023 23:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688971054; x=1720507054;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Fq8L0jRrWp8MFI20LM4QP+Y9mNsBbARTx9OQBMf9Qb4=;
  b=LgA0kahpXY/rxme/iJDop5Rzl/fbp5WINHIvW5jJtHcGFBZNl6CdMaag
   wY/ENoea5ZfAbQc4+4LwizXTzidOTzBbefL7OyYF//BEml+deITt/saEh
   TmDmhJmOSsuA8aODG68LzI+sbcLgZNHLpQPxrqheVpdXuiUprgmCOjm53
   oIae6I4aTj2Lf0RuKUXTVX5zq9vTsYaU3WY4pTufiM2vSz4FJsy1bKnJz
   tis3GWDbpl8gsZUyKEUVlrfoI3lg/XCUeNlfKD4quRy926WV7f5Kll/Cc
   BqdzqMb20G6++fLmTAvA1IpcIpsCL6Nhe0tjZPot872H5xtuQeVMoZHo+
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10766"; a="430340497"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="430340497"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2023 23:37:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10766"; a="894675457"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="894675457"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orsmga005.jf.intel.com with ESMTP; 09 Jul 2023 23:37:16 -0700
Date:   Mon, 10 Jul 2023 14:35:49 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Peter Colberg <peter.colberg@intel.com>
Cc:     hao.wu@intel.com, gregkh@linuxfoundation.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        aaron.j.grier@intel.com, tianfei.zhang@intel.com,
        russell.h.weight@intel.com, matthew.gerlach@linux.intel.com,
        marpagan@redhat.com, lgoncalv@redhat.com,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v3] fpga: dfl: afu: use PFN_DOWN() helper macro
Message-ID: <ZKumxfO5SaXXEer1@yilunxu-OptiPlex-7050>
References: <ZJvLlHpJwr/tv3gq@yilunxu-OptiPlex-7050>
 <20230629002255.25262-1-peter.colberg@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230629002255.25262-1-peter.colberg@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 2023-06-28 at 20:22:55 -0400, Peter Colberg wrote:
> Replace right shifts by PAGE_SHIFT with PFN_DOWN() helper macro to convert
> from physical addresses to page frame numbers.
> 
> These changes are cosmetic only; no functional changes.
> 
> Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Peter Colberg <peter.colberg@intel.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> v3:
> - Revert afu_mmap(), which calculates file offsets, not physical pages
> v2:
> - Comment in commit message that changes are cosmetic only
> ---
>  drivers/fpga/dfl-afu-dma-region.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/fpga/dfl-afu-dma-region.c b/drivers/fpga/dfl-afu-dma-region.c
> index 02b60fde0430..e8d54cfbb301 100644
> --- a/drivers/fpga/dfl-afu-dma-region.c
> +++ b/drivers/fpga/dfl-afu-dma-region.c
> @@ -10,6 +10,7 @@
>   */
>  
>  #include <linux/dma-mapping.h>
> +#include <linux/pfn.h>
>  #include <linux/sched/signal.h>
>  #include <linux/uaccess.h>
>  #include <linux/mm.h>
> @@ -34,7 +35,7 @@ void afu_dma_region_init(struct dfl_feature_platform_data *pdata)
>  static int afu_dma_pin_pages(struct dfl_feature_platform_data *pdata,
>  			     struct dfl_afu_dma_region *region)
>  {
> -	int npages = region->length >> PAGE_SHIFT;
> +	int npages = PFN_DOWN(region->length);
>  	struct device *dev = &pdata->dev->dev;
>  	int ret, pinned;
>  
> @@ -82,7 +83,7 @@ static int afu_dma_pin_pages(struct dfl_feature_platform_data *pdata,
>  static void afu_dma_unpin_pages(struct dfl_feature_platform_data *pdata,
>  				struct dfl_afu_dma_region *region)
>  {
> -	long npages = region->length >> PAGE_SHIFT;
> +	long npages = PFN_DOWN(region->length);
>  	struct device *dev = &pdata->dev->dev;
>  
>  	unpin_user_pages(region->pages, npages);
> @@ -101,7 +102,7 @@ static void afu_dma_unpin_pages(struct dfl_feature_platform_data *pdata,
>   */
>  static bool afu_dma_check_continuous_pages(struct dfl_afu_dma_region *region)
>  {
> -	int npages = region->length >> PAGE_SHIFT;
> +	int npages = PFN_DOWN(region->length);
>  	int i;
>  
>  	for (i = 0; i < npages - 1; i++)



@@ -837,7 +838,7 @@ static int afu_mmap(struct file *filp, struct vm_area_struct *vma)
        vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);

        return remap_pfn_range(vma, vma->vm_start,
-                       (region.phys + (offset - region.offset)) >> PAGE_SHIFT,
+                       PFN_DOWN(region.phys + (offset - region.offset)),
                        size, vma->vm_page_prot);


Why is this change also dropped? Maybe use PHYS_PFN() instead?

Thanks,
Yilun

> -- 
> 2.28.0
> 
