Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86EF650A490
	for <lists+linux-fpga@lfdr.de>; Thu, 21 Apr 2022 17:45:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390281AbiDUPpg (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 21 Apr 2022 11:45:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390247AbiDUPpd (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 21 Apr 2022 11:45:33 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82AA848338;
        Thu, 21 Apr 2022 08:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650555729; x=1682091729;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iyrtmVX8R4qF7b2JnARY9AoUPuBqnatgrb6GHKPVUl8=;
  b=ADHoZnqL2pTqR2zIOmGchApPNq0NStekraZsNUiFiRSkNE+g/ftJhJDD
   kh3uKS959Rrhb6qPpiQNof3BxKKAaaMMa1dsRvC+0UabfQeBrbwb6rx47
   OXmKdEWZF5tNoZQg1sQwFbYCk3nmJfzt+7qk1JQbToC1Ht5PIq2BlXTdc
   rvJCJqlXOb78nDzGWEBx/8NvRF46nFqP72hgPrsHKTczE4xsA6n4k06cv
   Rfgw+5nwYkfYykQpecauAXfJ1nuLjgn5AIxpmw0FWDta3xGMl7WCGnjms
   eBExlgr6mEFcDVVgp9jlTpgUbzGNMn3T22zN83FGdZd1eIa/TlhGwtXSV
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="261993861"
X-IronPort-AV: E=Sophos;i="5.90,279,1643702400"; 
   d="scan'208";a="261993861"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2022 08:41:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,279,1643702400"; 
   d="scan'208";a="577302302"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.135])
  by orsmga008.jf.intel.com with ESMTP; 21 Apr 2022 08:41:48 -0700
Date:   Thu, 21 Apr 2022 23:34:11 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Nava kishore Manne <nava.manne@xilinx.com>
Cc:     mdf@kernel.org, hao.wu@intel.com, trix@redhat.com,
        michal.simek@xilinx.com, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        git@xilinx.com
Subject: Re: [PATCH v5 2/5] fpga: fix for coding style issues
Message-ID: <20220421153411.GA347460@yilunxu-OptiPlex-7050>
References: <20220421044744.3777983-1-nava.manne@xilinx.com>
 <20220421044744.3777983-3-nava.manne@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220421044744.3777983-3-nava.manne@xilinx.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Thu, Apr 21, 2022 at 10:17:41AM +0530, Nava kishore Manne wrote:
> fixes the below checks reported by checkpatch.pl:
> - Lines should not end with a '('
> - Alignment should match open parenthesis
> 
> Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
> Acked-by: Xu Yilun <yilun.xu@intel.com>

Sorry, the checkpatch maintainer Joe gives comments after my Acked-by,
so maybe more changes should be made, see my comments inline.

And if you have more changes than expectation, it is better to remove the
Acked-by/Reviewed-by tags, otherwise people thought the reviewers are
good to new changes which are actually not checked at all.

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

The of_fpga_region_parse_ov() changes are also new to us.

> 
>  drivers/fpga/fpga-mgr.c          | 4 ++--
>  drivers/fpga/fpga-region.c       | 7 ++++---
>  drivers/fpga/of-fpga-region.c    | 6 +++---
>  include/linux/fpga/fpga-region.h | 7 ++++---
>  4 files changed, 13 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
> index d49a9ce34568..d9a2aad7b35f 100644
> --- a/drivers/fpga/fpga-mgr.c
> +++ b/drivers/fpga/fpga-mgr.c
> @@ -148,11 +148,11 @@ static int fpga_mgr_write_init_buf(struct fpga_manager *mgr,
>  	int ret;
>  
>  	mgr->state = FPGA_MGR_STATE_WRITE_INIT;
> +	count = min(mgr->mops->initial_header_size, count);

Move the line in 'else' block, cause the count is not used
if(!mgr->mops->initial_header_size).

>  	if (!mgr->mops->initial_header_size)
>  		ret = fpga_mgr_write_init(mgr, info, NULL, 0);
>  	else
> -		ret = fpga_mgr_write_init(
> -		    mgr, info, buf, min(mgr->mops->initial_header_size, count));
> +		ret = fpga_mgr_write_init(mgr, info, buf, count);
>  
>  	if (ret) {
>  		dev_err(&mgr->dev, "Error preparing FPGA for writing\n");
> diff --git a/drivers/fpga/fpga-region.c b/drivers/fpga/fpga-region.c
> index b0ac18de4885..3864bf4f8920 100644
> --- a/drivers/fpga/fpga-region.c
> +++ b/drivers/fpga/fpga-region.c
> @@ -18,9 +18,10 @@
>  static DEFINE_IDA(fpga_region_ida);
>  static struct class *fpga_region_class;
>  
> -struct fpga_region *fpga_region_class_find(
> -	struct device *start, const void *data,
> -	int (*match)(struct device *, const void *))
> +struct fpga_region *fpga_region_class_find(struct device *start,
> +					   const void *data,
> +					   int (*match)(struct device *,
> +							const void *))

According to Joe's suggestion, it had better be:

struct fpga_region *
fpga_region_class_find(struct device *start, const void *data,
		       int (*match)(struct device *, const void *))


>  {
>  	struct device *dev;
>  
> diff --git a/drivers/fpga/of-fpga-region.c b/drivers/fpga/of-fpga-region.c
> index 50b83057c048..55209737075f 100644
> --- a/drivers/fpga/of-fpga-region.c
> +++ b/drivers/fpga/of-fpga-region.c
> @@ -189,9 +189,9 @@ static int child_regions_with_firmware(struct device_node *overlay)
>   *   fpga_image_info struct if there is an image to program.
>   *   error code for invalid overlay.
>   */
> -static struct fpga_image_info *of_fpga_region_parse_ov(
> -						struct fpga_region *region,
> -						struct device_node *overlay)
> +static struct fpga_image_info
> +*of_fpga_region_parse_ov(struct fpga_region *region,
> +			 struct device_node *overlay)

Don't put the '*' at the beginning, it should be:

static struct fpga_image_info *
of_fpga_region_parse_ov(struct fpga_region *region,
			struct device_node *overlay)

>  {
>  	struct device *dev = &region->dev;
>  	struct fpga_image_info *info;
> diff --git a/include/linux/fpga/fpga-region.h b/include/linux/fpga/fpga-region.h
> index 3b87f232425c..7ebf743b8f8a 100644
> --- a/include/linux/fpga/fpga-region.h
> +++ b/include/linux/fpga/fpga-region.h
> @@ -52,9 +52,10 @@ struct fpga_region {
>  
>  #define to_fpga_region(d) container_of(d, struct fpga_region, dev)
>  
> -struct fpga_region *fpga_region_class_find(
> -	struct device *start, const void *data,
> -	int (*match)(struct device *, const void *));
> +struct fpga_region *fpga_region_class_find(struct device *start,
> +					   const void *data,
> +					   int (*match)(struct device *,
> +							const void *));

Please also follow Joe's suggestion:

struct fpga_region *
fpga_region_class_find(struct device *start, const void *data,
		       int (*match)(struct device *, const void *));


Thanks,
Yilun

>  
>  int fpga_region_program_fpga(struct fpga_region *region);
>  
> -- 
> 2.25.1
