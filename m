Return-Path: <linux-fpga+bounces-1226-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F69DAC0316
	for <lists+linux-fpga@lfdr.de>; Thu, 22 May 2025 05:41:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DABC4E4017
	for <lists+linux-fpga@lfdr.de>; Thu, 22 May 2025 03:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 473BD1758B;
	Thu, 22 May 2025 03:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GhrEOfZi"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB4BC2EF
	for <linux-fpga@vger.kernel.org>; Thu, 22 May 2025 03:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747885305; cv=none; b=Rchr/OAS6GCUyVzMvRxb9nPSq6a53CjWciTwMfCZjRvRXph3bSTpyCUmvdfRItWJL0vksf0Iae6HCvIdcLbbVGjiRI3QkqFPstTaRZG26trp94htazHjMXP1GP464xGBsQjiz1BOosd2jv5KX2/MO0Cx8Iest34a+SoWPePKO6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747885305; c=relaxed/simple;
	bh=3so9oONFTycEqq8evQLwgNSUOUcMgYZxPh3ha6/QruQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dlmxH0FD/cnrg7gkoc4UtMlVHgX+aM3kRLDnldh7AZcGpj2MHGcwt9QXNGgzXI0xvEaIYt8qvnq4akk2pPw+jnBmW2sE3NiFhxAO0EIRQCKXXwQalOhBIy4CLTMr76hSj6R2fx5CS8kanz3d9t53LZbvuNNNzzZfeu0XVO7+TNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GhrEOfZi; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747885303; x=1779421303;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3so9oONFTycEqq8evQLwgNSUOUcMgYZxPh3ha6/QruQ=;
  b=GhrEOfZias32l6lmiaqYTsU9u5yyVoaXygKt+L2Frj5o3VOAsScZHpt/
   XKo6bTnXwcjyv4w7wbv+niL+oQhnXbbH3TW83H27c8zDyUhft2QW3qa1F
   5J48XJsq3l+q/xYfu1WrcJU3RWwVyuKwQKDIfU+vWwVOxy4O2ROaj61yP
   30HCBIQ9ROZRUMeMjSt7pQbLr1tyT4uE4+e/uULb1rs4isAE04B1jyihe
   okL31afwbvuJlPq862fWRYH0HP/7MsJEc1URZ6ZlHXP+eTTsduXENIQrf
   cp2YLNN8Nr5TgF0kZ5fFVjPfB8WvH8Cd1nfxfO7B4RclWW8tVhLSNacfP
   Q==;
X-CSE-ConnectionGUID: UVMAsGOBSRaf8XwFqNZ1lg==
X-CSE-MsgGUID: McU8DXYsTtCTWf3YaSV+sA==
X-IronPort-AV: E=McAfee;i="6700,10204,11440"; a="49767687"
X-IronPort-AV: E=Sophos;i="6.15,305,1739865600"; 
   d="scan'208";a="49767687"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2025 20:41:43 -0700
X-CSE-ConnectionGUID: 5ApnH5YCRIeVp56h780oJA==
X-CSE-MsgGUID: +dXRMyeLQqiD5HbT7IJqrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,305,1739865600"; 
   d="scan'208";a="140278191"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa006.fm.intel.com with ESMTP; 21 May 2025 20:41:42 -0700
Date: Thu, 22 May 2025 11:35:44 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: yilun.xu@intel.com, linux-fpga@vger.kernel.org, mdf@kernel.org
Subject: Re: [GIT PULL] FPGA Manager changes for 6.16-rc1
Message-ID: <aC6bkIgiTi45JqWe@yilunxu-OptiPlex-7050>
References: <aCDPz42LmQ47ANDX@yilunxu-OptiPlex-7050>
 <2025052115-lance-punctured-578b@gregkh>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025052115-lance-punctured-578b@gregkh>

On Wed, May 21, 2025 at 02:10:02PM +0200, Greg KH wrote:
> On Mon, May 12, 2025 at 12:26:55AM +0800, Xu Yilun wrote:
> > The following changes since commit 0af2f6be1b4281385b618cb86ad946eded089ac8:
> > 
> >   Linux 6.15-rc1 (2025-04-06 13:11:33 -0700)
> > 
> > are available in the Git repository at:
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/fpga/linux-fpga tags/fpga-for-6.16-rc1
> 
> I've taken this but for some reason you have a commit in here with a
> Fixes: tag but no cc: stable line, which means it will not be
> automatically picked up for any stable backports :(

mm.. This is for Kunit test and it fixes a potential problem... I.e. I
think it may not be for stable kernel according to
stable-kernel-rules.rst

> 
> Please notify the stable team when it hits a release so that they can be
> sure to include it properly where needed.  And in the future, be more
> careful.

Yes. And if it really needs to be a stable kernel patch, I'll keep the
rule in my mind.

Thanks,
Yilun

> 
> thanks,
> 
> greg k-h

