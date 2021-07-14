Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7860B3C862D
	for <lists+linux-fpga@lfdr.de>; Wed, 14 Jul 2021 16:30:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232238AbhGNOdO (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 14 Jul 2021 10:33:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35935 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232065AbhGNOdO (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 14 Jul 2021 10:33:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626273022;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eiOYzmRxRkd9ALixnggbNVnpDMZpgQFXM4pqMgtPXZk=;
        b=JEBgEgtqIg3Z49RHuBSknTKtTouq9TEqJNTDbACmsVYdiH6hkrvZJZa3V2e9qakgFI9B+n
        ZNUTPRJNBVQgjGKVStzKWoDQ0DErJ1Ay/gO7xt3iotBmaYYOFR/dNJUsjgDDwm7zzxe75o
        MtoB/XyqQ8IcuvEniO7yXLa7kTAT82A=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-99-yZHQrC-gOQ2DgeVmXL3G1A-1; Wed, 14 Jul 2021 10:30:20 -0400
X-MC-Unique: yZHQrC-gOQ2DgeVmXL3G1A-1
Received: by mail-qk1-f199.google.com with SMTP id bk12-20020a05620a1a0cb02903b899a4309cso1368028qkb.14
        for <linux-fpga@vger.kernel.org>; Wed, 14 Jul 2021 07:30:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=eiOYzmRxRkd9ALixnggbNVnpDMZpgQFXM4pqMgtPXZk=;
        b=BUN0q4pt3R/OuBSXq/heAhF/8kduZm1AW6Wln1SK/6SvJSkyKn3cL28dg2FmFTtig1
         HAcAo9OwFbRLLAnZKjC4nr5uhDJJSWALCrT2Zg9P28bnf+rb7lbfZBuLONPfhOjg9Utf
         uOHXB+rz5p/utBpoa+kp/d5sDlMJtp4amSwrpaLiZ1r1RCLo82zIhYsbgcZz4HLpMUTB
         y5QTh8EA6OPSwL8E62ZNWLPf8z4slZVLxEsSbvfKDzYCuC91kO05QE8x3OiFlqQe+p73
         YVQhrUr519TMAkIKfNArbRDoxc/BNS5R6CLizhWIa7RjrCIBXu2GaJft37bl1wacj9/o
         hBfQ==
X-Gm-Message-State: AOAM530DdIRk1+AtU4XMWqZsmudYEBIVl04EXz4j8EyyoPc+HvR6w/Yy
        2Dq0oIJUU6hL6moaS1H8kVFojtnKg9npY65NzZwue9bq3azSlC9vmXo+zQSKNR7lYMbrmkzBbFu
        H0eHaYwQ1CgStyLC6TDbZjQ==
X-Received: by 2002:a37:4cd:: with SMTP id 196mr10325571qke.139.1626273020482;
        Wed, 14 Jul 2021 07:30:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwVz0c742Inf37LaXP95rWdNCsTupMjjVqw3JTbr4OZoarpmvyJ5+f4N5GvgC6ff3/UOoyNLA==
X-Received: by 2002:a37:4cd:: with SMTP id 196mr10325555qke.139.1626273020321;
        Wed, 14 Jul 2021 07:30:20 -0700 (PDT)
Received: from localhost.localdomain (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id i2sm1092055qko.43.2021.07.14.07.30.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Jul 2021 07:30:19 -0700 (PDT)
Subject: Re: [PATCH v4 1/4] fpga: dfl: expose feature revision from struct
 dfl_device
To:     =?UTF-8?Q?Martin_Hundeb=c3=b8ll?= <mhu@silicom.dk>,
        =?UTF-8?Q?Martin_Hundeb=c3=b8ll?= <martin@geanix.com>,
        Wu Hao <hao.wu@intel.com>, Moritz Fischer <mdf@kernel.org>,
        Xu Yilun <yilun.xu@intel.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-spi@vger.kernel.org,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>
References: <20210705101645.2040106-1-martin@geanix.com>
 <20210705101645.2040106-2-martin@geanix.com>
 <93a8e949-ec25-d00d-4740-72d9e18ebb68@redhat.com>
 <4ffd5153-e182-c615-0a81-2f5dad4979f5@silicom.dk>
From:   Tom Rix <trix@redhat.com>
Message-ID: <cf535684-52fa-d4c6-fe40-77d3a6c043d5@redhat.com>
Date:   Wed, 14 Jul 2021 07:30:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <4ffd5153-e182-c615-0a81-2f5dad4979f5@silicom.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 7/14/21 4:14 AM, Martin Hundebøll wrote:
>
>
> On 06/07/2021 16.10, Tom Rix wrote:
>>> diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
>>> index 511b20ff35a3..9381c579d1cd 100644
>>> --- a/drivers/fpga/dfl.c
>>> +++ b/drivers/fpga/dfl.c
>>> @@ -381,6 +381,7 @@ dfl_dev_add(struct dfl_feature_platform_data 
>>> *pdata,
>>>       ddev->type = feature_dev_id_type(pdev);
>>>       ddev->feature_id = feature->id;
>>> +    ddev->revision = feature->revision;
>>>       ddev->cdev = pdata->dfl_cdev;
>>>       /* add mmio resource */
>>> @@ -717,6 +718,7 @@ struct build_feature_devs_info {
>>>    */
>>>   struct dfl_feature_info {
>>>       u16 fid;
>>> +    u8 rev;
>>
>> In other places 'revision' is the element name.
>>
>> For consistency, change rev to revision
>
> So is fid vs. feature. I deliberately chose 'rev' to be consistent
> with other elements in struct dfl_feature_info.

Consistence for revision is important because we want to make it easy 
for folks using grep to search for one string not several.

fid vs feature_id is a problem, but one you do not need to solve.

Tom


>
> // Martin
>

