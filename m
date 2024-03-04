Return-Path: <linux-fpga+bounces-317-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 94A9487100A
	for <lists+linux-fpga@lfdr.de>; Mon,  4 Mar 2024 23:27:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A2E1281063
	for <lists+linux-fpga@lfdr.de>; Mon,  4 Mar 2024 22:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 165D678B47;
	Mon,  4 Mar 2024 22:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WIbPNTOX"
X-Original-To: linux-fpga@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66EA37A70D
	for <linux-fpga@vger.kernel.org>; Mon,  4 Mar 2024 22:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709591230; cv=none; b=XADcDQielev+r4QyDV4Ost6BjDnVgyKO3xlPM/uXKcFWQpzHUb4B3QLZAckK/kfiVrhc6KB42twIs+icoRVeINWOutfkQcijytdVyQ+qUlkzHczvtu7haa34PBXK5yQFXSUBzSHadEG7EX4NqFzgKWPDLjp1q4p5Iv+FmQRWc9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709591230; c=relaxed/simple;
	bh=1atHwK3n0oMhpG7HrhejVE4lgE2utbLsrDZmOQLvDGQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XHXudZzc6QYZdvSPVqjWkaqR/mNT5P7Ip5WMQphQVRbo3jPCnqYHsKj3lTSHlD5OwHAKIGreTr8iuPKmOaq0U4sd452kD0ZgPtDrGGgwb62zVrS28eInLcTmN1jgA8GD9zTgqadaCrheUbniEyOGR+VIWA+7mqIy65M2P89zTM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WIbPNTOX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709591227;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0I9Tu/Eo7kHXmD42e5VjWB2DaTI5c0rTAvGhSO84y0I=;
	b=WIbPNTOXomaMfty5oq4OJKqebqfbbtFNBT85tRFUvDaRGwor7SoHeYNMRUIgdntdfHyMZV
	W0NXkwdaphM25XPWwu2hkK64rYoiRzysXMsSgmNKE9+PplBxxYHzTSYazHZoD00AadsAI4
	ohwslKLyROB8wubLc3QcDpBYG45ujZU=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-92-eAAzSMvxP5GBTwfb8hKJhA-1; Mon, 04 Mar 2024 17:27:05 -0500
X-MC-Unique: eAAzSMvxP5GBTwfb8hKJhA-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6904160e997so43002356d6.2
        for <linux-fpga@vger.kernel.org>; Mon, 04 Mar 2024 14:27:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709591224; x=1710196024;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0I9Tu/Eo7kHXmD42e5VjWB2DaTI5c0rTAvGhSO84y0I=;
        b=vX3lJ0sSraErHXUD/e4cDOClgqtXkaCGqaNnTZNp+qCSTtQixaUOsyGubyRmVWbimo
         EqVBPU396kzS2QIvDhg7BusLQ5erXL8azzmupqSbsNIp+WyLonBGwlMDWEv6uuk+byP2
         I+1mujvApq1I78pOI1rXQgvENXJi4fhhS5vJtZlMdtFurvH5yrpYuDwjmnWZNQiJbIiG
         utEJJV56I8zlHlwxnh6eZaf2tec7sNMKrb+yTCQk7M9c9eCxAFI2zy98tgkXrBfQio/p
         6cy6SM95KVDJfxz+QOwvV+qF3GK793ph8w3KB2GQkAa+XEyDoHKOS7yg5vhUlVwAw3Pl
         0EAQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZCEtEl1OlPIavJCxeNhf7hGfMPma+qSyp6wcoY0dXsnQpNF789qH+zPfqY73Zmiz6VySMVQ8RRhKCaQZEV0bm+O7rxqAlCj8iEQ==
X-Gm-Message-State: AOJu0YzuH4XdHxwgLmG5Lf9StKLjx+VVwfy+lNE/syIVwOIokbSM/s0t
	X0WEOwQbQ4Fct6WUsPm/tZaYjht0zTXQSmnGW/v+oQ+YWiBfGvENcM1GpE7HxOnRsQGPtASrExm
	Bwv4T+NA5GHI14rD5iaAw3ka8XRDy0CvEZ2h5VXhX7isKZEIeJNFPlRMPtg==
X-Received: by 2002:a05:6214:2d14:b0:68f:e92a:6c2 with SMTP id mz20-20020a0562142d1400b0068fe92a06c2mr212586qvb.31.1709591224608;
        Mon, 04 Mar 2024 14:27:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEzLXcaGyAxnW4JJ7iJmtLjFnsvfT/z6F3AeNSlZin/oBAZwg0/RmYDpbOW0lqD2knN+mdzEA==
X-Received: by 2002:a05:6214:2d14:b0:68f:e92a:6c2 with SMTP id mz20-20020a0562142d1400b0068fe92a06c2mr212577qvb.31.1709591224336;
        Mon, 04 Mar 2024 14:27:04 -0800 (PST)
Received: from [192.168.9.34] (net-2-34-28-168.cust.vodafonedsl.it. [2.34.28.168])
        by smtp.gmail.com with ESMTPSA id pf10-20020a056214498a00b0068f914ac80bsm5596173qvb.50.2024.03.04.14.27.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Mar 2024 14:27:04 -0800 (PST)
Message-ID: <e4c54951-0e7d-4307-9266-2d6b984c967a@redhat.com>
Date: Mon, 4 Mar 2024 23:26:58 +0100
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
References: <Zbh7iO9wlm9ekzB7@yilunxu-OptiPlex-7050>
 <0720eb91-72f9-4781-8558-8a1b0a3691c2@redhat.com>
 <Zb8dd9af0Ru/fzGi@yilunxu-OptiPlex-7050>
 <4aaa131a-4b64-4b86-9548-68aef63c87b3@redhat.com>
 <ZdHWaeU+/On6LmHX@yilunxu-OptiPlex-7050>
 <9a9d4018-fd65-49be-9e0a-1eecc9cbf15d@redhat.com>
 <ZdYKnZxdTCvu5THG@yilunxu-OptiPlex-7050>
 <ae3cd81b-82af-4977-91d7-fa809c6fc45a@redhat.com>
 <Zd7cff43ffbJOGNY@yilunxu-OptiPlex-7050>
 <08ba8bce-0ebf-4c8f-952d-a6665dc7fdf9@redhat.com>
 <ZeXRWDGvd8P7KhxJ@yilunxu-OptiPlex-7050>
From: Marco Pagani <marpagan@redhat.com>
In-Reply-To: <ZeXRWDGvd8P7KhxJ@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024-03-04 14:49, Xu Yilun wrote:
>> Just to be sure that I understood correctly, you want to split the
>> changes into two patches, like:
>>
>> a) add module owner to the manager struct and take it in
>> __fpga_mgr_get(); move put_device() from __fpga_mgr_get() to
>> fpga_mgr_get() and of_fpga_mgr_get().
>>
>> b) add the mutex and the unregistered flag for protection against races.
>>
>> So that (b) can be reverted if try_module_get_safe() will be accepted?
> 
> Yes, that's what I mean.
> 

On second thought, I would prefer to send only the patches (a) for the
manager, bridge, and region for the moment. As you said, the chances of
having a race are slim (no crash has ever been reported to date). So,
after (a), I think it is worth focusing first on try_module_get_safe()
since it could also be useful for other subsystems. The (b) patches
could always be applied later if try_module_get_safe() is not accepted.
Thanks,
Marco


