Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DC1828A33B
	for <lists+linux-fpga@lfdr.de>; Sun, 11 Oct 2020 01:08:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731016AbgJJW5S (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sat, 10 Oct 2020 18:57:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:53569 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732117AbgJJTkQ (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Sat, 10 Oct 2020 15:40:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602358807;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lScSHb5GRh2T45yUL3D8Nuv4fLYCBkJXmfkPANcLZ0g=;
        b=NYVIOVV4VW8r9DiQo8/O8YrsGMux6TnhUUlxHzv8wNllMHHM5lxcrVXIIjAQvsy92RjY+Q
        /u1EVrsXchB3feMX4PKHusJpZBzI+44n8pb2qg7FUCLWIQ7bzcTNARR19XrViJ8BopDqLW
        nMFrwF5gJ4wa7bUVpcmlgWRf7TocEDU=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-96-iK-1aNHiN9uteD2uKiS6ew-1; Sat, 10 Oct 2020 11:07:11 -0400
X-MC-Unique: iK-1aNHiN9uteD2uKiS6ew-1
Received: by mail-oo1-f71.google.com with SMTP id q189so5244391ooa.18
        for <linux-fpga@vger.kernel.org>; Sat, 10 Oct 2020 08:07:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=lScSHb5GRh2T45yUL3D8Nuv4fLYCBkJXmfkPANcLZ0g=;
        b=HwgQEDZ3xkrldc9xS5T7z5M9K2rTkX3iYFWc5aQGmXWjC9pfZS6wnlFAgMY0LpBFom
         sTB4vrUhEGOBUgwPqCchEVw3mfZf09bSxMMTEe3v2p9GIj1KuHVgz2RYhq3NFsqBr0Es
         H1TT+pxXE+DUzcqWGNs1QyzAgZ9+iD3w8Smfg/bqzxBjr+wl+4HLt7TqPES+j1txQCnc
         X5cfZJu8SKEPQ3kc81TWUL30BRW/DiljkC2EYq6nad/fPTppleQW1fAscAr0+0OZEGeN
         d4kWIv1uv/8BjqNXxc5nz1cX4hrpYH8JGxgiB7Ww3XWQtEVbQLMbcglPAFg+/dsIrfj9
         wxnA==
X-Gm-Message-State: AOAM532j3+Vn0o5lTx02B01UItN+fuLPMOOP6goRHJ0dHRuJbIiklEP+
        2iBGqcOHu/mxNJtZJuRZFmn30tK4FEnNPJzoJIkc4PkXOZ0epAMIaWjmCgSVZrkESiaxTU2MPhW
        uKq87/c4Q/2CZ6Q+v/f/TqA==
X-Received: by 2002:a9d:3a64:: with SMTP id j91mr12166067otc.207.1602342430974;
        Sat, 10 Oct 2020 08:07:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzh7nJmECAqmKKTRnHbW9vZsSCDKSoZMOAeBdsZ+p66fOBHFuqLBgjCWEN5eSrDmBz2yZ4aiQ==
X-Received: by 2002:a9d:3a64:: with SMTP id j91mr12166054otc.207.1602342430696;
        Sat, 10 Oct 2020 08:07:10 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id h3sm8936617oom.18.2020.10.10.08.07.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Oct 2020 08:07:10 -0700 (PDT)
Subject: Re: [PATCH v9 1/6] fpga: dfl: fix the definitions of type &
 feature_id for dfl devices
To:     Xu Yilun <yilun.xu@intel.com>, mdf@kernel.org, krzk@kernel.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, lgoncalv@redhat.com, hao.wu@intel.com
References: <1602313793-21421-1-git-send-email-yilun.xu@intel.com>
 <1602313793-21421-2-git-send-email-yilun.xu@intel.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <8786ca8f-7edd-d7b1-7eca-6447814c6e5e@redhat.com>
Date:   Sat, 10 Oct 2020 08:07:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <1602313793-21421-2-git-send-email-yilun.xu@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 10/10/20 12:09 AM, Xu Yilun wrote:
> The value of the field dfl_device.type comes from the 12 bits register
> field DFH_ID according to DFL spec. So this patch changes the definition
> of the type field to u16.
>
> Also it is not necessary to illustrate the valid bits of the type field
> in comments. Instead we should explicitly define the possible values in
> the enumeration type for it, because they are shared by hardware spec.
> We should not let the compiler decide these values.
>
> Similar changes are also applied to dfl_device.feature_id.
>
> This patch also fixed the MODALIAS format according to the changes
> above.
>
> Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> ---
> v9: no change
> ---
>  drivers/fpga/dfl.c |  3 +--
>  drivers/fpga/dfl.h | 14 +++++++-------
>  2 files changed, 8 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
> index b450870..5a6ba3b 100644
> --- a/drivers/fpga/dfl.c
> +++ b/drivers/fpga/dfl.c
> @@ -298,8 +298,7 @@ static int dfl_bus_uevent(struct device *dev, struct kobj_uevent_env *env)
>  {
>  	struct dfl_device *ddev = to_dfl_dev(dev);
>  
> -	/* The type has 4 valid bits and feature_id has 12 valid bits */
> -	return add_uevent_var(env, "MODALIAS=dfl:t%01Xf%03X",
> +	return add_uevent_var(env, "MODALIAS=dfl:t%04Xf%04X",
>  			      ddev->type, ddev->feature_id);
>  }
>  
> diff --git a/drivers/fpga/dfl.h b/drivers/fpga/dfl.h
> index 5dc758f..ac373b1 100644
> --- a/drivers/fpga/dfl.h
> +++ b/drivers/fpga/dfl.h
> @@ -520,19 +520,19 @@ long dfl_feature_ioctl_set_irq(struct platform_device *pdev,
>   * enum dfl_id_type - define the DFL FIU types
>   */
>  enum dfl_id_type {
> -	FME_ID,
> -	PORT_ID,
> +	FME_ID = 0,
> +	PORT_ID = 1,

This is redundant, why make this change ?

Tom

>  	DFL_ID_MAX,
>  };
>  
>  /**
>   * struct dfl_device_id -  dfl device identifier
> - * @type: contains 4 bits DFL FIU type of the device. See enum dfl_id_type.
> - * @feature_id: contains 12 bits feature identifier local to its DFL FIU type.
> + * @type: DFL FIU type of the device. See enum dfl_id_type.
> + * @feature_id: feature identifier local to its DFL FIU type.
>   * @driver_data: driver specific data.
>   */
>  struct dfl_device_id {
> -	u8 type;
> +	u16 type;
>  	u16 feature_id;
>  	unsigned long driver_data;
>  };
> @@ -543,7 +543,7 @@ struct dfl_device_id {
>   * @dev: generic device interface.
>   * @id: id of the dfl device.
>   * @type: type of DFL FIU of the device. See enum dfl_id_type.
> - * @feature_id: 16 bits feature identifier local to its DFL FIU type.
> + * @feature_id: feature identifier local to its DFL FIU type.
>   * @mmio_res: mmio resource of this dfl device.
>   * @irqs: list of Linux IRQ numbers of this dfl device.
>   * @num_irqs: number of IRQs supported by this dfl device.
> @@ -553,7 +553,7 @@ struct dfl_device_id {
>  struct dfl_device {
>  	struct device dev;
>  	int id;
> -	u8 type;
> +	u16 type;
>  	u16 feature_id;
>  	struct resource mmio_res;
>  	int *irqs;

