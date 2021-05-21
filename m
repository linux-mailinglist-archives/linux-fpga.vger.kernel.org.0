Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DE7538BB49
	for <lists+linux-fpga@lfdr.de>; Fri, 21 May 2021 03:10:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235832AbhEUBLn (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 20 May 2021 21:11:43 -0400
Received: from mga17.intel.com ([192.55.52.151]:39432 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235398AbhEUBLm (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 20 May 2021 21:11:42 -0400
IronPort-SDR: 9Tcerl6sXO1WwQrDLqf/ZP84PWEz4tdI/a1WeioyYoUQtWO8bsLa4PTCKwpUId9EftL/AY28L8
 UgxC6srPUobw==
X-IronPort-AV: E=McAfee;i="6200,9189,9990"; a="181662809"
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="181662809"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2021 18:10:20 -0700
IronPort-SDR: 1GnTdyPSGBM5n9hQRYPGV56UDgOXVA5ol1sNihwsWG5Udp7Dcr/Euq04OtTJ8hDX7Mp8h1SqTL
 PCn6AWAqjf1w==
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="474284911"
Received: from rhweight-mobl2.amr.corp.intel.com (HELO [10.0.2.4]) ([10.209.50.218])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2021 18:10:20 -0700
Subject: Re: [PATCH 01/12] fpga: sec-mgr: fpga security manager class driver
To:     Tom Rix <trix@redhat.com>, Greg KH <gregkh@linuxfoundation.org>
Cc:     Xu Yilun <yilun.xu@intel.com>, Moritz Fischer <mdf@kernel.org>,
        linux-fpga@vger.kernel.org, moritzf@google.com
References: <20210517023200.52707-1-mdf@kernel.org>
 <20210517023200.52707-2-mdf@kernel.org> <YKH8qH9m1j5ubl9y@kroah.com>
 <0c54779e-4ac6-e816-e290-f613cfe1fff3@intel.com> <YKKuBSLp5Fe0Zh0v@kroah.com>
 <cb502b12-b941-b230-e67e-391baec0db20@intel.com>
 <007b6cad-ed86-4036-24ee-fdbc4190664c@redhat.com>
From:   Russ Weight <russell.h.weight@intel.com>
Message-ID: <af35f2cb-4f69-77e5-7add-d7f337a9dac7@intel.com>
Date:   Thu, 20 May 2021 18:10:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <007b6cad-ed86-4036-24ee-fdbc4190664c@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 5/19/21 1:42 PM, Tom Rix wrote:
>
> On 5/17/21 11:25 AM, Russ Weight wrote:
>>
>> On 5/17/21 10:55 AM, Greg KH wrote:
>>> On Mon, May 17, 2021 at 10:45:40AM -0700, Russ Weight wrote:
>>>> Hi Greg,
>>>>
>>>> On 5/16/21 10:18 PM, Greg KH wrote:
>>>>> On Sun, May 16, 2021 at 07:31:49PM -0700, Moritz Fischer wrote:
>>>>>> From: Russ Weight <russell.h.weight@intel.com>
>>>>>>
>>>>>> Create the FPGA Security Manager class driver. The security
>>>>>> manager provides interfaces to manage secure updates for the
>>>>>> FPGA and BMC images that are stored in FLASH. The driver can
>>>>>> also be used to update root entry hashes and to cancel code
>>>>>> signing keys. The image type is encoded in the image file
>>>>>> and is decoded by the HW/FW secure update engine.
>>>>>>
>>>>>> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
>>>>> Russ, you know the Intel rules here, why did you not get someone who has
>>>>> knowledge of the kernel's driver model to review your patches before
>>>>> sending them out?
>>>>>
>>>>> Basic driver model review comments below, I'm stopping after reviewing
>>>>> this one as there's some big failures here...
>>>>>
>>>>>> +++ b/drivers/fpga/fpga-sec-mgr.c
>>>>>> @@ -0,0 +1,296 @@
>>>>>> +// SPDX-License-Identifier: GPL-2.0
>>>>>> +/*
>>>>>> + * FPGA Security Manager
>>>>>> + *
>>>>>> + * Copyright (C) 2019-2020 Intel Corporation, Inc.
>>>>> What year is it?  :(
>>>> Thanks - I'll fix the copyright dates.
>>>>>> + */
>>>>>> +
>>>>>> +#include <linux/fpga/fpga-sec-mgr.h>
>>>>>> +#include <linux/idr.h>
>>>>>> +#include <linux/module.h>
>>>>>> +#include <linux/slab.h>
>>>>>> +#include <linux/vmalloc.h>
>>>>>> +
>>>>>> +static DEFINE_IDA(fpga_sec_mgr_ida);
>>>>>> +static struct class *fpga_sec_mgr_class;
>>>>>> +
>>>>>> +struct fpga_sec_mgr_devres {
>>>>>> +    struct fpga_sec_mgr *smgr;
>>>>>> +};
>>>>>> +
>>>>>> +#define to_sec_mgr(d) container_of(d, struct fpga_sec_mgr, dev)
>>>>>> +
>>>>>> +static ssize_t name_show(struct device *dev,
>>>>>> +             struct device_attribute *attr, char *buf)
>>>>>> +{
>>>>>> +    struct fpga_sec_mgr *smgr = to_sec_mgr(dev);
>>>>>> +
>>>>>> +    return sysfs_emit(buf, "%s\n", smgr->name);
>>>>>> +}
>>>>>> +static DEVICE_ATTR_RO(name);
>>>>> What is wrong with the name of the device?  Please just use that and do
>>>>> not have a "second name" of the thing.
>>>> The purpose was to display the name of the parent driver. Should I change
>>>> "name" to "parent"? Or drop this altogether?
>>> How is "name" a "parent"?  To find the parent, just walk up the sysfs
>>> tree.
>>>
>>>> Please note that in this and other cases, I have been conforming to
>>>> conventions already used in FPGA Manager class driver:
>>>>
>>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/fpga/fpga-mgr.c#n397
>>> Maybe that needs to be fixed as well :)
>>>
>>> But, why re-implement the same thing and not just use the existing class
>>> framework and code?
>> I did the exercise of trying to merge the new functionality into the
>> fpga-mgr.c code, but there was so little commonality that it was beginning
>> to look like a dual-personality driver. The only thing that could be shared
>> was the registration/unregistration of the driver. It seemed cleaner to
>> have it as a separate class driver.
>>
>> - Russ
>
> I'll post a patch in a bit that does nothing new but refactor fpga-mgr's ops into 'partial update' and 'full update'
>
> existing stuff in partial
>
> security update stuff in full
>
> Tom

FYI: I just posted patches that remove the managed resource functions and
populate the class dev_release functions for fpga_mgr.c, fpga_region.c,
and fpga_bridge.c.

https://marc.info/?l=linux-fpga&m=162155904229400&w=2
https://marc.info/?l=linux-fpga&m=162155904329404&w=2
https://marc.info/?l=linux-fpga&m=162155904529409&w=2
https://marc.info/?l=linux-fpga&m=162155904529412&w=2

- Russ

>
>>
>>>
>>>>>> +EXPORT_SYMBOL_GPL(fpga_sec_mgr_create);
>>>>> Why did you not register the device here.
>>>> My original implementation created and registered the device in a single function:
>>>>
>>>> https://marc.info/?l=linux-fpga&m=159926365226264&w=2
>>>>
>>>> It was split up to conform to the conventions used by other class drivers in the FPGA
>>>> framework: fpga-mgr.c, fpga-bridge.c, fpga-region.c
>>> If you don't need things to be split, don't split it.  Or better yet,
>>> use the existing code.
>>>
>>>>> There used to be some lovely documentation in the kernel that said I was
>>>>> allowed to yell at anyone who did something like this.  But that's
>>>>> removed, so I'll just be quiet and ask you to think about why you would
>>>>> ever want to provide an empty function, just to make the kernel core "be
>>>>> quiet".  Did you perhaps think you were smarter than the kobject core
>>>>> and this was the proper solution to make it "shut up" with it's crazy
>>>>> warning that some over-eager developer added?  Or perhaps, that warning
>>>>> was there on purpose, lovingly hand-added to help provide a HUGE HINT
>>>>> that not providing a REAL release function was wrong.
>>>> In my original submission, this function was populated.
>>>>
>>>> https://marc.info/?l=linux-fpga&m=159926365226264&w=2
>>>>
>>>> Again, I was conforming to conventions used in the other class drivers in
>>>> the FPGA framework, all of which have an empty *_dev_release()
>>>> function:
>>>>
>>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/fpga/fpga-mgr.c#n782
>>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/fpga/fpga-bridge.c#n476
>>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/fpga/fpga-region.c#n317
>>> Oh wow, that's totally wrong and broken, thanks for pointing it out.
>>> Please fix that up first.
>>>
>>> thanks,
>>>
>>> greg k-h
>

