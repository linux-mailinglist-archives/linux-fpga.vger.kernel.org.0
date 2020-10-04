Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEFAA282C60
	for <lists+linux-fpga@lfdr.de>; Sun,  4 Oct 2020 20:08:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726237AbgJDSIS (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 4 Oct 2020 14:08:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51373 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726085AbgJDSIS (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sun, 4 Oct 2020 14:08:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601834896;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=N1jxl+fty+3cZOgzn/o5Dk1a+dOxOr9OnZ3Qn9d9GVU=;
        b=EKDK0M2ybhw7jW6N77DMKjUn3lQv0MfJmvLw5ztzebRI9bLJqFXWUQG74PRUUw36sbHulP
        jcwC5HGAd9EWa2OLOCRi+bXUyPTGotpAksX00P3Khwnf+qdiccPWUYPL2yA8MpDnvxcl9P
        1MONkGPhMbuYebLXBQULCxqiM4d8k9s=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-499-4RIDhD48P0-OxS2dp-hFMA-1; Sun, 04 Oct 2020 14:08:15 -0400
X-MC-Unique: 4RIDhD48P0-OxS2dp-hFMA-1
Received: by mail-qk1-f198.google.com with SMTP id m23so5042008qkh.10
        for <linux-fpga@vger.kernel.org>; Sun, 04 Oct 2020 11:08:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=N1jxl+fty+3cZOgzn/o5Dk1a+dOxOr9OnZ3Qn9d9GVU=;
        b=G0boov+gBJReH3uh56ko0M4eCPysgJwprIjr+9xDEss/w6UxENZBkycVOEXATo057z
         Q8ShMY/W8nk9oUNQgWq6pc5ZcYkO3AUejsNZLsBE5XcRhIcgwWnmijbtUhfa04M6Oe34
         4lpsYhVCfGI3aEGyhjYxdJKd6orqDb9wJxz0xmpywwCbonFPFgpj06qQeaaEHcsGF/4n
         SRvh0ssNCZasw94bBnqTqr9X5xa4+CAfUGw/IAPYl7k5NBr9WJjoXrwIY6rC3JNnhZf0
         onOoUtMB+seSVLJwu2Ba2gQ+kbJwKvrqs9W4eiEi6h1qscue+MM4cdXTx6mEPXb3yvpb
         txpQ==
X-Gm-Message-State: AOAM530nCCbHGpDTj7iwRFR7d65ileLjIr+U0WvD4Nm/EnZ2T9yPRg4y
        TonPOteqDsZaxPNYXl+OWMTwKU3SuirZgcCvOg0/POlG/9vXLDAB7h+dbUvjoKp4aihAdt4RNJQ
        MS1M0j2NPlpH4Elm8eaiCjw==
X-Received: by 2002:ac8:2f6d:: with SMTP id k42mr11074099qta.115.1601834894474;
        Sun, 04 Oct 2020 11:08:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx2EAYPoTnLPWpL5wO+P8/OYBoM2ygsBMoqGPcNgI3UkJy0m5MfLDJvQGlNvw/tRI5YYFXImg==
X-Received: by 2002:ac8:2f6d:: with SMTP id k42mr11074084qta.115.1601834894186;
        Sun, 04 Oct 2020 11:08:14 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id j31sm5899527qtc.33.2020.10.04.11.08.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Oct 2020 11:08:13 -0700 (PDT)
Subject: Re: [PATCH 01/10] fpga: fpga-mgr: Add devm_fpga_mgr_register() API
To:     Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org
Cc:     hao.wu@intel.com, michal.simek@xilinx.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        russell.h.weight@intel.com, matthew.gerlach@intel.com
References: <20201004051423.75879-1-mdf@kernel.org>
 <20201004051423.75879-2-mdf@kernel.org>
From:   Tom Rix <trix@redhat.com>
Message-ID: <b00ad633-8703-8d1f-d5fe-c4483cd19b79@redhat.com>
Date:   Sun, 4 Oct 2020 11:08:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20201004051423.75879-2-mdf@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 10/3/20 10:14 PM, Moritz Fischer wrote:
> Add a devm_fpga_mgr_register() API that can be used to register a FPGA
> Manager that was created using devm_fpga_mgr_create().
>
> Introduce a struct fpga_mgr_devres that makes the devres
> allocation a little bit more readable and gets reused for
> devm_fpga_mgr_create() devm_fpga_mgr_register().
>
> Signed-off-by: Moritz Fischer <mdf@kernel.org>
> ---
>  drivers/fpga/fpga-mgr.c       | 76 ++++++++++++++++++++++++++++++-----
>  include/linux/fpga/fpga-mgr.h |  2 +
>  2 files changed, 68 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
> index f38bab01432e..774ac98fb69c 100644
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
> @@ -722,6 +726,58 @@ void fpga_mgr_unregister(struct fpga_manager *mgr)
>  }
>  EXPORT_SYMBOL_GPL(fpga_mgr_unregister);
>  
> +static int fpga_mgr_devres_match(struct device *dev, void *priv,
> +				 void *match_data)
> +{
> +	struct fpga_mgr_devres *dr = priv;
> +
> +	return match_data == dr->mgr;
> +}
> +
> +static void devm_fpga_mgr_unregister(struct device *dev, void *priv)
> +{
> +	struct fpga_mgr_devres *dr = priv;
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
> +	int err;

nit

int ret;

Fine if it isn't changed.

Reviewed-by: Tom Rix <trix@redhat.com>

> +
> +	/* Make sure that the struct fpga_manager * that is passed in is
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
> +	err = fpga_mgr_register(mgr);
> +	if (err) {
> +		devres_free(dr);
> +		return err;
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

