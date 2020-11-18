Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 707482B8151
	for <lists+linux-fpga@lfdr.de>; Wed, 18 Nov 2020 17:00:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726272AbgKRP5O (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 18 Nov 2020 10:57:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:53315 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727772AbgKRP5N (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 18 Nov 2020 10:57:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605715032;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7MUNtPoxOzFRYk7ZaLZB61FQy8r/ffEvOd46mt4ErR8=;
        b=D2258eRoebLL/9wf9VKOD/jmtpgpwgv3En52HQixTJkWXaEKqV03JDxlH9wkl+xiBY70fO
        3iDIK9g43YIsGHLDFUXDGLfKqnuZyB8tTJTt0HF/2rxDc3nljwUC49fdYFKTeI0YkIw7+T
        AkVTTqs5z2fL5Rdce/A2pu3ukZrNiLU=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-80-X9dksRGCOk-6vdInTFd_kg-1; Wed, 18 Nov 2020 10:57:08 -0500
X-MC-Unique: X9dksRGCOk-6vdInTFd_kg-1
Received: by mail-qv1-f72.google.com with SMTP id ca17so1619120qvb.1
        for <linux-fpga@vger.kernel.org>; Wed, 18 Nov 2020 07:57:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=7MUNtPoxOzFRYk7ZaLZB61FQy8r/ffEvOd46mt4ErR8=;
        b=fNE7blq3i+CoTGh6p7HO/JElGbnR9G8Xu2PW5UglMnzgxSoqBoeJWOWuqQDTeYmFRg
         n9GMCQpkJcrdayGql4V/VfXOsduRCoJxXobPafO/dNtRmN2v1mPoEZ9B1xU7TxLS7RQp
         jNxd1ho7irZ3+9FgJ4eMjFzsi95cmasH05LJOWUvpCEDoU6fiVsMhr9Z/9zk1gBaFC2l
         Ry9QnvavLEYQKM+qvbIIR8lUXIByIsNyYXSwLGCcLsaSasTD9HFxOf4BItE2lviHkcwd
         sr1kHyFg0k7cNAQ99/tQ58OKFvnj4NWvRZb3nVVxqhXmxCytW4yZe/1PuWXLMvKncahd
         wIqA==
X-Gm-Message-State: AOAM5327003aubSmz/ko0IzqFXqSTwzVzoGTpHTTa1ADM6YKUL+FA0Q/
        zxoHzou+WKYSkelf6FVlallUonuC0GbJjT4ZhdKZTQbhgs0fM5D3Lg+Y3ZeIfiLlr+gwCR1b2eO
        5uOOw1IXnLAMxL+ZkvkOPHg==
X-Received: by 2002:ac8:2fa2:: with SMTP id l31mr5297256qta.86.1605715027757;
        Wed, 18 Nov 2020 07:57:07 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwsDbT1P6U1bP9LZOVd6Q0kOCs3g4rLcoASoTUrH3oZa0kODquz39ngYh2mNa3cUkK4wh2T2g==
X-Received: by 2002:ac8:2fa2:: with SMTP id l31mr5297232qta.86.1605715027554;
        Wed, 18 Nov 2020 07:57:07 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id 189sm12287408qkn.125.2020.11.18.07.57.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Nov 2020 07:57:07 -0800 (PST)
Subject: Re: [PATCH v5 5/6] fpga: m10bmc-sec: add max10 secure update
 functions
To:     Russ Weight <russell.h.weight@intel.com>, mdf@kernel.org,
        lee.jones@linaro.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     lgoncalv@redhat.com, yilun.xu@intel.com, hao.wu@intel.com,
        matthew.gerlach@intel.com
References: <20201114005559.90860-1-russell.h.weight@intel.com>
 <20201114005559.90860-6-russell.h.weight@intel.com>
 <3c531b5d-0620-5239-06a7-02a01381c436@redhat.com>
 <4819688e-4967-360d-6ba7-36b93735b42d@intel.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <3fe70aff-b0ac-22dd-5f90-53924b20d8ef@redhat.com>
Date:   Wed, 18 Nov 2020 07:57:05 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <4819688e-4967-360d-6ba7-36b93735b42d@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 11/17/20 4:10 PM, Russ Weight wrote:
>
> On 11/15/20 6:17 AM, Tom Rix wrote:
>> On 11/13/20 4:55 PM, Russ Weight wrote:
>>> Extend the MAX10 BMC Secure Update driver to include
>>>
>>> +
>>> +	status = rsu_stat(doorbell);
>>> +	if (status == RSU_STAT_WEAROUT) {
>>> +		dev_warn(sec->dev, "Excessive flash update count detected\n");
>> If wear out is going to flood logs, move this to a warn once.
> There is no danger of flooding. The WEAROUT error will only be seen after 1000
> flash updates have occurred - an unlikely condition. It will also only occur
> once on an update, and only if they attempt to flash within 60 seconds of
> power-on or within 60 seconds of a previous flash.
>> Maybe make rsu_stat a function.
> Is there a reason to prefer a function in this case? Or should I change
> rsu_stat() to RSU_STAT() to make it more clear that it is a macro?

i was thinking a function could manage the warning messages.

If it will not flood, it is ok as-is.

Tom

