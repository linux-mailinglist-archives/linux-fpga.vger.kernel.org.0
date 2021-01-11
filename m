Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C8E12F22F7
	for <lists+linux-fpga@lfdr.de>; Mon, 11 Jan 2021 23:42:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390682AbhAKWlK (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 11 Jan 2021 17:41:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33749 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728062AbhAKWlJ (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 11 Jan 2021 17:41:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610404782;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cW3iSBkKoKiESA256+xWB2cAcMZQzJSIVrZ0jjOHSOQ=;
        b=MfxfpSAQRjxHQAuMTu4POs8zxfx+n6kJZTaCKxeSLZ+iwkrVss4D1439muXZhwhfrcWpS5
        5Oxaf0loDnNWMdUB1H1kXcjX27z1RbqUeNTKl+/nTZ9m1WgvvxuTaDTYJtpZhgNXHihpYm
        frhPTM5OZDdvKl+INJdLHsufKwmZga0=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-441-CYdRj1FzNCCjT-BmKvgc9Q-1; Mon, 11 Jan 2021 17:39:41 -0500
X-MC-Unique: CYdRj1FzNCCjT-BmKvgc9Q-1
Received: by mail-io1-f70.google.com with SMTP id w26so227099iox.21
        for <linux-fpga@vger.kernel.org>; Mon, 11 Jan 2021 14:39:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=cW3iSBkKoKiESA256+xWB2cAcMZQzJSIVrZ0jjOHSOQ=;
        b=PMaHhC4r7o0NeKz4KBLaCTL3dBKsO3GZZEqRIDRnmmJI6SfBOGaNDhzgepEf46mK32
         Xn7US/mMeAhRtXK5cXhYZDB+OjiPL9LPq5TUvPdz0U3u9ohMwijlYzo4JGgM2TIlzXYR
         eJSTvRupOjeFHASDCgJMBVkea3zh/SmZfLuhZI0knjikKE3ZssBvWIJOebs+cluZFAI7
         efnOG5WYYpslqW8ViOqPp9vcTxcSCdnFZnVHhRlfGleLGyhWph8Bz1b90Eg5Vvsusl98
         GTOuwZrHvkrXrvSSq4Osz74+Opua6z5lCTEb/4ACpmJSsrHuqFR8+o3SgOsY5GPFi4I3
         ZlWw==
X-Gm-Message-State: AOAM532SZtNmdksUrnWUknXpys6nVM0P94W64IDSLuN67GjO596MGjII
        WndOD8I063b8M0fLLNDcQC7gEkF1H9VlAi5cnu53ZJo0Q7otGPODJRw0SN7j0qMWoImOVVBh5PX
        X2nanV8bOYacyh1/cTs545g==
X-Received: by 2002:a02:ca09:: with SMTP id i9mr1601462jak.135.1610404780434;
        Mon, 11 Jan 2021 14:39:40 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzmYVnTm8u0tEM8m+5ab64f5NvBdYw48ngffL+JZzdezvXPa/KnRQlhCw/IPQKqaD8BZ2/85A==
X-Received: by 2002:a02:ca09:: with SMTP id i9mr1601443jak.135.1610404780215;
        Mon, 11 Jan 2021 14:39:40 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id k9sm539842iob.13.2021.01.11.14.39.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Jan 2021 14:39:39 -0800 (PST)
Subject: Re: [PATCH 0/8] FPGA DFL Changes for 5.12
To:     Moritz Fischer <mdf@kernel.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        linux-kernel@vger.kernel.org, moritzf@google.com,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Zheng Yongjun <zhengyongjun3@huawei.com>,
        Russ Weight <russell.h.weight@intel.com>,
        "Gerlach, Matthew" <matthew.gerlach@intel.com>,
        Sonal Santan <sonal.santan@xilinx.com>,
        Xu Yilun <yilun.xu@intel.com>,
        Richard Gong <richard.gong@intel.com>
References: <X/sz6lDq8WFzrRUJ@archbook>
 <95af46d6-d123-f610-2f21-6d6de6f248e9@redhat.com>
 <X/v2xs5Rnfw9F18E@kroah.com>
 <9bc01a73-726f-a979-1246-6ea048961670@redhat.com>
 <X/xmi/jJmDHnV5/N@kroah.com>
 <7923d9dc-c503-5318-6e4f-931f8c13c1be@redhat.com>
 <X/x4QjGyP8ssYUDI@kroah.com>
 <fe9739cf-abc9-c0c6-933e-8447a9d197a8@redhat.com>
 <X/yXOFYnQcA1MsUd@kroah.com>
 <dccc8075-b900-8680-3620-8050475858a7@redhat.com> <X/y0+ZCPsfrg/LUp@archbook>
From:   Tom Rix <trix@redhat.com>
Message-ID: <ac1fd7f4-f53a-ddc4-192b-8c8af254f7ee@redhat.com>
Date:   Mon, 11 Jan 2021 14:39:36 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <X/y0+ZCPsfrg/LUp@archbook>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 1/11/21 12:28 PM, Moritz Fischer wrote:
> Tom,
>
> On Mon, Jan 11, 2021 at 11:46:03AM -0800, Tom Rix wrote:
>
> [..]
>> I have been doing the first review in a couple of days after every patch landing.
> I appreciate your help with doing reviews.
>  
>> I see some pretty good response from the developers to fix the issues raised.Ã‚Â 
> ... yet patches have been rejected. So it doesn't seem purely a matter
> of throughput?
>
>> But I do not see Moritz picking up the review until weeks later.
> I'll admit there are delays that happen, I have a dayjob as I pointed
> out in earlier conversations. Furthermore, just because I do not
> immediately send out an email does not mean I don't look at stuff.
>
> If people show up with 100kLOC patchsets that don't pass checkpatch,
> it'll take a while for me to even read up and understand what they're
> doing / trying to do.
>
>> This consistent delay in timely reviews is a bottleneck.
> As Greg pointed out even ones that were reviewed got rejected, so
> clearly the issue is with the quality and not the speed at which we send
> them on.
>
>> It would be good if the big first reviews could be done in parallel.
> Again depending how the patchsets are structured it will take me a while
> to process. Having them re-use existing infrastructure, following
> coding and submission guidelines will speed up the process.
>
> On a personal level, being told I'm too slow and not doing my job as
> maintainer doesn't exactly increase my motivation to get to it ...

Sorry about that.

I really do want to help out, earlier you mentioned patchwork problems.

If you can point me at the wreckage, I'll take a look.

Tom


>
> - Moritz
>

