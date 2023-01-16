Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7E5266CF01
	for <lists+linux-fpga@lfdr.de>; Mon, 16 Jan 2023 19:40:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234683AbjAPSjM (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 16 Jan 2023 13:39:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235055AbjAPSi1 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 16 Jan 2023 13:38:27 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F4EE2A160
        for <linux-fpga@vger.kernel.org>; Mon, 16 Jan 2023 10:29:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673893739;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DfE/0f7WicUarpkQ6xDKer55vlLFOFPNhSrmueY6UH0=;
        b=hvnaz0NKBdSTqO/EoePrJlgMNEEShLR+7OWKnLE0TWPsAQDda69vk5Oq594oh871BVHFZb
        a+/EJJUgx1ZODEFUn7xUgo6acx2n0Xo+GG2OatQtapDOszrJrQ+gxCDKoYubuAzZe7lJjN
        N/XQTH2C2DU/m5UcNtxNGk7lLrJMmlA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-252-R_TT1zGDP52EqxFFSISyXg-1; Mon, 16 Jan 2023 13:28:58 -0500
X-MC-Unique: R_TT1zGDP52EqxFFSISyXg-1
Received: by mail-wr1-f70.google.com with SMTP id i2-20020adfaac2000000b002bc40f98167so4791816wrc.2
        for <linux-fpga@vger.kernel.org>; Mon, 16 Jan 2023 10:28:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DfE/0f7WicUarpkQ6xDKer55vlLFOFPNhSrmueY6UH0=;
        b=IWwB8In60yR9LfG4baSTQBlpt0ZmXKHvqtQ+hbng9Sk/gxV/6uToLM9Pp1OhneILeP
         wlXkUyLRXIS1M0gIgNWPbgqTl3pPxgJGQFJPHbONpsNI7tySj7HDxh2970HZmdph4xuW
         TmzneZ1n+dnFpgQ/+A40mpyPGx14R0t8i3EPE5FTFL7A62mk0KQsZ4tbF9LD7n4tK41W
         L8nYYfBhurRtLuxqxBRy50PMc7CbauZivedVAynUR0soUuHuhhfC7FzLbRdTMGH9CA4r
         V12w73GJAXLZUbzwt07mlYqvnSAD/a9+Pj8nMUjCvQi5tXQeVTbPhlpJ2J1UhEhqSRoe
         BHcA==
X-Gm-Message-State: AFqh2kpgZ+H2dUyZMsXktFTgG2Zz/Le8rceOoy7MBfDDN3AxbG1oLIA3
        AOubd11Bb2bmrs8CMkiqd7DL752JAkozssfUEB+w/T98K6DH9ffU9hc1CTP8abk03CpHW2Z4J7Q
        qUXfDXcDvQEnA9FMsLt+1
X-Received: by 2002:a1c:7415:0:b0:3da:fd07:1e3 with SMTP id p21-20020a1c7415000000b003dafd0701e3mr418538wmc.22.1673893736364;
        Mon, 16 Jan 2023 10:28:56 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvV870LGFYDRPc4DzkE5HF0Vy/AvtCIRmRYLTNYiUIhmJUMPByHsR2pTQhgRTCP0dBKTbiKqg==
X-Received: by 2002:a1c:7415:0:b0:3da:fd07:1e3 with SMTP id p21-20020a1c7415000000b003dafd0701e3mr418524wmc.22.1673893736156;
        Mon, 16 Jan 2023 10:28:56 -0800 (PST)
Received: from [192.168.9.16] (net-2-34-30-183.cust.vodafonedsl.it. [2.34.30.183])
        by smtp.gmail.com with ESMTPSA id d8-20020a05600c34c800b003c5571c27a1sm41738207wmq.32.2023.01.16.10.28.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Jan 2023 10:28:55 -0800 (PST)
Message-ID: <28f1f1bf-d490-2630-d41f-1344baa0eea9@redhat.com>
Date:   Mon, 16 Jan 2023 19:28:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v11 4/4] tty: serial: 8250: add DFL bus driver for Altera
 16550.
To:     Matthew Gerlach <matthew.gerlach@linux.intel.com>
References: <20230115151447.1353428-1-matthew.gerlach@linux.intel.com>
 <20230115151447.1353428-5-matthew.gerlach@linux.intel.com>
Content-Language: en-US
Cc:     andriy.shevchenko@linux.intel.com, bagasdotme@gmail.com,
        basheer.ahmed.muddebihal@intel.com, corbet@lwn.net,
        geert+renesas@glider.be, gregkh@linuxfoundation.org,
        hao.wu@intel.com, ilpo.jarvinen@linux.intel.com,
        jirislaby@kernel.org, johan@kernel.org, linux-doc@vger.kernel.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, lukas@wunner.de, macro@orcam.me.uk,
        marpagan@redhat.com, mdf@kernel.org,
        niklas.soderlund+renesas@ragnatech.se, russell.h.weight@intel.com,
        tianfei.zhang@intel.com, trix@redhat.com, yilun.xu@intel.com
From:   Marco Pagani <marpagan@redhat.com>
In-Reply-To: <20230115151447.1353428-5-matthew.gerlach@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 2023-01-15 16:14, matthew.gerlach@linux.intel.com wrote:
> From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> 
> Add a Device Feature List (DFL) bus driver for the Altera
> 16550 implementation of UART.
> 
> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Marco Pagani <marpagan@redhat.com>

> ---
> v11: sizeof(u64) -> sizeof(*pval)
>      16650 -> 16550
> 
> v10: track change to dfh_find_param()
> 
> v9: add Rb Andy Shevchenko
>     move dfh_get_u64_param_vals to static version of dfh_get_u64_param_val
> 
> v8: use dfh_get_u64_param_vals()
> 
> v7: no change
> 
> v6: move driver specific parameter definitions to limit scope
> 
> v5: removed unneeded blank line
>     removed unneeded includes
>     included device.h and types.h
>     removed unneeded local variable
>     remove calls to dev_dbg
>     memset -> { }
>     remove space after period
>     explicitly include used headers
>     remove redundant Inc from Copyright
>     fix format specifier
> 
> v4: use dev_err_probe() everywhere that is appropriate
>     clean up noise
>     change error messages to use the word, unsupported
>     tried again to sort Makefile and KConfig better
>     reorder probe function for easier error handling
>     use new dfh_find_param API
> 
> v3: use passed in location of registers
>     use cleaned up functions for parsing parameters
> 
> v2: clean up error messages
>     alphabetize header files
>     fix 'missing prototype' error by making function static
>     tried to sort Makefile and Kconfig better
> ---
>  drivers/tty/serial/8250/8250_dfl.c | 167 +++++++++++++++++++++++++++++
>  drivers/tty/serial/8250/Kconfig    |  12 +++
>  drivers/tty/serial/8250/Makefile   |   1 +
>  3 files changed, 180 insertions(+)
>  create mode 100644 drivers/tty/serial/8250/8250_dfl.c
> 
> diff --git a/drivers/tty/serial/8250/8250_dfl.c b/drivers/tty/serial/8250/8250_dfl.c
> new file mode 100644
> index 000000000000..6c5ff019df4b
> --- /dev/null
> +++ b/drivers/tty/serial/8250/8250_dfl.c
> @@ -0,0 +1,167 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Driver for FPGA UART
> + *
> + * Copyright (C) 2022 Intel Corporation.
> + *
> + * Authors:
> + *   Ananda Ravuri <ananda.ravuri@intel.com>
> + *   Matthew Gerlach <matthew.gerlach@linux.intel.com>
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/device.h>
> +#include <linux/dfl.h>
> +#include <linux/errno.h>
> +#include <linux/ioport.h>
> +#include <linux/module.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/types.h>
> +
> +#include <linux/serial.h>
> +#include <linux/serial_8250.h>
> +
> +#define DFHv1_PARAM_ID_CLK_FRQ    0x2
> +#define DFHv1_PARAM_ID_FIFO_LEN   0x3
> +
> +#define DFHv1_PARAM_ID_REG_LAYOUT	0x4
> +#define DFHv1_PARAM_REG_LAYOUT_WIDTH	GENMASK_ULL(63, 32)
> +#define DFHv1_PARAM_REG_LAYOUT_SHIFT	GENMASK_ULL(31, 0)
> +
> +struct dfl_uart {
> +	int line;
> +};
> +
> +static int dfh_get_u64_param_val(struct dfl_device *dfl_dev, int param_id, u64 *pval)
> +{
> +	size_t psize;
> +	u64 *p;
> +
> +	p = dfh_find_param(dfl_dev, param_id, &psize);
> +	if (IS_ERR(p))
> +		return PTR_ERR(p);
> +
> +	if (psize != sizeof(*pval))
> +		return -EINVAL;
> +
> +	*pval = *p;
> +
> +	return 0;
> +}
> +
> +static int dfl_uart_get_params(struct dfl_device *dfl_dev, struct uart_8250_port *uart)
> +{
> +	struct device *dev = &dfl_dev->dev;
> +	u64 fifo_len, clk_freq, reg_layout;
> +	u32 reg_width;
> +	int ret;
> +
> +	ret = dfh_get_u64_param_val(dfl_dev, DFHv1_PARAM_ID_CLK_FRQ, &clk_freq);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "missing CLK_FRQ param\n");
> +
> +	uart->port.uartclk = clk_freq;
> +
> +	ret = dfh_get_u64_param_val(dfl_dev, DFHv1_PARAM_ID_FIFO_LEN, &fifo_len);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "missing FIFO_LEN param\n");
> +
> +	switch (fifo_len) {
> +	case 32:
> +		uart->port.type = PORT_ALTR_16550_F32;
> +		break;
> +
> +	case 64:
> +		uart->port.type = PORT_ALTR_16550_F64;
> +		break;
> +
> +	case 128:
> +		uart->port.type = PORT_ALTR_16550_F128;
> +		break;
> +
> +	default:
> +		return dev_err_probe(dev, -EINVAL, "unsupported FIFO_LEN %llu\n", fifo_len);
> +	}
> +
> +	ret = dfh_get_u64_param_val(dfl_dev, DFHv1_PARAM_ID_REG_LAYOUT, &reg_layout);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "missing REG_LAYOUT param\n");
> +
> +	uart->port.regshift = FIELD_GET(DFHv1_PARAM_REG_LAYOUT_SHIFT, reg_layout);
> +	reg_width = FIELD_GET(DFHv1_PARAM_REG_LAYOUT_WIDTH, reg_layout);
> +	switch (reg_width) {
> +	case 4:
> +		uart->port.iotype = UPIO_MEM32;
> +		break;
> +
> +	case 2:
> +		uart->port.iotype = UPIO_MEM16;
> +		break;
> +
> +	default:
> +		return dev_err_probe(dev, -EINVAL, "unsupported reg-width %u\n", reg_width);
> +
> +	}
> +
> +	return 0;
> +}
> +
> +static int dfl_uart_probe(struct dfl_device *dfl_dev)
> +{
> +	struct device *dev = &dfl_dev->dev;
> +	struct uart_8250_port uart = { };
> +	struct dfl_uart *dfluart;
> +	int ret;
> +
> +	uart.port.flags = UPF_IOREMAP;
> +	uart.port.mapbase = dfl_dev->mmio_res.start;
> +	uart.port.mapsize = resource_size(&dfl_dev->mmio_res);
> +
> +	ret = dfl_uart_get_params(dfl_dev, &uart);
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "failed uart feature walk\n");
> +
> +	if (dfl_dev->num_irqs == 1)
> +		uart.port.irq = dfl_dev->irqs[0];
> +
> +	dfluart = devm_kzalloc(dev, sizeof(*dfluart), GFP_KERNEL);
> +	if (!dfluart)
> +		return -ENOMEM;
> +
> +	dfluart->line = serial8250_register_8250_port(&uart);
> +	if (dfluart->line < 0)
> +		return dev_err_probe(dev, dfluart->line, "unable to register 8250 port.\n");
> +
> +	dev_set_drvdata(dev, dfluart);
> +
> +	return 0;
> +}
> +
> +static void dfl_uart_remove(struct dfl_device *dfl_dev)
> +{
> +	struct dfl_uart *dfluart = dev_get_drvdata(&dfl_dev->dev);
> +
> +	serial8250_unregister_port(dfluart->line);
> +}
> +
> +#define FME_FEATURE_ID_UART 0x24
> +
> +static const struct dfl_device_id dfl_uart_ids[] = {
> +	{ FME_ID, FME_FEATURE_ID_UART },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(dfl, dfl_uart_ids);
> +
> +static struct dfl_driver dfl_uart_driver = {
> +	.drv = {
> +		.name = "dfl-uart",
> +	},
> +	.id_table = dfl_uart_ids,
> +	.probe = dfl_uart_probe,
> +	.remove = dfl_uart_remove,
> +};
> +module_dfl_driver(dfl_uart_driver);
> +
> +MODULE_DESCRIPTION("DFL Intel UART driver");
> +MODULE_AUTHOR("Intel Corporation");
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/tty/serial/8250/Kconfig b/drivers/tty/serial/8250/Kconfig
> index b0f62345bc84..020ef532940d 100644
> --- a/drivers/tty/serial/8250/Kconfig
> +++ b/drivers/tty/serial/8250/Kconfig
> @@ -370,6 +370,18 @@ config SERIAL_8250_FSL
>  	  erratum for Freescale 16550 UARTs in the 8250 driver. It also
>  	  enables support for ACPI enumeration.
>  
> +config SERIAL_8250_DFL
> +	tristate "DFL bus driver for Altera 16550 UART"
> +	depends on SERIAL_8250 && FPGA_DFL
> +	help
> +	  This option enables support for a Device Feature List (DFL) bus
> +	  driver for the Altera 16550 UART. One or more Altera 16550 UARTs
> +	  can be instantiated in a FPGA and then be discovered during
> +	  enumeration of the DFL bus.
> +
> +	  To compile this driver as a module, chose M here: the
> +	  module will be called 8250_dfl.
> +
>  config SERIAL_8250_DW
>  	tristate "Support for Synopsys DesignWare 8250 quirks"
>  	depends on SERIAL_8250
> diff --git a/drivers/tty/serial/8250/Makefile b/drivers/tty/serial/8250/Makefile
> index 1615bfdde2a0..4e1a32812683 100644
> --- a/drivers/tty/serial/8250/Makefile
> +++ b/drivers/tty/serial/8250/Makefile
> @@ -28,6 +28,7 @@ obj-$(CONFIG_SERIAL_8250_EXAR_ST16C554)	+= 8250_exar_st16c554.o
>  obj-$(CONFIG_SERIAL_8250_HUB6)		+= 8250_hub6.o
>  obj-$(CONFIG_SERIAL_8250_FSL)		+= 8250_fsl.o
>  obj-$(CONFIG_SERIAL_8250_MEN_MCB)	+= 8250_men_mcb.o
> +obj-$(CONFIG_SERIAL_8250_DFL)		+= 8250_dfl.o
>  obj-$(CONFIG_SERIAL_8250_DW)		+= 8250_dw.o
>  obj-$(CONFIG_SERIAL_8250_EM)		+= 8250_em.o
>  obj-$(CONFIG_SERIAL_8250_IOC3)		+= 8250_ioc3.o

