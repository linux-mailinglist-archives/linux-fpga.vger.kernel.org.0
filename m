Return-Path: <linux-fpga+bounces-1049-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C83AA306AA
	for <lists+linux-fpga@lfdr.de>; Tue, 11 Feb 2025 10:11:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A72916595A
	for <lists+linux-fpga@lfdr.de>; Tue, 11 Feb 2025 09:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80AA21F03D2;
	Tue, 11 Feb 2025 09:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HBb0zS73"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD1A26BDA6;
	Tue, 11 Feb 2025 09:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739265059; cv=none; b=QXX2m8uzcS0kzGLL385l5zvF4V+8wC8hpFGFBC82VVP++OCWqaa8QXHywPf377oriRfA8B5Tq5sucG3zrHfAtKWs/ZlkUE55bHr8gvyo8aY5tac3gVxBPetDR7xpJjWxwJHfaCpPlt0azvR4Q5K0QqWDfFqV2F1vFXzm3UNBAMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739265059; c=relaxed/simple;
	bh=U9/oUWehWMUw3I68Re2zy7G47SfbIzwiwflBq2Dbgeo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YbIJQbbqr1EdOqmbfY3OudrpwMqGW4P2FJdr/3FdYqZdVVIsLKUaSTbhxYjhPNEApF7Tey/SCaPVdVF0GUkAtMuFqsRgp0RfP0HOxeJkO/LxGKAxqFzOUGoae7GOSegAGAjAlorVGHDaqdXdQql5M4o0isblDo2HXmdwnS3T5S8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HBb0zS73; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739265058; x=1770801058;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=U9/oUWehWMUw3I68Re2zy7G47SfbIzwiwflBq2Dbgeo=;
  b=HBb0zS73ZbIJtI4MLset6G/HFSHV5A6jzyKoZ6BjarCf79Zy73vT4yiY
   LJv74W2s13GhKgDSnriChXKLniYOCNfdDpIQzhiT4HQUt015Y6zWpDj0u
   5aBZ4zFaAxX14Y7LrMaiwTHz3gjpB5wP2SY+fuzpyPMh1sgvlAs2EHhSB
   s62OoAVmTBv0+3IhLfOO2dFK2OIFUVGsHSZ8LRuvtkjGQjzT7+9Lmgg9w
   YMoaKKrouB2If83zssuoJgO19nthSIdRvmEdAiZMKhLKDjVaCdJvFcY1F
   71BAZaDd7IgAm4HY6lwSw45RiJW4cZY//BYuoYQggxh6FdBB5g27DFUCr
   Q==;
X-CSE-ConnectionGUID: MsnUMgu9RnGeJM/vFm2V0Q==
X-CSE-MsgGUID: y+2p3qwkQbmpBrBMweTpfw==
X-IronPort-AV: E=McAfee;i="6700,10204,11341"; a="40142983"
X-IronPort-AV: E=Sophos;i="6.13,277,1732608000"; 
   d="scan'208";a="40142983"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 01:10:57 -0800
X-CSE-ConnectionGUID: b5osf7sRQ9Obv8P1FBIWgA==
X-CSE-MsgGUID: CP2YKcN+TB6aPxK9USvlyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="112918889"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa007.jf.intel.com with ESMTP; 11 Feb 2025 01:10:55 -0800
Date: Tue, 11 Feb 2025 17:09:47 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Yidong Zhang <yidong.zhang@amd.com>
Cc: linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org,
	mdf@kernel.org, hao.wu@intel.com, yilun.xu@intel.com,
	lizhi.hou@amd.com, DMG Karthik <Karthik.DMG@amd.com>,
	Nishad Saraf <nishads@amd.com>,
	Hayden Laccabue <hayden.laccabue@amd.com>
Subject: Re: [PATCH V2 1/4] drivers/fpga/amd: Add new driver amd versal-pci
Message-ID: <Z6sT20uzjes7SGzr@yilunxu-OptiPlex-7050>
References: <20241210183734.30803-1-yidong.zhang@amd.com>
 <20241210183734.30803-2-yidong.zhang@amd.com>
 <Z5YPWHVmL29zuQNm@yilunxu-OptiPlex-7050>
 <3b520bab-d948-470a-b06f-5494243ebc1a@amd.com>
 <Z6Q3W2mUw/ZbtnWV@yilunxu-OptiPlex-7050>
 <796e2826-a423-4d0c-977a-105ed236e067@amd.com>
 <Z6Vtz/Bb8wsIH0pG@yilunxu-OptiPlex-7050>
 <7b9bd24f-8f89-4d6c-a079-47c4c0b88a35@amd.com>
 <Z6WO2Ktc9HoqdUSU@yilunxu-OptiPlex-7050>
 <e68be2e2-7fdd-4f09-b479-4b0e31af5be5@amd.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e68be2e2-7fdd-4f09-b479-4b0e31af5be5@amd.com>

On Mon, Feb 10, 2025 at 03:33:07AM -0800, Yidong Zhang wrote:
> 
> 
> On 2/6/25 20:40, Xu Yilun wrote:
> > Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> > 
> > 
> > On Thu, Feb 06, 2025 at 07:16:25PM -0800, Yidong Zhang wrote:
> > > 
> > > 
> > > On 2/6/25 18:19, Xu Yilun wrote:
> > > > Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> > > > 
> > > > 
> > > > > > No need to detach a specific driver, remove all devices in the
> > > > > > fpga-region. I imagine this could also be a generic flow for all PCI/e
> > > > > > based FPGA cards.
> > > > > 
> > > > > I see your point. Is there an existing example in current fpga driver for
> > > > > PCI/e based cards?
> > > > 
> > > > No. The fpga-region re-enumeration arch is still WIP, so no existing
> > > > implementation.
> > > 
> > > Got you. I can also help to test or provide feedback.
> > > Actually, I had sent Nava my protype of using configfs for the non-OF
> > > driver. He should have the updated patch soon.
> > > 
> > > > 
> > > > > 
> > > > > We will need to talk to our management team and re-design our driver.
> > > > > I think we have 2 approaches:
> > > > > 1) Align with linux fpga, having one driver for both userPF and mgmtPF; or
> > > > 
> > > > Don't get you. Linux FPGA doesn't require one driver for both PFs.
> > > 
> > > I assume when you said "generic flow for removing all devices in
> > > fpga-region" means that there is a single driver which use the fpga-region
> > > callbacks to remove all devices and then re-progream the FPGA.
> > > 
> > > On AMD V70 hardware, the userPF has different deviceid than the mgmtPF.
> > > Thus, our current design is having 2 separate pcie drivers for each
> > > different deviceid.
> > > 
> > > Thus, in our current design, the fpga-region should be in the userPF driver
> > > which has callbacks to remove all devices. But in mgmtPF, it is more like a
> > 
> > A question, if the FPGA logic is cleared, does the userPF still exist on
> > PCIe bus?
> 
> I am not sure I fully understand your question by "FPGA logic is cleared".
> Based on our design, the userPF exists, but all services need to be
> re-configured after hardware is changed.

I briefly read your XRT docs. IIUC we are talking about reprogramming
the "Dynamic Region", not the "Shell".

The userPF's PCIe basic functionality is in Shell and is out of
our reprograming discussion. So userPF PCI device always exists even if
the "Dynamic Region" is being reprogrammed. In this case, we should
create fpga-region for this "Dynamic Region" in userPF driver.

userPF uses some HW communication channel to require reprograming, so
fpga-manager could also be implemented in userPF driver.

And I agree the mgmtPF driver is a utility driver that just monitor on
the communication channel and serve requirements, nothing to do with
FPGA framework. I have no objection to put it in misc or firmware
directory.

What I'm not sure is whether a standalone utility driver in kernel tree
is preferred (at least I don't). You may talk to other maintainers.

> 
> 
> > 
> > > utility which only handles request from the userPF but it has the management
> > > privilege. Usually, cloud vendors require the mgmtPF deployed in their
> > > secured domain (can be a separate physical machine).
> > 
> > I though mgmtPF & userPF are just 2 functions on one PCIe card, they are not?
> > Then how the mgmtPF writes data to another physical machine and
> > influence the userPF?
> > 
> 
> They are functions but they also have different device id thus we can bind
> different driver onto each of them.
> 
> I think I should interrupt it accurately as Host and VM. See details here
> please:
> https://xilinx.github.io/XRT/2019.2/html/cloud_vendor_support.html
> 
> But, my point is that we do have 2 separate drivers.

OK, having 2 separate drivers is definitely fine.

Thanks,
Yilun

