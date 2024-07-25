Return-Path: <linux-fpga+bounces-578-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38BD493C33F
	for <lists+linux-fpga@lfdr.de>; Thu, 25 Jul 2024 15:45:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B75FF1F229D1
	for <lists+linux-fpga@lfdr.de>; Thu, 25 Jul 2024 13:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D127343146;
	Thu, 25 Jul 2024 13:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nP03fBjY"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0581F1DDE9;
	Thu, 25 Jul 2024 13:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721915108; cv=none; b=dzwOvus0hWQ8dtPNgRQb8+6SzHF1F8c5xK30iF1U0UVdNQCglGRGbPBsNlj6vatdai0vgtuhFw/tk5qscnrW0QMg3i9EArcRgMsHUXv5GTD5y3Q46ghoyjZQ+E88i/PS1E1fR/qt76StWEzYHngKs6XxtqNez2pHCKcQsprlnWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721915108; c=relaxed/simple;
	bh=SNFAvm8se8lcAcPs3JHdnyIdlXoSGNjhN5QMpBtOAUc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AGCCFE/pOJ4FCX4qrq3DffNd+skfws6ho7FUsAP+gIUGi+MWt8Wov50hL9J30PEVZbiYk3KVFSeoiKZTvZItHaHu2w8pu1ffu/1xtb/ulFAMGub4JJUKrc6NjM5XUFE2uCGQhZAqJy2xhE2HrD0vMGVGWznbbX4Lizbc7MMyfNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nP03fBjY; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-663dd13c0bbso9472337b3.1;
        Thu, 25 Jul 2024 06:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721915106; x=1722519906; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iVsReMzS6XQxaC6V5svnzdxwsKgUqrcjUt7KiDw3W+I=;
        b=nP03fBjYlulzv0kM/csKrqTvRZX/t6tS/Drr1go+RpKoUvozIGwdiaPBuww4HU7A2+
         fj3TU7iud5S1Z9YzhL1SRQCJV59UtAwfcZszdWOgSCK2m9t4zZr2M7/5aFrJ4rBfMbR1
         prfI4RfHgyH4wmvJIx3oNNMyP4b4ssIdiYvMM7RqVOnDzmnBpJulzRQbDyc7Xbm6/XnE
         f/9AgVjIGY7zbart/xh3siBbLeX+Xoe2BJIFLlZ2JDgAurvXMnbGTihJI1DhmX2kfu2B
         h8WOB/T7MGbgLzmdgEfuPgm/yIYZb58PjGz4rEfBp6UKFabrpTtYPrJjbKMoga8NyQwv
         UYAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721915106; x=1722519906;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iVsReMzS6XQxaC6V5svnzdxwsKgUqrcjUt7KiDw3W+I=;
        b=LZhQyUhyWpd0FEZkUy90nmlSv1N92NNd0PhiphEcrym2JJJNLIosGhNEh4peqGl2VA
         sqoJbmaRK3mpCJ3Y0RknmqY8AWODXVchzekd9nSj8hS8icRiu0fZ/ap13Z1esavMvYXn
         PC1/rTIk1uxO1P2pVSJdCjuPDOo9UN+W+LO2Hz3hpcjzbMPfAL2YeBbn52WovTUsBC06
         Lf7fAU9BmVM2HNiMX9nRsj5nxWaO5J3A74Sngvz77nhAxImd5oP0EeR2StrHX4zs41vD
         mUrzQlv+ghMd3IqrBoppL6dXvxm4v96xQp5SuAJgAanH2d8K7e85lvSErIim+uhkN72x
         HOYA==
X-Forwarded-Encrypted: i=1; AJvYcCUiiBEtP5T7ztYnbhK7BJDtcTovhWSP/Ij9ZOaNSupx1OQUbSwucjfe1sA3bi+s5rnr8VhT54L7YJWDeVC4A44T8nm19VSRE4TerkZMjy10X+MM5HMMfKMTl+XcSJP6meyr+xVwuqgjaCHGo85w+mG59KNq3Mmq2XA3jEqROBXHxI321W8=
X-Gm-Message-State: AOJu0YwMCses/hXUvC8bPHir0g8VSp7URlelVtKkxZBue09+ytfQpU23
	g0FdGLBSkkTuoqpibL6eYIlLyvHAgFvU+apvY6IGfx/kPGgZpVXCxwgdzXQZ9ZiuvOEn7mCv+Vx
	rgy75PwuC4j2WTSA+Bt6Ng/vrBGk=
X-Google-Smtp-Source: AGHT+IHpvJvytuJWE8iMopQa2m1IL+39GI3Pvs4+mSyHQLL22QA6WG7TOo7+kWCBsG7gDQudxEJfL/pupsx8bFBHrWo=
X-Received: by 2002:a0d:f547:0:b0:64a:f40d:5fd2 with SMTP id
 00721157ae682-675113b332bmr30409997b3.12.1721915105716; Thu, 25 Jul 2024
 06:45:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240620144217.124733-1-iansdannapel@gmail.com>
 <20240628152348.61133-1-iansdannapel@gmail.com> <20240628152348.61133-2-iansdannapel@gmail.com>
 <ZpDSz5dp+zFPYjVw@yilunxu-OptiPlex-7050>
In-Reply-To: <ZpDSz5dp+zFPYjVw@yilunxu-OptiPlex-7050>
From: Ian Dannapel <iansdannapel@gmail.com>
Date: Thu, 25 Jul 2024 15:44:54 +0200
Message-ID: <CAKrir7iHjxnRvZvch8ADgGFymm_z1=rU8gOM+Q==xpe64G6xkA@mail.gmail.com>
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

Hi Yilun, thanks for the review.

Am Fr., 12. Juli 2024 um 09:00 Uhr schrieb Xu Yilun <yilun.xu@linux.intel.com>:
>
> On Fri, Jun 28, 2024 at 05:23:46PM +0200, iansdannapel@gmail.com wrote:
> > From: Ian Dannapel <iansdannapel@gmail.com>
> >
>
> Please don't reply to the previous series when you post a new version.
sure
>
> > Add a new driver for loading binary firmware using "SPI passive
>
> Loading to some nvram or reporgraming to FPGA logic blocks.
>
> > programming" on Efinix FPGAs.
> >
> > Signed-off-by: Ian Dannapel <iansdannapel@gmail.com>
> > ---
> >  drivers/fpga/Kconfig                    |   8 +
> >  drivers/fpga/Makefile                   |   1 +
> >  drivers/fpga/efinix-trion-spi-passive.c | 219 ++++++++++++++++++++++++
> >  3 files changed, 228 insertions(+)
> >  create mode 100644 drivers/fpga/efinix-trion-spi-passive.c
> >
> > diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
> > index 37b35f58f0df..25579510e49e 100644
> > --- a/drivers/fpga/Kconfig
> > +++ b/drivers/fpga/Kconfig
> > @@ -83,6 +83,14 @@ config FPGA_MGR_XILINX_SPI
> >         FPGA manager driver support for Xilinx FPGA configuration
> >         over slave serial interface.
> >
> > +config FPGA_MGR_EFINIX_SPI
> > +     tristate "Efinix FPGA configuration over SPI passive"
> > +     depends on SPI
> > +     help
> > +       This option enables support for the FPGA manager driver to
> > +       configure Efinix Trion and Titanium Series FPGAs over SPI
> > +       using passive serial mode.
> > +
> >  config FPGA_MGR_ICE40_SPI
> >       tristate "Lattice iCE40 SPI"
> >       depends on OF && SPI
> > diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
> > index aeb89bb13517..1a95124ff847 100644
> > --- a/drivers/fpga/Makefile
> > +++ b/drivers/fpga/Makefile
> > @@ -18,6 +18,7 @@ obj-$(CONFIG_FPGA_MGR_TS73XX)               += ts73xx-fpga.o
> >  obj-$(CONFIG_FPGA_MGR_XILINX_CORE)   += xilinx-core.o
> >  obj-$(CONFIG_FPGA_MGR_XILINX_SELECTMAP)      += xilinx-selectmap.o
> >  obj-$(CONFIG_FPGA_MGR_XILINX_SPI)    += xilinx-spi.o
> > +obj-$(CONFIG_FPGA_MGR_EFINIX_SPI)    += efinix-trion-spi-passive.o
> >  obj-$(CONFIG_FPGA_MGR_ZYNQ_FPGA)     += zynq-fpga.o
> >  obj-$(CONFIG_FPGA_MGR_ZYNQMP_FPGA)   += zynqmp-fpga.o
> >  obj-$(CONFIG_FPGA_MGR_VERSAL_FPGA)   += versal-fpga.o
> > diff --git a/drivers/fpga/efinix-trion-spi-passive.c b/drivers/fpga/efinix-trion-spi-passive.c
> > new file mode 100644
> > index 000000000000..eb2592e788b9
> > --- /dev/null
> > +++ b/drivers/fpga/efinix-trion-spi-passive.c
> > @@ -0,0 +1,219 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Trion and Titanium Series FPGA SPI Passive Programming Driver
> > + *
> > + * Copyright (C) 2024 iris-GmbH infrared & intelligent sensors
> > + *
> > + * Ian Dannapel <iansdannapel@gmail.com>
> > + *
> > + * Manage Efinix FPGA firmware that is loaded over SPI using
> > + * the serial configuration interface.
> > + */
> > +
> > +#include <linux/delay.h>
> > +#include <linux/device.h>
> > +#include <linux/fpga/fpga-mgr.h>
> > +#include <linux/gpio/consumer.h>
> > +#include <linux/module.h>
> > +#include <linux/mod_devicetable.h>
> > +#include <linux/of.h>
> > +#include <linux/spi/spi.h>
> > +#include <linux/sizes.h>
> > +
> > +struct efinix_spi_conf {
> > +     struct spi_device *spi;
> > +     struct gpio_desc *cdone;
> > +     struct gpio_desc *creset;
> > +     struct gpio_desc *cs;
> > +};
> > +
> > +static int get_cdone_gpio(struct fpga_manager *mgr)
>
> Is it better use 'struct efinix_spi_conf *conf' as parameter?
>
> Same for the following functions.
>
> > +{
> > +     struct efinix_spi_conf *conf = mgr->priv;
> > +     int ret;
> > +
> > +     ret = gpiod_get_value(conf->cdone);
> > +     if (ret < 0)
> > +             dev_err(&mgr->dev, "Error reading CDONE (%d)\n", ret);
> > +
> > +     return ret;
> > +}
> > +
> > +static void reset(struct fpga_manager *mgr)
>
> Please unify the naming of the internal functions. You use
> 'efinix_spi_apply_clk_cycles()' below.
>
> > +{
> > +     struct efinix_spi_conf *conf = mgr->priv;
> > +
> > +     gpiod_set_value(conf->creset, 1);
> > +     /* wait tCRESET_N */
> > +     usleep_range(5, 15);
> > +     gpiod_set_value(conf->creset, 0);
> > +}
> > +
> > +static enum fpga_mgr_states efinix_spi_state(struct fpga_manager *mgr)
> > +{
> > +     struct efinix_spi_conf *conf = mgr->priv;
> > +
> > +     if (conf->cdone && get_cdone_gpio(mgr) == 1)
> > +             return FPGA_MGR_STATE_OPERATING;
> > +
> > +     return FPGA_MGR_STATE_UNKNOWN;
> > +}
> > +
> > +static int efinix_spi_apply_clk_cycles(struct fpga_manager *mgr)
> > +{
> > +     struct efinix_spi_conf *conf = mgr->priv;
> > +     char data[13] = {0};
> > +
> > +     return spi_write(conf->spi, data, sizeof(data));
> > +}
> > +
> > +static int efinix_spi_write_init(struct fpga_manager *mgr,
> > +                              struct fpga_image_info *info,
> > +                              const char *buf, size_t count)
> > +{
> > +     struct efinix_spi_conf *conf = mgr->priv;
> > +
> > +     if (info->flags & FPGA_MGR_PARTIAL_RECONFIG) {
> > +             dev_err(&mgr->dev, "Partial reconfiguration not supported\n");
> > +             return -EINVAL;
> > +     }
> > +
> > +     /* reset with chip select active */
> > +     gpiod_set_value(conf->cs, 1);
>
> Why operating chip selective at SPI client driver? Isn't it the job for SPI
> controller?
to enter the passive programming mode, a reset must be executed while
the chip select is active.
The is controlling the chip select from here, since I expect that the
SPI controller to only activate
the CS when communicating.
>
> > +     usleep_range(5, 15);
> > +     reset(mgr);
> > +
> > +     /* wait tDMIN */
> > +     usleep_range(100, 150);
> > +
> > +     return 0;
> > +}
> > +
> > +static int efinix_spi_write(struct fpga_manager *mgr, const char *buf,
> > +                         size_t count)
> > +{
> > +     struct efinix_spi_conf *conf = mgr->priv;
> > +     int ret;
> > +
> > +     ret = spi_write(conf->spi, buf, count);
> > +     if (ret) {
> > +             dev_err(&mgr->dev, "SPI error in firmware write: %d\n",
> > +                     ret);
> > +             return ret;
> > +     }
> > +
> > +     /* append at least 100 clock cycles */
> > +     efinix_spi_apply_clk_cycles(mgr);
> > +
> > +     /* release chip select */
> > +     gpiod_set_value(conf->cs, 0);
>
> Is it correct? What if there is remaining data to write?
I assumed that the spi controller should write complete buffer and
decide on the transfer block size,
so there shouldn't be any remaining data. Can someone confirm?
>
> > +
> > +     return 0;
> > +}
> > +
> > +static int efinix_spi_write_complete(struct fpga_manager *mgr,
> > +                                  struct fpga_image_info *info)
> > +{
> > +     struct efinix_spi_conf *conf = mgr->priv;
> > +     unsigned long timeout =
> > +             jiffies + usecs_to_jiffies(info->config_complete_timeout_us);
> > +     bool expired = false;
> > +     int done;
> > +
> > +     if (conf->cdone) {
> > +             while (!expired) {
> > +                     expired = time_after(jiffies, timeout);
> > +
> > +                     done = get_cdone_gpio(mgr);
> > +                     if (done < 0)
> > +                             return done;
> > +
> > +                     if (done)
> > +                             break;
> > +             }
> > +     }
> > +
> > +     if (expired)
> > +             return -ETIMEDOUT;
> > +
> > +     /* wait tUSER */
> > +     usleep_range(75, 125);
> > +
> > +     return 0;
> > +}
> > +
> > +static const struct fpga_manager_ops efinix_spi_ops = {
> > +     .state = efinix_spi_state,
> > +     .write_init = efinix_spi_write_init,
> > +     .write = efinix_spi_write,
> > +     .write_complete = efinix_spi_write_complete,
> > +};
> > +
> > +static int efinix_spi_probe(struct spi_device *spi)
> > +{
> > +     struct efinix_spi_conf *conf;
> > +     struct fpga_manager *mgr;
> > +
> > +     conf = devm_kzalloc(&spi->dev, sizeof(*conf), GFP_KERNEL);
> > +     if (!conf)
> > +             return -ENOMEM;
> > +
> > +     conf->spi = spi;
> > +
> > +     conf->creset = devm_gpiod_get(&spi->dev, "creset", GPIOD_OUT_HIGH);
> > +     if (IS_ERR(conf->creset))
> > +             return dev_err_probe(&spi->dev, PTR_ERR(conf->creset),
> > +                             "Failed to get RESET gpio\n");
> > +
> > +     conf->cs = devm_gpiod_get(&spi->dev, "cs", GPIOD_OUT_HIGH);
> > +     if (IS_ERR(conf->cs))
> > +             return dev_err_probe(&spi->dev, PTR_ERR(conf->cs),
> > +                             "Failed to get CHIP_SELECT gpio\n");
> > +
> > +     if (!(spi->mode & SPI_CPHA) || !(spi->mode & SPI_CPOL))
> > +             return dev_err_probe(&spi->dev, PTR_ERR(conf->cs),
> > +                             "Unsupported SPI mode, set CPHA and CPOL\n");
> > +
> > +     conf->cdone = devm_gpiod_get_optional(&spi->dev, "cdone", GPIOD_IN);
> > +     if (IS_ERR(conf->cdone))
> > +             return dev_err_probe(&spi->dev, PTR_ERR(conf->cdone),
> > +                             "Failed to get CDONE gpio\n");
> > +
> > +     mgr = devm_fpga_mgr_register(&spi->dev,
> > +                             "Efinix SPI Passive Programming FPGA Manager",
> > +                                     &efinix_spi_ops, conf);
> > +
> > +     return PTR_ERR_OR_ZERO(mgr);
> > +}
> > +
> > +#ifdef CONFIG_OF
> > +static const struct of_device_id efnx_spi_of_match[] = {
> > +     { .compatible = "efinix,trion-spi-passive", },
> > +     { .compatible = "efinix,titanium-spi-passive", },
> > +     {}
> > +};
> > +MODULE_DEVICE_TABLE(of, efnx_spi_of_match);
> > +#endif
> > +
> > +static const struct spi_device_id efinix_ids[] = {
> > +     { "trion-spi-passive", 0 },
> > +     { "titanium-spi-passive", 0 },
> > +     {},
> > +};
> > +MODULE_DEVICE_TABLE(spi, efinix_ids);
> > +
> > +
>
> remove the extra blank line.
>
> > +static struct spi_driver efinix_spi_passive_driver = {
> > +     .driver = {
> > +             .name = "efinix-fpga-spi-passive",
> > +             .of_match_table = of_match_ptr(efnx_spi_of_match),
>
> Is it OK remove CONFIG_OF & of_match_ptr()?
I don't think it could work without device tree support
>
> Thanks,
> Yilun
>
> > +     },
> > +     .probe = efinix_spi_probe,
> > +     .id_table = efinix_ids,
> > +};
> > +
> > +module_spi_driver(efinix_spi_passive_driver);
> > +
> > +MODULE_LICENSE("GPL");
> > +MODULE_AUTHOR("Ian Dannapel <iansdannapel@gmail.com>");
> > +MODULE_DESCRIPTION("Load Efinix FPGA firmware over SPI passive");
> > --
> > 2.34.1
> >
> >

I will soon prepare a v3 for the rest.

Thanks
Ian

