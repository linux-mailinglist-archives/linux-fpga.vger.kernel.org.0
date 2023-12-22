Return-Path: <linux-fpga+bounces-87-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF0BC81CF60
	for <lists+linux-fpga@lfdr.de>; Fri, 22 Dec 2023 21:52:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CFD01F22474
	for <lists+linux-fpga@lfdr.de>; Fri, 22 Dec 2023 20:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BC9420B09;
	Fri, 22 Dec 2023 20:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YSqD0sA5"
X-Original-To: linux-fpga@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 976681EA7E
	for <linux-fpga@vger.kernel.org>; Fri, 22 Dec 2023 20:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703278353;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3K6ZmZ5UWOMHI5EIh+QzCQYfKAchodZvC/bNYkDY5bs=;
	b=YSqD0sA5aqrK2dYenZ1Fb3DKPzKzMIo+uPCNkZHsA8p3nAleYLjVyK0SJ12vDg/+FwCEO/
	10DSeP5613SbqOm//poxVQmFld1DnrCUTmbAZqyK513bfdZbjmCQZUJBsNZFaaJlJbNU7v
	nAvIWqbEtxY5SIX5N5SHHtRxBiauomY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-401-4kuJPxL7P3qFcgErnDiy9A-1; Fri, 22 Dec 2023 15:52:32 -0500
X-MC-Unique: 4kuJPxL7P3qFcgErnDiy9A-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3368abe10c5so1245301f8f.0
        for <linux-fpga@vger.kernel.org>; Fri, 22 Dec 2023 12:52:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703278351; x=1703883151;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3K6ZmZ5UWOMHI5EIh+QzCQYfKAchodZvC/bNYkDY5bs=;
        b=nPLPqPM/CumqXt07ZqrJ7AQdxENTTCfym40g+lo8sNA3vNHXYJ+PtwdL4K6ZCYxbyn
         RIA+bJcJScG2LEjuVniUj5WAFlgXUX+9PVp25yn5O0zKCEvw2s69FWkI+AaqQLvavt+U
         dbbHi8qKJGzhDZkkpbyfr/Ncec5VzP0ex2oDtwV0q33M3y/k7Q1MDuioEapPAl1YuYQ8
         5yZniroIr22Lk2vZeMs/os7BgYRYz+LpnHR8+8X8RbyHrnOIpzidBpJF1z3ZMmPgTF3v
         511RfmM9THlwcXHjiaW1v3UZ6j/cdQvTIiqYxZ3hPsHiNaKYWIopmz373QNZoi0H5Uzh
         JlIA==
X-Gm-Message-State: AOJu0YyoyQ74Jv1lQu/ZRmUCLt0+XswRgQONK86E/pozbcxTSyVlUOzX
	SKikSNhHd4AKBKclNIOJW+4le4gvKwuwog1CkFAuhfq7p/dy48K4zDDjkWgfo3KLzUB7NWmKlFW
	5Ec1pfRPi4rSrn6O374IehywM23gl
X-Received: by 2002:a5d:6703:0:b0:336:7565:3b9e with SMTP id o3-20020a5d6703000000b0033675653b9emr814487wru.86.1703278350962;
        Fri, 22 Dec 2023 12:52:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHBW4PI4jbSdVnVeYC7/67r8Ds8SVKYWPZI9lAvgQds25yty37NAFHBMXQXUgM8+Cm6SrbkEA==
X-Received: by 2002:a5d:6703:0:b0:336:7565:3b9e with SMTP id o3-20020a5d6703000000b0033675653b9emr814484wru.86.1703278350505;
        Fri, 22 Dec 2023 12:52:30 -0800 (PST)
Received: from [192.168.9.34] (net-2-34-31-72.cust.vodafonedsl.it. [2.34.31.72])
        by smtp.gmail.com with ESMTPSA id v18-20020a5d5912000000b003368789f25fsm4540144wrd.17.2023.12.22.12.52.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Dec 2023 12:52:28 -0800 (PST)
Message-ID: <37f7a0dc-6983-437e-a338-65e1abd751c2@redhat.com>
Date: Fri, 22 Dec 2023 21:52:27 +0100
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 2/2] fpga: set owner of fpga_manager_ops for
 existing low-level modules
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
 Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
 linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org
References: <20231218202809.84253-1-marpagan@redhat.com>
 <20231218202809.84253-3-marpagan@redhat.com>
 <2023121829-zealous-prissy-99cc@gregkh>
 <9296941c-a3c8-4d55-9e52-f1277f1c3fc7@redhat.com>
 <2023121924-extent-defender-fb06@gregkh>
 <b2d3d88e-840d-48b1-86d4-0a89d6143683@redhat.com>
 <2023121927-desolate-choice-a2fe@gregkh>
 <a0925c7e-001b-4b8d-9da1-6b271e2f8434@redhat.com>
 <2023122118-captive-suburb-6717@gregkh>
From: Marco Pagani <marpagan@redhat.com>
In-Reply-To: <2023122118-captive-suburb-6717@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2023-12-21 09:22, Greg Kroah-Hartman wrote:
> On Wed, Dec 20, 2023 at 11:24:20PM +0100, Marco Pagani wrote:
>>
>>
>> On 19/12/23 19:11, Greg Kroah-Hartman wrote:
>>> On Tue, Dec 19, 2023 at 06:17:20PM +0100, Marco Pagani wrote:
>>>>
>>>> On 2023-12-19 16:10, Greg Kroah-Hartman wrote:
>>>>> On Tue, Dec 19, 2023 at 03:54:25PM +0100, Marco Pagani wrote:
>>>>>>
>>>>>>
>>>>>> On 2023-12-18 21:33, Greg Kroah-Hartman wrote:
>>>>>>> On Mon, Dec 18, 2023 at 09:28:09PM +0100, Marco Pagani wrote:
>>>>>>>> This patch tentatively set the owner field of fpga_manager_ops to
>>>>>>>> THIS_MODULE for existing fpga manager low-level control modules.
>>>>>>>>
>>>>>>>> Signed-off-by: Marco Pagani <marpagan@redhat.com>
>>>>>>>> ---
>>>>>>>>  drivers/fpga/altera-cvp.c             | 1 +
>>>>>>>>  drivers/fpga/altera-pr-ip-core.c      | 1 +
>>>>>>>>  drivers/fpga/altera-ps-spi.c          | 1 +
>>>>>>>>  drivers/fpga/dfl-fme-mgr.c            | 1 +
>>>>>>>>  drivers/fpga/ice40-spi.c              | 1 +
>>>>>>>>  drivers/fpga/lattice-sysconfig.c      | 1 +
>>>>>>>>  drivers/fpga/machxo2-spi.c            | 1 +
>>>>>>>>  drivers/fpga/microchip-spi.c          | 1 +
>>>>>>>>  drivers/fpga/socfpga-a10.c            | 1 +
>>>>>>>>  drivers/fpga/socfpga.c                | 1 +
>>>>>>>>  drivers/fpga/stratix10-soc.c          | 1 +
>>>>>>>>  drivers/fpga/tests/fpga-mgr-test.c    | 1 +
>>>>>>>>  drivers/fpga/tests/fpga-region-test.c | 1 +
>>>>>>>>  drivers/fpga/ts73xx-fpga.c            | 1 +
>>>>>>>>  drivers/fpga/versal-fpga.c            | 1 +
>>>>>>>>  drivers/fpga/xilinx-spi.c             | 1 +
>>>>>>>>  drivers/fpga/zynq-fpga.c              | 1 +
>>>>>>>>  drivers/fpga/zynqmp-fpga.c            | 1 +
>>>>>>>>  18 files changed, 18 insertions(+)
>>>>>>>>
>>>>>>>> diff --git a/drivers/fpga/altera-cvp.c b/drivers/fpga/altera-cvp.c
>>>>>>>> index 4ffb9da537d8..aeb913547dd8 100644
>>>>>>>> --- a/drivers/fpga/altera-cvp.c
>>>>>>>> +++ b/drivers/fpga/altera-cvp.c
>>>>>>>> @@ -520,6 +520,7 @@ static const struct fpga_manager_ops altera_cvp_ops = {
>>>>>>>>  	.write_init	= altera_cvp_write_init,
>>>>>>>>  	.write		= altera_cvp_write,
>>>>>>>>  	.write_complete	= altera_cvp_write_complete,
>>>>>>>> +	.owner		= THIS_MODULE,
>>>>>>>
>>>>>>> Note, this is not how to do this, force the compiler to set this for you
>>>>>>> automatically, otherwise everyone will always forget to do it.  Look at
>>>>>>> how functions like usb_register_driver() works.
>>>>>>>
>>>>>>> Also, are you _sure_ that you need a module owner in this structure?  I
>>>>>>> still don't know why...
>>>>>>>
>>>>>>
>>>>>> Do you mean moving the module owner field to the manager context and setting
>>>>>> it during registration with a helper macro?
>>>>>
>>>>> I mean set it during registration with a helper macro.
>>>>>
>>>>>> Something like:
>>>>>>
>>>>>> struct fpga_manager {
>>>>>> 	...
>>>>>> 	struct module *owner;
>>>>>> };
>>>>>>
>>>>>> #define fpga_mgr_register(parent, ...) \
>>>>>> 	__fpga_mgr_register(parent,..., THIS_MODULE)
>>>>>>
>>>>>> struct fpga_manager *
>>>>>> __fpga_mgr_register(struct device *parent, ..., struct module *owner)
>>>>>> {
>>>>>> 	...
>>>>>> 	mgr->owner = owner;
>>>>>> }
>>>>>
>>>>> Yes.
>>>>>
>>>>> But again, is a module owner even needed?  I don't think you all have
>>>>> proven that yet...
>>>>
>>>> Programming an FPGA involves a potentially lengthy sequence of interactions
>>>> with the reconfiguration engine. The manager conceptually organizes these
>>>> interactions as a sequence of ops. Low-level modules implement these ops/steps
>>>> for a specific device. If we don't protect the low-level module, someone might
>>>> unload it right when we are in the middle of a low-level op programming the
>>>> FPGA. As far as I know, the kernel would crash in that case.
>>>
>>> The only way an unload of a module can happen is if a user explicitly
>>> asks for it to be unloaded.  So they get what they ask for, right?
>>>
>>
>> Right, the user should get what he asked for, including hanging the
>> hardware. My only concern is that the kernel should not crash.
>>
>>> How do you "know" it is active?  And why doesn't the normal
>>> "driver/device" bindings prevent unloading from being a problem?  When
>>> you unload a module, you stop all ops on the driver, and then unregister
>>> it, which causes any future ones to fail.
>>>
>>> Or am I missing something here?
>>>
>>  
>> I think the problem is that the ops are not directly tied to the driver
>> of the manager's parent device.
> 
> Then that needs to be fixed right there, as that is obviously not using
> the driver model properly.
> 
> Why aren't the "ops" a driver that is bound to this device?  If it is
> the one responsible for controlling it, then it should be a driver and
> as such, the driver model logic will handle things if/when a module is
> unloaded to tear things down better.
> 
>> It is not even required to have a driver
>> to register a manager. The only way to know if the fpga manager is
>> active (i.e., someone is running one op) is by poking manager->state.
> 
> That too seems wrong, why is this?

I don't know. I was not around when the fpga subsystem was laid down.

> 
>> One possibility that comes into my mind, excluding a major reworking,
>> is waiting in fpga_mgr_unregister() until the manager reaches a steady
>> state (no ops are running) before unregistering the device. However, it
>> feels questionable because if one of the ops hangs, the module removal
>> will also hang.
> 
> You never know when a new operand will come in, so there's no way to
> know "all is quiet", sorry.
> 
> Try fixing this properly, buy using the driver model correctly, that
> should help resolve these issues automatically instead of hacked up
> module reference count attempts.
> 
> Remember, this is the whole reason why the driver model was created all
> those 20+ years ago, to move away from these module reference count
> issues, let's not forget history please.
> 

I do not entirely understand this part. The subsystem only provides an
in-kernel API for programming the fpga that in-kernel consumers can use.
The ops that the low-level module implements are used only internally by
the manager in a predefined order.

There is no standard interface for programming the fpga exposed to
userspace using file_operations or attributes exported via sysfs.
The manager only exports read-only attributes for status. On top
of that, there is only the support for device tree overlays.

Would it be correct to assume that the responsibility of keeping
the low-level module in while programming the fpga is on the kernel
component that consumes the subsystem's in-kernel API and (eventually)
exports a programming interface to userspace?

If we consider the case where the programming is done through a
userspace interface exported by the same module that implements the ops,
then we should be good even without taking the low-level module in the
manager.

However, I guess the decision to take the low-level module in the
manager was meant to address the case where the module implementing the
ops and the consumer of the in-kernel API (that may optionally export a
userspace interface for programming) are two separate entities.

Thanks,
Marco


