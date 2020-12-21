Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44B872DF80E
	for <lists+linux-fpga@lfdr.de>; Mon, 21 Dec 2020 04:39:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725497AbgLUDiv (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 20 Dec 2020 22:38:51 -0500
Received: from mga02.intel.com ([134.134.136.20]:9441 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725308AbgLUDiv (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Sun, 20 Dec 2020 22:38:51 -0500
IronPort-SDR: /QZ+yMIHYFMzW8OHwbgXL71rj2bwfuHJS2OmikUOKvECJb3YKOC7Yr+ANpwR/yYqhkUa6HwlRD
 0PUh/ayw/nvA==
X-IronPort-AV: E=McAfee;i="6000,8403,9841"; a="162729648"
X-IronPort-AV: E=Sophos;i="5.78,436,1599548400"; 
   d="scan'208";a="162729648"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2020 19:38:11 -0800
IronPort-SDR: 7sVttmY8nnPVY6zZbIUzG7ZGryPNO4JyJYMVMSqPznypG0B4qFG0/MKzm9TIndFr9KLS+bvUYs
 laWEUbsRLeOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,436,1599548400"; 
   d="scan'208";a="340478915"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.141])
  by orsmga003.jf.intel.com with ESMTP; 20 Dec 2020 19:38:09 -0800
Date:   Mon, 21 Dec 2020 11:33:46 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Tom Rix <trix@redhat.com>
Cc:     "Wu, Hao" <hao.wu@intel.com>, "mdf@kernel.org" <mdf@kernel.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "lgoncalv@redhat.com" <lgoncalv@redhat.com>
Subject: Re: [PATCH v3 2/3] fpga: dfl: add the userspace I/O device support
  for DFL devices
Message-ID: <20201221033346.GE14854@yilunxu-OptiPlex-7050>
References: <1608183881-18692-1-git-send-email-yilun.xu@intel.com>
 <1608183881-18692-3-git-send-email-yilun.xu@intel.com>
 <DM6PR11MB381997F5E297408A68BF5F2185C30@DM6PR11MB3819.namprd11.prod.outlook.com>
 <0d3f1f40-9f89-0ec2-96c4-b8b087f31382@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0d3f1f40-9f89-0ec2-96c4-b8b087f31382@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Fri, Dec 18, 2020 at 05:59:17AM -0800, Tom Rix wrote:
> 
> On 12/18/20 12:05 AM, Wu, Hao wrote:
> >> Subject: [PATCH v3 2/3] fpga: dfl: add the userspace I/O device support for
> >> DFL devices
> >>
> >> This patch supports the DFL drivers be written in userspace. This is
> >> realized by exposing the userspace I/O device interfaces.
> >>
> >> The driver leverages the uio_pdrv_genirq, it adds the uio_pdrv_genirq
> >> platform device with the DFL device's resources, and let the generic UIO
> >> platform device driver provide support to userspace access to kernel
> >> interrupts and memory locations.
> >>
> >> The driver matches DFL devices in a different way. It has no device id
> >> table, instead it matches any DFL device which could not be handled by
> >> other DFL drivers.
> > Looks like we want to build UIO driver as the default/generic driver for DFL,

I'm not going to make UIO as the default driver for DFL devs, the driver
module will not be autoloaded. I want to provide a choice to operate on
the unhandled devs in userspace. Insmod it if it helps otherwise leave
it.

> > it seems fine but my concern is that UIO has its own limitation, if some day,
> > dfl device is extended, but UIO has limitation, then we may need to select 
> > another one as the default driver.. or we can just match them using 

I think we may not have to select a "default" driver, if we have a
better way for userspace accessing, we could load that module, leave
UIO.

> > id_table as we know UIO meets the requirement for those DFL devices?

As we discussed, the drawback is that we should always change the code to
support a new dfl device for user accessing. But it is OK to me if the
generic UIO match rule is not considered proper.

> 
> When we have multiple defaults, could this be handled in the configury ?

I think we don't have to select a "default".

> 
> Tom
> 
> >
> >> Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> >> ---
> >> v2: switch to the new matching algorithem. It matches DFL devices which
> >>      could not be handled by other DFL drivers.
> >>     refacor the code about device resources filling.
> >>     fix some comments.
> >> v3: split the dfl.c changes out of this patch.
> >>     some minor fixes
> >> ---
> >>  drivers/fpga/Kconfig        |  10 ++++
> >>  drivers/fpga/Makefile       |   1 +
> >>  drivers/fpga/dfl-uio-pdev.c | 110
> >> ++++++++++++++++++++++++++++++++++++++++++++
> >>  3 files changed, 121 insertions(+)
> >>  create mode 100644 drivers/fpga/dfl-uio-pdev.c
> >>
> >> diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
> >> index 5d7f0ae..7a88af9 100644
> >> --- a/drivers/fpga/Kconfig
> >> +++ b/drivers/fpga/Kconfig
> >> @@ -202,6 +202,16 @@ config FPGA_DFL_NIOS_INTEL_PAC_N3000
> >>  	  the card. It also instantiates the SPI master (spi-altera) for
> >>  	  the card's BMC (Board Management Controller).
> >>
> >> +config FPGA_DFL_UIO_PDEV
> >> +	tristate "FPGA DFL Driver for Userspace I/O platform devices"
> >> +	depends on FPGA_DFL && UIO_PDRV_GENIRQ
> >> +	help
> >> +	  Enable this to allow some DFL drivers be written in userspace. It
> >> +	  adds the uio_pdrv_genirq platform device with the DFL feature's
> >> +	  resources, and lets the generic UIO platform device driver provide
> >> +	  support for userspace access to kernel interrupts and memory
> >> +	  locations.
> > If we consider this as a default driver for everybody in DFL, then we could
> > consider build it into the core, otherwise it always requires to be loaded
> > manually, right?

It should be loaded manually. I don't want to make this as default.

> >
> >> +
> >>  config FPGA_DFL_PCI
> >>  	tristate "FPGA DFL PCIe Device Driver"
> >>  	depends on PCI && FPGA_DFL
> >> diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
> >> index 18dc9885..8847fe0 100644
> >> --- a/drivers/fpga/Makefile
> >> +++ b/drivers/fpga/Makefile
> >> @@ -45,6 +45,7 @@ dfl-afu-objs := dfl-afu-main.o dfl-afu-region.o dfl-afu-
> >> dma-region.o
> >>  dfl-afu-objs += dfl-afu-error.o
> >>
> >>  obj-$(CONFIG_FPGA_DFL_NIOS_INTEL_PAC_N3000)	+= dfl-n3000-nios.o
> >> +obj-$(CONFIG_FPGA_DFL_UIO_PDEV)		+= dfl-uio-pdev.o
> >>
> >>  # Drivers for FPGAs which implement DFL
> >>  obj-$(CONFIG_FPGA_DFL_PCI)		+= dfl-pci.o
> >> diff --git a/drivers/fpga/dfl-uio-pdev.c b/drivers/fpga/dfl-uio-pdev.c
> >> new file mode 100644
> >> index 0000000..8c57233
> >> --- /dev/null
> >> +++ b/drivers/fpga/dfl-uio-pdev.c
> >> @@ -0,0 +1,110 @@
> >> +// SPDX-License-Identifier: GPL-2.0
> >> +/*
> >> + * DFL driver for Userspace I/O platform devices
> >> + *
> >> + * Copyright (C) 2020 Intel Corporation, Inc.
> >> + */
> >> +#include <linux/dfl.h>
> >> +#include <linux/errno.h>
> >> +#include <linux/kernel.h>
> >> +#include <linux/module.h>
> >> +#include <linux/platform_device.h>
> >> +#include <linux/slab.h>
> >> +#include <linux/uio_driver.h>
> >> +
> >> +#include "dfl.h"
> >> +
> >> +#define DRIVER_NAME "dfl-uio-pdev"
> >> +
> >> +static struct dfl_driver dfl_uio_pdev_driver;
> >> +
> >> +static int check_for_other_drv_match(struct device_driver *drv, void *data)
> >> +{
> >> +	struct dfl_driver *ddrv = to_dfl_drv(drv);
> >> +	struct dfl_device *ddev = data;
> >> +
> >> +	/* skip myself */
> >> +	if (ddrv == &dfl_uio_pdev_driver)
> >> +		return 0;
> >> +
> >> +	return dfl_match_device(ddev, ddrv);
> >> +}
> >> +
> >> +static int dfl_uio_pdev_match(struct dfl_device *ddev)
> >> +{
> >> +	/*
> >> +	 * If any other driver wants the device, leave the device to this other
> >> +	 * driver.
> >> +	 */
> >> +	if (bus_for_each_drv(&dfl_bus_type, NULL, ddev,
> >> check_for_other_drv_match))
> >> +		return 0;
> >> +
> >> +	return 1;
> >> +}
> >> +
> >> +static int dfl_uio_pdev_probe(struct dfl_device *ddev)
> >> +{
> >> +	struct device *dev = &ddev->dev;
> >> +	struct platform_device_info pdevinfo = { 0 };
> >> +	struct uio_info uio_pdata = { 0 };
> >> +	struct platform_device *uio_pdev;
> >> +	struct resource *res;
> >> +	int i;
> >> +
> >> +	pdevinfo.name = "uio_pdrv_genirq";
> >> +
> >> +	res = kcalloc(ddev->num_irqs + 1, sizeof(*res), GFP_KERNEL);
> >> +	if (!res)
> >> +		return -ENOMEM;
> >> +
> >> +	res[0].parent = &ddev->mmio_res;
> >> +	res[0].flags = IORESOURCE_MEM;
> >> +	res[0].start = ddev->mmio_res.start;
> >> +	res[0].end = ddev->mmio_res.end;
> >> +
> >> +	/* then add irq resource */
> >> +	for (i = 0; i < ddev->num_irqs; i++) {
> >> +		res[i + 1].flags = IORESOURCE_IRQ;
> >> +		res[i + 1].start = ddev->irqs[i];
> >> +		res[i + 1].end = ddev->irqs[i];
> >> +	}
> > How many interrupts UIO could support? or we need some
> > warning or just even return error here?

Yes, I can add some warning here.

Thanks,
Yilun
