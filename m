Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C04AE5F46C4
	for <lists+linux-fpga@lfdr.de>; Tue,  4 Oct 2022 17:33:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbiJDPb3 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 4 Oct 2022 11:31:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiJDPb2 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 4 Oct 2022 11:31:28 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8A9025E9E;
        Tue,  4 Oct 2022 08:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664897487; x=1696433487;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iFOChYJvoxzaLLOQbDuDmgouBoECtc1KKTUSJu34ImU=;
  b=cSoz2exaR56+6DewyZYFSazw+rPhjPbGws0VKXp00vkyUuIsSDzpnzHj
   gCMCyZa4+n0fEbBkVb3coFaxUO0fUmcUBMlDrh7++qA5N3iEaHdfdQbjE
   oV+JFb2/yEzD0HuY4JYKlUJchaTvN6wFMtN2FtibkpCAeAQ/ppKejwq6t
   gUavRS4c1kbQxLXN+G4RUQduaI7FFGpyKQlrauHH6KeTme9KJHTIhJZey
   j+nA91d5AwnTQO7Oz/iu1GPhqMNfqGtmdUatggtxaeW0w63uB5XS0QqYR
   L5oQgqlCUJLNmkmB4u3sskVlQDqEZCHO3lk3YFkb/ybf+rpR2U+cGHQyC
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10490"; a="286130565"
X-IronPort-AV: E=Sophos;i="5.95,158,1661842800"; 
   d="scan'208";a="286130565"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2022 08:31:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10490"; a="799152794"
X-IronPort-AV: E=Sophos;i="5.95,158,1661842800"; 
   d="scan'208";a="799152794"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga005.jf.intel.com with ESMTP; 04 Oct 2022 08:31:20 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ofjt8-0028VQ-28;
        Tue, 04 Oct 2022 18:31:18 +0300
Date:   Tue, 4 Oct 2022 18:31:18 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     matthew.gerlach@linux.intel.com
Cc:     hao.wu@intel.com, yilun.xu@intel.com, russell.h.weight@intel.com,
        basheer.ahmed.muddebihal@intel.com, trix@redhat.com,
        mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        tianfei.zhang@intel.com, corbet@lwn.net,
        gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        jirislaby@kernel.org, geert+renesas@glider.be,
        niklas.soderlund+renesas@ragnatech.se, macro@orcam.me.uk,
        johan@kernel.org, lukas@wunner.de,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v3 4/4] tty: serial: 8250: add DFL bus driver for Altera
 16550.
Message-ID: <YzxRxo8jL7rB1+px@smile.fi.intel.com>
References: <20221004143718.1076710-1-matthew.gerlach@linux.intel.com>
 <20221004143718.1076710-5-matthew.gerlach@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221004143718.1076710-5-matthew.gerlach@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Tue, Oct 04, 2022 at 07:37:18AM -0700, matthew.gerlach@linux.intel.com wrote:
> From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> 
> Add a Device Feature List (DFL) bus driver for the Altera
> 16550 implementation of UART.

...

> Reported-by: kernel test robot <lkp@intel.com>

https://docs.kernel.org/process/submitting-patches.html?highlight=reported#using-reported-by-tested-by-reviewed-by-suggested-by-and-fixes

"The Reported-by tag gives credit to people who find bugs and report them and it
hopefully inspires them to help us again in the future. Please note that if the
bug was reported in private, then ask for permission first before using the
Reported-by tag. The tag is intended for bugs; please do not use it to credit
feature requests."


...

> +	if (!dfhv1_has_params(dfh_base)) {
> +		dev_err(dev, "missing required DFH parameters\n");
> +		return -EINVAL;
> +	}

Why not use dev_err_probe() everywhere since this is called only at ->probe()
stage?

...

> +	off = dfhv1_find_param(dfh_base, max, DFHv1_PARAM_ID_CLK_FRQ);
> +	if (off < 0) {
> +		dev_err(dev, "missing CLK_FRQ param\n");

> +		return -EINVAL;

Why error code is being shadowed?

> +	}

...

> +	off = dfhv1_find_param(dfh_base, max, DFHv1_PARAM_ID_FIFO_LEN);
> +	if (off < 0) {
> +		dev_err(dev, "missing FIFO_LEN param\n");
> +		return -EINVAL;

Ditto.

> +	}

...

> +	off = dfhv1_find_param(dfh_base, max, DFHv1_PARAM_ID_REG_LAYOUT);
> +	if (off < 0) {
> +		dev_err(dev, "missing REG_LAYOUT param\n");
> +		return -EINVAL;
> +	}

Ditto.

...

> +	dev_dbg(dev, "UART_LAYOUT_ID width %lld shift %d\n",
> +		FIELD_GET(DFHv1_PARAM_ID_REG_WIDTH, v), (int)uart->port.regshift);

Casting in printf() in kernel in 99% shows the wrong specifier in use. Try to
select the best suitable one.

...

> +	dfh_base = devm_ioremap_resource(dev, &dfl_dev->mmio_res);
> +	if (IS_ERR(dfh_base))
> +		return PTR_ERR(dfh_base);
> +
> +	res_size = resource_size(&dfl_dev->mmio_res);
> +
> +	ret = dfl_uart_get_params(dev, dfh_base, res_size, &uart);

> +	devm_iounmap(dev, dfh_base);
> +	devm_release_mem_region(dev, dfl_dev->mmio_res.start, res_size);

If it's temporary, may be you shouldn't even consider devm_ioremap_resource()
to begin with? The devm_* release type of functions in 99% of the cases
indicate of the abusing devm_.

> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "failed uart feature walk\n");

...

> +	dev_info(dev, "serial8250_register_8250_port %d\n", dfluart->line);

Why do we need this noise?

...

> +	if (dfluart->line >= 0)

When this can be false?

> +		serial8250_unregister_port(dfluart->line);

...

> +config SERIAL_8250_DFL
> +	tristate "DFL bus driver for Altera 16550 UART"
> +	depends on SERIAL_8250 && FPGA_DFL
> +	help
> +	  This option enables support for a Device Feature List (DFL) bus
> +	  driver for the Altera 16650 UART.  One or more Altera 16650 UARTs
> +	  can be instantiated in a FPGA and then be discovered during
> +	  enumeration of the DFL bus.

When m, what be the module name?

...

>  obj-$(CONFIG_SERIAL_8250_FOURPORT)	+= 8250_fourport.o
>  obj-$(CONFIG_SERIAL_8250_ACCENT)	+= 8250_accent.o
>  obj-$(CONFIG_SERIAL_8250_BOCA)		+= 8250_boca.o
> +obj-$(CONFIG_SERIAL_8250_DFL)		+= 8250_dfl.o

This group of drivers for the 4 UARTs on the board or so, does FPGA belong to
it? (Same Q, btw, for the Kconfig section. And yes, I know that some of the
entries are not properly placed there and in Makefile.)

>  obj-$(CONFIG_SERIAL_8250_EXAR_ST16C554)	+= 8250_exar_st16c554.o
>  obj-$(CONFIG_SERIAL_8250_HUB6)		+= 8250_hub6.o
>  obj-$(CONFIG_SERIAL_8250_FSL)		+= 8250_fsl.o

-- 
With Best Regards,
Andy Shevchenko


