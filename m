Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F76840774F
	for <lists+linux-fpga@lfdr.de>; Sat, 11 Sep 2021 15:15:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236138AbhIKNQJ (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sat, 11 Sep 2021 09:16:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:56023 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236666AbhIKNO1 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Sat, 11 Sep 2021 09:14:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631365993;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AOiAO1qM4bihWeD92wRauJL0tFdgrEN2u+hChF5LlTY=;
        b=OFDUCmB7EFPLXezMRUEmebwB1FjUOrra714N2YWumbCJaqcNI65S6E+8w6YzReTKBUD8Jq
        RbXMXyLwjDHCAEzVtZkEkQqbYHIEiJm7uDnHStjzf6yiIi04fkD+GMQBJOO73yKSYXyNRd
        Y8FNmPb0WUvwkgsAprQAh5oKYWQy7kA=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-306-IepHTHdMPeCauf6g_Y3HZA-1; Sat, 11 Sep 2021 09:13:12 -0400
X-MC-Unique: IepHTHdMPeCauf6g_Y3HZA-1
Received: by mail-qk1-f200.google.com with SMTP id q13-20020a05620a038d00b003d38f784161so35137986qkm.8
        for <linux-fpga@vger.kernel.org>; Sat, 11 Sep 2021 06:13:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=AOiAO1qM4bihWeD92wRauJL0tFdgrEN2u+hChF5LlTY=;
        b=dO0ExMyJU2AkoHTmajVJQWd60m9/TjkLasEAAYGqBe9ILw8/lhnB7p5qKmeGHOk6mM
         MjvFUeKP+JUrvdAINhZbfNCryJOakcX95/TAijSxqxJ3WIaAgPzBqfsBX8qAix58cjZC
         /0+T4yobshKM2xYbEQHUfTKm8jp80isM06F/xLKChK/KAfWfBhZUW3ZwSSqqh7fgBCze
         GHvFK/pNelIN/82fPVqfCnE9aKFxuE91L92ibGpJDcOp/MleUQp47GbV9uLpyb2TSZTE
         z1We+FLLalug8cq6KRJ9O1ZBrH8cwEI8hbBNAr6xv4poWdkG5P9XNFstbuyLLgRUK6jp
         iNrw==
X-Gm-Message-State: AOAM533hKFC+32ncRoG/Akq46pt7MeEVfcuKRfj2JhWACgk/U3lp7uti
        zi/rbFdyTpaYLD4aigR+QpEkRojNh44+PUxdU5BtX6cFAX5n6vqvZ4ju/Kn0t5jfCqGUohwG1a3
        aoHh4cr+EHW/QsZi6tCKBAQ==
X-Received: by 2002:a0c:fb4f:: with SMTP id b15mr2151217qvq.44.1631365991770;
        Sat, 11 Sep 2021 06:13:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJytEw8/j2V589FcQYzii8KxfhB0IuITmFC2rn0twC8UkNV2QAtrku4o4ln4wu3aZzEqHb+4Vg==
X-Received: by 2002:a0c:fb4f:: with SMTP id b15mr2151187qvq.44.1631365991473;
        Sat, 11 Sep 2021 06:13:11 -0700 (PDT)
Received: from localhost.localdomain (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id 67sm1190940qkl.1.2021.09.11.06.13.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Sep 2021 06:13:11 -0700 (PDT)
Subject: Re: [PATCH v15 6/6] fpga: image-load: enable cancel of image upload
To:     Russ Weight <russell.h.weight@intel.com>,
        Xu Yilun <yilun.xu@intel.com>
Cc:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, lgoncalv@redhat.com,
        hao.wu@intel.com, matthew.gerlach@intel.com
References: <20210909021846.681121-1-russell.h.weight@intel.com>
 <20210909021846.681121-7-russell.h.weight@intel.com>
 <20210910145545.GA757507@yilunxu-OptiPlex-7050>
 <839aa95e-c3d1-1f60-1b36-20d29445e61f@intel.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <8351febc-2493-89c3-86ea-9e7660b6d3ee@redhat.com>
Date:   Sat, 11 Sep 2021 06:13:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <839aa95e-c3d1-1f60-1b36-20d29445e61f@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 9/10/21 4:38 PM, Russ Weight wrote:
>
> On 9/10/21 7:55 AM, Xu Yilun wrote:
>> On Wed, Sep 08, 2021 at 07:18:46PM -0700, Russ Weight wrote:
>>> Extend the FPGA Image Load class driver to include a cancel IOCTL that
>>> can be used to request that an image upload be canceled. The IOCTL may
>>> return EBUSY if it cannot be canceled by software or ENODEV if there
>>> is no update in progress.
>>>
>>> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
>>> ---
>>> v15:
>>>   - Compare to previous patch:
>>>       [PATCH v14 6/6] fpga: sec-mgr: enable cancel of secure update
>>>   - Changed file, symbol, and config names to reflect the new driver name
>>>   - Cancel is now initiated by IOCT instead of sysfs
>>>   - Removed signed-off/reviewed-by tags
>>> v14:
>>>   - Updated ABI documentation date and kernel version
>>> v13:
>>>    - No change
>>> v12:
>>>    - Updated Date and KernelVersion fields in ABI documentation
>>> v11:
>>>    - No change
>>> v10:
>>>    - Rebased to 5.12-rc2 next
>>>    - Updated Date and KernelVersion in ABI documentation
>>> v9:
>>>    - Updated Date and KernelVersion in ABI documentation
>>> v8:
>>>    - No change
>>> v7:
>>>    - Changed Date in documentation file to December 2020
>>> v6:
>>>    - No change
>>> v5:
>>>    - No change
>>> v4:
>>>    - Changed from "Intel FPGA Security Manager" to FPGA Security Manager"
>>>      and removed unnecessary references to "Intel".
>>>    - Changed: iops -> sops, imgr -> smgr, IFPGA_ -> FPGA_, ifpga_ to fpga_
>>> v3:
>>>    - No change
>>> v2:
>>>    - Bumped documentation date and version
>>>    - Minor code cleanup per review comments
>>> ---
>>> ---
>>>   Documentation/fpga/fpga-image-load.rst |  6 ++++
>>>   drivers/fpga/fpga-image-load.c         | 45 +++++++++++++++++++++++---
>>>   include/linux/fpga/fpga-image-load.h   |  1 +
>>>   include/uapi/linux/fpga-image-load.h   |  1 +
>>>   4 files changed, 49 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/Documentation/fpga/fpga-image-load.rst b/Documentation/fpga/fpga-image-load.rst
>>> index 3d5eb51223e3..763e7833a6ea 100644
>>> --- a/Documentation/fpga/fpga-image-load.rst
>>> +++ b/Documentation/fpga/fpga-image-load.rst
>>> @@ -37,3 +37,9 @@ FPGA_IMAGE_LOAD_STATUS:
>>>   Collect status for an on-going image upload. The status returned includes
>>>   how much data remains to be transferred, the progress of the image load,
>>>   and error information in the case of a failure.
>>> +
>>> +FPGA_IMAGE_LOAD_CANCEL:
>>> +
>>> +Request that a on-going image upload be cancelled. This IOCTL may return
>>> +EBUSY if it cannot be cancelled by software or ENODEV if there is no update
>>> +in progress.
>>> diff --git a/drivers/fpga/fpga-image-load.c b/drivers/fpga/fpga-image-load.c
>>> index 6ec0a39f07b3..c32e4b1ea35a 100644
>>> --- a/drivers/fpga/fpga-image-load.c
>>> +++ b/drivers/fpga/fpga-image-load.c
>>> @@ -46,6 +46,24 @@ static void fpga_image_dev_error(struct fpga_image_load *imgld,
>>>   	imgld->lops->cancel(imgld);
>>>   }
>>>   
>>> +static int fpga_image_prog_transition(struct fpga_image_load *imgld,
>>> +				      enum fpga_image_prog new_progress)
>>> +{
>>> +	int ret = 0;
>>> +
>>> +	mutex_lock(&imgld->lock);
>>> +	if (imgld->request_cancel) {
>>> +		imgld->err_progress = imgld->progress;
>>> +		imgld->err_code = FPGA_IMAGE_ERR_CANCELED;
>>> +		imgld->lops->cancel(imgld);
>>> +		ret = -ECANCELED;
>>> +	} else {
>>> +		imgld->progress = new_progress;
>>> +	}
>>> +	mutex_unlock(&imgld->lock);
>>> +	return ret;
>>> +}
>>> +
>>>   static void fpga_image_prog_complete(struct fpga_image_load *imgld)
>>>   {
>>>   	mutex_lock(&imgld->lock);
>>> @@ -77,8 +95,10 @@ static void fpga_image_do_load(struct work_struct *work)
>>>   		goto modput_exit;
>>>   	}
>>>   
>>> -	fpga_image_update_progress(imgld, FPGA_IMAGE_PROG_WRITING);
>>> -	while (imgld->remaining_size) {
>>> +	if (fpga_image_prog_transition(imgld, FPGA_IMAGE_PROG_WRITING))
>>> +		goto done;
>>> +
>>> +	while (imgld->remaining_size && !imgld->request_cancel) {
>>>   		ret = imgld->lops->write_blk(imgld, offset);
>>>   		if (ret != FPGA_IMAGE_ERR_NONE) {
>>>   			fpga_image_dev_error(imgld, ret);
>>> @@ -88,7 +108,9 @@ static void fpga_image_do_load(struct work_struct *work)
>>>   		offset = size - imgld->remaining_size;
>>>   	}
>>>   
>>> -	fpga_image_update_progress(imgld, FPGA_IMAGE_PROG_PROGRAMMING);
>>> +	if (fpga_image_prog_transition(imgld, FPGA_IMAGE_PROG_PROGRAMMING))
>>> +		goto done;
>>> +
>>>   	ret = imgld->lops->poll_complete(imgld);
>>>   	if (ret != FPGA_IMAGE_ERR_NONE)
>>>   		fpga_image_dev_error(imgld, ret);
>>> @@ -159,6 +181,7 @@ static int fpga_image_load_ioctl_write(struct fpga_image_load *imgld,
>>>   	imgld->remaining_size = wb.size;
>>>   	imgld->err_code = FPGA_IMAGE_ERR_NONE;
>>>   	imgld->progress = FPGA_IMAGE_PROG_STARTING;
>>> +	imgld->request_cancel = false;
>>>   	reinit_completion(&imgld->update_done);
>>>   	schedule_work(&imgld->work);
>>>   	return 0;
>>> @@ -189,7 +212,7 @@ static long fpga_image_load_ioctl(struct file *filp, unsigned int cmd,
>>>   				  unsigned long arg)
>>>   {
>>>   	struct fpga_image_load *imgld = filp->private_data;
>>> -	int ret = -ENOTTY;
>>> +	int ret = 0;
>>>   
>>>   	mutex_lock(&imgld->lock);
>>>   
>>> @@ -200,6 +223,17 @@ static long fpga_image_load_ioctl(struct file *filp, unsigned int cmd,
>>>   	case FPGA_IMAGE_LOAD_STATUS:
>>>   		ret = fpga_image_load_ioctl_status(imgld, arg);
>>>   		break;
>>> +	case FPGA_IMAGE_LOAD_CANCEL:
>>> +		if (imgld->progress == FPGA_IMAGE_PROG_PROGRAMMING)
>>> +			ret = -EBUSY;
>>> +		else if (imgld->progress == FPGA_IMAGE_PROG_IDLE)
>>> +			ret = -ENODEV;
>>> +		else
>>> +			imgld->request_cancel = true;
>>> +		break;
>>> +	default:
>>> +		ret = -ENOTTY;
>>> +		break;
>>>   	}
>>>   
>>>   	mutex_unlock(&imgld->lock);
>>> @@ -374,6 +408,9 @@ void fpga_image_load_unregister(struct fpga_image_load *imgld)
>>>   		goto unregister;
>>>   	}
>>>   
>>> +	if (imgld->progress != FPGA_IMAGE_PROG_PROGRAMMING)
>>> +		imgld->request_cancel = true;
>>> +
>> Why we cancel the programing rather than waiting for programing done?
> This isn't new - it is the way the security manager was implemented.
>
> Updates can take up to 40 minutes for the N3000. If a person tries
> to unload the driver modules, should we hang for 40 minutes? Or should
> we try to cancel the update and allow the module to be unloaded?
> I think it is reasonable to cancel the update (if possible) under these
> circumstances. What do you think?

I do not think stalling a shutdown for 40 minutes is good.

Is there a chance that cancelling would brick the card?

After restarting, can the hw detect an interrupted update ?

Tom

>
> - Russ
>
>> Thanks,
>> Yilun
>>
>>>   	mutex_unlock(&imgld->lock);
>>>   	wait_for_completion(&imgld->update_done);
>>>   
>>> diff --git a/include/linux/fpga/fpga-image-load.h b/include/linux/fpga/fpga-image-load.h
>>> index 68f3105b51d2..4e51b9fd1724 100644
>>> --- a/include/linux/fpga/fpga-image-load.h
>>> +++ b/include/linux/fpga/fpga-image-load.h
>>> @@ -52,6 +52,7 @@ struct fpga_image_load {
>>>   	enum fpga_image_prog progress;
>>>   	enum fpga_image_prog err_progress;	/* progress at time of failure */
>>>   	enum fpga_image_err err_code;		/* image load error code */
>>> +	bool request_cancel;
>>>   	bool driver_unload;
>>>   	struct eventfd_ctx *finished;
>>>   	void *priv;
>>> diff --git a/include/uapi/linux/fpga-image-load.h b/include/uapi/linux/fpga-image-load.h
>>> index 6a995bcc0fb7..8d0dfa1f9b77 100644
>>> --- a/include/uapi/linux/fpga-image-load.h
>>> +++ b/include/uapi/linux/fpga-image-load.h
>>> @@ -39,6 +39,7 @@ enum fpga_image_err {
>>>   
>>>   #define FPGA_IMAGE_LOAD_WRITE	_IOW(FPGA_IMAGE_LOAD_MAGIC, 0, struct fpga_image_write)
>>>   #define FPGA_IMAGE_LOAD_STATUS	_IOR(FPGA_IMAGE_LOAD_MAGIC, 1, struct fpga_image_status)
>>> +#define FPGA_IMAGE_LOAD_CANCEL	_IO(FPGA_IMAGE_LOAD_MAGIC, 2)
>>>   
>>>   /**
>>>    * FPGA_IMAGE_LOAD_WRITE - _IOW(FPGA_IMAGE_LOAD_MAGIC, 0,
>>> -- 
>>> 2.25.1

