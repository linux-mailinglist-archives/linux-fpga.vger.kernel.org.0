Return-Path: <linux-fpga+bounces-749-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DE42988F9E
	for <lists+linux-fpga@lfdr.de>; Sat, 28 Sep 2024 16:26:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 145CE1F2178F
	for <lists+linux-fpga@lfdr.de>; Sat, 28 Sep 2024 14:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5643188911;
	Sat, 28 Sep 2024 14:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kv0zVEoY"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395E9188736;
	Sat, 28 Sep 2024 14:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727533576; cv=none; b=Zmu1DEjeOwuBGmtcRusxofyda06DQWIhJY5i9XfBioyp1vr8FoCiLwV1VHUOD/hi0F9UkERcSR4D+4OmsE74gMdNwNI19+taMeA6M+eTZqwgM+ANyvgQCmm2LJMAJy9+mGxMR97/WHS7SlElEA2WVQeZN1jY9N0XsTUU5nvFf2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727533576; c=relaxed/simple;
	bh=CqACvt4uPObOZuE6ZysyiZbqZ+n1Gy2VqWBmupvIcQQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BY+Jl0X3O9IZekf+s+BG6zTyzzXd0llbI7LcLzgKvMv/q0JPfHe8e+OpKzp1DA0d45UUvR0kgG1W5vpg1aDtMWCldii9B+/L2aHegvnTUQrXbcxPrLiDpd1y8ZjRXJPVArjP7xFpuRlxNolEsWYXqbr4lP7HSj/vBchKacEoT28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kv0zVEoY; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e25cb91f3b3so2946164276.1;
        Sat, 28 Sep 2024 07:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727533574; x=1728138374; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oR+0oOiN8d/1wYicxD2JwSqLGDZwlCg3FFKs5UVXkaQ=;
        b=kv0zVEoYUdD9jdCDWp299AboKwziNwbwVVSYtdsf05v8K5saXKwoObVcucj4GR+kcR
         DeLXnmMZaBvLjrMs4r43tfAQrKF5lMNn+4Y1HniwVz/w2BrbBT2Cet/AmYkbsSofmYO/
         ZvUZka/bUA18puQGhf2Wz7Z362/gkUXRXQb+cEcHkwtT7HO90um7lNGsZ8ohmr85VR5l
         9lQmtxn2Ol+yJKzs7vIXQdfGr5wCR1QN4qr9t/53DkSY9EH2FJ/iDEa20hfiA29mfX9z
         Z0x/YQEFk9v5gOWX8F/gFJjZ1unxaFmtpczvf6HpAI+WTjECqklR8lhMg3/+bRxVPG5i
         Eu+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727533574; x=1728138374;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oR+0oOiN8d/1wYicxD2JwSqLGDZwlCg3FFKs5UVXkaQ=;
        b=A4z2E+1DKe6RnzadjNZyfe5bGqvmv5/73PObRkNTtVDPsGQUvWMsXXPEMbPCKe/VwD
         N6KmrjbJPIMFReWfks2/TfNv33R+y7eppkMmTRAwAUWcapAOQbHyEbgZfnmhRHnXzp2h
         YMZ5v6z/WNYx/lynhDnUh01AafrITGCZsXnPmmgPHpVxDVXbh4Fj2OhwfOEaPgUwEi0o
         o3omskguxdOxONW8a234gSJ32dNbMqBVswWyWxoLeNQGRSDylkbDg758JF/AJijlUad/
         q+p+0BmLFcHynCtk1rW7jlIKobKz3l8oOCW1fcSNV4IygS1wDCS4Kqwg107+EXromaxC
         fBAg==
X-Forwarded-Encrypted: i=1; AJvYcCU5rZZKiCLX/25rcmvn2598e0v8MpKf2TDuHy35K5ADZ8Z2cTqgIBxSO9mQClSJGHsL5Nl5cMUK4wzlTlFO@vger.kernel.org, AJvYcCU6Icjkm43HXY+ADyKsHYyJ/T1Z6ban8r4q6zxhAusBBa4vRjkNvEGti2T1f4DdxdkIrRiGNgQN2xd1@vger.kernel.org, AJvYcCXLtbROqPLLmke9cxe3DdeyjC7wWQN7Rgljx9wizCopvqr2ZZt93HW6hXsMnSMT8YnWbsh4rnSJJquBhw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy515IfLQZRKhImESdlYyldsLKijzqOGt8a6ORbqXZiGMUv78IU
	MZ0hKsay7eiIumy5uEKHQb3pjkGqk1X0h/7xJIL2qkhY7lahctMhhoVlggDigBEekPR8q91kLPn
	EaAMO2LogOng1VgQMgcVlQE+Am1o=
X-Google-Smtp-Source: AGHT+IH3PnqrIfD196KWiWq7zGkumFiC9yGM8Nc1vv/w+CjbKYRbXBPsh2nOXQj9kirbOcjpp+BnnIOXrKb8zy0u7L0=
X-Received: by 2002:a05:6902:238a:b0:e25:d554:c06d with SMTP id
 3f1490d57ef6-e2604b5f495mr5743887276.7.1727533573882; Sat, 28 Sep 2024
 07:26:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240927141445.157234-1-iansdannapel@gmail.com>
 <20240927141445.157234-2-iansdannapel@gmail.com> <dd9ae106-3c39-423b-9413-5a7ca57f7aec@kernel.org>
 <CAKrir7irvRbwCsdjF_NNfWy68wTDfRuyW2oHb90gYgBA=L7-Tg@mail.gmail.com>
 <c6ac1c4d-7f7a-41a9-9f32-55428f88bdfe@kernel.org> <CAKrir7iyiDWXQnxMrkDhsRj4+2XEUDBFpHYyfzdJksE_HE62JA@mail.gmail.com>
 <f57ca7c6-cb60-42cd-bba1-b48144bdef14@kernel.org>
In-Reply-To: <f57ca7c6-cb60-42cd-bba1-b48144bdef14@kernel.org>
From: Ian Dannapel <iansdannapel@gmail.com>
Date: Sat, 28 Sep 2024 16:26:03 +0200
Message-ID: <CAKrir7hfMww8GgxEbDd-WWhXmXD-q6=xddfy1GATr9JnF5Xohg@mail.gmail.com>
Subject: Re: [PATCH 2/3] dt-bindings: fpga: Add Efinix serial SPI programming bindings
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: mdf@kernel.org, hao.wu@intel.com, yilun.xu@intel.com, trix@redhat.com, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	neil.armstrong@linaro.org, heiko.stuebner@cherry.de, rafal@milecki.pl, 
	linus.walleij@linaro.org, linux-fpga@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Am Sa., 28. Sept. 2024 um 14:53 Uhr schrieb Krzysztof Kozlowski
<krzk@kernel.org>:
>
> On 28/09/2024 14:33, Ian Dannapel wrote:
> >>>>
> >>>>> +
> >>>>> +  spi-cpha: true
> >>>>> +
> >>>>> +  spi-cpol: true
> >>>>> +
> >>>>> +  spi-max-frequency:
> >>>>> +    maximum: 25000000
> >>>>> +
> >>>>> +  reg:
> >>>>> +    maxItems: 1
> >>>>> +
> >>>>> +  creset-gpios:
> >>>>
> >>>> reset-gpios
> >>>>
> >>>> Do not invent own properties.
> >>>>
> >>>>> +    description:
> >>>>> +      reset and re-configuration trigger pin (low active)
> >>>>> +    maxItems: 1
> >>>>> +
> >>>>> +  cs-gpios:
> >>>>> +    description:
> >>>>> +      chip-select pin (low active)
> >>>>
> >>>> Eee? That's a property of controller, not child. Aren't you duplicat=
ing
> >>>> existing controller property?
> >>> This device uses this pin in combination with the reset to enter the
> >>> programming mode. Also, the driver must guarantee that the pin is
> >>
> >> Isn't this the same on every SPI device?
> > Yes, but I was not very clear. In this case the pin must be hold
> > active including entering the programming mode. And if the controller
>
> Just like every CS, no?
>
> The only difference is that you must send entire programming sequence
> without releasing the CS.
>
> > transfers the data in bursts, the pin is also not allowed to go
> > inactive between transfer bursts.
> >>
> >>> active for the whole transfer process, including ending dummy bits.
> >>> This is why I added a warning to NOT use this driver with other
> >>> devices on the same bus.
> >>
> >> Not really related. None of this grants exception from duplicating
> >> controller's property.
> >>
> >> How do you think it will even work in Linux, if same GPIO is requested
> >> twice (imagine controller also has it)? Till now, this would be -EBUSY=
.
> > I expected that the controller is not able request the same gpio. From
> > the controller point of view, it is a device that does not have a chip
> > select. Not sure if the controller would be able to get to this gpio
> > if it is not explicitly given.
>
> But it could be given. Don't think only about your case.
it won't work if the controller also may request this gpio or interfere wit=
h it.
>
> Your description earlier clearly suggests it is CS. Description here
> suggests it is not a CS.
>
> No clue then.
>
> >>
> >> But regardless of implementation, I still do not understand why do you
> >> need duplicate same chip-select. Maybe just the naming is the confusio=
n,
> >> dunno.
> > This could be an option to make the difference to a "real chip-select"
> > clear, but it would drift away from the datasheet naming. Eg,
> > prog-select?
>
> Please go back to datasheet. Which pin is this? CS, yes or not? If not,
> then which other pin is CS?
Yes, this pin in question is referred to as the Chip Select (CS) or
Slave Select in the datasheet and pinout.
It is used in combination with the reset for entering the programming
mode and then used for the SPI data transfer to the FPGA=E2=80=99s volatile
configuration RAM.
There must be no state change on this CS pin between entering
programming mode and the completion of the SPI transfer.
Since the controller chip-select functionality can't fulfill these
requirements for this device, the proposed solution is to move this
pin from the controller to the child driver.
>
> Best regards,
> Krzysztof
>
Best regards
Ian

