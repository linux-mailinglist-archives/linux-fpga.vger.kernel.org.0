Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41A8B2E75B9
	for <lists+linux-fpga@lfdr.de>; Wed, 30 Dec 2020 03:57:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726189AbgL3C46 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 29 Dec 2020 21:56:58 -0500
Received: from mga04.intel.com ([192.55.52.120]:50580 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726168AbgL3C46 (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 29 Dec 2020 21:56:58 -0500
IronPort-SDR: RMKby7vBYIVmskCxNhM+1WaAUkJmtWjSzr/GAzoVY9CILSQ1MUVJLVvBNHbgTNG2YYtIvvsXPh
 gvMZlrEyOLYQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9849"; a="173985255"
X-IronPort-AV: E=Sophos;i="5.78,459,1599548400"; 
   d="scan'208";a="173985255"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2020 18:56:17 -0800
IronPort-SDR: sWTuzCB9qqo0TExUF+5MzV+8l7KirNmJmzRG41pzLZSe8dG912KDhrymB4RzKOjbmSkcMKUS2q
 VB5vbr3WsHdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,459,1599548400"; 
   d="scan'208";a="419380230"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.141])
  by orsmga001.jf.intel.com with ESMTP; 29 Dec 2020 18:56:15 -0800
Date:   Wed, 30 Dec 2020 10:51:41 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Tom Rix <trix@redhat.com>
Cc:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        lgoncalv@redhat.com, hao.wu@intel.com
Subject: Re: [PATCH v4 1/2] fpga: dfl: add the userspace I/O device support
  for DFL devices
Message-ID: <20201230025140.GG14854@yilunxu-OptiPlex-7050>
References: <1609209776-7296-1-git-send-email-yilun.xu@intel.com>
 <1609209776-7296-2-git-send-email-yilun.xu@intel.com>
 <761ed67a-f4cd-2f6c-82db-d88873c7c718@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <761ed67a-f4cd-2f6c-82db-d88873c7c718@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Tue, Dec 29, 2020 at 06:37:37AM -0800, Tom Rix wrote:
> 
> On 12/28/20 6:42 PM, Xu Yilun wrote:
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
> > ---
> >  drivers/fpga/Kconfig        |  10 +++++
> >  drivers/fpga/Makefile       |   1 +
> >  drivers/fpga/dfl-uio-pdev.c | 101 ++++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 112 insertions(+)
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
> > index 0000000..1100434
> > --- /dev/null
> > +++ b/drivers/fpga/dfl-uio-pdev.c
> > @@ -0,0 +1,101 @@
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
> > +	struct device *dev = &ddev->dev;
> > +	struct platform_device_info pdevinfo = { 0 };
> > +	struct uio_info uio_pdata = { 0 };
> > +	struct platform_device *uio_pdev;
> > +	unsigned int num_res = 1;
> > +	struct resource *res;
> > +
> > +	if (ddev->num_irqs > 1)
> This num_irq check could be combined with the one below.

Yes, I'll change it.

> > +		dev_warn(&ddev->dev,
> > +			 "%d irqs for %s, but UIO only supports the first one\n",
> > +			 ddev->num_irqs, dev_name(&ddev->dev));
> > +
> > +	pdevinfo.name = "uio_pdrv_genirq";
> > +
> > +	if (ddev->num_irqs)
> > +		num_res++;
> > +
> > +	res = kcalloc(num_res, sizeof(*res), GFP_KERNEL);
> 
> Since num_res is at most 2, could res be converted to a stack array ?

Yes, I could refactor the code.

Thanks,
Yilun

> 
> Reviewed-by: Tom Rix <trix@redhat.com> 
