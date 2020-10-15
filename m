Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 933F828F346
	for <lists+linux-fpga@lfdr.de>; Thu, 15 Oct 2020 15:33:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729735AbgJONdI (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 15 Oct 2020 09:33:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27330 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729016AbgJONdH (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 15 Oct 2020 09:33:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602768785;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ecFaVTS+b9Mz5LdmWHJaxUOoJETaqmSTJqNw7ajvKK4=;
        b=dku1Q1fqEDln0beE0uKqoNh4g0krQ9jK1EFXi0QG353KwB5uKdUw2JNpUdj2R7/NQhhjeg
        KjX6BkmBOGKEt85fVx/uhRlqYBm+2Z6ensGNTLh65C1ibU8bai0DSXMrkFUGmNR/c3cjlm
        va59JWQE9P9v0PoGWuYtt2YpvPZKOrw=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-1-Sw9bGloqMviSsxmCyoyQIA-1; Thu, 15 Oct 2020 09:33:03 -0400
X-MC-Unique: Sw9bGloqMviSsxmCyoyQIA-1
Received: by mail-ot1-f69.google.com with SMTP id g98so950717otg.5
        for <linux-fpga@vger.kernel.org>; Thu, 15 Oct 2020 06:33:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=ecFaVTS+b9Mz5LdmWHJaxUOoJETaqmSTJqNw7ajvKK4=;
        b=By6tDSKHwRjyyDQ6XYqjagKVlWGP6AFEeZ7oZZ2JtEHbCK7H8xmXrMTX/L7KysAMtl
         fg4HIKiapuHqBFGe5kzx6yCZLH+dRJvPp1NFzLQbEhjcKTWCR0myL2MQ5RbRZTURCtHZ
         qSxr/PG8QxqHASTZGleb/rVUOF3nLlIuIp41okPUPT+BLI94tYD0mQEe/wCcl6Faplo6
         kSBHoeFMHR0ZZjHOCuiZ6UOGF7Kxl6GFqMHteYMxPDkstjP5WNukGmRodtJrzIGk1ghC
         3n3wqGsOAak7sgFY3XwerBs+HkGivZG4ZYGlMD794Q29igx2O7TcPMIbaJ8bs7v52Bel
         aEsg==
X-Gm-Message-State: AOAM531x+d86QkxfB8hWikz08nLgFabvBRAViABptTmGQ8IgjmL2ky+S
        Wl103JTOKAtbN7cIJBp27TXlyJD2Drq+M/KxTb09AS4069rmdbcUpaPegGIrdeS9cWe7stkItsa
        NTsRwfnXw65bgaIUCNcxf/A==
X-Received: by 2002:a4a:d083:: with SMTP id i3mr2414628oor.74.1602768782085;
        Thu, 15 Oct 2020 06:33:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwLYb1V8BLpaH+mINQN5EWp56slEF06Uix7E9X2EPNZ4sz0YgKpsqbFnrjmjl6egS2Z2RfHSg==
X-Received: by 2002:a4a:d083:: with SMTP id i3mr2414602oor.74.1602768781682;
        Thu, 15 Oct 2020 06:33:01 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id n128sm1300580oif.14.2020.10.15.06.33.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Oct 2020 06:33:01 -0700 (PDT)
Subject: Re: [PATCH v10 1/6] fpga: dfl: fix the definitions of type &
 feature_id for dfl devices
To:     Xu Yilun <yilun.xu@intel.com>, mdf@kernel.org, krzk@kernel.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, lgoncalv@redhat.com, hao.wu@intel.com
References: <1602746193-10626-1-git-send-email-yilun.xu@intel.com>
 <1602746193-10626-2-git-send-email-yilun.xu@intel.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <2269d33f-3979-d032-7f4c-abf300a74c68@redhat.com>
Date:   Thu, 15 Oct 2020 06:32:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <1602746193-10626-2-git-send-email-yilun.xu@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 10/15/20 12:16 AM, Xu Yilun wrote:
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

Looks fine.

Reviewed-by: Tom Rix <trix@redhat.com>

> ---
> v9: no change
> v10: no change
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

