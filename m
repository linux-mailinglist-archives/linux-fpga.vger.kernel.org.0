Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 717E22E7170
	for <lists+linux-fpga@lfdr.de>; Tue, 29 Dec 2020 15:39:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbgL2OjK (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 29 Dec 2020 09:39:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:26116 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726126AbgL2OjK (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 29 Dec 2020 09:39:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609252663;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hC7lXKKIec1KBqGI+vzMItLuhIyQqpSsbQE96ALnpHY=;
        b=Wey7y9XUsHQhOJNrlydpuioH1b/OEer0qumxVspuAtPhidWiiS/CDOXlbsqeyzj2qYxuUH
        QQWJxJXqIkfmh4m240kBF4MHTlykWoekO+O4sx8bJadw7wNqwGIi3FBzLhelq6ffCh6NBH
        EP/8UiPf347IdJN3xEOTOFCbsxkwfas=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-230-kwAA7RecPcitYjrSN546Ug-1; Tue, 29 Dec 2020 09:37:41 -0500
X-MC-Unique: kwAA7RecPcitYjrSN546Ug-1
Received: by mail-oo1-f69.google.com with SMTP id t7so8006376oog.7
        for <linux-fpga@vger.kernel.org>; Tue, 29 Dec 2020 06:37:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=hC7lXKKIec1KBqGI+vzMItLuhIyQqpSsbQE96ALnpHY=;
        b=YetQkkrKHNWxwZmP7dhWDOy6n9mWIi/CpiOhQcS8NhfBnwheFcqhNcfaQ+PBuKwcE0
         CHpLLveBRqCqTPN2jFJ2W2AYlmRLa7Ehn7q+6Umz42J8GLNCjlsir0Fr9pJgb3h9PGyR
         JTthBEj1GMxxO4ztbV686XK+aAmHdQiGowdhh0xHITrJOUuVFCRQ0AsminyaI6GOrLLe
         TorK3+WM7K9Tr0KKLt9UY3RcO/OnHIXDk0uvAY+9TVrlsuDHRpgBVXKYJCOCNJEr4VJ1
         O3UFigY4JimT+0Cn25kO8iyCMsf6vIUzoqTcOrRQw0151j7ntAfQsA1fig4gHEJSlL+b
         qh7A==
X-Gm-Message-State: AOAM531js26/j4RE8R7gHsokYWPYPzVhTZ/UusJxVWukKAPWun2Zre9e
        0zX4nBLy2GUpr3uDQQMOxbfp/XjvweoHtucOQRQvVIVvIdyPVsliTiq8zsBKb9+qXYTnpfQLL2l
        4JXvXMM8R6Rp0amzIn3PkOg==
X-Received: by 2002:a05:6830:16d9:: with SMTP id l25mr36695913otr.314.1609252660066;
        Tue, 29 Dec 2020 06:37:40 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzxA/JG3xOFWv/fao8cFMkm84kafP5sj0x3xxCuXUgzsj4SrXBKhpHtQ8QknY/CXncRbLFJ/Q==
X-Received: by 2002:a05:6830:16d9:: with SMTP id l25mr36695904otr.314.1609252659823;
        Tue, 29 Dec 2020 06:37:39 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id a26sm8109044oos.46.2020.12.29.06.37.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Dec 2020 06:37:39 -0800 (PST)
Subject: Re: [PATCH v4 1/2] fpga: dfl: add the userspace I/O device support
 for DFL devices
To:     Xu Yilun <yilun.xu@intel.com>, mdf@kernel.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, lgoncalv@redhat.com, hao.wu@intel.com
References: <1609209776-7296-1-git-send-email-yilun.xu@intel.com>
 <1609209776-7296-2-git-send-email-yilun.xu@intel.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <761ed67a-f4cd-2f6c-82db-d88873c7c718@redhat.com>
Date:   Tue, 29 Dec 2020 06:37:37 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <1609209776-7296-2-git-send-email-yilun.xu@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 12/28/20 6:42 PM, Xu Yilun wrote:
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
> ---
>  drivers/fpga/Kconfig        |  10 +++++
>  drivers/fpga/Makefile       |   1 +
>  drivers/fpga/dfl-uio-pdev.c | 101 ++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 112 insertions(+)
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
> index 0000000..1100434
> --- /dev/null
> +++ b/drivers/fpga/dfl-uio-pdev.c
> @@ -0,0 +1,101 @@
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
> +	struct device *dev = &ddev->dev;
> +	struct platform_device_info pdevinfo = { 0 };
> +	struct uio_info uio_pdata = { 0 };
> +	struct platform_device *uio_pdev;
> +	unsigned int num_res = 1;
> +	struct resource *res;
> +
> +	if (ddev->num_irqs > 1)
This num_irq check could be combined with the one below.
> +		dev_warn(&ddev->dev,
> +			 "%d irqs for %s, but UIO only supports the first one\n",
> +			 ddev->num_irqs, dev_name(&ddev->dev));
> +
> +	pdevinfo.name = "uio_pdrv_genirq";
> +
> +	if (ddev->num_irqs)
> +		num_res++;
> +
> +	res = kcalloc(num_res, sizeof(*res), GFP_KERNEL);

Since num_res is at most 2, could res be converted to a stack array ?

Reviewed-by: Tom Rix <trix@redhat.com>

> +	if (!res)
> +		return -ENOMEM;
> +
> +	res[0].parent = &ddev->mmio_res;
> +	res[0].flags = IORESOURCE_MEM;
> +	res[0].start = ddev->mmio_res.start;
> +	res[0].end = ddev->mmio_res.end;
> +
> +	/* then add irq resource */
> +	if (num_res > 1) {
> +		res[1].flags = IORESOURCE_IRQ;
> +		res[1].start = ddev->irqs[0];
> +		res[1].end = ddev->irqs[0];
> +	}
> +
> +	uio_pdata.name = DRIVER_NAME;
> +	uio_pdata.version = "0";
> +
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
> +
> +	kfree(res);
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

