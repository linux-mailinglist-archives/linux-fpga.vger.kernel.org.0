Return-Path: <linux-fpga+bounces-483-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBA1F8A58DE
	for <lists+linux-fpga@lfdr.de>; Mon, 15 Apr 2024 19:13:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92E56281A4F
	for <lists+linux-fpga@lfdr.de>; Mon, 15 Apr 2024 17:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16CB283CAE;
	Mon, 15 Apr 2024 17:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HLFQr6/9"
X-Original-To: linux-fpga@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E8B85646
	for <linux-fpga@vger.kernel.org>; Mon, 15 Apr 2024 17:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713201073; cv=none; b=bQehXhF9G6rcD+CgrQANDHoT6TTMXi60W8MEIRxKejLBfBY2aRB86iSskT1MoIOSXGgaUDL86IOMzDxdSIOlmS+n+pZ6nr6XiSVUkDcsic6CDEEPpLi+aSGVV20ELzeuLNi/2A5FoVgSPWTsGj7BppPJIjgPpaBi1D8oRcu5rWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713201073; c=relaxed/simple;
	bh=SEcuJt/UZ8ba3isISMeftKrW6x4eGf3z22U6SReVxT8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=kVJwD2umo/lDUWpcpvG/T78RBEdD5RN/fStbbqG1NSwi/jzwCKLWfcB/vA6jnwJKWPL0t8WGBeiVTeEWBJ7oxUvTRslqZJ4xXy9DPBEEiu3Oet47vgVxkUxi0zC7zW2XNTpTBI1UbY+lSXRacw5vlS0cKRsC4yITV0ZCx4wi/kM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HLFQr6/9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713201070;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=khDc6xFWFIXG4OuztGv/s1Ulbk4vHwkXmIffcldK9WU=;
	b=HLFQr6/9olfijrbzpiTzPWwruPS2pkWceet18zuE6S2YowAXgpEzWloSWAB5BhrMVWinMe
	jgxvFwMnogxWVb4v/YyWLswbpGguRpeEnVJxGGxFUzJ9Mtqq5pUcUq2LjtdAqqaB862iYv
	h4dsNBGQFnVqodTLvZXKSE/riugjC6g=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-350-MLGDCH45P1i4vGB9kDUqWA-1; Mon, 15 Apr 2024 13:11:08 -0400
X-MC-Unique: MLGDCH45P1i4vGB9kDUqWA-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-516da5d2043so3181891e87.3
        for <linux-fpga@vger.kernel.org>; Mon, 15 Apr 2024 10:11:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713201067; x=1713805867;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=khDc6xFWFIXG4OuztGv/s1Ulbk4vHwkXmIffcldK9WU=;
        b=neThMMkq0RRudTIYWLQPKMzZKD664uCmhnj0uhSG4aIY3XvRpitkrYZHLiwf+0YgmB
         tXpOC1RONxOz7d3OCKlbwZDd3W+pIyEkvKmb684FS2eUr7Q1BjxbZuIhwl/kMoQR9J0/
         6EzJsIyZMbT0tiuMOny8IpUeoTBLL2uH3ycXvN5+9ZZvCnKIuyP74BvAN9eDjAzWcfrw
         JW/2HpjpQvN7n8v3DOHvcQuokuFqe9uCQ69o9Kl5a5ir1Yvox6zZ1VVBAMgANrOLF7i3
         bZs2s1RJnjaVLRZlyySSsLAZWBOtzcHhTfLjyp4HoYzDIj3mhZZE7lb5dCrh9g99HznV
         8g8w==
X-Forwarded-Encrypted: i=1; AJvYcCXdEqz2/8cdF9SRgZ+773MIggovQtpCmVyeEFhGkIeRE2mm1gcFBGXCN2NFpMk2oVQHEFm7I2JhejphK4XpvpA+m/ypsNNCNeyG1A==
X-Gm-Message-State: AOJu0YxtWXQEjWH5hBvoQQ7a04ZRtwm/bq/j5V/EswFBIp7+fBOeE2wX
	+8t0/mRvKTKVa9Ubm8iaz4RXWM09RPomu0UJEErxgzUHoJnxspJ+5e4YQbJC7B9PDbBngioB+Vj
	Bg8e5amz8FiDHMfReVxp/i4jFU/d4jiNq4J6eqQLKX73o1I9SwelbIP/i9A==
X-Received: by 2002:a05:6512:10c7:b0:518:c82a:bdf9 with SMTP id k7-20020a05651210c700b00518c82abdf9mr5757473lfg.44.1713201067078;
        Mon, 15 Apr 2024 10:11:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF/cIZ45K0OXdCc0M88lP7x/UqAbRwJSShIeGFCm4QF4V9CYuZrhpeNIeziBGI5i34SzHi2vQ==
X-Received: by 2002:a05:6512:10c7:b0:518:c82a:bdf9 with SMTP id k7-20020a05651210c700b00518c82abdf9mr5757434lfg.44.1713201066606;
        Mon, 15 Apr 2024 10:11:06 -0700 (PDT)
Received: from [192.168.142.123] ([78.209.35.245])
        by smtp.gmail.com with ESMTPSA id si29-20020a170906cedd00b00a4e5866448bsm5679354ejb.155.2024.04.15.10.11.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Apr 2024 10:11:06 -0700 (PDT)
Message-ID: <e5f15ea4-f8e4-4a97-95f6-63a2099d084c@redhat.com>
Date: Mon, 15 Apr 2024 19:11:03 +0200
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] fpga: region: add owner module and take its refcount
From: Marco Pagani <marpagan@redhat.com>
To: Xu Yilun <yilun.xu@linux.intel.com>
Cc: Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
 Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
 Jonathan Corbet <corbet@lwn.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Alan Tull <atull@opensource.altera.com>, Russ Weight
 <russ.weight@linux.dev>, linux-fpga@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240411144811.121500-1-marpagan@redhat.com>
 <ZhnviXAgnTdzUyV4@yilunxu-OptiPlex-7050>
 <669b8b55-df83-4c32-9c8f-41895db18b75@redhat.com>
Content-Language: en-US
In-Reply-To: <669b8b55-df83-4c32-9c8f-41895db18b75@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-04-15 14:19, Marco Pagani wrote:
> 
> 
> On 2024-04-13 04:35, Xu Yilun wrote:
>>>  /**
>>> - * fpga_region_register_full - create and register an FPGA Region device
>>> + * __fpga_region_register_full - create and register an FPGA Region device
>>>   * @parent: device parent
>>>   * @info: parameters for FPGA Region
>>> + * @owner: owner module containing the get_bridges function
>>
>> This is too specific and easily get unaligned if we add another
>> callback. How about "module containing the region ops"?
> 
> I had some concerns about using the name "region ops" in the kernel-doc
> comment since it was not supported by a struct definition nor referenced
> in the documentation. However, since the name is now referred to in the
> ops_owner pointer, making the change makes sense to me.
> 

On second thought, I think it would be better to leave the @owner
description to "module containing the get_bridges function" for the
moment. Otherwise, it could confuse the user by blurring the connection
between the @owner and @get_bridges parameters.

* __fpga_region_register - create and register an FPGA Region device
* [...]
* @get_bridges: optional function to get bridges to a list
* @owner: owner module containing get_bridges function

We can always modify the @owner description later, together with all the
necessary changes to add a new op, like grouping all ops in a structure
and changing the registration function signature.

Thanks,
Marco

> 
>>
>>>   *
>>>   * Return: struct fpga_region or ERR_PTR()
>>>   */
>>>  struct fpga_region *
>>> -fpga_region_register_full(struct device *parent, const struct fpga_region_info *info)
>>> +__fpga_region_register_full(struct device *parent, const struct fpga_region_info *info,
>>> +			    struct module *owner)
>>>  {
>>>  	struct fpga_region *region;
>>>  	int id, ret = 0;
>>> @@ -213,6 +215,7 @@ fpga_region_register_full(struct device *parent, const struct fpga_region_info *
>>>  	region->compat_id = info->compat_id;
>>>  	region->priv = info->priv;
>>>  	region->get_bridges = info->get_bridges;
>>> +	region->ops_owner = owner;
>>>  
>>>  	mutex_init(&region->mutex);
>>>  	INIT_LIST_HEAD(&region->bridge_list);
>>> @@ -241,13 +244,14 @@ fpga_region_register_full(struct device *parent, const struct fpga_region_info *
>>>  
>>>  	return ERR_PTR(ret);
>>>  }
>>> -EXPORT_SYMBOL_GPL(fpga_region_register_full);
>>> +EXPORT_SYMBOL_GPL(__fpga_region_register_full);
>>>  
>>>  /**
>>> - * fpga_region_register - create and register an FPGA Region device
>>> + * __fpga_region_register - create and register an FPGA Region device
>>>   * @parent: device parent
>>>   * @mgr: manager that programs this region
>>>   * @get_bridges: optional function to get bridges to a list
>>> + * @owner: owner module containing get_bridges function
>>
>> ditto
>>
>>>   *
>>>   * This simple version of the register function should be sufficient for most users.
>>>   * The fpga_region_register_full() function is available for users that need to
>>> @@ -256,17 +260,17 @@ EXPORT_SYMBOL_GPL(fpga_region_register_full);
>>>   * Return: struct fpga_region or ERR_PTR()
>>>   */
>>>  struct fpga_region *
>>> -fpga_region_register(struct device *parent, struct fpga_manager *mgr,
>>> -		     int (*get_bridges)(struct fpga_region *))
>>> +__fpga_region_register(struct device *parent, struct fpga_manager *mgr,
>>> +		       int (*get_bridges)(struct fpga_region *), struct module *owner)
>>>  {
>>>  	struct fpga_region_info info = { 0 };
>>>  
>>>  	info.mgr = mgr;
>>>  	info.get_bridges = get_bridges;
>>>  
>>> -	return fpga_region_register_full(parent, &info);
>>> +	return __fpga_region_register_full(parent, &info, owner);
>>>  }
>>> -EXPORT_SYMBOL_GPL(fpga_region_register);
>>> +EXPORT_SYMBOL_GPL(__fpga_region_register);
>>>  
>>>  /**
>>>   * fpga_region_unregister - unregister an FPGA region
>>> diff --git a/include/linux/fpga/fpga-region.h b/include/linux/fpga/fpga-region.h
>>> index 9d4d32909340..5fbc05fe70a6 100644
>>> --- a/include/linux/fpga/fpga-region.h
>>> +++ b/include/linux/fpga/fpga-region.h
>>> @@ -36,6 +36,7 @@ struct fpga_region_info {
>>>   * @mgr: FPGA manager
>>>   * @info: FPGA image info
>>>   * @compat_id: FPGA region id for compatibility check.
>>> + * @ops_owner: module containing the get_bridges function
>>
>> ditto
>>
>> Thanks,
>> Yilun
>>
>>>   * @priv: private data
>>>   * @get_bridges: optional function to get bridges to a list
>>>   */
>>> @@ -46,6 +47,7 @@ struct fpga_region {
>>>  	struct fpga_manager *mgr;
>>>  	struct fpga_image_info *info;
>>>  	struct fpga_compat_id *compat_id;
>>> +	struct module *ops_owner;
>>>  	void *priv;
>>>  	int (*get_bridges)(struct fpga_region *region);
>>>  };
>>


