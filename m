Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2921224A420
	for <lists+linux-fpga@lfdr.de>; Wed, 19 Aug 2020 18:32:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726854AbgHSQcc convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fpga@lfdr.de>); Wed, 19 Aug 2020 12:32:32 -0400
Received: from hostingweb31-40.netsons.net ([89.40.174.40]:37842 "EHLO
        hostingweb31-40.netsons.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726640AbgHSQca (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 19 Aug 2020 12:32:30 -0400
Received: from [78.134.86.56] (port=55002 helo=[192.168.77.62])
        by hostingweb31.netsons.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <luca@lucaceresoli.net>)
        id 1k8R0i-000Bvx-2V; Wed, 19 Aug 2020 18:32:24 +0200
Subject: Re: [PATCH 2/3] fpga manager: xilinx-spi: provide better diagnostics
 on programming failure
To:     Tom Rix <trix@redhat.com>, linux-fpga@vger.kernel.org
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
 <397b99e2-9b39-5a67-e1c6-8dcf3482f96b@redhat.com>
From:   Luca Ceresoli <luca@lucaceresoli.net>
Message-ID: <8c055a1d-e8f5-6d23-18c4-cb87d95bbc5a@lucaceresoli.net>
Date:   Wed, 19 Aug 2020 18:32:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <397b99e2-9b39-5a67-e1c6-8dcf3482f96b@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8BIT
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hostingweb31.netsons.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lucaceresoli.net
X-Get-Message-Sender-Via: hostingweb31.netsons.net: authenticated_id: luca@lucaceresoli.net
X-Authenticated-Sender: hostingweb31.netsons.net: luca@lucaceresoli.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 18/08/20 16:21, Tom Rix wrote:
> 
> On 8/18/20 3:20 AM, Luca Ceresoli wrote:
>> [a question for GPIO maintainers below]
>>
>> Hi Tom,
>>
>> thanks for your review!
>>
>> On 17/08/20 20:15, Tom Rix wrote:
>>> The other two patches are fine.
>>>
>>> On 8/17/20 9:59 AM, Luca Ceresoli wrote:
>>>> When the DONE pin does not go high after programming to confirm programming
>>>> success, the INIT_B pin provides some info on the reason. Use it if
>>>> available to provide a more explanatory error message.
>>>>
>>>> Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
>>>> ---
>>>>  drivers/fpga/xilinx-spi.c | 11 ++++++++++-
>>>>  1 file changed, 10 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/fpga/xilinx-spi.c b/drivers/fpga/xilinx-spi.c
>>>> index 502fae0d1d85..2aa942bb1114 100644
>>>> --- a/drivers/fpga/xilinx-spi.c
>>>> +++ b/drivers/fpga/xilinx-spi.c
>>>> @@ -169,7 +169,16 @@ static int xilinx_spi_write_complete(struct fpga_manager *mgr,
>>>>  			return xilinx_spi_apply_cclk_cycles(conf);
>>>>  	}
>>>>  
>>>> -	dev_err(&mgr->dev, "Timeout after config data transfer.\n");
>>>> +	if (conf->init_b) {
>>>> +		int init_b_asserted = gpiod_get_value(conf->init_b);
>>> gpiod_get_value can fail. So maybe need split the first statement.
>>>
>>> init_b_asserted < 0 ? "invalid device"
>>>
>>> As the if-else statement is getting complicated, embedding the ? : makes this hard to read.  'if,else if, else' would be better.
>> Thanks for the heads up. However I'm not sure which is the best thing to
>> do here.
>>
>> First, I've been reading the libgpiod code after your email and yes, the
>> libgpiod code _could_ return runtime errors received from the gpiochip
>> driver, even though the docs state:
>>
>>> The get/set calls do not return errors because “invalid GPIO”> should have been reported earlier from gpiod_direction_*().
>> (https://www.kernel.org/doc/html/latest/driver-api/gpio/consumer.html)
>>
>> On the other hand there are plenty of calls to gpiod_get/set_value in
>> the kernel that don't check for error values. I guess this is because
>> failures getting/setting a GPIO are very uncommon (perhaps impossible
>> with platform GPIO).
>>
>> When still a GPIO get/set operation fails I'm not sure adding thousands
>> of error-checking code lines in hundreds of drivers is the best way to
>> go. I feel like we should have a unique, noisy dev_err() in the error
>> path in libgpio but I was surprised in not finding any [1].
>>
>> Linus, Bartosz, what's your opinion? Should all drivers check for errors
>> after every gpiod_[sg]et_value*() call?
> 
> My opinion is that you know the driver / hw is in a bad state and you
> 
> are trying to convey useful information.  So you should
> 
> be as careful as possible and not assume gpio did not fail.

This patch aims at providing better diagnostics after programming has
already gone bad. Neglecting an error might lead to a misleading error
message, but this doesn't lead programming to fail -- it has failed already.

On the other hand a gpiod_get/set_value() call might fail earlier, along
the normal execution path, and lead to real failures without an error
message emitted after the gpiod call that failed.

Which doesn't mean I'm against your proposal of adding error checking
code. Rather, if we want error checking, we want it mainly in other
places: at the very least at the first usage of each of the GPIOs, maybe
at each usage. Have a look at the beginning of
xilinx_spi_write_complete() [0] for example: if gpiod_get_value() fails
there the driver would think programming has been successfully completed
(DONE asserted). To me this is worse than just printing the wrong error
message.

[0]
https://elixir.bootlin.com/linux/v5.8.2/source/drivers/fpga/xilinx-spi.c#L114

-- 
Luca

