Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 981A7407A10
	for <lists+linux-fpga@lfdr.de>; Sat, 11 Sep 2021 20:13:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232859AbhIKSOM (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sat, 11 Sep 2021 14:14:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:35953 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231866AbhIKSOK (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Sat, 11 Sep 2021 14:14:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631383976;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZOGvpMpDoC1kLlXx+PKy70ITmSGB25GbMp0YtkoCTFM=;
        b=Csh+lBbzTWmBqH618GXTGjtb0qPBy31eCavdL7c5IYhhLnSSIV29KlDPlCwO1Zual3mp8M
        FGalAaKDxvpdnHk7r/Kvh0KIDyj5LbbMY9lRYaIcaVqP0NbcxmO2CEsDKqozcUHB1yHGIZ
        7jCkB7QEXKN5a+udtIiM4XDumESP3xI=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-382-73UYR6yhPGakX41MaM9D3g-1; Sat, 11 Sep 2021 14:12:55 -0400
X-MC-Unique: 73UYR6yhPGakX41MaM9D3g-1
Received: by mail-qv1-f70.google.com with SMTP id v8-20020a0c9c08000000b003784e86dd0eso50334857qve.2
        for <linux-fpga@vger.kernel.org>; Sat, 11 Sep 2021 11:12:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=ZOGvpMpDoC1kLlXx+PKy70ITmSGB25GbMp0YtkoCTFM=;
        b=2p1aS+bJRVJlwsnXlF0N7CrnAqDIzxuN8deZdbPfu552MeWixPe/Po65Q5mmq1scki
         nn/XxPTVN1+x624gtPE+UUL0iC7OnezgAsQCdsR8bSoyY5Mab7SKvCrhJP4Pn1Heu2DH
         ryhuwxR7Ei90kp57kAsxDuZDaD2Wdk1Eq7A+AkkXlFehY++Uf+YfEaI4Aj5mwOCUGYrm
         9dTZhnv4r9chl0UTgPLbsIL9i4ow1Mlz8FnZXPFk+lsV0rFt/6eQi0/JwsBas5vfhYpl
         NCpzwbYXWUnJ83n5MqgA2YP/4xakIYdyx8GE3zUlOqTfAYrsWxcSSB6aq56fSKUIQ5q5
         KgFQ==
X-Gm-Message-State: AOAM532rt//B8Y49GsPRzzIM2Jd8isgaQav6dvIUQkOrUOZr/6FUPelK
        nQVoZ0SeH0qWFs/Cbjh92rzogRQyGdY3l8rcr+064z+DCkV3MsXwFWhfP3rRYP9wCDGbZe3VfZg
        N6xETR3d/dBBEfM9wdwzKwQ==
X-Received: by 2002:a05:620a:2045:: with SMTP id d5mr2967333qka.281.1631383974402;
        Sat, 11 Sep 2021 11:12:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzHTVLnfu0AG0I+FcuyKGF3FTej+zIo+usbExaOM5+zjJ3g3db0edbVxlh9TQZ3FK/xEPyvtQ==
X-Received: by 2002:a05:620a:2045:: with SMTP id d5mr2967301qka.281.1631383974113;
        Sat, 11 Sep 2021 11:12:54 -0700 (PDT)
Received: from localhost.localdomain (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id p14sm1393769qtq.43.2021.09.11.11.12.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Sep 2021 11:12:53 -0700 (PDT)
Subject: Re: [PATCH v15 4/6] fpga: image-load: add status ioctl
To:     Russ Weight <russell.h.weight@intel.com>,
        Xu Yilun <yilun.xu@intel.com>
Cc:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, lgoncalv@redhat.com,
        hao.wu@intel.com, matthew.gerlach@intel.com
References: <20210909021846.681121-1-russell.h.weight@intel.com>
 <20210909021846.681121-5-russell.h.weight@intel.com>
 <20210910085005.GC754505@yilunxu-OptiPlex-7050>
 <4ea07b83-f592-749e-80c3-27ed144171bc@intel.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <015f7401-3bf6-e2be-ec53-388e0e9d2fe1@redhat.com>
Date:   Sat, 11 Sep 2021 11:12:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <4ea07b83-f592-749e-80c3-27ed144171bc@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 9/10/21 4:23 PM, Russ Weight wrote:
>
> On 9/10/21 1:50 AM, Xu Yilun wrote:
>> On Wed, Sep 08, 2021 at 07:18:44PM -0700, Russ Weight wrote:
>>> Extend the FPGA Image Load class driver to include an
>>> FPGA_IMAGE_LOAD_STATUS IOCTL that can be used to monitor the progress
>>> of an ongoing image load.  The status returned includes how much data
>>> remains to be transferred, the progress of the image load, and error
>>> information in the case of a failure.
>>>
>>> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
>>> ---
>>> V15:
>>>   - This patch is new to the patchset and provides an FPGA_IMAGE_LOAD_STATUS
>>>     IOCTL to return the current values for: remaining_size, progress,
>>>     err_progress, and err_code.
>>>   - This patch has elements of the following three patches from the previous
>>>     patch-set:
>>>       [PATCH v14 3/6] fpga: sec-mgr: expose sec-mgr update status
>>>       [PATCH v14 4/6] fpga: sec-mgr: expose sec-mgr update errors
>>>       [PATCH v14 5/6] fpga: sec-mgr: expose sec-mgr update size
>>>   - Changed file, symbol, and config names to reflect the new driver name
>>>   - There are some minor changes to locking to enable this ioctl to return
>>>     coherent data.
>>> ---
>>>   Documentation/fpga/fpga-image-load.rst |  6 +++
>>>   drivers/fpga/fpga-image-load.c         | 53 ++++++++++++++++++++++----
>>>   include/uapi/linux/fpga-image-load.h   | 18 +++++++++
>>>   3 files changed, 70 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/Documentation/fpga/fpga-image-load.rst b/Documentation/fpga/fpga-image-load.rst
>>> index 739d735592a5..3d5eb51223e3 100644
>>> --- a/Documentation/fpga/fpga-image-load.rst
>>> +++ b/Documentation/fpga/fpga-image-load.rst
>>> @@ -31,3 +31,9 @@ updated. This is an exclusive operation; an attempt to start concurrent image
>>>   load for the same device will fail with EBUSY. An eventfd file descriptor
>>>   parameter is provided to this IOCTL, and it will be signalled at the
>>>   completion of the image load.
>>> +
>>> +FPGA_IMAGE_LOAD_STATUS:
>>> +
>>> +Collect status for an on-going image upload. The status returned includes
>>> +how much data remains to be transferred, the progress of the image load,
>>> +and error information in the case of a failure.
>>> diff --git a/drivers/fpga/fpga-image-load.c b/drivers/fpga/fpga-image-load.c
>>> index b784456765b0..99a47b21c995 100644
>>> --- a/drivers/fpga/fpga-image-load.c
>>> +++ b/drivers/fpga/fpga-image-load.c
>>> @@ -22,10 +22,27 @@ static dev_t fpga_image_devt;
>>>   
>>>   #define to_image_load(d) container_of(d, struct fpga_image_load, dev)
>>>   
>>> -static void fpga_image_dev_error(struct fpga_image_load *imgld,
>>> +static void fpga_image_update_progress(struct fpga_image_load *imgld,
>>> +				       enum fpga_image_prog new_progress)
>>> +{
>>> +	mutex_lock(&imgld->lock);
>>> +	imgld->progress = new_progress;
>>> +	mutex_unlock(&imgld->lock);
>>> +}
>>> +
>>> +static void fpga_image_set_error(struct fpga_image_load *imgld,
>>>   				 enum fpga_image_err err_code)
>>>   {
>>> +	mutex_lock(&imgld->lock);
>>> +	imgld->err_progress = imgld->progress;
>>>   	imgld->err_code = err_code;
>>> +	mutex_unlock(&imgld->lock);
>>> +}
>>> +
>>> +static void fpga_image_dev_error(struct fpga_image_load *imgld,
>>> +				 enum fpga_image_err err_code)
>>> +{
>>> +	fpga_image_set_error(imgld, err_code);
>>>   	imgld->lops->cancel(imgld);
>>>   }
>>>   
>>> @@ -49,18 +66,18 @@ static void fpga_image_do_load(struct work_struct *work)
>>>   
>>>   	get_device(&imgld->dev);
>>>   	if (!try_module_get(imgld->dev.parent->driver->owner)) {
>>> -		imgld->err_code = FPGA_IMAGE_ERR_BUSY;
>>> +		fpga_image_set_error(imgld, FPGA_IMAGE_ERR_BUSY);
>>>   		goto idle_exit;
>>>   	}
>>>   
>>> -	imgld->progress = FPGA_IMAGE_PROG_PREPARING;
>>> +	fpga_image_update_progress(imgld, FPGA_IMAGE_PROG_PREPARING);
>>>   	ret = imgld->lops->prepare(imgld);
>>>   	if (ret != FPGA_IMAGE_ERR_NONE) {
>>>   		fpga_image_dev_error(imgld, ret);
>>>   		goto modput_exit;
>>>   	}
>>>   
>>> -	imgld->progress = FPGA_IMAGE_PROG_WRITING;
>>> +	fpga_image_update_progress(imgld, FPGA_IMAGE_PROG_WRITING);
>>>   	while (imgld->remaining_size) {
>>>   		ret = imgld->lops->write_blk(imgld, offset);
>>>   		if (ret != FPGA_IMAGE_ERR_NONE) {
>>> @@ -71,7 +88,7 @@ static void fpga_image_do_load(struct work_struct *work)
>>>   		offset = size - imgld->remaining_size;
>>>   	}
>>>   
>>> -	imgld->progress = FPGA_IMAGE_PROG_PROGRAMMING;
>>> +	fpga_image_update_progress(imgld, FPGA_IMAGE_PROG_PROGRAMMING);
>>>   	ret = imgld->lops->poll_complete(imgld);
>>>   	if (ret != FPGA_IMAGE_ERR_NONE)
>>>   		fpga_image_dev_error(imgld, ret);
>>> @@ -151,20 +168,42 @@ static int fpga_image_load_ioctl_write(struct fpga_image_load *imgld,
>>>   	return ret;
>>>   }
>>>   
>>> +static int fpga_image_load_ioctl_status(struct fpga_image_load *imgld,
>>> +					unsigned long arg)
>>> +{
>>> +	struct fpga_image_status status;
>>> +
>>> +	memset(&status, 0, sizeof(status));
>>> +	status.progress = imgld->progress;
>>> +	status.remaining_size = imgld->remaining_size;
>>> +	status.err_progress = imgld->err_progress;
>>> +	status.err_code = imgld->err_code;
>>> +
>>> +	if (copy_to_user((void __user *)arg, &status, sizeof(status)))
>>> +		return -EFAULT;
>>> +
>>> +	return 0;
>>> +}
>>> +
>>>   static long fpga_image_load_ioctl(struct file *filp, unsigned int cmd,
>>>   				  unsigned long arg)
>>>   {
>>>   	struct fpga_image_load *imgld = filp->private_data;
>>>   	int ret = -ENOTTY;
>>>   
>>> +	mutex_lock(&imgld->lock);
>>> +
>>>   	switch (cmd) {
>>>   	case FPGA_IMAGE_LOAD_WRITE:
>>> -		mutex_lock(&imgld->lock);
>>>   		ret = fpga_image_load_ioctl_write(imgld, arg);
>>> -		mutex_unlock(&imgld->lock);
>>> +		break;
>>> +	case FPGA_IMAGE_LOAD_STATUS:
>>> +		ret = fpga_image_load_ioctl_status(imgld, arg);
>>>   		break;
>>>   	}
>>>   
>>> +	mutex_unlock(&imgld->lock);
>>> +
>>>   	return ret;
>>>   }
>>>   
>>> diff --git a/include/uapi/linux/fpga-image-load.h b/include/uapi/linux/fpga-image-load.h
>>> index a60da115adf5..6a995bcc0fb7 100644
>>> --- a/include/uapi/linux/fpga-image-load.h
>>> +++ b/include/uapi/linux/fpga-image-load.h
>>> @@ -38,6 +38,7 @@ enum fpga_image_err {
>>>   };
>>>   
>>>   #define FPGA_IMAGE_LOAD_WRITE	_IOW(FPGA_IMAGE_LOAD_MAGIC, 0, struct fpga_image_write)
>>> +#define FPGA_IMAGE_LOAD_STATUS	_IOR(FPGA_IMAGE_LOAD_MAGIC, 1, struct fpga_image_status)
>>>   
>>>   /**
>>>    * FPGA_IMAGE_LOAD_WRITE - _IOW(FPGA_IMAGE_LOAD_MAGIC, 0,
>>> @@ -56,4 +57,21 @@ struct fpga_image_write {
>>>   	__u64 buf;		/* User space address of source data */
>>>   };
>>>   
>>> +/**
>>> + * FPGA_IMAGE_LOAD_STATUS - _IOR(FPGA_IMAGE_LOAD_MAGIC, 1,
>>> + *				 struct fpga_image_status)
>>> + *
>>> + * Request status information for an ongoing update.
>>> + * data buffer, size, and an eventfd file descriptor.
>> This line is a typo.
> Thanks - I'll fix it.
>>> + *
>>> + * Return: 0 on success, -errno on failure.
>>> + */
>>> +struct fpga_image_status {
>>> +	/* Output */
>>> +	__u32 remaining_size;			/* size remaining to transfer */
>>> +	enum fpga_image_prog progress;		/* current progress of image load */
>>> +	enum fpga_image_prog err_progress;	/* progress at time of error */
>>> +	enum fpga_image_err err_code;		/* error code */
>> Should we use __u32 for these enumeration types?
> We could, but I did see a lot of uapi header file examples that use
> enum for IOCTL structures. Is there a reason to prefer __u32? If I change
> these to __u32, then I suppose I need to change from enum declarations to
> #define macros?

The __u32 makes sure the struct is a constant size.

yes, change the enums to #defines.

The layout of a new api should be consistent with similar older api.

review uapi/linux/fpga-dfl.h , the dfl_fpga_port_region_info struct.

Tom


> - Russ
>
>> Thanks,
>> Yilun
>>
>>> +};
>>> +
>>>   #endif /* _UAPI_LINUX_FPGA_IMAGE_LOAD_H */
>>> -- 
>>> 2.25.1

