Return-Path: <linux-fpga+bounces-281-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73D1A85BA13
	for <lists+linux-fpga@lfdr.de>; Tue, 20 Feb 2024 12:12:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BEA12835CE
	for <lists+linux-fpga@lfdr.de>; Tue, 20 Feb 2024 11:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29A6367E91;
	Tue, 20 Feb 2024 11:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UbsgpHMq"
X-Original-To: linux-fpga@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6520367E96
	for <linux-fpga@vger.kernel.org>; Tue, 20 Feb 2024 11:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708427496; cv=none; b=nev+PpiBy/xTVzaU9nMSMYfK8+ubl8NCN3PbBrl///nMaXQyuxrcyk/5r/lJ8MOau/Rc240dYcPWUtcLIzmPIYSgKQgrYnTnp4/HGrrU29nOjG9eYiNYsIWTVdGxxbLc6Fzd44FC+VfE9GQzCrou+qQ/P3wAJeanUucXs0oHFXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708427496; c=relaxed/simple;
	bh=C91A5rLZ2ygagCyh3jj0WuRiDBihrW1zf2K5r9Y6ciQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nIxfdQrYzBD4kjpMGV+4xzEozVNTi4DZQGjbrRS+sFWI1zdkahmzy2Ti5VgdWUCS4R8P1wpnHDXIhDSH9gp6PmI1UyYUq7ugQWw3GhVF7gJ4b/19B5qgqWhy3H9jho6MiEe3kpUq8+MdvRQdKjemSrQno4Har5QSjg9Ejd+Fld0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UbsgpHMq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708427493;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2MSipKiPs67DEWw5wlFB16YMhuuCHo3NiTgEwpzrbFk=;
	b=UbsgpHMqbCxrPljrpBhHTt4pEM5vuN+uWs+q3kQAIHisEC/fpbReNJtLcKbr+EbsA7hHAB
	qbTpRJlaz6W5zQUf0TgAY0hThFJOfe3uKk3tfmWsvkhI83mpPanWvTpsXB2XxuAyK1oKbg
	WizUSoRWzaTYmQsNkzdAqK/a+WFmXXk=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-468-afEOQixvNwubF7Pkgu-oCQ-1; Tue, 20 Feb 2024 06:11:31 -0500
X-MC-Unique: afEOQixvNwubF7Pkgu-oCQ-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-68f5fc425ffso24352166d6.1
        for <linux-fpga@vger.kernel.org>; Tue, 20 Feb 2024 03:11:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708427491; x=1709032291;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2MSipKiPs67DEWw5wlFB16YMhuuCHo3NiTgEwpzrbFk=;
        b=a/iToaTkn4ML6UtV79hmryYP+Q0Qj/0B+NMrZS88XZpqz+Bc9Xm9b9Fsdibj842rde
         r18Bs55XL94e7fZ2GgMuhqhTZfU9Tk99bdXN1175KpfbNwdWUefYlksGKyw6G2w+Mqg/
         jzSdfI9807q9+mSocCddhmGhfrhxdq2j93G5GQrpPtgesCON+iOOjHBcucybtPk+J32D
         uXfXGBRNK5sLpVvko0hVxSNrUq4O6ZQfIKp+yxREDU2fg3Hx28Fa57oY8Vbidj6AMo6x
         8+/M8RoNLihzNjxt2h3kLk9FJY85vna2W3ikJqRzrPxrRF2gJIQMbFzZadLWzlSmum7b
         4LeA==
X-Forwarded-Encrypted: i=1; AJvYcCVYrnV9VjmYAzOVvlGgIIXqvZsGEDrN0RRiImx0Fp0OKk/olwDLeTp9s95itoPsfP47/+1KBQiZ4Fkiz03bCT6kHeChbTpItqCezg==
X-Gm-Message-State: AOJu0Yxz6sdF20T2oZa9ynmTkDeZJjziLl0QU25B1vZpj8sJ2knlIQA7
	BPSipQYEaKMx9i1Qh+CnL7QDKp1jNZX2M4HRLqSFnZv/oSgViMJekVRcYRTYiKrl3ao1RYG29Te
	sf325NBPlevVvjZbto+80yKltRL+KjkJGmf9DLeCXpWo9YGNe7H3vPaqIiQ==
X-Received: by 2002:a0c:f2c4:0:b0:68f:7c62:ccc7 with SMTP id c4-20020a0cf2c4000000b0068f7c62ccc7mr3525563qvm.52.1708427490864;
        Tue, 20 Feb 2024 03:11:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH3e+rHiy7BLRRb2Bxlp90Q8E0Y8sYInFwg93yTV1yB+OetOFhQ+ojoYWpsW8esQ9yXtq0xnw==
X-Received: by 2002:a0c:f2c4:0:b0:68f:7c62:ccc7 with SMTP id c4-20020a0cf2c4000000b0068f7c62ccc7mr3525546qvm.52.1708427490567;
        Tue, 20 Feb 2024 03:11:30 -0800 (PST)
Received: from [192.168.9.34] (net-2-34-24-75.cust.vodafonedsl.it. [2.34.24.75])
        by smtp.gmail.com with ESMTPSA id l4-20020a0cee24000000b0068f6e1c3582sm255279qvs.146.2024.02.20.03.11.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Feb 2024 03:11:30 -0800 (PST)
Message-ID: <9a9d4018-fd65-49be-9e0a-1eecc9cbf15d@redhat.com>
Date: Tue, 20 Feb 2024 12:11:26 +0100
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v5 1/1] fpga: add an owner and use it to take the
 low-level module's refcount
Content-Language: en-US
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
From: Marco Pagani <marpagan@redhat.com>
In-Reply-To: <ZdHWaeU+/On6LmHX@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024-02-18 11:05, Xu Yilun wrote:
> On Mon, Feb 05, 2024 at 06:47:34PM +0100, Marco Pagani wrote:
>>
>>
>> On 2024-02-04 06:15, Xu Yilun wrote:
>>> On Fri, Feb 02, 2024 at 06:44:01PM +0100, Marco Pagani wrote:
>>>>
>>>>
>>>> On 2024-01-30 05:31, Xu Yilun wrote:
>>>>>> +#define fpga_mgr_register_full(parent, info) \
>>>>>> +	__fpga_mgr_register_full(parent, info, THIS_MODULE)
>>>>>>  struct fpga_manager *
>>>>>> -fpga_mgr_register_full(struct device *parent, const struct fpga_manager_info *info);
>>>>>> +__fpga_mgr_register_full(struct device *parent, const struct fpga_manager_info *info,
>>>>>> +			 struct module *owner);
>>>>>>  
>>>>>> +#define fpga_mgr_register(parent, name, mops, priv) \
>>>>>> +	__fpga_mgr_register(parent, name, mops, priv, THIS_MODULE)
>>>>>>  struct fpga_manager *
>>>>>> -fpga_mgr_register(struct device *parent, const char *name,
>>>>>> -		  const struct fpga_manager_ops *mops, void *priv);
>>>>>> +__fpga_mgr_register(struct device *parent, const char *name,
>>>>>> +		    const struct fpga_manager_ops *mops, void *priv, struct module *owner);
>>>>>> +
>>>>>>  void fpga_mgr_unregister(struct fpga_manager *mgr);
>>>>>>  
>>>>>> +#define devm_fpga_mgr_register_full(parent, info) \
>>>>>> +	__devm_fpga_mgr_register_full(parent, info, THIS_MODULE)
>>>>>>  struct fpga_manager *
>>>>>> -devm_fpga_mgr_register_full(struct device *parent, const struct fpga_manager_info *info);
>>>>>> +__devm_fpga_mgr_register_full(struct device *parent, const struct fpga_manager_info *info,
>>>>>> +			      struct module *owner);
>>>>>
>>>>> Add a line here. I can do it myself if you agree.
>>>>
>>>> Sure, that is fine by me. I also spotted a typo in the commit log body
>>>> (in taken -> is taken). Do you want me to send a v6, or do you prefer
>>>> to fix that in place?
>>>
>>> No need, I can fix it.
>>>
>>>>
>>>>>
>>>>> There is still a RFC prefix for this patch. Are you ready to get it merged?
>>>>> If yes, Acked-by: Xu Yilun <yilun.xu@intel.com>
>>>>
>>>> I'm ready for the patch to be merged. However, I recently sent an RFC
>>>> to propose a safer implementation of try_module_get() that would
>>>> simplify the code and may also benefit other subsystems. What do you
>>>> think?
>>>>
>>>> https://lore.kernel.org/linux-modules/20240130193614.49772-1-marpagan@redhat.com/
>>>
>>> I suggest take your fix to linux-fpga/for-next now. If your try_module_get()
>>> proposal is applied before the end of this cycle, we could re-evaluate
>>> this patch.
>>
>> That's fine by me.
> 
> Sorry, I still found issues about this solution.
> 
> void fpga_mgr_unregister(struct fpga_manager *mgr)
> {
>         dev_info(&mgr->dev, "%s %s\n", __func__, mgr->name);
> 
>         /*
>          * If the low level driver provides a method for putting fpga into
>          * a desired state upon unregister, do it.
>          */
>         fpga_mgr_fpga_remove(mgr);
> 
>         mutex_lock(&mgr->mops_mutex);
> 
>         mgr->mops = NULL;
> 
>         mutex_unlock(&mgr->mops_mutex);
> 
>         device_unregister(&mgr->dev);
> }
> 
> Note that fpga_mgr_unregister() doesn't have to be called in module_exit().
> So if we do fpga_mgr_get() then fpga_mgr_unregister(), We finally had a
> fpga_manager dev without mops, this is not what the user want and cause
> problem when using this fpga_manager dev for other FPGA APIs.

How about moving mgr->mops = NULL from fpga_mgr_unregister() to
class->dev_release()? In that way, mops will be set to NULL only when the
manager dev refcount reaches 0.

If fpga_mgr_unregister() is called from module_exit(), we are sure that nobody
got the manager dev earlier using fpga_mgr_get(), or it would have bumped up
the module's refcount, preventing its removal in the first place. In this case,
when device_unregister() is called, it will trigger dev_release() since the
manager dev refcount has reached 0.

If fpga_mgr_unregister() is called elsewhere in the module that registered the
manager (1), we have two subcases:

a) someone got the manager dev earlier and bumped the module's refcount. Hence,
the ops are safe since the module cannot be removed until the manager dev is
released by calling (the last) put_device(). This, in turn, will trigger
class->dev_release().

b) no one got manager dev. In this case, class->dev_release() will be called
immediately.

(1) The caller of fpga_mgr_register_*() is responsible for calling
fpga_mgr_unregister(), as specified in the docs.

> I have this concern when I was reviewing the same improvement for fpga
> bridge. The change for fpga bridge seems workable, the mutex keeps hold
> until fpga_bridge_put(). But I somewhat don't prefer the unregistration
> been unnecessarily blocked for long term.

I also don't like the idea of potentially blocking the unregistration, but I
could not find a better solution for the bridge at the moment.

> I think your try_module_get_safe() patch may finally solve the invalid
> module owner issue. Some options now, we ignore the invalid module owner
> issue (it exists before this change) and merge the rest of the
> improvements, or we wait for your patch accepted then re-evaluate. I
> prefer the former.

Yeah, try_module_get_safe() would make things simpler and easier. I'm currently
working on a series of selftests to demonstrate that the function is safe from
deadlocks, as requested by the maintainer. I hope I can convince people of the
advantages.

Thanks,
Marco


