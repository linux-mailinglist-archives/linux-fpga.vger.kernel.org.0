Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD52430338E
	for <lists+linux-fpga@lfdr.de>; Tue, 26 Jan 2021 05:59:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730013AbhAZE6Y (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 25 Jan 2021 23:58:24 -0500
Received: from mail-pg1-f182.google.com ([209.85.215.182]:39838 "EHLO
        mail-pg1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731577AbhAZCXj (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 25 Jan 2021 21:23:39 -0500
Received: by mail-pg1-f182.google.com with SMTP id 30so10402142pgr.6;
        Mon, 25 Jan 2021 18:23:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YuovXwXdBjvdd+7vdXraP0/ehw96Fq5o/HGfOxg3o6k=;
        b=X4YZUrnz7t8mA7pnmghZXO2+RfQFbnIcXxDeQwUle0tnqcOsjusADhctD3NxcNf0wy
         OCF9qxsmLkExvRzzXknAgb8BEIlxYpR5R7q+OKEGBE19/ui2BYQrcs48kVH+NnySt4Ro
         8hEu9x2ntOC0MGOqB4/90IAl8U7QEMP+hL7k8j8tw5aJsXdHP0/dTTCRW2SMWj10LPH7
         s9Lqt6+cotaPM+c2tYeqdfQOXBquB30/oSKEP8zFGeQN3DHhRkfHW9y5Zg76xfAZ5/+4
         NjEh2KW/3aT/pwsyakR3u8/F+ntsNkGGBdtXuuCeeuJscgYDt1kOb95OS2nmhcWsEZnK
         qppg==
X-Gm-Message-State: AOAM530hjWpSmPvMhaw5MM5R5j+JClWLLW7qOAb75MHhygR4y8MTkaah
        4VAiRcFPqKqF9WOm2ZVP8IA=
X-Google-Smtp-Source: ABdhPJyF1odO9gCrhDF5EtAe7dVYZBUItbDrYWN0eYgidsKcfsQoMF3m9e0PCHGHe5wWGA5Sj28vLg==
X-Received: by 2002:a62:1a43:0:b029:1b9:6acc:f485 with SMTP id a64-20020a621a430000b02901b96accf485mr3273227pfa.42.1611627776952;
        Mon, 25 Jan 2021 18:22:56 -0800 (PST)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id ob6sm569744pjb.30.2021.01.25.18.22.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 18:22:56 -0800 (PST)
Date:   Mon, 25 Jan 2021 18:22:55 -0800
From:   Moritz Fischer <mdf@kernel.org>
To:     Tom Rix <trix@redhat.com>
Cc:     Xu Yilun <yilun.xu@intel.com>, gregkh@linuxfoundation.org,
        mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, lgoncalv@redhat.com, hao.wu@intel.com
Subject: Re: [PATCH v9 1/2] uio: uio_dfl: add userspace i/o driver for DFL bus
Message-ID: <YA98/8r+yOCurHAJ@epycbox.lan>
References: <1611564563-9665-1-git-send-email-yilun.xu@intel.com>
 <1611564563-9665-2-git-send-email-yilun.xu@intel.com>
 <e9bb1ff8-f630-f1a3-985c-7e51369a733f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e9bb1ff8-f630-f1a3-985c-7e51369a733f@redhat.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Mon, Jan 25, 2021 at 11:00:38AM -0800, Tom Rix wrote:
> 
> On 1/25/21 12:49 AM, Xu Yilun wrote:
> > This patch supports the DFL drivers be written in userspace. This is
> > realized by exposing the userspace I/O device interfaces.
> >
> > The driver now only binds the ether group feature, which has no irq. So
> > the irq support is not implemented yet.
> >
> > Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> > ---
> > v9: switch to add a uio driver in drivers/uio
> > ---
> >  drivers/uio/Kconfig   | 13 ++++++++++
> >  drivers/uio/Makefile  |  1 +
> >  drivers/uio/uio_dfl.c | 66 +++++++++++++++++++++++++++++++++++++++++++++++++++
> 
> You should add this to the MAINTAINERS file.

This is covered by MAINTAINERS under drivers/uio.
> 
> >  3 files changed, 80 insertions(+)
> >  create mode 100644 drivers/uio/uio_dfl.c
> >
> > diff --git a/drivers/uio/Kconfig b/drivers/uio/Kconfig
> > index 202ee81..44778f8 100644
> > --- a/drivers/uio/Kconfig
> > +++ b/drivers/uio/Kconfig
> > @@ -165,4 +165,17 @@ config UIO_HV_GENERIC
> >  	  to network and storage devices from userspace.
> >  
> >  	  If you compile this as a module, it will be called uio_hv_generic.
> > +
> > +config UIO_DFL
> > +	tristate "Generic driver for DFL bus"
> 
> The term 'DFL' will be unknown to folks in drivers/uio
> 
> I think it would be better if DFL was always prefixed 'FPGA DFL'
> 
> > +	depends on FPGA_DFL
> > +	help
> > +	  Generic DFL (Device Feature List) driver for Userspace I/O devices.
> > +	  It is useful to provide direct access to DFL devices from userspace.
> > +	  A sample userspace application using this driver is available for
> > +	  download in a git repository:
> > +
> > +	    git clone https://github.com/OPAE/opae-sdk.git
> > +
> > +	  If you compile this as a module, it will be called uio_dfl.

I'm not sure KConfig is the right place for this.
> 
> opae-sdk is pretty large and uncovered in the Documentation/fpga/dfl.rst.
> 
> Where in opae-sdk is this example ?
> 
> If you can point me at the example, I will turn it into a selftest.
> 
> Tom
> 
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
> > +
> > +static const struct dfl_device_id uio_dfl_ids[] = {
> > +	{ FME_ID, FME_FEATURE_ID_ETH_GROUP },
> > +	{ }
> > +};
> > +MODULE_DEVICE_TABLE(dfl, uio_dfl_ids);
> > +
> > +static struct dfl_driver uio_dfl_driver = {
> > +	.drv = {
> > +		.name = DRIVER_NAME,
> > +	},
> > +	.id_table	= uio_dfl_ids,
> > +	.probe		= uio_dfl_probe,
> > +};
> > +module_dfl_driver(uio_dfl_driver);
> > +
> > +MODULE_DESCRIPTION("Generic DFL driver for Userspace I/O devices");
> > +MODULE_AUTHOR("Intel Corporation");
> > +MODULE_LICENSE("GPL v2");
> 
