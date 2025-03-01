Return-Path: <linux-fpga+bounces-1075-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14B66A4AA08
	for <lists+linux-fpga@lfdr.de>; Sat,  1 Mar 2025 10:29:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16BAC1744FF
	for <lists+linux-fpga@lfdr.de>; Sat,  1 Mar 2025 09:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 877AC1C5D79;
	Sat,  1 Mar 2025 09:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="COPRH/g0"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989921C3BF1;
	Sat,  1 Mar 2025 09:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740821363; cv=none; b=LGmg+TXfzvBk0GqtlYtxyPY0jJlq+DpuS4F/7C4gXQ/ipFDxoph2wWl5Ai7TulN1vdTOa+XQKo2xlgOhOKbQ3AFQ3QceKuFh/U5eCau2ZEccJBsbpoHDvwWbnzSOgfOtJLA7QAdPiU24vVticVSk/zQIiSdUr7OAU6TxJMEP7vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740821363; c=relaxed/simple;
	bh=jEwK21kfmrUQKCsYQRS+7dOxvBfeSC5o9qX2wR0QSPA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PsquN9m049gGKBTKj1yAYUd8M32dpP0bFccdADlo0TK5xF+0NByWewV1IlcWSg4ZshP7g5ojj761r5Wh2S5DNZX0JTjXA4YIw/3J6+sSzZOnqzqcDe5moAXAq/NIcDqC2+enZtlQNCG7HXkhDM18kjNr9lURq9zAtvt0EwX/qW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=COPRH/g0; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740821362; x=1772357362;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jEwK21kfmrUQKCsYQRS+7dOxvBfeSC5o9qX2wR0QSPA=;
  b=COPRH/g0ChfrEhAgOkorUwZ9uxWvX3FomHf4jE8ld8pMDulek+MO4Z5D
   woqKJF+a2OH9yTePVs0McqL//dDQ5MBB9QRPNpYuMFzboRICEyI6ca8GL
   hsgRq96ljwEPpw3WeyD9RCS9BQeGt9t+m3iHJmlbuhCo+1/eHSOvQ7gze
   FBuldFyyhmDTszg7hXeO5zwcSpcuZ6k0VF8nRSjQASArqJxHlT85QT9Ez
   r3ykErZfva6R3GlVhv66k7/wmFpM6rFbxNqR3IbIhVPoyyyBnuBz1SX61
   RAzZgxsnYpQYtDluuAB3auck8zqlvhXFRJ1BHXLBr7/MK6+SBVtsCmjHp
   g==;
X-CSE-ConnectionGUID: V/LraqzfQZaMf8rQoMzVSg==
X-CSE-MsgGUID: GqpNC3agQ9+xFgVNAnmuww==
X-IronPort-AV: E=McAfee;i="6700,10204,11359"; a="64209227"
X-IronPort-AV: E=Sophos;i="6.13,325,1732608000"; 
   d="scan'208";a="64209227"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2025 01:29:21 -0800
X-CSE-ConnectionGUID: NCKkDS+UT02fzqZYoQG4hw==
X-CSE-MsgGUID: rX+3mIBQT02FkU4evzR0wA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,325,1732608000"; 
   d="scan'208";a="117336465"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa006.fm.intel.com with ESMTP; 01 Mar 2025 01:29:17 -0800
Date: Sat, 1 Mar 2025 17:27:19 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Marco Pagani <marco.pagani@linux.dev>
Cc: Nava kishore Manne <nava.kishore.manne@amd.com>, git@amd.com,
	mdf@kernel.org, hao.wu@intel.com, yilun.xu@intel.com,
	trix@redhat.com, robh@kernel.org, saravanak@google.com,
	linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [RFC v2 1/1] fpga-region: Add generic IOCTL interface for
 runtime FPGA programming
Message-ID: <Z8LS93jh4KBvNlCd@yilunxu-OptiPlex-7050>
References: <20241029091734.3288005-1-nava.kishore.manne@amd.com>
 <20241029091734.3288005-2-nava.kishore.manne@amd.com>
 <ZzwQrYeWVF6cRtgA@yilunxu-OptiPlex-7050>
 <9bfaf1cf-3313-4cb3-9963-2b4bad2d3165@redhat.com>
 <Z0fIiQPCS69O2d/n@yilunxu-OptiPlex-7050>
 <00e5c1c1-a98e-4360-b7e5-ffaa384e1036@linux.dev>
 <Z6RRAXocxWHsZZLF@yilunxu-OptiPlex-7050>
 <a51c0c24-fd21-42b3-9c4a-39ebc0751f03@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a51c0c24-fd21-42b3-9c4a-39ebc0751f03@linux.dev>

On Mon, Feb 17, 2025 at 04:18:36PM +0100, Marco Pagani wrote:
> 
> 
> On 06/02/25 07:04, Xu Yilun wrote:
> >>>> I'm currently working on an RFC to propose a rework of the fpga
> >>>> subsystem in order to make it more aligned with the device model. One of
> >>>> the ideas I'm experimenting with is having a bus (struct bus_type) for
> >>>> fpga regions (devices) so that we can have region drivers that could
> >>>> handle internal device enumeration/management whenever a new region is
> >>>> configured on the fabric. Does this make sense in your opinions?
> >>>
> >>> mm.. I didn't fully understand the need to have a region driver, what's
> >>> the issue to solve?
> >>>
> >>
> >> Sorry for the late reply. The general idea is to handle regions in a way
> >> that is more aligned with the device model without having to resort to
> >> extra ops and additional devices.
> >>
> >> Having an fpga bus would allow us to handle enumeration using proper
> >> region drivers (in the device model sense of the term, i.e., struct
> >> device_driver) instead of derived region devices.
> >>
> >> On second thought, I think having a reconfiguration interface at the
> >> fpga manager level is sounder than having it at the region level (one
> >> for each region).
> > 
> > I don't think so. A firmware image may contain enumeration info, e.g.
> > of-fpga-region. And I think the fpga-region should parse these
> > enumeration info rather than fpga manager. fpga manager should only deal
> > with content writing stuff and not be exposed to user.
> 
> I agree with that. In my proposal, the fpga manager should be
> responsible only for writing the image into the configuration memory
> and allocating region devices. In-region enumeration should be handled by
> the region drivers.
> 
> My worry with having one reconfiguration interface for each region is
> that it does not reflect how the hardware works. To my knowledge, all
> major FPGA implementations use a DMA engine (controlled by the fpga
> manager) that performs the reconfiguration through a single port. So,
> having one interface per region might be conceptually confusing and give
> the impression that it is possible to configure regions independently in
> parallel.

One interface per region means the regions could be independently
reprogrammed, i.e. reprogramming of one region won't affect the working
of another region. But they don't have to be reprogrammed in parallel.
If it cannot be reprogrammed now, the interface call could fail.

> 
> >> With that in place, the fpga manager could request a firmware image,
> >> parse it, write the content into the fpga configuration memory, and then
> >> instantiate the region devices and add them to its fpga bus. Then, if
> > 
> > I think an fpga-region is always there no matter it is cleared, being
> > reprogrammed, or working. So I don't think an fpga-region needs to be
> > re-instantated. The sub devices inside fpga-region needs
> > re-instantating. That's also why I'm hesitating to fpga bus.
> 
> I think one of the issues with the current subsystem architecture is
> that it coalesces two cases: full and partial images. With partial
> images, it makes sense to keep the region devices and rerun the internal
> enumeration. With full images, I believe it makes sense to clear and
> reallocate new devices to set a new region tree.

MM.. I don't actually understand what's the fundamental differences
between full & partial. If a full region supports full & partial
reconfiguration, the full region contains partial regions as
sub-devices. The partial reconfiguration reallocates it sub-devices and
won't change partial region itself. The full reconfiguration also
reallocates it sub-devices including partial regions, and won't change
full region itself.

Thanks,
Yilun

