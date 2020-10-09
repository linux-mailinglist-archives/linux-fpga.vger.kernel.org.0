Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B185289A8D
	for <lists+linux-fpga@lfdr.de>; Fri,  9 Oct 2020 23:25:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388941AbgJIVZZ (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 9 Oct 2020 17:25:25 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46115 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731982AbgJIVZZ (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 9 Oct 2020 17:25:25 -0400
Received: by mail-pf1-f195.google.com with SMTP id y14so7894227pfp.13;
        Fri, 09 Oct 2020 14:25:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VuIDL2vCnAGQNGHUE6fH+BEg+Zmqgz3ue4CRX3IQE8g=;
        b=L3bF/wkCsSK/n/SMuvguPHI9Qfg7bfxnho3NTcbNfgjLnlQ0v8rSxDeGlvoJOzN22u
         UkVWNyaoZsgtNhJQ+2o87bPBX04uB8nlS6kN4CrR5cXZcXU6cpL9Tay+8pY7wW6cPcXl
         Y31ys18GACZMT04ek8qGpG5GTYnZ7s/s+p8uMQMfNTXLE87+68yCPI9juwCsDxXymYA7
         VljCbxYIC4+IQi+M5CkpTvqH6kE743CFaGJpxV4s8Ir0QsTTGCqmydecP638c+VXnrB7
         +trPkZzbmWdrk2XhdNLDDxqttu0yc69DJDHKSAxL+7azGslGOfZKhN3HGGUynngHObG5
         s44A==
X-Gm-Message-State: AOAM533O41wxNj252TnoAx/IE9sXL1CB3PZKzPRlcKke8JD6ncKo7GmW
        rn9FhPv6j5pjfg+oOCKpkis=
X-Google-Smtp-Source: ABdhPJw/TDwtzIN+iaGT3qzzcQu2RGeIY0US8EnqzL9JIgNJdYJ+mL8WoXIqNZ8TSJWAAzd7rlZFoQ==
X-Received: by 2002:a17:90a:cb05:: with SMTP id z5mr6791694pjt.92.1602278724324;
        Fri, 09 Oct 2020 14:25:24 -0700 (PDT)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id cu5sm4270883pjb.49.2020.10.09.14.25.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2020 14:25:23 -0700 (PDT)
Date:   Fri, 9 Oct 2020 14:25:21 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     Moritz Fischer <mdf@kernel.org>
Cc:     linux-fpga@vger.kernel.org, trix@redhat.com, hao.wu@intel.com,
        michal.simek@xilinx.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, russell.h.weight@intel.com,
        matthew.gerlach@intel.com
Subject: Re: [PATCH v2 01/10] fpga: fpga-mgr: Add devm_fpga_mgr_register() API
Message-ID: <20201009212521.GA2531@epycbox.lan>
References: <20201005173735.162408-1-mdf@kernel.org>
 <20201005173735.162408-2-mdf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201005173735.162408-2-mdf@kernel.org>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Mon, Oct 05, 2020 at 10:37:26AM -0700, Moritz Fischer wrote:
> Add a devm_fpga_mgr_register() API that can be used to register a FPGA
> Manager that was created using devm_fpga_mgr_create().
> 
> Introduce a struct fpga_mgr_devres that makes the devres
> allocation a little bit more readable and gets reused for
> devm_fpga_mgr_create() devm_fpga_mgr_register().
> 
> Reviewed-by: Tom Rix <trix@redhat.com>
> Signed-off-by: Moritz Fischer <mdf@kernel.org>
> ---
>  drivers/fpga/fpga-mgr.c       | 81 +++++++++++++++++++++++++++++------
>  include/linux/fpga/fpga-mgr.h |  2 +
>  2 files changed, 71 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
> index f38bab01432e..b85bc47c91a9 100644
> --- a/drivers/fpga/fpga-mgr.c
> +++ b/drivers/fpga/fpga-mgr.c
> @@ -21,6 +21,10 @@
>  static DEFINE_IDA(fpga_mgr_ida);
>  static struct class *fpga_mgr_class;
>  
> +struct fpga_mgr_devres {
> +	struct fpga_manager *mgr;
> +};
> +
>  /**
>   * fpga_image_info_alloc - Allocate a FPGA image info struct
>   * @dev: owning device
> @@ -625,9 +629,9 @@ EXPORT_SYMBOL_GPL(fpga_mgr_free);
>  
>  static void devm_fpga_mgr_release(struct device *dev, void *res)
>  {
> -	struct fpga_manager *mgr = *(struct fpga_manager **)res;
> +	struct fpga_mgr_devres *dr = res;
>  
> -	fpga_mgr_free(mgr);
> +	fpga_mgr_free(dr->mgr);
>  }
>  
>  /**
> @@ -651,21 +655,21 @@ struct fpga_manager *devm_fpga_mgr_create(struct device *dev, const char *name,
>  					  const struct fpga_manager_ops *mops,
>  					  void *priv)
>  {
> -	struct fpga_manager **ptr, *mgr;
> +	struct fpga_mgr_devres *dr;
>  
> -	ptr = devres_alloc(devm_fpga_mgr_release, sizeof(*ptr), GFP_KERNEL);
> -	if (!ptr)
> +	dr = devres_alloc(devm_fpga_mgr_release, sizeof(*dr), GFP_KERNEL);
> +	if (!dr)
>  		return NULL;
>  
> -	mgr = fpga_mgr_create(dev, name, mops, priv);
> -	if (!mgr) {
> -		devres_free(ptr);
> -	} else {
> -		*ptr = mgr;
> -		devres_add(dev, ptr);
> +	dr->mgr = fpga_mgr_create(dev, name, mops, priv);
> +	if (!dr->mgr) {
> +		devres_free(dr);
> +		return NULL;
>  	}
>  
> -	return mgr;
> +	devres_add(dev, dr);
> +
> +	return dr->mgr;
>  }
>  EXPORT_SYMBOL_GPL(devm_fpga_mgr_create);
>  
> @@ -722,6 +726,59 @@ void fpga_mgr_unregister(struct fpga_manager *mgr)
>  }
>  EXPORT_SYMBOL_GPL(fpga_mgr_unregister);
>  
> +static int fpga_mgr_devres_match(struct device *dev, void *res,
> +				 void *match_data)
> +{
> +	struct fpga_mgr_devres *dr = res;
> +
> +	return match_data == dr->mgr;
> +}
> +
> +static void devm_fpga_mgr_unregister(struct device *dev, void *res)
> +{
> +	struct fpga_mgr_devres *dr = res;
> +
> +	fpga_mgr_unregister(dr->mgr);
> +}
> +
> +/**
> + * devm_fpga_mgr_register - resource managed variant of fpga_mgr_register()
> + * @dev: managing device for this FPGA manager
> + * @mgr: fpga manager struct
> + *
> + * This is the devres variant of fpga_mgr_register() for which the unregister
> + * function will be called automatically when the managing device is detached.
> + */
> +int devm_fpga_mgr_register(struct device *dev, struct fpga_manager *mgr)
> +{
> +	struct fpga_mgr_devres *dr;
> +	int ret;
> +
> +	/*
> +	 * Make sure that the struct fpga_manager * that is passed in is
> +	 * managed itself.
> +	 */
> +	if (WARN_ON(!devres_find(dev, devm_fpga_mgr_release,
> +				 fpga_mgr_devres_match, mgr)))
> +		return -EINVAL;
> +
> +	dr = devres_alloc(devm_fpga_mgr_unregister, sizeof(*dr), GFP_KERNEL);
> +	if (!dr)
> +		return -ENOMEM;
> +
> +	ret = fpga_mgr_register(mgr);
> +	if (ret) {
> +		devres_free(dr);
> +		return ret;
> +	}
> +
> +	dr->mgr = mgr;
> +	devres_add(dev, dr);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(devm_fpga_mgr_register);
> +
>  static void fpga_mgr_dev_release(struct device *dev)
>  {
>  }
> diff --git a/include/linux/fpga/fpga-mgr.h b/include/linux/fpga/fpga-mgr.h
> index e8ca62b2cb5b..2bc3030a69e5 100644
> --- a/include/linux/fpga/fpga-mgr.h
> +++ b/include/linux/fpga/fpga-mgr.h
> @@ -198,6 +198,8 @@ void fpga_mgr_free(struct fpga_manager *mgr);
>  int fpga_mgr_register(struct fpga_manager *mgr);
>  void fpga_mgr_unregister(struct fpga_manager *mgr);
>  
> +int devm_fpga_mgr_register(struct device *dev, struct fpga_manager *mgr);
> +
>  struct fpga_manager *devm_fpga_mgr_create(struct device *dev, const char *name,
>  					  const struct fpga_manager_ops *mops,
>  					  void *priv);
> -- 
> 2.28.0
> 
Applied series to for-next,

Thanks
