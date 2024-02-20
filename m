Return-Path: <linux-fpga+bounces-280-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17D4885B8F4
	for <lists+linux-fpga@lfdr.de>; Tue, 20 Feb 2024 11:25:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A1D61C22810
	for <lists+linux-fpga@lfdr.de>; Tue, 20 Feb 2024 10:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 368B2612CD;
	Tue, 20 Feb 2024 10:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T8aXIan1"
X-Original-To: linux-fpga@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81AA7612C4
	for <linux-fpga@vger.kernel.org>; Tue, 20 Feb 2024 10:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708424725; cv=none; b=r6a3/gD2CAyF/VKApgPHePFgtNSsqhAAybUNALg++N0QWlNlX7gFdnIz6FOlZ8GsdObdaF3807GC0OQPlsjoyIEDwXwEG+vQ7A04n8MLEVXXzNcdXec+1VF0HPEfaWo4iMC0uheMKbaWBkQDW/N6AVr8xUjH6ttwve4jInvPktg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708424725; c=relaxed/simple;
	bh=E1tm9W/v3jXRclKbHPuBtzfAnLGGVmHa4BlPy0BxmEc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MBZaEeMxK4gakHHfmW8IzmdInGM0hzhjjrmZ/KCEOqImjQKYnTUUcP+16CDO/iDOk27nsWj+39qtVHEKEQ4Rdcskj60yvW/1k2MnCTtleG25eTzqUYaf9eLWKp6nf9j/SAILHtAlUr6uy4inqIcXAPGlzPHMXMzBUrnlzyCzEqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T8aXIan1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708424721;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vYDQrIFcrmGFEDFd/lQJSQdjifAhTBQLYF8vyTIdB5w=;
	b=T8aXIan1md6zROmthD9dHf/wZuasBQ7Abn+MslOy86tK3Udvr1MQOnJNN/fNSu1CJgx7kk
	UytDlkf9BOcUdEsBOGv7yQzVgc19TVk/kHl2z/sXazA15+B8TygRrsvt2HNJFv40SOqqpG
	8Zodgoeql2BLD6EoFzQD3uCGn3aYkqE=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-17-NZAokajwN-6Kl-tjfzLOkQ-1; Tue, 20 Feb 2024 05:25:19 -0500
X-MC-Unique: NZAokajwN-6Kl-tjfzLOkQ-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-68f3893d688so59280716d6.0
        for <linux-fpga@vger.kernel.org>; Tue, 20 Feb 2024 02:25:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708424719; x=1709029519;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vYDQrIFcrmGFEDFd/lQJSQdjifAhTBQLYF8vyTIdB5w=;
        b=lYpwE0hhUvkL0yrazrvJPzkmRMPIEnHqH+Zun0Uf2PqUea8EhT6rOcVi7v+MpMY4lm
         cJtDRn//NqmrM1uB70e0rcAtVtKg/EteEtV7G2feETICKAPw2hv+37hSp+6hm2RWS+5K
         +yRM+XjOED/v86uYzavmyEU84bxh70bj7hYUbY9MtF6RtrJw2BiI0X33Nu6YegOPuw7A
         hQ0ImkdF8lj8sH52ThbOTVdB2RGGUXbk6lUIZItZ8mVZvHfWhqvXk3DSOyPnxRAKF0Im
         jUvfbtu26YI5XkE8/OMBsQ/A77MQaHWcOfmNRgHXB4ixF3+RIgRM2/+uSdorAMTvQf3Y
         rLzg==
X-Forwarded-Encrypted: i=1; AJvYcCVOJQOFKgAxieikOv+wI80TqF85H1za9ETo9CNf4XIvF92z0OrJSgN2DUcLYt0ZFHRY7DpqLlI8S9vvhgg39h7Q86cL1H7jP4Echw==
X-Gm-Message-State: AOJu0YxYPKlhnhhgjNpEeMUNEnObX71nidWLYc2UmKeEK13YOfMtmgA8
	CGaQEgIwmt1aD3+MRsTI7g4osG/y/NmYuuSVBNLWl/BBj4gBOi8ID6yvIcjg/McqRZdHfydKitm
	nfqXHI80+IGaVPhuO+rYzs5few/Q7pysv9ii2u6sgqVUgm0hmIeM4lhJWDw==
X-Received: by 2002:a05:6214:5d0f:b0:68f:4df8:fef1 with SMTP id me15-20020a0562145d0f00b0068f4df8fef1mr9410793qvb.11.1708424719103;
        Tue, 20 Feb 2024 02:25:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG+3X6kRD0ZBg35AivR50jCJRUjHWkEAJBbACG4V/5NAALyyxhyTn6cv52exRIgQQkHwGN+DQ==
X-Received: by 2002:a05:6214:5d0f:b0:68f:4df8:fef1 with SMTP id me15-20020a0562145d0f00b0068f4df8fef1mr9410777qvb.11.1708424718810;
        Tue, 20 Feb 2024 02:25:18 -0800 (PST)
Received: from [192.168.9.34] (net-2-34-24-75.cust.vodafonedsl.it. [2.34.24.75])
        by smtp.gmail.com with ESMTPSA id u7-20020a05620a022700b007871a4b423fsm3244801qkm.110.2024.02.20.02.25.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Feb 2024 02:25:18 -0800 (PST)
Message-ID: <129e1b9d-ed1c-4dcf-86eb-7fee32bbcd7c@redhat.com>
Date: Tue, 20 Feb 2024 11:25:14 +0100
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] fpga: remove redundant checks for bridge ops
To: Xu Yilun <yilun.xu@linux.intel.com>
Cc: Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
 Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
 linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240201155713.82898-1-marpagan@redhat.com>
 <ZdGByar/ZmzA81cc@yilunxu-OptiPlex-7050>
Content-Language: en-US
From: Marco Pagani <marpagan@redhat.com>
In-Reply-To: <ZdGByar/ZmzA81cc@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024-02-18 05:04, Xu Yilun wrote:
> On Thu, Feb 01, 2024 at 04:57:12PM +0100, Marco Pagani wrote:
>> Commit 0d70af3c2530 ("fpga: bridge: Use standard dev_release for class
>> driver") introduced a check in fpga_bridge_register() that prevents
>> registering a bridge without ops, making checking on every call
>> redundant.
>>
>> v2:
>> - removed ops check also in state_show()
> 
> Don't put the history in changelog. 

You're right, sorry.

> 
> I could fix it.
> Acked-by: Xu Yilun <yilun.xu@intel.com>
> 

Yes, please.

>>
>> Signed-off-by: Marco Pagani <marpagan@redhat.com>
> ---
> v2:
> - XXXX
> 
> This way the history could be discarded when apply.
> 
>> ---
>>  drivers/fpga/fpga-bridge.c | 8 ++++----
>>  1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/fpga/fpga-bridge.c b/drivers/fpga/fpga-bridge.c
>> index a024be2b84e2..79c473b3c7c3 100644
>> --- a/drivers/fpga/fpga-bridge.c
>> +++ b/drivers/fpga/fpga-bridge.c

[...]
Thanks,
Marco


