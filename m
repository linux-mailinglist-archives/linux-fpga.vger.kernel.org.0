Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDBED434B09
	for <lists+linux-fpga@lfdr.de>; Wed, 20 Oct 2021 14:18:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230157AbhJTMUv (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 20 Oct 2021 08:20:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:52172 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230103AbhJTMUu (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 20 Oct 2021 08:20:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634732316;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8ZBxst80LCXNMfg6RoTJqv6FZv+6vj4EbXtRaZAkAmc=;
        b=Yp+ciXxMJmiZSqA8rRK7yxxar30uZcVe7/4O8Cw1uWSA1xRL9Y1lxv6JZV+Hi7jIi/Thsp
        ISCWJvMWAD7P/igxMWM/xf/Rf2qXZOFU7pfig+Wd9Hfhu8EiVR3/YUiz3Wvy/GLIE2khxO
        oVmvBdGvlmQZ0tQ9WmVP18ShWNiChnw=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-61-Iu8nUnMLM2iSAQDIClkoSw-1; Wed, 20 Oct 2021 08:18:35 -0400
X-MC-Unique: Iu8nUnMLM2iSAQDIClkoSw-1
Received: by mail-pf1-f198.google.com with SMTP id x25-20020aa79199000000b0044caf0d1ba8so1852360pfa.1
        for <linux-fpga@vger.kernel.org>; Wed, 20 Oct 2021 05:18:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=8ZBxst80LCXNMfg6RoTJqv6FZv+6vj4EbXtRaZAkAmc=;
        b=XOyiaRybsy5/ZllPvGqg8lbeMLeXUl4H7ZddEDZJUPimRGChW8wtQjIRkOVKoHUL18
         iNzG9KcQXI1aYI+8syX1JkDiQVMGm9WnJoHnjYoisOcSEkfC866SCExqhiGdra7gHgu5
         Mk3TmST7vSgBHFvXosNCzqEEzDSJoCm97S+c+rkrnNn6Xhn+pg16NpMrDDW6qRHJNf+N
         Wq4yJdQnzJfiEJqpIpb7MFswSiwg0sCvTB3LMwhqF84pOlPMY4bs2+wvi3vXQ92Pz0jr
         UQqur/jEA+aQOabqcu+9v4Sni1qX5XZXherEMOKPVzigdnMPuwnuOwCXaBJBmIIjFGaY
         z4Pw==
X-Gm-Message-State: AOAM530JVbDpS0E5tQ7QrZBrLd015f8om6yufW27ktqhcS0vbtNvzfEn
        YvUr42P2qkz7l26XFDh6D0eWGO+ItXeKyG8J0GqOOxNoWEcp9jo7isFa0Klwo5EhvsMAxIa2Zwr
        BN0lMouAAwmYdLNmsojb+6Q==
X-Received: by 2002:a17:90b:78d:: with SMTP id l13mr7089877pjz.37.1634732313808;
        Wed, 20 Oct 2021 05:18:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyOQBvKVIYHvoZrXW6sAeM+1+Gjf/RtOJNDDR2auxSs2JFSnR5H1g5F+wqr2+V24C5pTJG7Sw==
X-Received: by 2002:a17:90b:78d:: with SMTP id l13mr7089849pjz.37.1634732313495;
        Wed, 20 Oct 2021 05:18:33 -0700 (PDT)
Received: from localhost.localdomain (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id z71sm2748954pfc.19.2021.10.20.05.18.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Oct 2021 05:18:33 -0700 (PDT)
Subject: Re: [PATCH v1 1/2] fpga: dfl: afu: Clear port errors in afu init
To:     Russ Weight <russell.h.weight@intel.com>, mdf@kernel.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     lgoncalv@redhat.com, yilun.xu@intel.com, hao.wu@intel.com,
        matthew.gerlach@intel.com
References: <20211019231545.47118-1-russell.h.weight@intel.com>
 <20211019231545.47118-2-russell.h.weight@intel.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <e03a0a0a-74c3-9791-2603-523c2796a71d@redhat.com>
Date:   Wed, 20 Oct 2021 05:18:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20211019231545.47118-2-russell.h.weight@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 10/19/21 4:15 PM, Russ Weight wrote:
> When the AFU driver initializes, log any pre-existing errors and clear them.
>
> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> ---
>   drivers/fpga/dfl-afu-error.c | 26 ++++++++++++++++----------
>   1 file changed, 16 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/fpga/dfl-afu-error.c b/drivers/fpga/dfl-afu-error.c
> index ab7be6217368..0dc60bf49902 100644
> --- a/drivers/fpga/dfl-afu-error.c
> +++ b/drivers/fpga/dfl-afu-error.c
> @@ -47,13 +47,13 @@ static void afu_port_err_mask(struct device *dev, bool mask)
>   }
>   
>   /* clear port errors. */
> -static int afu_port_err_clear(struct device *dev, u64 err)
> +static int afu_port_err_clear(struct device *dev, u64 err, bool clear_all)
>   {
>   	struct dfl_feature_platform_data *pdata = dev_get_platdata(dev);
>   	struct platform_device *pdev = to_platform_device(dev);
> +	u64 v, port_error, port_first_error;
v is only used now by the read of PORT_HDR_STS, could v be changed to a 
more descriptive variable like hdr_sts ?
>   	void __iomem *base_err, *base_hdr;
>   	int enable_ret = 0, ret = -EBUSY;
> -	u64 v;
>   
>   	base_err = dfl_get_feature_ioaddr_by_id(dev, PORT_FEATURE_ID_ERROR);
>   	base_hdr = dfl_get_feature_ioaddr_by_id(dev, PORT_FEATURE_ID_HEADER);
> @@ -88,16 +88,21 @@ static int afu_port_err_clear(struct device *dev, u64 err)
>   	__afu_port_err_mask(dev, true);
>   
>   	/* Clear errors if err input matches with current port errors.*/
> -	v = readq(base_err + PORT_ERROR);
> +	port_error = readq(base_err + PORT_ERROR);
>   
> -	if (v == err) {
> -		writeq(v, base_err + PORT_ERROR);
> +	if (clear_all || port_error == err) {
> +		port_first_error = readq(base_err + PORT_FIRST_ERROR);
>   
> -		v = readq(base_err + PORT_FIRST_ERROR);
> -		writeq(v, base_err + PORT_FIRST_ERROR);
> +		if (clear_all && (port_error || port_first_error))

likely with clear_all that this dev_warn will over report.

how about removing clear_all && from if-check ?

> +			dev_warn(dev,
> +				 "Port Error: 0x%llx, First Error 0x%llx\n",
> +				 port_error, port_first_error);
> +
> +		writeq(port_error, base_err + PORT_ERROR);
> +		writeq(port_first_error, base_err + PORT_FIRST_ERROR);
>   	} else {
>   		dev_warn(dev, "%s: received 0x%llx, expected 0x%llx\n",
> -			 __func__, v, err);
> +			 __func__, port_error, err);
>   		ret = -EINVAL;
>   	}
>   
> @@ -137,7 +142,7 @@ static ssize_t errors_store(struct device *dev, struct device_attribute *attr,
>   	if (kstrtou64(buff, 0, &value))
>   		return -EINVAL;
>   
> -	ret = afu_port_err_clear(dev, value);
> +	ret = afu_port_err_clear(dev, value, false);
>   
>   	return ret ? ret : count;
>   }
> @@ -211,7 +216,8 @@ const struct attribute_group port_err_group = {
>   static int port_err_init(struct platform_device *pdev,
>   			 struct dfl_feature *feature)
>   {
> -	afu_port_err_mask(&pdev->dev, false);
> +	if (afu_port_err_clear(&pdev->dev, 0, true))
> +		afu_port_err_mask(&pdev->dev, false);

There is a __afu_port_err_mask at the end of afu_port_err_clear so this 
call isn't needed.

Tom

>   
>   	return 0;
>   }

