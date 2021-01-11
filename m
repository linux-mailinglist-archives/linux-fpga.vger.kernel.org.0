Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7E412F1B52
	for <lists+linux-fpga@lfdr.de>; Mon, 11 Jan 2021 17:45:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389111AbhAKQou (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 11 Jan 2021 11:44:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:26792 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732142AbhAKQou (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 11 Jan 2021 11:44:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610383404;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e/65f+ialXh4Oqh1VlU0K0i3Gq5vr/yiWp5Ivn7C86E=;
        b=bVVzfXMEZEWA/GIGCgUFaBA7bdMrbwLHI2dBuYt0FpJUo72BcYbBMKjoZQR2LsSNF8zYoG
        PX/9gctn7nbCTe29Qfb64hGxSNP57OYr+KHYX/ZBMUOX0Zb1eGebli5F6Tg5UD3E9fNQqi
        XQva6Z27YUF8JZuV9h/BvyE4AA2k4bo=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-306-Y3VMRMp0O02Flrm-NJBg1A-1; Mon, 11 Jan 2021 11:43:20 -0500
X-MC-Unique: Y3VMRMp0O02Flrm-NJBg1A-1
Received: by mail-qt1-f198.google.com with SMTP id i1so167816qtw.4
        for <linux-fpga@vger.kernel.org>; Mon, 11 Jan 2021 08:43:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=e/65f+ialXh4Oqh1VlU0K0i3Gq5vr/yiWp5Ivn7C86E=;
        b=aGVdmp3orozuoZLz5U66dYAgmEhg1iEp9bHQmBk0DJRBXOOYvEWGfN0DcKj2rVKtlz
         xfhOAFkAu0TyWrw9HCX3tdSXJcgpCODpv4n6iY1wfTiDnl2hQRDmNMApzU7vVuMYIM8w
         +B5bJIUY7tk+MWBmQf3y7Ex6kOKb2QJwK7GnS6Hizxkqo7sF7keXXHDTMvN/GesFTLTM
         BcKzph3GQXCNGJWLrk75mShsndvY7+o/6ZTA74ddEBlIxyNKr3Vnz/yRbFpZWiMFc9If
         TtYe6iM00TgQ7bmEs7LAazEwQWriFru9rymQGb31KjHrWhRKXN3ZEE1iYFh7ZGa/3mMN
         dBtQ==
X-Gm-Message-State: AOAM533lkXz3vNfdUBnuVwG3oK15+mrSOB2qqJtMG9MH2EERTNJBOoYZ
        3He4ax6D15CeSLrBRISvucmF1kCcTBcvYfPGA+i9Obf/e6BUnAoUb1q2OtSLOmFCZDm+0opEniD
        /YLjXyWiiEOrLxdR6HnTEFQ==
X-Received: by 2002:a37:9ecc:: with SMTP id h195mr165347qke.302.1610383398587;
        Mon, 11 Jan 2021 08:43:18 -0800 (PST)
X-Google-Smtp-Source: ABdhPJybJwjoYPSaJ+4HrIVa7HsjxVDugBHXzIiM1E9WGAvsuQII6bArqWtLnMMZD2Asu82QfFiztg==
X-Received: by 2002:a37:9ecc:: with SMTP id h195mr165324qke.302.1610383398343;
        Mon, 11 Jan 2021 08:43:18 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id 60sm57418qth.14.2021.01.11.08.43.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Jan 2021 08:43:17 -0800 (PST)
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
 <7923d9dc-c503-5318-6e4f-931f8c13c1be@redhat.com>
 <X/x4QjGyP8ssYUDI@kroah.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <fe9739cf-abc9-c0c6-933e-8447a9d197a8@redhat.com>
Date:   Mon, 11 Jan 2021 08:43:15 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <X/x4QjGyP8ssYUDI@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 1/11/21 8:09 AM, Greg KH wrote:
> On Mon, Jan 11, 2021 at 07:55:24AM -0800, Tom Rix wrote:
>> On 1/11/21 6:54 AM, Greg KH wrote:
>>> On Mon, Jan 11, 2021 at 06:40:24AM -0800, Tom Rix wrote:
>>>> On 1/10/21 10:57 PM, Greg KH wrote:
>>>>> On Sun, Jan 10, 2021 at 11:43:54AM -0800, Tom Rix wrote:
>>>>>> On 1/10/21 9:05 AM, Moritz Fischer wrote:
>>>>>>> Tom,
>>>>>>>
>>>>>>> On Sun, Jan 10, 2021 at 07:46:29AM -0800, Tom Rix wrote:
>>>>>>>> On 1/7/21 8:09 AM, Tom Rix wrote:
>>>>>>>>> On 1/6/21 8:37 PM, Moritz Fischer wrote:
>>>>>>>>>> This is a resend of the previous (unfortunately late) patchset of
>>>>>>>>>> changes for FPGA DFL.
>>>>>>>>> Is there something I can do to help ?
>>>>>>>>>
>>>>>>>>> I am paid to look after linux-fpga, so i have plenty of time.
>>>>>>>>>
>>>>>>>>> Some ideas of what i am doing now privately i can do publicly.
>>>>>>>>>
>>>>>>>>> 1. keep linux-fpga sync-ed to greg's branch so linux-fpga is normally in a pullable state.
>>>>>>> Is it not? It currently points to v5.11-rc1. If I start applying patches
>>>>>>> that require the changes that went into Greg's branch I can merge.
>>>>>> I mean the window between when we have staged patches and when they go into Greg's branch.
>>>>>>
>>>>>> We don't have any now, maybe those two trival ones.
>>>>>>
>>>>>> Since Greg's branch moves much faster than ours, our staging branch needs to be rebased regularly until its merge.
>>>>> Ick, no!  NEVER rebase a public branch.  Why does it matter the speed of
>>>>> my branch vs. anyone elses?  Git handles merges very well.
>>>>>
>>>>> Just like Linus's branches move much faster than mine, and I don't
>>>>> rebase my branches, you shouldn't rebase yours.
>>>>>
>>>>> Becides, I'm only taking _PATCHES_ for fpga changes at the moment, no
>>>>> git pulls, so why does it matter at all for any of this?
>>>>>
>>>>> What is the problem you are trying to solve here?
>>>> This 5.12 fpga patchset not making it into 5.11.
>>> Ok, but isn't it the responsibility of the submitter to make sure they
>>> apply properly when sending them out?
>>>
>>>> At some point before the 5.11 window, I tried it on next and it failed to merge.
>>>>
>>>> This points to needing some c/i so it does not happen again.
>>> "again"?  Merges and the like are a totally normal thing and happen all
>>> the time, I still fail to understand what you are trying to "solve" for
>>> here...
>> What can I do to help make your merges as easy as possible ?
> I have not had any problems with merges, I've only had "problems"
> rejecting patches for their content.
>
> Try helping out with patch reviews if you want, finding and fixing
> things before I review them is usually a good idea :)
ok.
>
>> Does the patchwork infra Moritz was speaking of earlier need fixing help?
> No idea, I don't use it.
>
>> Any other things ?
> What problems are you trying to solve here?  What's wrong with how this
> subsystem is working that you are feeling needs to be addressed?

I do not believe the issue I raised in 5.10 has made any progress.

If you look at the content in 5.11 we have actually regressed.

https://lore.kernel.org/linux-fpga/3295710c-5e82-7b97-43de-99b9870a8c8c@redhat.com/

Over the last two releases, I have shown i have the time and interest to maintain this subsystem.

So I am asking for

diff --git a/MAINTAINERS b/MAINTAINERS
index 11b38acb4c08..269cd08f4969 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6951,7 +6951,7 @@ F:        drivers/net/ethernet/nvidia/*
 
 FPGA DFL DRIVERS
 M:     Wu Hao <hao.wu@intel.com>
-R:     Tom Rix <trix@redhat.com>
+M:     Tom Rix <trix@redhat.com>
 L:     linux-fpga@vger.kernel.org
 S:     Maintained
 F:     Documentation/ABI/testing/sysfs-bus-dfl*
@@ -6962,7 +6962,7 @@ F:        include/uapi/linux/fpga-dfl.h
 
 FPGA MANAGER FRAMEWORK
 M:     Moritz Fischer <mdf@kernel.org>
-R:     Tom Rix <trix@redhat.com>
+M:     Tom Rix <trix@redhat.com>
 L:     linux-fpga@vger.kernel.org
 S:     Maintained
 W:     http://www.rocketboards.org

And to use/maintain my fpga-next and fpga-testing as official kernel.org branches.

Tom

>
> confused,
>
> greg k-h
>

