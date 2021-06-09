Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62BF63A19DD
	for <lists+linux-fpga@lfdr.de>; Wed,  9 Jun 2021 17:35:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237429AbhFIPgx (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 9 Jun 2021 11:36:53 -0400
Received: from mga05.intel.com ([192.55.52.43]:15463 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233134AbhFIPgr (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 9 Jun 2021 11:36:47 -0400
IronPort-SDR: cNmq8eSCoFwhHqKffEc+dGAmkXDMtXlpJ9Davyg6VcBG6VMBWpY9TRJbTcEXHcDS+Gx42fvtEr
 TMlfKlJ+s7Ww==
X-IronPort-AV: E=McAfee;i="6200,9189,10010"; a="290725990"
X-IronPort-AV: E=Sophos;i="5.83,261,1616482800"; 
   d="scan'208";a="290725990"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2021 08:34:24 -0700
IronPort-SDR: xohmmcSvgGDugSbN7DN6T1GIvaR38gl/O+V7h2IArkaiE7JTyktY9XBhfgfiyZW9Fuvlfn404J
 X11URT12ty5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,261,1616482800"; 
   d="scan'208";a="485767095"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.162])
  by fmsmga002.fm.intel.com with ESMTP; 09 Jun 2021 08:34:22 -0700
Date:   Wed, 9 Jun 2021 23:28:43 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Russ Weight <russell.h.weight@intel.com>
Cc:     mdf@kernel.org, linux-fpga@vger.kernel.org, trix@redhat.com,
        lgoncalv@redhat.com, hao.wu@intel.com, matthew.gerlach@intel.com,
        richard.gong@intel.com
Subject: Re: [PATCH v1 1/5] fpga: mgr: Use standard dev_release for class
 driver
Message-ID: <20210609152843.GA1994229@yilunxu-OptiPlex-7050>
References: <20210609004925.238044-1-russell.h.weight@intel.com>
 <20210609004925.238044-2-russell.h.weight@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210609004925.238044-2-russell.h.weight@intel.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Tue, Jun 08, 2021 at 05:49:21PM -0700, Russ Weight wrote:
> The FPGA manager class driver data structure is being treated as a
> managed resource instead of using the class.dev_release call-back
> function to release the class data structure. This change populates
> the class.dev_release function, changes the fpga_mgr_free() function
> to call put_device() and changes the fpga_mgr_unregister() function
> to call device_del() instead of device_unregister().
> 
> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> ---
>  drivers/fpga/fpga-mgr.c | 57 +++++++++++++++++++----------------------
>  1 file changed, 26 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
> index b85bc47c91a9..1a4031c0771e 100644
> --- a/drivers/fpga/fpga-mgr.c
> +++ b/drivers/fpga/fpga-mgr.c
> @@ -551,7 +551,7 @@ EXPORT_SYMBOL_GPL(fpga_mgr_unlock);
>  
>  /**
>   * fpga_mgr_create - create and initialize a FPGA manager struct
> - * @dev:	fpga manager device from pdev
> + * @parent:	fpga manager device from pdev

Could you split the renaming change to a separate patch? 

>   * @name:	fpga manager name
>   * @mops:	pointer to structure of fpga manager ops
>   * @priv:	fpga manager private data
> @@ -561,7 +561,7 @@ EXPORT_SYMBOL_GPL(fpga_mgr_unlock);
>   *
>   * Return: pointer to struct fpga_manager or NULL
>   */
> -struct fpga_manager *fpga_mgr_create(struct device *dev, const char *name,
> +struct fpga_manager *fpga_mgr_create(struct device *parent, const char *name,
>  				     const struct fpga_manager_ops *mops,
>  				     void *priv)
>  {
> @@ -571,12 +571,12 @@ struct fpga_manager *fpga_mgr_create(struct device *dev, const char *name,
>  	if (!mops || !mops->write_complete || !mops->state ||
>  	    !mops->write_init || (!mops->write && !mops->write_sg) ||
>  	    (mops->write && mops->write_sg)) {
> -		dev_err(dev, "Attempt to register without fpga_manager_ops\n");
> +		dev_err(parent, "Attempt to register without fpga_manager_ops\n");
>  		return NULL;
>  	}
>  
>  	if (!name || !strlen(name)) {
> -		dev_err(dev, "Attempt to register with no name!\n");
> +		dev_err(parent, "Attempt to register with no name!\n");
>  		return NULL;
>  	}
>  
> @@ -585,8 +585,10 @@ struct fpga_manager *fpga_mgr_create(struct device *dev, const char *name,
>  		return NULL;
>  
>  	id = ida_simple_get(&fpga_mgr_ida, 0, 0, GFP_KERNEL);
> -	if (id < 0)
> -		goto error_kfree;
> +	if (id < 0) {
> +		kfree(mgr);
> +		return NULL;
> +	}
>  
>  	mutex_init(&mgr->ref_mutex);
>  
> @@ -597,22 +599,17 @@ struct fpga_manager *fpga_mgr_create(struct device *dev, const char *name,
>  	device_initialize(&mgr->dev);
>  	mgr->dev.class = fpga_mgr_class;
>  	mgr->dev.groups = mops->groups;
> -	mgr->dev.parent = dev;
> -	mgr->dev.of_node = dev->of_node;
> +	mgr->dev.parent = parent;
> +	mgr->dev.of_node = parent->of_node;
>  	mgr->dev.id = id;
>  
>  	ret = dev_set_name(&mgr->dev, "fpga%d", id);
> -	if (ret)
> -		goto error_device;
> +	if (ret) {
> +		put_device(&mgr->dev);
> +		return NULL;
> +	}
>  
>  	return mgr;
> -
> -error_device:
> -	ida_simple_remove(&fpga_mgr_ida, id);
> -error_kfree:
> -	kfree(mgr);
> -
> -	return NULL;
>  }
>  EXPORT_SYMBOL_GPL(fpga_mgr_create);
>  
> @@ -622,8 +619,7 @@ EXPORT_SYMBOL_GPL(fpga_mgr_create);
>   */
>  void fpga_mgr_free(struct fpga_manager *mgr)
>  {
> -	ida_simple_remove(&fpga_mgr_ida, mgr->dev.id);
> -	kfree(mgr);
> +	put_device(&mgr->dev);
>  }
>  EXPORT_SYMBOL_GPL(fpga_mgr_free);
>  
> @@ -631,12 +627,12 @@ static void devm_fpga_mgr_release(struct device *dev, void *res)
>  {
>  	struct fpga_mgr_devres *dr = res;
>  
> -	fpga_mgr_free(dr->mgr);
> +	put_device(&dr->mgr->dev);

I don't think we have to change this. devm_fpga_mgr_create() saves people from calling
fpga_mgr_free(), so it may be more readable fpga_mgr_free() is called
here.

Thanks,
Yilun

>  }
>  
>  /**
>   * devm_fpga_mgr_create - create and initialize a managed FPGA manager struct
> - * @dev:	fpga manager device from pdev
> + * @parent:	fpga manager device from pdev
>   * @name:	fpga manager name
>   * @mops:	pointer to structure of fpga manager ops
>   * @priv:	fpga manager private data
> @@ -651,7 +647,7 @@ static void devm_fpga_mgr_release(struct device *dev, void *res)
>   *
>   * Return: pointer to struct fpga_manager or NULL
>   */
> -struct fpga_manager *devm_fpga_mgr_create(struct device *dev, const char *name,
> +struct fpga_manager *devm_fpga_mgr_create(struct device *parent, const char *name,
>  					  const struct fpga_manager_ops *mops,
>  					  void *priv)
>  {
> @@ -661,13 +657,13 @@ struct fpga_manager *devm_fpga_mgr_create(struct device *dev, const char *name,
>  	if (!dr)
>  		return NULL;
>  
> -	dr->mgr = fpga_mgr_create(dev, name, mops, priv);
> +	dr->mgr = fpga_mgr_create(parent, name, mops, priv);
>  	if (!dr->mgr) {
>  		devres_free(dr);
>  		return NULL;
>  	}
>  
> -	devres_add(dev, dr);
> +	devres_add(parent, dr);
>  
>  	return dr->mgr;
>  }
> @@ -692,16 +688,11 @@ int fpga_mgr_register(struct fpga_manager *mgr)
>  
>  	ret = device_add(&mgr->dev);
>  	if (ret)
> -		goto error_device;
> +		return ret;
>  
>  	dev_info(&mgr->dev, "%s registered\n", mgr->name);
>  
>  	return 0;
> -
> -error_device:
> -	ida_simple_remove(&fpga_mgr_ida, mgr->dev.id);
> -
> -	return ret;
>  }
>  EXPORT_SYMBOL_GPL(fpga_mgr_register);
>  
> @@ -722,7 +713,7 @@ void fpga_mgr_unregister(struct fpga_manager *mgr)
>  	if (mgr->mops->fpga_remove)
>  		mgr->mops->fpga_remove(mgr);
>  
> -	device_unregister(&mgr->dev);
> +	device_del(&mgr->dev);
>  }
>  EXPORT_SYMBOL_GPL(fpga_mgr_unregister);
>  
> @@ -781,6 +772,10 @@ EXPORT_SYMBOL_GPL(devm_fpga_mgr_register);
>  
>  static void fpga_mgr_dev_release(struct device *dev)
>  {
> +	struct fpga_manager *mgr = to_fpga_manager(dev);
> +
> +	ida_simple_remove(&fpga_mgr_ida, mgr->dev.id);
> +	kfree(mgr);
>  }
>  
>  static int __init fpga_mgr_class_init(void)
> -- 
> 2.25.1
