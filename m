Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1C2D26C5DB
	for <lists+linux-fpga@lfdr.de>; Wed, 16 Sep 2020 19:22:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbgIPRVi (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 16 Sep 2020 13:21:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31936 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726682AbgIPRV1 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 16 Sep 2020 13:21:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600276864;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HzLLHZVSV72vvlADhNXOViL8Ty89JaFD8mYPv4rGjzc=;
        b=OQbkQFhlWSrnqtM/wD0/7BsMEOIqS0akns6av89DFSUoaQEsk6N8aka511cE45GfH2RKyX
        p5lLneM41T2VJXFLAHpWtV4hzIcLVTAE+RYTxWblZg6ACmNHQwYGhYeArPIzuawdm84Lc+
        N11qbCfsbu3lerris6zV4EPRyLrcYwk=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-398-nBve9nL7MZC9sUtYln6i1Q-1; Wed, 16 Sep 2020 11:07:45 -0400
X-MC-Unique: nBve9nL7MZC9sUtYln6i1Q-1
Received: by mail-qt1-f200.google.com with SMTP id a14so6228138qtp.15
        for <linux-fpga@vger.kernel.org>; Wed, 16 Sep 2020 08:07:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=HzLLHZVSV72vvlADhNXOViL8Ty89JaFD8mYPv4rGjzc=;
        b=qUhA1RWtTMYdXKvg5Tb3D0Z4THp3Ztlo1ScTGYeW7yXzEiMU6e4xWs6WLszCBNltLZ
         8GGI3TEqrL7BZIRbLzWST+fCFUoSpF75xab3fl6ljg5I76e9T2YUcnYokhm5lJSCmug9
         cPy+u//MynzWedc6QU+NWX1RxmJsCX3RGMELCNButnJU8ztGmjgzNmo0XZ41Ays7mWPK
         etlX/JLVhGkSt6zCzAaGNgh5Z/2/OnISwAp/OB4/hwY69/n/a+si9do1faYlEZJvXdB2
         QDM3fijJpedR51B9cq/iycbVg0/HDnMoPnsYRnaS1ct597NTUF0epGiB0PtAWY9iqpUx
         SXPg==
X-Gm-Message-State: AOAM530xpPalv2CSQnVih23FBGNW+Cm9MmcIL3AIxaWyu9R/XW4DW4Qq
        el2qjy0roPW5UBFi6DdiD8CteCAAnxcopXUTLGw0GFPhNAQ+7T5xTIvaVfujvWasbK9NZd4/wvG
        GBPwSEL4jyt+I8UOREu2V7Q==
X-Received: by 2002:a05:6214:d6b:: with SMTP id 11mr23678203qvs.30.1600268865068;
        Wed, 16 Sep 2020 08:07:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyWN21X4CZRf9yrgu+X9BdFXtX9aNaENXZ2/bUqmRnZusfMO04Dp9KE9mH9QVWJlW4GBay9Ew==
X-Received: by 2002:a05:6214:d6b:: with SMTP id 11mr23678157qvs.30.1600268864680;
        Wed, 16 Sep 2020 08:07:44 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id i5sm19573735qko.86.2020.09.16.08.07.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Sep 2020 08:07:44 -0700 (PDT)
Subject: Re: RFC improving amount of content in 5.11
To:     Moritz Fischer <mdf@kernel.org>
Cc:     Wu Hao <hao.wu@intel.com>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>
References: <3295710c-5e82-7b97-43de-99b9870a8c8c@redhat.com>
 <20200914211012.GA22855@archbook>
 <0e51e17e-691f-04ef-699a-e0816c216375@redhat.com>
 <20200915213324.GA29697@epycbox.lan>
From:   Tom Rix <trix@redhat.com>
Message-ID: <be3844bc-8f5a-6e29-1ecb-debe51739eb0@redhat.com>
Date:   Wed, 16 Sep 2020 08:07:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200915213324.GA29697@epycbox.lan>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 9/15/20 2:33 PM, Moritz Fischer wrote:
> Tom,
>
> On Tue, Sep 15, 2020 at 01:58:52PM -0700, Tom Rix wrote:
>
>> A non trival change takes 8 revisions, with about 1 week per revision.
> I don't consider that to be out of the norm, especially if you want
> multiple people to give feedback on a changeset. This is a result of the
> distributed nature of people working across several timezones.
>
> I generally prefer to go a bit slower and get it right rather than
> having to redo or realize we got the interfaces wrong -- some of which
> have to stay stable.
>
>> Gives us 1 or 2 changes per release.
>>
>> In the easy case, a new card is in the same family, will have 4 new ip blocks
>>
>> and a change to glue it all together change, 5 patch sets.
> So far I haven't seen that happen that many times.
>
>> So we can handle 1 or 2 cards year.
> Again I haven't seen more than that in the past.
>> But if we can cut the review down to 2 weeks, we could do maybe 5-10 cards per year.
>>
>>
>> Then the downside if we do not keep up.
>>
>> every card has a custom out of tree driver available on a limited set of distros.
>>
>> which i believe is the current state of things.
> Tbh, this is easy to fix as vendor by just submitting the code earlier
> and in smaller chunks. People can send out RFCs early and then we can
> discuss designs and not just show up with 20+ patch series and expect them
> to be merged as is (ideally within 2-3 revisions) even more so if they
> span several subsystems.
>
> The kernel never has cared about corporate timelines, and as vendor if
> you care about timely hardware support (and want to avoid out-of-tree
> nightmares) start early with your upstreaming efforts. That has always
> been the case.
>
>>>> So I was wondering what we can do generally and i can do specifically
>>>> to improve this.
>>>>
>>>> My comment
>>>> Though we are a low volume list, anything non trivial takes about 8 revisions.
>>>> My suggestion is that we all try to give the developer our big first
>>>> pass review within a week of the patch landing and try to cut the
>>>> revisions down to 3.
>>> It's unfortunate that it takes so long to get things moving, I agree,
>>> but with everything that's going on - bear in mind people deal different
>>> with situations like the present - it is what it is.
>>>
>>> My current dayjob doesn't pay me for working on this so the time I dedicate
>>> to this comes out of my spare time and weekends - Personally I'd rather
>>> not burn out and keep functioning in the long run.
>> I understand, in the past i have worked as a maintainer when it was not my day job, it's hard.
>>
>> I am fortunate, fpga kernel and userspace is my day job.Ã‚Â  Over the last couple of months, i have been
>>
>> consistently spending a couple hours a day fixing random kernel problems as well as getting linux-fpga
>>
>> reviews out within a day or two so i know i have the bandwidth to devote.
>>
>>
>> So I am asking what else can I do ?
>>
>> Would helping out with staging the PR's be help ?
> As you pointed out above, the bottleneck is review velocity, I don't
> know what staging PRs helps with that.
>
>> Could i move up to a maintainer ?
> The problem is I'd still like to review the patches that go into my
> subsystem. I appreciate your help with the reviews, and it's been
> helpful so far. I don't think having an addtional maintainer will help
> with that at this point.

We agree slow reviews are throttling the content in the releases.

Is this a temporary situation with your work or is it steady state?


Are slow reviews the only problem ?

Which is getting back to my original RFC on how can we improve the amount of content in the releases ?

Tom

>
> - Moritz
>

