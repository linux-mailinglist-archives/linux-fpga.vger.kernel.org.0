Return-Path: <linux-fpga+bounces-495-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 463568AA9E4
	for <lists+linux-fpga@lfdr.de>; Fri, 19 Apr 2024 10:13:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9293FB239B0
	for <lists+linux-fpga@lfdr.de>; Fri, 19 Apr 2024 08:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 718024E1AD;
	Fri, 19 Apr 2024 08:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LDRFegmE"
X-Original-To: linux-fpga@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B61A55
	for <linux-fpga@vger.kernel.org>; Fri, 19 Apr 2024 08:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713514402; cv=none; b=DpfjsIBgEX7gRnPWjoABo10PlzOsjt7JXTwfiaSfq3O+PgB/6zVsB0+o6RID4FIntlp3/SY8hnQXSIHDZ0lRXJhLKZ5SFGR7iiSsGH0N68+yGSbc5wnX0M3aY5UcwlAQ7RESk728eg7bp8Ii2P9006UhSxX4TLkoJP8XyDy5NnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713514402; c=relaxed/simple;
	bh=0yvDWi0EV/hb1VKvTNZTFgNB9Gy6LhBXl4b//o+oFqI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GunQU3Ae5AjGT3VgLwoQ6xzx5O8+Qzs4sJaNotVJWRXvFlWrFHEnI+6xp+ErzD/0MA+5h8p5fG3U3qM3OXHLQQpW4gXoda/E8OfMoVNJ+wsfx6ta3BFP3gAamX8oifyH8e9DMgwkOHFVeiXwxnmtUldin2fT4XzNLTPUISRGPQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LDRFegmE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713514399;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nZXAGlyqXzDjJI5Omp2RG3Bui4aLRCPq8JyD6J4qt80=;
	b=LDRFegmE/OYt5UxA2LrVNb4Bjd7/gYM/8LYQVAKEf1uL65peXmbz52JCbr98C9LkEWndsD
	ncyqoV5guk/KDSi+RTLvOKXhpuCsLV/3lSm356skm6J5vIuAaLXNyhDPkZfX8jeJ/CqFSu
	C3b8kgn61bPyF6Xn8IiHNAA8LXAGjbE=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-JGRmGIuSO6mG2wGwwByF8Q-1; Fri, 19 Apr 2024 04:13:18 -0400
X-MC-Unique: JGRmGIuSO6mG2wGwwByF8Q-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-69b63f7ff71so42566156d6.1
        for <linux-fpga@vger.kernel.org>; Fri, 19 Apr 2024 01:13:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713514397; x=1714119197;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nZXAGlyqXzDjJI5Omp2RG3Bui4aLRCPq8JyD6J4qt80=;
        b=wRqYQUFUIlxy/P5f7DY2sjVHtHxLaLGAqwzS93W/3zk24fX297pJWYz7UgSb8VpZwg
         yhnN/qpe4GR8HmDVbug+n0Y17qV8eqqMbPHUXv+2ZZ8m2ki/kE1QETzY+9oCMCVCJCnm
         LikRPUYZycUHvWAr7940b/d3HTBlqI1MEqsVBf4yxVeyyy7uSZj2IbjIXJANYNExziXX
         NKWsnodqo624E4G4lBLYLxapgQ6rUfxaL4nwyRB3aPnCFvNwYHKG9SsrVFK84meSnHlM
         k1Sd2EkqWIYEg4Hh7zFUZqtaw6gSa9p/6fwXh8gloGumaKTNJ2AyqTu9pyg/ZjJZMoIX
         URbA==
X-Forwarded-Encrypted: i=1; AJvYcCUWRytXbApjB+37SQYmFTUjxnUgH7xIuQQeR/NeWaQzFGlR/SL7V1JjphxsWnbNtDOlPpd04ZVjDvQG3sDGb6PTwHJ99XX1LZrvYQ==
X-Gm-Message-State: AOJu0YzAHBhZAoYdSPtks7/z7iVe+hawYWKJlcy+gIx3FgCKsouPjJ9p
	YqqNzfCJU4Ld8Bx6oHUXRqpdFntq6EyBpuSpCeUgbFayRI6aL7nw7TjP1FpFZ3TSpE8qcFBXWp4
	V7usWNJ7uQPPYSvEsPsbu8uO8fKXf+F6taoA7ouSaphkAr3GTt0RKerBLZA==
X-Received: by 2002:a0c:fa44:0:b0:6a0:5d52:6271 with SMTP id k4-20020a0cfa44000000b006a05d526271mr2570745qvo.21.1713514397743;
        Fri, 19 Apr 2024 01:13:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IErsdvm6VXZI4dwYBYqnTx9ujGkHxUutDuxuaYyqvC6G7Y+JD5DWsG/CrmdAh5MkNdoXPjr9Q==
X-Received: by 2002:a0c:fa44:0:b0:6a0:5d52:6271 with SMTP id k4-20020a0cfa44000000b006a05d526271mr2570712qvo.21.1713514397397;
        Fri, 19 Apr 2024 01:13:17 -0700 (PDT)
Received: from [192.168.9.34] (net-2-34-26-208.cust.vodafonedsl.it. [2.34.26.208])
        by smtp.gmail.com with ESMTPSA id j13-20020a0cf30d000000b0069b584cd2dbsm1358642qvl.5.2024.04.19.01.13.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Apr 2024 01:13:17 -0700 (PDT)
Message-ID: <07eb8fa4-871f-4810-ba59-6a6807d40e6e@redhat.com>
Date: Fri, 19 Apr 2024 10:13:12 +0200
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] fpga: region: add owner module and take its refcount
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
 <e5f15ea4-f8e4-4a97-95f6-63a2099d084c@redhat.com>
 <ZiId9CnGEjwMcXeX@yilunxu-OptiPlex-7050>
Content-Language: en-US
From: Marco Pagani <marpagan@redhat.com>
In-Reply-To: <ZiId9CnGEjwMcXeX@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024-04-19 09:32, Xu Yilun wrote:
> On Mon, Apr 15, 2024 at 07:11:03PM +0200, Marco Pagani wrote:
>> On 2024-04-15 14:19, Marco Pagani wrote:
>>>
>>>
>>> On 2024-04-13 04:35, Xu Yilun wrote:
>>>>>  /**
>>>>> - * fpga_region_register_full - create and register an FPGA Region device
>>>>> + * __fpga_region_register_full - create and register an FPGA Region device
>>>>>   * @parent: device parent
>>>>>   * @info: parameters for FPGA Region
>>>>> + * @owner: owner module containing the get_bridges function
>>>>
>>>> This is too specific and easily get unaligned if we add another
>>>> callback. How about "module containing the region ops"?
>>>
>>> I had some concerns about using the name "region ops" in the kernel-doc
>>> comment since it was not supported by a struct definition nor referenced
>>> in the documentation. However, since the name is now referred to in the
>>> ops_owner pointer, making the change makes sense to me.
>>>
>>
>> On second thought, I think it would be better to leave the @owner
>> description to "module containing the get_bridges function" for the
>> moment. Otherwise, it could confuse the user by blurring the connection
>> between the @owner and @get_bridges parameters.
>>
>> * __fpga_region_register - create and register an FPGA Region device
>> * [...]
>> * @get_bridges: optional function to get bridges to a list
>> * @owner: owner module containing get_bridges function
>>
>> We can always modify the @owner description later, together with all the
>> necessary changes to add a new op, like grouping all ops in a structure
>> and changing the registration function signature.
> 
> OK, it's good to me. I'll apply this patch to for-next.
> 
> Acked-by: Xu Yilun <yilun.xu@intel.com>

Thanks, I'll quickly send v6 to fix a minor typo in the kernel-doc:

- @owner: owner module containing get_bridges function
+ @owner: module containing the get_bridges function

Marco

>>>>>   *
>>>>>   * Return: struct fpga_region or ERR_PTR()
>>>>>   */
>>>>>  struct fpga_region *
>>>>> -fpga_region_register_full(struct device *parent, const struct fpga_region_info *info)
>>>>> +__fpga_region_register_full(struct device *parent, const struct fpga_region_info *info,
>>>>> +			    struct module *owner)
>>>>>  {
>>>>>  	struct fpga_region *region;
>>>>>  	int id, ret = 0;
>>>>> @@ -213,6 +215,7 @@ fpga_region_register_full(struct device *parent, const struct fpga_region_info *
>>>>>  	region->compat_id = info->compat_id;
>>>>>  	region->priv = info->priv;
>>>>>  	region->get_bridges = info->get_bridges;
>>>>> +	region->ops_owner = owner;
>>>>>  
>>>>>  	mutex_init(&region->mutex);
>>>>>  	INIT_LIST_HEAD(&region->bridge_list);
>>>>> @@ -241,13 +244,14 @@ fpga_region_register_full(struct device *parent, const struct fpga_region_info *
>>>>>  
>>>>>  	return ERR_PTR(ret);
>>>>>  }
>>>>> -EXPORT_SYMBOL_GPL(fpga_region_register_full);
>>>>> +EXPORT_SYMBOL_GPL(__fpga_region_register_full);
>>>>>  
>>>>>  /**
>>>>> - * fpga_region_register - create and register an FPGA Region device
>>>>> + * __fpga_region_register - create and register an FPGA Region device
>>>>>   * @parent: device parent
>>>>>   * @mgr: manager that programs this region
>>>>>   * @get_bridges: optional function to get bridges to a list
>>>>> + * @owner: owner module containing get_bridges function
>>>>
>>>> ditto
>>>>
>>>>>   *
>>>>>   * This simple version of the register function should be sufficient for most users.
>>>>>   * The fpga_region_register_full() function is available for users that need to
>>>>> @@ -256,17 +260,17 @@ EXPORT_SYMBOL_GPL(fpga_region_register_full);
>>>>>   * Return: struct fpga_region or ERR_PTR()
>>>>>   */
>>>>>  struct fpga_region *
>>>>> -fpga_region_register(struct device *parent, struct fpga_manager *mgr,
>>>>> -		     int (*get_bridges)(struct fpga_region *))
>>>>> +__fpga_region_register(struct device *parent, struct fpga_manager *mgr,
>>>>> +		       int (*get_bridges)(struct fpga_region *), struct module *owner)
>>>>>  {
>>>>>  	struct fpga_region_info info = { 0 };
>>>>>  
>>>>>  	info.mgr = mgr;
>>>>>  	info.get_bridges = get_bridges;
>>>>>  
>>>>> -	return fpga_region_register_full(parent, &info);
>>>>> +	return __fpga_region_register_full(parent, &info, owner);
>>>>>  }
>>>>> -EXPORT_SYMBOL_GPL(fpga_region_register);
>>>>> +EXPORT_SYMBOL_GPL(__fpga_region_register);
>>>>>  
>>>>>  /**
>>>>>   * fpga_region_unregister - unregister an FPGA region
>>>>> diff --git a/include/linux/fpga/fpga-region.h b/include/linux/fpga/fpga-region.h
>>>>> index 9d4d32909340..5fbc05fe70a6 100644
>>>>> --- a/include/linux/fpga/fpga-region.h
>>>>> +++ b/include/linux/fpga/fpga-region.h
>>>>> @@ -36,6 +36,7 @@ struct fpga_region_info {
>>>>>   * @mgr: FPGA manager
>>>>>   * @info: FPGA image info
>>>>>   * @compat_id: FPGA region id for compatibility check.
>>>>> + * @ops_owner: module containing the get_bridges function
>>>>
>>>> ditto
>>>>
>>>> Thanks,
>>>> Yilun
>>>>
>>>>>   * @priv: private data
>>>>>   * @get_bridges: optional function to get bridges to a list
>>>>>   */
>>>>> @@ -46,6 +47,7 @@ struct fpga_region {
>>>>>  	struct fpga_manager *mgr;
>>>>>  	struct fpga_image_info *info;
>>>>>  	struct fpga_compat_id *compat_id;
>>>>> +	struct module *ops_owner;
>>>>>  	void *priv;
>>>>>  	int (*get_bridges)(struct fpga_region *region);
>>>>>  };
>>>>
>>
> 


