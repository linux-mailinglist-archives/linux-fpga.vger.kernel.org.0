Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F280969AB04
	for <lists+linux-fpga@lfdr.de>; Fri, 17 Feb 2023 13:07:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbjBQMFx (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 17 Feb 2023 07:05:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjBQMFw (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 17 Feb 2023 07:05:52 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A633E644DD
        for <linux-fpga@vger.kernel.org>; Fri, 17 Feb 2023 04:05:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676635509;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MeZ8ZIY1zOjEqjndKoMlTNhFCshjmhCchSEF4RkJN3A=;
        b=iRaysUEiunQz/Hw49po6/3wY2uyWO3RXHWioDDg1qjoUDs8Vfn/xnzbEfABaKb/yR2UH4Y
        YkHtK8CqkxNKSPhCK5wCKieHny4mgwbN5e1N8s9u5V5sktxerU5ePDowcNYHVcbEnSVybq
        GqrOd5whRoSykQWXO7VRSP3H3+6wc0w=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-670-9GbWROGxMnmu7fyxo0QdYQ-1; Fri, 17 Feb 2023 07:05:08 -0500
X-MC-Unique: 9GbWROGxMnmu7fyxo0QdYQ-1
Received: by mail-qt1-f198.google.com with SMTP id p18-20020ac84612000000b003ba3c280fabso179662qtn.2
        for <linux-fpga@vger.kernel.org>; Fri, 17 Feb 2023 04:05:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MeZ8ZIY1zOjEqjndKoMlTNhFCshjmhCchSEF4RkJN3A=;
        b=aiac37Fxl4vB0+xU2Gk9dA44CnMZfs91R3IRTKXD46KwFX9zhh6WMEigODrWsH/8vd
         MhCdRso1Tj5uOO22ua4ZCkGXpeJkdR7PLhJnyGX+je/HhDptIpjb8HgvforE6y7eBb9d
         QH5L0rNkON/XicT/s355d2G0dG/kV2+NRXXzYC6yjuZ8kJLC8UMQe+fsVgXAkMuCc/9z
         lqyCKP5zOP16vpF/rsaU9IxGoN003c6Qa+bZbXiP/NXh3t4LcZIZArbhzpKU88WNQieW
         E0DHXW0frfk6zMGJkxTyuMGiqU+6cYbcp4fMeuUjU19yD4zntYRG2BSNFRnsgr8y1UU8
         uglA==
X-Gm-Message-State: AO0yUKXOB3fxSYvv8UnQFs1QdvZB8/CGbmEHA2ZSU7GQeaiE0K8ertEF
        WDpjrwIOCj25jGdlSDWopol3cvKAAAg021J9GrKEzmRKzgGAKUXUPRlHB8skegXloQ8P9anEs4n
        z6PxMqRtGz2MyZJi9NDez
X-Received: by 2002:ac8:5a43:0:b0:3b8:3391:bde5 with SMTP id o3-20020ac85a43000000b003b83391bde5mr1862476qta.26.1676635508269;
        Fri, 17 Feb 2023 04:05:08 -0800 (PST)
X-Google-Smtp-Source: AK7set9vu+JJtAzOiIVcSatdvoOydcZVm8RnYaOetCCeIlhUKYkTJk3f3mzKzsaA1fup3DVktpT3OA==
X-Received: by 2002:ac8:5a43:0:b0:3b8:3391:bde5 with SMTP id o3-20020ac85a43000000b003b83391bde5mr1862441qta.26.1676635507987;
        Fri, 17 Feb 2023 04:05:07 -0800 (PST)
Received: from [192.168.9.16] (net-2-34-30-183.cust.vodafonedsl.it. [2.34.30.183])
        by smtp.gmail.com with ESMTPSA id s4-20020a372c04000000b006f9f3c0c63csm3179081qkh.32.2023.02.17.04.05.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Feb 2023 04:05:07 -0800 (PST)
Message-ID: <ddd17066-ce40-118b-28d8-33e14a3de876@redhat.com>
Date:   Fri, 17 Feb 2023 13:05:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] fpga: mgr: Update the state to provide the exact error
 code
To:     "Manne, Nava kishore" <nava.kishore.manne@amd.com>
Cc:     Nava kishore Manne <nava.manne@xilinx.com>,
        "mdf@kernel.org" <mdf@kernel.org>,
        "hao.wu@intel.com" <hao.wu@intel.com>,
        "trix@redhat.com" <trix@redhat.com>,
        "yilun.xu@intel.com" <yilun.xu@intel.com>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20230207095915.169146-1-nava.kishore.manne@amd.com>
 <8d34bc43-deb4-4166-83ad-34561ee5ac33@redhat.com>
 <DM6PR12MB3993232B3EB5DE00CBC9B452CDD89@DM6PR12MB3993.namprd12.prod.outlook.com>
 <c69b76d8-fc72-b52f-4c64-b8c4cd498649@redhat.com>
 <DM6PR12MB399309D9406A79D58BB7C763CDDD9@DM6PR12MB3993.namprd12.prod.outlook.com>
Content-Language: en-US
From:   Marco Pagani <marpagan@redhat.com>
In-Reply-To: <DM6PR12MB399309D9406A79D58BB7C763CDDD9@DM6PR12MB3993.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



On 2023-02-13 06:50, Manne, Nava kishore wrote:
> Hi Marco,
> 
> 	Please find my response inline.
> 
>> -----Original Message-----
>> From: Marco Pagani <marpagan@redhat.com>
>> Sent: Thursday, February 9, 2023 3:52 AM
>> To: Manne, Nava kishore <nava.kishore.manne@amd.com>
>> Cc: Nava kishore Manne <nava.manne@xilinx.com>; mdf@kernel.org;
>> hao.wu@intel.com; trix@redhat.com; yilun.xu@intel.com; linux-
>> fpga@vger.kernel.org; linux-kernel@vger.kernel.org
>> Subject: Re: [PATCH] fpga: mgr: Update the state to provide the exact error
>> code
>>
>>
>> On 2023-02-08 12:01, Manne, Nava kishore wrote:
>>> Hi Marco,
>>>
>>> 	Thanks for providing the review comments.
>>> Please find my response inline below.
>>>
>>>> -----Original Message-----
>>>> From: Marco Pagani <marpagan@redhat.com>
>>>> Sent: Wednesday, February 8, 2023 12:04 AM
>>>> To: Nava kishore Manne <nava.manne@xilinx.com>
>>>> Cc: Manne, Nava kishore <nava.kishore.manne@amd.com>;
>> mdf@kernel.org;
>>>> hao.wu@intel.com; trix@redhat.com; yilun.xu@intel.com;
>>>> linux-fpga@vger.kernel.org; linux-kernel@vger.kernel.org
>>>> Subject: Re: [PATCH] fpga: mgr: Update the state to provide the exact
>>>> error code
>>>>
>>>>
>>>> On 2023-02-07 10:59, Nava kishore Manne wrote:
>>>>> From: Nava kishore Manne <nava.manne@xilinx.com>
>>>>>
>>>>> Up on fpga configuration failure, the existing sysfs state interface
>>>>> is just providing the generic error message rather than providing
>>>>> the exact error code. This patch extends sysfs state interface to
>>>>> provide the exact error received from the lower layer along with the
>>>>> existing generic error message.
>>>>>
>>>>> Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
>>>>> ---
>>>>>  drivers/fpga/fpga-mgr.c       | 20 +++++++++++++++++++-
>>>>>  include/linux/fpga/fpga-mgr.h |  2 ++
>>>>>  2 files changed, 21 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c index
>>>>> 8efa67620e21..b2d74705a5a2 100644
>>>>> --- a/drivers/fpga/fpga-mgr.c
>>>>> +++ b/drivers/fpga/fpga-mgr.c
>>>>> @@ -61,12 +61,14 @@ static inline int fpga_mgr_write_complete(struct
>>>>> fpga_manager *mgr,  {
>>>>>  	int ret = 0;
>>>>>
>>>>> +	mgr->err = 0;
>>>>>  	mgr->state = FPGA_MGR_STATE_WRITE_COMPLETE;
>>>>>  	if (mgr->mops->write_complete)
>>>>>  		ret = mgr->mops->write_complete(mgr, info);
>>>>>  	if (ret) {
>>>>>  		dev_err(&mgr->dev, "Error after writing image data to
>>>> FPGA\n");
>>>>>  		mgr->state = FPGA_MGR_STATE_WRITE_COMPLETE_ERR;
>>>>> +		mgr->err = ret;
>>>>>  		return ret;
>>>>>  	}
>>>>>  	mgr->state = FPGA_MGR_STATE_OPERATING; @@ -154,6 +156,7 @@
>>>> static
>>>>> int fpga_mgr_parse_header_mapped(struct fpga_manager *mgr,  {
>>>>>  	int ret;
>>>>>
>>>>> +	mgr->err = 0;
>>>>>  	mgr->state = FPGA_MGR_STATE_PARSE_HEADER;
>>>>>  	ret = fpga_mgr_parse_header(mgr, info, buf, count);
>>>>>
>>>>> @@ -165,6 +168,7 @@ static int
>> fpga_mgr_parse_header_mapped(struct
>>>> fpga_manager *mgr,
>>>>>  	if (ret) {
>>>>>  		dev_err(&mgr->dev, "Error while parsing FPGA image
>>>> header\n");
>>>>>  		mgr->state = FPGA_MGR_STATE_PARSE_HEADER_ERR;
>>>>> +		mgr->err = ret;
>>>>>  	}
>>>>>
>>>>>  	return ret;
>>>>> @@ -185,6 +189,7 @@ static int fpga_mgr_parse_header_sg_first(struct
>>>> fpga_manager *mgr,
>>>>>  	int ret;
>>>>>
>>>>>  	mgr->state = FPGA_MGR_STATE_PARSE_HEADER;
>>>>> +	mgr->err = 0;
>>>>>
>>>>>  	sg_miter_start(&miter, sgt->sgl, sgt->nents, SG_MITER_FROM_SG);
>>>>>  	if (sg_miter_next(&miter) &&
>>>>> @@ -197,6 +202,7 @@ static int fpga_mgr_parse_header_sg_first(struct
>>>> fpga_manager *mgr,
>>>>>  	if (ret && ret != -EAGAIN) {
>>>>>  		dev_err(&mgr->dev, "Error while parsing FPGA image
>>>> header\n");
>>>>>  		mgr->state = FPGA_MGR_STATE_PARSE_HEADER_ERR;
>>>>> +		mgr->err = ret;
>>>>>  	}
>>>>>
>>>>>  	return ret;
>>>>> @@ -249,6 +255,7 @@ static void *fpga_mgr_parse_header_sg(struct
>>>> fpga_manager *mgr,
>>>>>  	if (ret) {
>>>>>  		dev_err(&mgr->dev, "Error while parsing FPGA image
>>>> header\n");
>>>>>  		mgr->state = FPGA_MGR_STATE_PARSE_HEADER_ERR;
>>>>> +		mgr->err = ret;
>>>>>  		kfree(buf);
>>>>>  		buf = ERR_PTR(ret);
>>>>>  	}
>>>>> @@ -272,6 +279,7 @@ static int fpga_mgr_write_init_buf(struct
>>>> fpga_manager *mgr,
>>>>>  	size_t header_size = info->header_size;
>>>>>  	int ret;
>>>>>
>>>>> +	mgr->err = 0;
>>>>>  	mgr->state = FPGA_MGR_STATE_WRITE_INIT;
>>>>>
>>>>>  	if (header_size > count)
>>>>> @@ -284,6 +292,7 @@ static int fpga_mgr_write_init_buf(struct
>>>> fpga_manager *mgr,
>>>>>  	if (ret) {
>>>>>  		dev_err(&mgr->dev, "Error preparing FPGA for writing\n");
>>>>>  		mgr->state = FPGA_MGR_STATE_WRITE_INIT_ERR;
>>>>> +		mgr->err = ret;
>>>>>  		return ret;
>>>>>  	}
>>>>>
>>>>> @@ -370,6 +379,7 @@ static int fpga_mgr_buf_load_sg(struct
>>>>> fpga_manager *mgr,
>>>>>
>>>>>  	/* Write the FPGA image to the FPGA. */
>>>>>  	mgr->state = FPGA_MGR_STATE_WRITE;
>>>>> +	mgr->err = 0;
>>>>>  	if (mgr->mops->write_sg) {
>>>>>  		ret = fpga_mgr_write_sg(mgr, sgt);
>>>>>  	} else {
>>>>> @@ -405,6 +415,7 @@ static int fpga_mgr_buf_load_sg(struct
>>>> fpga_manager *mgr,
>>>>>  	if (ret) {
>>>>>  		dev_err(&mgr->dev, "Error while writing image data to
>>>> FPGA\n");
>>>>>  		mgr->state = FPGA_MGR_STATE_WRITE_ERR;
>>>>> +		mgr->err = ret;
>>>>>  		return ret;
>>>>>  	}
>>>>>
>>>>> @@ -437,10 +448,12 @@ static int fpga_mgr_buf_load_mapped(struct
>>>> fpga_manager *mgr,
>>>>>  	 * Write the FPGA image to the FPGA.
>>>>>  	 */
>>>>>  	mgr->state = FPGA_MGR_STATE_WRITE;
>>>>> +	mgr->err = 0;
>>>>>  	ret = fpga_mgr_write(mgr, buf, count);
>>>>>  	if (ret) {
>>>>>  		dev_err(&mgr->dev, "Error while writing image data to
>>>> FPGA\n");
>>>>>  		mgr->state = FPGA_MGR_STATE_WRITE_ERR;
>>>>> +		mgr->err = ret;
>>>>>  		return ret;
>>>>>  	}
>>>>>
>>>>> @@ -544,10 +557,11 @@ static int fpga_mgr_firmware_load(struct
>>>> fpga_manager *mgr,
>>>>>  	dev_info(dev, "writing %s to %s\n", image_name, mgr->name);
>>>>>
>>>>>  	mgr->state = FPGA_MGR_STATE_FIRMWARE_REQ;
>>>>> -
>>>>> +	mgr->err = 0;
>>>>>  	ret = request_firmware(&fw, image_name, dev);
>>>>>  	if (ret) {
>>>>>  		mgr->state = FPGA_MGR_STATE_FIRMWARE_REQ_ERR;
>>>>> +		mgr->err = ret;
>>>>>  		dev_err(dev, "Error requesting firmware %s\n",
>>>> image_name);
>>>>>  		return ret;
>>>>>  	}
>>>>> @@ -626,6 +640,10 @@ static ssize_t state_show(struct device *dev,  {
>>>>>  	struct fpga_manager *mgr = to_fpga_manager(dev);
>>>>>
>>>>> +	if (mgr->err)
>>>>> +		return sprintf(buf, "%s: 0x%x\n",
>>>>> +			       state_str[mgr->state], mgr->err);
>>>>> +
>>>>>  	return sprintf(buf, "%s\n", state_str[mgr->state]);
>>>>
>>>>
>>>> If one of the fpga manager ops fails, the low-level error code is
>>>> already returned to the caller. Wouldn't it be better to rely on this
>>>> instead of printing the low-level error code in a sysfs attribute and sending
>> it to the userspace?
>>>>
>>> Agree, the low-level error code is already returned to the caller but
>>> the user application will not have any access to read this error info.
>>> So, I feel this patch provides that flexibility to the user application to get the
>> exact error info.
>>> please let me know if you have any other thoughts will implement that.
>>>
>>> Regards,
>>> Navakishore.
>>
>>
>> Hi Nava,
>>
>> Thanks for your quick reply. I understand the need to access the low-level
>> error code from userspace if the configuration goes wrong.
>>
>> However, in my understanding, the low-level driver is supposed to export
>> reconfiguration errors by implementing the status op and returning a bit field
>> set using the macros defined in fpga-mgr.h +189.
>> The fpga manager will, in turn, make the errors visible to userspace through
>> the status attribute. If the available error bits aren't descriptive enough,
>> wouldn't it be better to add more error macros instead of "overloading" the
>> state attribute?
>>
>> Moreover, it seems to me that if the reconfiguration is done by loading a
>> device tree overlay from userspace, the error code gets propagated back
>> through the notifier in of-fpga-region. Am I correct?
>>
> 
> AFAIK The state and status interface use cases are different. The Status interface will provide the H/W error info.
> whereas the state interface provides the FPGA manager driver state(including Error strings). 
> Please Refer: Documentation/ABI/testing/sysfs-class-fpga-manager (for Error strings information).
>

I didn't say that state and status interfaces have the same use case. 

Instead, I suggested that the state interface shouldn't be used to
report low-lever errors since this "responsibility" belongs to the
status interface.

The ABI documentation you cited states: "the intent [of the status
interface] is to provide more detailed information for FPGA
programming errors to userspace".

> With the existing implementation using DT-Overlay the Configuration/Reconfiguration lower-level
> driver errors are not propagating to userspace.
> 
> Please correct me if my understanding is wrong.

Out of curiosity, I ran a couple of tests on the QEMU arm "virt"
platform using linux-xlnx and linux-socfpga kernels and the fake
FPGA manager from the KUnit RFC. I modified the fake manager to
fail the write op returning a specific error code.

static int op_write(struct fpga_manager ...)
{
	[...]

        return -202302;
}

The op error code is visible from the message log on both kernels when
the overlay application fails:

[   23.958015] fpga_manager fpga0: writing fake.bin to Fake FPGA Manager
[   23.959119] fpga_manager fpga0: Error while writing image data to FPGA
[   23.959341] fpga_region region0: failed to load FPGA image
[   23.959472] OF: overlay: overlay changeset pre-apply notifier error -202302, target: /test_region
[   23.959622] create_overlay: Failed to create overlay (err=-202302)

However, I feel this part of the discussion is more speculative since
the DT overlay configFS interface is not mainline. 

> Regards,
> Navakishore.
> 

Thanks,
Marco

