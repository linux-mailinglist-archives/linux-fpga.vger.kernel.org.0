Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDCDE3A2647
	for <lists+linux-fpga@lfdr.de>; Thu, 10 Jun 2021 10:10:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbhFJIMC (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 10 Jun 2021 04:12:02 -0400
Received: from mga07.intel.com ([134.134.136.100]:1405 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229778AbhFJIMB (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 10 Jun 2021 04:12:01 -0400
IronPort-SDR: 9ZfTyPzJKkouJ/NA3KJ5zFXCFrqqZUy0X7KqKv+brdJMfx6Fvnse9YUwwh5K5V72pbP+FLyBuO
 OeJtcsya1HHw==
X-IronPort-AV: E=McAfee;i="6200,9189,10010"; a="269104025"
X-IronPort-AV: E=Sophos;i="5.83,263,1616482800"; 
   d="scan'208";a="269104025"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2021 01:10:00 -0700
IronPort-SDR: opJKC0RTN3oijEaIgd3OlnzMm9F+uUIbE2ZoLCk13funCQ/6ep5J9FZIdN9A0JzkANuf/y+bfq
 LNGN/s4Jtfvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,263,1616482800"; 
   d="scan'208";a="638281147"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.162])
  by fmsmga005.fm.intel.com with ESMTP; 10 Jun 2021 01:09:57 -0700
Date:   Thu, 10 Jun 2021 16:04:18 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Russ Weight <russell.h.weight@intel.com>
Cc:     mdf@kernel.org, linux-fpga@vger.kernel.org, trix@redhat.com,
        lgoncalv@redhat.com, hao.wu@intel.com, matthew.gerlach@intel.com,
        richard.gong@intel.com
Subject: Re: [PATCH v2 4/8] fpga: bridge: Rename dev to parent for parent
 device
Message-ID: <20210610080418.GC2007225@yilunxu-OptiPlex-7050>
References: <20210609221135.261837-1-russell.h.weight@intel.com>
 <20210609221135.261837-5-russell.h.weight@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210609221135.261837-5-russell.h.weight@intel.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Looks good to me.

Reviewed-by: Xu Yilun <yilun.xu@intel.com>

On Wed, Jun 09, 2021 at 03:11:31PM -0700, Russ Weight wrote:
> Rename variable "dev" to "parent" in cases where it represents the parent
> device.
> 
> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> ---
> v2:
>   - This patch contains the renaming of "dev" to "parent" that was previously
>     part of the patch: "fpga: bridge: Use standard dev_release for class driver"
> ---
>  drivers/fpga/fpga-bridge.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/fpga/fpga-bridge.c b/drivers/fpga/fpga-bridge.c
> index 05c6d4f2d043..6c56afc66a6d 100644
> --- a/drivers/fpga/fpga-bridge.c
> +++ b/drivers/fpga/fpga-bridge.c
> @@ -313,7 +313,7 @@ ATTRIBUTE_GROUPS(fpga_bridge);
>  
>  /**
>   * fpga_bridge_create - create and initialize a struct fpga_bridge
> - * @dev:	FPGA bridge device from pdev
> + * @parent:	FPGA bridge device from pdev
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
> @@ -353,8 +353,8 @@ struct fpga_bridge *fpga_bridge_create(struct device *dev, const char *name,
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
> @@ -392,7 +392,7 @@ static void devm_fpga_bridge_release(struct device *dev, void *res)
>  
>  /**
>   * devm_fpga_bridge_create - create and init a managed struct fpga_bridge
> - * @dev:	FPGA bridge device from pdev
> + * @parent:	FPGA bridge device from pdev
>   * @name:	FPGA bridge name
>   * @br_ops:	pointer to structure of fpga bridge ops
>   * @priv:	FPGA bridge private data
> @@ -408,7 +408,7 @@ static void devm_fpga_bridge_release(struct device *dev, void *res)
>   *  Return: struct fpga_bridge or NULL
>   */
>  struct fpga_bridge
> -*devm_fpga_bridge_create(struct device *dev, const char *name,
> +*devm_fpga_bridge_create(struct device *parent, const char *name,
>  			 const struct fpga_bridge_ops *br_ops, void *priv)
>  {
>  	struct fpga_bridge **ptr, *bridge;
> @@ -417,12 +417,12 @@ struct fpga_bridge
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
> -- 
> 2.25.1
