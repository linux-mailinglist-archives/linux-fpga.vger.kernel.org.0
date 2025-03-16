Return-Path: <linux-fpga+bounces-1116-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46386A6379F
	for <lists+linux-fpga@lfdr.de>; Sun, 16 Mar 2025 22:55:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84FF01640ED
	for <lists+linux-fpga@lfdr.de>; Sun, 16 Mar 2025 21:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74D7F195980;
	Sun, 16 Mar 2025 21:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YR4+LKPb"
X-Original-To: linux-fpga@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26DE7174EF0
	for <linux-fpga@vger.kernel.org>; Sun, 16 Mar 2025 21:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742162124; cv=none; b=XwsGHlvq+8ttDxGMNdsff+J8zkzJJtH68a5OKgx6BNUwVJ8lQCjQnuKxZ1pUKCOYAi/ACDwIrebnoAr4KIob9pKxl4/LAo957516BLzM0FaO0bAjAjv7EGKQQOJgizOSOQtZaI1LR5DWOAR5+KyfCZwky2sfK+ZJQ+/rJ7ip+is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742162124; c=relaxed/simple;
	bh=KvITfVWFiAHlc/UDGmRKZ8po7s5LIRx/q479ewV21tw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ctMMpVHhXMWEgbYcHFx2JR2Mdzb7XvBh/n1hvAqW5ZnMOOBbT9256Y5k8P1rF+hT9D7bIMNI5SBEPaiTvwoNFSgdLsg6/6AWeB553jAGeFj0nv1DiWbdVPLD/QYdB/jBFS7LLDZcPjX/uzac5usnxSdqvaZpgdxRbEUS4Kx/h1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YR4+LKPb; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <51c5a9e8-6bb5-4094-a1f2-711b139f83e7@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1742162109;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qbG3mEfDTeka59b50aeHpcTAVOm/WyqfOPBtEdRR8JA=;
	b=YR4+LKPbJDGDbECq5vJtgN8O+t3UuFm6xv0H9LszS+bK6kukjVj7un+z30fhqOIIB/H7G8
	WTTPpBfNuQtOWW0wtD4c4iv+TmrwyxdC4X2RZm9oAdDafcg1TANseIWP3Jgag+CRFkJZ1t
	+tiKYY0zsilB1GYon7baOZ6jJ7Hbi6k=
Date: Sun, 16 Mar 2025 22:55:07 +0100
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC v2 1/1] fpga-region: Add generic IOCTL interface for runtime
 FPGA programming
To: Xu Yilun <yilun.xu@linux.intel.com>
Cc: Nava kishore Manne <nava.kishore.manne@amd.com>, git@amd.com,
 mdf@kernel.org, hao.wu@intel.com, yilun.xu@intel.com, trix@redhat.com,
 robh@kernel.org, saravanak@google.com, linux-kernel@vger.kernel.org,
 linux-fpga@vger.kernel.org, devicetree@vger.kernel.org
References: <20241029091734.3288005-1-nava.kishore.manne@amd.com>
 <20241029091734.3288005-2-nava.kishore.manne@amd.com>
 <ZzwQrYeWVF6cRtgA@yilunxu-OptiPlex-7050>
 <9bfaf1cf-3313-4cb3-9963-2b4bad2d3165@redhat.com>
 <Z0fIiQPCS69O2d/n@yilunxu-OptiPlex-7050>
 <00e5c1c1-a98e-4360-b7e5-ffaa384e1036@linux.dev>
 <Z6RRAXocxWHsZZLF@yilunxu-OptiPlex-7050>
 <a51c0c24-fd21-42b3-9c4a-39ebc0751f03@linux.dev>
 <Z8LS93jh4KBvNlCd@yilunxu-OptiPlex-7050>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Marco Pagani <marco.pagani@linux.dev>
In-Reply-To: <Z8LS93jh4KBvNlCd@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 2025-03-01 10:27, Xu Yilun wrote:
> On Mon, Feb 17, 2025 at 04:18:36PM +0100, Marco Pagani wrote:
>>
>>
>> On 06/02/25 07:04, Xu Yilun wrote:
>>>>>> I'm currently working on an RFC to propose a rework of the fpga
>>>>>> subsystem in order to make it more aligned with the device model. One of
>>>>>> the ideas I'm experimenting with is having a bus (struct bus_type) for
>>>>>> fpga regions (devices) so that we can have region drivers that could
>>>>>> handle internal device enumeration/management whenever a new region is
>>>>>> configured on the fabric. Does this make sense in your opinions?
>>>>>
>>>>> mm.. I didn't fully understand the need to have a region driver, what's
>>>>> the issue to solve?
>>>>>
>>>>
>>>> Sorry for the late reply. The general idea is to handle regions in a way
>>>> that is more aligned with the device model without having to resort to
>>>> extra ops and additional devices.
>>>>
>>>> Having an fpga bus would allow us to handle enumeration using proper
>>>> region drivers (in the device model sense of the term, i.e., struct
>>>> device_driver) instead of derived region devices.
>>>>
>>>> On second thought, I think having a reconfiguration interface at the
>>>> fpga manager level is sounder than having it at the region level (one
>>>> for each region).
>>>
>>> I don't think so. A firmware image may contain enumeration info, e.g.
>>> of-fpga-region. And I think the fpga-region should parse these
>>> enumeration info rather than fpga manager. fpga manager should only deal
>>> with content writing stuff and not be exposed to user.
>>
>> I agree with that. In my proposal, the fpga manager should be
>> responsible only for writing the image into the configuration memory
>> and allocating region devices. In-region enumeration should be handled by
>> the region drivers.
>>
>> My worry with having one reconfiguration interface for each region is
>> that it does not reflect how the hardware works. To my knowledge, all
>> major FPGA implementations use a DMA engine (controlled by the fpga
>> manager) that performs the reconfiguration through a single port. So,
>> having one interface per region might be conceptually confusing and give
>> the impression that it is possible to configure regions independently in
>> parallel.
> 
> One interface per region means the regions could be independently
> reprogrammed, i.e. reprogramming of one region won't affect the working
> of another region. But they don't have to be reprogrammed in parallel.
> If it cannot be reprogrammed now, the interface call could fail.

Good point. However, I still have some other practical concerns. To the
best of my knowledge, reconfigurable images/bitstreams are statically
built for a specific reconfigurable region in current FPGA
implementations. So, what should happen if the user feeds the wrong
image (e.g., an image targeting another region) into a reconfigurable
region programming interface? I don't think the fpga manager could and
should detect these mistakes since the kernel has no visibility of the
FPGA configuration memory.

>>>> With that in place, the fpga manager could request a firmware image,
>>>> parse it, write the content into the fpga configuration memory, and then
>>>> instantiate the region devices and add them to its fpga bus. Then, if
>>>
>>> I think an fpga-region is always there no matter it is cleared, being
>>> reprogrammed, or working. So I don't think an fpga-region needs to be
>>> re-instantated. The sub devices inside fpga-region needs
>>> re-instantating. That's also why I'm hesitating to fpga bus.
>>
>> I think one of the issues with the current subsystem architecture is
>> that it coalesces two cases: full and partial images. With partial
>> images, it makes sense to keep the region devices and rerun the internal
>> enumeration. With full images, I believe it makes sense to clear and
>> reallocate new devices to set a new region tree.
> 
> MM.. I don't actually understand what's the fundamental differences
> between full & partial. If a full region supports full & partial
> reconfiguration, the full region contains partial regions as
> sub-devices. The partial reconfiguration reallocates it sub-devices and
> won't change partial region itself. The full reconfiguration also
> reallocates it sub-devices including partial regions, and won't change
> full region itself.

What I had in mind was re-instating a new region device in case of
partial reconfiguration to re-trigger the enumeration by a region driver
of the devices hosted in the region.

At this point, I believe I should send an RFC to have something concrete
to discuss. Unfortunately, it may take me some time due to a job change.

Thanks,
Marco


