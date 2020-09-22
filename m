Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 452B7274C1D
	for <lists+linux-fpga@lfdr.de>; Wed, 23 Sep 2020 00:31:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbgIVWbO (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 22 Sep 2020 18:31:14 -0400
Received: from mga03.intel.com ([134.134.136.65]:10288 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726448AbgIVWbO (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 22 Sep 2020 18:31:14 -0400
IronPort-SDR: Tm6Z5frl7PlOz4C9v8/Qkns4fw+4uD77vcmntpHNKzMTR1keZiVt2Ly6W+er+lbQ/8fXAR5n9m
 xFAlNkanJZNQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9752"; a="160805208"
X-IronPort-AV: E=Sophos;i="5.77,292,1596524400"; 
   d="scan'208";a="160805208"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2020 15:31:12 -0700
IronPort-SDR: nW3gdMCynutjvSTUUEYodsdC6+CVVvVe8VGXY9QncgSOeLWO/AUh3Yd++7mE3hrAeSaever+h4
 64HF/sSW+Cug==
X-IronPort-AV: E=Sophos;i="5.77,292,1596524400"; 
   d="scan'208";a="511402424"
Received: from rhweight-mobl2.amr.corp.intel.com (HELO [10.0.2.15]) ([10.212.137.114])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2020 15:31:11 -0700
Subject: Re: [PATCH v1 07/12] fpga: expose sec-mgr update status
To:     Tom Rix <trix@redhat.com>, mdf@kernel.org, lee.jones@linaro.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     lgoncalv@redhat.com, yilun.xu@intel.com, hao.wu@intel.com,
        matthew.gerlach@intel.com
References: <20200904235305.6254-1-russell.h.weight@intel.com>
 <20200904235305.6254-8-russell.h.weight@intel.com>
 <4fdb6000-ced9-1713-cace-8e7b09c6d586@redhat.com>
From:   Russ Weight <russell.h.weight@intel.com>
Message-ID: <3dc77b88-8d6c-424e-3c6e-a39ac8de8fb6@intel.com>
Date:   Tue, 22 Sep 2020 15:31:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <4fdb6000-ced9-1713-cace-8e7b09c6d586@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



On 9/6/20 9:16 AM, Tom Rix wrote:
> On 9/4/20 4:53 PM, Russ Weight wrote:
>> Extend the Intel Security Manager class driver to
>> include an update/status sysfs node that can be polled
>> and read to monitor the progress of an ongoing secure
>> update. Sysfs_notify() is used to signal transitions
>> between different phases of the update process.
>>
>> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
>> Reviewed-by: Wu Hao <hao.wu@intel.com>
>> ---
>>  .../ABI/testing/sysfs-class-ifpga-sec-mgr     | 11 ++++++
>>  drivers/fpga/ifpga-sec-mgr.c                  | 34 ++++++++++++++++---
>>  2 files changed, 41 insertions(+), 4 deletions(-)
>>
>> diff --git a/Documentation/ABI/testing/sysfs-class-ifpga-sec-mgr b/Documentation/ABI/testing/sysfs-class-ifpga-sec-mgr
>> index a476504b7ae9..849ccb2802f8 100644
>> --- a/Documentation/ABI/testing/sysfs-class-ifpga-sec-mgr
>> +++ b/Documentation/ABI/testing/sysfs-class-ifpga-sec-mgr
>> @@ -86,3 +86,14 @@ Description:	Write only. Write the filename of an Intel image
>>  		BMC images, BMC firmware, Static Region images,
>>  		and Root Entry Hashes, and to cancel Code Signing
>>  		Keys (CSK).
>> +
>> +What: 		/sys/class/ifpga_sec_mgr/ifpga_secX/update/status
>> +Date:		Sep 2020
>> +KernelVersion:  5.10
>> +Contact:	Russ Weight <russell.h.weight@intel.com>
>> +Description:	Read-only. Returns a string describing the current
>> +		status of an update. The string will be one of the
>> +		following: idle, read_file, preparing, writing,
> For consistency, read_file -> reading
Yes - I'll make the change.
>> +		programming. Userspace code can poll on this file,
>> +		as it will be signaled by sysfs_notify() on each
>> +		state change.
>> diff --git a/drivers/fpga/ifpga-sec-mgr.c b/drivers/fpga/ifpga-sec-mgr.c
>> index 73173badbe96..5fe3d85e2963 100644
>> --- a/drivers/fpga/ifpga-sec-mgr.c
>> +++ b/drivers/fpga/ifpga-sec-mgr.c
>> @@ -139,6 +139,13 @@ static struct attribute *sec_mgr_security_attrs[] = {
>>  	NULL,
>>  };
>>  
>> +static void update_progress(struct ifpga_sec_mgr *imgr,
>> +			    enum ifpga_sec_prog new_progress)
>> +{
>> +	imgr->progress = new_progress;
>> +	sysfs_notify(&imgr->dev.kobj, "update", "status");
>> +}
>> +
>>  static void ifpga_sec_dev_error(struct ifpga_sec_mgr *imgr,
>>  				enum ifpga_sec_err err_code)
>>  {
>> @@ -149,7 +156,7 @@ static void ifpga_sec_dev_error(struct ifpga_sec_mgr *imgr,
>>  static void progress_complete(struct ifpga_sec_mgr *imgr)
>>  {
>>  	mutex_lock(&imgr->lock);
>> -	imgr->progress = IFPGA_SEC_PROG_IDLE;
>> +	update_progress(imgr, IFPGA_SEC_PROG_IDLE);
>>  	complete_all(&imgr->update_done);
>>  	mutex_unlock(&imgr->lock);
>>  }
>> @@ -177,14 +184,14 @@ static void ifpga_sec_mgr_update(struct work_struct *work)
>>  		goto release_fw_exit;
>>  	}
>>  
>> -	imgr->progress = IFPGA_SEC_PROG_PREPARING;
>> +	update_progress(imgr, IFPGA_SEC_PROG_PREPARING);
>>  	ret = imgr->iops->prepare(imgr);
>>  	if (ret) {
>>  		ifpga_sec_dev_error(imgr, ret);
>>  		goto modput_exit;
>>  	}
>>  
>> -	imgr->progress = IFPGA_SEC_PROG_WRITING;
>> +	update_progress(imgr, IFPGA_SEC_PROG_WRITING);
>>  	size = imgr->remaining_size;
>>  	while (size) {
>>  		blk_size = min_t(u32, size, WRITE_BLOCK_SIZE);
>> @@ -199,7 +206,7 @@ static void ifpga_sec_mgr_update(struct work_struct *work)
>>  		offset += blk_size;
>>  	}
>>  
>> -	imgr->progress = IFPGA_SEC_PROG_PROGRAMMING;
>> +	update_progress(imgr, IFPGA_SEC_PROG_PROGRAMMING);
>>  	ret = imgr->iops->poll_complete(imgr);
>>  	if (ret) {
>>  		ifpga_sec_dev_error(imgr, ret);
>> @@ -251,6 +258,24 @@ static struct attribute_group sec_mgr_security_attr_group = {
>>  	.is_visible = sec_mgr_visible,
>>  };
>>  
>> +static const char * const sec_mgr_prog_str[] = {
>> +	"idle",			/* IFPGA_SEC_PROG_IDLE */
>> +	"read_file",		/* IFPGA_SEC_PROG_READ_FILE */
> "reading"
yes
>> +	"preparing",		/* IFPGA_SEC_PROG_PREPARING */
>> +	"writing",		/* IFPGA_SEC_PROG_WRITING */
>> +	"programming"		/* IFPGA_SEC_PROG_PROGRAMMING */
>> +};
>> +
>> +static ssize_t
>> +status_show(struct device *dev, struct device_attribute *attr, char *buf)
>> +{
>> +	struct ifpga_sec_mgr *imgr = to_sec_mgr(dev);
>> +
>> +	return sprintf(buf, "%s\n", (imgr->progress < IFPGA_SEC_PROG_MAX) ?
>> +		       sec_mgr_prog_str[imgr->progress] : "unknown-status");
> when imgr->progress is unknown, should there be a dev_warn ?
Yes, this is a case that should not happen so it probably warrants something in
the kernel log. I'll add that.
>
> Tom
>
>> +}
>> +static DEVICE_ATTR_RO(status);
>> +
>>  static ssize_t filename_store(struct device *dev, struct device_attribute *attr,
>>  			      const char *buf, size_t count)
>>  {
>> @@ -288,6 +313,7 @@ static DEVICE_ATTR_WO(filename);
>>  
>>  static struct attribute *sec_mgr_update_attrs[] = {
>>  	&dev_attr_filename.attr,
>> +	&dev_attr_status.attr,
>>  	NULL,
>>  };
>>  

