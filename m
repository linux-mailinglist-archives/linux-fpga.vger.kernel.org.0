Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42E7626AF0B
	for <lists+linux-fpga@lfdr.de>; Tue, 15 Sep 2020 23:00:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728009AbgIOU7t (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 15 Sep 2020 16:59:49 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:50330 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728013AbgIOU7E (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 15 Sep 2020 16:59:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600203537;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I0aDUxBLFKv9E20TqWjOT54E53N5hHeWOp6ztaYdO9w=;
        b=W1ah5UClV6ICo/Dl2ag2f3MuW2Qk+XAaWJC6zM+25NYdX3qK/oOYyFsbwVmlRDyjVugRYL
        jPHyr0CZYE61zw/2Cy/L8WVm2stvlL6nYKK1ZbVsWHr2nvyzCHuHDlfrzvBm3CCnvRLirG
        kUdwKO0YHHpUAnU1Bz4VHv4ape7Yyug=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-582-WgR4CDWhMymQsDa21Ehs0A-1; Tue, 15 Sep 2020 16:58:55 -0400
X-MC-Unique: WgR4CDWhMymQsDa21Ehs0A-1
Received: by mail-qt1-f200.google.com with SMTP id m13so3946334qtu.10
        for <linux-fpga@vger.kernel.org>; Tue, 15 Sep 2020 13:58:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=I0aDUxBLFKv9E20TqWjOT54E53N5hHeWOp6ztaYdO9w=;
        b=kq5HmSmrnVdgDOW6SFd0k+qe/nx6+Y/3EHudksVZLy/vTHrJ8N7NV+L7ocvtzz7knU
         HqRW98RLdYddg6NOQTufDJLysp5z+FkHZBOCKxC7pKhDm6n4QvRMd+GLLXJ1wbNlPJjK
         n426iW92CsyItZfGT+YxtTtpuTkiMZ4OyNLf+Ckfpi/Yixpyd5sXqT+vPru/rGD2gvcy
         r/JlSMsOxxXloc1PBBgCvuP3rnsyWfDCd6pRQnL6T3r5nzwkFG4Ff8GclyrZHFuJ63SY
         PryVJVGJwVcTdsj2svYf62GRyJwBb/7kYFuizWIYY0UPwvv9yklJ5JWSdV+Efy9e0qT+
         Y/BQ==
X-Gm-Message-State: AOAM530F5gLxzBz2jp3ppXXuYvcqlDZpmLlkD+lnTYzBCH2rnjNzO2qY
        UlORRvN73lqqlOrwhgdi9ejOKyHTHdf+5f+5zbwtc6g0d40onlcXcfV+007LSHXmbuSpY9/Ynwm
        y1/8DbB7eWZUlZLu6uZJvGw==
X-Received: by 2002:ac8:376d:: with SMTP id p42mr7532909qtb.288.1600203535140;
        Tue, 15 Sep 2020 13:58:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyoUWBwILfcbq44b/NzgBu4vV3Odm37q08bGQlQCVDiqSd2mi2OGjRLlXKv/r/C1L5nVphYJA==
X-Received: by 2002:ac8:376d:: with SMTP id p42mr7532893qtb.288.1600203534855;
        Tue, 15 Sep 2020 13:58:54 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id 18sm17686150qkd.120.2020.09.15.13.58.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Sep 2020 13:58:54 -0700 (PDT)
Subject: Re: RFC improving amount of content in 5.11
To:     Moritz Fischer <mdf@kernel.org>
Cc:     Wu Hao <hao.wu@intel.com>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>
References: <3295710c-5e82-7b97-43de-99b9870a8c8c@redhat.com>
 <20200914211012.GA22855@archbook>
From:   Tom Rix <trix@redhat.com>
Message-ID: <0e51e17e-691f-04ef-699a-e0816c216375@redhat.com>
Date:   Tue, 15 Sep 2020 13:58:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200914211012.GA22855@archbook>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 9/14/20 2:10 PM, Moritz Fischer wrote:
> Hi Tom,
>
> On Mon, Sep 14, 2020 at 01:29:47PM -0700, Tom Rix wrote:
>> I am disappointed with how little content is making it into 5.10
> One comment I've gotten from Greg in the past is to not hold on to
> patches so long, so the pull request this weekend was me trying to a
> first set of changes out there. This doesn't mean it has to be the only
> content that goes into 5.10 (Note how the pull request said: "First set
> of changes for the 5.10 merge window").


Let me try to explain why I am asking for input on how to improve the amount of content.

The rough planning i do in my head.  A release is about 2-3 months.

A non trival change takes 8 revisions, with about 1 week per revision.

Gives us 1 or 2 changes per release.

In the easy case, a new card is in the same family, will have 4 new ip blocks

and a change to glue it all together change, 5 patch sets.

So we can handle 1 or 2 cards year.

But if we can cut the review down to 2 weeks, we could do maybe 5-10 cards per year.


Then the downside if we do not keep up.

every card has a custom out of tree driver available on a limited set of distros.

which i believe is the current state of things.


>
>> So I was wondering what we can do generally and i can do specifically
>> to improve this.
>>
>> My comment
>> Though we are a low volume list, anything non trivial takes about 8 revisions.
>> My suggestion is that we all try to give the developer our big first
>> pass review within a week of the patch landing and try to cut the
>> revisions down to 3.
> It's unfortunate that it takes so long to get things moving, I agree,
> but with everything that's going on - bear in mind people deal different
> with situations like the present - it is what it is.
>
> My current dayjob doesn't pay me for working on this so the time I dedicate
> to this comes out of my spare time and weekends - Personally I'd rather
> not burn out and keep functioning in the long run.

I understand, in the past i have worked as a maintainer when it was not my day job, it's hard.

I am fortunate, fpga kernel and userspace is my day job.  Over the last couple of months, i have been

consistently spending a couple hours a day fixing random kernel problems as well as getting linux-fpga

reviews out within a day or two so i know i have the bandwidth to devote.


So I am asking what else can I do ?

Would helping out with staging the PR's be help ?

Could i move up to a maintainer ?

Tom

> Thanks,
> Moritz
>

