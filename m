Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F910389826
	for <lists+linux-fpga@lfdr.de>; Wed, 19 May 2021 22:42:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229454AbhESUnm (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 19 May 2021 16:43:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:53978 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229437AbhESUnl (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 19 May 2021 16:43:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621456941;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yBJ+jFmNpL9SB6gZaC1cl3/2efDoIcS83OeZ4oxnA9s=;
        b=g6AznXofa0bsjxlQ9cx09R9k95W11WjL57DtiUpq8KqQ7+rYEE8Mwn3YFmFveGbLSO1bk1
        fwRi9PckpKXtQnm55WBbI9YJt4RW4nRREInnvnZBPMi5+1hOVG7QKbhQkO+i16KuLrg+gW
        dIpXGa0cefANSXUceQU2Z6PrEkYzBUg=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-402-xUDL-M30P4iaF0jGnNNttg-1; Wed, 19 May 2021 16:42:15 -0400
X-MC-Unique: xUDL-M30P4iaF0jGnNNttg-1
Received: by mail-qk1-f200.google.com with SMTP id o14-20020a05620a0d4eb02903a5eee61155so303817qkl.9
        for <linux-fpga@vger.kernel.org>; Wed, 19 May 2021 13:42:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=yBJ+jFmNpL9SB6gZaC1cl3/2efDoIcS83OeZ4oxnA9s=;
        b=BQVufvhxYVa+BY/naWXQRj5inyAb1KNbJyjL7U9mV5Dd4TQv5kROClSqfniQr5cmto
         tRYqSOUs2FVKcgT+8nIjbqda+EXmph0EgXdrZiJdyn84ZhskAdsLi4yMmfQgfewqUqp2
         5d4ooHgan0kNnPYN+MqTNIyZK5rXY3ymlB3YdHb2wkHMT5yS78pYEN/avpVL5Prbwbyu
         1sDknvll9QHhhhu+ypmraQsR/VGKnCN/2Uhhwbe6aLrB0X2syd2G4D+KEQmd5bJBmbzn
         1YfMH2/8T4386ZOJp5nhqyqtJ0yq7jr6x6jej1f6J9fywQw+rh9nrmhpD6soWZcW0dhh
         nCXA==
X-Gm-Message-State: AOAM530t49T/W0yI+zJBw3hyDtAV7mfzKDzuEG/wzhDy09Zh4sCb6Nml
        xCiZnKTXyUwCjbkPasEAjAG73buN3aOQupVFH8bHGxcNuRnXxF3r2bGVxqUFwUDVxWsczRCXrpd
        03baCo2ahnGKSFjEe0bONtw==
X-Received: by 2002:a05:622a:202:: with SMTP id b2mr1457470qtx.343.1621456934515;
        Wed, 19 May 2021 13:42:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzui7oL01xOH+fysoe3I+vdv8OE7XhKYlFalV4QTj6eBIbktRvtVnVVVZ2TnQphkqqa7EKD9Q==
X-Received: by 2002:a05:622a:202:: with SMTP id b2mr1457450qtx.343.1621456934298;
        Wed, 19 May 2021 13:42:14 -0700 (PDT)
Received: from localhost.localdomain (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id t18sm385529qtn.63.2021.05.19.13.42.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 May 2021 13:42:13 -0700 (PDT)
Subject: Re: [PATCH 01/12] fpga: sec-mgr: fpga security manager class driver
To:     Russ Weight <russell.h.weight@intel.com>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     Xu Yilun <yilun.xu@intel.com>, Moritz Fischer <mdf@kernel.org>,
        linux-fpga@vger.kernel.org, moritzf@google.com
References: <20210517023200.52707-1-mdf@kernel.org>
 <20210517023200.52707-2-mdf@kernel.org> <YKH8qH9m1j5ubl9y@kroah.com>
 <0c54779e-4ac6-e816-e290-f613cfe1fff3@intel.com> <YKKuBSLp5Fe0Zh0v@kroah.com>
 <cb502b12-b941-b230-e67e-391baec0db20@intel.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <007b6cad-ed86-4036-24ee-fdbc4190664c@redhat.com>
Date:   Wed, 19 May 2021 13:42:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <cb502b12-b941-b230-e67e-391baec0db20@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 5/17/21 11:25 AM, Russ Weight wrote:
>
> On 5/17/21 10:55 AM, Greg KH wrote:
>> On Mon, May 17, 2021 at 10:45:40AM -0700, Russ Weight wrote:
>>> Hi Greg,
>>>
>>> On 5/16/21 10:18 PM, Greg KH wrote:
>>>> On Sun, May 16, 2021 at 07:31:49PM -0700, Moritz Fischer wrote:
>>>>> From: Russ Weight <russell.h.weight@intel.com>
>>>>>
>>>>> Create the FPGA Security Manager class driver. The security
>>>>> manager provides interfaces to manage secure updates for the
>>>>> FPGA and BMC images that are stored in FLASH. The driver can
>>>>> also be used to update root entry hashes and to cancel code
>>>>> signing keys. The image type is encoded in the image file
>>>>> and is decoded by the HW/FW secure update engine.
>>>>>
>>>>> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
>>>> Russ, you know the Intel rules here, why did you not get someone who has
>>>> knowledge of the kernel's driver model to review your patches before
>>>> sending them out?
>>>>
>>>> Basic driver model review comments below, I'm stopping after reviewing
>>>> this one as there's some big failures here...
>>>>
>>>>> +++ b/drivers/fpga/fpga-sec-mgr.c
>>>>> @@ -0,0 +1,296 @@
>>>>> +// SPDX-License-Identifier: GPL-2.0
>>>>> +/*
>>>>> + * FPGA Security Manager
>>>>> + *
>>>>> + * Copyright (C) 2019-2020 Intel Corporation, Inc.
>>>> What year is it?  :(
>>> Thanks - I'll fix the copyright dates.
>>>>> + */
>>>>> +
>>>>> +#include <linux/fpga/fpga-sec-mgr.h>
>>>>> +#include <linux/idr.h>
>>>>> +#include <linux/module.h>
>>>>> +#include <linux/slab.h>
>>>>> +#include <linux/vmalloc.h>
>>>>> +
>>>>> +static DEFINE_IDA(fpga_sec_mgr_ida);
>>>>> +static struct class *fpga_sec_mgr_class;
>>>>> +
>>>>> +struct fpga_sec_mgr_devres {
>>>>> +	struct fpga_sec_mgr *smgr;
>>>>> +};
>>>>> +
>>>>> +#define to_sec_mgr(d) container_of(d, struct fpga_sec_mgr, dev)
>>>>> +
>>>>> +static ssize_t name_show(struct device *dev,
>>>>> +			 struct device_attribute *attr, char *buf)
>>>>> +{
>>>>> +	struct fpga_sec_mgr *smgr = to_sec_mgr(dev);
>>>>> +
>>>>> +	return sysfs_emit(buf, "%s\n", smgr->name);
>>>>> +}
>>>>> +static DEVICE_ATTR_RO(name);
>>>> What is wrong with the name of the device?  Please just use that and do
>>>> not have a "second name" of the thing.
>>> The purpose was to display the name of the parent driver. Should I change
>>> "name" to "parent"? Or drop this altogether?
>> How is "name" a "parent"?  To find the parent, just walk up the sysfs
>> tree.
>>
>>> Please note that in this and other cases, I have been conforming to
>>> conventions already used in FPGA Manager class driver:
>>>
>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/fpga/fpga-mgr.c#n397
>> Maybe that needs to be fixed as well :)
>>
>> But, why re-implement the same thing and not just use the existing class
>> framework and code?
> I did the exercise of trying to merge the new functionality into the
> fpga-mgr.c code, but there was so little commonality that it was beginning
> to look like a dual-personality driver. The only thing that could be shared
> was the registration/unregistration of the driver. It seemed cleaner to
> have it as a separate class driver.
>
> - Russ

I'll post a patch in a bit that does nothing new but refactor fpga-mgr's 
ops into 'partial update' and 'full update'

existing stuff in partial

security update stuff in full

Tom

>
>>
>>>>> +EXPORT_SYMBOL_GPL(fpga_sec_mgr_create);
>>>> Why did you not register the device here.
>>> My original implementation created and registered the device in a single function:
>>>
>>> https://marc.info/?l=linux-fpga&m=159926365226264&w=2
>>>
>>> It was split up to conform to the conventions used by other class drivers in the FPGA
>>> framework: fpga-mgr.c, fpga-bridge.c, fpga-region.c
>> If you don't need things to be split, don't split it.  Or better yet,
>> use the existing code.
>>
>>>> There used to be some lovely documentation in the kernel that said I was
>>>> allowed to yell at anyone who did something like this.  But that's
>>>> removed, so I'll just be quiet and ask you to think about why you would
>>>> ever want to provide an empty function, just to make the kernel core "be
>>>> quiet".  Did you perhaps think you were smarter than the kobject core
>>>> and this was the proper solution to make it "shut up" with it's crazy
>>>> warning that some over-eager developer added?  Or perhaps, that warning
>>>> was there on purpose, lovingly hand-added to help provide a HUGE HINT
>>>> that not providing a REAL release function was wrong.
>>> In my original submission, this function was populated.
>>>
>>> https://marc.info/?l=linux-fpga&m=159926365226264&w=2
>>>
>>> Again, I was conforming to conventions used in the other class drivers in
>>> the FPGA framework, all of which have an empty *_dev_release()
>>> function:
>>>
>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/fpga/fpga-mgr.c#n782
>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/fpga/fpga-bridge.c#n476
>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/fpga/fpga-region.c#n317
>> Oh wow, that's totally wrong and broken, thanks for pointing it out.
>> Please fix that up first.
>>
>> thanks,
>>
>> greg k-h

