Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECC383A1A94
	for <lists+linux-fpga@lfdr.de>; Wed,  9 Jun 2021 18:11:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230058AbhFIQNA (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 9 Jun 2021 12:13:00 -0400
Received: from mga05.intel.com ([192.55.52.43]:19064 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229935AbhFIQNA (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 9 Jun 2021 12:13:00 -0400
IronPort-SDR: a1IuFNlq+aHUvTUqL/ze9Y4akXRxlG8y2Xz9vFSNpNU4DKn/A9kCoZIeNqlmEPsJ6kXkLkCAH2
 kMurBLL4IBPg==
X-IronPort-AV: E=McAfee;i="6200,9189,10010"; a="290733363"
X-IronPort-AV: E=Sophos;i="5.83,261,1616482800"; 
   d="scan'208";a="290733363"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2021 09:07:24 -0700
IronPort-SDR: Zz9IXZBmGRJFpwbMFxTdqGgUMf7FcN6EQeCLePnLzMupKbbUqxd5LIjVJDIUqgVIJs116M477e
 UHj4Pff8TDjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,261,1616482800"; 
   d="scan'208";a="482437411"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.162])
  by orsmga001.jf.intel.com with ESMTP; 09 Jun 2021 09:07:19 -0700
Date:   Thu, 10 Jun 2021 00:01:40 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Russ Weight <russell.h.weight@intel.com>
Cc:     mdf@kernel.org, linux-fpga@vger.kernel.org, trix@redhat.com,
        lgoncalv@redhat.com, hao.wu@intel.com, matthew.gerlach@intel.com,
        richard.gong@intel.com
Subject: Re: [PATCH v1 5/5] fpga: region: Use standard dev_release for class
 driver
Message-ID: <20210609160140.GE1994229@yilunxu-OptiPlex-7050>
References: <20210609004925.238044-1-russell.h.weight@intel.com>
 <20210609004925.238044-6-russell.h.weight@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210609004925.238044-6-russell.h.weight@intel.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Tue, Jun 08, 2021 at 05:49:25PM -0700, Russ Weight wrote:
> The FPGA region class driver data structure is being treated as a managed
> resource instead of using standard dev_release call-back to release the
> class data structure. This change populates the class.dev_release function
> and changes the fpga_region_free() function to call put_device().
> It also changes fpga_region_unregister() to call device_del() instead
> of device_unregister().
> 
> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> ---
>  drivers/fpga/fpga-region.c | 46 +++++++++++++++++++-------------------
>  1 file changed, 23 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/fpga/fpga-region.c b/drivers/fpga/fpga-region.c
> index c3134b89c3fe..31836fba559b 100644
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

Same concern, split the renaming changes out.

>  		    struct fpga_manager *mgr,
>  		    int (*get_bridges)(struct fpga_region *))
>  {
> @@ -204,8 +204,10 @@ struct fpga_region
>  		return NULL;
>  
>  	id = ida_simple_get(&fpga_region_ida, 0, 0, GFP_KERNEL);
> -	if (id < 0)
> -		goto err_free;
> +	if (id < 0) {
> +		kfree(region);
> +		return NULL;
> +	}
>  
>  	region->mgr = mgr;
>  	region->get_bridges = get_bridges;
> @@ -214,22 +216,17 @@ struct fpga_region
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
> -	if (ret)
> -		goto err_remove;
> +	if (ret) {
> +		put_device(&region->dev);
> +		return NULL;
> +	}
>  
>  	return region;
> -
> -err_remove:
> -	ida_simple_remove(&fpga_region_ida, id);
> -err_free:
> -	kfree(region);
> -
> -	return NULL;
>  }
>  EXPORT_SYMBOL_GPL(fpga_region_create);
>  
> @@ -239,8 +236,7 @@ EXPORT_SYMBOL_GPL(fpga_region_create);
>   */
>  void fpga_region_free(struct fpga_region *region)
>  {
> -	ida_simple_remove(&fpga_region_ida, region->dev.id);
> -	kfree(region);
> +	put_device(&region->dev);
>  }
>  EXPORT_SYMBOL_GPL(fpga_region_free);
>  
> @@ -248,12 +244,12 @@ static void devm_fpga_region_release(struct device *dev, void *res)
>  {
>  	struct fpga_region *region = *(struct fpga_region **)res;
>  
> -	fpga_region_free(region);
> +	put_device(&region->dev);

Same concern, I prefer to keep it unchanged.

Thanks,
Yilun

>  }
>  
>  /**
>   * devm_fpga_region_create - create and initialize a managed FPGA region struct
> - * @dev: device parent
> + * @parent: device parent
>   * @mgr: manager that programs this region
>   * @get_bridges: optional function to get bridges to a list
>   *
> @@ -268,7 +264,7 @@ static void devm_fpga_region_release(struct device *dev, void *res)
>   * Return: struct fpga_region or NULL
>   */
>  struct fpga_region
> -*devm_fpga_region_create(struct device *dev,
> +*devm_fpga_region_create(struct device *parent,
>  			 struct fpga_manager *mgr,
>  			 int (*get_bridges)(struct fpga_region *))
>  {
> @@ -278,12 +274,12 @@ struct fpga_region
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
> @@ -310,12 +306,16 @@ EXPORT_SYMBOL_GPL(fpga_region_register);
>   */
>  void fpga_region_unregister(struct fpga_region *region)
>  {
> -	device_unregister(&region->dev);
> +	device_del(&region->dev);
>  }
>  EXPORT_SYMBOL_GPL(fpga_region_unregister);
>  
>  static void fpga_region_dev_release(struct device *dev)
>  {
> +	struct fpga_region *region = to_fpga_region(dev);
> +
> +	ida_simple_remove(&fpga_region_ida, region->dev.id);
> +	kfree(region);
>  }
>  
>  /**
> -- 
> 2.25.1
