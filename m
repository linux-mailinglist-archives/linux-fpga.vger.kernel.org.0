Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6351E2DA2F7
	for <lists+linux-fpga@lfdr.de>; Mon, 14 Dec 2020 23:06:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408214AbgLNWEs (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 14 Dec 2020 17:04:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:37882 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2407896AbgLNWEk (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 14 Dec 2020 17:04:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607983392;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1JqJoAs3xhsm9Oi0ktKEeyolg71JD/n5jB3jqJ3XelQ=;
        b=APEVMGbAy635EbTuMIy5OTiByjs+w5b1dl2kLIMRFrK0WSWKkO9hXfb6Zda3uC1yhcETaQ
        6fMaPb2x4Ru2RqkGg/NQkZwXvpuygXprBWhPS6D1QANiEZpRXLiwtjRodgARcFcExBsToY
        UKl1vItpKVJI3lw8nMaycMF8ywm26Ug=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-410-X6A0BV3WOzevRfnIheYfNQ-1; Mon, 14 Dec 2020 17:03:07 -0500
X-MC-Unique: X6A0BV3WOzevRfnIheYfNQ-1
Received: by mail-qk1-f198.google.com with SMTP id 188so4943055qkh.7
        for <linux-fpga@vger.kernel.org>; Mon, 14 Dec 2020 14:03:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=1JqJoAs3xhsm9Oi0ktKEeyolg71JD/n5jB3jqJ3XelQ=;
        b=arOumbMzq9KWZudmY6Mr22rgU5IRgJ3owxvK9m9oadK0vr8sYHJbDuPzz7DrQ+538R
         +cnXLUn796VXSEK6rYia6uDkQv5FuPSEPTkfgDkUop4tj8xZuOXlZ9xEyh+x5ybNDx4s
         PZRUj07Pw0HRymrURpK5Bslr4gm8ZDNJy7T6oO8KsXs9wr1tYwZguLHKAW1ODdRljVUl
         dOyU5/juCdNYMj6uxAxzeQ5hgnAq8GUx2myvidFRBB//WykI/h0RZPC7W8PR7SquY4Tl
         cES65f2dP/BhO5Bmh6WvEqp+nYIlORaiQGU9RzWw6IimRAdOY1PQkihrcu6tXlJj4gRw
         VTsg==
X-Gm-Message-State: AOAM530Y5ufVSN4c+zU+BqfgXhHVHhdu4Eu3NCwItN2IqicnP67SoeZA
        9Hd2iI+5Ex/UdoSDHZ1DcFpCz2bsOvfi+UhpXOD470XfTikizrWN1Q782V39UkYQkFuwkRAJAUs
        RRX7CFIAV+A2Z97DOYcIw/A==
X-Received: by 2002:a37:7046:: with SMTP id l67mr3669651qkc.419.1607983386269;
        Mon, 14 Dec 2020 14:03:06 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzfpATaR8IAX01/y4GTsWN9hw7P8WF+nLB/jMopqJqEWmkkOQ9LIAQnvxbIox4CKqrqNAHTSg==
X-Received: by 2002:a37:7046:: with SMTP id l67mr3669606qkc.419.1607983385851;
        Mon, 14 Dec 2020 14:03:05 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id c14sm15725134qtg.85.2020.12.14.14.03.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Dec 2020 14:03:05 -0800 (PST)
Subject: Re: [PATCH v2 1/2] fpga: dfl: add the userspace I/O device support
 for DFL devices
To:     Xu Yilun <yilun.xu@intel.com>, mdf@kernel.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, lgoncalv@redhat.com, hao.wu@intel.com
References: <1607916981-14782-1-git-send-email-yilun.xu@intel.com>
 <1607916981-14782-2-git-send-email-yilun.xu@intel.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <4f8608a5-d362-3a5c-9925-717bd20a9148@redhat.com>
Date:   Mon, 14 Dec 2020 14:03:03 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <1607916981-14782-2-git-send-email-yilun.xu@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



On 12/13/20 7:36 PM, Xu Yilun wrote:
> This patch supports the DFL drivers be written in userspace. This is
> realized by exposing the userspace I/O device interfaces.
>
> The driver leverages the uio_pdrv_genirq, it adds the uio_pdrv_genirq
> platform device with the DFL device's resources, and let the generic UIO
> platform device driver provide support to userspace access to kernel
> interrupts and memory locations.
>
> The driver matches DFL devices in a different way. It has no device id
> table, instead it matches any DFL device which could not be handled by
> other DFL drivers. For this purpose, a match() ops is added to the dfl
> driver, to allow dfl drivers have their own matching algorithem instead
> of the standard id_table matching.

Because (*match) is added, this change is doing two things.

In the next version, please split the new interface out, i believe these are

the dfl.c/h changes.

>
> Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> ---
> v2: switch to the new matching algorithem. It matches DFL devices which
>      could not be handled by other DFL drivers.
>     refacor the code about device resources filling.
>     fix some comments.
> ---
>  drivers/fpga/Kconfig        |  10 ++++
>  drivers/fpga/Makefile       |   1 +
>  drivers/fpga/dfl-uio-pdev.c | 108 ++++++++++++++++++++++++++++++++++++++++++++
>  drivers/fpga/dfl.c          |  22 +++++++--
>  include/linux/dfl.h         |   7 +++
>  5 files changed, 143 insertions(+), 5 deletions(-)
>  create mode 100644 drivers/fpga/dfl-uio-pdev.c
>
> diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
> index 5d7f0ae..eb8a616 100644
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
DFL feature's
> +	  resources, and lets the generic UIO platform device driver provide
> +	  support to userspace access to kernel interrupts and memory
support for userspace
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
This does not really align with += dfl-pci.o, add another tab.
>  
>  # Drivers for FPGAs which implement DFL
>  obj-$(CONFIG_FPGA_DFL_PCI)		+= dfl-pci.o
> diff --git a/drivers/fpga/dfl-uio-pdev.c b/drivers/fpga/dfl-uio-pdev.c
> new file mode 100644
> index 0000000..68ede04
> --- /dev/null
> +++ b/drivers/fpga/dfl-uio-pdev.c
> @@ -0,0 +1,108 @@
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
> +static struct dfl_driver dfl_uio_pdev_driver;
> +
> +static int check_for_other_drv_match(struct device_driver *drv, void *data)
> +{
> +	struct dfl_driver *ddrv = to_dfl_drv(drv);
> +	struct dfl_device *ddev = data;
> +
> +	/* skip myself */
> +	if (ddrv == &dfl_uio_pdev_driver)
> +		return 0;
> +
> +	return dfl_match_device(ddev, ddrv);
> +}
> +
> +static int dfl_uio_pdev_match(struct dfl_device *ddev)
> +{
> +	/*
> +	 * If any other driver wants the device, leave the device to this other
> +	 * driver.
> +	 */
> +	if (bus_for_each_drv(&dfl_bus_type, NULL, ddev, check_for_other_drv_match))
> +		return 0;
> +
> +	return 1;
> +}
> +
> +static int dfl_uio_pdev_probe(struct dfl_device *ddev)
> +{
> +	struct device *dev = &ddev->dev;
> +	struct platform_device_info pdevinfo = { 0 };
> +	struct uio_info uio_pdata = { 0 };
> +	struct platform_device *uio_pdev;
> +	struct resource *res;
> +	int i;
> +
> +	pdevinfo.name = "uio_pdrv_genirq";
> +
> +	res = kcalloc(ddev->num_irqs + 1, sizeof(*res), GFP_KERNEL);
> +	if (!res)
> +		return -ENOMEM;
> +
> +	res[0].parent = &ddev->mmio_res;
> +	res[0].flags = IORESOURCE_MEM;
> +	res[0].start = ddev->mmio_res.start;
> +	res[0].end = ddev->mmio_res.end;
> +
> +	/* then add irq resource */
> +	for (i = 0; i < ddev->num_irqs; i++) {
> +		res[i + 1].flags = IORESOURCE_IRQ;
> +		res[i + 1].start = ddev->irqs[i];
> +		res[i + 1].end = ddev->irqs[i];
> +	}
> +
> +	uio_pdata.name = DRIVER_NAME;
> +	uio_pdata.version = "0";
> +
> +	pdevinfo.res = res;
> +	pdevinfo.num_res = ddev->num_irqs + 1;
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
> +	.match	= dfl_uio_pdev_match,
> +	.probe	= dfl_uio_pdev_probe,
> +	.remove	= dfl_uio_pdev_remove,
> +};
Could move this to the top and remove the forward decl.
> +module_dfl_driver(dfl_uio_pdev_driver);
> +
> +MODULE_DESCRIPTION("DFL driver for Userspace I/O platform devices");
> +MODULE_AUTHOR("Intel Corporation");
> +MODULE_LICENSE("GPL v2");
> diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
> index 511b20f..dd90111 100644
> --- a/drivers/fpga/dfl.c
> +++ b/drivers/fpga/dfl.c
> @@ -256,12 +256,13 @@ dfl_match_one_device(const struct dfl_device_id *id, struct dfl_device *ddev)
>  	return NULL;
>  }
>  
> -static int dfl_bus_match(struct device *dev, struct device_driver *drv)
> +int dfl_match_device(struct dfl_device *ddev, struct dfl_driver *ddrv)
>  {
> -	struct dfl_device *ddev = to_dfl_dev(dev);
> -	struct dfl_driver *ddrv = to_dfl_drv(drv);
>  	const struct dfl_device_id *id_entry;
>  
> +	if (ddrv->match)
> +		return ddrv->match(ddev);
> +
>  	id_entry = ddrv->id_table;
>  	if (id_entry) {
>  		while (id_entry->feature_id) {
> @@ -275,6 +276,15 @@ static int dfl_bus_match(struct device *dev, struct device_driver *drv)
>  
>  	return 0;
>  }
> +EXPORT_SYMBOL_GPL(dfl_match_device);
> +
> +static int dfl_bus_match(struct device *dev, struct device_driver *drv)
> +{
> +	struct dfl_device *ddev = to_dfl_dev(dev);
> +	struct dfl_driver *ddrv = to_dfl_drv(drv);
> +
> +	return dfl_match_device(ddev, ddrv);
> +}
>  
>  static int dfl_bus_probe(struct device *dev)
>  {
> @@ -328,7 +338,7 @@ static struct attribute *dfl_dev_attrs[] = {
>  };
>  ATTRIBUTE_GROUPS(dfl_dev);
>  
> -static struct bus_type dfl_bus_type = {
> +struct bus_type dfl_bus_type = {
>  	.name		= "dfl",
>  	.match		= dfl_bus_match,
>  	.probe		= dfl_bus_probe,
> @@ -336,6 +346,7 @@ static struct bus_type dfl_bus_type = {
>  	.uevent		= dfl_bus_uevent,
>  	.dev_groups	= dfl_dev_groups,
>  };
> +EXPORT_SYMBOL_GPL(dfl_bus_type);
>  
>  static void release_dfl_dev(struct device *dev)
>  {
> @@ -469,7 +480,8 @@ static int dfl_devs_add(struct dfl_feature_platform_data *pdata)
>  
>  int __dfl_driver_register(struct dfl_driver *dfl_drv, struct module *owner)
>  {
> -	if (!dfl_drv || !dfl_drv->probe || !dfl_drv->id_table)
> +	if (!dfl_drv || !dfl_drv->probe ||
> +	    (!dfl_drv->id_table && !dfl_drv->match))
>  		return -EINVAL;
>  
>  	dfl_drv->drv.owner = owner;
> diff --git a/include/linux/dfl.h b/include/linux/dfl.h
> index 6cc1098..7bd97ec 100644
> --- a/include/linux/dfl.h
> +++ b/include/linux/dfl.h
> @@ -11,6 +11,8 @@
>  #include <linux/device.h>
>  #include <linux/mod_devicetable.h>
>  
> +extern struct bus_type dfl_bus_type;

Why is this needed ?

This is a public interface, likely should happen somewhere in drivers/fpga

> +
>  /**
>   * enum dfl_id_type - define the DFL FIU types
>   */
> @@ -51,6 +53,8 @@ struct dfl_device {
>   * @drv: driver model structure.
>   * @id_table: pointer to table of device IDs the driver is interested in.
>   *	      { } member terminated.
> + * @match: returns a positive value if given device can be handled by the
returns one
> + *	   driver and zero otherwise. If NULL, matching is based on id_table.
>   * @probe: mandatory callback for device binding.
>   * @remove: callback for device unbinding.
>   */
> @@ -58,6 +62,7 @@ struct dfl_driver {
>  	struct device_driver drv;
>  	const struct dfl_device_id *id_table;
>  
> +	int (*match)(struct dfl_device *dfl_dev);
>  	int (*probe)(struct dfl_device *dfl_dev);
>  	void (*remove)(struct dfl_device *dfl_dev);
>  };
> @@ -65,6 +70,8 @@ struct dfl_driver {
>  #define to_dfl_dev(d) container_of(d, struct dfl_device, dev)
>  #define to_dfl_drv(d) container_of(d, struct dfl_driver, drv)
>  
> +int dfl_match_device(struct dfl_device *ddev, struct dfl_driver *ddrv);

Is it really necessary put this as a public interface ?

Tom

> +
>  /*
>   * use a macro to avoid include chaining to get THIS_MODULE.
>   */

