Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39E6A691A17
	for <lists+linux-fpga@lfdr.de>; Fri, 10 Feb 2023 09:34:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231318AbjBJIc1 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 10 Feb 2023 03:32:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230465AbjBJIc0 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 10 Feb 2023 03:32:26 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1657E2F783;
        Fri, 10 Feb 2023 00:32:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676017946; x=1707553946;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jFm9xpcveGu9I8CD5MjRI4jO55x+Fmd5yHhB1uzVGgs=;
  b=MVeZWLPH/IeqEoYmFzinyNcMxpZrn9eWJewpqL4hAwYNtQcagaktNpHA
   a9wMSAAcPRPAigVua3gNGiAR7SdWU1eGsBzzoga3Y9BmIJRNQiG6NOgLW
   JA6TryEEXnoL0eO5Mnr2Jcr6eoviFBuUOsGKlmBLflZdRvsiHhvhGTUXg
   i75Rg9VkGcMY4ie7nIE22U/8baec0t2FYI+NqhrlbMAjkXAYHnjZTJxko
   lv084XVfH5EqIiX8DJU7UHdVaqmQhFQxf9N7v4loZ5IvY0fy76B6JKFho
   6aWvMNLXZLBiWJzM/8dRFDPwR1zs2elxldvKqB4VhkOFQmsA4WkBpkRWB
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10616"; a="394973205"
X-IronPort-AV: E=Sophos;i="5.97,286,1669104000"; 
   d="scan'208";a="394973205"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2023 00:32:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10616"; a="661327564"
X-IronPort-AV: E=Sophos;i="5.97,286,1669104000"; 
   d="scan'208";a="661327564"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orsmga007.jf.intel.com with ESMTP; 10 Feb 2023 00:32:24 -0800
Date:   Fri, 10 Feb 2023 16:21:37 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     k1rh4.lee@gmail.com
Cc:     Wu Hao <hao.wu@intel.com>, Tom Rix <trix@redhat.com>,
        Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fpga: dfl-afu-region: Add overflow checks for region
 size and offset
Message-ID: <Y+X+kZResf0a/aES@yilunxu-OptiPlex-7050>
References: <20230206054326.89323-1-k1rh4.lee@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230206054326.89323-1-k1rh4.lee@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 2023-02-05 at 21:43:26 -0800, k1rh4.lee@gmail.com wrote:
> From: Sangsup Lee <k1rh4.lee@gmail.com>
> 
> The size + offset is able to be integer overflow value and it lead to mis-allocate region.

But I didn't see the memory allocation.

> 
> Signed-off-by: Sangsup Lee <k1rh4.lee@gmail.com>
> ---
>  drivers/fpga/dfl-afu-region.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/fpga/dfl-afu-region.c b/drivers/fpga/dfl-afu-region.c
> index 2e7b41629406..82b530111601 100644
> --- a/drivers/fpga/dfl-afu-region.c
> +++ b/drivers/fpga/dfl-afu-region.c
> @@ -151,12 +151,17 @@ int afu_mmio_region_get_by_offset(struct dfl_feature_platform_data *pdata,
>  	struct dfl_afu_mmio_region *region;
>  	struct dfl_afu *afu;
>  	int ret = 0;
> +	u64 region_size = 0;

Reverse Xmax tree please.

>  
>  	mutex_lock(&pdata->lock);
> +	if (check_add_overflow(offset, size, &region_size)) {

I'm not sure if the check is necessary.

The offset comes from: offset = vma->vm_pgoff << PAGE_SHIFT
The size comes from: size = vma->vm_end - vma->vm_start
Is it possible the upper mm layer passes invalid vma?

Thanks,
Yilun

> +		ret = -EINVAL;
> +		goto exit;
> +	}
>  	afu = dfl_fpga_pdata_get_private(pdata);
>  	for_each_region(region, afu)
>  		if (region->offset <= offset &&
> -		    region->offset + region->size >= offset + size) {
> +		    region->offset + region->size >= region_size) {
>  			*pregion = *region;
>  			goto exit;
>  		}
> -- 
> 2.25.1
> 
