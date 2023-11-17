Return-Path: <linux-fpga+bounces-9-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA9957EFB1F
	for <lists+linux-fpga@lfdr.de>; Fri, 17 Nov 2023 22:59:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD7091C20621
	for <lists+linux-fpga@lfdr.de>; Fri, 17 Nov 2023 21:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE91D43178;
	Fri, 17 Nov 2023 21:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hKOJXh7A"
X-Original-To: linux-fpga@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92F8A120
	for <linux-fpga@vger.kernel.org>; Fri, 17 Nov 2023 13:59:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700258345;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oWQdHec7BormnXBVKJnIj7WafCKTmMPkkY3/JChXWjE=;
	b=hKOJXh7AvVDJBy/7OYKaFlG5yCBz/Ir9pjvfo1ijhpsEdUhvKXP7miSxbKOYvuLisgJunt
	KBfa5NwdukuxZZoFRndMS3LXg9OIJhtN+xyqilvAHcqWt3YiChA6wLDEMD6j7lcPbDaVXM
	PRa+OnVfR/9bIN4umZnqzZWTraBkZ8I=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-V0k1g-u-OcGOBM4BEwmOZA-1; Fri, 17 Nov 2023 16:59:04 -0500
X-MC-Unique: V0k1g-u-OcGOBM4BEwmOZA-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-677f3c0bb78so12263776d6.1
        for <linux-fpga@vger.kernel.org>; Fri, 17 Nov 2023 13:59:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700258343; x=1700863143;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oWQdHec7BormnXBVKJnIj7WafCKTmMPkkY3/JChXWjE=;
        b=c1nhHyxQ4zea+NhhsikhW1XhSkQlUNR0ardSa05oB68johjVuJp/6x6skVBMjWxSkB
         B4vCmaSl0aleAOYCYp9rIJ4dd3jem6uPZQIt1fBxxwWTp99yFjmliJo5HEmI1Atckptv
         CnW5x4nl0Zc0xqWWW0pwvigUZII+1tUlXbpGokLsZGjbOw28G1YHhJksqQF7a49fmLEV
         HKWcHhMUQ3qDvLBw2G6Qx8klwF1N84TWsTJVu/+0OEHO9o0SU+KiTLCuXcfskSW+orDw
         BWRLzgfpVyIn3gIcIYWeLEMdiKeuqck8yy0XJx0psquicAskBNrLUTFfBVn/rwMlT2w8
         MBZA==
X-Gm-Message-State: AOJu0Yzds3uuKJcFtIPO+pVPFKZ+nH6Lu2UFUeWjTXjGi5IpO2LoVtsR
	N7EzZj5hmDx8C9yY/o42F9CsaiojRYJRGMKFL/ZHgufYdw/B1nJvBIYR1jIOwwBLIqZmB0jkUT/
	W/FlUXpCLo8IT5IYBu3iD
X-Received: by 2002:ad4:5bcf:0:b0:672:20c0:ac08 with SMTP id t15-20020ad45bcf000000b0067220c0ac08mr382706qvt.48.1700258343634;
        Fri, 17 Nov 2023 13:59:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG3i/vi2BN8Bs9Flb2+IX7GpzCmet/+Sa5Cf35ReQiHv571j6tdd0vItptAAYPoJcT6mxZEHQ==
X-Received: by 2002:ad4:5bcf:0:b0:672:20c0:ac08 with SMTP id t15-20020ad45bcf000000b0067220c0ac08mr382693qvt.48.1700258343350;
        Fri, 17 Nov 2023 13:59:03 -0800 (PST)
Received: from [192.168.9.34] (net-2-34-24-178.cust.vodafonedsl.it. [2.34.24.178])
        by smtp.gmail.com with ESMTPSA id y18-20020ad45312000000b0065aff6b49afsm926467qvr.110.2023.11.17.13.59.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Nov 2023 13:59:02 -0800 (PST)
Message-ID: <2b26d45d-7577-4824-bad9-d5c85f5a098a@redhat.com>
Date: Fri, 17 Nov 2023 22:58:59 +0100
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Marco Pagani <marpagan@redhat.com>
Subject: Re: [RFC PATCH] fpga: remove module reference counting from core
 components
To: Xu Yilun <yilun.xu@linux.intel.com>
Cc: Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
 Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
 Alan Tull <atull@opensource.altera.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-fpga@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20231027152928.184012-1-marpagan@redhat.com>
 <ZT9qENE9fE3Z0KCW@yilunxu-OptiPlex-7050>
 <ae202b70-b106-4805-9ce0-ffbb2738bb04@redhat.com>
 <ZUuu1CgVd4h3Qqu7@yilunxu-OptiPlex-7050>
 <5c3c3905-67c2-4cc2-8477-c6fc74676fc9@redhat.com>
 <ZVMZZNyLE0+YtKYz@yilunxu-OptiPlex-7050>
Content-Language: en-US
In-Reply-To: <ZVMZZNyLE0+YtKYz@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2023-11-14 07:53, Xu Yilun wrote:
> On Fri, Nov 10, 2023 at 11:58:37PM +0100, Marco Pagani wrote:
>>
>>
>> On 2023-11-08 16:52, Xu Yilun wrote:
>>> On Fri, Nov 03, 2023 at 09:31:02PM +0100, Marco Pagani wrote:
>>>>
>>>>
>>>> On 2023-10-30 09:32, Xu Yilun wrote:
>>>>> On Fri, Oct 27, 2023 at 05:29:27PM +0200, Marco Pagani wrote:
>>>>>> Remove unnecessary module reference counting from the core components
>>>>>> of the subsystem. Low-level driver modules cannot be removed before
>>>>>> core modules since they use their exported symbols.
>>>>>
>>>>> Could you help show the code for this conclusion?
>>>>>
>>>>> This is different from what I remember, a module cannot be removed when
>>>>> its exported symbols are being used by other modules. IOW, the core
>>>>> modules cannot be removed when there exist related low-level driver
>>>>> modules. But the low-level driver modules could be removed freely
>>>>> without other protecting mechanism.
>>>>>
>>>>
>>>> My understanding was that we wanted to remove module reference counting
>>>> from the fpga core and ease it from the responsibility of preventing
>>>> low-level driver modules from being unloaded. 
>>>
>>> FPGA core needs to prevent low-level driver module unloading sometimes,
>>> e.g. when region reprograming is in progress. That's why we get fpga
>>> region driver modules & bridge modules in fpga_region_program_fpga().
>>>
>>> But we try best to get them only necessary. Blindly geting them all the
>>> time results in no way to unload all modules (core & low level modules).
>>>
>>>>
>>>> If we want to keep reference counting in the fpga core, we could add a
>>>> struct module *owner field in the struct fpga_manager_ops (and others
>>>> core *_ops) so that the low-level driver can set it to THIS_MODULE.
>>>> In this way, we can later use it in fpga_mgr_register() to bump up the
>>>
>>> Yes, we should pass the module owner in fpga_mgr_register(), but could
>>> not bump up its refcount at once.
>>>
>>>> refcount of the low-level driver module by calling
>>>> try_module_get(mgr->mops->owner) directly when it registers the manager.
>>>> Finally, fpga_mgr_unregister() would call module_put(mgr->mops->owner)
>>>> to allow unloading the low-level driver module.
>>>
>>> As mentioned above, that makes problem. Most of the low level driver
>>> modules call fpga_mgr_unregister() on module_exit(), but bumping up
>>> their module refcount prevents module_exit() been executed. That came
>>> out to be a dead lock.
>>>
>>
>> Initially, I considered calling try_module_get(mgr->mops->owner)
>> in fpga_mgr_get(). But then, the new kernel-doc description of
>> try_module_get() (1) made me question the safety of that approach.
>> My concern is that the low-level driver could be removed right when
>> someone is calling fpga_mgr_get() and hasn't yet reached
>> try_module_get(mgr->mops->owner). In that case, the struct mops
>> (along with the entire low-level driver module) and the manager dev
>> would "disappear" under the feet of fpga_mgr_get().
> 
> I don't get what's the problem. fpga_mgr_get() would first of all
> look for mgr_dev via class_find_device(), if low-level module is
> unloaded, then you cannot find the mgr_dev and gracefully error out.
> 
> If class_find_device() succeed, mgr_dev got a reference and won't
> disappear. Finally we may still found module removed when
> try_module_get(), but should be another graceful error out.
> 
> Am I missing anything?
> 

My concern is: suppose that you successfully got the mgr dev from
class_find_device(), and now you are in __fpga_mgr_get(), right before
try_module_get(mgr->mops->owner). At that point, you get descheduled,
and while you are not running, someone unloads the low-level driver
module that ends its life by calling fpga_mgr_unregister(). When you
wake up, you find yourself with a reference to a device that does not
exist anymore, trying to get a module that does not exist anymore
through one of its symbols (module *owner in mops).

Greg suggested checking if this can really happen and eventually
protecting fpga_mgr_get() and fpga_mgr_unregister() with a lock for
mops (if I understood correctly). In that case, considering the same
scenario described above:

fpga_mgr_get() gets the mops lock and the mgr dev but is suspended
before calling try_module_get().

Someone unloads the low-level driver, delete_modules progresses
(the module's recount hasn't yet been incremented) but blocks while
calling fpga_mgr_unregister() since fpga_mgr_get() is holding the lock.

fpga_mgr_get() resumes and tries to get the module through one of its
symbols (mgr->mops->owner). The module's memory hasn't yet been freed
(delete_modules is blocked), and the refcount is zero, so
try_module_get() fails safely, and we can put the mgr dev that is
still present since fpga_mgr_unregister() is blocked.

fpga_mgr_unregister() resumes and unregisters the mgr dev.

I'm still thinking about the possible implications. On the one hand,
it looks safe in this case, but on the other hand, it feels brittle.
In my understanding, the root problem is that there will always be a
critical window (when you have taken a reference to the device but
not yet to the low-level driver module) when unloading the module
could be potentially unsafe depending on the current implementation
and the preemption model.

I still feel that it would be simpler and safer if we could bump
up the refcount during fpga_mgr_register() and maybe have a sysfs
attribute to unlock the low-level driver (if no one has taken the
mgr dev refcount). That way, it would be safer by design since the
refcount will be bumped up right during the module load procedure,
and we could guarantee that the lifetime of the mgr device is
entirely contained in the lifetime of the low-level driver module.

>>
>> (1) 557aafac1153 ("kernel/module: add documentation for try_module_get()")
>>  
 
Thanks,
Marco


