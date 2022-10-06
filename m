Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C54E5F5F5D
	for <lists+linux-fpga@lfdr.de>; Thu,  6 Oct 2022 05:14:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbiJFDMw (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 5 Oct 2022 23:12:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbiJFDMo (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 5 Oct 2022 23:12:44 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42634895F2;
        Wed,  5 Oct 2022 20:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665025959; x=1696561959;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gh5OVqF15e9clx6zOacfWTHXWSaHJb/fk8tuPk8eGYY=;
  b=aIPXZ3QTv8MGKmdAIyGMcs2GyjPXSbCqaJW/47oV/81FAJI9JNylwtbi
   wk1/AGyuJk4e6jVAgQHuMxU4xMJwJ85EWkatpTWUtT20AoqDeQ6VbckO4
   /kE3hEpF1kkKo3yAgQEIifGEwMk/gmgEhAJIhwIQqY4eYjaEEigDF8+wP
   8kUQvlC3O6oKSer/wZLCwHa/z738sY9qylVRfd9lguRp/e5Dw0kOchO6s
   mf+18w0JtU/4v1NkTfgdcIeRqDzN4uxUqDSAzgLI3eRzqye4NPMISIHcJ
   SPDuucUkdFckEJw2qlj8y9ZWMQR/TvHNx03zpOZsJ+xkLnEmQ/ee9+jHZ
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10491"; a="303307618"
X-IronPort-AV: E=Sophos;i="5.95,162,1661842800"; 
   d="scan'208";a="303307618"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2022 20:12:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10491"; a="953444525"
X-IronPort-AV: E=Sophos;i="5.95,162,1661842800"; 
   d="scan'208";a="953444525"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmsmga005.fm.intel.com with ESMTP; 05 Oct 2022 20:12:35 -0700
Date:   Thu, 6 Oct 2022 11:03:39 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Ivan Bornyakov <i.bornyakov@metrotek.ru>
Cc:     mdf@kernel.org, hao.wu@intel.com, trix@redhat.com, dg@emlix.com,
        j.zink@pengutronix.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-fpga@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, system@metrotek.ru
Subject: Re: [PATCH v13 1/2] fpga: lattice-sysconfig-spi: add Lattice
 sysCONFIG FPGA manager
Message-ID: <Yz5Fi3lBrzV8LMm7@yilunxu-OptiPlex-7050>
References: <20220926143924.11367-1-i.bornyakov@metrotek.ru>
 <20220926143924.11367-2-i.bornyakov@metrotek.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220926143924.11367-2-i.bornyakov@metrotek.ru>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 2022-09-26 at 17:39:23 +0300, Ivan Bornyakov wrote:
> Add support to the FPGA manager for programming Lattice ECP5 FPGA over
> slave SPI sysCONFIG interface.
> 
> sysCONFIG interface core functionality is separate from both ECP5 and
> SPI specifics, so support for other FPGAs with different port types can
> be added in the future.
> 
> Signed-off-by: Ivan Bornyakov <i.bornyakov@metrotek.ru>
> ---
>  drivers/fpga/Kconfig                 |  11 +
>  drivers/fpga/Makefile                |   2 +
>  drivers/fpga/lattice-sysconfig-spi.c | 151 ++++++++++
>  drivers/fpga/lattice-sysconfig.c     | 428 +++++++++++++++++++++++++++
>  drivers/fpga/lattice-sysconfig.h     |  41 +++
>  5 files changed, 633 insertions(+)
>  create mode 100644 drivers/fpga/lattice-sysconfig-spi.c
>  create mode 100644 drivers/fpga/lattice-sysconfig.c
>  create mode 100644 drivers/fpga/lattice-sysconfig.h
> 
> diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
> index 6c416955da53..d1a8107fdcb3 100644
> --- a/drivers/fpga/Kconfig
> +++ b/drivers/fpga/Kconfig
> @@ -263,4 +263,15 @@ config FPGA_MGR_MICROCHIP_SPI
>  	  programming over slave SPI interface with .dat formatted
>  	  bitstream image.
>  
> +config FPGA_MGR_LATTICE_SYSCONFIG
> +	tristate
> +
> +config FPGA_MGR_LATTICE_SYSCONFIG_SPI
> +	tristate "Lattice sysCONFIG SPI FPGA manager"
> +	depends on SPI
> +	select FPGA_MGR_LATTICE_SYSCONFIG
> +	help
> +	  FPGA manager driver support for Lattice FPGAs programming over slave
> +	  SPI sysCONFIG interface.
> +
>  endif # FPGA
> diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
> index 42ae8b58abce..72e554b4d2f7 100644
> --- a/drivers/fpga/Makefile
> +++ b/drivers/fpga/Makefile
> @@ -20,6 +20,8 @@ obj-$(CONFIG_FPGA_MGR_ZYNQ_FPGA)	+= zynq-fpga.o
>  obj-$(CONFIG_FPGA_MGR_ZYNQMP_FPGA)	+= zynqmp-fpga.o
>  obj-$(CONFIG_FPGA_MGR_VERSAL_FPGA)	+= versal-fpga.o
>  obj-$(CONFIG_FPGA_MGR_MICROCHIP_SPI)	+= microchip-spi.o
> +obj-$(CONFIG_FPGA_MGR_LATTICE_SYSCONFIG)	+= lattice-sysconfig.o
> +obj-$(CONFIG_FPGA_MGR_LATTICE_SYSCONFIG_SPI)	+= lattice-sysconfig-spi.o
>  obj-$(CONFIG_ALTERA_PR_IP_CORE)		+= altera-pr-ip-core.o
>  obj-$(CONFIG_ALTERA_PR_IP_CORE_PLAT)	+= altera-pr-ip-core-plat.o
>  
> diff --git a/drivers/fpga/lattice-sysconfig-spi.c b/drivers/fpga/lattice-sysconfig-spi.c
> new file mode 100644
> index 000000000000..1428705ae7d1
> --- /dev/null
> +++ b/drivers/fpga/lattice-sysconfig-spi.c
> @@ -0,0 +1,151 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Lattice FPGA programming over slave SPI sysCONFIG interface.
> + */
> +
> +#include <linux/spi/spi.h>
> +
> +#include "lattice-sysconfig.h"
> +
> +static const u32 ecp5_spi_max_speed_hz = 60000000;
> +
> +static int sysconfig_spi_cmd_write(struct sysconfig_priv *priv,
> +				   const void *tx_buf, size_t tx_len)
> +{
> +	struct spi_device *spi = to_spi_device(priv->dev);
> +
> +	return spi_write(spi, tx_buf, tx_len);
> +}
> +
> +static int sysconfig_spi_cmd_read(struct sysconfig_priv *priv,
> +				  const void *tx_buf, size_t tx_len,
> +				  void *rx_buf, size_t rx_len)
> +{
> +	struct spi_device *spi = to_spi_device(priv->dev);
> +
> +	return spi_write_then_read(spi, tx_buf, tx_len, rx_buf, rx_len);
> +}
> +
> +static int sysconfig_spi_bitstream_burst_init(struct sysconfig_priv *priv)
> +{
> +	const u8 lsc_bitstream_burst[] = SYSCONFIG_LSC_BITSTREAM_BURST;
> +	struct spi_device *spi = to_spi_device(priv->dev);
> +	struct spi_transfer xfer = {
> +		.tx_buf = lsc_bitstream_burst,
> +		.len = sizeof(lsc_bitstream_burst),
> +		.cs_change = 1,
> +	};
> +	struct spi_message msg;
> +	int ret;
> +
> +	spi_message_init_with_transfers(&msg, &xfer, 1);
> +
> +	/*
> +	 * Lock SPI bus for exclusive usage until FPGA programming is done.
> +	 * SPI bus will be released in sysconfig_spi_bitstream_burst_complete().
> +	 */
> +	spi_bus_lock(spi->controller);
> +
> +	ret = spi_sync_locked(spi, &msg);
> +	if (ret)
> +		spi_bus_unlock(spi->controller);
> +
> +	return ret;
> +}
> +
> +static int sysconfig_spi_bitstream_burst_write(struct sysconfig_priv *priv,
> +					       const char *buf, size_t len)
> +{
> +	struct spi_device *spi = to_spi_device(priv->dev);
> +	struct spi_transfer xfer = {
> +		.tx_buf = buf,
> +		.len = len,
> +		.cs_change = 1,
> +	};
> +	struct spi_message msg;
> +
> +	spi_message_init_with_transfers(&msg, &xfer, 1);
> +
> +	return spi_sync_locked(spi, &msg);
> +}
> +
> +static int sysconfig_spi_bitstream_burst_complete(struct sysconfig_priv *priv)
> +{
> +	struct spi_device *spi = to_spi_device(priv->dev);
> +
> +	/* Bitstream burst write is done, release SPI bus */
> +	spi_bus_unlock(spi->controller);
> +
> +	/* Toggle CS to finish bitstream write */
> +	return spi_write(spi, NULL, 0);
> +}
> +
> +static int sysconfig_spi_probe(struct spi_device *spi)
> +{
> +	const struct spi_device_id *dev_id;
> +	struct device *dev = &spi->dev;
> +	struct sysconfig_priv *priv;
> +	const u32 *spi_max_speed;
> +
> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	spi_max_speed = device_get_match_data(dev);
> +	if (!spi_max_speed) {
> +		dev_id = spi_get_device_id(spi);
> +		if (!dev_id)
> +			return -ENODEV;
> +
> +		spi_max_speed = (const u32 *)dev_id->driver_data;
> +	}
> +
> +	if (!spi_max_speed)
> +		return -EINVAL;
> +
> +	if (spi->max_speed_hz > *spi_max_speed) {
> +		dev_err(dev, "SPI speed %u is too high, maximum speed is %u\n",
> +			spi->max_speed_hz, *spi_max_speed);
> +		return -EINVAL;
> +	}
> +
> +	priv->dev = dev;
> +	priv->command_write = sysconfig_spi_cmd_write;
> +	priv->command_read = sysconfig_spi_cmd_read;
> +	priv->bitstream_burst_write_init = sysconfig_spi_bitstream_burst_init;
> +	priv->bitstream_burst_write = sysconfig_spi_bitstream_burst_write;
> +	priv->bitstream_burst_write_complete = sysconfig_spi_bitstream_burst_complete;
> +
> +	return sysconfig_probe(priv);
> +}
> +
> +static const struct spi_device_id sysconfig_spi_ids[] = {
> +	{
> +		.name = "sysconfig-ecp5",
> +		.driver_data = (kernel_ulong_t)&ecp5_spi_max_speed_hz,
> +	}, {},
> +};
> +MODULE_DEVICE_TABLE(spi, sysconfig_spi_ids);
> +
> +#if IS_ENABLED(CONFIG_OF)
> +static const struct of_device_id sysconfig_of_ids[] = {
> +	{
> +		.compatible = "lattice,sysconfig-ecp5",
> +		.data = &ecp5_spi_max_speed_hz,
> +	}, {},
> +};
> +MODULE_DEVICE_TABLE(of, sysconfig_of_ids);
> +#endif /* IS_ENABLED(CONFIG_OF) */
> +
> +static struct spi_driver lattice_sysconfig_driver = {
> +	.probe = sysconfig_spi_probe,
> +	.id_table = sysconfig_spi_ids,
> +	.driver = {
> +		.name = "lattice_sysconfig_spi_fpga_mgr",
> +		.of_match_table = of_match_ptr(sysconfig_of_ids),
> +	},
> +};
> +module_spi_driver(lattice_sysconfig_driver);
> +
> +MODULE_DESCRIPTION("Lattice sysCONFIG Slave SPI FPGA Manager");
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/fpga/lattice-sysconfig.c b/drivers/fpga/lattice-sysconfig.c
> new file mode 100644
> index 000000000000..f9acff1ab122
> --- /dev/null
> +++ b/drivers/fpga/lattice-sysconfig.c
> @@ -0,0 +1,428 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Lattice FPGA sysCONFIG interface functions independent of port type.
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/fpga/fpga-mgr.h>
> +#include <linux/gpio/consumer.h>
> +
> +#include "lattice-sysconfig.h"
> +
> +static int sysconfig_cmd_write(struct sysconfig_priv *priv, const void *buf,
> +			       size_t buf_len)
> +{
> +	return priv->command_write(priv, buf, buf_len);
> +}
> +
> +static int sysconfig_cmd_read(struct sysconfig_priv *priv, const void *tx_buf,
> +			      size_t tx_len, void *rx_buf, size_t rx_len)
> +{
> +	return priv->command_read(priv, tx_buf, tx_len, rx_buf, rx_len);
> +}
> +
> +static int sysconfig_read_busy(struct sysconfig_priv *priv)
> +{
> +	const u8 lsc_check_busy[] = SYSCONFIG_LSC_CHECK_BUSY;
> +	u8 busy;
> +	int ret;
> +
> +	ret = sysconfig_cmd_read(priv, lsc_check_busy, sizeof(lsc_check_busy),
> +				 &busy, sizeof(busy));
> +
> +	return ret ? : busy;
> +}
> +
> +static int sysconfig_poll_busy(struct sysconfig_priv *priv)
> +{
> +	unsigned long timeout;
> +	int ret;
> +
> +	timeout = jiffies + msecs_to_jiffies(SYSCONFIG_POLL_BUSY_TIMEOUT_MS);
> +
> +	while (time_before(jiffies, timeout)) {
> +		ret = sysconfig_read_busy(priv);
> +		if (ret <= 0)
> +			return ret;
> +
> +		usleep_range(SYSCONFIG_POLL_INTERVAL_US,
> +			     SYSCONFIG_POLL_INTERVAL_US * 2);
> +	}
> +
> +	return -EBUSY;

return -ETIMEDOUT? To be aligned with sysconfig_poll_gpio.

Others look good to me.

Thanks,
Yilun
