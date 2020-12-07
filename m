Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09D002D1169
	for <lists+linux-fpga@lfdr.de>; Mon,  7 Dec 2020 14:10:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725850AbgLGNIk (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 7 Dec 2020 08:08:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:29724 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725772AbgLGNIj (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 7 Dec 2020 08:08:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607346432;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1ULXZd9V8MdNo2ffCHp2FzyKIlBQT5F35TNgfvl8ulw=;
        b=FVV2W5UE19yWGkalrp8KwT4AdLf4Rw7bOFlvGBgEYws8UNRyfn7HYpfLPCXtDTkmFQ22qC
        vo5FEzWTo68mTi/dAWoA+1ESJ0ZJOaiJ7LD/0LOejgoztobH1UYaOiz9+EW6TocBBTLjGO
        jVCSt1A8c3wbmB8eKu3naMU7AycXqa0=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-16-jfUxSek6Pv2H9cv9ZTj6cw-1; Mon, 07 Dec 2020 08:07:08 -0500
X-MC-Unique: jfUxSek6Pv2H9cv9ZTj6cw-1
Received: by mail-qt1-f199.google.com with SMTP id n12so11099153qta.9
        for <linux-fpga@vger.kernel.org>; Mon, 07 Dec 2020 05:07:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=1ULXZd9V8MdNo2ffCHp2FzyKIlBQT5F35TNgfvl8ulw=;
        b=IgaCVumx3cfX1gA5sd9CzZBhyHwGwWpNBBOr+aGymM0foz8tmIRnokxRLd8MNoV933
         fL6JN7IROtT5Xb+oV27IMd8sg3qAtQhpBp/hK1GCkfP58+MtY2LwnaUBrxqCJmVUmWIH
         vhzrtzM0kuNYRamZabdjbEPcla+MCzcTx5Gp5EWS5z4y53/1JIKXHYRIudYZSO40Iq7p
         x9nuqXkxSRoezM6QXe51c/WWmcPzF9XGeatkzTT0bIocfIiHDXp9aVg2itu+EDGT3co2
         bfFt19uHrAUXp6W7lBlCrjuCIW/Yg6AN6KPWVC8cDJlg6wfciF6Vbc0hWk2DjU6T7SYL
         p2Vw==
X-Gm-Message-State: AOAM530dT4v1rXEBsr7li2wQDid+irc5MoR29umLZGl7EhdeAlT7b9F2
        zotns3ulHAKEARPXIUmWuG+d0iStv+BvrrOlHS+yG3sY5Bw/tWFKURvCVbFl5C62dr+k8UCEEYi
        y/uADSNXF0SmfL1bTx9QlmsZXN4vg3OXbfAnsWJn5CtXfzNRTcakfPeSeos6kbuBSf6Sz
X-Received: by 2002:a37:4758:: with SMTP id u85mr23302158qka.274.1607346427680;
        Mon, 07 Dec 2020 05:07:07 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyUtzi/YgVADNiwnTwvGCGHvD6G4UVHYje+75akBxANTaszYDjOPGcT2oqPk/BW4xOc9ffh6w==
X-Received: by 2002:a37:4758:: with SMTP id u85mr23302123qka.274.1607346427281;
        Mon, 07 Dec 2020 05:07:07 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id m65sm11782548qtd.5.2020.12.07.05.07.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Dec 2020 05:07:06 -0800 (PST)
Subject: Re: [RFC] fpga: dfl: a prototype uio driver
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     yilun.xu@intel.com, hao.wu@intel.com, mdf@kernel.org,
        linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org
References: <20201206215554.350230-1-trix@redhat.com>
 <X83hkdgrMysGuUdL@kroah.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <53097eaf-02ee-8e41-9738-107115dc9dcd@redhat.com>
Date:   Mon, 7 Dec 2020 05:07:05 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <X83hkdgrMysGuUdL@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 12/7/20 12:02 AM, Greg KH wrote:
> On Sun, Dec 06, 2020 at 01:55:54PM -0800, trix@redhat.com wrote:
>> From: Tom Rix <trix@redhat.com>
>>
>> >From [PATCH 0/2] UIO support for dfl devices
>> https://lore.kernel.org/linux-fpga/1602828151-24784-1-git-send-email-yilun.xu@intel.com/
> Why is this here?

As reference, Yilun's work has precedence for a uio driver and this rfc is trying to address what i believe is a sticking point of the driver override.  This rfc is some code i hacked out to show the idea and move uio support along.  I would like to see uio support for at least the unclaimed feature id's because this would make it easier for them to be developed.

>> Here is an idea to have uio support with no driver override.
>>
>> This makes UIO the primary driver interface because every feature
>> will have one and makes the existing platform driver interface
>> secondary.  There will be a new burden for locking write access when
>> they compete.
>>
>> Example shows finding the fpga's temperture.
>>
>> Signed-off-by: Tom Rix <trix@redhat.com>
>> ---
>>  drivers/fpga/dfl-fme-main.c |  9 +++-
>>  drivers/fpga/dfl-uio.c      | 96 +++++++++++++++++++++++++++++++++++++
>>  drivers/fpga/dfl.c          | 44 ++++++++++++++++-
>>  drivers/fpga/dfl.h          |  9 ++++
>>  uio.c                       | 56 ++++++++++++++++++++++
>>  5 files changed, 212 insertions(+), 2 deletions(-)
>>  create mode 100644 drivers/fpga/dfl-uio.c
>>  create mode 100644 uio.c
>>
>> diff --git a/drivers/fpga/dfl-fme-main.c b/drivers/fpga/dfl-fme-main.c
>> index 037dc4f946f0..3323e90a18c4 100644
>> --- a/drivers/fpga/dfl-fme-main.c
>> +++ b/drivers/fpga/dfl-fme-main.c
>> @@ -709,12 +709,18 @@ static int fme_probe(struct platform_device *pdev)
>>  	if (ret)
>>  		goto dev_destroy;
>>  
>> -	ret = dfl_fpga_dev_ops_register(pdev, &fme_fops, THIS_MODULE);
>> +	ret = dfl_fpga_dev_feature_init_uio(pdev, DFH_TYPE_FIU);
>>  	if (ret)
>>  		goto feature_uinit;
>>  
>> +	ret = dfl_fpga_dev_ops_register(pdev, &fme_fops, THIS_MODULE);
>> +	if (ret)
>> +		goto feature_uinit_uio;
>> +
>>  	return 0;
>>  
>> +feature_uinit_uio:
>> +	dfl_fpga_dev_feature_uinit_uio(pdev, DFH_TYPE_FIU);
>>  feature_uinit:
>>  	dfl_fpga_dev_feature_uinit(pdev);
>>  dev_destroy:
>> @@ -726,6 +732,7 @@ exit:
>>  static int fme_remove(struct platform_device *pdev)
>>  {
>>  	dfl_fpga_dev_ops_unregister(pdev);
>> +	dfl_fpga_dev_feature_uinit_uio(pdev, DFH_TYPE_FIU);
>>  	dfl_fpga_dev_feature_uinit(pdev);
>>  	fme_dev_destroy(pdev);
>>  
>> diff --git a/drivers/fpga/dfl-uio.c b/drivers/fpga/dfl-uio.c
>> new file mode 100644
>> index 000000000000..7610ee0b19dc
>> --- /dev/null
>> +++ b/drivers/fpga/dfl-uio.c
>> @@ -0,0 +1,96 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/*
>> + * prototype dfl uio driver
>> + *
>> + * Copyright Tom Rix 2020
>> + */
>> +#include <linux/module.h>
>> +#include "dfl.h"
>> +
>> +static irqreturn_t dfl_uio_handler(int irq, struct uio_info *info)
>> +{
>> +	return IRQ_HANDLED;
>> +}
>> +
>> +static int dfl_uio_mmap(struct uio_info *info, struct vm_area_struct *vma)
>> +{
>> +	int ret = -ENODEV;
>> +	return ret;
> Did you run this through checkpatch?
>
> Does the code make sense?
>
>> +}
>> +
>> +static int dfl_uio_open(struct uio_info *info, struct inode *inode)
>> +{
>> +	int ret = -ENODEV;
>> +	struct dfl_feature *feature = container_of(info, struct dfl_feature, uio);
>> +	if (feature->dev)
>> +		mutex_lock(&feature->lock);
>> +
>> +	ret = 0;
>> +	return ret;
> Same here, does this make sense?
>
> And wait, you are having userspace grab a kernel lock?  What could go
> wrong?  :(
>
Yes, this is the bad part of this idea.

Tom


>> +}
>> +
>> +static int dfl_uio_release(struct uio_info *info, struct inode *inode)
>> +{
>> +	int ret = -ENODEV;
>> +	struct dfl_feature *feature = container_of(info, struct dfl_feature, uio);
>> +	if (feature->dev)
>> +		mutex_unlock(&feature->lock);
>> +
>> +	ret = 0;
>> +	return ret;
>> +}
>> +
>> +static int dfl_uio_irqcontrol(struct uio_info *info, s32 irq_on)
>> +{
>> +	int ret = -ENODEV;
>> +	return ret;
>> +}
>> +
>> +int dfl_uio_add(struct dfl_feature *feature)
>> +{
>> +	struct uio_info *uio = &feature->uio;
>> +	struct resource *res =
>> +		&feature->dev->resource[feature->resource_index];
>> +	int ret = 0;
>> +
>> +	uio->name = kasprintf(GFP_KERNEL, "dfl-uio-%llx", feature->id);
>> +	if (!uio->name) {
>> +		ret = -ENOMEM;
>> +		goto exit;
>> +	}
>> +
>> +	uio->version = "0.1";
>> +	uio->mem[0].memtype = UIO_MEM_PHYS;
>> +	uio->mem[0].addr = res->start & PAGE_MASK;
>> +	uio->mem[0].offs = res->start & ~PAGE_MASK;
>> +	uio->mem[0].size = (uio->mem[0].offs + resource_size(res)
>> +			    + PAGE_SIZE - 1) & PAGE_MASK;
>> +	/* How are nr_irqs > 1 handled ??? */
>> +	if (feature->nr_irqs == 1)
>> +		uio->irq = feature->irq_ctx[0].irq;
>> +	uio->handler = dfl_uio_handler;
>> +	//uio->mmap = dfl_uio_mmap;
> ???
>
> I don't understand what this patch is trying to show...
> thanks,
>
> greg k-h
>

