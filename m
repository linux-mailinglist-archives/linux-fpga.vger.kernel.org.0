Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD67F2852C6
	for <lists+linux-fpga@lfdr.de>; Tue,  6 Oct 2020 22:00:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725962AbgJFUAM (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 6 Oct 2020 16:00:12 -0400
Received: from mga09.intel.com ([134.134.136.24]:22783 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725943AbgJFUAM (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 6 Oct 2020 16:00:12 -0400
IronPort-SDR: bpJZkOBbuSmtLf8TdGDXEjXzMahgdiopHS1j2PVFoJPafzqQrA3PVjbN6XKsOyVkHu7UFDjF8R
 uzGEcOZVrAKw==
X-IronPort-AV: E=McAfee;i="6000,8403,9766"; a="164798101"
X-IronPort-AV: E=Sophos;i="5.77,343,1596524400"; 
   d="scan'208";a="164798101"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2020 13:00:10 -0700
IronPort-SDR: uDe4lxWJP+Hz8hY5BF53JET2btrnbIDhircC2xMxZlRebfqh7Qevt3cvuINBFDqTZIbh/34Qx6
 wjyy8p4TE3OQ==
X-IronPort-AV: E=Sophos;i="5.77,343,1596524400"; 
   d="scan'208";a="460967583"
Received: from rhweight-mobl2.amr.corp.intel.com (HELO [10.0.2.15]) ([10.212.2.223])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2020 13:00:09 -0700
Subject: Re: [PATCH v2 4/7] fpga: sec-mgr: expose sec-mgr update errors
To:     "Wu, Hao" <hao.wu@intel.com>, "mdf@kernel.org" <mdf@kernel.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "trix@redhat.com" <trix@redhat.com>,
        "lgoncalv@redhat.com" <lgoncalv@redhat.com>,
        "Xu, Yilun" <yilun.xu@intel.com>,
        "Gerlach, Matthew" <matthew.gerlach@intel.com>
References: <20201002223701.1317-1-russell.h.weight@intel.com>
 <20201002223701.1317-5-russell.h.weight@intel.com>
 <DM6PR11MB3819F5AF4275019A8F0D3208850C0@DM6PR11MB3819.namprd11.prod.outlook.com>
From:   Russ Weight <russell.h.weight@intel.com>
Message-ID: <cf78c4e2-a519-4c1a-6e0d-849bbd24d44a@intel.com>
Date:   Tue, 6 Oct 2020 13:00:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <DM6PR11MB3819F5AF4275019A8F0D3208850C0@DM6PR11MB3819.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



On 10/5/20 1:55 AM, Wu, Hao wrote:
>> Subject: [PATCH v2 4/7] fpga: sec-mgr: expose sec-mgr update errors
>>
>> Extend Intel Security Manager class driver to include
>> an update/error sysfs node that can be read for error
>> information when a secure update fails.
>>
>> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
>> ---
>> v2:
>>   - Bumped documentation date and version
>>   - Added warning to sec_progress() for invalid progress status
>>   - Added sec_error() function (similar to sec_progress())
>> ---
>>  .../ABI/testing/sysfs-class-ifpga-sec-mgr     | 17 ++++
>>  drivers/fpga/ifpga-sec-mgr.c                  | 81 ++++++++++++++++---
>>  include/linux/fpga/ifpga-sec-mgr.h            |  1 +
>>  3 files changed, 89 insertions(+), 10 deletions(-)
>>
>> diff --git a/Documentation/ABI/testing/sysfs-class-ifpga-sec-mgr
>> b/Documentation/ABI/testing/sysfs-class-ifpga-sec-mgr
>> index 73a5246fea1b..1f9f2c215e0c 100644
>> --- a/Documentation/ABI/testing/sysfs-class-ifpga-sec-mgr
>> +++ b/Documentation/ABI/testing/sysfs-class-ifpga-sec-mgr
>> @@ -89,3 +89,20 @@ Description:Read-only. Returns a string describing
>> the current
>>  programming. Userspace code can poll on this file,
>>  as it will be signaled by sysfs_notify() on each
>>  state change.
>> +
>> +What: /sys/class/ifpga_sec_mgr/ifpga_secX/update/error
>> +Date:Oct 2020
>> +KernelVersion:  5.11
>> +Contact:Russ Weight <russell.h.weight@intel.com>
>> +Description:Read-only. Returns a string describing the failure
>> +of a secure update. This string will be in the form
>> +of <STATUS>:<ERROR>, where <STATUS> will be one of
>> +the status strings described for the status sysfs
>> +file and <ERROR> will be one of the following:
>> +hw-error, timeout, user-abort, device-busy,
>> +invalid-file-size, read-write-error, flash-wearout,
>> +file-read-error.  The error sysfs file is only
>> +meaningful when the secure update engine is in the
>> +idle state. If this file is read while a secure
>> +update is in progress, then the read will fail with
>> +EBUSY.
>> diff --git a/drivers/fpga/ifpga-sec-mgr.c b/drivers/fpga/ifpga-sec-mgr.c
>> index ad918fb42dc2..456ea0b71e3d 100644
>> --- a/drivers/fpga/ifpga-sec-mgr.c
>> +++ b/drivers/fpga/ifpga-sec-mgr.c
>> @@ -146,10 +146,16 @@ static void update_progress(struct ifpga_sec_mgr
>> *imgr,
>>  sysfs_notify(&imgr->dev.kobj, "update", "status");
>>  }
>>
>> +static void set_error(struct ifpga_sec_mgr *imgr, enum ifpga_sec_err
>> err_code)
>> +{
>> +imgr->err_state = imgr->progress;
>> +imgr->err_code = err_code;
>> +}
>> +
>>  static void ifpga_sec_dev_error(struct ifpga_sec_mgr *imgr,
>>  enum ifpga_sec_err err_code)
>>  {
>> -imgr->err_code = err_code;
>> +set_error(imgr, err_code);
>>  imgr->iops->cancel(imgr);
>>  }
>>
>> @@ -172,7 +178,7 @@ static void ifpga_sec_mgr_update(struct work_struct
>> *work)
>>
>>  get_device(&imgr->dev);
>>  if (request_firmware(&fw, imgr->filename, &imgr->dev)) {
>> -imgr->err_code = IFPGA_SEC_ERR_FILE_READ;
>> +set_error(imgr, IFPGA_SEC_ERR_FILE_READ);
>>  goto idle_exit;
>>  }
>>
>> @@ -180,7 +186,7 @@ static void ifpga_sec_mgr_update(struct work_struct
>> *work)
>>  imgr->remaining_size = fw->size;
>>
>>  if (!try_module_get(imgr->dev.parent->driver->owner)) {
>> -imgr->err_code = IFPGA_SEC_ERR_BUSY;
>> +set_error(imgr, IFPGA_SEC_ERR_BUSY);
>>  goto release_fw_exit;
>>  }
>>
>> @@ -274,22 +280,76 @@ static const char * const sec_mgr_prog_str[] = {
>>  "programming"/* IFPGA_SEC_PROG_PROGRAMMING */
>>  };
>>
>> -static ssize_t
>> -status_show(struct device *dev, struct device_attribute *attr, char *buf)
>> +static const char * const sec_mgr_err_str[] = {
>> +"none",/* IFPGA_SEC_ERR_NONE */
>> +"hw-error",/* IFPGA_SEC_ERR_HW_ERROR */
>> +"timeout",/* IFPGA_SEC_ERR_TIMEOUT */
>> +"user-abort",/* IFPGA_SEC_ERR_CANCELED */
>> +"device-busy",/* IFPGA_SEC_ERR_BUSY */
>> +"invalid-file-size",/* IFPGA_SEC_ERR_INVALID_SIZE */
>> +"read-write-error",/* IFPGA_SEC_ERR_RW_ERROR */
>> +"flash-wearout",/* IFPGA_SEC_ERR_WEAROUT */
>> +"file-read-error"/* IFPGA_SEC_ERR_FILE_READ */
>> +};
>> +
>> +static const char *sec_progress(struct device *dev, enum ifpga_sec_prog
>> prog)
>>  {
>> -struct ifpga_sec_mgr *imgr = to_sec_mgr(dev);
>>  const char *status = "unknown-status";
>>
>> -if (imgr->progress < IFPGA_SEC_PROG_MAX)
>> -status = sec_mgr_prog_str[imgr->progress];
>> +if (prog < IFPGA_SEC_PROG_MAX)
>> +status = sec_mgr_prog_str[prog];
>>  else
>>  dev_warn(dev, "Invalid status during secure update: %d\n",
>> - imgr->progress);
>> + prog);
>> +
>> +return status;
>> +}
>> +
>> +static const char *sec_error(struct device *dev, enum ifpga_sec_err
>> err_code)
>> +{
>> +const char *error = "unknown-error";
>> +
>> +if (err_code < IFPGA_SEC_ERR_MAX)
>> +error = sec_mgr_err_str[err_code];
>> +else
>> +dev_warn(dev, "Invalid error code during secure
>> update: %d\n",
>> + err_code);
>> +
>> +return error;
>> +}
>> +
>> +static ssize_t
>> +status_show(struct device *dev, struct device_attribute *attr, char *buf)
>> +{
>> +struct ifpga_sec_mgr *imgr = to_sec_mgr(dev);
>>
>> -return sprintf(buf, "%s\n", status);
>> +return sprintf(buf, "%s\n", sec_progress(dev, imgr->progress));
>>  }
>>  static DEVICE_ATTR_RO(status);
>>
>> +static ssize_t
>> +error_show(struct device *dev, struct device_attribute *attr, char *buf)
>> +{
>> +struct ifpga_sec_mgr *imgr = to_sec_mgr(dev);
>> +int ret;
>> +
>> +mutex_lock(&imgr->lock);
>> +
>> +if (imgr->progress != IFPGA_SEC_PROG_IDLE)
>> +ret = -EBUSY;
>> +else if (!imgr->err_code)
>> +ret = 0;
>> +else
>> +ret = sprintf(buf, "%s:%s\n",
>> +      sec_progress(dev, imgr->err_state),
>> +      sec_error(dev, imgr->err_code));
> In scheduled work for update, there is no lock protection, would that be a
> real problem here? e.g. progress is changed, or err_state and err_code
> are not matched.
-EBUSY is returned unless we are in the IDLE state. Also, the lock is held
during this function, so new updates cannot begin. This means there is no
worker thread in progress and there is no concurrent execution context
that can change the err_state and err_code values. They would retain the
error state from the previous update.

Thanks for the comments!
- Russ
>
> Thanks
> Hao
>
>> +
>> +mutex_unlock(&imgr->lock);
>> +
>> +return ret;
>> +}
>> +static DEVICE_ATTR_RO(error);
>> +
>>  static ssize_t filename_store(struct device *dev, struct device_attribute *attr,
>>        const char *buf, size_t count)
>>  {
>> @@ -325,6 +385,7 @@ static DEVICE_ATTR_WO(filename);
>>  static struct attribute *sec_mgr_update_attrs[] = {
>>  &dev_attr_filename.attr,
>>  &dev_attr_status.attr,
>> +&dev_attr_error.attr,
>>  NULL,
>>  };
>>
>> diff --git a/include/linux/fpga/ifpga-sec-mgr.h b/include/linux/fpga/ifpga-
>> sec-mgr.h
>> index 27008abd8e75..246e3d452c59 100644
>> --- a/include/linux/fpga/ifpga-sec-mgr.h
>> +++ b/include/linux/fpga/ifpga-sec-mgr.h
>> @@ -110,6 +110,7 @@ struct ifpga_sec_mgr {
>>  const u8 *data;/* pointer to update data */
>>  u32 remaining_size;/* size remaining to transfer */
>>  enum ifpga_sec_prog progress;
>> +enum ifpga_sec_prog err_state;/* progress state at time of
>> failure */
>>  enum ifpga_sec_err err_code;/* security manager error code */
>>  bool driver_unload;
>>  void *priv;
>> --
>> 2.17.1

