Return-Path: <linux-fpga+bounces-1119-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8429AA640EC
	for <lists+linux-fpga@lfdr.de>; Mon, 17 Mar 2025 07:11:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DD963A3D7F
	for <lists+linux-fpga@lfdr.de>; Mon, 17 Mar 2025 06:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C41BA215047;
	Mon, 17 Mar 2025 06:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ip5x1pup"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA742E3373;
	Mon, 17 Mar 2025 06:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742191874; cv=none; b=W0Cnv10NJB4W957ZY69QeBkpU68+/Kpk3ryUk5hHoA62wRA7vLgm+Yx62J1tBvG/Bm2GhbQ4sKUZM4eCGihpfV4G/h6acU6Kbt4tZZyDRIlFea8QYQNg5IVKY5xMIjaBbyI6D9IITZmHYE7F9BTXY3ACdBjzoUIe46wIk5WYumA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742191874; c=relaxed/simple;
	bh=+tBBYItJdAy1jBxiRg9TNMg0rDp98e+DU7O+7VJg1Ck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RfnY6KAJN7ftEyANo9gpNNvELAU2IM4PyJ7bHe2JUC3NW2oEC4wQjAI1rL9g9sCaLu4m0BwiJlzi34d2GeXdrn8XGX/tPBHa3nlNCY59j12eXubJkonPE9/uPS2lYiRyYknWmAso/2EfwYbXqVVMLs+4yiXPXcU/AbJkJDECej4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ip5x1pup; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742191873; x=1773727873;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+tBBYItJdAy1jBxiRg9TNMg0rDp98e+DU7O+7VJg1Ck=;
  b=Ip5x1pupjOMGxerl4wxK2Xq3ePUiyS6tCHLcoSq5xWW+Q25dHawdyLQ4
   KhWNB/8YMxfFrz5pQblsDriq+Ixh+t9cYDTS5SLjRU7ZbpywH5Cw0T0po
   GCPKnyfeptLvl/ScMNMqQ0Xe8QtqLAphEsW4brZUo3+2NZP3yty83q4NQ
   ZMYDho/ePDHWJ17eGX3N4ikJaeKwVSkgisImzJ+8q3uW1MMiXl7het1Fd
   PA6m/lYXhs6N7cq1Wrq0sjvDiPU1HKQ+FJ8moX+HnS/4JJAi2Va7kzmk+
   vdoqVRd1CAa26JlnMTgxwPcpr6pSTtBFJnDSlc6hyGWJPLLlWU+IvcYlc
   A==;
X-CSE-ConnectionGUID: 53yZrakpRy216z6qV63vAQ==
X-CSE-MsgGUID: bveIZCsgQaSx+Bco9HXEcw==
X-IronPort-AV: E=McAfee;i="6700,10204,11375"; a="43182062"
X-IronPort-AV: E=Sophos;i="6.14,253,1736841600"; 
   d="scan'208";a="43182062"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2025 23:11:12 -0700
X-CSE-ConnectionGUID: qT6d/rf3To2/AovUIRc90A==
X-CSE-MsgGUID: HFNjRowAR6GyquiPtRAVsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,253,1736841600"; 
   d="scan'208";a="158991406"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa001.jf.intel.com with ESMTP; 16 Mar 2025 23:11:09 -0700
Date: Mon, 17 Mar 2025 14:08:24 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Marco Pagani <marco.pagani@linux.dev>
Cc: Nava kishore Manne <nava.kishore.manne@amd.com>, git@amd.com,
	mdf@kernel.org, hao.wu@intel.com, yilun.xu@intel.com,
	trix@redhat.com, robh@kernel.org, saravanak@google.com,
	linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [RFC v2 1/1] fpga-region: Add generic IOCTL interface for
 runtime FPGA programming
Message-ID: <Z9e8WGzwcDOrx00l@yilunxu-OptiPlex-7050>
References: <20241029091734.3288005-1-nava.kishore.manne@amd.com>
 <20241029091734.3288005-2-nava.kishore.manne@amd.com>
 <ZzwQrYeWVF6cRtgA@yilunxu-OptiPlex-7050>
 <9bfaf1cf-3313-4cb3-9963-2b4bad2d3165@redhat.com>
 <Z0fIiQPCS69O2d/n@yilunxu-OptiPlex-7050>
 <00e5c1c1-a98e-4360-b7e5-ffaa384e1036@linux.dev>
 <Z6RRAXocxWHsZZLF@yilunxu-OptiPlex-7050>
 <a51c0c24-fd21-42b3-9c4a-39ebc0751f03@linux.dev>
 <Z8LS93jh4KBvNlCd@yilunxu-OptiPlex-7050>
 <51c5a9e8-6bb5-4094-a1f2-711b139f83e7@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51c5a9e8-6bb5-4094-a1f2-711b139f83e7@linux.dev>

On Sun, Mar 16, 2025 at 10:55:07PM +0100, Marco Pagani wrote:
> 
> On 2025-03-01 10:27, Xu Yilun wrote:
> > On Mon, Feb 17, 2025 at 04:18:36PM +0100, Marco Pagani wrote:
> >>
> >>
> >> On 06/02/25 07:04, Xu Yilun wrote:
> >>>>>> I'm currently working on an RFC to propose a rework of the fpga
> >>>>>> subsystem in order to make it more aligned with the device model. One of
> >>>>>> the ideas I'm experimenting with is having a bus (struct bus_type) for
> >>>>>> fpga regions (devices) so that we can have region drivers that could
> >>>>>> handle internal device enumeration/management whenever a new region is
> >>>>>> configured on the fabric. Does this make sense in your opinions?
> >>>>>
> >>>>> mm.. I didn't fully understand the need to have a region driver, what's
> >>>>> the issue to solve?
> >>>>>
> >>>>
> >>>> Sorry for the late reply. The general idea is to handle regions in a way
> >>>> that is more aligned with the device model without having to resort to
> >>>> extra ops and additional devices.
> >>>>
> >>>> Having an fpga bus would allow us to handle enumeration using proper
> >>>> region drivers (in the device model sense of the term, i.e., struct
> >>>> device_driver) instead of derived region devices.
> >>>>
> >>>> On second thought, I think having a reconfiguration interface at the
> >>>> fpga manager level is sounder than having it at the region level (one
> >>>> for each region).
> >>>
> >>> I don't think so. A firmware image may contain enumeration info, e.g.
> >>> of-fpga-region. And I think the fpga-region should parse these
> >>> enumeration info rather than fpga manager. fpga manager should only deal
> >>> with content writing stuff and not be exposed to user.
> >>
> >> I agree with that. In my proposal, the fpga manager should be
> >> responsible only for writing the image into the configuration memory
> >> and allocating region devices. In-region enumeration should be handled by
> >> the region drivers.
> >>
> >> My worry with having one reconfiguration interface for each region is
> >> that it does not reflect how the hardware works. To my knowledge, all
> >> major FPGA implementations use a DMA engine (controlled by the fpga
> >> manager) that performs the reconfiguration through a single port. So,
> >> having one interface per region might be conceptually confusing and give
> >> the impression that it is possible to configure regions independently in
> >> parallel.
> > 
> > One interface per region means the regions could be independently
> > reprogrammed, i.e. reprogramming of one region won't affect the working
> > of another region. But they don't have to be reprogrammed in parallel.
> > If it cannot be reprogrammed now, the interface call could fail.
> 
> Good point. However, I still have some other practical concerns. To the
> best of my knowledge, reconfigurable images/bitstreams are statically
> built for a specific reconfigurable region in current FPGA
> implementations. So, what should happen if the user feeds the wrong
> image (e.g., an image targeting another region) into a reconfigurable
> region programming interface? I don't think the fpga manager could and
> should detect these mistakes since the kernel has no visibility of the

I think fpga manager could do something with the helper of HW and image
builder. If the region identifier could be read out from some HW
registers on fpga_region enumeration, and it is also built into the
image header, the fpga manager could check the validity.

Some reprograming engine even enforce the validation by requiring SW
input region identifier along with the image data.

Without the help of HW, I cannot see any SW solution could help, one
interface per region or one interface per engine.

Thanks,
Yilun

