Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F03E262EDA
	for <lists+linux-fpga@lfdr.de>; Wed,  9 Sep 2020 15:02:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729912AbgIINAm (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 9 Sep 2020 09:00:42 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:34708 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730245AbgIIM4d (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 9 Sep 2020 08:56:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599656138;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cwYS+mSAZh9umKPn+XGPvMZJwr6XsPjld2rKUSGA8Rw=;
        b=ON7G9piYcqc3uHudFOl06uRFUX3J4X1uSvgLNpwqq34CqmCC+yomSelQy2QJeKm4R2QXSG
        aQC0QmhxY8awX97teET+ANnRya8kBA0+7JFOCO7TdakthPyWPZ+Lo03zlvtznh6pZ+hOCr
        M4CnyziSjRYeiDHAPXlzrDVpo57GWyA=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-552-oZoVH63CPzuGqYJUKmfcVA-1; Wed, 09 Sep 2020 08:55:37 -0400
X-MC-Unique: oZoVH63CPzuGqYJUKmfcVA-1
Received: by mail-qt1-f199.google.com with SMTP id m13so1686691qtu.10
        for <linux-fpga@vger.kernel.org>; Wed, 09 Sep 2020 05:55:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=cwYS+mSAZh9umKPn+XGPvMZJwr6XsPjld2rKUSGA8Rw=;
        b=eSDwxMt4JeVcr91u2wmZEMrS9e+o9vkcMkYrLf+yWspDQKgi5IUwzp+ZpMjJWSTScD
         ajnhTr/DNGW6+jqbgP8iozydE2k5lDE7+S/txNOnA6hI1dVhQ3VfH0LKg40G+XCc95JH
         87o2pL9Gpnfs/XCrOWTV0HHeT832s4uW5+Nu6V7OlJ6JvygGguY5lRnu5LJSSM32TVG0
         v5pQ6Ew87KSMY1mkb83nC6PSi3a94O7Dj/DicD8jx8WKJYy4AfgO13L4mLQCET7kTmfe
         C0Ly5Vuszt4PNBcmtO14LPsL9KM+29kOJjIpF+r7N6E6PKDWj7WPTZ4Jx3hf/kaQ14qC
         vrVw==
X-Gm-Message-State: AOAM531/aFK0YEUChC/YLFa4P8I6dbg4UC3I0XhXQx4uTZuZAxzSw+bN
        fRxEnwRFzG10pDoHm6bWff66rAqsh8+Mfyq73YDfk7VspNol1barpjGFFxAxvi5lJ65FnVxFsEr
        8agz6RGYxaPCUGoghYY0N2g==
X-Received: by 2002:ac8:6f21:: with SMTP id i1mr2884983qtv.89.1599656136989;
        Wed, 09 Sep 2020 05:55:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyAIj5zzLDvbU03DdW5LzH2DlTOLQd0MX70bcYW8JI6RyB44+LsfBXI3JEmCXCLfXZjSEjh9g==
X-Received: by 2002:ac8:6f21:: with SMTP id i1mr2884957qtv.89.1599656136618;
        Wed, 09 Sep 2020 05:55:36 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id 205sm2426626qki.118.2020.09.09.05.55.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Sep 2020 05:55:35 -0700 (PDT)
Subject: Re: [PATCH 1/3] fpga: dfl: move dfl_device_id to mod_devicetable.h
To:     Xu Yilun <yilun.xu@intel.com>, mdf@kernel.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        masahiroy@kernel.org
Cc:     lgoncalv@redhat.com, Wu Hao <hao.wu@intel.com>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        Russ Weight <russell.h.weight@intel.com>
References: <1599544129-17594-1-git-send-email-yilun.xu@intel.com>
 <1599544129-17594-2-git-send-email-yilun.xu@intel.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <aaa2d9a5-f5ae-d026-91c9-730403f04050@redhat.com>
Date:   Wed, 9 Sep 2020 05:55:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <1599544129-17594-2-git-send-email-yilun.xu@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 9/7/20 10:48 PM, Xu Yilun wrote:
> In order to support MODULE_DEVICE_TABLE() for dfl device driver, this
> patch moves struct dfl_device_id to mod_devicetable.h
>
> Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> Signed-off-by: Wu Hao <hao.wu@intel.com>
> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> ---
>  drivers/fpga/dfl.h              | 13 +------------
>  include/linux/mod_devicetable.h | 12 ++++++++++++
>  2 files changed, 13 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/fpga/dfl.h b/drivers/fpga/dfl.h
> index 5dc758f..d5b0760 100644
> --- a/drivers/fpga/dfl.h
> +++ b/drivers/fpga/dfl.h
> @@ -26,6 +26,7 @@
>  #include <linux/slab.h>
>  #include <linux/uuid.h>
>  #include <linux/fpga/fpga-region.h>
> +#include <linux/mod_devicetable.h>
>  
>  /* maximum supported number of ports */
>  #define MAX_DFL_FPGA_PORT_NUM 4
> @@ -526,18 +527,6 @@ enum dfl_id_type {
>  };
>  
>  /**
> - * struct dfl_device_id -  dfl device identifier
> - * @type: contains 4 bits DFL FIU type of the device. See enum dfl_id_type.
> - * @feature_id: contains 12 bits feature identifier local to its DFL FIU type.
> - * @driver_data: driver specific data.
> - */
> -struct dfl_device_id {
> -	u8 type;
> -	u16 feature_id;
> -	unsigned long driver_data;
> -};
> -
> -/**
>   * struct dfl_device - represent an dfl device on dfl bus
>   *
>   * @dev: generic device interface.
> diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_devicetable.h
> index 5b08a47..407d8dc 100644
> --- a/include/linux/mod_devicetable.h
> +++ b/include/linux/mod_devicetable.h
> @@ -838,4 +838,16 @@ struct mhi_device_id {
>  	kernel_ulong_t driver_data;
>  };
>  
> +/**
> + * struct dfl_device_id -  dfl device identifier
> + * @type: contains 4 bits DFL FIU type of the device. See enum dfl_id_type.
> + * @feature_id: contains 12 bits feature identifier local to its DFL FIU type.
> + * @driver_data: driver specific data.
> + */
> +struct dfl_device_id {
> +	__u8 type;
> +	__u16 feature_id;

I thought i saw feature id's going to 64 bit, does this type need to expand ?

Tom 

> +	kernel_ulong_t driver_data;
> +};
> +
>  #endif /* LINUX_MOD_DEVICETABLE_H */

