Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1A65551562
	for <lists+linux-fpga@lfdr.de>; Mon, 20 Jun 2022 12:08:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232000AbiFTKGs (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 20 Jun 2022 06:06:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239124AbiFTKGm (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 20 Jun 2022 06:06:42 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0421E1030;
        Mon, 20 Jun 2022 03:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655719600; x=1687255600;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3O74OoWkH/A87P21AgivPk4iFTe+cL+7psl//jnUvOE=;
  b=cascRjLrhrHQzQEwKnpc85Ln34E60RNNVLNDVfKWlF8bgWmO+TVkK4mo
   Gwjyn4DPm/Gqj6GM3SSu0g4oPv7/I9D34AshqOv3sKRmyosmjOT1QB+mg
   lu87az65sI/3ZZSnJZq7OmphrZ1XuBLsu+ZYH/sOKAM8WUL2nHllH/S7V
   TK3ebwYA5dUpnflumWxNA7n/Lxie/HnxXOINOTkXKXSQzwFsIvI1J6Zb9
   ZjqHynJWTSr7Zl+/5SUPuEUdUmOmT2CZ/0QxUgBYoH+fyri+bfQZLvKQN
   C3SYonyLm/Dx89YYLMU+AZotU6bXCskXe0vjD0sAk6OHGyVrQZZM4KX4F
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="277404662"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="277404662"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2022 03:06:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="833045031"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmsmga006.fm.intel.com with ESMTP; 20 Jun 2022 03:06:38 -0700
Date:   Mon, 20 Jun 2022 17:58:32 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Tianfei Zhang <tianfei.zhang@intel.com>
Cc:     lee.jones@linaro.org, hao.wu@intel.com, trix@redhat.com,
        linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org,
        russell.h.weight@intel.com, matthew.gerlach@linux.intel.com
Subject: Re: [PATCH v2 2/4] mfd: intel-m10-bmc: split into core and spi
Message-ID: <20220620095832.GB1319418@yilunxu-OptiPlex-7050>
References: <20220617020405.128352-1-tianfei.zhang@intel.com>
 <20220617020405.128352-3-tianfei.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220617020405.128352-3-tianfei.zhang@intel.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Thu, Jun 16, 2022 at 10:04:03PM -0400, Tianfei Zhang wrote:
> Split the common code from intel-m10-bmc driver into intel-m10-bmc-core.
> intel-m10-bmc-core is the core MFD functions which can support multiple
> bus interfaces like SPI bus.

Please specify which else are you going to support, for better
understanding.

> 
> Signed-off-by: Tianfei Zhang <tianfei.zhang@intel.com>
> ---
>  drivers/mfd/Kconfig                           |  30 +++---
>  drivers/mfd/Makefile                          |   5 +-
>  .../{intel-m10-bmc.c => intel-m10-bmc-core.c} | 101 +++++-------------
>  drivers/mfd/intel-m10-bmc-spi.c               |  83 ++++++++++++++
>  include/linux/mfd/intel-m10-bmc.h             |  15 +++
>  5 files changed, 144 insertions(+), 90 deletions(-)
>  rename drivers/mfd/{intel-m10-bmc.c => intel-m10-bmc-core.c} (63%)
>  create mode 100644 drivers/mfd/intel-m10-bmc-spi.c
> 
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 3b59456f5545..ee8398b02321 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -2158,18 +2158,24 @@ config SGI_MFD_IOC3
>  	  If you have an SGI Origin, Octane, or a PCI IOC3 card,
>  	  then say Y. Otherwise say N.
>  
> -config MFD_INTEL_M10_BMC
> -	tristate "Intel MAX 10 Board Management Controller"
> -	depends on SPI_MASTER
> -	select REGMAP_SPI_AVMM
> -	select MFD_CORE
> -	help
> -	  Support for the Intel MAX 10 board management controller using the
> -	  SPI interface.
> -
> -	  This driver provides common support for accessing the device,
> -	  additional drivers must be enabled in order to use the functionality
> -	  of the device.
> +config MFD_INTEL_M10_BMC_CORE
> +        tristate
> +        select MFD_CORE
> +        select REGMAP
> +        default n
> +
> +config MFD_INTEL_M10_BMC_SPI
> +        tristate "Intel MAX 10 Board Management Controller with SPI"
> +        depends on SPI_MASTER
> +        select MFD_INTEL_M10_BMC_CORE
> +        select REGMAP_SPI_AVMM
> +        help
> +          Support for the Intel MAX 10 board management controller using the
> +          SPI interface.
> +
> +          This driver provides common support for accessing the device,

                                                                   device by SPI,

> +          additional drivers must be enabled in order to use the functionality
> +          of the device.
>  
>  config MFD_RSMU_I2C
>  	tristate "Renesas Synchronization Management Unit with I2C"
> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> index 858cacf659d6..b5d3263c1205 100644
> --- a/drivers/mfd/Makefile
> +++ b/drivers/mfd/Makefile
> @@ -266,7 +266,10 @@ obj-$(CONFIG_MFD_QCOM_PM8008)	+= qcom-pm8008.o
>  
>  obj-$(CONFIG_SGI_MFD_IOC3)	+= ioc3.o
>  obj-$(CONFIG_MFD_SIMPLE_MFD_I2C)	+= simple-mfd-i2c.o
> -obj-$(CONFIG_MFD_INTEL_M10_BMC)   += intel-m10-bmc.o
> +
> +intel-m10-bmc-objs             := intel-m10-bmc-core.o
> +obj-$(CONFIG_MFD_INTEL_M10_BMC_CORE)   += intel-m10-bmc.o

Why make a intel-m10-bmc obj here? What's the problem of
intel-m10-bmc-core.o?

> +obj-$(CONFIG_MFD_INTEL_M10_BMC_SPI)   += intel-m10-bmc-spi.o
>  
>  obj-$(CONFIG_MFD_ATC260X)	+= atc260x-core.o
>  obj-$(CONFIG_MFD_ATC260X_I2C)	+= atc260x-i2c.o
> diff --git a/drivers/mfd/intel-m10-bmc.c b/drivers/mfd/intel-m10-bmc-core.c
> similarity index 63%
> rename from drivers/mfd/intel-m10-bmc.c
> rename to drivers/mfd/intel-m10-bmc-core.c
> index 7e521df29c72..f6dc549e1bc3 100644
> --- a/drivers/mfd/intel-m10-bmc.c
> +++ b/drivers/mfd/intel-m10-bmc-core.c
> @@ -1,23 +1,14 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /*
> - * Intel MAX 10 Board Management Controller chip
> + * Intel MAX 10 Board Management Controller chip - common code
>   *
> - * Copyright (C) 2018-2020 Intel Corporation. All rights reserved.
> + * Copyright (C) 2018-2022 Intel Corporation. All rights reserved.
>   */
>  #include <linux/bitfield.h>
>  #include <linux/init.h>
>  #include <linux/mfd/core.h>
>  #include <linux/mfd/intel-m10-bmc.h>
>  #include <linux/module.h>
> -#include <linux/mutex.h>
> -#include <linux/regmap.h>
> -#include <linux/spi/spi.h>
> -
> -enum m10bmc_type {
> -	M10_N3000,
> -	M10_D5005,
> -	M10_N5010,
> -};
>  
>  static struct mfd_cell m10bmc_d5005_subdevs[] = {
>  	{ .name = "d5005bmc-hwmon" },
> @@ -33,26 +24,6 @@ static struct mfd_cell m10bmc_n5010_subdevs[] = {
>  	{ .name = "n5010bmc-hwmon" },
>  };
>  
> -static const struct regmap_range m10bmc_regmap_range[] = {
> -	regmap_reg_range(M10BMC_LEGACY_BUILD_VER, M10BMC_LEGACY_BUILD_VER),
> -	regmap_reg_range(M10BMC_SYS_BASE, M10BMC_SYS_END),
> -	regmap_reg_range(M10BMC_FLASH_BASE, M10BMC_FLASH_END),
> -};
> -
> -static const struct regmap_access_table m10bmc_access_table = {
> -	.yes_ranges	= m10bmc_regmap_range,
> -	.n_yes_ranges	= ARRAY_SIZE(m10bmc_regmap_range),
> -};
> -
> -static struct regmap_config intel_m10bmc_regmap_config = {
> -	.reg_bits = 32,
> -	.val_bits = 32,
> -	.reg_stride = 4,
> -	.wr_table = &m10bmc_access_table,
> -	.rd_table = &m10bmc_access_table,
> -	.max_register = M10BMC_MEM_END,
> -};

Why remove all these configurations, I suppose it is not related to bus
type.

> -
>  static ssize_t bmc_version_show(struct device *dev,
>  				struct device_attribute *attr, char *buf)
>  {
> @@ -131,7 +102,16 @@ static struct attribute *m10bmc_attrs[] = {
>  	&dev_attr_mac_count.attr,
>  	NULL,
>  };
> -ATTRIBUTE_GROUPS(m10bmc);
> +
> +static const struct attribute_group m10bmc_group = {
> +	.attrs = m10bmc_attrs,
> +};
> +
> +const struct attribute_group *m10bmc_dev_groups[] = {
> +	&m10bmc_group,
> +	NULL,
> +};
> +EXPORT_SYMBOL_GPL(m10bmc_dev_groups);
>  
>  static int check_m10bmc_version(struct intel_m10bmc *ddata)
>  {
> @@ -158,37 +138,21 @@ static int check_m10bmc_version(struct intel_m10bmc *ddata)
>  	return 0;
>  }
>  
> -static int intel_m10_bmc_spi_probe(struct spi_device *spi)
> +int m10bmc_dev_init(struct intel_m10bmc *m10bmc)
>  {
> -	const struct spi_device_id *id = spi_get_device_id(spi);
> -	struct device *dev = &spi->dev;
> +	enum m10bmc_type type = m10bmc->type;
>  	struct mfd_cell *cells;
> -	struct intel_m10bmc *ddata;
>  	int ret, n_cell;
>  
> -	ddata = devm_kzalloc(dev, sizeof(*ddata), GFP_KERNEL);
> -	if (!ddata)
> -		return -ENOMEM;
> -
> -	ddata->dev = dev;
> -
> -	ddata->regmap =
> -		devm_regmap_init_spi_avmm(spi, &intel_m10bmc_regmap_config);
> -	if (IS_ERR(ddata->regmap)) {
> -		ret = PTR_ERR(ddata->regmap);
> -		dev_err(dev, "Failed to allocate regmap: %d\n", ret);
> -		return ret;
> -	}
> -
> -	spi_set_drvdata(spi, ddata);
> +	dev_set_drvdata(m10bmc->dev, m10bmc);

The naming is not consistent here, some are ddata, some are m10bmc,
please keep a unified name acress all the patches.

>  
> -	ret = check_m10bmc_version(ddata);
> +	ret = check_m10bmc_version(m10bmc);
>  	if (ret) {
> -		dev_err(dev, "Failed to identify m10bmc hardware\n");
> +		dev_err(m10bmc->dev, "Failed to identify m10bmc hardware\n");

Keep the dev local variable so that we don't have to change every
related lines.

>  		return ret;
>  	}
>  
> -	switch (id->driver_data) {
> +	switch (type) {
>  	case M10_N3000:
>  		cells = m10bmc_pacn3000_subdevs;
>  		n_cell = ARRAY_SIZE(m10bmc_pacn3000_subdevs);
> @@ -205,33 +169,16 @@ static int intel_m10_bmc_spi_probe(struct spi_device *spi)
>  		return -ENODEV;
>  	}
>  
> -	ret = devm_mfd_add_devices(dev, PLATFORM_DEVID_AUTO, cells, n_cell,
> -				   NULL, 0, NULL);
> +	ret = devm_mfd_add_devices(m10bmc->dev, PLATFORM_DEVID_AUTO,
> +				   cells, n_cell, NULL, 0, NULL);

ditto

>  	if (ret)
> -		dev_err(dev, "Failed to register sub-devices: %d\n", ret);
> +		dev_err(m10bmc->dev, "Failed to register sub-devices: %d\n",
> +			ret);

ditto

>  
>  	return ret;
>  }
> +EXPORT_SYMBOL_GPL(m10bmc_dev_init);
>  
> -static const struct spi_device_id m10bmc_spi_id[] = {
> -	{ "m10-n3000", M10_N3000 },
> -	{ "m10-d5005", M10_D5005 },
> -	{ "m10-n5010", M10_N5010 },
> -	{ }
> -};
> -MODULE_DEVICE_TABLE(spi, m10bmc_spi_id);
> -
> -static struct spi_driver intel_m10bmc_spi_driver = {
> -	.driver = {
> -		.name = "intel-m10-bmc",
> -		.dev_groups = m10bmc_groups,
> -	},
> -	.probe = intel_m10_bmc_spi_probe,
> -	.id_table = m10bmc_spi_id,
> -};
> -module_spi_driver(intel_m10bmc_spi_driver);
> -
> -MODULE_DESCRIPTION("Intel MAX 10 BMC Device Driver");
> +MODULE_DESCRIPTION("Intel MAX 10 BMC core MFD driver");
>  MODULE_AUTHOR("Intel Corporation");
>  MODULE_LICENSE("GPL v2");
> -MODULE_ALIAS("spi:intel-m10-bmc");
> diff --git a/drivers/mfd/intel-m10-bmc-spi.c b/drivers/mfd/intel-m10-bmc-spi.c
> new file mode 100644
> index 000000000000..9cafbc0f89f0
> --- /dev/null
> +++ b/drivers/mfd/intel-m10-bmc-spi.c
> @@ -0,0 +1,83 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Intel MAX 10 Board Management Controller chip

SPI driver for Intel MAX 10 ...

> + *
> + * Copyright (C) 2018-2021 Intel Corporation. All rights reserved.
> + */
> +#include <linux/bitfield.h>
> +#include <linux/init.h>
> +#include <linux/mfd/core.h>
> +#include <linux/mfd/intel-m10-bmc.h>
> +#include <linux/module.h>
> +#include <linux/regmap.h>
> +#include <linux/spi/spi.h>
> +
> +static const struct regmap_range m10bmc_regmap_range[] = {
> +	regmap_reg_range(M10BMC_LEGACY_BUILD_VER, M10BMC_LEGACY_BUILD_VER),
> +	regmap_reg_range(M10BMC_SYS_BASE, M10BMC_SYS_END),
> +	regmap_reg_range(M10BMC_FLASH_BASE, M10BMC_FLASH_END),
> +};
> +
> +static const struct regmap_access_table m10bmc_access_table = {
> +	.yes_ranges	= m10bmc_regmap_range,
> +	.n_yes_ranges	= ARRAY_SIZE(m10bmc_regmap_range),
> +};
> +
> +static struct regmap_config intel_m10bmc_regmap_config = {
> +	.reg_bits = 32,
> +	.val_bits = 32,
> +	.reg_stride = 4,
> +	.wr_table = &m10bmc_access_table,
> +	.rd_table = &m10bmc_access_table,
> +	.max_register = M10BMC_MEM_END,
> +};
> +
> +static int intel_m10_bmc_spi_probe(struct spi_device *spi)
> +{
> +	const struct spi_device_id *id = spi_get_device_id(spi);
> +	struct device *dev = &spi->dev;
> +	struct intel_m10bmc *ddata;
> +	int ret;
> +
> +	ddata = devm_kzalloc(dev, sizeof(*ddata), GFP_KERNEL);
> +	if (!ddata)
> +		return -ENOMEM;
> +
> +	ddata->dev = dev;
> +	ddata->type = (enum m10bmc_type)(id->driver_data);
> +
> +	ddata->regmap =
> +		devm_regmap_init_spi_avmm(spi, &intel_m10bmc_regmap_config);
> +	if (IS_ERR(ddata->regmap)) {
> +		ret = PTR_ERR(ddata->regmap);
> +		dev_err(dev, "Failed to allocate regmap: %d\n", ret);
> +		return ret;
> +	}
> +
> +	spi_set_drvdata(spi, ddata);

Why we need this? I saw the dev.drvdata is set in core driver.

> +
> +	return m10bmc_dev_init(ddata);
> +}
> +
> +static const struct spi_device_id m10bmc_spi_id[] = {
> +	{ "m10-n3000", M10_N3000 },
> +	{ "m10-d5005", M10_D5005 },
> +	{ "m10-n5010", M10_N5010 },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(spi, m10bmc_spi_id);
> +
> +static struct spi_driver intel_m10bmc_spi_driver = {
> +	.driver = {
> +		.name = "intel-m10-bmc",

Need renaming?

> +		.dev_groups = m10bmc_dev_groups,
> +	},
> +	.probe = intel_m10_bmc_spi_probe,
> +	.id_table = m10bmc_spi_id,
> +};
> +module_spi_driver(intel_m10bmc_spi_driver);
> +
> +MODULE_DESCRIPTION("Intel MAX 10 BMC SPI bus interface");
> +MODULE_AUTHOR("Intel Corporation");
> +MODULE_LICENSE("GPL");
> +MODULE_ALIAS("spi:intel-m10-bmc");
> diff --git a/include/linux/mfd/intel-m10-bmc.h b/include/linux/mfd/intel-m10-bmc.h
> index f0044b14136e..dd81ffdcf168 100644
> --- a/include/linux/mfd/intel-m10-bmc.h
> +++ b/include/linux/mfd/intel-m10-bmc.h
> @@ -118,14 +118,23 @@
>  /* Address of 4KB inverted bit vector containing staging area FLASH count */
>  #define STAGING_FLASH_COUNT	0x17ffb000
>  
> +/* Supported MAX10 BMC types */

Please use correct format for kernel doc comments

> +enum m10bmc_type {
> +	M10_N3000,
> +	M10_D5005,
> +	M10_N5010,
> +};
> +
>  /**
>   * struct intel_m10bmc - Intel MAX 10 BMC parent driver data structure
>   * @dev: this device
>   * @regmap: the regmap used to access registers by m10bmc itself
> + * @type: the type of MAX10 BMC
>   */
>  struct intel_m10bmc {
>  	struct device *dev;
>  	struct regmap *regmap;
> +	enum m10bmc_type type;
>  };
>  
>  /*
> @@ -159,4 +168,10 @@ m10bmc_raw_read(struct intel_m10bmc *m10bmc, unsigned int addr,
>  #define m10bmc_sys_read(m10bmc, offset, val) \
>  	m10bmc_raw_read(m10bmc, M10BMC_SYS_BASE + (offset), val)
>  
> +/*
> + * MAX10 BMC Core support
> + */
> +int m10bmc_dev_init(struct intel_m10bmc *m10bmc);
> +extern const struct attribute_group *m10bmc_dev_groups[];
> +
>  #endif /* __MFD_INTEL_M10_BMC_H */
> -- 
> 2.26.2
