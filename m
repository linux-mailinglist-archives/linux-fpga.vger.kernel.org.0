Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E838F2D10C8
	for <lists+linux-fpga@lfdr.de>; Mon,  7 Dec 2020 13:46:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725973AbgLGMoe (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 7 Dec 2020 07:44:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45231 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725928AbgLGMob (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 7 Dec 2020 07:44:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607344984;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SsqSttvUVrrzYn9yM0i2htneRQJKStYFmEvYG4Nm5eM=;
        b=L9d60BbdY/XVnlnRcZGrRrnFgRcq5S5Kd5nUN1oCJ3LuIT+C81zR6h+GaEd+HpEL6yijkk
        j3dWCJV0Y6TCXT7U/Xrb1yg9mS0FIbgonsW+c6XfmVuLV0Sb/590DnTPJxmTdXTQK1PkCG
        1KJTDwmfKr9t6gGXQV5vQmwU+WvzDmQ=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-37-Pv47oB_ZMeebLY6ONX8r8A-1; Mon, 07 Dec 2020 07:43:02 -0500
X-MC-Unique: Pv47oB_ZMeebLY6ONX8r8A-1
Received: by mail-qt1-f199.google.com with SMTP id r29so10991656qtu.21
        for <linux-fpga@vger.kernel.org>; Mon, 07 Dec 2020 04:43:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=SsqSttvUVrrzYn9yM0i2htneRQJKStYFmEvYG4Nm5eM=;
        b=kBCdThWaKtprjPEMJub5vUVAzH21oC/Sez6N5OubM6kSzwGVd5432aYNrnytZc8Fd9
         FSOimP0b0KIK6y51mYPvrwnVzOyF/3DarbS7dgCHtzOMyHw91c6XZJdrsjyIzEManIvK
         9c4wBwfmotL9s2o6ou7aRX8C8XW7KHIwiPlTK68A/UVE02DxKZLjsXIkSnuYU8G/6T9f
         KMYy1IRpWsAxIl65nKA7PovsxRMobljbFGYEWkJVzsb6FjVAnR/VkBxkabs/1i2iACW1
         iZA1NzjwD6c5NDdIG8aTVUPyo9rycPYzi0fAfJx5cPloQq1M27wv5ldWwGB6LZns+AAZ
         siRQ==
X-Gm-Message-State: AOAM53236noHVe7N7wEzhWgXK87vsFGkrqwZrFfL3ObCI9WnrzKAdKL8
        GpiTrL1OTvgP5sLINLWzYSzjPLpBWC9700mSsc8O+7UreDwgXdjb1ccPc/hw0QnDTo4jB/61ENw
        Pc57foavKhN+m+fXCr9X/zY0slArCJgPAtqVCcpbuvdHS6nF0E417A5QxOZ4fvqSOpFuC
X-Received: by 2002:a37:9d16:: with SMTP id g22mr24538205qke.62.1607344981286;
        Mon, 07 Dec 2020 04:43:01 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxbjUdsrpRsBiM4uYNZXh83JPYzp9pi4VSucZZIUY+eTlRJs5XvRk6wbKIa7uOlfJ9dT7M24Q==
X-Received: by 2002:a37:9d16:: with SMTP id g22mr24538170qke.62.1607344980880;
        Mon, 07 Dec 2020 04:43:00 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id b73sm12350502qkc.87.2020.12.07.04.42.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Dec 2020 04:43:00 -0800 (PST)
Subject: Re: [RFC] fpga: dfl: a prototype uio driver
To:     "Wu, Hao" <hao.wu@intel.com>, "Xu, Yilun" <yilun.xu@intel.com>
Cc:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "mdf@kernel.org" <mdf@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>
References: <20201206215554.350230-1-trix@redhat.com>
 <20201207034950.GA29754@yilunxu-OptiPlex-7050>
 <DM6PR11MB38195119D03A4877E0AB3F5085CE0@DM6PR11MB3819.namprd11.prod.outlook.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <56369ecc-5dfb-c896-d114-2ff59724ff97@redhat.com>
Date:   Mon, 7 Dec 2020 04:42:58 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <DM6PR11MB38195119D03A4877E0AB3F5085CE0@DM6PR11MB3819.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 12/6/20 10:24 PM, Wu, Hao wrote:
>> Subject: Re: [RFC] fpga: dfl: a prototype uio driver
>>
>> On Sun, Dec 06, 2020 at 01:55:54PM -0800, trix@redhat.com wrote:
>>> From: Tom Rix <trix@redhat.com>
>>>
>>> >From [PATCH 0/2] UIO support for dfl devices
>>> https://lore.kernel.org/linux-fpga/1602828151-24784-1-git-send-email-
>> yilun.xu@intel.com/
>>> Here is an idea to have uio support with no driver override.
>>>
>>> This makes UIO the primary driver interface because every feature
>>> will have one and makes the existing platform driver interface
>>> secondary.  There will be a new burden for locking write access when
>>> they compete.
>>>
>>> Example shows finding the fpga's temperture.
>> Hi Tom:
>>
>> Thanks for the idea and detailed illustrate with the patch. I see it
>> abandons the driver_override and expose all the DFL devices to userspace
>> by UIO. I'd like to see if we could get some more comments on it.
> This allows concurrent access from both userspace and kernel space driver
> to the same feature device? conflicts?

Yes conflicts, that is why a lock is needed and the unpleasant part of this idea.

Another way is split them and have uio for the unclaimed feature id's

Tom

>
> Hao
>
>> Thanks,
>> Yilun
>>
>>> Signed-off-by: Tom Rix <trix@redhat.com>
>>> ---
>>>  drivers/fpga/dfl-fme-main.c |  9 +++-
>>>  drivers/fpga/dfl-uio.c      | 96 +++++++++++++++++++++++++++++++++++++
>>>  drivers/fpga/dfl.c          | 44 ++++++++++++++++-
>>>  drivers/fpga/dfl.h          |  9 ++++
>>>  uio.c                       | 56 ++++++++++++++++++++++
>>>  5 files changed, 212 insertions(+), 2 deletions(-)
>>>  create mode 100644 drivers/fpga/dfl-uio.c
>>>  create mode 100644 uio.c
>>>
>>> diff --git a/drivers/fpga/dfl-fme-main.c b/drivers/fpga/dfl-fme-main.c
>>> index 037dc4f946f0..3323e90a18c4 100644
>>> --- a/drivers/fpga/dfl-fme-main.c
>>> +++ b/drivers/fpga/dfl-fme-main.c
>>> @@ -709,12 +709,18 @@ static int fme_probe(struct platform_device
>> *pdev)
>>>  	if (ret)
>>>  		goto dev_destroy;
>>>
>>> -	ret = dfl_fpga_dev_ops_register(pdev, &fme_fops, THIS_MODULE);
>>> +	ret = dfl_fpga_dev_feature_init_uio(pdev, DFH_TYPE_FIU);
>>>  	if (ret)
>>>  		goto feature_uinit;
>>>
>>> +	ret = dfl_fpga_dev_ops_register(pdev, &fme_fops, THIS_MODULE);
>>> +	if (ret)
>>> +		goto feature_uinit_uio;
>>> +
>>>  	return 0;
>>>
>>> +feature_uinit_uio:
>>> +	dfl_fpga_dev_feature_uinit_uio(pdev, DFH_TYPE_FIU);
>>>  feature_uinit:
>>>  	dfl_fpga_dev_feature_uinit(pdev);
>>>  dev_destroy:
>>> @@ -726,6 +732,7 @@ exit:
>>>  static int fme_remove(struct platform_device *pdev)
>>>  {
>>>  	dfl_fpga_dev_ops_unregister(pdev);
>>> +	dfl_fpga_dev_feature_uinit_uio(pdev, DFH_TYPE_FIU);
>>>  	dfl_fpga_dev_feature_uinit(pdev);
>>>  	fme_dev_destroy(pdev);
>>>
>>> diff --git a/drivers/fpga/dfl-uio.c b/drivers/fpga/dfl-uio.c
>>> new file mode 100644
>>> index 000000000000..7610ee0b19dc
>>> --- /dev/null
>>> +++ b/drivers/fpga/dfl-uio.c
>>> @@ -0,0 +1,96 @@
>>> +/* SPDX-License-Identifier: GPL-2.0 */
>>> +/*
>>> + * prototype dfl uio driver
>>> + *
>>> + * Copyright Tom Rix 2020
>>> + */
>>> +#include <linux/module.h>
>>> +#include "dfl.h"
>>> +
>>> +static irqreturn_t dfl_uio_handler(int irq, struct uio_info *info)
>>> +{
>>> +	return IRQ_HANDLED;
>>> +}
>>> +
>>> +static int dfl_uio_mmap(struct uio_info *info, struct vm_area_struct *vma)
>>> +{
>>> +	int ret = -ENODEV;
>>> +	return ret;
>>> +}
>>> +
>>> +static int dfl_uio_open(struct uio_info *info, struct inode *inode)
>>> +{
>>> +	int ret = -ENODEV;
>>> +	struct dfl_feature *feature = container_of(info, struct dfl_feature,
>> uio);
>>> +	if (feature->dev)
>>> +		mutex_lock(&feature->lock);
>>> +
>>> +	ret = 0;
>>> +	return ret;
>>> +}
>>> +
>>> +static int dfl_uio_release(struct uio_info *info, struct inode *inode)
>>> +{
>>> +	int ret = -ENODEV;
>>> +	struct dfl_feature *feature = container_of(info, struct dfl_feature,
>> uio);
>>> +	if (feature->dev)
>>> +		mutex_unlock(&feature->lock);
>>> +
>>> +	ret = 0;
>>> +	return ret;
>>> +}
>>> +
>>> +static int dfl_uio_irqcontrol(struct uio_info *info, s32 irq_on)
>>> +{
>>> +	int ret = -ENODEV;
>>> +	return ret;
>>> +}
>>> +
>>> +int dfl_uio_add(struct dfl_feature *feature)
>>> +{
>>> +	struct uio_info *uio = &feature->uio;
>>> +	struct resource *res =
>>> +		&feature->dev->resource[feature->resource_index];
>>> +	int ret = 0;
>>> +
>>> +	uio->name = kasprintf(GFP_KERNEL, "dfl-uio-%llx", feature->id);
>>> +	if (!uio->name) {
>>> +		ret = -ENOMEM;
>>> +		goto exit;
>>> +	}
>>> +
>>> +	uio->version = "0.1";
>>> +	uio->mem[0].memtype = UIO_MEM_PHYS;
>>> +	uio->mem[0].addr = res->start & PAGE_MASK;
>>> +	uio->mem[0].offs = res->start & ~PAGE_MASK;
>>> +	uio->mem[0].size = (uio->mem[0].offs + resource_size(res)
>>> +			    + PAGE_SIZE - 1) & PAGE_MASK;
>>> +	/* How are nr_irqs > 1 handled ??? */
>>> +	if (feature->nr_irqs == 1)
>>> +		uio->irq = feature->irq_ctx[0].irq;
>>> +	uio->handler = dfl_uio_handler;
>>> +	//uio->mmap = dfl_uio_mmap;
>>> +	uio->open = dfl_uio_open;
>>> +	uio->release = dfl_uio_release;
>>> +	uio->irqcontrol = dfl_uio_irqcontrol;
>>> +
>>> +	ret = uio_register_device(&feature->dev->dev, uio);
>>> +	if (ret)
>>> +		goto err_register;
>>> +
>>> +exit:
>>> +	return ret;
>>> +err_register:
>>> +	kfree(uio->name);
>>> +	goto exit;
>>> +}
>>> +EXPORT_SYMBOL_GPL(dfl_uio_add);
>>> +
>>> +int dfl_uio_remove(struct dfl_feature *feature)
>>> +{
>>> +	uio_unregister_device(&feature->uio);
>>> +	kfree(feature->uio.name);
>>> +	return 0;
>>> +}
>>> +EXPORT_SYMBOL_GPL(dfl_uio_remove);
>>> +
>>> diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
>>> index 1305be48037d..af2cd3d1b5f6 100644
>>> --- a/drivers/fpga/dfl.c
>>> +++ b/drivers/fpga/dfl.c
>>> @@ -603,6 +603,7 @@ static int dfl_feature_instance_init(struct
>> platform_device *pdev,
>>>  	}
>>>
>>>  	feature->ops = drv->ops;
>>> +	mutex_init(&feature->lock);
>>>
>>>  	return ret;
>>>  }
>>> @@ -663,10 +664,51 @@ exit:
>>>  }
>>>  EXPORT_SYMBOL_GPL(dfl_fpga_dev_feature_init);
>>>
>>> +int dfl_fpga_dev_feature_init_uio(struct platform_device *pdev, int
>> dfh_type) {
>>> +	struct dfl_feature_platform_data *pdata = dev_get_platdata(&pdev-
>>> dev);
>>> +	struct dfl_feature *feature;
>>> +	int ret;
>>> +
>>> +	dfl_fpga_dev_for_each_feature(pdata, feature) {
>>> +		if (dfh_type == DFH_TYPE_FIU) {
>>> +			if (feature->id == FEATURE_ID_FIU_HEADER ||
>>> +			    feature->id == FEATURE_ID_AFU)
>>> +			    continue;
>>> +
>>> +			ret = dfl_uio_add(feature);
>>> +			if (ret)
>>> +				goto exit;
>>> +		}
>>> +	}
>>> +
>>> +	return 0;
>>> +exit:
>>> +	dfl_fpga_dev_feature_uinit_uio(pdev, dfh_type);
>>> +	return ret;
>>> +}
>>> +EXPORT_SYMBOL_GPL(dfl_fpga_dev_feature_init_uio);
>>> +
>>> +int dfl_fpga_dev_feature_uinit_uio(struct platform_device *pdev, int
>> dfh_type) {
>>> +	struct dfl_feature_platform_data *pdata = dev_get_platdata(&pdev-
>>> dev);
>>> +	struct dfl_feature *feature;
>>> +	int ret = 0;
>>> +
>>> +	dfl_fpga_dev_for_each_feature(pdata, feature) {
>>> +		if (dfh_type == DFH_TYPE_FIU) {
>>> +			if (feature->id == FEATURE_ID_FIU_HEADER ||
>>> +			    feature->id == FEATURE_ID_AFU)
>>> +				continue;
>>> +
>>> +			ret |= dfl_uio_remove(feature);
>>> +		}
>>> +	}
>>> +	return ret;
>>> +}
>>> +EXPORT_SYMBOL_GPL(dfl_fpga_dev_feature_uinit_uio);
>>> +
>>>  static void dfl_chardev_uinit(void)
>>>  {
>>>  	int i;
>>> -
>>>  	for (i = 0; i < DFL_FPGA_DEVT_MAX; i++)
>>>  		if (MAJOR(dfl_chrdevs[i].devt)) {
>>>  			unregister_chrdev_region(dfl_chrdevs[i].devt,
>>> diff --git a/drivers/fpga/dfl.h b/drivers/fpga/dfl.h
>>> index a85d1cd7a130..fde0fc902d4d 100644
>>> --- a/drivers/fpga/dfl.h
>>> +++ b/drivers/fpga/dfl.h
>>> @@ -26,6 +26,7 @@
>>>  #include <linux/platform_device.h>
>>>  #include <linux/slab.h>
>>>  #include <linux/uuid.h>
>>> +#include <linux/uio_driver.h>
>>>  #include <linux/fpga/fpga-region.h>
>>>
>>>  /* maximum supported number of ports */
>>> @@ -232,6 +233,7 @@ struct dfl_feature_irq_ctx {
>>>   * struct dfl_feature - sub feature of the feature devices
>>>   *
>>>   * @dev: ptr to pdev of the feature device which has the sub feature.
>>> + * @uio: uio interface for feature.
>>>   * @id: sub feature id.
>>>   * @index: unique identifier for an sub feature within the feature device.
>>>   *	   It is possible that multiply sub features with same feature id are
>>> @@ -248,6 +250,8 @@ struct dfl_feature_irq_ctx {
>>>   */
>>>  struct dfl_feature {
>>>  	struct platform_device *dev;
>>> +	struct uio_info uio;
>>> +	struct mutex lock; /* serialize dev and uio */
>>>  	u64 id;
>>>  	int index;
>>>  	int resource_index;
>>> @@ -360,6 +364,11 @@ void dfl_fpga_dev_feature_uinit(struct
>> platform_device *pdev);
>>>  int dfl_fpga_dev_feature_init(struct platform_device *pdev,
>>>  			      struct dfl_feature_driver *feature_drvs);
>>>
>>> +int dfl_fpga_dev_feature_init_uio(struct platform_device *pdev, int
>> dfh_type);
>>> +int dfl_fpga_dev_feature_uinit_uio(struct platform_device *pdev, int
>> dfh_type);
>>> +int dfl_uio_add(struct dfl_feature *feature);
>>> +int dfl_uio_remove(struct dfl_feature *feature);
>>> +
>>>  int dfl_fpga_dev_ops_register(struct platform_device *pdev,
>>>  			      const struct file_operations *fops,
>>>  			      struct module *owner);
>>> diff --git a/uio.c b/uio.c
>>> new file mode 100644
>>> index 000000000000..50210aab4822
>>> --- /dev/null
>>> +++ b/uio.c
>>> @@ -0,0 +1,56 @@
>>> +#include <stdlib.h>
>>> +#include <stdio.h>
>>> +#include <unistd.h>
>>> +#include <sys/mman.h>
>>> +#include <sys/types.h>
>>> +#include <sys/stat.h>
>>> +#include <fcntl.h>
>>> +#include <errno.h>
>>> +#include <stdint.h>
>>> +
>>> +int main()
>>> +{
>>> +	int fd;
>>> +	uint64_t *ptr;
>>> +	unsigned page_size=sysconf(_SC_PAGESIZE);
>>> +	struct stat sb;
>>> +
>>> +	/*
>>> +	 * this is fid 1, thermal mgt
>>> +	 * ex/
>>> +	 * # cat /sys/class/hwmon/hwmon3/temp1_input
>>> +	 * 39000
>>> +	 */
>>> +	fd = open("/dev/uio0", O_RDONLY|O_SYNC);
>>> +	if (fd < 0) {
>>> +		perror("uio open:");
>>> +		return errno;
>>> +	}
>>> +
>>> +	ptr = (uint64_t *) mmap(NULL, page_size, PROT_READ, MAP_SHARED,
>> fd, 0);
>>> +	if (!ptr) {
>>> +		perror("uio mmap:");
>>> +	} else {
>>> +
>>> +		/* from dfl-fme-main.c :
>>> +		 *
>>> +		 * #define FME_THERM_RDSENSOR_FMT1	0x10
>>> +		 * #define FPGA_TEMPERATURE	GENMASK_ULL(6, 0)
>>> +		 *
>>> +		 * case hwmon_temp_input:
>>> +		 * v = readq(feature->ioaddr +
>> FME_THERM_RDSENSOR_FMT1);
>>> +		 * *val = (long)(FIELD_GET(FPGA_TEMPERATURE, v) * 1000);
>>> +		 * break;
>>> +		 */
>>> +		uint64_t v = ptr[2];
>>> +		v &= (1 << 6) -1;
>>> +		v *= 1000;
>>> +		printf("Temperature %d\n", v);
>>> +
>>> +		munmap(ptr, page_size);
>>> +	}
>>> +	if (close(fd))
>>> +		perror("uio close:");
>>> +
>>> +	return errno;
>>> +}
>>> --
>>> 2.18.4

