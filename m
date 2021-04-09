Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 751C43594EC
	for <lists+linux-fpga@lfdr.de>; Fri,  9 Apr 2021 07:46:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbhDIFqN (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 9 Apr 2021 01:46:13 -0400
Received: from mga01.intel.com ([192.55.52.88]:33250 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229715AbhDIFqM (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Fri, 9 Apr 2021 01:46:12 -0400
IronPort-SDR: emEOgVbXuIrqFAZA339IF7r1mlPeBqHI6tzzym1pQORjAm7qosLWDrX65TyQhrdHyI7obAkxUk
 ZdhPRhMj5K0g==
X-IronPort-AV: E=McAfee;i="6000,8403,9948"; a="214113707"
X-IronPort-AV: E=Sophos;i="5.82,208,1613462400"; 
   d="scan'208";a="214113707"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2021 22:45:59 -0700
IronPort-SDR: tRgmdXAFflQUnaoxZHEUfJuiUJuPFhsYTuqDfoDD7MbPvxJU8SqWiE31BL82Rdo6ZqiwVhoUVu
 CsvOHh1w/KoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,208,1613462400"; 
   d="scan'208";a="450059140"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.141])
  by fmsmga002.fm.intel.com with ESMTP; 08 Apr 2021 22:45:56 -0700
Date:   Fri, 9 Apr 2021 13:41:18 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     "Wu, Hao" <hao.wu@intel.com>
Cc:     Moritz Fischer <mdf@kernel.org>,
        "matthew.gerlach@linux.intel.com" <matthew.gerlach@linux.intel.com>,
        "trix@redhat.com" <trix@redhat.com>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jdelvare@suse.com" <jdelvare@suse.com>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "russell.h.weight@linux.intel.com" <russell.h.weight@linux.intel.com>
Subject: Re: [PATCH 2/3] fpga: dfl: Add DFL bus driver for Altera SPI Master
Message-ID: <20210409054118.GA7986@yilunxu-OptiPlex-7050>
References: <20210405235301.187542-1-matthew.gerlach@linux.intel.com>
 <20210405235301.187542-3-matthew.gerlach@linux.intel.com>
 <YGuvFYvJTMPPm2Jy@epycbox.lan>
 <alpine.DEB.2.22.394.2104060847030.208844@rhweight-WRK1>
 <YGyQdN9uS/niyFDP@epycbox.lan>
 <DM6PR11MB3819E0FC4F735C72746CE54785749@DM6PR11MB3819.namprd11.prod.outlook.com>
 <20210408081152.GA2713@yilunxu-OptiPlex-7050>
 <DM6PR11MB3819317A55FD7798E778EC4D85749@DM6PR11MB3819.namprd11.prod.outlook.com>
 <20210409013730.GB2713@yilunxu-OptiPlex-7050>
 <DM6PR11MB381912BD810637E0CDA1885F85739@DM6PR11MB3819.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR11MB381912BD810637E0CDA1885F85739@DM6PR11MB3819.namprd11.prod.outlook.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Fri, Apr 09, 2021 at 12:02:47PM +0800, Wu, Hao wrote:
> > > > > > > > > +
> > > > > > > > > +static void dfl_spi_altera_remove(struct dfl_device *dfl_dev)
> > > > > > > > > +{
> > > > > > > > > +struct dfl_altera_spi *aspi = dev_get_drvdata(&dfl_dev->dev);
> > > > > > > > > +
> > > > > > > > > +platform_device_unregister(aspi->altr_spi);
> > > > > > > > > +}
> > > > > > > > > +
> > > > > > > > > +#define FME_FEATURE_ID_MAX10_SPI        0xe
> > > > > > > > > +
> > > > > > > > > +static const struct dfl_device_id dfl_spi_altera_ids[] = {
> > > > > > > > > +{ FME_ID, FME_FEATURE_ID_MAX10_SPI },
> > > > > > > > > +{ }
> > > > > > > > > +};
> > > > > > > >
> > > > > > > > Maybe you can extend the Altera SPI driver with this part?
> > > > > > >
> > > > > > > The file, drivers/spi/spi-altera.c, already has platform MODULE_
> > related
> > > > > > > code.  Wouldn't moving this code to that file produce conflicts?
> > > > > >
> > > > > > I've seen other drivers support multiple busses, so it should be
> > > > > > possible, there might be nuances I'm missing in my brief look at this,
> > > > > > though.
> > > > > >
> > > > > > I think one of them would be MODULE_DEVICE_TABLE(platform, ...)
> > > > > > and the other one MODULE_DEVICE_TABLE(dfl, ...)
> > > > > >
> > > > > > See drivers/i2c/busses/i2c-designware-platdrv.c for an example (though
> > > > > > they might be guarding against what you describe with CONFIG_OF vs
> > > > > > CONFIG_ACPI)
> > > > > >
> > > > > > If that doesn't work we could split it up into
> > > > > >
> > > > > > altera-spi-plat.c and altera-spi-dfl.c and altera-spi-core.c
> > > > > > or something of that sort?
> > > > > >
> > > > > > My point being, now that we have a bus, let's use it and develop drivers
> > > > > > according to the Linux device model where possible :)
> > > > >
> > > > > Agree. This does make sense from my side too. DFL core provides the
> > > > mechanism
> > > > > to enumerate different IPs on FPGA, but each function driver needs to go
> > to
> > > > > related subsystem for review.  : )
> > > > >
> > > > > I understand that for FPGA case, it may have some additional logics for
> > specific
> > > > > purposes based on common altera spi master IP, then additional code for
> > > >
> > > > I'm wondering if the additional logics are extensions for common spi-altera.
> > Like
> > > > the
> > > > SPI_CORE_PARAMETER register, it is not within the register space of
> > > > spi-altera,
> > > >
> > > >
> > > >   |   |      +-------------+
> > > >   |DFL|------| +--------+  |
> > > >   |BUS|      | |SPI CORE|  |
> > > >   |   |      | |PARAM   |  |
> > > >   |   |      | +--------+  |
> > > >   |   |      |             |
> > > >   |   |      | +--------+  |   +-------+
> > > >              | |Indirect|  |   |spi    |
> > > >              | |access  +--+---|altera |
> > > >              | |master  |  |   +-------+
> > > >              | +--------+  |
> > > >              +-------------+
> > > > > a specific product still can be put into altera-spi-xxxx.c or altera-spi-dfl-
> > xxxx.c
> > > >
> > > > So is it proper we integrate this feature into spi-altera? Previously
> > > > we have merged the dfl-n3000-nios, its spi part is very similar as
> > > > this driver. The dfl-n3000-nios make the spi-altera as a sub device.
> > > > Could we borrow the idea, or could we just integrate this driver in
> > > > dfl-n3000-nios?
> > >
> > > Looks like those are enhancements of the IP. They can be applied even
> >
> > I don't think the extra registers are the enhancement of the IP. They
> > are not part of the IP because they are not within the IP's register
> > space. They are like some external way of describing the IP like
> > Devicetree or ACPI.
> 
> Why adding new registers can't be consider as enhancement, those
> changes serve the original IP and make it better, right? small mmio
> footprint and parameter registers?
> 
> >
> > > other buses are used, not only for DFL, like PCI device or platform device,
> > > right? then why not put related code together with the original IP?
> >
> > The code of devicetree or ACPI parsing are integrated in the IP drivers,
> > but for this case, it may not be proper for now, cause this style is not
> > formally introduced by any standard. IP specific parameters description
> > are not within the scope of DFL now.
> 
> Not sure if I get your point, but it's possible that we add some enhancements
> to one IP then driver could be simplified and doesn't need devicetree any more.
> For sure, it's IP specific thing, not the scope of DFL.
> 
> Then things become this: extension to IP to allow this IP to be used without
> device tree, so that this IP can be used in DFL or PCI or other buses without
> device tree?

It's good to extend an IP, but it needs a published SPEC and stable
register interfaces. For now, the spi-altera driver conforms to the
"SPI Core" chapter of the following spec:

https://www.intel.com/content/www/us/en/programmable/documentation/sfo1400787952932.html

There is no info about the core parameter register and this specific
indirect access bus. That's why I don't see these additional parts as
the enhancements to spi-altera. This DFL feature is like a wrapper for
the spi-altera sub device.

Thanks
Yilun
