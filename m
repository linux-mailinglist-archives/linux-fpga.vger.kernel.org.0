Return-Path: <linux-fpga+bounces-296-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BE9A868F67
	for <lists+linux-fpga@lfdr.de>; Tue, 27 Feb 2024 12:49:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 781871F27216
	for <lists+linux-fpga@lfdr.de>; Tue, 27 Feb 2024 11:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8999D13959F;
	Tue, 27 Feb 2024 11:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YwepjxT7"
X-Original-To: linux-fpga@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C60E01384B9
	for <linux-fpga@vger.kernel.org>; Tue, 27 Feb 2024 11:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709034555; cv=none; b=UbAVz+QLspBBlbeGY9Ir06llo7j+RomemfRCGN+ZHSZ/5zBfLTOsEFeqMngwdGj+k6PBHvp4hXX8QIBA/giWHww/KiGRLumDb1QNA5bfpkCoV7jLBpGxypoCR8QGD1/cvEeEJ3O6up7nSrs2DJBKYGSD4OZx6OFU1A+Wa87e9cQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709034555; c=relaxed/simple;
	bh=UousizaRBOkglhySSICITocpDyA5znlSJNJqP0CNqjM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p5pdUjX0z4KrTmH1gENT8LCBSJnBki1k4JS5NoIqDTu/ghW+wilMY74ru/+NvqC5H1pkz2Z/EQhUrsjujf+gpGfNJ1l5c1oJ4O/gHdT9emgPBhnNOV1zqxKvTU5vCB3wo/UmlqBwfrpxtldZZGnKxFNqSBFazwmJBsqqkNBpYB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YwepjxT7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709034552;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0/IU59TzJPaZ/e/WhPBdoj8RUUDKdP5qN63RH8kPqgk=;
	b=YwepjxT7WcQ0YU1CcZdeImQoVlATIuARD6P7tSPS9NeZRwjLsRTcoRUJG8WhIP1VyfWcks
	nCIyMQcE1AiCKZpPMeoEwuEPczV9uMCypjcHNjtPYH7kTlkJetbKHKLsGEvxOGGXJPTqtb
	EP/FGf3JxcLoQIp/FprJKnFiQOqcLSI=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-gJniOEgsOLu2uyPQwnlBwQ-1; Tue, 27 Feb 2024 06:49:11 -0500
X-MC-Unique: gJniOEgsOLu2uyPQwnlBwQ-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6901234f078so15974466d6.0
        for <linux-fpga@vger.kernel.org>; Tue, 27 Feb 2024 03:49:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709034551; x=1709639351;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0/IU59TzJPaZ/e/WhPBdoj8RUUDKdP5qN63RH8kPqgk=;
        b=hUhsAthvTpX1v6bqCFFW0eBXSX9icUOxEiqVjBy/IyNQ0LQvqermUw73TLjeWnFI7q
         /T+vvaIUMy7o6w5ha26kYWYeT+3KIrKPKacAanM4js9NmldmsdISD7H97FQm0ucoWnE2
         KKfNO3Kc6vwX9oFkQL1auA5SUAHxoP0EP7Zmin6AUZCp9rPAmRDI+u/+HK3blksdDIAG
         Sc1jLGb+8QiDps/bQrA8rGy4D2QA1hl0hkraBA+Lkv2Oj5tRqK+yX1A6JN65AzfgDCqT
         8Qty2gQLhm3BZUKwpfQNOpvUwwRCTlF+FjE/zrNDCqelAk5FeeRizr5pSUhFtKIwlRAA
         voBA==
X-Forwarded-Encrypted: i=1; AJvYcCW/eFpn9NOrMpoE1l/iBDnZrrriyWTdJaMJETJu5Ho4r3ti2YsNmZDIp3Ah8ZBzDyQpF1LjWc+tg3f2bMKvPJ9IQwLWVwPl1J0Udw==
X-Gm-Message-State: AOJu0Yzz4O+lHtrMP69K5mtUnnV5wzMwEEkYDQnRhDYT9a7QhSTncTmI
	N/tjKlHfM4MwNBAfgop5eeLaOG+m1m9O+iL2udANuU8B9wk3lGr5mHr1PC5L6ngIkHZv6K42z0t
	zvWn453jtIQ+0vi/iksCVoxl0gCtBRHzFM3B5XPLiayGIrVGq+2PiBwyaDw==
X-Received: by 2002:a05:6214:509b:b0:68f:5ac3:8af3 with SMTP id kk27-20020a056214509b00b0068f5ac38af3mr1976403qvb.22.1709034550939;
        Tue, 27 Feb 2024 03:49:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGKWbuU40rDlbdUvfIiKGDOizWmABM8HEsCdP8/vSZa8l8MnsDCfln+CVmlGikRiYl39wsyVA==
X-Received: by 2002:a05:6214:509b:b0:68f:5ac3:8af3 with SMTP id kk27-20020a056214509b00b0068f5ac38af3mr1976386qvb.22.1709034550616;
        Tue, 27 Feb 2024 03:49:10 -0800 (PST)
Received: from [192.168.9.34] (net-2-34-30-118.cust.vodafonedsl.it. [2.34.30.118])
        by smtp.gmail.com with ESMTPSA id qj24-20020a056214321800b0068f9fd1d688sm4037682qvb.21.2024.02.27.03.49.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Feb 2024 03:49:10 -0800 (PST)
Message-ID: <ae3cd81b-82af-4977-91d7-fa809c6fc45a@redhat.com>
Date: Tue, 27 Feb 2024 12:49:06 +0100
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v5 1/1] fpga: add an owner and use it to take the
 low-level module's refcount
To: Xu Yilun <yilun.xu@linux.intel.com>
Cc: Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
 Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
 Jonathan Corbet <corbet@lwn.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Alan Tull <atull@opensource.altera.com>, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-fpga@vger.kernel.org
References: <20240111160242.149265-1-marpagan@redhat.com>
 <20240111160242.149265-2-marpagan@redhat.com>
 <Zbh7iO9wlm9ekzB7@yilunxu-OptiPlex-7050>
 <0720eb91-72f9-4781-8558-8a1b0a3691c2@redhat.com>
 <Zb8dd9af0Ru/fzGi@yilunxu-OptiPlex-7050>
 <4aaa131a-4b64-4b86-9548-68aef63c87b3@redhat.com>
 <ZdHWaeU+/On6LmHX@yilunxu-OptiPlex-7050>
 <9a9d4018-fd65-49be-9e0a-1eecc9cbf15d@redhat.com>
 <ZdYKnZxdTCvu5THG@yilunxu-OptiPlex-7050>
Content-Language: en-US
From: Marco Pagani <marpagan@redhat.com>
In-Reply-To: <ZdYKnZxdTCvu5THG@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024-02-21 15:37, Xu Yilun wrote:
> On Tue, Feb 20, 2024 at 12:11:26PM +0100, Marco Pagani wrote:
>>
>>
>> On 2024-02-18 11:05, Xu Yilun wrote:
>>> On Mon, Feb 05, 2024 at 06:47:34PM +0100, Marco Pagani wrote:
>>>>
>>>>
>>>> On 2024-02-04 06:15, Xu Yilun wrote:
>>>>> On Fri, Feb 02, 2024 at 06:44:01PM +0100, Marco Pagani wrote:
>>>>>>
>>>>>>
>>>>>> On 2024-01-30 05:31, Xu Yilun wrote:
>>>>>>>> +#define fpga_mgr_register_full(parent, info) \
>>>>>>>> +	__fpga_mgr_register_full(parent, info, THIS_MODULE)
>>>>>>>>  struct fpga_manager *
>>>>>>>> -fpga_mgr_register_full(struct device *parent, const struct fpga_manager_info *info);
>>>>>>>> +__fpga_mgr_register_full(struct device *parent, const struct fpga_manager_info *info,
>>>>>>>> +			 struct module *owner);
>>>>>>>>  
>>>>>>>> +#define fpga_mgr_register(parent, name, mops, priv) \
>>>>>>>> +	__fpga_mgr_register(parent, name, mops, priv, THIS_MODULE)
>>>>>>>>  struct fpga_manager *
>>>>>>>> -fpga_mgr_register(struct device *parent, const char *name,
>>>>>>>> -		  const struct fpga_manager_ops *mops, void *priv);
>>>>>>>> +__fpga_mgr_register(struct device *parent, const char *name,
>>>>>>>> +		    const struct fpga_manager_ops *mops, void *priv, struct module *owner);
>>>>>>>> +
>>>>>>>>  void fpga_mgr_unregister(struct fpga_manager *mgr);
>>>>>>>>  
>>>>>>>> +#define devm_fpga_mgr_register_full(parent, info) \
>>>>>>>> +	__devm_fpga_mgr_register_full(parent, info, THIS_MODULE)
>>>>>>>>  struct fpga_manager *
>>>>>>>> -devm_fpga_mgr_register_full(struct device *parent, const struct fpga_manager_info *info);
>>>>>>>> +__devm_fpga_mgr_register_full(struct device *parent, const struct fpga_manager_info *info,
>>>>>>>> +			      struct module *owner);
>>>>>>>
>>>>>>> Add a line here. I can do it myself if you agree.
>>>>>>
>>>>>> Sure, that is fine by me. I also spotted a typo in the commit log body
>>>>>> (in taken -> is taken). Do you want me to send a v6, or do you prefer
>>>>>> to fix that in place?
>>>>>
>>>>> No need, I can fix it.
>>>>>
>>>>>>
>>>>>>>
>>>>>>> There is still a RFC prefix for this patch. Are you ready to get it merged?
>>>>>>> If yes, Acked-by: Xu Yilun <yilun.xu@intel.com>
>>>>>>
>>>>>> I'm ready for the patch to be merged. However, I recently sent an RFC
>>>>>> to propose a safer implementation of try_module_get() that would
>>>>>> simplify the code and may also benefit other subsystems. What do you
>>>>>> think?
>>>>>>
>>>>>> https://lore.kernel.org/linux-modules/20240130193614.49772-1-marpagan@redhat.com/
>>>>>
>>>>> I suggest take your fix to linux-fpga/for-next now. If your try_module_get()
>>>>> proposal is applied before the end of this cycle, we could re-evaluate
>>>>> this patch.
>>>>
>>>> That's fine by me.
>>>
>>> Sorry, I still found issues about this solution.
>>>
>>> void fpga_mgr_unregister(struct fpga_manager *mgr)
>>> {
>>>         dev_info(&mgr->dev, "%s %s\n", __func__, mgr->name);
>>>
>>>         /*
>>>          * If the low level driver provides a method for putting fpga into
>>>          * a desired state upon unregister, do it.
>>>          */
>>>         fpga_mgr_fpga_remove(mgr);
>>>
>>>         mutex_lock(&mgr->mops_mutex);
>>>
>>>         mgr->mops = NULL;
>>>
>>>         mutex_unlock(&mgr->mops_mutex);
>>>
>>>         device_unregister(&mgr->dev);
>>> }
>>>
>>> Note that fpga_mgr_unregister() doesn't have to be called in module_exit().
>>> So if we do fpga_mgr_get() then fpga_mgr_unregister(), We finally had a
>>> fpga_manager dev without mops, this is not what the user want and cause
>>> problem when using this fpga_manager dev for other FPGA APIs.
>>
>> How about moving mgr->mops = NULL from fpga_mgr_unregister() to
>> class->dev_release()? In that way, mops will be set to NULL only when the
>> manager dev refcount reaches 0.
> 
> I'm afraid it doesn't help.  The lifecycle of the module and the fpga
> mgr dev is different.
> 
> We use mops = NULL to indicate module has been freed or will be freed in no
> time.  On the other hand mops != NULL means module is still there, so
> that try_module_get() could be safely called.  It is possible someone
> has got fpga mgr dev but not the module yet, at that time the module is
> unloaded, then try_module_get() triggers crash.
> 
>>
>> If fpga_mgr_unregister() is called from module_exit(), we are sure that nobody
>> got the manager dev earlier using fpga_mgr_get(), or it would have bumped up
> 
> No, someone may get the manager dev but not the module yet, and been
> scheduled out.
>

You are right. Overall, it's a bad idea. How about then using an additional 
bool flag instead of "overloading" the mops pointer? Something like:

get:
	if (!mgr->owner_valid || !try_module_get(mgr->mops_owner))

remove:
	mgr->owner_valid = false;

Another possibility that comes to my mind would be to "overload" the owner
pointer itself by using the ERR_PTR/IS_ERR macros. However, it looks ugly
to me.

Thanks,
Marco


[...]


