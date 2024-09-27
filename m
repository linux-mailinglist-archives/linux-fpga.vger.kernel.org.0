Return-Path: <linux-fpga+bounces-745-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E5E0E988856
	for <lists+linux-fpga@lfdr.de>; Fri, 27 Sep 2024 17:35:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D31B1C2100D
	for <lists+linux-fpga@lfdr.de>; Fri, 27 Sep 2024 15:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C47581BFE13;
	Fri, 27 Sep 2024 15:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FShUV+3T"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF30A2D;
	Fri, 27 Sep 2024 15:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727451312; cv=none; b=Vo4Hg+ldchTGkCGdMgEb7SdsccaSoZpYYrnFBirA4OA6Q0CeUH9tuZIaOmvQKlLEFCBAfPrEOIKXUjizMZYSIPgm62U7Sz8EOM7hjaQosFOcFOI94JDsAQ7flfF8Se4iGnxfPSufbO2TRGlaaO4GSGSU3QMc4gVWEzCOhIoE874=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727451312; c=relaxed/simple;
	bh=KWiqkGb44uCl2lQmMMXoHG2mJyoihIc+Bd7VB2Ess+o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J+t3swCisRyixgW6IbtUAD9MRkdTywLEs3A1QeQ2Veml4oOQt8cccC1UUmIf5Z1KvzbeURh43rQtvwPpg7EIAr4qgl8yDHZsfz73+HGu3avbCPlJnd/DBVIBVfSpgy7xVmZ990IdxGSj7OjDehQFGa9JaDSLM7OAkOG2YSsjEyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FShUV+3T; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e026a2238d8so2276680276.0;
        Fri, 27 Sep 2024 08:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727451309; x=1728056109; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OkjIuAs2YAv8rv1r4DmkhZ5+/9ilK5MYdkrmnv3HCoc=;
        b=FShUV+3TeyDb2B6BjkwpKRxA1E6qCX0QxeYP0o0xcZFuEaMhPDxL0GxhH0RrJVkuEC
         rt+WVK879EdSD2g36/elnWpi1uTXhzu+7E0ENV8sYncRSgu6xowUotZdLhEbtN6vxmbv
         UYGN+8fwHySSaUL7cFhxKC03Cc5eYxkbdC9e7sHePjXuk34xFH8mq2PXQvx8dHKFdeo1
         MZ7ZVOOFPiBrFzzeZGjjrHYN0PdijWeB0Q+887E9oeM7LpvDK3D/KDcOYV9JckfS/DTn
         34m98IGupXjSBouyLpN2iijBewnAUF7Z5n5xnZATR9i5VnzrfsRlASQ+dZW5T72Tqr+4
         eGJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727451309; x=1728056109;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OkjIuAs2YAv8rv1r4DmkhZ5+/9ilK5MYdkrmnv3HCoc=;
        b=C9Q4NoMfIksvt15y16JqizkT0Eb52KEcvNUf3EJ6ox2mT000pACPHuRzbYYsK1kp7y
         oXDdE4iZ8A+uuSW4DuCX5K65B+kQ4aFfyYfH9F7/zJ/yXw13em336vNSNcv4Qjg6EjUv
         cTVWoyyqJGOojpkoWGYsgJiu8HYgP+WQCyn5XPXiwgDcvn4FCb5mlucoBOvJEgBzV1Za
         U1I7bc9B/tVurQDj9rKlPPllDvdk2Xnip/yUMzg+Qt2rdjrGG7+WC+Cxkeqiot8ob4vB
         +3iNbCdjzhUke0i1gNN1JdRjph7Qfl23Ygkcpee+f4osNYIAqnvU4aTov4uhnAsOmE2t
         DL4Q==
X-Forwarded-Encrypted: i=1; AJvYcCU5yRbyOvL7MixjevEjCekAws5lGJVK5tlB3SZ+iCnj6u6+IVRyBOc1R+JPgR/dTPjJcPf0+9mQSUyeRQ==@vger.kernel.org, AJvYcCVvvxeST2FMR4wdDaOB46I5XcynJK71QbmGjoE5Xh6amnk1D7irYsd4P4j/Y8OLIOaKsUVMAwPd0yqB@vger.kernel.org, AJvYcCX+XsdWT5xsVt2ca1kdK26p+CR9V9vtG/ThGtLR8o1BEaWdp8+WMzLb5DxxyxLXf/3tnEC0Pwic4vBC3LEb@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9Mi8h76l/Icu26TgRKznm5AlJ81HzPnx+jil7UFlop0pfmRZQ
	1iw+93se1tnZgf+Eg63OpegFRcvORel8kPAgi+dIQz+IPaned5DVb7V0d0IlJWIFlVcn+ktPp+q
	yT7S+Ztio4YS2jbXXqiL8h3Fb0yI=
X-Google-Smtp-Source: AGHT+IHNqoBNrjaN/muDbkbee0O4BUeveW5kk0CXzvo0C1B+ZXkb+LpCIJlAoLW2k7z2DIhoZ7Djtveav1EOaNXCBfU=
X-Received: by 2002:a05:6902:c0d:b0:e24:9850:cd1f with SMTP id
 3f1490d57ef6-e2604b3c605mr2559290276.16.1727451308897; Fri, 27 Sep 2024
 08:35:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240927141445.157234-1-iansdannapel@gmail.com>
 <20240927141445.157234-2-iansdannapel@gmail.com> <dd9ae106-3c39-423b-9413-5a7ca57f7aec@kernel.org>
In-Reply-To: <dd9ae106-3c39-423b-9413-5a7ca57f7aec@kernel.org>
From: Ian Dannapel <iansdannapel@gmail.com>
Date: Fri, 27 Sep 2024 17:34:58 +0200
Message-ID: <CAKrir7irvRbwCsdjF_NNfWy68wTDfRuyW2oHb90gYgBA=L7-Tg@mail.gmail.com>
Subject: Re: [PATCH 2/3] dt-bindings: fpga: Add Efinix serial SPI programming bindings
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: mdf@kernel.org, hao.wu@intel.com, yilun.xu@intel.com, trix@redhat.com, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	neil.armstrong@linaro.org, heiko.stuebner@cherry.de, rafal@milecki.pl, 
	linus.walleij@linaro.org, linux-fpga@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Thanks for the review Krzysztof.

Am Fr., 27. Sept. 2024 um 16:26 Uhr schrieb Krzysztof Kozlowski
<krzk@kernel.org>:
>
> On 27/09/2024 16:14, iansdannapel@gmail.com wrote:
> > From: Ian Dannapel <iansdannapel@gmail.com>
> >
> > Add device tree binding documentation for configuring Efinix FPGA
> > using serial SPI passive programming mode.
> >
> > Signed-off-by: Ian Dannapel <iansdannapel@gmail.com>
> > ---
> >  .../fpga/efinix,trion-spi-passive.yaml        | 85 +++++++++++++++++++
> >  1 file changed, 85 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/fpga/efinix,trion-spi-passive.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/fpga/efinix,trion-spi-passive.yaml b/Documentation/devicetree/bindings/fpga/efinix,trion-spi-passive.yaml
> > new file mode 100644
> > index 000000000000..ec6697fa6f44
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/fpga/efinix,trion-spi-passive.yaml
> > @@ -0,0 +1,85 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/fpga/efinix,trion-spi-passive.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Efinix SPI FPGA Manager
> > +
> > +maintainers:
> > +  - Ian Dannapel <iansdannapel@gmail.com>
> > +
> > +description: |
> > +  Efinix Trion and Titanium Series FPGAs support a method of loading the
> > +  bitstream over what is referred to as "SPI Passive Programming".
> > +  Only serial (1x bus width) is supported, setting the programming mode
> > +  is not in the scope the this manager and must be done elsewhere.
> > +
> > +  Warning: The slave serial link is not technically SPI and therefore it is
> > +  not recommended to have other devices on the same bus since it might
> > +  interfere or be interfered by other transmissions.
> > +
> > +  References:
> > +  - https://www.efinixinc.com/docs/an033-configuring-titanium-fpgas-v2.6.pdf
> > +  - https://www.efinixinc.com/docs/an006-configuring-trion-fpgas-v6.0.pdf
> > +
> > +allOf:
> > +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - efinix,trion-spi-passive
> > +      - efinix,titanium-spi-passive
>
> 1. Your driver suggests these are compatible, so make them compatible
> with using fallback.
>
> 2. What is "spi-passive"? Compatible is supposed to be the name of the
> device, so I assume this is "trion"? Can trion be anything else than fpga?
spi-passive is the programming mode, where the device is in slave
mode. There are also other modes, but not supported by this driver.
The name was inspired by similar drivers (spi-xilinx.c). Isn't just
"efinix,trion"/"efinix,titanium" too generic?
>
> > +
> > +  spi-cpha: true
> > +
> > +  spi-cpol: true
> > +
> > +  spi-max-frequency:
> > +    maximum: 25000000
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  creset-gpios:
>
> reset-gpios
>
> Do not invent own properties.
>
> > +    description:
> > +      reset and re-configuration trigger pin (low active)
> > +    maxItems: 1
> > +
> > +  cs-gpios:
> > +    description:
> > +      chip-select pin (low active)
>
> Eee? That's a property of controller, not child. Aren't you duplicating
> existing controller property?
This device uses this pin in combination with the reset to enter the
programming mode. Also, the driver must guarantee that the pin is
active for the whole transfer process, including ending dummy bits.
This is why I added a warning to NOT use this driver with other
devices on the same bus.
>
> > +    maxItems: 1
> > +
> > +  cdone-gpios:
> > +    description:
> > +      optional configuration done status pin (high active)
> > +    maxItems: 1
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - creset-gpios
> > +  - cs-gpios
> > +
> > +additionalProperties: false
>
> unevaluatedProperties instead
>
> > +
>
>
>
> Best regards,
> Krzysztof
>

Best regards,
Ian

