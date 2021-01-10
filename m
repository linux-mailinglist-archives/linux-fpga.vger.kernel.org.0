Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 221BF2F0962
	for <lists+linux-fpga@lfdr.de>; Sun, 10 Jan 2021 20:47:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726263AbhAJTpa (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 10 Jan 2021 14:45:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:27784 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726267AbhAJTp3 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Sun, 10 Jan 2021 14:45:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610307842;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f1dYfoWP3G2nAzxG7PaOeZ2GC7vIthKJOgs5Vk0jAI8=;
        b=OfdzqluUU9BMorKOznIuMrM2jFzLJRn21ROQ4IR/Fp4cHsmNVBejhYwKOClf3I+wNP2fyT
        /DEQjEBw7DzhrjJ291Gj/mO5nrDa1eaSfwyBE2UdXz9Tvy6Q6RF0mTSG+sihVN17IzarBq
        3JyW0mJ1Cvt2vvqiAJ0PaG/eXZu83vQ=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-332-_AEcTsL2M0KqTYk6oM8rXA-1; Sun, 10 Jan 2021 14:43:59 -0500
X-MC-Unique: _AEcTsL2M0KqTYk6oM8rXA-1
Received: by mail-io1-f70.google.com with SMTP id q21so11167102ios.14
        for <linux-fpga@vger.kernel.org>; Sun, 10 Jan 2021 11:43:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=f1dYfoWP3G2nAzxG7PaOeZ2GC7vIthKJOgs5Vk0jAI8=;
        b=KwustwBp1Se4LXnLTVxCkJuZ6J6T5RJIBubfplCoCyY3ysA1koW/IHEVuxwRe/u61w
         KRqaQsIYWQEJPek8OQxUNh2pVfgQj8CYsMGwYsHq68nkotSFW771drMGIQh9ASG7gUkN
         OHfsCAyw9StUb794E81LoC15Sl9U9vuJ7LY4lGHr0stTs/nVeN4dPcgoZ6QZ/bnXdkCe
         kS0I8wUBQmjWKqvv1bqYJbq9e0oUIYAgYjgsB0ZUGlg3twlI9FT8Dv9j586qMBXv+YT2
         BrIlLvq1hA54wMaDQjJCBBQnGrxD/g2pQNeExv3pfrLQATsB2cjqWx5HukRiGVx3uFmO
         CRYA==
X-Gm-Message-State: AOAM5316urI2oopNwWfjIsz+OhkPZYkt2CXvWPgDQzTVF2kp2+n84mkN
        fjdPBSaw8Re7+a+rswfMi/djdWS61AK8AbUJHv9WxBQh/H0ORFLNN1hRjCXrIVfWOs2MGw99AaM
        C/I3OrN7/+EWlASeuk79/Lg==
X-Received: by 2002:a92:418d:: with SMTP id o135mr13296757ila.213.1610307838405;
        Sun, 10 Jan 2021 11:43:58 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwtrhrsF/kYCnIjUyqnRA4Oe36UpBrov9xC91eYfAlLOBBdxkH7wwiDRRctSnShZLYmp/aKag==
X-Received: by 2002:a92:418d:: with SMTP id o135mr13296744ila.213.1610307838181;
        Sun, 10 Jan 2021 11:43:58 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id 17sm7030271ilt.15.2021.01.10.11.43.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Jan 2021 11:43:57 -0800 (PST)
Subject: Re: [PATCH 0/8] FPGA DFL Changes for 5.12
To:     Moritz Fischer <mdf@kernel.org>
Cc:     gregkh@linuxfoundation.org,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        linux-kernel@vger.kernel.org, moritzf@google.com,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Zheng Yongjun <zhengyongjun3@huawei.com>,
        Russ Weight <russell.h.weight@intel.com>,
        "Gerlach, Matthew" <matthew.gerlach@intel.com>,
        Sonal Santan <sonal.santan@xilinx.com>,
        Xu Yilun <yilun.xu@intel.com>,
        Richard Gong <richard.gong@intel.com>
References: <20210107043714.991646-1-mdf@kernel.org>
 <80b29715-aa0a-b2ac-03af-904fc8f8be98@redhat.com>
 <e1d30642-ce85-b9b7-e8b2-5ad4fe6338e5@redhat.com> <X/sz6lDq8WFzrRUJ@archbook>
From:   Tom Rix <trix@redhat.com>
Message-ID: <95af46d6-d123-f610-2f21-6d6de6f248e9@redhat.com>
Date:   Sun, 10 Jan 2021 11:43:54 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <X/sz6lDq8WFzrRUJ@archbook>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 1/10/21 9:05 AM, Moritz Fischer wrote:
> Tom,
>
> On Sun, Jan 10, 2021 at 07:46:29AM -0800, Tom Rix wrote:
>> On 1/7/21 8:09 AM, Tom Rix wrote:
>>> On 1/6/21 8:37 PM, Moritz Fischer wrote:
>>>> This is a resend of the previous (unfortunately late) patchset of
>>>> changes for FPGA DFL.
>>> Is there something I can do to help ?
>>>
>>> I am paid to look after linux-fpga, so i have plenty of time.
>>>
>>> Some ideas of what i am doing now privately i can do publicly.
>>>
>>> 1. keep linux-fpga sync-ed to greg's branch so linux-fpga is normally in a pullable state.
> Is it not? It currently points to v5.11-rc1. If I start applying patches
> that require the changes that went into Greg's branch I can merge.

I mean the window between when we have staged patches and when they go into Greg's branch.

We don't have any now, maybe those two trival ones.

Since Greg's branch moves much faster than ours, our staging branch needs to be rebased regularly until its merge.

There are no outstanding fixes so all changes would go to -next.

>>> 2. an in-flight dev branch for the outstanding patches 
>> I have setup these branches based on Greg's char-misc-next
>>
>> fpga-next, which is char-misc-next base for fpga-testing
>>
>> fpga-testing, all the in-flight patches that would apply with automatic merge conflict resolution
>>
>> These are respectively
>>
>> https://github.com/trixirt/linux-fpga/tree/fpga-next
>>
>> https://github.com/trixirt/linux-fpga/tree/fpga-testing
> Feel free to have your own repos/branches etc, but I'd like to keep the
> offical trees on kernel.org.
Is there a way for me to move these to kernel.org ?
>
> Tbh I'd much rather see the patchwork instance be cleaned up if you want
> to do stuff.
Please point me at the wreckage and I will clean it up.
>>
>> There are two trivial changes, that could go to 5.12 now.
>>
>> fpga: dfl: fme: Constify static attribute_group structs
>>
>> fpga: Use DEFINE_SPINLOCK() for spinlock
>>
>> respectively
>>
>> https://lore.kernel.org/linux-fpga/20210108235414.48017-1-rikard.falkeborn@gmail.com/
>>
>> https://lore.kernel.org/linux-fpga/20201228135135.28788-1-zhengyongjun3@huawei.com/
> I was going to pick them up monday ...
>>
>> There are a couple of patchsets that conflict
>>
>> https://lore.kernel.org/linux-fpga/20210105230855.15019-7-russell.h.weight@intel.com/
>>
>> https://lore.kernel.org/linux-fpga/20201203171548.1538178-3-matthew.gerlach@linux.intel.com/
> Conflict between what and what?

There are basic git am ... applying problems.

By having a -testing branch it is easier to see where the conficts with all the outstanding patchsets.

>  
>> And the xilinx patchset
>>
>> https://lore.kernel.org/linux-fpga/20201217075046.28553-1-sonals@xilinx.com/
>>
>> Which is being split/worked on offline.
> I'm not sure what that means.

Don't worry about this until a new patchset lands.

Tom

>>
>> If I have missed any patchset, poke me.
>>
>> Tom
> - Moritz
>

