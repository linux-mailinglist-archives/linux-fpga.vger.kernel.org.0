Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EADA56257B5
	for <lists+linux-fpga@lfdr.de>; Fri, 11 Nov 2022 11:15:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233333AbiKKKNe (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 11 Nov 2022 05:13:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233483AbiKKKNd (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 11 Nov 2022 05:13:33 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 466471403F;
        Fri, 11 Nov 2022 02:13:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668161611; x=1699697611;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=hT6VwI9Lfadetc7tu4o4wb1qK4/zT2RrGyprifczX3s=;
  b=aKhr68e80bp3CvtxHNayXof/kxXUGZcLYadZWlTijkFkgZJovna03ZqF
   i1mWBtv+fbfVUgwywUEtz7dyTKIp0T1sq+wGCWk7UjA+nKTgpd1nTvlXv
   2o9FUeKNpiNEMuzfeV77t0Fy7Cg1VQE/hpgHWH4ROmDYi1exJ7ezVSt66
   9TIKVcd2BIFxaAtsXZszUjUZKkQ1rpoWy7Z788lbt6k79CInBiRSxnbb0
   6SL/VMWNgzlUzfc+cKfQiUUTGdA00o7lkjh0wOS1aFhD2wuPNcH4OeSUL
   HqodJ6iiIyXQkaAdB8/dLc8hmOBXywKhjon4Aq3IgAyrgVXZo/1LtpFQb
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="309197148"
X-IronPort-AV: E=Sophos;i="5.96,156,1665471600"; 
   d="scan'208";a="309197148"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2022 02:13:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="701169668"
X-IronPort-AV: E=Sophos;i="5.96,156,1665471600"; 
   d="scan'208";a="701169668"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmsmga008.fm.intel.com with ESMTP; 11 Nov 2022 02:13:27 -0800
Date:   Fri, 11 Nov 2022 18:04:07 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     linux-fpga@vger.kernel.org, Wu Hao <hao.wu@intel.com>,
        Tom Rix <trix@redhat.com>, Moritz Fischer <mdf@kernel.org>,
        Lee Jones <lee@kernel.org>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        Russ Weight <russell.h.weight@intel.com>,
        Tianfei zhang <tianfei.zhang@intel.com>,
        Mark Brown <broonie@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/12] mfd: intel-m10-bmc: Add PMCI driver
Message-ID: <Y24eF6OsRTFGcB/F@yilunxu-OptiPlex-7050>
References: <20221108144305.45424-1-ilpo.jarvinen@linux.intel.com>
 <20221108144305.45424-11-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221108144305.45424-11-ilpo.jarvinen@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 2022-11-08 at 16:43:03 +0200, Ilpo Järvinen wrote:
> Adding an mfd driver for the PMCI-based interface of Intel MAX10 BMC
> controller.

Could you help describe what is PMCI? Also add the description somewhere
in code.

> 
> Co-developed-by: Tianfei zhang <tianfei.zhang@intel.com>
> Signed-off-by: Tianfei zhang <tianfei.zhang@intel.com>
> Co-developed-by: Russ Weight <russell.h.weight@intel.com>
> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---
>  .../ABI/testing/sysfs-driver-intel-m10-bmc    |   8 +-
>  drivers/mfd/Kconfig                           |  12 ++
>  drivers/mfd/Makefile                          |   1 +
>  drivers/mfd/intel-m10-bmc-pmci.c              | 154 ++++++++++++++++++
>  include/linux/mfd/intel-m10-bmc.h             |   1 +
>  5 files changed, 172 insertions(+), 4 deletions(-)
>  create mode 100644 drivers/mfd/intel-m10-bmc-pmci.c
> 
> diff --git a/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc b/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc
> index 9773925138af..a8ab58035c95 100644
> --- a/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc
> +++ b/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc
> @@ -1,4 +1,4 @@
> -What:		/sys/bus/spi/devices/.../bmc_version
> +What:		/sys/bus/.../drivers/intel-m10-bmc/.../bmc_version

It's good. And could you add in commit message about why the changes to the ABI
description.

>  Date:		June 2020
>  KernelVersion:	5.10
>  Contact:	Xu Yilun <yilun.xu@intel.com>
> @@ -6,7 +6,7 @@ Description:	Read only. Returns the hardware build version of Intel
>  		MAX10 BMC chip.
>  		Format: "0x%x".
>  
> -What:		/sys/bus/spi/devices/.../bmcfw_version
> +What:		/sys/bus/.../drivers/intel-m10-bmc/.../bmcfw_version
>  Date:		June 2020
>  KernelVersion:	5.10
>  Contact:	Xu Yilun <yilun.xu@intel.com>
> @@ -14,7 +14,7 @@ Description:	Read only. Returns the firmware version of Intel MAX10
>  		BMC chip.
>  		Format: "0x%x".
>  
> -What:		/sys/bus/spi/devices/.../mac_address
> +What:		/sys/bus/.../drivers/intel-m10-bmc/.../mac_address
>  Date:		January 2021
>  KernelVersion:  5.12
>  Contact:	Russ Weight <russell.h.weight@intel.com>
> @@ -25,7 +25,7 @@ Description:	Read only. Returns the first MAC address in a block
>  		space.
>  		Format: "%02x:%02x:%02x:%02x:%02x:%02x".
>  
> -What:		/sys/bus/spi/devices/.../mac_count
> +What:		/sys/bus/.../drivers/intel-m10-bmc/.../mac_count
>  Date:		January 2021
>  KernelVersion:  5.12
>  Contact:	Russ Weight <russell.h.weight@intel.com>
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index a09d4ac60dc7..38d53f6c4d7b 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -2238,6 +2238,18 @@ config MFD_INTEL_M10_BMC_SPI
>            additional drivers must be enabled in order to use the functionality
>            of the device.
>  
> +config MFD_INTEL_M10_BMC_PMCI
> +	tristate "Intel MAX 10 Board Management Controller with PMCI"
> +	depends on FPGA_DFL
> +	select MFD_INTEL_M10_BMC_CORE
> +	select REGMAP_INDIRECT
> +	help
> +	  Support for the Intel MAX 10 board management controller via PMCI.
> +
> +	  This driver provides common support for accessing the device,
> +	  additional drivers must be enabled in order to use the functionality
> +	  of the device.
> +
>  config MFD_RSMU_I2C
>  	tristate "Renesas Synchronization Management Unit with I2C"
>  	depends on I2C && OF
> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> index f32276cdd0c2..7559362cb438 100644
> --- a/drivers/mfd/Makefile
> +++ b/drivers/mfd/Makefile
> @@ -275,6 +275,7 @@ obj-$(CONFIG_MFD_SIMPLE_MFD_I2C)	+= simple-mfd-i2c.o
>  intel-m10-bmc-objs             := intel-m10-bmc-core.o
>  obj-$(CONFIG_MFD_INTEL_M10_BMC_CORE)   += intel-m10-bmc.o
>  obj-$(CONFIG_MFD_INTEL_M10_BMC_SPI)   += intel-m10-bmc-spi.o
> +obj-$(CONFIG_MFD_INTEL_M10_BMC_PMCI)  += intel-m10-bmc-pmci.o
>  
>  obj-$(CONFIG_MFD_ATC260X)	+= atc260x-core.o
>  obj-$(CONFIG_MFD_ATC260X_I2C)	+= atc260x-i2c.o
> diff --git a/drivers/mfd/intel-m10-bmc-pmci.c b/drivers/mfd/intel-m10-bmc-pmci.c
> new file mode 100644
> index 000000000000..918378a78bdb
> --- /dev/null
> +++ b/drivers/mfd/intel-m10-bmc-pmci.c
> @@ -0,0 +1,154 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * PMCI-based interface to MAX10 BMC
> + *
> + * Copyright (C) 2020-2022 Intel Corporation, Inc.
> + *
> + */
> +
> +#include <linux/dfl.h>
> +#include <linux/mfd/core.h>
> +#include <linux/mfd/intel-m10-bmc.h>
> +#include <linux/module.h>
> +#include <linux/regmap.h>
> +
> +#define M10BMC_PMCI_INDIRECT_BASE	0x400
> +
> +#define M10BMC_PMCI_SYS_BASE		0x0
> +#define M10BMC_PMCI_SYS_END		0xfff
> +
> +#define M10BMC_PMCI_DOORBELL		0x1c0
> +#define M10BMC_PMCI_AUTH_RESULT		0x1c4
> +
> +/* Telemetry registers */
> +#define M10BMC_PMCI_TELEM_START		0x400
> +#define M10BMC_PMCI_TELEM_END		0x78c
> +
> +#define M10BMC_PMCI_BUILD_VER		0x0
> +#define NIOS2_PMCI_FW_VERSION		0x4
> +#define M10BMC_PMCI_MAC_LOW		0x20
> +#define M10BMC_PMCI_MAC_HIGH		(M10BMC_PMCI_MAC_LOW + 4)
> +
> +/* Addresses for security related data in FLASH */
> +#define PMCI_BMC_REH_ADDR		0x7ffc004
> +#define PMCI_BMC_PROG_ADDR		0x7ffc000
> +#define PMCI_BMC_PROG_MAGIC		0x5746
> +
> +#define PMCI_SR_REH_ADDR		0x7ffd004
> +#define PMCI_SR_PROG_ADDR		0x7ffd000
> +#define PMCI_SR_PROG_MAGIC		0x5253
> +
> +#define PMCI_PR_REH_ADDR		0x7ffe004
> +#define PMCI_PR_PROG_ADDR		0x7ffe000
> +#define PMCI_PR_PROG_MAGIC		0x5250
> +
> +#define PMCI_STAGING_FLASH_COUNT	0x7ff5000
> +
> +struct pmci_device {
> +	void __iomem *base;
> +	struct device *dev;
> +	struct intel_m10bmc m10bmc;
> +};
> +
> +static const struct regmap_range m10bmc_pmci_regmap_range[] = {
> +	regmap_reg_range(M10BMC_PMCI_SYS_BASE, M10BMC_PMCI_SYS_END),
> +};
> +
> +static const struct regmap_access_table m10_access_table = {
> +	.yes_ranges	= m10bmc_pmci_regmap_range,
> +	.n_yes_ranges	= ARRAY_SIZE(m10bmc_pmci_regmap_range),
> +};
> +
> +static const struct regmap_indirect_cfg indirect_cfg = {
> +	INTEL_M10_REGMAP_INDIRECT_CFG,
> +};
> +
> +static struct regmap_config m10bmc_pmci_regmap_config = {
> +	.reg_bits = 32,
> +	.reg_stride = 4,
> +	.val_bits = 32,
> +	.wr_table = &m10_access_table,
> +	.rd_table = &m10_access_table,
> +	.max_register = M10BMC_PMCI_SYS_END,
> +	.indirect_cfg = &indirect_cfg,
> +};
> +
> +static struct mfd_cell m10bmc_n6000_bmc_subdevs[] = {
> +	{ .name = "n6000bmc-hwmon" },
> +};
> +
> +static const struct m10bmc_csr_map m10bmc_pmci_csr_map = {
> +	.base = M10BMC_PMCI_SYS_BASE,
> +	.build_version = M10BMC_PMCI_BUILD_VER,
> +	.fw_version = NIOS2_PMCI_FW_VERSION,
> +	.mac_low = M10BMC_PMCI_MAC_LOW,
> +	.mac_high = M10BMC_PMCI_MAC_HIGH,
> +	.doorbell = M10BMC_PMCI_DOORBELL,
> +	.auth_result = M10BMC_PMCI_AUTH_RESULT,
> +	.bmc_prog_addr = PMCI_BMC_PROG_ADDR,
> +	.bmc_reh_addr = PMCI_BMC_REH_ADDR,
> +	.bmc_magic = PMCI_BMC_PROG_MAGIC,
> +	.sr_prog_addr = PMCI_SR_PROG_ADDR,
> +	.sr_reh_addr = PMCI_SR_REH_ADDR,
> +	.sr_magic = PMCI_SR_PROG_MAGIC,
> +	.pr_prog_addr = PMCI_PR_PROG_ADDR,
> +	.pr_reh_addr = PMCI_PR_REH_ADDR,
> +	.pr_magic = PMCI_PR_PROG_MAGIC,
> +	.rsu_update_counter = PMCI_STAGING_FLASH_COUNT,
> +};
> +
> +static const struct intel_m10bmc_platform_info m10bmc_m10_n6000 = {
> +	.type = M10_N6000,
> +	.cells = m10bmc_n6000_bmc_subdevs,
> +	.n_cells = ARRAY_SIZE(m10bmc_n6000_bmc_subdevs),
> +	.csr_map = &m10bmc_pmci_csr_map,
> +};
> +
> +static int pmci_probe(struct dfl_device *ddev)
> +{
> +	struct device *dev = &ddev->dev;
> +	struct pmci_device *pmci;
> +
> +	pmci = devm_kzalloc(dev, sizeof(*pmci), GFP_KERNEL);
> +	if (!pmci)
> +		return -ENOMEM;
> +
> +	pmci->m10bmc.dev = dev;
> +	pmci->dev = dev;

I don't see its usage.

> +
> +	pmci->base = devm_ioremap_resource(dev, &ddev->mmio_res);
> +	if (IS_ERR(pmci->base))
> +		return PTR_ERR(pmci->base);
> +
> +	pmci->m10bmc.regmap =
> +		devm_regmap_init_indirect(dev,
> +					  pmci->base + M10BMC_PMCI_INDIRECT_BASE,
> +					  &m10bmc_pmci_regmap_config);
> +	if (IS_ERR(pmci->m10bmc.regmap))
> +		return PTR_ERR(pmci->m10bmc.regmap);
> +
> +	return m10bmc_dev_init(&pmci->m10bmc, &m10bmc_m10_n6000);
> +}
> +
> +#define FME_FEATURE_ID_PMCI_BMC	0x12
> +
> +static const struct dfl_device_id pmci_ids[] = {
> +	{ FME_ID, FME_FEATURE_ID_PMCI_BMC },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(dfl, pmci_ids);
> +
> +static struct dfl_driver pmci_driver = {
> +	.drv	= {
> +		.name       = "intel-m10-bmc",
> +		.dev_groups = m10bmc_dev_groups,
> +	},
> +	.id_table = pmci_ids,
> +	.probe    = pmci_probe,
> +};
> +
> +module_dfl_driver(pmci_driver);

Maybe change the name. This is still a MAX10 bmc driver, pmci is just the
interface to max10.

Thanks,
Yilun

> +
> +MODULE_DESCRIPTION("MAX10 BMC PMCI-based interface");
> +MODULE_AUTHOR("Intel Corporation");
> +MODULE_LICENSE("GPL");
> diff --git a/include/linux/mfd/intel-m10-bmc.h b/include/linux/mfd/intel-m10-bmc.h
> index 1b907c1a176f..90f2a691ef46 100644
> --- a/include/linux/mfd/intel-m10-bmc.h
> +++ b/include/linux/mfd/intel-m10-bmc.h
> @@ -13,6 +13,7 @@ enum m10bmc_type {
>  	M10_N3000,
>  	M10_D5005,
>  	M10_N5010,
> +	M10_N6000,
>  };
>  
>  #define INTEL_M10_REGMAP_INDIRECT_CFG	\
> -- 
> 2.30.2
> 
