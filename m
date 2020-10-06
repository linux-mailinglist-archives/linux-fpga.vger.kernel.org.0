Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F16A62852A2
	for <lists+linux-fpga@lfdr.de>; Tue,  6 Oct 2020 21:46:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726073AbgJFTqX (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 6 Oct 2020 15:46:23 -0400
Received: from mga11.intel.com ([192.55.52.93]:31832 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725943AbgJFTqX (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 6 Oct 2020 15:46:23 -0400
IronPort-SDR: It7d7Bysmc78BMF06I4VxWuz4Wu0W+8PsxyhGt/D17vGmIbUNeHuEwZxvIaKjSixOntke2yY3c
 awbI09gHMUCg==
X-IronPort-AV: E=McAfee;i="6000,8403,9766"; a="161265745"
X-IronPort-AV: E=Sophos;i="5.77,343,1596524400"; 
   d="scan'208";a="161265745"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2020 12:46:18 -0700
IronPort-SDR: /tUAKzQGwEZhCztATXCidW/jYmxRoaCsb0hLkIMivOsZ/syrZ/TAXVBbRT2oxF7C9zKVFGZse2
 4vSXgkntEgXQ==
X-IronPort-AV: E=Sophos;i="5.77,343,1596524400"; 
   d="scan'208";a="460958848"
Received: from rhweight-mobl2.amr.corp.intel.com (HELO [10.0.2.15]) ([10.212.2.223])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2020 12:46:16 -0700
Subject: Re: [PATCH v2 3/7] fpga: sec-mgr: expose sec-mgr update status
To:     "Wu, Hao" <hao.wu@intel.com>, "mdf@kernel.org" <mdf@kernel.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "trix@redhat.com" <trix@redhat.com>,
        "lgoncalv@redhat.com" <lgoncalv@redhat.com>,
        "Xu, Yilun" <yilun.xu@intel.com>,
        "Gerlach, Matthew" <matthew.gerlach@intel.com>
References: <20201002223701.1317-1-russell.h.weight@intel.com>
 <20201002223701.1317-4-russell.h.weight@intel.com>
 <DM6PR11MB3819276C0C4F12E3CEF33F3E850C0@DM6PR11MB3819.namprd11.prod.outlook.com>
From:   Russ Weight <russell.h.weight@intel.com>
Message-ID: <0a7c51ea-a905-eaf6-0915-10d93423b5d7@intel.com>
Date:   Tue, 6 Oct 2020 12:46:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <DM6PR11MB3819276C0C4F12E3CEF33F3E850C0@DM6PR11MB3819.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



On 10/5/20 1:41 AM, Wu, Hao wrote:
>> Subject: [PATCH v2 3/7] fpga: sec-mgr: expose sec-mgr update status
>>
>> Extend the Intel Security Manager class driver to
>> include an update/status sysfs node that can be polled
>> and read to monitor the progress of an ongoing secure
>> update. Sysfs_notify() is used to signal transitions
>> between different phases of the update process.
>>
>> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
>> ---
>> v2:
>>   - Bumped documentation date and version
>>   - Changed progress state "read_file" to "reading"
>> ---
>>  .../ABI/testing/sysfs-class-ifpga-sec-mgr     | 11 +++++
>>  drivers/fpga/ifpga-sec-mgr.c                  | 40 +++++++++++++++++--
>>  2 files changed, 47 insertions(+), 4 deletions(-)
>>
>> diff --git a/Documentation/ABI/testing/sysfs-class-ifpga-sec-mgr
>> b/Documentation/ABI/testing/sysfs-class-ifpga-sec-mgr
>> index 4f375f132c34..73a5246fea1b 100644
>> --- a/Documentation/ABI/testing/sysfs-class-ifpga-sec-mgr
>> +++ b/Documentation/ABI/testing/sysfs-class-ifpga-sec-mgr
>> @@ -78,3 +78,14 @@ Description:Write only. Write the filename of an
>> Intel image
>>  BMC images, BMC firmware, Static Region images,
>>  and Root Entry Hashes, and to cancel Code Signing
>>  Keys (CSK).
>> +
>> +What: /sys/class/ifpga_sec_mgr/ifpga_secX/update/status
>> +Date:Oct 2020
>> +KernelVersion:  5.11
>> +Contact:Russ Weight <russell.h.weight@intel.com>
>> +Description:Read-only. Returns a string describing the current
>> +status of an update. The string will be one of the
>> +following: idle, reading, preparing, writing,
>> +programming. Userspace code can poll on this file,
>> +as it will be signaled by sysfs_notify() on each
>> +state change.
>> diff --git a/drivers/fpga/ifpga-sec-mgr.c b/drivers/fpga/ifpga-sec-mgr.c
>> index 7d5a4979554b..ad918fb42dc2 100644
>> --- a/drivers/fpga/ifpga-sec-mgr.c
>> +++ b/drivers/fpga/ifpga-sec-mgr.c
>> @@ -139,6 +139,13 @@ static struct attribute *sec_mgr_security_attrs[] = {
>>  NULL,
>>  };
>>
>> +static void update_progress(struct ifpga_sec_mgr *imgr,
>> +    enum ifpga_sec_prog new_progress)
>> +{
>> +imgr->progress = new_progress;
>> +sysfs_notify(&imgr->dev.kobj, "update", "status");
>> +}
>> +
>>  static void ifpga_sec_dev_error(struct ifpga_sec_mgr *imgr,
>>  enum ifpga_sec_err err_code)
>>  {
>> @@ -149,7 +156,7 @@ static void ifpga_sec_dev_error(struct ifpga_sec_mgr
>> *imgr,
>>  static void progress_complete(struct ifpga_sec_mgr *imgr)
>>  {
>>  mutex_lock(&imgr->lock);
>> -imgr->progress = IFPGA_SEC_PROG_IDLE;
>> +update_progress(imgr, IFPGA_SEC_PROG_IDLE);
>>  complete_all(&imgr->update_done);
>>  mutex_unlock(&imgr->lock);
>>  }
>> @@ -177,14 +184,14 @@ static void ifpga_sec_mgr_update(struct
>> work_struct *work)
>>  goto release_fw_exit;
>>  }
>>
>> -imgr->progress = IFPGA_SEC_PROG_PREPARING;
>> +update_progress(imgr, IFPGA_SEC_PROG_PREPARING);
>>  ret = imgr->iops->prepare(imgr);
>>  if (ret) {
>>  ifpga_sec_dev_error(imgr, ret);
>>  goto modput_exit;
>>  }
>>
>> -imgr->progress = IFPGA_SEC_PROG_WRITING;
>> +update_progress(imgr, IFPGA_SEC_PROG_WRITING);
>>  size = imgr->remaining_size;
>>  while (size) {
>>  blk_size = min_t(u32, size, WRITE_BLOCK_SIZE);
>> @@ -199,7 +206,7 @@ static void ifpga_sec_mgr_update(struct work_struct
>> *work)
>>  offset += blk_size;
>>  }
>>
>> -imgr->progress = IFPGA_SEC_PROG_PROGRAMMING;
>> +update_progress(imgr, IFPGA_SEC_PROG_PROGRAMMING);
>>  ret = imgr->iops->poll_complete(imgr);
>>  if (ret) {
>>  ifpga_sec_dev_error(imgr, ret);
>> @@ -259,6 +266,30 @@ static struct attribute_group
>> sec_mgr_security_attr_group = {
>>  .is_visible = sec_mgr_visible,
>>  };
>>
>> +static const char * const sec_mgr_prog_str[] = {
>> +"idle",/* IFPGA_SEC_PROG_IDLE */
>> +"reading",/* IFPGA_SEC_PROG_READING */
>> +"preparing",/* IFPGA_SEC_PROG_PREPARING */
>> +"writing",/* IFPGA_SEC_PROG_WRITING */
>> +"programming"/* IFPGA_SEC_PROG_PROGRAMMING */
>> +};
>> +
>> +static ssize_t
>> +status_show(struct device *dev, struct device_attribute *attr, char *buf)
>> +{
>> +struct ifpga_sec_mgr *imgr = to_sec_mgr(dev);
>> +const char *status = "unknown-status";
>> +
>> +if (imgr->progress < IFPGA_SEC_PROG_MAX)
>> +status = sec_mgr_prog_str[imgr->progress];
> I am not sure if this would be a problem that as there is no lock protection for
> the progress value. If someone changes imgr->progress into a bad value just
> after the first check imgr->progress < IFPGA_SEC_PROG_MAX passed.
I'll read imgr->progress into a local variable and operate off of that so that I
am using a consistent value.

We really should never see an invalid value. These values are set explicitly (not
incremented or decremented) during the update process. If we do see an invalid
value, it would indicate a driver bug.
>
>> +else
>> +dev_warn(dev, "Invalid status during secure update: %d\n",
>> + imgr->progress);
> One minor thing, dev_err or even WARN_ON should be better, and I think
> if it hits this, that will be a critical issue in the driver, isn't it?
Yes. I'll switch to dev_err(). A stack trace probably wouldn't be useful
since the error would be happening in a different kernel thread.
>
> Thanks
> Hao
>
>> +
>> +return sprintf(buf, "%s\n", status);
>> +}
>> +static DEVICE_ATTR_RO(status);
>> +
>>  static ssize_t filename_store(struct device *dev, struct device_attribute *attr,
>>        const char *buf, size_t count)
>>  {
>> @@ -293,6 +324,7 @@ static DEVICE_ATTR_WO(filename);
>>
>>  static struct attribute *sec_mgr_update_attrs[] = {
>>  &dev_attr_filename.attr,
>> +&dev_attr_status.attr,
>>  NULL,
>>  };
>>
>> --
>> 2.17.1

