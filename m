Return-Path: <linux-fpga+bounces-1115-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FFA2A63627
	for <lists+linux-fpga@lfdr.de>; Sun, 16 Mar 2025 16:06:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD0CE16C3C4
	for <lists+linux-fpga@lfdr.de>; Sun, 16 Mar 2025 15:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52B781A83F5;
	Sun, 16 Mar 2025 15:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gPklbRLh"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B82A7EED6;
	Sun, 16 Mar 2025 15:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742137564; cv=none; b=fQ8XL6B3V506aRKtvpfLZhv5c82rd0gXcBwwXSHgoy0ygmHcDtekKGoHCTKXJNUgufDRj04MJ9VL+DrTFwvf8ArwoK/nEiDZiQB2MODKsdJOu4N8BYP7al3r0STfIp7FJAICbzYa9SZEZS+zyGjFavd8MzjG8qTOYV6ElgIYVKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742137564; c=relaxed/simple;
	bh=5WZkh1y0CnzwZX2cfcpuXX/dy7rVTjvXzb6FwMOiUNA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WvqNtu4EJ4l8k/jjYnjQMnM8mwfZm8/pjjvBYXeahm5fzVYeLwQpvDc3W+7RWwIyJxokC1y5+B5ROjx1F6IjuL/+PaeadRxomygcXz+BpsJ747+1tmhlS8eUVmj4NVMzv3HfQEDZetHnr0Y1wgR7vcUtm2ydteAF1xZgwKfnhPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gPklbRLh; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742137562; x=1773673562;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5WZkh1y0CnzwZX2cfcpuXX/dy7rVTjvXzb6FwMOiUNA=;
  b=gPklbRLhBWEeYd2AoTbEC0K/fEM0F5I3bsqTXUTfs47GjLEEksSnjDck
   GCxvHteU1xDsvCW5OjJiukkBYOcDcrnFhbjhpIVqddMd/4/aCIQXOblDQ
   2HhDY1rKEejR26Iso8hHuAA+XlONEJxAjNFESf/YMNAZDCtX8lfwKjJ+a
   1vzPWu8QWwCjQEsGFJ970zHhVZVRc9V0WtRJEZD5IQwfi1SNAKfQS9ChT
   GyurmAWpBrocJyvnLc6FnS2w3wp+O/sv95Vlhd+uni8CAHYjqqoIZlO7l
   v++Al26+Dke71rKKWNpTuWHyzADqeSjKbXzgq6vD2ZhpgGTHgwXjAemDX
   w==;
X-CSE-ConnectionGUID: e/uoEQNlSN+yl6wkjA3gWQ==
X-CSE-MsgGUID: xbAE7fsvRn6bzmewcKakHg==
X-IronPort-AV: E=McAfee;i="6700,10204,11375"; a="43266389"
X-IronPort-AV: E=Sophos;i="6.14,252,1736841600"; 
   d="scan'208";a="43266389"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2025 08:06:01 -0700
X-CSE-ConnectionGUID: IfM1vACrReun9fXTGEBPgA==
X-CSE-MsgGUID: KPkzNhuLTaWxTEc2D5A5WQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,252,1736841600"; 
   d="scan'208";a="122674572"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa008.jf.intel.com with ESMTP; 16 Mar 2025 08:05:57 -0700
Date: Sun, 16 Mar 2025 23:03:14 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: iansdannapel@gmail.com
Cc: linux-fpga@vger.kernel.org, Moritz Fischer <mdf@kernel.org>,
	Wu Hao <hao.wu@intel.com>, Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	=?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
	Aradhya Bhatia <a-bhatia1@ti.com>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [v4 3/3] fpga-mgr: Add Efinix SPI programming driver
Message-ID: <Z9boMlOyKbP2xArA@yilunxu-OptiPlex-7050>
References: <20250228094732.54642-1-iansdannapel@gmail.com>
 <20250228094732.54642-4-iansdannapel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250228094732.54642-4-iansdannapel@gmail.com>

On Fri, Feb 28, 2025 at 10:47:32AM +0100, iansdannapel@gmail.com wrote:
> From: Ian Dannapel <iansdannapel@gmail.com>
> 
> Add a new driver for loading binary firmware to configuration
> RAM using "SPI passive mode" on Efinix FPGAs.
> 
> Signed-off-by: Ian Dannapel <iansdannapel@gmail.com>
> ---
>  drivers/fpga/Kconfig      |   7 ++
>  drivers/fpga/Makefile     |   1 +
>  drivers/fpga/efinix-spi.c | 212 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 220 insertions(+)
>  create mode 100644 drivers/fpga/efinix-spi.c
> 
> diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
> index 37b35f58f0df..b5d60ba62900 100644
> --- a/drivers/fpga/Kconfig
> +++ b/drivers/fpga/Kconfig
> @@ -83,6 +83,13 @@ config FPGA_MGR_XILINX_SPI
>  	  FPGA manager driver support for Xilinx FPGA configuration
>  	  over slave serial interface.
>  
> +config FPGA_MGR_EFINIX_SPI
> +	tristate "Efinix FPGA configuration over SPI"
> +	depends on SPI
> +	help
> +	  FPGA manager driver support for Efinix FPGAs configuration over SPI
> +	  (passive mode only).
> +
>  config FPGA_MGR_ICE40_SPI
>  	tristate "Lattice iCE40 SPI"
>  	depends on OF && SPI
> diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
> index aeb89bb13517..adbd51d2cd1e 100644
> --- a/drivers/fpga/Makefile
> +++ b/drivers/fpga/Makefile
> @@ -18,6 +18,7 @@ obj-$(CONFIG_FPGA_MGR_TS73XX)		+= ts73xx-fpga.o
>  obj-$(CONFIG_FPGA_MGR_XILINX_CORE)	+= xilinx-core.o
>  obj-$(CONFIG_FPGA_MGR_XILINX_SELECTMAP)	+= xilinx-selectmap.o
>  obj-$(CONFIG_FPGA_MGR_XILINX_SPI)	+= xilinx-spi.o
> +obj-$(CONFIG_FPGA_MGR_EFINIX_SPI)	+= efinix-spi.o
>  obj-$(CONFIG_FPGA_MGR_ZYNQ_FPGA)	+= zynq-fpga.o
>  obj-$(CONFIG_FPGA_MGR_ZYNQMP_FPGA)	+= zynqmp-fpga.o
>  obj-$(CONFIG_FPGA_MGR_VERSAL_FPGA)	+= versal-fpga.o
> diff --git a/drivers/fpga/efinix-spi.c b/drivers/fpga/efinix-spi.c
> new file mode 100644
> index 000000000000..07885110a8a8
> --- /dev/null
> +++ b/drivers/fpga/efinix-spi.c
> @@ -0,0 +1,212 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * FPGA Manager Driver for Efinix
> + *
> + * Copyright (C) 2025 iris-GmbH infrared & intelligent sensors
> + *
> + * Ian Dannapel <iansdannapel@gmail.com>
> + *
> + * Load Efinix FPGA firmware over SPI using the serial configuration interface.
> + *
> + * Note 1: Only passive mode (host initiates transfer) is currently supported.
> + * Note 2: Topaz and Titanium support is based on documentation but remains
> + * untested.
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/fpga/fpga-mgr.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/spi/spi.h>
> +
> +struct efinix_spi_conf {
> +	struct spi_device *spi;
> +	struct gpio_desc *cdone;
> +	struct gpio_desc *reset;
> +};
> +
> +static void efinix_spi_reset(struct efinix_spi_conf *conf)
> +{
> +	gpiod_set_value(conf->reset, 1);
> +	/* tCRESET_N > 320 ns */
> +	usleep_range(1, 2);
> +	gpiod_set_value(conf->reset, 0);
> +
> +	/* tDMIN > 32 us */
> +	usleep_range(35, 40);
> +}
> +
> +static enum fpga_mgr_states efinix_spi_state(struct fpga_manager *mgr)
> +{
> +	struct efinix_spi_conf *conf = mgr->priv;
> +
> +	if (conf->cdone && gpiod_get_value(conf->cdone) == 1)
> +		return FPGA_MGR_STATE_OPERATING;
> +
> +	return FPGA_MGR_STATE_UNKNOWN;
> +}
> +
> +static int efinix_spi_write_init(struct fpga_manager *mgr,
> +				 struct fpga_image_info *info,
> +				 const char *buf, size_t count)
> +{
> +	if (info->flags & FPGA_MGR_PARTIAL_RECONFIG) {
> +		dev_err(&mgr->dev, "Partial reconfiguration not supported\n");
> +		return -EOPNOTSUPP;
> +	}
> +	return 0;
> +}
> +
> +static int efinix_spi_write(struct fpga_manager *mgr, const char *buf,
> +			    size_t count)
> +{
> +	struct efinix_spi_conf *conf = mgr->priv;
> +	int ret;
> +	struct spi_message message;
> +	struct spi_transfer assert_cs = {
> +		.cs_change = 1
> +	};
> +	struct spi_transfer write_xfer = {
> +		.tx_buf = buf,
> +		.len = count
> +	};
> +	struct spi_transfer clk_cycles = {
> +		.len = 13,  // > 100 clock cycles

Please define a meaning for Macro name for this.

> +		.tx_buf = NULL
> +	};
> +	u8 *dummy_buf;
> +
> +	dummy_buf = kzalloc(13, GFP_KERNEL);

and here.

> +	if (!dummy_buf) {
> +		ret = -ENOMEM;
> +		goto fail;
> +	}
> +
> +	spi_bus_lock(conf->spi->controller);
> +	spi_message_init(&message);
> +	spi_message_add_tail(&assert_cs, &message);

Is it better use spi_message_init_with_transfers()?

> +	ret = spi_sync_locked(conf->spi, &message);
> +	if (ret)
> +		goto fail_unlock;
> +
> +	/* reset with asserted cs */
> +	efinix_spi_reset(conf);

Recall we've discussed the write() operation may be called multiple
times, each writes a part of the image data. So with this
implementation, the cs & reset may be toggled several times during the
whole reprogramming, is it? Could the fpga be correctly reprogramed?
I remember you said no.

> +
> +	spi_message_init(&message);
> +	spi_message_add_tail(&write_xfer, &message);
> +
> +	clk_cycles.tx_buf = dummy_buf;
> +	spi_message_add_tail(&clk_cycles, &message);

use spi_message_init_with_transfers when possible.

Thanks,
Yilun

> +
> +	ret = spi_sync_locked(conf->spi, &message);
> +	if (ret)
> +		dev_err(&mgr->dev, "SPI error in firmware write: %d\n", ret);
> +
> +fail_unlock:
> +	spi_bus_unlock(conf->spi->controller);
> +	kfree(dummy_buf);
> +fail:
> +	return ret;
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
> +			done = gpiod_get_value(conf->cdone);
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
> +	/* tUSER > 25 us */
> +	usleep_range(30, 35);
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
> +	conf->reset = devm_gpiod_get(&spi->dev, "reset", GPIOD_OUT_HIGH);
> +	if (IS_ERR(conf->reset))
> +		return dev_err_probe(&spi->dev, PTR_ERR(conf->reset),
> +				     "Failed to get RESET gpio\n");
> +
> +	if (!(spi->mode & SPI_CPHA) || !(spi->mode & SPI_CPOL))
> +		return dev_err_probe(&spi->dev, -EINVAL,
> +				     "Unsupported SPI mode, set CPHA and CPOL\n");
> +
> +	conf->cdone = devm_gpiod_get_optional(&spi->dev, "cdone", GPIOD_IN);
> +	if (IS_ERR(conf->cdone))
> +		return dev_err_probe(&spi->dev, PTR_ERR(conf->cdone),
> +				     "Failed to get CDONE gpio\n");
> +
> +	mgr = devm_fpga_mgr_register(&spi->dev,
> +				     "Efinix FPGA Manager",
> +				     &efinix_spi_ops, conf);
> +
> +	return PTR_ERR_OR_ZERO(mgr);
> +}
> +
> +static const struct of_device_id efinix_spi_of_match[] = {
> +	{ .compatible = "efinix,trion-spi", },
> +	{ .compatible = "efinix,titanium-spi", },
> +	{ .compatible = "efinix,topaz-spi", },
> +	{ .compatible = "efinix,fpga-spi", },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, efinix_spi_of_match);
> +
> +static const struct spi_device_id efinix_ids[] = {
> +	{ "trion-spi", 0 },
> +	{ "titanium-spi", 0 },
> +	{ "topaz-spi", 0 },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(spi, efinix_ids);
> +
> +static struct spi_driver efinix_spi_driver = {
> +	.driver = {
> +		.name = "efinix-spi",
> +		.of_match_table = efinix_spi_of_match,
> +	},
> +	.probe = efinix_spi_probe,
> +	.id_table = efinix_ids,
> +};
> +
> +module_spi_driver(efinix_spi_driver);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Ian Dannapel <iansdannapel@gmail.com>");
> +MODULE_DESCRIPTION("Efinix FPGA SPI Programming Driver (Topaz/Titanium untested)");
> -- 
> 2.43.0
> 
> 

