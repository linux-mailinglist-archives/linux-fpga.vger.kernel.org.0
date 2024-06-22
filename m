Return-Path: <linux-fpga+bounces-557-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14CE3913483
	for <lists+linux-fpga@lfdr.de>; Sat, 22 Jun 2024 16:49:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D89A1C2087D
	for <lists+linux-fpga@lfdr.de>; Sat, 22 Jun 2024 14:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A05511E531;
	Sat, 22 Jun 2024 14:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HxhqQYnG"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A781E4A2;
	Sat, 22 Jun 2024 14:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719067753; cv=none; b=W4JaVCFhCLp1F+Rpkm+TC5DyjzRSwGBUaWFxll02rXdoR5B0tIFgXZaBcb+Olqx6u+F49u6MWnzjtidx8yYLP52LlZm4MkYdqcOKROkxpSbsqjrrr/PFElfYlicYwN0Z1MxGr05rpauBt+vne23s7FoXyR82Op9O/OGLl5bxBtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719067753; c=relaxed/simple;
	bh=y4CRsLfS3bCjR+ZqugYctGjnywHt8Ket7b7tsZWmclQ=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W6os+twylx4O/nVjChFH8LBZ993ulX53niB48vHuE6V/2lQt4oFnrDhNmONLf6x0kH1R3jmtegNmQT1qz3ycRug9GpUhYg5GPRBAniUGSNZGUNxaOZDPOBfT9oxoSQF3twavWnQzp4MtebbF4RQtiVkkastlW8pWk1+mJqgGRS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HxhqQYnG; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719067753; x=1750603753;
  h=date:from:to:subject:message-id:references:mime-version:
   in-reply-to;
  bh=y4CRsLfS3bCjR+ZqugYctGjnywHt8Ket7b7tsZWmclQ=;
  b=HxhqQYnGXTXJk4iXgtnjDgCONgJh6JVAUQz145fCgTisN5CJsjnOTlra
   AwI7fyaxHwm1Yu/gZCB90mKJw8DADCJwlcR2m1UFokwwnxtUFKi3wm2/k
   0eAWD6Qgo3BhbMwvofElnIAUmgzIsMe4/9ICwoagDJoVEgslnPCvPqtmF
   P8JvnDSR+R7adkywl8U5XHBjby0j5HcYS2fuyoOcxBHhIYnKamdniVUtL
   dk/uvB7QGzk6SHFyAo3d53SIexVw1bz7Zz2ZceGWiPCC9tnl9xw6yndwn
   FHd3OqY9TWqxRe4LLSnzGOJd2UhlDjf7MezlSncJ5wsIkVDucc9cLZ1Kf
   w==;
X-CSE-ConnectionGUID: 3By/UQTGQdyQVqqtI1mO3w==
X-CSE-MsgGUID: MzkzfxRESyCFS7VConqq/g==
X-IronPort-AV: E=McAfee;i="6700,10204,11111"; a="33551479"
X-IronPort-AV: E=Sophos;i="6.08,257,1712646000"; 
   d="scan'208";a="33551479"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2024 07:49:12 -0700
X-CSE-ConnectionGUID: C1m86aQgRZOrBBhE/yDlBg==
X-CSE-MsgGUID: U4/DciALRny4qpn/eKY5DQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,257,1712646000"; 
   d="scan'208";a="43538156"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa007.jf.intel.com with ESMTP; 22 Jun 2024 07:49:09 -0700
Date: Sat, 22 Jun 2024 22:42:24 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	linux-crypto@vger.kernel.org, Moritz Fischer <mdf@kernel.org>,
	Wu Hao <hao.wu@intel.com>, Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>, linux-fpga@vger.kernel.org
Subject: Re: [PATCH 1/2] fpga: socfpga: use 'time_left' variable with
 wait_for_completion_interruptible_timeout()
Message-ID: <Znbi0OFnT6NQ/lRX@yilunxu-OptiPlex-7050>
References: <20240502210038.11480-1-wsa+renesas@sang-engineering.com>
 <20240502210038.11480-2-wsa+renesas@sang-engineering.com>
 <ZmgGiuu/5Eqxb0uR@yilunxu-OptiPlex-7050>
 <g5xw3icobdq2cuubqzmfvkph5jd3ag7shbxkntnotposuxviis@ewfw2cyc4g7k>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <g5xw3icobdq2cuubqzmfvkph5jd3ag7shbxkntnotposuxviis@ewfw2cyc4g7k>

On Thu, Jun 20, 2024 at 12:21:10PM +0200, Wolfram Sang wrote:
> Hi Yilun,
> 
> > Sorry for late reply.
> 
> No worries, thank you for the review.
> 
> > First of all, please limit your subject/shortlog/summary within 70
> > chars.
> 
> I'll try but it will be hard when it contains such a long function name.

You don't have to include the funtion name. The code change itself
explains.

Thanks,
Yilun

> 
> > > There is a confusing pattern in the kernel to use a variable named 'timeout' to
> > 
> > Please make the changelog line wrapped at less than 75 chars.
> 
> Good point. My scripts reformat generated paragraphs now accordingly.
> 
> > > +	int ret = 0;
> > > +	long time_left;
> > 
> > Please use reverse xmas tree when it is easy to follow.
> 
> Will fix.
> 
> All the best,
> 
>    Wolfram
> 



