Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3BB45FA44B
	for <lists+linux-fpga@lfdr.de>; Mon, 10 Oct 2022 21:43:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbiJJTmB (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 10 Oct 2022 15:42:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiJJTmA (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 10 Oct 2022 15:42:00 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B60D65FF48;
        Mon, 10 Oct 2022 12:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665430918; x=1696966918;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=fwc/TV//W0VLule90wp2FfviuoKkw6DMu8Bl1+R9tpY=;
  b=VvgZpmJPSJZxk/Ewbu0aruas3X4OEyrio/ii/ob8suRSoCod9gyPMiHK
   tl6RrGy5neLXigl+52tinRBe2mpRv37ErNWg1fvM+qMy9W36x5G7BESo8
   SZaqDIJuyExyrPZi5X2kiJBxutdN6oct76kW6NpE7YjyDBi3pICMjYZsi
   tMTNtamczEYj1bJKCKR1+N5cRJdvAdi2wH0JVw6ndRu/f1D7M3CRA+ccj
   8luWq1+3met2tpaWQ6lbrm03PnHP0EWu9Y3P/fTtsW9z1hhuvxtBd1tiV
   ldQ3s9Yb9lEI+YTg2W3H1qgft4a2eF/gROVTzpbxXxCudrxkBnd9SN8KZ
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10496"; a="303059520"
X-IronPort-AV: E=Sophos;i="5.95,173,1661842800"; 
   d="scan'208";a="303059520"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2022 12:41:57 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10496"; a="603850834"
X-IronPort-AV: E=Sophos;i="5.95,173,1661842800"; 
   d="scan'208";a="603850834"
Received: from rhweight-wrk1.ra.intel.com ([137.102.106.139])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2022 12:41:57 -0700
Date:   Mon, 10 Oct 2022 12:42:15 -0700 (PDT)
From:   matthew.gerlach@linux.intel.com
X-X-Sender: mgerlach@rhweight-WRK1
To:     Marco Pagani <marpagan@redhat.com>
cc:     andriy.shevchenko@linux.intel.com,
        basheer.ahmed.muddebihal@intel.com, corbet@lwn.net,
        geert+renesas@glider.be, gregkh@linuxfoundation.org,
        hao.wu@intel.com, jirislaby@kernel.org, johan@kernel.org,
        linux-doc@vger.kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        lkp@intel.com, lukas@wunner.de, macro@orcam.me.uk, mdf@kernel.org,
        niklas.soderlund+renesas@ragnatech.se, russell.h.weight@intel.com,
        tianfei.zhang@intel.com, trix@redhat.com, yilun.xu@intel.com
Subject: Re: [PATCH v3 4/4] tty: serial: 8250: add DFL bus driver for Altera
 16550.
In-Reply-To: <cfd34b7c-d5eb-5087-5b9f-9577807fc09b@redhat.com>
Message-ID: <alpine.DEB.2.22.394.2210101239360.2404672@rhweight-WRK1>
References: <20221004143718.1076710-5-matthew.gerlach@linux.intel.com> <cfd34b7c-d5eb-5087-5b9f-9577807fc09b@redhat.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



On Mon, 10 Oct 2022, Marco Pagani wrote:

>
> On 2022-10-04 16:37, matthew.gerlach@linux.intel.com wrote:
>> From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>>
>> Add a Device Feature List (DFL) bus driver for the Altera
>> 16550 implementation of UART.
>>
>> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>> Reported-by: kernel test robot <lkp@intel.com>
>> ---
>> v3: use passed in location of registers
>>     use cleaned up functions for parsing parameters
>>
>> v2: clean up error messages
>>     alphabetize header files
>>     fix 'missing prototype' error by making function static
>>     tried to sort Makefile and Kconfig better
>> ---
>>  drivers/tty/serial/8250/8250_dfl.c | 177 +++++++++++++++++++++++++++++
>>  drivers/tty/serial/8250/Kconfig    |   9 ++
>>  drivers/tty/serial/8250/Makefile   |   1 +
>>  3 files changed, 187 insertions(+)
>>  create mode 100644 drivers/tty/serial/8250/8250_dfl.c
>>
>> diff --git a/drivers/tty/serial/8250/8250_dfl.c b/drivers/tty/serial/8250/8250_dfl.c
>> new file mode 100644
>> index 000000000000..110ad3a73459
>> --- /dev/null
>> +++ b/drivers/tty/serial/8250/8250_dfl.c
>> @@ -0,0 +1,177 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Driver for FPGA UART
>> + *
>> + * Copyright (C) 2022 Intel Corporation, Inc.
>> + *
>> + * Authors:
>> + *   Ananda Ravuri <ananda.ravuri@intel.com>
>> + *   Matthew Gerlach <matthew.gerlach@linux.intel.com>
>> + */
>> +
>> +#include <linux/bitfield.h>
>> +#include <linux/dfl.h>
>> +#include <linux/io-64-nonatomic-lo-hi.h>
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +#include <linux/serial.h>
>> +#include <linux/serial_8250.h>
>> +
>> +struct dfl_uart {
>> +	int line;
>> +};
>> +
>> +static int dfl_uart_get_params(struct device *dev, void __iomem *dfh_base, resource_size_t max,
>> +			       struct uart_8250_port *uart)
>> +{
>> +	u64 v, fifo_len, reg_width;
>> +	int off;
>> +
>> +	if (!dfhv1_has_params(dfh_base)) {
>> +		dev_err(dev, "missing required DFH parameters\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	off = dfhv1_find_param(dfh_base, max, DFHv1_PARAM_ID_CLK_FRQ);
>> +	if (off < 0) {
>> +		dev_err(dev, "missing CLK_FRQ param\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	uart->port.uartclk = readq(dfh_base + off);
>> +	dev_dbg(dev, "UART_CLK_ID %u Hz\n", uart->port.uartclk);
>> +
>> +	off = dfhv1_find_param(dfh_base, max, DFHv1_PARAM_ID_FIFO_LEN);
>> +	if (off < 0) {
>> +		dev_err(dev, "missing FIFO_LEN param\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	fifo_len = readq(dfh_base + off);
>> +	dev_dbg(dev, "UART_FIFO_ID fifo_len %llu\n", fifo_len);
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
>> +		dev_err(dev, "bad fifo_len %llu\n", fifo_len);
>> +		return -EINVAL;
>> +	}
>> +
>> +	off = dfhv1_find_param(dfh_base, max, DFHv1_PARAM_ID_REG_LAYOUT);
>> +	if (off < 0) {
>> +		dev_err(dev, "missing REG_LAYOUT param\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	v = readq(dfh_base + off);
>> +	uart->port.regshift = FIELD_GET(DFHv1_PARAM_ID_REG_SHIFT, v);
>> +	reg_width = FIELD_GET(DFHv1_PARAM_ID_REG_WIDTH, v);
>> +
>> +	dev_dbg(dev, "UART_LAYOUT_ID width %lld shift %d\n",
>> +		FIELD_GET(DFHv1_PARAM_ID_REG_WIDTH, v), (int)uart->port.regshift);
>> +
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
>> +		dev_err(dev, "invalid reg_width %lld\n", reg_width);
>> +		return -EINVAL;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int dfl_uart_probe(struct dfl_device *dfl_dev)
>> +{
>> +	struct device *dev = &dfl_dev->dev;
>> +	struct uart_8250_port uart;
>> +	struct dfl_uart *dfluart;
>> +	resource_size_t res_size;
>> +	void __iomem *dfh_base;
>> +	int ret;
>> +
>> +	memset(&uart, 0, sizeof(uart));
>> +	uart.port.flags = UPF_IOREMAP;
>> +	uart.port.mapbase = dfl_dev->csr_res.start;
>> +	uart.port.mapsize = resource_size(&dfl_dev->csr_res);
>> +
>> +	dfluart = devm_kzalloc(dev, sizeof(*dfluart), GFP_KERNEL);
>> +	if (!dfluart)
>> +		return -ENOMEM;
>> +
>> +	dfh_base = devm_ioremap_resource(dev, &dfl_dev->mmio_res);
>> +	if (IS_ERR(dfh_base))
>> +		return PTR_ERR(dfh_base);
>> +
>> +	res_size = resource_size(&dfl_dev->mmio_res);
>> +
>> +	ret = dfl_uart_get_params(dev, dfh_base, res_size, &uart);
>
>
> It seems to me that the dfl_uart driver supports only DFHv1 headers.
> So why not checking dfl_dev->dfh_version in dfl_uart_probe() before
> allocating, mapping, and then checking with dfl_uart_get_params()?

Checking dfl_dev->dfh_version at the top of dfl_uart_probe() is a good 
suggestion.  I can also move the call to devm_kzalloc until after the call 
the dfl_uart_get_params.


>
>
>> +
>> +	devm_iounmap(dev, dfh_base);
>> +	devm_release_mem_region(dev, dfl_dev->mmio_res.start, res_size);
>> +
>> +	if (ret < 0)
>> +		return dev_err_probe(dev, ret, "failed uart feature walk\n");
>> +
>> +	dev_dbg(dev, "nr_irqs %d %p\n", dfl_dev->num_irqs, dfl_dev->irqs);
>> +
>> +	if (dfl_dev->num_irqs == 1)
>> +		uart.port.irq = dfl_dev->irqs[0];
>> +
>> +	/* register the port */
>> +	dfluart->line = serial8250_register_8250_port(&uart);
>> +	if (dfluart->line < 0)
>> +		return dev_err_probe(dev, dfluart->line, "unable to register 8250 port.\n");
>> +
>> +	dev_info(dev, "serial8250_register_8250_port %d\n", dfluart->line);
>> +	dev_set_drvdata(dev, dfluart);
>> +
>> +	return 0;
>> +}
>> +
>> +static void dfl_uart_remove(struct dfl_device *dfl_dev)
>> +{
>> +	struct dfl_uart *dfluart = dev_get_drvdata(&dfl_dev->dev);
>> +
>> +	if (dfluart->line >= 0)
>> +		serial8250_unregister_port(dfluart->line);
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
>> index d0b49e15fbf5..5c6497ce5c12 100644
>> --- a/drivers/tty/serial/8250/Kconfig
>> +++ b/drivers/tty/serial/8250/Kconfig
>> @@ -361,6 +361,15 @@ config SERIAL_8250_BCM2835AUX
>>
>>  	  If unsure, say N.
>>
>> +config SERIAL_8250_DFL
>> +	tristate "DFL bus driver for Altera 16550 UART"
>> +	depends on SERIAL_8250 && FPGA_DFL
>> +	help
>> +	  This option enables support for a Device Feature List (DFL) bus
>> +	  driver for the Altera 16650 UART.  One or more Altera 16650 UARTs
>> +	  can be instantiated in a FPGA and then be discovered during
>> +	  enumeration of the DFL bus.
>> +
>>  config SERIAL_8250_FSL
>>  	bool "Freescale 16550 UART support" if COMPILE_TEST && !(PPC || ARM || ARM64)
>>  	depends on SERIAL_8250_CONSOLE
>> diff --git a/drivers/tty/serial/8250/Makefile b/drivers/tty/serial/8250/Makefile
>> index bee908f99ea0..32006e0982d1 100644
>> --- a/drivers/tty/serial/8250/Makefile
>> +++ b/drivers/tty/serial/8250/Makefile
>> @@ -24,6 +24,7 @@ obj-$(CONFIG_SERIAL_8250_CONSOLE)	+= 8250_early.o
>>  obj-$(CONFIG_SERIAL_8250_FOURPORT)	+= 8250_fourport.o
>>  obj-$(CONFIG_SERIAL_8250_ACCENT)	+= 8250_accent.o
>>  obj-$(CONFIG_SERIAL_8250_BOCA)		+= 8250_boca.o
>> +obj-$(CONFIG_SERIAL_8250_DFL)		+= 8250_dfl.o
>>  obj-$(CONFIG_SERIAL_8250_EXAR_ST16C554)	+= 8250_exar_st16c554.o
>>  obj-$(CONFIG_SERIAL_8250_HUB6)		+= 8250_hub6.o
>>  obj-$(CONFIG_SERIAL_8250_FSL)		+= 8250_fsl.o
>
>
> Thanks,
> Marco
>
>
