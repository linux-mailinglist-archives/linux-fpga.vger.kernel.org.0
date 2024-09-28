Return-Path: <linux-fpga+bounces-746-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC0C4988E2A
	for <lists+linux-fpga@lfdr.de>; Sat, 28 Sep 2024 09:31:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4184D1F21D8B
	for <lists+linux-fpga@lfdr.de>; Sat, 28 Sep 2024 07:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB6DA19B3C3;
	Sat, 28 Sep 2024 07:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R3BETcDc"
X-Original-To: linux-fpga@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD581859;
	Sat, 28 Sep 2024 07:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727508715; cv=none; b=dlIwi7G9z666SRF+r+ywJ0Ai4CcPByE94QuaB5RLiRrXjlfBIC3jGhptwieV3i9bjrkpjm29iw5e69mlyGikQjwxWebubK4YVTDqqwlPt4CeILfi8R6vk+DW32cVxU8croiTxqJmm3LvY+1ud4Ree9mmmulYXktsizzNTvKYAuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727508715; c=relaxed/simple;
	bh=YcrXNs/yZ3nUKsxdQjoyr6fgGMjvgH7aNff0uH5SnmM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uMDZkPOSZNptKoEU/rd4xYFLlkNcTLiiFfpjfzFFo4YUiovMaJxiwibABIZ+yOt8sEL3FRy5t3WvLRsoCN/NRFQl8lm6hKEM5iTMttxyNRrlcZsiMb1rmnYyazCmixt4lg53RHrzr6MnH0W9zK8TcP1YKKw9er2uFe7U0WKhmGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R3BETcDc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FD18C4CEC3;
	Sat, 28 Sep 2024 07:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727508715;
	bh=YcrXNs/yZ3nUKsxdQjoyr6fgGMjvgH7aNff0uH5SnmM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=R3BETcDczWPBOkAwWqlYT3rF7Rr1HoHrUjo03Mpq6WSKnXVmwvWD6F/I40zjZ+QCt
	 Vu5BNQGNluzg9w5Km0JGCXiE3bpqIhL/ERIVXdyqH27s09y7VhMU2G+WiSx3gqr2X3
	 nZ9zWVZmj3XLk/0ZjBcJKSaukPaLR4TxhhO6MxzL1gcfJfxIX8L3c+gKNQEhNLisOe
	 SBh9eL8YHa5z9CspjhkRs9dmgYYmDFzBg+V/v1OSRPkSNZUJCj3I4LizFBV+Y75iKQ
	 hZlMjA7pRd03s29Y+1cuIGsa2Y/caMS+3Wl2gMdW1bYrdO3dpWLKT0zy+GB03Ecy6N
	 zVjdi/QqTcaAQ==
Message-ID: <c6ac1c4d-7f7a-41a9-9f32-55428f88bdfe@kernel.org>
Date: Sat, 28 Sep 2024 09:31:49 +0200
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
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <CAKrir7irvRbwCsdjF_NNfWy68wTDfRuyW2oHb90gYgBA=L7-Tg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 27/09/2024 17:34, Ian Dannapel wrote:
> Thanks for the review Krzysztof.
> 
> Am Fr., 27. Sept. 2024 um 16:26 Uhr schrieb Krzysztof Kozlowski
> <krzk@kernel.org>:
>>
>> On 27/09/2024 16:14, iansdannapel@gmail.com wrote:
>>> From: Ian Dannapel <iansdannapel@gmail.com>
>>>
>>> Add device tree binding documentation for configuring Efinix FPGA
>>> using serial SPI passive programming mode.
>>>
>>> Signed-off-by: Ian Dannapel <iansdannapel@gmail.com>
>>> ---
>>>  .../fpga/efinix,trion-spi-passive.yaml        | 85 +++++++++++++++++++
>>>  1 file changed, 85 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/fpga/efinix,trion-spi-passive.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/fpga/efinix,trion-spi-passive.yaml b/Documentation/devicetree/bindings/fpga/efinix,trion-spi-passive.yaml
>>> new file mode 100644
>>> index 000000000000..ec6697fa6f44
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/fpga/efinix,trion-spi-passive.yaml
>>> @@ -0,0 +1,85 @@
>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/fpga/efinix,trion-spi-passive.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: Efinix SPI FPGA Manager
>>> +
>>> +maintainers:
>>> +  - Ian Dannapel <iansdannapel@gmail.com>
>>> +
>>> +description: |
>>> +  Efinix Trion and Titanium Series FPGAs support a method of loading the
>>> +  bitstream over what is referred to as "SPI Passive Programming".
>>> +  Only serial (1x bus width) is supported, setting the programming mode
>>> +  is not in the scope the this manager and must be done elsewhere.
>>> +
>>> +  Warning: The slave serial link is not technically SPI and therefore it is
>>> +  not recommended to have other devices on the same bus since it might
>>> +  interfere or be interfered by other transmissions.
>>> +
>>> +  References:
>>> +  - https://www.efinixinc.com/docs/an033-configuring-titanium-fpgas-v2.6.pdf
>>> +  - https://www.efinixinc.com/docs/an006-configuring-trion-fpgas-v6.0.pdf
>>> +
>>> +allOf:
>>> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
>>> +
>>> +properties:
>>> +  compatible:
>>> +    enum:
>>> +      - efinix,trion-spi-passive
>>> +      - efinix,titanium-spi-passive
>>
>> 1. Your driver suggests these are compatible, so make them compatible
>> with using fallback.
>>
>> 2. What is "spi-passive"? Compatible is supposed to be the name of the
>> device, so I assume this is "trion"? Can trion be anything else than fpga?
> spi-passive is the programming mode, where the device is in slave
> mode. There are also other modes, but not supported by this driver.

But we do no describe here drivers, so it does no matter what it supports.

> The name was inspired by similar drivers (spi-xilinx.c). Isn't just
> "efinix,trion"/"efinix,titanium" too generic?

What do you mean too generic? What else could it be? BTW, that was my
question, which you did not answer. Bindings describe hardware, so
describe here hardware.

>>
>>> +
>>> +  spi-cpha: true
>>> +
>>> +  spi-cpol: true
>>> +
>>> +  spi-max-frequency:
>>> +    maximum: 25000000
>>> +
>>> +  reg:
>>> +    maxItems: 1
>>> +
>>> +  creset-gpios:
>>
>> reset-gpios
>>
>> Do not invent own properties.
>>
>>> +    description:
>>> +      reset and re-configuration trigger pin (low active)
>>> +    maxItems: 1
>>> +
>>> +  cs-gpios:
>>> +    description:
>>> +      chip-select pin (low active)
>>
>> Eee? That's a property of controller, not child. Aren't you duplicating
>> existing controller property?
> This device uses this pin in combination with the reset to enter the
> programming mode. Also, the driver must guarantee that the pin is

Isn't this the same on every SPI device?

> active for the whole transfer process, including ending dummy bits.
> This is why I added a warning to NOT use this driver with other
> devices on the same bus.

Not really related. None of this grants exception from duplicating
controller's property.

How do you think it will even work in Linux, if same GPIO is requested
twice (imagine controller also has it)? Till now, this would be -EBUSY.

But regardless of implementation, I still do not understand why do you
need duplicate same chip-select. Maybe just the naming is the confusion,
dunno.


Best regards,
Krzysztof


