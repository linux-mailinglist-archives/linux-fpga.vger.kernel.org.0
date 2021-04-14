Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D957335F7A9
	for <lists+linux-fpga@lfdr.de>; Wed, 14 Apr 2021 17:29:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352308AbhDNP3h (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 14 Apr 2021 11:29:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50798 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1352305AbhDNP3g (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 14 Apr 2021 11:29:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618414154;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MeWK7S4FSJDFGhFSe6NzT/9bbUJoX8iagCcLa/pL95g=;
        b=MYMzPUNHJLXsfEhquSFaJc3FrOkbcAIeplHZl4w7ctCUqzhQUo9RMpeqGrEQN/Ryx9MRJk
        RbaR+Sv87pU5Bdi8V5QwAdPQNJxOpUAgceC+m/6aDQzJJBSn7bLrMmIT753AOnUkPT+cOd
        cKW/SBisQ49M2qHqIJYC63K/A9qORe8=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-23-hGYIkTThMD-86ieSTN1PxQ-1; Wed, 14 Apr 2021 11:29:13 -0400
X-MC-Unique: hGYIkTThMD-86ieSTN1PxQ-1
Received: by mail-qv1-f71.google.com with SMTP id g2so468222qvy.4
        for <linux-fpga@vger.kernel.org>; Wed, 14 Apr 2021 08:29:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=MeWK7S4FSJDFGhFSe6NzT/9bbUJoX8iagCcLa/pL95g=;
        b=LEX06jLJkqWwmIaV8GPmHr3FHCNAF+W6OBbCckXN8JN6E1H7m0hdi6OjIlM/WkqBeK
         9fNTFAbiJH5xQ7cWfuxG/dlxbitev8Xd1l7hDHUP+L0fg/eoUdYGi8yPm2O/+JcHOPBE
         FlcFcD3gfYbYOte2TAKlagwyN3c7sXj1GRSttdB0n6V03ziiXnMtKgXUu3W/pJViI6zt
         fADHv4gAFwF/re4Kb7j8LD+jNhGfVXuoT6GpbYEkQDEW43fJibJtVG9Cds4chMb51ozM
         hIhfxFtW/E+M/D2PrvQ9uC8eTYTWsqWk7586ay/bagPINTLTVdyhJ7TZbbe+zHzHcd1t
         H/lw==
X-Gm-Message-State: AOAM530t5hmnep6JL0t6FlpSfVLZwdR5PbyBnQvK6KFh6GII+yreka8+
        USbIELA08mRWvJC3XsVGukiydmS4R7UjKVK5+3TLKZtSfmHBLkgDR0I3quV7OPrumktPX8PlorE
        GUpQ6XnbnXPmeDIfn9TLIqA==
X-Received: by 2002:ad4:538a:: with SMTP id i10mr38685661qvv.9.1618414151562;
        Wed, 14 Apr 2021 08:29:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxP2zEotmr81rgi5/eyGgnxNajj/C8MBL7fJk7ZrR0lMMWOY1AqoZeH+UyFVOPVQsjAXEsbSw==
X-Received: by 2002:ad4:538a:: with SMTP id i10mr38685635qvv.9.1618414151269;
        Wed, 14 Apr 2021 08:29:11 -0700 (PDT)
Received: from localhost.localdomain (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id a10sm12492404qkh.122.2021.04.14.08.29.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Apr 2021 08:29:11 -0700 (PDT)
Subject: Re: [PATCH v2 1/2] spi: Add DFL bus driver for Altera SPI Master
To:     matthew.gerlach@linux.intel.com, hao.wu@intel.com, mdf@kernel.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        yilun.xu@intel.com, jdelvare@suse.com, linux@roeck-us.net,
        lee.jones@linaro.org, linux-hwmon@vger.kernel.org,
        russell.h.weight@intel.com, broonie@kernel.org,
        linux-spi@vger.kernel.org
References: <20210413225835.459662-1-matthew.gerlach@linux.intel.com>
 <20210413225835.459662-2-matthew.gerlach@linux.intel.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <559fdf6a-d019-6353-071e-f973ddc906a7@redhat.com>
Date:   Wed, 14 Apr 2021 08:29:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210413225835.459662-2-matthew.gerlach@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 4/13/21 3:58 PM, matthew.gerlach@linux.intel.com wrote:
> From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>
> This patch adds a Device Feature List (DFL) bus driver for the
> Altera SPI Master controller.  The SPI master is connected to an
> Intel SPI Slave to Avalon Master Bridge inside an Intel MAX10
> BMC Chip.
>
> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> ---
> v2: moved drivers/fpga/dfl-spi-altera.c to drivers/spi/spi-altera-dfl.c
> ---
>   drivers/spi/Kconfig          |   9 ++
>   drivers/spi/Makefile         |   1 +
>   drivers/spi/spi-altera-dfl.c | 222 +++++++++++++++++++++++++++++++++++++++++++
does this need a MAINTAINER's entry ?
>   3 files changed, 232 insertions(+)
>   create mode 100644 drivers/spi/spi-altera-dfl.c
>
> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
> index 853cf4c..6c6798e 100644
> --- a/drivers/spi/Kconfig
> +++ b/drivers/spi/Kconfig
> @@ -63,6 +63,15 @@ config SPI_ALTERA
>   	help
>   	  This is the driver for the Altera SPI Controller.
>   
> +config SPI_ALTERA_DFL
> +	tristate "DFL driver for Altera SPI Controller"
> +	depends on FPGA_DFL
> +	select SPI_ALTERA
> +	help
> +	  This is a Device Feature List (DFL) bus driver for the
> +	  Altera SPI master controller.  The SPI master is connected
> +	  to a SPI slave to Avalon Master bridge in a Intel MAX BMC.

Last sentence is a little confusing with two 'masters', could this be

The SPI master is connected to the Avalon SPI bridge in the Intel Max10 BMC.

?

> +
>   config SPI_AR934X
>   	tristate "Qualcomm Atheros AR934X/QCA95XX SPI controller driver"
>   	depends on ATH79 || COMPILE_TEST
> diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
> index 29fee71..2e348ea 100644
> --- a/drivers/spi/Makefile
> +++ b/drivers/spi/Makefile
> @@ -15,6 +15,7 @@ obj-$(CONFIG_SPI_LOOPBACK_TEST)		+= spi-loopback-test.o
>   
>   # SPI master controller drivers (bus)
>   obj-$(CONFIG_SPI_ALTERA)		+= spi-altera.o
> +obj-$(CONFIG_SPI_ALTERA_DFL)		+= spi-altera-dfl.o
>   obj-$(CONFIG_SPI_AR934X)		+= spi-ar934x.o
>   obj-$(CONFIG_SPI_ARMADA_3700)		+= spi-armada-3700.o
>   obj-$(CONFIG_SPI_ATMEL)			+= spi-atmel.o
> diff --git a/drivers/spi/spi-altera-dfl.c b/drivers/spi/spi-altera-dfl.c
> new file mode 100644
> index 0000000..8ddfc5d
> --- /dev/null
> +++ b/drivers/spi/spi-altera-dfl.c
> @@ -0,0 +1,222 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * DFL bus driver for Altera SPI Master
> + *
> + * Copyright (C) 2020 Intel Corporation, Inc.
> + *
> + * Authors:
> + *   Matthew Gerlach <matthew.gerlach@linux.intel.com>
> + */
> +
> +#include <linux/types.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/stddef.h>
> +#include <linux/errno.h>
> +#include <linux/platform_device.h>
> +#include <linux/io.h>
> +#include <linux/bitfield.h>
> +#include <linux/io-64-nonatomic-lo-hi.h>
> +#include <linux/regmap.h>
> +#include <linux/spi/spi.h>
> +#include <linux/spi/altera.h>
> +#include <linux/dfl.h>
> +
> +struct dfl_altera_spi {
> +	void __iomem *base;
> +	struct regmap *regmap;
> +	struct device *dev;
> +	struct platform_device *altr_spi;
the read/write can take a while, is a lock needed ?
> +};
> +
> +#define SPI_CORE_PARAMETER      0x8
a prefix would like 'DFL_' would make this less likely to have namespace 
issues.
> +#define SHIFT_MODE              BIT_ULL(1)
> +#define SHIFT_MODE_MSB          0
> +#define SHIFT_MODE_LSB          1
> +#define DATA_WIDTH              GENMASK_ULL(7, 2)
> +#define NUM_CHIPSELECT          GENMASK_ULL(13, 8)
> +#define CLK_POLARITY            BIT_ULL(14)
> +#define CLK_PHASE               BIT_ULL(15)
> +#define PERIPHERAL_ID           GENMASK_ULL(47, 32)
> +#define SPI_CLK                 GENMASK_ULL(31, 22)
> +#define SPI_INDIRECT_ACC_OFST   0x10
> +
> +#define INDIRECT_ADDR           (SPI_INDIRECT_ACC_OFST+0x0)
checkpatch --strict complains here and similar, preferring spaces around 
the '+'
> +#define INDIRECT_WR             BIT_ULL(8)
> +#define INDIRECT_RD             BIT_ULL(9)
> +#define INDIRECT_RD_DATA        (SPI_INDIRECT_ACC_OFST+0x8)
> +#define INDIRECT_DATA_MASK      GENMASK_ULL(31, 0)
> +#define INDIRECT_DEBUG          BIT_ULL(32)
> +#define INDIRECT_WR_DATA        (SPI_INDIRECT_ACC_OFST+0x10)
> +#define INDIRECT_TIMEOUT        10000
this does not have units of time, maybe rename to INDIRECT_RETRY_COUNT
> +
> +static int indirect_bus_reg_read(void *context, unsigned int reg,
> +				 unsigned int *val)
> +{
> +	struct dfl_altera_spi *aspi = context;
> +	void __iomem *base = aspi->base;
> +	int loops;
could initialize loop here
> +	u64 v;
> +
> +	writeq((reg >> 2) | INDIRECT_RD, base + INDIRECT_ADDR);
is input 'reg' checked elsewhere ?
> +
> +	loops = 0;
> +	while ((readq(base + INDIRECT_ADDR) & INDIRECT_RD) &&
> +	       (loops++ < INDIRECT_TIMEOUT))
> +		cpu_relax();
> +
> +	if (loops >= INDIRECT_TIMEOUT) {
> +		pr_err("%s timed out %d\n", __func__, loops);
> +		return -ETIME;
maybe -EBUSY ?
> +	}
> +
> +	v = readq(base + INDIRECT_RD_DATA);
> +
> +	*val = v & INDIRECT_DATA_MASK;
> +
> +	return 0;
> +}
> +
> +static int indirect_bus_reg_write(void *context, unsigned int reg,
> +				  unsigned int val)
> +{
> +	struct dfl_altera_spi *aspi = context;
> +	void __iomem *base = aspi->base;
> +	int loops;
> +
> +	writeq(val, base + INDIRECT_WR_DATA);
> +	writeq((reg >> 2) | INDIRECT_WR, base + INDIRECT_ADDR);
> +
> +	loops = 0;
> +	while ((readq(base + INDIRECT_ADDR) & INDIRECT_WR) &&
> +	       (loops++ < INDIRECT_TIMEOUT))
> +		cpu_relax();
> +
> +	if (loops >= INDIRECT_TIMEOUT) {
> +		pr_err("%s timed out %d\n", __func__, loops);
> +		return -ETIME;
> +	}
> +	return 0;
> +}
> +
> +static const struct regmap_config indirect_regbus_cfg = {
> +	.reg_bits = 32,
> +	.reg_stride = 4,
> +	.val_bits = 32,
> +	.fast_io = true,
> +	.max_register = 24,
> +
> +	.reg_write = indirect_bus_reg_write,
> +	.reg_read = indirect_bus_reg_read,
> +};
> +
> +static struct spi_board_info m10_bmc_info = {
> +	.modalias = "m10-d5005",
> +	.max_speed_hz = 12500000,
> +	.bus_num = 0,
> +	.chip_select = 0,
> +};
> +
> +static struct platform_device *create_cntrl(struct device *dev,
> +					    void __iomem *base,
> +					    struct spi_board_info *m10_info)
> +{
could this function be inlined to probe ?
> +	struct altera_spi_platform_data pdata;
> +	struct platform_device_info pdevinfo;
> +	u64 v;
> +
> +	v = readq(base + SPI_CORE_PARAMETER);
move down two lines to before the if-checks that use it
> +
> +	memset(&pdata, 0, sizeof(pdata));
> +	pdata.mode_bits = SPI_CS_HIGH;
> +	if (FIELD_GET(CLK_POLARITY, v))
> +		pdata.mode_bits |= SPI_CPOL;
> +	if (FIELD_GET(CLK_PHASE, v))
> +		pdata.mode_bits |= SPI_CPHA;
> +
> +	pdata.num_chipselect = FIELD_GET(NUM_CHIPSELECT, v);
> +	pdata.bits_per_word_mask =
> +		SPI_BPW_RANGE_MASK(1, FIELD_GET(DATA_WIDTH, v));
> +
> +	pdata.num_devices = 1;
> +	pdata.devices = m10_info;
> +
> +	dev_dbg(dev, "%s cs %u bpm 0x%x mode 0x%x\n", __func__,
> +		pdata.num_chipselect, pdata.bits_per_word_mask,
> +		pdata.mode_bits);
> +
> +	memset(&pdevinfo, 0, sizeof(pdevinfo));
> +
> +	pdevinfo.name = "subdev_spi_altera";
> +	pdevinfo.id = PLATFORM_DEVID_AUTO;
> +	pdevinfo.parent = dev;
> +	pdevinfo.data = &pdata;
> +	pdevinfo.size_data = sizeof(pdata);
> +
> +	return platform_device_register_full(&pdevinfo);
> +}
> +static int dfl_spi_altera_probe(struct dfl_device *dfl_dev)
> +{
> +	struct device *dev = &dfl_dev->dev;
> +	struct dfl_altera_spi *aspi;
> +
> +	aspi = devm_kzalloc(dev, sizeof(*aspi), GFP_KERNEL);
> +
> +	if (!aspi)
> +		return -ENOMEM;
> +
> +	dev_set_drvdata(dev, aspi);
> +
> +	aspi->dev = dev;
> +
> +	aspi->base = devm_ioremap_resource(dev, &dfl_dev->mmio_res);
> +
> +	if (IS_ERR(aspi->base)) {
> +		dev_err(dev, "%s get mem resource fail!\n", __func__);
> +		return PTR_ERR(aspi->base);
> +	}
> +
> +	aspi->regmap = devm_regmap_init(dev, NULL, aspi, &indirect_regbus_cfg);
> +	if (IS_ERR(aspi->regmap))
> +		return PTR_ERR(aspi->regmap);
> +
> +	aspi->altr_spi = create_cntrl(dev, aspi->base, &m10_bmc_info);

it does not seem like this can fail for device reasons. is there a 
sanity check on the reg values that could be done ?

Tom

> +
> +	if (IS_ERR(aspi->altr_spi)) {
> +		dev_err(dev, "%s failed to create spi platform driver\n",
> +			__func__);
> +		return PTR_ERR(aspi->base);
> +	}
> +
> +	return 0;
> +}
> +
> +static void dfl_spi_altera_remove(struct dfl_device *dfl_dev)
> +{
> +	struct dfl_altera_spi *aspi = dev_get_drvdata(&dfl_dev->dev);
> +
> +	platform_device_unregister(aspi->altr_spi);
> +}
> +
> +#define FME_FEATURE_ID_MAX10_SPI        0xe
> +
> +static const struct dfl_device_id dfl_spi_altera_ids[] = {
> +	{ FME_ID, FME_FEATURE_ID_MAX10_SPI },
> +	{ }
> +};
> +
> +static struct dfl_driver dfl_spi_altera_driver = {
> +	.drv	= {
> +		.name       = "dfl-spi-altera",
> +	},
> +	.id_table = dfl_spi_altera_ids,
> +	.probe   = dfl_spi_altera_probe,
> +	.remove  = dfl_spi_altera_remove,
> +};
> +
> +module_dfl_driver(dfl_spi_altera_driver);
> +
> +MODULE_DEVICE_TABLE(dfl, dfl_spi_altera_ids);
> +MODULE_DESCRIPTION("DFL spi altera driver");
> +MODULE_AUTHOR("Intel Corporation");
> +MODULE_LICENSE("GPL v2");

