Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 994592F04B7
	for <lists+linux-fpga@lfdr.de>; Sun, 10 Jan 2021 02:42:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726249AbhAJBmK (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sat, 9 Jan 2021 20:42:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:24290 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726238AbhAJBmK (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sat, 9 Jan 2021 20:42:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610242843;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2sAhMPAqZzotrO2nlPyhJHBXpEmoJ10fcvEPsZhICVM=;
        b=K1hM3EjKz3Hdt91Z6Pk4HRK3eq61ERsGPcOdDoIaGQ0ZWTfsicwEK9sD+1+BodpzG03SO1
        WgghHD1I4Z5r6LuoxlHcBGihRWpAwlHUK4hkIFFWlq4RnPx4XNg8GV4CKPVx7hiseKfIjX
        Z72D3ns2PvO2qmPKIkIHG/K4wRO2u8Y=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-496-zZDd6M8kPnysMlmSJIqgKA-1; Sat, 09 Jan 2021 20:40:41 -0500
X-MC-Unique: zZDd6M8kPnysMlmSJIqgKA-1
Received: by mail-il1-f200.google.com with SMTP id f4so13962194ilu.15
        for <linux-fpga@vger.kernel.org>; Sat, 09 Jan 2021 17:40:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=2sAhMPAqZzotrO2nlPyhJHBXpEmoJ10fcvEPsZhICVM=;
        b=UZIPkGkZ9XO3BmiNg2UjNFCV5UY2gGdULFkhxw+FKOY76nRz+eH/4fHhAlaUAh1e6R
         vwQ7O5N5fIzlEA7vYIgCO3g6ycLIdDh4AW+HP9hCLNXSsFQT5z+1yC7BoxjleNiUIR59
         zAroV4Q29XGstrwRPP5FzZxS0LBQDhOpHuxrpoPhS+3gIrNua1IIwrNoUuZdYG5N7qIL
         dE21NpYqk3P6KwPAGNPC9XgPyVASjkYLfob+Ilo99TTfy83x4fMsaJI6ibepp1Qbn0SZ
         ZyBxNts0jcEb8gFgCli+Ul0Cd6ZhoKJSFRJXQmYCnV5zpmz7KL/Y9ny9itNyxiegdi2Y
         aa6w==
X-Gm-Message-State: AOAM532JqxH3dZ0ePcmspfhKqKsR+zcY4d/OQSuSMS9Jf2BmYP5dZ8hL
        RCBiKhBGGb3qD+kR6YRyjrb5ZqzZs15kB8WiCjJLtmeLbLBRbJNrd1HOJuAPkKyHq3QDCj21Nrl
        DOPyMSA/NGZsrTuwnPBGyvA==
X-Received: by 2002:a05:6602:2d81:: with SMTP id k1mr10582279iow.90.1610242840887;
        Sat, 09 Jan 2021 17:40:40 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxiXUcJQB4lXNerQgsf1XbHxTycNdizR8B4WJUw/0QV7qNzteCeyovlCFvltXLwwYS30Y6DIg==
X-Received: by 2002:a05:6602:2d81:: with SMTP id k1mr10582273iow.90.1610242840681;
        Sat, 09 Jan 2021 17:40:40 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id 62sm8844048ioc.36.2021.01.09.17.40.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Jan 2021 17:40:40 -0800 (PST)
Subject: Re: [PATCH] fpga: dfl: fme: Constify static attribute_group structs
To:     Rikard Falkeborn <rikard.falkeborn@gmail.com>
Cc:     Wu Hao <hao.wu@intel.com>, Moritz Fischer <mdf@kernel.org>,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210108235414.48017-1-rikard.falkeborn@gmail.com>
 <a1c87050-0962-5169-8ed4-c1da0098ff34@redhat.com> <X/ozuAn64pe71rh+@rikard>
From:   Tom Rix <trix@redhat.com>
Message-ID: <55ca10fc-e52e-af47-609a-edaa65752a38@redhat.com>
Date:   Sat, 9 Jan 2021 17:40:38 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <X/ozuAn64pe71rh+@rikard>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 1/9/21 2:52 PM, Rikard Falkeborn wrote:
> On Sat, Jan 09, 2021 at 01:55:13PM -0800, Tom Rix wrote:
>> On 1/8/21 3:54 PM, Rikard Falkeborn wrote:
>>> The only usage of these is to put their addresses in arrays of pointers
>>> to const attribute_groups. Make them const to allow the compiler to put
>>> them in read-only memory.
>>>
>>> Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
>>> ---
>>>  drivers/fpga/dfl-fme-perf.c | 6 +++---
>> This looks ok.
>>
>> There are other 'static struct's in drivers/fpga.
>>
>> Why is the change limited to this file ?
>>
>> Tom
>>
> I have a WIP coccinelle script to constify static struct attribute_group
> and this is the only file in drivers/fpga which has non-const struct
> attribute_group, that's why it's limited to this file. I could have
> mentioned that in the commit message.

No worries, thanks for the change!

Reviewed-by: Tom Rix <trix@redhat.com>

> Rikard
>
>
>>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/fpga/dfl-fme-perf.c b/drivers/fpga/dfl-fme-perf.c
>>> index 531266287eee..4299145ef347 100644
>>> --- a/drivers/fpga/dfl-fme-perf.c
>>> +++ b/drivers/fpga/dfl-fme-perf.c
>>> @@ -192,7 +192,7 @@ static struct attribute *fme_perf_cpumask_attrs[] = {
>>>  	NULL,
>>>  };
>>>  
>>> -static struct attribute_group fme_perf_cpumask_group = {
>>> +static const struct attribute_group fme_perf_cpumask_group = {
>>>  	.attrs = fme_perf_cpumask_attrs,
>>>  };
>>>  
>>> @@ -225,7 +225,7 @@ static struct attribute *fme_perf_format_attrs[] = {
>>>  	NULL,
>>>  };
>>>  
>>> -static struct attribute_group fme_perf_format_group = {
>>> +static const struct attribute_group fme_perf_format_group = {
>>>  	.name = "format",
>>>  	.attrs = fme_perf_format_attrs,
>>>  };
>>> @@ -239,7 +239,7 @@ static struct attribute *fme_perf_events_attrs_empty[] = {
>>>  	NULL,
>>>  };
>>>  
>>> -static struct attribute_group fme_perf_events_group = {
>>> +static const struct attribute_group fme_perf_events_group = {
>>>  	.name = "events",
>>>  	.attrs = fme_perf_events_attrs_empty,
>>>  };

