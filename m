Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D62C2F1FBD
	for <lists+linux-fpga@lfdr.de>; Mon, 11 Jan 2021 20:48:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726405AbhAKTrh (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 11 Jan 2021 14:47:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25910 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726211AbhAKTrg (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 11 Jan 2021 14:47:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610394369;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f8BUh1IsIX/fGdj6s9C/GYcx62rLqXVVSIaPZHwNOcY=;
        b=MeWag5pazclgd94CI2kN3Xr4I2LLN6f9TYXAx9DRnh1M/5xi97wCXWodijXAmrQVwhtWs7
        Mdqzw+zPFgaWpLB38yIFWnzrgoNLpsud/vcr+Id1p2lHIjCWAnVzKeFVhrk+hNeg0KQ40J
        qSEsrFQ4wZYZuzDSc6Srg4Vm0CXbyg0=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-255-Ycm_xDH-MYiWcZf8jKd0nA-1; Mon, 11 Jan 2021 14:46:07 -0500
X-MC-Unique: Ycm_xDH-MYiWcZf8jKd0nA-1
Received: by mail-io1-f71.google.com with SMTP id r16so393039ioa.1
        for <linux-fpga@vger.kernel.org>; Mon, 11 Jan 2021 11:46:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=f8BUh1IsIX/fGdj6s9C/GYcx62rLqXVVSIaPZHwNOcY=;
        b=rGgJfC6NfLpauMgTcCqrStvjEX84ttN35T7dRz8zzhwzPXB+P8p4sgMe/VtjnJIaC+
         Uhftx/WNfnnG0QpkHoK53KwLioA8eGJYHmcIXqabPKzl9Y4grJ5Rct5Qw1MIVh1C+UnF
         eo3OQEkLul2qanmlQ5K7Zhrc04XIbTsPIdikLhOGkUWxkbw2jGsmvjM+DRQ5gIHg22Xr
         IdGq+SWCVyrWpKOsxFCoC5AneinD3eCqgWjUZNU2br0dNMrstW+Bfaez+aEfkMmoiHpR
         aZoyzajG6SeGUe+bh9TgJQh75Mw+djapjYyqG2f2IBaBFOtWsKqapL9aQmZA7FfNJsrJ
         yxXQ==
X-Gm-Message-State: AOAM531X3Ro2pEa2zoJVUeztfKiUmDIEUWG2/jVpMNlJBU4VNQx5Ird7
        xV06S5eU5yxXn5TkQnCcjjK5+y+gQL3rP/K0oarZvkUAUIkcPNjR2qb2nKXo09rWc65BIYoieV5
        TO06uZkhjmdqhI5iKk6rUBg==
X-Received: by 2002:a92:c890:: with SMTP id w16mr716007ilo.188.1610394367203;
        Mon, 11 Jan 2021 11:46:07 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxK7o+iDICf6O6KjZqqD7KVlQd1aSbIDv+QUS1ipPtSheD4Un0rGtC1nyiJZWfzOf2a0AJl3A==
X-Received: by 2002:a92:c890:: with SMTP id w16mr715991ilo.188.1610394367004;
        Mon, 11 Jan 2021 11:46:07 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id s12sm399797ilp.66.2021.01.11.11.46.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Jan 2021 11:46:06 -0800 (PST)
Subject: Re: [PATCH 0/8] FPGA DFL Changes for 5.12
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Moritz Fischer <mdf@kernel.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        linux-kernel@vger.kernel.org, moritzf@google.com,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Zheng Yongjun <zhengyongjun3@huawei.com>,
        Russ Weight <russell.h.weight@intel.com>,
        "Gerlach, Matthew" <matthew.gerlach@intel.com>,
        Sonal Santan <sonal.santan@xilinx.com>,
        Xu Yilun <yilun.xu@intel.com>,
        Richard Gong <richard.gong@intel.com>
References: <80b29715-aa0a-b2ac-03af-904fc8f8be98@redhat.com>
 <e1d30642-ce85-b9b7-e8b2-5ad4fe6338e5@redhat.com> <X/sz6lDq8WFzrRUJ@archbook>
 <95af46d6-d123-f610-2f21-6d6de6f248e9@redhat.com>
 <X/v2xs5Rnfw9F18E@kroah.com>
 <9bc01a73-726f-a979-1246-6ea048961670@redhat.com>
 <X/xmi/jJmDHnV5/N@kroah.com>
 <7923d9dc-c503-5318-6e4f-931f8c13c1be@redhat.com>
 <X/x4QjGyP8ssYUDI@kroah.com>
 <fe9739cf-abc9-c0c6-933e-8447a9d197a8@redhat.com>
 <X/yXOFYnQcA1MsUd@kroah.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <dccc8075-b900-8680-3620-8050475858a7@redhat.com>
Date:   Mon, 11 Jan 2021 11:46:03 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <X/yXOFYnQcA1MsUd@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 1/11/21 10:21 AM, Greg KH wrote:
> On Mon, Jan 11, 2021 at 08:43:15AM -0800, Tom Rix wrote:
>> On 1/11/21 8:09 AM, Greg KH wrote:
>>> On Mon, Jan 11, 2021 at 07:55:24AM -0800, Tom Rix wrote:
>>>> On 1/11/21 6:54 AM, Greg KH wrote:
>>>>> On Mon, Jan 11, 2021 at 06:40:24AM -0800, Tom Rix wrote:
>>>>>> On 1/10/21 10:57 PM, Greg KH wrote:
>>>>>>> On Sun, Jan 10, 2021 at 11:43:54AM -0800, Tom Rix wrote:
>>>>>>>> On 1/10/21 9:05 AM, Moritz Fischer wrote:
>>>>>>>>> Tom,
>>>>>>>>>
>>>>>>>>> On Sun, Jan 10, 2021 at 07:46:29AM -0800, Tom Rix wrote:
>>>>>>>>>> On 1/7/21 8:09 AM, Tom Rix wrote:
>>>>>>>>>>> On 1/6/21 8:37 PM, Moritz Fischer wrote:
>>>>>>>>>>>> This is a resend of the previous (unfortunately late) patchset of
>>>>>>>>>>>> changes for FPGA DFL.
>>>>>>>>>>> Is there something I can do to help ?
>>>>>>>>>>>
>>>>>>>>>>> I am paid to look after linux-fpga, so i have plenty of time.
>>>>>>>>>>>
>>>>>>>>>>> Some ideas of what i am doing now privately i can do publicly.
>>>>>>>>>>>
>>>>>>>>>>> 1. keep linux-fpga sync-ed to greg's branch so linux-fpga is normally in a pullable state.
>>>>>>>>> Is it not? It currently points to v5.11-rc1. If I start applying patches
>>>>>>>>> that require the changes that went into Greg's branch I can merge.
>>>>>>>> I mean the window between when we have staged patches and when they go into Greg's branch.
>>>>>>>>
>>>>>>>> We don't have any now, maybe those two trival ones.
>>>>>>>>
>>>>>>>> Since Greg's branch moves much faster than ours, our staging branch needs to be rebased regularly until its merge.
>>>>>>> Ick, no!  NEVER rebase a public branch.  Why does it matter the speed of
>>>>>>> my branch vs. anyone elses?  Git handles merges very well.
>>>>>>>
>>>>>>> Just like Linus's branches move much faster than mine, and I don't
>>>>>>> rebase my branches, you shouldn't rebase yours.
>>>>>>>
>>>>>>> Becides, I'm only taking _PATCHES_ for fpga changes at the moment, no
>>>>>>> git pulls, so why does it matter at all for any of this?
>>>>>>>
>>>>>>> What is the problem you are trying to solve here?
>>>>>> This 5.12 fpga patchset not making it into 5.11.
>>>>> Ok, but isn't it the responsibility of the submitter to make sure they
>>>>> apply properly when sending them out?
>>>>>
>>>>>> At some point before the 5.11 window, I tried it on next and it failed to merge.
>>>>>>
>>>>>> This points to needing some c/i so it does not happen again.
>>>>> "again"?  Merges and the like are a totally normal thing and happen all
>>>>> the time, I still fail to understand what you are trying to "solve" for
>>>>> here...
>>>> What can I do to help make your merges as easy as possible ?
>>> I have not had any problems with merges, I've only had "problems"
>>> rejecting patches for their content.
>>>
>>> Try helping out with patch reviews if you want, finding and fixing
>>> things before I review them is usually a good idea :)
>> ok.
>>>> Does the patchwork infra Moritz was speaking of earlier need fixing help?
>>> No idea, I don't use it.
>>>
>>>> Any other things ?
>>> What problems are you trying to solve here?  What's wrong with how this
>>> subsystem is working that you are feeling needs to be addressed?
>> I do not believe the issue I raised in 5.10 has made any progress.
> What issue?
>
>> If you look at the content in 5.11 we have actually regressed.
> What bugs regressed?
>
>> https://lore.kernel.org/linux-fpga/3295710c-5e82-7b97-43de-99b9870a8c8c@redhat.com/
> I don't see the problem here, other than a low-quality of patches that
> need reworking for some patchsets, and others are just fine.  Just like
> all kernel subsystems, I don't see anything odd here.
>
>> Over the last two releases, I have shown i have the time and interest to maintain this subsystem.
> That's not how any of this works :)
>
>> So I am asking for
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 11b38acb4c08..269cd08f4969 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -6951,7 +6951,7 @@ F:        drivers/net/ethernet/nvidia/*
>>  
>>  FPGA DFL DRIVERS
>>  M:     Wu Hao <hao.wu@intel.com>
>> -R:     Tom Rix <trix@redhat.com>
>> +M:     Tom Rix <trix@redhat.com>
> That's generous, but how about doing review first, the maintainership of
> this subsystem does not feel like any sort of bottleneck to me.  I
> personally have no problems with Moritz's interactions with the
> community, his reviewing of patches, and forwarding on to me.
>
> Of course we all have delays as we have other work to do than just this,
> that's just part of normal development.  I don't see anything stalled at
> the moment, nor anything that having another maintainer would have
> helped out with at all, so this feels like it is not needed from my end.
>
> Again, it feels like the developers need more reviews, and good ones, so
> please continue to help out with that, as that's the best thing I can
> see to do here.

I have been doing the first review in a couple of days after every patch landing.

I see some pretty good response from the developers to fix the issues raised. 

But I do not see Moritz picking up the review until weeks later.

This consistent delay in timely reviews is a bottleneck.

It would be good if the big first reviews could be done in parallel.

Tom

>
> thanks,
>
> greg k-h
>

