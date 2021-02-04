Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E33E530F4E6
	for <lists+linux-fpga@lfdr.de>; Thu,  4 Feb 2021 15:27:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236518AbhBDO02 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 4 Feb 2021 09:26:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35931 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236681AbhBDO0P (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 4 Feb 2021 09:26:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612448687;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XpXFDxYEEygOiSW0EwEnIt2QyvX50R8LwyF4+V7RRmU=;
        b=YGqulw1Ut5wecUUKyPa/tk7EgvJkUa4O6IczR272s3GnSSwP6H8ZoPmuXsOZYnet0jfC4R
        c3ctx9TfDBWsFDJ7J0u5sSA2UffA94m8YEaF2v/iBl0ZqT+CPewl2davwnKw211PS7nIJx
        jGEb6BVflxnZuyT8Aep503Wa/BR3y6o=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-531-LRpgly5nP5mQegt7hBM7fw-1; Thu, 04 Feb 2021 09:24:43 -0500
X-MC-Unique: LRpgly5nP5mQegt7hBM7fw-1
Received: by mail-qv1-f72.google.com with SMTP id e10so2261025qvp.22
        for <linux-fpga@vger.kernel.org>; Thu, 04 Feb 2021 06:24:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=XpXFDxYEEygOiSW0EwEnIt2QyvX50R8LwyF4+V7RRmU=;
        b=GZhxIxLVqwTImMLPyiXv2QSs96Lol28lGeydMMBCpNbHGWy+lwRpzBnCBp4E/HfXiW
         pgNMmLfcmLul7mQfxIPcRf/F4PtrSUCdgX0UOWy4Hb8rybeeNP13HkG+QjZMCZoKH6yt
         ieIYZC+5ntdctoW/qvSHMHbW5zn4TJRn0IffkxZuKhbWure6YGwn3/XjoRFc8ZH432QS
         rtqmxvhMma05shXf+FRGHQ9dQF+l3wmOWSjyTa/ogoGkjlCSIkJdybeFVOkPkSm3Xw/G
         Fpdz+EddLwAjEFUQw+3sRI3Xnp7qHZAZJK6HUa7Ag96h2JIiT3xb359rhzkjUtN/ffET
         C2/w==
X-Gm-Message-State: AOAM533WOYtkOmyHhr9i6JRj4f0YLlie37hKA+13VlUBrvp0wHHCJ5NM
        rC47JB/ykc/GXuVu3yMs0k8Xwu5pYIWw8y/e6olnfrPhYzAPWllKiNPtd6hPN7yeH42IK+WeONM
        q1CeQDJyffvXHszm+4Q/C4w==
X-Received: by 2002:a37:60e:: with SMTP id 14mr7606615qkg.60.1612448682906;
        Thu, 04 Feb 2021 06:24:42 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzlFRShimnFw8uB0YGrJn4zH7BpK44y33+Whl8wip1+QMHHK9wY+W9WC+2xok1oF9sj/wA8PA==
X-Received: by 2002:a37:60e:: with SMTP id 14mr7606600qkg.60.1612448682692;
        Thu, 04 Feb 2021 06:24:42 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id u7sm4350137qta.75.2021.02.04.06.24.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Feb 2021 06:24:42 -0800 (PST)
Subject: Re: [PATCH v3 1/1] fpga: dfl: afu: harden port enable logic
To:     Russ Weight <russell.h.weight@intel.com>, mdf@kernel.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     lgoncalv@redhat.com, yilun.xu@intel.com, hao.wu@intel.com,
        matthew.gerlach@intel.com
References: <20210202230631.198950-1-russell.h.weight@intel.com>
 <15f90871-170c-3487-0f99-47cf54163bb7@redhat.com>
 <9e53d35b-b1b5-5f21-f771-63ce689dd67e@intel.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <6751f883-36d1-dad8-7754-bd335fd767a5@redhat.com>
Date:   Thu, 4 Feb 2021 06:24:40 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <9e53d35b-b1b5-5f21-f771-63ce689dd67e@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 2/3/21 3:06 PM, Russ Weight wrote:
>
> On 2/3/21 7:25 AM, Tom Rix wrote:
>> ..snip..
>>
>> On 2/2/21 3:06 PM, Russ Weight wrote:
>>> diff --git a/drivers/fpga/dfl-afu.h b/drivers/fpga/dfl-afu.h
>>> index 576e94960086..e5020e2b1f3d 100644
>>> --- a/drivers/fpga/dfl-afu.h
>>> +++ b/drivers/fpga/dfl-afu.h
>>> @@ -80,7 +80,7 @@ struct dfl_afu {
>>>  };
>>>  
>>>  /* hold pdata->lock when call __afu_port_enable/disable */
>>> -void __afu_port_enable(struct platform_device *pdev);
>>> +int __afu_port_enable(struct platform_device *pdev);
>>>  int __afu_port_disable(struct platform_device *pdev);
>>>  
>> Should the '__' prefix be removed from __afu_port* ?
>>
>> This would make the function names consistent with the other decls
> The '__' prefix is used here to help highlight the fact that these functions go not manage
> the locking themselves and must be called while holding the port mutex. There are additional
> functions, such as__port_reset(), that are following this same convention. I think these
> are OK as they are.

ok

Reviewed-by: Tom Rix <trix@redhat.com>

Tom

>
> - Russ
>
>> Tom
>>
>>>  void afu_mmio_region_init(struct dfl_feature_platform_data *pdata);

