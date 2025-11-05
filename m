Return-Path: <linux-fpga+bounces-1423-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BD2DC36082
	for <lists+linux-fpga@lfdr.de>; Wed, 05 Nov 2025 15:23:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 227C41885C40
	for <lists+linux-fpga@lfdr.de>; Wed,  5 Nov 2025 14:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D770F3164A8;
	Wed,  5 Nov 2025 14:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YXjvtFFU"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC75F22D785;
	Wed,  5 Nov 2025 14:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762352577; cv=none; b=K9dkWW/SFzJXmLJeu9KL38Daz1lzM7Ld/Fq1Xezp1khyqcmvi3a7rkWO+F4i8vCDZ7ocLSXHlE7ldBRdj1mnllBVKwLYbmQR4TDtiYnKArcS3W9VvFIG1JfJop0u6Ia0hYgC1ZVa2/E/YxKPEE03ZWgyxDFDWN3J5wYIcUHEWm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762352577; c=relaxed/simple;
	bh=lHz30B4VkxkIiT9h7xSUpmJpe3w9gt1OrxbGcakIO5I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kVgKtpxqMMrC8LDRDXvRVD7SPlQmsgYEx/KLy5tA3z8FLgqyp3Zt3TRC1HcQKH3YcR27B2tVYfe3MGM43eQsWtuunrkJSWvqJy/8+bVBete8+3+Y0nE9l0TInigcuBjMtU+EVv7IZqvXX2qj/F2z/LdgtWNweSUOUIxt9R5Om9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YXjvtFFU; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762352576; x=1793888576;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lHz30B4VkxkIiT9h7xSUpmJpe3w9gt1OrxbGcakIO5I=;
  b=YXjvtFFUuoLT/oo+1d89UerTOTf2AcVQXEZFxW/Jwd5YshfCN3IAeLsT
   KLOGWFoaCWpsZaCHroIu6gzK7VLnxObaTXBvNqY9QCVL8UTNvWBQ7BrOW
   WS3FiKBdrp05d9OWkQx+4ZExvxD/yruW/wXgdg9xe/MeOfUghcCYlP7fA
   pWHCiHkZkMbzwQMznMXqJiMfTpKtD07N9pgenFUEjq2DKg8F5sEnt1DFE
   gOz3cnh2p2LSUyW3ic0xS2D2gUyUmksezYGMhO7fMUK8+aoe0al9nPJ+G
   /T5rVjsX8MCpGrHTy3t4PC1Uf87kaHib89sVq0SOf/TSZl0mNk/AadiUb
   w==;
X-CSE-ConnectionGUID: JBThAsgmTuyghj4uEeJZJg==
X-CSE-MsgGUID: E/pl49APS82lB1qQHrrdww==
X-IronPort-AV: E=McAfee;i="6800,10657,11603"; a="89928475"
X-IronPort-AV: E=Sophos;i="6.19,282,1754982000"; 
   d="scan'208";a="89928475"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2025 06:22:55 -0800
X-CSE-ConnectionGUID: 6r64+RsHTBS5Ayw86mbvFQ==
X-CSE-MsgGUID: SpRR8Hf6RiCs4KQlhF8YoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,282,1754982000"; 
   d="scan'208";a="186755002"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa010.jf.intel.com with ESMTP; 05 Nov 2025 06:22:53 -0800
Date: Wed, 5 Nov 2025 22:08:45 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Ian Abbott <abbotti@mev.co.uk>
Cc: linux-fpga@vger.kernel.org, Moritz Fischer <mdf@kernel.org>,
	Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] fpga: Add dummy definitions of API functions
Message-ID: <aQtabTZ16CN1pmMl@yilunxu-OptiPlex-7050>
References: <20251104153013.154463-1-abbotti@mev.co.uk>
 <aQqsnFl8uakMAsH+@yilunxu-OptiPlex-7050>
 <22148db9-3579-4298-b641-91cc98dc1c5c@mev.co.uk>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22148db9-3579-4298-b641-91cc98dc1c5c@mev.co.uk>

On Wed, Nov 05, 2025 at 10:37:39AM +0000, Ian Abbott wrote:
> On 2025-11-05 01:47, Xu Yilun wrote:
> > On Tue, Nov 04, 2025 at 03:27:01PM +0000, Ian Abbott wrote:
> > > Add dummy definitions of the FPGA API functions for build testing
> > > 
> > > 1) fpga: altera-pr-ip: Add dummy definitions of API functions
> > > 2) fpga: bridge: Add dummy definitions of API functions
> > > 3) fpga: manager: Add dummy definitions of API functions
> > > 4) fpga: region: Add dummy definitions of API functions
> > 
> > Sorry I don't get the idea. Why should someone use FPGA APIs without
> > selecting CONIG_FPGA_XXX? Better make the changes along with the use
> > case patches.
> 
> Projects using FPGAs often have custom devices with custom, out-of-tree
> drivers, so it's quite useful to be able to build test those drivers against
> later kernel versions on the host to keep up with kernel API drift, prior to

But why don't you select the FPGA options on your "later kernel"? I
don't see much benifit for not doing so. Finally you still need
runtime test for new kernel adoption which requires selecting these
FPGA options.

And the problem for these stubs is, real users lose the chance to find
config error at earlier stage.

> possible later adoption of the kernel version on the target.
> 
> > Thanks,
> > Yilun
> > 
> > > 
> > >   include/linux/fpga/altera-pr-ip-core.h |  8 ++-
> > >   include/linux/fpga/fpga-bridge.h       | 75 ++++++++++++++++++++++++++-
> > >   include/linux/fpga/fpga-mgr.h          | 95 +++++++++++++++++++++++++++++++---
> > >   include/linux/fpga/fpga-region.h       | 44 ++++++++++++++--
> > >   4 files changed, 207 insertions(+), 15 deletions(-)
> However, I messed up the patches, because I only built them without the FPGA
> configure options defined.  I plan to submit a v2 patch series unless it is
> deemed a complete waste of effort by the maintainers.

Sorry, for now it still seems unnecessary to me.

Thanks,
Yilun

> 
> Cheers,
> Ian
> -- 
> -=( Ian Abbott <abbotti@mev.co.uk> || MEV Ltd. is a company  )=-
> -=( registered in England & Wales.  Regd. number: 02862268.  )=-
> -=( Regd. addr.: S11 & 12 Building 67, Europa Business Park, )=-
> -=( Bird Hall Lane, STOCKPORT, SK3 0XA, UK. || www.mev.co.uk )=-
> 

