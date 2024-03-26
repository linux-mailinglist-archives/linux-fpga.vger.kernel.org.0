Return-Path: <linux-fpga+bounces-355-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B60A88CC8D
	for <lists+linux-fpga@lfdr.de>; Tue, 26 Mar 2024 20:00:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2FAAB2319E
	for <lists+linux-fpga@lfdr.de>; Tue, 26 Mar 2024 18:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29BC214265;
	Tue, 26 Mar 2024 18:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F23C4LX0"
X-Original-To: linux-fpga@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FFCC13C69D
	for <linux-fpga@vger.kernel.org>; Tue, 26 Mar 2024 18:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711479544; cv=none; b=s4RNIkwZyswAjEAuob8/G3poi/QrUdEXaR6d/Pzdn1+C+TtvNGR6tKDoDiRJsgJlRx7N24S48BQIMpQV1SNJl/sHVgB19yRLHhJHxJm/h7Bdli2C8AiTBj3yd91qjZ9MIIMYI716+czb2sFwgZYeNHNhRb6GLik0pwWVnisqPxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711479544; c=relaxed/simple;
	bh=nzlWsc/uDBEtSoEPDmhVs0OiVWzdIGK9LtPb8FUS+30=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EH/JRYsv/HJYNjA4TKY6etdYjsrYo9QZ09QaCMKgltEh90cHMM2G6lUGTQYePNrWl3tjQg+R7Y8JFpGXaDaEfV5gUhukCETQkPgPA5Ztfy9dUI+Jmr0nV0U4TU5oVo4I5p61FHPo6eLAdrFkCb2A6vXrph3MWTJKV6y9bFW+5yM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F23C4LX0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711479541;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uQIrddOl3QUoZaT2l/FFu3ki6nhY9Dj9MjNzIjnSbds=;
	b=F23C4LX0RR5EoC3UwE1OMqfsKja+9vVlE/RH1kE/LEMK52Q4xUCvsv5fmdmudpTeaiUxIX
	4wXmxZnhyI8w8rDEZFyddwsp4pSbM8zfNezP+UaQ7CDb/2jj4s3aB+wZdmA3Yv7KNagfRs
	7TRj2Q5i3Fe6gGg3DXgStwqqA5D4ADQ=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-120-BoebVE5UOle6DCwFbOjr8A-1; Tue, 26 Mar 2024 14:58:59 -0400
X-MC-Unique: BoebVE5UOle6DCwFbOjr8A-1
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-3c3d7bf4e1cso983813b6e.1
        for <linux-fpga@vger.kernel.org>; Tue, 26 Mar 2024 11:58:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711479538; x=1712084338;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uQIrddOl3QUoZaT2l/FFu3ki6nhY9Dj9MjNzIjnSbds=;
        b=aUFfzUKXqzc/fG91uQBRHm2ea692Dy2QGq5NqzWlUXKtH59evemrYV0DzPE5VqOsrQ
         3TCXaXUF82/UuGLmrnUW7S9dBeaREiMTJur6UexUgR021lnZJ5G/U6L9EdoxHUGIYu3q
         whzAoMMZfznZoLUYlMQYZO7iT0GLhKy+O1zqROooJFen6cfTqEtp/BY78Ts7nHb4ncBI
         Q3EmIWwl4myp0ogBjnp+8TUFfSjbAaWCrlcPrXb82gWUnPIhdJ9aTuFDMXr5muAXwaZu
         gZjotVVFPEwggWh4Ffm1wRcWOyiNU2rESTL/CL0ol3OWec7+sB0kXj+ak0FQOAUqWDJF
         rd/A==
X-Forwarded-Encrypted: i=1; AJvYcCXqJFvQeWQwNk0I7ug4pE8rPo1x5H1ogJF475k0qhuSx8CGOv6WvtVmYifX5YXFWHfcFvCsQiwCsaIwkgIGXUohjzVC6qrxypLGoA==
X-Gm-Message-State: AOJu0YzLZQhGpfP1WX8C6Pwbegg/H0/hbK7tSwaUld7aS8oulRtxK9tN
	IDi7dN8V4dPxePfPQO1pNKqPpePxr89SKQtGBk/ScWkrMLOMX8x3hK4vFW8jIq7RcEeQXNMMhon
	Rql3EOPrIszCGe+XWc8DRi9y3LS08FPXMrW2gYgdp5MM83a02nm2ZISSoNWbY2W87Sw==
X-Received: by 2002:a05:6808:201a:b0:3c3:8822:dc36 with SMTP id q26-20020a056808201a00b003c38822dc36mr477648oiw.28.1711479538553;
        Tue, 26 Mar 2024 11:58:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGrik+AkTkIE9LjyOL97tsR5AKnWXtxMce6KS0OU3DQAjEkRYoZ9yMnGkVi5vEp8AiJwCmJyw==
X-Received: by 2002:a05:6808:201a:b0:3c3:8822:dc36 with SMTP id q26-20020a056808201a00b003c38822dc36mr477630oiw.28.1711479538296;
        Tue, 26 Mar 2024 11:58:58 -0700 (PDT)
Received: from [192.168.9.34] (net-2-34-30-89.cust.vodafonedsl.it. [2.34.30.89])
        by smtp.gmail.com with ESMTPSA id eo7-20020a05622a544700b00431532ced95sm2620960qtb.27.2024.03.26.11.58.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Mar 2024 11:58:58 -0700 (PDT)
Message-ID: <befc8ccf-0661-4c6f-b262-3dab3c34e0be@redhat.com>
Date: Tue, 26 Mar 2024 19:58:53 +0100
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fpga: region: add owner module and take its refcount
To: Russ Weight <russ.weight@linux.dev>
Cc: Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
 Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
 Jonathan Corbet <corbet@lwn.net>, Alan Tull <atull@opensource.altera.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-fpga@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240322171931.233925-1-marpagan@redhat.com>
 <20240326172854.h6gww3mqlq63kxbp@4VRSMR2-DT.corp.robot.car>
Content-Language: en-US
From: Marco Pagani <marpagan@redhat.com>
In-Reply-To: <20240326172854.h6gww3mqlq63kxbp@4VRSMR2-DT.corp.robot.car>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024-03-26 18:28, Russ Weight wrote:
> 
> On Fri, Mar 22, 2024 at 06:19:30PM +0100, Marco Pagani wrote:
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
>>
>> Fixes: 0fa20cdfcc1f ("fpga: fpga-region: device tree control for FPGA")
>> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Suggested-by: Xu Yilun <yilun.xu@intel.com>
>> Signed-off-by: Marco Pagani <marpagan@redhat.com>
>> ---
>>  Documentation/driver-api/fpga/fpga-region.rst | 13 ++++++----
>>  drivers/fpga/fpga-region.c                    | 26 +++++++++++--------
>>  include/linux/fpga/fpga-region.h              | 13 +++++++---
>>  3 files changed, 33 insertions(+), 19 deletions(-)
>>
>> diff --git a/Documentation/driver-api/fpga/fpga-region.rst b/Documentation/driver-api/fpga/fpga-region.rst
>> index dc55d60a0b4a..3aff5199b6d8 100644
>> --- a/Documentation/driver-api/fpga/fpga-region.rst
>> +++ b/Documentation/driver-api/fpga/fpga-region.rst
>> @@ -46,13 +46,16 @@ API to add a new FPGA region
>>  ----------------------------
>>  
>>  * struct fpga_region - The FPGA region struct
>> -* struct fpga_region_info - Parameter structure for fpga_region_register_full()
>> -* fpga_region_register_full() -  Create and register an FPGA region using the
>> +* struct fpga_region_info - Parameter structure for __fpga_region_register_full()
>> +* __fpga_region_register_full() -  Create and register an FPGA region using the
>>    fpga_region_info structure to provide the full flexibility of options
>> -* fpga_region_register() -  Create and register an FPGA region using standard
>> +* __fpga_region_register() -  Create and register an FPGA region using standard
>>    arguments
>>  * fpga_region_unregister() -  Unregister an FPGA region
>>  
>> +Helper macros ``fpga_region_register()`` and ``fpga_region_register_full()``
>> +automatically sets the module that registers the FPGA region as the owner.
> 
> s/sets/set/

Nice catch.

> 
>> +
>>  The FPGA region's probe function will need to get a reference to the FPGA
>>  Manager it will be using to do the programming.  This usually would happen
>>  during the region's probe function.
>> @@ -82,10 +85,10 @@ following APIs to handle building or tearing down that list.
>>     :functions: fpga_region_info
>>  
>>  .. kernel-doc:: drivers/fpga/fpga-region.c
>> -   :functions: fpga_region_register_full
>> +   :functions: __fpga_region_register
>>  
>>  .. kernel-doc:: drivers/fpga/fpga-region.c
>> -   :functions: fpga_region_register
>> +   :functions: __fpga_region_register_full
>>  
>>  .. kernel-doc:: drivers/fpga/fpga-region.c
>>     :functions: fpga_region_unregister
>> diff --git a/drivers/fpga/fpga-region.c b/drivers/fpga/fpga-region.c
>> index b364a929425c..f8bbda024d59 100644
>> --- a/drivers/fpga/fpga-region.c
>> +++ b/drivers/fpga/fpga-region.c
>> @@ -53,7 +53,7 @@ static struct fpga_region *fpga_region_get(struct fpga_region *region)
>>  	}
>>  
>>  	get_device(dev);
>> -	if (!try_module_get(dev->parent->driver->owner)) {
>> +	if (!try_module_get(region->get_br_owner)) {
>>  		put_device(dev);
>>  		mutex_unlock(&region->mutex);
>>  		return ERR_PTR(-ENODEV);
>> @@ -75,9 +75,9 @@ static void fpga_region_put(struct fpga_region *region)
>>  
>>  	dev_dbg(dev, "put\n");
>>  
>> -	module_put(dev->parent->driver->owner);
>> -	put_device(dev);
>> +	module_put(region->get_br_owner);
>>  	mutex_unlock(&region->mutex);
>> +	put_device(dev);
>>  }
>>  
>>  /**
>> @@ -181,14 +181,16 @@ static struct attribute *fpga_region_attrs[] = {
>>  ATTRIBUTE_GROUPS(fpga_region);
>>  
>>  /**
>> - * fpga_region_register_full - create and register an FPGA Region device
>> + * __fpga_region_register_full - create and register an FPGA Region device
>>   * @parent: device parent
>>   * @info: parameters for FPGA Region
>> + * @owner: owner module containing the get_bridges function
>>   *
>>   * Return: struct fpga_region or ERR_PTR()
>>   */
>>  struct fpga_region *
>> -fpga_region_register_full(struct device *parent, const struct fpga_region_info *info)
>> +__fpga_region_register_full(struct device *parent, const struct fpga_region_info *info,
>> +			    struct module *owner)
>>  {
>>  	struct fpga_region *region;
>>  	int id, ret = 0;
>> @@ -213,6 +215,7 @@ fpga_region_register_full(struct device *parent, const struct fpga_region_info *
>>  	region->compat_id = info->compat_id;
>>  	region->priv = info->priv;
>>  	region->get_bridges = info->get_bridges;
>> +	region->get_br_owner = owner;
> 
> get_* implies a function. Maybe this would be better called br_owner?

You are right. I will change it to br_owner in v2.

> 
> - Russ
> 

[ ... ]
Thanks,
Marco


