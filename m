Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 693C3275859
	for <lists+linux-fpga@lfdr.de>; Wed, 23 Sep 2020 15:02:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726130AbgIWNCo (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 23 Sep 2020 09:02:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28902 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726332AbgIWNCm (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 23 Sep 2020 09:02:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600866159;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QCJYlGYOYZlshQeHXl+UspzurULpVNwd1ROqVV4YhEY=;
        b=ZXaSVa3Rxg/fGqktHLCxhLBeLw5xGv4IK0xzexURA78VkooJfApX1UuJ22MaiZCCbpV4b4
        6XPt1Q4pf0UjaqEAsdS1Jo6xRnZy5v9cWt6fbvK40u6x67xriuZTHRlVABy2AofMpagxlt
        Cn6B1FyokeqoBMRM/HXNAbxESHpwUdw=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-363-b3fw7WNZOvq_PgpUNmfIaA-1; Wed, 23 Sep 2020 09:02:36 -0400
X-MC-Unique: b3fw7WNZOvq_PgpUNmfIaA-1
Received: by mail-ot1-f72.google.com with SMTP id o3so4680031otp.8
        for <linux-fpga@vger.kernel.org>; Wed, 23 Sep 2020 06:02:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=QCJYlGYOYZlshQeHXl+UspzurULpVNwd1ROqVV4YhEY=;
        b=Z9Rm1clyi+qopbfpw80lTWcgzpISHvnheVV5O0du0uYNKRFKVBPSFU2+xlX3yByfkQ
         /hN82hq02osV/om8qsBiP0o+VCyscVyj/rpDXDROELvm442UvhVRifLUT+K3g0JVeMLf
         J3xydPsfMHoKksrFlO/4Rtvmc4UJbgXZvGfLKdSEjQoerNyshdg+Gh84ihxWwqC22czU
         sA1inRsgP/XqC7K8ujoHQO6WVo2ZFV/jrvM/L58fTwH3boy9Jx2Jabtoq1C+szU8fS4c
         E/B8bAb8f4ApIhkPIE68858yiwkYUmpLUpZu0V2asYP60XYe5ZZmVyyv431PKZOL6ac8
         jMUg==
X-Gm-Message-State: AOAM532zt7IENWy/jnCxzgyR61QWD+biZBSnNcHNfNmex2KlBdJc+7lY
        f6AJGAIoQzOq9Bc5WBJ9rB5G+nI8IF92XV1k5zsFiIilAooJLggV0KclLYEG7Z2NK0O7Ct5ZM/m
        PLHtdZIXW/uhLlvKBM5NAxQ==
X-Received: by 2002:aca:3012:: with SMTP id w18mr5428577oiw.44.1600866154842;
        Wed, 23 Sep 2020 06:02:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzVyh+sbSdr/1KOGlHduiTD/o2bXxxFYYV+kAaj66Cf8V+9lrwFFiG0Dh91hm0jnAuH3XEJAw==
X-Received: by 2002:aca:3012:: with SMTP id w18mr5428554oiw.44.1600866154492;
        Wed, 23 Sep 2020 06:02:34 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id d1sm7589077otb.80.2020.09.23.06.02.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Sep 2020 06:02:33 -0700 (PDT)
Subject: Re: [PATCH v1 10/12] fpga: enable sec-mgr update cancel
To:     Russ Weight <russell.h.weight@intel.com>, mdf@kernel.org,
        lee.jones@linaro.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     lgoncalv@redhat.com, yilun.xu@intel.com, hao.wu@intel.com,
        matthew.gerlach@intel.com
References: <20200904235305.6254-1-russell.h.weight@intel.com>
 <20200904235305.6254-11-russell.h.weight@intel.com>
 <bfcdc249-1cc7-e755-1030-cf1fed2416fa@redhat.com>
 <678f8d39-a244-42d0-4c56-91eb859b43f0@intel.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <8044594c-675d-40b9-ab12-e3dde50de399@redhat.com>
Date:   Wed, 23 Sep 2020 06:02:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <678f8d39-a244-42d0-4c56-91eb859b43f0@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 9/22/20 5:55 PM, Russ Weight wrote:
>
> On 9/6/20 10:00 AM, Tom Rix wrote:
>> On 9/4/20 4:53 PM, Russ Weight wrote:
>>> Extend the Intel Security Manager class driver to include
>>> an update/cancel sysfs file that can be written to request
>>> that an update be canceled. The write may return EBUSY if
>>> the update has progressed to the point that it cannot be
>>> canceled by software or ENODEV if there is no update in
>>> progress.
>>>
>>> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
>>> ---
>>>  .../ABI/testing/sysfs-class-ifpga-sec-mgr     | 10 ++++
>>>  drivers/fpga/ifpga-sec-mgr.c                  | 59 +++++++++++++++++--
>>>  include/linux/fpga/ifpga-sec-mgr.h            |  1 +
>>>  3 files changed, 66 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/Documentation/ABI/testing/sysfs-class-ifpga-sec-mgr b/Documentation/ABI/testing/sysfs-class-ifpga-sec-mgr
>>> index cf1967f1b3e3..762a7dee9453 100644
>>> --- a/Documentation/ABI/testing/sysfs-class-ifpga-sec-mgr
>>> +++ b/Documentation/ABI/testing/sysfs-class-ifpga-sec-mgr
>>> @@ -87,6 +87,16 @@ Description:	Write only. Write the filename of an Intel image
>>>  		and Root Entry Hashes, and to cancel Code Signing
>>>  		Keys (CSK).
>>>  
>>> +What: 		/sys/class/ifpga_sec_mgr/ifpga_secX/update/cancel
>>> +Date:		Sep 2020
>>> +KernelVersion:  5.10
>>> +Contact:	Russ Weight <russell.h.weight@intel.com>
>>> +Description:	Write-only. Write a "1" to this file to request
>>> +		that a current update be canceled. This request
>>> +		will be rejected (EBUSY) if the programming phase
>>> +		has already started or (ENODEV) if there is no
>>> +		update in progress.
>>> +
>>>  What: 		/sys/class/ifpga_sec_mgr/ifpga_secX/update/status
>>>  Date:		Sep 2020
>>>  KernelVersion:  5.10
>>> diff --git a/drivers/fpga/ifpga-sec-mgr.c b/drivers/fpga/ifpga-sec-mgr.c
>>> index 4ca5d13e5656..afd97c135ebe 100644
>>> --- a/drivers/fpga/ifpga-sec-mgr.c
>>> +++ b/drivers/fpga/ifpga-sec-mgr.c
>>> @@ -159,6 +159,23 @@ static void ifpga_sec_dev_error(struct ifpga_sec_mgr *imgr,
>>>  	imgr->iops->cancel(imgr);
>>>  }
>>>  
>>> +static int progress_transition(struct ifpga_sec_mgr *imgr,
>>> +			       enum ifpga_sec_prog new_progress)
>>> +{
>>> +	int ret = 0;
>>> +
>>> +	mutex_lock(&imgr->lock);
>>> +	if (imgr->request_cancel) {
>>> +		set_error(imgr, IFPGA_SEC_ERR_CANCELED);
>>> +		imgr->iops->cancel(imgr);
>> check cancel() for double error ?
> Meaning - what if the cancel function returns an error? I have been of the opinion that the first event (in this case, the cancel) is the most important one to report. In the unlikely event that an error occurred during the cancel, if it was a persistent error, it would be reported on the next secure update. Do you think this is a problem? Do you think it would be worth adding logic to report both errors? One thought would be to add a flag to the ifpga_sec_mgr structure to indicate that the error being reported occurred while canceling. And then the error_show() logic could append two error strings (something like: "user-abort+read-write-error"). In this case we could also enable hw_errinfo. What do you think? Would it be better to make this change?
Ok, we will let the next secure update catch the problem.
>> should request_cancel be cleared ?
> I don't think it needs to be cleared here, as we are exiting on error/abort and
> we initialize request_cancel at the beginning of a new secure update.
ok
>>> +		ret = -ECANCELED;
>>> +	} else {
>>> +		update_progress(imgr, new_progress);
>>> +	}
>>> +	mutex_unlock(&imgr->lock);
>>> +	return ret;
>>> +}
>>> +
>>>  static void progress_complete(struct ifpga_sec_mgr *imgr)
>>>  {
>>>  	mutex_lock(&imgr->lock);
>>> @@ -190,16 +207,20 @@ static void ifpga_sec_mgr_update(struct work_struct *work)
>>>  		goto release_fw_exit;
>>>  	}
>>>  
>>> -	update_progress(imgr, IFPGA_SEC_PROG_PREPARING);
>>> +	if (progress_transition(imgr, IFPGA_SEC_PROG_PREPARING))
>>> +		goto modput_exit;
>>> +
>>>  	ret = imgr->iops->prepare(imgr);
>>>  	if (ret) {
>>>  		ifpga_sec_dev_error(imgr, ret);
>>>  		goto modput_exit;
>>>  	}
>>>  
>>> -	update_progress(imgr, IFPGA_SEC_PROG_WRITING);
>>> +	if (progress_transition(imgr, IFPGA_SEC_PROG_WRITING))
>>> +		goto done;
>>> +
>>>  	size = imgr->remaining_size;
>>> -	while (size) {
>>> +	while (size && !imgr->request_cancel) {
>>>  		blk_size = min_t(u32, size, WRITE_BLOCK_SIZE);
>>>  		size -= blk_size;
>>>  		ret = imgr->iops->write_blk(imgr, offset, blk_size);
>>> @@ -212,7 +233,9 @@ static void ifpga_sec_mgr_update(struct work_struct *work)
>>>  		offset += blk_size;
>>>  	}
>>>  
>>> -	update_progress(imgr, IFPGA_SEC_PROG_PROGRAMMING);
>>> +	if (progress_transition(imgr, IFPGA_SEC_PROG_PROGRAMMING))
>>> +		goto done;
>>> +
>>>  	ret = imgr->iops->poll_complete(imgr);
>>>  	if (ret) {
>>>  		ifpga_sec_dev_error(imgr, ret);
>>> @@ -359,6 +382,7 @@ static ssize_t filename_store(struct device *dev, struct device_attribute *attr,
>>>  		imgr->filename[strlen(imgr->filename) - 1] = '\0';
>>>  
>>>  	imgr->err_code = IFPGA_SEC_ERR_NONE;
>>> +	imgr->request_cancel = false;
>>>  	imgr->progress = IFPGA_SEC_PROG_READ_FILE;
>>>  	reinit_completion(&imgr->update_done);
>>>  	schedule_work(&imgr->work);
>>> @@ -369,8 +393,32 @@ static ssize_t filename_store(struct device *dev, struct device_attribute *attr,
>>>  }
>>>  static DEVICE_ATTR_WO(filename);
>>>  
>>> +static ssize_t cancel_store(struct device *dev, struct device_attribute *attr,
>>> +			    const char *buf, size_t count)
>>> +{
>>> +	struct ifpga_sec_mgr *imgr = to_sec_mgr(dev);
>>> +	bool cancel;
>>> +	int ret = 0;
>> int ret = count;
> OK
>>> +
>>> +	if (kstrtobool(buf, &cancel) || !cancel)
>> This does not match your description in the testing section.
>>
>> kstrtobool has many other valid inputs.
>>
>> maybe check if count is 1 and buf[0] == '1'
> The documentation is not really incorrect though, is it? I see several other instances
> of *_store() functions that use krstrtobool for input and document that a 1 or a 0
> should be written as input.
>
> However, I'm willing to change it if you think it needs to be changed.

I am being pedantic.

This is ok as-is, testing would work.

Tom

>
>>> +		return -EINVAL;
>>> +
>>> +	mutex_lock(&imgr->lock);
>>> +	if (imgr->progress == IFPGA_SEC_PROG_PROGRAMMING)
>>> +		ret = -EBUSY;
>>> +	else if (imgr->progress == IFPGA_SEC_PROG_IDLE)
>>> +		ret = -ENODEV;
>>> +	else
>>> +		imgr->request_cancel = true;
>>> +	mutex_unlock(&imgr->lock);
>>> +
>>> +	return ret ? : count;
>> return ret;
> Yes - I'll change this.
>> Tom
>>
>>> +}
>>> +static DEVICE_ATTR_WO(cancel);
>>> +
>>>  static struct attribute *sec_mgr_update_attrs[] = {
>>>  	&dev_attr_filename.attr,
>>> +	&dev_attr_cancel.attr,
>>>  	&dev_attr_status.attr,
>>>  	&dev_attr_error.attr,
>>>  	&dev_attr_remaining_size.attr,
>>> @@ -536,6 +584,9 @@ void ifpga_sec_mgr_unregister(struct ifpga_sec_mgr *imgr)
>>>  		goto unregister;
>>>  	}
>>>  
>>> +	if (imgr->progress != IFPGA_SEC_PROG_PROGRAMMING)
>>> +		imgr->request_cancel = true;
>>> +
>>>  	mutex_unlock(&imgr->lock);
>>>  	wait_for_completion(&imgr->update_done);
>>>  
>>> diff --git a/include/linux/fpga/ifpga-sec-mgr.h b/include/linux/fpga/ifpga-sec-mgr.h
>>> index f04bf9e30c67..f51ed663a723 100644
>>> --- a/include/linux/fpga/ifpga-sec-mgr.h
>>> +++ b/include/linux/fpga/ifpga-sec-mgr.h
>>> @@ -183,6 +183,7 @@ struct ifpga_sec_mgr {
>>>  	enum ifpga_sec_prog progress;
>>>  	enum ifpga_sec_prog err_state;	/* progress state at time of failure */
>>>  	enum ifpga_sec_err err_code;	/* security manager error code */
>>> +	bool request_cancel;
>>>  	bool driver_unload;
>>>  	void *priv;
>>>  };

