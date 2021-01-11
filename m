Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFEE12F187F
	for <lists+linux-fpga@lfdr.de>; Mon, 11 Jan 2021 15:42:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730148AbhAKOl6 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 11 Jan 2021 09:41:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:49636 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730257AbhAKOl4 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 11 Jan 2021 09:41:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610376030;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WKAWuquRO7icbSu42Bo9pe6imSnG/5np8OZXbVqms+s=;
        b=OMAIuNMhXFUsWZJutlc+oy5HT2LyFHfHOx14FAHRl9hxB/sotlqUAMDt26ck9xFQUGyppO
        gCBP3sadnOWRoKvvW93xchQopivtNLNbVvaejbNZVB2DEE/FPCBjDiFPZwB1lZUh5mMyYQ
        GXrV/Jbfmz+WufXOBNbyxN2KPRYiCq8=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-262-bW7CMsC2Oc21sYEo0Yb1GA-1; Mon, 11 Jan 2021 09:40:29 -0500
X-MC-Unique: bW7CMsC2Oc21sYEo0Yb1GA-1
Received: by mail-il1-f199.google.com with SMTP id l12so12874895ilj.18
        for <linux-fpga@vger.kernel.org>; Mon, 11 Jan 2021 06:40:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=WKAWuquRO7icbSu42Bo9pe6imSnG/5np8OZXbVqms+s=;
        b=Nmm2iLLF3GYOGhg4JFoB7IbRwgx5tj5cfJ6vPJpkc1JCa8Y33XDWhLFpW5VpC2N/ot
         Er9IT7IwgDxUOEbjVPFYQ3jAcXJWOsdI9q7InlIyupl/u7CQ6Hmk0NZmgRn5wOh4037k
         M4081HJglRnF9RPGLLqsrVOc66VAtYPsAyyBblxwiPmFgWjyGeN16PCmzuh9BSjzAyFN
         yCEV8qg0p5Y/WXsAtp9cJmxK5EVqGVq63Xz0eBGd0W06cw6bgfBarIDPUYEbWWZqfG06
         VrPx563Rw0tNdake60W3gy3avFGWK18v5PaZUvgm22mI/GVELKx5OirnXV3mbVNYG22y
         U33w==
X-Gm-Message-State: AOAM530h1Y/9CncdLMgeAyDfmXMP4DTX0/0IhaOo32MIUlJGWowkxR7N
        ZZY8lc6gqth7p9aASDIIXQU7nYeW1a/3OU2D+EVynQiZwCz8tI3KRdloxjsT9zrqLriWA9uuzfZ
        s/oGbLjlNjNKO/zn3Xxuihg==
X-Received: by 2002:a92:79c7:: with SMTP id u190mr15260290ilc.140.1610376028279;
        Mon, 11 Jan 2021 06:40:28 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxhLMyR1k9jCSaUTWzlhfrsjSuduZ0K7D0iVFUL/V58jWOVgaNKoNa5+Cj7Bwlb88GgLj/f6g==
X-Received: by 2002:a92:79c7:: with SMTP id u190mr15260279ilc.140.1610376028147;
        Mon, 11 Jan 2021 06:40:28 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id t14sm11580602iof.23.2021.01.11.06.40.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Jan 2021 06:40:27 -0800 (PST)
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
References: <20210107043714.991646-1-mdf@kernel.org>
 <80b29715-aa0a-b2ac-03af-904fc8f8be98@redhat.com>
 <e1d30642-ce85-b9b7-e8b2-5ad4fe6338e5@redhat.com> <X/sz6lDq8WFzrRUJ@archbook>
 <95af46d6-d123-f610-2f21-6d6de6f248e9@redhat.com>
 <X/v2xs5Rnfw9F18E@kroah.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <9bc01a73-726f-a979-1246-6ea048961670@redhat.com>
Date:   Mon, 11 Jan 2021 06:40:24 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <X/v2xs5Rnfw9F18E@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 1/10/21 10:57 PM, Greg KH wrote:
> On Sun, Jan 10, 2021 at 11:43:54AM -0800, Tom Rix wrote:
>> On 1/10/21 9:05 AM, Moritz Fischer wrote:
>>> Tom,
>>>
>>> On Sun, Jan 10, 2021 at 07:46:29AM -0800, Tom Rix wrote:
>>>> On 1/7/21 8:09 AM, Tom Rix wrote:
>>>>> On 1/6/21 8:37 PM, Moritz Fischer wrote:
>>>>>> This is a resend of the previous (unfortunately late) patchset of
>>>>>> changes for FPGA DFL.
>>>>> Is there something I can do to help ?
>>>>>
>>>>> I am paid to look after linux-fpga, so i have plenty of time.
>>>>>
>>>>> Some ideas of what i am doing now privately i can do publicly.
>>>>>
>>>>> 1. keep linux-fpga sync-ed to greg's branch so linux-fpga is normally in a pullable state.
>>> Is it not? It currently points to v5.11-rc1. If I start applying patches
>>> that require the changes that went into Greg's branch I can merge.
>> I mean the window between when we have staged patches and when they go into Greg's branch.
>>
>> We don't have any now, maybe those two trival ones.
>>
>> Since Greg's branch moves much faster than ours, our staging branch needs to be rebased regularly until its merge.
> Ick, no!  NEVER rebase a public branch.  Why does it matter the speed of
> my branch vs. anyone elses?  Git handles merges very well.
>
> Just like Linus's branches move much faster than mine, and I don't
> rebase my branches, you shouldn't rebase yours.
>
> Becides, I'm only taking _PATCHES_ for fpga changes at the moment, no
> git pulls, so why does it matter at all for any of this?
>
> What is the problem you are trying to solve here?

This 5.12 fpga patchset not making it into 5.11.

At some point before the 5.11 window, I tried it on next and it failed to merge.

This points to needing some c/i so it does not happen again.

Tom

>
> thanks,
>
> greg k-h
>

