Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D4CC5B4BD5
	for <lists+linux-fpga@lfdr.de>; Sun, 11 Sep 2022 06:34:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbiIKEcu (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 11 Sep 2022 00:32:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiIKEct (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sun, 11 Sep 2022 00:32:49 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 112AE40BE6;
        Sat, 10 Sep 2022 21:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662870767; x=1694406767;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/CDTCVlVP/0ECgL/5XUP3DIsW6gIRq18YEyeTwCVH1I=;
  b=G0/6kQSGvtkTwlbPs/uwOK6fwNjrxZBp6aegCuDywGcEvX9m9UQf1M8j
   jMF6qKHZy9OYTc7PJjjCm+8fo6O91JQHDHPij76bBtHXpet5FRAKF8lkz
   sKGuZgsPW1RUV9s2az/NekTrh/l8ZipawSZ08bKlNMhkNWg0kPuKcO8yT
   w727aZcR1Anb5S3f9wtWF+jAokz9oKR5yJI0rS++FFpu2GSNtWdO9a7vx
   Oq4IV14x1o84ZezJNUzSbCiIDFIqu3a1qvWEdUrh1U72ItsTzsa8+Oc/w
   fpv3VtTQqX8oCVa5wYibFkBPiWIwB8hjLUxWuoXVflI6LxOz4osweOry8
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10466"; a="383989131"
X-IronPort-AV: E=Sophos;i="5.93,307,1654585200"; 
   d="scan'208";a="383989131"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2022 21:32:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,307,1654585200"; 
   d="scan'208";a="677668462"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmsmga008.fm.intel.com with ESMTP; 10 Sep 2022 21:32:43 -0700
Date:   Sun, 11 Sep 2022 12:23:12 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Ivan Bornyakov <i.bornyakov@metrotek.ru>
Cc:     mdf@kernel.org, hao.wu@intel.com, trix@redhat.com, dg@emlix.com,
        j.zink@pengutronix.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-fpga@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, system@metrotek.ru
Subject: Re: [PATCH v10 1/2] fpga: lattice-sysconfig-spi: add Lattice
 sysCONFIG FPGA manager
Message-ID: <Yx1isMn5+z/UYapO@yilunxu-OptiPlex-7050>
References: <20220905133205.17039-1-i.bornyakov@metrotek.ru>
 <20220905133205.17039-2-i.bornyakov@metrotek.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220905133205.17039-2-i.bornyakov@metrotek.ru>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 2022-09-05 at 16:32:04 +0300, Ivan Bornyakov wrote:
> Add support to the FPGA manager for programming Lattice ECP5 and MachXO2
> FPGAs over slave SPI sysCONFIG interface.

This version is much better, see my comments inline.

> 
> Signed-off-by: Ivan Bornyakov <i.bornyakov@metrotek.ru>
> ---
>  drivers/fpga/Kconfig         |   7 +
>  drivers/fpga/Makefile        |   3 +
>  drivers/fpga/sysconfig-spi.c | 199 ++++++++++++++
>  drivers/fpga/sysconfig.c     | 520 +++++++++++++++++++++++++++++++++++
>  drivers/fpga/sysconfig.h     |  63 +++++
>  5 files changed, 792 insertions(+)
>  create mode 100644 drivers/fpga/sysconfig-spi.c
>  create mode 100644 drivers/fpga/sysconfig.c
>  create mode 100644 drivers/fpga/sysconfig.h
> 
> diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
> index 6c416955da53..991d9d976dca 100644
> --- a/drivers/fpga/Kconfig
> +++ b/drivers/fpga/Kconfig
> @@ -263,4 +263,11 @@ config FPGA_MGR_MICROCHIP_SPI
>  	  programming over slave SPI interface with .dat formatted
>  	  bitstream image.
>  
> +config FPGA_MGR_LATTICE_SPI
> +	tristate "Lattice sysCONFIG SPI FPGA manager"
> +	depends on SPI
> +	help
> +	  FPGA manager driver support for Lattice FPGAs programming over slave
> +	  SPI sysCONFIG interface.
> +
>  endif # FPGA
> diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
> index 42ae8b58abce..70e5f58d0c10 100644
> --- a/drivers/fpga/Makefile
> +++ b/drivers/fpga/Makefile
> @@ -20,9 +20,12 @@ obj-$(CONFIG_FPGA_MGR_ZYNQ_FPGA)	+= zynq-fpga.o
>  obj-$(CONFIG_FPGA_MGR_ZYNQMP_FPGA)	+= zynqmp-fpga.o
>  obj-$(CONFIG_FPGA_MGR_VERSAL_FPGA)	+= versal-fpga.o
>  obj-$(CONFIG_FPGA_MGR_MICROCHIP_SPI)	+= microchip-spi.o
> +obj-$(CONFIG_FPGA_MGR_LATTICE_SPI)	+= lattice-sysconfig-spi.o
>  obj-$(CONFIG_ALTERA_PR_IP_CORE)		+= altera-pr-ip-core.o
>  obj-$(CONFIG_ALTERA_PR_IP_CORE_PLAT)	+= altera-pr-ip-core-plat.o
>  
> +lattice-sysconfig-spi-objs		:= sysconfig-spi.o sysconfig.o
> +
>  # FPGA Secure Update Drivers
>  obj-$(CONFIG_FPGA_M10_BMC_SEC_UPDATE)	+= intel-m10-bmc-sec-update.o
>  
> diff --git a/drivers/fpga/sysconfig-spi.c b/drivers/fpga/sysconfig-spi.c
> new file mode 100644
> index 000000000000..f4dba2b57352
> --- /dev/null
> +++ b/drivers/fpga/sysconfig-spi.c
> @@ -0,0 +1,199 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Lattice FPGA programming over slave SPI sysCONFIG interface.
> + */
> +
> +#include <linux/of_device.h>
> +#include <linux/spi/spi.h>
> +
> +#include "sysconfig.h"
> +
> +static int sysconfig_spi_cmd_write(struct sysconfig_priv *priv,
> +				   const void *tx_buf, size_t tx_len)
> +{
> +	struct spi_device *spi = to_spi_device(priv->dev);
> +
> +	if (!spi)
> +		return -ENODEV;
> +
> +	return spi_write(spi, tx_buf, tx_len);
> +}
> +
> +static int sysconfig_spi_cmd_write_with_data(struct sysconfig_priv *priv,
> +					     const void *cmd, size_t cmd_len,
> +					     const void *data, size_t data_len)
> +{
> +	struct spi_device *spi = to_spi_device(priv->dev);
> +	struct spi_transfer xfers[2] = {
> +		{
> +			.tx_buf = cmd,
> +			.len = cmd_len,
> +		}, {
> +			.tx_buf = data,
> +			.len = data_len,
> +		},
> +	};
> +
> +	if (!spi)
> +		return -ENODEV;
> +
> +	return spi_sync_transfer(spi, xfers, 2);
> +}
> +
> +static int sysconfig_spi_cmd_write_then_read(struct sysconfig_priv *priv,
> +					     const void *tx_buf, size_t tx_len,
> +					     void *rx_buf, size_t rx_len)
> +{
> +	struct spi_device *spi = to_spi_device(priv->dev);
> +
> +	if (!spi)
> +		return -ENODEV;
> +
> +	return spi_write_then_read(spi, tx_buf, tx_len, rx_buf, rx_len);
> +}
> +
> +static int sysconfig_lsc_burst_init(struct sysconfig_priv *priv)

add the spi prefix for the func name.

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
> +	if (!spi)
> +		return -ENODEV;
> +
> +	spi_message_init_with_transfers(&msg, &xfer, 1);
> +
> +	/*
> +	 * Lock SPI bus for exclusive usage until FPGA programming is done.
> +	 * SPI bus will be released in sysconfig_lsc_burst_complete().
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
> +static int sysconfig_bitstream_burst_write(struct sysconfig_priv *priv,
> +					   const char *buf, size_t count)

Add spi prefix

> +{
> +	struct spi_device *spi = to_spi_device(priv->dev);
> +	struct spi_transfer xfer = {
> +		.tx_buf = buf,
> +		.len = count,
> +		.cs_change = 1,
> +	};
> +	struct spi_message msg;
> +	int ret;
> +
> +	if (!spi)
> +		return -ENODEV;
> +
> +	spi_message_init_with_transfers(&msg, &xfer, 1);
> +	ret = spi_sync_locked(spi, &msg);
> +	if (ret)
> +		spi_bus_unlock(spi->controller);

The sysconfig_spi don't have to assume the sysconfig core driver will
register an fpga_manager. It is possible the core driver uses these
callback for MTD ops?

So the burst operations don't have to be strictly aligned with
fpga_manager_ops->write_init/write/write_complete.

Maybe the logic in core driver could be more generic, like:

  if (burst_init())
	fail;

  if (burst_write()) {
	burst_complete();
	fail;
  }

  burst_complete();

So I think you don't have to unlock bus here, let burst_complete do it.

> +
> +	return ret;
> +}
> +
> +static int sysconfig_lsc_burst_complete(struct sysconfig_priv *priv)

Add spi prefix

> +{
> +	struct spi_device *spi = to_spi_device(priv->dev);
> +
> +	if (!spi)
> +		return -ENODEV;
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
> +	const struct sysconfig_fpga_priv *fpga_priv;
> +	const struct spi_device_id *dev_id;
> +	struct device *dev = &spi->dev;
> +	struct sysconfig_priv *priv;
> +
> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	fpga_priv = of_device_get_match_data(dev);
> +	if (!fpga_priv) {
> +		dev_id = spi_get_device_id(spi);
> +		if (!dev_id)
> +			return -ENODEV;
> +
> +		fpga_priv = (const struct sysconfig_fpga_priv *)dev_id->driver_data;
> +	}
> +
> +	if (!fpga_priv)
> +		return -EINVAL;
> +
> +	if (spi->max_speed_hz > fpga_priv->spi_max_speed_hz) {
> +		dev_err(dev, "SPI speed %u is too high, maximum speed is %u\n",
> +			spi->max_speed_hz, fpga_priv->spi_max_speed_hz);
> +		return -EINVAL;
> +	}
> +
> +	priv->dev = dev;
> +	priv->fpga_priv = fpga_priv;
> +	priv->command_write = sysconfig_spi_cmd_write;
> +	priv->command_write_with_data = sysconfig_spi_cmd_write_with_data;
> +	priv->command_write_then_read = sysconfig_spi_cmd_write_then_read;
> +	priv->bitstream_burst_write_init = sysconfig_lsc_burst_init;
> +	priv->bitstream_burst_write = sysconfig_bitstream_burst_write;
> +	priv->bitstream_burst_write_complete = sysconfig_lsc_burst_complete;
> +
> +	return sysconfig_probe(priv);
> +}
> +
> +static const struct spi_device_id sysconfig_spi_ids[] = {
> +	{
> +		.name = "ecp5-fpga-mgr",

I assume sysconfig could do more than fpga-manager, like detailed flash
management maybe a name not specific to fpga-mgr.

> +		.driver_data = (kernel_ulong_t)&ecp5_data,
> +	}, {
> +		.name = "machxo2-fpga-mgr",
> +		.driver_data = (kernel_ulong_t)&machxo2_data,
> +	}, {},
> +};
> +MODULE_DEVICE_TABLE(spi, sysconfig_spi_ids);
> +
> +#if IS_ENABLED(CONFIG_OF)
> +static const struct of_device_id sysconfig_of_ids[] = {
> +	{
> +		.compatible = "lattice,ecp5-fpga-mgr",
> +		.data = &ecp5_data,
> +	}, {
> +		.compatible = "lattice,machxo2-fpga-mgr",
> +		.data = &machxo2_data,
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
> +
> +module_spi_driver(lattice_sysconfig_driver);
> +
> +MODULE_DESCRIPTION("Lattice sysCONFIG Slave SPI FPGA Manager");
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/fpga/sysconfig.c b/drivers/fpga/sysconfig.c
> new file mode 100644
> index 000000000000..453dd6f6bf30
> --- /dev/null
> +++ b/drivers/fpga/sysconfig.c
> @@ -0,0 +1,520 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Lattice FPGA sysCONFIG interface functions independent of port type.
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/fpga/fpga-mgr.h>
> +#include <linux/gpio/consumer.h>
> +
> +#include "sysconfig.h"
> +
> +const struct sysconfig_fpga_priv ecp5_data = {
> +	.spi_max_speed_hz = 60000000,

Again, don't put spi stuff in core driver, embedded it in
sysconfig_spi.c.

> +	.isc_enable_operand = 0x00,
> +	.burst_write = true,

Just query, from spec I see we must use burst_write for SRAM
configuration. Is it specific to ecp5 or mandatory to all other boards,
why we cannot configure SRAM by page write?

> +	.internal_flash = false,

On reviewing the machxo2 patches, I think reprogramming flash should not
be implemented by fpga manager, there are existing solutions for fine
flash control. So maybe we don't have to support flash reprogramming
here.

But SRAM configuration from flash could be a feature supported by fpga
manager, we don't have code now, this could be another topic.

Thanks,
Yilun

> +};
> +
> +const struct sysconfig_fpga_priv machxo2_data = {
> +	.spi_max_speed_hz = 66000000,
> +	.isc_enable_operand = 0x08,
> +	.burst_write = false,
> +	.internal_flash = true,
> +};
> +
> +static int sysconfig_cmd_write(struct sysconfig_priv *priv, const void *buf,
> +			       size_t buf_len)
> +{
> +	return priv->command_write(priv, buf, buf_len);
> +}
> +
> +static int sysconfig_cmd_write_with_data(struct sysconfig_priv *priv,
> +					 const void *cmd, size_t cmd_len,
> +					 const void *data, size_t data_len)
> +{
> +	return priv->command_write_with_data(priv, cmd, cmd_len, data, data_len);
> +}
> +
> +static int sysconfig_cmd_write_then_read(struct sysconfig_priv *priv,
> +					 const void *tx_buf, size_t tx_len,
> +					 void *rx_buf, size_t rx_len)
> +{
> +	return priv->command_write_then_read(priv, tx_buf, tx_len, rx_buf, rx_len);
> +}
> +
> +static int sysconfig_read_busy(struct sysconfig_priv *priv)
> +{
> +	const u8 lsc_check_busy[] = SYSCONFIG_LSC_CHECK_BUSY;
> +	u8 busy;
> +	int ret;
> +
> +	ret = sysconfig_cmd_write_then_read(priv, lsc_check_busy,
> +					    sizeof(lsc_check_busy),
> +					    &busy, sizeof(busy));
> +
> +	return ret ? : busy;
> +}
> +
> +static int sysconfig_poll_busy(struct sysconfig_priv *priv)
> +{
> +	size_t retries = SYSCONFIG_POLL_RETRIES;
> +	int ret;
> +
> +	while (retries--) {
> +		ret = sysconfig_read_busy(priv);
> +		if (ret <= 0)
> +			return ret;
> +
> +		usleep_range(SYSCONFIG_POLL_INTERVAL_US,
> +			     SYSCONFIG_POLL_INTERVAL_US * 2);
> +	}
> +
> +	return -EBUSY;
> +}
> +
> +static int sysconfig_read_status(struct sysconfig_priv *priv, u32 *status)
> +{
> +	const u8 lsc_read_status[] = SYSCONFIG_LSC_READ_STATUS;
> +	__be32 device_status;
> +	int ret;
> +
> +	ret = sysconfig_cmd_write_then_read(priv, lsc_read_status,
> +					    sizeof(lsc_read_status),
> +					    &device_status,
> +					    sizeof(device_status));
> +	if (ret)
> +		return ret;
> +
> +	*status = be32_to_cpu(device_status);
> +
> +	return 0;
> +}
> +
> +static int sysconfig_poll_status(struct sysconfig_priv *priv, u32 *status)
> +{
> +	int ret = sysconfig_poll_busy(priv);
> +
> +	if (ret)
> +		return ret;
> +
> +	return sysconfig_read_status(priv, status);
> +}
> +
> +static int sysconfig_poll_gpio(struct gpio_desc *gpio, bool is_active)
> +{
> +	size_t retries = SYSCONFIG_POLL_RETRIES;
> +	int value;
> +
> +	while (retries--) {
> +		value = gpiod_get_value(gpio);
> +		if (value < 0)
> +			return value;
> +
> +		if ((is_active && value) || (!is_active && !value))
> +			return 0;
> +	}
> +
> +	return -ETIMEDOUT;
> +}
> +
> +static int sysconfig_gpio_refresh(struct sysconfig_priv *priv)
> +{
> +	struct gpio_desc *program = priv->program;
> +	struct gpio_desc *init = priv->init;
> +	struct gpio_desc *done = priv->done;
> +	int ret;
> +
> +	/* Enter init mode */
> +	gpiod_set_value(program, 1);
> +
> +	ret = sysconfig_poll_gpio(init, true);
> +	if (!ret)
> +		ret = sysconfig_poll_gpio(done, false);
> +
> +	if (ret)
> +		return ret;
> +
> +	/* Enter program mode */
> +	gpiod_set_value(program, 0);
> +
> +	return sysconfig_poll_gpio(init, false);
> +}
> +
> +static int sysconfig_lsc_refresh(struct sysconfig_priv *priv)
> +{
> +	static const u8 lsc_refresh[] = SYSCONFIG_LSC_REFRESH;
> +	int ret;
> +
> +	ret = sysconfig_cmd_write(priv, lsc_refresh, sizeof(lsc_refresh));
> +	if (ret)
> +		return ret;
> +
> +	usleep_range(4000, 8000);
> +
> +	return 0;
> +}
> +
> +static int sysconfig_refresh(struct sysconfig_priv *priv)
> +{
> +	struct gpio_desc *program = priv->program;
> +	struct gpio_desc *init = priv->init;
> +	struct gpio_desc *done = priv->done;
> +
> +	if (program && init && done)
> +		return sysconfig_gpio_refresh(priv);
> +
> +	return sysconfig_lsc_refresh(priv);
> +}
> +
> +static int sysconfig_isc_enable(struct sysconfig_priv *priv)
> +{
> +	const struct sysconfig_fpga_priv *fpga_priv = priv->fpga_priv;
> +	u8 isc_enable[] = SYSCONFIG_ISC_ENABLE;
> +	u32 status;
> +	int ret;
> +
> +	isc_enable[1] = fpga_priv->isc_enable_operand;
> +
> +	ret = sysconfig_cmd_write(priv, isc_enable, sizeof(isc_enable));
> +	if (ret)
> +		return ret;
> +
> +	ret = sysconfig_poll_status(priv, &status);
> +	if (ret || (status & SYSCONFIG_STATUS_FAIL))
> +		return ret ? : -EFAULT;
> +
> +	return 0;
> +}
> +
> +static int sysconfig_isc_erase(struct sysconfig_priv *priv)
> +{
> +	const struct sysconfig_fpga_priv *fpga_priv = priv->fpga_priv;
> +	u8 isc_erase[] = SYSCONFIG_ISC_ERASE;
> +	u32 status;
> +	int ret;
> +
> +	isc_erase[1] = SYSCONFIG_ISC_ERASE_SRAM;
> +
> +	if (fpga_priv->internal_flash)
> +		isc_erase[1] |= SYSCONFIG_ISC_ERASE_FLASH;
> +
> +	ret = sysconfig_cmd_write(priv, isc_erase, sizeof(isc_erase));
> +	if (ret)
> +		return ret;
> +
> +	ret = sysconfig_poll_status(priv, &status);
> +	if (ret || (status & SYSCONFIG_STATUS_FAIL))
> +		return ret ? : -EFAULT;
> +
> +	return 0;
> +}
> +
> +static int sysconfig_isc_init(struct sysconfig_priv *priv)
> +{
> +	int ret = sysconfig_isc_enable(priv);
> +
> +	if (ret)
> +		return ret;
> +
> +	return sysconfig_isc_erase(priv);
> +}
> +
> +static int sysconfig_lsc_init_addr(struct sysconfig_priv *priv)
> +{
> +	const u8 lsc_init_addr[] = SYSCONFIG_LSC_INIT_ADDR;
> +
> +	return sysconfig_cmd_write(priv, lsc_init_addr, sizeof(lsc_init_addr));
> +}
> +
> +static int sysconfig_burst_write_init(struct sysconfig_priv *priv)
> +{
> +	if (priv->bitstream_burst_write_init)
> +		return priv->bitstream_burst_write_init(priv);
> +
> +	return 0;
> +}
> +
> +static int sysconfig_bitstream_burst_write(struct sysconfig_priv *priv,
> +					   const char *buf, size_t count)
> +{
> +	return priv->bitstream_burst_write(priv, buf, count);
> +}
> +
> +static int sysconfig_bitstream_paged_write(struct sysconfig_priv *priv,
> +					   const char *buf, size_t count)
> +{
> +	const u8 lsc_progincr[] = SYSCONFIG_LSC_PROG_INCR_NV;
> +	size_t i;
> +	int ret;
> +
> +	if (count % SYSCONFIG_PAGE_SIZE)
> +		return -EINVAL;
> +
> +	for (i = 0; i < count; i += SYSCONFIG_PAGE_SIZE) {
> +		ret = sysconfig_cmd_write_with_data(priv, lsc_progincr,
> +						    sizeof(lsc_progincr),
> +						    buf + i, SYSCONFIG_PAGE_SIZE);
> +		if (!ret)
> +			ret = sysconfig_poll_busy(priv);
> +
> +		if (ret)
> +			break;
> +	}
> +
> +	return ret;
> +}
> +
> +static int sysconfig_burst_write_complete(struct sysconfig_priv *priv)
> +{
> +	if (priv->bitstream_burst_write_complete)
> +		return priv->bitstream_burst_write_complete(priv);
> +
> +	return 0;
> +}
> +
> +static int sysconfig_isc_prog_done(struct sysconfig_priv *priv)
> +{
> +	const u8 isc_prog_done[] = SYSCONFIG_ISC_PROGRAM_DONE;
> +	u32 status;
> +	int ret;
> +
> +	ret = sysconfig_cmd_write(priv, isc_prog_done, sizeof(isc_prog_done));
> +	if (ret)
> +		return ret;
> +
> +	ret = sysconfig_poll_status(priv, &status);
> +	if (ret)
> +		return ret;
> +
> +	if (status & SYSCONFIG_STATUS_DONE)
> +		return 0;
> +
> +	return -EFAULT;
> +}
> +
> +static int sysconfig_isc_disable(struct sysconfig_priv *priv)
> +{
> +	const u8 isc_disable[] = SYSCONFIG_ISC_DISABLE;
> +
> +	return sysconfig_cmd_write(priv, isc_disable, sizeof(isc_disable));
> +}
> +
> +static void sysconfig_cleanup(struct sysconfig_priv *priv)
> +{
> +	sysconfig_isc_erase(priv);
> +	sysconfig_refresh(priv);
> +}
> +
> +static int sysconfig_isc_finish(struct sysconfig_priv *priv)
> +{
> +	const struct sysconfig_fpga_priv *fpga_priv = priv->fpga_priv;
> +	int ret, retries = SYSCONFIG_REFRESH_RETRIES;
> +	struct gpio_desc *done_gpio = priv->done;
> +	u32 status;
> +
> +	if (done_gpio) {
> +		ret = sysconfig_isc_disable(priv);
> +		if (ret)
> +			return ret;
> +
> +		return sysconfig_poll_gpio(done_gpio, true);
> +	}
> +
> +	while (retries--) {
> +		ret = sysconfig_poll_status(priv, &status);
> +		if (ret)
> +			break;
> +
> +		if ((status & SYSCONFIG_STATUS_DONE) &&
> +		    !(status & SYSCONFIG_STATUS_BUSY) &&
> +		    !(status & SYSCONFIG_STATUS_ERR)) {
> +			return sysconfig_isc_disable(priv);
> +		}
> +
> +		if (fpga_priv->internal_flash) {
> +			ret = sysconfig_refresh(priv);
> +			if (ret)
> +				break;
> +		}
> +	}
> +
> +	return -EFAULT;
> +}
> +
> +static enum fpga_mgr_states sysconfig_ops_state(struct fpga_manager *mgr)
> +{
> +	struct sysconfig_priv *priv = mgr->priv;
> +	struct gpio_desc *done = priv->done;
> +	u32 status;
> +	int ret;
> +
> +	if (done && (gpiod_get_value(done) > 0))
> +		return FPGA_MGR_STATE_OPERATING;
> +
> +	ret = sysconfig_read_status(priv, &status);
> +	if (!ret && (status & SYSCONFIG_STATUS_DONE))
> +		return FPGA_MGR_STATE_OPERATING;
> +
> +	return FPGA_MGR_STATE_UNKNOWN;
> +}
> +
> +static int sysconfig_ops_write_init(struct fpga_manager *mgr,
> +				    struct fpga_image_info *info,
> +				    const char *buf, size_t count)
> +{
> +	const struct sysconfig_fpga_priv *fpga_priv;
> +	struct sysconfig_priv *priv;
> +	struct device *dev;
> +	int ret;
> +
> +	dev = &mgr->dev;
> +	priv = mgr->priv;
> +	fpga_priv = priv->fpga_priv;
> +
> +	if (info->flags & FPGA_MGR_PARTIAL_RECONFIG) {
> +		dev_err(dev, "Partial reconfiguration is not supported\n");
> +		return -EOPNOTSUPP;
> +	}
> +
> +	if (!fpga_priv->internal_flash) {
> +		/* Write directly to SRAM */
> +		ret = sysconfig_refresh(priv);
> +		if (ret) {
> +			dev_err(dev, "Failed to go to program mode\n");
> +			return ret;
> +		}
> +	}
> +
> +	/* Enter ISC mode */
> +	ret = sysconfig_isc_init(priv);
> +	if (ret) {
> +		dev_err(dev, "Failed to go to ISC mode\n");
> +		return ret;
> +	}
> +
> +	/* Initialize the Address Shift Register */
> +	ret = sysconfig_lsc_init_addr(priv);
> +	if (ret) {
> +		dev_err(dev,
> +			"Failed to initialize the Address Shift Register\n");
> +		return ret;
> +	}
> +
> +	if (fpga_priv->burst_write) {
> +		/* Prepare for bitstream burst write */
> +		ret = sysconfig_burst_write_init(priv);
> +		if (ret)
> +			dev_err(dev,
> +				"Failed to prepare for bitstream burst write\n");
> +	}
> +
> +	return ret;
> +}
> +
> +static int sysconfig_ops_write(struct fpga_manager *mgr, const char *buf,
> +			       size_t count)
> +{
> +	const struct sysconfig_fpga_priv *fpga_priv;
> +	struct sysconfig_priv *priv;
> +
> +	priv = mgr->priv;
> +	fpga_priv = priv->fpga_priv;
> +
> +	if (fpga_priv->burst_write)
> +		return sysconfig_bitstream_burst_write(priv, buf, count);
> +
> +	return sysconfig_bitstream_paged_write(priv, buf, count);
> +}
> +
> +static int sysconfig_ops_write_complete(struct fpga_manager *mgr,
> +					struct fpga_image_info *info)
> +{
> +	const struct sysconfig_fpga_priv *fpga_priv;
> +	struct sysconfig_priv *priv;
> +	struct device *dev;
> +	int ret;
> +
> +	dev = &mgr->dev;
> +	priv = mgr->priv;
> +	fpga_priv = priv->fpga_priv;
> +
> +	if (fpga_priv->burst_write) {
> +		ret = sysconfig_burst_write_complete(priv);
> +		if (!ret)
> +			ret = sysconfig_poll_busy(priv);
> +
> +		if (ret) {
> +			dev_err(dev,
> +				"Error while waiting bitstream write to finish\n");
> +			goto fail;
> +		}
> +	}
> +
> +	if (fpga_priv->internal_flash) {
> +		ret = sysconfig_isc_prog_done(priv);
> +		if (!ret)
> +			ret = sysconfig_refresh(priv);
> +
> +		if (ret) {
> +			dev_err(dev, "Failed to enable Self-Download Mode\n");
> +			goto fail;
> +		}
> +	}
> +
> +	ret = sysconfig_isc_finish(priv);
> +
> +fail:
> +	if (ret)
> +		sysconfig_cleanup(priv);
> +
> +	return ret;
> +}
> +
> +static const struct fpga_manager_ops sysconfig_fpga_mgr_ops = {
> +	.state = sysconfig_ops_state,
> +	.write_init = sysconfig_ops_write_init,
> +	.write = sysconfig_ops_write,
> +	.write_complete = sysconfig_ops_write_complete,
> +};
> +
> +int sysconfig_probe(struct sysconfig_priv *priv)
> +{
> +	struct gpio_desc *program, *init, *done;
> +	struct device *dev = priv->dev;
> +	struct fpga_manager *mgr;
> +	int ret;
> +
> +	if (!dev)
> +		return -ENODEV;
> +
> +	program = devm_gpiod_get_optional(dev, "program", GPIOD_OUT_LOW);
> +	if (IS_ERR(program)) {
> +		ret = PTR_ERR(program);
> +		dev_err(dev, "Failed to get PROGRAM GPIO: %d\n", ret);
> +		return ret;
> +	}
> +
> +	init = devm_gpiod_get_optional(dev, "init", GPIOD_IN);
> +	if (IS_ERR(init)) {
> +		ret = PTR_ERR(init);
> +		dev_err(dev, "Failed to get INIT GPIO: %d\n", ret);
> +		return ret;
> +	}
> +
> +	done = devm_gpiod_get_optional(dev, "done", GPIOD_IN);
> +	if (IS_ERR(done)) {
> +		ret = PTR_ERR(done);
> +		dev_err(dev, "Failed to get DONE GPIO: %d\n", ret);
> +		return ret;
> +	}
> +
> +	priv->program = program;
> +	priv->init = init;
> +	priv->done = done;
> +
> +	mgr = devm_fpga_mgr_register(dev, "Lattice sysCONFIG FPGA Manager",
> +				     &sysconfig_fpga_mgr_ops, priv);
> +
> +	return PTR_ERR_OR_ZERO(mgr);
> +}
> diff --git a/drivers/fpga/sysconfig.h b/drivers/fpga/sysconfig.h
> new file mode 100644
> index 000000000000..770228feccaf
> --- /dev/null
> +++ b/drivers/fpga/sysconfig.h
> @@ -0,0 +1,63 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#ifndef	__LATTICE_SYSCONFIG_H
> +#define	__LATTICE_SYSCONFIG_H
> +
> +#define	SYSCONFIG_ISC_ENABLE		{0xC6, 0x00, 0x00, 0x00}
> +#define	SYSCONFIG_ISC_DISABLE		{0x26, 0x00, 0x00, 0x00}
> +#define	SYSCONFIG_ISC_ERASE		{0x0E, 0x00, 0x00, 0x00}
> +#define	SYSCONFIG_ISC_PROGRAM_DONE	{0x5E, 0x00, 0x00, 0x00}
> +#define	SYSCONFIG_LSC_READ_STATUS	{0x3C, 0x00, 0x00, 0x00}
> +#define	SYSCONFIG_LSC_CHECK_BUSY	{0xF0, 0x00, 0x00, 0x00}
> +#define	SYSCONFIG_LSC_REFRESH		{0x79, 0x00, 0x00, 0x00}
> +#define	SYSCONFIG_LSC_INIT_ADDR		{0x46, 0x00, 0x00, 0x00}
> +#define	SYSCONFIG_LSC_BITSTREAM_BURST	{0x7a, 0x00, 0x00, 0x00}
> +#define	SYSCONFIG_LSC_PROG_INCR_NV	{0x70, 0x00, 0x00, 0x01}
> +
> +#define	SYSCONFIG_ISC_ERASE_SRAM	BIT(0)
> +#define	SYSCONFIG_ISC_ERASE_FLASH	BIT(2)
> +
> +#define	SYSCONFIG_STATUS_DONE		BIT(8)
> +#define	SYSCONFIG_STATUS_BUSY		BIT(12)
> +#define	SYSCONFIG_STATUS_FAIL		BIT(13)
> +#define	SYSCONFIG_STATUS_ERR		(BIT(23) | BIT(24) | BIT(25))
> +
> +#define	SYSCONFIG_REFRESH_RETRIES	16
> +#define	SYSCONFIG_POLL_RETRIES		1000000
> +#define	SYSCONFIG_POLL_INTERVAL_US	30
> +
> +#define	SYSCONFIG_PAGE_SIZE		16
> +
> +struct sysconfig_fpga_priv {
> +	u32 spi_max_speed_hz;
> +	u8 isc_enable_operand;
> +	bool burst_write;
> +	bool internal_flash;
> +};
> +
> +extern const struct sysconfig_fpga_priv ecp5_data;
> +extern const struct sysconfig_fpga_priv machxo2_data;
> +
> +struct sysconfig_priv {
> +	const struct sysconfig_fpga_priv *fpga_priv;
> +	struct gpio_desc *program;
> +	struct gpio_desc *init;
> +	struct gpio_desc *done;
> +	struct device *dev;
> +	int (*command_write)(struct sysconfig_priv *priv,
> +			     const void *tx_buf, size_t tx_len);
> +	int (*command_write_with_data)(struct sysconfig_priv *priv,
> +				       const void *cmd_buf, size_t cmd_len,
> +				       const void *data_buf, size_t data_len);
> +	int (*command_write_then_read)(struct sysconfig_priv *priv,
> +				       const void *tx_buf, size_t tx_len,
> +				       void *rx_buf, size_t rx_len);
> +	int (*bitstream_burst_write_init)(struct sysconfig_priv *priv);
> +	int (*bitstream_burst_write)(struct sysconfig_priv *priv,
> +				     const char *tx_buf, size_t tx_len);
> +	int (*bitstream_burst_write_complete)(struct sysconfig_priv *priv);
> +};
> +
> +int sysconfig_probe(struct sysconfig_priv *priv);
> +
> +#endif /* __LATTICE_SYSCONFIG_H */
> -- 
> 2.37.2
> 
> 
