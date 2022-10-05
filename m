Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 657885F52E1
	for <lists+linux-fpga@lfdr.de>; Wed,  5 Oct 2022 12:49:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbiJEKrY (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 5 Oct 2022 06:47:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiJEKrV (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 5 Oct 2022 06:47:21 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C109926492;
        Wed,  5 Oct 2022 03:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664966838; x=1696502838;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Qvdvm6/Yzu7ojmkolJcq8JM8ELA489o7JaJRUu4mY5U=;
  b=IuoI0hTa7ArWrespAaoLf+8W3nQQa2Mrlwf2E3ditrFWFx4AysDHUJaC
   8EmFCUAUJ/Fpfyo4kwpzzY9OS7wttI48w/JBpM26a8sePDJhlY8bATrcb
   jvFw11O/xA7ux3Vz63CPJu+PhEvx4IJHhhU76Gs/mMpWz4uWxeYA1xw0S
   XUf76pHoF7IDHI9dU1eiDi/0TC5CE3R+tvDsK8sj+WLhoc2+T48mqdMaK
   KXq5peKU9Pzc6OUos9DeqWnPMK7PQkd5aGfQmWlFCa56v4OpkntpfGOlj
   08MC3kHmA554FeV0f06r2NERv01uz0Sjev+Ud50dO6mBBcWBylpNNx9p4
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10490"; a="329543795"
X-IronPort-AV: E=Sophos;i="5.95,159,1661842800"; 
   d="scan'208";a="329543795"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2022 03:47:18 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10490"; a="869361684"
X-IronPort-AV: E=Sophos;i="5.95,159,1661842800"; 
   d="scan'208";a="869361684"
Received: from refaase-mobl1.ger.corp.intel.com ([10.252.39.164])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2022 03:47:11 -0700
Date:   Wed, 5 Oct 2022 13:47:08 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Matthew Gerlach <matthew.gerlach@linux.intel.com>
cc:     hao.wu@intel.com, yilun.xu@intel.com, russell.h.weight@intel.com,
        basheer.ahmed.muddebihal@intel.com, trix@redhat.com,
        mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        tianfei.zhang@intel.com, corbet@lwn.net,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>, geert+renesas@glider.be,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        niklas.soderlund+renesas@ragnatech.se, macro@orcam.me.uk,
        johan@kernel.org, Lukas Wunner <lukas@wunner.de>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v3 4/4] tty: serial: 8250: add DFL bus driver for Altera
 16550.
In-Reply-To: <20221004143718.1076710-5-matthew.gerlach@linux.intel.com>
Message-ID: <d75abf9c-e982-563f-b2-d5a376367b1e@linux.intel.com>
References: <20221004143718.1076710-1-matthew.gerlach@linux.intel.com> <20221004143718.1076710-5-matthew.gerlach@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Tue, 4 Oct 2022, matthew.gerlach@linux.intel.com wrote:

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

I'd tell user "unsupported" rather than "bad".

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

Why not use reg_width directly?

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

unsupported ?

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

This comment is pretty useless. Just drop it.

> +	dfluart->line = serial8250_register_8250_port(&uart);
> +	if (dfluart->line < 0)
> +		return dev_err_probe(dev, dfluart->line, "unable to register 8250 port.\n");
> +
> +	dev_info(dev, "serial8250_register_8250_port %d\n", dfluart->line);

This you want to drop too. It seems a debug thing rather than info level 
stuff.


-- 
 i.

