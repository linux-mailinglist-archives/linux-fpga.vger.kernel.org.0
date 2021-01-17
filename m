Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBC282F905A
	for <lists+linux-fpga@lfdr.de>; Sun, 17 Jan 2021 04:57:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbhAQD4x (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sat, 16 Jan 2021 22:56:53 -0500
Received: from mail-pg1-f171.google.com ([209.85.215.171]:35553 "EHLO
        mail-pg1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726864AbhAQD4w (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sat, 16 Jan 2021 22:56:52 -0500
Received: by mail-pg1-f171.google.com with SMTP id n7so8803280pgg.2;
        Sat, 16 Jan 2021 19:56:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zL0mAaynA6nRxLJnMHpwyAv/T/0Uk0SnXAzHYCWha18=;
        b=M12e8ObYzrvEPL566Pm/URYzYLbXvkKwRyznbn3jISbQp7c1mUI2FRzP+LJFilSEw+
         AE1wjcG84qmAn7QsMm3DGcSGoPzhHj/guQweyPOLY4Sb6ZH2tjocuf7VGl5i9W1sVTLk
         OnxEQMkVTWzyAlXyTT0V8uZ6ZG1Guvl4q6PLMJtG/xL8IGS7qHEqKOxbRU/d6FWr+sm4
         y2cGO/SEIRhzZjCVhWTs5XWZA+BGcI3B9Axn3GwD/obE70abK/0mOLDF6gpaOtWCNqUN
         VfEFmzKePZfFEfoF/STysZm6gM0NRRKEVi+Y7hJdl2XOYyKG514JBu63/K/HZkiizcQM
         yjiA==
X-Gm-Message-State: AOAM531lj291NsVdFQA4X3ivZSVp/fBN7E1RboEGRwB6Wrdw7tpdde3J
        ZitskgAeghRkQZK3anJpoqM=
X-Google-Smtp-Source: ABdhPJzuCJuBdQNtGv/RZDU819GYtDo2sHNRNS1LpGHhtjxgBojNjWF0Q8lzOJKOGWRX76ZGWuQUPg==
X-Received: by 2002:a63:597:: with SMTP id 145mr20164257pgf.252.1610855771097;
        Sat, 16 Jan 2021 19:56:11 -0800 (PST)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id k16sm12193778pgg.87.2021.01.16.19.56.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Jan 2021 19:56:10 -0800 (PST)
Date:   Sat, 16 Jan 2021 19:56:08 -0800
From:   Moritz Fischer <mdf@kernel.org>
To:     Xu Yilun <yilun.xu@intel.com>
Cc:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        trix@redhat.com, lgoncalv@redhat.com, hao.wu@intel.com
Subject: Re: [PATCH v6 1/2] fpga: dfl: add the userspace I/O device support
 for DFL devices
Message-ID: <YAO1WJGr2EBvF1rd@epycbox.lan>
References: <1610502848-30345-1-git-send-email-yilun.xu@intel.com>
 <1610502848-30345-2-git-send-email-yilun.xu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1610502848-30345-2-git-send-email-yilun.xu@intel.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi Xu,

On Wed, Jan 13, 2021 at 09:54:07AM +0800, Xu Yilun wrote:
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
> Acked-by: Wu Hao <hao.wu@intel.com>
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
> v6: fix the res[] zero initialization issue.
>     improve the return code for probe().
> ---
>  drivers/fpga/Kconfig        | 10 +++++
>  drivers/fpga/Makefile       |  1 +
>  drivers/fpga/dfl-uio-pdev.c | 93 +++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 104 insertions(+)
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
Nit: Enable this to allow DFL drivers to be written in userspace.
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
> index 0000000..12b47bf
> --- /dev/null
> +++ b/drivers/fpga/dfl-uio-pdev.c
> @@ -0,0 +1,93 @@
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
> +	struct resource res[2] = { { 0 } };
> +	struct uio_info uio_pdata = { 0 };
> +	struct platform_device *uio_pdev;
> +	struct device *dev = &ddev->dev;
> +	unsigned int num_res = 1;
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
It looks like:
	platform_device_register_resndata(&ddev->dev, "uio_pdrv_genirq",
					  PLATFORM_DEVID_AUTO, res, num_res,
					  &uio_pdata, sizeof(uio_pdata))

would work?


> +	if (IS_ERR(uio_pdev))
> +		return PTR_ERR(uio_pdev);
> +
> +	dev_set_drvdata(dev, uio_pdev);
> +
> +	return 0;
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
> +
> +	/* Add your new id entries here to support uio for more dfl features */
This is fairly common, we can maybe drop this comment?
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

Otherwise, looks good to me.

- Moritz
