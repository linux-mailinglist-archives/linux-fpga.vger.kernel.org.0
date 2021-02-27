Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33F8B326E7C
	for <lists+linux-fpga@lfdr.de>; Sat, 27 Feb 2021 18:51:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230258AbhB0Rud (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sat, 27 Feb 2021 12:50:33 -0500
Received: from mga11.intel.com ([192.55.52.93]:35647 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230203AbhB0Rsu (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Sat, 27 Feb 2021 12:48:50 -0500
IronPort-SDR: But1I5Rzzhu1a4NxTPpzw4GKdq+ymeA4hWsn/e0k+eKFMsPgHPzFesdCSFF2bDm5UGhpNVmBDD
 B9BdYeh7sm2A==
X-IronPort-AV: E=McAfee;i="6000,8403,9908"; a="182726569"
X-IronPort-AV: E=Sophos;i="5.81,211,1610438400"; 
   d="scan'208";a="182726569"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2021 09:44:23 -0800
IronPort-SDR: /n8a59ktF//veXNbtBiQZt9taBPEU5vI9yP4ZZRZJbo9LqXLQZx68Qb+9HjQccm7e2RzLyaqwF
 i4Dhsthatk0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,211,1610438400"; 
   d="scan'208";a="405464579"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.141])
  by orsmga008.jf.intel.com with ESMTP; 27 Feb 2021 09:44:20 -0800
Date:   Sun, 28 Feb 2021 01:39:41 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, trix@redhat.com, lgoncalv@redhat.com,
        hao.wu@intel.com, yilun.xu@intel.com
Subject: Re: [RESEND PATCH v11 1/2] uio: uio_dfl: add userspace i/o driver
  for DFL bus
Message-ID: <20210227173941.GA4009@yilunxu-OptiPlex-7050>
References: <1614439624-3946-1-git-send-email-yilun.xu@intel.com>
 <1614439624-3946-2-git-send-email-yilun.xu@intel.com>
 <YDpof59XjiOSoDnV@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YDpof59XjiOSoDnV@kroah.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Sat, Feb 27, 2021 at 04:42:55PM +0100, Greg KH wrote:
> On Sat, Feb 27, 2021 at 11:27:03PM +0800, Xu Yilun wrote:
> > This patch supports the DFL drivers be written in userspace. This is
> > realized by exposing the userspace I/O device interfaces.
> > 
> > The driver now only binds the ether group feature, which has no irq. So
> > the irq support is not implemented yet.
> > 
> > Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> > Reviewed-by: Tom Rix <trix@redhat.com>
> > ---
> > v9: switch to add a uio driver in drivers/uio
> > v10: add the source file in MAINTAINERS
> >      more descriptive Kconfig header
> >      add detailed path for opae uio example
> > v11: no change
> > ---
> >  MAINTAINERS           |  1 +
> >  drivers/uio/Kconfig   | 17 +++++++++++++
> >  drivers/uio/Makefile  |  1 +
> >  drivers/uio/uio_dfl.c | 66 +++++++++++++++++++++++++++++++++++++++++++++++++++
> >  4 files changed, 85 insertions(+)
> >  create mode 100644 drivers/uio/uio_dfl.c
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 000fe0b..4dc0354 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -6943,6 +6943,7 @@ S:	Maintained
> >  F:	Documentation/ABI/testing/sysfs-bus-dfl*
> >  F:	Documentation/fpga/dfl.rst
> >  F:	drivers/fpga/dfl*
> > +F:	drivers/uio/uio_dfl.c
> >  F:	include/linux/dfl.h
> >  F:	include/uapi/linux/fpga-dfl.h
> >  
> > diff --git a/drivers/uio/Kconfig b/drivers/uio/Kconfig
> > index 202ee81..5531f3a 100644
> > --- a/drivers/uio/Kconfig
> > +++ b/drivers/uio/Kconfig
> > @@ -165,4 +165,21 @@ config UIO_HV_GENERIC
> >  	  to network and storage devices from userspace.
> >  
> >  	  If you compile this as a module, it will be called uio_hv_generic.
> > +
> > +config UIO_DFL
> > +	tristate "Generic driver for DFL (Device Feature List) bus"
> > +	depends on FPGA_DFL
> > +	help
> > +	  Generic DFL (Device Feature List) driver for Userspace I/O devices.
> > +	  It is useful to provide direct access to DFL devices from userspace.
> > +	  A sample userspace application using this driver is available for
> > +	  download in a git repository:
> > +
> > +	    git clone https://github.com/OPAE/opae-sdk.git
> > +
> > +	  It could be found at:
> > +
> > +	    opae-sdk/tools/libopaeuio/
> > +
> > +	  If you compile this as a module, it will be called uio_dfl.
> >  endif
> > diff --git a/drivers/uio/Makefile b/drivers/uio/Makefile
> > index c285dd2..f2f416a1 100644
> > --- a/drivers/uio/Makefile
> > +++ b/drivers/uio/Makefile
> > @@ -11,3 +11,4 @@ obj-$(CONFIG_UIO_PRUSS)         += uio_pruss.o
> >  obj-$(CONFIG_UIO_MF624)         += uio_mf624.o
> >  obj-$(CONFIG_UIO_FSL_ELBC_GPCM)	+= uio_fsl_elbc_gpcm.o
> >  obj-$(CONFIG_UIO_HV_GENERIC)	+= uio_hv_generic.o
> > +obj-$(CONFIG_UIO_DFL)	+= uio_dfl.o
> > diff --git a/drivers/uio/uio_dfl.c b/drivers/uio/uio_dfl.c
> > new file mode 100644
> > index 0000000..89c0fc7
> > --- /dev/null
> > +++ b/drivers/uio/uio_dfl.c
> > @@ -0,0 +1,66 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Generic DFL driver for Userspace I/O devicess
> > + *
> > + * Copyright (C) 2021 Intel Corporation, Inc.
> > + */
> > +#include <linux/dfl.h>
> > +#include <linux/errno.h>
> > +#include <linux/module.h>
> > +#include <linux/uio_driver.h>
> > +
> > +#define DRIVER_NAME "uio_dfl"
> > +
> > +static int uio_dfl_probe(struct dfl_device *ddev)
> > +{
> > +	struct resource *r = &ddev->mmio_res;
> > +	struct device *dev = &ddev->dev;
> > +	struct uio_info *uioinfo;
> > +	struct uio_mem *uiomem;
> > +	int ret;
> > +
> > +	uioinfo = devm_kzalloc(dev, sizeof(struct uio_info), GFP_KERNEL);
> > +	if (!uioinfo)
> > +		return -ENOMEM;
> > +
> > +	uioinfo->name = DRIVER_NAME;
> > +	uioinfo->version = "0";
> > +
> > +	uiomem = &uioinfo->mem[0];
> > +	uiomem->memtype = UIO_MEM_PHYS;
> > +	uiomem->addr = r->start & PAGE_MASK;
> > +	uiomem->offs = r->start & ~PAGE_MASK;
> > +	uiomem->size = (uiomem->offs + resource_size(r)
> > +			+ PAGE_SIZE - 1) & PAGE_MASK;
> > +	uiomem->name = r->name;
> > +
> > +	/* Irq is yet to be supported */
> > +	uioinfo->irq = UIO_IRQ_NONE;
> > +
> > +	ret = devm_uio_register_device(dev, uioinfo);
> > +	if (ret)
> > +		dev_err(dev, "unable to register uio device\n");
> > +
> > +	return ret;
> > +}
> > +
> > +#define FME_FEATURE_ID_ETH_GROUP	0x10
> 
> Why are you saying that an ethernet driver should be using the UIO
> interface?

The ETH GROUP IP is not designed as the full functional ethernet
controller. It is specially developed for the Intel N3000 NIC. Since it
is an FPGA based card, it is designed for the users to runtime reload
part of the MAC layer logic developed by themselves, while the ETH GROUP
is another part of the MAC which is not expected to be reloaded by
customers, but it provides some configurations for software to work with
the user logic.

So I catagory the feature as the devices that "designed for specific
purposes and does not fit into one of the standard kernel subsystems".
Some related description could be found in Patch #2, to illustrate why
using UIO for some DFL devices.

> 
> And why can't you use the existing UIO drivers that bind to memory

There are now UIO drivers for PCI or platform devices, but in this case
we are going to export a DFL(Device Feature List) bus device to
userspace, a DFL driver for UIO is needed to bind to it.

> regions specified by firmware?  Without an interrupt being used, why is
> UIO needed at all?

This DFL UIO driver could exports the MMIO of a DFL device to users for
direct access. This is enough for the only ETH GROUP feature been fully
controlled by user since it supports no interrupt.

The memory regions for DFL devices are enumerated by DFL core according to
the Device Feature List info on hardware, not specified by firmware tables.
People may also use /dev/mem, but they have no knowledge of the memory base
of the DFL device they want.

Some DFL features support interrupts but they are handled by kernel drivers.
We may add interrupt support for the DFL UIO driver when it is to support
a new DFL feature with interrupts.


Thanks,
Yilun
