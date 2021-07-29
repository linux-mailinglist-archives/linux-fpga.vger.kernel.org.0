Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 673553DABB8
	for <lists+linux-fpga@lfdr.de>; Thu, 29 Jul 2021 21:16:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231224AbhG2TQ7 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 29 Jul 2021 15:16:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36879 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230034AbhG2TQ7 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 29 Jul 2021 15:16:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627586215;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5A2N7dGYeQ+Xbk5UXj9qLfRubLSGQbg8nll0cwkgIt4=;
        b=f/lP5fuKFN8BxfqEU+DAv3BE0ZjPSw0GUIR8hVCdvUYtDbo0ctY/HOanViEmnX8zRp+49p
        3011iGWSQ2M4eS2mV7h1aqtpqRgi3HMrGK+lTFrV31mLmTF46fnL4bPsAxdOhbGORjPeBf
        Dt0+BmfILhgZf/EasJ20upTDawLjr4w=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-5-v0e46dFaN_SyAmyUcwAIXQ-1; Thu, 29 Jul 2021 15:16:51 -0400
X-MC-Unique: v0e46dFaN_SyAmyUcwAIXQ-1
Received: by mail-qt1-f198.google.com with SMTP id l24-20020ac872580000b029024e988e8277so3169333qtp.23
        for <linux-fpga@vger.kernel.org>; Thu, 29 Jul 2021 12:16:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=5A2N7dGYeQ+Xbk5UXj9qLfRubLSGQbg8nll0cwkgIt4=;
        b=dsvJhvfiTrpeCHRtC8RCJMNqqzcSGltOZgslkQJsM+VIr27l6phV+2cWB5CGfkyKKZ
         fTHfePo8TC0CpfuZccCcl/Ev4UVdsp7hyDB5imikKjLoleLShG1J3SFS3uzLsyKxfbMC
         hC/+DMCob/2OcTUK9lUbKxL1miFki4e00aKLOA9L6UkgSNjejEGQII9bwgK4KlyT5Ivt
         +jlzQWvhOfhQbsEaxq9kyC1vW3MA//q4nUbEkMziGx4jFMdCM7DNIR6Yqh0gWa4b9JPQ
         CofOfra/kmkQNVp4bc59msvzdEQfIbTnFPkMdkoiSrmuNxxaO/AQKLfAnMa1TNXjoLAT
         MPug==
X-Gm-Message-State: AOAM531OdpjOphnGFVwJbQoKs6Lx5X/vW1j2IaWQzugo0+xdgBzxpCRC
        IsEvV8X8BLIiwZbX1iwCsytYViroEoMbGUUEX55GchFTd5iIQjXnek/8eL384204eIGmmOAAzW9
        WRApUAZVTK5azkNEN36Vekmuo7PlHXwlnSDq40cLi9glEYIcKiUrTGp9hPUs23MYYPdli
X-Received: by 2002:a37:668e:: with SMTP id a136mr6733818qkc.54.1627586210427;
        Thu, 29 Jul 2021 12:16:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxXWZdunXtPWYgMO5r2/mrUnugJE+AZjsM1cvmYe3z4ID1Ag4YUCClpSiGUppBJ4TltSIlYHQ==
X-Received: by 2002:a37:668e:: with SMTP id a136mr6733790qkc.54.1627586210155;
        Thu, 29 Jul 2021 12:16:50 -0700 (PDT)
Received: from localhost.localdomain (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id t6sm2219044qkg.75.2021.07.29.12.16.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jul 2021 12:16:49 -0700 (PDT)
Subject: Re: [PATCH] fpga: region: handle compat_id as an uuid
To:     Moritz Fischer <mdf@kernel.org>, "Wu, Hao" <hao.wu@intel.com>
Cc:     "Weight, Russell H" <russell.h.weight@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>
References: <20210726202650.4074614-1-trix@redhat.com>
 <6f30a4c6-61a0-bb57-9f13-bcad3f3589b8@intel.com>
 <ba28bac6-9c6d-de73-523f-b8ba4bef84de@redhat.com>
 <DM6PR11MB38199F872DC94971D9C8A53885EA9@DM6PR11MB3819.namprd11.prod.outlook.com>
 <YQL4qyAmqj322HTz@epycbox.lan>
From:   Tom Rix <trix@redhat.com>
Message-ID: <a5b4b303-7d9b-27d7-4c1e-cd29fea8cdb9@redhat.com>
Date:   Thu, 29 Jul 2021 12:16:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YQL4qyAmqj322HTz@epycbox.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 7/29/21 11:51 AM, Moritz Fischer wrote:
> On Wed, Jul 28, 2021 at 01:36:56AM +0000, Wu, Hao wrote:
>>> On 7/26/21 3:12 PM, Russ Weight wrote:
>>>> On 7/26/21 1:26 PM, trix@redhat.com wrote:
>>>>> From: Tom Rix <trix@redhat.com>
>>>>>
>>>>> An fpga region's compat_id is exported by the sysfs
>>>>> as a 128 bit hex string formed by concatenating two
>>>>> 64 bit values together.
>>>>>
>>>>> The only user of compat_id is dfl.  Its user library
>>>>> opae converts this value into a uuid.
>>>>>
>>>>> ex/
>>>>> $ cat /sys/class/fpga_region/region1/compat_id
>>>>> f3c9941350814aadbced07eb84a6d0bb
>>>>>
>>>>> Is reported as
>>>>> $ fpgainfo bmc
>>>>> ...
>>>>> Pr Interface Id                  : f3c99413-5081-4aad-bced-07eb84a6d0bb
>>>>>
>>>>> Storing a uuid as 2 64 bit values is vendor specific.
>>>>> And concatenating them together is vendor specific.
>>>>>
>>>>> It is better to store and print out as a vendor neutral uuid.
>>>>>
>>>>> Change fpga_compat_id from a struct to a union.
>>>>> Keep the old 64 bit values for dfl.
>>>>> Sysfs output is now
>>>>> f3c99413-5081-4aad-bced-07eb84a6d0bb
>>>> I'm fowarding feedback from Tim Whisonant, one of the OPAE userspace
>>>> developers:
>>>>
>>>> I think that this change to the sysfs for the compat_id node will
>>>> end up breaking the SDK, which does not expect the '-' characters to
>>>> be included when parsing the sysfs value. Currently, it is parsed as
>>>> a raw hex string without regard to any '-' characters. This goes for
>>>> any "guid" currently exported by sysfs and for what we read in the
>>>> device MMIO space.
>>> Yes, it will.
>>>
>>> And there are other places, like dfl-afu-main.c:afu_id_show()
>>>
>>> outputs raw hex that sdk turns into a uuid.
>>>
>>>
>>> Some options.
>>>
>>> If no one but dfl will ever use it, then v1 of patchset.
>>>
>>> If others can use it but don't want to change dfl, then v2 of patchset,
>>> my favorite.
>>>
>>> Or this one for uuid for everyone, what have been v3 but changed too much.
>>>
>>>
>>> could dfl change generally to output uuid's to the sysfs ?
>>>
>>> this would be generally helpful and a one time disruption to the sdk.
>> This change limited the output format to uuid_t, but if any hardware doesn't
>> use uuid_t on hardware may have to convert it back from the sysfs output in
>> userspace. Leave it to print hardware values (e.g. from register), and convert
>> it in userspace should be fine too I think.
> I'm not entirely sure. I seem to recall there being examples of sysfs
> files returning different things for different drivers.
>
> That being said it seems largely cosmetic to add the '-' in between.
>
> If it breaks userspace, I'm against it. If you *need* it make a
> compat_uuid entry or something in that case?

My gripe is

For a nominally common interface, compat_id has a vendor specific output.

If for example another vendor wanted to use this field but their natural 
format was an OF string.

16 bytes of raw hex would not work for them, so they would roll their own.

which defeats the purpose of a common interface.


The language in the docs as-is is vague on the output format.

DFL is the only user of the interface.

So ver 2

https://lore.kernel.org/linux-fpga/4ab7dd2d-c215-6333-6860-6f7d0ac64c3d@redhat.com/

Keeps the output as-is for dfl, so nothing breaks in userspace

And adds flexibility for vendors to output their appropriate natural form.

So compat_id becomes generally useful.


Tom


>
> - Moritz
>

