Return-Path: <linux-fpga+bounces-554-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16921911088
	for <lists+linux-fpga@lfdr.de>; Thu, 20 Jun 2024 20:15:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C182F2862BB
	for <lists+linux-fpga@lfdr.de>; Thu, 20 Jun 2024 18:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E84E41BA060;
	Thu, 20 Jun 2024 18:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CDd72eAN"
X-Original-To: linux-fpga@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 826601B47AF
	for <linux-fpga@vger.kernel.org>; Thu, 20 Jun 2024 18:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718906732; cv=none; b=TkDFsT3cTreqkKLIFwkCX8cG5wQcVtnglpfR5cJBbLTTGoeiIF/YEl+bqoiiZUUF1GyVLIgm8tC596rPyUKI8vOg29qUAmut7i+3sEm3TowDK9U49IwA7R9cuZpSiNJSY3frSN6PVQF/DYpHxUABFXfvZs6eUk1HGUBp5Kahs9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718906732; c=relaxed/simple;
	bh=Yile4sr8mC3zshy1Dc3rfeZmdcX39e3EdVE13QRC3Ak=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=Tns992Vqwl6jMpvvyyaBfzCLDiKb1qONTTdBIhoFs0yTx0zGTzCuMhUewAXHaI8CjNE7Ln4pkg7WAaMHOJv4U6eBGAX529m+4sfzZnYGqExLdY43jE7Ynzp4doXzk+xNnxFTv7Sp1K9GB6Co5AbvAgRXtWXJelpjfft35X53Xpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CDd72eAN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718906728;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EluoeVyiNvPdZ4+QR9jpe9q8NyD9J0G0PNghGozSf84=;
	b=CDd72eAN6w9s0ekFmOusuiYjqsW11gG6I4EdqSADU24sGr2+ECvWcxWWKZfpTi25PDsN6p
	PdlfMC7Hz9qXATEV9rYQnyDc195WvvHhc6xv4m6kt2PfNk58DO4uW8rwcPZk4+h3f9xL9J
	w+01XNit7c0Ezn3tVoKarNTrtFAfsBw=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-369-TYDzp0uHP0qj7tFBMBbZuQ-1; Thu, 20 Jun 2024 14:05:27 -0400
X-MC-Unique: TYDzp0uHP0qj7tFBMBbZuQ-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4404a08e4d0so22343421cf.1
        for <linux-fpga@vger.kernel.org>; Thu, 20 Jun 2024 11:05:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718906726; x=1719511526;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EluoeVyiNvPdZ4+QR9jpe9q8NyD9J0G0PNghGozSf84=;
        b=Z09brit9yZ0kdP4RiXIaygBfRwK/AvUwU517kMuWsdPGr/L7Sc0Qfv0eFi0znQlvlE
         7ZxA3xYRSMdf/9AkgN7/Whum1Toh+VZ36B6kmVgGPsgsucdiv6PgzYWEJjFFV66R38Zo
         rd01baAy0JXyA4HnGMgIkLN+1wxcL6GCqkrBGi/EVn2FmBy2/2gwaX6TW/tHhhDX33GU
         WbhL3Po0ehAtPI4NvCnENeKCXxKRL56zYycRBlBB/aKWNJ70mx8jFgFe7wnYBoOCRNHM
         Yhb3KKP5r2bM7cPKWlH8P/s8UsdZTvT/Hkfd96olIsu/ywN+CtrjFF3qOnTtNADKT2tm
         IM5g==
X-Forwarded-Encrypted: i=1; AJvYcCXit8IWrQ3z3DdXwLBOtgd+W+aqoxhIi/SjOVMJ1DLxU0EPLmvTsMymifrnZxmYlmxaQyBfToMVlYf20IdUkwhdyCKLZOadkMpEFg==
X-Gm-Message-State: AOJu0YyiL83N13tydcyJwNtUnBDhqEw5AG/rrhcZt8emx4d9kHRqMqEO
	Uey9vqjsavsdXrDOWhAK7tYYAtR5z3xxcC4mmQSYzqSt2plOcWV+dU3YnST+jAqzGaqKyQ3Ohv1
	K3kxjtqfgm8zD2Shjpns6rf/id6E+F4gEr5/NwRNLv3Mut89sZUNJRHRBBw==
X-Received: by 2002:ac8:574c:0:b0:440:d294:3b4a with SMTP id d75a77b69052e-444a78ca7a0mr107004491cf.22.1718906726575;
        Thu, 20 Jun 2024 11:05:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IERe2rL98vuIWhtn9e3Yw6aKuQ/xARuUaP4lQ1wxR6mOjtjAWxyuo+QlQXUZWkeFTCRVnYwyg==
X-Received: by 2002:ac8:574c:0:b0:440:d294:3b4a with SMTP id d75a77b69052e-444a78ca7a0mr107004111cf.22.1718906726206;
        Thu, 20 Jun 2024 11:05:26 -0700 (PDT)
Received: from [192.168.1.100] (host-82-62-247-97.business.telecomitalia.it. [82.62.247.97])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-441f2fcc297sm76321831cf.63.2024.06.20.11.05.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jun 2024 11:05:25 -0700 (PDT)
Message-ID: <8257d6b1-5c15-4e3c-93a7-71ab5d6cb19b@redhat.com>
Date: Thu, 20 Jun 2024 20:05:22 +0200
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] fpga: Add Efinix Trion & Titanium serial SPI
 programming driver
To: iansdannapel@gmail.com
References: <20240620144217.124733-1-iansdannapel@gmail.com>
Content-Language: en-US
Cc: mdf@kernel.org, hao.wu@intel.com, yilun.xu@intel.com, trix@redhat.com,
 linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org
From: Marco Pagani <marpagan@redhat.com>
In-Reply-To: <20240620144217.124733-1-iansdannapel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024-06-20 16:42, iansdannapel@gmail.com wrote:
> From: Ian Dannapel <iansdannapel@gmail.com>
> 
> Add a new driver for loading binary firmware using "SPI passive
> programming" on Efinix FPGAs.
> 
> Signed-off-by: Ian Dannapel <iansdannapel@gmail.com>
> ---
>  drivers/fpga/Kconfig      |   8 ++
>  drivers/fpga/Makefile     |   1 +
>  drivers/fpga/efinix-spi.c | 219 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 228 insertions(+)
>  create mode 100644 drivers/fpga/efinix-spi.c
> 
> diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
> index 37b35f58f0df..cb3a6628fa71 100644
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
> +	  This option enables support for the FPGA manager driver to configure
> +	  Efinix Trion and Titanium Series FPGAs over SPI using passive serial
> +	  mode.
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
> index 000000000000..7f7d7e6714ae
> --- /dev/null
> +++ b/drivers/fpga/efinix-spi.c
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
> +	struct gpio_desc *done;
> +	struct gpio_desc *reset;
> +	struct gpio_desc *cs;
> +	enum fpga_mgr_states state;

This is a bit confusing. I wouldn't use an fpga_mgr_states enum in the
context struct of the low-level module since they define the state of
the fpga manager core. If possible, I would have read the physical
state of the device in the state op to determine if the fpga is
already programmed or in an unknown or error state, since the op is
called only during device registration to set the initial state.

Also, a quick check with checkpatch.pl returned a couple of style
issues.

> +};
> +
> +static int get_done_gpio(struct fpga_manager *mgr)
> +{
> +	struct efinix_spi_conf *conf = mgr->priv;
> +	int ret = 0;
> +
> +	if (conf->done) {
> +		ret = gpiod_get_value(conf->done);
> +		if (ret < 0)
> +			dev_err(&mgr->dev, "Error reading DONE (%d)\n", ret);
> +	}
> +
> +	return ret;
> +}
> +
> +static void reset(struct fpga_manager *mgr)
> +{
> +	struct efinix_spi_conf *conf = mgr->priv;
> +
> +	gpiod_set_value(conf->reset, 1);
> +	/* wait tCRESET_N */
> +	usleep_range(5, 15);
> +	gpiod_set_value(conf->reset, 0);
> +	conf->state = FPGA_MGR_STATE_RESET;
> +}
> +
> +static enum fpga_mgr_states efinix_spi_state(struct fpga_manager *mgr)
> +{
> +	struct efinix_spi_conf *conf = mgr->priv;
> +
> +	return conf->state;
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
> +	if (conf->done) {
> +		while (!expired) {
> +			expired = time_after(jiffies, timeout);
> +
> +			done = get_done_gpio(mgr);
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
> +	conf->state = FPGA_MGR_STATE_UNKNOWN;
> +
> +	conf->reset = devm_gpiod_get(&spi->dev, "reset", GPIOD_OUT_HIGH);
> +	if (IS_ERR(conf->reset))
> +		return dev_err_probe(&spi->dev, PTR_ERR(conf->reset),
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
> +	conf->done = devm_gpiod_get_optional(&spi->dev, "done", GPIOD_IN);

I'm not familiar with this FPGA, but from the code, it seems to me that
you also want to support the case where a "done" line is not available.
In such a case, what happens if you start a new programming cycle before
waiting for the previous one to complete? Also, checking if (conf->done)
in get_done_gpio() seems to be redundant since the function is called only
in efinix_spi_write_complete() after checking if (conf->done).


> +	if (IS_ERR(conf->done))
> +		return dev_err_probe(&spi->dev, PTR_ERR(conf->done),
> +				"Failed to get DONE gpio\n");
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
> +	{ .compatible = "efnx,fpga-spi-passive", },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, efnx_spi_of_match);
> +#endif
> +
> +static const struct spi_device_id efinix_ids[] = {
> +	{ "fpga-spi-passive", 0 },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(spi, efinix_ids);
> +
> +
> +static struct spi_driver efinix_spi_passive_driver = {
> +	.driver = {
> +		.name = "efnx-fpga-spi-passive",
> +		.of_match_table = of_match_ptr(efnx_spi_of_match),
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

Thanks,
Marco


