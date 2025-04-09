Return-Path: <linux-fpga+bounces-1145-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7797DA81C95
	for <lists+linux-fpga@lfdr.de>; Wed,  9 Apr 2025 08:06:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54A293ABB20
	for <lists+linux-fpga@lfdr.de>; Wed,  9 Apr 2025 06:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87BF51DE891;
	Wed,  9 Apr 2025 06:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bNCGTpwN"
X-Original-To: linux-fpga@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 504571DE4FB;
	Wed,  9 Apr 2025 06:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744178596; cv=none; b=O9lTYv8kTU+9HrDU6FmK7klzv9NqnhiUP13iQJ1j02GsmZbD3xzU9s1a7OGUfQGbz1+47+Q/1l5kMVfJw/39ms6Jw+M/Bn6O4/PWUoHB8C4st+K8yErWm7VDc49Ma5CvQlcKyVQLnCxNxbDNg9iLyQrIZN8/xaajLCB9sSLSsOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744178596; c=relaxed/simple;
	bh=PC2Cvk3hQ6ILTfs1axrdvZeQZiDqDu4ODKLySChbf7c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GRjPhuATHqIxaw6l7w35cmOHknrZ47XZClv5z+q1bKBSZDcpbC43WA+RkOR0rNJhIbusmL7a1CW9Ao51QvMjqy0OhptW+L4WQqMSWaE7WL75/KNIt1jLCcZniC9j4CtFCgPZtmLyOEEDKfDjgMZ1/iCe8YQOWFOtUE+xAcvqzho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bNCGTpwN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74033C4CEE3;
	Wed,  9 Apr 2025 06:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744178595;
	bh=PC2Cvk3hQ6ILTfs1axrdvZeQZiDqDu4ODKLySChbf7c=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=bNCGTpwNtqhjwkBxrcKicZtLgSQCrTSimburI1kUZbPyPgyf0m2Fuv02WDFw9A0KV
	 Z/pZhHtEX7NzXilgoFDSWa9P10SddYfY/u5lrPCsf8gTLEytItl/2+IYQN66CPaVXv
	 jG2+TNYvonlnFICwqePiGdmuP+oJcuOZy48bjyLKHz+S8qDcyIY89KIwrH/xix9mHU
	 eN1YS7Zv4tSJbB5THHFVdjI0BSjYf4n2l/XBbh8b/i+N83F7z2e4l0BgEG5gP1YCjC
	 C/bAkZ6YJGA54WRj93qGXuqhdZ2kpSY3qije0fA8t2yoWOstMIr9tCmS1jZyzYX67W
	 2oyyiT2p1Rxhg==
Message-ID: <018b15a8-4f5b-4752-b865-06608b82e7d5@kernel.org>
Date: Wed, 9 Apr 2025 08:03:10 +0200
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: fpga: zynq: Document ICAP on boot
To: Sam Winchenbach <sam.winchenbach@framepointer.org>
Cc: linux-kernel@vger.kernel.org, mdf@kernel.org, hao.wu@intel.com,
 yilun.xu@intel.com, trix@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, michal.simek@amd.com, linux-fpga@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Sam Winchenbach <swinchenbach@arka.org>
References: <20250328141944.119504-1-sam.winchenbach@framepointer.org>
 <02496a88-3d9c-49ee-93ab-8f1400fc0c6b@kernel.org>
 <p4bujnmgkcvsu4qipmgh2j2loedepmwgp7zlaxrurhaveb6tbc@ibqtbjnbzdzj>
 <14b12882-119d-4c24-9634-e4cc37a39212@kernel.org>
 <2ccsnpv67gsu354uo7xe7syrxs265ncj6hl26v3cwf2dfm7hyu@ihkemyajuiag>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <2ccsnpv67gsu354uo7xe7syrxs265ncj6hl26v3cwf2dfm7hyu@ihkemyajuiag>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 31/03/2025 15:07, Sam Winchenbach wrote:
>>> Before writing the fabric to the FPGA the driver disables the ICAP, enabling
>>> the PCAP. Once writing is complete it unconditionally disables the PCAP,
>>> enabling the ICAP. This patch just makes it so, depending on the use case,
>>> the ICAP can be enabled at boot. This will not prevent the system from being
>>> able to load a fabric through the driver. I added in this boolean so existing
>>> behavior would be maintained.
>>>
>>> Do you recommend another approach such as writing to a sysfs attribute to
>>> switch from PCAP to ICAP?
>> Not sure yet. Can't you check the status of ICAP before programming and
>> then enable it only if was enabled before?
> 
> I am having a bit of difficulty understanding this so let's talk about cases
> where the ICAP is enabled/disabled -
> 
> 1. When writing the fabric from the driver
>    In this situation it might make sense to read the state of the ICAP
>    interface when preparing the fabric, before enabling PCAP. When the write
>    completes you could re-enable the ICAP if it was previously enabled.
> 
>    This might be outside the scope of this change - and I am not comfortable
>    enough with this use-case to understand potential side effects from doing
>    this. Logically it makes sense, but there may be a very specific reason that
>    the ICAP must be enabled after doing a fabric load or partial
>    reconfiguration.
> 
> 2. When the FPGA driver loads and is probed by the DTS
>    In this situation, which is covered by this patch, the FPGA is loaded by
>    BootROM/FSBL but contains functionality that requires the ICAP. Unless the
>    user has made modifications to the FSBL or 3rd stage bootloader there is no
>    clear way to enable the ICAP interface. Checking to see if it had been
>    enabled prior to loading this driver does not (in my opinion) make a lot of
>    sense here.
> 
>    Perhaps the name of the DTS is confusing? The suffix '-on-load' was meant to
>    indicate when the driver was loaded, not the fabric. Would the suffix
>    '-on-probe' be more clear?
None of these two, because you refer to software. Property is fine but
you need to describe the actual state of hardware or system or entire
stack, e.g. "fpga-with-sem".
Best regards,
Krzysztof

