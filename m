Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC5BF271555
	for <lists+linux-fpga@lfdr.de>; Sun, 20 Sep 2020 17:24:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726305AbgITPYs (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 20 Sep 2020 11:24:48 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:24924 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726267AbgITPYs (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Sun, 20 Sep 2020 11:24:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600615486;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X2pc1srMVeeLC/LBr1Y27GS4LGAQBXsd1B5qr143Grw=;
        b=Wwe72mdJY9+j4CJEada4r9PPfnhmX6jRoQk3rxwaqqrFeIEtGshldhCVPDNImOFsdFMGn0
        IHuR6rZSvkP8EG6IDHPDrmyft/AL/09xT9jBmRDBWyAhwdOqCf0Dmd2Gr5igPsXT0jl96j
        sKgfMmwGGJN8vR6lfl1xod5difr+0ZM=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-590-jtnyuyMHM06izK3N9NJc_w-1; Sun, 20 Sep 2020 11:24:44 -0400
X-MC-Unique: jtnyuyMHM06izK3N9NJc_w-1
Received: by mail-qv1-f72.google.com with SMTP id y2so7493192qvs.14
        for <linux-fpga@vger.kernel.org>; Sun, 20 Sep 2020 08:24:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=X2pc1srMVeeLC/LBr1Y27GS4LGAQBXsd1B5qr143Grw=;
        b=GAx1z3cCp04+yrIMI3WReEaQvTsocWV5h4RPCLKWK6GtdKW3bAlLUDnLp70O3Irffq
         +grJpdapaZjdoRL29VgG1VO4qJYTLzOUGF2iqaIaG2bCcFHKMD+LwVHdDApDyCkf78VS
         otoc0b4FrVYYwwU6DK9pZaV3/1GvhzwKcW1V3dGWvF08Udn94peMNpJf1mu/JI6Zdff+
         +mR2pAlBQ+Owddf6g/F/r7ycyIiyzTLCVKDeI4AW5kF1IZUhwFAcnQ+Mx6wAzbxbG043
         mZ88G08yO4YgER8afRyj+W1MLaiCQZ1Nj2RLt5vRGZGHSjsWhD9Ph9StvkhUPrUbsyds
         GViQ==
X-Gm-Message-State: AOAM533wvwFzT2ZK/cZq0TYlsMs9dw1XoQ3F18ykyuyPMlu4P/OYHegg
        kwdhjw8T4tI07f7DN4Mzo1QPtWXfvpN2GHdyFwRNPVS3rW0L1ufQnqatj1O7lzzuY93H5PLFFpc
        PcZ1dly7yToepXWUhl2MR7g==
X-Received: by 2002:ac8:3261:: with SMTP id y30mr42470420qta.242.1600615483330;
        Sun, 20 Sep 2020 08:24:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx+Kp+qiLBoxIYKVP3m9dc3m6WN1SE33tBt4n95IXmaC7PoegrsnGhtiu6YfA0FCHHxhCq3FA==
X-Received: by 2002:ac8:3261:: with SMTP id y30mr42470394qta.242.1600615482884;
        Sun, 20 Sep 2020 08:24:42 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id m64sm6919353qkd.80.2020.09.20.08.24.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Sep 2020 08:24:42 -0700 (PDT)
Subject: Re: [PATCH v1 05/12] fpga: enable secure updates
To:     Russ Weight <russell.h.weight@intel.com>, mdf@kernel.org,
        lee.jones@linaro.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     lgoncalv@redhat.com, yilun.xu@intel.com, hao.wu@intel.com,
        matthew.gerlach@intel.com
References: <20200904235305.6254-1-russell.h.weight@intel.com>
 <20200904235305.6254-6-russell.h.weight@intel.com>
 <3c3440c3-1087-f1aa-d25f-52156b68020c@redhat.com>
 <1d90bfb6-417c-55df-9290-991c391158a9@intel.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <96a1d2b9-5fe2-238d-4712-23d658b7ea6d@redhat.com>
Date:   Sun, 20 Sep 2020 08:24:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <1d90bfb6-417c-55df-9290-991c391158a9@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 9/18/20 6:10 PM, Russ Weight wrote:
>
> On 9/5/20 3:04 PM, Tom Rix wrote:
>> On 9/4/20 4:52 PM, Russ Weight wrote:
>>> Extend the FPGA Intel Security Manager class driver to
>>> include an update/filename sysfs node that can be used
>>> to initiate a security update.  The filename of a secure
>>> update file (BMC image, FPGA image, Root Entry Hash image,
>>> or Code Signing Key cancellation image) can be written to
>>> this sysfs entry to cause a secure update to occur.
>>>
>>> The write of the filename will return immediately, and the
>>> update will begin in the context of a kernel worker thread.
>>> This tool utilizes the request_firmware framework, which
>>> requires that the image file reside under /lib/firmware.
>>>
>>> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
>>> ---
>>>  .../ABI/testing/sysfs-class-ifpga-sec-mgr     |  13 ++
>>>  drivers/fpga/ifpga-sec-mgr.c                  | 155 ++++++++++++++++++
>>>  include/linux/fpga/ifpga-sec-mgr.h            |  49 ++++++
>>>  3 files changed, 217 insertions(+)
>>>
>>> diff --git a/Documentation/ABI/testing/sysfs-class-ifpga-sec-mgr b/Documentation/ABI/testing/sysfs-class-ifpga-sec-mgr
>>> index 86f8992559bf..a476504b7ae9 100644
>>> --- a/Documentation/ABI/testing/sysfs-class-ifpga-sec-mgr
>>> +++ b/Documentation/ABI/testing/sysfs-class-ifpga-sec-mgr
>>> @@ -73,3 +73,16 @@ Contact:	Russ Weight <russell.h.weight@intel.com>
>>>  Description:	Read only. Returns number of times the BMC image has been
>>>  		flashed.
>>>  		Format: "%d".
>>> +
>>> +What: 		/sys/class/ifpga_sec_mgr/ifpga_secX/update/filename
>>> +Date:		Sep 2020
>>> +KernelVersion:  5.10
>>> +Contact:	Russ Weight <russell.h.weight@intel.com>
>>> +Description:	Write only. Write the filename of an Intel image
>>> +		file to this sysfs file to initiate a secure
>>> +		update. The file must have an appropriate header
>>> +		which, among other things, identifies the target
>>> +		for the update. This mechanism is used to update
>>> +		BMC images, BMC firmware, Static Region images,
>>> +		and Root Entry Hashes, and to cancel Code Signing
>>> +		Keys (CSK).
>>> diff --git a/drivers/fpga/ifpga-sec-mgr.c b/drivers/fpga/ifpga-sec-mgr.c
>>> index 97bf80277ed2..73173badbe96 100644
>>> --- a/drivers/fpga/ifpga-sec-mgr.c
>>> +++ b/drivers/fpga/ifpga-sec-mgr.c
>>> @@ -5,8 +5,11 @@
>>>   * Copyright (C) 2019-2020 Intel Corporation, Inc.
>>>   */
>>>  
>>> +#include <linux/delay.h>
>>> +#include <linux/firmware.h>
>>>  #include <linux/fpga/ifpga-sec-mgr.h>
>>>  #include <linux/idr.h>
>>> +#include <linux/kernel.h>
>>>  #include <linux/module.h>
>>>  #include <linux/slab.h>
>>>  #include <linux/vmalloc.h>
>>> @@ -14,6 +17,8 @@
>>>  static DEFINE_IDA(ifpga_sec_mgr_ida);
>>>  static struct class *ifpga_sec_mgr_class;
>>>  
>>> +#define WRITE_BLOCK_SIZE	0x4000
>>> +
>>>  static ssize_t show_canceled_csk(struct ifpga_sec_mgr *imgr,
>>>  				 sysfs_csk_hndlr_t get_csk,
>>>  				 sysfs_csk_nbits_t get_csk_nbits,
>>> @@ -134,6 +139,91 @@ static struct attribute *sec_mgr_security_attrs[] = {
>>>  	NULL,
>>>  };
>>>  
>>> +static void ifpga_sec_dev_error(struct ifpga_sec_mgr *imgr,
>>> +				enum ifpga_sec_err err_code)
>>> +{
>>> +	imgr->err_code = err_code;
>>> +	imgr->iops->cancel(imgr);
>>> +}
>>> +
>>> +static void progress_complete(struct ifpga_sec_mgr *imgr)
>>> +{
>>> +	mutex_lock(&imgr->lock);
>>> +	imgr->progress = IFPGA_SEC_PROG_IDLE;
>>> +	complete_all(&imgr->update_done);
>>> +	mutex_unlock(&imgr->lock);
>>> +}
>>> +
>>> +static void ifpga_sec_mgr_update(struct work_struct *work)
>>> +{
>>> +	u32 size, blk_size, offset = 0;
>>> +	struct ifpga_sec_mgr *imgr;
>>> +	const struct firmware *fw;
>>> +	enum ifpga_sec_err ret;
>>> +
>>> +	imgr = container_of(work, struct ifpga_sec_mgr, work);
>> Why not lock here ? It seems like filename and other
>>
>> state could be changed out from under the work func.
> Filename_store() uses imgr->progress, imgr->driver_unload, and imgr->lock
> to ensure that only one worker thread is running at a time. In some of the later
> patches there is some lock protection around error, progress, and cancel accesses.
> At this point in the patchset, the synchronization in filename_store() should be
> sufficient.
ok
>>> +
>>> +	get_device(&imgr->dev);
>>> +	if (request_firmware(&fw, imgr->filename, &imgr->dev)) {
>>> +		imgr->err_code = IFPGA_SEC_ERR_FILE_READ;
>>> +		goto idle_exit;
>>> +	}
>>> +
>>> +	imgr->data = fw->data;
>>> +	imgr->remaining_size = fw->size;
>>> +
>>> +	if (!try_module_get(imgr->dev.parent->driver->owner)) {
>>> +		imgr->err_code = IFPGA_SEC_ERR_BUSY;
>>> +		goto release_fw_exit;
>>> +	}
>>> +
>>> +	imgr->progress = IFPGA_SEC_PROG_PREPARING;
>>> +	ret = imgr->iops->prepare(imgr);
>>> +	if (ret) {
>>> +		ifpga_sec_dev_error(imgr, ret);
>>> +		goto modput_exit;
>>> +	}
>>> +
>>> +	imgr->progress = IFPGA_SEC_PROG_WRITING;
>>> +	size = imgr->remaining_size;
>>> +	while (size) {
>>> +		blk_size = min_t(u32, size, WRITE_BLOCK_SIZE);
>>> +		size -= blk_size;
>>> +		ret = imgr->iops->write_blk(imgr, offset, blk_size);
>> Check for function pointer later, good.
>>
>> Could writing a short block be handled like libc's write()
>>
>> by passing back the bytes written ?
> It could be done, multiplexing the size into the return code. Do you think it
> would add value?
A toss up. I like consistent interfaces.
>>> +		if (ret) {
>>> +			ifpga_sec_dev_error(imgr, ret);
>>> +			goto done;
>>> +		}
>>> +
>>> +		imgr->remaining_size = size;
>>> +		offset += blk_size;
>>> +	}
>>> +
>>> +	imgr->progress = IFPGA_SEC_PROG_PROGRAMMING;
>>> +	ret = imgr->iops->poll_complete(imgr);
>>> +	if (ret) {
>>> +		ifpga_sec_dev_error(imgr, ret);
>>> +		goto done;
>>> +	}
>> Add a paranoid crc check the flash is what was written ?
> In the secure update implementation, the host driver transfers the data
> to a staging area in flash, and then it is up to the BMC firmware to
> actually do the programming and validation, so it is unnecessary for
> the host driver to check the flash. Also, on the n3000, the updates
> take more than 30 minutes, so adding additional checks would add
> to an already long wait.
ok
>>> +
>>> +done:
>>> +	if (imgr->iops->cleanup)
>>> +		imgr->iops->cleanup(imgr);
>>> +
>>> +modput_exit:
>>> +	module_put(imgr->dev.parent->driver->owner);
>>> +
>>> +release_fw_exit:
>>> +	imgr->data = NULL;
>> clear remaining_size ?
> Remaining size is left unchanged intentionally. On success it will be zero.
> In the case of an error it can be helpful/interesting to see how much data
> has transferred (using the remaining_size sysfs file). Remaining_size will
> be reinitialized at the start of the next instance of a secure update.

Is there a way to tell if the transfer is stuck/in the middle or a failure ?

Maybe add a comment that this is intentional so someone does not remove this later.

>>> +	release_firmware(fw);
>>> +
>>> +idle_exit:
>>> +	kfree(imgr->filename);
>>> +	imgr->filename = NULL;
>>> +	put_device(&imgr->dev);
>>> +	progress_complete(imgr);
>>> +}
>>> +
>>>  #define check_attr(attribute, _name) \
>>>  	((attribute) == &dev_attr_##_name.attr && imgr->iops->_name)
>>>  
>>> @@ -161,6 +251,51 @@ static struct attribute_group sec_mgr_security_attr_group = {
>>>  	.is_visible = sec_mgr_visible,
>>>  };
>>>  
>>> +static ssize_t filename_store(struct device *dev, struct device_attribute *attr,
>>> +			      const char *buf, size_t count)
>>> +{
>>> +	struct ifpga_sec_mgr *imgr = to_sec_mgr(dev);
>>> +	int ret = 0;
>>> +
>>> +	if (count == 0 || count >= PATH_MAX)
>>> +		return -EINVAL;
>>> +
>>> +	mutex_lock(&imgr->lock);
>>> +	if (imgr->driver_unload || imgr->progress != IFPGA_SEC_PROG_IDLE) {
>>> +		ret = -EBUSY;
>>> +		goto unlock_exit;
>>> +	}
>>> +
>>> +	imgr->filename = kstrndup(buf, PATH_MAX - 1, GFP_KERNEL);
>> shouldn't this be 'count - 1' ?
> Yes - you are right. I'll make that change. Thanks!
>>> +	if (!imgr->filename) {
>>> +		ret = -ENOMEM;
>>> +		goto unlock_exit;
>>> +	}
>>> +
>>> +	if (imgr->filename[strlen(imgr->filename) - 1] == '\n')
>>> +		imgr->filename[strlen(imgr->filename) - 1] = '\0';
>> If you are catching the '\n' is a more general striping of
>>
>> whitespace needed ?
> My intent was to take care of the common case, but now that you  mention it,
> I don't think the '\n' case is really required. Perhaps this check could be
> removed?
>
> Or do you think I should add more checks? Currently, if a quoted string with
> whitespace is provided for the filename, then the update will fail with
> "file-error". But it seems like an unlikely case.

Perhaps i am being paranoid, i think user inputs need extra checking.

see more comment below.

>> Could a file exists check be done before kicking off the worker?
> It could be done. I didn't include them because I thought it would be redundant
> with functionality already provided by request_firmware(). In the current
> implementation, the error sysfs file would indicate "file-error". It may be
> possible to give a more descriptive error using errno if it was detected in
> this context.

yes this would be redundant, but you would know early if filename was invalid.

toss up, change if you want.

Tom

>>> +
>>> +	imgr->err_code = IFPGA_SEC_ERR_NONE;
>>> +	imgr->progress = IFPGA_SEC_PROG_READ_FILE;
>>> +	reinit_completion(&imgr->update_done);
>>> +	schedule_work(&imgr->work);
>> Skip the if-check at the end
>>
>> ret = count.
> OK. It looks like I could just initialize ret to count.
>>> +
>>> +unlock_exit:
>>> +	mutex_unlock(&imgr->lock);
>>> +	return ret ? : count;
>>> +}
>>> +static DEVICE_ATTR_WO(filename);
>>> +
>>> +static struct attribute *sec_mgr_update_attrs[] = {
>>> +	&dev_attr_filename.attr,
>>> +	NULL,
>>> +};
>>> +
>>> +static struct attribute_group sec_mgr_update_attr_group = {
>>> +	.name = "update",
>>> +	.attrs = sec_mgr_update_attrs,
>>> +};
>>> +
>>>  static ssize_t name_show(struct device *dev,
>>>  			 struct device_attribute *attr, char *buf)
>>>  {
>>> @@ -182,6 +317,7 @@ static struct attribute_group sec_mgr_attr_group = {
>>>  static const struct attribute_group *ifpga_sec_mgr_attr_groups[] = {
>>>  	&sec_mgr_attr_group,
>>>  	&sec_mgr_security_attr_group,
>>> +	&sec_mgr_update_attr_group,
>>>  	NULL,
>>>  };
>>>  
>>> @@ -233,6 +369,12 @@ ifpga_sec_mgr_register(struct device *dev, const char *name,
>>>  	struct ifpga_sec_mgr *imgr;
>>>  	int id, ret;
>>>  
>>> +	if (!iops || !iops->cancel || !iops->prepare ||
>>> +	    !iops->write_blk || !iops->poll_complete) {
>> Comments in ifpga-sec-mgr.h say 'Required: ' good.
>>> +		dev_err(dev, "Attempt to register without ifpga_sec_mgr_ops\n");
>> without required ifpga_sec_mgr_ops
> Yes - I'll make the change.
>>> +		return NULL;
>>> +	}
>>> +
>>>  	if (!check_reh_handler(dev, iops, bmc) ||
>>>  	    !check_reh_handler(dev, iops, sr) ||
>>>  	    !check_reh_handler(dev, iops, pr) ||
>>> @@ -254,6 +396,8 @@ ifpga_sec_mgr_register(struct device *dev, const char *name,
>>>  	imgr->name = name;
>>>  	imgr->priv = priv;
>>>  	imgr->iops = iops;
>>> +	init_completion(&imgr->update_done);
>>> +	INIT_WORK(&imgr->work, ifpga_sec_mgr_update);
>>>  	mutex_init(&imgr->lock);
>>>  
>>>  	id = ida_simple_get(&ifpga_sec_mgr_ida, 0, 0, GFP_KERNEL);
>>> @@ -299,6 +443,17 @@ void ifpga_sec_mgr_unregister(struct ifpga_sec_mgr *imgr)
>>>  {
>>>  	dev_info(&imgr->dev, "%s %s\n", __func__, imgr->name);
>>>  
>>> +	mutex_lock(&imgr->lock);
>>> +	imgr->driver_unload = true;
>>> +	if (imgr->progress == IFPGA_SEC_PROG_IDLE) {
>>> +		mutex_unlock(&imgr->lock);
>>> +		goto unregister;
>>> +	}
>>> +
>>> +	mutex_unlock(&imgr->lock);
>>> +	wait_for_completion(&imgr->update_done);
>>> +
>>> +unregister:
>>>  	device_unregister(&imgr->dev);
>>>  }
>>>  EXPORT_SYMBOL_GPL(ifpga_sec_mgr_unregister);
>>> diff --git a/include/linux/fpga/ifpga-sec-mgr.h b/include/linux/fpga/ifpga-sec-mgr.h
>>> index e391b0c8f448..4da2864e251c 100644
>>> --- a/include/linux/fpga/ifpga-sec-mgr.h
>>> +++ b/include/linux/fpga/ifpga-sec-mgr.h
>>> @@ -7,6 +7,7 @@
>>>  #ifndef _LINUX_IFPGA_SEC_MGR_H
>>>  #define _LINUX_IFPGA_SEC_MGR_H
>>>  
>>> +#include <linux/completion.h>
>>>  #include <linux/device.h>
>>>  #include <linux/mutex.h>
>>>  #include <linux/types.h>
>>> @@ -86,6 +87,19 @@ typedef int (*sysfs_csk_nbits_t)(struct ifpga_sec_mgr *imgr);
>>>  typedef int (*sysfs_csk_hndlr_t)(struct ifpga_sec_mgr *imgr,
>>>  				 unsigned long *csk_map, unsigned int nbits);
>>>  
>>> +enum ifpga_sec_err {
>>> +	IFPGA_SEC_ERR_NONE	   = 0x0,
>>> +	IFPGA_SEC_ERR_HW_ERROR	   = 0x1,
>>> +	IFPGA_SEC_ERR_TIMEOUT	   = 0x2,
>>> +	IFPGA_SEC_ERR_CANCELED	   = 0x3,
>>> +	IFPGA_SEC_ERR_BUSY	   = 0x4,
>>> +	IFPGA_SEC_ERR_INVALID_SIZE = 0x5,
>>> +	IFPGA_SEC_ERR_RW_ERROR	   = 0x6,
>>> +	IFPGA_SEC_ERR_WEAROUT	   = 0x7,
>>> +	IFPGA_SEC_ERR_FILE_READ	   = 0x8,
>>> +	IFPGA_SEC_ERR_MAX	   = 0x9
>> The initializers are redundant.
> OK - I'll remove them.
>>> +};
>>> +
>>>  /**
>>>   * struct ifpga_sec_mgr_ops - device specific operations
>>>   * @user_flash_count:	    Optional: Return sysfs string output for FPGA
>>> @@ -110,6 +124,17 @@ typedef int (*sysfs_csk_hndlr_t)(struct ifpga_sec_mgr *imgr,
>>>   * @bmc_reh_size:	    Optional: Return byte size for BMC root entry hash
>>>   * @sr_reh_size:	    Optional: Return byte size for SR root entry hash
>>>   * @pr_reh_size:	    Optional: Return byte size for PR root entry hash
>>> + * @prepare:		    Required: Prepare secure update
>>> + * @write_blk:		    Required: Write a block of data
>>> + * @poll_complete:	    Required: Check for the completion of the
>>> + *			    HW authentication/programming process. This
>>> + *			    function should check for imgr->driver_unload
>>> + *			    and abort with IFPGA_SEC_ERR_CANCELED when true.
>>> + * @cancel:		    Required: Signal HW to cancel update
>>> + * @cleanup:		    Optional: Complements the prepare()
>>> + *			    function and is called at the completion
>>> + *			    of the update, whether success or failure,
>>> + *			    if the prepare function succeeded.
>>>   */
>>>  struct ifpga_sec_mgr_ops {
>>>  	sysfs_cnt_hndlr_t user_flash_count;
>>> @@ -127,6 +152,22 @@ struct ifpga_sec_mgr_ops {
>>>  	sysfs_csk_nbits_t bmc_canceled_csk_nbits;
>>>  	sysfs_csk_nbits_t sr_canceled_csk_nbits;
>>>  	sysfs_csk_nbits_t pr_canceled_csk_nbits;
>>> +	enum ifpga_sec_err (*prepare)(struct ifpga_sec_mgr *imgr);
>>> +	enum ifpga_sec_err (*write_blk)(struct ifpga_sec_mgr *imgr,
>>> +					u32 offset, u32 size);
>>> +	enum ifpga_sec_err (*poll_complete)(struct ifpga_sec_mgr *imgr);
>>> +	void (*cleanup)(struct ifpga_sec_mgr *imgr);
>>> +	enum ifpga_sec_err (*cancel)(struct ifpga_sec_mgr *imgr);
>>> +};
>>> +
>>> +/* Update progress codes */
>>> +enum ifpga_sec_prog {
>>> +	IFPGA_SEC_PROG_IDLE	   = 0x0,
>>> +	IFPGA_SEC_PROG_READ_FILE   = 0x1,
>>> +	IFPGA_SEC_PROG_PREPARING   = 0x2,
>>> +	IFPGA_SEC_PROG_WRITING	   = 0x3,
>>> +	IFPGA_SEC_PROG_PROGRAMMING = 0x4,
>>> +	IFPGA_SEC_PROG_MAX	   = 0x5
>> ditto
> Yes. Thanks for the comments!
>
> - Russ
>> Tom
>>
>>>  };
>>>  
>>>  struct ifpga_sec_mgr {
>>> @@ -134,6 +175,14 @@ struct ifpga_sec_mgr {
>>>  	struct device dev;
>>>  	const struct ifpga_sec_mgr_ops *iops;
>>>  	struct mutex lock;		/* protect data structure contents */
>>> +	struct work_struct work;
>>> +	struct completion update_done;
>>> +	char *filename;
>>> +	const u8 *data;			/* pointer to update data */
>>> +	u32 remaining_size;		/* size remaining to transfer */
>>> +	enum ifpga_sec_prog progress;
>>> +	enum ifpga_sec_err err_code;	/* security manager error code */
>>> +	bool driver_unload;
>>>  	void *priv;
>>>  };
>>>  

