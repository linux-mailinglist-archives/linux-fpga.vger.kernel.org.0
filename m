Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AC4B5B5D28
	for <lists+linux-fpga@lfdr.de>; Mon, 12 Sep 2022 17:31:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230325AbiILP3c (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 12 Sep 2022 11:29:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230320AbiILP3b (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 12 Sep 2022 11:29:31 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01444229;
        Mon, 12 Sep 2022 08:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662996569; x=1694532569;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=hfayPL3j698ZNRxhwLICEuUsIz1m0Yd4sGU88/h2w7Y=;
  b=Bd9oUONTgDxilgrFjAkvlU9+mralsnj09BGxwehEnvsen3lFLis6vcsb
   T3xfUkO7z2jGK8svRB68v8SRuN3O29oIVkBFprZtRi/6wjXtQMobtQrjl
   cnAnhvJLW3mPhztlDFGPbFFz3HIi3kjk2t4Y59TZzJB69Ih8fte7iyq4U
   YM+Efj5zOQ4gEE5tYRHsKSW2GHPxMCYJeNmHW31HNnxegMMa6slyUjN3U
   EZrdTLD5n2nnAb1yRDmQyF9XtW3N5/wOoKTNAC24TWd1Lr6au5+fr35la
   +V+y4P+ZoUiX4lV4xCheQSomMq2psy212kIAEvPU5JTSlEC5CiVeaQ/BX
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10468"; a="361845066"
X-IronPort-AV: E=Sophos;i="5.93,310,1654585200"; 
   d="scan'208";a="361845066"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2022 08:29:28 -0700
X-IronPort-AV: E=Sophos;i="5.93,310,1654585200"; 
   d="scan'208";a="719803601"
Received: from rhweight-wrk1.ra.intel.com ([137.102.106.139])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2022 08:29:27 -0700
Date:   Mon, 12 Sep 2022 08:29:47 -0700 (PDT)
From:   matthew.gerlach@linux.intel.com
X-X-Sender: mgerlach@rhweight-WRK1
To:     Xu Yilun <yilun.xu@intel.com>
cc:     hao.wu@intel.com, russell.h.weight@intel.com,
        basheer.ahmed.muddebihal@intel.com, trix@redhat.com,
        mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        tianfei.zhang@intel.com, corbet@lwn.net,
        gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        jirislaby@kernel.org, geert+renesas@glider.be,
        andriy.shevchenko@linux.intel.com,
        niklas.soderlund+renesas@ragnatech.se, phil.edworthy@renesas.com,
        macro@orcam.me.uk, johan@kernel.org, lukas@wunner.de
Subject: Re: [PATCH v1 5/5] tty: serial: 8250: add DFL bus driver for Altera
 16550.
In-Reply-To: <Yx2tSicH1M73cISi@yilunxu-OptiPlex-7050>
Message-ID: <alpine.DEB.2.22.394.2209120817490.960392@rhweight-WRK1>
References: <20220906190426.3139760-1-matthew.gerlach@linux.intel.com> <20220906190426.3139760-6-matthew.gerlach@linux.intel.com> <Yx2tSicH1M73cISi@yilunxu-OptiPlex-7050>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



On Sun, 11 Sep 2022, Xu Yilun wrote:

> On 2022-09-06 at 12:04:26 -0700, matthew.gerlach@linux.intel.com wrote:
>> From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>>
>> Add a Device Feature List (DFL) bus driver for the Altera
>> 16550 implementation of UART.
>>
>> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>> ---
>>  drivers/tty/serial/8250/8250_dfl.c | 188 +++++++++++++++++++++++++++++
>>  drivers/tty/serial/8250/Kconfig    |   9 ++
>>  drivers/tty/serial/8250/Makefile   |   1 +
>>  include/linux/dfl.h                |   7 ++
>>  4 files changed, 205 insertions(+)
>>  create mode 100644 drivers/tty/serial/8250/8250_dfl.c
>>
>> diff --git a/drivers/tty/serial/8250/8250_dfl.c b/drivers/tty/serial/8250/8250_dfl.c
>> new file mode 100644
>> index 000000000000..dcf6638a298c
>> --- /dev/null
>> +++ b/drivers/tty/serial/8250/8250_dfl.c
>> @@ -0,0 +1,188 @@
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
>> +#include <linux/dfl.h>
>> +#include <linux/version.h>
>> +#include <linux/serial.h>
>> +#include <linux/serial_8250.h>
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +#include <linux/bitfield.h>
>> +#include <linux/io-64-nonatomic-lo-hi.h>
>> +
>> +struct dfl_uart {
>> +	void __iomem   *csr_base;
>> +	u64             csr_addr;
>> +	unsigned int    csr_size;
>> +	struct device  *dev;
>> +	u64             uart_clk;
>> +	u64             fifo_len;
>> +	unsigned int    fifo_size;
>> +	unsigned int    reg_shift;
>> +	unsigned int    line;
>> +};
>> +
>> +int feature_uart_walk(struct dfl_uart *dfluart, resource_size_t max)
>> +{
>> +	void __iomem *param_base;
>> +	int off;
>> +	u64 v;
>> +
>> +	v = readq(dfluart->csr_base + DFHv1_CSR_ADDR);
>> +	dfluart->csr_addr = FIELD_GET(DFHv1_CSR_ADDR_MASK, v);
>> +
>> +	v = readq(dfluart->csr_base + DFHv1_CSR_SIZE_GRP);
>> +	dfluart->csr_size = FIELD_GET(DFHv1_CSR_SIZE_GRP_SIZE, v);
>
> These are generic for DFHv1, so maybe we parse them in DFL generic code.

I will look into moving this to the DFL generic code.

>
>> +
>> +	if (dfluart->csr_addr == 0 || dfluart->csr_size == 0) {
>> +		dev_err(dfluart->dev, "FIXME bad dfh address and size\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	if (!FIELD_GET(DFHv1_CSR_SIZE_GRP_HAS_PARAMS, v)) {
>> +		dev_err(dfluart->dev, "missing required parameters\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	param_base = dfluart->csr_base + DFHv1_PARAM_HDR;
>
> The same concern.
>
>> +
>> +	off = dfl_find_param(param_base, max, DFHv1_PARAM_ID_CLK_FRQ);
>> +	if (off < 0) {
>> +		dev_err(dfluart->dev, "missing CLK_FRQ param\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	dfluart->uart_clk = readq(param_base + off + DFHv1_PARAM_DATA);
>> +	dev_dbg(dfluart->dev, "UART_CLK_ID %llu Hz\n", dfluart->uart_clk);
>
> I see the DFHv1_PARAM_ID_CLK_FRQ defined in generic dfl.h, is this
> param definition global to all features, or specific to uart?

Certainly uart drivers need to know the input clock frequency in order to 
properly calculate baud rate dividers, but drivers for other features/IP 
blocks may need to know the input clock frequency as well.  On the other 
hand not all drivers need to know the input clock frequency to the 
feature/IP block.

>
> Do we have clear definition of generic parameters vs feature specific
> parameters?

I don't think there is a clear definition of generic versus feature 
specific, but a clock frequency and interrupt information it fairly 
generic.

>
> The concern here is to avoid duplicated parameter parsing for each driver.

I understand the concern about avoiding duplicated parameter parsing.


>
> Thanks,
> Yilun
>
>> +
>> +	off = dfl_find_param(param_base, max, DFHv1_PARAM_ID_FIFO_LEN);
>> +	if (off < 0) {
>> +		dev_err(dfluart->dev, "missing FIFO_LEN param\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	dfluart->fifo_len = readq(param_base + off + DFHv1_PARAM_DATA);
>> +	dev_dbg(dfluart->dev, "UART_FIFO_ID fifo_len %llu\n", dfluart->fifo_len);
>> +
>> +	off = dfl_find_param(param_base, max, DFHv1_PARAM_ID_REG_LAYOUT);
>> +	if (off < 0) {
>> +		dev_err(dfluart->dev, "missing REG_LAYOUT param\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	v = readq(param_base + off + DFHv1_PARAM_DATA);
>> +	dfluart->fifo_size = FIELD_GET(DFHv1_PARAM_ID_REG_WIDTH, v);
>> +	dfluart->reg_shift = FIELD_GET(DFHv1_PARAM_ID_REG_SHIFT, v);
>> +	dev_dbg(dfluart->dev, "UART_LAYOUT_ID width %d shift %d\n",
>> +		dfluart->fifo_size, dfluart->reg_shift);
>> +
>> +	return 0;
>> +}
>> +
>> +static int dfl_uart_probe(struct dfl_device *dfl_dev)
>> +{
>> +	struct device *dev = &dfl_dev->dev;
>> +	struct uart_8250_port uart;
>> +	struct dfl_uart *dfluart;
>> +	int ret;
>> +
>> +	memset(&uart, 0, sizeof(uart));
>> +
>> +	dfluart = devm_kzalloc(dev, sizeof(*dfluart), GFP_KERNEL);
>> +	if (!dfluart)
>> +		return -ENOMEM;
>> +
>> +	dfluart->csr_base = devm_ioremap_resource(dev, &dfl_dev->mmio_res);
>> +	if (IS_ERR(dfluart->csr_base)) {
>> +		dev_err(dev, "failed to get mem resource!\n");
>> +		return PTR_ERR(dfluart->csr_base);
>> +	}
>> +
>> +	dfluart->dev = dev;
>> +
>> +	ret = feature_uart_walk(dfluart, resource_size(&dfl_dev->mmio_res));
>> +	if (ret < 0) {
>> +		dev_err(dev, "failed to uart feature walk %d\n", ret);
>> +		return -EINVAL;
>> +	}
>> +
>> +	dev_dbg(dev, "nr_irqs %d %p\n", dfl_dev->num_irqs, dfl_dev->irqs);
>> +
>> +	if (dfl_dev->num_irqs == 1)
>> +		uart.port.irq = dfl_dev->irqs[0];
>> +
>> +	switch (dfluart->fifo_len) {
>> +	case 32:
>> +		uart.port.type = PORT_ALTR_16550_F32;
>> +		break;
>> +
>> +	case 64:
>> +		uart.port.type = PORT_ALTR_16550_F64;
>> +		break;
>> +
>> +	case 128:
>> +		uart.port.type = PORT_ALTR_16550_F128;
>> +		break;
>> +
>> +	default:
>> +		dev_err(dev, "bad fifo_len %llu\n", dfluart->fifo_len);
>> +		return -EINVAL;
>> +	}
>> +
>> +	uart.port.iotype = UPIO_MEM32;
>> +	uart.port.membase = dfluart->csr_base + dfluart->csr_addr;
>> +	uart.port.mapsize = dfluart->csr_size;
>> +	uart.port.regshift = dfluart->reg_shift;
>> +	uart.port.uartclk = dfluart->uart_clk;
>> +
>> +	/* register the port */
>> +	ret = serial8250_register_8250_port(&uart);
>> +	if (ret < 0) {
>> +		dev_err(dev, "unable to register 8250 port %d.\n", ret);
>> +		return -EINVAL;
>> +	}
>> +	dev_info(dev, "serial8250_register_8250_port %d\n", ret);
>> +	dfluart->line = ret;
>> +	dev_set_drvdata(dev, dfluart);
>> +
>> +	return 0;
>> +}
>> +
>> +static void dfl_uart_remove(struct dfl_device *dfl_dev)
>> +{
>> +	struct dfl_uart *dfluart = dev_get_drvdata(&dfl_dev->dev);
>> +
>> +	if (dfluart->line > 0)
>> +		serial8250_unregister_port(dfluart->line);
>> +}
>> +
>> +#define FME_FEATURE_ID_UART 0x24
>> +
>> +static const struct dfl_device_id dfl_uart_ids[] = {
>> +	{ FME_ID, FME_FEATURE_ID_UART },
>> +	{ }
>> +};
>> +
>> +static struct dfl_driver dfl_uart_driver = {
>> +	.drv = {
>> +		.name = "dfl-uart",
>> +	},
>> +	.id_table = dfl_uart_ids,
>> +	.probe = dfl_uart_probe,
>> +	.remove = dfl_uart_remove,
>> +};
>> +
>> +module_dfl_driver(dfl_uart_driver);
>> +
>> +MODULE_DEVICE_TABLE(dfl, dfl_uart_ids);
>> +MODULE_DESCRIPTION("DFL Intel UART driver");
>> +MODULE_AUTHOR("Intel Corporation");
>> +MODULE_LICENSE("GPL");
>> diff --git a/drivers/tty/serial/8250/Kconfig b/drivers/tty/serial/8250/Kconfig
>> index d0b49e15fbf5..fbb59216ce7f 100644
>> --- a/drivers/tty/serial/8250/Kconfig
>> +++ b/drivers/tty/serial/8250/Kconfig
>> @@ -546,3 +546,12 @@ config SERIAL_OF_PLATFORM
>>  	  are probed through devicetree, including Open Firmware based
>>  	  PowerPC systems and embedded systems on architectures using the
>>  	  flattened device tree format.
>> +
>> +config SERIAL_8250_DFL
>> +	tristate "DFL bus driver for Altera 16550 UART"
>> +	depends on SERIAL_8250 && FPGA_DFL
>> +	help
>> +	  This option enables support for a Device Feature List (DFL) bus
>> +	  driver for the Altera 16650 UART.  One or more Altera 16650 UARTs
>> +	  can be instantiated in a FPGA and then be discovered during
>> +	  enumeration of the DFL bus.
>> diff --git a/drivers/tty/serial/8250/Makefile b/drivers/tty/serial/8250/Makefile
>> index bee908f99ea0..8e987b04820a 100644
>> --- a/drivers/tty/serial/8250/Makefile
>> +++ b/drivers/tty/serial/8250/Makefile
>> @@ -43,5 +43,6 @@ obj-$(CONFIG_SERIAL_8250_PXA)		+= 8250_pxa.o
>>  obj-$(CONFIG_SERIAL_8250_TEGRA)		+= 8250_tegra.o
>>  obj-$(CONFIG_SERIAL_8250_BCM7271)	+= 8250_bcm7271.o
>>  obj-$(CONFIG_SERIAL_OF_PLATFORM)	+= 8250_of.o
>> +obj-$(CONFIG_SERIAL_8250_DFL)		+= 8250_dfl.o
>>
>>  CFLAGS_8250_ingenic.o += -I$(srctree)/scripts/dtc/libfdt
>> diff --git a/include/linux/dfl.h b/include/linux/dfl.h
>> index 5652879ab48e..d37636090fed 100644
>> --- a/include/linux/dfl.h
>> +++ b/include/linux/dfl.h
>> @@ -73,6 +73,13 @@
>>  #define DFHv1_PARAM_MSIX_STARTV	0x8
>>  #define DFHv1_PARAM_MSIX_NUMV	0xc
>>
>> +#define DFHv1_PARAM_ID_CLK_FRQ    0x2
>> +#define DFHv1_PARAM_ID_FIFO_LEN   0x3
>> +
>> +#define DFHv1_PARAM_ID_REG_LAYOUT 0x4
>> +#define DFHv1_PARAM_ID_REG_WIDTH  GENMASK_ULL(63, 32)
>> +#define DFHv1_PARAM_ID_REG_SHIFT  GENMASK_ULL(31, 0)
>> +
>>  /**
>>   * enum dfl_id_type - define the DFL FIU types
>>   */
>> --
>> 2.25.1
>>
>
