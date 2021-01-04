Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EE132E9077
	for <lists+linux-fpga@lfdr.de>; Mon,  4 Jan 2021 07:55:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726608AbhADGyp (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 4 Jan 2021 01:54:45 -0500
Received: from mga11.intel.com ([192.55.52.93]:43598 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725830AbhADGyp (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 4 Jan 2021 01:54:45 -0500
IronPort-SDR: EFjR3LmAqzlFgCkQtKqcV9gauWV9lyhXep2nd8CJEcTg3WhXjSpf4n5aIL2gqORpnBs/5OelJB
 VJfydbKtqb5g==
X-IronPort-AV: E=McAfee;i="6000,8403,9853"; a="173410343"
X-IronPort-AV: E=Sophos;i="5.78,473,1599548400"; 
   d="scan'208";a="173410343"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2021 22:54:02 -0800
IronPort-SDR: NS+Bt0RvoMM3NgDlgtYg9T/O8wPR4mUzl0OP2a6a3fgZnb6DG+umPanddvCtSS/3rliQD+k6Ad
 tAT/39QEcusw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,473,1599548400"; 
   d="scan'208";a="378305327"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.141])
  by orsmga008.jf.intel.com with ESMTP; 03 Jan 2021 22:54:00 -0800
Date:   Mon, 4 Jan 2021 14:49:19 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     "Wu, Hao" <hao.wu@intel.com>
Cc:     "mdf@kernel.org" <mdf@kernel.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "trix@redhat.com" <trix@redhat.com>,
        "lgoncalv@redhat.com" <lgoncalv@redhat.com>
Subject: Re: [PATCH v5 1/2] fpga: dfl: add the userspace I/O device support
  for DFL devices
Message-ID: <20210104064919.GA4151@yilunxu-OptiPlex-7050>
References: <1609557182-20787-1-git-send-email-yilun.xu@intel.com>
 <1609557182-20787-2-git-send-email-yilun.xu@intel.com>
 <DM6PR11MB3819CD80A065FC474128454B85D20@DM6PR11MB3819.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR11MB3819CD80A065FC474128454B85D20@DM6PR11MB3819.namprd11.prod.outlook.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Mon, Jan 04, 2021 at 12:16:30PM +0800, Wu, Hao wrote:
> > Subject: [PATCH v5 1/2] fpga: dfl: add the userspace I/O device support for
> > DFL devices
> >
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
> >  drivers/fpga/dfl-uio-pdev.c | 91
> > +++++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 102 insertions(+)
> >  create mode 100644 drivers/fpga/dfl-uio-pdev.c
> >
> > diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
> > index 5ff9438..61445be 100644
> > --- a/drivers/fpga/Kconfig
> > +++ b/drivers/fpga/Kconfig
> > @@ -203,6 +203,16 @@ config FPGA_DFL_NIOS_INTEL_PAC_N3000
> >    the card. It also instantiates the SPI master (spi-altera) for
> >    the card's BMC (Board Management Controller).
> >
> > +config FPGA_DFL_UIO_PDEV
> > +tristate "FPGA DFL Driver for Userspace I/O platform devices"
> > +depends on FPGA_DFL && UIO_PDRV_GENIRQ
> > +help
> > +  Enable this to allow some DFL drivers be written in userspace. It
> > +  adds the uio_pdrv_genirq platform device with the DFL feature's
> > +  resources, and lets the generic UIO platform device driver provide
> > +  support for userspace access to kernel interrupts and memory
> > +  locations.
> > +
> >  config FPGA_DFL_PCI
> >  tristate "FPGA DFL PCIe Device Driver"
> >  depends on PCI && FPGA_DFL
> > diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
> > index 18dc9885..8847fe0 100644
> > --- a/drivers/fpga/Makefile
> > +++ b/drivers/fpga/Makefile
> > @@ -45,6 +45,7 @@ dfl-afu-objs := dfl-afu-main.o dfl-afu-region.o dfl-afu-
> > dma-region.o
> >  dfl-afu-objs += dfl-afu-error.o
> >
> >  obj-$(CONFIG_FPGA_DFL_NIOS_INTEL_PAC_N3000)+= dfl-n3000-nios.o
> > +obj-$(CONFIG_FPGA_DFL_UIO_PDEV)+= dfl-uio-pdev.o
> >
> >  # Drivers for FPGAs which implement DFL
> >  obj-$(CONFIG_FPGA_DFL_PCI)+= dfl-pci.o
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
> > +struct platform_device_info pdevinfo = { 0 };
> > +struct uio_info uio_pdata = { 0 };
> > +struct platform_device *uio_pdev;
> > +struct device *dev = &ddev->dev;
> > +unsigned int num_res = 1;
> > +struct resource res[2];
> > +
> > +res[0].parent = &ddev->mmio_res;
> > +res[0].flags = IORESOURCE_MEM;
> > +res[0].start = ddev->mmio_res.start;
> > +res[0].end = ddev->mmio_res.end;
> > +
> > +if (ddev->num_irqs) {
> > +if (ddev->num_irqs > 1)
> > +dev_warn(&ddev->dev,
> > + "%d irqs for %s, but UIO only supports the
> > first one\n",
> > + ddev->num_irqs, dev_name(&ddev->dev));
> > +
> > +res[1].flags = IORESOURCE_IRQ;
> > +res[1].start = ddev->irqs[0];
> > +res[1].end = ddev->irqs[0];
> 
> Looks like res[] needs to be zeroed for other fields not used here.

Thanks for catching this. Will fix it.

Yilun
