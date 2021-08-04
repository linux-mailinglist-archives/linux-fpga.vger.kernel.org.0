Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 713983E01D5
	for <lists+linux-fpga@lfdr.de>; Wed,  4 Aug 2021 15:22:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237459AbhHDNWN (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 4 Aug 2021 09:22:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:40928 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237382AbhHDNWN (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 4 Aug 2021 09:22:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628083320;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fVTqOxqeEgFMdxSeIIeK4Wrh+5Kp/mRSGciCM9V9/Sw=;
        b=EmadTH4rRiE7FAlgbpefY+bq5h9nHaYLNQIfpIytwYz4Da6WQjYZhqQ9MrZB0SMon1F9It
        IBlhbAW9dlOYb3Hu7FTqdQaUx7yGHmUAf7W7+ofAz/TcNQTIE1EUOGB0NK7Cp7e5+/MqKn
        pMn4ExWp4LilxKyI5fT37ilUBkiL1vk=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-600-LExroo6sP2u7WU6Lv1OpWw-1; Wed, 04 Aug 2021 09:21:59 -0400
X-MC-Unique: LExroo6sP2u7WU6Lv1OpWw-1
Received: by mail-qv1-f72.google.com with SMTP id s12-20020ad4446c0000b029033a9344451cso1622218qvt.21
        for <linux-fpga@vger.kernel.org>; Wed, 04 Aug 2021 06:21:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=fVTqOxqeEgFMdxSeIIeK4Wrh+5Kp/mRSGciCM9V9/Sw=;
        b=uHWKxvyRTdLd7qnCs75TfcKRS4rIwD5ejqmAdiwC3yKXQG8WnEOLrJEB/WYYZcscj7
         8gE1TMLfD2+FFGtu1gZYgygoi1D1Iq2rzfscYxbj1UkCSdZGyBVU5jEVedPlgioXvqiq
         86bluuKQiX7KQgl7s4aJU8Zd5+heE1VevKkZJkK/5vQniXMeIWCKPZ78A2FopYv7hOcI
         ZBDoXQ/tw2VHJEJi87uPA0HY5MjV+9pseppmYh4dkt4GCLa9WuCrIgSS1J89y6p54RAG
         liQDGKI8UjtZIuz33+VgcyWv6x3a8O8dwE6TE9LTOrzzOBpvASoc97Tkv+BffvrKLVqn
         KJJA==
X-Gm-Message-State: AOAM530G69bkxgTgm+llWIjGt4Y+d6s/jp1/81Wvt05gN8Gq9Blq09u1
        987OwB001kODnj0uP42kWjsDRTy36/elYvHc14zNC+HW7pGjwz3OCM0NSkLnT1iT2y9o+6PNZTK
        R/LeeIBCDtRPq8ut60tCDi3WikyL+tkK4FohzzPYzrhLtQ+08SMPwdXXYG2j9QLHjGySs
X-Received: by 2002:a05:6214:d4b:: with SMTP id 11mr10319859qvr.44.1628083318551;
        Wed, 04 Aug 2021 06:21:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx1JkITU3IJ9+loR1/ezSopUbJ3tXUFAf8AcJOcHXV9cxfRpn/tERf4G4ZWbG+Zbo4kvF6GRQ==
X-Received: by 2002:a05:6214:d4b:: with SMTP id 11mr10319834qvr.44.1628083318284;
        Wed, 04 Aug 2021 06:21:58 -0700 (PDT)
Received: from localhost.localdomain (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id bm34sm1266482qkb.17.2021.08.04.06.21.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Aug 2021 06:21:57 -0700 (PDT)
Subject: Re: [PATCH] fpga: region: handle compat_id as an uuid
To:     Xu Yilun <yilun.xu@intel.com>
Cc:     Moritz Fischer <mdf@kernel.org>, "Wu, Hao" <hao.wu@intel.com>,
        "Weight, Russell H" <russell.h.weight@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>
References: <20210726202650.4074614-1-trix@redhat.com>
 <6f30a4c6-61a0-bb57-9f13-bcad3f3589b8@intel.com>
 <ba28bac6-9c6d-de73-523f-b8ba4bef84de@redhat.com>
 <DM6PR11MB38199F872DC94971D9C8A53885EA9@DM6PR11MB3819.namprd11.prod.outlook.com>
 <YQL4qyAmqj322HTz@epycbox.lan>
 <a5b4b303-7d9b-27d7-4c1e-cd29fea8cdb9@redhat.com>
 <20210730014859.GA436611@yilunxu-OptiPlex-7050>
 <dd2bc08b-3610-b14f-59fc-ab444845d0f7@redhat.com>
 <20210803033224.GA461389@yilunxu-OptiPlex-7050>
 <fa35d07e-f455-a9c9-1d01-b115d114de9b@redhat.com>
 <20210804014455.GB461389@yilunxu-OptiPlex-7050>
From:   Tom Rix <trix@redhat.com>
Message-ID: <12d6563a-6cdc-490d-81fb-6699bc9d2d4b@redhat.com>
Date:   Wed, 4 Aug 2021 06:21:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210804014455.GB461389@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 8/3/21 6:44 PM, Xu Yilun wrote:
> On Tue, Aug 03, 2021 at 05:21:54AM -0700, Tom Rix wrote:
>> On 8/2/21 8:32 PM, Xu Yilun wrote:
>>> On Fri, Jul 30, 2021 at 05:07:00AM -0700, Tom Rix wrote:
>>>> On 7/29/21 6:48 PM, Xu Yilun wrote:
>>>>> On Thu, Jul 29, 2021 at 12:16:47PM -0700, Tom Rix wrote:
>>>>>> On 7/29/21 11:51 AM, Moritz Fischer wrote:
>>>>>>> On Wed, Jul 28, 2021 at 01:36:56AM +0000, Wu, Hao wrote:
>>>>>>>>> On 7/26/21 3:12 PM, Russ Weight wrote:
>>>>>>>>>> On 7/26/21 1:26 PM, trix@redhat.com wrote:
>>>>>>>>>>> From: Tom Rix <trix@redhat.com>
>>>>>>>>>>>
>>>>>>>>>>> An fpga region's compat_id is exported by the sysfs
>>>>>>>>>>> as a 128 bit hex string formed by concatenating two
>>>>>>>>>>> 64 bit values together.
>>>>>>>>>>>
>>>>>>>>>>> The only user of compat_id is dfl.  Its user library
>>>>>>>>>>> opae converts this value into a uuid.
>>>>>>>>>>>
>>>>>>>>>>> ex/
>>>>>>>>>>> $ cat /sys/class/fpga_region/region1/compat_id
>>>>>>>>>>> f3c9941350814aadbced07eb84a6d0bb
>>>>>>>>>>>
>>>>>>>>>>> Is reported as
>>>>>>>>>>> $ fpgainfo bmc
>>>>>>>>>>> ...
>>>>>>>>>>> Pr Interface Id                  : f3c99413-5081-4aad-bced-07eb84a6d0bb
>>>>>>>>>>>
>>>>>>>>>>> Storing a uuid as 2 64 bit values is vendor specific.
>>>>>>>>>>> And concatenating them together is vendor specific.
>>>>>>>>>>>
>>>>>>>>>>> It is better to store and print out as a vendor neutral uuid.
>>>>>>>>>>>
>>>>>>>>>>> Change fpga_compat_id from a struct to a union.
>>>>>>>>>>> Keep the old 64 bit values for dfl.
>>>>>>>>>>> Sysfs output is now
>>>>>>>>>>> f3c99413-5081-4aad-bced-07eb84a6d0bb
>>>>>>>>>> I'm fowarding feedback from Tim Whisonant, one of the OPAE userspace
>>>>>>>>>> developers:
>>>>>>>>>>
>>>>>>>>>> I think that this change to the sysfs for the compat_id node will
>>>>>>>>>> end up breaking the SDK, which does not expect the '-' characters to
>>>>>>>>>> be included when parsing the sysfs value. Currently, it is parsed as
>>>>>>>>>> a raw hex string without regard to any '-' characters. This goes for
>>>>>>>>>> any "guid" currently exported by sysfs and for what we read in the
>>>>>>>>>> device MMIO space.
>>>>>>>>> Yes, it will.
>>>>>>>>>
>>>>>>>>> And there are other places, like dfl-afu-main.c:afu_id_show()
>>>>>>>>>
>>>>>>>>> outputs raw hex that sdk turns into a uuid.
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> Some options.
>>>>>>>>>
>>>>>>>>> If no one but dfl will ever use it, then v1 of patchset.
>>>>>>>>>
>>>>>>>>> If others can use it but don't want to change dfl, then v2 of patchset,
>>>>>>>>> my favorite.
>>>>>>>>>
>>>>>>>>> Or this one for uuid for everyone, what have been v3 but changed too much.
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> could dfl change generally to output uuid's to the sysfs ?
>>>>>>>>>
>>>>>>>>> this would be generally helpful and a one time disruption to the sdk.
>>>>>>>> This change limited the output format to uuid_t, but if any hardware doesn't
>>>>>>>> use uuid_t on hardware may have to convert it back from the sysfs output in
>>>>>>>> userspace. Leave it to print hardware values (e.g. from register), and convert
>>>>>>>> it in userspace should be fine too I think.
>>>>>>> I'm not entirely sure. I seem to recall there being examples of sysfs
>>>>>>> files returning different things for different drivers.
>>>>>>>
>>>>>>> That being said it seems largely cosmetic to add the '-' in between.
>>>>>>>
>>>>>>> If it breaks userspace, I'm against it. If you *need* it make a
>>>>>>> compat_uuid entry or something in that case?
>>>>>> My gripe is
>>>>>>
>>>>>> For a nominally common interface, compat_id has a vendor specific output.
>>>>>>
>>>>>> If for example another vendor wanted to use this field but their natural
>>>>>> format was an OF string.
>>>>>>
>>>>>> 16 bytes of raw hex would not work for them, so they would roll their own.
>>>>>>
>>>>>> which defeats the purpose of a common interface.
>>>>>>
>>>>>>
>>>>>> The language in the docs as-is is vague on the output format.
>>>>>>
>>>>>> DFL is the only user of the interface.
>>>>>>
>>>>>> So ver 2
>>>>>>
>>>>>> https://lore.kernel.org/linux-fpga/4ab7dd2d-c215-6333-6860-6f7d0ac64c3d@redhat.com/
>>>>>>
>>>>>> Keeps the output as-is for dfl, so nothing breaks in userspace
>>>>>>
>>>>>> And adds flexibility for vendors to output their appropriate natural form.
>>>>>>
>>>>>> So compat_id becomes generally useful.
>>>>> Mixing types seems be strongly against in Documentation/filesystems/sysfs.rst.
>>>>> So in my opinion there should be a determined format for the output. The
>>>>> concern for this patch is which one is a better format, uuid style or
>>>>> 128 bit raw hex?
>>>>>
>>>>> And I vote for 128 bit raw hex, as other vendors may not use uuid_t as
>>>>> the identifier, may be an OF string. So we don't have to force them
>>>>> decorate it as the uuid style.
>>>> So you would be ok with v2 of this patchset ?
>>> No. I prefer we keep the current implementation. I mean 128 bit raw hex
>>> could be a more compatible output format for all vendors, uuid style,
>>> string style or others.
>> How would 128 bit raw hex be compatible if a vendor's natural format was an
>> OF string ?
>>
>> Why would they even use compat_id ?
> As I mentioned before, I assume there should be a unified output format
> for all vendors. So we need to choose one from raw hex, uuid_t, string
> and all other formats. Raw hex is the fundamental format, which could be
> further interpreted by user as a uuid_t, a string or other objects.

Having one format is not a requirement, the format is not listed in the 
docs.

How would converting an OF string to hex work and why would a vendor 
want to display it as hex ?

For the user, instead of reading an OF string directly they would be 
required to decrypt it.

So it they had a compat_id they would not use this one, they would stick 
it somewhere else.

Defeating the purpose of a having it a common area.

Tom

>
> Thanks,
> Yilun
>
>> Tom
>>
>>> Thanks,
>>> Yilun
>>>
>>>> Tom
>>>>
>>>>> Thanks
>>>>> Yilun
>>>>>
>>>>>> Tom
>>>>>>
>>>>>>
>>>>>>> - Moritz
>>>>>>>

