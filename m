Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE31173F487
	for <lists+linux-fpga@lfdr.de>; Tue, 27 Jun 2023 08:29:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbjF0G1v (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 27 Jun 2023 02:27:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjF0G1u (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 27 Jun 2023 02:27:50 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52C15BF;
        Mon, 26 Jun 2023 23:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687847269; x=1719383269;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=o+fthfSZXkNKVIgP62MykaV0f/1LQv8WAEt1GlzZMG0=;
  b=Pw71a3s3sW5DcaClrjyFSptbOQH4VgiYHFiTRZSQZAE3H3cK9dhkpbA4
   LU9yqi4Jb5CrWUflE4AsO5ziyDWDqMLSebCRXruAl3fcM6chEkX9xOWx/
   4bXQoA5CjDTbyJnmP0sVryCPdjpHyJTpfV9RlETN8LnhVV7Rkp7Gcdepm
   z/T+9rlLoTjbpHOy7dWwkAMIxmqfcKmZtGIIHWt2BEWDsYd4DiCOlmVXO
   o4/IFZWWi0bvKPbBaHwZlxaxeP//EisrPCinN+59qrWBObZdTTQsIKIG2
   2qO40q6zF+X+QHjuf6kMOAm6qTev1gZ0btRYu0vzhH5aw+27MNIhf9c9d
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10753"; a="425155126"
X-IronPort-AV: E=Sophos;i="6.01,161,1684825200"; 
   d="scan'208";a="425155126"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2023 23:27:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10753"; a="786463017"
X-IronPort-AV: E=Sophos;i="6.01,161,1684825200"; 
   d="scan'208";a="786463017"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmsmga004.fm.intel.com with ESMTP; 26 Jun 2023 23:27:36 -0700
Date:   Tue, 27 Jun 2023 14:26:27 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Peter Colberg <peter.colberg@intel.com>
Cc:     hao.wu@intel.com, gregkh@linuxfoundation.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        aaron.j.grier@intel.com, tianfei.zhang@intel.com,
        russell.h.weight@intel.com, matthew.gerlach@linux.intel.com,
        marpagan@redhat.com, lgoncalv@redhat.com,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2] fpga: dfl: afu: use PFN_DOWN() and PFN_PHYS() helper
 macros
Message-ID: <ZJqBE1mCjSaRIvyt@yilunxu-OptiPlex-7050>
References: <2023061908-subscribe-persuader-9b9f@gregkh>
 <20230619195634.11366-1-peter.colberg@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230619195634.11366-1-peter.colberg@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 2023-06-19 at 15:56:34 -0400, Peter Colberg wrote:
> Replace all shifts by PAGE_SHIFT with PFN_DOWN() and PFN_PHYS() helper
> macros to convert between physical addresses and page frame numbers.
> 
> These changes are cosmetic only; no functional changes.
> 
> Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Peter Colberg <peter.colberg@intel.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> v2:
> - Comment in commit message that changes are cosmetic only
> ---
>  drivers/fpga/dfl-afu-dma-region.c | 7 ++++---
>  drivers/fpga/dfl-afu-main.c       | 5 +++--
>  2 files changed, 7 insertions(+), 5 deletions(-)
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

I don't much prefer this change, it is not doing the phy addr to pfn
convertion. The macro name doesn't match what is doing here.

>  	struct device *dev = &pdata->dev->dev;
>  	int ret, pinned;
>  
> @@ -82,7 +83,7 @@ static int afu_dma_pin_pages(struct dfl_feature_platform_data *pdata,
>  static void afu_dma_unpin_pages(struct dfl_feature_platform_data *pdata,
>  				struct dfl_afu_dma_region *region)
>  {
> -	long npages = region->length >> PAGE_SHIFT;
> +	long npages = PFN_DOWN(region->length);

ditto

>  	struct device *dev = &pdata->dev->dev;
>  
>  	unpin_user_pages(region->pages, npages);
> @@ -101,7 +102,7 @@ static void afu_dma_unpin_pages(struct dfl_feature_platform_data *pdata,
>   */
>  static bool afu_dma_check_continuous_pages(struct dfl_afu_dma_region *region)
>  {
> -	int npages = region->length >> PAGE_SHIFT;
> +	int npages = PFN_DOWN(region->length);

ditto

>  	int i;
>  
>  	for (i = 0; i < npages - 1; i++)
> diff --git a/drivers/fpga/dfl-afu-main.c b/drivers/fpga/dfl-afu-main.c
> index 7f621e96d3b8..048c9b418c8b 100644
> --- a/drivers/fpga/dfl-afu-main.c
> +++ b/drivers/fpga/dfl-afu-main.c
> @@ -16,6 +16,7 @@
>  
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> +#include <linux/pfn.h>
>  #include <linux/uaccess.h>
>  #include <linux/fpga-dfl.h>
>  
> @@ -816,7 +817,7 @@ static int afu_mmap(struct file *filp, struct vm_area_struct *vma)
>  
>  	pdata = dev_get_platdata(&pdev->dev);
>  
> -	offset = vma->vm_pgoff << PAGE_SHIFT;
> +	offset = PFN_PHYS(vma->vm_pgoff);

ditto. The variables are offsets within file, not phys addr & pfn.

>  	ret = afu_mmio_region_get_by_offset(pdata, offset, size, &region);
>  	if (ret)
>  		return ret;
> @@ -837,7 +838,7 @@ static int afu_mmap(struct file *filp, struct vm_area_struct *vma)
>  	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
>  
>  	return remap_pfn_range(vma, vma->vm_start,
> -			(region.phys + (offset - region.offset)) >> PAGE_SHIFT,
> +			PFN_DOWN(region.phys + (offset - region.offset)),
>  			size, vma->vm_page_prot);
>  }
>  
> -- 
> 2.28.0
> 
