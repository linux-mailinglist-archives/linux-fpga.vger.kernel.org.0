Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3CE932739E
	for <lists+linux-fpga@lfdr.de>; Sun, 28 Feb 2021 18:21:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230214AbhB1RVg (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 28 Feb 2021 12:21:36 -0500
Received: from mail-pl1-f174.google.com ([209.85.214.174]:45010 "EHLO
        mail-pl1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbhB1RVe (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sun, 28 Feb 2021 12:21:34 -0500
Received: by mail-pl1-f174.google.com with SMTP id a24so8416524plm.11;
        Sun, 28 Feb 2021 09:21:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=l8w43V0nVo22Y2oRs1pu3SKBX3hEwYchxrB02/c0GGM=;
        b=Pfse8tDegLZLl2P0FGI2uv98HLNtXv7F3hSyql6AQKwnHxmI4abSxA+6Of/smJg7Kv
         2a4hbl0tR8kh6Cxj5mSzy+29Al1sIisfuATdPdgHbSaHgBf/wm4Dp46H4RBhW+tbDSmC
         eAEU01u4ciYaEvRRM0LrlXxsj6fy5a8YeYm7n0JURu5bDDSsnfSyD++RaqaoymuVY8cT
         H/4l2ySulx/SoYWA9VzPjJIommwysb1Qxt/vEGhajT5Zo+kHm3UmLULwAh8b6VdN+/+l
         X0HRCqGozVMxTNq4GKNy5ZfIB0OS/QRNsVIwZpQXfB9Wo501RThwXfb0feTmIS6sJ9zK
         9oDg==
X-Gm-Message-State: AOAM531IsOaHAZWIqNa6G7q3Wb5GP9yzVlNdtkmTMh3Ijy7aPJsAoKh4
        2TRHJ8m5aefE+D/wh8+0qx8=
X-Google-Smtp-Source: ABdhPJx7p0CX52nKFV8hx4RkzaNxFy2PVLfVl0627K87ibV6XeEm6uaurI+TxDb4r5z0jOVSubGPCg==
X-Received: by 2002:a17:902:ec83:b029:e3:ec1f:9def with SMTP id x3-20020a170902ec83b02900e3ec1f9defmr12041311plg.11.1614532853386;
        Sun, 28 Feb 2021 09:20:53 -0800 (PST)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id c15sm14487284pfj.170.2021.02.28.09.20.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Feb 2021 09:20:51 -0800 (PST)
Date:   Sun, 28 Feb 2021 09:20:49 -0800
From:   Moritz Fischer <mdf@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Xu Yilun <yilun.xu@intel.com>, mdf@kernel.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        trix@redhat.com, lgoncalv@redhat.com, hao.wu@intel.com
Subject: Re: [RESEND PATCH v11 1/2] uio: uio_dfl: add userspace i/o driver
 for DFL bus
Message-ID: <YDvQ8aO8v3NhLKzx@epycbox.lan>
References: <1614439624-3946-1-git-send-email-yilun.xu@intel.com>
 <1614439624-3946-2-git-send-email-yilun.xu@intel.com>
 <YDpof59XjiOSoDnV@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YDpof59XjiOSoDnV@kroah.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi Greg,

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
> 
> And why can't you use the existing UIO drivers that bind to memory
> regions specified by firmware?  Without an interrupt being used, why is
> UIO needed at all?

That was an earlier version -- which from your comments you didn't seem
to like :) Maybe miscommunication.

Essentially I see two options:
- Have a DFL bus driver instantiate a platform driver (uio_pdrv_genirq)
  which I *think* you described above?
- What this patch implements -- a UIO driver on the DFL bus

These FPGA devices can on the fly change their contents and -- even if
just for test -- being able to expose a bunch of registers via UIO can
be extremely useful.

Whether a device should expose registers or not should be up to the
implemeneter of the FPGA design I think (policy). This patch (or the
previous version) provides a mechanism to do so via DFL.

This is similar in nature to uio_pdrv_genirq on a DT based platform, to
expose the registers you instantiate the DT node.

Re-implementing a new driver for each of these instances doesn't seem
desirable and tying DFL as enumeration mechanism to UIO seems like a
good compromise for enabling this kind of functionality.

Note this is *not* an attempt to bypass the network stack or other
existing subsystems.

Cheers,

Moritz
