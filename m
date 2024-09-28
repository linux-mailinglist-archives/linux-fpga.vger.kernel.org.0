Return-Path: <linux-fpga+bounces-748-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A33F988F49
	for <lists+linux-fpga@lfdr.de>; Sat, 28 Sep 2024 14:53:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 407621C20C41
	for <lists+linux-fpga@lfdr.de>; Sat, 28 Sep 2024 12:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D2EF187FE2;
	Sat, 28 Sep 2024 12:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SuHUK8lb"
X-Original-To: linux-fpga@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F0531DFF7;
	Sat, 28 Sep 2024 12:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727528030; cv=none; b=jI0svOpizkPQukU4clsencE9OLewCnT52ghDYodQCi1jQTnW9VomAtHqnTp/j+jTwO2WeS72PbypJEDA/1OXUGbnje3jlBIvmt9+meO2bSjJc4DSnZZv4jf2OZ1Jlzy8AIYiqUx68kp1rpJB1o4HwCX58CJp/qA+vwggpLuf9nA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727528030; c=relaxed/simple;
	bh=lXQwcL/7NWG7ExGqevrmOkKKrfoWwNZ/kwtDJvmkYvQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jTfKgWyvaYAAyGJyk2QXJjLC8c3+NbG5uSTHQ84cSUKktuZ2IvEHTay1dH1gV1f6aEWwtfLMqyN/7pSlV4ppyAqbQc9tRitqHnISPuuOR20UH+eTzcJ3hnHiOVRV5MBsrP4QkSl1DCD5sYMIXlRKu2PhYqtsn8xp0nSst2KgGTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SuHUK8lb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B9D4C4CEC3;
	Sat, 28 Sep 2024 12:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727528029;
	bh=lXQwcL/7NWG7ExGqevrmOkKKrfoWwNZ/kwtDJvmkYvQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=SuHUK8lbW1G+8la6edvfe1a9KQFgdB/phyRrc9AvoHruEPkerycv8w5/zwiZ4IH/v
	 sY8rO13eS7SYdBeKeMQHdq0k5ZsG62R4JpT+qzlKbP1gdYVyenRVzbhghQsW1uC1E7
	 Xt4zMOcCBf6loR6VzyLYKDdUubT+dlIQSDbCGMkqG6/93XoS9AFBSJIKRY8FqBkrfK
	 b6mNJ46yKcIaJafjXiskBs0VlCIaewv+CfdDZdI23gsLcIiv74EKQX6snyMQngpvoz
	 itC9UT0qzRIR6XL+HO+FJ2mrt4gdpQY+JF8qLf+pB5mpppAosLHy4KA3GvTA1pyg8+
	 9zzpk4Tp51eEw==
Message-ID: <f57ca7c6-cb60-42cd-bba1-b48144bdef14@kernel.org>
Date: Sat, 28 Sep 2024 14:53:44 +0200
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] dt-bindings: fpga: Add Efinix serial SPI programming
 bindings
To: Ian Dannapel <iansdannapel@gmail.com>
Cc: mdf@kernel.org, hao.wu@intel.com, yilun.xu@intel.com, trix@redhat.com,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 neil.armstrong@linaro.org, heiko.stuebner@cherry.de, rafal@milecki.pl,
 linus.walleij@linaro.org, linux-fpga@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240927141445.157234-1-iansdannapel@gmail.com>
 <20240927141445.157234-2-iansdannapel@gmail.com>
 <dd9ae106-3c39-423b-9413-5a7ca57f7aec@kernel.org>
 <CAKrir7irvRbwCsdjF_NNfWy68wTDfRuyW2oHb90gYgBA=L7-Tg@mail.gmail.com>
 <c6ac1c4d-7f7a-41a9-9f32-55428f88bdfe@kernel.org>
 <CAKrir7iyiDWXQnxMrkDhsRj4+2XEUDBFpHYyfzdJksE_HE62JA@mail.gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <CAKrir7iyiDWXQnxMrkDhsRj4+2XEUDBFpHYyfzdJksE_HE62JA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 28/09/2024 14:33, Ian Dannapel wrote:
>>>>
>>>>> +
>>>>> +  spi-cpha: true
>>>>> +
>>>>> +  spi-cpol: true
>>>>> +
>>>>> +  spi-max-frequency:
>>>>> +    maximum: 25000000
>>>>> +
>>>>> +  reg:
>>>>> +    maxItems: 1
>>>>> +
>>>>> +  creset-gpios:
>>>>
>>>> reset-gpios
>>>>
>>>> Do not invent own properties.
>>>>
>>>>> +    description:
>>>>> +      reset and re-configuration trigger pin (low active)
>>>>> +    maxItems: 1
>>>>> +
>>>>> +  cs-gpios:
>>>>> +    description:
>>>>> +      chip-select pin (low active)
>>>>
>>>> Eee? That's a property of controller, not child. Aren't you duplicating
>>>> existing controller property?
>>> This device uses this pin in combination with the reset to enter the
>>> programming mode. Also, the driver must guarantee that the pin is
>>
>> Isn't this the same on every SPI device?
> Yes, but I was not very clear. In this case the pin must be hold
> active including entering the programming mode. And if the controller

Just like every CS, no?

The only difference is that you must send entire programming sequence
without releasing the CS.

> transfers the data in bursts, the pin is also not allowed to go
> inactive between transfer bursts.
>>
>>> active for the whole transfer process, including ending dummy bits.
>>> This is why I added a warning to NOT use this driver with other
>>> devices on the same bus.
>>
>> Not really related. None of this grants exception from duplicating
>> controller's property.
>>
>> How do you think it will even work in Linux, if same GPIO is requested
>> twice (imagine controller also has it)? Till now, this would be -EBUSY.
> I expected that the controller is not able request the same gpio. From
> the controller point of view, it is a device that does not have a chip
> select. Not sure if the controller would be able to get to this gpio
> if it is not explicitly given.

But it could be given. Don't think only about your case.

Your description earlier clearly suggests it is CS. Description here
suggests it is not a CS.

No clue then.

>>
>> But regardless of implementation, I still do not understand why do you
>> need duplicate same chip-select. Maybe just the naming is the confusion,
>> dunno.
> This could be an option to make the difference to a "real chip-select"
> clear, but it would drift away from the datasheet naming. Eg,
> prog-select?

Please go back to datasheet. Which pin is this? CS, yes or not? If not,
then which other pin is CS?

Best regards,
Krzysztof


