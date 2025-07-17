Return-Path: <linux-fpga+bounces-1287-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34AECB082BA
	for <lists+linux-fpga@lfdr.de>; Thu, 17 Jul 2025 04:04:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0C8018917A9
	for <lists+linux-fpga@lfdr.de>; Thu, 17 Jul 2025 02:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6C571B412A;
	Thu, 17 Jul 2025 02:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kS8ua3OM"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C39D383
	for <linux-fpga@vger.kernel.org>; Thu, 17 Jul 2025 02:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752717876; cv=none; b=RCa4hVrdj2oxXv7iEc9eNgDXTeGHBgxhxnudB641QRbL65ITEfycR7rxbKPp/bdkamxPKACTrGTsBSAOhX3fy5iU/EpUlZh6+Ab24x47oeUTgutInp+aKnkwmkqPSHelHQnmt3ZdHKoFTR2gzE8fPFtDke0IOJ+Pwi20RPU41zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752717876; c=relaxed/simple;
	bh=VyVfya8KeQDitSfeuop+5gjqUyG/MKXBIca0g3EHrNk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fkaYUey7mMiLeRk+WEMLtguV/IapcBKUR5zm02UHRvjiub//zljDPFE/CWaWU7Inm6GRE5BffxSE2WBbXfPhgWmXeUhSfoSw6z8fVYwtOLPbBuURkEp5uqRuBB3lyffafADTycz1ypap4ln+K/HiOQkLazKn6tHWHm+TrMJJYIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kS8ua3OM; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752717875; x=1784253875;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VyVfya8KeQDitSfeuop+5gjqUyG/MKXBIca0g3EHrNk=;
  b=kS8ua3OMDsFZSNu7Kly0Vu37zjFAVczzl8jUz3B8hs38+PmNHoELrUnR
   NrzIOYrCTSL1riL6eXMcM9zxs8rfA5RN8Ikqz935g07cmB3NLgI27Ho9T
   Nj141BbM6ac3kAr8UZVqpQQ/ToWccIMD0ePgC8GOsfI0jSoiiVjjz4VYx
   qnOx2qI//XtiSdHRo6YBxkHIdJfHyFGIahdfllmR3xarivvARypKr2u4+
   1peG/B2LYaac1MouWik0MjzAIDembyoae+BUL1oP85aXfU+hXQbLCBMk2
   RFEk5S7Q8J6/03Nr7CEelEd1RVdM6fVGJ01F4w2upPRhyAsVApR7BY8vi
   w==;
X-CSE-ConnectionGUID: CCU67A3DQuyTWjlsjvsJ3g==
X-CSE-MsgGUID: YNShRvcWQjWL7j8NHl2csA==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="55100069"
X-IronPort-AV: E=Sophos;i="6.16,317,1744095600"; 
   d="scan'208";a="55100069"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2025 19:04:35 -0700
X-CSE-ConnectionGUID: gHlOG6QORxWCz/3++ArslA==
X-CSE-MsgGUID: hFxHmEGOQgeOdNGYAaORsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,317,1744095600"; 
   d="scan'208";a="161971644"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa003.jf.intel.com with ESMTP; 16 Jul 2025 19:04:33 -0700
Date: Thu, 17 Jul 2025 09:55:53 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: yilun.xu@intel.com, linux-fpga@vger.kernel.org, mdf@kernel.org
Subject: Re: [GIT PULL] FPGA Manager changes for 6.16-final
Message-ID: <aHhYKZGYYLh5Brlf@yilunxu-OptiPlex-7050>
References: <aHfYjZ62LMw2VCCU@yilunxu-OptiPlex-7050>
 <2025071619-epic-confined-3bfd@gregkh>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025071619-epic-confined-3bfd@gregkh>

On Wed, Jul 16, 2025 at 07:22:01PM +0200, Greg KH wrote:
> On Thu, Jul 17, 2025 at 12:51:25AM +0800, Xu Yilun wrote:
> > The following changes since commit 19272b37aa4f83ca52bdf9c16d5d81bdd1354494:
> > 
> >   Linux 6.16-rc1 (2025-06-08 13:44:43 -0700)
> > 
> > are available in the Git repository at:
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/fpga/linux-fpga tags/fpga-for-6.16-final
> > 
> > for you to fetch changes up to 1c6a132cb30909aba5b37ffc1739f3c288330603:
> > 
> >   MAINTAINERS: Update FPGA MANAGER maintainer (2025-07-12 02:52:40 +0800)
> > 
> > ----------------------------------------------------------------
> > FPGA Manager changes for 6.16-final
> > 
> > - FPGA DFL DRIVERS Maintainer change from Wu Hao to Yilun
> > 
> > All patches have been reviewed on the mailing list, and have been in the
> > last linux-next releases (as part of our fixes branch)
> > 
> > Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> > 
> > ----------------------------------------------------------------
> > Xu Yilun (1):
> >       MAINTAINERS: Update FPGA MANAGER maintainer
> > 
> >  MAINTAINERS | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> I already took this in my -next branch, any reason it has to be in
> 6.16-final?

No strong reason. Going to -next is good to me.

Thanks,
Yilun

> 
> thanks,
> 
> greg k-h

