Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A40040C9D6
	for <lists+linux-fpga@lfdr.de>; Wed, 15 Sep 2021 18:12:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbhIOQOP (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 15 Sep 2021 12:14:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52646 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229465AbhIOQOP (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 15 Sep 2021 12:14:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631722375;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=10lNI8B2ykcDlT6iGlVrYhDzSdCOksGH1lUgb477+0A=;
        b=icQEGzeYJXUSV+6O0OmnPHHYfLPyE2LceOzOcT+E15nbPX+K+g4TMVLOndH4VJ0/KKKjJF
        eGJvzuqA2HPyozN29YjMH+0CDZHDjGjG9r4wlMDyJGKQtBLyXl3QiLm+3W2nj6jvmS6tas
        HqzFwsmv1mFdaFmKR+8NBjEZjGqAS4k=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-293-pgO44wK4NXOpyqSRrONOgQ-1; Wed, 15 Sep 2021 12:12:54 -0400
X-MC-Unique: pgO44wK4NXOpyqSRrONOgQ-1
Received: by mail-qv1-f72.google.com with SMTP id v1-20020a0cc1c1000000b0037c671dbf1cso5125755qvh.12
        for <linux-fpga@vger.kernel.org>; Wed, 15 Sep 2021 09:12:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=10lNI8B2ykcDlT6iGlVrYhDzSdCOksGH1lUgb477+0A=;
        b=RtDeE+z3mOBjp+yfcdZxLaiQ/GEUO6AGckZwHUvyPTUBn4HjwHbLIo8/s2Cmm2vJdk
         SCNjn1LKQvNUZsETgwWkNgyNNJ6yA2E1Ej9GmPxJRmbfJqOSyEy/gHnqMHMzC/V6iaea
         N+RvhTbSYGj6V2pdE1PE9YT7EqbyuMBnqzm1YUpR52sxHo8A18MTS0+70FYKZbAfaObk
         7f6+nz5AK7CrjscUILbe8V3qdKzLLuMUkfq2tgy90O8dZp2CTOxf7JNmDW1PfwAdzAbW
         iWeJY03d+jGlV7MHtELpxJLWEvNR60++42zhHlSRwYvHhPIK65BiW9J9+jU2vhP9qI+9
         DghQ==
X-Gm-Message-State: AOAM532Sl4diDMFcxdKgz0gfG9ZgE1/SLgs+v7XRqT+36/2VFtle7Bu2
        JtDWbDin8jg9tdv3yfFGHniK0zYiI84YcRrjFCmcF9WSxksrvQZA9ssrliYBeIhoX5IfKjQiWhn
        Zq1f+A/WAjVxYxqWthMs25hUYfQzPDWXFARXmBrNrA2O4dzmV2KMGj/bqM3aKIilFX/T3
X-Received: by 2002:ac8:704f:: with SMTP id y15mr592908qtm.305.1631722373820;
        Wed, 15 Sep 2021 09:12:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzHHlvO3QXFRgdxMrY3PtT9ECasFVAhJ46tRea2+JbQye0iHKQ0fXOMH8y+xqEtBuDRoWxkRQ==
X-Received: by 2002:ac8:704f:: with SMTP id y15mr592873qtm.305.1631722373529;
        Wed, 15 Sep 2021 09:12:53 -0700 (PDT)
Received: from localhost.localdomain (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id q7sm304277qkm.68.2021.09.15.09.12.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Sep 2021 09:12:53 -0700 (PDT)
Subject: Re: [PATCH] MAINTAINERS: Add Tom Rix as fpga maintainer
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     mdf@kernel.org, hao.wu@intel.com, linux-kernel@vger.kernel.org,
        linux-fpga@vger.kernel.org
References: <20210914182333.3903389-1-trix@redhat.com>
 <YUDw0gvgdijpytfU@kroah.com>
 <25d1dac2-4f9f-b5f0-8ce8-b88442deac9d@redhat.com>
 <YUH9dg01Mtk+kO+C@kroah.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <c0630361-69cf-992a-78bf-a1c8335acd28@redhat.com>
Date:   Wed, 15 Sep 2021 09:12:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YUH9dg01Mtk+kO+C@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 9/15/21 7:04 AM, Greg KH wrote:
> On Wed, Sep 15, 2021 at 06:23:16AM -0700, Tom Rix wrote:
>> On 9/14/21 11:58 AM, Greg KH wrote:
>>> [note, you got the maintainer's email address wrong on your cc: line
>>>    I fixed it up...]
>>>
>>> On Tue, Sep 14, 2021 at 11:23:33AM -0700, trix@redhat.com wrote:
>>>> From: Tom Rix <trix@redhat.com>
>>>>
>>>> I am the maintainer of the fpga/ subsystem for both the kernel and
>>>> userspace for Red Hat.  I have been an active reviewer and contributor
>>>> on for public fpga/ subsystem for the last year.  I would like to
>>>> help out more.
>>>>
>>>> Since I am paid to do this work, change the status to Supported.
>>>>
>>>> Signed-off-by: Tom Rix <trix@redhat.com>
>>>> ---
>>>>    MAINTAINERS | 4 ++--
>>>>    1 file changed, 2 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>>> index 04fa4edf100b83..0443d7ab826659 100644
>>>> --- a/MAINTAINERS
>>>> +++ b/MAINTAINERS
>>>> @@ -7353,9 +7353,9 @@ F:	include/uapi/linux/fpga-dfl.h
>>>>    FPGA MANAGER FRAMEWORK
>>>>    M:	Moritz Fischer <mdf@kernel.org>
>>>> -R:	Tom Rix <trix@redhat.com>
>>>> +M:	Tom Rix <trix@redhat.com>
>>>>    L:	linux-fpga@vger.kernel.org
>>>> -S:	Maintained
>>>> +S:	Supported
>>>>    W:	http://www.rocketboards.org
>>>>    Q:	http://patchwork.kernel.org/project/linux-fpga/list/
>>>>    T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mdf/linux-fpga.git
>>>> -- 
>>>> 2.26.3
>>>>
>>> Traditionally existing maintainers are the ones that add new
>>> maintainers, it's not something that you just submit a patch for hoping
>>> it will be accepted.
>>>
>>> What has changed since the last time you asked to do this?
>> Because public and private requests have gone unanswered for so long, it is
>> unclear if Moritz is still maintaining the subsystem.
> He is, as is evident by the patches I accept from him each merge.
>
>> The nearly year old xrt patchset has been pending for 6 weeks with minor
>> changes to one patch out of 14 needing reviews.
> Code quality is not the maintainer's job, it's the developer's, so the
> age and number of reviews is not any indication.

https://lore.kernel.org/linux-fpga/20210802160521.331031-1-lizhi.hou@xilinx.com/

The review is needed because Moritz asked for the changes v8 here

https://lore.kernel.org/linux-fpga/YP42zE2ljx4hHj40@epycbox.lan/

When the maintainer asks for the changes, they are responsible for the 
followup.

>> The standard release patchset, which needs an opinion has on an api change,
>> has been outstanding for 8 weeks.
> Have a pointer to it?

This was a change you requested. the recent patchset is

https://lore.kernel.org/linux-fpga/20210914214327.94048-4-russell.h.weight@intel.com/

The discussion around the api change is

https://lore.kernel.org/linux-fpga/661d53d0-0ba4-d344-8da0-995a9b612905@redhat.com/

In these toss up's if the maintainer does not weigh in as the tie 
breaker, the patch stalls.

>
>> If maintainership depends on an approving maintainter, what happens when the
>> approving maintainer has left ?
> Vacations happen in the summer.  I've talked to Moritz many times, and
> all is well here.

Yes. in the xrt v9 patch Moritz announced late of a vacation with a 
return of 9/4.

It has been 11 days.


I have tried to reach him privately several times of the last 2 months 
without a response.

Publicly several folks and I have asked for a reply to move their 
patches along.

For a low volume list, it should be possible to clear outstanding 
requests at least weekly.

When that turns into months, that is a problem.


The subsystem needs at least a submaintainer.

Tom

> greg k-h
>

