Return-Path: <linux-fpga+bounces-582-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0DF993E4D1
	for <lists+linux-fpga@lfdr.de>; Sun, 28 Jul 2024 13:44:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FDF21C210A7
	for <lists+linux-fpga@lfdr.de>; Sun, 28 Jul 2024 11:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A22A38FB0;
	Sun, 28 Jul 2024 11:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kcexS70K"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BBCC21105;
	Sun, 28 Jul 2024 11:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722167060; cv=none; b=eWRGFTD1IgFmQrcWM7p8y0G77uqnS/T/oFCWNTaRL0M6a9STxK7SY+mMnewxnhCH0ymxEmJBZOaLKPj2A8ettyFiBKY8zAGJYCw5Rl9k3rVR1HVQu9pEsHLYlO43C3L7UdS6afEJ91WTF1KFWiwiUAkl5vPShOulxO/zkdcL97A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722167060; c=relaxed/simple;
	bh=ZWTjsg3Hg2zEAqP66DeLagEoalDLkFuFyueIvUni3Jc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WRBel/nyoisw9KhBiCAEtsTcIqjbirMK0Ry4yjCw8uVpQmY26uckzbwIUI5oRmapq/G/v8hUe680y6lOor75F0dq54IwVZsAoAZo/AtBuPSWRS6EA+mwCyA6w61Gv1qPFlcDyPsFVaZjhsqVebFjsU3zRE87orxRVNB/1iEGBwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kcexS70K; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e0874f138aeso790709276.2;
        Sun, 28 Jul 2024 04:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722167057; x=1722771857; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=V8RnFqVZ9ZBfgK0NG6HegAHRjTJo1fOnA7bfa6YsYsA=;
        b=kcexS70Kke685RrDwim4oGhiI+pbZjvBLhlXKzJhT+GJpdfoRXQwtu+tJEV45xFbV1
         +FLiTL4LY676C2iVU/FORcRiQiMb+XVkwrVLs2r0/Q5yZs+H4+zLhPP/b/gUKptOJBZG
         N6CCc32Yu04c5WYQmVEabt/IcUDZbTdbH+jTp5RDINVoshKb1qgtNwSOnNOxlWe61IJl
         jtkrj9WqACdejxx0IGqXwgsQ8ahONAz9Ml+Tld2IRW0ClZx+3nXMZ2METZXK1EY4pJ1t
         VD4glMhI89NdzsOlxz6MdDFExn3vowxZAv/F9/DruZQO0FQtdWkd4V2+ABOLloEFgk5R
         5rkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722167057; x=1722771857;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V8RnFqVZ9ZBfgK0NG6HegAHRjTJo1fOnA7bfa6YsYsA=;
        b=wJDGkNagJ79GLHSQVvqCGYxFIdGNJoEvt78lotVjO0yyGwGqquhe9klSIlL4w6pMMV
         EApOCTLQyS9s5kUyghhfgkNeqVG8MmTjojG4fdbRsWyWvhsqgEyd6dBelTHG6FXnv9VM
         Nc+AAzcdkTcSV0WF3mYUP4lJLf7G4ESG1y65D05EDncbSZwPgGz+D9GkyesG2K1ouO7d
         nzxB3/1YWtve0tLbzZTixAK/cIvSUlYehYo9drtsuDER/h9cF6Ah6zciZzpyI8t+ZW0I
         5RmhXaOAxUYfZxEL06Fa+20NVBc9RAItJaVyIy36n9zVJXOgurL2zu61TrwvT3Xa/RQE
         CxiQ==
X-Forwarded-Encrypted: i=1; AJvYcCUqs53bJD+g3+MnU0IZNENqUVawWsY+NAgeyhOAp2uQ/X2L2ugdOLJvGPpWj1+uGN07QHk4AX1vUL8x5qJteK1pOkF2CPAYbf9P2be3JOCAQEfrilRZb3XXSwKhSwQiJoVNhV06E4yvqLpc7OPs2oerIdsCJvPH3t6djV1DW9AJs0DkWxE=
X-Gm-Message-State: AOJu0YzJHzsvgNuOswXjuYR5hE9jIU7USlTvoLWytTGigSsHq7f305Rl
	ta0iZBnfM70w55n7vmSbHgLYKwdlFH8zKOskMsAH8v/v3VAD0oAENHq1T5nBba8Dr6dK6NhTd4P
	mHO0r/Xzg0+rS0ueITANdSX0SyaFTCpB2YCQ=
X-Google-Smtp-Source: AGHT+IECVOr7iQIHV68f9mNkfeOpTLvHn15/CSGxAZtXWJ5uoff/7Ed2McbC4G2JbMw06MwSRC9S+ufllWoeNYOfFIU=
X-Received: by 2002:a05:6902:1382:b0:e02:ed0f:e83b with SMTP id
 3f1490d57ef6-e0b5449c811mr3358769276.11.1722167057172; Sun, 28 Jul 2024
 04:44:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240620144217.124733-1-iansdannapel@gmail.com>
 <20240628152348.61133-1-iansdannapel@gmail.com> <20240628152348.61133-2-iansdannapel@gmail.com>
 <ZpDSz5dp+zFPYjVw@yilunxu-OptiPlex-7050> <CAKrir7iHjxnRvZvch8ADgGFymm_z1=rU8gOM+Q==xpe64G6xkA@mail.gmail.com>
 <ZqUZK14ROqNvVuiO@yilunxu-OptiPlex-7050>
In-Reply-To: <ZqUZK14ROqNvVuiO@yilunxu-OptiPlex-7050>
From: Ian Dannapel <iansdannapel@gmail.com>
Date: Sun, 28 Jul 2024 13:44:03 +0200
Message-ID: <CAKrir7jU4dAWREMVLbe1A3a1TGOb8r-UM2zviZEXYY9nzJrm7A@mail.gmail.com>
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

Am Sa., 27. Juli 2024 um 18:00 Uhr schrieb Xu Yilun <yilun.xu@linux.intel.com>:
>
> On Thu, Jul 25, 2024 at 03:44:54PM +0200, Ian Dannapel wrote:
> > Hi Yilun, thanks for the review.
> >
> > Am Fr., 12. Juli 2024 um 09:00 Uhr schrieb Xu Yilun <yilun.xu@linux.intel.com>:
> > >
> > > On Fri, Jun 28, 2024 at 05:23:46PM +0200, iansdannapel@gmail.com wrote:
> > > > From: Ian Dannapel <iansdannapel@gmail.com>
> > > >
> > >
> > > Please don't reply to the previous series when you post a new version.
> > sure
> > >
> > > > Add a new driver for loading binary firmware using "SPI passive
> > >
> > > Loading to some nvram or reporgraming to FPGA logic blocks.
>
> Sorry for typo, this is a question:
>
>   Loading to some nvram or reporgraming to FPGA logic blocks?
The datasheet refers to it as configuration RAM (CRAM) and must be
loaded on every boot up.
>
> > >
> > > > programming" on Efinix FPGAs.
> > > >
> > > > Signed-off-by: Ian Dannapel <iansdannapel@gmail.com>
> > > > ---
> > > >  drivers/fpga/Kconfig                    |   8 +
> > > >  drivers/fpga/Makefile                   |   1 +
> > > >  drivers/fpga/efinix-trion-spi-passive.c | 219 ++++++++++++++++++++++++
> > > >  3 files changed, 228 insertions(+)
> > > >  create mode 100644 drivers/fpga/efinix-trion-spi-passive.c
> > > >
> > > > diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
> > > > index 37b35f58f0df..25579510e49e 100644
> > > > --- a/drivers/fpga/Kconfig
> > > > +++ b/drivers/fpga/Kconfig
> > > > @@ -83,6 +83,14 @@ config FPGA_MGR_XILINX_SPI
> > > >         FPGA manager driver support for Xilinx FPGA configuration
> > > >         over slave serial interface.
> > > >
> > > > +config FPGA_MGR_EFINIX_SPI
> > > > +     tristate "Efinix FPGA configuration over SPI passive"
> > > > +     depends on SPI
> > > > +     help
> > > > +       This option enables support for the FPGA manager driver to
> > > > +       configure Efinix Trion and Titanium Series FPGAs over SPI
> > > > +       using passive serial mode.
> > > > +
> > > >  config FPGA_MGR_ICE40_SPI
> > > >       tristate "Lattice iCE40 SPI"
> > > >       depends on OF && SPI
> > > > diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
> > > > index aeb89bb13517..1a95124ff847 100644
> > > > --- a/drivers/fpga/Makefile
> > > > +++ b/drivers/fpga/Makefile
> > > > @@ -18,6 +18,7 @@ obj-$(CONFIG_FPGA_MGR_TS73XX)               += ts73xx-fpga.o
> > > >  obj-$(CONFIG_FPGA_MGR_XILINX_CORE)   += xilinx-core.o
> > > >  obj-$(CONFIG_FPGA_MGR_XILINX_SELECTMAP)      += xilinx-selectmap.o
> > > >  obj-$(CONFIG_FPGA_MGR_XILINX_SPI)    += xilinx-spi.o
> > > > +obj-$(CONFIG_FPGA_MGR_EFINIX_SPI)    += efinix-trion-spi-passive.o
> > > >  obj-$(CONFIG_FPGA_MGR_ZYNQ_FPGA)     += zynq-fpga.o
> > > >  obj-$(CONFIG_FPGA_MGR_ZYNQMP_FPGA)   += zynqmp-fpga.o
> > > >  obj-$(CONFIG_FPGA_MGR_VERSAL_FPGA)   += versal-fpga.o
> > > > diff --git a/drivers/fpga/efinix-trion-spi-passive.c b/drivers/fpga/efinix-trion-spi-passive.c
> > > > new file mode 100644
> > > > index 000000000000..eb2592e788b9
> > > > --- /dev/null
> > > > +++ b/drivers/fpga/efinix-trion-spi-passive.c
> > > > @@ -0,0 +1,219 @@
> > > > +// SPDX-License-Identifier: GPL-2.0-only
> > > > +/*
> > > > + * Trion and Titanium Series FPGA SPI Passive Programming Driver
> > > > + *
> > > > + * Copyright (C) 2024 iris-GmbH infrared & intelligent sensors
> > > > + *
> > > > + * Ian Dannapel <iansdannapel@gmail.com>
> > > > + *
> > > > + * Manage Efinix FPGA firmware that is loaded over SPI using
> > > > + * the serial configuration interface.
> > > > + */
> > > > +
> > > > +#include <linux/delay.h>
> > > > +#include <linux/device.h>
> > > > +#include <linux/fpga/fpga-mgr.h>
> > > > +#include <linux/gpio/consumer.h>
> > > > +#include <linux/module.h>
> > > > +#include <linux/mod_devicetable.h>
> > > > +#include <linux/of.h>
> > > > +#include <linux/spi/spi.h>
> > > > +#include <linux/sizes.h>
> > > > +
> > > > +struct efinix_spi_conf {
> > > > +     struct spi_device *spi;
> > > > +     struct gpio_desc *cdone;
> > > > +     struct gpio_desc *creset;
> > > > +     struct gpio_desc *cs;
> > > > +};
> > > > +
> > > > +static int get_cdone_gpio(struct fpga_manager *mgr)
> > >
> > > Is it better use 'struct efinix_spi_conf *conf' as parameter?
> > >
> > > Same for the following functions.
> > >
> > > > +{
> > > > +     struct efinix_spi_conf *conf = mgr->priv;
> > > > +     int ret;
> > > > +
> > > > +     ret = gpiod_get_value(conf->cdone);
> > > > +     if (ret < 0)
> > > > +             dev_err(&mgr->dev, "Error reading CDONE (%d)\n", ret);
> > > > +
> > > > +     return ret;
> > > > +}
> > > > +
> > > > +static void reset(struct fpga_manager *mgr)
> > >
> > > Please unify the naming of the internal functions. You use
> > > 'efinix_spi_apply_clk_cycles()' below.
> > >
> > > > +{
> > > > +     struct efinix_spi_conf *conf = mgr->priv;
> > > > +
> > > > +     gpiod_set_value(conf->creset, 1);
> > > > +     /* wait tCRESET_N */
> > > > +     usleep_range(5, 15);
> > > > +     gpiod_set_value(conf->creset, 0);
> > > > +}
> > > > +
> > > > +static enum fpga_mgr_states efinix_spi_state(struct fpga_manager *mgr)
> > > > +{
> > > > +     struct efinix_spi_conf *conf = mgr->priv;
> > > > +
> > > > +     if (conf->cdone && get_cdone_gpio(mgr) == 1)
> > > > +             return FPGA_MGR_STATE_OPERATING;
> > > > +
> > > > +     return FPGA_MGR_STATE_UNKNOWN;
> > > > +}
> > > > +
> > > > +static int efinix_spi_apply_clk_cycles(struct fpga_manager *mgr)
> > > > +{
> > > > +     struct efinix_spi_conf *conf = mgr->priv;
> > > > +     char data[13] = {0};
> > > > +
> > > > +     return spi_write(conf->spi, data, sizeof(data));
> > > > +}
> > > > +
> > > > +static int efinix_spi_write_init(struct fpga_manager *mgr,
> > > > +                              struct fpga_image_info *info,
> > > > +                              const char *buf, size_t count)
> > > > +{
> > > > +     struct efinix_spi_conf *conf = mgr->priv;
> > > > +
> > > > +     if (info->flags & FPGA_MGR_PARTIAL_RECONFIG) {
> > > > +             dev_err(&mgr->dev, "Partial reconfiguration not supported\n");
> > > > +             return -EINVAL;
> > > > +     }
> > > > +
> > > > +     /* reset with chip select active */
> > > > +     gpiod_set_value(conf->cs, 1);
> > >
> > > Why operating chip selective at SPI client driver? Isn't it the job for SPI
> > > controller?
> > to enter the passive programming mode, a reset must be executed while
> > the chip select is active.
> > The is controlling the chip select from here, since I expect that the
> > SPI controller to only activate
> > the CS when communicating.
>
> The concern is, it may conflict with the underlying cs control in spi
> controller.
>
> There are several control flags in struct spi_transfter to affect cs. Is
> there any chance using them, or try to improve if they doesn't meet your
> request?
The main problem of this chip is that probably the of SPI is out of
spec, so would like to avoid changes in the spi contoller for this
edge case.
That is probably one the reasons that the datasheet does not recommend
other devices on the same SPI bus.
>
> > >
> > > > +     usleep_range(5, 15);
> > > > +     reset(mgr);
> > > > +
> > > > +     /* wait tDMIN */
> > > > +     usleep_range(100, 150);
>
> And these ones, or you could use some delay controls in struct spi_transfer.
I don't think spi_transfer delay option could work in this case, the
data transfer did not start yet.
>
> > > > +
> > > > +     return 0;
> > > > +}
> > > > +
> > > > +static int efinix_spi_write(struct fpga_manager *mgr, const char *buf,
> > > > +                         size_t count)
> > > > +{
> > > > +     struct efinix_spi_conf *conf = mgr->priv;
> > > > +     int ret;
> > > > +
> > > > +     ret = spi_write(conf->spi, buf, count);
> > > > +     if (ret) {
> > > > +             dev_err(&mgr->dev, "SPI error in firmware write: %d\n",
> > > > +                     ret);
> > > > +             return ret;
> > > > +     }
> > > > +
> > > > +     /* append at least 100 clock cycles */
> > > > +     efinix_spi_apply_clk_cycles(mgr);
> > > > +
> > > > +     /* release chip select */
> > > > +     gpiod_set_value(conf->cs, 0);
> > >
> > > Is it correct? What if there is remaining data to write?
> > I assumed that the spi controller should write complete buffer and
> > decide on the transfer block size,
> > so there shouldn't be any remaining data. Can someone confirm?
>
> This is not about spi transfer, it is the fpga_manager_ops.write could
> be called multiple times during one time reprogramming. Please
> investigate more about the FPGA mgr core.
I see, I should move this to write_complete since the CS must stay low
throughout the configuration.
That is also a reason to avoid letting the SPI controller manage the CS gpio.
>
> Thanks,
> Yilun

Thanks
Ian

