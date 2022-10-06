Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA49A5F6D30
	for <lists+linux-fpga@lfdr.de>; Thu,  6 Oct 2022 19:45:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbiJFRo0 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 6 Oct 2022 13:44:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbiJFRoZ (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 6 Oct 2022 13:44:25 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BF48B3B3A;
        Thu,  6 Oct 2022 10:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665078264; x=1696614264;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0Algq8hyduIEzy6JYyaOhF1vsvyg3XX+0FRx/6j5o0g=;
  b=P40ET/E+96MyPWObFb/pj2DToiN71/rWVfNN96w5AcLuw6VBH+/3BMjw
   w5wJWMId5jSRn3W3bZMxqWa0fLPTN2fF7VWy1LXJ8JTpFTi4WgeHXDSe0
   +4o1R2C2478UfB7Hz7qSKZKWrVdbxA42OYmXKMpQ7fsiVd1MyzBtf3My8
   x6rS20cG7vzmpilqERzCht7+0SjIZxFOGAyS8AV2SRGG+Ioq6n9hgasX1
   UzBcoRr94OLj2m2klPG1Ldiry4DMmxHU4oK6rLpbr9H9PxWXF7OswvIQF
   FkdjcuBtXGKowFVT3X8Ez+BApVFQH1jrkn8WCi6uKyWuhCzItz/unVmbd
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10492"; a="367644479"
X-IronPort-AV: E=Sophos;i="5.95,164,1661842800"; 
   d="scan'208";a="367644479"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2022 10:44:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10492"; a="687529739"
X-IronPort-AV: E=Sophos;i="5.95,164,1661842800"; 
   d="scan'208";a="687529739"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga008.fm.intel.com with ESMTP; 06 Oct 2022 10:44:18 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ogUuu-003HN6-1V;
        Thu, 06 Oct 2022 20:44:16 +0300
Date:   Thu, 6 Oct 2022 20:44:16 +0300
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
Message-ID: <Yz8T8GdzMLyAKIMb@smile.fi.intel.com>
References: <20221004143718.1076710-1-matthew.gerlach@linux.intel.com>
 <20221004143718.1076710-5-matthew.gerlach@linux.intel.com>
 <YzxRxo8jL7rB1+px@smile.fi.intel.com>
 <alpine.DEB.2.22.394.2210060940150.1988353@rhweight-WRK1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2210060940150.1988353@rhweight-WRK1>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Thu, Oct 06, 2022 at 10:00:43AM -0700, matthew.gerlach@linux.intel.com wrote:
> On Tue, 4 Oct 2022, Andy Shevchenko wrote:
> > On Tue, Oct 04, 2022 at 07:37:18AM -0700, matthew.gerlach@linux.intel.com wrote:

...

> > > Reported-by: kernel test robot <lkp@intel.com>
> > 
> > https://docs.kernel.org/process/submitting-patches.html?highlight=reported#using-reported-by-tested-by-reviewed-by-suggested-by-and-fixes
> > 
> > "The Reported-by tag gives credit to people who find bugs and report them and it
> > hopefully inspires them to help us again in the future. Please note that if the
> > bug was reported in private, then ask for permission first before using the
> > Reported-by tag. The tag is intended for bugs; please do not use it to credit
> > feature requests."
> 
> The kernel test robot did find a bug in my v1 submission.  I was missing the
> static keyword for a function declaration.  Should I remove the tag?

What's yours take from the above documentation?

...

> > > +	dfh_base = devm_ioremap_resource(dev, &dfl_dev->mmio_res);
> > > +	if (IS_ERR(dfh_base))
> > > +		return PTR_ERR(dfh_base);
> > > +
> > > +	res_size = resource_size(&dfl_dev->mmio_res);
> > > +
> > > +	ret = dfl_uart_get_params(dev, dfh_base, res_size, &uart);
> > 
> > > +	devm_iounmap(dev, dfh_base);
> > > +	devm_release_mem_region(dev, dfl_dev->mmio_res.start, res_size);
> > 
> > If it's temporary, may be you shouldn't even consider devm_ioremap_resource()
> > to begin with? The devm_* release type of functions in 99% of the cases
> > indicate of the abusing devm_.
> 
> I will change the code to call ioremap() and request_mem_region() directly
> instead of the devm_ versions.

But why will you need request_mem_region() in that case?

> > > +	if (ret < 0)
> > > +		return dev_err_probe(dev, ret, "failed uart feature walk\n");

...

> > > +config SERIAL_8250_DFL
> > > +	tristate "DFL bus driver for Altera 16550 UART"
> > > +	depends on SERIAL_8250 && FPGA_DFL
> > > +	help
> > > +	  This option enables support for a Device Feature List (DFL) bus
> > > +	  driver for the Altera 16650 UART.  One or more Altera 16650 UARTs
> > > +	  can be instantiated in a FPGA and then be discovered during
> > > +	  enumeration of the DFL bus.
> > 
> > When m, what be the module name?
> 
> I see the file, kernel/drivers/tty/serial/8250/8250_dfl.ko, installed into
> /lib/modules/...  I also see "alias dfl:t0000f0024* 8250_dfl" in
> modules.alias

My point is that user who will run `make menuconfig` will read this and have
no clue after the kernel build if the module was built or not. Look into other
(recent) sections of the Kconfig for drivers in the kernel for how they inform
user about the module name (this more or less standard pattern you just need
to copy'n'paste'n'edit carefully).

...

> > >  obj-$(CONFIG_SERIAL_8250_FOURPORT)	+= 8250_fourport.o
> > >  obj-$(CONFIG_SERIAL_8250_ACCENT)	+= 8250_accent.o
> > >  obj-$(CONFIG_SERIAL_8250_BOCA)		+= 8250_boca.o
> > > +obj-$(CONFIG_SERIAL_8250_DFL)		+= 8250_dfl.o
> > 
> > This group of drivers for the 4 UARTs on the board or so, does FPGA belong to
> > it? (Same Q, btw, for the Kconfig section. And yes, I know that some of the
> > entries are not properly placed there and in Makefile.)
> 
> Since 8250_dfl results in its own module, and my kernel config doesn't have
> FOURPORT, ACCENT, nor BOCA, I guess I don't understand the problem.

The Makefile is a bit chaotic, but try to find the sorted (more or less)
group of drivers that are not 4 ports and squeeze your entry there
(I expect somewhere between the LPSS/MID lines).

It will help to sort out that mess in the future.

> > >  obj-$(CONFIG_SERIAL_8250_EXAR_ST16C554)	+= 8250_exar_st16c554.o
> > >  obj-$(CONFIG_SERIAL_8250_HUB6)		+= 8250_hub6.o
> > >  obj-$(CONFIG_SERIAL_8250_FSL)		+= 8250_fsl.o

-- 
With Best Regards,
Andy Shevchenko


