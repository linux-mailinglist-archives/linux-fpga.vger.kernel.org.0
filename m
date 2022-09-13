Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 220485B65B7
	for <lists+linux-fpga@lfdr.de>; Tue, 13 Sep 2022 04:41:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230016AbiIMCjX (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 12 Sep 2022 22:39:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbiIMCjW (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 12 Sep 2022 22:39:22 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5ACC4331D;
        Mon, 12 Sep 2022 19:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663036761; x=1694572761;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=K/EtDYoKROjD8UuR8udCj5gDyp3UBZk8ez/tReGgiP8=;
  b=loHknw7UqsJQZMqJ2zpS7KqGePVpQeHUyRCw9Htd9RXmCa9XLaBQRdQH
   5bWFnn4FdDc80mPqd9WBRZmyQzqx+afhrfwK/X+MDHOJ7r9G5TM0yuoDJ
   /fGZpHE9X7tfJv/OxONbthntUFwGCCUeP6sNHCz6C84B8wqY1h5IUsmcK
   e7bf+ukACwKz8a9rQtWXJGQORk5negMRWPvn6yMLp6Nv1O+zD0g4PYnRQ
   9O8D31hS4F/AF1h/5GJCHgNZbeXGDvBkNY9g7VSqaF5tbq06vSGj44WVv
   q9bwKUzh8NjSsxX+DXa5DTQsqd0xBQdrG3Dx2s9DBPWvWGWttfgWmEsWj
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10468"; a="298022521"
X-IronPort-AV: E=Sophos;i="5.93,311,1654585200"; 
   d="scan'208";a="298022521"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2022 19:39:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,311,1654585200"; 
   d="scan'208";a="684677415"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmsmga004.fm.intel.com with ESMTP; 12 Sep 2022 19:39:17 -0700
Date:   Tue, 13 Sep 2022 10:29:44 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Ivan Bornyakov <i.bornyakov@metrotek.ru>
Cc:     mdf@kernel.org, hao.wu@intel.com, trix@redhat.com, dg@emlix.com,
        j.zink@pengutronix.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-fpga@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, system@metrotek.ru
Subject: Re: [PATCH v10 1/2] fpga: lattice-sysconfig-spi: add Lattice
 sysCONFIG FPGA manager
Message-ID: <Yx/rFy9lwbrvmrjf@yilunxu-OptiPlex-7050>
References: <20220905133205.17039-1-i.bornyakov@metrotek.ru>
 <20220905133205.17039-2-i.bornyakov@metrotek.ru>
 <Yx1isMn5+z/UYapO@yilunxu-OptiPlex-7050>
 <20220911123257.gpamtv3mhagi42x2@x260>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220911123257.gpamtv3mhagi42x2@x260>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 2022-09-11 at 15:32:57 +0300, Ivan Bornyakov wrote:
> On Sun, Sep 11, 2022 at 12:23:12PM +0800, Xu Yilun wrote:
> > On 2022-09-05 at 16:32:04 +0300, Ivan Bornyakov wrote:
> > > Add support to the FPGA manager for programming Lattice ECP5 and MachXO2
> > > FPGAs over slave SPI sysCONFIG interface.
> > 
> > This version is much better, see my comments inline.
> > 
> > > 
> > > Signed-off-by: Ivan Bornyakov <i.bornyakov@metrotek.ru>
> > > ---
> > >  drivers/fpga/Kconfig         |   7 +
> > >  drivers/fpga/Makefile        |   3 +
> > >  drivers/fpga/sysconfig-spi.c | 199 ++++++++++++++
> > >  drivers/fpga/sysconfig.c     | 520 +++++++++++++++++++++++++++++++++++
> > >  drivers/fpga/sysconfig.h     |  63 +++++
> > >  5 files changed, 792 insertions(+)
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
> > > +
> > >  # FPGA Secure Update Drivers
> > >  obj-$(CONFIG_FPGA_M10_BMC_SEC_UPDATE)	+= intel-m10-bmc-sec-update.o
> > >  
> > > diff --git a/drivers/fpga/sysconfig-spi.c b/drivers/fpga/sysconfig-spi.c
> > > new file mode 100644
> > > index 000000000000..f4dba2b57352
> > > --- /dev/null
> > > +++ b/drivers/fpga/sysconfig-spi.c
> > > @@ -0,0 +1,199 @@
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
> > > +static int sysconfig_spi_cmd_write(struct sysconfig_priv *priv,
> > > +				   const void *tx_buf, size_t tx_len)
> > > +{
> > > +	struct spi_device *spi = to_spi_device(priv->dev);
> > > +
> > > +	if (!spi)
> > > +		return -ENODEV;
> > > +
> > > +	return spi_write(spi, tx_buf, tx_len);
> > > +}
> > > +
> > > +static int sysconfig_spi_cmd_write_with_data(struct sysconfig_priv *priv,
> > > +					     const void *cmd, size_t cmd_len,
> > > +					     const void *data, size_t data_len)
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
> > > +{
> > > +	struct spi_device *spi = to_spi_device(priv->dev);
> > > +
> > > +	if (!spi)
> > > +		return -ENODEV;
> > > +
> > > +	return spi_write_then_read(spi, tx_buf, tx_len, rx_buf, rx_len);
> > > +}
> > > +
> > > +static int sysconfig_lsc_burst_init(struct sysconfig_priv *priv)
> > 
> > add the spi prefix for the func name.
> > 
> > > +{
> > > +	const u8 lsc_bitstream_burst[] = SYSCONFIG_LSC_BITSTREAM_BURST;
> > > +	struct spi_device *spi = to_spi_device(priv->dev);
> > > +	struct spi_transfer xfer = {
> > > +		.tx_buf = lsc_bitstream_burst,
> > > +		.len = sizeof(lsc_bitstream_burst),
> > > +		.cs_change = 1,
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
> > > +	 * SPI bus will be released in sysconfig_lsc_burst_complete().
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
> > > +static int sysconfig_bitstream_burst_write(struct sysconfig_priv *priv,
> > > +					   const char *buf, size_t count)
> > 
> > Add spi prefix
> > 
> > > +{
> > > +	struct spi_device *spi = to_spi_device(priv->dev);
> > > +	struct spi_transfer xfer = {
> > > +		.tx_buf = buf,
> > > +		.len = count,
> > > +		.cs_change = 1,
> > > +	};
> > > +	struct spi_message msg;
> > > +	int ret;
> > > +
> > > +	if (!spi)
> > > +		return -ENODEV;
> > > +
> > > +	spi_message_init_with_transfers(&msg, &xfer, 1);
> > > +	ret = spi_sync_locked(spi, &msg);
> > > +	if (ret)
> > > +		spi_bus_unlock(spi->controller);
> > 
> > The sysconfig_spi don't have to assume the sysconfig core driver will
> > register an fpga_manager. It is possible the core driver uses these
> > callback for MTD ops?
> > 
> > So the burst operations don't have to be strictly aligned with
> > fpga_manager_ops->write_init/write/write_complete.
> > 
> > Maybe the logic in core driver could be more generic, like:
> > 
> >   if (burst_init())
> > 	fail;
> > 
> >   if (burst_write()) {
> > 	burst_complete();
> > 	fail;
> >   }
> > 
> >   burst_complete();
> > 
> > So I think you don't have to unlock bus here, let burst_complete do it.
> > 
> > > +
> > > +	return ret;
> > > +}
> > > +
> > > +static int sysconfig_lsc_burst_complete(struct sysconfig_priv *priv)
> > 
> > Add spi prefix
> > 
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
> > > +	const struct sysconfig_fpga_priv *fpga_priv;
> > > +	const struct spi_device_id *dev_id;
> > > +	struct device *dev = &spi->dev;
> > > +	struct sysconfig_priv *priv;
> > > +
> > > +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> > > +	if (!priv)
> > > +		return -ENOMEM;
> > > +
> > > +	fpga_priv = of_device_get_match_data(dev);
> > > +	if (!fpga_priv) {
> > > +		dev_id = spi_get_device_id(spi);
> > > +		if (!dev_id)
> > > +			return -ENODEV;
> > > +
> > > +		fpga_priv = (const struct sysconfig_fpga_priv *)dev_id->driver_data;
> > > +	}
> > > +
> > > +	if (!fpga_priv)
> > > +		return -EINVAL;
> > > +
> > > +	if (spi->max_speed_hz > fpga_priv->spi_max_speed_hz) {
> > > +		dev_err(dev, "SPI speed %u is too high, maximum speed is %u\n",
> > > +			spi->max_speed_hz, fpga_priv->spi_max_speed_hz);
> > > +		return -EINVAL;
> > > +	}
> > > +
> > > +	priv->dev = dev;
> > > +	priv->fpga_priv = fpga_priv;
> > > +	priv->command_write = sysconfig_spi_cmd_write;
> > > +	priv->command_write_with_data = sysconfig_spi_cmd_write_with_data;
> > > +	priv->command_write_then_read = sysconfig_spi_cmd_write_then_read;
> > > +	priv->bitstream_burst_write_init = sysconfig_lsc_burst_init;
> > > +	priv->bitstream_burst_write = sysconfig_bitstream_burst_write;
> > > +	priv->bitstream_burst_write_complete = sysconfig_lsc_burst_complete;
> > > +
> > > +	return sysconfig_probe(priv);
> > > +}
> > > +
> > > +static const struct spi_device_id sysconfig_spi_ids[] = {
> > > +	{
> > > +		.name = "ecp5-fpga-mgr",
> > 
> > I assume sysconfig could do more than fpga-manager, like detailed flash
> > management maybe a name not specific to fpga-mgr.
> > 
> > > +		.driver_data = (kernel_ulong_t)&ecp5_data,
> > > +	}, {
> > > +		.name = "machxo2-fpga-mgr",
> > > +		.driver_data = (kernel_ulong_t)&machxo2_data,
> > > +	}, {},
> > > +};
> > > +MODULE_DEVICE_TABLE(spi, sysconfig_spi_ids);
> > > +
> > > +#if IS_ENABLED(CONFIG_OF)
> > > +static const struct of_device_id sysconfig_of_ids[] = {
> > > +	{
> > > +		.compatible = "lattice,ecp5-fpga-mgr",
> > > +		.data = &ecp5_data,
> > > +	}, {
> > > +		.compatible = "lattice,machxo2-fpga-mgr",
> > > +		.data = &machxo2_data,
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
> > > index 000000000000..453dd6f6bf30
> > > --- /dev/null
> > > +++ b/drivers/fpga/sysconfig.c
> > > @@ -0,0 +1,520 @@
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
> > > +	.spi_max_speed_hz = 60000000,
> > 
> > Again, don't put spi stuff in core driver, embedded it in
> > sysconfig_spi.c.
> > 
> > > +	.isc_enable_operand = 0x00,
> > > +	.burst_write = true,
> > 
> > Just query, from spec I see we must use burst_write for SRAM
> > configuration. Is it specific to ecp5 or mandatory to all other boards,
> > why we cannot configure SRAM by page write?
> > 
> 
> I'm afraid this is beyond my expertise. I'll do some experiments with
> paged write on ECP5 some time next week.
> 
> > > +	.internal_flash = false,
> > 
> > On reviewing the machxo2 patches, I think reprogramming flash should not
> > be implemented by fpga manager, there are existing solutions for fine
> > flash control. So maybe we don't have to support flash reprogramming
> > here.
> > 
> > But SRAM configuration from flash could be a feature supported by fpga
> > manager, we don't have code now, this could be another topic.
> > 
> 
> Am I expected to do something about this in v11? Or it is OK for now as
> it is and rework can be postponed for the future?

No, it's OK without it. We could investigate this feature later.

Thanks,
Yilun
