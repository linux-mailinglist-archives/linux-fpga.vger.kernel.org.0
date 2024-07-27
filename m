Return-Path: <linux-fpga+bounces-581-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0684293E00D
	for <lists+linux-fpga@lfdr.de>; Sat, 27 Jul 2024 18:00:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67724B2146A
	for <lists+linux-fpga@lfdr.de>; Sat, 27 Jul 2024 16:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F33B181B8E;
	Sat, 27 Jul 2024 16:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dnY2tWFK"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 284DD1E533;
	Sat, 27 Jul 2024 16:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722096033; cv=none; b=WRDFbLCk81M2i6nahNbm+Mj5E47gobr4jspoGH1MRoEuYIgfbhDZE2FSg6e3X0EPMf6Q62U/U4VUVxo8fSnk47+nysBMieMORF3Ow99P+1+7ZRDYClLSfOzdWciWcYcow1XbIMKvqp3R43yNc+wa0/UY8EtfHzGJD22t0RGYUtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722096033; c=relaxed/simple;
	bh=jZK/rmA4ayO7aWEQBS2PzK8pYVctyzjXoQECEIKOeMo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qHBUrORiPCc8epNQbzuhwaqaTKWZPewBP6FrdWr19uQs4K594ZWkGf/0Ctv7l3Yf28q1qlx4EglrX9DMTVacKIvb/Xk3MugBwoQyTlcfsar0Zbin5FiY7yebONHYPzYpnOs2BZcbbQOW3Q8uciIkHEbHJgzd4OkeKhVhgEfpRAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dnY2tWFK; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722096031; x=1753632031;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jZK/rmA4ayO7aWEQBS2PzK8pYVctyzjXoQECEIKOeMo=;
  b=dnY2tWFKJ1PpPXf35dqKf3Ju+QVETRvKgVUJ4HbPTz13CStKDpqXw6zV
   VnzCc+LtnBNl/vnU6uGYSGlDKtxlWYLdGnG6MV24fT31LUq3s2gSTykt2
   SSPFWQt4iBeMnGcR+MVNYBJ7dXnyaqsoi3dYeB2ha7ku/duX7dIBW2CLn
   HSmecgEEKFqXQDiXtMWfkRfthlwYpBuWXS8DWxy4aYZzym4S3TD1aEWzu
   grb6L/33o6Q0kI+cpDbDE/Pa29N7R5UEBZjlomHop99NuOz6UANsHFiTk
   wdekVJngkiAxFXL/xywtmYjuLHsHI7pMbujnu3xeRPoDHYQVthQv50qmK
   g==;
X-CSE-ConnectionGUID: NW3LnwlPRH+x0H+HiwU2Lw==
X-CSE-MsgGUID: jl04zFMxSo6/MsU9hX7HMg==
X-IronPort-AV: E=McAfee;i="6700,10204,11146"; a="22788670"
X-IronPort-AV: E=Sophos;i="6.09,241,1716274800"; 
   d="scan'208";a="22788670"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2024 09:00:30 -0700
X-CSE-ConnectionGUID: lJb010xXT/C2Y/p9MNpB2g==
X-CSE-MsgGUID: 1UJ96dyvRkOMvrEIihIpSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,241,1716274800"; 
   d="scan'208";a="84189567"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa002.jf.intel.com with ESMTP; 27 Jul 2024 09:00:26 -0700
Date: Sat, 27 Jul 2024 23:58:35 +0800
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
Message-ID: <ZqUZK14ROqNvVuiO@yilunxu-OptiPlex-7050>
References: <20240620144217.124733-1-iansdannapel@gmail.com>
 <20240628152348.61133-1-iansdannapel@gmail.com>
 <20240628152348.61133-2-iansdannapel@gmail.com>
 <ZpDSz5dp+zFPYjVw@yilunxu-OptiPlex-7050>
 <CAKrir7iHjxnRvZvch8ADgGFymm_z1=rU8gOM+Q==xpe64G6xkA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKrir7iHjxnRvZvch8ADgGFymm_z1=rU8gOM+Q==xpe64G6xkA@mail.gmail.com>

On Thu, Jul 25, 2024 at 03:44:54PM +0200, Ian Dannapel wrote:
> Hi Yilun, thanks for the review.
> 
> Am Fr., 12. Juli 2024 um 09:00 Uhr schrieb Xu Yilun <yilun.xu@linux.intel.com>:
> >
> > On Fri, Jun 28, 2024 at 05:23:46PM +0200, iansdannapel@gmail.com wrote:
> > > From: Ian Dannapel <iansdannapel@gmail.com>
> > >
> >
> > Please don't reply to the previous series when you post a new version.
> sure
> >
> > > Add a new driver for loading binary firmware using "SPI passive
> >
> > Loading to some nvram or reporgraming to FPGA logic blocks.

Sorry for typo, this is a question:

  Loading to some nvram or reporgraming to FPGA logic blocks?

> >
> > > programming" on Efinix FPGAs.
> > >
> > > Signed-off-by: Ian Dannapel <iansdannapel@gmail.com>
> > > ---
> > >  drivers/fpga/Kconfig                    |   8 +
> > >  drivers/fpga/Makefile                   |   1 +
> > >  drivers/fpga/efinix-trion-spi-passive.c | 219 ++++++++++++++++++++++++
> > >  3 files changed, 228 insertions(+)
> > >  create mode 100644 drivers/fpga/efinix-trion-spi-passive.c
> > >
> > > diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
> > > index 37b35f58f0df..25579510e49e 100644
> > > --- a/drivers/fpga/Kconfig
> > > +++ b/drivers/fpga/Kconfig
> > > @@ -83,6 +83,14 @@ config FPGA_MGR_XILINX_SPI
> > >         FPGA manager driver support for Xilinx FPGA configuration
> > >         over slave serial interface.
> > >
> > > +config FPGA_MGR_EFINIX_SPI
> > > +     tristate "Efinix FPGA configuration over SPI passive"
> > > +     depends on SPI
> > > +     help
> > > +       This option enables support for the FPGA manager driver to
> > > +       configure Efinix Trion and Titanium Series FPGAs over SPI
> > > +       using passive serial mode.
> > > +
> > >  config FPGA_MGR_ICE40_SPI
> > >       tristate "Lattice iCE40 SPI"
> > >       depends on OF && SPI
> > > diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
> > > index aeb89bb13517..1a95124ff847 100644
> > > --- a/drivers/fpga/Makefile
> > > +++ b/drivers/fpga/Makefile
> > > @@ -18,6 +18,7 @@ obj-$(CONFIG_FPGA_MGR_TS73XX)               += ts73xx-fpga.o
> > >  obj-$(CONFIG_FPGA_MGR_XILINX_CORE)   += xilinx-core.o
> > >  obj-$(CONFIG_FPGA_MGR_XILINX_SELECTMAP)      += xilinx-selectmap.o
> > >  obj-$(CONFIG_FPGA_MGR_XILINX_SPI)    += xilinx-spi.o
> > > +obj-$(CONFIG_FPGA_MGR_EFINIX_SPI)    += efinix-trion-spi-passive.o
> > >  obj-$(CONFIG_FPGA_MGR_ZYNQ_FPGA)     += zynq-fpga.o
> > >  obj-$(CONFIG_FPGA_MGR_ZYNQMP_FPGA)   += zynqmp-fpga.o
> > >  obj-$(CONFIG_FPGA_MGR_VERSAL_FPGA)   += versal-fpga.o
> > > diff --git a/drivers/fpga/efinix-trion-spi-passive.c b/drivers/fpga/efinix-trion-spi-passive.c
> > > new file mode 100644
> > > index 000000000000..eb2592e788b9
> > > --- /dev/null
> > > +++ b/drivers/fpga/efinix-trion-spi-passive.c
> > > @@ -0,0 +1,219 @@
> > > +// SPDX-License-Identifier: GPL-2.0-only
> > > +/*
> > > + * Trion and Titanium Series FPGA SPI Passive Programming Driver
> > > + *
> > > + * Copyright (C) 2024 iris-GmbH infrared & intelligent sensors
> > > + *
> > > + * Ian Dannapel <iansdannapel@gmail.com>
> > > + *
> > > + * Manage Efinix FPGA firmware that is loaded over SPI using
> > > + * the serial configuration interface.
> > > + */
> > > +
> > > +#include <linux/delay.h>
> > > +#include <linux/device.h>
> > > +#include <linux/fpga/fpga-mgr.h>
> > > +#include <linux/gpio/consumer.h>
> > > +#include <linux/module.h>
> > > +#include <linux/mod_devicetable.h>
> > > +#include <linux/of.h>
> > > +#include <linux/spi/spi.h>
> > > +#include <linux/sizes.h>
> > > +
> > > +struct efinix_spi_conf {
> > > +     struct spi_device *spi;
> > > +     struct gpio_desc *cdone;
> > > +     struct gpio_desc *creset;
> > > +     struct gpio_desc *cs;
> > > +};
> > > +
> > > +static int get_cdone_gpio(struct fpga_manager *mgr)
> >
> > Is it better use 'struct efinix_spi_conf *conf' as parameter?
> >
> > Same for the following functions.
> >
> > > +{
> > > +     struct efinix_spi_conf *conf = mgr->priv;
> > > +     int ret;
> > > +
> > > +     ret = gpiod_get_value(conf->cdone);
> > > +     if (ret < 0)
> > > +             dev_err(&mgr->dev, "Error reading CDONE (%d)\n", ret);
> > > +
> > > +     return ret;
> > > +}
> > > +
> > > +static void reset(struct fpga_manager *mgr)
> >
> > Please unify the naming of the internal functions. You use
> > 'efinix_spi_apply_clk_cycles()' below.
> >
> > > +{
> > > +     struct efinix_spi_conf *conf = mgr->priv;
> > > +
> > > +     gpiod_set_value(conf->creset, 1);
> > > +     /* wait tCRESET_N */
> > > +     usleep_range(5, 15);
> > > +     gpiod_set_value(conf->creset, 0);
> > > +}
> > > +
> > > +static enum fpga_mgr_states efinix_spi_state(struct fpga_manager *mgr)
> > > +{
> > > +     struct efinix_spi_conf *conf = mgr->priv;
> > > +
> > > +     if (conf->cdone && get_cdone_gpio(mgr) == 1)
> > > +             return FPGA_MGR_STATE_OPERATING;
> > > +
> > > +     return FPGA_MGR_STATE_UNKNOWN;
> > > +}
> > > +
> > > +static int efinix_spi_apply_clk_cycles(struct fpga_manager *mgr)
> > > +{
> > > +     struct efinix_spi_conf *conf = mgr->priv;
> > > +     char data[13] = {0};
> > > +
> > > +     return spi_write(conf->spi, data, sizeof(data));
> > > +}
> > > +
> > > +static int efinix_spi_write_init(struct fpga_manager *mgr,
> > > +                              struct fpga_image_info *info,
> > > +                              const char *buf, size_t count)
> > > +{
> > > +     struct efinix_spi_conf *conf = mgr->priv;
> > > +
> > > +     if (info->flags & FPGA_MGR_PARTIAL_RECONFIG) {
> > > +             dev_err(&mgr->dev, "Partial reconfiguration not supported\n");
> > > +             return -EINVAL;
> > > +     }
> > > +
> > > +     /* reset with chip select active */
> > > +     gpiod_set_value(conf->cs, 1);
> >
> > Why operating chip selective at SPI client driver? Isn't it the job for SPI
> > controller?
> to enter the passive programming mode, a reset must be executed while
> the chip select is active.
> The is controlling the chip select from here, since I expect that the
> SPI controller to only activate
> the CS when communicating.

The concern is, it may conflict with the underlying cs control in spi
controller.

There are several control flags in struct spi_transfter to affect cs. Is
there any chance using them, or try to improve if they doesn't meet your
request?

> >
> > > +     usleep_range(5, 15);
> > > +     reset(mgr);
> > > +
> > > +     /* wait tDMIN */
> > > +     usleep_range(100, 150);

And these ones, or you could use some delay controls in struct spi_transfer.

> > > +
> > > +     return 0;
> > > +}
> > > +
> > > +static int efinix_spi_write(struct fpga_manager *mgr, const char *buf,
> > > +                         size_t count)
> > > +{
> > > +     struct efinix_spi_conf *conf = mgr->priv;
> > > +     int ret;
> > > +
> > > +     ret = spi_write(conf->spi, buf, count);
> > > +     if (ret) {
> > > +             dev_err(&mgr->dev, "SPI error in firmware write: %d\n",
> > > +                     ret);
> > > +             return ret;
> > > +     }
> > > +
> > > +     /* append at least 100 clock cycles */
> > > +     efinix_spi_apply_clk_cycles(mgr);
> > > +
> > > +     /* release chip select */
> > > +     gpiod_set_value(conf->cs, 0);
> >
> > Is it correct? What if there is remaining data to write?
> I assumed that the spi controller should write complete buffer and
> decide on the transfer block size,
> so there shouldn't be any remaining data. Can someone confirm?

This is not about spi transfer, it is the fpga_manager_ops.write could
be called multiple times during one time reprogramming. Please
investigate more about the FPGA mgr core.

Thanks,
Yilun

