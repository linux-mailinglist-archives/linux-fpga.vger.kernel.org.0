Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B830228BA63
	for <lists+linux-fpga@lfdr.de>; Mon, 12 Oct 2020 16:10:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731864AbgJLOIl (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 12 Oct 2020 10:08:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47388 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391220AbgJLOIE (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 12 Oct 2020 10:08:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602511682;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SaF6cMVDlVpoFfwkDVmoyVLnyiyb+8WHLNcrHzGdFx8=;
        b=StR1HqHGCBRieO9eumNH+RXgTFkZwrmu7cBYxS8yEYMARCF/mM9iziVRaRhoUbakoL3E4o
        s024R4RJKrMRsGTrWEMPbo7dEX9iQHuueD8nndiv7MbCS+Xj9YHd5UKxQDdWBMtnfWfHeJ
        muV1QQ5kV1wwuDNxHFPO3bk7UiKG5UI=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-117-mtimKenPP5mSb0rx9E5Jug-1; Mon, 12 Oct 2020 10:07:59 -0400
X-MC-Unique: mtimKenPP5mSb0rx9E5Jug-1
Received: by mail-qt1-f198.google.com with SMTP id p2so1946021qtw.16
        for <linux-fpga@vger.kernel.org>; Mon, 12 Oct 2020 07:07:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=SaF6cMVDlVpoFfwkDVmoyVLnyiyb+8WHLNcrHzGdFx8=;
        b=HffaYl+dgDiCu6BTHATFM1rpjPoZMxtHqLC3ZkhUdq9p0ileP8xblYU/FFdCnoiRmO
         SyG9Dhy3b3Av4m4jBZNG33+LVUOKWVbB/GVzSSn4+jMMipngrpTJb7CTC+vmaH2gM4f9
         YI7KEoXSFda2emUQ5tWjMw9zj6d4Kd8SPKCB2cR6ykR2+g0usT9j4NKGArLwtR1pwDYC
         O14AF3eScvZHcEbcoGO4EzGofSliitB5SG2dn372prgXbTqYJ21PkiZwQW8Vm2QOUmnO
         m5YIFiHS1Wf/EUIMMy8k3FdGUfrXSMiz7GoK9YFMDrkwrnULIJ0ERF8rcUJ1+dndiJyz
         UshA==
X-Gm-Message-State: AOAM5325hXEvgFM74dw7eEL8mu53G8PVLM2p5TfJHmxAMuujd3lXc8km
        jS9Dtuo0299Xsvu/m3EOE7BzlNL3VmZGml6kqKD3kh9gqW2jqJ4WJ3yGW6pYX5znEKiq4xMGtta
        8GtYBx03X8tAy4J458CVLHw==
X-Received: by 2002:a37:b782:: with SMTP id h124mr7138536qkf.169.1602511679193;
        Mon, 12 Oct 2020 07:07:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwQcHEwB54mQ/ZTK405YXwJFA8SS8HAiWpwGkm1pSQUWn+MqMwcU89Xxlt4bFwLro0ehIWuMA==
X-Received: by 2002:a37:b782:: with SMTP id h124mr7138512qkf.169.1602511678829;
        Mon, 12 Oct 2020 07:07:58 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id l13sm13088697qtv.82.2020.10.12.07.07.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Oct 2020 07:07:57 -0700 (PDT)
Subject: Re: [PATCH v9 1/6] fpga: dfl: fix the definitions of type &
 feature_id for dfl devices
To:     Xu Yilun <yilun.xu@intel.com>
Cc:     mdf@kernel.org, krzk@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        lgoncalv@redhat.com, hao.wu@intel.com
References: <1602313793-21421-1-git-send-email-yilun.xu@intel.com>
 <1602313793-21421-2-git-send-email-yilun.xu@intel.com>
 <8786ca8f-7edd-d7b1-7eca-6447814c6e5e@redhat.com>
 <20201012024100.GC29436@yilunxu-OptiPlex-7050>
From:   Tom Rix <trix@redhat.com>
Message-ID: <440b7d06-426f-86c6-cf3f-396a9cc6bff7@redhat.com>
Date:   Mon, 12 Oct 2020 07:07:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20201012024100.GC29436@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 10/11/20 7:41 PM, Xu Yilun wrote:
> On Sat, Oct 10, 2020 at 08:07:07AM -0700, Tom Rix wrote:
>> On 10/10/20 12:09 AM, Xu Yilun wrote:
>>> The value of the field dfl_device.type comes from the 12 bits register
>>> field DFH_ID according to DFL spec. So this patch changes the definition
>>> of the type field to u16.
>>>
>>> Also it is not necessary to illustrate the valid bits of the type field
>>> in comments. Instead we should explicitly define the possible values in
>>> the enumeration type for it, because they are shared by hardware spec.
>>> We should not let the compiler decide these values.
>>>
>>> Similar changes are also applied to dfl_device.feature_id.
>>>
>>> This patch also fixed the MODALIAS format according to the changes
>>> above.
>>>
>>> Signed-off-by: Xu Yilun <yilun.xu@intel.com>
>>> ---
>>> v9: no change
>>> ---
>>>  drivers/fpga/dfl.c |  3 +--
>>>  drivers/fpga/dfl.h | 14 +++++++-------
>>>  2 files changed, 8 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
>>> index b450870..5a6ba3b 100644
>>> --- a/drivers/fpga/dfl.c
>>> +++ b/drivers/fpga/dfl.c
>>> @@ -298,8 +298,7 @@ static int dfl_bus_uevent(struct device *dev, struct kobj_uevent_env *env)
>>>  {
>>>  	struct dfl_device *ddev = to_dfl_dev(dev);
>>>  
>>> -	/* The type has 4 valid bits and feature_id has 12 valid bits */
>>> -	return add_uevent_var(env, "MODALIAS=dfl:t%01Xf%03X",
>>> +	return add_uevent_var(env, "MODALIAS=dfl:t%04Xf%04X",
>>>  			      ddev->type, ddev->feature_id);
>>>  }
>>>  
>>> diff --git a/drivers/fpga/dfl.h b/drivers/fpga/dfl.h
>>> index 5dc758f..ac373b1 100644
>>> --- a/drivers/fpga/dfl.h
>>> +++ b/drivers/fpga/dfl.h
>>> @@ -520,19 +520,19 @@ long dfl_feature_ioctl_set_irq(struct platform_device *pdev,
>>>   * enum dfl_id_type - define the DFL FIU types
>>>   */
>>>  enum dfl_id_type {
>>> -	FME_ID,
>>> -	PORT_ID,
>>> +	FME_ID = 0,
>>> +	PORT_ID = 1,
>> This is redundant, why make this change ?
> These values are shared by hardware spec, so it is suggested that the
> values of the enum type should be explicitly set, otherwise the compiler
> is in its right to do whatever it wants with them (within reason...)
>
> Please see the original discussion:
> https://lore.kernel.org/linux-fpga/20200923055436.GA2629915@kroah.com/

I don't believe this is undefined behavior for the compiler

from c11 6.7.2.2,3

The identifiers in an enumerator list are declared as constants that have type int and may appear wherever such are permitted.127) An enumerator with = defines its enumeration constant as the value of the constant expression. If the first enumerator has no =, the value of its enumeration constant is 0. Each subsequent enumerator with no = defines its enumeration constant as the value of the constant expression obtained by adding 1 to the value of the previous enumeration constant. (The use of enumerators with = may produce enumeration constants with values that duplicate other values in the same enumeration.) The enumerators of an enumeration are also known as its members.

setting them again has some use for documentation so this change is ok if you have strong feeling for it.

Tom

>
> Thanks,
> Yilun
>
>> Tom
>>
>>>  	DFL_ID_MAX,
>>>  };
>>>  
>>>  /**
>>>   * struct dfl_device_id -  dfl device identifier
>>> - * @type: contains 4 bits DFL FIU type of the device. See enum dfl_id_type.
>>> - * @feature_id: contains 12 bits feature identifier local to its DFL FIU type.
>>> + * @type: DFL FIU type of the device. See enum dfl_id_type.
>>> + * @feature_id: feature identifier local to its DFL FIU type.
>>>   * @driver_data: driver specific data.
>>>   */
>>>  struct dfl_device_id {
>>> -	u8 type;
>>> +	u16 type;
>>>  	u16 feature_id;
>>>  	unsigned long driver_data;
>>>  };
>>> @@ -543,7 +543,7 @@ struct dfl_device_id {
>>>   * @dev: generic device interface.
>>>   * @id: id of the dfl device.
>>>   * @type: type of DFL FIU of the device. See enum dfl_id_type.
>>> - * @feature_id: 16 bits feature identifier local to its DFL FIU type.
>>> + * @feature_id: feature identifier local to its DFL FIU type.
>>>   * @mmio_res: mmio resource of this dfl device.
>>>   * @irqs: list of Linux IRQ numbers of this dfl device.
>>>   * @num_irqs: number of IRQs supported by this dfl device.
>>> @@ -553,7 +553,7 @@ struct dfl_device_id {
>>>  struct dfl_device {
>>>  	struct device dev;
>>>  	int id;
>>> -	u8 type;
>>> +	u16 type;
>>>  	u16 feature_id;
>>>  	struct resource mmio_res;
>>>  	int *irqs;

