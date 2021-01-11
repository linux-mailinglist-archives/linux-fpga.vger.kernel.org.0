Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A36332F0CD0
	for <lists+linux-fpga@lfdr.de>; Mon, 11 Jan 2021 07:21:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726202AbhAKGVf (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 11 Jan 2021 01:21:35 -0500
Received: from mga11.intel.com ([192.55.52.93]:18040 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726151AbhAKGVf (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 11 Jan 2021 01:21:35 -0500
IronPort-SDR: 5hyjcP40wFesYfZXWsDgVzoUzbHcar/Rie+MGW1/NPLbrz68i/2uWqhctErjujqKaRpa6DNoHz
 miUHj2dJS1tQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9860"; a="174303049"
X-IronPort-AV: E=Sophos;i="5.79,337,1602572400"; 
   d="scan'208";a="174303049"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2021 22:20:55 -0800
IronPort-SDR: GfYCac+F2z20z99Te+SO6V55jqUTB9D/2KEqzQybE4K03my9VCwzl8/XVhNFj/0dq9JbstRLb9
 H/yhmRHCPabQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,337,1602572400"; 
   d="scan'208";a="399694656"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.141])
  by fmsmga002.fm.intel.com with ESMTP; 10 Jan 2021 22:20:52 -0800
Date:   Mon, 11 Jan 2021 14:16:03 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Moritz Fischer <mdf@kernel.org>
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, trix@redhat.com, lgoncalv@redhat.com,
        hao.wu@intel.com, yilun.xu@intel.com
Subject: Re: [PATCH v5 1/2] fpga: dfl: add the userspace I/O device support
  for DFL devices
Message-ID: <20210111061602.GA13963@yilunxu-OptiPlex-7050>
References: <1609557182-20787-1-git-send-email-yilun.xu@intel.com>
 <1609557182-20787-2-git-send-email-yilun.xu@intel.com>
 <X/tfZQz8tCGkabMZ@archbook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <X/tfZQz8tCGkabMZ@archbook>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Sun, Jan 10, 2021 at 12:11:17PM -0800, Moritz Fischer wrote:
> On Sat, Jan 02, 2021 at 11:13:01AM +0800, Xu Yilun wrote:
> > This patch supports the DFL drivers be written in userspace. This is
> > realized by exposing the userspace I/O device interfaces.
> > 
> > The driver leverages the uio_pdrv_genirq, it adds the uio_pdrv_genirq
> > platform device with the DFL device's resources, and let the generic UIO
> > platform device driver provide support to userspace access to kernel
> > interrupts and memory locations.
> > 
> > The driver now supports the ether group feature. To support a new DFL
> > feature been directly accessed via UIO, its feature id should be added to
> > the driver's id_table.
> > 
> > Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> > Reviewed-by: Tom Rix <trix@redhat.com>
> > ---
> > v2: switch to the new matching algorithem. It matches DFL devices which
> >      could not be handled by other DFL drivers.
> >     refacor the code about device resources filling.
> >     fix some comments.
> > v3: split the dfl.c changes out of this patch.
> >     some minor fixes
> > v4: drop the idea of a generic matching algorithem, instead we specify
> >      each matching device in id_table.
> >     to make clear that only one irq is supported, the irq handling code
> >      is refactored.
> > v5: refactor the irq resource code.
> > ---
> >  drivers/fpga/Kconfig        | 10 +++++
> >  drivers/fpga/Makefile       |  1 +
> >  drivers/fpga/dfl-uio-pdev.c | 91 +++++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 102 insertions(+)
> >  create mode 100644 drivers/fpga/dfl-uio-pdev.c
> > 
> > diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
> > index 5ff9438..61445be 100644
> > --- a/drivers/fpga/Kconfig
> > +++ b/drivers/fpga/Kconfig
> > @@ -203,6 +203,16 @@ config FPGA_DFL_NIOS_INTEL_PAC_N3000
> >  	  the card. It also instantiates the SPI master (spi-altera) for
> >  	  the card's BMC (Board Management Controller).
> >  
> > +config FPGA_DFL_UIO_PDEV
> > +	tristate "FPGA DFL Driver for Userspace I/O platform devices"
> > +	depends on FPGA_DFL && UIO_PDRV_GENIRQ
> > +	help
> > +	  Enable this to allow some DFL drivers be written in userspace. It
> > +	  adds the uio_pdrv_genirq platform device with the DFL feature's
> > +	  resources, and lets the generic UIO platform device driver provide
> > +	  support for userspace access to kernel interrupts and memory
> > +	  locations.
> > +
> >  config FPGA_DFL_PCI
> >  	tristate "FPGA DFL PCIe Device Driver"
> >  	depends on PCI && FPGA_DFL
> > diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
> > index 18dc9885..8847fe0 100644
> > --- a/drivers/fpga/Makefile
> > +++ b/drivers/fpga/Makefile
> > @@ -45,6 +45,7 @@ dfl-afu-objs := dfl-afu-main.o dfl-afu-region.o dfl-afu-dma-region.o
> >  dfl-afu-objs += dfl-afu-error.o
> >  
> >  obj-$(CONFIG_FPGA_DFL_NIOS_INTEL_PAC_N3000)	+= dfl-n3000-nios.o
> > +obj-$(CONFIG_FPGA_DFL_UIO_PDEV)		+= dfl-uio-pdev.o
> >  
> >  # Drivers for FPGAs which implement DFL
> >  obj-$(CONFIG_FPGA_DFL_PCI)		+= dfl-pci.o
> > diff --git a/drivers/fpga/dfl-uio-pdev.c b/drivers/fpga/dfl-uio-pdev.c
> > new file mode 100644
> > index 0000000..a4cd581
> > --- /dev/null
> > +++ b/drivers/fpga/dfl-uio-pdev.c
> > @@ -0,0 +1,91 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * DFL driver for Userspace I/O platform devices
> > + *
> > + * Copyright (C) 2020 Intel Corporation, Inc.
> > + */
> > +#include <linux/dfl.h>
> > +#include <linux/errno.h>
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/slab.h>
> > +#include <linux/uio_driver.h>
> > +
> > +#define DRIVER_NAME "dfl-uio-pdev"
> > +
> > +static int dfl_uio_pdev_probe(struct dfl_device *ddev)
> > +{
> > +	struct platform_device_info pdevinfo = { 0 };
> > +	struct uio_info uio_pdata = { 0 };
> > +	struct platform_device *uio_pdev;
> > +	struct device *dev = &ddev->dev;
> > +	unsigned int num_res = 1;
> > +	struct resource res[2];
> > +
> > +	res[0].parent = &ddev->mmio_res;
> > +	res[0].flags = IORESOURCE_MEM;
> > +	res[0].start = ddev->mmio_res.start;
> > +	res[0].end = ddev->mmio_res.end;
> > +
> > +	if (ddev->num_irqs) {
> > +		if (ddev->num_irqs > 1)
> > +			dev_warn(&ddev->dev,
> > +				 "%d irqs for %s, but UIO only supports the first one\n",
> > +				 ddev->num_irqs, dev_name(&ddev->dev));
> > +
> > +		res[1].flags = IORESOURCE_IRQ;
> > +		res[1].start = ddev->irqs[0];
> > +		res[1].end = ddev->irqs[0];
> > +		num_res++;
> > +	}
> > +
> > +	uio_pdata.name = DRIVER_NAME;
> > +	uio_pdata.version = "0";
> > +
> > +	pdevinfo.name = "uio_pdrv_genirq";
> > +	pdevinfo.res = res;
> > +	pdevinfo.num_res = num_res;
> > +	pdevinfo.parent = &ddev->dev;
> > +	pdevinfo.id = PLATFORM_DEVID_AUTO;
> > +	pdevinfo.data = &uio_pdata;
> > +	pdevinfo.size_data = sizeof(uio_pdata);
> > +
> > +	uio_pdev = platform_device_register_full(&pdevinfo);
> > +	if (!IS_ERR(uio_pdev))
> > +		dev_set_drvdata(dev, uio_pdev);
> 
> I'm not sure if this is more readable than:
> 
>    	uio_pdev = platform_device_register_full(&pdevinfo);
>    	if (IS_ERR(uio_pdev))
>    		return PTR_ERR(uio_pdev);
> 
> 	dev_set_drvdata(dev, uio_pdev);
> 	return 0;
> 
> No strong preference, though ... :)

I think your version is more readable, I'll change it.

> > +
> > +	return PTR_ERR_OR_ZERO(uio_pdev);
> > +}
> > +
> > +static void dfl_uio_pdev_remove(struct dfl_device *ddev)
> > +{
> > +	struct platform_device *uio_pdev = dev_get_drvdata(&ddev->dev);
> > +
> > +	platform_device_unregister(uio_pdev);
> > +}
> > +
> > +#define FME_FEATURE_ID_ETH_GROUP	0x10
> > +
> > +static const struct dfl_device_id dfl_uio_pdev_ids[] = {
> > +	{ FME_ID, FME_FEATURE_ID_ETH_GROUP },
> 
> Will you want to always bind FME_FEATURE_ID_ETH_GROUP? If not I'd suggest not
> to add it here.

Actually this is not the most preferable to me. I'm always looking for a
generic way to bind the uio driver to user assigned dfl devices. But there
is concern that userspace should not be responsible for the device driver
matching in previous mail thread:

https://lore.kernel.org/linux-fpga/1602828151-24784-2-git-send-email-yilun.xu@intel.com/

But TBH I still didn't figure out why driver_override is not OK in this
case.

> 
> If you want to provide an option to somewhat non-ABI fixed bind things
> you could look at what vfio-pci does (provide a module parameter),
> otherwise use sysfs 'new_id' or 'bind'.

I would like to have a "new_id" for dfl bus driver. It is not generic to
all drivers, I need to add the attr for dfl drivers like pci do.

My concern is how the module param or "new_id" is different from
"driver_override", seems userspace is also taking part in the device
matching.

But since we've restarted the discussion, I'm very much willing to have
a try on the "new_id".

Thanks,
Yilun
