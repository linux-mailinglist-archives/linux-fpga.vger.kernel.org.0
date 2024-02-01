Return-Path: <linux-fpga+bounces-208-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A29B3845B09
	for <lists+linux-fpga@lfdr.de>; Thu,  1 Feb 2024 16:14:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CA101C285D0
	for <lists+linux-fpga@lfdr.de>; Thu,  1 Feb 2024 15:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 184DD6215B;
	Thu,  1 Feb 2024 15:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iPrx+wne"
X-Original-To: linux-fpga@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4205A62151
	for <linux-fpga@vger.kernel.org>; Thu,  1 Feb 2024 15:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706800463; cv=none; b=qieBLQbN1cOQ5isK1CYjUUqVPOZ4nco+H/H34jANbHaC8wQ2qtYEABmQKgBgUAP2E51bc9vwUIWaS8zlZMYZX1p/sxMM3rIZeQF+C2u7rP6Iu8NA2ga63po3uVmVC8SpJ25C4idrMZP9dl7/koX+bKvgnYXlzO3VRwAPsZTNShE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706800463; c=relaxed/simple;
	bh=2c2O8Cc9VKYP/y1ar4r+bdMh2y3qB+F8BIbxfjXxo4I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ohXLFG4W7mZgui+ZLmm7fRD4wmna0R+mExcsRgaexWsXiUyMmaqAb+S0QFIuuaXJwwnmK50y7Z4BoOQpboX4B9zFGuCHALqGASgrWtGaTFtHIyT7XwBOa8m/PqPhwkRHKHX96JmTEAVTBpPyT6dhLC+5a3fhtnqtgqVrMUoOqzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iPrx+wne; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706800460;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H+qWz/DQvoXRtLaiUs+ygF3UhqzsPEEWrkmZUq5EmAU=;
	b=iPrx+wneuis0mfXuCEShXC/zUhkhRDY7CeixD35Xi+O/FPSknOI6p5dyuRjLpRbKG2Ze66
	euJVZsGZRqWt623A55P0xQfie649aWs2Nv7x9bIbqq1c9e3l5gUsKPtdXjHJf6NCT0uzly
	N9/etDRecmIOxFhquu1ZmddLiQMzxMs=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-398-k5kqycyQMb-aoi4zb9bbOA-1; Thu, 01 Feb 2024 10:14:18 -0500
X-MC-Unique: k5kqycyQMb-aoi4zb9bbOA-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-33af11b30fbso439700f8f.3
        for <linux-fpga@vger.kernel.org>; Thu, 01 Feb 2024 07:14:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706800458; x=1707405258;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H+qWz/DQvoXRtLaiUs+ygF3UhqzsPEEWrkmZUq5EmAU=;
        b=NpXn+YW1lAMRp8XXZ0IDTNHrgLWXHLIhTykcYvRdUIoe2gDfK/Lz7QGjT+2Z5Faixd
         HcVaKR3Y3/sCD7FnbQXzhXNzrjhwo2U19UQtS4oJQiTlliq3NYgUrq4Mu9lRrkfuQUsg
         G35JMr2LeGh8HEWkTVPnV9XhjXeTyVClHo/UuVtYvE+o6ghl2QkyX8s3a1yy3Fx4GJf5
         E3rfasOYzcMktGfZD9b7V/f4PBUIS5wUTjn4hNbaKndU3ABCsyuoWJ9YBIwqCXZ+iFkp
         lFh5QrOqeO6GbAa59IDwIcMpUaTB7nQ5rEdVi24u5fq9COxynKETSukaSHONEwEwuS8t
         oc6Q==
X-Gm-Message-State: AOJu0Yz4t9jRIgwRHw9uV9mmrbRBVz9RMl4M1QXHEvncLKxguTXLqChw
	QQuMbl6vjAMLejET9Zck4Khfx3cRsftWGlCxklkSFRPrVyp//DwvMC6VC0+ePQICWPYlntsi2aa
	9KuGn+pfvWBPwNxTYOjJkSHgDKOWSXDXqcBxdAeWe6jgbyz1bXtYzZf8H9A==
X-Received: by 2002:adf:fec3:0:b0:33b:1ae4:10be with SMTP id q3-20020adffec3000000b0033b1ae410bemr656917wrs.46.1706800457805;
        Thu, 01 Feb 2024 07:14:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEQ1LSSiNVgFItzWKTj0LfVmS5upYQ2eKQBxvYDmMDMD7a3/zefheP6gAwFbMonNNjA8rzILA==
X-Received: by 2002:adf:fec3:0:b0:33b:1ae4:10be with SMTP id q3-20020adffec3000000b0033b1ae410bemr656907wrs.46.1706800457493;
        Thu, 01 Feb 2024 07:14:17 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXaEwqOkI/VK9eNkoA4uPPbdatQOwtq1EPu0xJA7z2SWYUIWqy+ov7zZDoNulKSTiXoUR02WK++vXcyW3dU0M6SaRBhGyrdona8fTbFXXg6h/5CDcoicVaNzGGOT3Dq+E7irt+xb03koPH/lr13Dv/mESKncyMmLbTR7lbsWUeailm79/RQZ1JJhhfsEzgbmw2fW6uaGkrMX5wjRHu5T9Q=
Received: from [192.168.9.34] (net-2-34-24-75.cust.vodafonedsl.it. [2.34.24.75])
        by smtp.gmail.com with ESMTPSA id t8-20020adfe108000000b0033921c383b2sm16400154wrz.67.2024.02.01.07.14.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Feb 2024 07:14:17 -0800 (PST)
Message-ID: <985729eb-08c5-4c0d-9172-1642a45caffd@redhat.com>
Date: Thu, 1 Feb 2024 16:14:15 +0100
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fpga: remove redundant checks for bridge ops
Content-Language: en-US
To: Xu Yilun <yilun.xu@linux.intel.com>
Cc: Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
 Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
 linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240124152408.88068-1-marpagan@redhat.com>
 <Zbi+yJC7KNvl9med@yilunxu-OptiPlex-7050>
From: Marco Pagani <marpagan@redhat.com>
In-Reply-To: <Zbi+yJC7KNvl9med@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024-01-30 10:18, Xu Yilun wrote:
> On Wed, Jan 24, 2024 at 04:24:07PM +0100, Marco Pagani wrote:
>> Commit 0d70af3c2530 ("fpga: bridge: Use standard dev_release for class
>> driver") introduced a check in fpga_bridge_register() that prevents
>> registering a bridge without ops, making checking on every call
>> redundant.
>>
>> Signed-off-by: Marco Pagani <marpagan@redhat.com>
>> ---
>>  drivers/fpga/fpga-bridge.c | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/fpga/fpga-bridge.c b/drivers/fpga/fpga-bridge.c
>> index a024be2b84e2..e0a5ef318f5e 100644
>> --- a/drivers/fpga/fpga-bridge.c
>> +++ b/drivers/fpga/fpga-bridge.c
>> @@ -30,7 +30,7 @@ int fpga_bridge_enable(struct fpga_bridge *bridge)
>>  {
>>  	dev_dbg(&bridge->dev, "enable\n");
>>  
>> -	if (bridge->br_ops && bridge->br_ops->enable_set)
>> +	if (bridge->br_ops->enable_set)
>>  		return bridge->br_ops->enable_set(bridge, 1);
>>  
>>  	return 0;
>> @@ -48,7 +48,7 @@ int fpga_bridge_disable(struct fpga_bridge *bridge)
>>  {
>>  	dev_dbg(&bridge->dev, "disable\n");
>>  
>> -	if (bridge->br_ops && bridge->br_ops->enable_set)
>> +	if (bridge->br_ops->enable_set)
>>  		return bridge->br_ops->enable_set(bridge, 0);
>>  
>>  	return 0;
>> @@ -401,7 +401,7 @@ void fpga_bridge_unregister(struct fpga_bridge *bridge)
>>  	 * If the low level driver provides a method for putting bridge into
>>  	 * a desired state upon unregister, do it.
>>  	 */
>> -	if (bridge->br_ops && bridge->br_ops->fpga_bridge_remove)
>> +	if (bridge->br_ops->fpga_bridge_remove)
>>  		bridge->br_ops->fpga_bridge_remove(bridge);
> 
> Also for state_show()?

Right, I missed that one. I'll remove it in v2

Thanks,
Marco

 


