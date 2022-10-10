Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11CEB5F9F9B
	for <lists+linux-fpga@lfdr.de>; Mon, 10 Oct 2022 15:45:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbiJJNnU (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 10 Oct 2022 09:43:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbiJJNnS (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 10 Oct 2022 09:43:18 -0400
Received: from mail.pr-group.ru (mail.pr-group.ru [178.18.215.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7308E72ED4;
        Mon, 10 Oct 2022 06:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
        d=metrotek.ru; s=mail;
        h=from:subject:date:message-id:to:cc:mime-version:content-type:in-reply-to:
         references;
        bh=LhcfvSknTQDPeHJp+YBOLS1HJuq3qgDZKjNDaSrfP8w=;
        b=R8INfu3SXebC2w8qTfuuVNKmC2e+OoyvmAcsXFwLy5VNcGSmxsFJvDF08a/Rh0xgCLsPgvJNctTAv
         IXW4i72u6ZSqDWZylbxTOFVDYRhFWVusZP/84LDv9awTThybiA8WSfVcyC2Z4Soo1tACbJyEJfzZHT
         DtzR6v5KnkfrTsPo0IRUugJr21OfeZyCml1jw8YufFmsi8u1yvMLT8SUnZ/3jraZiQRZFNAmX91Psz
         3N5PUnBw8dyBMN+LEPPrX/GGFAmATIkRTZShPkGYMzroroMOKT5QCT3CO+lHXYMKVTCB5pyBwcP1gG
         YWmhQuHkKsPM4v7LmikQIhWIkusYguw==
X-Kerio-Anti-Spam:  Build: [Engines: 2.16.4.1445, Stamp: 3], Multi: [Enabled, t: (0.000014,0.068510)], BW: [Enabled, t: (0.000014,0.000001)], RTDA: [Enabled, t: (0.074672), Hit: No, Details: v2.42.0; Id: 15.52k2r8.1gf124r5u.a4oa; mclb], total: 0(700)
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLACK autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: 
X-Footer: bWV0cm90ZWsucnU=
Received: from x260 ([92.100.86.33])
        (authenticated user i.bornyakov@metrotek.ru)
        by mail.pr-group.ru with ESMTPSA
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits));
        Mon, 10 Oct 2022 16:42:55 +0300
Date:   Mon, 10 Oct 2022 16:14:48 +0300
From:   Ivan Bornyakov <i.bornyakov@metrotek.ru>
To:     Xu Yilun <yilun.xu@intel.com>
Cc:     mdf@kernel.org, hao.wu@intel.com, trix@redhat.com, dg@emlix.com,
        j.zink@pengutronix.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        Ivan Bornyakov <brnkv.i1@gmail.com>,
        linux-fpga@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        system@metrotek.ru
Subject: Re: [PATCH v15 1/2] fpga: lattice-sysconfig-spi: add Lattice
 sysCONFIG FPGA manager
Message-ID: <20221010131448.tbkjt6zi27yhme2s@x260>
References: <20221008111419.21245-1-i.bornyakov@metrotek.ru>
 <20221008111419.21245-2-i.bornyakov@metrotek.ru>
 <Y0PYj59rLT/Yrdlg@yilunxu-OptiPlex-7050>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y0PYj59rLT/Yrdlg@yilunxu-OptiPlex-7050>
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Mon, Oct 10, 2022 at 04:32:15PM +0800, Xu Yilun wrote:
> On 2022-10-08 at 14:14:18 +0300, Ivan Bornyakov wrote:
> > Add support to the FPGA manager for programming Lattice ECP5 FPGA over
> > slave SPI sysCONFIG interface.
> > 
> > sysCONFIG interface core functionality is separate from both ECP5 and
> > SPI specifics, so support for other FPGAs with different port types can
> > be added in the future.
> > 
> > Signed-off-by: Ivan Bornyakov <i.bornyakov@metrotek.ru>
> > ---
> >  drivers/fpga/Kconfig                 |  11 +
> >  drivers/fpga/Makefile                |   2 +
> >  drivers/fpga/lattice-sysconfig-spi.c | 151 ++++++++++
> >  drivers/fpga/lattice-sysconfig.c     | 425 +++++++++++++++++++++++++++
> >  drivers/fpga/lattice-sysconfig.h     |  42 +++
> >  5 files changed, 631 insertions(+)
> >  create mode 100644 drivers/fpga/lattice-sysconfig-spi.c
> >  create mode 100644 drivers/fpga/lattice-sysconfig.c
> >  create mode 100644 drivers/fpga/lattice-sysconfig.h
> > 
> > diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
> > index 6c416955da53..d1a8107fdcb3 100644
> > --- a/drivers/fpga/Kconfig
> > +++ b/drivers/fpga/Kconfig
> > @@ -263,4 +263,15 @@ config FPGA_MGR_MICROCHIP_SPI
> >  	  programming over slave SPI interface with .dat formatted
> >  	  bitstream image.
> >  
> > +config FPGA_MGR_LATTICE_SYSCONFIG
> > +	tristate
> > +
> > +config FPGA_MGR_LATTICE_SYSCONFIG_SPI
> > +	tristate "Lattice sysCONFIG SPI FPGA manager"
> > +	depends on SPI
> > +	select FPGA_MGR_LATTICE_SYSCONFIG
> > +	help
> > +	  FPGA manager driver support for Lattice FPGAs programming over slave
> > +	  SPI sysCONFIG interface.
> > +
> >  endif # FPGA
> > diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
> > index 42ae8b58abce..72e554b4d2f7 100644
> > --- a/drivers/fpga/Makefile
> > +++ b/drivers/fpga/Makefile
> > @@ -20,6 +20,8 @@ obj-$(CONFIG_FPGA_MGR_ZYNQ_FPGA)	+= zynq-fpga.o
> >  obj-$(CONFIG_FPGA_MGR_ZYNQMP_FPGA)	+= zynqmp-fpga.o
> >  obj-$(CONFIG_FPGA_MGR_VERSAL_FPGA)	+= versal-fpga.o
> >  obj-$(CONFIG_FPGA_MGR_MICROCHIP_SPI)	+= microchip-spi.o
> > +obj-$(CONFIG_FPGA_MGR_LATTICE_SYSCONFIG)	+= lattice-sysconfig.o
> > +obj-$(CONFIG_FPGA_MGR_LATTICE_SYSCONFIG_SPI)	+= lattice-sysconfig-spi.o
> >  obj-$(CONFIG_ALTERA_PR_IP_CORE)		+= altera-pr-ip-core.o
> >  obj-$(CONFIG_ALTERA_PR_IP_CORE_PLAT)	+= altera-pr-ip-core-plat.o
> >  
> > diff --git a/drivers/fpga/lattice-sysconfig-spi.c b/drivers/fpga/lattice-sysconfig-spi.c
> > new file mode 100644
> > index 000000000000..94be802f19ce
> > --- /dev/null
> > +++ b/drivers/fpga/lattice-sysconfig-spi.c
> > @@ -0,0 +1,151 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Lattice FPGA programming over slave SPI sysCONFIG interface.
> > + */
> > +
> > +#include <linux/spi/spi.h>
> > +
> > +#include "lattice-sysconfig.h"
> > +
> > +static const u32 ecp5_spi_max_speed_hz = 60000000;
> > +
> > +static int sysconfig_spi_cmd_write(struct sysconfig_priv *priv)
> > +{
> > +	struct spi_device *spi = to_spi_device(priv->dev);
> > +
> > +	return spi_write(spi, priv->cmd_tx_buf, SYSCONFIG_CMD_SIZE);
> > +}
> > +
> > +static int sysconfig_spi_cmd_read(struct sysconfig_priv *priv, size_t rx_len)
> > +{
> > +	struct spi_device *spi = to_spi_device(priv->dev);
> > +
> > +	return spi_write_then_read(spi, priv->cmd_tx_buf, SYSCONFIG_CMD_SIZE,
> > +				   priv->cmd_rx_buf,
> > +				   min(rx_len, (size_t)SYSCONFIG_CMD_SIZE));
> 
> Should we fail out if rx_len > SYSCONFIG_CMD_SIZE?
> 
> And the readback data would be no more than 4 bytes for all commands?
> Seems not the case according to ECP5 spec.
> 

So far we use LSC_CHECK_BUSY command with 1 byte readback and
LSC_READ_STATUS command with 4 bytes readback.

There is commands with more than 4 bytes readback, tho.

> > +}
> > +
> > +static int sysconfig_spi_bitstream_burst_init(struct sysconfig_priv *priv)
> > +{
> > +	const u8 lsc_bitstream_burst[] = SYSCONFIG_LSC_BITSTREAM_BURST;
> > +	struct spi_device *spi = to_spi_device(priv->dev);
> > +	struct spi_transfer xfer = {
> > +		.tx_buf = priv->cmd_tx_buf,
> > +		.len = SYSCONFIG_CMD_SIZE,
> > +		.cs_change = 1,
> > +	};
> > +	struct spi_message msg;
> > +	int ret;
> > +
> > +	memcpy(priv->cmd_tx_buf, lsc_bitstream_burst, SYSCONFIG_CMD_SIZE);
> > +	spi_message_init_with_transfers(&msg, &xfer, 1);
> > +
> > +	/*
> > +	 * Lock SPI bus for exclusive usage until FPGA programming is done.
> > +	 * SPI bus will be released in sysconfig_spi_bitstream_burst_complete().
> > +	 */
> > +	spi_bus_lock(spi->controller);
> > +
> > +	ret = spi_sync_locked(spi, &msg);
> > +	if (ret)
> > +		spi_bus_unlock(spi->controller);
> > +
> > +	return ret;
> > +}
> > +
> > +static int sysconfig_spi_bitstream_burst_write(struct sysconfig_priv *priv,
> > +					       const char *buf, size_t len)
> > +{
> > +	struct spi_device *spi = to_spi_device(priv->dev);
> > +	struct spi_transfer xfer = {
> > +		.tx_buf = buf,
> > +		.len = len,
> > +		.cs_change = 1,
> > +	};
> > +	struct spi_message msg;
> > +
> > +	spi_message_init_with_transfers(&msg, &xfer, 1);
> > +
> > +	return spi_sync_locked(spi, &msg);
> > +}
> > +
> > +static int sysconfig_spi_bitstream_burst_complete(struct sysconfig_priv *priv)
> > +{
> > +	struct spi_device *spi = to_spi_device(priv->dev);
> > +
> > +	/* Bitstream burst write is done, release SPI bus */
> > +	spi_bus_unlock(spi->controller);
> > +
> > +	/* Toggle CS to finish bitstream write */
> > +	return spi_write(spi, NULL, 0);
> > +}
> > +
> > +static int sysconfig_spi_probe(struct spi_device *spi)
> > +{
> > +	const struct spi_device_id *dev_id;
> > +	struct device *dev = &spi->dev;
> > +	struct sysconfig_priv *priv;
> > +	const u32 *spi_max_speed;
> > +
> > +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> 
> Study from dma-api-howto.rst, the main concern for stack buffer is the
> cache-align problem. But buffer from devm_kzalloc doesn't guarantee cache
> alignment, so priv->cmd_tx_buf is still not dma safe.
> 
> > +	if (!priv)
> > +		return -ENOMEM;
> > +
> > +	spi_max_speed = device_get_match_data(dev);
> > +	if (!spi_max_speed) {
> > +		dev_id = spi_get_device_id(spi);
> > +		if (!dev_id)
> > +			return -ENODEV;
> > +
> > +		spi_max_speed = (const u32 *)dev_id->driver_data;
> > +	}
> > +
> > +	if (!spi_max_speed)
> > +		return -EINVAL;
> > +
> > +	if (spi->max_speed_hz > *spi_max_speed) {
> > +		dev_err(dev, "SPI speed %u is too high, maximum speed is %u\n",
> > +			spi->max_speed_hz, *spi_max_speed);
> > +		return -EINVAL;
> > +	}
> > +
> > +	priv->dev = dev;
> > +	priv->command_write = sysconfig_spi_cmd_write;
> > +	priv->command_read = sysconfig_spi_cmd_read;
> > +	priv->bitstream_burst_write_init = sysconfig_spi_bitstream_burst_init;
> > +	priv->bitstream_burst_write = sysconfig_spi_bitstream_burst_write;
> > +	priv->bitstream_burst_write_complete = sysconfig_spi_bitstream_burst_complete;
> > +
> > +	return sysconfig_probe(priv);
> > +}
> > +
> > +static const struct spi_device_id sysconfig_spi_ids[] = {
> > +	{
> > +		.name = "sysconfig-ecp5",
> > +		.driver_data = (kernel_ulong_t)&ecp5_spi_max_speed_hz,
> > +	}, {},
> > +};
> > +MODULE_DEVICE_TABLE(spi, sysconfig_spi_ids);
> > +
> > +#if IS_ENABLED(CONFIG_OF)
> > +static const struct of_device_id sysconfig_of_ids[] = {
> > +	{
> > +		.compatible = "lattice,sysconfig-ecp5",
> > +		.data = &ecp5_spi_max_speed_hz,
> > +	}, {},
> > +};
> > +MODULE_DEVICE_TABLE(of, sysconfig_of_ids);
> > +#endif /* IS_ENABLED(CONFIG_OF) */
> > +
> > +static struct spi_driver lattice_sysconfig_driver = {
> > +	.probe = sysconfig_spi_probe,
> > +	.id_table = sysconfig_spi_ids,
> > +	.driver = {
> > +		.name = "lattice_sysconfig_spi_fpga_mgr",
> > +		.of_match_table = of_match_ptr(sysconfig_of_ids),
> > +	},
> > +};
> > +module_spi_driver(lattice_sysconfig_driver);
> > +
> > +MODULE_DESCRIPTION("Lattice sysCONFIG Slave SPI FPGA Manager");
> > +MODULE_LICENSE("GPL");
> > diff --git a/drivers/fpga/lattice-sysconfig.c b/drivers/fpga/lattice-sysconfig.c
> > new file mode 100644
> > index 000000000000..086eb80b5f33
> > --- /dev/null
> > +++ b/drivers/fpga/lattice-sysconfig.c
> > @@ -0,0 +1,425 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Lattice FPGA sysCONFIG interface functions independent of port type.
> > + */
> > +
> > +#include <linux/delay.h>
> > +#include <linux/fpga/fpga-mgr.h>
> > +#include <linux/gpio/consumer.h>
> > +
> > +#include "lattice-sysconfig.h"
> > +
> > +static int sysconfig_cmd_write(struct sysconfig_priv *priv)
> > +{
> > +	return priv->command_write(priv);
> > +}
> > +
> > +static int sysconfig_cmd_read(struct sysconfig_priv *priv, size_t rx_len)
> > +{
> > +	return priv->command_read(priv, rx_len);
> > +}
> > +
> > +static int sysconfig_poll_busy(struct sysconfig_priv *priv)
> > +{
> > +	const u8 lsc_check_busy[] = SYSCONFIG_LSC_CHECK_BUSY;
> > +	unsigned long timeout;
> > +	int ret;
> > +
> > +	memcpy(priv->cmd_tx_buf, lsc_check_busy, SYSCONFIG_CMD_SIZE);
> 
> Is the memcpy needed for all buses, or for all callback?

Documentation/i2c/dma-considerations.rst says that it is not mandatory
that the buffer of an I2C message is DMA safe, however, it is
recomended.

> At least no need for spi_write_then_read, is it?.

Yes, you're right, spi_write_then_read() copies data to its
pre-allocated buffer. I've mislooked that.

> Maybe let the specific bus driver decide,
> and don't touch the cmd_tx/rx_buf in core driver, or even move these temp
> buffers out of common sysconfig_priv.
> 
> > +	timeout = jiffies + msecs_to_jiffies(SYSCONFIG_POLL_BUSY_TIMEOUT_MS);
> > +
> > +	while (time_before(jiffies, timeout)) {
> > +		ret = sysconfig_cmd_read(priv, 1);
> > +		if (ret)
> > +			return ret;
> > +
> > +		if (!priv->cmd_rx_buf[0])
> > +			return 0;
> > +
> > +		usleep_range(SYSCONFIG_POLL_INTERVAL_US,
> > +			     SYSCONFIG_POLL_INTERVAL_US * 2);
> > +	}
> > +
> > +	return -ETIMEDOUT;
> > +}
> > +
> > +static int sysconfig_read_status(struct sysconfig_priv *priv, u32 *status)
> > +{
> > +	const u8 lsc_read_status[] = SYSCONFIG_LSC_READ_STATUS;
> > +	int ret;
> > +
> > +	memcpy(priv->cmd_tx_buf, lsc_read_status, SYSCONFIG_CMD_SIZE);
> > +	ret = sysconfig_cmd_read(priv, SYSCONFIG_CMD_SIZE);
> > +	if (ret)
> > +		return ret;
> > +
> > +	*status = be32_to_cpup((__be32 *)priv->cmd_rx_buf);
> > +
> > +	return 0;
> > +}
> > +
> > +static int sysconfig_poll_status(struct sysconfig_priv *priv, u32 *status)
> > +{
> > +	int ret = sysconfig_poll_busy(priv);
> > +
> > +	if (ret)
> > +		return ret;
> > +
> > +	return sysconfig_read_status(priv, status);
> > +}
> > +
> > +static int sysconfig_poll_gpio(struct gpio_desc *gpio, bool is_active)
> > +{
> > +	unsigned long timeout;
> > +	int value;
> > +
> > +	timeout = jiffies + msecs_to_jiffies(SYSCONFIG_POLL_GPIO_TIMEOUT_MS);
> > +
> > +	while (time_before(jiffies, timeout)) {
> > +		value = gpiod_get_value(gpio);
> > +		if (value < 0)
> > +			return value;
> > +
> > +		if ((is_active && value) || (!is_active && !value))
> > +			return 0;
> > +
> > +		usleep_range(SYSCONFIG_POLL_INTERVAL_US,
> > +			     SYSCONFIG_POLL_INTERVAL_US * 2);
> > +	}
> > +
> > +	return -ETIMEDOUT;
> > +}
> > +
> > +static int sysconfig_gpio_refresh(struct sysconfig_priv *priv)
> > +{
> > +	struct gpio_desc *program = priv->program;
> > +	struct gpio_desc *init = priv->init;
> > +	struct gpio_desc *done = priv->done;
> > +	int ret;
> > +
> > +	/* Enter init mode */
> > +	gpiod_set_value(program, 1);
> > +
> > +	ret = sysconfig_poll_gpio(init, true);
> > +	if (!ret)
> > +		ret = sysconfig_poll_gpio(done, false);
> > +
> > +	if (ret)
> > +		return ret;
> > +
> > +	/* Enter program mode */
> > +	gpiod_set_value(program, 0);
> > +
> > +	return sysconfig_poll_gpio(init, false);
> > +}
> > +
> > +static int sysconfig_lsc_refresh(struct sysconfig_priv *priv)
> > +{
> > +	static const u8 lsc_refresh[] = SYSCONFIG_LSC_REFRESH;
> > +	int ret;
> > +
> > +	memcpy(priv->cmd_tx_buf, lsc_refresh, SYSCONFIG_CMD_SIZE);
> > +	ret = sysconfig_cmd_write(priv);
> > +	if (ret)
> > +		return ret;
> > +
> > +	usleep_range(4000, 8000);
> > +
> > +	return 0;
> > +}
> > +
> > +static int sysconfig_refresh(struct sysconfig_priv *priv)
> > +{
> > +	struct gpio_desc *program = priv->program;
> > +	struct gpio_desc *init = priv->init;
> > +	struct gpio_desc *done = priv->done;
> > +
> > +	if (program && init && done)
> > +		return sysconfig_gpio_refresh(priv);
> > +
> > +	return sysconfig_lsc_refresh(priv);
> > +}
> > +
> > +static int sysconfig_isc_enable(struct sysconfig_priv *priv)
> > +{
> > +	u8 isc_enable[] = SYSCONFIG_ISC_ENABLE;
> > +	u32 status;
> > +	int ret;
> > +
> > +	memcpy(priv->cmd_tx_buf, isc_enable, SYSCONFIG_CMD_SIZE);
> > +	ret = sysconfig_cmd_write(priv);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = sysconfig_poll_status(priv, &status);
> > +	if (ret)
> > +		return ret;
> > +
> > +	if (status & SYSCONFIG_STATUS_FAIL)
> > +		return -EFAULT;
> > +
> > +	return 0;
> > +}
> > +
> > +static int sysconfig_isc_erase(struct sysconfig_priv *priv)
> > +{
> > +	u8 isc_erase[] = SYSCONFIG_ISC_ERASE;
> > +	u32 status;
> > +	int ret;
> > +
> > +	memcpy(priv->cmd_tx_buf, isc_erase, SYSCONFIG_CMD_SIZE);
> > +	ret = sysconfig_cmd_write(priv);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = sysconfig_poll_status(priv, &status);
> > +	if (ret)
> > +		return ret;
> > +
> > +	if (status & SYSCONFIG_STATUS_FAIL)
> > +		return -EFAULT;
> > +
> > +	return 0;
> > +}
> > +
> > +static int sysconfig_isc_init(struct sysconfig_priv *priv)
> > +{
> > +	int ret = sysconfig_isc_enable(priv);
> > +
> > +	if (ret)
> > +		return ret;
> > +
> > +	return sysconfig_isc_erase(priv);
> > +}
> > +
> > +static int sysconfig_lsc_init_addr(struct sysconfig_priv *priv)
> > +{
> > +	const u8 lsc_init_addr[] = SYSCONFIG_LSC_INIT_ADDR;
> > +
> > +	memcpy(priv->cmd_tx_buf, lsc_init_addr, SYSCONFIG_CMD_SIZE);
> > +
> > +	return sysconfig_cmd_write(priv);
> > +}
> > +
> > +static int sysconfig_burst_write_init(struct sysconfig_priv *priv)
> > +{
> > +	return priv->bitstream_burst_write_init(priv);
> > +}
> > +
> > +static int sysconfig_burst_write_complete(struct sysconfig_priv *priv)
> > +{
> > +	return priv->bitstream_burst_write_complete(priv);
> > +}
> > +
> > +static int sysconfig_bitstream_burst_write(struct sysconfig_priv *priv,
> > +					   const char *buf, size_t count)
> > +{
> > +	int ret = priv->bitstream_burst_write(priv, buf, count);
> > +
> > +	if (ret)
> > +		sysconfig_burst_write_complete(priv);
> > +
> > +	return ret;
> > +}
> > +
> > +static int sysconfig_isc_disable(struct sysconfig_priv *priv)
> > +{
> > +	const u8 isc_disable[] = SYSCONFIG_ISC_DISABLE;
> > +
> > +	memcpy(priv->cmd_tx_buf, isc_disable, SYSCONFIG_CMD_SIZE);
> > +
> > +	return sysconfig_cmd_write(priv);
> > +}
> > +
> > +static void sysconfig_cleanup(struct sysconfig_priv *priv)
> > +{
> > +	sysconfig_isc_erase(priv);
> > +	sysconfig_refresh(priv);
> > +}
> > +
> > +static int sysconfig_isc_finish(struct sysconfig_priv *priv)
> > +{
> > +	struct gpio_desc *done_gpio = priv->done;
> > +	u32 status;
> > +	int ret;
> > +
> > +	if (done_gpio) {
> > +		ret = sysconfig_isc_disable(priv);
> > +		if (ret)
> > +			return ret;
> > +
> > +		return sysconfig_poll_gpio(done_gpio, true);
> > +	}
> > +
> > +	ret = sysconfig_poll_status(priv, &status);
> > +	if (ret)
> > +		return ret;
> > +
> > +	if ((status & SYSCONFIG_STATUS_DONE) &&
> > +	    !(status & SYSCONFIG_STATUS_BUSY) &&
> > +	    !(status & SYSCONFIG_STATUS_ERR))
> > +		return sysconfig_isc_disable(priv);
> > +
> > +	return -EFAULT;
> > +}
> > +
> > +static enum fpga_mgr_states sysconfig_ops_state(struct fpga_manager *mgr)
> > +{
> > +	struct sysconfig_priv *priv = mgr->priv;
> > +	struct gpio_desc *done = priv->done;
> > +	u32 status;
> > +	int ret;
> > +
> > +	if (done && (gpiod_get_value(done) > 0))
> > +		return FPGA_MGR_STATE_OPERATING;
> > +
> > +	ret = sysconfig_read_status(priv, &status);
> > +	if (!ret && (status & SYSCONFIG_STATUS_DONE))
> > +		return FPGA_MGR_STATE_OPERATING;
> > +
> > +	return FPGA_MGR_STATE_UNKNOWN;
> > +}
> > +
> > +static int sysconfig_ops_write_init(struct fpga_manager *mgr,
> > +				    struct fpga_image_info *info,
> > +				    const char *buf, size_t count)
> > +{
> > +	struct sysconfig_priv *priv = mgr->priv;
> > +	struct device *dev = &mgr->dev;
> > +	int ret;
> > +
> > +	if (info->flags & FPGA_MGR_PARTIAL_RECONFIG) {
> > +		dev_err(dev, "Partial reconfiguration is not supported\n");
> > +		return -EOPNOTSUPP;
> > +	}
> > +
> > +	/* Enter program mode */
> > +	ret = sysconfig_refresh(priv);
> > +	if (ret) {
> > +		dev_err(dev, "Failed to go to program mode\n");
> > +		return ret;
> > +	}
> > +
> > +	/* Enter ISC mode */
> > +	ret = sysconfig_isc_init(priv);
> > +	if (ret) {
> > +		dev_err(dev, "Failed to go to ISC mode\n");
> > +		return ret;
> > +	}
> > +
> > +	/* Initialize the Address Shift Register */
> > +	ret = sysconfig_lsc_init_addr(priv);
> > +	if (ret) {
> > +		dev_err(dev,
> > +			"Failed to initialize the Address Shift Register\n");
> > +		return ret;
> > +	}
> > +
> > +	/* Prepare for bitstream burst write */
> > +	ret = sysconfig_burst_write_init(priv);
> > +	if (ret)
> > +		dev_err(dev, "Failed to prepare for bitstream burst write\n");
> > +
> > +	return ret;
> > +}
> > +
> > +static int sysconfig_ops_write(struct fpga_manager *mgr, const char *buf,
> > +			       size_t count)
> > +{
> > +	return sysconfig_bitstream_burst_write(mgr->priv, buf, count);
> > +}
> > +
> > +static int sysconfig_ops_write_complete(struct fpga_manager *mgr,
> > +					struct fpga_image_info *info)
> > +{
> > +	struct sysconfig_priv *priv = mgr->priv;
> > +	struct device *dev = &mgr->dev;
> > +	int ret;
> > +
> > +	ret = sysconfig_burst_write_complete(priv);
> > +	if (!ret)
> > +		ret = sysconfig_poll_busy(priv);
> > +
> > +	if (ret) {
> > +		dev_err(dev, "Error while waiting bitstream write to finish\n");
> > +		goto fail;
> > +	}
> > +
> > +	ret = sysconfig_isc_finish(priv);
> > +
> > +fail:
> > +	if (ret)
> > +		sysconfig_cleanup(priv);
> > +
> > +	return ret;
> > +}
> > +
> > +static const struct fpga_manager_ops sysconfig_fpga_mgr_ops = {
> > +	.state = sysconfig_ops_state,
> > +	.write_init = sysconfig_ops_write_init,
> > +	.write = sysconfig_ops_write,
> > +	.write_complete = sysconfig_ops_write_complete,
> > +};
> > +
> > +int sysconfig_probe(struct sysconfig_priv *priv)
> > +{
> > +	struct gpio_desc *program, *init, *done;
> > +	struct device *dev = priv->dev;
> > +	struct fpga_manager *mgr;
> > +	int ret;
> > +
> > +	if (!dev)
> > +		return -ENODEV;
> > +
> > +	if (!priv->bitstream_burst_write_init) {
> > +		dev_err(dev,
> > +			"Callback for preparation for bitstream burst write is not defined\n");
> > +		return -EOPNOTSUPP;
> > +	}
> > +
> > +	if (!priv->bitstream_burst_write) {
> > +		dev_err(dev,
> > +			"Callback for bitstream burst write is not defined\n");
> > +		return -EOPNOTSUPP;
> > +	}
> > +
> > +	if (!priv->bitstream_burst_write_complete) {
> > +		dev_err(dev,
> > +			"Callback for finishing bitstream burst write is not defined\n");
> > +		return -EOPNOTSUPP;
> > +	}
> > +
> > +	program = devm_gpiod_get_optional(dev, "program", GPIOD_OUT_LOW);
> > +	if (IS_ERR(program)) {
> > +		ret = PTR_ERR(program);
> > +		dev_err(dev, "Failed to get PROGRAM GPIO: %d\n", ret);
> > +		return ret;
> > +	}
> > +
> > +	init = devm_gpiod_get_optional(dev, "init", GPIOD_IN);
> > +	if (IS_ERR(init)) {
> > +		ret = PTR_ERR(init);
> > +		dev_err(dev, "Failed to get INIT GPIO: %d\n", ret);
> > +		return ret;
> > +	}
> > +
> > +	done = devm_gpiod_get_optional(dev, "done", GPIOD_IN);
> > +	if (IS_ERR(done)) {
> > +		ret = PTR_ERR(done);
> > +		dev_err(dev, "Failed to get DONE GPIO: %d\n", ret);
> > +		return ret;
> > +	}
> > +
> > +	priv->program = program;
> > +	priv->init = init;
> > +	priv->done = done;
> > +
> > +	mgr = devm_fpga_mgr_register(dev, "Lattice sysCONFIG FPGA Manager",
> > +				     &sysconfig_fpga_mgr_ops, priv);
> > +
> > +	return PTR_ERR_OR_ZERO(mgr);
> > +}
> > +EXPORT_SYMBOL(sysconfig_probe);
> > +
> > +MODULE_DESCRIPTION("Lattice sysCONFIG FPGA Manager Core");
> > +MODULE_LICENSE("GPL");
> > diff --git a/drivers/fpga/lattice-sysconfig.h b/drivers/fpga/lattice-sysconfig.h
> > new file mode 100644
> > index 000000000000..5332c46aa809
> > --- /dev/null
> > +++ b/drivers/fpga/lattice-sysconfig.h
> > @@ -0,0 +1,42 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +
> > +#ifndef	__LATTICE_SYSCONFIG_H
> > +#define	__LATTICE_SYSCONFIG_H
> > +
> > +#define	SYSCONFIG_ISC_ENABLE		{0xC6, 0x00, 0x00, 0x00}
> > +#define	SYSCONFIG_ISC_DISABLE		{0x26, 0x00, 0x00, 0x00}
> > +#define	SYSCONFIG_ISC_ERASE		{0x0E, 0x01, 0x00, 0x00}
> > +#define	SYSCONFIG_LSC_READ_STATUS	{0x3C, 0x00, 0x00, 0x00}
> > +#define	SYSCONFIG_LSC_CHECK_BUSY	{0xF0, 0x00, 0x00, 0x00}
> > +#define	SYSCONFIG_LSC_REFRESH		{0x79, 0x00, 0x00, 0x00}
> > +#define	SYSCONFIG_LSC_INIT_ADDR		{0x46, 0x00, 0x00, 0x00}
> > +#define	SYSCONFIG_LSC_BITSTREAM_BURST	{0x7a, 0x00, 0x00, 0x00}
> > +#define	SYSCONFIG_CMD_SIZE		4
> > +
> > +#define	SYSCONFIG_STATUS_DONE		BIT(8)
> > +#define	SYSCONFIG_STATUS_BUSY		BIT(12)
> > +#define	SYSCONFIG_STATUS_FAIL		BIT(13)
> > +#define	SYSCONFIG_STATUS_ERR		GENMASK(25, 23)
> > +
> > +#define	SYSCONFIG_POLL_INTERVAL_US	30
> > +#define	SYSCONFIG_POLL_BUSY_TIMEOUT_MS	1000
> > +#define	SYSCONFIG_POLL_GPIO_TIMEOUT_MS	100
> > +
> > +struct sysconfig_priv {
> > +	struct gpio_desc *program;
> > +	struct gpio_desc *init;
> > +	struct gpio_desc *done;
> > +	struct device *dev;
> > +	int (*command_write)(struct sysconfig_priv *priv);
> > +	int (*command_read)(struct sysconfig_priv *priv, size_t rx_len);
> > +	int (*bitstream_burst_write_init)(struct sysconfig_priv *priv);
> > +	int (*bitstream_burst_write)(struct sysconfig_priv *priv,
> > +				     const char *tx_buf, size_t tx_len);
> > +	int (*bitstream_burst_write_complete)(struct sysconfig_priv *priv);
> > +	u8 cmd_tx_buf[SYSCONFIG_CMD_SIZE];
> > +	u8 cmd_rx_buf[SYSCONFIG_CMD_SIZE];
> 
> I'm pretty sure the buffer (*priv) from kmalloc is cache aligned,
> but is priv->cmd_tx_buf still cache aligned?
> 

I guess ____cacheline_aligned should help to ensure that

> Thanks,
> Yilun
> 
> > +};
> > +
> > +int sysconfig_probe(struct sysconfig_priv *priv);
> > +
> > +#endif /* __LATTICE_SYSCONFIG_H */
> > -- 
> > 2.35.1
> > 
> > 

