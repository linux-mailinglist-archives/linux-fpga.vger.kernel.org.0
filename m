Return-Path: <linux-fpga+bounces-747-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E1CA988F32
	for <lists+linux-fpga@lfdr.de>; Sat, 28 Sep 2024 14:33:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE414B2145D
	for <lists+linux-fpga@lfdr.de>; Sat, 28 Sep 2024 12:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90D2A185B43;
	Sat, 28 Sep 2024 12:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KPbuWpbd"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D374C14F9E9;
	Sat, 28 Sep 2024 12:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727526832; cv=none; b=jC7fWQzG8/BZICZmddQHixLQqeO3BEk6iMyuauRftfen49UrBrTRDboIsSbvKakpevsqfsWptQhHA3GSzMaC+0PgVbric/WVJAbuXE9jpjt4/k/VdyYC9F6QiNqGinrIKlgrO3XOE92K91goaiHfVw+zHYs6dfyO20kyA+iVcGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727526832; c=relaxed/simple;
	bh=nvx894P26dlpD6v/izFxOgg5M0k5tJSTl1a4We/2Kj0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FeU2s7tnkbK77Uhx00QWPmzTXpb92KbxcxmI6SMYbL8IZEKeKYBnZSOLeuzBDKk5T7rIHnEncTkegeERGCScFEObAXkH47OsnulTDcf7JOcDBuyHq1alsjoTgcRhuXiBR5Ndce8scAzfad7Zot3WOXjEXchsn2IROjtTBhv7ycE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KPbuWpbd; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e25c5ed057dso2966910276.3;
        Sat, 28 Sep 2024 05:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727526830; x=1728131630; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Z+XR7nXFIWwF1tEgi8L5f5pbxumnzjoC+13KxZdr84g=;
        b=KPbuWpbduycFncn64bHC7uwc5fbClyKwL6Ha2o9iboLURGfV8hVFZwoh35wjzJLR/2
         +I2HT0yfg0xA/96KvSIlPa1h3B3OUoxRnrxXdY1eqzzbyZ3yo/4BpcmB+B2b4vOj97ys
         y41lKAEjVOhr6jGlF0ihVaeEXSmQXw/SDxxbgGRXwM4JjpI5JQSKhBW2ylv2q0+ikgG6
         uBwYk1WGIys12v+30zpfiR/xvg9JBvjU1TUd09GfiVehUgL5+mKKufs6y92jhafv24Fg
         9+zV2VIawdJtSbkEeRsvQZmk9pbayY7PeZnkwBzFjWAV6mpWmul0UV63klJxk4UkWvxM
         BumQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727526830; x=1728131630;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z+XR7nXFIWwF1tEgi8L5f5pbxumnzjoC+13KxZdr84g=;
        b=TLoAuKPD2LZDwhYnnCHLHi2Oi1O0dvoSzjZ1opWQ2TA8VpFq3EbCPPYt1yrlsjBbIc
         4FRx+ttRz2h88ESoARU5NKmRK9MTAL4WzyAX6dtPJLXDKxs1PCQfQlYqQQnrQsiu8PO2
         WmQhYw/CuBONPGsY00MdyJZd3qHHA3QsHe8+jiyXRQcBRW+hHlJ9XfevAWOxM9CARWAj
         3PID84Hw0mst2PtdeIw8pBdx5LUvtVbSob+vSyP49qqlf9besA1diK3OO/Himb3u6HTW
         NpIdwq9+U2YM585vgw08EAd2yLFXBlaxaNfzIFmrGRcnyF0LSwcft6jM4lr9iQvsN7lG
         u7Ow==
X-Forwarded-Encrypted: i=1; AJvYcCUmvdPDnnZeyp471gMGiZUgDFr7exMrPq5Z5+rufmiKxb+CMT9frX2imZoRGBStEh2BDZz1j37/s1bCMwRD@vger.kernel.org, AJvYcCWb2/5k2wPwuYHbMyCoM5iBLXxouSpnzH0CKj1j0AE7MGj2D67Bsrh768zfGesDUK6JUPZcxiUJ9BN2Lg==@vger.kernel.org, AJvYcCWv72pG9bqhsNRezyZIFkvvU6gF+RLM/w2kjiB448AaOSqV1R5KTuLNLiZ+4xc3Hx6AI3fCw5cATnsI@vger.kernel.org
X-Gm-Message-State: AOJu0YxU/scJvVXr0CfxzA7zyiRHlxp5xPWoenZdXYKinEetuM7CQV4n
	Vn30VLh1SCrZd78LSe4o9Bqyd9Ipi1ZIa9id94l7+gdMLMqdZK6tVJ7ok2ytEkb2JOvEa8hTEuK
	AIS9Qem6NRY5752BVKNXIylbNKh8=
X-Google-Smtp-Source: AGHT+IGuzjVP7bsAjCecGFeI8L9lM+t7/U8e6etx2Uxw2X/kzAD+ngNPcjxyMYpnPnjO4ciKvtwG+Ps5tRNOy2XjH90=
X-Received: by 2002:a5b:1c2:0:b0:e0e:9195:be85 with SMTP id
 3f1490d57ef6-e2604b487b1mr4523950276.29.1727526829607; Sat, 28 Sep 2024
 05:33:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240927141445.157234-1-iansdannapel@gmail.com>
 <20240927141445.157234-2-iansdannapel@gmail.com> <dd9ae106-3c39-423b-9413-5a7ca57f7aec@kernel.org>
 <CAKrir7irvRbwCsdjF_NNfWy68wTDfRuyW2oHb90gYgBA=L7-Tg@mail.gmail.com> <c6ac1c4d-7f7a-41a9-9f32-55428f88bdfe@kernel.org>
In-Reply-To: <c6ac1c4d-7f7a-41a9-9f32-55428f88bdfe@kernel.org>
From: Ian Dannapel <iansdannapel@gmail.com>
Date: Sat, 28 Sep 2024 14:33:38 +0200
Message-ID: <CAKrir7iyiDWXQnxMrkDhsRj4+2XEUDBFpHYyfzdJksE_HE62JA@mail.gmail.com>
Subject: Re: [PATCH 2/3] dt-bindings: fpga: Add Efinix serial SPI programming bindings
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: mdf@kernel.org, hao.wu@intel.com, yilun.xu@intel.com, trix@redhat.com, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	neil.armstrong@linaro.org, heiko.stuebner@cherry.de, rafal@milecki.pl, 
	linus.walleij@linaro.org, linux-fpga@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Am Sa., 28. Sept. 2024 um 09:31 Uhr schrieb Krzysztof Kozlowski
<krzk@kernel.org>:
>
> On 27/09/2024 17:34, Ian Dannapel wrote:
> > Thanks for the review Krzysztof.
> >
> > Am Fr., 27. Sept. 2024 um 16:26 Uhr schrieb Krzysztof Kozlowski
> > <krzk@kernel.org>:
> >>
> >> On 27/09/2024 16:14, iansdannapel@gmail.com wrote:
> >>> From: Ian Dannapel <iansdannapel@gmail.com>
> >>>
> >>> Add device tree binding documentation for configuring Efinix FPGA
> >>> using serial SPI passive programming mode.
> >>>
> >>> Signed-off-by: Ian Dannapel <iansdannapel@gmail.com>
> >>> ---
> >>>  .../fpga/efinix,trion-spi-passive.yaml        | 85 +++++++++++++++++++
> >>>  1 file changed, 85 insertions(+)
> >>>  create mode 100644 Documentation/devicetree/bindings/fpga/efinix,trion-spi-passive.yaml
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/fpga/efinix,trion-spi-passive.yaml b/Documentation/devicetree/bindings/fpga/efinix,trion-spi-passive.yaml
> >>> new file mode 100644
> >>> index 000000000000..ec6697fa6f44
> >>> --- /dev/null
> >>> +++ b/Documentation/devicetree/bindings/fpga/efinix,trion-spi-passive.yaml
> >>> @@ -0,0 +1,85 @@
> >>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> >>> +%YAML 1.2
> >>> +---
> >>> +$id: http://devicetree.org/schemas/fpga/efinix,trion-spi-passive.yaml#
> >>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >>> +
> >>> +title: Efinix SPI FPGA Manager
> >>> +
> >>> +maintainers:
> >>> +  - Ian Dannapel <iansdannapel@gmail.com>
> >>> +
> >>> +description: |
> >>> +  Efinix Trion and Titanium Series FPGAs support a method of loading the
> >>> +  bitstream over what is referred to as "SPI Passive Programming".
> >>> +  Only serial (1x bus width) is supported, setting the programming mode
> >>> +  is not in the scope the this manager and must be done elsewhere.
> >>> +
> >>> +  Warning: The slave serial link is not technically SPI and therefore it is
> >>> +  not recommended to have other devices on the same bus since it might
> >>> +  interfere or be interfered by other transmissions.
> >>> +
> >>> +  References:
> >>> +  - https://www.efinixinc.com/docs/an033-configuring-titanium-fpgas-v2.6.pdf
> >>> +  - https://www.efinixinc.com/docs/an006-configuring-trion-fpgas-v6.0.pdf
> >>> +
> >>> +allOf:
> >>> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> >>> +
> >>> +properties:
> >>> +  compatible:
> >>> +    enum:
> >>> +      - efinix,trion-spi-passive
> >>> +      - efinix,titanium-spi-passive
> >>
> >> 1. Your driver suggests these are compatible, so make them compatible
> >> with using fallback.
> >>
> >> 2. What is "spi-passive"? Compatible is supposed to be the name of the
> >> device, so I assume this is "trion"? Can trion be anything else than fpga?
> > spi-passive is the programming mode, where the device is in slave
> > mode. There are also other modes, but not supported by this driver.
>
> But we do no describe here drivers, so it does no matter what it supports.
>
> > The name was inspired by similar drivers (spi-xilinx.c). Isn't just
> > "efinix,trion"/"efinix,titanium" too generic?
>
> What do you mean too generic? What else could it be? BTW, that was my
> question, which you did not answer. Bindings describe hardware, so
> describe here hardware.
>
> >>
> >>> +
> >>> +  spi-cpha: true
> >>> +
> >>> +  spi-cpol: true
> >>> +
> >>> +  spi-max-frequency:
> >>> +    maximum: 25000000
> >>> +
> >>> +  reg:
> >>> +    maxItems: 1
> >>> +
> >>> +  creset-gpios:
> >>
> >> reset-gpios
> >>
> >> Do not invent own properties.
> >>
> >>> +    description:
> >>> +      reset and re-configuration trigger pin (low active)
> >>> +    maxItems: 1
> >>> +
> >>> +  cs-gpios:
> >>> +    description:
> >>> +      chip-select pin (low active)
> >>
> >> Eee? That's a property of controller, not child. Aren't you duplicating
> >> existing controller property?
> > This device uses this pin in combination with the reset to enter the
> > programming mode. Also, the driver must guarantee that the pin is
>
> Isn't this the same on every SPI device?
Yes, but I was not very clear. In this case the pin must be hold
active including entering the programming mode. And if the controller
transfers the data in bursts, the pin is also not allowed to go
inactive between transfer bursts.
>
> > active for the whole transfer process, including ending dummy bits.
> > This is why I added a warning to NOT use this driver with other
> > devices on the same bus.
>
> Not really related. None of this grants exception from duplicating
> controller's property.
>
> How do you think it will even work in Linux, if same GPIO is requested
> twice (imagine controller also has it)? Till now, this would be -EBUSY.
I expected that the controller is not able request the same gpio. From
the controller point of view, it is a device that does not have a chip
select. Not sure if the controller would be able to get to this gpio
if it is not explicitly given.
>
> But regardless of implementation, I still do not understand why do you
> need duplicate same chip-select. Maybe just the naming is the confusion,
> dunno.
This could be an option to make the difference to a "real chip-select"
clear, but it would drift away from the datasheet naming. Eg,
prog-select?
>
>
> Best regards,
> Krzysztof
>

Regards,
Ian

