Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F13735A85C
	for <lists+linux-fpga@lfdr.de>; Fri,  9 Apr 2021 23:30:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234470AbhDIVbB (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 9 Apr 2021 17:31:01 -0400
Received: from mail-pg1-f174.google.com ([209.85.215.174]:43936 "EHLO
        mail-pg1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233687AbhDIVbB (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 9 Apr 2021 17:31:01 -0400
Received: by mail-pg1-f174.google.com with SMTP id p12so4863054pgj.10;
        Fri, 09 Apr 2021 14:30:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2XXqOMB7no84r14nU406OpNWXXLiSmIGXiQhHcyMAkk=;
        b=iCSC3AERc/mTBUDNMTnczOVjgXldZvSPc/6dzLL3wibnvmZv/YHqI1fIM+yND9yan2
         HyYyHHaRDAgSxzEERFdgGJiA3rzK7oCRVQ8P9/t/Bj+/EVsBTPqFi5npuxAvYYvR0q5z
         00LEhy3/ZS+yW2ONGTpSwQxwAryXYlea/x3zS5+bdprjB5Hgc5tLT9AzZYB/Vti8vKsX
         a2EktsrZfoOTc3vFqP4Npfxbt9Ff7boFLao9PQKnEgnWoVsfWMo5JGbo03mW69JuB71b
         oSsfVGVMO/PD+wajHjfdK53wBGDLuidyriUTNi6mtMoAqG6r7Vo2Aum7vZqTcCgVjDfQ
         NnRA==
X-Gm-Message-State: AOAM532OCZaer2KZ/+UvBNJSMbhb0mRt/iinVslOIy4+KitZ3lN+2vPU
        gZFnglcn2zCO9uPo+vWvOOz6KoPqFIg=
X-Google-Smtp-Source: ABdhPJwBrLtol0mRutEPMQs4Fpt4m0HV/+0/6ayK48mHIdHR3+k7+LHV2Q2U+8ZRkZWw0s/l8S0vHg==
X-Received: by 2002:a63:c145:: with SMTP id p5mr14851986pgi.451.1618003847503;
        Fri, 09 Apr 2021 14:30:47 -0700 (PDT)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id k10sm2995741pfk.205.2021.04.09.14.30.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 14:30:46 -0700 (PDT)
Date:   Fri, 9 Apr 2021 14:30:45 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     Nava kishore Manne <nava.manne@xilinx.com>
Cc:     mdf@kernel.org, trix@redhat.com, robh+dt@kernel.org,
        michal.simek@xilinx.com, linux-fpga@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, git@xilinx.com
Subject: Re: [PATCH 3/3] fpga: region: Adds runtime PM support
Message-ID: <YHDHhf1tQo6vI49W@epycbox.lan>
References: <20210402092049.479-1-nava.manne@xilinx.com>
 <20210402092049.479-4-nava.manne@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210402092049.479-4-nava.manne@xilinx.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Fri, Apr 02, 2021 at 02:50:49PM +0530, Nava kishore Manne wrote:
> Adds support to handle FPGA/PL power domain. With this patch,
> the PL power domain will be turned on before loading the bitstream
> and turned off while removing/unloading the bitstream using overlays.
> This can be achieved by adding the runtime PM support.
> 
> Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
> ---
>  drivers/fpga/of-fpga-region.c | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/fpga/of-fpga-region.c b/drivers/fpga/of-fpga-region.c
> index e405309baadc..35fc2f3d4bd8 100644
> --- a/drivers/fpga/of-fpga-region.c
> +++ b/drivers/fpga/of-fpga-region.c
> @@ -15,6 +15,7 @@
>  #include <linux/of_platform.h>
>  #include <linux/slab.h>
>  #include <linux/spinlock.h>
> +#include <linux/pm_runtime.h>
>  
>  static const struct of_device_id fpga_region_of_match[] = {
>  	{ .compatible = "fpga-region", },
> @@ -302,6 +303,7 @@ static int of_fpga_region_notify_pre_apply(struct fpga_region *region,
>  	}
>  
>  	region->info = info;
> +	pm_runtime_get_sync(dev->parent);
>  	ret = fpga_region_program_fpga(region);
>  	if (ret) {
>  		/* error; reject overlay */
> @@ -324,10 +326,13 @@ static int of_fpga_region_notify_pre_apply(struct fpga_region *region,
>  static void of_fpga_region_notify_post_remove(struct fpga_region *region,
>  					      struct of_overlay_notify_data *nd)
>  {
> +	struct device *dev = &region->dev;
> +
>  	fpga_bridges_disable(&region->bridge_list);
>  	fpga_bridges_put(&region->bridge_list);
>  	fpga_image_info_free(region->info);
>  	region->info = NULL;
> +	pm_runtime_put(dev->parent);
>  }
>  
>  /**
> @@ -411,9 +416,16 @@ static int of_fpga_region_probe(struct platform_device *pdev)
>  		goto eprobe_mgr_put;
>  	}
>  
> +	pm_runtime_enable(&pdev->dev);
> +	ret = pm_runtime_get_sync(&pdev->dev);
> +	if (ret < 0)
> +		goto err_pm;
> +
> +	pm_runtime_put(&pdev->dev);
> +
>  	ret = fpga_region_register(region);
>  	if (ret)
> -		goto eprobe_mgr_put;
> +		goto err_pm;
>  
>  	of_platform_populate(np, fpga_region_of_match, NULL, &region->dev);
>  	platform_set_drvdata(pdev, region);
> @@ -422,6 +434,9 @@ static int of_fpga_region_probe(struct platform_device *pdev)
>  
>  	return 0;
>  
> +err_pm:
> +	pm_runtime_put(&pdev->dev);
> +	pm_runtime_disable(&pdev->dev);
>  eprobe_mgr_put:
>  	fpga_mgr_put(mgr);
>  	return ret;
> @@ -434,6 +449,7 @@ static int of_fpga_region_remove(struct platform_device *pdev)
>  
>  	fpga_region_unregister(region);
>  	fpga_mgr_put(mgr);
> +	pm_runtime_disable(region->dev.parent);
>  
>  	return 0;
>  }
> -- 
> 2.18.0
> 

Does this add a dependency on CONFIG_PM?

Thanks,
Moritz
