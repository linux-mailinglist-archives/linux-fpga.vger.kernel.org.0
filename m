Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6F56670F04
	for <lists+linux-fpga@lfdr.de>; Wed, 18 Jan 2023 01:49:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbjARArj (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 17 Jan 2023 19:47:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbjARArI (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 17 Jan 2023 19:47:08 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AFCC4497;
        Tue, 17 Jan 2023 16:31:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674001907; x=1705537907;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=62EDyxsF4lIIGJBsxN/0U5ODRNkedVcoG4tlga2KVug=;
  b=XjjrddGqVM+5my6mNoHZJERrqWDxhX08z/IcAPjprjmK/s6gcZ0abLQb
   /R2mmxzdNWo0Rw11zmSydFUO3KQGTwxbwpDKSguzPPHChuZyigW6CbkSy
   WCuYZW981gFsTKdtIm7kQ7egdFkojnwd+MRsI94xHTznsZNv90s1ZerEX
   Ww5wWCQSZLDcOgZYYi6fOPuhGaz/9JZ74Q378ocdoktTIVRzcTsLglv9r
   KUxfbu1QRZbviLksWHG5P1NrMktigdKyLMwz9DTW0FvQv2RpIOneNP/qf
   LacM537O3nMCwRdyt4yyOGL6H0vxTliovyklhiY//1DMq/DPc5+lDtYEC
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10593"; a="352106436"
X-IronPort-AV: E=Sophos;i="5.97,224,1669104000"; 
   d="scan'208";a="352106436"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2023 16:31:46 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10593"; a="783448333"
X-IronPort-AV: E=Sophos;i="5.97,224,1669104000"; 
   d="scan'208";a="783448333"
Received: from rhweight-wrk1.ra.intel.com ([137.102.106.43])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2023 16:31:46 -0800
Date:   Tue, 17 Jan 2023 16:32:19 -0800 (PST)
From:   matthew.gerlach@linux.intel.com
X-X-Sender: mgerlach@rhweight-WRK1
To:     Marco Pagani <marpagan@redhat.com>
cc:     andriy.shevchenko@linux.intel.com, bagasdotme@gmail.com,
        basheer.ahmed.muddebihal@intel.com, corbet@lwn.net,
        geert+renesas@glider.be, gregkh@linuxfoundation.org,
        hao.wu@intel.com, ilpo.jarvinen@linux.intel.com,
        jirislaby@kernel.org, johan@kernel.org, linux-doc@vger.kernel.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, lukas@wunner.de, macro@orcam.me.uk,
        mdf@kernel.org, niklas.soderlund+renesas@ragnatech.se,
        russell.h.weight@intel.com, tianfei.zhang@intel.com,
        trix@redhat.com, yilun.xu@intel.com
Subject: Re: [PATCH v11 4/4] tty: serial: 8250: add DFL bus driver for Altera
 16550.
In-Reply-To: <28f1f1bf-d490-2630-d41f-1344baa0eea9@redhat.com>
Message-ID: <alpine.DEB.2.22.394.2301171631550.1389057@rhweight-WRK1>
References: <20230115151447.1353428-1-matthew.gerlach@linux.intel.com> <20230115151447.1353428-5-matthew.gerlach@linux.intel.com> <28f1f1bf-d490-2630-d41f-1344baa0eea9@redhat.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-448638966-1674001943=:1389057"
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-448638966-1674001943=:1389057
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT



On Mon, 16 Jan 2023, Marco Pagani wrote:

>
> On 2023-01-15 16:14, matthew.gerlach@linux.intel.com wrote:
>> From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>>
>> Add a Device Feature List (DFL) bus driver for the Altera
>> 16550 implementation of UART.
>>
>> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>> Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
>> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>
> Reviewed-by: Marco Pagani <marpagan@redhat.com>

Thanks for the review,
Matthew Gerlach

>
>> ---
>> v11: sizeof(u64) -> sizeof(*pval)
>>      16650 -> 16550
>>
>> v10: track change to dfh_find_param()
>>
>> v9: add Rb Andy Shevchenko
>>     move dfh_get_u64_param_vals to static version of dfh_get_u64_param_val
>>
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
>>  drivers/tty/serial/8250/8250_dfl.c | 167 +++++++++++++++++++++++++++++
>>  drivers/tty/serial/8250/Kconfig    |  12 +++
>>  drivers/tty/serial/8250/Makefile   |   1 +
>>  3 files changed, 180 insertions(+)
>>  create mode 100644 drivers/tty/serial/8250/8250_dfl.c
>>
>> diff --git a/drivers/tty/serial/8250/8250_dfl.c b/drivers/tty/serial/8250/8250_dfl.c
>> new file mode 100644
>> index 000000000000..6c5ff019df4b
>> --- /dev/null
>> +++ b/drivers/tty/serial/8250/8250_dfl.c
>> @@ -0,0 +1,167 @@
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
>> +static int dfh_get_u64_param_val(struct dfl_device *dfl_dev, int param_id, u64 *pval)
>> +{
>> +	size_t psize;
>> +	u64 *p;
>> +
>> +	p = dfh_find_param(dfl_dev, param_id, &psize);
>> +	if (IS_ERR(p))
>> +		return PTR_ERR(p);
>> +
>> +	if (psize != sizeof(*pval))
>> +		return -EINVAL;
>> +
>> +	*pval = *p;
>> +
>> +	return 0;
>> +}
>> +
>> +static int dfl_uart_get_params(struct dfl_device *dfl_dev, struct uart_8250_port *uart)
>> +{
>> +	struct device *dev = &dfl_dev->dev;
>> +	u64 fifo_len, clk_freq, reg_layout;
>> +	u32 reg_width;
>> +	int ret;
>> +
>> +	ret = dfh_get_u64_param_val(dfl_dev, DFHv1_PARAM_ID_CLK_FRQ, &clk_freq);
>> +	if (ret)
>> +		return dev_err_probe(dev, ret, "missing CLK_FRQ param\n");
>> +
>> +	uart->port.uartclk = clk_freq;
>> +
>> +	ret = dfh_get_u64_param_val(dfl_dev, DFHv1_PARAM_ID_FIFO_LEN, &fifo_len);
>> +	if (ret)
>> +		return dev_err_probe(dev, ret, "missing FIFO_LEN param\n");
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
>> +	ret = dfh_get_u64_param_val(dfl_dev, DFHv1_PARAM_ID_REG_LAYOUT, &reg_layout);
>> +	if (ret)
>> +		return dev_err_probe(dev, ret, "missing REG_LAYOUT param\n");
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
>> index b0f62345bc84..020ef532940d 100644
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
>> +	  driver for the Altera 16550 UART. One or more Altera 16550 UARTs
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
>
>
--8323328-448638966-1674001943=:1389057--
