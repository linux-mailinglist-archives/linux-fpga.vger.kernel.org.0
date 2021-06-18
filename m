Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8E223ACF92
	for <lists+linux-fpga@lfdr.de>; Fri, 18 Jun 2021 17:58:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232182AbhFRQAL (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 18 Jun 2021 12:00:11 -0400
Received: from mga11.intel.com ([192.55.52.93]:47657 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231697AbhFRQAK (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Fri, 18 Jun 2021 12:00:10 -0400
IronPort-SDR: 7wgK1J73DlXd1MvZm6GIj6iY8zivGAACTEgKRik8+7FSVJwhHWL8Bdat74xTiBmq5Ncyo/KyX5
 uxjmoj+07Dnw==
X-IronPort-AV: E=McAfee;i="6200,9189,10019"; a="203554040"
X-IronPort-AV: E=Sophos;i="5.83,284,1616482800"; 
   d="scan'208";a="203554040"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2021 08:58:01 -0700
IronPort-SDR: k90dfGltNRQGwwuUwxvAeUgBsz0RUr47TB2Y8eWYeLj3zh5krZ/3EHzGfomMs5goNrqx3RxD1C
 weEcqrB+DSEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,284,1616482800"; 
   d="scan'208";a="640743380"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.162])
  by fmsmga005.fm.intel.com with ESMTP; 18 Jun 2021 08:57:58 -0700
Date:   Fri, 18 Jun 2021 23:52:50 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Russ Weight <russell.h.weight@intel.com>
Cc:     mdf@kernel.org, linux-fpga@vger.kernel.org, trix@redhat.com,
        lgoncalv@redhat.com, hao.wu@intel.com, matthew.gerlach@intel.com,
        richard.gong@intel.com
Subject: Re: [PATCH v5 2/3] fpga: bridge: Use standard dev_release for class
 driver
Message-ID: <20210618155250.GB5626@yilunxu-OptiPlex-7050>
References: <20210616225740.399486-1-russell.h.weight@intel.com>
 <20210616225740.399486-3-russell.h.weight@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210616225740.399486-3-russell.h.weight@intel.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Wed, Jun 16, 2021 at 03:57:39PM -0700, Russ Weight wrote:
> The FPGA bridge class driver data structure is being treated as a
> managed resource instead of using standard dev_release call-back
> to release the class data structure. This change removes the
> managed resource code and combines the create() and register()
> functions into a single register() function.
> 
> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> ---
> v5:
>   - Rebased on top of recently accepted patches.
> v4:
>   - Restore the previous format for the Return value in the comment header
>     for fpga_bridge_register()
> v3:
>   - Cleaned up comment header for fpga_bridge_register()
>   - Fix error return values for fpga_bridge_register()
> v2:
>   - No changes
> ---
>  drivers/fpga/altera-fpga2sdram.c    |  12 +--
>  drivers/fpga/altera-freeze-bridge.c |  10 +--
>  drivers/fpga/altera-hps2fpga.c      |  12 +--
>  drivers/fpga/dfl-fme-br.c           |  10 +--
>  drivers/fpga/fpga-bridge.c          | 116 ++++++----------------------
>  drivers/fpga/xilinx-pr-decoupler.c  |  17 ++--
>  include/linux/fpga/fpga-bridge.h    |  12 +--
>  7 files changed, 49 insertions(+), 140 deletions(-)
> 
> diff --git a/drivers/fpga/altera-fpga2sdram.c b/drivers/fpga/altera-fpga2sdram.c
> index a78e49c63c64..66063507116b 100644
> --- a/drivers/fpga/altera-fpga2sdram.c
> +++ b/drivers/fpga/altera-fpga2sdram.c
> @@ -121,17 +121,13 @@ static int alt_fpga_bridge_probe(struct platform_device *pdev)
>  	/* Get f2s bridge configuration saved in handoff register */
>  	regmap_read(sysmgr, SYSMGR_ISWGRP_HANDOFF3, &priv->mask);
>  
> -	br = devm_fpga_bridge_create(dev, F2S_BRIDGE_NAME,
> -				     &altera_fpga2sdram_br_ops, priv);
> -	if (!br)
> -		return -ENOMEM;
> +	br = fpga_bridge_register(dev, F2S_BRIDGE_NAME,
> +				  &altera_fpga2sdram_br_ops, priv);
> +	if (IS_ERR(br))
> +		return PTR_ERR(mgr);
>  
>  	platform_set_drvdata(pdev, br);
>  
> -	ret = fpga_bridge_register(br);
> -	if (ret)
> -		return ret;
> -
>  	dev_info(dev, "driver initialized with handoff %08x\n", priv->mask);
>  
>  	if (!of_property_read_u32(dev->of_node, "bridge-enable", &enable)) {
> diff --git a/drivers/fpga/altera-freeze-bridge.c b/drivers/fpga/altera-freeze-bridge.c
> index dd58c4aea92e..bfbfa43cd05b 100644
> --- a/drivers/fpga/altera-freeze-bridge.c
> +++ b/drivers/fpga/altera-freeze-bridge.c
> @@ -244,14 +244,14 @@ static int altera_freeze_br_probe(struct platform_device *pdev)
>  
>  	priv->base_addr = base_addr;
>  
> -	br = devm_fpga_bridge_create(dev, FREEZE_BRIDGE_NAME,
> -				     &altera_freeze_br_br_ops, priv);
> -	if (!br)
> -		return -ENOMEM;
> +	br = fpga_bridge_register(dev, FREEZE_BRIDGE_NAME,
> +				  &altera_freeze_br_br_ops, priv);
> +	if (IS_ERR(br))
> +		return PTR_ERR(br);
>  
>  	platform_set_drvdata(pdev, br);
>  
> -	return fpga_bridge_register(br);
> +	return 0;
>  }
>  
>  static int altera_freeze_br_remove(struct platform_device *pdev)
> diff --git a/drivers/fpga/altera-hps2fpga.c b/drivers/fpga/altera-hps2fpga.c
> index 77b95f251821..aa758426c22b 100644
> --- a/drivers/fpga/altera-hps2fpga.c
> +++ b/drivers/fpga/altera-hps2fpga.c
> @@ -180,19 +180,15 @@ static int alt_fpga_bridge_probe(struct platform_device *pdev)
>  		}
>  	}
>  
> -	br = devm_fpga_bridge_create(dev, priv->name,
> -				     &altera_hps2fpga_br_ops, priv);
> -	if (!br) {
> -		ret = -ENOMEM;
> +	br = fpga_bridge_register(dev, priv->name,
> +				  &altera_hps2fpga_br_ops, priv);
> +	if (IS_ERR(br)) {
> +		ret = PTR_ERR(br);
>  		goto err;
>  	}
>  
>  	platform_set_drvdata(pdev, br);
>  
> -	ret = fpga_bridge_register(br);
> -	if (ret)
> -		goto err;
> -
>  	return 0;
>  
>  err:
> diff --git a/drivers/fpga/dfl-fme-br.c b/drivers/fpga/dfl-fme-br.c
> index 3ff9f3a687ce..808d1f4d76df 100644
> --- a/drivers/fpga/dfl-fme-br.c
> +++ b/drivers/fpga/dfl-fme-br.c
> @@ -68,14 +68,14 @@ static int fme_br_probe(struct platform_device *pdev)
>  
>  	priv->pdata = dev_get_platdata(dev);
>  
> -	br = devm_fpga_bridge_create(dev, "DFL FPGA FME Bridge",
> -				     &fme_bridge_ops, priv);
> -	if (!br)
> -		return -ENOMEM;
> +	br = fpga_bridge_register(dev, "DFL FPGA FME Bridge",
> +				  &fme_bridge_ops, priv);
> +	if (IS_ERR(br))
> +		return PTR_ERR(br);
>  
>  	platform_set_drvdata(pdev, br);
>  
> -	return fpga_bridge_register(br);
> +	return 0;
>  }
>  
>  static int fme_br_remove(struct platform_device *pdev)
> diff --git a/drivers/fpga/fpga-bridge.c b/drivers/fpga/fpga-bridge.c
> index 798f55670646..15be378b64ab 100644
> --- a/drivers/fpga/fpga-bridge.c
> +++ b/drivers/fpga/fpga-bridge.c
> @@ -312,36 +312,35 @@ static struct attribute *fpga_bridge_attrs[] = {
>  ATTRIBUTE_GROUPS(fpga_bridge);
>  
>  /**
> - * fpga_bridge_create - create and initialize a struct fpga_bridge
> + * fpga_bridge_register - create and register a FPGA Bridge device
>   * @parent:	FPGA bridge device from pdev
>   * @name:	FPGA bridge name
>   * @br_ops:	pointer to structure of fpga bridge ops
>   * @priv:	FPGA bridge private data
>   *
> - * The caller of this function is responsible for freeing the bridge with
> - * fpga_bridge_free().  Using devm_fpga_bridge_create() instead is recommended.
> - *
> - * Return: struct fpga_bridge or NULL
> + * Return: struct fpga_bridge pointer or ERR_PTR()
>   */
> -struct fpga_bridge *fpga_bridge_create(struct device *parent, const char *name,
> -				       const struct fpga_bridge_ops *br_ops,
> -				       void *priv)
> +struct fpga_bridge *fpga_bridge_register(struct device *parent, const char *name,
> +					 const struct fpga_bridge_ops *br_ops,
> +					 void *priv)

Is it better we use the same style as fpga_mgr_register?

Thanks,
Yilun

>  {
>  	struct fpga_bridge *bridge;
>  	int id, ret;
>  
>  	if (!name || !strlen(name)) {
>  		dev_err(parent, "Attempt to register with no name!\n");
> -		return NULL;
> +		return ERR_PTR(-EINVAL);
>  	}
>  
>  	bridge = kzalloc(sizeof(*bridge), GFP_KERNEL);
>  	if (!bridge)
> -		return NULL;
> +		return ERR_PTR(-ENOMEM);
>  
>  	id = ida_simple_get(&fpga_bridge_ida, 0, 0, GFP_KERNEL);
> -	if (id < 0)
> +	if (id < 0) {
> +		ret = id;
>  		goto error_kfree;
> +	}
>  
>  	mutex_init(&bridge->mutex);
>  	INIT_LIST_HEAD(&bridge->node);
> @@ -350,17 +349,23 @@ struct fpga_bridge *fpga_bridge_create(struct device *parent, const char *name,
>  	bridge->br_ops = br_ops;
>  	bridge->priv = priv;
>  
> -	device_initialize(&bridge->dev);
>  	bridge->dev.groups = br_ops->groups;
>  	bridge->dev.class = fpga_bridge_class;
>  	bridge->dev.parent = parent;
>  	bridge->dev.of_node = parent->of_node;
>  	bridge->dev.id = id;
> +	of_platform_populate(bridge->dev.of_node, NULL, NULL, &bridge->dev);
>  
>  	ret = dev_set_name(&bridge->dev, "br%d", id);
>  	if (ret)
>  		goto error_device;
>  
> +	ret = device_register(&bridge->dev);
> +	if (ret) {
> +		put_device(&bridge->dev);
> +		return ERR_PTR(ret);
> +	}
> +
>  	return bridge;
>  
>  error_device:
> @@ -368,88 +373,7 @@ struct fpga_bridge *fpga_bridge_create(struct device *parent, const char *name,
>  error_kfree:
>  	kfree(bridge);
>  
> -	return NULL;
> -}
> -EXPORT_SYMBOL_GPL(fpga_bridge_create);
> -
> -/**
> - * fpga_bridge_free - free an fpga bridge created by fpga_bridge_create()
> - * @bridge:	FPGA bridge struct
> - */
> -void fpga_bridge_free(struct fpga_bridge *bridge)
> -{
> -	ida_simple_remove(&fpga_bridge_ida, bridge->dev.id);
> -	kfree(bridge);
> -}
> -EXPORT_SYMBOL_GPL(fpga_bridge_free);
> -
> -static void devm_fpga_bridge_release(struct device *dev, void *res)
> -{
> -	struct fpga_bridge *bridge = *(struct fpga_bridge **)res;
> -
> -	fpga_bridge_free(bridge);
> -}
> -
> -/**
> - * devm_fpga_bridge_create - create and init a managed struct fpga_bridge
> - * @parent:	FPGA bridge device from pdev
> - * @name:	FPGA bridge name
> - * @br_ops:	pointer to structure of fpga bridge ops
> - * @priv:	FPGA bridge private data
> - *
> - * This function is intended for use in an FPGA bridge driver's probe function.
> - * After the bridge driver creates the struct with devm_fpga_bridge_create(), it
> - * should register the bridge with fpga_bridge_register().  The bridge driver's
> - * remove function should call fpga_bridge_unregister().  The bridge struct
> - * allocated with this function will be freed automatically on driver detach.
> - * This includes the case of a probe function returning error before calling
> - * fpga_bridge_register(), the struct will still get cleaned up.
> - *
> - *  Return: struct fpga_bridge or NULL
> - */
> -struct fpga_bridge
> -*devm_fpga_bridge_create(struct device *parent, const char *name,
> -			 const struct fpga_bridge_ops *br_ops, void *priv)
> -{
> -	struct fpga_bridge **ptr, *bridge;
> -
> -	ptr = devres_alloc(devm_fpga_bridge_release, sizeof(*ptr), GFP_KERNEL);
> -	if (!ptr)
> -		return NULL;
> -
> -	bridge = fpga_bridge_create(parent, name, br_ops, priv);
> -	if (!bridge) {
> -		devres_free(ptr);
> -	} else {
> -		*ptr = bridge;
> -		devres_add(parent, ptr);
> -	}
> -
> -	return bridge;
> -}
> -EXPORT_SYMBOL_GPL(devm_fpga_bridge_create);
> -
> -/**
> - * fpga_bridge_register - register an FPGA bridge
> - *
> - * @bridge: FPGA bridge struct
> - *
> - * Return: 0 for success, error code otherwise.
> - */
> -int fpga_bridge_register(struct fpga_bridge *bridge)
> -{
> -	struct device *dev = &bridge->dev;
> -	int ret;
> -
> -	ret = device_add(dev);
> -	if (ret)
> -		return ret;
> -
> -	of_platform_populate(dev->of_node, NULL, NULL, dev);
> -
> -	dev_info(dev->parent, "fpga bridge [%s] registered\n", bridge->name);
> -
> -	return 0;
> +	return ERR_PTR(ret);
>  }
>  EXPORT_SYMBOL_GPL(fpga_bridge_register);
>  
> @@ -475,6 +399,10 @@ EXPORT_SYMBOL_GPL(fpga_bridge_unregister);
>  
>  static void fpga_bridge_dev_release(struct device *dev)
>  {
> +	struct fpga_bridge *bridge = to_fpga_bridge(dev);
> +
> +	ida_simple_remove(&fpga_bridge_ida, bridge->dev.id);
> +	kfree(bridge);
>  }
>  
>  static int __init fpga_bridge_dev_init(void)
> diff --git a/drivers/fpga/xilinx-pr-decoupler.c b/drivers/fpga/xilinx-pr-decoupler.c
> index ea2bde6e5bc4..c004e52b9464 100644
> --- a/drivers/fpga/xilinx-pr-decoupler.c
> +++ b/drivers/fpga/xilinx-pr-decoupler.c
> @@ -138,22 +138,17 @@ static int xlnx_pr_decoupler_probe(struct platform_device *pdev)
>  
>  	clk_disable(priv->clk);
>  
> -	br = devm_fpga_bridge_create(&pdev->dev, priv->ipconfig->name,
> -				     &xlnx_pr_decoupler_br_ops, priv);
> -	if (!br) {
> -		err = -ENOMEM;
> -		goto err_clk;
> -	}
> -
> -	platform_set_drvdata(pdev, br);
> -
> -	err = fpga_bridge_register(br);
> -	if (err) {
> +	br = fpga_bridge_register(&pdev->dev, priv->ipconfig->name,
> +				  &xlnx_pr_decoupler_br_ops, priv);
> +	if (IS_ERR(br)) {
> +		err = PTR_ERR(br);
>  		dev_err(&pdev->dev, "unable to register %s",
>  			priv->ipconfig->name);
>  		goto err_clk;
>  	}
>  
> +	platform_set_drvdata(pdev, br);
> +
>  	return 0;
>  
>  err_clk:
> diff --git a/include/linux/fpga/fpga-bridge.h b/include/linux/fpga/fpga-bridge.h
> index 6c3c28806ff1..2f0eb62c49f5 100644
> --- a/include/linux/fpga/fpga-bridge.h
> +++ b/include/linux/fpga/fpga-bridge.h
> @@ -62,15 +62,9 @@ int of_fpga_bridge_get_to_list(struct device_node *np,
>  			       struct fpga_image_info *info,
>  			       struct list_head *bridge_list);
>  
> -struct fpga_bridge *fpga_bridge_create(struct device *dev, const char *name,
> -				       const struct fpga_bridge_ops *br_ops,
> -				       void *priv);
> -void fpga_bridge_free(struct fpga_bridge *br);
> -int fpga_bridge_register(struct fpga_bridge *br);
> +struct fpga_bridge *fpga_bridge_register(struct device *dev, const char *name,
> +					 const struct fpga_bridge_ops *br_ops,
> +					 void *priv);
>  void fpga_bridge_unregister(struct fpga_bridge *br);
>  
> -struct fpga_bridge
> -*devm_fpga_bridge_create(struct device *dev, const char *name,
> -			 const struct fpga_bridge_ops *br_ops, void *priv);
> -
>  #endif /* _LINUX_FPGA_BRIDGE_H */
> -- 
> 2.25.1
