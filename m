Return-Path: <linux-fpga+bounces-586-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 775C193F8C3
	for <lists+linux-fpga@lfdr.de>; Mon, 29 Jul 2024 16:52:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 144372811AB
	for <lists+linux-fpga@lfdr.de>; Mon, 29 Jul 2024 14:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D55C155301;
	Mon, 29 Jul 2024 14:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dRDUrnmM"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C9E014601E;
	Mon, 29 Jul 2024 14:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722264757; cv=none; b=c6dtgzUp6NK0xzmngTkYLjItzxaq/lgX6hzFVtJEiIcO4tLeI6lvURZBxDknk2i62gFeH9MY5WQWrjKQrz3rnP6HQvloEHZ6/7OjJSm4afUL1SGnHUsQzQexCJY6PXHmZCsUAYoVTIus1W+OZdcU2Ux/uboUHEEooXDLObiBSuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722264757; c=relaxed/simple;
	bh=HA5U8J/0cZAQHyQHsQHwWyAbSeeJuUKl71C1GXxq5BA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VBLmCEzbK+ZJZjKGrFZB0k+cMw2NCyIY2redrW0dsDbWABOZV9jxBXIISK2m4HKRXwYkRBbzFajy4jMDHWiFWCRgCd2ieIAfX9ILq+TW8/ktqixRgxBYCpDKRlg/DtoKDU4KKQ3wH+dZhDY46ZXWT2iEfcBgRo7H5GnnGLtqFy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dRDUrnmM; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722264755; x=1753800755;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HA5U8J/0cZAQHyQHsQHwWyAbSeeJuUKl71C1GXxq5BA=;
  b=dRDUrnmMpzd7P+vP9P4pQIt+j2XTT3njiyzl5ZsosClK7CYyzoWjjRAL
   QFOSCo/EkKei27I8IZ0L+Be+w43ylLDw8KmUHpEEjLF+oibu3SqImIBvh
   YieB5oe6N8UStILiKAncnchRuyyZRSxcyvILXGm3BGujjBm5T6WYUrFtJ
   6oPUM0N+0JSfmeVfS/g7gOkBh+kWgxpRW8Aqkx8x4wNAx5W67ybORELEl
   IBXXAlki/svFIYC05J/lmrfmlV2IUT3G8087WqlKGFmY2uDFvrNW5IwNZ
   Jk684SL1HAktJuGKW+wyO9HYP/CB3g8ZfOYh/hWNqzYszjtjAhl2dEe47
   w==;
X-CSE-ConnectionGUID: 1w62rMW6S4Kblw6J7oVdcA==
X-CSE-MsgGUID: 2TO8UP6qSmqgAdHeGEaKGg==
X-IronPort-AV: E=McAfee;i="6700,10204,11148"; a="20156303"
X-IronPort-AV: E=Sophos;i="6.09,246,1716274800"; 
   d="scan'208";a="20156303"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2024 07:52:07 -0700
X-CSE-ConnectionGUID: mxsAZBDpRb+gl1o8UrT1fg==
X-CSE-MsgGUID: p737N3MSSz+nYiyz0Uzb1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,246,1716274800"; 
   d="scan'208";a="58128517"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa003.fm.intel.com with ESMTP; 29 Jul 2024 07:52:02 -0700
Date: Mon, 29 Jul 2024 22:50:10 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Ian Dannapel <iansdannapel@gmail.com>
Cc: Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
	Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko.stuebner@cherry.de>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Sebastian Reichel <sre@kernel.org>,
	Chris Morgan <macromorgan@hotmail.com>,
	Michael Riesch <michael.riesch@wolfvision.net>,
	=?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
	Andre Przywara <andre.przywara@arm.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-fpga@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] fpga: Add Efinix Trion & Titanium serial SPI
 programming driver
Message-ID: <ZqesIi6pW12TlPlc@yilunxu-OptiPlex-7050>
References: <20240620144217.124733-1-iansdannapel@gmail.com>
 <20240628152348.61133-1-iansdannapel@gmail.com>
 <20240628152348.61133-2-iansdannapel@gmail.com>
 <ZpDSz5dp+zFPYjVw@yilunxu-OptiPlex-7050>
 <CAKrir7iHjxnRvZvch8ADgGFymm_z1=rU8gOM+Q==xpe64G6xkA@mail.gmail.com>
 <ZqUZK14ROqNvVuiO@yilunxu-OptiPlex-7050>
 <CAKrir7jU4dAWREMVLbe1A3a1TGOb8r-UM2zviZEXYY9nzJrm7A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKrir7jU4dAWREMVLbe1A3a1TGOb8r-UM2zviZEXYY9nzJrm7A@mail.gmail.com>

On Sun, Jul 28, 2024 at 01:44:03PM +0200, Ian Dannapel wrote:
> Am Sa., 27. Juli 2024 um 18:00 Uhr schrieb Xu Yilun <yilun.xu@linux.intel.com>:
> >
> > On Thu, Jul 25, 2024 at 03:44:54PM +0200, Ian Dannapel wrote:
> > > Hi Yilun, thanks for the review.
> > >
> > > Am Fr., 12. Juli 2024 um 09:00 Uhr schrieb Xu Yilun <yilun.xu@linux.intel.com>:
> > > >
> > > > On Fri, Jun 28, 2024 at 05:23:46PM +0200, iansdannapel@gmail.com wrote:
> > > > > From: Ian Dannapel <iansdannapel@gmail.com>
> > > > >
> > > >
> > > > Please don't reply to the previous series when you post a new version.
> > > sure
> > > >
> > > > > Add a new driver for loading binary firmware using "SPI passive
> > > >
> > > > Loading to some nvram or reporgraming to FPGA logic blocks.
> >
> > Sorry for typo, this is a question:
> >
> >   Loading to some nvram or reporgraming to FPGA logic blocks?
> The datasheet refers to it as configuration RAM (CRAM) and must be
> loaded on every boot up.

The FPGA reprogramming is about loading the FPGA logic blocks, and from
the POV of the System, it is about runtime changing the HW and
re-enumerate the devices.

But some submitted fpga-mgr drivers are just used to to write nvram
backend for FPGA, don't affect any running device at all. I think these
drivers virtually have nothing to do with fpga-mgr. Some generic
storage (e.g. nvram, mtd) or firmware image loading interfaces better
fit them. I assume this driver is also of this kind.

> >
> > > >
> > > > > programming" on Efinix FPGAs.
> > > > >
> > > > > Signed-off-by: Ian Dannapel <iansdannapel@gmail.com>
> > > > > ---
> > > > >  drivers/fpga/Kconfig                    |   8 +
> > > > >  drivers/fpga/Makefile                   |   1 +
> > > > >  drivers/fpga/efinix-trion-spi-passive.c | 219 ++++++++++++++++++++++++
> > > > >  3 files changed, 228 insertions(+)
> > > > >  create mode 100644 drivers/fpga/efinix-trion-spi-passive.c
> > > > >
> > > > > diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
> > > > > index 37b35f58f0df..25579510e49e 100644
> > > > > --- a/drivers/fpga/Kconfig
> > > > > +++ b/drivers/fpga/Kconfig
> > > > > @@ -83,6 +83,14 @@ config FPGA_MGR_XILINX_SPI
> > > > >         FPGA manager driver support for Xilinx FPGA configuration
> > > > >         over slave serial interface.
> > > > >
> > > > > +config FPGA_MGR_EFINIX_SPI
> > > > > +     tristate "Efinix FPGA configuration over SPI passive"
> > > > > +     depends on SPI
> > > > > +     help
> > > > > +       This option enables support for the FPGA manager driver to
> > > > > +       configure Efinix Trion and Titanium Series FPGAs over SPI
> > > > > +       using passive serial mode.
> > > > > +
> > > > >  config FPGA_MGR_ICE40_SPI
> > > > >       tristate "Lattice iCE40 SPI"
> > > > >       depends on OF && SPI
> > > > > diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
> > > > > index aeb89bb13517..1a95124ff847 100644
> > > > > --- a/drivers/fpga/Makefile
> > > > > +++ b/drivers/fpga/Makefile
> > > > > @@ -18,6 +18,7 @@ obj-$(CONFIG_FPGA_MGR_TS73XX)               += ts73xx-fpga.o
> > > > >  obj-$(CONFIG_FPGA_MGR_XILINX_CORE)   += xilinx-core.o
> > > > >  obj-$(CONFIG_FPGA_MGR_XILINX_SELECTMAP)      += xilinx-selectmap.o
> > > > >  obj-$(CONFIG_FPGA_MGR_XILINX_SPI)    += xilinx-spi.o
> > > > > +obj-$(CONFIG_FPGA_MGR_EFINIX_SPI)    += efinix-trion-spi-passive.o
> > > > >  obj-$(CONFIG_FPGA_MGR_ZYNQ_FPGA)     += zynq-fpga.o
> > > > >  obj-$(CONFIG_FPGA_MGR_ZYNQMP_FPGA)   += zynqmp-fpga.o
> > > > >  obj-$(CONFIG_FPGA_MGR_VERSAL_FPGA)   += versal-fpga.o
> > > > > diff --git a/drivers/fpga/efinix-trion-spi-passive.c b/drivers/fpga/efinix-trion-spi-passive.c
> > > > > new file mode 100644
> > > > > index 000000000000..eb2592e788b9
> > > > > --- /dev/null
> > > > > +++ b/drivers/fpga/efinix-trion-spi-passive.c
> > > > > @@ -0,0 +1,219 @@
> > > > > +// SPDX-License-Identifier: GPL-2.0-only
> > > > > +/*
> > > > > + * Trion and Titanium Series FPGA SPI Passive Programming Driver
> > > > > + *
> > > > > + * Copyright (C) 2024 iris-GmbH infrared & intelligent sensors
> > > > > + *
> > > > > + * Ian Dannapel <iansdannapel@gmail.com>
> > > > > + *
> > > > > + * Manage Efinix FPGA firmware that is loaded over SPI using
> > > > > + * the serial configuration interface.
> > > > > + */
> > > > > +
> > > > > +#include <linux/delay.h>
> > > > > +#include <linux/device.h>
> > > > > +#include <linux/fpga/fpga-mgr.h>
> > > > > +#include <linux/gpio/consumer.h>
> > > > > +#include <linux/module.h>
> > > > > +#include <linux/mod_devicetable.h>
> > > > > +#include <linux/of.h>
> > > > > +#include <linux/spi/spi.h>
> > > > > +#include <linux/sizes.h>
> > > > > +
> > > > > +struct efinix_spi_conf {
> > > > > +     struct spi_device *spi;
> > > > > +     struct gpio_desc *cdone;
> > > > > +     struct gpio_desc *creset;
> > > > > +     struct gpio_desc *cs;
> > > > > +};
> > > > > +
> > > > > +static int get_cdone_gpio(struct fpga_manager *mgr)
> > > >
> > > > Is it better use 'struct efinix_spi_conf *conf' as parameter?
> > > >
> > > > Same for the following functions.
> > > >
> > > > > +{
> > > > > +     struct efinix_spi_conf *conf = mgr->priv;
> > > > > +     int ret;
> > > > > +
> > > > > +     ret = gpiod_get_value(conf->cdone);
> > > > > +     if (ret < 0)
> > > > > +             dev_err(&mgr->dev, "Error reading CDONE (%d)\n", ret);
> > > > > +
> > > > > +     return ret;
> > > > > +}
> > > > > +
> > > > > +static void reset(struct fpga_manager *mgr)
> > > >
> > > > Please unify the naming of the internal functions. You use
> > > > 'efinix_spi_apply_clk_cycles()' below.
> > > >
> > > > > +{
> > > > > +     struct efinix_spi_conf *conf = mgr->priv;
> > > > > +
> > > > > +     gpiod_set_value(conf->creset, 1);
> > > > > +     /* wait tCRESET_N */
> > > > > +     usleep_range(5, 15);
> > > > > +     gpiod_set_value(conf->creset, 0);
> > > > > +}
> > > > > +
> > > > > +static enum fpga_mgr_states efinix_spi_state(struct fpga_manager *mgr)
> > > > > +{
> > > > > +     struct efinix_spi_conf *conf = mgr->priv;
> > > > > +
> > > > > +     if (conf->cdone && get_cdone_gpio(mgr) == 1)
> > > > > +             return FPGA_MGR_STATE_OPERATING;
> > > > > +
> > > > > +     return FPGA_MGR_STATE_UNKNOWN;
> > > > > +}
> > > > > +
> > > > > +static int efinix_spi_apply_clk_cycles(struct fpga_manager *mgr)
> > > > > +{
> > > > > +     struct efinix_spi_conf *conf = mgr->priv;
> > > > > +     char data[13] = {0};
> > > > > +
> > > > > +     return spi_write(conf->spi, data, sizeof(data));
> > > > > +}
> > > > > +
> > > > > +static int efinix_spi_write_init(struct fpga_manager *mgr,
> > > > > +                              struct fpga_image_info *info,
> > > > > +                              const char *buf, size_t count)
> > > > > +{
> > > > > +     struct efinix_spi_conf *conf = mgr->priv;
> > > > > +
> > > > > +     if (info->flags & FPGA_MGR_PARTIAL_RECONFIG) {
> > > > > +             dev_err(&mgr->dev, "Partial reconfiguration not supported\n");
> > > > > +             return -EINVAL;
> > > > > +     }
> > > > > +
> > > > > +     /* reset with chip select active */
> > > > > +     gpiod_set_value(conf->cs, 1);
> > > >
> > > > Why operating chip selective at SPI client driver? Isn't it the job for SPI
> > > > controller?
> > > to enter the passive programming mode, a reset must be executed while
> > > the chip select is active.
> > > The is controlling the chip select from here, since I expect that the
> > > SPI controller to only activate
> > > the CS when communicating.
> >
> > The concern is, it may conflict with the underlying cs control in spi
> > controller.
> >
> > There are several control flags in struct spi_transfter to affect cs. Is
> > there any chance using them, or try to improve if they doesn't meet your
> > request?
> The main problem of this chip is that probably the of SPI is out of
> spec, so would like to avoid changes in the spi contoller for this
> edge case.
> That is probably one the reasons that the datasheet does not recommend
> other devices on the same SPI bus.

I think anyway you need to communicate with spi controller driver and
have one voice how/who to take control of cs, rather than blindly
operate at both sides.

Thanks,
Yilun

