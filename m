Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 848153B1B47
	for <lists+linux-fpga@lfdr.de>; Wed, 23 Jun 2021 15:38:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbhFWNka (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 23 Jun 2021 09:40:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51487 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230163AbhFWNk3 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 23 Jun 2021 09:40:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624455491;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ayosJHzto3Nl337sThWluxXrKp5Ovvc0yF/Tu5r9k3g=;
        b=imHZEtmXNjfrr38+nN6XQbcKxWRALBVWJ4WVtjg/rv8TdVT7MirP1PIi9OFMyDrTTJdCzw
        3syWX/zijPTdFQ3nWdHjgm4C0TGFMrLWQn5ZKap0YgYUd4Ky8zwLEk1OdorC5RRPs41JEV
        FNUeMj+GYlSQ56DixSJjmEaZ/CrliAQ=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-289-MBl9Sl7XNga-zBzL6ZZEkA-1; Wed, 23 Jun 2021 09:38:10 -0400
X-MC-Unique: MBl9Sl7XNga-zBzL6ZZEkA-1
Received: by mail-oo1-f71.google.com with SMTP id q14-20020a4adc4e0000b0290249480f62d9so1764285oov.0
        for <linux-fpga@vger.kernel.org>; Wed, 23 Jun 2021 06:38:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=ayosJHzto3Nl337sThWluxXrKp5Ovvc0yF/Tu5r9k3g=;
        b=nNVDWe200qknNbgLbkhZhuMWcNT1TKUvsJI6BrYDzUGbjTP9TPnuTwsArkK9Tp3Mv7
         bZbhwEeCBlFI3kM03i14rlU5Ev4VCkvcn8/3lP0+mDO7DQUNPbphGr/8iSgAcjOPomQg
         BNQ9HhBMDyDj2TIKXvwrz1qQXacYRb1Pv24w6MdnQzQLySlhqJc2bPkIZdJ9IXiJjZRw
         G2J5rneL0SN8phgKemMqNKxrI1zWsQrbIKW8uI5iABRzmn7AWB93HB6TwULoLUV91yxB
         SNIiL4evHSqMB/6QyFZx4eZIavWMbWbxxjP+aDTlAyT1g03Oj0icRUESLHmuNhBPIwKO
         hosA==
X-Gm-Message-State: AOAM5324NkdW9isz8WIKA8HbdN6qVBCSsd+Spe0Xz/IrtlA7nwgOnd1J
        wug3LaRRj7hlXLUKhJehlZ0D9bNS7ZlFuZLSxsIHUbDDIeJePX28pMpqWMui97XhPY/LARcuyem
        HDXsUbAvLLseLCTvSgJr0Zw==
X-Received: by 2002:a9d:baa:: with SMTP id 39mr7603972oth.159.1624455489666;
        Wed, 23 Jun 2021 06:38:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwlXyWHG5pyZpeayDKedl3jn/cHEnHebPyntDXCkLWrrUxenbpooc7H5uW2VJ/PBltOy/+i9Q==
X-Received: by 2002:a9d:baa:: with SMTP id 39mr7603952oth.159.1624455489491;
        Wed, 23 Jun 2021 06:38:09 -0700 (PDT)
Received: from localhost.localdomain (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id m10sm5008296oig.9.2021.06.23.06.38.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Jun 2021 06:38:09 -0700 (PDT)
Subject: Re: [PATCH 2/4] fpga: dfl: Move DFH header register macros to
 linux/dfl.h
To:     =?UTF-8?Q?Martin_Hundeb=c3=b8ll?= <mhu@silicom.dk>,
        Wu Hao <hao.wu@intel.com>, Moritz Fischer <mdf@kernel.org>,
        Xu Yilun <yilun.xu@intel.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Brown <broonie@kernel.org>
Cc:     =?UTF-8?Q?Martin_Hundeb=c3=b8ll?= <mhu@geanix.com>,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-spi@vger.kernel.org,
        Debarati Biswas <debaratix.biswas@intel.com>,
        Russ Weight <russell.h.weight@intel.com>
References: <20210621070621.431482-1-mhu@silicom.dk>
 <20210621070621.431482-3-mhu@silicom.dk>
 <81975a85-e9d6-bd4b-7666-56d1d1d581bc@redhat.com>
 <7c6021cc-69c5-7c3f-9e37-30c933535835@silicom.dk>
From:   Tom Rix <trix@redhat.com>
Message-ID: <77aa43c1-6d94-bf08-13cf-ec405916b4b7@redhat.com>
Date:   Wed, 23 Jun 2021 06:38:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <7c6021cc-69c5-7c3f-9e37-30c933535835@silicom.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 6/23/21 4:44 AM, Martin Hundebøll wrote:
> On 21/06/2021 15.56, Tom Rix wrote:
>>
>> On 6/21/21 12:06 AM, Martin Hundebøll wrote:
>>> From: Debarati Biswas <debaratix.biswas@intel.com>
>>>
>>> Device Feature List (DFL) drivers may be defined in subdirectories 
>>> other
>>> than drivers/fpga, and each DFL driver should have access to the Device
>>> Feature Header (DFH) register, which contains revision and type
>>> information. This change moves the macros specific to the DFH register
>>> from drivers/fpga/dfl.h to include/linux/dfl.h.
>>>
>>> Signed-off-by: Debarati Biswas <debaratix.biswas@intel.com>
>>> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
>>> Signed-off-by: Martin Hundebøll <mhu@silicom.dk>
>>> ---
>>>   drivers/fpga/dfl.h  | 48 +----------------------------------------
>>>   include/linux/dfl.h | 52 
>>> +++++++++++++++++++++++++++++++++++++++++++++
>>>   2 files changed, 53 insertions(+), 47 deletions(-)
>>>
>>> diff --git a/drivers/fpga/dfl.h b/drivers/fpga/dfl.h
>>> index 2b82c96ba56c..6ed0353e9a99 100644
>>> --- a/drivers/fpga/dfl.h
>>> +++ b/drivers/fpga/dfl.h
>>> @@ -17,6 +17,7 @@
>>>   #include <linux/bitfield.h>
>>
>> bitfield.h was added to linux/dfl.h
>>
>> Likely both aren't needed, try removing this one.
>
> After this patch both headers use GENMASK_ULL() and BIT_ULL(), which 
> are both defined in linux/bits.h, so I would expect both to include 
> that instead. A lot of the users of dfl.h uses FIELD_GET(), which is 
> defined in linux/bitfield.h, so I would expect that to be included 
> there instead.
>
> I can prepare a patch to fix that up, if you like?

A rule of thumb, if your commit says 'A and B' , likely it should only be A.

Remove the the linux/bitfield.h from drivers/fpga/dfl.h

Leave the linux/bitfield.h as-is in include/linux/dfl.h

If you feel include/linux/dfl.h can be optimized by the reduction of 
linux/bitfield.h to linux/bits.h, do that as a follow on patchset.

Tom

>
> // Martin
>

