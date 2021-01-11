Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EE452F1910
	for <lists+linux-fpga@lfdr.de>; Mon, 11 Jan 2021 16:01:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729803AbhAKPAp (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 11 Jan 2021 10:00:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:53535 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728141AbhAKPAp (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 11 Jan 2021 10:00:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610377157;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ITnHqcO7sIEWr+InPo1+37W7NuL6w/yxgJzxS4jgowk=;
        b=EeoLemapDU0sFx1mAbG6hBA7p8y6cr8O2nZimntGUl13cszNNoFOpq9Pvht6HMC/H3gmk6
        qCmytckxBQXOGg/EBq19Z3cf4u3ofAaafQ4eKXbOj9Eg2T1iTLnlvfbc44wrirmqJXSLtr
        dBQl0ZzhmWxrEUtnv0oQUsj6plcwlq8=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-68-jrY6gMtwM5u8t8GbJrXRlQ-1; Mon, 11 Jan 2021 09:59:15 -0500
X-MC-Unique: jrY6gMtwM5u8t8GbJrXRlQ-1
Received: by mail-io1-f71.google.com with SMTP id 191so12691286iob.15
        for <linux-fpga@vger.kernel.org>; Mon, 11 Jan 2021 06:59:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=ITnHqcO7sIEWr+InPo1+37W7NuL6w/yxgJzxS4jgowk=;
        b=UPZFuM2jlHivjvGFrETrca/fl3SUbhn1Vhnv2Fua5gKkmfBYrBtHSMBu8djmB3Zmfj
         q7nk+OniNQfjB7HmTFFjZ+lGiFzp1w+ivofTOi3cMBNlK5vHoN8yqQBP549EFspipy1B
         Iy3IoXFe/FQM6gA3Q1EXSvoJ0hCOEu2jWWAMGGzY0O9vt0SVfIMXjodT/+/RCy9IA7cz
         Cvm1+RwcN1g8oDq1rdGJIps5yPIJWIfbX+0hJqLxBx736aRjA712zYo4XKwekR5PzL5H
         KIGrSkQ9l/zPxeoV/41Q6JvJCnSmywp4XCYGe+fTO13bKIp2C2byg75+Ow06VZOLdnRQ
         Bj8Q==
X-Gm-Message-State: AOAM533KwVAL+AV7d60ezGUgJXQ5yafslxbFG6CqylrYmyYFX5ikafMe
        tj5/CoB3BOw/y24aCRgJjpS9dBbzmnQxGA9t8cN0ifqRxJiHUF0jqemOgNks0dV/6oKrAXTVYIN
        LIArCuW3ESpiOyrI4TMS8zA==
X-Received: by 2002:a92:d8c1:: with SMTP id l1mr15584663ilo.178.1610377153736;
        Mon, 11 Jan 2021 06:59:13 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwigTybs5u4uWrwl8KRTtIq8+8v+eF72Ka8ywCY1j+MUob7wkMFHvpyUjgj5sbYS0qjNBPUmQ==
X-Received: by 2002:a92:d8c1:: with SMTP id l1mr15584641ilo.178.1610377153495;
        Mon, 11 Jan 2021 06:59:13 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id r11sm15231261ilg.39.2021.01.11.06.59.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Jan 2021 06:59:12 -0800 (PST)
Subject: Re: [PATCH v5 1/2] fpga: dfl: add the userspace I/O device support
 for DFL devices
To:     Xu Yilun <yilun.xu@intel.com>, Moritz Fischer <mdf@kernel.org>
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, lgoncalv@redhat.com, hao.wu@intel.com
References: <1609557182-20787-1-git-send-email-yilun.xu@intel.com>
 <1609557182-20787-2-git-send-email-yilun.xu@intel.com>
 <X/tfZQz8tCGkabMZ@archbook> <20210111061602.GA13963@yilunxu-OptiPlex-7050>
From:   Tom Rix <trix@redhat.com>
Message-ID: <dae0308c-c991-e079-73c5-68d602005c33@redhat.com>
Date:   Mon, 11 Jan 2021 06:59:10 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20210111061602.GA13963@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 1/10/21 10:16 PM, Xu Yilun wrote:
> On Sun, Jan 10, 2021 at 12:11:17PM -0800, Moritz Fischer wrote:
>> On Sat, Jan 02, 2021 at 11:13:01AM +0800, Xu Yilun wrote:
>>> This patch supports the DFL drivers be written in userspace. This is
>>> realized by exposing the userspace I/O device interfaces.
>>>
>>> The driver leverages the uio_pdrv_genirq, it adds the uio_pdrv_genirq
>>> platform device with the DFL device's resources, and let the generic UIO
>>> platform device driver provide support to userspace access to kernel
>>> interrupts and memory locations.
>>>
>>> The driver now supports the ether group feature. To support a new DFL
>>> feature been directly accessed via UIO, its feature id should be added to
>>> the driver's id_table.
>>>
>>> Signed-off-by: Xu Yilun <yilun.xu@intel.com>
>>> Reviewed-by: Tom Rix <trix@redhat.com>
>>> ---
>>> v2: switch to the new matching algorithem. It matches DFL devices which
>>>      could not be handled by other DFL drivers.
>>>     refacor the code about device resources filling.
>>>     fix some comments.
>>> v3: split the dfl.c changes out of this patch.
>>>     some minor fixes
>>> v4: drop the idea of a generic matching algorithem, instead we specify
>>>      each matching device in id_table.
>>>     to make clear that only one irq is supported, the irq handling code
>>>      is refactored.
>>> v5: refactor the irq resource code.
>>> ---
>>>  drivers/fpga/Kconfig        | 10 +++++
>>>  drivers/fpga/Makefile       |  1 +
>>>  drivers/fpga/dfl-uio-pdev.c | 91 +++++++++++++++++++++++++++++++++++++++++++++
>>>  3 files changed, 102 insertions(+)
>>>  create mode 100644 drivers/fpga/dfl-uio-pdev.c
>>>
>>> diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
>>> index 5ff9438..61445be 100644
>>> --- a/drivers/fpga/Kconfig
>>> +++ b/drivers/fpga/Kconfig
>>> @@ -203,6 +203,16 @@ config FPGA_DFL_NIOS_INTEL_PAC_N3000
>>>  	  the card. It also instantiates the SPI master (spi-altera) for
>>>  	  the card's BMC (Board Management Controller).
>>>  
>>> +config FPGA_DFL_UIO_PDEV
>>> +	tristate "FPGA DFL Driver for Userspace I/O platform devices"
>>> +	depends on FPGA_DFL && UIO_PDRV_GENIRQ
>>> +	help
>>> +	  Enable this to allow some DFL drivers be written in userspace. It
>>> +	  adds the uio_pdrv_genirq platform device with the DFL feature's
>>> +	  resources, and lets the generic UIO platform device driver provide
>>> +	  support for userspace access to kernel interrupts and memory
>>> +	  locations.
>>> +
>>>  config FPGA_DFL_PCI
>>>  	tristate "FPGA DFL PCIe Device Driver"
>>>  	depends on PCI && FPGA_DFL
>>> diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
>>> index 18dc9885..8847fe0 100644
>>> --- a/drivers/fpga/Makefile
>>> +++ b/drivers/fpga/Makefile
>>> @@ -45,6 +45,7 @@ dfl-afu-objs := dfl-afu-main.o dfl-afu-region.o dfl-afu-dma-region.o
>>>  dfl-afu-objs += dfl-afu-error.o
>>>  
>>>  obj-$(CONFIG_FPGA_DFL_NIOS_INTEL_PAC_N3000)	+= dfl-n3000-nios.o
>>> +obj-$(CONFIG_FPGA_DFL_UIO_PDEV)		+= dfl-uio-pdev.o
>>>  
>>>  # Drivers for FPGAs which implement DFL
>>>  obj-$(CONFIG_FPGA_DFL_PCI)		+= dfl-pci.o
>>> diff --git a/drivers/fpga/dfl-uio-pdev.c b/drivers/fpga/dfl-uio-pdev.c
>>> new file mode 100644
>>> index 0000000..a4cd581
>>> --- /dev/null
>>> +++ b/drivers/fpga/dfl-uio-pdev.c
>>> @@ -0,0 +1,91 @@
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
>>> +	struct platform_device_info pdevinfo = { 0 };
>>> +	struct uio_info uio_pdata = { 0 };
>>> +	struct platform_device *uio_pdev;
>>> +	struct device *dev = &ddev->dev;
>>> +	unsigned int num_res = 1;
>>> +	struct resource res[2];
>>> +
>>> +	res[0].parent = &ddev->mmio_res;
>>> +	res[0].flags = IORESOURCE_MEM;
>>> +	res[0].start = ddev->mmio_res.start;
>>> +	res[0].end = ddev->mmio_res.end;
>>> +
>>> +	if (ddev->num_irqs) {
>>> +		if (ddev->num_irqs > 1)
>>> +			dev_warn(&ddev->dev,
>>> +				 "%d irqs for %s, but UIO only supports the first one\n",
>>> +				 ddev->num_irqs, dev_name(&ddev->dev));
>>> +
>>> +		res[1].flags = IORESOURCE_IRQ;
>>> +		res[1].start = ddev->irqs[0];
>>> +		res[1].end = ddev->irqs[0];
>>> +		num_res++;
>>> +	}
>>> +
>>> +	uio_pdata.name = DRIVER_NAME;
>>> +	uio_pdata.version = "0";
>>> +
>>> +	pdevinfo.name = "uio_pdrv_genirq";
>>> +	pdevinfo.res = res;
>>> +	pdevinfo.num_res = num_res;
>>> +	pdevinfo.parent = &ddev->dev;
>>> +	pdevinfo.id = PLATFORM_DEVID_AUTO;
>>> +	pdevinfo.data = &uio_pdata;
>>> +	pdevinfo.size_data = sizeof(uio_pdata);
>>> +
>>> +	uio_pdev = platform_device_register_full(&pdevinfo);
>>> +	if (!IS_ERR(uio_pdev))
>>> +		dev_set_drvdata(dev, uio_pdev);
>> I'm not sure if this is more readable than:
>>
>>    	uio_pdev = platform_device_register_full(&pdevinfo);
>>    	if (IS_ERR(uio_pdev))
>>    		return PTR_ERR(uio_pdev);
>>
>> 	dev_set_drvdata(dev, uio_pdev);
>> 	return 0;
>>
>> No strong preference, though ... :)
> I think your version is more readable, I'll change it.
>
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
>>> +#define FME_FEATURE_ID_ETH_GROUP	0x10
>>> +
>>> +static const struct dfl_device_id dfl_uio_pdev_ids[] = {
>>> +	{ FME_ID, FME_FEATURE_ID_ETH_GROUP },
>> Will you want to always bind FME_FEATURE_ID_ETH_GROUP? If not I'd suggest not
>> to add it here.
> Actually this is not the most preferable to me. I'm always looking for a
> generic way to bind the uio driver to user assigned dfl devices. But there
> is concern that userspace should not be responsible for the device driver
> matching in previous mail thread:
>
> https://lore.kernel.org/linux-fpga/1602828151-24784-2-git-send-email-yilun.xu@intel.com/
>
> But TBH I still didn't figure out why driver_override is not OK in this
> case.
>
>> If you want to provide an option to somewhat non-ABI fixed bind things
>> you could look at what vfio-pci does (provide a module parameter),
>> otherwise use sysfs 'new_id' or 'bind'.
> I would like to have a "new_id" for dfl bus driver. It is not generic to
> all drivers, I need to add the attr for dfl drivers like pci do.
>
> My concern is how the module param or "new_id" is different from
> "driver_override", seems userspace is also taking part in the device
> matching.
>
> But since we've restarted the discussion, I'm very much willing to have
> a try on the "new_id".

I don't believe there is any problem with the basic platform uio driver.

Can we split it out and work the new_id change in parallel ?

Tom

>
> Thanks,
> Yilun
>

