Return-Path: <linux-fpga+bounces-304-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBBA686E597
	for <lists+linux-fpga@lfdr.de>; Fri,  1 Mar 2024 17:29:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC9081C20DB1
	for <lists+linux-fpga@lfdr.de>; Fri,  1 Mar 2024 16:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8944470CC8;
	Fri,  1 Mar 2024 16:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PB1fikMz"
X-Original-To: linux-fpga@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7162F70CA7
	for <linux-fpga@vger.kernel.org>; Fri,  1 Mar 2024 16:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709310573; cv=none; b=HooEXrFZi1f8Aa3zgYyXCsKA6/LAVf0tPVVXCjRS/tNjDDCf4/K8IAfBU7TIFGMQc22f/wNx5YQU54HdWQX0av6mUkDK6/giKDIlnsq3sykPgcoK4inDWj9/6Z9R88ziQP/efHD4dX7BwnNKpiCuidMJMfsgi1LLIpHKlvT7g94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709310573; c=relaxed/simple;
	bh=4ENR5LUp28xMXehmU/AKJ8VrJmmzhvBxZei16elzGu8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jofyk7Gcay7NYE5SQyT/q0cQA1AFUdZiWKuimDZ3yonWsts9GNX39R0qKqyzNSWdSE+oK0wVXmZ4vWWiwu7tUnwgeyvXVEho6d/qMJuW7FQEA4EJwhehU/pHTXDUKfvgPeNVhk1Bdr0wOV2YWdulbTX78GgCgTFob0tCwnvYVOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PB1fikMz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709310570;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QNe7wQkN/o3BCAKNQu3U4+jdytvs3hfcAhbPOfxPT0w=;
	b=PB1fikMzqjz8+Abrbl92XkHDfocz94FfNt4r5mRieozL+FBK5pA1ek0IhE0SkiXagcOm9e
	WFRuhYYK4IQXpPLmkNDJcCHm8UeCdlbsFKXWIxQbKXsNCCWrou9SyHHr0UJPwgi3mb7PNq
	8ifvpWy3NXjcQFPA4/9b0Mrvb+RMD8o=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-583-u9ZQA5EHOc2Y2zLxtscJDw-1; Fri, 01 Mar 2024 11:29:29 -0500
X-MC-Unique: u9ZQA5EHOc2Y2zLxtscJDw-1
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-3c03ea9cde0so2738795b6e.3
        for <linux-fpga@vger.kernel.org>; Fri, 01 Mar 2024 08:29:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709310568; x=1709915368;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QNe7wQkN/o3BCAKNQu3U4+jdytvs3hfcAhbPOfxPT0w=;
        b=OXOf1hZi7KskGivUXrGF5Rw1Unpx5FtiFi/u29yifiIFBqziib2JMRI+TEIt7iyLTE
         57s3sPepB2ftpGo9nP/wp+tre6pqATY0WOnbRKQ38MjOaNv9sChZq3YdvU00O2Y0ldKg
         ptw67awOKTt6+ui/VrqKSISyHah2U0SfAri6n/9rbSj/SoLEJaRrhlIoIQ54SqKUqrpi
         IwlQHgX4Qe1TbLzatCFybrHMns3HUwxxTYZpAwb4INEv7KGCBht0P7WV6jQFkTofHIj+
         w1cKWwVsSlfgSXsNSkkdFQnfGakWb0nYA9Yc3OcARfxCt2KZ606EOy/HMi/ASfNWILCh
         mxQg==
X-Forwarded-Encrypted: i=1; AJvYcCV8XpBd2oZa/a+5r3hYZx7h0AIFQ8DUCyYig+4130wJ7OuA84uQGt25vmR0NPKR8TQlcGNiOCTBM0Lwf0WoZdGj6roj644hzbIMOQ==
X-Gm-Message-State: AOJu0YwY4ZdFXhv+ZWsu4ZHc5QnZm8iDlxxG48pJx6R/Gr58aycQS06H
	O+6lORJMpVgOybxvxf98kKmpH6EngI+7PLg3m3GRDucb/2hUtRqVX/jcc1dDNbyCr0eQ4tDFJrr
	Z5KcoD7Jp6UZMqUigovljxIMb57uyL27UOEffuWQPgwjhfUKaJ+Zm3XDWEo8d0zSCHQ==
X-Received: by 2002:a05:6808:2124:b0:3c1:c250:96ee with SMTP id r36-20020a056808212400b003c1c25096eemr2651215oiw.2.1709310567911;
        Fri, 01 Mar 2024 08:29:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHlTpfV8lDCDZU0jDCFb2TIQ4JuCOInMQ1C6p5i+3jWLtn6h3oIis54i4vBrQ/yhtLTAXXavg==
X-Received: by 2002:a05:6808:2124:b0:3c1:c250:96ee with SMTP id r36-20020a056808212400b003c1c25096eemr2651188oiw.2.1709310567520;
        Fri, 01 Mar 2024 08:29:27 -0800 (PST)
Received: from [192.168.9.34] (net-2-34-30-118.cust.vodafonedsl.it. [2.34.30.118])
        by smtp.gmail.com with ESMTPSA id e12-20020ac84b4c000000b0042e69db4c1fsm1832196qts.39.2024.03.01.08.29.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Mar 2024 08:29:27 -0800 (PST)
Message-ID: <d4f5243c-696a-4d1d-94f4-0ecf42b6d7f0@redhat.com>
Date: Fri, 1 Mar 2024 17:29:24 +0100
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
References: <Zbh7iO9wlm9ekzB7@yilunxu-OptiPlex-7050>
 <0720eb91-72f9-4781-8558-8a1b0a3691c2@redhat.com>
 <Zb8dd9af0Ru/fzGi@yilunxu-OptiPlex-7050>
 <4aaa131a-4b64-4b86-9548-68aef63c87b3@redhat.com>
 <ZdHWaeU+/On6LmHX@yilunxu-OptiPlex-7050>
 <9a9d4018-fd65-49be-9e0a-1eecc9cbf15d@redhat.com>
 <ZdYKnZxdTCvu5THG@yilunxu-OptiPlex-7050>
 <ae3cd81b-82af-4977-91d7-fa809c6fc45a@redhat.com>
 <Zd7cff43ffbJOGNY@yilunxu-OptiPlex-7050>
 <0c885ff2-44bc-4158-b5dd-3d7513cb2857@redhat.com>
 <ZeHwatupHVmC2N2+@yilunxu-OptiPlex-7050>
Content-Language: en-US
From: Marco Pagani <marpagan@redhat.com>
In-Reply-To: <ZeHwatupHVmC2N2+@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024-03-01 16:12, Xu Yilun wrote:
> On Thu, Feb 29, 2024 at 11:37:10AM +0100, Marco Pagani wrote:
>>
>> On 2024-02-28 08:10, Xu Yilun wrote:
>>> On Tue, Feb 27, 2024 at 12:49:06PM +0100, Marco Pagani wrote:
>>>>
>>>>
>>>> On 2024-02-21 15:37, Xu Yilun wrote:
>>>>> On Tue, Feb 20, 2024 at 12:11:26PM +0100, Marco Pagani wrote:
>>>>>>
>>>>>>
>>>>>> On 2024-02-18 11:05, Xu Yilun wrote:
>>>>>>> On Mon, Feb 05, 2024 at 06:47:34PM +0100, Marco Pagani wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>> On 2024-02-04 06:15, Xu Yilun wrote:
>>>>>>>>> On Fri, Feb 02, 2024 at 06:44:01PM +0100, Marco Pagani wrote:
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> On 2024-01-30 05:31, Xu Yilun wrote:
>>>>>>>>>>>> +#define fpga_mgr_register_full(parent, info) \
>>>>>>>>>>>> +	__fpga_mgr_register_full(parent, info, THIS_MODULE)
>>>>>>>>>>>>  struct fpga_manager *
>>>>>>>>>>>> -fpga_mgr_register_full(struct device *parent, const struct fpga_manager_info *info);
>>>>>>>>>>>> +__fpga_mgr_register_full(struct device *parent, const struct fpga_manager_info *info,
>>>>>>>>>>>> +			 struct module *owner);
>>>>>>>>>>>>  
>>>>>>>>>>>> +#define fpga_mgr_register(parent, name, mops, priv) \
>>>>>>>>>>>> +	__fpga_mgr_register(parent, name, mops, priv, THIS_MODULE)
>>>>>>>>>>>>  struct fpga_manager *
>>>>>>>>>>>> -fpga_mgr_register(struct device *parent, const char *name,
>>>>>>>>>>>> -		  const struct fpga_manager_ops *mops, void *priv);
>>>>>>>>>>>> +__fpga_mgr_register(struct device *parent, const char *name,
>>>>>>>>>>>> +		    const struct fpga_manager_ops *mops, void *priv, struct module *owner);
>>>>>>>>>>>> +
>>>>>>>>>>>>  void fpga_mgr_unregister(struct fpga_manager *mgr);
>>>>>>>>>>>>  
>>>>>>>>>>>> +#define devm_fpga_mgr_register_full(parent, info) \
>>>>>>>>>>>> +	__devm_fpga_mgr_register_full(parent, info, THIS_MODULE)
>>>>>>>>>>>>  struct fpga_manager *
>>>>>>>>>>>> -devm_fpga_mgr_register_full(struct device *parent, const struct fpga_manager_info *info);
>>>>>>>>>>>> +__devm_fpga_mgr_register_full(struct device *parent, const struct fpga_manager_info *info,
>>>>>>>>>>>> +			      struct module *owner);
>>>>>>>>>>>
>>>>>>>>>>> Add a line here. I can do it myself if you agree.
>>>>>>>>>>
>>>>>>>>>> Sure, that is fine by me. I also spotted a typo in the commit log body
>>>>>>>>>> (in taken -> is taken). Do you want me to send a v6, or do you prefer
>>>>>>>>>> to fix that in place?
>>>>>>>>>
>>>>>>>>> No need, I can fix it.
>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> There is still a RFC prefix for this patch. Are you ready to get it merged?
>>>>>>>>>>> If yes, Acked-by: Xu Yilun <yilun.xu@intel.com>
>>>>>>>>>>
>>>>>>>>>> I'm ready for the patch to be merged. However, I recently sent an RFC
>>>>>>>>>> to propose a safer implementation of try_module_get() that would
>>>>>>>>>> simplify the code and may also benefit other subsystems. What do you
>>>>>>>>>> think?
>>>>>>>>>>
>>>>>>>>>> https://lore.kernel.org/linux-modules/20240130193614.49772-1-marpagan@redhat.com/
>>>>>>>>>
>>>>>>>>> I suggest take your fix to linux-fpga/for-next now. If your try_module_get()
>>>>>>>>> proposal is applied before the end of this cycle, we could re-evaluate
>>>>>>>>> this patch.
>>>>>>>>
>>>>>>>> That's fine by me.
>>>>>>>
>>>>>>> Sorry, I still found issues about this solution.
>>>>>>>
>>>>>>> void fpga_mgr_unregister(struct fpga_manager *mgr)
>>>>>>> {
>>>>>>>         dev_info(&mgr->dev, "%s %s\n", __func__, mgr->name);
>>>>>>>
>>>>>>>         /*
>>>>>>>          * If the low level driver provides a method for putting fpga into
>>>>>>>          * a desired state upon unregister, do it.
>>>>>>>          */
>>>>>>>         fpga_mgr_fpga_remove(mgr);
>>>>>>>
>>>>>>>         mutex_lock(&mgr->mops_mutex);
>>>>>>>
>>>>>>>         mgr->mops = NULL;
>>>>>>>
>>>>>>>         mutex_unlock(&mgr->mops_mutex);
>>>>>>>
>>>>>>>         device_unregister(&mgr->dev);
>>>>>>> }
>>>>>>>
>>>>>>> Note that fpga_mgr_unregister() doesn't have to be called in module_exit().
>>>>>>> So if we do fpga_mgr_get() then fpga_mgr_unregister(), We finally had a
>>>>>>> fpga_manager dev without mops, this is not what the user want and cause
>>>>>>> problem when using this fpga_manager dev for other FPGA APIs.
>>>>>>
>>>>>> How about moving mgr->mops = NULL from fpga_mgr_unregister() to
>>>>>> class->dev_release()? In that way, mops will be set to NULL only when the
>>>>>> manager dev refcount reaches 0.
>>>>>
>>>>> I'm afraid it doesn't help.  The lifecycle of the module and the fpga
>>>>> mgr dev is different.
>>>>>
>>>>> We use mops = NULL to indicate module has been freed or will be freed in no
>>>>> time.  On the other hand mops != NULL means module is still there, so
>>>>> that try_module_get() could be safely called.  It is possible someone
>>>>> has got fpga mgr dev but not the module yet, at that time the module is
>>>>> unloaded, then try_module_get() triggers crash.
>>>>>
>>>>>>
>>>>>> If fpga_mgr_unregister() is called from module_exit(), we are sure that nobody
>>>>>> got the manager dev earlier using fpga_mgr_get(), or it would have bumped up
>>>>>
>>>>> No, someone may get the manager dev but not the module yet, and been
>>>>> scheduled out.
>>>>>
>>>>
>>>> You are right. Overall, it's a bad idea. How about then using an additional 
>>>> bool flag instead of "overloading" the mops pointer? Something like:
>>>>
>>>> get:
>>>> 	if (!mgr->owner_valid || !try_module_get(mgr->mops_owner))
>>>>
>>>> remove:
>>>> 	mgr->owner_valid = false;
>>>
>>> I'm not quite sure which function is actually mentioned by "remove".  I
>>> assume it should be fpga_mgr_unregister().
>>
>> Yes, I was referring to fpga_mgr_unregister().
>>
>>> IIUC this flag means no more reference to fpga mgr, but existing
>>> references are still valid.
>>
>> Yes.
>>
>>>
>>> It works for me. But the name of this flag could be reconsidered to
>>> avoid misunderstanding.  The owner is still valid (we still need to put
>>> the owner) but allows no more reference.  Maybe "owner_inactive"?
>>
>> Right, owner_valid might be misleading. How about removing any
>> reference to the owner module and name the flag unreg?
> 
> the full name "unregistered" is better.

That's fine by me.

> 
>>
>> __fpga_mgr_get:
>> 	if (mgr->unreg || !try_module_get(mgr->mops_owner))
>> 		mgr = ERR_PTR(-ENODEV);
>>
>> fpga_mgr_unregister:
>>  	mgr->unreg = true;
>>
>>> I still wanna this owner reference change been splitted, so that
>>> we could simply revert it when the try_module_get_safe() got accepted.
>>
>> I guess it may take some time to have try_module_get_safe() accepted.
>> What do you prefer to do with the bridge and the region in the
>> meantime?
> 
> This issue could happen in little chance. I actually don't have much
> preference, either way is good to me.
> 

Okay, I'll also send the patch for the region then.

Thanks,
Marco


