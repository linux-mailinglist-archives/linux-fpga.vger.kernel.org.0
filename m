Return-Path: <linux-fpga+bounces-573-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB00192F5D7
	for <lists+linux-fpga@lfdr.de>; Fri, 12 Jul 2024 09:00:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CAFD1F25AFB
	for <lists+linux-fpga@lfdr.de>; Fri, 12 Jul 2024 07:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E54B613D621;
	Fri, 12 Jul 2024 07:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WI6RcsfU"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0164279CC;
	Fri, 12 Jul 2024 07:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720767623; cv=none; b=lIEmuaUasMJY1eFNda47/+Nss7fyXZ61YJ3JeRLq3Vf9S4qmCIqGpCTeXXQbW9NTAz7cizvZ2riPPbL3JL80ZlEso9W8bIGcsEDVVvikm5WetS65nhMyUifTbcHDh9egMJAyqt+cjrI3Di+Sdim8AfeMEu0a/dqMMTFBo/mPfes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720767623; c=relaxed/simple;
	bh=YWNPe/Cqus+tfjanU3N91pMEW64VdJ0ekr/JmIA7dss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sv5cpBN6TsvrNk4b5zXRGihZf3Fym6e4bLe/DDQfe1lQ+taQb0/NZyZUU0DQSu4eVuyidQ/JCqX3M4IjwEYQ7Csx8zvLinlDAz5JaiN0Ux4sa1HszwXiSBMkgk4FtBNeX11Ub9Kr0XbLlXoSODno4N3aBvGF5Tee2386T2OEs+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WI6RcsfU; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720767622; x=1752303622;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YWNPe/Cqus+tfjanU3N91pMEW64VdJ0ekr/JmIA7dss=;
  b=WI6RcsfUJYerVsCrBK1/sxSMUDubFvLr3NfPBcx8CQpU7t+l/09otzj0
   4hZOPsHT3JnL1I9tVQKnb6jo/WCtk492I0AkAXhv6+xIq9Tv/21vV8w/r
   NUAc919tGH3HeMI2aWrayEkB77jr1optOzDRH45O5AVFl6tDtnnqvylii
   Y6i1fF2jyMYX/M7qz/yjh5GnkEru041/HBrF450cYisuvgm2Vqj+JMHpI
   XXk490a+pPCjpRG3dB/J5mXrfIdK0vgmNeVeG2gd60en7FFZP3KwW/2Ys
   L1zHC3dI/u4cwC/i4VBZAwGLDECRquzUEuuVgq/y3ydibhkH1v9FFCZR7
   Q==;
X-CSE-ConnectionGUID: nqURL3xiSYSj7TGz8qYyWg==
X-CSE-MsgGUID: jNmIUcBXRROVBbixHl2dZQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11130"; a="17904487"
X-IronPort-AV: E=Sophos;i="6.09,202,1716274800"; 
   d="scan'208";a="17904487"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2024 00:00:21 -0700
X-CSE-ConnectionGUID: mi4bSo3vRlSFpyPu1ivf5w==
X-CSE-MsgGUID: 0+ybpHzeQB245fQdvrQzjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,202,1716274800"; 
   d="scan'208";a="53656048"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa003.jf.intel.com with ESMTP; 12 Jul 2024 00:00:16 -0700
Date: Fri, 12 Jul 2024 14:53:03 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: iansdannapel@gmail.com
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
Message-ID: <ZpDSz5dp+zFPYjVw@yilunxu-OptiPlex-7050>
References: <20240620144217.124733-1-iansdannapel@gmail.com>
 <20240628152348.61133-1-iansdannapel@gmail.com>
 <20240628152348.61133-2-iansdannapel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240628152348.61133-2-iansdannapel@gmail.com>

On Fri, Jun 28, 2024 at 05:23:46PM +0200, iansdannapel@gmail.com wrote:
> From: Ian Dannapel <iansdannapel@gmail.com>
> 

Please don't reply to the previous series when you post a new version.

> Add a new driver for loading binary firmware using "SPI passive

Loading to some nvram or reporgraming to FPGA logic blocks.

> programming" on Efinix FPGAs.
> 
> Signed-off-by: Ian Dannapel <iansdannapel@gmail.com>
> ---
>  drivers/fpga/Kconfig                    |   8 +
>  drivers/fpga/Makefile                   |   1 +
>  drivers/fpga/efinix-trion-spi-passive.c | 219 ++++++++++++++++++++++++
>  3 files changed, 228 insertions(+)
>  create mode 100644 drivers/fpga/efinix-trion-spi-passive.c
> 
> diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
> index 37b35f58f0df..25579510e49e 100644
> --- a/drivers/fpga/Kconfig
> +++ b/drivers/fpga/Kconfig
> @@ -83,6 +83,14 @@ config FPGA_MGR_XILINX_SPI
>  	  FPGA manager driver support for Xilinx FPGA configuration
>  	  over slave serial interface.
>  
> +config FPGA_MGR_EFINIX_SPI
> +	tristate "Efinix FPGA configuration over SPI passive"
> +	depends on SPI
> +	help
> +	  This option enables support for the FPGA manager driver to
> +	  configure Efinix Trion and Titanium Series FPGAs over SPI
> +	  using passive serial mode.
> +
>  config FPGA_MGR_ICE40_SPI
>  	tristate "Lattice iCE40 SPI"
>  	depends on OF && SPI
> diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
> index aeb89bb13517..1a95124ff847 100644
> --- a/drivers/fpga/Makefile
> +++ b/drivers/fpga/Makefile
> @@ -18,6 +18,7 @@ obj-$(CONFIG_FPGA_MGR_TS73XX)		+= ts73xx-fpga.o
>  obj-$(CONFIG_FPGA_MGR_XILINX_CORE)	+= xilinx-core.o
>  obj-$(CONFIG_FPGA_MGR_XILINX_SELECTMAP)	+= xilinx-selectmap.o
>  obj-$(CONFIG_FPGA_MGR_XILINX_SPI)	+= xilinx-spi.o
> +obj-$(CONFIG_FPGA_MGR_EFINIX_SPI)	+= efinix-trion-spi-passive.o
>  obj-$(CONFIG_FPGA_MGR_ZYNQ_FPGA)	+= zynq-fpga.o
>  obj-$(CONFIG_FPGA_MGR_ZYNQMP_FPGA)	+= zynqmp-fpga.o
>  obj-$(CONFIG_FPGA_MGR_VERSAL_FPGA)	+= versal-fpga.o
> diff --git a/drivers/fpga/efinix-trion-spi-passive.c b/drivers/fpga/efinix-trion-spi-passive.c
> new file mode 100644
> index 000000000000..eb2592e788b9
> --- /dev/null
> +++ b/drivers/fpga/efinix-trion-spi-passive.c
> @@ -0,0 +1,219 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Trion and Titanium Series FPGA SPI Passive Programming Driver
> + *
> + * Copyright (C) 2024 iris-GmbH infrared & intelligent sensors
> + *
> + * Ian Dannapel <iansdannapel@gmail.com>
> + *
> + * Manage Efinix FPGA firmware that is loaded over SPI using
> + * the serial configuration interface.
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/fpga/fpga-mgr.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/module.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/of.h>
> +#include <linux/spi/spi.h>
> +#include <linux/sizes.h>
> +
> +struct efinix_spi_conf {
> +	struct spi_device *spi;
> +	struct gpio_desc *cdone;
> +	struct gpio_desc *creset;
> +	struct gpio_desc *cs;
> +};
> +
> +static int get_cdone_gpio(struct fpga_manager *mgr)

Is it better use 'struct efinix_spi_conf *conf' as parameter?

Same for the following functions.

> +{
> +	struct efinix_spi_conf *conf = mgr->priv;
> +	int ret;
> +
> +	ret = gpiod_get_value(conf->cdone);
> +	if (ret < 0)
> +		dev_err(&mgr->dev, "Error reading CDONE (%d)\n", ret);
> +
> +	return ret;
> +}
> +
> +static void reset(struct fpga_manager *mgr)

Please unify the naming of the internal functions. You use
'efinix_spi_apply_clk_cycles()' below.

> +{
> +	struct efinix_spi_conf *conf = mgr->priv;
> +
> +	gpiod_set_value(conf->creset, 1);
> +	/* wait tCRESET_N */
> +	usleep_range(5, 15);
> +	gpiod_set_value(conf->creset, 0);
> +}
> +
> +static enum fpga_mgr_states efinix_spi_state(struct fpga_manager *mgr)
> +{
> +	struct efinix_spi_conf *conf = mgr->priv;
> +
> +	if (conf->cdone && get_cdone_gpio(mgr) == 1)
> +		return FPGA_MGR_STATE_OPERATING;
> +
> +	return FPGA_MGR_STATE_UNKNOWN;
> +}
> +
> +static int efinix_spi_apply_clk_cycles(struct fpga_manager *mgr)
> +{
> +	struct efinix_spi_conf *conf = mgr->priv;
> +	char data[13] = {0};
> +
> +	return spi_write(conf->spi, data, sizeof(data));
> +}
> +
> +static int efinix_spi_write_init(struct fpga_manager *mgr,
> +				 struct fpga_image_info *info,
> +				 const char *buf, size_t count)
> +{
> +	struct efinix_spi_conf *conf = mgr->priv;
> +
> +	if (info->flags & FPGA_MGR_PARTIAL_RECONFIG) {
> +		dev_err(&mgr->dev, "Partial reconfiguration not supported\n");
> +		return -EINVAL;
> +	}
> +
> +	/* reset with chip select active */
> +	gpiod_set_value(conf->cs, 1);

Why operating chip selective at SPI client driver? Isn't it the job for SPI
controller?

> +	usleep_range(5, 15);
> +	reset(mgr);
> +
> +	/* wait tDMIN */
> +	usleep_range(100, 150);
> +
> +	return 0;
> +}
> +
> +static int efinix_spi_write(struct fpga_manager *mgr, const char *buf,
> +			    size_t count)
> +{
> +	struct efinix_spi_conf *conf = mgr->priv;
> +	int ret;
> +
> +	ret = spi_write(conf->spi, buf, count);
> +	if (ret) {
> +		dev_err(&mgr->dev, "SPI error in firmware write: %d\n",
> +			ret);
> +		return ret;
> +	}
> +
> +	/* append at least 100 clock cycles */
> +	efinix_spi_apply_clk_cycles(mgr);
> +
> +	/* release chip select */
> +	gpiod_set_value(conf->cs, 0);

Is it correct? What if there is remaining data to write?

> +
> +	return 0;
> +}
> +
> +static int efinix_spi_write_complete(struct fpga_manager *mgr,
> +				     struct fpga_image_info *info)
> +{
> +	struct efinix_spi_conf *conf = mgr->priv;
> +	unsigned long timeout =
> +		jiffies + usecs_to_jiffies(info->config_complete_timeout_us);
> +	bool expired = false;
> +	int done;
> +
> +	if (conf->cdone) {
> +		while (!expired) {
> +			expired = time_after(jiffies, timeout);
> +
> +			done = get_cdone_gpio(mgr);
> +			if (done < 0)
> +				return done;
> +
> +			if (done)
> +				break;
> +		}
> +	}
> +
> +	if (expired)
> +		return -ETIMEDOUT;
> +
> +	/* wait tUSER */
> +	usleep_range(75, 125);
> +
> +	return 0;
> +}
> +
> +static const struct fpga_manager_ops efinix_spi_ops = {
> +	.state = efinix_spi_state,
> +	.write_init = efinix_spi_write_init,
> +	.write = efinix_spi_write,
> +	.write_complete = efinix_spi_write_complete,
> +};
> +
> +static int efinix_spi_probe(struct spi_device *spi)
> +{
> +	struct efinix_spi_conf *conf;
> +	struct fpga_manager *mgr;
> +
> +	conf = devm_kzalloc(&spi->dev, sizeof(*conf), GFP_KERNEL);
> +	if (!conf)
> +		return -ENOMEM;
> +
> +	conf->spi = spi;
> +
> +	conf->creset = devm_gpiod_get(&spi->dev, "creset", GPIOD_OUT_HIGH);
> +	if (IS_ERR(conf->creset))
> +		return dev_err_probe(&spi->dev, PTR_ERR(conf->creset),
> +				"Failed to get RESET gpio\n");
> +
> +	conf->cs = devm_gpiod_get(&spi->dev, "cs", GPIOD_OUT_HIGH);
> +	if (IS_ERR(conf->cs))
> +		return dev_err_probe(&spi->dev, PTR_ERR(conf->cs),
> +				"Failed to get CHIP_SELECT gpio\n");
> +
> +	if (!(spi->mode & SPI_CPHA) || !(spi->mode & SPI_CPOL))
> +		return dev_err_probe(&spi->dev, PTR_ERR(conf->cs),
> +				"Unsupported SPI mode, set CPHA and CPOL\n");
> +
> +	conf->cdone = devm_gpiod_get_optional(&spi->dev, "cdone", GPIOD_IN);
> +	if (IS_ERR(conf->cdone))
> +		return dev_err_probe(&spi->dev, PTR_ERR(conf->cdone),
> +				"Failed to get CDONE gpio\n");
> +
> +	mgr = devm_fpga_mgr_register(&spi->dev,
> +				"Efinix SPI Passive Programming FPGA Manager",
> +					&efinix_spi_ops, conf);
> +
> +	return PTR_ERR_OR_ZERO(mgr);
> +}
> +
> +#ifdef CONFIG_OF
> +static const struct of_device_id efnx_spi_of_match[] = {
> +	{ .compatible = "efinix,trion-spi-passive", },
> +	{ .compatible = "efinix,titanium-spi-passive", },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, efnx_spi_of_match);
> +#endif
> +
> +static const struct spi_device_id efinix_ids[] = {
> +	{ "trion-spi-passive", 0 },
> +	{ "titanium-spi-passive", 0 },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(spi, efinix_ids);
> +
> +

remove the extra blank line.

> +static struct spi_driver efinix_spi_passive_driver = {
> +	.driver = {
> +		.name = "efinix-fpga-spi-passive",
> +		.of_match_table = of_match_ptr(efnx_spi_of_match),

Is it OK remove CONFIG_OF & of_match_ptr()?

Thanks,
Yilun

> +	},
> +	.probe = efinix_spi_probe,
> +	.id_table = efinix_ids,
> +};
> +
> +module_spi_driver(efinix_spi_passive_driver);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Ian Dannapel <iansdannapel@gmail.com>");
> +MODULE_DESCRIPTION("Load Efinix FPGA firmware over SPI passive");
> -- 
> 2.34.1
> 
> 

