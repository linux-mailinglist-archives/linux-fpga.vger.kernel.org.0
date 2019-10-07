Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C3623CE4F7
	for <lists+linux-fpga@lfdr.de>; Mon,  7 Oct 2019 16:18:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728111AbfJGOSn (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 7 Oct 2019 10:18:43 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37430 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726334AbfJGOSm (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 7 Oct 2019 10:18:42 -0400
Received: by mail-pf1-f196.google.com with SMTP id y5so8767549pfo.4;
        Mon, 07 Oct 2019 07:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=t1mrLZXO/jxwuKLpUxmNHwQxyP6fiweNueFwmQYCfLk=;
        b=ofoS2PZtCYLW9R2/Uu1yFc6+T2w95dJ77T8QunqWPADdWe/BSoIczCt0YKEAPj2i2D
         jgJcu9CGzPInjX/ZfDMl6su4u627zqkkjbkUSldRLNcb6ZcvoYatQ2PFB/FvZK9dajYs
         1GgMAd9cdS2Wj5x9mqneg5/Uz2OHeSou4sAvz2RxhWzUWO+0aONPtdtaW38k2gGR7Jtq
         mZfFZ7dtMBBxakOcdFHTuy07t5PexYpbqSH845wulICBMBPCY4ZVo6kBba20G7g88hk+
         7gLhG+TUlp7XjtfrsZyaQw2LmhmJ26H7aFGjk0b4YhovX2Mwv8TuGRTZv0smMuzwFcTC
         RTow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=t1mrLZXO/jxwuKLpUxmNHwQxyP6fiweNueFwmQYCfLk=;
        b=t7hAO5qHjHeSuN5N0e/0ZIPP5uoJl5rOc2849QSbhg60IXXH9k4PZNOpCiA4ObkEtu
         8mPeUYZs/q5jnBZke8gsr4ZNB7XEEBk55h0qP3DAMDzdprIaQ8PUolCC/NM7//9Ff46z
         U2MDai8TXyV1EaD0ac/Sd5VlffICcw2UW+3Y2bv1C0QY/vlSY4d/2Qv5T3WbZKvegbKZ
         qF7IRAVamqiBpJ/Ujgw7C9kLwCB5Qj7yG2iP6sPLnpm1XD6yeHpXV0qjHUq8uZmVz6Jb
         ethEHPh0wrNZY6mIII6OfpCwCTXGaGiMMwohCTSJGFSTGCY4YBRuL4/EZq43XbwjkGAP
         tifg==
X-Gm-Message-State: APjAAAXuBAZFGuEIOU3/cmD2PJACg9WTydRq2u9305a0V2QJSaSGVEGS
        eKvvYU+VxWyjeOcfPICSu4o=
X-Google-Smtp-Source: APXvYqwzwetxIrLFm6Goh4cn7kHOBzCs2yV2qBisWPHnXeRV9P/rl78Yrb/lUSynwb1qs0ctyMUVHw==
X-Received: by 2002:a17:90a:7105:: with SMTP id h5mr34080814pjk.107.1570457920487;
        Mon, 07 Oct 2019 07:18:40 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id b69sm17251767pfb.132.2019.10.07.07.18.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Oct 2019 07:18:39 -0700 (PDT)
Subject: Re: [PATCH 2/3] hwmon: Support ADI Fan Control IP
To:     "Sa, Nuno" <Nuno.Sa@analog.com>
Cc:     "mdf@kernel.org" <mdf@kernel.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "jdelvare@suse.com" <jdelvare@suse.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
References: <20190926103925.194973-1-nuno.sa@analog.com>
 <20190926103925.194973-3-nuno.sa@analog.com>
 <20191006153209.GA30372@roeck-us.net>
 <9a3bec277caaabffb75248ddc6fbb89b5d95da5b.camel@analog.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <8f6e8513-eba1-39ad-cb7c-d92afa9e0b92@roeck-us.net>
Date:   Mon, 7 Oct 2019 07:18:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <9a3bec277caaabffb75248ddc6fbb89b5d95da5b.camel@analog.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 10/7/19 6:52 AM, Sa, Nuno wrote:
[ ... ]
>>> +static long axi_fan_control_get_pwm_duty(const struct
>>> axi_fan_control_data *ctl)
>>> +{
>>> +	u32 pwm_width = axi_fan_control_ioread(ADI_REG_PWM_WIDTH, ctl);
>>> +	u32 pwm_period = axi_fan_control_ioread(ADI_REG_PWM_PERIOD,
>>> ctl);
>>> +
>>> +	return DIV_ROUND_CLOSEST(pwm_width * SYSFS_PWM_MAX,
>>> pwm_period);
>>
>> Is pwm_period guaranteed to be != 0 ?
> 
> Yes, It is a RO register and it is set by the core with the default of
> 0x4e20.

Trusting the hardware doesn't make me too comfortable. Are we sure at all
times that the HW isn't messed up ? If so, please at least add a comment
stating that the HW will never return 0. We can then fix it after we get
the first crash report from the field ;-).

[ ... ]

>>> +	if (irq_pending & ADI_IRQ_SRC_TEMP_INCREASE)
>>> +		/* hardware requested a new pwm */
>>> +		ctl->hw_pwm_req = true;
>>> +
>> I don't really understand the logic here. If
>> ADI_IRQ_SRC_TEMP_INCREASE means
>> that hardware wants a new pwm, how is userspace informed about that
>> request ?
> 
> It isn't. Userspace would have to read the pwm attribute and figure
> that changed. Should I use something like sysfs_notify() on the pwm
> attribute?
> 
That might make sense.

>> And why are the tacho paramaters _not_ updated in this case later on
>> (unless
>> ADI_IRQ_SRC_PWM_CHANGED and ADI_IRQ_SRC_TEMP_INCREASE are both set) ?
>> It might be useful to describe the expected sequence of events.
> 
> The core can change the PWM by itself (which is when we receive
> ADI_IRQ_SRC_TEMP_INCREASE) and in that case it will use predefined
> values to evaluate the tacho signal (so it won't use the values on
> TACH_PERIOD and TACH_TOLERANCE). Alternatively, the user can request a
> new PWM by writing the pwm attribute. In this case the CORE is
> expecting that TACH_PERIOD and TACH_TOLERANCE are given otherwise it
> won't evaluate the tacho signal. Note that when is the user which
> requests a new pwm we only get ADI_IRQ_SRC_PWM_CHANGED (and not +	
> if (irq_pending & ADI_IRQ_SRC_TEMP_INCREASE), so I use that to know
> when do I have to update the tacho parameters.
>   
Wondering ... if setting the pwm requires an update of period and tolerance,
why not set update_tacho_params to true when the pwm value is written, or
update the registers directly instead of waiting for an interrupt ?

Either case, I think the above sequence of events should be explained
in the driver for future developers to understand why the code is written
the way it is.

>>>
> )
> 
>>> +	if (irq_pending & ADI_IRQ_SRC_TACH_ERR)
>>> +		ctl->fan_fault = 1;
>>
>> Is it on purpose that this bit is never reset ?
> 
> Yes, and it is wrong. I though that the core would never clear this
> alarm but it does clear it in the next temperature reading cycle (and
> set it again if needed). Then, would a clear on read be a correct
> approach?

Not sure if there is a "correct", but I think it would make sense.

>>
>>> +
>>> +	/* clear all interrupts */
>>> +	clear_mask = irq_pending & ADI_IRQ_SRC_MASK;
>>> +	axi_fan_control_iowrite(clear_mask, ADI_REG_IRQ_PENDING, ctl);
>>> +
>>> +	return IRQ_HANDLED;
>>> +}
>>> +
>>> +static int axi_fan_control_init(struct axi_fan_control_data *ctl,
>>> +				const struct device_node *np)
>>> +{
>>> +	int ret;
>>> +
>>> +	/* get fan pulses per revolution */
>>> +	ret = of_property_read_u32(np, "adi,pulses-per-revolution",
>>> &ctl->ppr);
>>> +	if (ret)
>>> +		return ret;
>>
>> So all random values are acceptable, including 0 and 0xffffffff ?
> 
> Yes, I'm aware that 1 and 2 are typical values but I'm not sure what is
> the maximum that typically exists so I didn't want to put limits here
> without knowing. Though at least 0 must not be accepted since then we
> are always dividing by 0 when reading the FAN rpm.
> 
The only values I am aware of are 2 and 4. I don't recall seeing any fans
with 1 pulse per revolution. Overall, I don't think values other than 1, 2,
and 4 make sense.

Guenter
