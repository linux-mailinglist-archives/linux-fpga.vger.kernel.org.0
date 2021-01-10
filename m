Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C9112F09A4
	for <lists+linux-fpga@lfdr.de>; Sun, 10 Jan 2021 21:12:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbhAJUMA (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 10 Jan 2021 15:12:00 -0500
Received: from mail-pj1-f42.google.com ([209.85.216.42]:53164 "EHLO
        mail-pj1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbhAJUMA (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sun, 10 Jan 2021 15:12:00 -0500
Received: by mail-pj1-f42.google.com with SMTP id v1so6518221pjr.2;
        Sun, 10 Jan 2021 12:11:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=upT8ABS7E/7Meo+JMC1WW6JLAkg0Xuj/VkP9gQJmfD4=;
        b=CQ/nMUT3y0+k06n70uL0B3zuh4bHqycwVw8RJGFYhRA7FDftmXz1WbpRP5JrbK0k9l
         BJE7DVaSIwbgQ11w9WA9cfyHCTlPwppLhNvrzhjGCwBQAUYSoYWr5QQ85rqVVh2gIbpQ
         RVFdyhfO0wDvRN09Fv9ZECjvs8xxdhouuKrPnqDVFfqVYz36ESD8EDAW+jh5CIIjFxZT
         sKp0kcJOymDAF8ln8mpcYA6Zgl3HhQqMHkaAl8TWSzdNAbZuLVnj+GOV5a/tpv2zX6Ax
         InKbUW81E1gTa54k0tTSANFxJ4L+VnWSDOaQ7m+XBKqM/z5ErEGf3cSh72D2jXYpYDJ1
         kxQQ==
X-Gm-Message-State: AOAM531fYVF1OnURd9O27mxK7u5SwbOyM8tdaSXhyZHHwfFcfFteb1fW
        KhUsc9vbaclGjqEa7/HvEgQ=
X-Google-Smtp-Source: ABdhPJyE9PeCA9k+ESqvJsPvtOBkHsTPJgpB9y1k4uHBIis6xSqcRBzigNilPNXXQr7zaX/lC7TBBw==
X-Received: by 2002:a17:90a:68c3:: with SMTP id q3mr14109799pjj.135.1610309479226;
        Sun, 10 Jan 2021 12:11:19 -0800 (PST)
Received: from localhost ([2601:647:5b00:1162:1ac0:17a6:4cc6:d1ef])
        by smtp.gmail.com with ESMTPSA id p9sm16895232pfq.109.2021.01.10.12.11.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jan 2021 12:11:18 -0800 (PST)
Date:   Sun, 10 Jan 2021 12:11:17 -0800
From:   Moritz Fischer <mdf@kernel.org>
To:     Xu Yilun <yilun.xu@intel.com>
Cc:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        trix@redhat.com, lgoncalv@redhat.com, hao.wu@intel.com
Subject: Re: [PATCH v5 1/2] fpga: dfl: add the userspace I/O device support
 for DFL devices
Message-ID: <X/tfZQz8tCGkabMZ@archbook>
References: <1609557182-20787-1-git-send-email-yilun.xu@intel.com>
 <1609557182-20787-2-git-send-email-yilun.xu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1609557182-20787-2-git-send-email-yilun.xu@intel.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Sat, Jan 02, 2021 at 11:13:01AM +0800, Xu Yilun wrote:
> This patch supports the DFL drivers be written in userspace. This is
> realized by exposing the userspace I/O device interfaces.
> 
> The driver leverages the uio_pdrv_genirq, it adds the uio_pdrv_genirq
> platform device with the DFL device's resources, and let the generic UIO
> platform device driver provide support to userspace access to kernel
> interrupts and memory locations.
> 
> The driver now supports the ether group feature. To support a new DFL
> feature been directly accessed via UIO, its feature id should be added to
> the driver's id_table.
> 
> Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> Reviewed-by: Tom Rix <trix@redhat.com>
> ---
> v2: switch to the new matching algorithem. It matches DFL devices which
>      could not be handled by other DFL drivers.
>     refacor the code about device resources filling.
>     fix some comments.
> v3: split the dfl.c changes out of this patch.
>     some minor fixes
> v4: drop the idea of a generic matching algorithem, instead we specify
>      each matching device in id_table.
>     to make clear that only one irq is supported, the irq handling code
>      is refactored.
> v5: refactor the irq resource code.
> ---
>  drivers/fpga/Kconfig        | 10 +++++
>  drivers/fpga/Makefile       |  1 +
>  drivers/fpga/dfl-uio-pdev.c | 91 +++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 102 insertions(+)
>  create mode 100644 drivers/fpga/dfl-uio-pdev.c
> 
> diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
> index 5ff9438..61445be 100644
> --- a/drivers/fpga/Kconfig
> +++ b/drivers/fpga/Kconfig
> @@ -203,6 +203,16 @@ config FPGA_DFL_NIOS_INTEL_PAC_N3000
>  	  the card. It also instantiates the SPI master (spi-altera) for
>  	  the card's BMC (Board Management Controller).
>  
> +config FPGA_DFL_UIO_PDEV
> +	tristate "FPGA DFL Driver for Userspace I/O platform devices"
> +	depends on FPGA_DFL && UIO_PDRV_GENIRQ
> +	help
> +	  Enable this to allow some DFL drivers be written in userspace. It
> +	  adds the uio_pdrv_genirq platform device with the DFL feature's
> +	  resources, and lets the generic UIO platform device driver provide
> +	  support for userspace access to kernel interrupts and memory
> +	  locations.
> +
>  config FPGA_DFL_PCI
>  	tristate "FPGA DFL PCIe Device Driver"
>  	depends on PCI && FPGA_DFL
> diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
> index 18dc9885..8847fe0 100644
> --- a/drivers/fpga/Makefile
> +++ b/drivers/fpga/Makefile
> @@ -45,6 +45,7 @@ dfl-afu-objs := dfl-afu-main.o dfl-afu-region.o dfl-afu-dma-region.o
>  dfl-afu-objs += dfl-afu-error.o
>  
>  obj-$(CONFIG_FPGA_DFL_NIOS_INTEL_PAC_N3000)	+= dfl-n3000-nios.o
> +obj-$(CONFIG_FPGA_DFL_UIO_PDEV)		+= dfl-uio-pdev.o
>  
>  # Drivers for FPGAs which implement DFL
>  obj-$(CONFIG_FPGA_DFL_PCI)		+= dfl-pci.o
> diff --git a/drivers/fpga/dfl-uio-pdev.c b/drivers/fpga/dfl-uio-pdev.c
> new file mode 100644
> index 0000000..a4cd581
> --- /dev/null
> +++ b/drivers/fpga/dfl-uio-pdev.c
> @@ -0,0 +1,91 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * DFL driver for Userspace I/O platform devices
> + *
> + * Copyright (C) 2020 Intel Corporation, Inc.
> + */
> +#include <linux/dfl.h>
> +#include <linux/errno.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +#include <linux/uio_driver.h>
> +
> +#define DRIVER_NAME "dfl-uio-pdev"
> +
> +static int dfl_uio_pdev_probe(struct dfl_device *ddev)
> +{
> +	struct platform_device_info pdevinfo = { 0 };
> +	struct uio_info uio_pdata = { 0 };
> +	struct platform_device *uio_pdev;
> +	struct device *dev = &ddev->dev;
> +	unsigned int num_res = 1;
> +	struct resource res[2];
> +
> +	res[0].parent = &ddev->mmio_res;
> +	res[0].flags = IORESOURCE_MEM;
> +	res[0].start = ddev->mmio_res.start;
> +	res[0].end = ddev->mmio_res.end;
> +
> +	if (ddev->num_irqs) {
> +		if (ddev->num_irqs > 1)
> +			dev_warn(&ddev->dev,
> +				 "%d irqs for %s, but UIO only supports the first one\n",
> +				 ddev->num_irqs, dev_name(&ddev->dev));
> +
> +		res[1].flags = IORESOURCE_IRQ;
> +		res[1].start = ddev->irqs[0];
> +		res[1].end = ddev->irqs[0];
> +		num_res++;
> +	}
> +
> +	uio_pdata.name = DRIVER_NAME;
> +	uio_pdata.version = "0";
> +
> +	pdevinfo.name = "uio_pdrv_genirq";
> +	pdevinfo.res = res;
> +	pdevinfo.num_res = num_res;
> +	pdevinfo.parent = &ddev->dev;
> +	pdevinfo.id = PLATFORM_DEVID_AUTO;
> +	pdevinfo.data = &uio_pdata;
> +	pdevinfo.size_data = sizeof(uio_pdata);
> +
> +	uio_pdev = platform_device_register_full(&pdevinfo);
> +	if (!IS_ERR(uio_pdev))
> +		dev_set_drvdata(dev, uio_pdev);

I'm not sure if this is more readable than:

   	uio_pdev = platform_device_register_full(&pdevinfo);
   	if (IS_ERR(uio_pdev))
   		return PTR_ERR(uio_pdev);

	dev_set_drvdata(dev, uio_pdev);
	return 0;

No strong preference, though ... :)
> +
> +	return PTR_ERR_OR_ZERO(uio_pdev);
> +}
> +
> +static void dfl_uio_pdev_remove(struct dfl_device *ddev)
> +{
> +	struct platform_device *uio_pdev = dev_get_drvdata(&ddev->dev);
> +
> +	platform_device_unregister(uio_pdev);
> +}
> +
> +#define FME_FEATURE_ID_ETH_GROUP	0x10
> +
> +static const struct dfl_device_id dfl_uio_pdev_ids[] = {
> +	{ FME_ID, FME_FEATURE_ID_ETH_GROUP },

Will you want to always bind FME_FEATURE_ID_ETH_GROUP? If not I'd suggest not
to add it here.

If you want to provide an option to somewhat non-ABI fixed bind things
you could look at what vfio-pci does (provide a module parameter),
otherwise use sysfs 'new_id' or 'bind'.

Does that sound reasonable?
> +
> +	/* Add your new id entries here to support uio for more dfl features */
> +
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(dfl, dfl_uio_pdev_ids);
> +
> +static struct dfl_driver dfl_uio_pdev_driver = {
> +	.drv	= {
> +		.name       = DRIVER_NAME,
> +	},
> +	.id_table = dfl_uio_pdev_ids,
> +	.probe	= dfl_uio_pdev_probe,
> +	.remove	= dfl_uio_pdev_remove,
> +};
> +module_dfl_driver(dfl_uio_pdev_driver);
> +
> +MODULE_DESCRIPTION("DFL driver for Userspace I/O platform devices");
> +MODULE_AUTHOR("Intel Corporation");
> +MODULE_LICENSE("GPL v2");
> -- 
> 2.7.4
> 
Thanks,

Moritz
