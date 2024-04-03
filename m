Return-Path: <linux-fpga+bounces-402-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 14143897142
	for <lists+linux-fpga@lfdr.de>; Wed,  3 Apr 2024 15:35:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57756B2A2DA
	for <lists+linux-fpga@lfdr.de>; Wed,  3 Apr 2024 13:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 066C71482F2;
	Wed,  3 Apr 2024 13:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EZrwjHom"
X-Original-To: linux-fpga@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CEDA146D65
	for <linux-fpga@vger.kernel.org>; Wed,  3 Apr 2024 13:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712151269; cv=none; b=FyFlzgm2izX+knMRNjKc5iPm4pW2xR5pmNVsKhQkXG1rLgrYS3XZp202Scd3PCdLMUQDTESVuSR5SCpx0TDRxaxavO2GTkbY++Zkr8sKRrOK7XgVBA6FWhNj6vWPW7AYJBHfiYHw4PEms9DcZZLZsygk+UgbPpSaCY7JODdPsPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712151269; c=relaxed/simple;
	bh=d0DirP2/DcnMHmap5JRHS10akoeyY4HwoPDoR/NLxSo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ki7udm2sR4xoeslAFhKsGeVWFkUcmPmHEZALVXoKsfKTVLFnoRbHUhxZXUKnyhWNdl/lFPFtPwDReFmjZb4/DYlSEElS2fagjdWhuo6ngS+jNU5DKZm+ZRtfMQHWmuaadDjWsxSp2KJAF/TQxNoWrExlJRz/vUqW1RPetGN8UVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EZrwjHom; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712151267;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZF+AJqNgdEEhHyUGebHGFGETeFDomSQcf3CdIhYx3HE=;
	b=EZrwjHomwpWBlET0jhs2ZESpyvDqetDc9rby5ypIrDgFHTur4Yo4g1WZ4FLyP2uX+H9NhI
	sPuATJ2OWy96nMsCVwcuP6MKLUREWE54ureuDWi6+tsFTy1QHUL0a2QgfkTPRloXTS1Yt6
	d6nCqxh+RyW9UzOIjm+QMyG3yxadgr8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-269-5sAxm3D6MHuN6F0yVDxQwg-1; Wed, 03 Apr 2024 09:34:25 -0400
X-MC-Unique: 5sAxm3D6MHuN6F0yVDxQwg-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4147de378b9so26351435e9.3
        for <linux-fpga@vger.kernel.org>; Wed, 03 Apr 2024 06:34:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712151264; x=1712756064;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZF+AJqNgdEEhHyUGebHGFGETeFDomSQcf3CdIhYx3HE=;
        b=NCS9KEeFe4uUiJklSRg3QOpb3PEoSGkX1pEvB82XgWQQlGPR6ekqHECelYKQomd5fL
         WZhf3l1wawvG3pG8cyAWJLUUDbRQZWxlKPo6TveFAJNYl6cfLNItb79aGaGxO3vy2OgO
         KqPiTDz0/bp4gMzi+sHJ5s91LyKx11lJJEl1FHtl2aTM3sAFAf3KEcjcMpXPawA/tvDh
         +YMp90K7k4wtl+uCz8KVa90Rr6ZG0cmtsQYiC9AaqYnle6vouPMO137y5u9bd8Ok4gU9
         CIHOB11VcOBAGJEfpr5avbu7UHAHxBPqA71oravl0qBpsXYjJjm63RPeiXMCpvNTV3EI
         y71w==
X-Forwarded-Encrypted: i=1; AJvYcCVHiFS/B3KkSMOkRZvPqxJbjTQBSNuI9uZVni/h2J0EFDef80GzilaazHlWFW0Dg1iG8t6TJLGR99e5M+ZVP2iAtefniWn7KGSkqA==
X-Gm-Message-State: AOJu0YzTvVC3xnGclaZZNFnv+Xn8k9spCW/Dn8+N9HMwUKn3x1Ga8IV6
	xOau84p65+f50OCKOOICoo3wsEFHdN7eMsfBC318FyuQ7EgjnKqzgnOg+34lyFifbHrCnF8NHNj
	8zy3og9lvdCnkhe1fIpOVhDIfkajXuqyKDfVG4GiA/WNZqthj+RRKnzzjjw==
X-Received: by 2002:a05:600c:35d6:b0:415:46be:6239 with SMTP id r22-20020a05600c35d600b0041546be6239mr10742079wmq.36.1712151264764;
        Wed, 03 Apr 2024 06:34:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IElhlHqGlXgrKBRjpBu+aCPba7HI3pIkryMbfYOmjzU/p76YAySJkx1x/cXO6NJMk8FLvGZ3g==
X-Received: by 2002:a05:600c:35d6:b0:415:46be:6239 with SMTP id r22-20020a05600c35d600b0041546be6239mr10742054wmq.36.1712151264329;
        Wed, 03 Apr 2024 06:34:24 -0700 (PDT)
Received: from [192.168.9.34] (net-2-34-25-239.cust.vodafonedsl.it. [2.34.25.239])
        by smtp.gmail.com with ESMTPSA id n18-20020a05600c4f9200b004148c3685ffsm21867330wmq.3.2024.04.03.06.34.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Apr 2024 06:34:23 -0700 (PDT)
Message-ID: <64c1685a-b544-408e-97e4-8c3cff6aca6c@redhat.com>
Date: Wed, 3 Apr 2024 15:34:22 +0200
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
Content-Language: en-US
From: Marco Pagani <marpagan@redhat.com>
In-Reply-To: <Zgp/jNst2yuXEbpU@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024-04-01 11:34, Xu Yilun wrote:
> On Wed, Mar 27, 2024 at 05:00:20PM +0100, Marco Pagani wrote:
>> The current implementation of the fpga region assumes that the low-level
>> module registers a driver for the parent device and uses its owner pointer
>> to take the module's refcount. This approach is problematic since it can
>> lead to a null pointer dereference while attempting to get the region
>> during programming if the parent device does not have a driver.
>>
>> To address this problem, add a module owner pointer to the fpga_region
>> struct and use it to take the module's refcount. Modify the functions for
>> registering a region to take an additional owner module parameter and
>> rename them to avoid conflicts. Use the old function names for helper
>> macros that automatically set the module that registers the region as the
>> owner. This ensures compatibility with existing low-level control modules
>> and reduces the chances of registering a region without setting the owner.
>>
>> Also, update the documentation to keep it consistent with the new interface
>> for registering an fpga region.
>>
>> Other changes: unlock the mutex before calling put_device() in
>> fpga_region_put() to avoid potential use after release issues.
> 
> Please try not to mix different changes in one patch, especially for
> a "bug fix" as you said.

You are right. I'll split out the change and eventually send it as a
separate patch.

> And I do have concern about the fix, see below.
> 
> [...]
> 
>> @@ -53,7 +53,7 @@ static struct fpga_region *fpga_region_get(struct fpga_region *region)
>>  	}
>>  
>>  	get_device(dev);
>> -	if (!try_module_get(dev->parent->driver->owner)) {
>> +	if (!try_module_get(region->br_owner)) {
>>  		put_device(dev);
>>  		mutex_unlock(&region->mutex);
>>  		return ERR_PTR(-ENODEV);
>> @@ -75,9 +75,9 @@ static void fpga_region_put(struct fpga_region *region)
>>  
>>  	dev_dbg(dev, "put\n");
>>  
>> -	module_put(dev->parent->driver->owner);
>> -	put_device(dev);
>> +	module_put(region->br_owner);
>>  	mutex_unlock(&region->mutex);
> 
> If there is concern the region would be freed after put_device(), then
> why still keep the sequence in fpga_region_get()?

Ouch, sorry, I forgot to make the change also in fpga_region_get().

> And is it possible region is freed before get_device() in
> fpga_region_get()?

If the user follows the usual pattern (i.e., waiting for
fpga_region_program_fpga() to complete before calling
fpga_region_unregister()) there should be no problem. However, I think
releasing the device before unlocking the mutex contained in the context
associated with the device makes the code brittle and more prone to
problems.

> Or we should clearly document how/when to use these functions?
 
I think it is not necessary to change the documentation since the
in-kernel programming API will not be affected by the change.

Thanks,
Marco


