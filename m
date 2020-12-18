Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A3762DE39B
	for <lists+linux-fpga@lfdr.de>; Fri, 18 Dec 2020 15:00:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725535AbgLROAv (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 18 Dec 2020 09:00:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:40256 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725924AbgLROAv (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Fri, 18 Dec 2020 09:00:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608299963;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=moKU7AhMJ8xbFjKlJUpgeR4TMscG46KCaGlErsXQQjg=;
        b=CSBDfiQUqGZo3YxU65os23eSKuHU8Grv0Bue8I1LePiOmxEYtb4J09JYTVE6MpR//IJKNY
        fFTgYyv8/F3p6UcQxs6r0agcXDvp5Hv6AEZFxYBrjDB3fj6QnxRP/x7czZ3M+oR/vqd8LA
        sg1om/be5P+sCZrB+M9Ah4OgI5Zn/ak=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-436-rvCzm3dbO6OzEqG3DoYBMQ-1; Fri, 18 Dec 2020 08:59:21 -0500
X-MC-Unique: rvCzm3dbO6OzEqG3DoYBMQ-1
Received: by mail-qv1-f71.google.com with SMTP id t12so2141244qvj.19
        for <linux-fpga@vger.kernel.org>; Fri, 18 Dec 2020 05:59:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=moKU7AhMJ8xbFjKlJUpgeR4TMscG46KCaGlErsXQQjg=;
        b=uZxHBOiZzkz4OGYLoX9070m4qD/mDlOEPjpOEVLyIndTIZaVTpJfi0o7UURgpbY/xD
         cLqkHMsBRkFjVzHc/hXucfF/kyvnKQLCnq0Cztg9XXQEEm2L+Nso9JPY+puQaILQz91c
         V48FKuNexajEddLRiQAFKTBYZwjfT4iCpcfjfDzmCKKP2Cpp/98RgiG3Vy3rZM0Rcph2
         sHPwdB7IWvt6Mza0I3iGKtEmAP1242cRmhXl4i0CCOChpDrXX41I1+Cn9hbrH7ZeBw1m
         DTaO5FsLL3zHgyWRzygrx7cBy6FgBCRWN+dY1mdR0dSWaoRVP8BD8VIj6tNAfwcYI7tN
         5TPw==
X-Gm-Message-State: AOAM530B7o81L8NBjteTG2zZeOOxJemMMPb6j87B/peoB2A6QL70mFzL
        6thdWnS7NE8OhucmWXea5ZgX5F+0ptSE4sPQ4nIkbYYNS7smlm4YHkro1rtTUICgMcy4NeM0s3A
        ArM0hnZ5qKz3etQpZooUHFw==
X-Received: by 2002:ac8:4e84:: with SMTP id 4mr4020347qtp.296.1608299960678;
        Fri, 18 Dec 2020 05:59:20 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwbOxvqn7rGPkhVH7D2SZzFP4tNP7WPo0/o7l1oYhW6ARDszj2S8HYKh/eno/ZmVg5QIVUbUA==
X-Received: by 2002:ac8:4e84:: with SMTP id 4mr4020314qtp.296.1608299960232;
        Fri, 18 Dec 2020 05:59:20 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id v137sm5863135qka.110.2020.12.18.05.59.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Dec 2020 05:59:19 -0800 (PST)
Subject: Re: [PATCH v3 2/3] fpga: dfl: add the userspace I/O device support
 for DFL devices
To:     "Wu, Hao" <hao.wu@intel.com>, "Xu, Yilun" <yilun.xu@intel.com>,
        "mdf@kernel.org" <mdf@kernel.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "lgoncalv@redhat.com" <lgoncalv@redhat.com>
References: <1608183881-18692-1-git-send-email-yilun.xu@intel.com>
 <1608183881-18692-3-git-send-email-yilun.xu@intel.com>
 <DM6PR11MB381997F5E297408A68BF5F2185C30@DM6PR11MB3819.namprd11.prod.outlook.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <0d3f1f40-9f89-0ec2-96c4-b8b087f31382@redhat.com>
Date:   Fri, 18 Dec 2020 05:59:17 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <DM6PR11MB381997F5E297408A68BF5F2185C30@DM6PR11MB3819.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 12/18/20 12:05 AM, Wu, Hao wrote:
>> Subject: [PATCH v3 2/3] fpga: dfl: add the userspace I/O device support for
>> DFL devices
>>
>> This patch supports the DFL drivers be written in userspace. This is
>> realized by exposing the userspace I/O device interfaces.
>>
>> The driver leverages the uio_pdrv_genirq, it adds the uio_pdrv_genirq
>> platform device with the DFL device's resources, and let the generic UIO
>> platform device driver provide support to userspace access to kernel
>> interrupts and memory locations.
>>
>> The driver matches DFL devices in a different way. It has no device id
>> table, instead it matches any DFL device which could not be handled by
>> other DFL drivers.
> Looks like we want to build UIO driver as the default/generic driver for DFL,
> it seems fine but my concern is that UIO has its own limitation, if some day,
> dfl device is extended, but UIO has limitation, then we may need to select 
> another one as the default driver.. or we can just match them using 
> id_table as we know UIO meets the requirement for those DFL devices?

When we have multiple defaults, could this be handled in the configury ?

Tom

>
>> Signed-off-by: Xu Yilun <yilun.xu@intel.com>
>> ---
>> v2: switch to the new matching algorithem. It matches DFL devices which
>>      could not be handled by other DFL drivers.
>>     refacor the code about device resources filling.
>>     fix some comments.
>> v3: split the dfl.c changes out of this patch.
>>     some minor fixes
>> ---
>>  drivers/fpga/Kconfig        |  10 ++++
>>  drivers/fpga/Makefile       |   1 +
>>  drivers/fpga/dfl-uio-pdev.c | 110
>> ++++++++++++++++++++++++++++++++++++++++++++
>>  3 files changed, 121 insertions(+)
>>  create mode 100644 drivers/fpga/dfl-uio-pdev.c
>>
>> diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
>> index 5d7f0ae..7a88af9 100644
>> --- a/drivers/fpga/Kconfig
>> +++ b/drivers/fpga/Kconfig
>> @@ -202,6 +202,16 @@ config FPGA_DFL_NIOS_INTEL_PAC_N3000
>>  	  the card. It also instantiates the SPI master (spi-altera) for
>>  	  the card's BMC (Board Management Controller).
>>
>> +config FPGA_DFL_UIO_PDEV
>> +	tristate "FPGA DFL Driver for Userspace I/O platform devices"
>> +	depends on FPGA_DFL && UIO_PDRV_GENIRQ
>> +	help
>> +	  Enable this to allow some DFL drivers be written in userspace. It
>> +	  adds the uio_pdrv_genirq platform device with the DFL feature's
>> +	  resources, and lets the generic UIO platform device driver provide
>> +	  support for userspace access to kernel interrupts and memory
>> +	  locations.
> If we consider this as a default driver for everybody in DFL, then we could
> consider build it into the core, otherwise it always requires to be loaded
> manually, right?
>
>> +
>>  config FPGA_DFL_PCI
>>  	tristate "FPGA DFL PCIe Device Driver"
>>  	depends on PCI && FPGA_DFL
>> diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
>> index 18dc9885..8847fe0 100644
>> --- a/drivers/fpga/Makefile
>> +++ b/drivers/fpga/Makefile
>> @@ -45,6 +45,7 @@ dfl-afu-objs := dfl-afu-main.o dfl-afu-region.o dfl-afu-
>> dma-region.o
>>  dfl-afu-objs += dfl-afu-error.o
>>
>>  obj-$(CONFIG_FPGA_DFL_NIOS_INTEL_PAC_N3000)	+= dfl-n3000-nios.o
>> +obj-$(CONFIG_FPGA_DFL_UIO_PDEV)		+= dfl-uio-pdev.o
>>
>>  # Drivers for FPGAs which implement DFL
>>  obj-$(CONFIG_FPGA_DFL_PCI)		+= dfl-pci.o
>> diff --git a/drivers/fpga/dfl-uio-pdev.c b/drivers/fpga/dfl-uio-pdev.c
>> new file mode 100644
>> index 0000000..8c57233
>> --- /dev/null
>> +++ b/drivers/fpga/dfl-uio-pdev.c
>> @@ -0,0 +1,110 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * DFL driver for Userspace I/O platform devices
>> + *
>> + * Copyright (C) 2020 Intel Corporation, Inc.
>> + */
>> +#include <linux/dfl.h>
>> +#include <linux/errno.h>
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/slab.h>
>> +#include <linux/uio_driver.h>
>> +
>> +#include "dfl.h"
>> +
>> +#define DRIVER_NAME "dfl-uio-pdev"
>> +
>> +static struct dfl_driver dfl_uio_pdev_driver;
>> +
>> +static int check_for_other_drv_match(struct device_driver *drv, void *data)
>> +{
>> +	struct dfl_driver *ddrv = to_dfl_drv(drv);
>> +	struct dfl_device *ddev = data;
>> +
>> +	/* skip myself */
>> +	if (ddrv == &dfl_uio_pdev_driver)
>> +		return 0;
>> +
>> +	return dfl_match_device(ddev, ddrv);
>> +}
>> +
>> +static int dfl_uio_pdev_match(struct dfl_device *ddev)
>> +{
>> +	/*
>> +	 * If any other driver wants the device, leave the device to this other
>> +	 * driver.
>> +	 */
>> +	if (bus_for_each_drv(&dfl_bus_type, NULL, ddev,
>> check_for_other_drv_match))
>> +		return 0;
>> +
>> +	return 1;
>> +}
>> +
>> +static int dfl_uio_pdev_probe(struct dfl_device *ddev)
>> +{
>> +	struct device *dev = &ddev->dev;
>> +	struct platform_device_info pdevinfo = { 0 };
>> +	struct uio_info uio_pdata = { 0 };
>> +	struct platform_device *uio_pdev;
>> +	struct resource *res;
>> +	int i;
>> +
>> +	pdevinfo.name = "uio_pdrv_genirq";
>> +
>> +	res = kcalloc(ddev->num_irqs + 1, sizeof(*res), GFP_KERNEL);
>> +	if (!res)
>> +		return -ENOMEM;
>> +
>> +	res[0].parent = &ddev->mmio_res;
>> +	res[0].flags = IORESOURCE_MEM;
>> +	res[0].start = ddev->mmio_res.start;
>> +	res[0].end = ddev->mmio_res.end;
>> +
>> +	/* then add irq resource */
>> +	for (i = 0; i < ddev->num_irqs; i++) {
>> +		res[i + 1].flags = IORESOURCE_IRQ;
>> +		res[i + 1].start = ddev->irqs[i];
>> +		res[i + 1].end = ddev->irqs[i];
>> +	}
> How many interrupts UIO could support? or we need some
> warning or just even return error here?
>
> Thanks
> Hao
>
>> +
>> +	uio_pdata.name = DRIVER_NAME;
>> +	uio_pdata.version = "0";
>> +
>> +	pdevinfo.res = res;
>> +	pdevinfo.num_res = ddev->num_irqs + 1;
>> +	pdevinfo.parent = &ddev->dev;
>> +	pdevinfo.id = PLATFORM_DEVID_AUTO;
>> +	pdevinfo.data = &uio_pdata;
>> +	pdevinfo.size_data = sizeof(uio_pdata);
>> +
>> +	uio_pdev = platform_device_register_full(&pdevinfo);
>> +	if (!IS_ERR(uio_pdev))
>> +		dev_set_drvdata(dev, uio_pdev);
>> +
>> +	kfree(res);
>> +
>> +	return PTR_ERR_OR_ZERO(uio_pdev);
>> +}
>> +
>> +static void dfl_uio_pdev_remove(struct dfl_device *ddev)
>> +{
>> +	struct platform_device *uio_pdev = dev_get_drvdata(&ddev->dev);
>> +
>> +	platform_device_unregister(uio_pdev);
>> +}
>> +
>> +static struct dfl_driver dfl_uio_pdev_driver = {
>> +	.drv	= {
>> +		.name       = DRIVER_NAME,
>> +	},
>> +	.match	= dfl_uio_pdev_match,
>> +	.probe	= dfl_uio_pdev_probe,
>> +	.remove	= dfl_uio_pdev_remove,
>> +};
>> +module_dfl_driver(dfl_uio_pdev_driver);
>> +
>> +MODULE_DESCRIPTION("DFL driver for Userspace I/O platform devices");
>> +MODULE_AUTHOR("Intel Corporation");
>> +MODULE_LICENSE("GPL v2");
>> --
>> 2.7.4

