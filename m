Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7BF750D864
	for <lists+linux-fpga@lfdr.de>; Mon, 25 Apr 2022 06:32:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240876AbiDYEd7 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 25 Apr 2022 00:33:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235076AbiDYEd5 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 25 Apr 2022 00:33:57 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 655513F309;
        Sun, 24 Apr 2022 21:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650861054; x=1682397054;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=89hd6kJ3nzrRo6JJusipc/9vdsoN37aiQs7fLUUIQdg=;
  b=mn5LGffrr5SDiOVEciRw0vTjOg0pPbC7EGeMyG2IipO4LoN1uBSaDsSr
   vyHv7qvfuxv0UukwvszEqJgNlpu+pngPPUXvYgq5tfNbtW5qXOB6Y/EXg
   33qv+0IK0foeFVmLNx96vSvWG2WD1IVrRkCfwigZtu1NnUgFiHmJ1PeCi
   uwQ6biOGdntNlOXDjcNjJIbwkbVvmM4BXCliAfSgYp7LLykHIMpJTZzZa
   CZt/48cPCXqEeWx2saAQ+oGmIGjFG/exTrpPyyMu0Rg6LRO0IlDDe0CWS
   HTjr7cDqSGk0zWo4w92PliWsnKr6gYvV2cNGCnG7lE10G+Xi+F7sgTNc5
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10327"; a="264933285"
X-IronPort-AV: E=Sophos;i="5.90,287,1643702400"; 
   d="scan'208";a="264933285"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2022 21:30:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,287,1643702400"; 
   d="scan'208";a="512461881"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.135])
  by orsmga003.jf.intel.com with ESMTP; 24 Apr 2022 21:30:51 -0700
Date:   Mon, 25 Apr 2022 12:23:10 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Nava kishore Manne <nava.manne@xilinx.com>
Cc:     mdf@kernel.org, hao.wu@intel.com, trix@redhat.com,
        michal.simek@xilinx.com, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        git@xilinx.com
Subject: Re: [PATCH v6 2/5] fpga: fix for coding style issues
Message-ID: <20220425042310.GA363075@yilunxu-OptiPlex-7050>
References: <20220423170235.2115479-1-nava.manne@xilinx.com>
 <20220423170235.2115479-3-nava.manne@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220423170235.2115479-3-nava.manne@xilinx.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Sat, Apr 23, 2022 at 10:32:32PM +0530, Nava kishore Manne wrote:
> fixes the below checks reported by checkpatch.pl:
> - Lines should not end with a '('
> - Alignment should match open parenthesis
> 
> Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>

Acked-by: Xu Yilun <yilun.xu@intel.com>

> ---
> Changes for v2:
>                 -None.
> Changes for v3:
>                -Fixed similar issue exists in "drivers/fpga/*".
> Changes for v4:
>                -None.
> Changes for v5:
>               - Reduced the length of the 'fpga_mgr_write_init(...)' API
>                 as suggested by Joe.
>               - To align Include declaration and definition of APIs updated
>                 the FPGA-region.h file as suggested by joe.
>               - Fixed similar issue exists with of_fpga_region_parse_ov() API.
> 
> Changes for v6:
>               - Align the declaration and definition of APIs as suggested by
>                 Yilun and Joe.
>               - Move the 'count' handling logic into 'else' block as suggested
>                 by Yilun.
> 
>  drivers/fpga/fpga-mgr.c          | 9 +++++----
>  drivers/fpga/fpga-region.c       | 6 +++---
>  drivers/fpga/of-fpga-region.c    | 6 +++---
>  include/linux/fpga/fpga-region.h | 6 +++---
>  4 files changed, 14 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
> index d49a9ce34568..24dee27c7897 100644
> --- a/drivers/fpga/fpga-mgr.c
> +++ b/drivers/fpga/fpga-mgr.c
> @@ -148,11 +148,12 @@ static int fpga_mgr_write_init_buf(struct fpga_manager *mgr,
>  	int ret;
>  
>  	mgr->state = FPGA_MGR_STATE_WRITE_INIT;
> -	if (!mgr->mops->initial_header_size)
> +	if (!mgr->mops->initial_header_size) {
>  		ret = fpga_mgr_write_init(mgr, info, NULL, 0);
> -	else
> -		ret = fpga_mgr_write_init(
> -		    mgr, info, buf, min(mgr->mops->initial_header_size, count));
> +	} else {
> +		count = min(mgr->mops->initial_header_size, count);
> +		ret = fpga_mgr_write_init(mgr, info, buf, count);
> +	}
>  
>  	if (ret) {
>  		dev_err(&mgr->dev, "Error preparing FPGA for writing\n");
> diff --git a/drivers/fpga/fpga-region.c b/drivers/fpga/fpga-region.c
> index b0ac18de4885..485948e3c0db 100644
> --- a/drivers/fpga/fpga-region.c
> +++ b/drivers/fpga/fpga-region.c
> @@ -18,9 +18,9 @@
>  static DEFINE_IDA(fpga_region_ida);
>  static struct class *fpga_region_class;
>  
> -struct fpga_region *fpga_region_class_find(
> -	struct device *start, const void *data,
> -	int (*match)(struct device *, const void *))
> +struct fpga_region *
> +fpga_region_class_find(struct device *start, const void *data,
> +		       int (*match)(struct device *, const void *))
>  {
>  	struct device *dev;
>  
> diff --git a/drivers/fpga/of-fpga-region.c b/drivers/fpga/of-fpga-region.c
> index 50b83057c048..a598d03626af 100644
> --- a/drivers/fpga/of-fpga-region.c
> +++ b/drivers/fpga/of-fpga-region.c
> @@ -189,9 +189,9 @@ static int child_regions_with_firmware(struct device_node *overlay)
>   *   fpga_image_info struct if there is an image to program.
>   *   error code for invalid overlay.
>   */
> -static struct fpga_image_info *of_fpga_region_parse_ov(
> -						struct fpga_region *region,
> -						struct device_node *overlay)
> +static struct fpga_image_info *
> +of_fpga_region_parse_ov(struct fpga_region *region,
> +			struct device_node *overlay)
>  {
>  	struct device *dev = &region->dev;
>  	struct fpga_image_info *info;
> diff --git a/include/linux/fpga/fpga-region.h b/include/linux/fpga/fpga-region.h
> index 3b87f232425c..9d4d32909340 100644
> --- a/include/linux/fpga/fpga-region.h
> +++ b/include/linux/fpga/fpga-region.h
> @@ -52,9 +52,9 @@ struct fpga_region {
>  
>  #define to_fpga_region(d) container_of(d, struct fpga_region, dev)
>  
> -struct fpga_region *fpga_region_class_find(
> -	struct device *start, const void *data,
> -	int (*match)(struct device *, const void *));
> +struct fpga_region *
> +fpga_region_class_find(struct device *start, const void *data,
> +		       int (*match)(struct device *, const void *));
>  
>  int fpga_region_program_fpga(struct fpga_region *region);
>  
> -- 
> 2.25.1
