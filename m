Return-Path: <linux-fpga+bounces-3-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92BD27E85EA
	for <lists+linux-fpga@lfdr.de>; Fri, 10 Nov 2023 23:58:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4A581C208A3
	for <lists+linux-fpga@lfdr.de>; Fri, 10 Nov 2023 22:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A5B33B79E;
	Fri, 10 Nov 2023 22:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XUbU+eCz"
X-Original-To: linux-fpga@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D3AED3
	for <linux-fpga@vger.kernel.org>; Fri, 10 Nov 2023 22:58:47 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDF8DA9
	for <linux-fpga@vger.kernel.org>; Fri, 10 Nov 2023 14:58:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699657125;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9j28lXvsEf9BPZXTXKi6AXZ8wcoBFGBKcddSWxqVXIY=;
	b=XUbU+eCziZ16sxtdIUkzRDsphtqplkuZYlJpyynsfyo7O/aTBZckkZGmdDUce3ykaQMndJ
	wjdYORkPrnQBUZue3npvbypQvhswehDYATbOsbCdaLtdC/Tdtqe/8A7JeKPql+9bFPRX9A
	vnGcd6oHSv2p4eZrjxpCrKCZKhSwcbw=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-5-EVenmXqdPK68SDpRuZ-YZQ-1; Fri, 10 Nov 2023 17:58:42 -0500
X-MC-Unique: EVenmXqdPK68SDpRuZ-YZQ-1
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-41cd433742dso29290361cf.2
        for <linux-fpga@vger.kernel.org>; Fri, 10 Nov 2023 14:58:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699657122; x=1700261922;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9j28lXvsEf9BPZXTXKi6AXZ8wcoBFGBKcddSWxqVXIY=;
        b=D1FTlE/WfMbl9pAp2VrmMP8L3p8sqg4JU2pcYrVvmFUIAKBhZkVSNIr5ylumU/b1D2
         udD+vjJQgaJ6rGW0VjfNE56t+pe4/VwqhIX7c9O9kr/BwLLnorqZP0uVJLgV+LPY58ig
         /Y85S4NKiLdcWqyE/YHfAGfvqNTit0YfcEUFWmedB/SWL2+0pD6eHwX+rg7++qECr+s4
         NvFWTYom3ht+7D3jBwdN5RZsenBy4xJTuYpTGl+DCsI0gJ1Fr59I2ctlrAe63eZ/LJz2
         CJRJbtO4GH3LkI/+/J0HioL/gO7JsxwwIZE0kBPnKdjjoFoY0QdRRYJ4+otu3kXP1ztZ
         AC3g==
X-Gm-Message-State: AOJu0YwD7P/F6y6q9HrPFYK79yko7uTap+0FxlZq5BwJg77cFvdexGKd
	mHKUJeeXGOBUYKrnsQ/AohZWazNPHoDDno5B6I9J1T40qOIsHCDXkF0iiBSnYPKVOuY6f+uIArm
	k5RhoM+xE2gayhrWA6iUp
X-Received: by 2002:a05:622a:1113:b0:417:9c63:391c with SMTP id e19-20020a05622a111300b004179c63391cmr486228qty.52.1699657122316;
        Fri, 10 Nov 2023 14:58:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGqNcVi5ZpAoz5E4DZnIcE33eRoScJUzOJxPAsBq0IMcrHzgjOg6abO3/Fb1UdR07aav7i0ew==
X-Received: by 2002:a05:622a:1113:b0:417:9c63:391c with SMTP id e19-20020a05622a111300b004179c63391cmr486214qty.52.1699657122006;
        Fri, 10 Nov 2023 14:58:42 -0800 (PST)
Received: from [192.168.9.16] (net-2-34-31-107.cust.vodafonedsl.it. [2.34.31.107])
        by smtp.gmail.com with ESMTPSA id o2-20020ac841c2000000b0041803dfb240sm154082qtm.45.2023.11.10.14.58.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Nov 2023 14:58:41 -0800 (PST)
Message-ID: <5c3c3905-67c2-4cc2-8477-c6fc74676fc9@redhat.com>
Date: Fri, 10 Nov 2023 23:58:37 +0100
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
Content-Language: en-US
In-Reply-To: <ZUuu1CgVd4h3Qqu7@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2023-11-08 16:52, Xu Yilun wrote:
> On Fri, Nov 03, 2023 at 09:31:02PM +0100, Marco Pagani wrote:
>>
>>
>> On 2023-10-30 09:32, Xu Yilun wrote:
>>> On Fri, Oct 27, 2023 at 05:29:27PM +0200, Marco Pagani wrote:
>>>> Remove unnecessary module reference counting from the core components
>>>> of the subsystem. Low-level driver modules cannot be removed before
>>>> core modules since they use their exported symbols.
>>>
>>> Could you help show the code for this conclusion?
>>>
>>> This is different from what I remember, a module cannot be removed when
>>> its exported symbols are being used by other modules. IOW, the core
>>> modules cannot be removed when there exist related low-level driver
>>> modules. But the low-level driver modules could be removed freely
>>> without other protecting mechanism.
>>>
>>
>> My understanding was that we wanted to remove module reference counting
>> from the fpga core and ease it from the responsibility of preventing
>> low-level driver modules from being unloaded. 
> 
> FPGA core needs to prevent low-level driver module unloading sometimes,
> e.g. when region reprograming is in progress. That's why we get fpga
> region driver modules & bridge modules in fpga_region_program_fpga().
> 
> But we try best to get them only necessary. Blindly geting them all the
> time results in no way to unload all modules (core & low level modules).
> 
>>
>> If we want to keep reference counting in the fpga core, we could add a
>> struct module *owner field in the struct fpga_manager_ops (and others
>> core *_ops) so that the low-level driver can set it to THIS_MODULE.
>> In this way, we can later use it in fpga_mgr_register() to bump up the
> 
> Yes, we should pass the module owner in fpga_mgr_register(), but could
> not bump up its refcount at once.
> 
>> refcount of the low-level driver module by calling
>> try_module_get(mgr->mops->owner) directly when it registers the manager.
>> Finally, fpga_mgr_unregister() would call module_put(mgr->mops->owner)
>> to allow unloading the low-level driver module.
> 
> As mentioned above, that makes problem. Most of the low level driver
> modules call fpga_mgr_unregister() on module_exit(), but bumping up
> their module refcount prevents module_exit() been executed. That came
> out to be a dead lock.
>

Initially, I considered calling try_module_get(mgr->mops->owner)
in fpga_mgr_get(). But then, the new kernel-doc description of
try_module_get() (1) made me question the safety of that approach.
My concern is that the low-level driver could be removed right when
someone is calling fpga_mgr_get() and hasn't yet reached
try_module_get(mgr->mops->owner). In that case, the struct mops
(along with the entire low-level driver module) and the manager dev
would "disappear" under the feet of fpga_mgr_get().

(1) 557aafac1153 ("kernel/module: add documentation for try_module_get()")
 
>>
>> In this way, it would no longer be necessary to call try_module_get()
>> in fpga_mrg_get() since we could use a kref (included in the struct
>> fpga_manager) to do refcounting for the in-kernel API users. Only when
>> the kref reaches zero fpga_mgr_unregister() would succeed and put the
>> low-level driver module.
>>
>> I think this approach would be safer since it would avoid the crash
>> that can currently happen if the low-level driver module is removed
>> right when executing try_module_get() in fpga_mrg_get(). The possible
>> caveat is that it would be required to call fpga_mgr_unregister()
>> before being able to remove the low-level driver module.
>>


[...]

Thanks,
Marco


