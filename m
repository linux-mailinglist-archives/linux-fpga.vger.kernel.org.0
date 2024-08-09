Return-Path: <linux-fpga+bounces-590-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDDEE94CECF
	for <lists+linux-fpga@lfdr.de>; Fri,  9 Aug 2024 12:38:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FC831F21AAD
	for <lists+linux-fpga@lfdr.de>; Fri,  9 Aug 2024 10:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40FA2191F9F;
	Fri,  9 Aug 2024 10:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kSZ/h6II"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7918D15ECE2;
	Fri,  9 Aug 2024 10:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723199897; cv=none; b=IkQLtqGT9PlCYcxibgnnZTCl/6D10tC18cY9pUsbxMeBDP4apAsriYa2kO97ozdHFApr5HKhAQVWXchwlHW94+RxiXdHRmtLH1/2/pD6pvvJFyzj6ZYIgHV1vhU0/1DlP25kIGzAoiNjR26G1XO0j2+QK2QBRGq90VyHxOPCvok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723199897; c=relaxed/simple;
	bh=Mb6b1bjV9sanf6V4GLnxt2bYlvQGbzNEo1khvjRoC/A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lw+oOVo63TWZQ1RcJ3CtufOJVuPgrwXQfWIQ4wEx8+70J6KyWuPDAU8VFvIsZsyBuDKEKdhPX2evVEfDRgCMV/Vr2LDqaPNqxMlcFH122d/NUx8MFmpNiPS2/AbOqI/UAzPcb5F7YRfdbErhDKHukkvK6AEDMA1J2CB0g+qZ6zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kSZ/h6II; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e02b79c6f21so1832376276.2;
        Fri, 09 Aug 2024 03:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723199894; x=1723804694; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HTE6RJlGQR3VkcjzNcrQi3tTe1y8STXMCk1EgDfvt5k=;
        b=kSZ/h6IIMN+4FLOqJcI5xZZZWBuTB1Vyp0CDXxKWyOtm7FG8NtfrdmulOXXH9sN/Cl
         OTp5clWU3fNh1ZNeP+bI96fBgy/PbPLxjEs/vQYT/ji2d4U+4LTN6kznJYCfwxxCBHoL
         xd9nTWhxgZsnAujZ3amTqXLd50GYYBBSeleoau52w7w69cABATC/PFKr4QX9eEqfJIx4
         Hg8WhsnJU6qIgoqr8cTHJlWC5zBWM+MMT9A5fvFR+mmMEtjKMZwy2Xu58jitS+62f9ti
         m3aWnJyZqU3qwr/F6/3C9SXAevGPk3XnAfWimZqnM8IiRbA1SSyWbeGjic6GqGfYlIiU
         icAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723199894; x=1723804694;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HTE6RJlGQR3VkcjzNcrQi3tTe1y8STXMCk1EgDfvt5k=;
        b=KurL314iFLnBfrvDURa1NLAeqllNJH2W/OBpwDKFGc2ovHzgTbtNjWnYR3WWDHqssU
         tyxM7Mb6tZCGrlFNPm/Zt5dgyPkW1mEN0GpIUQ7pEvrKFKnWg/Vi5UC5mN/nXAy88yPu
         ITiJ10q4Ua0p8LL3luNTbGUJ7jpZRQ6pE157KPnkgmj3ChOkE7Wpn9bITxjC8ZyUbXYe
         cniRNWZyjmXrbaxfazle0ZAnjqw3KSW6PxFLMl6k87plSda6HL2/7RXXlJyrDCqXfydk
         eKiAsyLANHIRbpN6wxWTE7EQrySbQlR/W1lgxsEDk7/SLcdq1Aky3zoo3METE40zOc58
         cMjg==
X-Forwarded-Encrypted: i=1; AJvYcCXLYxLZnYyJ37ve6DRiOdxc3PwKWZRdb6k51ne5uMIOK5XQghua6X+jq2kzY1FDhUW7/7VYt4icCs1NeG4g7/G1XWzK5KJMmmeYP4LbqicVI6+AZ4m0omZylsPLy8FRbsHePNxOVVwZn0ZlwGufSqZf49qfKv0bp4RY93zIs5SLAurDesA=
X-Gm-Message-State: AOJu0YxujT6aUsv5KKNusgZyslm9kNa5rmVxxtyfFIqGIY7EQP8J7VWR
	OzZBsrWXvAdAie2WU62ZkATm9zfGPbZXxAgH6hB/Xh8e3SpK8haLic7YNnlUVHOyDD5tz5B/5PG
	KtRpSQTb0dCmcygen+nLsgELFLEU=
X-Google-Smtp-Source: AGHT+IEUT8qEhh7QYzPUL8lRLTrpcjaj8X9TF3Ou11D5OJfX1LaJQcxiJAD85RM9dPrKwQ1c19GDWjKGIS9v1tPRMwg=
X-Received: by 2002:a05:6902:102c:b0:e0b:bd20:1f00 with SMTP id
 3f1490d57ef6-e0eb98e5d76mr1282096276.9.1723199894233; Fri, 09 Aug 2024
 03:38:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240620144217.124733-1-iansdannapel@gmail.com>
 <20240628152348.61133-1-iansdannapel@gmail.com> <20240628152348.61133-2-iansdannapel@gmail.com>
 <ZpDSz5dp+zFPYjVw@yilunxu-OptiPlex-7050> <CAKrir7iHjxnRvZvch8ADgGFymm_z1=rU8gOM+Q==xpe64G6xkA@mail.gmail.com>
 <ZqUZK14ROqNvVuiO@yilunxu-OptiPlex-7050> <CAKrir7jU4dAWREMVLbe1A3a1TGOb8r-UM2zviZEXYY9nzJrm7A@mail.gmail.com>
 <ZqesIi6pW12TlPlc@yilunxu-OptiPlex-7050>
In-Reply-To: <ZqesIi6pW12TlPlc@yilunxu-OptiPlex-7050>
From: Ian Dannapel <iansdannapel@gmail.com>
Date: Fri, 9 Aug 2024 12:38:03 +0200
Message-ID: <CAKrir7h4bSMQ=TkP=a+4sG6OK7NVn=dj2k6ypCF6TJUd_JiOcw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] fpga: Add Efinix Trion & Titanium serial SPI
 programming driver
To: Xu Yilun <yilun.xu@linux.intel.com>
Cc: Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>, Xu Yilun <yilun.xu@intel.com>, 
	Tom Rix <trix@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiko Stuebner <heiko.stuebner@cherry.de>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Sebastian Reichel <sre@kernel.org>, Chris Morgan <macromorgan@hotmail.com>, 
	Michael Riesch <michael.riesch@wolfvision.net>, =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>, 
	Andre Przywara <andre.przywara@arm.com>, Linus Walleij <linus.walleij@linaro.org>, 
	linux-fpga@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Am Mo., 29. Juli 2024 um 16:52 Uhr schrieb Xu Yilun <yilun.xu@linux.intel.com>:
>
> On Sun, Jul 28, 2024 at 01:44:03PM +0200, Ian Dannapel wrote:
> > Am Sa., 27. Juli 2024 um 18:00 Uhr schrieb Xu Yilun <yilun.xu@linux.intel.com>:
> > >
> > > On Thu, Jul 25, 2024 at 03:44:54PM +0200, Ian Dannapel wrote:
> > > > Hi Yilun, thanks for the review.
> > > >
> > > > Am Fr., 12. Juli 2024 um 09:00 Uhr schrieb Xu Yilun <yilun.xu@linux.intel.com>:
> > > > >
> > > > > On Fri, Jun 28, 2024 at 05:23:46PM +0200, iansdannapel@gmail.com wrote:
> > > > > > From: Ian Dannapel <iansdannapel@gmail.com>
> > > > > >
> > > > >
> > > > > Please don't reply to the previous series when you post a new version.
> > > > sure
> > > > >
> > > > > > Add a new driver for loading binary firmware using "SPI passive
> > > > >
> > > > > Loading to some nvram or reporgraming to FPGA logic blocks.
> > >
> > > Sorry for typo, this is a question:
> > >
> > >   Loading to some nvram or reporgraming to FPGA logic blocks?
> > The datasheet refers to it as configuration RAM (CRAM) and must be
> > loaded on every boot up.
>
> The FPGA reprogramming is about loading the FPGA logic blocks, and from
> the POV of the System, it is about runtime changing the HW and
> re-enumerate the devices.
>
> But some submitted fpga-mgr drivers are just used to to write nvram
> backend for FPGA, don't affect any running device at all. I think these
> drivers virtually have nothing to do with fpga-mgr. Some generic
> storage (e.g. nvram, mtd) or firmware image loading interfaces better
> fit them. I assume this driver is also of this kind.
To clarify, this driver does not write to a nvram or any persistent
memory. Programming or reprogramming at runtime is necessary, but
partial reprogramming is not supported.
>
> > >
> > > > >
> > > > > > programming" on Efinix FPGAs.
> > > > > >
> > > > > > Signed-off-by: Ian Dannapel <iansdannapel@gmail.com>
> > > > > > ---
> > > > > >  drivers/fpga/Kconfig                    |   8 +
> > > > > >  drivers/fpga/Makefile                   |   1 +
> > > > > >  drivers/fpga/efinix-trion-spi-passive.c | 219 ++++++++++++++++++++++++
> > > > > >  3 files changed, 228 insertions(+)
> > > > > >  create mode 100644 drivers/fpga/efinix-trion-spi-passive.c
> > > > > >
> > > > > > diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
> > > > > > index 37b35f58f0df..25579510e49e 100644
> > > > > > --- a/drivers/fpga/Kconfig
> > > > > > +++ b/drivers/fpga/Kconfig
> > > > > > @@ -83,6 +83,14 @@ config FPGA_MGR_XILINX_SPI
> > > > > >         FPGA manager driver support for Xilinx FPGA configuration
> > > > > >         over slave serial interface.
> > > > > >
> > > > > > +config FPGA_MGR_EFINIX_SPI
> > > > > > +     tristate "Efinix FPGA configuration over SPI passive"
> > > > > > +     depends on SPI
> > > > > > +     help
> > > > > > +       This option enables support for the FPGA manager driver to
> > > > > > +       configure Efinix Trion and Titanium Series FPGAs over SPI
> > > > > > +       using passive serial mode.
> > > > > > +
> > > > > >  config FPGA_MGR_ICE40_SPI
> > > > > >       tristate "Lattice iCE40 SPI"
> > > > > >       depends on OF && SPI
> > > > > > diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
> > > > > > index aeb89bb13517..1a95124ff847 100644
> > > > > > --- a/drivers/fpga/Makefile
> > > > > > +++ b/drivers/fpga/Makefile
> > > > > > @@ -18,6 +18,7 @@ obj-$(CONFIG_FPGA_MGR_TS73XX)               += ts73xx-fpga.o
> > > > > >  obj-$(CONFIG_FPGA_MGR_XILINX_CORE)   += xilinx-core.o
> > > > > >  obj-$(CONFIG_FPGA_MGR_XILINX_SELECTMAP)      += xilinx-selectmap.o
> > > > > >  obj-$(CONFIG_FPGA_MGR_XILINX_SPI)    += xilinx-spi.o
> > > > > > +obj-$(CONFIG_FPGA_MGR_EFINIX_SPI)    += efinix-trion-spi-passive.o
> > > > > >  obj-$(CONFIG_FPGA_MGR_ZYNQ_FPGA)     += zynq-fpga.o
> > > > > >  obj-$(CONFIG_FPGA_MGR_ZYNQMP_FPGA)   += zynqmp-fpga.o
> > > > > >  obj-$(CONFIG_FPGA_MGR_VERSAL_FPGA)   += versal-fpga.o
> > > > > > diff --git a/drivers/fpga/efinix-trion-spi-passive.c b/drivers/fpga/efinix-trion-spi-passive.c
> > > > > > new file mode 100644
> > > > > > index 000000000000..eb2592e788b9
> > > > > > --- /dev/null
> > > > > > +++ b/drivers/fpga/efinix-trion-spi-passive.c
> > > > > > @@ -0,0 +1,219 @@
> > > > > > +// SPDX-License-Identifier: GPL-2.0-only
> > > > > > +/*
> > > > > > + * Trion and Titanium Series FPGA SPI Passive Programming Driver
> > > > > > + *
> > > > > > + * Copyright (C) 2024 iris-GmbH infrared & intelligent sensors
> > > > > > + *
> > > > > > + * Ian Dannapel <iansdannapel@gmail.com>
> > > > > > + *
> > > > > > + * Manage Efinix FPGA firmware that is loaded over SPI using
> > > > > > + * the serial configuration interface.
> > > > > > + */
> > > > > > +
> > > > > > +#include <linux/delay.h>
> > > > > > +#include <linux/device.h>
> > > > > > +#include <linux/fpga/fpga-mgr.h>
> > > > > > +#include <linux/gpio/consumer.h>
> > > > > > +#include <linux/module.h>
> > > > > > +#include <linux/mod_devicetable.h>
> > > > > > +#include <linux/of.h>
> > > > > > +#include <linux/spi/spi.h>
> > > > > > +#include <linux/sizes.h>
> > > > > > +
> > > > > > +struct efinix_spi_conf {
> > > > > > +     struct spi_device *spi;
> > > > > > +     struct gpio_desc *cdone;
> > > > > > +     struct gpio_desc *creset;
> > > > > > +     struct gpio_desc *cs;
> > > > > > +};
> > > > > > +
> > > > > > +static int get_cdone_gpio(struct fpga_manager *mgr)
> > > > >
> > > > > Is it better use 'struct efinix_spi_conf *conf' as parameter?
> > > > >
> > > > > Same for the following functions.
> > > > >
> > > > > > +{
> > > > > > +     struct efinix_spi_conf *conf = mgr->priv;
> > > > > > +     int ret;
> > > > > > +
> > > > > > +     ret = gpiod_get_value(conf->cdone);
> > > > > > +     if (ret < 0)
> > > > > > +             dev_err(&mgr->dev, "Error reading CDONE (%d)\n", ret);
> > > > > > +
> > > > > > +     return ret;
> > > > > > +}
> > > > > > +
> > > > > > +static void reset(struct fpga_manager *mgr)
> > > > >
> > > > > Please unify the naming of the internal functions. You use
> > > > > 'efinix_spi_apply_clk_cycles()' below.
> > > > >
> > > > > > +{
> > > > > > +     struct efinix_spi_conf *conf = mgr->priv;
> > > > > > +
> > > > > > +     gpiod_set_value(conf->creset, 1);
> > > > > > +     /* wait tCRESET_N */
> > > > > > +     usleep_range(5, 15);
> > > > > > +     gpiod_set_value(conf->creset, 0);
> > > > > > +}
> > > > > > +
> > > > > > +static enum fpga_mgr_states efinix_spi_state(struct fpga_manager *mgr)
> > > > > > +{
> > > > > > +     struct efinix_spi_conf *conf = mgr->priv;
> > > > > > +
> > > > > > +     if (conf->cdone && get_cdone_gpio(mgr) == 1)
> > > > > > +             return FPGA_MGR_STATE_OPERATING;
> > > > > > +
> > > > > > +     return FPGA_MGR_STATE_UNKNOWN;
> > > > > > +}
> > > > > > +
> > > > > > +static int efinix_spi_apply_clk_cycles(struct fpga_manager *mgr)
> > > > > > +{
> > > > > > +     struct efinix_spi_conf *conf = mgr->priv;
> > > > > > +     char data[13] = {0};
> > > > > > +
> > > > > > +     return spi_write(conf->spi, data, sizeof(data));
> > > > > > +}
> > > > > > +
> > > > > > +static int efinix_spi_write_init(struct fpga_manager *mgr,
> > > > > > +                              struct fpga_image_info *info,
> > > > > > +                              const char *buf, size_t count)
> > > > > > +{
> > > > > > +     struct efinix_spi_conf *conf = mgr->priv;
> > > > > > +
> > > > > > +     if (info->flags & FPGA_MGR_PARTIAL_RECONFIG) {
> > > > > > +             dev_err(&mgr->dev, "Partial reconfiguration not supported\n");
> > > > > > +             return -EINVAL;
> > > > > > +     }
> > > > > > +
> > > > > > +     /* reset with chip select active */
> > > > > > +     gpiod_set_value(conf->cs, 1);
> > > > >
> > > > > Why operating chip selective at SPI client driver? Isn't it the job for SPI
> > > > > controller?
> > > > to enter the passive programming mode, a reset must be executed while
> > > > the chip select is active.
> > > > The is controlling the chip select from here, since I expect that the
> > > > SPI controller to only activate
> > > > the CS when communicating.
> > >
> > > The concern is, it may conflict with the underlying cs control in spi
> > > controller.
> > >
> > > There are several control flags in struct spi_transfter to affect cs. Is
> > > there any chance using them, or try to improve if they doesn't meet your
> > > request?
> > The main problem of this chip is that probably the of SPI is out of
> > spec, so would like to avoid changes in the spi contoller for this
> > edge case.
> > That is probably one the reasons that the datasheet does not recommend
> > other devices on the same SPI bus.
>
> I think anyway you need to communicate with spi controller driver and
> have one voice how/who to take control of cs, rather than blindly
> operate at both sides.
I did not find a clear solution yet. This FGPA device requires an SPI
without a chip-select signal and no other device transaction should be
allowed in between reprogramming, which seems to be a very specific
case for the SPI Controller to manage
>
> Thanks,
> Yilun

Thank
Ian

