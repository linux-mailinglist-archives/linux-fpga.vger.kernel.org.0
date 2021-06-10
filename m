Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 034223A2713
	for <lists+linux-fpga@lfdr.de>; Thu, 10 Jun 2021 10:31:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230199AbhFJIdS (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 10 Jun 2021 04:33:18 -0400
Received: from mga18.intel.com ([134.134.136.126]:51415 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230409AbhFJIdD (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 10 Jun 2021 04:33:03 -0400
IronPort-SDR: ph2P3D2O+xulcSMTGQZ7wXVAZIxX+qS/AXnLdCuJQ1NVqWKlw0cqb5DwVqP2xt/HMiqLUbT62x
 ONbdoh+o/azw==
X-IronPort-AV: E=McAfee;i="6200,9189,10010"; a="192571337"
X-IronPort-AV: E=Sophos;i="5.83,263,1616482800"; 
   d="scan'208";a="192571337"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2021 01:30:45 -0700
IronPort-SDR: UHIo7zeOgNAMqPdLfm1kidrBBXPogmhgBfTKmv74nxhDVkftnM3Rr0fcDveBBCB/a7ks3/Ixf0
 ZtRybRLVihIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,263,1616482800"; 
   d="scan'208";a="414050069"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.162])
  by fmsmga007.fm.intel.com with ESMTP; 10 Jun 2021 01:30:42 -0700
Date:   Thu, 10 Jun 2021 16:25:02 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Russ Weight <russell.h.weight@intel.com>
Cc:     mdf@kernel.org, linux-fpga@vger.kernel.org, trix@redhat.com,
        lgoncalv@redhat.com, hao.wu@intel.com, matthew.gerlach@intel.com,
        richard.gong@intel.com
Subject: Re: [PATCH v2 5/8] fpga: region: Rename dev to parent for parent
 device
Message-ID: <20210610082502.GG2007225@yilunxu-OptiPlex-7050>
References: <20210609221135.261837-1-russell.h.weight@intel.com>
 <20210609221135.261837-6-russell.h.weight@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210609221135.261837-6-russell.h.weight@intel.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Sorry, one more minor comment inline.

On Wed, Jun 09, 2021 at 03:11:32PM -0700, Russ Weight wrote:
> Rename variable "dev" to "parent" in cases where it represents the parent
> device.
> 
> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> ---
> v2:
>   - This patch contains the renaming of "dev" to "parent" that was previously
>     part of the patch: "fpga: region: Use standard dev_release for class driver"
> ---
>  drivers/fpga/fpga-region.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/fpga/fpga-region.c b/drivers/fpga/fpga-region.c
> index c3134b89c3fe..563626d66e56 100644
> --- a/drivers/fpga/fpga-region.c
> +++ b/drivers/fpga/fpga-region.c
> @@ -181,7 +181,7 @@ ATTRIBUTE_GROUPS(fpga_region);
>  
>  /**
>   * fpga_region_create - alloc and init a struct fpga_region
> - * @dev: device parent
> + * @parent: device parent
>   * @mgr: manager that programs this region
>   * @get_bridges: optional function to get bridges to a list
>   *
> @@ -192,7 +192,7 @@ ATTRIBUTE_GROUPS(fpga_region);
>   * Return: struct fpga_region or NULL
>   */
>  struct fpga_region
> -*fpga_region_create(struct device *dev,
> +*fpga_region_create(struct device *parent,
>  		    struct fpga_manager *mgr,
>  		    int (*get_bridges)(struct fpga_region *))
>  {
> @@ -214,8 +214,8 @@ struct fpga_region
>  
>  	device_initialize(&region->dev);
>  	region->dev.class = fpga_region_class;
> -	region->dev.parent = dev;
> -	region->dev.of_node = dev->of_node;
> +	region->dev.parent = parent;
> +	region->dev.of_node = parent->of_node;
>  	region->dev.id = id;
>  
>  	ret = dev_set_name(&region->dev, "region%d", id);
> @@ -268,7 +268,7 @@ static void devm_fpga_region_release(struct device *dev, void *res)
>   * Return: struct fpga_region or NULL
>   */
>  struct fpga_region
> -*devm_fpga_region_create(struct device *dev,
> +*devm_fpga_region_create(struct device *parent,

You missed the function description doc change in Patch #8

Thanks,
Yilun

>  			 struct fpga_manager *mgr,
>  			 int (*get_bridges)(struct fpga_region *))



>  {
> @@ -278,12 +278,12 @@ struct fpga_region
>  	if (!ptr)
>  		return NULL;
>  
> -	region = fpga_region_create(dev, mgr, get_bridges);
> +	region = fpga_region_create(parent, mgr, get_bridges);
>  	if (!region) {
>  		devres_free(ptr);
>  	} else {
>  		*ptr = region;
> -		devres_add(dev, ptr);
> +		devres_add(parent, ptr);
>  	}
>  
>  	return region;
> -- 
> 2.25.1
