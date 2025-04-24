Return-Path: <linux-fpga+bounces-1172-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68066A9A975
	for <lists+linux-fpga@lfdr.de>; Thu, 24 Apr 2025 12:07:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A14961B6394B
	for <lists+linux-fpga@lfdr.de>; Thu, 24 Apr 2025 10:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20F08220680;
	Thu, 24 Apr 2025 10:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HscU/1vM"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5596F1EB5D4;
	Thu, 24 Apr 2025 10:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745489210; cv=none; b=QmgFctegt34t02xynE9DnWO/8l5Kx2zBt7JDn8jPwYeiIPUqCQNPbQEgkxfKIDpPcnlIj0HACM9qW++mrj7pebwqlUEh24u95m2x2S9lcY8CxXVmHNyE+QLj95btuVuHMBUoZASkrdfCD8pFrhxnO4G0bJAckxbUm8MfPcZ+NbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745489210; c=relaxed/simple;
	bh=ohWISbUI5Hdqkvh3YTzjrPdr0SXkU3j2Fcx45MwThg8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J2djdOD7RdLrJohAwY794QJ9EWB2N91V6RFafZzgJSUHiqE+p7AaoXaYMZrCmrsmyEuoXFIy5NCK8RgDVuGxAj4j+4PfHLNer32jStTaipfEHjCSvM8OUt4V1VMRPLA/xkwGaCfQdOB6uc3BPdYUKCzv11f3UEb52VUcYwi/q+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HscU/1vM; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745489209; x=1777025209;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ohWISbUI5Hdqkvh3YTzjrPdr0SXkU3j2Fcx45MwThg8=;
  b=HscU/1vMSV66+z8117S8dr5HfKjK0+dU+JIW+5WvrXHaUSYDOgdVWDvK
   IiGbB0fJsL+ZMw9fEmuF2CVtzXBuncIhppREMvwMRCJkgLvIVMtr9yPS/
   kM5qqTJ8xLKIa86VlvM7a7yq4MY/x+HdZg5/gBknDzoiLEeaVOmDo2g/D
   Jip3u3dkfe4P7qVA1KplNPcw8MwNQ+LoYoJkT7kdi8v9gXWrmQt7hNVfZ
   bq/shjmWgYBe+51syxzSWDkZB5QgU8sVJGhwazp5vgPb8v6uFUZWb30i6
   Fyqh7PACKM5KG1dDDVO8BfQfD/RzS9hKANDH4x9qV6Vt/d0u+Y8sUiUOk
   w==;
X-CSE-ConnectionGUID: Ku0crXDMRAu8c8PXxv8Idg==
X-CSE-MsgGUID: UL13JzeWQiaGJOJHM4tI0w==
X-IronPort-AV: E=McAfee;i="6700,10204,11412"; a="46821430"
X-IronPort-AV: E=Sophos;i="6.15,235,1739865600"; 
   d="scan'208";a="46821430"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2025 03:06:44 -0700
X-CSE-ConnectionGUID: M87gWBuhQQW769P5s2kxjA==
X-CSE-MsgGUID: 8NT3xrSgTm60P/0pBA820Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,235,1739865600"; 
   d="scan'208";a="169788122"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa001.jf.intel.com with ESMTP; 24 Apr 2025 03:06:40 -0700
Date: Thu, 24 Apr 2025 18:02:05 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Sam Winchenbach <sam.winchenbach@framepointer.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, linux-kernel@vger.kernel.org,
	mdf@kernel.org, hao.wu@intel.com, yilun.xu@intel.com,
	trix@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, michal.simek@amd.com,
	linux-fpga@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Sam Winchenbach <swinchenbach@arka.org>
Subject: Re: [PATCH 1/2] dt-bindings: fpga: zynq: Document ICAP on boot
Message-ID: <aAoMHV4cPrMWPHNk@yilunxu-OptiPlex-7050>
References: <20250328141944.119504-1-sam.winchenbach@framepointer.org>
 <02496a88-3d9c-49ee-93ab-8f1400fc0c6b@kernel.org>
 <p4bujnmgkcvsu4qipmgh2j2loedepmwgp7zlaxrurhaveb6tbc@ibqtbjnbzdzj>
 <14b12882-119d-4c24-9634-e4cc37a39212@kernel.org>
 <2ccsnpv67gsu354uo7xe7syrxs265ncj6hl26v3cwf2dfm7hyu@ihkemyajuiag>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ccsnpv67gsu354uo7xe7syrxs265ncj6hl26v3cwf2dfm7hyu@ihkemyajuiag>

On Mon, Mar 31, 2025 at 09:07:03AM -0400, Sam Winchenbach wrote:
> On Mon, Mar 31, 2025 at 02:43:59PM +0200, Krzysztof Kozlowski wrote:
> > On 31/03/2025 14:30, Sam Winchenbach wrote:
> > >>
> > >>> +    type: boolean
> > >>> +    description: If present, the ICAP controller will be enabled when
> > >>> +      the driver probes. This is useful if the fabric is loaded
> > >>> +      during the boot process and contains a core, such as the SEM,
> > >>
> > >> I don't get how this is suitable for DT. If you decide to load the
> > >> fabric from driver, that's driver decision so not DT.
> > > 
> > > Before writing the fabric to the FPGA the driver disables the ICAP, enabling
> > > the PCAP. Once writing is complete it unconditionally disables the PCAP,
> > > enabling the ICAP. This patch just makes it so, depending on the use case,
> > > the ICAP can be enabled at boot. This will not prevent the system from being
> > > able to load a fabric through the driver. I added in this boolean so existing
> > > behavior would be maintained.
> > > 
> > > Do you recommend another approach such as writing to a sysfs attribute to
> > > switch from PCAP to ICAP?
> > Not sure yet. Can't you check the status of ICAP before programming and
> > then enable it only if was enabled before?
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

I don't think this should be a property for fpga_mgr device. It is for
FPGA reprogramming. You insmod the reprograming driver not for
reprogramming, just to enable the already programmed functionality.

My idea is, to load the fpga_region with an image tagged "external-fpga-config".

Thanks,
Yilun

>    enabled prior to loading this driver does not (in my opinion) make a lot of
>    sense here.
> 
>    Perhaps the name of the DTS is confusing? The suffix '-on-load' was meant to
>    indicate when the driver was loaded, not the fabric. Would the suffix
>    '-on-probe' be more clear?
> 
> Let me know your thoughts,
> -Sam
> 
> >
> > Best regards,
> > Krzysztof
> 

