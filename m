Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AB563ACF9B
	for <lists+linux-fpga@lfdr.de>; Fri, 18 Jun 2021 17:59:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232713AbhFRQBo (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 18 Jun 2021 12:01:44 -0400
Received: from mga17.intel.com ([192.55.52.151]:39277 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231697AbhFRQBo (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Fri, 18 Jun 2021 12:01:44 -0400
IronPort-SDR: zvNGvoeXgFUskPThGwx1eu3wHP3nReQwrqiHvq0Sel1XHoDg+BkoTtmzyHBG4PJrH9O6EpBSSJ
 KiJhtB4BOD6A==
X-IronPort-AV: E=McAfee;i="6200,9189,10019"; a="186952978"
X-IronPort-AV: E=Sophos;i="5.83,284,1616482800"; 
   d="scan'208";a="186952978"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2021 08:59:35 -0700
IronPort-SDR: 0/eRG0Y4rcAXklW+w6QtuT/3vNBkzlkNprvo5We1ttYlij1r9pbW4T9dUvnBUDWWtzXagsMdJR
 qVUIi1wzJVjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,284,1616482800"; 
   d="scan'208";a="640743659"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.162])
  by fmsmga005.fm.intel.com with ESMTP; 18 Jun 2021 08:59:32 -0700
Date:   Fri, 18 Jun 2021 23:54:24 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Russ Weight <russell.h.weight@intel.com>
Cc:     mdf@kernel.org, linux-fpga@vger.kernel.org, trix@redhat.com,
        lgoncalv@redhat.com, hao.wu@intel.com, matthew.gerlach@intel.com,
        richard.gong@intel.com
Subject: Re: [PATCH v5 3/3] fpga: region: Use standard dev_release for class
 driver
Message-ID: <20210618155424.GC5626@yilunxu-OptiPlex-7050>
References: <20210616225740.399486-1-russell.h.weight@intel.com>
 <20210616225740.399486-4-russell.h.weight@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210616225740.399486-4-russell.h.weight@intel.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Wed, Jun 16, 2021 at 03:57:40PM -0700, Russ Weight wrote:
> The FPGA region class driver data structure is being treated as a
> managed resource instead of using standard dev_release call-back
> to release the class data structure. This change removes the
> managed resource code and combines the create() and register()
> functions into a single register() function.
> 
> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> ---
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
>  drivers/fpga/dfl-fme-pr.c        |   2 +-
>  drivers/fpga/dfl-fme-region.c    |  32 ++++++---
>  drivers/fpga/dfl.c               |  12 ++--
>  drivers/fpga/fpga-bridge.c       |   2 +-
>  drivers/fpga/fpga-region.c       | 119 ++++++++-----------------------
>  drivers/fpga/of-fpga-region.c    |  14 ++--
>  include/linux/fpga/fpga-region.h |  38 ++++++----
>  7 files changed, 86 insertions(+), 133 deletions(-)
> 
> diff --git a/drivers/fpga/dfl-fme-pr.c b/drivers/fpga/dfl-fme-pr.c
> index d61ce9a18879..4805d8c533d4 100644
> --- a/drivers/fpga/dfl-fme-pr.c
> +++ b/drivers/fpga/dfl-fme-pr.c
> @@ -151,7 +151,7 @@ static int fme_pr(struct platform_device *pdev, unsigned long arg)
>  	 * reenabling the bridge to clear things out between acceleration runs.
>  	 * so no need to hold the bridges after partial reconfiguration.
>  	 */
> -	if (region->get_bridges)
> +	if (region->rops && region->rops->get_bridges)
>  		fpga_bridges_put(&region->bridge_list);
>  
>  	put_device(&region->dev);
> diff --git a/drivers/fpga/dfl-fme-region.c b/drivers/fpga/dfl-fme-region.c
> index a64c13e198a0..16d8b3f6f07a 100644
> --- a/drivers/fpga/dfl-fme-region.c
> +++ b/drivers/fpga/dfl-fme-region.c
> @@ -21,12 +21,29 @@
>  
>  static int fme_region_get_bridges(struct fpga_region *region)
>  {
> -	struct dfl_fme_region_pdata *pdata = region->priv;
> +	struct dfl_fme_region_pdata *pdata = region->rops->priv;
>  	struct device *dev = &pdata->br->dev;
>  
>  	return fpga_bridge_get_to_list(dev, region->info, &region->bridge_list);
>  }
>  
> +static struct fpga_region_ops *
> +fme_region_get_ops(struct device *dev, struct fpga_manager *mgr,
> +		   struct dfl_fme_region_pdata *pdata)
> +{
> +	struct fpga_region_ops *ops;
> +
> +	ops = devm_kzalloc(dev, sizeof(*ops), GFP_KERNEL);
> +	if (!ops)
> +		return NULL;
> +
> +	ops->get_bridges = fme_region_get_bridges;
> +	ops->compat_id = mgr->mops->compat_id;
> +	ops->priv = pdata;
> +
> +	return ops;
> +}
> +
>  static int fme_region_probe(struct platform_device *pdev)
>  {
>  	struct dfl_fme_region_pdata *pdata = dev_get_platdata(&pdev->dev);
> @@ -39,20 +56,15 @@ static int fme_region_probe(struct platform_device *pdev)
>  	if (IS_ERR(mgr))
>  		return -EPROBE_DEFER;
>  
> -	region = devm_fpga_region_create(dev, mgr, fme_region_get_bridges);
> -	if (!region) {
> -		ret = -ENOMEM;
> +	region = fpga_region_register(dev, mgr,
> +				      fme_region_get_ops(dev, mgr, pdata));
> +	if (IS_ERR(region)) {
> +		ret = PTR_ERR(region);
>  		goto eprobe_mgr_put;
>  	}
>  
> -	region->priv = pdata;
> -	region->compat_id = mgr->mops->compat_id;
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
> index 511b20ff35a3..3905995ef6d5 100644
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
> +	cdev->region = fpga_region_register(info->dev, NULL, NULL);
> +	if (IS_ERR(cdev->region)) {
> +		ret = PTR_ERR(cdev->region);
>  		goto free_cdev_exit;
> +	}
>  
>  	/* create and init build info for enumeration */
>  	binfo = devm_kzalloc(info->dev, sizeof(*binfo), GFP_KERNEL);
> diff --git a/drivers/fpga/fpga-bridge.c b/drivers/fpga/fpga-bridge.c
> index 15be378b64ab..f7e8500561f4 100644
> --- a/drivers/fpga/fpga-bridge.c
> +++ b/drivers/fpga/fpga-bridge.c
> @@ -312,7 +312,7 @@ static struct attribute *fpga_bridge_attrs[] = {
>  ATTRIBUTE_GROUPS(fpga_bridge);
>  
>  /**
> - * fpga_bridge_register - create and register a FPGA Bridge device
> + * fpga_bridge_register - create and register an FPGA Bridge device
>   * @parent:	FPGA bridge device from pdev
>   * @name:	FPGA bridge name
>   * @br_ops:	pointer to structure of fpga bridge ops
> diff --git a/drivers/fpga/fpga-region.c b/drivers/fpga/fpga-region.c
> index a4838715221f..7199ad93814f 100644
> --- a/drivers/fpga/fpga-region.c
> +++ b/drivers/fpga/fpga-region.c
> @@ -115,8 +115,8 @@ int fpga_region_program_fpga(struct fpga_region *region)
>  	 * In some cases, we already have a list of bridges in the
>  	 * fpga region struct.  Or we don't have any bridges.
>  	 */
> -	if (region->get_bridges) {
> -		ret = region->get_bridges(region);
> +	if (region->rops && region->rops->get_bridges) {
> +		ret = region->rops->get_bridges(region);
>  		if (ret) {
>  			dev_err(dev, "failed to get fpga region bridges\n");
>  			goto err_unlock_mgr;
> @@ -147,7 +147,7 @@ int fpga_region_program_fpga(struct fpga_region *region)
>  	return 0;
>  
>  err_put_br:
> -	if (region->get_bridges)
> +	if (region->rops && region->rops->get_bridges)
>  		fpga_bridges_put(&region->bridge_list);
>  err_unlock_mgr:
>  	fpga_mgr_unlock(region->mgr);
> @@ -163,12 +163,12 @@ static ssize_t compat_id_show(struct device *dev,
>  {
>  	struct fpga_region *region = to_fpga_region(dev);
>  
> -	if (!region->compat_id)
> +	if (!region->rops || !region->rops->compat_id)
>  		return -ENOENT;
>  
>  	return sprintf(buf, "%016llx%016llx\n",
> -		       (unsigned long long)region->compat_id->id_h,
> -		       (unsigned long long)region->compat_id->id_l);
> +		       (unsigned long long)region->rops->compat_id->id_h,
> +		       (unsigned long long)region->rops->compat_id->id_l);
>  }
>  
>  static DEVICE_ATTR_RO(compat_id);
> @@ -180,39 +180,35 @@ static struct attribute *fpga_region_attrs[] = {
>  ATTRIBUTE_GROUPS(fpga_region);
>  
>  /**
> - * fpga_region_create - alloc and init a struct fpga_region
> + * fpga_region_register - create and register an FPGA Region device
>   * @parent: device parent
>   * @mgr: manager that programs this region
> - * @get_bridges: optional function to get bridges to a list
> + * @rops: optional: FPGA Region ops for low level FPGA Region drivers
>   *
> - * The caller of this function is responsible for freeing the resulting region
> - * struct with fpga_region_free().  Using devm_fpga_region_create() instead is
> - * recommended.
> - *
> - * Return: struct fpga_region or NULL
> + * Return: struct fpga_region or ERR_PTR()
>   */
> -struct fpga_region
> -*fpga_region_create(struct device *parent,
> -		    struct fpga_manager *mgr,
> -		    int (*get_bridges)(struct fpga_region *))
> +struct fpga_region *
> +fpga_region_register(struct device *parent, struct fpga_manager *mgr,
> +		     struct fpga_region_ops *rops)

Is it better we use the same style as fpga_mgr_register?

Thanks,
Yilun

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
>  
>  	region->mgr = mgr;
> -	region->get_bridges = get_bridges;
> +	region->rops = rops;
>  	mutex_init(&region->mutex);
>  	INIT_LIST_HEAD(&region->bridge_list);
>  
> -	device_initialize(&region->dev);
>  	region->dev.class = fpga_region_class;
>  	region->dev.parent = parent;
>  	region->dev.of_node = parent->of_node;
> @@ -222,6 +218,12 @@ struct fpga_region
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
> @@ -229,76 +231,7 @@ struct fpga_region
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
> -}
> -
> -/**
> - * devm_fpga_region_create - create and initialize a managed FPGA region struct
> - * @parent: device parent
> - * @mgr: manager that programs this region
> - * @get_bridges: optional function to get bridges to a list
> - *
> - * This function is intended for use in an FPGA region driver's probe function.
> - * After the region driver creates the region struct with
> - * devm_fpga_region_create(), it should register it with fpga_region_register().
> - * The region driver's remove function should call fpga_region_unregister().
> - * The region struct allocated with this function will be freed automatically on
> - * driver detach.  This includes the case of a probe function returning error
> - * before calling fpga_region_register(), the struct will still get cleaned up.
> - *
> - * Return: struct fpga_region or NULL
> - */
> -struct fpga_region
> -*devm_fpga_region_create(struct device *parent,
> -			 struct fpga_manager *mgr,
> -			 int (*get_bridges)(struct fpga_region *))
> -{
> -	struct fpga_region **ptr, *region;
> -
> -	ptr = devres_alloc(devm_fpga_region_release, sizeof(*ptr), GFP_KERNEL);
> -	if (!ptr)
> -		return NULL;
> -
> -	region = fpga_region_create(parent, mgr, get_bridges);
> -	if (!region) {
> -		devres_free(ptr);
> -	} else {
> -		*ptr = region;
> -		devres_add(parent, ptr);
> -	}
> -
> -	return region;
> -}
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
> +	return ERR_PTR(ret);
>  }
>  EXPORT_SYMBOL_GPL(fpga_region_register);
>  
> @@ -316,6 +249,10 @@ EXPORT_SYMBOL_GPL(fpga_region_unregister);
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
> index e3c25576b6b9..55b7c4ec8f6d 100644
> --- a/drivers/fpga/of-fpga-region.c
> +++ b/drivers/fpga/of-fpga-region.c
> @@ -392,6 +392,10 @@ static struct notifier_block fpga_region_of_nb = {
>  	.notifier_call = of_fpga_region_notify,
>  };
>  
> +static struct fpga_region_ops of_fpga_region_ops = {
> +	.get_bridges = of_fpga_region_get_bridges;
> +};
> +
>  static int of_fpga_region_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> @@ -405,16 +409,12 @@ static int of_fpga_region_probe(struct platform_device *pdev)
>  	if (IS_ERR(mgr))
>  		return -EPROBE_DEFER;
>  
> -	region = devm_fpga_region_create(dev, mgr, of_fpga_region_get_bridges);
> -	if (!region) {
> -		ret = -ENOMEM;
> +	region = fpga_region_register(dev, mgr, &of_fpga_region_ops);
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
> index 27cb706275db..02626dfd41ed 100644
> --- a/include/linux/fpga/fpga-region.h
> +++ b/include/linux/fpga/fpga-region.h
> @@ -7,6 +7,24 @@
>  #include <linux/fpga/fpga-mgr.h>
>  #include <linux/fpga/fpga-bridge.h>
>  
> +struct fpga_region;
> +
> +/**
> + * struct fpga_region_ops - ops for low level fpga region drivers
> + * @get_bridges: optional function to get bridges to a list
> + * @compat_id: optional: FPGA manager id for compatibility check.
> + * @priv: optional: private data
> + *
> + * fpga_region_ops are the low level functions implemented by a specific
> + * fpga region driver.  The optional ones are tested for NULL before being
> + * referenced, so leaving them out is fine.
> + */
> +struct fpga_region_ops {
> +	int (*get_bridges)(struct fpga_region *region);
> +	struct fpga_compat_id *compat_id;
> +	void *priv;
> +};
> +
>  /**
>   * struct fpga_region - FPGA Region structure
>   * @dev: FPGA Region device
> @@ -14,9 +32,7 @@
>   * @bridge_list: list of FPGA bridges specified in region
>   * @mgr: FPGA manager
>   * @info: FPGA image info
> - * @compat_id: FPGA region id for compatibility check.
> - * @priv: private data
> - * @get_bridges: optional function to get bridges to a list
> + * @rops: optional: FPGA Region ops for low level FPGA region drivers
>   */
>  struct fpga_region {
>  	struct device dev;
> @@ -24,9 +40,7 @@ struct fpga_region {
>  	struct list_head bridge_list;
>  	struct fpga_manager *mgr;
>  	struct fpga_image_info *info;
> -	struct fpga_compat_id *compat_id;
> -	void *priv;
> -	int (*get_bridges)(struct fpga_region *region);
> +	struct fpga_region_ops *rops;
>  };
>  
>  #define to_fpga_region(d) container_of(d, struct fpga_region, dev)
> @@ -37,15 +51,9 @@ struct fpga_region *fpga_region_class_find(
>  
>  int fpga_region_program_fpga(struct fpga_region *region);
>  
> -struct fpga_region
> -*fpga_region_create(struct device *dev, struct fpga_manager *mgr,
> -		    int (*get_bridges)(struct fpga_region *));
> -void fpga_region_free(struct fpga_region *region);
> -int fpga_region_register(struct fpga_region *region);
> +struct fpga_region *
> +fpga_region_register(struct device *dev, struct fpga_manager *mgr,
> +		     struct fpga_region_ops *rops);
>  void fpga_region_unregister(struct fpga_region *region);
>  
> -struct fpga_region
> -*devm_fpga_region_create(struct device *dev, struct fpga_manager *mgr,
> -			int (*get_bridges)(struct fpga_region *));
> -
>  #endif /* _FPGA_REGION_H */
> -- 
> 2.25.1
