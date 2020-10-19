Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 517062928B5
	for <lists+linux-fpga@lfdr.de>; Mon, 19 Oct 2020 16:01:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728721AbgJSOB4 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 19 Oct 2020 10:01:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28755 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728872AbgJSOBz (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 19 Oct 2020 10:01:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603116114;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=d4S8DYlhaI02Jop7YRwsKvp+dH07NKVibP/IiS65oTc=;
        b=hYUQqALtSp/RUxnNV4G7mGthYHKkKGkISVTn/DTKmsy5U85uHfKGeIlTKZdHyboAsZoKP/
        BnSQVJa2O7ucIoZuSLIua9gsoJeynUF7rUvK5m4lPdBqVxvdLJdumXMCnUaZiNAJLC2lcB
        zE/C4sT7CMNaXcdkMT22Kp2l3Otatmo=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-399-vTyEYx-MO82i9K8SHED4iQ-1; Mon, 19 Oct 2020 10:01:42 -0400
X-MC-Unique: vTyEYx-MO82i9K8SHED4iQ-1
Received: by mail-qk1-f197.google.com with SMTP id x85so6658820qka.14
        for <linux-fpga@vger.kernel.org>; Mon, 19 Oct 2020 07:01:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=d4S8DYlhaI02Jop7YRwsKvp+dH07NKVibP/IiS65oTc=;
        b=Q2Sh9aeDbvtxwVbIrnLh0CsBvVsWMpU4tldy0FZVQlN5FdCibQKKluMbGIWm6bMvZb
         PquketRvXbpTn1l30ft1tMgVg0k9lfbufSYHmSWywKAWlC4Bc5VWzVs9WOSYq/cJDtx4
         CuBrVl+rM459QSBzbZOLif2LfZm7mpmdJWGJs4LX4L9XYOzyeXD+8lUqfPGa6bp77LVB
         cjQez0GKz58W48FTQoBjTbYW+t4p5O6/uFKArdJj1PzgQBkwg9VM07Cm1sHMjOpWbZnQ
         CszwwmjwaO4cW9XFghsXp/d13/HQIZ1qqPElV7olhCfNB1poKAQNkraLPeWSxccKrFug
         NB6w==
X-Gm-Message-State: AOAM530p1J7grr+ztni5sEeOsmJ29Div1B0cI0W3vzmeTiVplhiO7aRW
        g7+fF2bG9TfZdb6qc0HiyhMTlvdLEq5lC/9/RTyH17TvXMwsDyEinfyD8Z4sX7smaHuwXdxbNpx
        d35S6xV+YSb7jARohSspV+w==
X-Received: by 2002:aed:3325:: with SMTP id u34mr15495924qtd.263.1603116101653;
        Mon, 19 Oct 2020 07:01:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwO1ods2R8ZSpPT94+LfqpoQVajYqFyzh5W6csuXGE3vu39iIh4EJLr8JpboVP2QPiMDYRmNA==
X-Received: by 2002:aed:3325:: with SMTP id u34mr15495846qtd.263.1603116100748;
        Mon, 19 Oct 2020 07:01:40 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id p13sm51188qkj.58.2020.10.19.07.01.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Oct 2020 07:01:40 -0700 (PDT)
Subject: Re: [PATCH 2/2] fpga: dfl: add the userspace I/O device support for
 DFL devices
To:     Xu Yilun <yilun.xu@intel.com>
Cc:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        lgoncalv@redhat.com, hao.wu@intel.com
References: <1602828151-24784-1-git-send-email-yilun.xu@intel.com>
 <1602828151-24784-3-git-send-email-yilun.xu@intel.com>
 <cba18e8f-009b-0732-c91e-88bd58445271@redhat.com>
 <20201019041609.GB16172@yilunxu-OptiPlex-7050>
From:   Tom Rix <trix@redhat.com>
Message-ID: <78c66206-f264-9a95-e782-2195fc86306f@redhat.com>
Date:   Mon, 19 Oct 2020 07:01:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20201019041609.GB16172@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 10/18/20 9:16 PM, Xu Yilun wrote:
> On Fri, Oct 16, 2020 at 09:36:00AM -0700, Tom Rix wrote:
>> On 10/15/20 11:02 PM, Xu Yilun wrote:
>>> This patch supports the DFL drivers be written in userspace. This is
>>> realized by exposing the userspace I/O device interfaces. The driver
>>> leverages the uio_pdrv_genirq, it adds the uio_pdrv_genirq platform
>>> device with the DFL device's resources, and let the generic UIO platform
>>> device driver provide support to userspace access to kernel interrupts
>>> and memory locations.
>>>
>>> Signed-off-by: Xu Yilun <yilun.xu@intel.com>
>>> ---
>>>  drivers/fpga/Kconfig        | 10 ++++++
>>>  drivers/fpga/Makefile       |  1 +
>>>  drivers/fpga/dfl-uio-pdev.c | 83 +++++++++++++++++++++++++++++++++++++++++++++
>>>  3 files changed, 94 insertions(+)
>>>  create mode 100644 drivers/fpga/dfl-uio-pdev.c
>>>
>>> diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
>>> index 5d7f0ae..e054722 100644
>>> --- a/drivers/fpga/Kconfig
>>> +++ b/drivers/fpga/Kconfig
>>> @@ -202,6 +202,16 @@ config FPGA_DFL_NIOS_INTEL_PAC_N3000
>>>  	  the card. It also instantiates the SPI master (spi-altera) for
>>>  	  the card's BMC (Board Management Controller).
>>>  
>>> +config FPGA_DFL_UIO_PDEV
>>> +	tristate "FPGA DFL Driver for Userspace I/O platform devices"
>>> +	depends on FPGA_DFL && UIO_PDRV_GENIRQ
>>> +	help
>>> +	  Enable this to allow some DFL drivers be written in userspace. It
>>> +	  adds the uio_pdrv_genirq platform device with the DFL device's
>>> +	  resources, and let the generic UIO platform device driver provide
>> 'and lets the'
> Yes.
>
>>> +	  support to userspace access to kernel interrupts and memory
>>> +	  locations.
>>> +
>>>  config FPGA_DFL_PCI
>>>  	tristate "FPGA DFL PCIe Device Driver"
>>>  	depends on PCI && FPGA_DFL
>>> diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
>>> index 18dc9885..e07b3d5 100644
>>> --- a/drivers/fpga/Makefile
>>> +++ b/drivers/fpga/Makefile
>>> @@ -45,6 +45,7 @@ dfl-afu-objs := dfl-afu-main.o dfl-afu-region.o dfl-afu-dma-region.o
>>>  dfl-afu-objs += dfl-afu-error.o
>>>  
>>>  obj-$(CONFIG_FPGA_DFL_NIOS_INTEL_PAC_N3000)	+= dfl-n3000-nios.o
>>> +obj-$(CONFIG_FPGA_DFL_UIO_PDEV)	+= dfl-uio-pdev.o
>>>  
>>>  # Drivers for FPGAs which implement DFL
>>>  obj-$(CONFIG_FPGA_DFL_PCI)		+= dfl-pci.o
>>> diff --git a/drivers/fpga/dfl-uio-pdev.c b/drivers/fpga/dfl-uio-pdev.c
>>> new file mode 100644
>>> index 0000000..d35b846
>>> --- /dev/null
>>> +++ b/drivers/fpga/dfl-uio-pdev.c
>>> @@ -0,0 +1,83 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +/*
>>> + * DFL driver for Userspace I/O platform devices
>>> + *
>>> + * Copyright (C) 2020 Intel Corporation, Inc.
>>> + */
>>> +#include <linux/dfl.h>
>>> +#include <linux/errno.h>
>>> +#include <linux/kernel.h>
>>> +#include <linux/module.h>
>>> +#include <linux/platform_device.h>
>>> +#include <linux/slab.h>
>>> +#include <linux/uio_driver.h>
>>> +
>>> +#define DRIVER_NAME "dfl-uio-pdev"
>>> +
>>> +static int dfl_uio_pdev_probe(struct dfl_device *ddev)
>>> +{
>>> +	struct device *dev = &ddev->dev;
>>> +	struct platform_device_info pdevinfo = { 0 };
>>> +	struct uio_info uio_pdata = { 0 };
>>> +	struct platform_device *uio_pdev;
>>> +	struct resource *res;
>>> +	int i, idx = 0;
>> idx is not needed.
> I could remove the idx. But I think I could ++res during the resource
> filling.

ok.

You may want to check the code generation, my feeling is ++res will be worse.

Tom

>
> Thanks,
> Yilun
>
>>> +
>>> +	pdevinfo.name = "uio_pdrv_genirq";
>>> +
>>> +	res = kcalloc(ddev->num_irqs + 1, sizeof(*res), GFP_KERNEL);
>>> +	if (!res)
>>> +		return -ENOMEM;
>>> +
>>> +	res[idx].parent = &ddev->mmio_res;
>> res[0].parent =
>>> +	res[idx].flags = IORESOURCE_MEM;
>>> +	res[idx].start = ddev->mmio_res.start;
>>> +	res[idx].end = ddev->mmio_res.end;
>>> +	++idx;
>>> +
>>> +	/* then add irq resource */
>>> +	for (i = 0; i < ddev->num_irqs; i++) {
>>> +		res[idx].flags = IORESOURCE_IRQ;
>> res[i+1].flags =
>>
>> Tom
>>
>>> +		res[idx].start = ddev->irqs[i];
>>> +		res[idx].end = ddev->irqs[i];
>>> +		++idx;
>>> +	}
>>> +
>>> +	uio_pdata.name = DRIVER_NAME;
>>> +	uio_pdata.version = "0";
>>> +
>>> +	pdevinfo.res = res;
>>> +	pdevinfo.num_res = idx;
>>> +	pdevinfo.parent = &ddev->dev;
>>> +	pdevinfo.id = PLATFORM_DEVID_AUTO;
>>> +	pdevinfo.data = &uio_pdata;
>>> +	pdevinfo.size_data = sizeof(uio_pdata);
>>> +
>>> +	uio_pdev = platform_device_register_full(&pdevinfo);
>>> +	if (!IS_ERR(uio_pdev))
>>> +		dev_set_drvdata(dev, uio_pdev);
>>> +
>>> +	kfree(res);
>>> +
>>> +	return PTR_ERR_OR_ZERO(uio_pdev);
>>> +}
>>> +
>>> +static void dfl_uio_pdev_remove(struct dfl_device *ddev)
>>> +{
>>> +	struct platform_device *uio_pdev = dev_get_drvdata(&ddev->dev);
>>> +
>>> +	platform_device_unregister(uio_pdev);
>>> +}
>>> +
>>> +static struct dfl_driver dfl_uio_pdev_driver = {
>>> +	.drv	= {
>>> +		.name       = DRIVER_NAME,
>>> +	},
>>> +	.probe	= dfl_uio_pdev_probe,
>>> +	.remove	= dfl_uio_pdev_remove,
>>> +};
>>> +module_dfl_driver(dfl_uio_pdev_driver);
>>> +
>>> +MODULE_DESCRIPTION("DFL driver for Userspace I/O platform devices");
>>> +MODULE_AUTHOR("Intel Corporation");
>>> +MODULE_LICENSE("GPL v2");

