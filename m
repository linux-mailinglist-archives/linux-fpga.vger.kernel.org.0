Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E36BF5B25BA
	for <lists+linux-fpga@lfdr.de>; Thu,  8 Sep 2022 20:28:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbiIHS0z (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 8 Sep 2022 14:26:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbiIHS0y (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 8 Sep 2022 14:26:54 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D79BC80536;
        Thu,  8 Sep 2022 11:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662661613; x=1694197613;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=XCN+nznFK/T3/KATNNPaflYV2XfXuH0BnwglpOubXP4=;
  b=QgJvsi8CpjS5uGka2WJyBqiAzibsaVzlT+hwyplX3m7ZUMZP3/L+In2+
   ZGYdxcgcSSBML3BkFmm3AddRVUtdH1qySpc1wAew8zKaKlPTuH4rAxJdA
   rk+iB9xGbOsOU8OGMMkZ5gIgpPPNLwkL2SvL49AJf01mZkiJR458TtjWm
   NEf4ltqCxIrQIjCPvqeW0/akiWPWql0IPLWJq+pot7ToUYka1IvRc8Ap5
   nARt1g9VFYR5nvuf+rNWqaniFi+fJ6qYxK3DJFbQfyhUwOzYJFZ0skJ/Y
   wP9Dp7ua3diCiYRF2lRNrdKxsaOTIokYXjHllrQ33Dp8jyqdZdJSz0oGO
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10464"; a="280313745"
X-IronPort-AV: E=Sophos;i="5.93,300,1654585200"; 
   d="scan'208";a="280313745"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2022 11:26:53 -0700
X-IronPort-AV: E=Sophos;i="5.93,300,1654585200"; 
   d="scan'208";a="683335025"
Received: from rhweight-wrk1.ra.intel.com ([137.102.106.43])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2022 11:26:52 -0700
Date:   Thu, 8 Sep 2022 11:27:03 -0700 (PDT)
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
        niklas.soderlund+renesas@ragnatech.se, phil.edworthy@renesas.com,
        macro@orcam.me.uk, johan@kernel.org, lukas@wunner.de
Subject: Re: [PATCH v1 5/5] tty: serial: 8250: add DFL bus driver for Altera
 16550.
In-Reply-To: <YxesjfoBagiC3gGE@smile.fi.intel.com>
Message-ID: <alpine.DEB.2.22.394.2209081049290.61321@rhweight-WRK1>
References: <20220906190426.3139760-1-matthew.gerlach@linux.intel.com> <20220906190426.3139760-6-matthew.gerlach@linux.intel.com> <YxesjfoBagiC3gGE@smile.fi.intel.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



On Tue, 6 Sep 2022, Andy Shevchenko wrote:

> On Tue, Sep 06, 2022 at 12:04:26PM -0700, matthew.gerlach@linux.intel.com wrote:
>> From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>>
>> Add a Device Feature List (DFL) bus driver for the Altera
>> 16550 implementation of UART.
>
> ...
>
>> +#include <linux/dfl.h>
>
>> +#include <linux/version.h>
>
> Hmm... Do we need this?

We do not need this.

>
>> +#include <linux/serial.h>
>> +#include <linux/serial_8250.h>
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +#include <linux/bitfield.h>
>> +#include <linux/io-64-nonatomic-lo-hi.h>
>
> Can this block be sorted alphabetically?

Yes, they can and should be sorted alphabetically.

>
> ...
>
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
>> +
>> +	if (dfluart->csr_addr == 0 || dfluart->csr_size == 0) {
>> +		dev_err(dfluart->dev, "FIXME bad dfh address and size\n");
>
> DFH ?

Yes,"DFH" is better than "dfh" in the message.

>
>> +		return -EINVAL;
>> +	}
>> +
>> +	if (!FIELD_GET(DFHv1_CSR_SIZE_GRP_HAS_PARAMS, v)) {
>> +		dev_err(dfluart->dev, "missing required parameters\n");
>
> Not sure I understood what parameters are here. FPGA VHDL? Configuration? RTL?

How about "missing required DFH parameters\n"?

>
>> +		return -EINVAL;
>> +	}
>> +
>> +	param_base = dfluart->csr_base + DFHv1_PARAM_HDR;
>> +
>> +	off = dfl_find_param(param_base, max, DFHv1_PARAM_ID_CLK_FRQ);
>> +	if (off < 0) {
>> +		dev_err(dfluart->dev, "missing CLK_FRQ param\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	dfluart->uart_clk = readq(param_base + off + DFHv1_PARAM_DATA);
>
>> +	dev_dbg(dfluart->dev, "UART_CLK_ID %llu Hz\n", dfluart->uart_clk);
>
> Isn't this available via normal interfaces to user?

I am not sure what "normal interfaces to user" you are referring to.  The 
code is just trying to read the frequency of the input clock to the uart 
from a DFH paramter.

>
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
>
>> +		dev_err(dev, "failed to get mem resource!\n");
>
> The above call have a few different messages depending on error code.
> No need to repeat this.

I will remove the call to dev_err().
>
>> +		return PTR_ERR(dfluart->csr_base);
>> +	}
>> +
>> +	dfluart->dev = dev;
>> +
>> +	ret = feature_uart_walk(dfluart, resource_size(&dfl_dev->mmio_res));
>> +	if (ret < 0) {
>> +		dev_err(dev, "failed to uart feature walk %d\n", ret);
>
>> +		return -EINVAL;
>
> Why shadowing error code?
> What about
>
> 	return dev_err_probe(dev, ret, ...);
> ?
>

Using dev_err_probe seems like the way to go.

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
>
> ...
>
>> +#define FME_FEATURE_ID_UART 0x24
>
> Purpose of this definition? For me with or without is still an ID.

I don't think I understand the question. Is the name of the macro unclear, 
or do you think it is not necessary?

>
>> +static const struct dfl_device_id dfl_uart_ids[] = {
>> +	{ FME_ID, FME_FEATURE_ID_UART },
>> +	{ }
>> +};
>
> ...
>
>> +static struct dfl_driver dfl_uart_driver = {
>> +	.drv = {
>> +		.name = "dfl-uart",
>> +	},
>> +	.id_table = dfl_uart_ids,
>> +	.probe = dfl_uart_probe,
>> +	.remove = dfl_uart_remove,
>> +};
>
>> +
>
> No need to have this blank line.

I will remove the blank line.

>
>> +module_dfl_driver(dfl_uart_driver);
>
> ...
>
>> +MODULE_DEVICE_TABLE(dfl, dfl_uart_ids);
>
> Move this closer to the definition. That's how other drivers do in the kernel.

Thanks for the suggestion.

>
> ...
>
>> --- a/drivers/tty/serial/8250/Kconfig
>> +++ b/drivers/tty/serial/8250/Kconfig
>
>> --- a/drivers/tty/serial/8250/Makefile
>> +++ b/drivers/tty/serial/8250/Makefile
>
> I know that the records in those files are not sorted, but can you try hard
> to find the best place for them in those files from sorting point of view?
>

I will try to find a better place from sorting porint of view.

> -- 
> With Best Regards,
> Andy Shevchenko
>
>
>
