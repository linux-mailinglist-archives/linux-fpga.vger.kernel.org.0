Return-Path: <linux-fpga+bounces-1433-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D204C4267F
	for <lists+linux-fpga@lfdr.de>; Sat, 08 Nov 2025 05:16:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 468441891101
	for <lists+linux-fpga@lfdr.de>; Sat,  8 Nov 2025 04:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D491221544;
	Sat,  8 Nov 2025 04:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F01qHcOo"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D493F213E89;
	Sat,  8 Nov 2025 04:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762575374; cv=none; b=dOP1FZlC/+0McgQcfoEMzLfg82aRZeUh8HiYLGGwGlteYAbk7uh9NMeQSvtx8g6rOk9e1shLS4sFN2avMIQmEvNi1SiQdSKRIeIlhg+3EFb8dg8pC3MupecYE3bZZfbKwL1T/bfmXYAhBms2pFziLpQTg26/sMjOPBPizpcnaeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762575374; c=relaxed/simple;
	bh=ibDCRmOwG1IVBD7kY3t3GP9ad89w/MYSwp2rwzL/tz4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lGJu7sd+r088tHkd0HA++tWXahBXxUKiAhlaJh2hZl1+kGmjg5m5N8Sip8N7OeYZIgsXjYw+WsYLVxV2HSS50uc5GMrwyP0SL1abBvcmPlBDsC1dJXQDH6iPTfiYSD/rekgfDXghP9xWBAJuZAmUcuzf7gylUpBckl5wMMidQAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F01qHcOo; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762575373; x=1794111373;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=ibDCRmOwG1IVBD7kY3t3GP9ad89w/MYSwp2rwzL/tz4=;
  b=F01qHcOohtgwMvaj+t/EvQC7AIIk5oICoUkJJDA9WgYolHJF6XZc1TiY
   5Qk8dfCMqWPa6yPasKQ4TtYkWfJZl7EYcWwm2unTT+bt09wQQ0T1oY7sH
   rByfJ2qCy3ZVqNAM2mX9yiDvt0/2LBfkfWA/QyRsRtU2fG/TjrvolanZk
   0/V/JFB6/Q3g/SbQVivb3PG6h4GWX8c9Ua+uCynFxZ6MOwIsm3pA8ahE4
   Hn68vZKRIapI98I6YS9EHAS9xsZB5qeC37D+M/L1IMPMTFNq/RLlcQnTC
   fJy12j+gQ4bBiE3JRXfyTshL8QV8JDA0zCLNjzjE8wgjmhKywNbVy5gbs
   w==;
X-CSE-ConnectionGUID: 4gZpf0FBQUeGisIVCpQhPw==
X-CSE-MsgGUID: xZvHAdtVQHCadkiaYNgxYA==
X-IronPort-AV: E=McAfee;i="6800,10657,11606"; a="64638348"
X-IronPort-AV: E=Sophos;i="6.19,288,1754982000"; 
   d="scan'208";a="64638348"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2025 20:16:12 -0800
X-CSE-ConnectionGUID: o5CHm+RNTrO21N6oKEKwDg==
X-CSE-MsgGUID: Mb7l+uO2T3m1KfIFOpCWPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,288,1754982000"; 
   d="scan'208";a="225462129"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa001.jf.intel.com with ESMTP; 07 Nov 2025 20:16:11 -0800
Date: Sat, 8 Nov 2025 12:01:55 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-fpga@vger.kernel.org, Moritz Fischer <mdf@kernel.org>,
	Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] fpga: stratix10-soc: add COMPILE_TEST support
Message-ID: <aQ7As9KVG+5Dn5FB@yilunxu-OptiPlex-7050>
References: <20251106185938.6419-1-rosenp@gmail.com>
 <20251106185938.6419-3-rosenp@gmail.com>
 <aQ2csK4TtTOFmyLj@yilunxu-OptiPlex-7050>
 <CAKxU2N8QHoQxb0ddUtMTtK6psL4gPPGSTwTf5X=7py22GXxkrw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKxU2N8QHoQxb0ddUtMTtK6psL4gPPGSTwTf5X=7py22GXxkrw@mail.gmail.com>

On Fri, Nov 07, 2025 at 11:28:03AM -0800, Rosen Penev wrote:
> On Thu, Nov 6, 2025 at 11:30 PM Xu Yilun <yilun.xu@linux.intel.com> wrote:
> >
> > On Thu, Nov 06, 2025 at 10:59:38AM -0800, Rosen Penev wrote:
> > > Allow the buildbots to find compilation issues.
> > >
> > > Signed-off-by: Rosen Penev <rosenp@gmail.com>
> > > ---
> > >  drivers/fpga/Kconfig | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
> > > index 311313f3b282..f2e2776acdd5 100644
> > > --- a/drivers/fpga/Kconfig
> > > +++ b/drivers/fpga/Kconfig
> > > @@ -60,7 +60,7 @@ config FPGA_MGR_ZYNQ_FPGA
> > >
> > >  config FPGA_MGR_STRATIX10_SOC
> > >       tristate "Intel Stratix10 SoC FPGA Manager"
> > > -     depends on (ARCH_INTEL_SOCFPGA && INTEL_STRATIX10_SERVICE)
> > > +     depends on (ARCH_INTEL_SOCFPGA && INTEL_STRATIX10_SERVICE) || COMPILE_TEST
> >
> > I don't think it works without INTEL_STRATIX10_SERVICE, maybe:
> >
> >         depends on ARCH_INTEL_SOCFPGA || COMPILE_TEST
> >         depends on INTEL_STRATIX10_SERVICE
> >
> > But INTEL_STRATIX10_SERVICE depends on HAVE_ARM_SMCCC, and they all
> > require arch configurations...
> Yeah I don't think INTEL_STRATIX10_SERVICE is needed for COMPILE_TEST.

Have you actually passed compilation without INTEL_STRATIX10_SERVICE?
I can't image how it works without stratix10_svc_xx kAPI definitions.

> >
> > >       help
> > >         FPGA manager driver support for the Intel Stratix10 SoC.
> > >
> > > --
> > > 2.51.2
> > >
> > >

