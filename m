Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A6372909C2
	for <lists+linux-fpga@lfdr.de>; Fri, 16 Oct 2020 18:36:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410799AbgJPQgH (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 16 Oct 2020 12:36:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:53973 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2410753AbgJPQgH (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Fri, 16 Oct 2020 12:36:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602866166;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rHirm0QjVOLIduO3/OBhyNE0q0zYdGhVKCP/DslpnEQ=;
        b=M1IQRwyJRHlJTqTE/R0N6cUKYPaPoKV5VPwog/VKqFOGQD90h7osscylBDZfPbw1eJpkCy
        J/KJVlXbIbNoBDjoLlb08cbNdIfz1PoMNLkD+WeTAq5KOGXEDtSpfvJEIelTmeRQ9LKLvy
        /mAWSYHAG+G3ACSbmONXVtMqSC9JYFM=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-554-s0yo09nSMNqN9NtwVJYhHg-1; Fri, 16 Oct 2020 12:36:03 -0400
X-MC-Unique: s0yo09nSMNqN9NtwVJYhHg-1
Received: by mail-ot1-f71.google.com with SMTP id x12so985457otq.11
        for <linux-fpga@vger.kernel.org>; Fri, 16 Oct 2020 09:36:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=rHirm0QjVOLIduO3/OBhyNE0q0zYdGhVKCP/DslpnEQ=;
        b=ruwu3ZECc59DYYpex8oMWwu+hLwj3mSKhnn1K5RHc+bD8SkR2lpyApABeAj0mmjS3S
         Yp5o3AT03a1xbtEP8PfYAIq+mY82QzjpYmy0G8o0Qxh/bRdR5Djdnd5of7f8YnEDtG+r
         Ii4BZFV2k3PtH64H8+sUavXfrQf6cMnl5hGGfcqRU3EqoMFAB4Pi4bReZfCsKs4cxtmu
         tpYWGIveBpa+4i6W9ZmyuLAmFItho4v8pM93v+4aN/HpbakF6gz10UQ6UhHs1NMwyJQQ
         JGOsZ61H5YNCVK7wRq6hTbjZMzwaRQSIbv4YSIJ7MIc8X+elDDYbLlVf1CwbH749zegh
         DLGA==
X-Gm-Message-State: AOAM5319RzRMceAvB8zlbFuwRTWWuFHS/CEjfiWpswrUo29mhj5GbmQb
        LA/Qe9myAnRBYGMPHnyhaL5XBUMh2f56A8rPb26GC+ni0FeTcSuemiZLT+KlFZo+zsBSXThDs1F
        r40sI1k/HOr2JX1JQ0kWWVA==
X-Received: by 2002:a05:6830:2436:: with SMTP id k22mr3339023ots.185.1602866162884;
        Fri, 16 Oct 2020 09:36:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxbfNADlp4FQryac4k3gYT4DINIBC63zGgPiwDCxauhYn2KAaUYsBlzwg/0ZMELMGeOYa/N9A==
X-Received: by 2002:a05:6830:2436:: with SMTP id k22mr3339011ots.185.1602866162634;
        Fri, 16 Oct 2020 09:36:02 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id p17sm1252186oov.1.2020.10.16.09.36.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Oct 2020 09:36:01 -0700 (PDT)
Subject: Re: [PATCH 2/2] fpga: dfl: add the userspace I/O device support for
 DFL devices
To:     Xu Yilun <yilun.xu@intel.com>, mdf@kernel.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, lgoncalv@redhat.com, hao.wu@intel.com
References: <1602828151-24784-1-git-send-email-yilun.xu@intel.com>
 <1602828151-24784-3-git-send-email-yilun.xu@intel.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <cba18e8f-009b-0732-c91e-88bd58445271@redhat.com>
Date:   Fri, 16 Oct 2020 09:36:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <1602828151-24784-3-git-send-email-yilun.xu@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 10/15/20 11:02 PM, Xu Yilun wrote:
> This patch supports the DFL drivers be written in userspace. This is
> realized by exposing the userspace I/O device interfaces. The driver
> leverages the uio_pdrv_genirq, it adds the uio_pdrv_genirq platform
> device with the DFL device's resources, and let the generic UIO platform
> device driver provide support to userspace access to kernel interrupts
> and memory locations.
>
> Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> ---
>  drivers/fpga/Kconfig        | 10 ++++++
>  drivers/fpga/Makefile       |  1 +
>  drivers/fpga/dfl-uio-pdev.c | 83 +++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 94 insertions(+)
>  create mode 100644 drivers/fpga/dfl-uio-pdev.c
>
> diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
> index 5d7f0ae..e054722 100644
> --- a/drivers/fpga/Kconfig
> +++ b/drivers/fpga/Kconfig
> @@ -202,6 +202,16 @@ config FPGA_DFL_NIOS_INTEL_PAC_N3000
>  	  the card. It also instantiates the SPI master (spi-altera) for
>  	  the card's BMC (Board Management Controller).
>  
> +config FPGA_DFL_UIO_PDEV
> +	tristate "FPGA DFL Driver for Userspace I/O platform devices"
> +	depends on FPGA_DFL && UIO_PDRV_GENIRQ
> +	help
> +	  Enable this to allow some DFL drivers be written in userspace. It
> +	  adds the uio_pdrv_genirq platform device with the DFL device's
> +	  resources, and let the generic UIO platform device driver provide
'and lets the'
> +	  support to userspace access to kernel interrupts and memory
> +	  locations.
> +
>  config FPGA_DFL_PCI
>  	tristate "FPGA DFL PCIe Device Driver"
>  	depends on PCI && FPGA_DFL
> diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
> index 18dc9885..e07b3d5 100644
> --- a/drivers/fpga/Makefile
> +++ b/drivers/fpga/Makefile
> @@ -45,6 +45,7 @@ dfl-afu-objs := dfl-afu-main.o dfl-afu-region.o dfl-afu-dma-region.o
>  dfl-afu-objs += dfl-afu-error.o
>  
>  obj-$(CONFIG_FPGA_DFL_NIOS_INTEL_PAC_N3000)	+= dfl-n3000-nios.o
> +obj-$(CONFIG_FPGA_DFL_UIO_PDEV)	+= dfl-uio-pdev.o
>  
>  # Drivers for FPGAs which implement DFL
>  obj-$(CONFIG_FPGA_DFL_PCI)		+= dfl-pci.o
> diff --git a/drivers/fpga/dfl-uio-pdev.c b/drivers/fpga/dfl-uio-pdev.c
> new file mode 100644
> index 0000000..d35b846
> --- /dev/null
> +++ b/drivers/fpga/dfl-uio-pdev.c
> @@ -0,0 +1,83 @@
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
> +	struct resource *res;
> +	int i, idx = 0;

idx is not needed.

> +
> +	pdevinfo.name = "uio_pdrv_genirq";
> +
> +	res = kcalloc(ddev->num_irqs + 1, sizeof(*res), GFP_KERNEL);
> +	if (!res)
> +		return -ENOMEM;
> +
> +	res[idx].parent = &ddev->mmio_res;
res[0].parent =
> +	res[idx].flags = IORESOURCE_MEM;
> +	res[idx].start = ddev->mmio_res.start;
> +	res[idx].end = ddev->mmio_res.end;
> +	++idx;
> +
> +	/* then add irq resource */
> +	for (i = 0; i < ddev->num_irqs; i++) {
> +		res[idx].flags = IORESOURCE_IRQ;

res[i+1].flags =

Tom

> +		res[idx].start = ddev->irqs[i];
> +		res[idx].end = ddev->irqs[i];
> +		++idx;
> +	}
> +
> +	uio_pdata.name = DRIVER_NAME;
> +	uio_pdata.version = "0";
> +
> +	pdevinfo.res = res;
> +	pdevinfo.num_res = idx;
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
> +static struct dfl_driver dfl_uio_pdev_driver = {
> +	.drv	= {
> +		.name       = DRIVER_NAME,
> +	},
> +	.probe	= dfl_uio_pdev_probe,
> +	.remove	= dfl_uio_pdev_remove,
> +};
> +module_dfl_driver(dfl_uio_pdev_driver);
> +
> +MODULE_DESCRIPTION("DFL driver for Userspace I/O platform devices");
> +MODULE_AUTHOR("Intel Corporation");
> +MODULE_LICENSE("GPL v2");

