Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6775535D415
	for <lists+linux-fpga@lfdr.de>; Tue, 13 Apr 2021 01:45:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239269AbhDLXpH (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 12 Apr 2021 19:45:07 -0400
Received: from mga04.intel.com ([192.55.52.120]:30725 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238646AbhDLXpH (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 12 Apr 2021 19:45:07 -0400
IronPort-SDR: D0qAYcRd3wQ9ON8jZIBvHZFud0VYSgP7Wz5jdxzb1e7mLYUufqkbwiPqxo7h3oufIr0hHSl8hx
 wMou/sIXzj/w==
X-IronPort-AV: E=McAfee;i="6200,9189,9952"; a="192170186"
X-IronPort-AV: E=Sophos;i="5.82,216,1613462400"; 
   d="scan'208";a="192170186"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2021 16:44:43 -0700
IronPort-SDR: NY65vNL7gMbTsL7ebvY+8mSC4gJ4V9LdqdQzuoeT12E/Yx6yVBw8oRh+dFFQacwY2+rylFL9DV
 OqIVzhaRMPrg==
X-IronPort-AV: E=Sophos;i="5.82,216,1613462400"; 
   d="scan'208";a="424014978"
Received: from rhweight-wrk1.ra.intel.com ([137.102.106.42])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2021 16:44:43 -0700
Date:   Mon, 12 Apr 2021 16:46:10 -0700 (PDT)
From:   matthew.gerlach@linux.intel.com
X-X-Sender: mgerlach@rhweight-WRK1
To:     "Wu, Hao" <hao.wu@intel.com>
cc:     "Xu, Yilun" <yilun.xu@intel.com>, Moritz Fischer <mdf@kernel.org>,
        "trix@redhat.com" <trix@redhat.com>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jdelvare@suse.com" <jdelvare@suse.com>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "russell.h.weight@linux.intel.com" <russell.h.weight@linux.intel.com>
Subject: RE: [PATCH 2/3] fpga: dfl: Add DFL bus driver for Altera SPI
 Master
In-Reply-To: <DM6PR11MB381916140583F3C31D66EFC385739@DM6PR11MB3819.namprd11.prod.outlook.com>
Message-ID: <alpine.DEB.2.22.394.2104121610040.413249@rhweight-WRK1>
References: <20210405235301.187542-1-matthew.gerlach@linux.intel.com> <20210405235301.187542-3-matthew.gerlach@linux.intel.com> <YGuvFYvJTMPPm2Jy@epycbox.lan> <alpine.DEB.2.22.394.2104060847030.208844@rhweight-WRK1> <YGyQdN9uS/niyFDP@epycbox.lan>
 <DM6PR11MB3819E0FC4F735C72746CE54785749@DM6PR11MB3819.namprd11.prod.outlook.com> <20210408081152.GA2713@yilunxu-OptiPlex-7050> <DM6PR11MB3819317A55FD7798E778EC4D85749@DM6PR11MB3819.namprd11.prod.outlook.com> <20210409013730.GB2713@yilunxu-OptiPlex-7050>
 <DM6PR11MB381912BD810637E0CDA1885F85739@DM6PR11MB3819.namprd11.prod.outlook.com> <20210409054118.GA7986@yilunxu-OptiPlex-7050> <DM6PR11MB381916140583F3C31D66EFC385739@DM6PR11MB3819.namprd11.prod.outlook.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



On Fri, 9 Apr 2021, Wu, Hao wrote:

>> On Fri, Apr 09, 2021 at 12:02:47PM +0800, Wu, Hao wrote:
>>>>>>>>>>> +
>>>>>>>>>>> +static void dfl_spi_altera_remove(struct dfl_device *dfl_dev)
>>>>>>>>>>> +{
>>>>>>>>>>> +struct dfl_altera_spi *aspi = dev_get_drvdata(&dfl_dev->dev);
>>>>>>>>>>> +
>>>>>>>>>>> +platform_device_unregister(aspi->altr_spi);
>>>>>>>>>>> +}
>>>>>>>>>>> +
>>>>>>>>>>> +#define FME_FEATURE_ID_MAX10_SPI        0xe
>>>>>>>>>>> +
>>>>>>>>>>> +static const struct dfl_device_id dfl_spi_altera_ids[] = {
>>>>>>>>>>> +{ FME_ID, FME_FEATURE_ID_MAX10_SPI },
>>>>>>>>>>> +{ }
>>>>>>>>>>> +};
>>>>>>>>>>
>>>>>>>>>> Maybe you can extend the Altera SPI driver with this part?
>>>>>>>>>
>>>>>>>>> The file, drivers/spi/spi-altera.c, already has platform MODULE_
>>>> related
>>>>>>>>> code.  Wouldn't moving this code to that file produce conflicts?
>>>>>>>>
>>>>>>>> I've seen other drivers support multiple busses, so it should be
>>>>>>>> possible, there might be nuances I'm missing in my brief look at this,
>>>>>>>> though.
>>>>>>>>
>>>>>>>> I think one of them would be MODULE_DEVICE_TABLE(platform, ...)
>>>>>>>> and the other one MODULE_DEVICE_TABLE(dfl, ...)
>>>>>>>>
>>>>>>>> See drivers/i2c/busses/i2c-designware-platdrv.c for an example
>> (though
>>>>>>>> they might be guarding against what you describe with CONFIG_OF vs
>>>>>>>> CONFIG_ACPI)
>>>>>>>>
>>>>>>>> If that doesn't work we could split it up into
>>>>>>>>
>>>>>>>> altera-spi-plat.c and altera-spi-dfl.c and altera-spi-core.c
>>>>>>>> or something of that sort?
>>>>>>>>
>>>>>>>> My point being, now that we have a bus, let's use it and develop
>> drivers
>>>>>>>> according to the Linux device model where possible :)
>>>>>>>
>>>>>>> Agree. This does make sense from my side too. DFL core provides the
>>>>>> mechanism
>>>>>>> to enumerate different IPs on FPGA, but each function driver needs to
>> go
>>>> to
>>>>>>> related subsystem for review.  : )
>>>>>>>
>>>>>>> I understand that for FPGA case, it may have some additional logics for
>>>> specific
>>>>>>> purposes based on common altera spi master IP, then additional code
>> for
>>>>>>
>>>>>> I'm wondering if the additional logics are extensions for common spi-
>> altera.
>>>> Like
>>>>>> the
>>>>>> SPI_CORE_PARAMETER register, it is not within the register space of
>>>>>> spi-altera,
>>>>>>
>>>>>>
>>>>>>   |   |      +-------------+
>>>>>>   |DFL|------| +--------+  |
>>>>>>   |BUS|      | |SPI CORE|  |
>>>>>>   |   |      | |PARAM   |  |
>>>>>>   |   |      | +--------+  |
>>>>>>   |   |      |             |
>>>>>>   |   |      | +--------+  |   +-------+
>>>>>>              | |Indirect|  |   |spi    |
>>>>>>              | |access  +--+---|altera |
>>>>>>              | |master  |  |   +-------+
>>>>>>              | +--------+  |
>>>>>>              +-------------+
>>>>>>> a specific product still can be put into altera-spi-xxxx.c or altera-spi-dfl-
>>>> xxxx.c
>>>>>>
>>>>>> So is it proper we integrate this feature into spi-altera? Previously
>>>>>> we have merged the dfl-n3000-nios, its spi part is very similar as
>>>>>> this driver. The dfl-n3000-nios make the spi-altera as a sub device.
>>>>>> Could we borrow the idea, or could we just integrate this driver in
>>>>>> dfl-n3000-nios?
>>>>>
>>>>> Looks like those are enhancements of the IP. They can be applied even
>>>>
>>>> I don't think the extra registers are the enhancement of the IP. They
>>>> are not part of the IP because they are not within the IP's register
>>>> space. They are like some external way of describing the IP like
>>>> Devicetree or ACPI.
>>>
>>> Why adding new registers can't be consider as enhancement, those
>>> changes serve the original IP and make it better, right? small mmio
>>> footprint and parameter registers?
>>>
>>>>
>>>>> other buses are used, not only for DFL, like PCI device or platform device,
>>>>> right? then why not put related code together with the original IP?
>>>>
>>>> The code of devicetree or ACPI parsing are integrated in the IP drivers,
>>>> but for this case, it may not be proper for now, cause this style is not
>>>> formally introduced by any standard. IP specific parameters description
>>>> are not within the scope of DFL now.
>>>
>>> Not sure if I get your point, but it's possible that we add some enhancements
>>> to one IP then driver could be simplified and doesn't need devicetree any more.
>>> For sure, it's IP specific thing, not the scope of DFL.
>>>
>>> Then things become this: extension to IP to allow this IP to be used without
>>> device tree, so that this IP can be used in DFL or PCI or other buses without
>>> device tree?
>>
>> It's good to extend an IP, but it needs a published SPEC and stable
>> register interfaces. For now, the spi-altera driver conforms to the
>> "SPI Core" chapter of the following spec:
>>
>> https://www.intel.com/content/www/us/en/programmable/documentation/sf
>> o1400787952932.html
>>
>> There is no info about the core parameter register and this specific
>> indirect access bus. That's why I don't see these additional parts as
>> the enhancements to spi-altera. This DFL feature is like a wrapper for
>> the spi-altera sub device.
>
> It really doesn't matter, even if you consider this as an new IP, it's still a SPI
> Master, it's driver still need to be reviewed in drivers/spi subsystem. The
> worst case is that we need to write a new spi-xxx.c driver, that's it.
>
> From DFL part, DFL only can enumerate the common hardware resources,
> but no good way to help thing like this, specific IP parameters (which handle
> by devicetree in platform driver). So for some IPs , they still need some
> extensions to avoid such dependency (on device tree for parameters). I guess
> we may see more similar cases in the future.
>
> Anyway, I think we reached agreement that for device drivers on DFL bus, it
> needs to be reviewed in its own subsystem. : )

Yes, I agree that device drivers on the DFL bus should go in the 
appropriate the directory of the appropriate  framework.  As Moritz has 
pointed out there are already examples bus specific driver code, for 
multiple buses, being the driver framework directory (e.g. Designware 
I2C).

In this particular case, the Device Feature is wraps a particular 
instantiation of an Altera SPI Master controller.  As Yilun pointed out, this 
wrapper has a SPI_CORE_PARAMETER register which contains the values 
of all the configuration parameters of the Altera SPI Master IP block. 
This kind of information would also be included in a Device Tree 
description of the instantiation. The Device Feature also implements 
indirect register access to the actual registers of the Altera SPI Master 
that provides a bridge from the PCIe bus to the Avalon Slave containing 
the registers of the Altera SPI Master.

Given the Device Feature wraps an Altera SPI Master, it might still make 
sense for the DFL driver to instantiate a sub driver instance for the 
Altera SPI Master.  I will resubmit the current patches with 
drivers/fpga/dfl-spi-altera.c moved to drivers/spi/spi-altera-dfl.c for 
feedback from the SPI maintainers and continue investigating collapsing 
the DFL driver and the platform sub-driver into a single DFL driver.  My 
first attempt did not go well.

Matthew

directory of the app >
> Thanks
> Hao
>
>>
>> Thanks
>> Yilun
>
