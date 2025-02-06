Return-Path: <linux-fpga+bounces-1041-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF278A2A0B5
	for <lists+linux-fpga@lfdr.de>; Thu,  6 Feb 2025 07:07:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBEA23A84E0
	for <lists+linux-fpga@lfdr.de>; Thu,  6 Feb 2025 06:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26E4C224893;
	Thu,  6 Feb 2025 06:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f6o3wCtQ"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50BAB22370D;
	Thu,  6 Feb 2025 06:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738821947; cv=none; b=k9lzbjKDPxzT6c+1ia5j7MaTAXtHdSVhe2ZdP/IUjrdM9OqhmqVVcM/aJ75fD/Y9gaH1k8wNDVGBbnvmKyu6caZ5oK/QGn9mPCNRDdf7lkAdaifCUcz04NkETKu4HY+6gZohkU7RjOVzZSIf10+R1uFbSrQB01vPJAuXHHZWC/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738821947; c=relaxed/simple;
	bh=ncXxcvgdUa5DjwY3qx7h1Jbj3YQk22S0tZsM/G1hMds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LS7YrjYEDk6pAeNDYMW7eDxGFhYIYI+aAAEFgY5f8OBdcJ1a+P8AuUJRWo21Ij8wxhBP7aqUGDoBKuwwTxdKT6FWyMETAvrX5/X7m8EmQ7rwbx262z5jBDk2KlwJNy1ufIwzB+jvIKarg1QGPdmEMAVeGwJQRmsFKYTXpKGShO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f6o3wCtQ; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738821946; x=1770357946;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ncXxcvgdUa5DjwY3qx7h1Jbj3YQk22S0tZsM/G1hMds=;
  b=f6o3wCtQjHOjCwFCSqGhpUYBb/wr6UkHgH0Azy09gPhAs7F1A0zS5ST4
   hLgjyHLvWX8GTSrDHFqAwNy7hQozBT/TAs69GSKYFj150ZKSsjYUAlBOO
   izfGIPF0LREey6WMumZysF795SgBh76oSkLv0q6s1cVrMJZsXnPLGbvLf
   imEGYvKuvQu1vlNkB6WLak9gMWkf+jXObCN7qKTxt4i7KUN3KU65R7QQu
   /fHZz51/p1P+87RH3gy8Jj4Rn3DI5UW9unpMKnQzh8MeAyOXRaMiBi0og
   l848HHtXX8BmV/fwIk5zgWuSfcRtI5lkLIcwrY8DVb1YOLa/9kC0WZtsW
   w==;
X-CSE-ConnectionGUID: nXzfySC3QG6f+xPxSfa3Ww==
X-CSE-MsgGUID: LZbNVdcUThSWsRMhlAYvwg==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="39543965"
X-IronPort-AV: E=Sophos;i="6.13,263,1732608000"; 
   d="scan'208";a="39543965"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2025 22:05:45 -0800
X-CSE-ConnectionGUID: Cn3VOvX9TAOlWmjEIqCSXg==
X-CSE-MsgGUID: LPqCElsjTI+VafDokhy3VA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,263,1732608000"; 
   d="scan'208";a="111646767"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa010.fm.intel.com with ESMTP; 05 Feb 2025 22:05:42 -0800
Date: Thu, 6 Feb 2025 14:04:49 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Marco Pagani <marco.pagani@linux.dev>
Cc: Nava kishore Manne <nava.kishore.manne@amd.com>, git@amd.com,
	mdf@kernel.org, hao.wu@intel.com, yilun.xu@intel.com,
	trix@redhat.com, robh@kernel.org, saravanak@google.com,
	linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [RFC v2 1/1] fpga-region: Add generic IOCTL interface for
 runtime FPGA programming
Message-ID: <Z6RRAXocxWHsZZLF@yilunxu-OptiPlex-7050>
References: <20241029091734.3288005-1-nava.kishore.manne@amd.com>
 <20241029091734.3288005-2-nava.kishore.manne@amd.com>
 <ZzwQrYeWVF6cRtgA@yilunxu-OptiPlex-7050>
 <9bfaf1cf-3313-4cb3-9963-2b4bad2d3165@redhat.com>
 <Z0fIiQPCS69O2d/n@yilunxu-OptiPlex-7050>
 <00e5c1c1-a98e-4360-b7e5-ffaa384e1036@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00e5c1c1-a98e-4360-b7e5-ffaa384e1036@linux.dev>

> >> I'm currently working on an RFC to propose a rework of the fpga
> >> subsystem in order to make it more aligned with the device model. One of
> >> the ideas I'm experimenting with is having a bus (struct bus_type) for
> >> fpga regions (devices) so that we can have region drivers that could
> >> handle internal device enumeration/management whenever a new region is
> >> configured on the fabric. Does this make sense in your opinions?
> > 
> > mm.. I didn't fully understand the need to have a region driver, what's
> > the issue to solve?
> > 
> 
> Sorry for the late reply. The general idea is to handle regions in a way
> that is more aligned with the device model without having to resort to
> extra ops and additional devices.
> 
> Having an fpga bus would allow us to handle enumeration using proper
> region drivers (in the device model sense of the term, i.e., struct
> device_driver) instead of derived region devices.
> 
> On second thought, I think having a reconfiguration interface at the
> fpga manager level is sounder than having it at the region level (one
> for each region).

I don't think so. A firmware image may contain enumeration info, e.g.
of-fpga-region. And I think the fpga-region should parse these
enumeration info rather than fpga manager. fpga manager should only deal
with content writing stuff and not be exposed to user.

> 
> With that in place, the fpga manager could request a firmware image,
> parse it, write the content into the fpga configuration memory, and then
> instantiate the region devices and add them to its fpga bus. Then, if

I think an fpga-region is always there no matter it is cleared, being
reprogrammed, or working. So I don't think an fpga-region needs to be
re-instantated. The sub devices inside fpga-region needs
re-instantating. That's also why I'm hesitating to fpga bus.

Thanks,
Yilun

> there is a match, a specific region driver can handle the enumeration
> within the new region.
> 
> What do you think?
> 
> Thanks,
> Marco
> 

