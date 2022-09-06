Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CAD55AF5CE
	for <lists+linux-fpga@lfdr.de>; Tue,  6 Sep 2022 22:26:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbiIFUY5 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 6 Sep 2022 16:24:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiIFUYz (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 6 Sep 2022 16:24:55 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F9FA3C8E0;
        Tue,  6 Sep 2022 13:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662495894; x=1694031894;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=t+qIvJWu1umzxU89Y8+usFUVVPU+q4y0SQBnYE3zFEo=;
  b=N/pjZSy2yS0wGAbmnUejHfeSupmz55g+OgOM0zGCVYHv4XFTTsAFuzCl
   cYwMWV5xF7sXpY9gxK6dtA+impgNFqTbSTxcfdlva660mM3qJ1APzKkqX
   iMVeM3O0NT1TJmW8Ml8E4SzabsX5c1A+LNwOcRVoCDKcTPx8BjGUUpxLd
   aFWKid514rWPt8lgk0dRe7jAXJwTz2FXBfvHGOVHQAD5Ad2xTsqIqS3Vf
   r35z1C8Z8xS21V16+Q58svZjLtFhuDPcvt6z9qYBqdjcUKY2/T4QOZCpE
   0WTMBCa5acSpB8MLSuJmHB3C9vadd7JnJ1Mol4JNQBqkcMVSPRs57JvyI
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10462"; a="358413767"
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="358413767"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2022 13:24:53 -0700
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="756503229"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2022 13:24:49 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oVf7l-009MXY-2c;
        Tue, 06 Sep 2022 23:24:45 +0300
Date:   Tue, 6 Sep 2022 23:24:45 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     matthew.gerlach@linux.intel.com
Cc:     hao.wu@intel.com, yilun.xu@intel.com, russell.h.weight@intel.com,
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
Message-ID: <YxesjfoBagiC3gGE@smile.fi.intel.com>
References: <20220906190426.3139760-1-matthew.gerlach@linux.intel.com>
 <20220906190426.3139760-6-matthew.gerlach@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220906190426.3139760-6-matthew.gerlach@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Tue, Sep 06, 2022 at 12:04:26PM -0700, matthew.gerlach@linux.intel.com wrote:
> From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> 
> Add a Device Feature List (DFL) bus driver for the Altera
> 16550 implementation of UART.

...

> +#include <linux/dfl.h>

> +#include <linux/version.h>

Hmm... Do we need this?

> +#include <linux/serial.h>
> +#include <linux/serial_8250.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/bitfield.h>
> +#include <linux/io-64-nonatomic-lo-hi.h>

Can this block be sorted alphabetically?

...

> +int feature_uart_walk(struct dfl_uart *dfluart, resource_size_t max)
> +{
> +	void __iomem *param_base;
> +	int off;
> +	u64 v;
> +
> +	v = readq(dfluart->csr_base + DFHv1_CSR_ADDR);
> +	dfluart->csr_addr = FIELD_GET(DFHv1_CSR_ADDR_MASK, v);
> +
> +	v = readq(dfluart->csr_base + DFHv1_CSR_SIZE_GRP);
> +	dfluart->csr_size = FIELD_GET(DFHv1_CSR_SIZE_GRP_SIZE, v);
> +
> +	if (dfluart->csr_addr == 0 || dfluart->csr_size == 0) {
> +		dev_err(dfluart->dev, "FIXME bad dfh address and size\n");

DFH ?

> +		return -EINVAL;
> +	}
> +
> +	if (!FIELD_GET(DFHv1_CSR_SIZE_GRP_HAS_PARAMS, v)) {
> +		dev_err(dfluart->dev, "missing required parameters\n");

Not sure I understood what parameters are here. FPGA VHDL? Configuration? RTL?

> +		return -EINVAL;
> +	}
> +
> +	param_base = dfluart->csr_base + DFHv1_PARAM_HDR;
> +
> +	off = dfl_find_param(param_base, max, DFHv1_PARAM_ID_CLK_FRQ);
> +	if (off < 0) {
> +		dev_err(dfluart->dev, "missing CLK_FRQ param\n");
> +		return -EINVAL;
> +	}
> +
> +	dfluart->uart_clk = readq(param_base + off + DFHv1_PARAM_DATA);

> +	dev_dbg(dfluart->dev, "UART_CLK_ID %llu Hz\n", dfluart->uart_clk);

Isn't this available via normal interfaces to user?

> +	off = dfl_find_param(param_base, max, DFHv1_PARAM_ID_FIFO_LEN);
> +	if (off < 0) {
> +		dev_err(dfluart->dev, "missing FIFO_LEN param\n");
> +		return -EINVAL;
> +	}
> +
> +	dfluart->fifo_len = readq(param_base + off + DFHv1_PARAM_DATA);
> +	dev_dbg(dfluart->dev, "UART_FIFO_ID fifo_len %llu\n", dfluart->fifo_len);
> +
> +	off = dfl_find_param(param_base, max, DFHv1_PARAM_ID_REG_LAYOUT);
> +	if (off < 0) {
> +		dev_err(dfluart->dev, "missing REG_LAYOUT param\n");
> +		return -EINVAL;
> +	}
> +
> +	v = readq(param_base + off + DFHv1_PARAM_DATA);
> +	dfluart->fifo_size = FIELD_GET(DFHv1_PARAM_ID_REG_WIDTH, v);
> +	dfluart->reg_shift = FIELD_GET(DFHv1_PARAM_ID_REG_SHIFT, v);
> +	dev_dbg(dfluart->dev, "UART_LAYOUT_ID width %d shift %d\n",
> +		dfluart->fifo_size, dfluart->reg_shift);
> +
> +	return 0;
> +}
> +
> +static int dfl_uart_probe(struct dfl_device *dfl_dev)
> +{
> +	struct device *dev = &dfl_dev->dev;
> +	struct uart_8250_port uart;
> +	struct dfl_uart *dfluart;
> +	int ret;
> +
> +	memset(&uart, 0, sizeof(uart));
> +
> +	dfluart = devm_kzalloc(dev, sizeof(*dfluart), GFP_KERNEL);
> +	if (!dfluart)
> +		return -ENOMEM;
> +
> +	dfluart->csr_base = devm_ioremap_resource(dev, &dfl_dev->mmio_res);
> +	if (IS_ERR(dfluart->csr_base)) {

> +		dev_err(dev, "failed to get mem resource!\n");

The above call have a few different messages depending on error code.
No need to repeat this.

> +		return PTR_ERR(dfluart->csr_base);
> +	}
> +
> +	dfluart->dev = dev;
> +
> +	ret = feature_uart_walk(dfluart, resource_size(&dfl_dev->mmio_res));
> +	if (ret < 0) {
> +		dev_err(dev, "failed to uart feature walk %d\n", ret);

> +		return -EINVAL;

Why shadowing error code?
What about

	return dev_err_probe(dev, ret, ...);
?

> +	}
> +
> +	dev_dbg(dev, "nr_irqs %d %p\n", dfl_dev->num_irqs, dfl_dev->irqs);
> +
> +	if (dfl_dev->num_irqs == 1)
> +		uart.port.irq = dfl_dev->irqs[0];
> +
> +	switch (dfluart->fifo_len) {
> +	case 32:
> +		uart.port.type = PORT_ALTR_16550_F32;
> +		break;
> +
> +	case 64:
> +		uart.port.type = PORT_ALTR_16550_F64;
> +		break;
> +
> +	case 128:
> +		uart.port.type = PORT_ALTR_16550_F128;
> +		break;
> +
> +	default:
> +		dev_err(dev, "bad fifo_len %llu\n", dfluart->fifo_len);
> +		return -EINVAL;
> +	}
> +
> +	uart.port.iotype = UPIO_MEM32;
> +	uart.port.membase = dfluart->csr_base + dfluart->csr_addr;
> +	uart.port.mapsize = dfluart->csr_size;
> +	uart.port.regshift = dfluart->reg_shift;
> +	uart.port.uartclk = dfluart->uart_clk;
> +
> +	/* register the port */
> +	ret = serial8250_register_8250_port(&uart);
> +	if (ret < 0) {
> +		dev_err(dev, "unable to register 8250 port %d.\n", ret);
> +		return -EINVAL;
> +	}
> +	dev_info(dev, "serial8250_register_8250_port %d\n", ret);
> +	dfluart->line = ret;
> +	dev_set_drvdata(dev, dfluart);
> +
> +	return 0;
> +}
> +
> +static void dfl_uart_remove(struct dfl_device *dfl_dev)
> +{
> +	struct dfl_uart *dfluart = dev_get_drvdata(&dfl_dev->dev);
> +
> +	if (dfluart->line > 0)
> +		serial8250_unregister_port(dfluart->line);
> +}

...

> +#define FME_FEATURE_ID_UART 0x24

Purpose of this definition? For me with or without is still an ID.

> +static const struct dfl_device_id dfl_uart_ids[] = {
> +	{ FME_ID, FME_FEATURE_ID_UART },
> +	{ }
> +};

...

> +static struct dfl_driver dfl_uart_driver = {
> +	.drv = {
> +		.name = "dfl-uart",
> +	},
> +	.id_table = dfl_uart_ids,
> +	.probe = dfl_uart_probe,
> +	.remove = dfl_uart_remove,
> +};

> +

No need to have this blank line.

> +module_dfl_driver(dfl_uart_driver);

...

> +MODULE_DEVICE_TABLE(dfl, dfl_uart_ids);

Move this closer to the definition. That's how other drivers do in the kernel.

...

> --- a/drivers/tty/serial/8250/Kconfig
> +++ b/drivers/tty/serial/8250/Kconfig

> --- a/drivers/tty/serial/8250/Makefile
> +++ b/drivers/tty/serial/8250/Makefile

I know that the records in those files are not sorted, but can you try hard
to find the best place for them in those files from sorting point of view?

-- 
With Best Regards,
Andy Shevchenko


