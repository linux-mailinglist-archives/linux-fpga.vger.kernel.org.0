Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8480C595320
	for <lists+linux-fpga@lfdr.de>; Tue, 16 Aug 2022 08:56:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231280AbiHPGyu (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 16 Aug 2022 02:54:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbiHPGyT (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 16 Aug 2022 02:54:19 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C1D1109743;
        Mon, 15 Aug 2022 19:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660615789; x=1692151789;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+bzxfDJ5jmZfEPUMVMNi2m4Go8FDE/fAmruYSl2IrtA=;
  b=euQwqTS20VZvr8EuWEvFuz+BgJF4Js0DMKR0SnD603/3BWIJDI6fGSj2
   O4JYjmrSpgD926s8q02uiiFevMr+QVRGfX7bBbym74Fcgz2vQPPa+T5y0
   hsQlf7MJK6DrGnAJK05Ge+4LDr2yXF/eSuOpCBaGfc6XdS6B8F7uh7g3e
   gYVUZyQp+IQTIwYCnim4BqYPcayUfp3G5xU6cBWzBaqflNFmDaDx0hKmo
   iwSTwu88FiLyPmMYpiOuoBGl/gfbut/Y6ROA7q1sIZ1bGD/MBUqQssXTW
   oeks1NQvQwDzrFIU55SX9yKW7VB6wa8kiiQmvtiY28aoiW7ErpqdEQ7u5
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10440"; a="289673282"
X-IronPort-AV: E=Sophos;i="5.93,239,1654585200"; 
   d="scan'208";a="289673282"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2022 19:09:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,240,1654585200"; 
   d="scan'208";a="666900513"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmsmga008.fm.intel.com with ESMTP; 15 Aug 2022 19:09:45 -0700
Date:   Tue, 16 Aug 2022 10:00:41 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Ivan Bornyakov <i.bornyakov@metrotek.ru>
Cc:     mdf@kernel.org, hao.wu@intel.com, trix@redhat.com, dg@emlix.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-fpga@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, system@metrotek.ru
Subject: Re: [PATCH v6 1/2] fpga: ecp5-spi: add Lattice ECP5 FPGA manager
Message-ID: <Yvr6SY5WGXlYiLig@yilunxu-OptiPlex-7050>
References: <20220815132157.8083-1-i.bornyakov@metrotek.ru>
 <20220815132157.8083-2-i.bornyakov@metrotek.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220815132157.8083-2-i.bornyakov@metrotek.ru>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 2022-08-15 at 16:21:56 +0300, Ivan Bornyakov wrote:
> Add support to the FPGA manager for programming Lattice ECP5 FPGA over
> slave SPI interface with .bit formatted uncompressed bitstream image.

Not sure if something is missed.

https://lore.kernel.org/all/20220729145757.GA2601292@yilunxu-OptiPlex-7050/

I was considering if a generic driver for lattice slave SPI sysCONFIG
interface could be introduced. From machxo2 & ecp5 Programming Usage
Guide, or others in this series, they basically use the same reconfigure
interface & protocol.

Thanks,
Yilun

> 
> Signed-off-by: Ivan Bornyakov <i.bornyakov@metrotek.ru>
> ---
>  drivers/fpga/Kconfig    |   7 +
>  drivers/fpga/Makefile   |   1 +
>  drivers/fpga/ecp5-spi.c | 311 ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 319 insertions(+)
>  create mode 100644 drivers/fpga/ecp5-spi.c
> 
> diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
> index 6c416955da53..920277a08ed9 100644
> --- a/drivers/fpga/Kconfig
> +++ b/drivers/fpga/Kconfig
> @@ -263,4 +263,11 @@ config FPGA_MGR_MICROCHIP_SPI
>  	  programming over slave SPI interface with .dat formatted
>  	  bitstream image.
>  
> +config FPGA_MGR_ECP5_SPI
> +	tristate "Lattice ECP5 SPI FPGA manager"
> +	depends on SPI
> +	help
> +	  FPGA manager driver support for Lattice ECP5 programming over slave
> +	  SPI interface with .bit formatted uncompressed bitstream image.
> +
>  endif # FPGA
> diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
> index 42ae8b58abce..17c7a3c4b385 100644
> --- a/drivers/fpga/Makefile
> +++ b/drivers/fpga/Makefile
> @@ -20,6 +20,7 @@ obj-$(CONFIG_FPGA_MGR_ZYNQ_FPGA)	+= zynq-fpga.o
>  obj-$(CONFIG_FPGA_MGR_ZYNQMP_FPGA)	+= zynqmp-fpga.o
>  obj-$(CONFIG_FPGA_MGR_VERSAL_FPGA)	+= versal-fpga.o
>  obj-$(CONFIG_FPGA_MGR_MICROCHIP_SPI)	+= microchip-spi.o
> +obj-$(CONFIG_FPGA_MGR_ECP5_SPI)		+= ecp5-spi.o
>  obj-$(CONFIG_ALTERA_PR_IP_CORE)		+= altera-pr-ip-core.o
>  obj-$(CONFIG_ALTERA_PR_IP_CORE_PLAT)	+= altera-pr-ip-core-plat.o
>  
> diff --git a/drivers/fpga/ecp5-spi.c b/drivers/fpga/ecp5-spi.c
> new file mode 100644
> index 000000000000..aa0dd10823a3
> --- /dev/null
> +++ b/drivers/fpga/ecp5-spi.c
> @@ -0,0 +1,311 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Lattice ECP5 FPGA programming over slave SPI interface.
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/fpga/fpga-mgr.h>
> +#include <linux/spi/spi.h>
> +
> +#define	ECP5_SPI_MAX_SPEED_HZ		60000000
> +
> +#define	ECP5_SPI_ISC_ENABLE		{0xC6, 0x00, 0x00, 0x00}
> +#define	ECP5_SPI_ISC_DISABLE		{0x26, 0x00, 0x00, 0x00}
> +#define	ECP5_SPI_ISC_ERASE		{0x0E, 0x01, 0x00, 0x00}
> +#define	ECP5_SPI_LSC_INIT_ADDR		{0x46, 0x00, 0x00, 0x00}
> +#define	ECP5_SPI_LSC_BITSTREAM_BURST	{0x7a, 0x00, 0x00, 0x00}
> +#define	ECP5_SPI_LSC_CHECK_BUSY		{0xF0, 0x00, 0x00, 0x00}
> +
> +#define ECP5_POLL_RETRIES		100000
> +
> +struct ecp5_priv {
> +	struct gpio_desc *program;
> +	struct gpio_desc *init;
> +	struct gpio_desc *done;
> +	struct spi_device *spi;
> +};
> +
> +static enum fpga_mgr_states ecp5_ops_state(struct fpga_manager *mgr)
> +{
> +	struct ecp5_priv *priv = mgr->priv;
> +
> +	return gpiod_get_value(priv->done) ? FPGA_MGR_STATE_OPERATING :
> +					     FPGA_MGR_STATE_UNKNOWN;
> +}
> +
> +static int ecp5_poll_busy(struct spi_device *spi)
> +{
> +	const u8 lsc_check_busy[] = ECP5_SPI_LSC_CHECK_BUSY;
> +	int ret, retries = ECP5_POLL_RETRIES;
> +	struct spi_transfer xfers[2] = { 0 };
> +	struct spi_message msg;
> +	u8 busy;
> +
> +	xfers[0].tx_buf = lsc_check_busy;
> +	xfers[0].len = sizeof(lsc_check_busy);
> +	xfers[1].rx_buf = &busy;
> +	xfers[1].len = sizeof(busy);
> +
> +	while (retries--) {
> +		spi_message_init_with_transfers(&msg, xfers, ARRAY_SIZE(xfers));
> +		ret = spi_sync_locked(spi, &msg);
> +		if (ret)
> +			return ret;
> +
> +		if (!busy)
> +			return 0;
> +
> +		usleep_range(50, 100);
> +	}
> +
> +	return -EBUSY;
> +}
> +
> +static int ecp5_poll_gpio(struct gpio_desc *gpio, bool is_active)
> +{
> +	int value, retries = ECP5_POLL_RETRIES;
> +
> +	while (retries--) {
> +		value = gpiod_get_value(gpio);
> +		if (value < 0)
> +			return value;
> +
> +		if ((!is_active && !value) || (is_active && value))
> +			return 0;
> +
> +		ndelay(10);
> +	}
> +
> +	return -EFAULT;
> +}
> +
> +static int ecp5_ops_write_init(struct fpga_manager *mgr,
> +			       struct fpga_image_info *info,
> +			       const char *buf, size_t count)
> +{
> +	const u8 lsc_bitstream_burst[] = ECP5_SPI_LSC_BITSTREAM_BURST;
> +	const u8 lsc_init_addr[] = ECP5_SPI_LSC_INIT_ADDR;
> +	const u8 isc_enable[] = ECP5_SPI_ISC_ENABLE;
> +	const u8 isc_erase[] = ECP5_SPI_ISC_ERASE;
> +	struct ecp5_priv *priv = mgr->priv;
> +	struct spi_device *spi = priv->spi;
> +	struct device *dev = &mgr->dev;
> +	struct spi_transfer isc_xfers[] = {
> +		{
> +			.tx_buf = isc_enable,
> +			.len = sizeof(isc_enable),
> +			.cs_change = 1,
> +		}, {
> +			.tx_buf = isc_erase,
> +			.len = sizeof(isc_erase),
> +		},
> +	};
> +	struct spi_transfer lsc_xfers[] = {
> +		{
> +			.tx_buf = lsc_init_addr,
> +			.len = sizeof(lsc_init_addr),
> +			.cs_change = 1,
> +		}, {
> +			.tx_buf = lsc_bitstream_burst,
> +			.len = sizeof(lsc_bitstream_burst),
> +			.cs_change = 1,
> +		},
> +	};
> +	struct spi_message msg;
> +	int ret;
> +
> +	if (info->flags & FPGA_MGR_PARTIAL_RECONFIG) {
> +		dev_err(dev, "Partial reconfiguration is not supported\n");
> +		return -EOPNOTSUPP;
> +	}
> +
> +	/* Enter init mode */
> +	gpiod_set_value(priv->program, 1);
> +
> +	ret = ecp5_poll_gpio(priv->init, true);
> +	if (!ret)
> +		ret = ecp5_poll_gpio(priv->done, false);
> +
> +	if (ret) {
> +		dev_err(dev, "Failed to go to initialization mode\n");
> +		return ret;
> +	}
> +
> +	/* Enter program mode */
> +	gpiod_set_value(priv->program, 0);
> +
> +	ret = ecp5_poll_gpio(priv->init, false);
> +	if (ret) {
> +		dev_err(dev, "Failed to go to program mode\n");
> +		return ret;
> +	}
> +
> +	/*
> +	 * Lock SPI bus for exclusive usage until FPGA programming is done.
> +	 * SPI bus will be released in ecp5_ops_write_complete() or on error.
> +	 */
> +	spi_bus_lock(spi->controller);
> +
> +	/* Enter ISC mode */
> +	spi_message_init_with_transfers(&msg, isc_xfers, ARRAY_SIZE(isc_xfers));
> +	ret = spi_sync_locked(spi, &msg);
> +	if (!ret)
> +		ret = ecp5_poll_busy(spi);
> +
> +	if (ret) {
> +		dev_err(dev, "Failed to go to ISC mode\n");
> +		goto out;
> +	}
> +
> +	/* Prepare for bitstream burst write */
> +	spi_message_init_with_transfers(&msg, lsc_xfers, ARRAY_SIZE(lsc_xfers));
> +	ret = spi_sync_locked(spi, &msg);
> +	if (ret)
> +		dev_err(dev, "Failed to prepare for bitstream burst write\n");
> +
> +out:
> +	if (ret)
> +		spi_bus_unlock(spi->controller);
> +
> +	return ret;
> +}
> +
> +static int ecp5_ops_write(struct fpga_manager *mgr, const char *buf, size_t count)
> +{
> +	struct ecp5_priv *priv = mgr->priv;
> +	struct spi_device *spi = priv->spi;
> +	struct spi_transfer xfer = {
> +		.tx_buf = buf,
> +		.len = count,
> +		.cs_change = 1,
> +	};
> +	struct spi_message msg;
> +	int ret;
> +
> +	spi_message_init_with_transfers(&msg, &xfer, 1);
> +	ret = spi_sync_locked(spi, &msg);
> +	if (ret)
> +		spi_bus_unlock(spi->controller);
> +
> +	return ret;
> +}
> +
> +static int ecp5_ops_write_complete(struct fpga_manager *mgr,
> +				   struct fpga_image_info *info)
> +{
> +	const u8 isc_disable[] = ECP5_SPI_ISC_DISABLE;
> +	struct ecp5_priv *priv = mgr->priv;
> +	struct spi_device *spi = priv->spi;
> +	struct spi_transfer xfer = { 0 };
> +	struct device *dev = &mgr->dev;
> +	struct spi_message msg;
> +	int ret;
> +
> +	/* Toggle CS and wait for bitstream write to finish */
> +	spi_message_init_with_transfers(&msg, &xfer, 1);
> +	ret = spi_sync_locked(spi, &msg);
> +	if (!ret)
> +		ret = ecp5_poll_busy(spi);
> +
> +	if (ret) {
> +		dev_err(dev, "Error while waiting bitstream write to finish\n");
> +		goto out;
> +	}
> +
> +	/* Exit ISC mode */
> +	xfer.tx_buf = isc_disable;
> +	xfer.len = sizeof(isc_disable);
> +	spi_message_init_with_transfers(&msg, &xfer, 1);
> +	ret = spi_sync_locked(spi, &msg);
> +	if (!ret)
> +		ret = ecp5_poll_gpio(priv->done, true);
> +
> +	if (ret)
> +		dev_err(dev, "Failed to finish ISC\n");
> +
> +out:
> +	spi_bus_unlock(spi->controller);
> +
> +	return ret;
> +}
> +
> +static const struct fpga_manager_ops ecp5_fpga_ops = {
> +	.state = ecp5_ops_state,
> +	.write_init = ecp5_ops_write_init,
> +	.write = ecp5_ops_write,
> +	.write_complete = ecp5_ops_write_complete,
> +};
> +
> +static int ecp5_probe(struct spi_device *spi)
> +{
> +	struct device *dev = &spi->dev;
> +	struct fpga_manager *mgr;
> +	struct ecp5_priv *priv;
> +	int ret;
> +
> +	if (spi->max_speed_hz > ECP5_SPI_MAX_SPEED_HZ) {
> +		dev_err(dev, "SPI speed %u is too high, maximum speed is %u\n",
> +			spi->max_speed_hz, ECP5_SPI_MAX_SPEED_HZ);
> +		return -EINVAL;
> +	}
> +
> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	priv->spi = spi;
> +
> +	priv->done = devm_gpiod_get(dev, "done", GPIOD_IN);
> +	if (IS_ERR(priv->done)) {
> +		ret = PTR_ERR(priv->done);
> +		dev_err(dev, "Failed to get DONE GPIO: %d\n", ret);
> +		return ret;
> +	}
> +
> +	priv->init = devm_gpiod_get(dev, "init", GPIOD_IN);
> +	if (IS_ERR(priv->init)) {
> +		ret = PTR_ERR(priv->init);
> +		dev_err(dev, "Failed to get INIT GPIO: %d\n", ret);
> +		return ret;
> +	}
> +
> +	priv->program = devm_gpiod_get(dev, "program", GPIOD_OUT_LOW);
> +	if (IS_ERR(priv->program)) {
> +		ret = PTR_ERR(priv->program);
> +		dev_err(dev, "Failed to get PROGRAM GPIO: %d\n", ret);
> +		return ret;
> +	}
> +
> +	mgr = devm_fpga_mgr_register(dev, "Lattice ECP5 SPI FPGA Manager",
> +				     &ecp5_fpga_ops, priv);
> +
> +	return PTR_ERR_OR_ZERO(mgr);
> +}
> +
> +static const struct spi_device_id ecp5_spi_ids[] = {
> +	{ .name = "ecp5-fpga-mgr" },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(spi, ecp5_spi_ids);
> +
> +#if IS_ENABLED(CONFIG_OF)
> +static const struct of_device_id ecp5_of_ids[] = {
> +	{ .compatible = "lattice,ecp5-fpga-mgr" },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, ecp5_of_ids);
> +#endif /* IS_ENABLED(CONFIG_OF) */
> +
> +static struct spi_driver ecp5_driver = {
> +	.probe = ecp5_probe,
> +	.id_table = ecp5_spi_ids,
> +	.driver = {
> +		.name = "lattice_ecp5_spi_fpga_mgr",
> +		.of_match_table = of_match_ptr(ecp5_of_ids),
> +	},
> +};
> +
> +module_spi_driver(ecp5_driver);
> +
> +MODULE_DESCRIPTION("Lattice ECP5 SPI FPGA Manager");
> +MODULE_LICENSE("GPL");
> -- 
> 2.37.1
> 
> 
