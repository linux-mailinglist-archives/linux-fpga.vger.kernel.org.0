Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DD8C407A0B
	for <lists+linux-fpga@lfdr.de>; Sat, 11 Sep 2021 19:58:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232447AbhIKR7i (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sat, 11 Sep 2021 13:59:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:35642 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233270AbhIKR7h (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Sat, 11 Sep 2021 13:59:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631383104;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I23sL43WTtF7oayx0KMEoNg2rnvX/euM2ChSLz1boDI=;
        b=P903HSIcUT6/oH6Bq3EHJkv0xIl1CeBFTgfrMKAr+ItIbpXbwol6B30jpfNgR63LLOoxY3
        S2k9Pb2suixMFoWpO8cHJYlPHJLHJtM/vCA4VRRAafJYfE7Ou2Xolll2zx7ykI1YXdNN8I
        fBLpNVYPD2CwVwZ4/DG/XGy2ULtOCFI=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-400-nfjeJD1bMOmCDzH5BE4Kkg-1; Sat, 11 Sep 2021 13:58:20 -0400
X-MC-Unique: nfjeJD1bMOmCDzH5BE4Kkg-1
Received: by mail-qk1-f197.google.com with SMTP id y185-20020a3764c20000b02903d2c78226ceso35915693qkb.6
        for <linux-fpga@vger.kernel.org>; Sat, 11 Sep 2021 10:58:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=I23sL43WTtF7oayx0KMEoNg2rnvX/euM2ChSLz1boDI=;
        b=i6T1by/0IEa6DUOoPJXE1Ff9VBFfbdpqnFcaPwMsXR9V/Ut51sEgpnWPfzeWVEYErN
         H0l4u300M1zAg3G910NIQQ4aSfuT/QfZdJLca7koy2eSS+zfxcY3mABFDfp3VX2PN0yU
         jA49i71HP7Vs+1BtySiRwmWugA/DzrL+tKG9USUJhs//P8jGaG96gwXQO5ERpjBdTaMU
         HqI4RAmB7kktZ2AdUX5vuIpYvPZAl2t1K0+DNa0p/reSEnOi4kUJnQz3rft0rbDvWTLL
         XUp0JbKRtystIPltLVM20t7vCAxOd6RDcbEHj7PF2qE6yhNwUOy6svJzvHP/n4ZjgliT
         s3Ng==
X-Gm-Message-State: AOAM5307HoQ2qO/UOjuNe2AzWeQGbKxyKxRfmntTXzT0hmW6CBSyZdMj
        Ge71eFwrug9mXJ4sQB0Y2EN/0dcepvY8AWjgBvKrLcMyxlbsFLMfQQDyziX6GgHpnLLPzpbHAL0
        mtNBNdrirN7/LHkmT6tu6Bw==
X-Received: by 2002:a05:620a:20c5:: with SMTP id f5mr3005498qka.204.1631383100285;
        Sat, 11 Sep 2021 10:58:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJymDdjCPbHVH97P8/R1kSSzAiZo9S5ymopq3gEF4k0QYrP47pLqKz6gCGhcrdyuMpUG9KKr3w==
X-Received: by 2002:a05:620a:20c5:: with SMTP id f5mr3005478qka.204.1631383100007;
        Sat, 11 Sep 2021 10:58:20 -0700 (PDT)
Received: from localhost.localdomain (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id t194sm1658145qka.72.2021.09.11.10.58.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Sep 2021 10:58:19 -0700 (PDT)
Subject: Re: [PATCH v15 5/6] fpga: image-load: create status sysfs node
To:     Russ Weight <russell.h.weight@intel.com>,
        Xu Yilun <yilun.xu@intel.com>
Cc:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, lgoncalv@redhat.com,
        hao.wu@intel.com, matthew.gerlach@intel.com
References: <20210909021846.681121-1-russell.h.weight@intel.com>
 <20210909021846.681121-6-russell.h.weight@intel.com>
 <20210910085238.GD754505@yilunxu-OptiPlex-7050>
 <bc14ba58-a457-68dc-ca59-720adaa32524@intel.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <ae637d01-b6c1-4b7f-a536-449e27c7711d@redhat.com>
Date:   Sat, 11 Sep 2021 10:58:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <bc14ba58-a457-68dc-ca59-720adaa32524@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 9/10/21 4:30 PM, Russ Weight wrote:
>
> On 9/10/21 1:52 AM, Xu Yilun wrote:
>> On Wed, Sep 08, 2021 at 07:18:45PM -0700, Russ Weight wrote:
>>> Extend the FPGA Image Load class driver to include a status sysfs node that
>>> can be viewed to determine from the command line if an image load is in
>>> progress. Status will be one of: idle, starting, preparing, writing, or
>>> programming.
>> The FPGA_IMAGE_LOAD_STATUS ioctl already provides the progress info.
>> Why we need 2 user interfaces for the same information?
> Updates on Vista Creek can take up to 40 minutes. I thought it might
> be helpful to have a simple way, from the command line, to verify
> whether or not there is an image upload in progress. Do you agree? Or
> do you think this is unnecessary? Should I remove it? Or save it for
> a later patch (after the main patches have been accepted)?

I agree, there should not be two methods to doing the same thing.

I prefer the ioctl since it handles other cmd's as well.

The user has to use the ioctl to start the write so it would for more 
natural to use the ioctl over sysfs to the check the status

Remove it.

Make a strong case for it's need when/if you want to add it back later.

Tom

>
> - Russ
>
>> Thanks,
>> Yilun
>>
>>> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
>>> ---
>>> v15:
>>>   - Compare to previous patch:
>>>       [PATCH v14 3/6] fpga: sec-mgr: expose sec-mgr update status
>>>   - Changed file, symbol, and config names to reflect the new driver name
>>>   - Removed signed-off/reviewed-by tags
>>> v14:
>>>   - Updated ABI documentation date and kernel version
>>> v13:
>>>    - No change
>>> v12:
>>>    - Updated Date and KernelVersion fields in ABI documentation
>>>    - Changed syntax of sec_mgr_prog_str[] array definition from:
>>> 	"idle",			/* FPGA_SEC_PROG_IDLE */
>>>      to:
>>> 	[FPGA_SEC_PROG_IDLE]	    = "idle",
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
>>>    - Use new function sysfs_emit() in the status_show() function
>>> v4:
>>>    - Changed from "Intel FPGA Security Manager" to FPGA Security Manager"
>>>      and removed unnecessary references to "Intel".
>>>    - Changed: iops -> sops, imgr -> smgr, IFPGA_ -> FPGA_, ifpga_ to fpga_
>>> v3:
>>>    - Use a local variable to read progress once in status_show()
>>>    - Use dev_err to report invalid progress status
>>> v2:
>>>    - Bumped documentation date and version
>>>    - Changed progress state "read_file" to "reading"
>>> ---
>>>   .../ABI/testing/sysfs-class-fpga-image-load   |  7 ++++
>>>   MAINTAINERS                                   |  1 +
>>>   drivers/fpga/fpga-image-load.c                | 33 +++++++++++++++++++
>>>   3 files changed, 41 insertions(+)
>>>   create mode 100644 Documentation/ABI/testing/sysfs-class-fpga-image-load
>>>
>>> diff --git a/Documentation/ABI/testing/sysfs-class-fpga-image-load b/Documentation/ABI/testing/sysfs-class-fpga-image-load
>>> new file mode 100644
>>> index 000000000000..6c04a49f01cc
>>> --- /dev/null
>>> +++ b/Documentation/ABI/testing/sysfs-class-fpga-image-load
>>> @@ -0,0 +1,7 @@
>>> +What: 		/sys/class/fpga_image_load/fpga_imageX/status
>>> +Date:		Aug 2021
>>> +KernelVersion:	5.15
>>> +Contact:	Russ Weight <russell.h.weight@intel.com>
>>> +Description:	Read-only. Returns a string describing the current status
>>> +		of an FPGA image upload. The string will be one of the
>>> +		following: idle, starting, preparing, writing, programming.
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index 637bc003ca81..e3fbc1bde9bc 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -7362,6 +7362,7 @@ FPGA SECURITY MANAGER DRIVERS
>>>   M:	Russ Weight <russell.h.weight@intel.com>
>>>   L:	linux-fpga@vger.kernel.org
>>>   S:	Maintained
>>> +F:	Documentation/ABI/testing/sysfs-class-fpga-image-load
>>>   F:	Documentation/fpga/fpga-image-load.rst
>>>   F:	drivers/fpga/fpga-image-load.c
>>>   F:	include/linux/fpga/fpga-image-load.h
>>> diff --git a/drivers/fpga/fpga-image-load.c b/drivers/fpga/fpga-image-load.c
>>> index 99a47b21c995..6ec0a39f07b3 100644
>>> --- a/drivers/fpga/fpga-image-load.c
>>> +++ b/drivers/fpga/fpga-image-load.c
>>> @@ -236,6 +236,38 @@ static const struct file_operations fpga_image_load_fops = {
>>>   	.unlocked_ioctl = fpga_image_load_ioctl,
>>>   };
>>>   
>>> +static const char * const image_load_prog_str[] = {
>>> +	[FPGA_IMAGE_PROG_IDLE]	      = "idle",
>>> +	[FPGA_IMAGE_PROG_STARTING]    = "starting",
>>> +	[FPGA_IMAGE_PROG_PREPARING]   = "preparing",
>>> +	[FPGA_IMAGE_PROG_WRITING]     = "writing",
>>> +	[FPGA_IMAGE_PROG_PROGRAMMING] = "programming"
>>> +};
>>> +
>>> +static ssize_t
>>> +status_show(struct device *dev, struct device_attribute *attr, char *buf)
>>> +{
>>> +	struct fpga_image_load *imgld = to_image_load(dev);
>>> +	const char *status = "unknown-status";
>>> +	enum fpga_image_prog progress;
>>> +
>>> +	progress = imgld->progress;
>>> +	if (progress < FPGA_IMAGE_PROG_MAX)
>>> +		status = image_load_prog_str[progress];
>>> +	else
>>> +		dev_err(dev, "Invalid status during secure update: %d\n",
>>> +			progress);
>>> +
>>> +	return sysfs_emit(buf, "%s\n", status);
>>> +}
>>> +static DEVICE_ATTR_RO(status);
>>> +
>>> +static struct attribute *fpga_image_load_attrs[] = {
>>> +	&dev_attr_status.attr,
>>> +	NULL,
>>> +};
>>> +ATTRIBUTE_GROUPS(fpga_image_load);
>>> +
>>>   /**
>>>    * fpga_image_load_register - create and register an FPGA Image Load Device
>>>    *
>>> @@ -373,6 +405,7 @@ static int __init fpga_image_load_class_init(void)
>>>   	if (ret)
>>>   		goto exit_destroy_class;
>>>   
>>> +	fpga_image_load_class->dev_groups = fpga_image_load_groups;
>>>   	fpga_image_load_class->dev_release = fpga_image_load_dev_release;
>>>   
>>>   	return 0;
>>> -- 
>>> 2.25.1

