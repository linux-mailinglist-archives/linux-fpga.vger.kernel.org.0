Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A69FE5F7A53
	for <lists+linux-fpga@lfdr.de>; Fri,  7 Oct 2022 17:12:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbiJGPK1 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 7 Oct 2022 11:10:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbiJGPKX (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 7 Oct 2022 11:10:23 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C53DF688AD;
        Fri,  7 Oct 2022 08:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665155422; x=1696691422;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=ozz4dRjKrdNdv2whvmeTudwuPMNq3KNa5u3HQ0DA55k=;
  b=fxm0p9vbv2DsUj+QclJeFLNEAVnUabjzLMkecQq8xppr3R4lLRx1TeOU
   E4eW8yXINhubRyRTrbFXHorhhWAYxkpu1wbbwYDBgICnYBNmd/oopOuk3
   GTOPpCF7M7K6vNQBlNhZzY8/cByFkjPgjMx95Ua0gLkS3jD9MAKZUALA7
   sYr4gdTTX5hQx3aIo1sjysSZOEGSaxoSQXCnFqVcF5rYe8awlqOKDNz4A
   AUQeZy/qpTV3vxTa2RVOXNMkgoiadVo4pD3aIG6oC2Lt2mbvHKRDLNDSJ
   5AmRzJBqgd6ANRGzbyqiqVHG2t0e+xUBrpCYfnikVGjqq7jINHXrPnOwe
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10493"; a="301357183"
X-IronPort-AV: E=Sophos;i="5.95,167,1661842800"; 
   d="scan'208";a="301357183"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2022 08:10:22 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10493"; a="625173439"
X-IronPort-AV: E=Sophos;i="5.95,167,1661842800"; 
   d="scan'208";a="625173439"
Received: from rhweight-wrk1.ra.intel.com ([137.102.106.139])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2022 08:10:21 -0700
Date:   Fri, 7 Oct 2022 08:10:34 -0700 (PDT)
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
In-Reply-To: <Yz/uTGeNaOP4Btli@smile.fi.intel.com>
Message-ID: <alpine.DEB.2.22.394.2210070807340.2155700@rhweight-WRK1>
References: <20221004143718.1076710-1-matthew.gerlach@linux.intel.com> <20221004143718.1076710-5-matthew.gerlach@linux.intel.com> <YzxRxo8jL7rB1+px@smile.fi.intel.com> <alpine.DEB.2.22.394.2210060940150.1988353@rhweight-WRK1> <Yz8T8GdzMLyAKIMb@smile.fi.intel.com>
 <alpine.DEB.2.22.394.2210061517300.1772307@rhweight-WRK1> <Yz/uTGeNaOP4Btli@smile.fi.intel.com>
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



On Fri, 7 Oct 2022, Andy Shevchenko wrote:

> On Thu, Oct 06, 2022 at 03:24:16PM -0700, matthew.gerlach@linux.intel.com wrote:
>> On Thu, 6 Oct 2022, Andy Shevchenko wrote:
>>> On Thu, Oct 06, 2022 at 10:00:43AM -0700, matthew.gerlach@linux.intel.com wrote:
>>>> On Tue, 4 Oct 2022, Andy Shevchenko wrote:
>>>>> On Tue, Oct 04, 2022 at 07:37:18AM -0700, matthew.gerlach@linux.intel.com wrote:
>
> ...
>
>>>>>> Reported-by: kernel test robot <lkp@intel.com>
>>>>>
>>>>> https://docs.kernel.org/process/submitting-patches.html?highlight=reported#using-reported-by-tested-by-reviewed-by-suggested-by-and-fixes
>>>>>
>>>>> "The Reported-by tag gives credit to people who find bugs and report them and it
>>>>> hopefully inspires them to help us again in the future. Please note that if the
>>>>> bug was reported in private, then ask for permission first before using the
>>>>> Reported-by tag. The tag is intended for bugs; please do not use it to credit
>>>>> feature requests."
>>>>
>>>> The kernel test robot did find a bug in my v1 submission.  I was missing the
>>>> static keyword for a function declaration.  Should I remove the tag?
>>>
>>> What's yours take from the above documentation?
>>
>> Since the kernel test robot did find a bug. The tag should stay.
>
> I suggest otherwise because of the last sentence in the cited excerpt: "please
> do not use it to credit feature requests". To distinguish "feature request" you
> can ask yourself "Am I fixing _existing_ code or adding a new one?" And the
> answer here is crystal clear (at least to me).
>
> ...
>
>>>>>> +config SERIAL_8250_DFL
>>>>>> +	tristate "DFL bus driver for Altera 16550 UART"
>>>>>> +	depends on SERIAL_8250 && FPGA_DFL
>>>>>> +	help
>>>>>> +	  This option enables support for a Device Feature List (DFL) bus
>>>>>> +	  driver for the Altera 16650 UART.  One or more Altera 16650 UARTs
>>>>>> +	  can be instantiated in a FPGA and then be discovered during
>>>>>> +	  enumeration of the DFL bus.
>>>>>
>>>>> When m, what be the module name?
>>>>
>>>> I see the file, kernel/drivers/tty/serial/8250/8250_dfl.ko, installed into
>>>> /lib/modules/...  I also see "alias dfl:t0000f0024* 8250_dfl" in
>>>> modules.alias
>>>
>>> My point is that user who will run `make menuconfig` will read this and have
>>> no clue after the kernel build if the module was built or not. Look into other
>>> (recent) sections of the Kconfig for drivers in the kernel for how they inform
>>> user about the module name (this more or less standard pattern you just need
>>> to copy'n'paste'n'edit carefully).
>>
>> I think this should be added:
>>           To compile this driver as a module, chose M here: the
>>           module will be called 8250_dfl.
>
> Looks good to me!
>
>
>>>>>>  obj-$(CONFIG_SERIAL_8250_FOURPORT)	+= 8250_fourport.o
>>>>>>  obj-$(CONFIG_SERIAL_8250_ACCENT)	+= 8250_accent.o
>>>>>>  obj-$(CONFIG_SERIAL_8250_BOCA)		+= 8250_boca.o
>>>>>> +obj-$(CONFIG_SERIAL_8250_DFL)		+= 8250_dfl.o
>>>>>
>>>>> This group of drivers for the 4 UARTs on the board or so, does FPGA belong to
>>>>> it? (Same Q, btw, for the Kconfig section. And yes, I know that some of the
>>>>> entries are not properly placed there and in Makefile.)
>>>>
>>>> Since 8250_dfl results in its own module, and my kernel config doesn't have
>>>> FOURPORT, ACCENT, nor BOCA, I guess I don't understand the problem.
>>>
>>> The Makefile is a bit chaotic, but try to find the sorted (more or less)
>>> group of drivers that are not 4 ports and squeeze your entry there
>>> (I expect somewhere between the LPSS/MID lines).
>>>
>>> It will help to sort out that mess in the future.
>>
>> I will move 8250_dfl between LPSS and MID lines in the Makefile.  Should I
>> move the definition in Kconfig to be between LPSS and MID to be consistent?
>
> D is not ordered if put between L and M, I meant not to literally put it there
> but think about it a bit.
>
> Kconfig is another story because it has different approach in ordering (seems
> so), try to find the best compromise there.

In the Kconfig, I think the driver fits into the section, Misc. 
options/drivers.  Within this section, I think SERIAL_8250_DFL should go 
before SERIAL_8250_DW to approximate alphabetical ordering.  Similarly, I 
think 8250_dfl.o should go above 8250_dw.o in the Makefile.

>
>>>>>>  obj-$(CONFIG_SERIAL_8250_EXAR_ST16C554)	+= 8250_exar_st16c554.o
>>>>>>  obj-$(CONFIG_SERIAL_8250_HUB6)		+= 8250_hub6.o
>>>>>>  obj-$(CONFIG_SERIAL_8250_FSL)		+= 8250_fsl.o
>
> -- 
> With Best Regards,
> Andy Shevchenko
>
>
>
