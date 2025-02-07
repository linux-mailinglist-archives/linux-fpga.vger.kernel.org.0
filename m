Return-Path: <linux-fpga+bounces-1045-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E36B1A2B8FD
	for <lists+linux-fpga@lfdr.de>; Fri,  7 Feb 2025 03:23:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63ED73A89D6
	for <lists+linux-fpga@lfdr.de>; Fri,  7 Feb 2025 02:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA18D1552F5;
	Fri,  7 Feb 2025 02:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="McRn1hFd"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 360F325771;
	Fri,  7 Feb 2025 02:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738894859; cv=none; b=bwAa8uXbXqsDQJgYrkEOdZWi5kQMvy30KM6dh3qQWR9odoB2U7oKu7kvOZEUxnie97CwnG0QRCvIDqjg2S6ITUWD0oltdy4XlvxtoqzzAirLEvfwa/FbD5mlU+UtgNFL7FcUaHbyMfH+0g8UDSpjIwWzi9LqDLch1520JuEnwqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738894859; c=relaxed/simple;
	bh=Czeax2Q5EkEZzGBpofnMQnmSfLfxZjeH2jXWl4EDQLY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JCOmfjjqLXjbfL0fzNMqlINjgnbC7g7c0l6hjs4rUlRTOs4kSwVi5J0I9dxQB8cfUyV6Tl7AXuV66xV5FwUa2HtiPalpZdl31LbVVeyXfeQ5RJCHvsYLkdGiOyxQ8tyQ8NQK9l6Xtf71iWhD2u9AIgKEcAC7/XjDrHfhQ9GaRZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=McRn1hFd; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738894858; x=1770430858;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Czeax2Q5EkEZzGBpofnMQnmSfLfxZjeH2jXWl4EDQLY=;
  b=McRn1hFdmG9IAnMqPYa0XmvYPPX4r03AfJBTjnsWusRM4VlAmnw6/p7E
   u9kizB82nsl49nr61fx3uI5JAhjKKQD650BFWfDJGCcjnuX5nlmcv4YcP
   pVir0QxMv2wE8H5Zgox2oTxGdEspkMZ/HS5wvBgt4Uq2NEipsOXnMM0fc
   HqXa6483dtzXhqO3PASCSTaMo+t/mP1fuYv/RtlsHgwmtj6cltrF1Qwfm
   87pUWT1o8TXGXAMFfn7MsO8r31sR+vown2iOz9fRC7ECOWleiM8n/zWnL
   fp5bUT5pbdkkpx9hoaAqjFK6UlaIgSd6V3s2urBuIQxExUum2d8D/8NqV
   A==;
X-CSE-ConnectionGUID: lrHooW6SSwe1hW92DN3WsQ==
X-CSE-MsgGUID: kOxutTIsQ3i1gbastzu26g==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="38759296"
X-IronPort-AV: E=Sophos;i="6.13,266,1732608000"; 
   d="scan'208";a="38759296"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2025 18:20:58 -0800
X-CSE-ConnectionGUID: ru6MDZZbSdSJaSxB2cjDpw==
X-CSE-MsgGUID: 3DZsWhxkSyuCngL9+R/flw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,266,1732608000"; 
   d="scan'208";a="116400837"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa004.jf.intel.com with ESMTP; 06 Feb 2025 18:20:55 -0800
Date: Fri, 7 Feb 2025 10:19:59 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Yidong Zhang <yidong.zhang@amd.com>
Cc: linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org,
	mdf@kernel.org, hao.wu@intel.com, yilun.xu@intel.com,
	lizhi.hou@amd.com, DMG Karthik <Karthik.DMG@amd.com>,
	Nishad Saraf <nishads@amd.com>,
	Prapul Krishnamurthy <prapulk@amd.com>,
	Hayden Laccabue <hayden.laccabue@amd.com>
Subject: Re: [PATCH V2 1/4] drivers/fpga/amd: Add new driver amd versal-pci
Message-ID: <Z6Vtz/Bb8wsIH0pG@yilunxu-OptiPlex-7050>
References: <20241210183734.30803-1-yidong.zhang@amd.com>
 <20241210183734.30803-2-yidong.zhang@amd.com>
 <Z5YPWHVmL29zuQNm@yilunxu-OptiPlex-7050>
 <3b520bab-d948-470a-b06f-5494243ebc1a@amd.com>
 <Z6Q3W2mUw/ZbtnWV@yilunxu-OptiPlex-7050>
 <796e2826-a423-4d0c-977a-105ed236e067@amd.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <796e2826-a423-4d0c-977a-105ed236e067@amd.com>

> > No need to detach a specific driver, remove all devices in the
> > fpga-region. I imagine this could also be a generic flow for all PCI/e
> > based FPGA cards.
> 
> I see your point. Is there an existing example in current fpga driver for
> PCI/e based cards?

No. The fpga-region re-enumeration arch is still WIP, so no existing
implementation.

> 
> We will need to talk to our management team and re-design our driver.
> I think we have 2 approaches:
> 1) Align with linux fpga, having one driver for both userPF and mgmtPF; or

Don't get you. Linux FPGA doesn't require one driver for both PFs.

> 2) find a different location (maybe driver/misc) for the version-pci driver,
> because it is an utility driver, not need to be tied with fpga framework.

I'm not the misc maintainer, but I assume in-tree utility driver +
out-of-tree client driver is not generally welcomed.

Thanks,
Yilun

> 
> Please let me know you thoughts. Which way is acceptable by you.
> 
> Thanks,
> David
> > 
> > Thanks,
> > Yilun
> > 
> > > driver and allow the userPF driver re-enumerate all to match the new
> > > hardware.
> > > 
> > > I think my understanding is correct, it is doable.
> > > 
> > > As long as we can keep our userPF driver as separate driver, the code change
> > > won't be too big.
> > > 
> > > > 
> > > > Thanks,
> > > > Yilun

