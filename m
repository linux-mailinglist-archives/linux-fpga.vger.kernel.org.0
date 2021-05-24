Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 452A338F420
	for <lists+linux-fpga@lfdr.de>; Mon, 24 May 2021 22:16:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233009AbhEXURx (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 24 May 2021 16:17:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54912 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232929AbhEXURx (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 24 May 2021 16:17:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621887384;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KiJwDRHG0vD5G07VIKC7JzxwmdfbKhwaf2V5PonBaUI=;
        b=aAygSxX59DhABoYo95VOkchv+E0vnp3Zay0cgfBUivOkLBoyofaqjcGsXZ1XDLFDiLuQ61
        jXHKa8Jf5DmKD2Mbd0+SUqY7dZ5lkzjtwQRi4Bcwq6i1OayMmqfIZq5dPQSH1aG1E5KrS3
        FjpHIijiSIyP8aslCyX5jahg7p1nmsE=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-39-lIr6UQI8PIS8sU5Ycv8Xmw-1; Mon, 24 May 2021 16:16:21 -0400
X-MC-Unique: lIr6UQI8PIS8sU5Ycv8Xmw-1
Received: by mail-oo1-f71.google.com with SMTP id g19-20020a4a6b130000b029020ebe83598fso12072300ooc.15
        for <linux-fpga@vger.kernel.org>; Mon, 24 May 2021 13:16:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=KiJwDRHG0vD5G07VIKC7JzxwmdfbKhwaf2V5PonBaUI=;
        b=eeovduhjIAe5VcAhxNOJeOYyHWm6WPcLXrOKT2PdQgRaQXTw1S3M/rwNrzRzFa64/I
         eYuocPIfkQ/dfRdWgG5FxPKzQjxZhefvQjr9sYM8z3c2bb7bFcPkIlUf6xLKoWhCxzhJ
         1Ukib0ZUx/oQiTr1xzDQvfwGQ5XG4qfOJhUrVRnunCM+7UMQaQp0SnEZOVEREAs/YfD0
         kXpsVeNxD/jQ1Uexluxa01xednPw4D/0wSBVXAnZ2aaKQTMmSI+71nxYwi+jyMkrKneV
         d6tcUrB9lxr8MyYe1d0QwVHbkv9lTvp04R9XWJfy9GNcvCLz5D0fUnx0nUuhj2jyfu2+
         EcNw==
X-Gm-Message-State: AOAM5314MJj6o+ohOzmBrxcPX4rXrFVlyU4UCTkDaLfoUPT+fdvC+qoC
        azQbwIgudGLGP/OlFC+MdNOkEB13UZc4EBTmLGAiDPt+t8dW4pp2NGDG839/17qIlCbARyBGouB
        WcQzZOLdLrxxgWEI3eV6dwQ==
X-Received: by 2002:a9d:6457:: with SMTP id m23mr3555099otl.11.1621887379474;
        Mon, 24 May 2021 13:16:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyT0FUS97pXJl4USf8lBpMt5M/VOxeDHQf5ZOTAj5jNViM/BWZDr2v5bLnWNgzZzj2F//2KCQ==
X-Received: by 2002:a9d:6457:: with SMTP id m23mr3555083otl.11.1621887379193;
        Mon, 24 May 2021 13:16:19 -0700 (PDT)
Received: from localhost.localdomain (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id x5sm3188579otg.76.2021.05.24.13.16.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 May 2021 13:16:18 -0700 (PDT)
Subject: Re: [PATCH v3 1/3] fpga: mgr: Use standard dev_release for class
 driver
To:     Russ Weight <russell.h.weight@intel.com>, mdf@kernel.org,
        linux-fpga@vger.kernel.org
Cc:     lgoncalv@redhat.com, yilun.xu@intel.com, hao.wu@intel.com,
        matthew.gerlach@intel.com, richard.gong@intel.com
References: <20210524185049.681683-1-russell.h.weight@intel.com>
 <20210524185049.681683-2-russell.h.weight@intel.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <353d1753-070d-38fc-dfc6-7020aea32c5d@redhat.com>
Date:   Mon, 24 May 2021 13:16:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210524185049.681683-2-russell.h.weight@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Russ,

I think the signature fpga_mgr_register, should change to

int fpga_mgr_register(struct device *, const struct fpga_mager_ops 
*mops, void *priv);

I'll explain below ..

On 5/24/21 11:50 AM, Russ Weight wrote:
> The FPGA manager class driver data structure is being treated as a
> managed resource instead of using standard dev_release call-back
> to release the class data structure. This change removes the
> managed resource code for the freeing of the class data structure
> and combines the create() and register() functions into a single
> register() function.
>
> The devm_fpga_mgr_register() function is retained.
>
> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> ---
> v3:
>    - Cleaned up comment header for fpga_mgr_register()
>    - Fix error return on ida_simple_get() failure
> v2:
>    - Restored devm_fpga_mgr_register() functionality, adapted for the combined
>      create/register functionality.
>    - All previous callers of devm_fpga_mgr_register() will continue to call
>      devm_fpga_mgr_register().
>    - replaced unnecessary ternary operators in return statements with standard
>      if conditions.
> ---
>   drivers/fpga/altera-cvp.c        |  12 +--
>   drivers/fpga/altera-pr-ip-core.c |   8 +-
>   drivers/fpga/altera-ps-spi.c     |  10 +-
>   drivers/fpga/dfl-fme-mgr.c       |  10 +-
>   drivers/fpga/fpga-mgr.c          | 163 ++++++++-----------------------
>   drivers/fpga/ice40-spi.c         |  10 +-
>   drivers/fpga/machxo2-spi.c       |  10 +-
>   drivers/fpga/socfpga-a10.c       |  16 ++-
>   drivers/fpga/socfpga.c           |  10 +-
>   drivers/fpga/stratix10-soc.c     |  15 +--
>   drivers/fpga/ts73xx-fpga.c       |  10 +-
>   drivers/fpga/xilinx-spi.c        |  12 +--
>   drivers/fpga/zynq-fpga.c         |  16 ++-
>   drivers/fpga/zynqmp-fpga.c       |  10 +-
>   include/linux/fpga/fpga-mgr.h    |  17 ++--
>   15 files changed, 112 insertions(+), 217 deletions(-)
>
> diff --git a/drivers/fpga/altera-cvp.c b/drivers/fpga/altera-cvp.c
> index 4e0edb60bfba..b61020ceb0a1 100644
> --- a/drivers/fpga/altera-cvp.c
> +++ b/drivers/fpga/altera-cvp.c
> @@ -652,19 +652,15 @@ static int altera_cvp_probe(struct pci_dev *pdev,
>   	snprintf(conf->mgr_name, sizeof(conf->mgr_name), "%s @%s",
>   		 ALTERA_CVP_MGR_NAME, pci_name(pdev));
>   
> -	mgr = devm_fpga_mgr_create(&pdev->dev, conf->mgr_name,
> -				   &altera_cvp_ops, conf);
> -	if (!mgr) {
> -		ret = -ENOMEM;
> +	mgr = fpga_mgr_register(&pdev->dev, conf->mgr_name,
> +				&altera_cvp_ops, conf);
> +	if (IS_ERR(mgr)) {
> +		ret = PTR_ERR(mgr);
>   		goto err_unmap;
>   	}
>   
>   	pci_set_drvdata(pdev, mgr);

This is a wrapper around

dev_set_drvdata()

>   
> -	ret = fpga_mgr_register(mgr);
> -	if (ret)
> -		goto err_unmap;
> -
>   	return 0;
>   
>   err_unmap:
> diff --git a/drivers/fpga/altera-pr-ip-core.c b/drivers/fpga/altera-pr-ip-core.c
> index 5b130c4d9882..0980e134cc43 100644
> --- a/drivers/fpga/altera-pr-ip-core.c
> +++ b/drivers/fpga/altera-pr-ip-core.c
> @@ -191,11 +191,11 @@ int alt_pr_register(struct device *dev, void __iomem *reg_base)
>   		(val & ALT_PR_CSR_STATUS_MSK) >> ALT_PR_CSR_STATUS_SFT,
>   		(int)(val & ALT_PR_CSR_PR_START));
>   
> -	mgr = devm_fpga_mgr_create(dev, dev_name(dev), &alt_pr_ops, priv);
using the name of the device
> -	if (!mgr)
> -		return -ENOMEM;
> +	mgr = devm_fpga_mgr_register(dev, dev_name(dev), &alt_pr_ops, priv);
> +	if (IS_ERR(mgr))
> +		return PTR_ERR(mgr);
mgr is unused
>   
> -	return devm_fpga_mgr_register(dev, mgr);
> +	return 0;
>   }
>   EXPORT_SYMBOL_GPL(alt_pr_register);
>   
> diff --git a/drivers/fpga/altera-ps-spi.c b/drivers/fpga/altera-ps-spi.c
> index 23bfd4d1ad0f..d3f77b0312b2 100644
> --- a/drivers/fpga/altera-ps-spi.c
> +++ b/drivers/fpga/altera-ps-spi.c
> @@ -302,12 +302,12 @@ static int altera_ps_probe(struct spi_device *spi)
>   	snprintf(conf->mgr_name, sizeof(conf->mgr_name), "%s %s",
>   		 dev_driver_string(&spi->dev), dev_name(&spi->dev));
a combo of devices name, is that really necessary ?
>   
> -	mgr = devm_fpga_mgr_create(&spi->dev, conf->mgr_name,
> -				   &altera_ps_ops, conf);
> -	if (!mgr)
> -		return -ENOMEM;
> +	mgr = devm_fpga_mgr_register(&spi->dev, conf->mgr_name,
> +				     &altera_ps_ops, conf);
> +	if (IS_ERR(mgr))
> +		return PTR_ERR(mgr);
mgr is unused
>   
> -	return devm_fpga_mgr_register(&spi->dev, mgr);
> +	return 0;
>   }
>   
>   static const struct spi_device_id altera_ps_spi_ids[] = {
> diff --git a/drivers/fpga/dfl-fme-mgr.c b/drivers/fpga/dfl-fme-mgr.c
> index d5861d13b306..d71eba817b3b 100644
> --- a/drivers/fpga/dfl-fme-mgr.c
> +++ b/drivers/fpga/dfl-fme-mgr.c
> @@ -308,14 +308,14 @@ static int fme_mgr_probe(struct platform_device *pdev)
>   
>   	fme_mgr_get_compat_id(priv->ioaddr, compat_id);
>   
> -	mgr = devm_fpga_mgr_create(dev, "DFL FME FPGA Manager",
> -				   &fme_mgr_ops, priv);
> -	if (!mgr)
> -		return -ENOMEM;
> +	mgr = devm_fpga_mgr_register(dev, "DFL FME FPGA Manager",
> +				     &fme_mgr_ops, priv);
drv name is 'dfl-fme-mgr', is this close enough ?
> +	if (IS_ERR(mgr))
> +		return PTR_ERR(mgr);
>   
>   	mgr->compat_id = compat_id;
>   
> -	return devm_fpga_mgr_register(dev, mgr);
> +	return 0;
>   }
>   
>   static struct platform_driver fme_mgr_driver = {
> diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
> index b85bc47c91a9..22f0dd5c2834 100644
> --- a/drivers/fpga/fpga-mgr.c
> +++ b/drivers/fpga/fpga-mgr.c
> @@ -550,20 +550,20 @@ void fpga_mgr_unlock(struct fpga_manager *mgr)
>   EXPORT_SYMBOL_GPL(fpga_mgr_unlock);
>   
>   /**
> - * fpga_mgr_create - create and initialize a FPGA manager struct
> + * fpga_mgr_register - create and register a FPGA Manager device
>    * @dev:	fpga manager device from pdev

nit, space or tab after ':' ? this is inconsistent everywhere.


>    * @name:	fpga manager name
>    * @mops:	pointer to structure of fpga manager ops
>    * @priv:	fpga manager private data
>    *
> - * The caller of this function is responsible for freeing the struct with
> - * fpga_mgr_free().  Using devm_fpga_mgr_create() instead is recommended.
> + * The caller of this function is responsible for calling fpga_mgr_unregister().
> + * Using devm_fpga_mgr_register instead is recommended.
>    *
> - * Return: pointer to struct fpga_manager or NULL
> + * Returns a struct fpga_manager pointer on success, or ERR_PTR() on error.
>    */
> -struct fpga_manager *fpga_mgr_create(struct device *dev, const char *name,
> -				     const struct fpga_manager_ops *mops,
> -				     void *priv)
> +struct fpga_manager *
> +fpga_mgr_register(struct device *dev, const char *name,
> +		  const struct fpga_manager_ops *mops, void *priv)
>   {
>   	struct fpga_manager *mgr;
>   	int id, ret;
> @@ -572,21 +572,23 @@ struct fpga_manager *fpga_mgr_create(struct device *dev, const char *name,
>   	    !mops->write_init || (!mops->write && !mops->write_sg) ||
>   	    (mops->write && mops->write_sg)) {
>   		dev_err(dev, "Attempt to register without fpga_manager_ops\n");
> -		return NULL;
> +		return ERR_PTR(-EINVAL);

return -EINVAL;

And similar

The user's error checking is simplified to an int check.

The clunky ERR_PTR()/PTR_ERR() can be removed

>   	}
>   
>   	if (!name || !strlen(name)) {
>   		dev_err(dev, "Attempt to register with no name!\n");
> -		return NULL;
> +		return ERR_PTR(-EINVAL);
>   	}
>   
>   	mgr = kzalloc(sizeof(*mgr), GFP_KERNEL);
>   	if (!mgr)
> -		return NULL;
> +		return ERR_PTR(-ENOMEM);
>   
>   	id = ida_simple_get(&fpga_mgr_ida, 0, 0, GFP_KERNEL);
> -	if (id < 0)
> +	if (id < 0) {
> +		ret = id;
>   		goto error_kfree;
> +	}
>   
>   	mutex_init(&mgr->ref_mutex);
>   
> @@ -594,7 +596,6 @@ struct fpga_manager *fpga_mgr_create(struct device *dev, const char *name,

Just use the device name, do not give the user an option and simplify 
the calling parameters.

mgr->name = dev_name(dev)

>   	mgr->mops = mops;
>   	mgr->priv = priv;
>   
> -	device_initialize(&mgr->dev);
>   	mgr->dev.class = fpga_mgr_class;
>   	mgr->dev.groups = mops->groups;
>   	mgr->dev.parent = dev;
> @@ -605,84 +606,6 @@ struct fpga_manager *fpga_mgr_create(struct device *dev, const char *name,
>   	if (ret)
>   		goto error_device;
>   

The only use of returned mgr seems to be a variant of setting the 
dev->driver_data = mgr

so just make it the default and don't pass back the ptr.

dev_set_drvdata(dev, mgr);

return 0;


Tom


