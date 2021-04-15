Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B5A636089E
	for <lists+linux-fpga@lfdr.de>; Thu, 15 Apr 2021 13:53:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232670AbhDOLyO (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 15 Apr 2021 07:54:14 -0400
Received: from mga05.intel.com ([192.55.52.43]:15737 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229943AbhDOLyJ (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 15 Apr 2021 07:54:09 -0400
IronPort-SDR: o5WusX4HZarXl25mRYE2JjdEW9HkJ4awfaVE+JmkU3sdGQfAGMWpgqGhnScJPEmUfr9xbxt/pz
 b1ZTuU/YCrwQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9954"; a="280151257"
X-IronPort-AV: E=Sophos;i="5.82,223,1613462400"; 
   d="scan'208";a="280151257"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2021 04:53:46 -0700
IronPort-SDR: QiOY3ULHr9jD3kNe5TNBzdaH9ybzlKM0FQX22FuYv+jHl/GdWThfRyjukhW7FDVaXgcj5dIJz9
 +myQ53fPhIPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,223,1613462400"; 
   d="scan'208";a="418716586"
Received: from marshy.an.intel.com (HELO [10.122.105.143]) ([10.122.105.143])
  by fmsmga008.fm.intel.com with ESMTP; 15 Apr 2021 04:53:45 -0700
Subject: Re: FW: [RFC PATCH v1 1/1] fpga: mgr: enable asynchronous image
 updates
To:     mdf@kernel.org,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>
References: <20210410003810.222597-1-russell.h.weight@intel.com>
 <20210410003810.222597-2-russell.h.weight@intel.com>
 <d82b7551-8434-b600-c20f-3854638355b2@intel.com>
 <MWHPR11MB0015BA72FFC35BF0DDB90E63874D9@MWHPR11MB0015.namprd11.prod.outlook.com>
Cc:     Tom Rix <trix@redhat.com>, lgoncalv@redhat.com,
        Xu Yilun <yilun.xu@intel.com>, hao.wu@intel.com,
        "Gerlach, Matthew" <matthew.gerlach@intel.com>
From:   Richard Gong <richard.gong@linux.intel.com>
Message-ID: <05c2921e-c2dd-347a-c606-f2bf704db7d6@linux.intel.com>
Date:   Thu, 15 Apr 2021 07:13:10 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <MWHPR11MB0015BA72FFC35BF0DDB90E63874D9@MWHPR11MB0015.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


> 
> 
> -----Original Message-----
> From: Weight, Russell H <russell.h.weight@intel.com>
> Sent: Wednesday, April 14, 2021 11:46 AM
> To: mdf@kernel.org; linux-fpga@vger.kernel.org
> Cc: trix@redhat.com; lgoncalv@redhat.com; Xu, Yilun <yilun.xu@intel.com>; Wu, Hao <hao.wu@intel.com>; Gerlach, Matthew <matthew.gerlach@intel.com>; Gong, Richard <richard.gong@intel.com>
> Subject: Re: [RFC PATCH v1 1/1] fpga: mgr: enable asynchronous image updates
> 
> +Richard Gong
> 
> On 4/9/21 5:38 PM, Russ Weight wrote:
>> Extend the FPGA Manager class driver to support asynchronous image
>> updates in the context of a kernel worker thread. These updates are
>> managed through sysfs file entries. This patch specifically creates
>> the async_update/filename sysfs node that can be used to initiate an
>> asynchronous update. The filename of a update image can be written to
>> this sysfs entry to cause the update to occur.
>>
>> The write of the filename will return immediately, and the update will
>> begin in the context of a kernel worker thread.  This tool utilizes
>> the request_firmware framework, which requires that the image file
>> reside under /lib/firmware.
>>
>> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
>> ---
>>   .../ABI/testing/sysfs-class-fpga-manager      |   9 +
>>   drivers/fpga/fpga-mgr.c                       | 199 +++++++++++++++++-
>>   include/linux/fpga/fpga-mgr.h                 |  52 +++++
>>   3 files changed, 259 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/ABI/testing/sysfs-class-fpga-manager
>> b/Documentation/ABI/testing/sysfs-class-fpga-manager
>> index d78689c357a5..39ff8764f261 100644
>> --- a/Documentation/ABI/testing/sysfs-class-fpga-manager
>> +++ b/Documentation/ABI/testing/sysfs-class-fpga-manager
>> @@ -58,3 +58,12 @@ Description:	Read fpga manager status as a string.
>>   						  reconfiguration hardware
>>   		* reconfig fifo overflow error	- FIFO overflow detected by
>>   						  reconfiguration hardware
>> +
>> +What:		/sys/class/fpga_manager/<fpga>/async_update/filename
>> +Date:		April 2021
>> +KernelVersion:	5.13
>> +Contact:	Russ Weight <russell.h.weight@intel.com>
>> +Description:	Write only. Write the filename of a self-describing  image
>> +		file to this sysfs file to initiate an image update. The
>> +		write will return immediately, and the image update will
>> +		proceed in the background.
>> diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c index
>> b85bc47c91a9..5d4449c82af5 100644
>> --- a/drivers/fpga/fpga-mgr.c
>> +++ b/drivers/fpga/fpga-mgr.c
>> @@ -8,6 +8,7 @@
>>    * With code from the mailing list:
>>    * Copyright (C) 2013 Xilinx, Inc.
>>    */
>> +#include <linux/device.h>
>>   #include <linux/firmware.h>
>>   #include <linux/fpga/fpga-mgr.h>
>>   #include <linux/idr.h>
>> @@ -446,7 +447,166 @@ static struct attribute *fpga_mgr_attrs[] = {
>>   	&dev_attr_status.attr,
>>   	NULL,
>>   };
>> -ATTRIBUTE_GROUPS(fpga_mgr);
>> +
>> +static const struct attribute_group fpga_mgr_group = {
>> +	.attrs = fpga_mgr_attrs,
>> +};
>> +
>> +#define WRITE_BLOCK_SIZE 0x4000	/* Update remaining_size every 0x4000 bytes */
>> +
>> +static void fpga_async_dev_error(struct fpga_manager *mgr,
>> +				 enum fpga_async_err err_code)
>> +{
>> +	mgr->async_update.err_code = err_code;
>> +	mgr->mops->async_cancel(mgr);
>> +}
>> +
>> +static void progress_complete(struct fpga_manager *mgr) {
>> +	struct fpga_async_update *update = &mgr->async_update;
>> +
>> +	mutex_lock(&update->lock);
>> +	update->progress = FPGA_ASYNC_PROG_IDLE;
>> +	complete_all(&update->done);
>> +	mutex_unlock(&update->lock);
>> +}
>> +
>> +static void fpga_mgr_async_update(struct work_struct *work) {
>> +	struct fpga_async_update *update;
>> +	u32 size, blk_size, offset = 0;
>> +	struct fpga_manager *mgr;
>> +	const struct firmware *fw;
>> +	enum fpga_async_err ret;
>> +
>> +	update = container_of(work, struct fpga_async_update, work);
>> +	mgr = container_of(update, struct fpga_manager, async_update);
>> +
>> +	get_device(&mgr->dev);
>> +	if (request_firmware(&fw, update->filename, &mgr->dev)) {
>> +		update->err_code = FPGA_ASYNC_ERR_FILE_READ;
>> +		goto idle_exit;
>> +	}
>> +
>> +	update->data = fw->data;
>> +	update->remaining_size = fw->size;
>> +
>> +	if (!try_module_get(mgr->dev.parent->driver->owner)) {
>> +		update->err_code = FPGA_ASYNC_ERR_BUSY;
>> +		goto release_fw_exit;
>> +	}
>> +
>> +	update->progress = FPGA_ASYNC_PROG_PREPARING;
>> +	ret = mgr->mops->async_write_init(mgr, fw->size);
>> +	if (ret != FPGA_ASYNC_ERR_NONE) {
>> +		fpga_async_dev_error(mgr, ret);
>> +		goto modput_exit;
>> +	}
>> +
>> +	update->progress = FPGA_ASYNC_PROG_WRITING;
>> +	size = update->remaining_size;
>> +	while (size) {
>> +		blk_size = min_t(u32, size, WRITE_BLOCK_SIZE);
>> +		size -= blk_size;
>> +		ret = mgr->mops->async_write_blk(mgr, mgr->async_update.data,
>> +						 offset, blk_size);

It is not good idea to set 0x400 bytes here, the size of data chunk 
should be decided by low-level driver.

The actual hardware device or firmware may be able to handle data chunk 
which is larger than 0x400 bytes in one transaction. So it is good for 
FPGA manager to pass the data to low-level driver and leave the decision 
to low-level driver.

Regards,
Richard

>> +		if (ret != FPGA_ASYNC_ERR_NONE) {
>> +			fpga_async_dev_error(mgr, ret);
>> +			goto done;
>> +		}
>> +
>> +		update->remaining_size = size;
>> +		offset += blk_size;
>> +	}
>> +
>> +	update->progress = FPGA_ASYNC_PROG_PROGRAMMING;
>> +	ret = mgr->mops->async_write_complete(mgr);
>> +	if (ret != FPGA_ASYNC_ERR_NONE)
>> +		fpga_async_dev_error(mgr, ret);
>> +
>> +done:
>> +	if (mgr->mops->async_cleanup)
>> +		mgr->mops->async_cleanup(mgr);
>> +
>> +modput_exit:
>> +	module_put(mgr->dev.parent->driver->owner);
>> +
>> +release_fw_exit:
>> +	update->data = NULL;
>> +	release_firmware(fw);
>> +
>> +idle_exit:
>> +	/*
>> +	 * Note: update->remaining_size is left unmodified here to
>> +	 * provide additional information on errors. It will be
>> +	 * reinitialized when the next async update begins.
>> +	 */
>> +	kfree(update->filename);
>> +	update->filename = NULL;
>> +	put_device(&mgr->dev);
>> +	progress_complete(mgr);
>> +}
>> +
>> +static ssize_t filename_store(struct device *dev, struct device_attribute *attr,
>> +			      const char *buf, size_t count) {
>> +	struct fpga_manager *mgr = to_fpga_manager(dev);
>> +	struct fpga_async_update *update = &mgr->async_update;
>> +	int ret = count;
>> +
>> +	if (count == 0 || count >= PATH_MAX)
>> +		return -EINVAL;
>> +
>> +	mutex_lock(&update->lock);
>> +	if (update->driver_unload || update->progress != FPGA_ASYNC_PROG_IDLE) {
>> +		ret = -EBUSY;
>> +		goto unlock_exit;
>> +	}
>> +
>> +	update->filename = kmemdup_nul(buf, count, GFP_KERNEL);
>> +	if (!update->filename) {
>> +		ret = -ENOMEM;
>> +		goto unlock_exit;
>> +	}
>> +
>> +	update->err_code = FPGA_ASYNC_ERR_NONE;
>> +	update->progress = FPGA_ASYNC_PROG_READING;
>> +	reinit_completion(&update->done);
>> +	schedule_work(&update->work);
>> +
>> +unlock_exit:
>> +	mutex_unlock(&update->lock);
>> +	return ret;
>> +}
>> +static DEVICE_ATTR_WO(filename);
>> +
>> +static umode_t
>> +fpga_async_update_visible(struct kobject *kobj, struct attribute
>> +*attr, int n) {
>> +	struct fpga_manager *mgr = to_fpga_manager(kobj_to_dev(kobj));
>> +
>> +	if (!mgr->mops->async_write_init)
>> +		return 0;
>> +
>> +	return attr->mode;
>> +}
>> +
>> +static struct attribute *fpga_mgr_async_attrs[] = {
>> +	&dev_attr_filename.attr,
>> +	NULL,
>> +};
>> +
>> +static struct attribute_group fpga_mgr_async_group = {
>> +	.name = "async_update",
>> +	.attrs = fpga_mgr_async_attrs,
>> +	.is_visible = fpga_async_update_visible, };
>> +
>> +static const struct attribute_group *fpga_mgr_groups[] = {
>> +	&fpga_mgr_group,
>> +	&fpga_mgr_async_group,
>> +	NULL,
>> +};
>>   
>>   static struct fpga_manager *__fpga_mgr_get(struct device *dev)  { @@
>> -575,6 +735,15 @@ struct fpga_manager *fpga_mgr_create(struct device *dev, const char *name,
>>   		return NULL;
>>   	}
>>   
>> +	if (mops->async_write_init || mops->async_write_blk ||
>> +	    mops->async_write_complete || mops->async_cancel ||
>> +	    mops->async_cleanup) {
>> +		if (!mops->async_write_init || !mops->async_write_blk ||
>> +		    !mops->async_write_complete || !mops->async_cancel)
>> +			dev_err(dev, "Attempt to register incomplete async ops\n");
>> +			return NULL;
>> +	}
>> +
>>   	if (!name || !strlen(name)) {
>>   		dev_err(dev, "Attempt to register with no name!\n");
>>   		return NULL;
>> @@ -594,6 +763,12 @@ struct fpga_manager *fpga_mgr_create(struct device *dev, const char *name,
>>   	mgr->mops = mops;
>>   	mgr->priv = priv;
>>   
>> +	mgr->async_update.driver_unload = false;
>> +	mgr->async_update.progress = FPGA_ASYNC_PROG_IDLE;
>> +	mutex_init(&mgr->async_update.lock);
>> +	init_completion(&mgr->async_update.done);
>> +	INIT_WORK(&mgr->async_update.work, fpga_mgr_async_update);
>> +
>>   	device_initialize(&mgr->dev);
>>   	mgr->dev.class = fpga_mgr_class;
>>   	mgr->dev.groups = mops->groups;
>> @@ -710,11 +885,33 @@ EXPORT_SYMBOL_GPL(fpga_mgr_register);
>>    * @mgr: fpga manager struct
>>    *
>>    * This function is intended for use in a FPGA manager driver's remove function.
>> + *
>> + * For some devices, once an aysynchronous update has begun the
>> + authentication
>> + * phase, the hardware cannot be signaled to stop, and the driver
>> + will not exit
>> + * until the hardware signals completion.  This could be 30+ minutes of waiting.
>> + * The driver_unload flag enables a force-unload of the driver (e.g.
>> + modprobe -r)
>> + * by signaling the parent driver to exit even if the hardware update is incomplete.
>> + * The driver_unload flag also prevents new updates from starting
>> + once the
>> + * unregister process has begun.
>>    */
>>   void fpga_mgr_unregister(struct fpga_manager *mgr)  {
>> +	struct fpga_async_update *update = &mgr->async_update;
>> +
>>   	dev_info(&mgr->dev, "%s %s\n", __func__, mgr->name);
>>   
>> +	mutex_lock(&update->lock);
>> +	update->driver_unload = true;
>> +	if (update->progress == FPGA_ASYNC_PROG_IDLE) {
>> +		mutex_unlock(&update->lock);
>> +		goto unregister;
>> +	}
>> +
>> +	mutex_unlock(&update->lock);
>> +	wait_for_completion(&update->done);
>> +
>> +unregister:
>> +
>>   	/*
>>   	 * If the low level driver provides a method for putting fpga into
>>   	 * a desired state upon unregister, do it.
>> diff --git a/include/linux/fpga/fpga-mgr.h
>> b/include/linux/fpga/fpga-mgr.h index 2bc3030a69e5..9ff6c55f7a43
>> 100644
>> --- a/include/linux/fpga/fpga-mgr.h
>> +++ b/include/linux/fpga/fpga-mgr.h
>> @@ -9,6 +9,7 @@
>>   #define _LINUX_FPGA_MGR_H
>>   
>>   #include <linux/mutex.h>
>> +#include <linux/completion.h>
>>   #include <linux/platform_device.h>
>>   
>>   struct fpga_manager;
>> @@ -74,6 +75,30 @@ enum fpga_mgr_states {
>>   #define FPGA_MGR_BITSTREAM_LSB_FIRST	BIT(3)
>>   #define FPGA_MGR_COMPRESSED_BITSTREAM	BIT(4)
>>   
>> +/* Asynchronous update error codes */ enum fpga_async_err {
>> +	FPGA_ASYNC_ERR_NONE,
>> +	FPGA_ASYNC_ERR_HW_ERROR,
>> +	FPGA_ASYNC_ERR_TIMEOUT,
>> +	FPGA_ASYNC_ERR_CANCELED,
>> +	FPGA_ASYNC_ERR_BUSY,
>> +	FPGA_ASYNC_ERR_INVALID_SIZE,
>> +	FPGA_ASYNC_ERR_RW_ERROR,
>> +	FPGA_ASYNC_ERR_WEAROUT,
>> +	FPGA_ASYNC_ERR_FILE_READ,
>> +	FPGA_ASYNC_ERR_MAX
>> +};
>> +
>> +/* Asynchronous update progress codes */ enum fpga_async_prog {
>> +	FPGA_ASYNC_PROG_IDLE,
>> +	FPGA_ASYNC_PROG_READING,
>> +	FPGA_ASYNC_PROG_PREPARING,
>> +	FPGA_ASYNC_PROG_WRITING,
>> +	FPGA_ASYNC_PROG_PROGRAMMING,
>> +	FPGA_ASYNC_PROG_MAX
>> +};
>> +
>>   /**
>>    * struct fpga_image_info - information specific to a FPGA image
>>    * @flags: boolean flags as defined above @@ -133,6 +158,16 @@ struct
>> fpga_manager_ops {
>>   	int (*write_complete)(struct fpga_manager *mgr,
>>   			      struct fpga_image_info *info);
>>   	void (*fpga_remove)(struct fpga_manager *mgr);
>> +
>> +	/* async update ops */
>> +	enum fpga_async_err (*async_write_init)(struct fpga_manager *mgr,
>> +			     size_t count);
>> +	enum fpga_async_err (*async_write_blk)(struct fpga_manager *mgr,
>> +			     const char *buf, u32 offset, size_t count);
>> +	enum fpga_async_err (*async_write_complete)(struct fpga_manager *mgr);
>> +	enum fpga_async_err (*async_cancel)(struct fpga_manager *mgr);
>> +	void (*async_cleanup)(struct fpga_manager *mgr);
>> +
>>   	const struct attribute_group **groups;  };
>>   
>> @@ -154,6 +189,22 @@ struct fpga_compat_id {
>>   	u64 id_l;
>>   };
>>   
>> +/**
>> + * struct fpga_async_update - asynchronous image update structure
>> + * @name: name of low level fpga manager  */ struct fpga_async_update
>> +{
>> +	char *filename;
>> +	const u8 *data;			/* pointer to update data */
>> +	u32 remaining_size;		/* size remaining to transfer */
>> +	struct work_struct work;
>> +	struct completion done;
>> +	enum fpga_async_prog progress;
>> +	enum fpga_async_err err_code;	/* async update error code */
>> +	bool driver_unload;
>> +	struct mutex lock;		/* protect data structure contents */
>> +};
>> +
>>   /**
>>    * struct fpga_manager - fpga manager structure
>>    * @name: name of low level fpga manager @@ -171,6 +222,7 @@ struct
>> fpga_manager {
>>   	enum fpga_mgr_states state;
>>   	struct fpga_compat_id *compat_id;
>>   	const struct fpga_manager_ops *mops;
>> +	struct fpga_async_update async_update;
>>   	void *priv;
>>   };
>>   
> 
