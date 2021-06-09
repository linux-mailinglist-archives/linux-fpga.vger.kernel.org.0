Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3D5F3A1A8C
	for <lists+linux-fpga@lfdr.de>; Wed,  9 Jun 2021 18:09:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233272AbhFIQKz (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 9 Jun 2021 12:10:55 -0400
Received: from mga09.intel.com ([134.134.136.24]:20666 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229685AbhFIQKz (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 9 Jun 2021 12:10:55 -0400
IronPort-SDR: KxqiOPiFl4y4cMLu1jOs7puS30mZRJMwp4+kugabaD5Lbu+fCHy3aO3Y95s/A/KbvOVLWLTxM0
 rLQYw8L2D5Tg==
X-IronPort-AV: E=McAfee;i="6200,9189,10010"; a="205066186"
X-IronPort-AV: E=Sophos;i="5.83,261,1616482800"; 
   d="scan'208";a="205066186"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2021 09:03:59 -0700
IronPort-SDR: 6zH/YnaD7hpWX/xqdlRc3z7/VQRdlEPYfFq8mP1yh9fRdD75D06/yIKnq0ocrvRCAHkBjJDs2w
 FjIez24A9ejw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,261,1616482800"; 
   d="scan'208";a="485776744"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.162])
  by fmsmga002.fm.intel.com with ESMTP; 09 Jun 2021 09:03:56 -0700
Date:   Wed, 9 Jun 2021 23:58:17 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Russ Weight <russell.h.weight@intel.com>
Cc:     mdf@kernel.org, linux-fpga@vger.kernel.org, trix@redhat.com,
        lgoncalv@redhat.com, hao.wu@intel.com, matthew.gerlach@intel.com,
        richard.gong@intel.com
Subject: Re: [PATCH v1 4/5] fpga: bridge: Use standard dev_release for class
 driver
Message-ID: <20210609155817.GD1994229@yilunxu-OptiPlex-7050>
References: <20210609004925.238044-1-russell.h.weight@intel.com>
 <20210609004925.238044-5-russell.h.weight@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210609004925.238044-5-russell.h.weight@intel.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Tue, Jun 08, 2021 at 05:49:24PM -0700, Russ Weight wrote:
> The FPGA bridge class driver data structure is being treated as a managed
> resource instead of using standard dev_release call-back to release the
> class data structure. This change populates the class.dev_release function
> and changes the fpga_bridge_free() function to call put_device(). It also
> changes fpga_bridge_unregister() to call device_del() instead of
> device_unregister().
> 
> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> ---
>  drivers/fpga/fpga-bridge.c | 48 +++++++++++++++++++-------------------
>  1 file changed, 24 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/fpga/fpga-bridge.c b/drivers/fpga/fpga-bridge.c
> index 05c6d4f2d043..59f40f26035d 100644
> --- a/drivers/fpga/fpga-bridge.c
> +++ b/drivers/fpga/fpga-bridge.c
> @@ -313,7 +313,7 @@ ATTRIBUTE_GROUPS(fpga_bridge);
>  
>  /**
>   * fpga_bridge_create - create and initialize a struct fpga_bridge
> - * @dev:	FPGA bridge device from pdev
> + * @parent:	FPGA bridge device from pdev

The same concern, split the rename changes out.

>   * @name:	FPGA bridge name
>   * @br_ops:	pointer to structure of fpga bridge ops
>   * @priv:	FPGA bridge private data
> @@ -323,7 +323,7 @@ ATTRIBUTE_GROUPS(fpga_bridge);
>   *
>   * Return: struct fpga_bridge or NULL
>   */
> -struct fpga_bridge *fpga_bridge_create(struct device *dev, const char *name,
> +struct fpga_bridge *fpga_bridge_create(struct device *parent, const char *name,
>  				       const struct fpga_bridge_ops *br_ops,
>  				       void *priv)
>  {
> @@ -331,7 +331,7 @@ struct fpga_bridge *fpga_bridge_create(struct device *dev, const char *name,
>  	int id, ret;
>  
>  	if (!name || !strlen(name)) {
> -		dev_err(dev, "Attempt to register with no name!\n");
> +		dev_err(parent, "Attempt to register with no name!\n");
>  		return NULL;
>  	}
>  
> @@ -340,8 +340,10 @@ struct fpga_bridge *fpga_bridge_create(struct device *dev, const char *name,
>  		return NULL;
>  
>  	id = ida_simple_get(&fpga_bridge_ida, 0, 0, GFP_KERNEL);
> -	if (id < 0)
> -		goto error_kfree;
> +	if (id < 0) {
> +		kfree(bridge);
> +		return NULL;
> +	}
>  
>  	mutex_init(&bridge->mutex);
>  	INIT_LIST_HEAD(&bridge->node);
> @@ -353,22 +355,17 @@ struct fpga_bridge *fpga_bridge_create(struct device *dev, const char *name,
>  	device_initialize(&bridge->dev);
>  	bridge->dev.groups = br_ops->groups;
>  	bridge->dev.class = fpga_bridge_class;
> -	bridge->dev.parent = dev;
> -	bridge->dev.of_node = dev->of_node;
> +	bridge->dev.parent = parent;
> +	bridge->dev.of_node = parent->of_node;
>  	bridge->dev.id = id;
>  
>  	ret = dev_set_name(&bridge->dev, "br%d", id);
> -	if (ret)
> -		goto error_device;
> +	if (ret) {
> +		put_device(&bridge->dev);
> +		return NULL;
> +	}
>  
>  	return bridge;
> -
> -error_device:
> -	ida_simple_remove(&fpga_bridge_ida, id);
> -error_kfree:
> -	kfree(bridge);
> -
> -	return NULL;
>  }
>  EXPORT_SYMBOL_GPL(fpga_bridge_create);
>  
> @@ -378,8 +375,7 @@ EXPORT_SYMBOL_GPL(fpga_bridge_create);
>   */
>  void fpga_bridge_free(struct fpga_bridge *bridge)
>  {
> -	ida_simple_remove(&fpga_bridge_ida, bridge->dev.id);
> -	kfree(bridge);
> +	put_device(&bridge->dev);
>  }
>  EXPORT_SYMBOL_GPL(fpga_bridge_free);
>  
> @@ -387,12 +383,12 @@ static void devm_fpga_bridge_release(struct device *dev, void *res)
>  {
>  	struct fpga_bridge *bridge = *(struct fpga_bridge **)res;
>  
> -	fpga_bridge_free(bridge);
> +	put_device(&bridge->dev);

The same concern, I prefer to keep it unchanged.

Thanks,
Yilun

>  }
>  
>  /**
>   * devm_fpga_bridge_create - create and init a managed struct fpga_bridge
> - * @dev:	FPGA bridge device from pdev
> + * @parent:	FPGA bridge device from pdev
>   * @name:	FPGA bridge name
>   * @br_ops:	pointer to structure of fpga bridge ops
>   * @priv:	FPGA bridge private data
> @@ -408,7 +404,7 @@ static void devm_fpga_bridge_release(struct device *dev, void *res)
>   *  Return: struct fpga_bridge or NULL
>   */
>  struct fpga_bridge
> -*devm_fpga_bridge_create(struct device *dev, const char *name,
> +*devm_fpga_bridge_create(struct device *parent, const char *name,
>  			 const struct fpga_bridge_ops *br_ops, void *priv)
>  {
>  	struct fpga_bridge **ptr, *bridge;
> @@ -417,12 +413,12 @@ struct fpga_bridge
>  	if (!ptr)
>  		return NULL;
>  
> -	bridge = fpga_bridge_create(dev, name, br_ops, priv);
> +	bridge = fpga_bridge_create(parent, name, br_ops, priv);
>  	if (!bridge) {
>  		devres_free(ptr);
>  	} else {
>  		*ptr = bridge;
> -		devres_add(dev, ptr);
> +		devres_add(parent, ptr);
>  	}
>  
>  	return bridge;
> @@ -469,12 +465,16 @@ void fpga_bridge_unregister(struct fpga_bridge *bridge)
>  	if (bridge->br_ops && bridge->br_ops->fpga_bridge_remove)
>  		bridge->br_ops->fpga_bridge_remove(bridge);
>  
> -	device_unregister(&bridge->dev);
> +	device_del(&bridge->dev);
>  }
>  EXPORT_SYMBOL_GPL(fpga_bridge_unregister);
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
> -- 
> 2.25.1
