Return-Path: <linux-fpga+bounces-1431-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CE2EC416F2
	for <lists+linux-fpga@lfdr.de>; Fri, 07 Nov 2025 20:27:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F062B4E3004
	for <lists+linux-fpga@lfdr.de>; Fri,  7 Nov 2025 19:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 788203009CB;
	Fri,  7 Nov 2025 19:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WGWEYpme"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBED32D8DAF
	for <linux-fpga@vger.kernel.org>; Fri,  7 Nov 2025 19:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762543636; cv=none; b=SHeuhT02Kl98HB0V5zWE00d7IWghqC6kepwVVfsO84o1YJI1g5ZGIzFwEBMPPOxzDJJ/O3ct6MGT01ItX5aDYrZN41GvK7O8yoWXjR+xLLfSm1bmk2IlTGA2LZdS4pCzZCVgMBZ1ytjY3vZbUjlhUnSz8WocaBmC6+KIHzZDx1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762543636; c=relaxed/simple;
	bh=+uAue8VHRfE5bDhEEpaOZp67/N7yEWNDOOmylvy8lLY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bt4pyx1XtJsbIxuUfNWP3OD3KHZg0yM/P2gntWEWj0gjWmw1E50VkMUf+yylxPLN3wj3OlBjkr0zDsDxFbdODKQjh/OvD60xzHDHNHLMBzhZmwYW4/tvWcTjTK8iTAhZhB236W3f5TJ5fgepLuBRPRK7DLdmfSqDTGFnnMWiODc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WGWEYpme; arc=none smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-640d0895d7cso762835d50.1
        for <linux-fpga@vger.kernel.org>; Fri, 07 Nov 2025 11:27:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762543634; x=1763148434; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VdkaJh3hOfI8XOdwUl8MBmH4/W03UBCDbQt0lHkUPho=;
        b=WGWEYpmeoXuAZteZ8b/au6G9jguPOKrEJNNUynZMe0KRNmO6jU4C7FemqqMcA120wu
         89XkAGh35E6CgkjzPFWLsfHBtfkdzMGD4l7K3bI7vO7/f0ZgCOSgvFadOwfbRHDnUbkX
         sI96KOnAXawHRrychYZtKkQcqWSOT3fpllmBzMPsY/m+3IBin6YocTi8y38ioOaHqG20
         iwoAX1kSzXu6o+fESfrQjH64vG8wZXxEPH2IFuV0VTmX0we4b42Zm8qzyqhcz9g8VkNn
         H5/MBtGbFn/4iagZGMO936jSoGvwIL5ETOn5s2+Ie9NdiQ5LkaO59vKcaol/+gncttOa
         iPEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762543634; x=1763148434;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VdkaJh3hOfI8XOdwUl8MBmH4/W03UBCDbQt0lHkUPho=;
        b=M9BT1Y3/TVpyweQu40YLu01XmwqYFustecs1091EduAkA3ZRW/gKQjsfFShaeYt6HD
         WreNYDutpkYSZTBUIGQ2nlP0+lb+nUI9xkhr3WhS38n/XSqw7kkJiO9+WVYFUeRawgcu
         Oqf/svhzeqM8PGo7rgaQ2T5rVBDdOui/A8PadobB7/02spNtCQxmFNYffeQdTMuHriZs
         81bm0Xu67RK1HoSc8dyAmen6Utw8SpngvPuhiiWmAnNovhVJs7FlW60VRTazYQhaW/gu
         izNKM0kVqnc5PXWW+MVCweZwQK+EQP6xHl34NCLD9dgZhAyo90N3RQULbeDpzvc3XmBx
         f+aw==
X-Gm-Message-State: AOJu0Yz5qGDBsp6J9Keda9cgeFfcP8MwKPd52rTUJZOXdeKaV015c0HR
	e2zz++QxoB6Zj9ihqpYZL8RPkbwlN0QS3q1l9EGqgtH8CSxGLgSojFyD2QOnabHPVY+cpUFXCxj
	FwVsZTU8zKly2eOmelpk9jBBfsAlbYtk=
X-Gm-Gg: ASbGnctzqBtOhRQeKJIcatLIc0jQvEJEDFF32Ec0WirZhAaNcArtbTrKnWO/KqEglFq
	JZW2iDvLDHpSrp5/rYgp54H8HQkP52Ip9v+L24rVuDH9ZUqoNGcCudpJNFGqrBklRYsUvoAOYUd
	puCvv5JlmMPp7DWP6tdrfm9ZJIEyr7gHtmPVV6TFisYzOp3F2lP4HfHyl0dURZe5dmK5iVSkrqg
	1uoOJyiuWC9jTJqf6msHozfhZ28k/J9k3cpNVj5aVsdIwUeICcNNwLfdZ25
X-Google-Smtp-Source: AGHT+IGeohnsbh7G27YZJaehGvu2qH71sfz6HWBE6/RSVbMiMu4Y/cvxYKirNRHOMRu2qi2AdGwlTzwh8RFon6gWf3k=
X-Received: by 2002:a05:690e:150f:b0:63f:bb1b:b63a with SMTP id
 956f58d0204a3-640c9caaeb8mr2820507d50.11.1762543633869; Fri, 07 Nov 2025
 11:27:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251106185938.6419-1-rosenp@gmail.com> <20251106185938.6419-2-rosenp@gmail.com>
 <aQ2Yfh5kWCIJ4VsN@yilunxu-OptiPlex-7050>
In-Reply-To: <aQ2Yfh5kWCIJ4VsN@yilunxu-OptiPlex-7050>
From: Rosen Penev <rosenp@gmail.com>
Date: Fri, 7 Nov 2025 11:27:02 -0800
X-Gm-Features: AWmQ_bkRmJusENLuMOSMfnN-lD4DTZAtuXFfHGCZoTIfniusVPZI_FOqYokHCxo
Message-ID: <CAKxU2N-awq-7HRnobmMzssxX6Noo4Y2b3EyFveB0nSOkvXSNMg@mail.gmail.com>
Subject: Re: [PATCH 1/2] fpga: stratix10-soc: add missing header
To: Xu Yilun <yilun.xu@linux.intel.com>
Cc: linux-fpga@vger.kernel.org, Moritz Fischer <mdf@kernel.org>, 
	Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 6, 2025 at 11:12=E2=80=AFPM Xu Yilun <yilun.xu@linux.intel.com>=
 wrote:
>
> On Thu, Nov 06, 2025 at 10:59:37AM -0800, Rosen Penev wrote:
> > linux/sizes.h is needed for SZ_512K.
>
> Does it always fail or only with COMPILE_TEST?
Well, COMPILE_TEST under x86. If I had to guess, this header gets
included from some ARM header.
>
> Please add "fixes" & Cc stable kernel if it always fail.
>
> >
> > Signed-off-by: Rosen Penev <rosenp@gmail.com>
> > ---
> >  drivers/fpga/stratix10-soc.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/fpga/stratix10-soc.c b/drivers/fpga/stratix10-soc.=
c
> > index 0a295ccf1644..ab309cbf21c6 100644
> > --- a/drivers/fpga/stratix10-soc.c
> > +++ b/drivers/fpga/stratix10-soc.c
> > @@ -11,6 +11,7 @@
> >  #include <linux/of.h>
> >  #include <linux/of_platform.h>
> >  #include <linux/platform_device.h>
> > +#include <linux/sizes.h>
> >
> >  /*
> >   * FPGA programming requires a higher level of privilege (EL3), per th=
e SoC
> > --
> > 2.51.2
> >
> >

