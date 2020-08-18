Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9ECB248745
	for <lists+linux-fpga@lfdr.de>; Tue, 18 Aug 2020 16:21:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726745AbgHROV0 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 18 Aug 2020 10:21:26 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:35097 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726617AbgHROVY (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 18 Aug 2020 10:21:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597760482;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Yz2aFioQzK66jmr3N2BmfzM3+e8xJ7f1GvUhfZfDu9o=;
        b=JwyBklrT1/VqzgieFxVef68Fn9VVINYScT+BCudGeO8vxE8Z8tig5y2WwFeYP3tlJTF22O
        +A8XlTl1wHL2qD5xSykrCNS9DFy6gf3uPi9fHda9rSs0pXJJUrzUEOUxly0krrtsL7hcf1
        8emaSKQIl/Mt08yhLYIivS02SwNgScg=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-432-bDwUuchlNfWgAXv_gEaquw-1; Tue, 18 Aug 2020 10:21:14 -0400
X-MC-Unique: bDwUuchlNfWgAXv_gEaquw-1
Received: by mail-qk1-f197.google.com with SMTP id j7so13237063qki.5
        for <linux-fpga@vger.kernel.org>; Tue, 18 Aug 2020 07:21:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Yz2aFioQzK66jmr3N2BmfzM3+e8xJ7f1GvUhfZfDu9o=;
        b=Y16O5zILqPPjViSGyXm+3HgJ5dp0h7B1Xi4F4QLk15fRSMHsMAvqleEEy6JRABCRwZ
         6k0/YHJOooe+hjj0DIGcwKAILirew32DKkZJi8TCFltaSBjCGuVufMM1P3L+R9+yy6gv
         trjwoSd/n6zhENpQoiAiIMawkmdbGoEg+UY/GZiervjNwiF80A1AMoznHOnzBzSs/nix
         +NaQUdFu71VdeJoTzAqIOYvn6cvnOvQLK7kYutle9TUc2MtMjmR2sfNRgK9X445cdgUe
         +dLtSTigZRNA3XIxi8cBqIXazblL4upy22nKixn+U3e1mLaVkinR3MECqzevFjy1xY14
         RpEw==
X-Gm-Message-State: AOAM532dvTJJWp4EFmmcs2rjX8ss5ZjPvuojCBB4j+JyHUZBYeazg9b1
        r5wIphSOaXI3dPKpizzydfANhMSpBu0TznRChedGLY4rKd2qngGGfE+NBdtRR384turaqyaZ30m
        3igDBEMf7CtM/bjtFDY+5Dw==
X-Received: by 2002:a0c:aece:: with SMTP id n14mr19686884qvd.68.1597760473504;
        Tue, 18 Aug 2020 07:21:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwR7cqBHSHZWO71g7kDKxrm2e6bQpvtnq4BHkeoL4lVYkiYaEGKTNKdjAybReLDnZZ+QWqphQ==
X-Received: by 2002:a0c:aece:: with SMTP id n14mr19686865qvd.68.1597760473260;
        Tue, 18 Aug 2020 07:21:13 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id x5sm22753285qtp.76.2020.08.18.07.21.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Aug 2020 07:21:12 -0700 (PDT)
Subject: Re: [PATCH 2/3] fpga manager: xilinx-spi: provide better diagnostics
 on programming failure
To:     Luca Ceresoli <luca@lucaceresoli.net>, linux-fpga@vger.kernel.org
Cc:     Moritz Fischer <mdf@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anatolij Gustschin <agust@denx.de>, linux-gpio@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
References: <20200817165911.32589-1-luca@lucaceresoli.net>
 <20200817165911.32589-2-luca@lucaceresoli.net>
 <b1a1a9d9-d36b-40f0-24e3-f793e55db929@redhat.com>
 <51694865-2a05-ac67-43a0-dbcb9989cbab@lucaceresoli.net>
From:   Tom Rix <trix@redhat.com>
Message-ID: <397b99e2-9b39-5a67-e1c6-8dcf3482f96b@redhat.com>
Date:   Tue, 18 Aug 2020 07:21:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <51694865-2a05-ac67-43a0-dbcb9989cbab@lucaceresoli.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 8/18/20 3:20 AM, Luca Ceresoli wrote:
> [a question for GPIO maintainers below]
>
> Hi Tom,
>
> thanks for your review!
>
> On 17/08/20 20:15, Tom Rix wrote:
>> The other two patches are fine.
>>
>> On 8/17/20 9:59 AM, Luca Ceresoli wrote:
>>> When the DONE pin does not go high after programming to confirm programming
>>> success, the INIT_B pin provides some info on the reason. Use it if
>>> available to provide a more explanatory error message.
>>>
>>> Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
>>> ---
>>>  drivers/fpga/xilinx-spi.c | 11 ++++++++++-
>>>  1 file changed, 10 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/fpga/xilinx-spi.c b/drivers/fpga/xilinx-spi.c
>>> index 502fae0d1d85..2aa942bb1114 100644
>>> --- a/drivers/fpga/xilinx-spi.c
>>> +++ b/drivers/fpga/xilinx-spi.c
>>> @@ -169,7 +169,16 @@ static int xilinx_spi_write_complete(struct fpga_manager *mgr,
>>>  			return xilinx_spi_apply_cclk_cycles(conf);
>>>  	}
>>>  
>>> -	dev_err(&mgr->dev, "Timeout after config data transfer.\n");
>>> +	if (conf->init_b) {
>>> +		int init_b_asserted = gpiod_get_value(conf->init_b);
>> gpiod_get_value can fail. So maybe need split the first statement.
>>
>> init_b_asserted < 0 ? "invalid device"
>>
>> As the if-else statement is getting complicated, embedding the ? : makes this hard to read.  'if,else if, else' would be better.
> Thanks for the heads up. However I'm not sure which is the best thing to
> do here.
>
> First, I've been reading the libgpiod code after your email and yes, the
> libgpiod code _could_ return runtime errors received from the gpiochip
> driver, even though the docs state:
>
>> The get/set calls do not return errors because “invalid GPIO”> should have been reported earlier from gpiod_direction_*().
> (https://www.kernel.org/doc/html/latest/driver-api/gpio/consumer.html)
>
> On the other hand there are plenty of calls to gpiod_get/set_value in
> the kernel that don't check for error values. I guess this is because
> failures getting/setting a GPIO are very uncommon (perhaps impossible
> with platform GPIO).
>
> When still a GPIO get/set operation fails I'm not sure adding thousands
> of error-checking code lines in hundreds of drivers is the best way to
> go. I feel like we should have a unique, noisy dev_err() in the error
> path in libgpio but I was surprised in not finding any [1].
>
> Linus, Bartosz, what's your opinion? Should all drivers check for errors
> after every gpiod_[sg]et_value*() call?

My opinion is that you know the driver / hw is in a bad state and you

are trying to convey useful information.  So you should

be as careful as possible and not assume gpio did not fail.

>
>>> +		dev_err(&mgr->dev,
>>> +			init_b_asserted ? "CRC error or invalid device\n"
>>> +			: "Missing sync word or incomplete bitstream\n");
>>> +	} else {
>>> +		dev_err(&mgr->dev, "Timeout after config data transfer.\n");
>> patch 3 removes '.' s , and you just added one back in ?
> Here I'm only changing indentation of this line. But OK, this is
> misleading, so I'll swap patches 2 and 3 in the next patch iteration to
> avoid confusion.
Maybe just remove the '.' at the same time and/or collapse 2&3 into a single patch.
>
> [1]
> https://elixir.bootlin.com/linux/v5.8/source/drivers/gpio/gpiolib.c#L3646
>

