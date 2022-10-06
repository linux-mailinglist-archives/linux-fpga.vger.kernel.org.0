Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19C825F6C7A
	for <lists+linux-fpga@lfdr.de>; Thu,  6 Oct 2022 19:02:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230325AbiJFRBM (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 6 Oct 2022 13:01:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbiJFRBG (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 6 Oct 2022 13:01:06 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64296FAD0;
        Thu,  6 Oct 2022 10:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665075645; x=1696611645;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=2Bqgzrp3vtMupt4HNoMx9Nbs0GAwkw5X72t1qJY7vHg=;
  b=Y6NmjK4UnG6rTdtWAPjf3xydG5wYirg9Sp/tNv+5VM64+Csqn6p1UWkK
   4DD+3tFT1Wx57m6pjTygU7OTPQN6MTommb+ohi82ueKpvgFybpELsQOi/
   kkV2kn5sW0SavEGtlK16O8fhzaFVsUs5nEHUl0/541z4ptQuwLGBndV8h
   P9Jpw3okGstgEqtgxWncniaSJsfB64BsJ3pXcY7ysex8kWrEWPG6cXZci
   TahfApy0krFrdc2kJ+SM9XuBI7ctHzIgDFuLizk3lqJA69ZXrEwXTi8rI
   cxF91/YNenvfAd12DgteAIlXPf/+892wSqSSE4Dxxnl4dPgGNRnE0ZXki
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10492"; a="303481507"
X-IronPort-AV: E=Sophos;i="5.95,164,1661842800"; 
   d="scan'208";a="303481507"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2022 10:00:32 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10492"; a="729224224"
X-IronPort-AV: E=Sophos;i="5.95,164,1661842800"; 
   d="scan'208";a="729224224"
Received: from rhweight-wrk1.ra.intel.com ([137.102.106.139])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2022 10:00:32 -0700
Date:   Thu, 6 Oct 2022 10:00:43 -0700 (PDT)
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
        johan@kernel.org, lukas@wunner.de,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v3 4/4] tty: serial: 8250: add DFL bus driver for Altera
 16550.
In-Reply-To: <YzxRxo8jL7rB1+px@smile.fi.intel.com>
Message-ID: <alpine.DEB.2.22.394.2210060940150.1988353@rhweight-WRK1>
References: <20221004143718.1076710-1-matthew.gerlach@linux.intel.com> <20221004143718.1076710-5-matthew.gerlach@linux.intel.com> <YzxRxo8jL7rB1+px@smile.fi.intel.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



On Tue, 4 Oct 2022, Andy Shevchenko wrote:

> On Tue, Oct 04, 2022 at 07:37:18AM -0700, matthew.gerlach@linux.intel.com wrote:
>> From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>>
>> Add a Device Feature List (DFL) bus driver for the Altera
>> 16550 implementation of UART.
>
> ...
>
>> Reported-by: kernel test robot <lkp@intel.com>
>
> https://docs.kernel.org/process/submitting-patches.html?highlight=reported#using-reported-by-tested-by-reviewed-by-suggested-by-and-fixes
>
> "The Reported-by tag gives credit to people who find bugs and report them and it
> hopefully inspires them to help us again in the future. Please note that if the
> bug was reported in private, then ask for permission first before using the
> Reported-by tag. The tag is intended for bugs; please do not use it to credit
> feature requests."
>

The kernel test robot did find a bug in my v1 submission.  I was missing 
the static keyword for a function declaration.  Should I remove the tag?

>
> ...
>
>> +	if (!dfhv1_has_params(dfh_base)) {
>> +		dev_err(dev, "missing required DFH parameters\n");
>> +		return -EINVAL;
>> +	}
>
> Why not use dev_err_probe() everywhere since this is called only at ->probe()
> stage?

I wasn't sure if using dev_err_probe() was correct, since the usage is 
technically in a different function.  Since the code is only called from 
->probe(), and it is much cleaner, I'll switch to dev_err_probe() 
everywhere

> > ...
>
>> +	off = dfhv1_find_param(dfh_base, max, DFHv1_PARAM_ID_CLK_FRQ);
>> +	if (off < 0) {
>> +		dev_err(dev, "missing CLK_FRQ param\n");
>
>> +		return -EINVAL;
>
> Why error code is being shadowed?

Definitely a mistake.

>
>> +	}
>
> ...
>
>> +	off = dfhv1_find_param(dfh_base, max, DFHv1_PARAM_ID_FIFO_LEN);
>> +	if (off < 0) {
>> +		dev_err(dev, "missing FIFO_LEN param\n");
>> +		return -EINVAL;
>
> Ditto.
>
>> +	}
>
> ...
>
>> +	off = dfhv1_find_param(dfh_base, max, DFHv1_PARAM_ID_REG_LAYOUT);
>> +	if (off < 0) {
>> +		dev_err(dev, "missing REG_LAYOUT param\n");
>> +		return -EINVAL;
>> +	}
>
> Ditto.
>
> ...
>
>> +	dev_dbg(dev, "UART_LAYOUT_ID width %lld shift %d\n",
>> +		FIELD_GET(DFHv1_PARAM_ID_REG_WIDTH, v), (int)uart->port.regshift);
>
> Casting in printf() in kernel in 99% shows the wrong specifier in use. Try to
> select the best suitable one.

I will remove the casting and find the correct format specifier.

>
> ...
>
>> +	dfh_base = devm_ioremap_resource(dev, &dfl_dev->mmio_res);
>> +	if (IS_ERR(dfh_base))
>> +		return PTR_ERR(dfh_base);
>> +
>> +	res_size = resource_size(&dfl_dev->mmio_res);
>> +
>> +	ret = dfl_uart_get_params(dev, dfh_base, res_size, &uart);
>
>> +	devm_iounmap(dev, dfh_base);
>> +	devm_release_mem_region(dev, dfl_dev->mmio_res.start, res_size);
>
> If it's temporary, may be you shouldn't even consider devm_ioremap_resource()
> to begin with? The devm_* release type of functions in 99% of the cases
> indicate of the abusing devm_.

I will change the code to call ioremap() and request_mem_region() directly 
instead of the devm_ versions.

>
>> +	if (ret < 0)
>> +		return dev_err_probe(dev, ret, "failed uart feature walk\n");
>
> ...
>
>> +	dev_info(dev, "serial8250_register_8250_port %d\n", dfluart->line);
>
> Why do we need this noise?

No, we do not need this noise.

>
> ...
>
>> +	if (dfluart->line >= 0)
>
> When this can be false?

This can never be false.  I will remove it.

>
>> +		serial8250_unregister_port(dfluart->line);
>
> ...
>
>> +config SERIAL_8250_DFL
>> +	tristate "DFL bus driver for Altera 16550 UART"
>> +	depends on SERIAL_8250 && FPGA_DFL
>> +	help
>> +	  This option enables support for a Device Feature List (DFL) bus
>> +	  driver for the Altera 16650 UART.  One or more Altera 16650 UARTs
>> +	  can be instantiated in a FPGA and then be discovered during
>> +	  enumeration of the DFL bus.
>
> When m, what be the module name?

I see the file, kernel/drivers/tty/serial/8250/8250_dfl.ko, installed 
into /lib/modules/...  I also see "alias dfl:t0000f0024* 8250_dfl" in 
modules.alias


>
> ...
>
>>  obj-$(CONFIG_SERIAL_8250_FOURPORT)	+= 8250_fourport.o
>>  obj-$(CONFIG_SERIAL_8250_ACCENT)	+= 8250_accent.o
>>  obj-$(CONFIG_SERIAL_8250_BOCA)		+= 8250_boca.o
>> +obj-$(CONFIG_SERIAL_8250_DFL)		+= 8250_dfl.o
>
> This group of drivers for the 4 UARTs on the board or so, does FPGA belong to
> it? (Same Q, btw, for the Kconfig section. And yes, I know that some of the
> entries are not properly placed there and in Makefile.)

Since 8250_dfl results in its own module, and my kernel config doesn't 
have FOURPORT, ACCENT, nor BOCA, I guess I don't understand the problem.

>
>>  obj-$(CONFIG_SERIAL_8250_EXAR_ST16C554)	+= 8250_exar_st16c554.o
>>  obj-$(CONFIG_SERIAL_8250_HUB6)		+= 8250_hub6.o
>>  obj-$(CONFIG_SERIAL_8250_FSL)		+= 8250_fsl.o
>
> -- 
> With Best Regards,
> Andy Shevchenko

Thanks for the feedback.


>
>
>
