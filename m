Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29C853A6F3D
	for <lists+linux-fpga@lfdr.de>; Mon, 14 Jun 2021 21:38:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234219AbhFNTkB (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 14 Jun 2021 15:40:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55605 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233865AbhFNTkB (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 14 Jun 2021 15:40:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623699477;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3BJ5O27clnR5cGJrYKlEuYA0fPGRx/F8qnn1d/757kc=;
        b=DBTQPjsVjMb4VJi+3wF9fcDnJFz7QoDZbWRkmqSt3lZBcfNxyr2Jse/kZOClfIzt5xRfGW
        uoYlgct8ttn2D9wYRfz1svZpztJA7YJdDWyn7JB6KIB3SEvXwbNEMPnHZsUxZc7Zkuz600
        gwM68AZHzkrXa2Ibo/pReQ1Y2Kczotg=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-273-gYRJ6I-PMeaWXUFL11iDfw-1; Mon, 14 Jun 2021 15:37:56 -0400
X-MC-Unique: gYRJ6I-PMeaWXUFL11iDfw-1
Received: by mail-oi1-f197.google.com with SMTP id y25-20020a0568080619b02901f8e8a51961so3745580oih.13
        for <linux-fpga@vger.kernel.org>; Mon, 14 Jun 2021 12:37:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=3BJ5O27clnR5cGJrYKlEuYA0fPGRx/F8qnn1d/757kc=;
        b=EkJSaszxsWgv4itlq5Ch1WONoXiSgY3XNdU5UTZsiG90T40b5giH+Tleauu844bdCg
         05WLKPnwXAAjP792a+JliZ1gPij6N1LBTvTP1EfGHgZRx7Ylx9EZHvkKVFFHMvmGv3bq
         r69PdV2c8uXc1BbEK+43udsEIwHeIF/dVojfsziv3Nz2esL2u0EMUW6xiZpzTw5bKmH2
         7d9p4VbeoVoxqyhejSqpsn2dnC0sTfzs0dyBre//m0fnZxY7ROAyxJd/RGgD8Jwl5WqX
         ITA8gGJGvMJg+gtZxVfyrAtl9kAXYd91qtxX3izI81eL7/rY3uybcMNFmBTiI2E4Q8pZ
         0zdQ==
X-Gm-Message-State: AOAM533FfuCA0doQa/xqmIJGKBLGzcoMRd9YV+HIGZhiJvx9hKAfWS7l
        mU04I+FU8aBPYow4OAlWTLmEQBuoA/kHNfzM1lzPxmymsw9jNbCCN5RpEl/SWvej4/YQkkabQht
        P4WAg1hk0ZviLZ1+ZdkB9zA==
X-Received: by 2002:a05:6830:190:: with SMTP id q16mr14408712ota.34.1623699475974;
        Mon, 14 Jun 2021 12:37:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz8p0QFbVXQfC0QNKHYnnRI8FMKAlh+fKs1XFy7aI7TkhFRX5Q9extu0k7MX/H+VtuG6zGBHg==
X-Received: by 2002:a05:6830:190:: with SMTP id q16mr14408698ota.34.1623699475748;
        Mon, 14 Jun 2021 12:37:55 -0700 (PDT)
Received: from localhost.localdomain (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id p65sm3265218oop.0.2021.06.14.12.37.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jun 2021 12:37:55 -0700 (PDT)
Subject: Re: [PATCH 3/8] fpga: mgr: Rename dev to parent for parent device
To:     Moritz Fischer <mdf@kernel.org>, gregkh@linuxfoundation.org
Cc:     linux-fpga@vger.kernel.org,
        Russ Weight <russell.h.weight@intel.com>,
        Xu Yilun <yilun.xu@intel.com>
References: <20210614170909.232415-1-mdf@kernel.org>
 <20210614170909.232415-4-mdf@kernel.org>
From:   Tom Rix <trix@redhat.com>
Message-ID: <e948f1ef-34c1-edef-68d4-ab6f2b03f8a9@redhat.com>
Date:   Mon, 14 Jun 2021 12:37:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210614170909.232415-4-mdf@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 6/14/21 10:09 AM, Moritz Fischer wrote:
> From: Russ Weight <russell.h.weight@intel.com>
>
> Rename variable "dev" to "parent" in cases where it represents the parent
> device.
>
> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> Reviewed-by: Xu Yilun <yilun.xu@intel.com>
> Signed-off-by: Moritz Fischer <mdf@kernel.org>
> ---
>   drivers/fpga/fpga-mgr.c | 20 ++++++++++----------
>   1 file changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
> index b85bc47c91a9..42ddc0844781 100644
> --- a/drivers/fpga/fpga-mgr.c
> +++ b/drivers/fpga/fpga-mgr.c
> @@ -551,7 +551,7 @@ EXPORT_SYMBOL_GPL(fpga_mgr_unlock);
>   
>   /**
>    * fpga_mgr_create - create and initialize a FPGA manager struct
> - * @dev:	fpga manager device from pdev
> + * @parent:	fpga manager device from pdev

This line has a conflict with -next because of my recent 'a FPGA -> an 
FPGA' change in the preceding line

Tom

>    * @name:	fpga manager name
>    * @mops:	pointer to structure of fpga manager ops
>    * @priv:	fpga manager private data
> @@ -561,7 +561,7 @@ EXPORT_SYMBOL_GPL(fpga_mgr_unlock);
>    *
>    * Return: pointer to struct fpga_manager or NULL
>    */
> -struct fpga_manager *fpga_mgr_create(struct device *dev, const char *name,
> +struct fpga_manager *fpga_mgr_create(struct device *parent, const char *name,
>   				     const struct fpga_manager_ops *mops,
>   				     void *priv)
>   {
> @@ -571,12 +571,12 @@ struct fpga_manager *fpga_mgr_create(struct device *dev, const char *name,
>   	if (!mops || !mops->write_complete || !mops->state ||
>   	    !mops->write_init || (!mops->write && !mops->write_sg) ||
>   	    (mops->write && mops->write_sg)) {
> -		dev_err(dev, "Attempt to register without fpga_manager_ops\n");
> +		dev_err(parent, "Attempt to register without fpga_manager_ops\n");
>   		return NULL;
>   	}
>   
>   	if (!name || !strlen(name)) {
> -		dev_err(dev, "Attempt to register with no name!\n");
> +		dev_err(parent, "Attempt to register with no name!\n");
>   		return NULL;
>   	}
>   
> @@ -597,8 +597,8 @@ struct fpga_manager *fpga_mgr_create(struct device *dev, const char *name,
>   	device_initialize(&mgr->dev);
>   	mgr->dev.class = fpga_mgr_class;
>   	mgr->dev.groups = mops->groups;
> -	mgr->dev.parent = dev;
> -	mgr->dev.of_node = dev->of_node;
> +	mgr->dev.parent = parent;
> +	mgr->dev.of_node = parent->of_node;
>   	mgr->dev.id = id;
>   
>   	ret = dev_set_name(&mgr->dev, "fpga%d", id);
> @@ -636,7 +636,7 @@ static void devm_fpga_mgr_release(struct device *dev, void *res)
>   
>   /**
>    * devm_fpga_mgr_create - create and initialize a managed FPGA manager struct
> - * @dev:	fpga manager device from pdev
> + * @parent:	fpga manager device from pdev
>    * @name:	fpga manager name
>    * @mops:	pointer to structure of fpga manager ops
>    * @priv:	fpga manager private data
> @@ -651,7 +651,7 @@ static void devm_fpga_mgr_release(struct device *dev, void *res)
>    *
>    * Return: pointer to struct fpga_manager or NULL
>    */
> -struct fpga_manager *devm_fpga_mgr_create(struct device *dev, const char *name,
> +struct fpga_manager *devm_fpga_mgr_create(struct device *parent, const char *name,
>   					  const struct fpga_manager_ops *mops,
>   					  void *priv)
>   {
> @@ -661,13 +661,13 @@ struct fpga_manager *devm_fpga_mgr_create(struct device *dev, const char *name,
>   	if (!dr)
>   		return NULL;
>   
> -	dr->mgr = fpga_mgr_create(dev, name, mops, priv);
> +	dr->mgr = fpga_mgr_create(parent, name, mops, priv);
>   	if (!dr->mgr) {
>   		devres_free(dr);
>   		return NULL;
>   	}
>   
> -	devres_add(dev, dr);
> +	devres_add(parent, dr);
>   
>   	return dr->mgr;
>   }

