Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBDF03A02E6
	for <lists+linux-fpga@lfdr.de>; Tue,  8 Jun 2021 21:22:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236563AbhFHTLH (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 8 Jun 2021 15:11:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:30752 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235875AbhFHTHi (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 8 Jun 2021 15:07:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623179143;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7bda8qKrYBdrl6J95LCGp+lpIpDC0YoD+14XcFJ5Ns8=;
        b=H/L9lyBYfQ1QgRKi6/PsmkoZE9Ff14QUuuc7WK7Ve3/3cLrNincswGreZ36IdX4GcggKB2
        aS8ZEUz5QsGeavyoJbfJXufCtNhVC+OcT8dX+7SPZ5H7UYWNBIaWRkwUiIIbg0s+5ZLKeq
        TDDmfZFEt4WXw9WcR9DlCLyw/Q+jZJ4=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-88-ETNY85B2OLSEod0sjD0QPQ-1; Tue, 08 Jun 2021 15:05:42 -0400
X-MC-Unique: ETNY85B2OLSEod0sjD0QPQ-1
Received: by mail-oo1-f70.google.com with SMTP id r130-20020a4a37880000b029024987ad471cso6754239oor.17
        for <linux-fpga@vger.kernel.org>; Tue, 08 Jun 2021 12:05:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=7bda8qKrYBdrl6J95LCGp+lpIpDC0YoD+14XcFJ5Ns8=;
        b=YWyBhNUlBEMqaA2qwIUe4P7nvUdezoBLPC6UYP7M1cHChysHhQy/IBhZGGjKdyB26X
         2Eod/BxA0wSpCm44QMTjdo+4lxwuTNpQxbl1uVNbn1PFYDXQ+MtR2aj7Q1GtITlGWX37
         2ArKrHPZ3h0yQusYsyt0vrYMxJmzv2EmDwrG8SDyNP3Loau9AX2sVTjb9wryLPCr2ndk
         1GDvPiC0mg+VH6zt61eyi3De9Z2pyNx+fbOWuMWz06A2GwhQmZuWtZYZmg7XVQTibqqL
         yq5GPUASSnVa6aA86BT/onYxV9RN4lSXrodQORWBGJZr+btXWDq1k+iboNatZ8CIX7Qr
         MmyA==
X-Gm-Message-State: AOAM5313ok8tzHPVYG5TbCSnhMRkGG3G6/eJbZ1WW7zvBcKxvVGGFLdT
        MtocQf76FZoD/+79T93g0S93LQJuoKZ5A5Tmoc4S2Kc+X1+NfyNWbP2fEDU4L+f2RwL/sou6AHL
        eKJw9SMantNFMB1aLBveLtA==
X-Received: by 2002:a9d:19ed:: with SMTP id k100mr18893732otk.329.1623179141655;
        Tue, 08 Jun 2021 12:05:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz9uRSf/J+rCQi9NLexIXXQEVhh2pTd041kBvsvzmkI7RYzdysf4m+Mc/Rwzl3IYu+OtdO7xg==
X-Received: by 2002:a9d:19ed:: with SMTP id k100mr18893722otk.329.1623179141455;
        Tue, 08 Jun 2021 12:05:41 -0700 (PDT)
Received: from localhost.localdomain (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id e11sm3190450otk.78.2021.06.08.12.05.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jun 2021 12:05:41 -0700 (PDT)
Subject: Re: [PATCH 1/7] fpga: wrap the write_init() op
To:     =?UTF-8?Q?Martin_Hundeb=c3=b8ll?= <mhu@silicom.dk>,
        Moritz Fischer <mdf@kernel.org>
Cc:     hao.wu@intel.com, michal.simek@xilinx.com,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20210607172402.2938697-1-trix@redhat.com>
 <20210607172402.2938697-2-trix@redhat.com> <YL6fUSD0KLP0l80g@epycbox.lan>
 <2faf6ccb-005b-063a-a2a3-e177082c4b3c@silicom.dk>
From:   Tom Rix <trix@redhat.com>
Message-ID: <6cda92dc-74f1-a6ad-e9f9-030a4095118e@redhat.com>
Date:   Tue, 8 Jun 2021 12:05:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <2faf6ccb-005b-063a-a2a3-e177082c4b3c@silicom.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 6/7/21 11:23 PM, Martin Hundebøll wrote:
>
>
> On 08/06/2021 00.36, Moritz Fischer wrote:
>> On Mon, Jun 07, 2021 at 10:23:56AM -0700, trix@redhat.com wrote:
>>> From: Tom Rix <trix@redhat.com>
>>>
>>> The board should not be required to provide a
>> Nit: Can you turn these into for whole series:
>> A FPGA Manager should not be ...
>
> Nit nit: should be:
> An FPGA Manager should not be ...
>
> // Martin

ok.

I went down a rabbit hole on this one, looks fine.

Tom

>
>>
>>> write_init() op if there is nothing for it do.
>>> So add a wrapper and move the op checking.
>>> Default to success.
>>>
>>> Signed-off-by: Tom Rix <trix@redhat.com>
>>> ---
>>>   drivers/fpga/fpga-mgr.c | 14 +++++++++++---
>>>   1 file changed, 11 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
>>> index b85bc47c91a9..24547e36a56d 100644
>>> --- a/drivers/fpga/fpga-mgr.c
>>> +++ b/drivers/fpga/fpga-mgr.c
>>> @@ -69,6 +69,14 @@ void fpga_image_info_free(struct fpga_image_info 
>>> *info)
>>>   }
>>>   EXPORT_SYMBOL_GPL(fpga_image_info_free);
>>>   +static int fpga_mgr_write_init(struct fpga_manager *mgr,
>>> +                   struct fpga_image_info *info,
>>> +                   const char *buf, size_t count)
>>> +{
>>> +    if (mgr->mops && mgr->mops->write_init)
>>> +        return  mgr->mops->write_init(mgr, info, buf, count);
>>> +    return 0;
>>> +}
>>>   /*
>>>    * Call the low level driver's write_init function.  This will do the
>>>    * device-specific things to get the FPGA into the state where it 
>>> is ready to
>>> @@ -83,9 +91,9 @@ static int fpga_mgr_write_init_buf(struct 
>>> fpga_manager *mgr,
>>>         mgr->state = FPGA_MGR_STATE_WRITE_INIT;
>>>       if (!mgr->mops->initial_header_size)
>>> -        ret = mgr->mops->write_init(mgr, info, NULL, 0);
>>> +        ret = fpga_mgr_write_init(mgr, info, NULL, 0);
>>>       else
>>> -        ret = mgr->mops->write_init(
>>> +        ret = fpga_mgr_write_init(
>>>               mgr, info, buf, min(mgr->mops->initial_header_size, 
>>> count));
>>>         if (ret) {
>>> @@ -569,7 +577,7 @@ struct fpga_manager *fpga_mgr_create(struct 
>>> device *dev, const char *name,
>>>       int id, ret;
>>>         if (!mops || !mops->write_complete || !mops->state ||
>>> -        !mops->write_init || (!mops->write && !mops->write_sg) ||
>>> +        (!mops->write && !mops->write_sg) ||
>>>           (mops->write && mops->write_sg)) {
>>>           dev_err(dev, "Attempt to register without 
>>> fpga_manager_ops\n");
>>>           return NULL;
>>> -- 
>>> 2.26.3
>>>
>>
>> Can you change the subjects to "fpga: fpga-mgr: ..."
>>
>> Otherwise series looks good.
>>
>> - Moritz
>>
>

