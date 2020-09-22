Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E98CE274D75
	for <lists+linux-fpga@lfdr.de>; Wed, 23 Sep 2020 01:42:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbgIVXmr (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 22 Sep 2020 19:42:47 -0400
Received: from mga06.intel.com ([134.134.136.31]:61261 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726641AbgIVXmr (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 22 Sep 2020 19:42:47 -0400
IronPort-SDR: Q7y7O2Rk8BFwmUq81wJ5HgeE+pNi2Y1vi323vHvUDBttOiMpgPetrI2ky7w1ltu2FSJFbeAzDw
 wznCM7NRXJ9g==
X-IronPort-AV: E=McAfee;i="6000,8403,9752"; a="222326414"
X-IronPort-AV: E=Sophos;i="5.77,292,1596524400"; 
   d="scan'208";a="222326414"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2020 16:42:46 -0700
IronPort-SDR: DsEXEgmznbPT+bBtVbakuFDUsUoN+5iuL09IlhwYNgSpuAL+V58Hp5hfQVfqDRNJQFPzIjpsKQ
 dmsVi2EX9jJg==
X-IronPort-AV: E=Sophos;i="5.77,292,1596524400"; 
   d="scan'208";a="511419759"
Received: from rhweight-mobl2.amr.corp.intel.com (HELO [10.0.2.15]) ([10.212.137.114])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2020 16:42:45 -0700
Subject: Re: [PATCH v1 08/12] fpga: expose sec-mgr update errors
To:     Tom Rix <trix@redhat.com>, mdf@kernel.org, lee.jones@linaro.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     lgoncalv@redhat.com, yilun.xu@intel.com, hao.wu@intel.com,
        matthew.gerlach@intel.com
References: <20200904235305.6254-1-russell.h.weight@intel.com>
 <20200904235305.6254-9-russell.h.weight@intel.com>
 <448b27a2-0724-77c1-20e8-1c3ff9287034@redhat.com>
From:   Russ Weight <russell.h.weight@intel.com>
Message-ID: <62e8f79b-32aa-041e-8b12-4b8570b085f6@intel.com>
Date:   Tue, 22 Sep 2020 16:42:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <448b27a2-0724-77c1-20e8-1c3ff9287034@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



On 9/6/20 9:27 AM, Tom Rix wrote:
> On 9/4/20 4:53 PM, Russ Weight wrote:
>> Extend Intel Security Manager class driver to include
>> an update/error sysfs node that can be read for error
>> information when a secure update fails.
>>
>> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
>> Reviewed-by: Wu Hao <hao.wu@intel.com>
>> ---
>>  .../ABI/testing/sysfs-class-ifpga-sec-mgr     | 17 ++++++
>>  drivers/fpga/ifpga-sec-mgr.c                  | 60 +++++++++++++++++--
>>  include/linux/fpga/ifpga-sec-mgr.h            |  1 +
>>  3 files changed, 73 insertions(+), 5 deletions(-)
>>
>> diff --git a/Documentation/ABI/testing/sysfs-class-ifpga-sec-mgr b/Documentation/ABI/testing/sysfs-class-ifpga-sec-mgr
>> index 849ccb2802f8..e7b1b02bf7ee 100644
>> --- a/Documentation/ABI/testing/sysfs-class-ifpga-sec-mgr
>> +++ b/Documentation/ABI/testing/sysfs-class-ifpga-sec-mgr
>> @@ -97,3 +97,20 @@ Description:	Read-only. Returns a string describing the current
>>  		programming. Userspace code can poll on this file,
>>  		as it will be signaled by sysfs_notify() on each
>>  		state change.
>> +
>> +What: 		/sys/class/ifpga_sec_mgr/ifpga_secX/update/error
>> +Date:		Sep 2020
>> +KernelVersion:  5.10
>> +Contact:	Russ Weight <russell.h.weight@intel.com>
>> +Description:	Read-only. Returns a string describing the failure
>> +		of a secure update. This string will be in the form
>> +		of <STATUS>:<ERROR>, where <STATUS> will be one of
>> +		the status strings described for the status sysfs
>> +		file and <ERROR> will be one of the following:
>> +		hw-error, timeout, user-abort, device-busy,
>> +		invalid-file-size, read-write-error, flash-wearout,
>> +		file-read-error.  The error sysfs file is only
>> +		meaningful when the secure update engine is in the
>> +		idle state. If this file is read while a secure
>> +		update is in progress, then the read will fail with
>> +		EBUSY.
>> diff --git a/drivers/fpga/ifpga-sec-mgr.c b/drivers/fpga/ifpga-sec-mgr.c
>> index 5fe3d85e2963..a7718bd8ee61 100644
>> --- a/drivers/fpga/ifpga-sec-mgr.c
>> +++ b/drivers/fpga/ifpga-sec-mgr.c
>> @@ -146,10 +146,16 @@ static void update_progress(struct ifpga_sec_mgr *imgr,
>>  	sysfs_notify(&imgr->dev.kobj, "update", "status");
>>  }
>>  
>> +static void set_error(struct ifpga_sec_mgr *imgr, enum ifpga_sec_err err_code)
>> +{
>> +	imgr->err_state = imgr->progress;
>> +	imgr->err_code = err_code;
>> +}
>> +
>>  static void ifpga_sec_dev_error(struct ifpga_sec_mgr *imgr,
>>  				enum ifpga_sec_err err_code)
>>  {
>> -	imgr->err_code = err_code;
>> +	set_error(imgr, err_code);
>>  	imgr->iops->cancel(imgr);
>>  }
>>  
>> @@ -172,7 +178,7 @@ static void ifpga_sec_mgr_update(struct work_struct *work)
>>  
>>  	get_device(&imgr->dev);
>>  	if (request_firmware(&fw, imgr->filename, &imgr->dev)) {
>> -		imgr->err_code = IFPGA_SEC_ERR_FILE_READ;
>> +		set_error(imgr, IFPGA_SEC_ERR_FILE_READ);
>>  		goto idle_exit;
>>  	}
>>  
>> @@ -180,7 +186,7 @@ static void ifpga_sec_mgr_update(struct work_struct *work)
>>  	imgr->remaining_size = fw->size;
>>  
>>  	if (!try_module_get(imgr->dev.parent->driver->owner)) {
>> -		imgr->err_code = IFPGA_SEC_ERR_BUSY;
>> +		set_error(imgr, IFPGA_SEC_ERR_BUSY);
>>  		goto release_fw_exit;
>>  	}
>>  
>> @@ -266,16 +272,59 @@ static const char * const sec_mgr_prog_str[] = {
>>  	"programming"		/* IFPGA_SEC_PROG_PROGRAMMING */
>>  };
>>  
>> +static const char * const sec_mgr_err_str[] = {
>> +	"none",			/* IFPGA_SEC_ERR_NONE */
>> +	"hw-error",		/* IFPGA_SEC_ERR_HW_ERROR */
>> +	"timeout",		/* IFPGA_SEC_ERR_TIMEOUT */
>> +	"user-abort",		/* IFPGA_SEC_ERR_CANCELED */
>> +	"device-busy",		/* IFPGA_SEC_ERR_BUSY */
>> +	"invalid-file-size",	/* IFPGA_SEC_ERR_INVALID_SIZE */
>> +	"read-write-error",	/* IFPGA_SEC_ERR_RW_ERROR */
>> +	"flash-wearout",	/* IFPGA_SEC_ERR_WEAROUT */
>> +	"file-read-error"	/* IFPGA_SEC_ERR_FILE_READ */
>> +};
>> +
>> +static const char *sec_progress(enum ifpga_sec_prog prog)
>> +{
> A consistent api would have imgr as the parameter.

There are two calls to this function: one passes imgr->progress, and one
passes imgr->err_status. For this function, passing imgr alone would be
insufficient.
>> +	return (prog < IFPGA_SEC_PROG_MAX) ?
>> +		sec_mgr_prog_str[prog] : "unknown-status";
>> +}
>> +
>>  static ssize_t
>>  status_show(struct device *dev, struct device_attribute *attr, char *buf)
>>  {
>>  	struct ifpga_sec_mgr *imgr = to_sec_mgr(dev);
>>  
>> -	return sprintf(buf, "%s\n", (imgr->progress < IFPGA_SEC_PROG_MAX) ?
>> -		       sec_mgr_prog_str[imgr->progress] : "unknown-status");
>> +	return sprintf(buf, "%s\n", sec_progress(imgr->progress));
>>  }
>>  static DEVICE_ATTR_RO(status);
>>  
>> +static ssize_t
>> +error_show(struct device *dev, struct device_attribute *attr, char *buf)
>> +{
>> +	struct ifpga_sec_mgr *imgr = to_sec_mgr(dev);
>> +	enum ifpga_sec_err err_code;
>> +	const char *prog_str;
>> +	int ret;
>> +
>> +	mutex_lock(&imgr->lock);
>> +	if (imgr->progress != IFPGA_SEC_PROG_IDLE) {
>> +		ret = -EBUSY;
>> +	} else if (!imgr->err_code) {
>> +		ret = 0;
>> +	} else {
>> +		err_code = imgr->err_code;
>> +		prog_str = sec_progress(imgr->err_state);
>> +		ret = sprintf(buf, "%s:%s\n", prog_str,
>> +			      (err_code < IFPGA_SEC_ERR_MAX) ?
>> +			      sec_mgr_err_str[err_code] : "unknown-error");
> Should have sec_error() call to match the new sec_progress()
OK - I'll add the sec_error() function.
>
> Tom
>
>> +	}
>> +	mutex_unlock(&imgr->lock);
>> +
>> +	return ret;
>> +}
>> +static DEVICE_ATTR_RO(error);
>> +
>>  static ssize_t filename_store(struct device *dev, struct device_attribute *attr,
>>  			      const char *buf, size_t count)
>>  {
>> @@ -314,6 +363,7 @@ static DEVICE_ATTR_WO(filename);
>>  static struct attribute *sec_mgr_update_attrs[] = {
>>  	&dev_attr_filename.attr,
>>  	&dev_attr_status.attr,
>> +	&dev_attr_error.attr,
>>  	NULL,
>>  };
>>  
>> diff --git a/include/linux/fpga/ifpga-sec-mgr.h b/include/linux/fpga/ifpga-sec-mgr.h
>> index 4da2864e251c..f04bf9e30c67 100644
>> --- a/include/linux/fpga/ifpga-sec-mgr.h
>> +++ b/include/linux/fpga/ifpga-sec-mgr.h
>> @@ -181,6 +181,7 @@ struct ifpga_sec_mgr {
>>  	const u8 *data;			/* pointer to update data */
>>  	u32 remaining_size;		/* size remaining to transfer */
>>  	enum ifpga_sec_prog progress;
>> +	enum ifpga_sec_prog err_state;	/* progress state at time of failure */
>>  	enum ifpga_sec_err err_code;	/* security manager error code */
>>  	bool driver_unload;
>>  	void *priv;

