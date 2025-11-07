Return-Path: <linux-fpga+bounces-1432-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BBE3C416F8
	for <lists+linux-fpga@lfdr.de>; Fri, 07 Nov 2025 20:28:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14A6B3B8781
	for <lists+linux-fpga@lfdr.de>; Fri,  7 Nov 2025 19:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B2F33009F5;
	Fri,  7 Nov 2025 19:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PerZgW9/"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9759B1D61A3
	for <linux-fpga@vger.kernel.org>; Fri,  7 Nov 2025 19:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762543697; cv=none; b=D7qHQs/lt/aKoW4OLoWbYT9aKi6ruZjJqFfCUjS2YClr6IWWfmrwCVR8+/94gVC/K4w8lJ3xtdsx2i/1jw1/M7yCOeBzcIhJKwU+DUuDPYM41raEdLmIdxQsJ3icughAC8zcVblpnlSS3DjWrDNMRASQhN0B6lomAzCBCocYozc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762543697; c=relaxed/simple;
	bh=/qs9Kz/VvTemB2KCsq7rLMRP35wSkzZZ5ATLF/F1kBg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ooF/c1Nuf1YN+s5BbimxXlsJlIM47OJVItRE8HBtAjVsy9nhesCumhlzJLxt8n1iWQtYiMg1a7WTtp66pAZuWTQ/NynHb4DhnxZkBq6zOfhbwnMAAHHuJmhbcYsqLlO2Aw97SIRpjTcg+YumfqzK1gTNOwwxrrRwPMedLk0JJYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PerZgW9/; arc=none smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-63fc72db706so1138802d50.2
        for <linux-fpga@vger.kernel.org>; Fri, 07 Nov 2025 11:28:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762543694; x=1763148494; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rCf0FGqMcc2XvdVlS3FupM0HnEo5ZlFgJ9AoqitPiqE=;
        b=PerZgW9/p5u1FPJKZePzEP74bWm7SVlTSXd7UNO3KOGXseTBch1TQkCK6w3tRDF0XE
         uL+kr/pOliP7wcRRzChnEviRmou9Cs98ffvtdjCBVJ1O0Aj59iCJPwR+N7rfGOVsPlNA
         IdhNlgyDoF+cM+L2bLmYwQvMlT2xHlsUV4OziczMuTLefpuKbe+VLMaEBi74/oVSCr1+
         43q/vi8f2O5BVhwcKWvMtBT25EUDHLxGn5w6Qrb3I+zGVFFJgVkL++q2xz/PTjOTbTdE
         vdZu5NSMq5pvfw13qo/Jax/80OePxzr7s9q6xMXeCORiaQ6DxLiAzexOSLE3cHivROiK
         xkvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762543694; x=1763148494;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rCf0FGqMcc2XvdVlS3FupM0HnEo5ZlFgJ9AoqitPiqE=;
        b=tRe4H5oKomXYBkTSZ9W0bv8tUAVGbwZSWLvxSc0OWMln7huKHtDh0wYo0EHY9Ufdw2
         muEHM5kcUHxLjt415mddXQfB9MfEDPgzBQZDffCcQaopzUmycghsvqxvr83vijQOP5rE
         0OY60BjLSVCSK4bMEQeVIWu0+UW0pL5chwxtSas9DTtyEq5q4uPzr7TT2ObLsKiVAU4t
         3qUC99rLb1KHwcz8Rd5Y6IA/LNNcKrx8yGOx1MVg9REEqJNZKLDSL0/6E5c7JeMBmAhy
         Dcq0NfSr43RyheZwP7HxKxtYfXn7wOMsX+UcMzOykdBQoGKCJTPqmHkSUKa0xgqf+KgC
         IAkg==
X-Gm-Message-State: AOJu0YzHwLj7NLvUCMZM4qiMbI3FODr2g7y+SZ0zaKXNwaetb1/MTsag
	dJVdFuo0a3mxqh9VVyDIZOyR5EwLpQQ0I0SloVj5T+53y/1WKZSEoZ934936MinHFEWrg2+78PN
	Kk/fPzwwBczmBoPLuvHjXCE8x1s7M5E8=
X-Gm-Gg: ASbGncuCQ3PkWxIKNl37UE7IEGArjE76ZR5ltb+DDyOw/xu9AuPG3gSUh9CHbbHGo/l
	P8KVx5biEMFSl/zOmvzGSfm7aVLq7OJCIIGrrFHhauYP6sjcykqPX+AVfMaePSdPaRIFB4nN6mc
	OqZLSLGFNTBofbFs02NP79i6MmaOxhXTm2RpHFeipyEfxf5SNrIn5C2FslTomRdHqTXSIA6A/Zm
	bit+UWRHZK+v0gN1Vii0ypSLEfmm376LN1viM1Azd1DUKe2tIQKKboN5BTtYPP/sqsPiL6bYg==
X-Google-Smtp-Source: AGHT+IGnVjpXRvKwFbJeYUFIsmZGICbvd8XOwNdFBtVZeWHz57+8G+PRDBNRvxza4sRwH5i/atri7E9kRv8uaEPanWE=
X-Received: by 2002:a05:690e:2513:20b0:63e:2598:54b0 with SMTP id
 956f58d0204a3-640d4552a35mr158109d50.26.1762543694431; Fri, 07 Nov 2025
 11:28:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251106185938.6419-1-rosenp@gmail.com> <20251106185938.6419-3-rosenp@gmail.com>
 <aQ2csK4TtTOFmyLj@yilunxu-OptiPlex-7050>
In-Reply-To: <aQ2csK4TtTOFmyLj@yilunxu-OptiPlex-7050>
From: Rosen Penev <rosenp@gmail.com>
Date: Fri, 7 Nov 2025 11:28:03 -0800
X-Gm-Features: AWmQ_bly-VZuui2gAqiFKI3nncbBCd3kvQg9qbtpxUD3whaTwcIMolQF6u15KTI
Message-ID: <CAKxU2N8QHoQxb0ddUtMTtK6psL4gPPGSTwTf5X=7py22GXxkrw@mail.gmail.com>
Subject: Re: [PATCH 2/2] fpga: stratix10-soc: add COMPILE_TEST support
To: Xu Yilun <yilun.xu@linux.intel.com>
Cc: linux-fpga@vger.kernel.org, Moritz Fischer <mdf@kernel.org>, 
	Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 6, 2025 at 11:30=E2=80=AFPM Xu Yilun <yilun.xu@linux.intel.com>=
 wrote:
>
> On Thu, Nov 06, 2025 at 10:59:38AM -0800, Rosen Penev wrote:
> > Allow the buildbots to find compilation issues.
> >
> > Signed-off-by: Rosen Penev <rosenp@gmail.com>
> > ---
> >  drivers/fpga/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
> > index 311313f3b282..f2e2776acdd5 100644
> > --- a/drivers/fpga/Kconfig
> > +++ b/drivers/fpga/Kconfig
> > @@ -60,7 +60,7 @@ config FPGA_MGR_ZYNQ_FPGA
> >
> >  config FPGA_MGR_STRATIX10_SOC
> >       tristate "Intel Stratix10 SoC FPGA Manager"
> > -     depends on (ARCH_INTEL_SOCFPGA && INTEL_STRATIX10_SERVICE)
> > +     depends on (ARCH_INTEL_SOCFPGA && INTEL_STRATIX10_SERVICE) || COM=
PILE_TEST
>
> I don't think it works without INTEL_STRATIX10_SERVICE, maybe:
>
>         depends on ARCH_INTEL_SOCFPGA || COMPILE_TEST
>         depends on INTEL_STRATIX10_SERVICE
>
> But INTEL_STRATIX10_SERVICE depends on HAVE_ARM_SMCCC, and they all
> require arch configurations...
Yeah I don't think INTEL_STRATIX10_SERVICE is needed for COMPILE_TEST.
>
> >       help
> >         FPGA manager driver support for the Intel Stratix10 SoC.
> >
> > --
> > 2.51.2
> >
> >

