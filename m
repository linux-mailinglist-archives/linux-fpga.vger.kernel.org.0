Return-Path: <linux-fpga+bounces-429-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 57C6B89EF0D
	for <lists+linux-fpga@lfdr.de>; Wed, 10 Apr 2024 11:42:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3D691F21F33
	for <lists+linux-fpga@lfdr.de>; Wed, 10 Apr 2024 09:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D1CC155722;
	Wed, 10 Apr 2024 09:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="StHDVKfD"
X-Original-To: linux-fpga@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 973831553BF
	for <linux-fpga@vger.kernel.org>; Wed, 10 Apr 2024 09:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712742154; cv=none; b=sq0Qpnzc3ElQ+Q4i2OTCq4ySDWSBl/rVSC0hXzb4ZaElYQ4C8RODr7nuYJr/jBYO3uWp2wtVGPXFIXrv2vh7L/S6LXPsbL/pe7FZUH6og4xIYeqhwoFFrNu2oqGR8LXXGQPlF5ALysL71vJsqOHAEsf+xdLgC5oxifSulLcU9kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712742154; c=relaxed/simple;
	bh=iDurjAgFGrlhlEIPBAKii1dr+5SSgiTReOphZSWtcwE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hh4LqzDQmDoncejkzfnmk1UEM/NsQVxsFCmW6uXeyVGYhh15a5CG2ogmyp0CREPnnK9lIVNwebQcUPVk3qeKdp3fgAg1SKCFI1fIUdZDOwMppV+/qhAx8yNsurE4Qpc1E/TrhWyVyC5f6lmvo4AQe7yQloFnwsp164Ejhf9W/zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=StHDVKfD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712742151;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3bgi29jmYNkPTs9PQtxTcWx3C/WwQCp+NvBv8CYqpsw=;
	b=StHDVKfDSL51yLckbf/ZJ3GZ2RPLU++9Uh6wTtYiYd3wDmcfiWGO1++T/MmAMVPknj0pMJ
	DK2JiInHh1kTs18yGhQiywPLymyaL/aTzl4jSibhHDrLGMuDiZEl5TgR2asquS+RYN1e7X
	KJKMmtBGqXbt+zQ8FT6sFudTWsgHYRU=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-55--QTNEubcM86A2o8WHFWlkQ-1; Wed, 10 Apr 2024 05:42:30 -0400
X-MC-Unique: -QTNEubcM86A2o8WHFWlkQ-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-78d475004b6so784864585a.0
        for <linux-fpga@vger.kernel.org>; Wed, 10 Apr 2024 02:42:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712742149; x=1713346949;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3bgi29jmYNkPTs9PQtxTcWx3C/WwQCp+NvBv8CYqpsw=;
        b=VYGT97iEbEN8uaQvNFjMYh0y+kof1pJ+D7/D7ceoLt9Ps6OhYxcy0J5zMg24e1dClh
         Yz2U/dEa2elmcn17D+TYLVuFWVQ8QjB3Ba5om7EsTzYyx8nMYueGBgX6dCIlFlCXJG6K
         8bIKZw3g/iuwqMiLBCx0g3qvMGpCBVAwUPtgJBrt16iDwTlD/ZEi8yJ/MTsKTaQYVTxX
         QDvutiXIsZyE8ejzzOvSHi1gFgP5ZTdl7Uy2UwQKgaBVGmRscPXL8IiCE4LoJldkz92K
         c1/MDCbOvrK+UqAvYgDH5YsQ5v1Y4PzVrn1/gH2nrQI10Cw8hEsrIlUVLnfJbuxckXYK
         OrbQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+M2aKMWjwi1gMW7bREEY0Rk39WEiKBOcw5k5psHfSYh7pc8EPsyPqUwHX8KZYVU84OakalCWfMfL10AwC/KVV/a3hu3PW1WYV6w==
X-Gm-Message-State: AOJu0YzCh9yIytxuewaX8dbmBgtNPcK4CHwuqWp73hjRkPdHkPzVZqmQ
	41LTOq+c3iwPYPn+UwLOtfUHsLuq7hU5Jd5+KEBq7JyEKViz+N1iaV9qc251F8WB7Mqq6mhIRut
	h4PuEu7r9Nv5HDG5Kere/7/hwAFJBYSqiWlcPdWRxMXp2HmAOrxKPUZ1ndA==
X-Received: by 2002:a05:620a:f97:b0:78d:607e:2194 with SMTP id b23-20020a05620a0f9700b0078d607e2194mr1911324qkn.3.1712742149543;
        Wed, 10 Apr 2024 02:42:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG5BDTvXis2tHGPFgQN21Tpeh6ejkg3dj6ba9+xOWtzffuVwnJkjsQ+WKOsJO2bxNjBBYZk+A==
X-Received: by 2002:a05:620a:f97:b0:78d:607e:2194 with SMTP id b23-20020a05620a0f9700b0078d607e2194mr1911283qkn.3.1712742147977;
        Wed, 10 Apr 2024 02:42:27 -0700 (PDT)
Received: from [192.168.9.29] (net-2-34-25-239.cust.vodafonedsl.it. [2.34.25.239])
        by smtp.gmail.com with ESMTPSA id de14-20020a05620a370e00b0078d73533196sm1269317qkb.76.2024.04.10.02.42.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Apr 2024 02:42:27 -0700 (PDT)
Message-ID: <9d016f83-8e7f-4bdf-8610-e3d0b49f7097@redhat.com>
Date: Wed, 10 Apr 2024 11:42:23 +0200
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] fpga: region: add owner module and take its refcount
To: Xu Yilun <yilun.xu@linux.intel.com>
Cc: Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
 Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
 Jonathan Corbet <corbet@lwn.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Alan Tull <atull@opensource.altera.com>, linux-fpga@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240327160022.202934-1-marpagan@redhat.com>
 <Zgp/jNst2yuXEbpU@yilunxu-OptiPlex-7050>
 <64c1685a-b544-408e-97e4-8c3cff6aca6c@redhat.com>
 <ZhS/M6pa9AHyvb0y@yilunxu-OptiPlex-7050>
Content-Language: en-US
From: Marco Pagani <marpagan@redhat.com>
In-Reply-To: <ZhS/M6pa9AHyvb0y@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024-04-09 06:08, Xu Yilun wrote:
> On Wed, Apr 03, 2024 at 03:34:22PM +0200, Marco Pagani wrote:
>>
>>
>> On 2024-04-01 11:34, Xu Yilun wrote:
>>> On Wed, Mar 27, 2024 at 05:00:20PM +0100, Marco Pagani wrote:
>>>> The current implementation of the fpga region assumes that the low-level
>>>> module registers a driver for the parent device and uses its owner pointer
>>>> to take the module's refcount. This approach is problematic since it can
>>>> lead to a null pointer dereference while attempting to get the region
>>>> during programming if the parent device does not have a driver.
>>>>
>>>> To address this problem, add a module owner pointer to the fpga_region
>>>> struct and use it to take the module's refcount. Modify the functions for
>>>> registering a region to take an additional owner module parameter and
>>>> rename them to avoid conflicts. Use the old function names for helper
>>>> macros that automatically set the module that registers the region as the
>>>> owner. This ensures compatibility with existing low-level control modules
>>>> and reduces the chances of registering a region without setting the owner.
>>>>
>>>> Also, update the documentation to keep it consistent with the new interface
>>>> for registering an fpga region.
>>>>
>>>> Other changes: unlock the mutex before calling put_device() in
>>>> fpga_region_put() to avoid potential use after release issues.
>>>
>>> Please try not to mix different changes in one patch, especially for
>>> a "bug fix" as you said.
>>
>> You are right. I'll split out the change and eventually send it as a
>> separate patch.
>>
>>> And I do have concern about the fix, see below.
>>>
>>> [...]
>>>
>>>> @@ -53,7 +53,7 @@ static struct fpga_region *fpga_region_get(struct fpga_region *region)
>>>>  	}
>>>>  
>>>>  	get_device(dev);
>>>> -	if (!try_module_get(dev->parent->driver->owner)) {
>>>> +	if (!try_module_get(region->br_owner)) {
>>>>  		put_device(dev);
>>>>  		mutex_unlock(&region->mutex);
>>>>  		return ERR_PTR(-ENODEV);
>>>> @@ -75,9 +75,9 @@ static void fpga_region_put(struct fpga_region *region)
>>>>  
>>>>  	dev_dbg(dev, "put\n");
>>>>  
>>>> -	module_put(dev->parent->driver->owner);
>>>> -	put_device(dev);
>>>> +	module_put(region->br_owner);
>>>>  	mutex_unlock(&region->mutex);
>>>
>>> If there is concern the region would be freed after put_device(), then
>>> why still keep the sequence in fpga_region_get()?
>>
>> Ouch, sorry, I forgot to make the change also in fpga_region_get().
>>
>>> And is it possible region is freed before get_device() in
>>> fpga_region_get()?
>>
>> If the user follows the usual pattern (i.e., waiting for
> 
> I can see the only safe way is fpga_region_program_fpga() or fpga_region_get()
> should be included in:
> 
>   region = fpga_region_class_find();
>   ...
>   put_device(&region->dev);
> 
> That is to say, fpga_region_get() should not be called when there is no
> region dev reference hold beforehand. In this case, no use after release
> risk. That's why I was thinking about some documentation.
> 
> Another concern is we'd better keep the get/put operations symmetrical
> for easy maintaining, as long as it doesn't cause problem.

Now I see your point. So, you suggest changing only the docs to clarify
that the region must be taken with fpga_region_class_find() before
programming it with fpga_region_program_fpga()?

That's fine by me. However, this made me wonder why we need to take the
region dev with get_device() in fpga_region_program_fpga()->fpga_region_get().
If we assume that the user must always call fpga_region_class_find()
before programming with fpga_region_program_fpga(), why do we need the
double get?

Thanks,
Marco
 
>> fpga_region_program_fpga() to complete before calling
>> fpga_region_unregister()) there should be no problem. However, I think
>> releasing the device before unlocking the mutex contained in the context
>> associated with the device makes the code brittle and more prone to
>> problems.
>>
>>> Or we should clearly document how/when to use these functions?
>>  
>> I think it is not necessary to change the documentation since the
>> in-kernel programming API will not be affected by the change.
>>
[...]


