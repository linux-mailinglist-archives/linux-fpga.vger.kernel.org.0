Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AA785F711B
	for <lists+linux-fpga@lfdr.de>; Fri,  7 Oct 2022 00:25:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbiJFWYD (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 6 Oct 2022 18:24:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232283AbiJFWYB (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 6 Oct 2022 18:24:01 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08F2CF1904;
        Thu,  6 Oct 2022 15:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665095040; x=1696631040;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=KfziOm5EbaEsewwxZsiXqYnDBhy0tNb1GQYOUvhzcvs=;
  b=XWtw4sJVLsOFzafsH1XPKNQ7AWv32ah3pvQ7wYKxAk1yPL4BcK+ST3Y4
   E2kipGti57kn2Kc2vIqdcU8kW7a2hpdE3BeKovIwupvKK0+9iSu+IZOG6
   hXvxtJoSW2FDtk/c5G0KnwmUPvHJZpb9lwg6jPG6iF4XJCZk6NBmUjgE8
   fPRKQmmBbCgMxVWeL44WnqtTxlijcG/cHdhsMPjyrML/TSf1FTiIPTf7/
   pHU9zb58EJk5ojVQMjFkq5s+fwu0RYLsSydqYIslr2VI/Qr0/fFCnvcst
   yEBDaoxKZoa3cxwYyl5fh3jNf9xYaPf7xPG75qsfTsTWcgrNUl3NMx0IK
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10492"; a="286816182"
X-IronPort-AV: E=Sophos;i="5.95,164,1661842800"; 
   d="scan'208";a="286816182"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2022 15:23:59 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10492"; a="714025046"
X-IronPort-AV: E=Sophos;i="5.95,164,1661842800"; 
   d="scan'208";a="714025046"
Received: from rhweight-wrk1.ra.intel.com ([137.102.106.139])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2022 15:23:58 -0700
Date:   Thu, 6 Oct 2022 15:24:16 -0700 (PDT)
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
In-Reply-To: <Yz8T8GdzMLyAKIMb@smile.fi.intel.com>
Message-ID: <alpine.DEB.2.22.394.2210061517300.1772307@rhweight-WRK1>
References: <20221004143718.1076710-1-matthew.gerlach@linux.intel.com> <20221004143718.1076710-5-matthew.gerlach@linux.intel.com> <YzxRxo8jL7rB1+px@smile.fi.intel.com> <alpine.DEB.2.22.394.2210060940150.1988353@rhweight-WRK1>
 <Yz8T8GdzMLyAKIMb@smile.fi.intel.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



On Thu, 6 Oct 2022, Andy Shevchenko wrote:

> On Thu, Oct 06, 2022 at 10:00:43AM -0700, matthew.gerlach@linux.intel.com wrote:
>> On Tue, 4 Oct 2022, Andy Shevchenko wrote:
>>> On Tue, Oct 04, 2022 at 07:37:18AM -0700, matthew.gerlach@linux.intel.com wrote:
>
> ...
>
>>>> Reported-by: kernel test robot <lkp@intel.com>
>>>
>>> https://docs.kernel.org/process/submitting-patches.html?highlight=reported#using-reported-by-tested-by-reviewed-by-suggested-by-and-fixes
>>>
>>> "The Reported-by tag gives credit to people who find bugs and report them and it
>>> hopefully inspires them to help us again in the future. Please note that if the
>>> bug was reported in private, then ask for permission first before using the
>>> Reported-by tag. The tag is intended for bugs; please do not use it to credit
>>> feature requests."
>>
>> The kernel test robot did find a bug in my v1 submission.  I was missing the
>> static keyword for a function declaration.  Should I remove the tag?
>
> What's yours take from the above documentation?
>

Since the kernel test robot did find a bug. The tag should stay.

> ...
>
>>>> +	dfh_base = devm_ioremap_resource(dev, &dfl_dev->mmio_res);
>>>> +	if (IS_ERR(dfh_base))
>>>> +		return PTR_ERR(dfh_base);
>>>> +
>>>> +	res_size = resource_size(&dfl_dev->mmio_res);
>>>> +
>>>> +	ret = dfl_uart_get_params(dev, dfh_base, res_size, &uart);
>>>
>>>> +	devm_iounmap(dev, dfh_base);
>>>> +	devm_release_mem_region(dev, dfl_dev->mmio_res.start, res_size);
>>>
>>> If it's temporary, may be you shouldn't even consider devm_ioremap_resource()
>>> to begin with? The devm_* release type of functions in 99% of the cases
>>> indicate of the abusing devm_.
>>
>> I will change the code to call ioremap() and request_mem_region() directly
>> instead of the devm_ versions.
>
> But why will you need request_mem_region() in that case?

It doesn't seem that I need to call request_mem_regsion; so I will skip 
it.

>
>>>> +	if (ret < 0)
>>>> +		return dev_err_probe(dev, ret, "failed uart feature walk\n");
>
> ...
>
>>>> +config SERIAL_8250_DFL
>>>> +	tristate "DFL bus driver for Altera 16550 UART"
>>>> +	depends on SERIAL_8250 && FPGA_DFL
>>>> +	help
>>>> +	  This option enables support for a Device Feature List (DFL) bus
>>>> +	  driver for the Altera 16650 UART.  One or more Altera 16650 UARTs
>>>> +	  can be instantiated in a FPGA and then be discovered during
>>>> +	  enumeration of the DFL bus.
>>>
>>> When m, what be the module name?
>>
>> I see the file, kernel/drivers/tty/serial/8250/8250_dfl.ko, installed into
>> /lib/modules/...  I also see "alias dfl:t0000f0024* 8250_dfl" in
>> modules.alias
>
> My point is that user who will run `make menuconfig` will read this and have
> no clue after the kernel build if the module was built or not. Look into other
> (recent) sections of the Kconfig for drivers in the kernel for how they inform
> user about the module name (this more or less standard pattern you just need
> to copy'n'paste'n'edit carefully).
>
> ...

I think this should be added:
           To compile this driver as a module, chose M here: the
           module will be called 8250_dfl.
>
>>>>  obj-$(CONFIG_SERIAL_8250_FOURPORT)	+= 8250_fourport.o
>>>>  obj-$(CONFIG_SERIAL_8250_ACCENT)	+= 8250_accent.o
>>>>  obj-$(CONFIG_SERIAL_8250_BOCA)		+= 8250_boca.o
>>>> +obj-$(CONFIG_SERIAL_8250_DFL)		+= 8250_dfl.o
>>>
>>> This group of drivers for the 4 UARTs on the board or so, does FPGA belong to
>>> it? (Same Q, btw, for the Kconfig section. And yes, I know that some of the
>>> entries are not properly placed there and in Makefile.)
>>
>> Since 8250_dfl results in its own module, and my kernel config doesn't have
>> FOURPORT, ACCENT, nor BOCA, I guess I don't understand the problem.
>
> The Makefile is a bit chaotic, but try to find the sorted (more or less)
> group of drivers that are not 4 ports and squeeze your entry there
> (I expect somewhere between the LPSS/MID lines).
>
> It will help to sort out that mess in the future.

I will move 8250_dfl between LPSS and MID lines in the Makefile.  Should I 
move the definition in Kconfig to be between LPSS and MID to be consistent?

>
>>>>  obj-$(CONFIG_SERIAL_8250_EXAR_ST16C554)	+= 8250_exar_st16c554.o
>>>>  obj-$(CONFIG_SERIAL_8250_HUB6)		+= 8250_hub6.o
>>>>  obj-$(CONFIG_SERIAL_8250_FSL)		+= 8250_fsl.o
>
> -- 
> With Best Regards,
> Andy Shevchenko
>
>
>
