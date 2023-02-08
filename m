Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D8A168FA3D
	for <lists+linux-fpga@lfdr.de>; Wed,  8 Feb 2023 23:24:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232406AbjBHWWx (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 8 Feb 2023 17:22:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbjBHWWw (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 8 Feb 2023 17:22:52 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36E0F22A38
        for <linux-fpga@vger.kernel.org>; Wed,  8 Feb 2023 14:22:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675894922;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fERqKIJ8qSq+qpDh+YjgEagGSXpDbt65o7S1w1RVWHk=;
        b=U/aZiNGYrJdL0P5aV9yAx6v9BcV8vqPJAmvsUJCtzjkD2q5TEMRXBLnO73tKVjQbMKQcJp
        MDckG5eeczkEpHHVYJNlY/167qy4jJVJs9KNeEagkNLegEhunQS1H9ixEmXNruPNIBw5Od
        9zFAlOZcLYXgOKeHRNf4GVF0g4t1l4c=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-88-vN-eN1j5MQScXfXdWldpBw-1; Wed, 08 Feb 2023 17:22:01 -0500
X-MC-Unique: vN-eN1j5MQScXfXdWldpBw-1
Received: by mail-qt1-f199.google.com with SMTP id j26-20020ac84c9a000000b003b9b7c60108so11618530qtv.16
        for <linux-fpga@vger.kernel.org>; Wed, 08 Feb 2023 14:22:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fERqKIJ8qSq+qpDh+YjgEagGSXpDbt65o7S1w1RVWHk=;
        b=ghBywIOoIsd3a8yZNoghtCBcV7n3TaGz5SFrkJ8pGctaGMVtmy6g+vkHKLHiD/LJw/
         XulM/yr3qU7VSFkuf0q0GKdzU2+iJT+uDmlx3d41YO0upN2fZYRF+JuGjwAgNdLwltGM
         odfRfnNxV09hqr8sNE3x2XryKOdy6MSqOYbR4dne5ozTRZcx5asRg+EPEWhEP/ovOy6e
         xRfzznHgaSoKc6SuLWiQmKL+QthZDRCZKAfavXLeRBsbsJ9Uj9TMR3+u3/y4jKUKloWa
         ZyPWOTLprorBKAjr+W6Oq9Q7GYzXaqYhJV5KRb55+LSki3UIEOleWDaO7G4q8ggtekDq
         npFA==
X-Gm-Message-State: AO0yUKVimnPo05tlEUlrEUNAyFb2BCliaQaT4y/hLUwl8xhWdWrtVsXI
        YI20PZyGvXS0cV+FwSoA20Bg6FB8w1ii2u6lnyq2ImhXbsq/theZmNV6ebyBpE5aOy0kbMsHNx+
        gWEasUeCENa/gOQp7d5qr
X-Received: by 2002:a05:622a:487:b0:3b6:33c6:c5ac with SMTP id p7-20020a05622a048700b003b633c6c5acmr15895727qtx.4.1675894920588;
        Wed, 08 Feb 2023 14:22:00 -0800 (PST)
X-Google-Smtp-Source: AK7set8VNDEOx4tn/DpctG4R5LSen5NRg7qCA44d8IZFoofTsprQg6w4UJ1/o6x5AKLqa3O4ur+2mg==
X-Received: by 2002:a05:622a:487:b0:3b6:33c6:c5ac with SMTP id p7-20020a05622a048700b003b633c6c5acmr15895691qtx.4.1675894920274;
        Wed, 08 Feb 2023 14:22:00 -0800 (PST)
Received: from [192.168.9.16] (net-2-34-30-183.cust.vodafonedsl.it. [2.34.30.183])
        by smtp.gmail.com with ESMTPSA id fu48-20020a05622a5db000b003b63a734434sm20380qtb.52.2023.02.08.14.21.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Feb 2023 14:21:59 -0800 (PST)
Message-ID: <c69b76d8-fc72-b52f-4c64-b8c4cd498649@redhat.com>
Date:   Wed, 8 Feb 2023 23:21:56 +0100
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
Content-Language: en-US
From:   Marco Pagani <marpagan@redhat.com>
In-Reply-To: <DM6PR12MB3993232B3EB5DE00CBC9B452CDD89@DM6PR12MB3993.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 2023-02-08 12:01, Manne, Nava kishore wrote:
> Hi Marco,
> 
> 	Thanks for providing the review comments.
> Please find my response inline below.
> 
>> -----Original Message-----
>> From: Marco Pagani <marpagan@redhat.com>
>> Sent: Wednesday, February 8, 2023 12:04 AM
>> To: Nava kishore Manne <nava.manne@xilinx.com>
>> Cc: Manne, Nava kishore <nava.kishore.manne@amd.com>;
>> mdf@kernel.org; hao.wu@intel.com; trix@redhat.com; yilun.xu@intel.com;
>> linux-fpga@vger.kernel.org; linux-kernel@vger.kernel.org
>> Subject: Re: [PATCH] fpga: mgr: Update the state to provide the exact error
>> code
>>
>>
>> On 2023-02-07 10:59, Nava kishore Manne wrote:
>>> From: Nava kishore Manne <nava.manne@xilinx.com>
>>>
>>> Up on fpga configuration failure, the existing sysfs state interface
>>> is just providing the generic error message rather than providing the
>>> exact error code. This patch extends sysfs state interface to provide
>>> the exact error received from the lower layer along with the existing
>>> generic error message.
>>>
>>> Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
>>> ---
>>>  drivers/fpga/fpga-mgr.c       | 20 +++++++++++++++++++-
>>>  include/linux/fpga/fpga-mgr.h |  2 ++
>>>  2 files changed, 21 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c index
>>> 8efa67620e21..b2d74705a5a2 100644
>>> --- a/drivers/fpga/fpga-mgr.c
>>> +++ b/drivers/fpga/fpga-mgr.c
>>> @@ -61,12 +61,14 @@ static inline int fpga_mgr_write_complete(struct
>>> fpga_manager *mgr,  {
>>>  	int ret = 0;
>>>
>>> +	mgr->err = 0;
>>>  	mgr->state = FPGA_MGR_STATE_WRITE_COMPLETE;
>>>  	if (mgr->mops->write_complete)
>>>  		ret = mgr->mops->write_complete(mgr, info);
>>>  	if (ret) {
>>>  		dev_err(&mgr->dev, "Error after writing image data to
>> FPGA\n");
>>>  		mgr->state = FPGA_MGR_STATE_WRITE_COMPLETE_ERR;
>>> +		mgr->err = ret;
>>>  		return ret;
>>>  	}
>>>  	mgr->state = FPGA_MGR_STATE_OPERATING; @@ -154,6 +156,7 @@
>> static
>>> int fpga_mgr_parse_header_mapped(struct fpga_manager *mgr,  {
>>>  	int ret;
>>>
>>> +	mgr->err = 0;
>>>  	mgr->state = FPGA_MGR_STATE_PARSE_HEADER;
>>>  	ret = fpga_mgr_parse_header(mgr, info, buf, count);
>>>
>>> @@ -165,6 +168,7 @@ static int fpga_mgr_parse_header_mapped(struct
>> fpga_manager *mgr,
>>>  	if (ret) {
>>>  		dev_err(&mgr->dev, "Error while parsing FPGA image
>> header\n");
>>>  		mgr->state = FPGA_MGR_STATE_PARSE_HEADER_ERR;
>>> +		mgr->err = ret;
>>>  	}
>>>
>>>  	return ret;
>>> @@ -185,6 +189,7 @@ static int fpga_mgr_parse_header_sg_first(struct
>> fpga_manager *mgr,
>>>  	int ret;
>>>
>>>  	mgr->state = FPGA_MGR_STATE_PARSE_HEADER;
>>> +	mgr->err = 0;
>>>
>>>  	sg_miter_start(&miter, sgt->sgl, sgt->nents, SG_MITER_FROM_SG);
>>>  	if (sg_miter_next(&miter) &&
>>> @@ -197,6 +202,7 @@ static int fpga_mgr_parse_header_sg_first(struct
>> fpga_manager *mgr,
>>>  	if (ret && ret != -EAGAIN) {
>>>  		dev_err(&mgr->dev, "Error while parsing FPGA image
>> header\n");
>>>  		mgr->state = FPGA_MGR_STATE_PARSE_HEADER_ERR;
>>> +		mgr->err = ret;
>>>  	}
>>>
>>>  	return ret;
>>> @@ -249,6 +255,7 @@ static void *fpga_mgr_parse_header_sg(struct
>> fpga_manager *mgr,
>>>  	if (ret) {
>>>  		dev_err(&mgr->dev, "Error while parsing FPGA image
>> header\n");
>>>  		mgr->state = FPGA_MGR_STATE_PARSE_HEADER_ERR;
>>> +		mgr->err = ret;
>>>  		kfree(buf);
>>>  		buf = ERR_PTR(ret);
>>>  	}
>>> @@ -272,6 +279,7 @@ static int fpga_mgr_write_init_buf(struct
>> fpga_manager *mgr,
>>>  	size_t header_size = info->header_size;
>>>  	int ret;
>>>
>>> +	mgr->err = 0;
>>>  	mgr->state = FPGA_MGR_STATE_WRITE_INIT;
>>>
>>>  	if (header_size > count)
>>> @@ -284,6 +292,7 @@ static int fpga_mgr_write_init_buf(struct
>> fpga_manager *mgr,
>>>  	if (ret) {
>>>  		dev_err(&mgr->dev, "Error preparing FPGA for writing\n");
>>>  		mgr->state = FPGA_MGR_STATE_WRITE_INIT_ERR;
>>> +		mgr->err = ret;
>>>  		return ret;
>>>  	}
>>>
>>> @@ -370,6 +379,7 @@ static int fpga_mgr_buf_load_sg(struct
>>> fpga_manager *mgr,
>>>
>>>  	/* Write the FPGA image to the FPGA. */
>>>  	mgr->state = FPGA_MGR_STATE_WRITE;
>>> +	mgr->err = 0;
>>>  	if (mgr->mops->write_sg) {
>>>  		ret = fpga_mgr_write_sg(mgr, sgt);
>>>  	} else {
>>> @@ -405,6 +415,7 @@ static int fpga_mgr_buf_load_sg(struct
>> fpga_manager *mgr,
>>>  	if (ret) {
>>>  		dev_err(&mgr->dev, "Error while writing image data to
>> FPGA\n");
>>>  		mgr->state = FPGA_MGR_STATE_WRITE_ERR;
>>> +		mgr->err = ret;
>>>  		return ret;
>>>  	}
>>>
>>> @@ -437,10 +448,12 @@ static int fpga_mgr_buf_load_mapped(struct
>> fpga_manager *mgr,
>>>  	 * Write the FPGA image to the FPGA.
>>>  	 */
>>>  	mgr->state = FPGA_MGR_STATE_WRITE;
>>> +	mgr->err = 0;
>>>  	ret = fpga_mgr_write(mgr, buf, count);
>>>  	if (ret) {
>>>  		dev_err(&mgr->dev, "Error while writing image data to
>> FPGA\n");
>>>  		mgr->state = FPGA_MGR_STATE_WRITE_ERR;
>>> +		mgr->err = ret;
>>>  		return ret;
>>>  	}
>>>
>>> @@ -544,10 +557,11 @@ static int fpga_mgr_firmware_load(struct
>> fpga_manager *mgr,
>>>  	dev_info(dev, "writing %s to %s\n", image_name, mgr->name);
>>>
>>>  	mgr->state = FPGA_MGR_STATE_FIRMWARE_REQ;
>>> -
>>> +	mgr->err = 0;
>>>  	ret = request_firmware(&fw, image_name, dev);
>>>  	if (ret) {
>>>  		mgr->state = FPGA_MGR_STATE_FIRMWARE_REQ_ERR;
>>> +		mgr->err = ret;
>>>  		dev_err(dev, "Error requesting firmware %s\n",
>> image_name);
>>>  		return ret;
>>>  	}
>>> @@ -626,6 +640,10 @@ static ssize_t state_show(struct device *dev,  {
>>>  	struct fpga_manager *mgr = to_fpga_manager(dev);
>>>
>>> +	if (mgr->err)
>>> +		return sprintf(buf, "%s: 0x%x\n",
>>> +			       state_str[mgr->state], mgr->err);
>>> +
>>>  	return sprintf(buf, "%s\n", state_str[mgr->state]);
>>
>>
>> If one of the fpga manager ops fails, the low-level error code is already
>> returned to the caller. Wouldn't it be better to rely on this instead of printing
>> the low-level error code in a sysfs attribute and sending it to the userspace?
>>
> Agree, the low-level error code is already returned to the caller but the user application
> will not have any access to read this error info. So, I feel this patch provides that flexibility 
> to the user application to get the exact error info. 
> please let me know if you have any other thoughts will implement that.
> 
> Regards,
> Navakishore.


Hi Nava,

Thanks for your quick reply. I understand the need to access the
low-level error code from userspace if the configuration goes wrong.

However, in my understanding, the low-level driver is supposed to
export reconfiguration errors by implementing the status op and
returning a bit field set using the macros defined in fpga-mgr.h +189.
The fpga manager will, in turn, make the errors visible to userspace
through the status attribute. If the available error bits aren't
descriptive enough, wouldn't it be better to add more error macros
instead of "overloading" the state attribute?

Moreover, it seems to me that if the reconfiguration is done by
loading a device tree overlay from userspace, the error code gets
propagated back through the notifier in of-fpga-region. Am I correct?

Thanks,
Marco

