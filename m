Return-Path: <linux-fpga+bounces-741-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75E2C988705
	for <lists+linux-fpga@lfdr.de>; Fri, 27 Sep 2024 16:23:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D921281E5A
	for <lists+linux-fpga@lfdr.de>; Fri, 27 Sep 2024 14:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 800FE80034;
	Fri, 27 Sep 2024 14:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ei/JQSng"
X-Original-To: linux-fpga@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5596D13A3EC;
	Fri, 27 Sep 2024 14:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727446978; cv=none; b=moPODdqWyP77bjjXfUGN+s1jqvmhh1C3ZuosmccYZHSZ7vmwSSx43mSdOS8eQAI1FyHq7s7zqb5QJjQWUwo1778sInU/pepkx6RXAdOaaNEz4TJrNc+spKs84f+ZNr0MA3GTYDtApwTW3sgaWuq95TdymV4x1v7U1t+S4gD3VLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727446978; c=relaxed/simple;
	bh=M/39kum3E/trMY3xAOIUM0UlUX5wD8I/F08ihv1OY8o=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=AENFEceKfSmDa+M32q8TQQexi9O2Rc6tCTD7RSx1+7kJ4z+HPWHRMTNqtaUd6Nb5gCQIKZjwGpkQA1+I872QEw0ntHGcbJP4ON4AqqzJFovp9KCU/ec1ds2m8Vht8IjoSgpB7BwVEigWHnrrETjfJayOC0AkpLr8DUsENzVNrW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ei/JQSng; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E67AC4CEC4;
	Fri, 27 Sep 2024 14:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727446978;
	bh=M/39kum3E/trMY3xAOIUM0UlUX5wD8I/F08ihv1OY8o=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=Ei/JQSng7c7VVc/nMPDGk0U5AlyaozxtuSqfALu/DcWS8m3i6LuIy77RqvamJh0ra
	 b8C7ErIdsDAs/h0avrFXuEp9OWXJ2j3Fd75y/Mgtj/pUCsnOKEO3xbng6TQpBLbIMe
	 s70+ZXb81TJ4Zw09wuIYML4M4n3U6fzvSXhXInTdqfxPOBCC6UpEFSJmOpoS01pmA/
	 7D3qYh4vi3k+t5QenbHB4sv9lE4IzPB8fV97EcB7b/dnK5wnLICdwzMAEOjsfs6aSA
	 r2oFjEcat9xrJUjF/mJQRkTwr0BRNW+uyQDdwdpZFibffKhXHoz1uu78CKX4GyQi0V
	 z5IC0pBcxrfCA==
Message-ID: <c292b99c-3d51-461e-aadb-cd21ed972db0@kernel.org>
Date: Fri, 27 Sep 2024 16:22:50 +0200
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] fpga: Add Efinix Trion & Titanium serial SPI
 programming driver
To: iansdannapel@gmail.com, mdf@kernel.org, hao.wu@intel.com,
 yilun.xu@intel.com, trix@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, neil.armstrong@linaro.org, heiko.stuebner@cherry.de,
 rafal@milecki.pl, linus.walleij@linaro.org, linux-fpga@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240927141445.157234-1-iansdannapel@gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20240927141445.157234-1-iansdannapel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 27/09/2024 16:14, iansdannapel@gmail.com wrote:
> From: Ian Dannapel <iansdannapel@gmail.com>
> 
> Add a new driver for loading binary firmware to volatile
> configuration RAM using "SPI passive programming" on Efinix FPGAs.
> 
> Signed-off-by: Ian Dannapel <iansdannapel@gmail.com>

Thank you for your patch. There is something to discuss/improve.

> ---
>  drivers/fpga/Kconfig                    |  10 ++
>  drivers/fpga/Makefile                   |   1 +
>  drivers/fpga/efinix-trion-spi-passive.c | 211 ++++++++++++++++++++++++
>  3 files changed, 222 insertions(+)
>  create mode 100644 drivers/fpga/efinix-trion-spi-passive.c
> 
> diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
> index 37b35f58f0df..eb1e44c4e3e0 100644
> --- a/drivers/fpga/Kconfig
> +++ b/drivers/fpga/Kconfig
> @@ -83,6 +83,16 @@ config FPGA_MGR_XILINX_SPI
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
> +	  Warning: Do not activate this if there are other SPI devices
> +	  on the same bus as it might interfere with the transmission.
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
> index 000000000000..87ff645265ca
> --- /dev/null
> +++ b/drivers/fpga/efinix-trion-spi-passive.c
> @@ -0,0 +1,211 @@
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
> +static int efinix_spi_get_cdone_gpio(struct efinix_spi_conf *conf)
> +{
> +	int ret;
> +
> +	ret = gpiod_get_value(conf->cdone);

This should be just return gpiod_get_value()... but then it's quite
simple wrapper, so just use it directly.

> +	return ret;
> +}
> +
> +static void efinix_spi_reset(struct efinix_spi_conf *conf)
> +{
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
> +	if (conf->cdone && efinix_spi_get_cdone_gpio(conf) == 1)
> +		return FPGA_MGR_STATE_OPERATING;
> +
> +	return FPGA_MGR_STATE_UNKNOWN;
> +}
> +
> +static int efinix_spi_apply_clk_cycles(struct efinix_spi_conf *conf)
> +{
> +	char data[13] = {0};
> +
> +	return spi_write(conf->spi, data, sizeof(data));

Hm, aren't buffers from stack discouraged? spi-summary explicitly
mentions this case or I am getting this wrong?

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
> +	usleep_range(5, 15);
> +	efinix_spi_reset(conf);
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
> +	/* append at least 100 clock cycles */
> +	efinix_spi_apply_clk_cycles(conf);
> +
> +	/* release chip select */
> +	gpiod_set_value(conf->cs, 0);
> +
> +	if (conf->cdone) {
> +		while (!expired) {
> +			expired = time_after(jiffies, timeout);
> +
> +			done = efinix_spi_get_cdone_gpio(conf);
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
> +		return dev_err_probe(&spi->dev, -EINVAL,
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

Drop

> +static const struct of_device_id efinix_spi_of_match[] = {
> +	{ .compatible = "efinix,trion-spi-passive", },
> +	{ .compatible = "efinix,titanium-spi-passive", },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, efinix_spi_of_match);
> +#endif
> +
> +static const struct spi_device_id efinix_ids[] = {
> +	{ "trion-spi-passive", 0 },
> +	{ "titanium-spi-passive", 0 },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(spi, efinix_ids);
> +
> +static struct spi_driver efinix_spi_passive_driver = {
> +	.driver = {
> +		.name = "efinix-fpga-spi-passive",
> +		.of_match_table = of_match_ptr(efinix_spi_of_match),

Drop of_match_ptr


Best regards,
Krzysztof


