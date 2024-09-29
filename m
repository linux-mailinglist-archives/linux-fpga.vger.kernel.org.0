Return-Path: <linux-fpga+bounces-750-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A9D3F98972C
	for <lists+linux-fpga@lfdr.de>; Sun, 29 Sep 2024 21:49:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAE521C20B28
	for <lists+linux-fpga@lfdr.de>; Sun, 29 Sep 2024 19:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67FA176026;
	Sun, 29 Sep 2024 19:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G/Muj2Pt"
X-Original-To: linux-fpga@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35BCE46434;
	Sun, 29 Sep 2024 19:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727639360; cv=none; b=c/jThlTZ4jxb1qTAcgG8cqB35YhLGUaXVrj89zZyh/Czsq25T0Q0yVLMbnEXidMf665lL0BBVnOF6rbG2klO72IpGbnui3703QBgrZdungzMagXivTf59LG5UI8j8wRg2IEe1fGy9FC3VHcJMEcLvjawAnFQVA2Q+A8B+LXUHdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727639360; c=relaxed/simple;
	bh=rEpYN1LbCEP9bt1XfZB67uBP4cdWXOYbxS2ED/uo1g4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oaly5A4tXWn1VlVOwMGvV/wj5L9FiM9xLvYZuigkw1DjezI5K8cY6dgRy79Oa2UX336a7fsewadleOlOS4pLB004qHjcD8A5UE3gwQfyp82BSBPiNdZ/ndnYwN6CmXQ1OafkJsKl2SNnwEoHuUrqsGBdDpN8n83VPJ8cMrQoMao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G/Muj2Pt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4025AC4CEC5;
	Sun, 29 Sep 2024 19:49:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727639359;
	bh=rEpYN1LbCEP9bt1XfZB67uBP4cdWXOYbxS2ED/uo1g4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G/Muj2Ptr5rTBB7TeDOK18eoUpIvyz2PJFUwExEIj6n8+tb5+GG9IaTexFpSihgcD
	 oxZvpKUPmhGkesrynbcUxGB1CBh1VXQxi6Ae5LMjR8wgCHJi9h/VuPnq+Eeqp65+Lb
	 pciq1j0aBcDI16Knk5adSRN3JQE+rxUE16tlObYcP1RmykU9DSLDwmDZtH3vkf792Y
	 YKZ238wb1283hJ3wTAh2IMW+bMeWzWZH9/D9Lslw2Cozqv4z/dqpQju01/egHjDenz
	 9XkR2iAp99VKwcJ9nu+bakVvcvBzrS2vtorXmal9m6XerV0OYTnDGMYwO2zEQtdWcW
	 jL/AACuT9e3rw==
Date: Sun, 29 Sep 2024 21:49:17 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Ian Dannapel <iansdannapel@gmail.com>
Cc: mdf@kernel.org, hao.wu@intel.com, yilun.xu@intel.com, trix@redhat.com, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	neil.armstrong@linaro.org, heiko.stuebner@cherry.de, rafal@milecki.pl, 
	linus.walleij@linaro.org, linux-fpga@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] dt-bindings: fpga: Add Efinix serial SPI programming
 bindings
Message-ID: <cldodjlatbxjrsjhympium57k2ta35hzets35xfv57gedkqdcg@77dzf7ro5hm5>
References: <20240927141445.157234-1-iansdannapel@gmail.com>
 <20240927141445.157234-2-iansdannapel@gmail.com>
 <dd9ae106-3c39-423b-9413-5a7ca57f7aec@kernel.org>
 <CAKrir7irvRbwCsdjF_NNfWy68wTDfRuyW2oHb90gYgBA=L7-Tg@mail.gmail.com>
 <c6ac1c4d-7f7a-41a9-9f32-55428f88bdfe@kernel.org>
 <CAKrir7iyiDWXQnxMrkDhsRj4+2XEUDBFpHYyfzdJksE_HE62JA@mail.gmail.com>
 <f57ca7c6-cb60-42cd-bba1-b48144bdef14@kernel.org>
 <CAKrir7hfMww8GgxEbDd-WWhXmXD-q6=xddfy1GATr9JnF5Xohg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAKrir7hfMww8GgxEbDd-WWhXmXD-q6=xddfy1GATr9JnF5Xohg@mail.gmail.com>

On Sat, Sep 28, 2024 at 04:26:03PM +0200, Ian Dannapel wrote:
> Am Sa., 28. Sept. 2024 um 14:53 Uhr schrieb Krzysztof Kozlowski
> <krzk@kernel.org>:
> >
> > On 28/09/2024 14:33, Ian Dannapel wrote:
> > >>>>
> > >>>>> +
> > >>>>> +  spi-cpha: true
> > >>>>> +
> > >>>>> +  spi-cpol: true
> > >>>>> +
> > >>>>> +  spi-max-frequency:
> > >>>>> +    maximum: 25000000
> > >>>>> +
> > >>>>> +  reg:
> > >>>>> +    maxItems: 1
> > >>>>> +
> > >>>>> +  creset-gpios:
> > >>>>
> > >>>> reset-gpios
> > >>>>
> > >>>> Do not invent own properties.
> > >>>>
> > >>>>> +    description:
> > >>>>> +      reset and re-configuration trigger pin (low active)
> > >>>>> +    maxItems: 1
> > >>>>> +
> > >>>>> +  cs-gpios:
> > >>>>> +    description:
> > >>>>> +      chip-select pin (low active)
> > >>>>
> > >>>> Eee? That's a property of controller, not child. Aren't you duplic=
ating
> > >>>> existing controller property?
> > >>> This device uses this pin in combination with the reset to enter the
> > >>> programming mode. Also, the driver must guarantee that the pin is
> > >>
> > >> Isn't this the same on every SPI device?
> > > Yes, but I was not very clear. In this case the pin must be hold
> > > active including entering the programming mode. And if the controller
> >
> > Just like every CS, no?
> >
> > The only difference is that you must send entire programming sequence
> > without releasing the CS.
> >
> > > transfers the data in bursts, the pin is also not allowed to go
> > > inactive between transfer bursts.
> > >>
> > >>> active for the whole transfer process, including ending dummy bits.
> > >>> This is why I added a warning to NOT use this driver with other
> > >>> devices on the same bus.
> > >>
> > >> Not really related. None of this grants exception from duplicating
> > >> controller's property.
> > >>
> > >> How do you think it will even work in Linux, if same GPIO is request=
ed
> > >> twice (imagine controller also has it)? Till now, this would be -EBU=
SY.
> > > I expected that the controller is not able request the same gpio. From
> > > the controller point of view, it is a device that does not have a chip
> > > select. Not sure if the controller would be able to get to this gpio
> > > if it is not explicitly given.
> >
> > But it could be given. Don't think only about your case.
> it won't work if the controller also may request this gpio or interfere w=
ith it.

Then your binding is incomplete, I would say. What stops anyone from
providing the same GPIO for CS in controller node, like typical bindings
expect?

> >
> > Your description earlier clearly suggests it is CS. Description here
> > suggests it is not a CS.
> >
> > No clue then.
> >
> > >>
> > >> But regardless of implementation, I still do not understand why do y=
ou
> > >> need duplicate same chip-select. Maybe just the naming is the confus=
ion,
> > >> dunno.
> > > This could be an option to make the difference to a "real chip-select"
> > > clear, but it would drift away from the datasheet naming. Eg,
> > > prog-select?
> >
> > Please go back to datasheet. Which pin is this? CS, yes or not? If not,
> > then which other pin is CS?
> Yes, this pin in question is referred to as the Chip Select (CS) or
> Slave Select in the datasheet and pinout.
> It is used in combination with the reset for entering the programming
> mode and then used for the SPI data transfer to the FPGA=E2=80=99s volati=
le
> configuration RAM.
> There must be no state change on this CS pin between entering
> programming mode and the completion of the SPI transfer.

You just described CS gpio in parent controller node.

> Since the controller chip-select functionality can't fulfill these
> requirements for this device, the proposed solution is to move this
> pin from the controller to the child driver.

You mix two different things. Where the property should be described and
how it should be handled. child driver is not the matter of bindings.

Best regards,
Krzysztof


