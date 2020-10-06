Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82D442851F2
	for <lists+linux-fpga@lfdr.de>; Tue,  6 Oct 2020 20:55:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbgJFSzh (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 6 Oct 2020 14:55:37 -0400
Received: from mga11.intel.com ([192.55.52.93]:23521 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726943AbgJFSzg (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 6 Oct 2020 14:55:36 -0400
IronPort-SDR: RwCfiDxaYUeWlto1ZxHtIqEY65pFk3olQAZ3ZjumzpJUR6tcpa/cJVauZ1932zSSrCvCfJqEoD
 XsVc3RDz5Msg==
X-IronPort-AV: E=McAfee;i="6000,8403,9765"; a="161241927"
X-IronPort-AV: E=Sophos;i="5.77,343,1596524400"; 
   d="scan'208";a="161241927"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2020 11:55:21 -0700
IronPort-SDR: jUxJndrJ08uq3vPskGLQ3dlHo22PvV8aod0lMCcUup330mgJbPpz8AioCqwv7Q+VzbBMayTSML
 SUutWrBy8gbw==
X-IronPort-AV: E=Sophos;i="5.77,343,1596524400"; 
   d="scan'208";a="460935930"
Received: from rhweight-mobl2.amr.corp.intel.com (HELO [10.0.2.15]) ([10.212.2.223])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2020 11:55:17 -0700
Subject: Re: [PATCH v2 2/7] fpga: sec-mgr: enable secure updates
To:     "Wu, Hao" <hao.wu@intel.com>, "mdf@kernel.org" <mdf@kernel.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "trix@redhat.com" <trix@redhat.com>,
        "lgoncalv@redhat.com" <lgoncalv@redhat.com>,
        "Xu, Yilun" <yilun.xu@intel.com>,
        "Gerlach, Matthew" <matthew.gerlach@intel.com>
References: <20201002223701.1317-1-russell.h.weight@intel.com>
 <20201002223701.1317-3-russell.h.weight@intel.com>
 <DM6PR11MB38195987C3B51752D4912577850C0@DM6PR11MB3819.namprd11.prod.outlook.com>
From:   Russ Weight <russell.h.weight@intel.com>
Message-ID: <8b6653e7-385f-d134-9146-1b134c393da0@intel.com>
Date:   Tue, 6 Oct 2020 11:55:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <DM6PR11MB38195987C3B51752D4912577850C0@DM6PR11MB3819.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



On 10/5/20 1:19 AM, Wu, Hao wrote:
>> -----Original Message-----
>> From: Russ Weight <russell.h.weight@intel.com>
>> Sent: Saturday, October 3, 2020 6:37 AM
>> To: mdf@kernel.org; linux-fpga@vger.kernel.org; linux-
>> kernel@vger.kernel.org
>> Cc: trix@redhat.com; lgoncalv@redhat.com; Xu, Yilun <yilun.xu@intel.com>;
>> Wu, Hao <hao.wu@intel.com>; Gerlach, Matthew
>> <matthew.gerlach@intel.com>; Weight, Russell H
>> <russell.h.weight@intel.com>
>> Subject: [PATCH v2 2/7] fpga: sec-mgr: enable secure updates
>>
>> Extend the FPGA Intel Security Manager class driver to
>> include an update/filename sysfs node that can be used
>> to initiate a security update.  The filename of a secure
>> update file (BMC image, FPGA image, Root Entry Hash image,
>> or Code Signing Key cancellation image) can be written to
>> this sysfs entry to cause a secure update to occur.
>>
>> The write of the filename will return immediately, and the
>> update will begin in the context of a kernel worker thread.
>> This tool utilizes the request_firmware framework, which
>> requires that the image file reside under /lib/firmware.
>>
>> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
>> ---
>> v2:
>>   - Bumped documentation date and version
>>   - Removed explicit value assignments in enums
>>   - Other minor code cleanup per review comments
>> ---
>>  .../ABI/testing/sysfs-class-ifpga-sec-mgr     |  13 ++
>>  drivers/fpga/ifpga-sec-mgr.c                  | 157 ++++++++++++++++++
>>  include/linux/fpga/ifpga-sec-mgr.h            |  49 ++++++
>>  3 files changed, 219 insertions(+)
>>
>> diff --git a/Documentation/ABI/testing/sysfs-class-ifpga-sec-mgr
>> b/Documentation/ABI/testing/sysfs-class-ifpga-sec-mgr
>> index 707958971bcb..4f375f132c34 100644
>> --- a/Documentation/ABI/testing/sysfs-class-ifpga-sec-mgr
>> +++ b/Documentation/ABI/testing/sysfs-class-ifpga-sec-mgr
>> @@ -65,3 +65,16 @@ Contact:Russ Weight <russell.h.weight@intel.com>
>>  Description:Read only. Returns number of times the user image for the
>>  static region has been flashed.
>>  Format: "%u".
>> +
>> +What:
>> /sys/class/ifpga_sec_mgr/ifpga_secX/update/filename
>> +Date:Oct 2020
>> +KernelVersion:  5.11
>> +Contact:Russ Weight <russell.h.weight@intel.com>
>> +Description:Write only. Write the filename of an Intel image
>> +file to this sysfs file to initiate a secure
>> +update. The file must have an appropriate header
>> +which, among other things, identifies the target
>> +for the update. This mechanism is used to update
>> +BMC images, BMC firmware, Static Region images,
>> +and Root Entry Hashes, and to cancel Code Signing
>> +Keys (CSK).
>> diff --git a/drivers/fpga/ifpga-sec-mgr.c b/drivers/fpga/ifpga-sec-mgr.c
>> index f1caa4602ab3..7d5a4979554b 100644
>> --- a/drivers/fpga/ifpga-sec-mgr.c
>> +++ b/drivers/fpga/ifpga-sec-mgr.c
>> @@ -5,8 +5,11 @@
>>   * Copyright (C) 2019-2020 Intel Corporation, Inc.
>>   */
>>
>> +#include <linux/delay.h>
>> +#include <linux/firmware.h>
>>  #include <linux/fpga/ifpga-sec-mgr.h>
>>  #include <linux/idr.h>
>> +#include <linux/kernel.h>
>>  #include <linux/module.h>
>>  #include <linux/slab.h>
>>  #include <linux/vmalloc.h>
>> @@ -14,6 +17,8 @@
>>  static DEFINE_IDA(ifpga_sec_mgr_ida);
>>  static struct class *ifpga_sec_mgr_class;
>>
>> +#define WRITE_BLOCK_SIZE0x4000
> Maybe some comments here for this value or should this be a parameter
> of ifpga sec mgr, provided from low level driver during initialization?
I'll add a comment. The only purpose of WRITE_BLOCK_SIZE is to ensure
that the remaining_size gets updated at regular intervals to show progress
during the writing phase.
>
>> +
>>  #define to_sec_mgr(d) container_of(d, struct ifpga_sec_mgr, dev)
>>
>>  static ssize_t
>> @@ -134,6 +139,96 @@ static struct attribute *sec_mgr_security_attrs[] = {
>>  NULL,
>>  };
>>
>> +static void ifpga_sec_dev_error(struct ifpga_sec_mgr *imgr,
>> +enum ifpga_sec_err err_code)
>> +{
>> +imgr->err_code = err_code;
>> +imgr->iops->cancel(imgr);
>> +}
>> +
>> +static void progress_complete(struct ifpga_sec_mgr *imgr)
>> +{
>> +mutex_lock(&imgr->lock);
>> +imgr->progress = IFPGA_SEC_PROG_IDLE;
>> +complete_all(&imgr->update_done);
>> +mutex_unlock(&imgr->lock);
>> +}
>> +
>> +static void ifpga_sec_mgr_update(struct work_struct *work)
>> +{
>> +u32 size, blk_size, offset = 0;
>> +struct ifpga_sec_mgr *imgr;
>> +const struct firmware *fw;
>> +enum ifpga_sec_err ret;
>> +
>> +imgr = container_of(work, struct ifpga_sec_mgr, work);
>> +
>> +get_device(&imgr->dev);
>> +if (request_firmware(&fw, imgr->filename, &imgr->dev)) {
>> +imgr->err_code = IFPGA_SEC_ERR_FILE_READ;
>> +goto idle_exit;
>> +}
>> +
>> +imgr->data = fw->data;
>> +imgr->remaining_size = fw->size;
>> +
>> +if (!try_module_get(imgr->dev.parent->driver->owner)) {
>> +imgr->err_code = IFPGA_SEC_ERR_BUSY;
>> +goto release_fw_exit;
>> +}
>> +
>> +imgr->progress = IFPGA_SEC_PROG_PREPARING;
>> +ret = imgr->iops->prepare(imgr);
>> +if (ret) {
>> +ifpga_sec_dev_error(imgr, ret);
>> +goto modput_exit;
>> +}
>> +
>> +imgr->progress = IFPGA_SEC_PROG_WRITING;
>> +size = imgr->remaining_size;
>> +while (size) {
>> +blk_size = min_t(u32, size, WRITE_BLOCK_SIZE);
>> +size -= blk_size;
>> +ret = imgr->iops->write_blk(imgr, offset, blk_size);
>> +if (ret) {
>> +ifpga_sec_dev_error(imgr, ret);
>> +goto done;
>> +}
>> +
>> +imgr->remaining_size = size;
>> +offset += blk_size;
>> +}
> Looks like we can remove size and just use remaining_size here?
We could, but it would change the meaning of remaining size a little bit.
Currently, remaining size represents the number bytes that are confirmed
to be written to the flash. If we eliminate size, then we would be updating
remaining_size before the next block of bytes are written.

What do you think? Is it worth making a change here?
>
>> +
>> +imgr->progress = IFPGA_SEC_PROG_PROGRAMMING;
>> +ret = imgr->iops->poll_complete(imgr);
>> +if (ret) {
>> +ifpga_sec_dev_error(imgr, ret);
>> +goto done;
> Looks like no need for this goto done.
Yes - I'll remove it.
>
>> +}
>> +
>> +done:
>> +if (imgr->iops->cleanup)
>> +imgr->iops->cleanup(imgr);
>> +
>> +modput_exit:
>> +module_put(imgr->dev.parent->driver->owner);
>> +
>> +release_fw_exit:
>> +imgr->data = NULL;
>> +release_firmware(fw);
>> +
>> +idle_exit:
>> +/*
>> + * Note: imgr->remaining_size is left unmodified here to
>> + * provide additional information on errors. It will be
>> + * reinitialized when the next secure update begins.
>> + */
>> +kfree(imgr->filename);
>> +imgr->filename = NULL;
>> +put_device(&imgr->dev);
>> +progress_complete(imgr);
> Should it call this function progress complete even in failure case?
> A little confusing.
Yes - this function returns us to the idle state and signals a completion
structure for waiting threads. Do you think a name change is needed? Any
suggestions? progress_done?
>
>> +}
>> +
>>  #define check_attr(attribute, _name) \
>>  ((attribute) == &dev_attr_##_name.attr && imgr->iops->_name)
>>
>> @@ -164,6 +259,48 @@ static struct attribute_group
>> sec_mgr_security_attr_group = {
>>  .is_visible = sec_mgr_visible,
>>  };
>>
>> +static ssize_t filename_store(struct device *dev, struct device_attribute *attr,
>> +      const char *buf, size_t count)
>> +{
>> +struct ifpga_sec_mgr *imgr = to_sec_mgr(dev);
>> +int ret = count;
>> +
>> +if (count == 0 || count >= PATH_MAX)
>> +return -EINVAL;
>> +
>> +mutex_lock(&imgr->lock);
>> +if (imgr->driver_unload || imgr->progress != IFPGA_SEC_PROG_IDLE)
>> {
>> +ret = -EBUSY;
>> +goto unlock_exit;
>> +}
>> +
>> +imgr->filename = kstrndup(buf, count - 1, GFP_KERNEL);
>> +if (!imgr->filename) {
>> +ret = -ENOMEM;
>> +goto unlock_exit;
>> +}
>> +
>> +imgr->err_code = IFPGA_SEC_ERR_NONE;
>> +imgr->progress = IFPGA_SEC_PROG_READING;
>> +reinit_completion(&imgr->update_done);
>> +schedule_work(&imgr->work);
>> +
>> +unlock_exit:
>> +mutex_unlock(&imgr->lock);
>> +return ret;
>> +}
>> +static DEVICE_ATTR_WO(filename);
>> +
>> +static struct attribute *sec_mgr_update_attrs[] = {
>> +&dev_attr_filename.attr,
>> +NULL,
>> +};
>> +
>> +static struct attribute_group sec_mgr_update_attr_group = {
>> +.name = "update",
>> +.attrs = sec_mgr_update_attrs,
>> +};
>> +
>>  static ssize_t name_show(struct device *dev,
>>   struct device_attribute *attr, char *buf)
>>  {
>> @@ -185,6 +322,7 @@ static struct attribute_group sec_mgr_attr_group = {
>>  static const struct attribute_group *ifpga_sec_mgr_attr_groups[] = {
>>  &sec_mgr_attr_group,
>>  &sec_mgr_security_attr_group,
>> +&sec_mgr_update_attr_group,
>>  NULL,
>>  };
>>
>> @@ -245,6 +383,12 @@ ifpga_sec_mgr_create(struct device *dev, const char
>> *name,
>>  struct ifpga_sec_mgr *imgr;
>>  int id, ret;
>>
>> +if (!iops || !iops->cancel || !iops->prepare ||
>> +    !iops->write_blk || !iops->poll_complete) {
>> +dev_err(dev, "Attempt to register without required ops\n");
>> +return NULL;
>> +}
>> +
>>  if (!check_reh_handler(dev, iops, bmc) ||
>>      !check_reh_handler(dev, iops, sr) ||
>>      !check_reh_handler(dev, iops, pr) ||
>> @@ -272,6 +416,8 @@ ifpga_sec_mgr_create(struct device *dev, const char
>> *name,
>>  imgr->name = name;
>>  imgr->priv = priv;
>>  imgr->iops = iops;
>> +init_completion(&imgr->update_done);
>> +INIT_WORK(&imgr->work, ifpga_sec_mgr_update);
>>
>>  device_initialize(&imgr->dev);
>>  imgr->dev.class = ifpga_sec_mgr_class;
>> @@ -397,6 +543,17 @@ void ifpga_sec_mgr_unregister(struct ifpga_sec_mgr
>> *imgr)
>>  {
>>  dev_info(&imgr->dev, "%s %s\n", __func__, imgr->name);
>>
>> +mutex_lock(&imgr->lock);
>> +imgr->driver_unload = true;
> May need some comments here, do you mean get module doesn't work here
> to prevent unexpected driver unloading? Or you mean parent device maybe
> hot unplug in some cases?
The driver_unload flag is used to:
(1) prevent another update from startingwhile waiting to unregister
(2) signal the parent driver that the driver is being unloaded/unbound.

Generally, the driver cannot be interrupted (CTRL-C) once the authentication
begins, which can take 30+ minutes to complete. The driver_unload flag signals
the parent driver to abort if someone is trying to unload/unbind the driver.

Without this flag, "modprobe -r" could hang for 30 minutes or more.

Does this seem like a reasonable way to handle it?

I'll add comments to this function.
>
> Thanks
> Hao
>
>> +if (imgr->progress == IFPGA_SEC_PROG_IDLE) {
>> +mutex_unlock(&imgr->lock);
>> +goto unregister;
>> +}
>> +
>> +mutex_unlock(&imgr->lock);
>> +wait_for_completion(&imgr->update_done);
>> +
>> +unregister:
>>  device_unregister(&imgr->dev);
>>  }
>>  EXPORT_SYMBOL_GPL(ifpga_sec_mgr_unregister);
>> diff --git a/include/linux/fpga/ifpga-sec-mgr.h b/include/linux/fpga/ifpga-
>> sec-mgr.h
>> index ded62090e9b9..27008abd8e75 100644
>> --- a/include/linux/fpga/ifpga-sec-mgr.h
>> +++ b/include/linux/fpga/ifpga-sec-mgr.h
>> @@ -7,12 +7,26 @@
>>  #ifndef _LINUX_IFPGA_SEC_MGR_H
>>  #define _LINUX_IFPGA_SEC_MGR_H
>>
>> +#include <linux/completion.h>
>>  #include <linux/device.h>
>>  #include <linux/mutex.h>
>>  #include <linux/types.h>
>>
>>  struct ifpga_sec_mgr;
>>
>> +enum ifpga_sec_err {
>> +IFPGA_SEC_ERR_NONE,
>> +IFPGA_SEC_ERR_HW_ERROR,
>> +IFPGA_SEC_ERR_TIMEOUT,
>> +IFPGA_SEC_ERR_CANCELED,
>> +IFPGA_SEC_ERR_BUSY,
>> +IFPGA_SEC_ERR_INVALID_SIZE,
>> +IFPGA_SEC_ERR_RW_ERROR,
>> +IFPGA_SEC_ERR_WEAROUT,
>> +IFPGA_SEC_ERR_FILE_READ,
>> +IFPGA_SEC_ERR_MAX
>> +};
>> +
>>  /**
>>   * struct ifpga_sec_mgr_ops - device specific operations
>>   * @user_flash_count:    Optional: Return sysfs string output for FPGA
>> @@ -35,6 +49,17 @@ struct ifpga_sec_mgr;
>>   * @bmc_reh_size:    Optional: Return byte size for BMC root entry hash
>>   * @sr_reh_size:    Optional: Return byte size for SR root entry hash
>>   * @pr_reh_size:    Optional: Return byte size for PR root entry hash
>> + * @prepare:    Required: Prepare secure update
>> + * @write_blk:    Required: Write a block of data
>> + * @poll_complete:    Required: Check for the completion of the
>> + *    HW authentication/programming process. This
>> + *    function should check for imgr->driver_unload
>> + *    and abort with IFPGA_SEC_ERR_CANCELED when
>> true.
>> + * @cancel:    Required: Signal HW to cancel update
>> + * @cleanup:    Optional: Complements the prepare()
>> + *    function and is called at the completion
>> + *    of the update, whether success or failure,
>> + *    if the prepare function succeeded.
>>   */
>>  struct ifpga_sec_mgr_ops {
>>  int (*user_flash_count)(struct ifpga_sec_mgr *imgr);
>> @@ -56,6 +81,22 @@ struct ifpga_sec_mgr_ops {
>>  int (*bmc_canceled_csk_nbits)(struct ifpga_sec_mgr *imgr);
>>  int (*sr_canceled_csk_nbits)(struct ifpga_sec_mgr *imgr);
>>  int (*pr_canceled_csk_nbits)(struct ifpga_sec_mgr *imgr);
>> +enum ifpga_sec_err (*prepare)(struct ifpga_sec_mgr *imgr);
>> +enum ifpga_sec_err (*write_blk)(struct ifpga_sec_mgr *imgr,
>> +u32 offset, u32 size);
>> +enum ifpga_sec_err (*poll_complete)(struct ifpga_sec_mgr *imgr);
>> +void (*cleanup)(struct ifpga_sec_mgr *imgr);
>> +enum ifpga_sec_err (*cancel)(struct ifpga_sec_mgr *imgr);
>> +};
>> +
>> +/* Update progress codes */
>> +enum ifpga_sec_prog {
>> +IFPGA_SEC_PROG_IDLE,
>> +IFPGA_SEC_PROG_READING,
>> +IFPGA_SEC_PROG_PREPARING,
>> +IFPGA_SEC_PROG_WRITING,
>> +IFPGA_SEC_PROG_PROGRAMMING,
>> +IFPGA_SEC_PROG_MAX
>>  };
>>
>>  struct ifpga_sec_mgr {
>> @@ -63,6 +104,14 @@ struct ifpga_sec_mgr {
>>  struct device dev;
>>  const struct ifpga_sec_mgr_ops *iops;
>>  struct mutex lock;/* protect data structure contents */
>> +struct work_struct work;
>> +struct completion update_done;
>> +char *filename;
>> +const u8 *data;/* pointer to update data */
>> +u32 remaining_size;/* size remaining to transfer */
>> +enum ifpga_sec_prog progress;
>> +enum ifpga_sec_err err_code;/* security manager error code */
>> +bool driver_unload;
>>  void *priv;
>>  };
>>
>> --
>> 2.17.1

