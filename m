Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E40445BC1A1
	for <lists+linux-fpga@lfdr.de>; Mon, 19 Sep 2022 05:07:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbiISDGI (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 18 Sep 2022 23:06:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiISDGF (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sun, 18 Sep 2022 23:06:05 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E22617E28;
        Sun, 18 Sep 2022 20:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663556763; x=1695092763;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8eQN0+j8J1gNYWE59T8AG8ZCYP4nMvzve1PVx1wP5ak=;
  b=VTD3MrR9tZI2cgquOOUXICm2MRQc2bssIQghCjbG2N7c3xmy12biYCER
   h+3as5A0Lno6U3xRsmz+E7j323UfxxV8HodaQV7LQYKp360DivaMjDD9S
   oZVSlaFZ9uEOe5ewbA6sXN971NTuZ8v+TuFWt34Fijo7mnZGrBwdAjPaC
   7n5gVm3wmWeqSD344W1AAHxo63/sjmCjW+HO+sespkFk3xrGhsj6HXrmU
   bz+1pi2YRtJQfjqEAfsNy6kdEG0i1zjbfCphhrG7O6MlgCmdHHGLxvZYE
   MCq6Bjz9ofu9IYLa6WwJyewFzZw4pTIRjnFzsPkqkxnD5OE4qsMm48bsU
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10474"; a="286337498"
X-IronPort-AV: E=Sophos;i="5.93,325,1654585200"; 
   d="scan'208";a="286337498"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2022 20:06:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,325,1654585200"; 
   d="scan'208";a="947039659"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmsmga005.fm.intel.com with ESMTP; 18 Sep 2022 20:05:59 -0700
Date:   Mon, 19 Sep 2022 10:56:20 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Ivan Bornyakov <i.bornyakov@metrotek.ru>
Cc:     mdf@kernel.org, hao.wu@intel.com, trix@redhat.com, dg@emlix.com,
        j.zink@pengutronix.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-fpga@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, system@metrotek.ru
Subject: Re: [PATCH v11 1/2] fpga: lattice-sysconfig-spi: add Lattice
 sysCONFIG FPGA manager
Message-ID: <YyfaVPkJIMGfAJpl@yilunxu-OptiPlex-7050>
References: <20220913130714.31404-1-i.bornyakov@metrotek.ru>
 <20220913130714.31404-2-i.bornyakov@metrotek.ru>
 <YySuBCiufhrUuK1q@yilunxu-OptiPlex-7050>
 <20220916182745.dq7b4xgsyljder6k@x260>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220916182745.dq7b4xgsyljder6k@x260>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 2022-09-16 at 21:27:45 +0300, Ivan Bornyakov wrote:
> On Sat, Sep 17, 2022 at 01:10:28AM +0800, Xu Yilun wrote:
> > On 2022-09-13 at 16:07:13 +0300, Ivan Bornyakov wrote:
> > > Add support to the FPGA manager for programming Lattice ECP5 and MachXO2
> > > FPGAs over slave SPI sysCONFIG interface.
> > > 
> > > Signed-off-by: Ivan Bornyakov <i.bornyakov@metrotek.ru>
> > > ---
> > >  drivers/fpga/Kconfig         |   7 +
> > >  drivers/fpga/Makefile        |   3 +
> > >  drivers/fpga/sysconfig-spi.c | 210 ++++++++++++++
> > >  drivers/fpga/sysconfig.c     | 528 +++++++++++++++++++++++++++++++++++
> > >  drivers/fpga/sysconfig.h     |  62 ++++
> > >  5 files changed, 810 insertions(+)
> > >  create mode 100644 drivers/fpga/sysconfig-spi.c
> > >  create mode 100644 drivers/fpga/sysconfig.c
> > >  create mode 100644 drivers/fpga/sysconfig.h
> > > 
> > > diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
> > > index 6c416955da53..991d9d976dca 100644
> > > --- a/drivers/fpga/Kconfig
> > > +++ b/drivers/fpga/Kconfig
> > > @@ -263,4 +263,11 @@ config FPGA_MGR_MICROCHIP_SPI
> > >  	  programming over slave SPI interface with .dat formatted
> > >  	  bitstream image.
> > >  
> > > +config FPGA_MGR_LATTICE_SPI
> > > +	tristate "Lattice sysCONFIG SPI FPGA manager"
> > > +	depends on SPI
> > > +	help
> > > +	  FPGA manager driver support for Lattice FPGAs programming over slave
> > > +	  SPI sysCONFIG interface.
> > > +
> > >  endif # FPGA
> > > diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
> > > index 42ae8b58abce..70e5f58d0c10 100644
> > > --- a/drivers/fpga/Makefile
> > > +++ b/drivers/fpga/Makefile
> > > @@ -20,9 +20,12 @@ obj-$(CONFIG_FPGA_MGR_ZYNQ_FPGA)	+= zynq-fpga.o
> > >  obj-$(CONFIG_FPGA_MGR_ZYNQMP_FPGA)	+= zynqmp-fpga.o
> > >  obj-$(CONFIG_FPGA_MGR_VERSAL_FPGA)	+= versal-fpga.o
> > >  obj-$(CONFIG_FPGA_MGR_MICROCHIP_SPI)	+= microchip-spi.o
> > > +obj-$(CONFIG_FPGA_MGR_LATTICE_SPI)	+= lattice-sysconfig-spi.o
> > >  obj-$(CONFIG_ALTERA_PR_IP_CORE)		+= altera-pr-ip-core.o
> > >  obj-$(CONFIG_ALTERA_PR_IP_CORE_PLAT)	+= altera-pr-ip-core-plat.o
> > >  
> > > +lattice-sysconfig-spi-objs		:= sysconfig-spi.o sysconfig.o
> > 
> > What's your plan if sysconfig-i2c is to be added?
> > 
> > There are many examples in kernel actually, is it better like the
> > following:
> > 
> >   obj-$(CONFIG_FPGA_MGR_LATTICE_SYSCONFIG)	+= lattice-sysconfig.o
> >   obj-$(CONFIG_LATTICE_SYSCONFIG_SPI)		+= lattice-sysconfig-spi.o
> > 
> 
> I was thinking of:
> 
> 	obj-$(CONFIG_FPGA_MGR_LATTICE_I2C)	+= lattice-sysconfig-i2c.o
> 	lattice-sysconfig-i2c-objs	:= sysconfig-i2c.o sysconfig.o

I think it would be better we don't duplicate common code segment across
different binaries, especially when the common core driver could be a bigger
part.

> 
> > > +
> > >  # FPGA Secure Update Drivers
> > >  obj-$(CONFIG_FPGA_M10_BMC_SEC_UPDATE)	+= intel-m10-bmc-sec-update.o
> > >  
> > > diff --git a/drivers/fpga/sysconfig-spi.c b/drivers/fpga/sysconfig-spi.c
> > > new file mode 100644
> > > index 000000000000..e2c71bc3b674
> > > --- /dev/null
> > > +++ b/drivers/fpga/sysconfig-spi.c
> > > @@ -0,0 +1,210 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * Lattice FPGA programming over slave SPI sysCONFIG interface.
> > > + */
> > > +
> > > +#include <linux/of_device.h>
> > > +#include <linux/spi/spi.h>
> > > +
> > > +#include "sysconfig.h"
> > > +
> > > +struct sysconfig_spi_fpga_priv {
> > > +	const struct sysconfig_fpga_priv *fpga_priv;
> > > +	u32 max_speed_hz;
> > > +};
> > > +
> > > +static const struct sysconfig_spi_fpga_priv ecp5_spi_data = {
> > > +	.fpga_priv = &ecp5_data,
> > > +	.max_speed_hz = 60000000,
> > > +};
> > > +
> > > +static const struct sysconfig_spi_fpga_priv machxo2_spi_data = {
> > > +	.fpga_priv = &machxo2_data,
> > > +	.max_speed_hz = 66000000,
> > > +};
> > > +
> > > +static int sysconfig_spi_cmd_write(struct sysconfig_priv *priv,
> > > +				   const void *tx_buf, size_t tx_len)
> > > +{
> > > +	struct spi_device *spi = to_spi_device(priv->dev);
> > > +
> > > +	if (!spi)
> > > +		return -ENODEV;
> > 
> > Any reason to check it everytime? The driver should make sure it is
> > properly initialized on probe, is it?
> > 
> 
> Actually, no.
> 
> > > +
> > > +	return spi_write(spi, tx_buf, tx_len);
> > > +}
> > > +
> > > +static int sysconfig_spi_cmd_write_with_data(struct sysconfig_priv *priv,
> > > +					     const void *cmd, size_t cmd_len,
> > > +					     const void *data, size_t data_len)
> > 
> > I think the 2 write callbacks could be combined and named
> > sysconfig_spi_cmd_write()
> > 
> 
> sysconfig_spi_cmd_write_with_data() is only needed for paged bitstream
> write. The reason to have a separate write_with_data() was to simplify
> calling of write() of every other commands.

This could be done inside sysconfig core, for the interfaces between
core & bus specific drivers, we'd better not introduce too many similar
callbacks.

> 
> > > +{
> > > +	struct spi_device *spi = to_spi_device(priv->dev);
> > > +	struct spi_transfer xfers[2] = {
> > > +		{
> > > +			.tx_buf = cmd,
> > > +			.len = cmd_len,
> > > +		}, {
> > > +			.tx_buf = data,
> > > +			.len = data_len,
> > > +		},
> > > +	};
> > > +
> > > +	if (!spi)
> > > +		return -ENODEV;
> > > +
> > > +	return spi_sync_transfer(spi, xfers, 2);
> > > +}
> > > +
> > > +static int sysconfig_spi_cmd_write_then_read(struct sysconfig_priv *priv,
> > > +					     const void *tx_buf, size_t tx_len,
> > > +					     void *rx_buf, size_t rx_len)
> > 
> > Maybe just sysconfig_spi_cmd_read(), No matter write or read data, command word
> > should always be TXed first, so no need to say write here.
> > 
> 
> As you wish. I have no strong feelings for namings. cmd_write() and
> cmd_write_then_read() was named so to mimic spi_write() and
> spi_write_then_read() namings.
> 
> > > +{
> > > +	struct spi_device *spi = to_spi_device(priv->dev);
> > > +
> > > +	if (!spi)
> > > +		return -ENODEV;
> > > +
> > > +	return spi_write_then_read(spi, tx_buf, tx_len, rx_buf, rx_len);
> > > +}
> > > +
> > > +static int sysconfig_spi_lsc_burst_init(struct sysconfig_priv *priv)
> > 
> > Is it better sysconfig_spi_bitstream_burst_init?
> 
> Sure, why not
> 
> > 
> > By the way, what is LSC & ISC?
> > 
> 
> I don't know. Commands naming is from datasheet FPGA-TN-02039-2.0, but,
> sadly, datasheet don't provide definitions for these acronyms.
> 
> > > +{
> > > +	const u8 lsc_bitstream_burst[] = SYSCONFIG_LSC_BITSTREAM_BURST;
> > > +	struct spi_device *spi = to_spi_device(priv->dev);
> > > +	struct spi_transfer xfer = {
> > > +		.tx_buf = lsc_bitstream_burst,
> > > +		.len = sizeof(lsc_bitstream_burst),
> > > +		.cs_change = 1,
> > 
> > I'm not sure what's the effect to have cs_change on last transfer, is it to
> > last cs active to the next message?
> > 
> 
> Yes, you are correct.
> 
> > > +	};
> > > +	struct spi_message msg;
> > > +	int ret;
> > > +
> > > +	if (!spi)
> > > +		return -ENODEV;
> > > +
> > > +	spi_message_init_with_transfers(&msg, &xfer, 1);
> > > +
> > > +	/*
> > > +	 * Lock SPI bus for exclusive usage until FPGA programming is done.
> > > +	 * SPI bus will be released in sysconfig_spi_lsc_burst_complete().
> > > +	 */
> > > +	spi_bus_lock(spi->controller);
> > > +
> > > +	ret = spi_sync_locked(spi, &msg);
> > > +	if (ret)
> > > +		spi_bus_unlock(spi->controller);
> > > +
> > > +	return ret;
> > > +}
> > > +
> > > +static int sysconfig_spi_bitstream_burst_write(struct sysconfig_priv *priv,
> > > +					       const char *buf, size_t count)
> > 
> > Why 'count', is 'len' better, to aligned with previous callbacks.
> > 
> 
> OK
> 
> > > +{
> > > +	struct spi_device *spi = to_spi_device(priv->dev);
> > > +	struct spi_transfer xfer = {
> > > +		.tx_buf = buf,
> > > +		.len = count,
> > > +		.cs_change = 1,
> > > +	};
> > > +	struct spi_message msg;
> > > +
> > > +	if (!spi)
> > > +		return -ENODEV;
> > > +
> > > +	spi_message_init_with_transfers(&msg, &xfer, 1);
> > > +
> > > +	return spi_sync_locked(spi, &msg);
> > > +}
> > > +
> > > +static int sysconfig_spi_lsc_burst_complete(struct sysconfig_priv *priv)
> > 
> > sysconfig_spi_bitstream_burst_complete?
> > 
> 
> OK
> 
> > > +{
> > > +	struct spi_device *spi = to_spi_device(priv->dev);
> > > +
> > > +	if (!spi)
> > > +		return -ENODEV;
> > > +
> > > +	/* Bitstream burst write is done, release SPI bus */
> > > +	spi_bus_unlock(spi->controller);
> > > +
> > > +	/* Toggle CS to finish bitstream write */
> > > +	return spi_write(spi, NULL, 0);
> > > +}
> > > +
> > > +static int sysconfig_spi_probe(struct spi_device *spi)
> > > +{
> > > +	const struct sysconfig_spi_fpga_priv *spi_fpga_priv;
> > > +	const struct spi_device_id *dev_id;
> > > +	struct device *dev = &spi->dev;
> > > +	struct sysconfig_priv *priv;
> > > +
> > > +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> > > +	if (!priv)
> > > +		return -ENOMEM;
> > > +
> > > +	spi_fpga_priv = of_device_get_match_data(dev);
> > > +	if (!spi_fpga_priv) {
> > > +		dev_id = spi_get_device_id(spi);
> > > +		if (!dev_id)
> > > +			return -ENODEV;
> > > +
> > > +		spi_fpga_priv = (const struct sysconfig_spi_fpga_priv *)dev_id->driver_data;
> > > +	}
> > > +
> > > +	if (!spi_fpga_priv)
> > > +		return -EINVAL;
> > > +
> > > +	if (spi->max_speed_hz > spi_fpga_priv->max_speed_hz) {
> > > +		dev_err(dev, "SPI speed %u is too high, maximum speed is %u\n",
> > > +			spi->max_speed_hz, spi_fpga_priv->max_speed_hz);
> > > +		return -EINVAL;
> > > +	}
> > > +
> > > +	priv->dev = dev;
> > > +	priv->fpga_priv = spi_fpga_priv->fpga_priv;
> > > +	priv->command_write = sysconfig_spi_cmd_write;
> > > +	priv->command_write_with_data = sysconfig_spi_cmd_write_with_data;
> > > +	priv->command_write_then_read = sysconfig_spi_cmd_write_then_read;
> > > +	priv->bitstream_burst_write_init = sysconfig_spi_lsc_burst_init;
> > > +	priv->bitstream_burst_write = sysconfig_spi_bitstream_burst_write;
> > > +	priv->bitstream_burst_write_complete = sysconfig_spi_lsc_burst_complete;
> > > +
> > > +	return sysconfig_probe(priv);
> > > +}
> > > +
> > > +static const struct spi_device_id sysconfig_spi_ids[] = {
> > > +	{
> > > +		.name = "sysconfig-ecp5",
> > > +		.driver_data = (kernel_ulong_t)&ecp5_spi_data,
> > > +	}, {
> > > +		.name = "sysconfig-machxo2",
> > > +		.driver_data = (kernel_ulong_t)&machxo2_spi_data,
> > > +	}, {},
> > > +};
> > > +MODULE_DEVICE_TABLE(spi, sysconfig_spi_ids);
> > > +
> > > +#if IS_ENABLED(CONFIG_OF)
> > > +static const struct of_device_id sysconfig_of_ids[] = {
> > > +	{
> > > +		.compatible = "lattice,sysconfig-ecp5",
> > > +		.data = &ecp5_spi_data,
> > > +	}, {
> > > +		.compatible = "lattice,sysconfig-machxo2",
> > > +		.data = &machxo2_spi_data,
> > > +	}, {},
> > > +};
> > > +MODULE_DEVICE_TABLE(of, sysconfig_of_ids);
> > > +#endif /* IS_ENABLED(CONFIG_OF) */
> > > +
> > > +static struct spi_driver lattice_sysconfig_driver = {
> > > +	.probe = sysconfig_spi_probe,
> > > +	.id_table = sysconfig_spi_ids,
> > > +	.driver = {
> > > +		.name = "lattice_sysconfig_spi_fpga_mgr",
> > > +		.of_match_table = of_match_ptr(sysconfig_of_ids),
> > > +	},
> > > +};
> > > +
> > > +module_spi_driver(lattice_sysconfig_driver);
> > > +
> > > +MODULE_DESCRIPTION("Lattice sysCONFIG Slave SPI FPGA Manager");
> > > +MODULE_LICENSE("GPL");
> > > diff --git a/drivers/fpga/sysconfig.c b/drivers/fpga/sysconfig.c
> > > new file mode 100644
> > > index 000000000000..af697203ed5d
> > > --- /dev/null
> > > +++ b/drivers/fpga/sysconfig.c
> > > @@ -0,0 +1,528 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * Lattice FPGA sysCONFIG interface functions independent of port type.
> > > + */
> > > +
> > > +#include <linux/delay.h>
> > > +#include <linux/fpga/fpga-mgr.h>
> > > +#include <linux/gpio/consumer.h>
> > > +
> > > +#include "sysconfig.h"
> > > +
> > > +const struct sysconfig_fpga_priv ecp5_data = {
> > > +	.isc_enable_operand = 0x00,
> > > +	.burst_write = true,
> > > +	.internal_flash = false,
> > 
> > Sorry, we still have gaps here.
> > Machxo2 reprograming can be splitted to 2 steps, flash reprograming &
> > FPGA reconfiguration from flash,
> 
> Keep in mind that, according to MachXO2 docs, ISC_ENABLE, ISC_ERASE and
> LSC_INIT_ADDR commands still needs to be issued for writing internal
> flash.
> 
> > and now I think it is not a good idea
> > to include the 2 steps in an FPGA manager. Flash reprograming is actually
> > not the job for FPGA manager, it could be done by other existing
> > interfaces. And I also don't want to support it in this new driver. FPGA
> > reconfiguration from flash, as we discussed previously, could be a
> > FPGA manager feature, but could be considered later.
> > 
> > In another word, only to implement FPGA reconfiguration from bitstream
> > file, we don't even need to support machxo2 now.
> > 
> 
> Ok, I don't mind to drop MachXO2 support, I can't test it anyway.
> 
> > For this sysconfig_fpga_priv, isc_enable_operand & internal_flash are
> > not need here, they are for flash reprograming actually. burst_write
> > is the only concern, any finding about whether page write works?
> > 
> 
> No, I didn't succeed in paged write to SRAM on ECP5.

OK. So for now there is no evidence we could reconfigure FPGA by page write,
then the burst_write flag is not needed either.

Thanks,
Yilun
