Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4716A536D9F
	for <lists+linux-fpga@lfdr.de>; Sat, 28 May 2022 17:53:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233274AbiE1Pvm (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sat, 28 May 2022 11:51:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238043AbiE1Pvm (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sat, 28 May 2022 11:51:42 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 472F3F6A;
        Sat, 28 May 2022 08:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653753101; x=1685289101;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CFrbHpnVeSUfFa9hJ0kyjcpJ28gU4L6TqI/eG/r0hJA=;
  b=dzM+wr1ThCWZtYmmVslzboWTvpDpZQprAz4VGSwl5N50fwQd7hmpV3gR
   NcZ5CYFu23xY+Yyx3+CnHgAEaCvrxX8tJiLSEUfq71g0NbIZ8SybeDQKL
   l3DXcLn9h9jTFHf90mNy9IzRtOOFZDBDYDnlPsoBWqIwfPV0yClYnGMA4
   3GodGzLwAPHLMU93xYhEh0LEfC0p1b9+R+JfThjMy1L3jt9RrEE7Vk59G
   uChjsL5hhayFSt6keShktRBQLQHW3uSD3EmAkQYlWCtk+Meb2Uh48y/JA
   TCEgyVJ1i6PaJTswC5JY8t59VB35IdgPE8YBGpw/0xJIU6keNUQhcsFLz
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10361"; a="272257542"
X-IronPort-AV: E=Sophos;i="5.91,258,1647327600"; 
   d="scan'208";a="272257542"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2022 08:51:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,258,1647327600"; 
   d="scan'208";a="604441656"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.135])
  by orsmga008.jf.intel.com with ESMTP; 28 May 2022 08:51:38 -0700
Date:   Sat, 28 May 2022 23:43:55 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     keliu <liuke94@huawei.com>
Cc:     hao.wu@intel.com, trix@redhat.com, mdf@kernel.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fpga: Directly use ida_alloc()/free()
Message-ID: <20220528154355.GA183426@yilunxu-OptiPlex-7050>
References: <20220527085915.2798928-1-liuke94@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220527085915.2798928-1-liuke94@huawei.com>
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Fri, May 27, 2022 at 08:59:15AM +0000, keliu wrote:
> Use ida_alloc()/ida_free() instead of deprecated
> ida_simple_get()/ida_simple_remove() .
> 
> Signed-off-by: keliu <liuke94@huawei.com>

Acked-by: Xu Yilun <yilun.xu@intel.com>

> ---
>  drivers/fpga/dfl.c         | 4 ++--
>  drivers/fpga/fpga-bridge.c | 6 +++---
>  drivers/fpga/fpga-mgr.c    | 6 +++---
>  drivers/fpga/fpga-region.c | 6 +++---
>  4 files changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
> index 599bb21d86af..2dff0c626cc6 100644
> --- a/drivers/fpga/dfl.c
> +++ b/drivers/fpga/dfl.c
> @@ -342,7 +342,7 @@ static void release_dfl_dev(struct device *dev)
>  	if (ddev->mmio_res.parent)
>  		release_resource(&ddev->mmio_res);
>  
> -	ida_simple_remove(&dfl_device_ida, ddev->id);
> +	ida_free(&dfl_device_ida, ddev->id);
>  	kfree(ddev->irqs);
>  	kfree(ddev);
>  }
> @@ -360,7 +360,7 @@ dfl_dev_add(struct dfl_feature_platform_data *pdata,
>  	if (!ddev)
>  		return ERR_PTR(-ENOMEM);
>  
> -	id = ida_simple_get(&dfl_device_ida, 0, 0, GFP_KERNEL);
> +	id = ida_alloc(&dfl_device_ida, GFP_KERNEL);
>  	if (id < 0) {
>  		dev_err(&pdev->dev, "unable to get id\n");
>  		kfree(ddev);
> diff --git a/drivers/fpga/fpga-bridge.c b/drivers/fpga/fpga-bridge.c
> index 16f2b164a178..727704431f61 100644
> --- a/drivers/fpga/fpga-bridge.c
> +++ b/drivers/fpga/fpga-bridge.c
> @@ -342,7 +342,7 @@ fpga_bridge_register(struct device *parent, const char *name,
>  	if (!bridge)
>  		return ERR_PTR(-ENOMEM);
>  
> -	id = ida_simple_get(&fpga_bridge_ida, 0, 0, GFP_KERNEL);
> +	id = ida_alloc(&fpga_bridge_ida, GFP_KERNEL);
>  	if (id < 0) {
>  		ret = id;
>  		goto error_kfree;
> @@ -375,7 +375,7 @@ fpga_bridge_register(struct device *parent, const char *name,
>  	return bridge;
>  
>  error_device:
> -	ida_simple_remove(&fpga_bridge_ida, id);
> +	ida_free(&fpga_bridge_ida, id);
>  error_kfree:
>  	kfree(bridge);
>  
> @@ -407,7 +407,7 @@ static void fpga_bridge_dev_release(struct device *dev)
>  {
>  	struct fpga_bridge *bridge = to_fpga_bridge(dev);
>  
> -	ida_simple_remove(&fpga_bridge_ida, bridge->dev.id);
> +	ida_free(&fpga_bridge_ida, bridge->dev.id);
>  	kfree(bridge);
>  }
>  
> diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
> index d49a9ce34568..2955a21beebe 100644
> --- a/drivers/fpga/fpga-mgr.c
> +++ b/drivers/fpga/fpga-mgr.c
> @@ -622,7 +622,7 @@ fpga_mgr_register_full(struct device *parent, const struct fpga_manager_info *in
>  	if (!mgr)
>  		return ERR_PTR(-ENOMEM);
>  
> -	id = ida_simple_get(&fpga_mgr_ida, 0, 0, GFP_KERNEL);
> +	id = ida_alloc(&fpga_mgr_ida, GFP_KERNEL);
>  	if (id < 0) {
>  		ret = id;
>  		goto error_kfree;
> @@ -661,7 +661,7 @@ fpga_mgr_register_full(struct device *parent, const struct fpga_manager_info *in
>  	return mgr;
>  
>  error_device:
> -	ida_simple_remove(&fpga_mgr_ida, id);
> +	ida_free(&fpga_mgr_ida, id);
>  error_kfree:
>  	kfree(mgr);
>  
> @@ -785,7 +785,7 @@ static void fpga_mgr_dev_release(struct device *dev)
>  {
>  	struct fpga_manager *mgr = to_fpga_manager(dev);
>  
> -	ida_simple_remove(&fpga_mgr_ida, mgr->dev.id);
> +	ida_free(&fpga_mgr_ida, mgr->dev.id);
>  	kfree(mgr);
>  }
>  
> diff --git a/drivers/fpga/fpga-region.c b/drivers/fpga/fpga-region.c
> index b0ac18de4885..18bcaa1926dd 100644
> --- a/drivers/fpga/fpga-region.c
> +++ b/drivers/fpga/fpga-region.c
> @@ -202,7 +202,7 @@ fpga_region_register_full(struct device *parent, const struct fpga_region_info *
>  	if (!region)
>  		return ERR_PTR(-ENOMEM);
>  
> -	id = ida_simple_get(&fpga_region_ida, 0, 0, GFP_KERNEL);
> +	id = ida_alloc(&fpga_region_ida, GFP_KERNEL);
>  	if (id < 0) {
>  		ret = id;
>  		goto err_free;
> @@ -234,7 +234,7 @@ fpga_region_register_full(struct device *parent, const struct fpga_region_info *
>  	return region;
>  
>  err_remove:
> -	ida_simple_remove(&fpga_region_ida, id);
> +	ida_free(&fpga_region_ida, id);
>  err_free:
>  	kfree(region);
>  
> @@ -283,7 +283,7 @@ static void fpga_region_dev_release(struct device *dev)
>  {
>  	struct fpga_region *region = to_fpga_region(dev);
>  
> -	ida_simple_remove(&fpga_region_ida, region->dev.id);
> +	ida_free(&fpga_region_ida, region->dev.id);
>  	kfree(region);
>  }
>  
> -- 
> 2.25.1
