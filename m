Return-Path: <linux-fpga+bounces-49-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 570A47FED1B
	for <lists+linux-fpga@lfdr.de>; Thu, 30 Nov 2023 11:42:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 221AE1C20D8F
	for <lists+linux-fpga@lfdr.de>; Thu, 30 Nov 2023 10:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76C0C3C06E;
	Thu, 30 Nov 2023 10:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q6rZHy5O"
X-Original-To: linux-fpga@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 240BB10DB
	for <linux-fpga@vger.kernel.org>; Thu, 30 Nov 2023 02:42:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701340962;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aZ1Pvc4c3F7Q6rOgmqORqJyTcv5oSL8c+4FiyLvo39c=;
	b=Q6rZHy5O8hYOalrNi8RN47TZ9SjF9i4uv7RqLMlb0YS9EqROY6lGsamkrt1BhVWkN+57is
	hKlkO8gms90QDH0BgAmcywZZSwVB01s6QzakvcsCwrAlGN89+JGZTkAbFV3BV91LD8rIaE
	0sIrGKT8Egm7j0rBeBTc1I0Y3ICHbVE=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-33-ZGI-9MSeP7SNDC6Z_X2SjA-1; Thu, 30 Nov 2023 05:42:40 -0500
X-MC-Unique: ZGI-9MSeP7SNDC6Z_X2SjA-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-50ab7b85b6eso831457e87.3
        for <linux-fpga@vger.kernel.org>; Thu, 30 Nov 2023 02:42:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701340959; x=1701945759;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aZ1Pvc4c3F7Q6rOgmqORqJyTcv5oSL8c+4FiyLvo39c=;
        b=gJ2uA2I43I1HpN50AIormqT7QAPqPETJvhAx/cmar07uZ4/ftMxkXiCaHd3Al3wHcY
         UMbwl8i11NYO6bdlNlbepR/nuYu6anzPUUMmetzDnClY43BoDTSh/UCXxF3dg+DNCC4/
         S4R2MXcqi003tB18RqBx7ySTR+1M+Y1Tqow97TqHfNWa0A/y5V1vLDjpHXucO/UoIXhH
         n0QsGDe1nkvbi7LICCoN1cZnZM7UFWuz5moLhu7J3ShHds0Dd0tAkavv2otvaHOpaCBj
         FnoniBeEOEdzODbvKNMQ3ErQsRRCgWe4Cd1mJG0kL3HiwSAVMPIn8fq+9kRAWeuReBz6
         pBlA==
X-Gm-Message-State: AOJu0Yz7fABhJlxu0kpbp/nUeg1xqoyMW0qWJSxeuTR/bZDLARwUd3Yy
	B2IDu6pSDdXqWlNhN3SlQQcbnteg1kSlAGj6uFtBflfqebR4/Fa5xxCTvzISPuP5jtwrKSmfzpd
	CygG5jP/wyDbYbYrklgrk
X-Received: by 2002:a05:6512:39c5:b0:50b:caed:71f5 with SMTP id k5-20020a05651239c500b0050bcaed71f5mr1675847lfu.6.1701340959117;
        Thu, 30 Nov 2023 02:42:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE+4iQXCCZBlJckrLPtfF30/I0+ZNGOYW/SKU86jNTI4+7W2JATdzHLDiNH16XXm3B3+/4aAQ==
X-Received: by 2002:a05:6512:39c5:b0:50b:caed:71f5 with SMTP id k5-20020a05651239c500b0050bcaed71f5mr1675827lfu.6.1701340958759;
        Thu, 30 Nov 2023 02:42:38 -0800 (PST)
Received: from [192.168.9.34] (net-2-34-30-38.cust.vodafonedsl.it. [2.34.30.38])
        by smtp.gmail.com with ESMTPSA id e9-20020adffc49000000b00332cfd83b8dsm1164223wrs.96.2023.11.30.02.42.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Nov 2023 02:42:38 -0800 (PST)
Message-ID: <7004d215-5185-4cce-a51e-42e131a30453@redhat.com>
Date: Thu, 30 Nov 2023 11:42:36 +0100
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Marco Pagani <marpagan@redhat.com>
Subject: Re: [RFC PATCH v2 1/2] fpga: add a module owner field to fpga_manager
 and fpga_manager_ops
To: Xu Yilun <yilun.xu@linux.intel.com>
Cc: Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
 Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org
References: <20231124162807.238724-1-marpagan@redhat.com>
 <20231124162807.238724-2-marpagan@redhat.com>
 <ZWG6Tg0egX6Cy9j5@yilunxu-OptiPlex-7050>
Content-Language: en-US
In-Reply-To: <ZWG6Tg0egX6Cy9j5@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2023-11-25 10:11, Xu Yilun wrote:
> On Fri, Nov 24, 2023 at 05:28:06PM +0100, Marco Pagani wrote:
>> Add a module *owner field to the fpga_manager_ops and fpga_manager
>> structs to protect the fpga manager against the unloading of the
>> low-level control module while someone is holding a reference to the
>> manager device. Low-level control modules should statically set the
>> owner field of the fpga_manager_ops struct to THIS_MODULE. Then, when
>> the manager is registered using fpga_mgr_register(), the value is copied
>> into the owner field of the fpga_manager struct (that contains the
>> device context). In this way, the manager can later use it in
>> fpga_mgr_get() to take the low-level module's refcount. To prevent races
>> while unloading the low-level control module, fpga_mgr_get() and part of
>> the fpga_mgr_unregister() methods are protected with a mutex.
>>
>> Other changes: move put_device() from __fpga_mgr_get() to fpga_mgr_get()
>> and of_fpga_mgr_get() to improve code clarity.
>>
>> Fixes: 654ba4cc0f3e ("fpga manager: ensure lifetime with of_fpga_mgr_get")
>> Signed-off-by: Marco Pagani <marpagan@redhat.com>
>> ---
>>  drivers/fpga/fpga-mgr.c       | 56 +++++++++++++++++++++++++----------
>>  include/linux/fpga/fpga-mgr.h |  4 +++
>>  2 files changed, 44 insertions(+), 16 deletions(-)
>>
>> diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
>> index 06651389c592..608605d59860 100644
>> --- a/drivers/fpga/fpga-mgr.c
>> +++ b/drivers/fpga/fpga-mgr.c
>> @@ -21,6 +21,8 @@
>>  static DEFINE_IDA(fpga_mgr_ida);
>>  static const struct class fpga_mgr_class;
>>  
>> +static DEFINE_MUTEX(mgr_lock);
>> +
>>  struct fpga_mgr_devres {
>>  	struct fpga_manager *mgr;
>>  };
>> @@ -667,17 +669,15 @@ ATTRIBUTE_GROUPS(fpga_mgr);
>>  static struct fpga_manager *__fpga_mgr_get(struct device *dev)
>>  {
>>  	struct fpga_manager *mgr;
>> +	struct module *owner;
>>  
>>  	mgr = to_fpga_manager(dev);
>> +	owner = mgr->owner;
>>  
>> -	if (!try_module_get(dev->parent->driver->owner))
>> -		goto err_dev;
>> +	if (owner && !try_module_get(owner))
> 
> No need to test owner == NULL, try_module_get() does this.

You are right. I'll remove it in the next version.

> 
>> +		mgr = ERR_PTR(-ENODEV);
>>  
>>  	return mgr;
>> -
>> -err_dev:
>> -	put_device(dev);
>> -	return ERR_PTR(-ENODEV);
>>  }
>>  
>>  static int fpga_mgr_dev_match(struct device *dev, const void *data)
>> @@ -693,12 +693,22 @@ static int fpga_mgr_dev_match(struct device *dev, const void *data)
>>   */
>>  struct fpga_manager *fpga_mgr_get(struct device *dev)
>>  {
>> -	struct device *mgr_dev = class_find_device(&fpga_mgr_class, NULL, dev,
>> -						   fpga_mgr_dev_match);
>> +	struct fpga_manager *mgr = ERR_PTR(-ENODEV);
>> +	struct device *mgr_dev;
>> +
>> +	mutex_lock(&mgr_lock);
>> +
>> +	mgr_dev = class_find_device(&fpga_mgr_class, NULL, dev, fpga_mgr_dev_match);
>>  	if (!mgr_dev)
>> -		return ERR_PTR(-ENODEV);
>> +		goto out;
>> +
>> +	mgr = __fpga_mgr_get(mgr_dev);
>> +	if (IS_ERR(mgr))
>> +		put_device(mgr_dev);
>>  
>> -	return __fpga_mgr_get(mgr_dev);
>> +out:
>> +	mutex_unlock(&mgr_lock);
>> +	return mgr;
>>  }
>>  EXPORT_SYMBOL_GPL(fpga_mgr_get);
>>  
>> @@ -711,13 +721,22 @@ EXPORT_SYMBOL_GPL(fpga_mgr_get);
>>   */
>>  struct fpga_manager *of_fpga_mgr_get(struct device_node *node)
>>  {
>> -	struct device *dev;
>> +	struct fpga_manager *mgr = ERR_PTR(-ENODEV);
>> +	struct device *mgr_dev;
>> +
>> +	mutex_lock(&mgr_lock);
>> +
>> +	mgr_dev = class_find_device_by_of_node(&fpga_mgr_class, node);
>> +	if (!mgr_dev)
>> +		goto out;
>>  
>> -	dev = class_find_device_by_of_node(&fpga_mgr_class, node);
>> -	if (!dev)
>> -		return ERR_PTR(-ENODEV);
>> +	mgr = __fpga_mgr_get(mgr_dev);
>> +	if (IS_ERR(mgr))
>> +		put_device(mgr_dev);
>>  
>> -	return __fpga_mgr_get(dev);
>> +out:
>> +	mutex_unlock(&mgr_lock);
>> +	return mgr;
>>  }
>>  EXPORT_SYMBOL_GPL(of_fpga_mgr_get);
>>  
>> @@ -727,7 +746,7 @@ EXPORT_SYMBOL_GPL(of_fpga_mgr_get);
>>   */
>>  void fpga_mgr_put(struct fpga_manager *mgr)
>>  {
>> -	module_put(mgr->dev.parent->driver->owner);
>> +	module_put(mgr->owner);
>>  	put_device(&mgr->dev);
>>  }
>>  EXPORT_SYMBOL_GPL(fpga_mgr_put);
>> @@ -806,6 +825,7 @@ fpga_mgr_register_full(struct device *parent, const struct fpga_manager_info *in
>>  
>>  	mgr->name = info->name;
>>  	mgr->mops = info->mops;
>> +	mgr->owner = info->mops->owner;
>>  	mgr->priv = info->priv;
>>  	mgr->compat_id = info->compat_id;
>>  
>> @@ -888,7 +908,11 @@ void fpga_mgr_unregister(struct fpga_manager *mgr)
>>  	 */
>>  	fpga_mgr_fpga_remove(mgr);
>>  
>> +	mutex_lock(&mgr_lock);
>> +
>>  	device_unregister(&mgr->dev);
>> +
>> +	mutex_unlock(&mgr_lock);
> 
> Why this part should be protected rather than the whole
> fpga_mgr_unregister()?
>

Protecting the fpga_remove() op seems unnecessary to me because it
does not affect the manager device's lifetime. Moreover, it may hold
the mutex for a long time since it was intended to interact with the
hardware to put it in a specific state before removing the driver.

> I feel the scope of the protection is unclear to me in this patch. What
> data should be protected from concurrent access by this mutex? From the
> code seems the racing of mgr dev should be protected but apparently it
> doesn't have to.

The mutex is there to ensure the lifetime of the manager device and
its context (struct fpga_manager) if fpga_mgr_get() happens to run
concurrently with the removal of the low-level module.

> 
> And with this mutex, the get/put/unregister() for one mgr should be
> exclusive with another mgr, but that also seems not necessary.
> 

I decided to use a static mutex because I thought putting the mutex
in the manager's context would be unsafe since its life would be tied
to the manager's life. For instance, consider the following sequence:

- A removes the low-level control module, and delete_module progresses
up to the point when it calls the module's exit function, which in turn
calls fpga_mgr_unregister().

- fpga_mgr_unregister() takes the mutex but gets descheduled before
completing the unregistering of the manager device.

- Meanwhile, B wants to get the manager (it is still there) and calls
fpga_mgr_get(), which tries to take the mutex but gets suspended since
it is held by A.

- A resumes and fpga_mgr_unregister() releases the manager device and
its context, including the mutex on which B is suspended.

We could mitigate this specific case using mutex_trylock(). However,
there will still be other problematic cases, like if fpga_mgr_get()
gets suspended right before taking the mutex and then delete_module
proceeds up to when fpga_mgr_unregister() frees the manager device
and its context.

> I think the mgr->owner & mgr->ops should be protected from concurrent
> access of delete_module & fpga_mgr_get/put(), so how about:
> 
> struct fpga_manager_ops {
> 	struct module *owner;
> 	...
> };
> 
> struct fpga_manager {
> 	...
> 	struct mutex mops_lock;
> 	const struct fpga_manager_ops *mops;
> 	...
> };
> 
> 
> static struct fpga_manager *__fpga_mgr_get(struct device *dev)
> {
> 	struct fpga_manager *mgr;
> 
> 	mgr = to_fpga_manager(dev);
> 
> 	mutex_lock(&mgr->mops_lock);
> 
> 	if (!mgr->mops || !try_module_get(mgr->mops->owner))
> 		mgr = ERR_PTR(-ENODEV);
> 
> 	mutex_unlock(&mgr->mops_lock);
> 		
> 	return mgr;
> }
> 
> void fpga_mgr_unregister(struct fpga_manager *mgr)
> {
> 	fpga_mgr_fpga_remove(mgr);	
> 
> 	mutex_lock(&mgr->ops_lock);
> 	mgr->mops = NULL;
> 	mutex_unlock(&mgr->ops_lock);
> 
> 	device_unregister(&mgr->dev);	
> }
> 
> Not actually tested.
> 

I think protecting the only the ops is not enough for the same reasons.
If fpga_mgr_get() gets suspended right after class_find_device(),and
meanwhile the low-level module is removed, it resumes with a reference
to a manager device that no longer exists.

In a certain sense, however, using a mutex seems like a mitigation
that does not solve the problem at its root. I honestly still think
that taking the module's refcount right when registering the manager
is the only way that is both safe and robust against code changes.
However, my proposal was rejected.

So, if you prefer, I can drop the mutex entirely in the next version,
and we leave the responsibility of keeping all kernel pieces to the
user. It will still be an improvement over taking the low-level
module's refcount through the parent device's driver pointer.

Thanks,
Marco


