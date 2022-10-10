Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8AE75FA095
	for <lists+linux-fpga@lfdr.de>; Mon, 10 Oct 2022 16:55:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbiJJOxQ (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 10 Oct 2022 10:53:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbiJJOxQ (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 10 Oct 2022 10:53:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09EC8326E4
        for <linux-fpga@vger.kernel.org>; Mon, 10 Oct 2022 07:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665413594;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ppdAHziEVuq8s62lKVdmn9/Ee5D1B4rjqScUg9W2iYw=;
        b=CJFQ3VRBOivfEGtvw+CHF8aG53BNnP0PQ00eWe5oFIHVv5TJ7ZvLLsqfocCbzjXWJgh9ES
        mQXiPFSAbKI7G2CeAj4DE9fxeywhPBGXugDLgP/UeZlIxJq7R7aQZgxv12woCXrkMqTwec
        Ro+mKXYyULqbrlliBdhUGN1YSVlh/fY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-625-nxKlW6QCMyCRw5-hgXlD3w-1; Mon, 10 Oct 2022 10:53:13 -0400
X-MC-Unique: nxKlW6QCMyCRw5-hgXlD3w-1
Received: by mail-wm1-f72.google.com with SMTP id n6-20020a7bc5c6000000b003c6bbe5d5cfso1207999wmk.4
        for <linux-fpga@vger.kernel.org>; Mon, 10 Oct 2022 07:53:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ppdAHziEVuq8s62lKVdmn9/Ee5D1B4rjqScUg9W2iYw=;
        b=hkSjuvdUyaASTLCUXpaLZ5K3k00NhzgDyR9Wq87Y2WQZX959g2jywS1pt4pJ7LJ81c
         6vBX7tJRBZt2a9PmTssfDlps/Bso4lfxpG3xNbXzwNnsrATxKzKFzXSrwDoWyY9EHxKI
         23hVSc0sc4demWVIxkparrpnmsfR6O+NeEsT3C+ajjlUPAeG4r+X9G3Qw6k46y2lZRZA
         VgFiLypgDA0dEr2QVZOZ90kaehsD14zaALwtBnl92pCG1aoY+5k8/KsLkWHZJbVA76v7
         e15l6FxwgdGlNLT9smYRKzs1z2PrIgAoeMmC0PxXdN2/VzG1WIowqIbIWs64mVil5I49
         63BQ==
X-Gm-Message-State: ACrzQf1Po4wLZVrM9bygc8CES3r/vjE4+WN+DNIqOkrJxD4FE+E1HcOI
        S3NH/fGWj7pV97mHPRw1iq7G+tHUE2ZhfGm3ZCCCwQIjcanK+INMChdwxRzDMjYZxi8dSrmV2NV
        dQ73XgJuRhd3uNN2Cw7Qg
X-Received: by 2002:a05:6000:18c7:b0:22e:5503:9c46 with SMTP id w7-20020a05600018c700b0022e55039c46mr11131485wrq.668.1665413590037;
        Mon, 10 Oct 2022 07:53:10 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7NHdp4VIhWLIxsicDWsx8OBqC9INB3sSxqTr86oYPzzmBiwkSfLkjUgI1pGYsZXTiYKD1Q1g==
X-Received: by 2002:a05:6000:18c7:b0:22e:5503:9c46 with SMTP id w7-20020a05600018c700b0022e55039c46mr11131467wrq.668.1665413589815;
        Mon, 10 Oct 2022 07:53:09 -0700 (PDT)
Received: from [192.168.9.16] (net-2-34-29-141.cust.vodafonedsl.it. [2.34.29.141])
        by smtp.gmail.com with ESMTPSA id c8-20020a05600c0a4800b003b4fdbb6319sm18078667wmq.21.2022.10.10.07.53.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Oct 2022 07:53:09 -0700 (PDT)
Message-ID: <cfd34b7c-d5eb-5087-5b9f-9577807fc09b@redhat.com>
Date:   Mon, 10 Oct 2022 16:53:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
To:     matthew.gerlach@linux.intel.com
Cc:     andriy.shevchenko@linux.intel.com,
        basheer.ahmed.muddebihal@intel.com, corbet@lwn.net,
        geert+renesas@glider.be, gregkh@linuxfoundation.org,
        hao.wu@intel.com, jirislaby@kernel.org, johan@kernel.org,
        linux-doc@vger.kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        lkp@intel.com, lukas@wunner.de, macro@orcam.me.uk, mdf@kernel.org,
        niklas.soderlund+renesas@ragnatech.se, russell.h.weight@intel.com,
        tianfei.zhang@intel.com, trix@redhat.com, yilun.xu@intel.com
References: <20221004143718.1076710-5-matthew.gerlach@linux.intel.com>
Subject: Re: [PATCH v3 4/4] tty: serial: 8250: add DFL bus driver for Altera
 16550.
Content-Language: en-US
From:   Marco Pagani <marpagan@redhat.com>
In-Reply-To: <20221004143718.1076710-5-matthew.gerlach@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 2022-10-04 16:37, matthew.gerlach@linux.intel.com wrote:
> From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> 
> Add a Device Feature List (DFL) bus driver for the Altera
> 16550 implementation of UART.
> 
> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> Reported-by: kernel test robot <lkp@intel.com>
> ---
> v3: use passed in location of registers
>     use cleaned up functions for parsing parameters
> 
> v2: clean up error messages
>     alphabetize header files
>     fix 'missing prototype' error by making function static
>     tried to sort Makefile and Kconfig better
> ---
>  drivers/tty/serial/8250/8250_dfl.c | 177 +++++++++++++++++++++++++++++
>  drivers/tty/serial/8250/Kconfig    |   9 ++
>  drivers/tty/serial/8250/Makefile   |   1 +
>  3 files changed, 187 insertions(+)
>  create mode 100644 drivers/tty/serial/8250/8250_dfl.c
> 
> diff --git a/drivers/tty/serial/8250/8250_dfl.c b/drivers/tty/serial/8250/8250_dfl.c
> new file mode 100644
> index 000000000000..110ad3a73459
> --- /dev/null
> +++ b/drivers/tty/serial/8250/8250_dfl.c
> @@ -0,0 +1,177 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Driver for FPGA UART
> + *
> + * Copyright (C) 2022 Intel Corporation, Inc.
> + *
> + * Authors:
> + *   Ananda Ravuri <ananda.ravuri@intel.com>
> + *   Matthew Gerlach <matthew.gerlach@linux.intel.com>
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/dfl.h>
> +#include <linux/io-64-nonatomic-lo-hi.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/serial.h>
> +#include <linux/serial_8250.h>
> +
> +struct dfl_uart {
> +	int line;
> +};
> +
> +static int dfl_uart_get_params(struct device *dev, void __iomem *dfh_base, resource_size_t max,
> +			       struct uart_8250_port *uart)
> +{
> +	u64 v, fifo_len, reg_width;
> +	int off;
> +
> +	if (!dfhv1_has_params(dfh_base)) {
> +		dev_err(dev, "missing required DFH parameters\n");
> +		return -EINVAL;
> +	}
> +
> +	off = dfhv1_find_param(dfh_base, max, DFHv1_PARAM_ID_CLK_FRQ);
> +	if (off < 0) {
> +		dev_err(dev, "missing CLK_FRQ param\n");
> +		return -EINVAL;
> +	}
> +
> +	uart->port.uartclk = readq(dfh_base + off);
> +	dev_dbg(dev, "UART_CLK_ID %u Hz\n", uart->port.uartclk);
> +
> +	off = dfhv1_find_param(dfh_base, max, DFHv1_PARAM_ID_FIFO_LEN);
> +	if (off < 0) {
> +		dev_err(dev, "missing FIFO_LEN param\n");
> +		return -EINVAL;
> +	}
> +
> +	fifo_len = readq(dfh_base + off);
> +	dev_dbg(dev, "UART_FIFO_ID fifo_len %llu\n", fifo_len);
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
> +		dev_err(dev, "bad fifo_len %llu\n", fifo_len);
> +		return -EINVAL;
> +	}
> +
> +	off = dfhv1_find_param(dfh_base, max, DFHv1_PARAM_ID_REG_LAYOUT);
> +	if (off < 0) {
> +		dev_err(dev, "missing REG_LAYOUT param\n");
> +		return -EINVAL;
> +	}
> +
> +	v = readq(dfh_base + off);
> +	uart->port.regshift = FIELD_GET(DFHv1_PARAM_ID_REG_SHIFT, v);
> +	reg_width = FIELD_GET(DFHv1_PARAM_ID_REG_WIDTH, v);
> +
> +	dev_dbg(dev, "UART_LAYOUT_ID width %lld shift %d\n",
> +		FIELD_GET(DFHv1_PARAM_ID_REG_WIDTH, v), (int)uart->port.regshift);
> +
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
> +		dev_err(dev, "invalid reg_width %lld\n", reg_width);
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int dfl_uart_probe(struct dfl_device *dfl_dev)
> +{
> +	struct device *dev = &dfl_dev->dev;
> +	struct uart_8250_port uart;
> +	struct dfl_uart *dfluart;
> +	resource_size_t res_size;
> +	void __iomem *dfh_base;
> +	int ret;
> +
> +	memset(&uart, 0, sizeof(uart));
> +	uart.port.flags = UPF_IOREMAP;
> +	uart.port.mapbase = dfl_dev->csr_res.start;
> +	uart.port.mapsize = resource_size(&dfl_dev->csr_res);
> +
> +	dfluart = devm_kzalloc(dev, sizeof(*dfluart), GFP_KERNEL);
> +	if (!dfluart)
> +		return -ENOMEM;
> +
> +	dfh_base = devm_ioremap_resource(dev, &dfl_dev->mmio_res);
> +	if (IS_ERR(dfh_base))
> +		return PTR_ERR(dfh_base);
> +
> +	res_size = resource_size(&dfl_dev->mmio_res);
> +
> +	ret = dfl_uart_get_params(dev, dfh_base, res_size, &uart);


It seems to me that the dfl_uart driver supports only DFHv1 headers.
So why not checking dfl_dev->dfh_version in dfl_uart_probe() before
allocating, mapping, and then checking with dfl_uart_get_params()?


> +
> +	devm_iounmap(dev, dfh_base);
> +	devm_release_mem_region(dev, dfl_dev->mmio_res.start, res_size);
> +
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "failed uart feature walk\n");
> +
> +	dev_dbg(dev, "nr_irqs %d %p\n", dfl_dev->num_irqs, dfl_dev->irqs);
> +
> +	if (dfl_dev->num_irqs == 1)
> +		uart.port.irq = dfl_dev->irqs[0];
> +
> +	/* register the port */
> +	dfluart->line = serial8250_register_8250_port(&uart);
> +	if (dfluart->line < 0)
> +		return dev_err_probe(dev, dfluart->line, "unable to register 8250 port.\n");
> +
> +	dev_info(dev, "serial8250_register_8250_port %d\n", dfluart->line);
> +	dev_set_drvdata(dev, dfluart);
> +
> +	return 0;
> +}
> +
> +static void dfl_uart_remove(struct dfl_device *dfl_dev)
> +{
> +	struct dfl_uart *dfluart = dev_get_drvdata(&dfl_dev->dev);
> +
> +	if (dfluart->line >= 0)
> +		serial8250_unregister_port(dfluart->line);
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
> index d0b49e15fbf5..5c6497ce5c12 100644
> --- a/drivers/tty/serial/8250/Kconfig
> +++ b/drivers/tty/serial/8250/Kconfig
> @@ -361,6 +361,15 @@ config SERIAL_8250_BCM2835AUX
>  
>  	  If unsure, say N.
>  
> +config SERIAL_8250_DFL
> +	tristate "DFL bus driver for Altera 16550 UART"
> +	depends on SERIAL_8250 && FPGA_DFL
> +	help
> +	  This option enables support for a Device Feature List (DFL) bus
> +	  driver for the Altera 16650 UART.  One or more Altera 16650 UARTs
> +	  can be instantiated in a FPGA and then be discovered during
> +	  enumeration of the DFL bus.
> +
>  config SERIAL_8250_FSL
>  	bool "Freescale 16550 UART support" if COMPILE_TEST && !(PPC || ARM || ARM64)
>  	depends on SERIAL_8250_CONSOLE
> diff --git a/drivers/tty/serial/8250/Makefile b/drivers/tty/serial/8250/Makefile
> index bee908f99ea0..32006e0982d1 100644
> --- a/drivers/tty/serial/8250/Makefile
> +++ b/drivers/tty/serial/8250/Makefile
> @@ -24,6 +24,7 @@ obj-$(CONFIG_SERIAL_8250_CONSOLE)	+= 8250_early.o
>  obj-$(CONFIG_SERIAL_8250_FOURPORT)	+= 8250_fourport.o
>  obj-$(CONFIG_SERIAL_8250_ACCENT)	+= 8250_accent.o
>  obj-$(CONFIG_SERIAL_8250_BOCA)		+= 8250_boca.o
> +obj-$(CONFIG_SERIAL_8250_DFL)		+= 8250_dfl.o
>  obj-$(CONFIG_SERIAL_8250_EXAR_ST16C554)	+= 8250_exar_st16c554.o
>  obj-$(CONFIG_SERIAL_8250_HUB6)		+= 8250_hub6.o
>  obj-$(CONFIG_SERIAL_8250_FSL)		+= 8250_fsl.o


Thanks,
Marco

