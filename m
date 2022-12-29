Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F57A658FF2
	for <lists+linux-fpga@lfdr.de>; Thu, 29 Dec 2022 18:35:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233969AbiL2Rds (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 29 Dec 2022 12:33:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234011AbiL2RdO (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 29 Dec 2022 12:33:14 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8151115F2B;
        Thu, 29 Dec 2022 09:33:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672335193; x=1703871193;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=mA1aVFRaMsOcJtQ5SDdn3FwLj8DAkdodQXt0ho57zsQ=;
  b=iO4qZemHJfJ0g7EkB3U7A8kquco5xt69Q0B42xIjKkkvACIABJE7b1y7
   LGbBPebnoHbmnDO0ROebaL3/G0yZyhep427vGS8gmso7mx/TwyykOhbI/
   /5RjoEh4fQ4IuyMHbvFL1nVC/6/pMNCLfb2lLvxFSdKCcSly5Y09hpGgm
   RJ8iNaFWxsMTszX+dME8/7ywpxpPCjTvioggAQ8EPHwE+5JNz6sfChaOa
   29v0r81XCLgaSTfMUYeJpk2Jd0yGZtdyAEFrvrJesouJ9OwyfXVNNVQ1K
   S8ItOK5goXRarXg1+uRkUhOhtuKVCYS6QRnzdNjvZTVLIplykphv5Sz2I
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10575"; a="301450862"
X-IronPort-AV: E=Sophos;i="5.96,284,1665471600"; 
   d="scan'208";a="301450862"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2022 09:33:12 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10575"; a="684271925"
X-IronPort-AV: E=Sophos;i="5.96,284,1665471600"; 
   d="scan'208";a="684271925"
Received: from rhweight-wrk1.ra.intel.com ([137.102.106.139])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2022 09:33:12 -0800
Date:   Thu, 29 Dec 2022 09:33:38 -0800 (PST)
From:   matthew.gerlach@linux.intel.com
X-X-Sender: mgerlach@rhweight-WRK1
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
cc:     hao.wu@intel.com, yilun.xu@intel.com, russell.h.weight@intel.com,
        basheer.ahmed.muddebihal@intel.com, trix@redhat.com,
        mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        tianfei.zhang@intel.com, corbet@lwn.net,
        gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        jirislaby@kernel.org, geert+renesas@glider.be,
        niklas.soderlund+renesas@ragnatech.se, macro@orcam.me.uk,
        johan@kernel.org, lukas@wunner.de, ilpo.jarvinen@linux.intel.com,
        marpagan@redhat.com, bagasdotme@gmail.com
Subject: Re: [PATCH v8 4/4] tty: serial: 8250: add DFL bus driver for Altera
 16550.
In-Reply-To: <Y61kwSEBTHNAU/Fh@smile.fi.intel.com>
Message-ID: <alpine.DEB.2.22.394.2212290932310.1857691@rhweight-WRK1>
References: <20221228181624.1793433-1-matthew.gerlach@linux.intel.com> <20221228181624.1793433-5-matthew.gerlach@linux.intel.com> <Y61kwSEBTHNAU/Fh@smile.fi.intel.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1806459893-1672335218=:1857691"
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1806459893-1672335218=:1857691
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT



On Thu, 29 Dec 2022, Andy Shevchenko wrote:

> On Wed, Dec 28, 2022 at 10:16:24AM -0800, matthew.gerlach@linux.intel.com wrote:
>> From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>>
>> Add a Device Feature List (DFL) bus driver for the Altera
>> 16550 implementation of UART.
>
> With that helper looks better,
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

I agree the helper function makes the code look better and is safer.

Thanks for the review,
Matthew Gerlach

>
>> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>> Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
>> ---
>> v8: use dfh_get_u64_param_vals()
>>
>> v7: no change
>>
>> v6: move driver specific parameter definitions to limit scope
>>
>> v5: removed unneeded blank line
>>     removed unneeded includes
>>     included device.h and types.h
>>     removed unneeded local variable
>>     remove calls to dev_dbg
>>     memset -> { }
>>     remove space after period
>>     explicitly include used headers
>>     remove redundant Inc from Copyright
>>     fix format specifier
>>
>> v4: use dev_err_probe() everywhere that is appropriate
>>     clean up noise
>>     change error messages to use the word, unsupported
>>     tried again to sort Makefile and KConfig better
>>     reorder probe function for easier error handling
>>     use new dfh_find_param API
>>
>> v3: use passed in location of registers
>>     use cleaned up functions for parsing parameters
>>
>> v2: clean up error messages
>>     alphabetize header files
>>     fix 'missing prototype' error by making function static
>>     tried to sort Makefile and Kconfig better
>> ---
>>  drivers/tty/serial/8250/8250_dfl.c | 150 +++++++++++++++++++++++++++++
>>  drivers/tty/serial/8250/Kconfig    |  12 +++
>>  drivers/tty/serial/8250/Makefile   |   1 +
>>  3 files changed, 163 insertions(+)
>>  create mode 100644 drivers/tty/serial/8250/8250_dfl.c
>>
>> diff --git a/drivers/tty/serial/8250/8250_dfl.c b/drivers/tty/serial/8250/8250_dfl.c
>> new file mode 100644
>> index 000000000000..0ee78c38a721
>> --- /dev/null
>> +++ b/drivers/tty/serial/8250/8250_dfl.c
>> @@ -0,0 +1,150 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Driver for FPGA UART
>> + *
>> + * Copyright (C) 2022 Intel Corporation.
>> + *
>> + * Authors:
>> + *   Ananda Ravuri <ananda.ravuri@intel.com>
>> + *   Matthew Gerlach <matthew.gerlach@linux.intel.com>
>> + */
>> +
>> +#include <linux/bitfield.h>
>> +#include <linux/device.h>
>> +#include <linux/dfl.h>
>> +#include <linux/errno.h>
>> +#include <linux/ioport.h>
>> +#include <linux/module.h>
>> +#include <linux/mod_devicetable.h>
>> +#include <linux/types.h>
>> +
>> +#include <linux/serial.h>
>> +#include <linux/serial_8250.h>
>> +
>> +#define DFHv1_PARAM_ID_CLK_FRQ    0x2
>> +#define DFHv1_PARAM_ID_FIFO_LEN   0x3
>> +
>> +#define DFHv1_PARAM_ID_REG_LAYOUT	0x4
>> +#define DFHv1_PARAM_REG_LAYOUT_WIDTH	GENMASK_ULL(63, 32)
>> +#define DFHv1_PARAM_REG_LAYOUT_SHIFT	GENMASK_ULL(31, 0)
>> +
>> +struct dfl_uart {
>> +	int line;
>> +};
>> +
>> +static int dfl_uart_get_params(struct dfl_device *dfl_dev, struct uart_8250_port *uart)
>> +{
>> +	struct device *dev = &dfl_dev->dev;
>> +	u64 fifo_len, clk_freq, reg_layout;
>> +	u32 reg_width;
>> +	u64 *p;
>> +
>> +	p = dfh_get_u64_param_vals(dfl_dev, DFHv1_PARAM_ID_CLK_FRQ, &clk_freq, 1);
>> +	if (IS_ERR(p))
>> +		return dev_err_probe(dev, PTR_ERR(p), "missing CLK_FRQ param\n");
>> +
>> +	uart->port.uartclk = clk_freq;
>> +
>> +	p = dfh_get_u64_param_vals(dfl_dev, DFHv1_PARAM_ID_FIFO_LEN, &fifo_len, 1);
>> +	if (IS_ERR(p))
>> +		return dev_err_probe(dev, PTR_ERR(p), "missing FIFO_LEN param\n");
>> +
>> +	switch (fifo_len) {
>> +	case 32:
>> +		uart->port.type = PORT_ALTR_16550_F32;
>> +		break;
>> +
>> +	case 64:
>> +		uart->port.type = PORT_ALTR_16550_F64;
>> +		break;
>> +
>> +	case 128:
>> +		uart->port.type = PORT_ALTR_16550_F128;
>> +		break;
>> +
>> +	default:
>> +		return dev_err_probe(dev, -EINVAL, "unsupported FIFO_LEN %llu\n", fifo_len);
>> +	}
>> +
>> +	p = dfh_get_u64_param_vals(dfl_dev, DFHv1_PARAM_ID_REG_LAYOUT, &reg_layout, 1);
>> +	if (IS_ERR(p))
>> +		return dev_err_probe(dev, PTR_ERR(p), "missing REG_LAYOUT param\n");
>> +
>> +	uart->port.regshift = FIELD_GET(DFHv1_PARAM_REG_LAYOUT_SHIFT, reg_layout);
>> +	reg_width = FIELD_GET(DFHv1_PARAM_REG_LAYOUT_WIDTH, reg_layout);
>> +	switch (reg_width) {
>> +	case 4:
>> +		uart->port.iotype = UPIO_MEM32;
>> +		break;
>> +
>> +	case 2:
>> +		uart->port.iotype = UPIO_MEM16;
>> +		break;
>> +
>> +	default:
>> +		return dev_err_probe(dev, -EINVAL, "unsupported reg-width %u\n", reg_width);
>> +
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int dfl_uart_probe(struct dfl_device *dfl_dev)
>> +{
>> +	struct device *dev = &dfl_dev->dev;
>> +	struct uart_8250_port uart = { };
>> +	struct dfl_uart *dfluart;
>> +	int ret;
>> +
>> +	uart.port.flags = UPF_IOREMAP;
>> +	uart.port.mapbase = dfl_dev->mmio_res.start;
>> +	uart.port.mapsize = resource_size(&dfl_dev->mmio_res);
>> +
>> +	ret = dfl_uart_get_params(dfl_dev, &uart);
>> +	if (ret < 0)
>> +		return dev_err_probe(dev, ret, "failed uart feature walk\n");
>> +
>> +	if (dfl_dev->num_irqs == 1)
>> +		uart.port.irq = dfl_dev->irqs[0];
>> +
>> +	dfluart = devm_kzalloc(dev, sizeof(*dfluart), GFP_KERNEL);
>> +	if (!dfluart)
>> +		return -ENOMEM;
>> +
>> +	dfluart->line = serial8250_register_8250_port(&uart);
>> +	if (dfluart->line < 0)
>> +		return dev_err_probe(dev, dfluart->line, "unable to register 8250 port.\n");
>> +
>> +	dev_set_drvdata(dev, dfluart);
>> +
>> +	return 0;
>> +}
>> +
>> +static void dfl_uart_remove(struct dfl_device *dfl_dev)
>> +{
>> +	struct dfl_uart *dfluart = dev_get_drvdata(&dfl_dev->dev);
>> +
>> +	serial8250_unregister_port(dfluart->line);
>> +}
>> +
>> +#define FME_FEATURE_ID_UART 0x24
>> +
>> +static const struct dfl_device_id dfl_uart_ids[] = {
>> +	{ FME_ID, FME_FEATURE_ID_UART },
>> +	{ }
>> +};
>> +MODULE_DEVICE_TABLE(dfl, dfl_uart_ids);
>> +
>> +static struct dfl_driver dfl_uart_driver = {
>> +	.drv = {
>> +		.name = "dfl-uart",
>> +	},
>> +	.id_table = dfl_uart_ids,
>> +	.probe = dfl_uart_probe,
>> +	.remove = dfl_uart_remove,
>> +};
>> +module_dfl_driver(dfl_uart_driver);
>> +
>> +MODULE_DESCRIPTION("DFL Intel UART driver");
>> +MODULE_AUTHOR("Intel Corporation");
>> +MODULE_LICENSE("GPL");
>> diff --git a/drivers/tty/serial/8250/Kconfig b/drivers/tty/serial/8250/Kconfig
>> index b0f62345bc84..08af2acd4645 100644
>> --- a/drivers/tty/serial/8250/Kconfig
>> +++ b/drivers/tty/serial/8250/Kconfig
>> @@ -370,6 +370,18 @@ config SERIAL_8250_FSL
>>  	  erratum for Freescale 16550 UARTs in the 8250 driver. It also
>>  	  enables support for ACPI enumeration.
>>
>> +config SERIAL_8250_DFL
>> +	tristate "DFL bus driver for Altera 16550 UART"
>> +	depends on SERIAL_8250 && FPGA_DFL
>> +	help
>> +	  This option enables support for a Device Feature List (DFL) bus
>> +	  driver for the Altera 16650 UART. One or more Altera 16650 UARTs
>> +	  can be instantiated in a FPGA and then be discovered during
>> +	  enumeration of the DFL bus.
>> +
>> +	  To compile this driver as a module, chose M here: the
>> +	  module will be called 8250_dfl.
>> +
>>  config SERIAL_8250_DW
>>  	tristate "Support for Synopsys DesignWare 8250 quirks"
>>  	depends on SERIAL_8250
>> diff --git a/drivers/tty/serial/8250/Makefile b/drivers/tty/serial/8250/Makefile
>> index 1615bfdde2a0..4e1a32812683 100644
>> --- a/drivers/tty/serial/8250/Makefile
>> +++ b/drivers/tty/serial/8250/Makefile
>> @@ -28,6 +28,7 @@ obj-$(CONFIG_SERIAL_8250_EXAR_ST16C554)	+= 8250_exar_st16c554.o
>>  obj-$(CONFIG_SERIAL_8250_HUB6)		+= 8250_hub6.o
>>  obj-$(CONFIG_SERIAL_8250_FSL)		+= 8250_fsl.o
>>  obj-$(CONFIG_SERIAL_8250_MEN_MCB)	+= 8250_men_mcb.o
>> +obj-$(CONFIG_SERIAL_8250_DFL)		+= 8250_dfl.o
>>  obj-$(CONFIG_SERIAL_8250_DW)		+= 8250_dw.o
>>  obj-$(CONFIG_SERIAL_8250_EM)		+= 8250_em.o
>>  obj-$(CONFIG_SERIAL_8250_IOC3)		+= 8250_ioc3.o
>> --
>> 2.25.1
>>
>
> -- 
> With Best Regards,
> Andy Shevchenko
>
>
>
--8323328-1806459893-1672335218=:1857691--
