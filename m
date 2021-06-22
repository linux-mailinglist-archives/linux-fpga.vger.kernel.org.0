Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34ED03AFF35
	for <lists+linux-fpga@lfdr.de>; Tue, 22 Jun 2021 10:25:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbhFVI1W (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 22 Jun 2021 04:27:22 -0400
Received: from mga11.intel.com ([192.55.52.93]:38712 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229747AbhFVI1V (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 22 Jun 2021 04:27:21 -0400
IronPort-SDR: vRBAfgVgv43te4NGOlnGiMqzw053Qy498gTnKa/RyJjQkh2PkVjo2rArA3ummYPTb88lPgeTyI
 zDfNCgNrl3NA==
X-IronPort-AV: E=McAfee;i="6200,9189,10022"; a="204001165"
X-IronPort-AV: E=Sophos;i="5.83,291,1616482800"; 
   d="scan'208";a="204001165"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2021 01:24:59 -0700
IronPort-SDR: IVQLINicmyeDTKcQ4mPSwbU7MnmMXkUyhx668FMC1tXvUIyKDecxiVvR5KiftFg1sWvvKWE3Ka
 lQiiKOalBAUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,291,1616482800"; 
   d="scan'208";a="490200153"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.162])
  by fmsmga002.fm.intel.com with ESMTP; 22 Jun 2021 01:24:57 -0700
Date:   Tue, 22 Jun 2021 16:19:45 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Russ Weight <russell.h.weight@intel.com>
Cc:     mdf@kernel.org, linux-fpga@vger.kernel.org, trix@redhat.com,
        lgoncalv@redhat.com, hao.wu@intel.com, matthew.gerlach@intel.com,
        richard.gong@intel.com
Subject: Re: [PATCH v6 3/3] fpga: region: Use standard dev_release for class
 driver
Message-ID: <20210622081945.GE27046@yilunxu-OptiPlex-7050>
References: <20210621222249.451387-1-russell.h.weight@intel.com>
 <20210621222249.451387-4-russell.h.weight@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210621222249.451387-4-russell.h.weight@intel.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Mon, Jun 21, 2021 at 03:22:49PM -0700, Russ Weight wrote:
> The FPGA region class driver data structure is being treated as a
> managed resource instead of using standard dev_release call-back
> to release the class data structure. This change removes the
> managed resource code and combines the create() and register()
> functions into a single register() function.
> 
> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> ---
> v6:
>   - Moved FPGA manager optional parameters out of the ops structure and
>     back into the FPGA Region structure.
>   - Changed fpga_region_register() parameters to accept an info data
>     structure to provide flexibility in passing optional parameters.
>   - Added fpga_region_register_simple() functions to support current
>     parameters for users that don't require the use of optional parameters.

Add the _simple() description in commit message.

> v5:
>   - Rebased on top of recently accepted patches.
>   - Created the fpga_region_ops data structure which is optionally passed
>     to fpga_region_register(). compat_id, the get_bridges() pointer, and
>     the priv pointer are included in the fpga_region_ops structure.
> v4:
>   - Added the compat_id parameter to fpga_region_register() to ensure
>     that the compat_id is set before the device_register() call.
>   - Modified the dfl_fpga_feature_devs_enumerate() function to restore
>     the fpga_region_register() call to the correct location.
> v3:
>   - Cleaned up comment header for fpga_region_register()
>   - Fix fpga_region_register() error return on ida_simple_get() failure
> v2:
>   - No changes
> ---
>  drivers/fpga/dfl-fme-region.c    |  17 +++--
>  drivers/fpga/dfl.c               |  12 ++--
>  drivers/fpga/fpga-region.c       | 115 +++++++++++--------------------
>  drivers/fpga/of-fpga-region.c    |  11 ++-
>  include/linux/fpga/fpga-region.h |  36 +++++++---
>  5 files changed, 82 insertions(+), 109 deletions(-)
> 
> diff --git a/drivers/fpga/dfl-fme-region.c b/drivers/fpga/dfl-fme-region.c
> index 1eeb42af1012..36bf6865bbc3 100644
> --- a/drivers/fpga/dfl-fme-region.c
> +++ b/drivers/fpga/dfl-fme-region.c
> @@ -30,6 +30,7 @@ static int fme_region_get_bridges(struct fpga_region *region)
>  static int fme_region_probe(struct platform_device *pdev)
>  {
>  	struct dfl_fme_region_pdata *pdata = dev_get_platdata(&pdev->dev);
> +	struct fpga_region_info info = { 0 };
>  	struct device *dev = &pdev->dev;
>  	struct fpga_region *region;
>  	struct fpga_manager *mgr;
> @@ -39,20 +40,18 @@ static int fme_region_probe(struct platform_device *pdev)
>  	if (IS_ERR(mgr))
>  		return -EPROBE_DEFER;
>  
> -	region = devm_fpga_region_create(dev, mgr, fme_region_get_bridges);
> -	if (!region) {
> -		ret = -ENOMEM;
> +	info.mgr = mgr;
> +	info.compat_id = mgr->compat_id;
> +	info.get_bridges = fme_region_get_bridges;
> +	info.priv = pdata;
> +	region = fpga_region_register(dev, &info);
> +	if (IS_ERR(region)) {
> +		ret = PTR_ERR(region);
>  		goto eprobe_mgr_put;
>  	}
>  
> -	region->priv = pdata;
> -	region->compat_id = mgr->compat_id;
>  	platform_set_drvdata(pdev, region);
>  
> -	ret = fpga_region_register(region);
> -	if (ret)
> -		goto eprobe_mgr_put;
> -
>  	dev_dbg(dev, "DFL FME FPGA Region probed\n");
>  
>  	return 0;
> diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
> index 511b20ff35a3..a4269d40586e 100644
> --- a/drivers/fpga/dfl.c
> +++ b/drivers/fpga/dfl.c
> @@ -1400,19 +1400,15 @@ dfl_fpga_feature_devs_enumerate(struct dfl_fpga_enum_info *info)
>  	if (!cdev)
>  		return ERR_PTR(-ENOMEM);
>  
> -	cdev->region = devm_fpga_region_create(info->dev, NULL, NULL);
> -	if (!cdev->region) {
> -		ret = -ENOMEM;
> -		goto free_cdev_exit;
> -	}
> -
>  	cdev->parent = info->dev;
>  	mutex_init(&cdev->lock);
>  	INIT_LIST_HEAD(&cdev->port_dev_list);
>  
> -	ret = fpga_region_register(cdev->region);
> -	if (ret)
> +	cdev->region = fpga_region_register_simple(info->dev, NULL, NULL);
> +	if (IS_ERR(cdev->region)) {
> +		ret = PTR_ERR(cdev->region);
>  		goto free_cdev_exit;
> +	}
>  
>  	/* create and init build info for enumeration */
>  	binfo = devm_kzalloc(info->dev, sizeof(*binfo), GFP_KERNEL);
> diff --git a/drivers/fpga/fpga-region.c b/drivers/fpga/fpga-region.c
> index a4838715221f..0d831b85a98f 100644
> --- a/drivers/fpga/fpga-region.c
> +++ b/drivers/fpga/fpga-region.c
> @@ -180,39 +180,36 @@ static struct attribute *fpga_region_attrs[] = {
>  ATTRIBUTE_GROUPS(fpga_region);
>  
>  /**
> - * fpga_region_create - alloc and init a struct fpga_region
> + * fpga_region_register - create and register an FPGA Region device
>   * @parent: device parent
> - * @mgr: manager that programs this region
> - * @get_bridges: optional function to get bridges to a list
> - *
> - * The caller of this function is responsible for freeing the resulting region
> - * struct with fpga_region_free().  Using devm_fpga_region_create() instead is
> - * recommended.

Same question, introduce a devm_fpga_region_register or leave it later?

> + * @info: parameters for FPGA Region
>   *
> - * Return: struct fpga_region or NULL
> + * Return: struct fpga_region or ERR_PTR()
>   */
> -struct fpga_region
> -*fpga_region_create(struct device *parent,
> -		    struct fpga_manager *mgr,
> -		    int (*get_bridges)(struct fpga_region *))
> +struct fpga_region *
> +fpga_region_register(struct device *parent, struct fpga_region_info *info)

					 const struct fpga_region_info

>  {
>  	struct fpga_region *region;
>  	int id, ret = 0;
>  
>  	region = kzalloc(sizeof(*region), GFP_KERNEL);
>  	if (!region)
> -		return NULL;
> +		return ERR_PTR(-ENOMEM);
>  
>  	id = ida_simple_get(&fpga_region_ida, 0, 0, GFP_KERNEL);
> -	if (id < 0)
> +	if (id < 0) {
> +		ret = id;
>  		goto err_free;
> +	}
> +
> +	region->mgr = info->mgr;
> +	region->compat_id = info->compat_id;
> +	region->priv = info->priv;
> +	region->get_bridges = info->get_bridges;
>  
> -	region->mgr = mgr;
> -	region->get_bridges = get_bridges;
>  	mutex_init(&region->mutex);
>  	INIT_LIST_HEAD(&region->bridge_list);
>  
> -	device_initialize(&region->dev);
>  	region->dev.class = fpga_region_class;
>  	region->dev.parent = parent;
>  	region->dev.of_node = parent->of_node;
> @@ -222,6 +219,12 @@ struct fpga_region
>  	if (ret)
>  		goto err_remove;
>  
> +	ret = device_register(&region->dev);
> +	if (ret) {
> +		put_device(&region->dev);
> +		return ERR_PTR(ret);
> +	}
> +
>  	return region;
>  
>  err_remove:
> @@ -229,78 +232,34 @@ struct fpga_region
>  err_free:
>  	kfree(region);
>  
> -	return NULL;
> -}
> -EXPORT_SYMBOL_GPL(fpga_region_create);
> -
> -/**
> - * fpga_region_free - free an FPGA region created by fpga_region_create()
> - * @region: FPGA region
> - */
> -void fpga_region_free(struct fpga_region *region)
> -{
> -	ida_simple_remove(&fpga_region_ida, region->dev.id);
> -	kfree(region);
> -}
> -EXPORT_SYMBOL_GPL(fpga_region_free);
> -
> -static void devm_fpga_region_release(struct device *dev, void *res)
> -{
> -	struct fpga_region *region = *(struct fpga_region **)res;
> -
> -	fpga_region_free(region);
> +	return ERR_PTR(ret);
>  }
> +EXPORT_SYMBOL_GPL(fpga_region_register);
>  
>  /**
> - * devm_fpga_region_create - create and initialize a managed FPGA region struct
> + * fpga_region_register_simple - create and register an FPGA Region device
>   * @parent: device parent
>   * @mgr: manager that programs this region
>   * @get_bridges: optional function to get bridges to a list
>   *
> - * This function is intended for use in an FPGA region driver's probe function.
> - * After the region driver creates the region struct with
> - * devm_fpga_region_create(), it should register it with fpga_region_register().
> - * The region driver's remove function should call fpga_region_unregister().
> - * The region struct allocated with this function will be freed automatically on
> - * driver detach.  This includes the case of a probe function returning error
> - * before calling fpga_region_register(), the struct will still get cleaned up.
> + * This simple version of the register should be sufficient for most users.
> + * The fpga_bridge_register function is available for users that need to

          fpga_region_register()

> + * pass additional, optional parameters.
>   *
> - * Return: struct fpga_region or NULL
> + * Return: struct fpga_region or ERR_PTR()
>   */
> -struct fpga_region
> -*devm_fpga_region_create(struct device *parent,
> -			 struct fpga_manager *mgr,
> -			 int (*get_bridges)(struct fpga_region *))
> +struct fpga_region *
> +fpga_region_register_simple(struct device *parent, struct fpga_manager *mgr,
> +			    int (*get_bridges)(struct fpga_region *))
>  {
> -	struct fpga_region **ptr, *region;
> -
> -	ptr = devres_alloc(devm_fpga_region_release, sizeof(*ptr), GFP_KERNEL);
> -	if (!ptr)
> -		return NULL;
> +	struct fpga_region_info info = { 0 };
>  
> -	region = fpga_region_create(parent, mgr, get_bridges);
> -	if (!region) {
> -		devres_free(ptr);
> -	} else {
> -		*ptr = region;
> -		devres_add(parent, ptr);
> -	}
> +	info.mgr = mgr;
> +	info.get_bridges = get_bridges;
>  
> -	return region;
> +	return fpga_region_register(parent, &info);
>  }
> -EXPORT_SYMBOL_GPL(devm_fpga_region_create);
> -
> -/**
> - * fpga_region_register - register an FPGA region
> - * @region: FPGA region
> - *
> - * Return: 0 or -errno
> - */
> -int fpga_region_register(struct fpga_region *region)
> -{
> -	return device_add(&region->dev);
> -}
> -EXPORT_SYMBOL_GPL(fpga_region_register);
> +EXPORT_SYMBOL_GPL(fpga_region_register_simple);
>  
>  /**
>   * fpga_region_unregister - unregister an FPGA region
> @@ -316,6 +275,10 @@ EXPORT_SYMBOL_GPL(fpga_region_unregister);
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
> diff --git a/drivers/fpga/of-fpga-region.c b/drivers/fpga/of-fpga-region.c
> index e3c25576b6b9..377d19585d8e 100644
> --- a/drivers/fpga/of-fpga-region.c
> +++ b/drivers/fpga/of-fpga-region.c
> @@ -405,16 +405,13 @@ static int of_fpga_region_probe(struct platform_device *pdev)
>  	if (IS_ERR(mgr))
>  		return -EPROBE_DEFER;
>  
> -	region = devm_fpga_region_create(dev, mgr, of_fpga_region_get_bridges);
> -	if (!region) {
> -		ret = -ENOMEM;
> +	region = fpga_region_register_simple(dev, mgr,
> +					     of_fpga_region_get_bridges);
> +	if (IS_ERR(region)) {
> +		ret = PTR_ERR(region);
>  		goto eprobe_mgr_put;
>  	}
>  
> -	ret = fpga_region_register(region);
> -	if (ret)
> -		goto eprobe_mgr_put;
> -
>  	of_platform_populate(np, fpga_region_of_match, NULL, &region->dev);
>  	platform_set_drvdata(pdev, region);
>  
> diff --git a/include/linux/fpga/fpga-region.h b/include/linux/fpga/fpga-region.h
> index 27cb706275db..7b8f76d52c4e 100644
> --- a/include/linux/fpga/fpga-region.h
> +++ b/include/linux/fpga/fpga-region.h
> @@ -7,6 +7,27 @@
>  #include <linux/fpga/fpga-mgr.h>
>  #include <linux/fpga/fpga-bridge.h>
>  
> +struct fpga_region;
> +
> +/**
> + * struct fpga_region_info - collection of parameters an FPGA Region
> + * @mgr: fpga region manager
> + * @compat_id: FPGA region id for compatibility check.
> + * @priv: fpga region private data
> + * @get_bridges: optional function to get bridges to a list
> + *
> + * fpga_region_info contains parameters for the register function. These
> + * are separated into an info structure because they some are optional
> + * others could be added to in the future. The info structure facilitates
> + * maintaining a stable API.
> + */
> +struct fpga_region_info {
> +	struct fpga_manager *mgr;
> +	struct fpga_compat_id *compat_id;
> +	void *priv;
> +	int (*get_bridges)(struct fpga_region *region);
> +};
> +
>  /**
>   * struct fpga_region - FPGA Region structure
>   * @dev: FPGA Region device
> @@ -37,15 +58,12 @@ struct fpga_region *fpga_region_class_find(
>  
>  int fpga_region_program_fpga(struct fpga_region *region);
>  
> -struct fpga_region
> -*fpga_region_create(struct device *dev, struct fpga_manager *mgr,
> -		    int (*get_bridges)(struct fpga_region *));
> -void fpga_region_free(struct fpga_region *region);
> -int fpga_region_register(struct fpga_region *region);
> -void fpga_region_unregister(struct fpga_region *region);
> +struct fpga_region *
> +fpga_region_register(struct device *dev, struct fpga_region_info *info);

			struct device *parent, const struct fpga_region_info

>  
> -struct fpga_region
> -*devm_fpga_region_create(struct device *dev, struct fpga_manager *mgr,
> -			int (*get_bridges)(struct fpga_region *));
> +struct fpga_region *
> +fpga_region_register_simple(struct device *dev, struct fpga_manager *mgr,

			       struct device *parent

> +			    int (*get_bridges)(struct fpga_region *));
> +void fpga_region_unregister(struct fpga_region *region);
>  
>  #endif /* _FPGA_REGION_H */
> -- 
> 2.25.1
