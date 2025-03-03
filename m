Return-Path: <linux-fpga+bounces-1085-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14C2DA4BC45
	for <lists+linux-fpga@lfdr.de>; Mon,  3 Mar 2025 11:32:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FEF218945B7
	for <lists+linux-fpga@lfdr.de>; Mon,  3 Mar 2025 10:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A1C01F181F;
	Mon,  3 Mar 2025 10:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hQBIRLo6"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F22B1D63F7;
	Mon,  3 Mar 2025 10:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740997782; cv=none; b=ExJ+yMzRXQkE/lcEsxC+PaM2FmwiNI/o/m+OSuLVNXb67yWgadRrZcCFvfmyp9M5WQ1T8WEdrGDeDW1UCuOwertJVNp/okNbeON4KERsAFtrCU7OXrlMrOCDtQ4qlhcScI+cExvBrNuFVaDebN9zmaRd4vUn1MEdgKpDpovlnd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740997782; c=relaxed/simple;
	bh=+r4llVo+3ndkQm7rOEYR8s7Hv6cob7nTwsGObbvFHys=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qVa6MaRy8allvKWYdQ/3RxMJYCGwRPX9+QNSCwiZkcaELjGZ+LgpvblSn2s/EdVDAR1M8XML9eZz8zfy/L/fCSgmjkdU+h7RYuLrkZ8ztL14SfAGExJzYTrX5jjqMhkgrb66xdEL86ur6h7i88xabcFSfSaclZlXfOo8rbC9HOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hQBIRLo6; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5e4f5cc3172so4395999a12.0;
        Mon, 03 Mar 2025 02:29:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740997779; x=1741602579; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b+97tgtpkrZhLd54RdqWzvDlP1FIh/jaXB6LeS6lQqQ=;
        b=hQBIRLo6/jcCMeTaLmvNTbXTunvIjyEwut9vNMoFYg7Ik+efFTIKM9tJIOKao4xXxB
         Q3CVPIBfIk7Qgff5IAvWoDVLZnSTZHcYhCrq1YfrKPIZ6tEyN7pENAwFLPGKrIjw2Gp/
         HabY0/2vRaaT5pv+PoBfkCC1RWgUU5mDNK69M+lSQBmkLIlQwA4cPbqJXGFREMz/GAfk
         Ypw6A5z+vxhTO9MBHiqhl1kMRiG+eNwgnv8zIpwsxZrcrGRK02q9H3+zL6Ptqmc91WOi
         nOjt2pEEUHIbJnVjS6Y9OauthlLHdq5UJnuYW3vmwr0oD8rXJMA+wuVSH0iGqg4MogS5
         sY5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740997779; x=1741602579;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b+97tgtpkrZhLd54RdqWzvDlP1FIh/jaXB6LeS6lQqQ=;
        b=AoOvJUvLXJPU+kohkPqyWTf2Vw0BkBLsp0csp7LDcEikyyTwoB9bWqg/tWBlJawMt/
         iC21rkCuwaipTGVcZB1okO61eG9XmhPWG0asjgifAkRkpKTCSHr4XQw3Th4UVPh4oAdM
         oF7iUsFPqwYj87IFCiyuHDwXRINIw89Ezkb7QbG9o1Ar8S1BgrOqL5hk8GhMLLEgtNFb
         0jFXgvzyEmQuRxvNKG2QLRNaNn64N1mApHLf+HNFtYPbRvCsl+cyZXRkDu6LLeTFlIly
         Bxo/gd8WWOkUwG11Dr7hRQU3kQBnmJ90wj+5qeqQ/SewZz83teUgQ6exNZ6eWgZDY200
         n/jw==
X-Forwarded-Encrypted: i=1; AJvYcCUdjpyr1mk8yIbyg21EM703mMeKVKqV1Ocy3bgXsYKpCknYE36c0S+GlaQqzHNqH0BlY0E3wONQBk1z@vger.kernel.org, AJvYcCXVcdnP72oG/NungtnTXsnEEJw/mOKrKyvXvRzFKb74gBsBOsxSIKMOF7viadrlgg7YgIfF/euXg739pnCS@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0KcWMbEUWz/keK9CK1lr4B7BAbTyKHbNBdCol0LS7y254gHTK
	IWjPhjYZLT6A+d4eufgyn2RMF+xKmPN2NkJIhUDgsW9L7TsAnKLdvvxznmsHUBO5hSlimxQ76ZF
	+BugWag9g7gNrCe9emovkn8NadxE=
X-Gm-Gg: ASbGncuT3OZeesgUuXAfFgSD9lslBQbZZ1cbiHKqDlpeQ0lSinbWX1Kuqb5GjZG/M8v
	5vBqKZZDeLtq6f9mJ4Udm8WEYg54tXxJZCkYbV12Zd7d3SwKlHaewH1ZTrFVT0+EdNgbw5Yy4yS
	cgGu6SoIOT//A5tgCmfA8lJJoEQcxPmcQAptMcAF1O4qca3Pte6P3OoaKvnA==
X-Google-Smtp-Source: AGHT+IHxwrji66kSeeCeo2zzRKJg/oI/nnS7ZQ+3CFp3Q1n6jT/o8WlpvhYiYRpqYeJ/eBh3sTt9FSpzdIVV4X0U5yU=
X-Received: by 2002:a17:907:9626:b0:abf:6389:6d19 with SMTP id
 a640c23a62f3a-abf63897b13mr688099566b.15.1740997778409; Mon, 03 Mar 2025
 02:29:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250228094732.54642-1-iansdannapel@gmail.com>
 <20250228094732.54642-3-iansdannapel@gmail.com> <20250228-copilot-trekker-72a20709e9f7@spud>
 <CAKrir7hdyP-bPKkZOpK3cFp=rvH_MJ98DLKnsRni_BWsQEg5yw@mail.gmail.com>
In-Reply-To: <CAKrir7hdyP-bPKkZOpK3cFp=rvH_MJ98DLKnsRni_BWsQEg5yw@mail.gmail.com>
From: Ian Dannapel <iansdannapel@gmail.com>
Date: Mon, 3 Mar 2025 11:29:27 +0100
X-Gm-Features: AQ5f1Jp0OX_vuxj4kEUePqY16WGoKNNDMGuRuGmS5FYBbipZRNwkqFirCWmH03o
Message-ID: <CAKrir7gODeEfaxVg9Yd-suSEWE3dYUb8k6CE51Ma495TF+2LHA@mail.gmail.com>
Subject: Re: [v4 2/3] dt-bindings: fpga: Add Efinix SPI programming bindings
To: Conor Dooley <conor@kernel.org>
Cc: linux-fpga@vger.kernel.org, Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>, 
	Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	=?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>, 
	Aradhya Bhatia <a-bhatia1@ti.com>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Krzysztof, thanks for the quick response.

On Sat, Mar 1, 2025 at 2:13=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.org=
> wrote:
>
> On 28/02/2025 10:47, iansdannapel@gmail.com wrote:
> > +
> > +  References:
> > +  - https://www.efinixinc.com/docs/an006-configuring-trion-fpgas-v6.3.=
pdf
> > +  - https://www.efinixinc.com/docs/an033-configuring-titanium-fpgas-v2=
.8.pdf
> > +  - https://www.efinixinc.com/docs/an061-configuring-topaz-fpgas-v1.1.=
pdf
> > +
> > +allOf:
> > +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - efinix,trion-spi
> > +      - efinix,titanium-spi
> > +      - efinix,topaz-spi
>
>
> Same comments as before about compatibility. Address or implement.
>
The compatibles are implemented in the device match table, what
exactly should be addressed or implemented here?

> > +      - efinix,fpga-spi
>
>
> And this one is for which device? It is not even used.
The proposed compatible is a generic fallback for any Efinix FPGA
Series. Isn't it used if the compatible is part of the drivers match
table?

Regards,
Ian

