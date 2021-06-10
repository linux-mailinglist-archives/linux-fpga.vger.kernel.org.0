Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDE7C3A263D
	for <lists+linux-fpga@lfdr.de>; Thu, 10 Jun 2021 10:08:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbhFJIKW (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 10 Jun 2021 04:10:22 -0400
Received: from mga01.intel.com ([192.55.52.88]:13604 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229770AbhFJIKV (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 10 Jun 2021 04:10:21 -0400
IronPort-SDR: xr3nOwn9YpsN7k8M7bbbF729w5Vpit54oKMB8+h1CcRD8eTL9Mc6lMRAMnynPEo/dT0tCIUUAL
 frP6a5+T0B5w==
X-IronPort-AV: E=McAfee;i="6200,9189,10010"; a="226638738"
X-IronPort-AV: E=Sophos;i="5.83,263,1616482800"; 
   d="scan'208";a="226638738"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2021 01:08:17 -0700
IronPort-SDR: grg7mwbvEthZEbvswQT6dq+gSlB8iGV0BIxWrX5DcUGkoLQfFzRhmALZ2DNC86LqFycYT7GOUF
 fMQoMH4Wp/Jw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,263,1616482800"; 
   d="scan'208";a="482739986"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.162])
  by orsmga001.jf.intel.com with ESMTP; 10 Jun 2021 01:08:10 -0700
Date:   Thu, 10 Jun 2021 16:02:30 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Russ Weight <russell.h.weight@intel.com>
Cc:     mdf@kernel.org, linux-fpga@vger.kernel.org, trix@redhat.com,
        lgoncalv@redhat.com, hao.wu@intel.com, matthew.gerlach@intel.com,
        richard.gong@intel.com
Subject: Re: [PATCH v2 3/8] fpga: mgr: Rename dev to parent for parent device
Message-ID: <20210610080230.GB2007225@yilunxu-OptiPlex-7050>
References: <20210609221135.261837-1-russell.h.weight@intel.com>
 <20210609221135.261837-4-russell.h.weight@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210609221135.261837-4-russell.h.weight@intel.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Looks good to me.

Reviewed-by: Xu Yilun <yilun.xu@intel.com>

On Wed, Jun 09, 2021 at 03:11:30PM -0700, Russ Weight wrote:
> Rename variable "dev" to "parent" in cases where it represents the parent
> device.
> 
> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> ---
> v2:
>   - This patch contains the renaming of "dev" to "parent" that was previously
>     part of the patch: "fpga: mgr: Use standard dev_release for class driver"
> ---
>  drivers/fpga/fpga-mgr.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
> index b85bc47c91a9..42ddc0844781 100644
> --- a/drivers/fpga/fpga-mgr.c
> +++ b/drivers/fpga/fpga-mgr.c
> @@ -551,7 +551,7 @@ EXPORT_SYMBOL_GPL(fpga_mgr_unlock);
>  
>  /**
>   * fpga_mgr_create - create and initialize a FPGA manager struct
> - * @dev:	fpga manager device from pdev
> + * @parent:	fpga manager device from pdev
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
> @@ -597,8 +597,8 @@ struct fpga_manager *fpga_mgr_create(struct device *dev, const char *name,
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
> @@ -636,7 +636,7 @@ static void devm_fpga_mgr_release(struct device *dev, void *res)
>  
>  /**
>   * devm_fpga_mgr_create - create and initialize a managed FPGA manager struct
> - * @dev:	fpga manager device from pdev
> + * @parent:	fpga manager device from pdev
>   * @name:	fpga manager name
>   * @mops:	pointer to structure of fpga manager ops
>   * @priv:	fpga manager private data
> @@ -651,7 +651,7 @@ static void devm_fpga_mgr_release(struct device *dev, void *res)
>   *
>   * Return: pointer to struct fpga_manager or NULL
>   */
> -struct fpga_manager *devm_fpga_mgr_create(struct device *dev, const char *name,
> +struct fpga_manager *devm_fpga_mgr_create(struct device *parent, const char *name,
>  					  const struct fpga_manager_ops *mops,
>  					  void *priv)
>  {
> @@ -661,13 +661,13 @@ struct fpga_manager *devm_fpga_mgr_create(struct device *dev, const char *name,
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
> -- 
> 2.25.1
