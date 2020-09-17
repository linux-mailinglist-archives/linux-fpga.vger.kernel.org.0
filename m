Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E05226DFFE
	for <lists+linux-fpga@lfdr.de>; Thu, 17 Sep 2020 17:47:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728100AbgIQPrp (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 17 Sep 2020 11:47:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:46534 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728127AbgIQPrU (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 17 Sep 2020 11:47:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600357584;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=N9KOqf2leCM1HCqS8l6PF3xaF+XgXaQ2ZP6YRd6k2IA=;
        b=HCNZFaVl03utX1sgvmktQRf2yTyWTUHnP6+Yb19Dz8cBB+aJt3zQzCoXgWm6RjDtg1ydkP
        ayLce3QcYDIlGy+X9d7nEdJnpzLhNJIlP2cMCrqqG/mkbowLDo3u9Mvh7DG9qzjGJvcv2l
        bbhX40IIkcy7jwoJBtgdNN8EJzowWB4=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-515-09gFBss9NVqIY9P4zKZKjw-1; Thu, 17 Sep 2020 11:38:11 -0400
X-MC-Unique: 09gFBss9NVqIY9P4zKZKjw-1
Received: by mail-qk1-f199.google.com with SMTP id 125so1849958qkh.4
        for <linux-fpga@vger.kernel.org>; Thu, 17 Sep 2020 08:38:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=N9KOqf2leCM1HCqS8l6PF3xaF+XgXaQ2ZP6YRd6k2IA=;
        b=XYMyuNlUfDLkB3ZfuLUB5s34J6byCCa5oa9obH16mrsw6Wnw+XEpZ/ewrLr5D9mgHu
         7SNUsxsYwuCUCzHcGPPCDp6gUJr5TumaHKfZfO/abcQce6gtjmMboAW2vd4hB30uvv/J
         5DRsd+tuUMhnHK72LEWPLiMxA/9r1f5ixhyUXH2tN4huy50JlW2trdR3Bixqk5uJ5CGr
         sqfp0jLIHHYZHn0wWWsc+YMZ3MOlOmtrmS8kDzjfM9KXf1kReOmjR1MvPq53s46uV9K0
         MOQE1sbuCaE/E1p7C+mz+k/VIkCoknHpsjPbaIboZFW1YYa39Wa0Cu//k4SmZdvM086Y
         jduQ==
X-Gm-Message-State: AOAM533sKALYA0n0/7H4sFNXfW1Olre8Xzg+8WqvioqLm/tIYpSkz3ur
        MMiUdcU0zCPxK/bJ08pOtAY+BxhFh2ihB2Jff6JInv2ZGwGM2oR21EfxO7i1LKaX70S9Ep4SEMG
        kpGJDrWSwzjLDrfpkc2mfAw==
X-Received: by 2002:ac8:157:: with SMTP id f23mr28290445qtg.273.1600357090651;
        Thu, 17 Sep 2020 08:38:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwotuvBxjhgnWmAskssE8RgDYDiVqT80zp07DmTyUgIxGNyhJebGvW2W/z0r3TL5PijsxnTLA==
X-Received: by 2002:ac8:157:: with SMTP id f23mr28290407qtg.273.1600357090251;
        Thu, 17 Sep 2020 08:38:10 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id z26sm72289qkj.107.2020.09.17.08.38.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Sep 2020 08:38:09 -0700 (PDT)
Subject: Re: RFC improving amount of content in 5.11
To:     Moritz Fischer <mdf@kernel.org>
Cc:     Wu Hao <hao.wu@intel.com>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>
References: <3295710c-5e82-7b97-43de-99b9870a8c8c@redhat.com>
 <20200914211012.GA22855@archbook>
 <0e51e17e-691f-04ef-699a-e0816c216375@redhat.com>
 <20200915213324.GA29697@epycbox.lan>
 <be3844bc-8f5a-6e29-1ecb-debe51739eb0@redhat.com>
 <20200917060150.GA1084338@epycbox.lan>
From:   Tom Rix <trix@redhat.com>
Message-ID: <f2b83192-0d73-d083-6f6c-83d385bae1bb@redhat.com>
Date:   Thu, 17 Sep 2020 08:38:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200917060150.GA1084338@epycbox.lan>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 9/16/20 11:01 PM, Moritz Fischer wrote:
> Tom,
>
> On Wed, Sep 16, 2020 at 08:07:42AM -0700, Tom Rix wrote:
>> On 9/15/20 2:33 PM, Moritz Fischer wrote:
>>> Tom,
>>>
>>> On Tue, Sep 15, 2020 at 01:58:52PM -0700, Tom Rix wrote:
>>>
>>>> A non trival change takes 8 revisions, with about 1 week per revision.
>>> I don't consider that to be out of the norm, especially if you want
>>> multiple people to give feedback on a changeset. This is a result of the
>>> distributed nature of people working across several timezones.
>>>
>>> I generally prefer to go a bit slower and get it right rather than
>>> having to redo or realize we got the interfaces wrong -- some of which
>>> have to stay stable.
>>>
>>>> Gives us 1 or 2 changes per release.
>>>>
>>>> In the easy case, a new card is in the same family, will have 4 new ip blocks
>>>>
>>>> and a change to glue it all together change, 5 patch sets.
>>> So far I haven't seen that happen that many times.
>>>
>>>> So we can handle 1 or 2 cards year.
>>> Again I haven't seen more than that in the past.
>>>> But if we can cut the review down to 2 weeks, we could do maybe 5-10 cards per year.
>>>>
>>>>
>>>> Then the downside if we do not keep up.
>>>>
>>>> every card has a custom out of tree driver available on a limited set of distros.
>>>>
>>>> which i believe is the current state of things.
>>> Tbh, this is easy to fix as vendor by just submitting the code earlier
>>> and in smaller chunks. People can send out RFCs early and then we can
>>> discuss designs and not just show up with 20+ patch series and expect them
>>> to be merged as is (ideally within 2-3 revisions) even more so if they
>>> span several subsystems.
>>>
>>> The kernel never has cared about corporate timelines, and as vendor if
>>> you care about timely hardware support (and want to avoid out-of-tree
>>> nightmares) start early with your upstreaming efforts. That has always
>>> been the case.
>>>
>>>>>> So I was wondering what we can do generally and i can do specifically
>>>>>> to improve this.
>>>>>>
>>>>>> My comment
>>>>>> Though we are a low volume list, anything non trivial takes about 8 revisions.
>>>>>> My suggestion is that we all try to give the developer our big first
>>>>>> pass review within a week of the patch landing and try to cut the
>>>>>> revisions down to 3.
>>>>> It's unfortunate that it takes so long to get things moving, I agree,
>>>>> but with everything that's going on - bear in mind people deal different
>>>>> with situations like the present - it is what it is.
>>>>>
>>>>> My current dayjob doesn't pay me for working on this so the time I dedicate
>>>>> to this comes out of my spare time and weekends - Personally I'd rather
>>>>> not burn out and keep functioning in the long run.
>>>> I understand, in the past i have worked as a maintainer when it was not my day job, it's hard.
>>>>
>>>> I am fortunate, fpga kernel and userspace is my day job.Ã‚Â  Over the last couple of months, i have been
>>>>
>>>> consistently spending a couple hours a day fixing random kernel problems as well as getting linux-fpga
>>>>
>>>> reviews out within a day or two so i know i have the bandwidth to devote.
>>>>
>>>>
>>>> So I am asking what else can I do ?
>>>>
>>>> Would helping out with staging the PR's be help ?
>>> As you pointed out above, the bottleneck is review velocity, I don't
>>> know what staging PRs helps with that.
>>>
>>>> Could i move up to a maintainer ?
>>> The problem is I'd still like to review the patches that go into my
>>> subsystem. I appreciate your help with the reviews, and it's been
>>> helpful so far. I don't think having an addtional maintainer will help
>>> with that at this point.
>> We agree slow reviews are throttling the content in the releases.
>>
>> Is this a temporary situation with your work or is it steady state?
> Tbh, I don't appreciate the tone you're taking with your emails:
>
> Starting a conversation with how disappointed you are is generally not a
> great way to get people on board with anything.
>
> I'll let you know when I need help beyond the reviews, as I already told
> you earlier in the replies to your off-list emails.
>
> I am not generally opposed to the idea of bringing on new maintainers --
> Hao has done a great job for the DFL code so far -- but as of now I do
> not see an immediate benefit (or need) in terms of process to adding more
> FPGA maintainers.
>
>> Are slow reviews the only problem ?
> Since the FPGA pull requests go through Greg's tree they need to be sent
> out earlier than a pull request to Linus, if you send out a patchset
> around rc4 don't expect it to go in in that release if it requires a
> non-trivial amount of review -- if you have patches just send them.
>
>> Which is getting back to my original RFC on how can we improve the amount of content in the releases ?
> Send patches earlier (ideally start with an RFC if you intend larger
> changes) and in smaller batches, which will save you time later in the
> process.

I am sorry, this is difficult i just did not know where to start, i know this is stressful.

My ask for more content is the first step in a bigger ask.

My expectation is that developers should be able to develop first in the kernel.

This a win for everyone, it supports the your call for small changes and rfc's, kills off oot drivers etc.

Having reviewed xilinx and intel dev repos I know we are far far from this.


Thanks for bearing with me,

Tom

>
> - Moritz
>

