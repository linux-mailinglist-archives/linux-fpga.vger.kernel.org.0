Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 633B22F1A46
	for <lists+linux-fpga@lfdr.de>; Mon, 11 Jan 2021 16:58:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387972AbhAKP5A (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 11 Jan 2021 10:57:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:47545 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732539AbhAKP5A (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 11 Jan 2021 10:57:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610380532;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WYZyEx34y2wGkNYlTSiCTOGlTDW179acirgz+hIyYhc=;
        b=fnSxOPocb9LyChwi0R0w9UZlz0t7Ssp/vUUbQOEZfkkz/3EoSbIVgjhx0sQFkdiJkq2rMa
        rDASwyNc/3LMGSA7Z4LbW2lswFow2Rzo9ya/Nln4XbIMf4Hlhql1z97mQOPc9DYuuIZGzR
        sNrhbKCLYs34yOT2nvA0dwqvr4fphO4=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-258-zwneI5aeMVSZfSibUrHaUA-1; Mon, 11 Jan 2021 10:55:30 -0500
X-MC-Unique: zwneI5aeMVSZfSibUrHaUA-1
Received: by mail-qt1-f199.google.com with SMTP id m27so54377qtu.20
        for <linux-fpga@vger.kernel.org>; Mon, 11 Jan 2021 07:55:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=WYZyEx34y2wGkNYlTSiCTOGlTDW179acirgz+hIyYhc=;
        b=Ypujw5zbp5++v5qfBhtJQA3L1Pgb1KzFplTWlM/Ucff7tYVB5Wc2rXiGbTD5NfZANJ
         rnh5aEgGvsJyjcn91wZ+hJt7cXjGbriKL74yuCA8/GJt0HAXZNVhS2IUFRiYPKSdsarT
         jWUzH6Mnay95ckBHHkxXzCBthQQAg8lRLyHR1Kvn3M0uDz3EEj755M4D3TGuoUGb7xwL
         Xto+6aa99fWzXfyDV1LWsCPgnq7uKqtq7o2oP+A00v1mAuVoGW1DYjVf/l13yGYEkDEP
         GYY+S3Tuz/1goa5BH8ZWGWUnteCrJb0mY9Ydc8dZTZFQnQJH4R9LNzu6WNUnjLXAS8Ks
         BbQA==
X-Gm-Message-State: AOAM532qHxB+LaDp/M4pwruLsjKLYr1SPRuoCSpLCt2+fYbhvErSoBuu
        M0K5X1DSIMKlEE1/HFWUOVDoxhdaNxhsL5dITP5M3+x9C9NPJfth1u6Kr3uZP01dqNvjSuoGzlp
        2URY3QEBb26MtR3Ztwkmubw==
X-Received: by 2002:ae9:e64d:: with SMTP id x13mr16703837qkl.464.1610380529744;
        Mon, 11 Jan 2021 07:55:29 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxaetYR1FLUkbBtsjhV3+2QMaQEq1oWksSzb7fFsAuTBINUV+y9hC//TYW/F6pLaXQGv6EYLA==
X-Received: by 2002:ae9:e64d:: with SMTP id x13mr16703809qkl.464.1610380529488;
        Mon, 11 Jan 2021 07:55:29 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id y22sm77461qkj.129.2021.01.11.07.55.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Jan 2021 07:55:28 -0800 (PST)
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
 <9bc01a73-726f-a979-1246-6ea048961670@redhat.com>
 <X/xmi/jJmDHnV5/N@kroah.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <7923d9dc-c503-5318-6e4f-931f8c13c1be@redhat.com>
Date:   Mon, 11 Jan 2021 07:55:24 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <X/xmi/jJmDHnV5/N@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 1/11/21 6:54 AM, Greg KH wrote:
> On Mon, Jan 11, 2021 at 06:40:24AM -0800, Tom Rix wrote:
>> On 1/10/21 10:57 PM, Greg KH wrote:
>>> On Sun, Jan 10, 2021 at 11:43:54AM -0800, Tom Rix wrote:
>>>> On 1/10/21 9:05 AM, Moritz Fischer wrote:
>>>>> Tom,
>>>>>
>>>>> On Sun, Jan 10, 2021 at 07:46:29AM -0800, Tom Rix wrote:
>>>>>> On 1/7/21 8:09 AM, Tom Rix wrote:
>>>>>>> On 1/6/21 8:37 PM, Moritz Fischer wrote:
>>>>>>>> This is a resend of the previous (unfortunately late) patchset of
>>>>>>>> changes for FPGA DFL.
>>>>>>> Is there something I can do to help ?
>>>>>>>
>>>>>>> I am paid to look after linux-fpga, so i have plenty of time.
>>>>>>>
>>>>>>> Some ideas of what i am doing now privately i can do publicly.
>>>>>>>
>>>>>>> 1. keep linux-fpga sync-ed to greg's branch so linux-fpga is normally in a pullable state.
>>>>> Is it not? It currently points to v5.11-rc1. If I start applying patches
>>>>> that require the changes that went into Greg's branch I can merge.
>>>> I mean the window between when we have staged patches and when they go into Greg's branch.
>>>>
>>>> We don't have any now, maybe those two trival ones.
>>>>
>>>> Since Greg's branch moves much faster than ours, our staging branch needs to be rebased regularly until its merge.
>>> Ick, no!  NEVER rebase a public branch.  Why does it matter the speed of
>>> my branch vs. anyone elses?  Git handles merges very well.
>>>
>>> Just like Linus's branches move much faster than mine, and I don't
>>> rebase my branches, you shouldn't rebase yours.
>>>
>>> Becides, I'm only taking _PATCHES_ for fpga changes at the moment, no
>>> git pulls, so why does it matter at all for any of this?
>>>
>>> What is the problem you are trying to solve here?
>> This 5.12 fpga patchset not making it into 5.11.
> Ok, but isn't it the responsibility of the submitter to make sure they
> apply properly when sending them out?
>
>> At some point before the 5.11 window, I tried it on next and it failed to merge.
>>
>> This points to needing some c/i so it does not happen again.
> "again"?  Merges and the like are a totally normal thing and happen all
> the time, I still fail to understand what you are trying to "solve" for
> here...

What can I do to help make your merges as easy as possible ?

Does the patchwork infra Moritz was speaking of earlier need fixing help?

Any other things ?

Tom

>
> thanks,
>
> greg k-h
>

