Return-Path: <linux-fpga+bounces-1417-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E54EDC3552A
	for <lists+linux-fpga@lfdr.de>; Wed, 05 Nov 2025 12:20:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B7CF425FBD
	for <lists+linux-fpga@lfdr.de>; Wed,  5 Nov 2025 11:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAAC42F1FD2;
	Wed,  5 Nov 2025 11:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b="WIB9Yl0W"
X-Original-To: linux-fpga@vger.kernel.org
Received: from smtp82.iad3b.emailsrvr.com (smtp82.iad3b.emailsrvr.com [146.20.161.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF5D7301014
	for <linux-fpga@vger.kernel.org>; Wed,  5 Nov 2025 11:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=146.20.161.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762341395; cv=none; b=uxx5ysbHxp0T7prwci2cd2PswQbxHlP6rAgWGf2Sb73ZmSddKQ+VN5RIs0c26/dpBLKqP/cbspHQchMj1ulEJJW6Qm+diPsDuDHkGtqX0wU3B+flO+Nf2Lz5LJQkLC4mwE3rJOSIInPeWR5lrSJ1WS/6019iQu1SHl7ePdQPMl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762341395; c=relaxed/simple;
	bh=gmrLDFWIcFEh0KvbnxCeN7ggLLHUJBDVEAKb2UpLZVs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lDETo87oO4bDNX7dm+Cc7Z1ip7i9G5BT4dwP/+e8jEUG1Px+EFWyclJPkcHy/KSItATfRW4qX3I3WAPoF5t4Xfl0vmrck9Aexkb1afhwUuEhQXY0j45AwIlPYmbeCZLFs+ENuvl3Se3CsKxkP8jyfr2pxEMSdp6Zc3eDU/ya7sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk; spf=pass smtp.mailfrom=mev.co.uk; dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b=WIB9Yl0W; arc=none smtp.client-ip=146.20.161.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mev.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
	s=20221208-6x11dpa4; t=1762339061;
	bh=gmrLDFWIcFEh0KvbnxCeN7ggLLHUJBDVEAKb2UpLZVs=;
	h=Date:Subject:To:From:From;
	b=WIB9Yl0WLbne2ba/EbDcR8hvmkBLPu3P9tUJXDUfGuBWGZyE8ZSCPCfHby8Ps5EiK
	 5pg0bNdpL//RNxxKHOR9cvcpx7164ljYF5c96DymehkxBorl8BbQ2oEIIJ5g7GaaLr
	 F0B5oQ5VCT9UHZFRWAh8gYSjavaMLtZ7lOlHSzbk=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp3.relay.iad3b.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id CD318403C0;
	Wed,  5 Nov 2025 05:37:40 -0500 (EST)
Message-ID: <22148db9-3579-4298-b641-91cc98dc1c5c@mev.co.uk>
Date: Wed, 5 Nov 2025 10:37:39 +0000
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] fpga: Add dummy definitions of API functions
To: Xu Yilun <yilun.xu@linux.intel.com>
Cc: linux-fpga@vger.kernel.org, Moritz Fischer <mdf@kernel.org>,
 Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
 linux-kernel@vger.kernel.org
References: <20251104153013.154463-1-abbotti@mev.co.uk>
 <aQqsnFl8uakMAsH+@yilunxu-OptiPlex-7050>
Content-Language: en-GB
From: Ian Abbott <abbotti@mev.co.uk>
Organization: MEV Ltd.
In-Reply-To: <aQqsnFl8uakMAsH+@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Classification-ID: e93dd03d-3b13-4ec7-81ac-1f36f800238a-1-1

On 2025-11-05 01:47, Xu Yilun wrote:
> On Tue, Nov 04, 2025 at 03:27:01PM +0000, Ian Abbott wrote:
>> Add dummy definitions of the FPGA API functions for build testing
>>
>> 1) fpga: altera-pr-ip: Add dummy definitions of API functions
>> 2) fpga: bridge: Add dummy definitions of API functions
>> 3) fpga: manager: Add dummy definitions of API functions
>> 4) fpga: region: Add dummy definitions of API functions
> 
> Sorry I don't get the idea. Why should someone use FPGA APIs without
> selecting CONIG_FPGA_XXX? Better make the changes along with the use
> case patches.

Projects using FPGAs often have custom devices with custom, out-of-tree 
drivers, so it's quite useful to be able to build test those drivers 
against later kernel versions on the host to keep up with kernel API 
drift, prior to possible later adoption of the kernel version on the target.

> Thanks,
> Yilun
> 
>>
>>   include/linux/fpga/altera-pr-ip-core.h |  8 ++-
>>   include/linux/fpga/fpga-bridge.h       | 75 ++++++++++++++++++++++++++-
>>   include/linux/fpga/fpga-mgr.h          | 95 +++++++++++++++++++++++++++++++---
>>   include/linux/fpga/fpga-region.h       | 44 ++++++++++++++--
>>   4 files changed, 207 insertions(+), 15 deletions(-)
However, I messed up the patches, because I only built them without the 
FPGA configure options defined.  I plan to submit a v2 patch series 
unless it is deemed a complete waste of effort by the maintainers.

Cheers,
Ian
-- 
-=( Ian Abbott <abbotti@mev.co.uk> || MEV Ltd. is a company  )=-
-=( registered in England & Wales.  Regd. number: 02862268.  )=-
-=( Regd. addr.: S11 & 12 Building 67, Europa Business Park, )=-
-=( Bird Hall Lane, STOCKPORT, SK3 0XA, UK. || www.mev.co.uk )=-


