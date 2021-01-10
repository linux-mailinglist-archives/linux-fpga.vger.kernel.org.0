Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B617A2F0831
	for <lists+linux-fpga@lfdr.de>; Sun, 10 Jan 2021 16:48:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726069AbhAJPsE (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 10 Jan 2021 10:48:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22272 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726263AbhAJPsE (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Sun, 10 Jan 2021 10:48:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610293596;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nJHPoDKDKNzn4WVZWR4KeYqpHAlbzTvnVzZyjMDlt1c=;
        b=TINUq16BGBcjUS0MGQZHSCD+ODyf4Fs9oT7yLsUtsuZ/hU30grUvGqBkyMQyatJJP8OLj6
        Gsel8Roi6pm8csiUUMUs1X+YbMi9UUq1s+0xFTAsuXemzyGMRLnyg7s1HJHoRLsxURr9DO
        T+k1KvunL8xntveQ0Hmt5JLjxLIkQgg=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-433-s7i9SzO_OlyCW2fXeWEANw-1; Sun, 10 Jan 2021 10:46:33 -0500
X-MC-Unique: s7i9SzO_OlyCW2fXeWEANw-1
Received: by mail-io1-f72.google.com with SMTP id m2so9905076iow.23
        for <linux-fpga@vger.kernel.org>; Sun, 10 Jan 2021 07:46:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=nJHPoDKDKNzn4WVZWR4KeYqpHAlbzTvnVzZyjMDlt1c=;
        b=l6i981IiUxO2o5Sn77WLI8ObvWMpBbRSaUYtrg8byyjji6XXB4+ae7NWTa2SCe00JR
         jlQWcO2C6fiWxmkfsRMtyt9WOgBrV0nxMcuYs5z0f9PHHHbak2issckOK4RKpUmhwN3V
         olUhc/eYJ3jL5fRVscG+PQfhoqMG0WcWRo8K2dvyCptoYsm1zhL31im3JJH4emd1hrs3
         CtnmL8JHZ9fJ1E1tjk/VDGslY9fQmpdY5RdSP5Zq4olNPToYvQk3rWf7Slp4yQmW5tNW
         BbXZlPLogumvroX7KpPnuURBPE7CnQSJupuYvdOwfl5PUyHkqRu/fnv4cnPF2HH8Vfze
         0NwA==
X-Gm-Message-State: AOAM532n5u+P3ioovGq6Hbji3Tyetu8NHh+93BbOD8v2lwP0Psi+jiO8
        X4vva+HJwLMbJPBQkuOI+w1xFHsFiOAmiHEVziZOShsVYc8Bxzs6jHahsXxnTfI0MBl37QTpCTm
        f6jSVU5IckvtOC/a39/F6iA==
X-Received: by 2002:a92:bbc1:: with SMTP id x62mr12385753ilk.73.1610293593356;
        Sun, 10 Jan 2021 07:46:33 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzZ3r6sw5d9VM0GgPbcaCZGcSx2U4R9erKNULHXWVKc2CCssIlcALBlqUui9irGxbStQvwoBw==
X-Received: by 2002:a92:bbc1:: with SMTP id x62mr12385736ilk.73.1610293593158;
        Sun, 10 Jan 2021 07:46:33 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id v6sm12043670ilo.61.2021.01.10.07.46.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Jan 2021 07:46:32 -0800 (PST)
Subject: Re: [PATCH 0/8] FPGA DFL Changes for 5.12
From:   Tom Rix <trix@redhat.com>
To:     Moritz Fischer <mdf@kernel.org>, gregkh@linuxfoundation.org,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>
Cc:     linux-kernel@vger.kernel.org, moritzf@google.com,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Zheng Yongjun <zhengyongjun3@huawei.com>,
        Russ Weight <russell.h.weight@intel.com>,
        "Gerlach, Matthew" <matthew.gerlach@intel.com>,
        Sonal Santan <sonal.santan@xilinx.com>,
        Xu Yilun <yilun.xu@intel.com>,
        Richard Gong <richard.gong@intel.com>
References: <20210107043714.991646-1-mdf@kernel.org>
 <80b29715-aa0a-b2ac-03af-904fc8f8be98@redhat.com>
Message-ID: <e1d30642-ce85-b9b7-e8b2-5ad4fe6338e5@redhat.com>
Date:   Sun, 10 Jan 2021 07:46:29 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <80b29715-aa0a-b2ac-03af-904fc8f8be98@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 1/7/21 8:09 AM, Tom Rix wrote:
> On 1/6/21 8:37 PM, Moritz Fischer wrote:
>> This is a resend of the previous (unfortunately late) patchset of
>> changes for FPGA DFL.
> Is there something I can do to help ?
>
> I am paid to look after linux-fpga, so i have plenty of time.
>
> Some ideas of what i am doing now privately i can do publicly.
>
> 1. keep linux-fpga sync-ed to greg's branch so linux-fpga is normally in a pullable state.
>
> 2. an in-flight dev branch for the outstanding patches 

I have setup these branches based on Greg's char-misc-next

fpga-next, which is char-misc-next base for fpga-testing

fpga-testing, all the in-flight patches that would apply with automatic merge conflict resolution

These are respectively

https://github.com/trixirt/linux-fpga/tree/fpga-next

https://github.com/trixirt/linux-fpga/tree/fpga-testing


There are two trivial changes, that could go to 5.12 now.

fpga: dfl: fme: Constify static attribute_group structs

fpga: Use DEFINE_SPINLOCK() for spinlock

respectively

https://lore.kernel.org/linux-fpga/20210108235414.48017-1-rikard.falkeborn@gmail.com/

https://lore.kernel.org/linux-fpga/20201228135135.28788-1-zhengyongjun3@huawei.com/


There are a couple of patchsets that conflict

https://lore.kernel.org/linux-fpga/20210105230855.15019-7-russell.h.weight@intel.com/

https://lore.kernel.org/linux-fpga/20201203171548.1538178-3-matthew.gerlach@linux.intel.com/

Which I will follow up on.


And the xilinx patchset

https://lore.kernel.org/linux-fpga/20201217075046.28553-1-sonals@xilinx.com/

Which is being split/worked on offline.


If I have missed any patchset, poke me.

Tom


>
> Tom
>
>

