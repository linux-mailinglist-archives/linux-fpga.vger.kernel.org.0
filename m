Return-Path: <linux-fpga+bounces-792-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D14C59A58C9
	for <lists+linux-fpga@lfdr.de>; Mon, 21 Oct 2024 04:13:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55C1CB22050
	for <lists+linux-fpga@lfdr.de>; Mon, 21 Oct 2024 02:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DCC918054;
	Mon, 21 Oct 2024 02:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jI+f4NyB"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F2559463;
	Mon, 21 Oct 2024 02:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729476831; cv=none; b=POioKR02e+6vcgE8KMtGkM/nwCYR0rnM1n7+WPKsqcL+DE8eKwJvYaP5/b5Iec8Op4lViNUAMMvaki9g4eeGJNy2GMv0AV1QW9HB8nGZLDy7EBs5Bb3owg9BBE6DdcYrXx7vpSOqjkspyMOQ0m4eWATmt/WybGeRyLq/VsNcOaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729476831; c=relaxed/simple;
	bh=OD4AAsexjTR3I9ceqkNhqpfWXaWDnOkq4ZfOj6GH2qY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rrvFsLMtP4ZdcMmTxbfYRBAu61kmzCiiSrCt0n+W14P8Se0U4Wk4IiCaJSZ4sT7HzTgdvsBt+i1R+lLT32chszPsTG2HK933GJC9WcDKGl6cFotftr0TBRs4awuNWWdOvqwMLfado3+Zhv3vioIOALAA0J1m6DoP7XEv0V1bbk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jI+f4NyB; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729476829; x=1761012829;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OD4AAsexjTR3I9ceqkNhqpfWXaWDnOkq4ZfOj6GH2qY=;
  b=jI+f4NyBOGQ7kQwj6O0i1eb2KDAb2Pr2GEN4ZuxORF5Zo8bNsEcXlj1A
   8A1V5wr3nz02uHT0ZNdXCIXGfxpT+CSyw0b5aCjn8msNd4YhxkOfnkIfL
   wqeeJvNN9p6muJANeo7vtF8jVEeQDyiqvMl24BLDV4PTvQaSlao0YWL18
   BvyPqZU6ZAsq9JcVIllr/od1Be+EIF+hofZsskenfmHjpWAyCqs+4IaP4
   mDIyI9uHU4nJhZQOFWiJuzkwsVbCtVRfgNxgX9HdHvezJze0sGA1VEqYL
   Ghqt45o4KDkCQibiBLMt26Ke7QTnTq3XXD4KwL4a4sVBw+K5QzeiNAR8J
   w==;
X-CSE-ConnectionGUID: WvTRQdCQQeKCDF9q6EwfsQ==
X-CSE-MsgGUID: Njme4jUGQ5i90Eyum6P9iA==
X-IronPort-AV: E=McAfee;i="6700,10204,11231"; a="31807334"
X-IronPort-AV: E=Sophos;i="6.11,219,1725346800"; 
   d="scan'208";a="31807334"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2024 19:13:48 -0700
X-CSE-ConnectionGUID: kUW2hnsjTGi6LSEFDqnBgw==
X-CSE-MsgGUID: 5X1ROblbTPukD38o921Stg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,219,1725346800"; 
   d="scan'208";a="116841266"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa001.jf.intel.com with ESMTP; 20 Oct 2024 19:13:44 -0700
Date: Mon, 21 Oct 2024 10:10:20 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Conor Dooley <conor@kernel.org>
Cc: iansdannapel@gmail.com, mdf@kernel.org, hao.wu@intel.com,
	yilun.xu@intel.com, trix@redhat.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, neil.armstrong@linaro.org,
	heiko.stuebner@cherry.de, rafal@milecki.pl,
	linus.walleij@linaro.org, linux-fpga@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] fpga: Add Efinix Trion & Titanium serial SPI
 programming driver
Message-ID: <ZxW4DJOES77ifOC9@yilunxu-OptiPlex-7050>
References: <20240927141445.157234-1-iansdannapel@gmail.com>
 <ZxG70kzjsvT3UBlQ@yilunxu-OptiPlex-7050>
 <20241018-chump-juvenile-dc368d3d2f2c@spud>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241018-chump-juvenile-dc368d3d2f2c@spud>

On Fri, Oct 18, 2024 at 05:58:44PM +0100, Conor Dooley wrote:
> On Fri, Oct 18, 2024 at 09:37:22AM +0800, Xu Yilun wrote:
> > On Fri, Sep 27, 2024 at 04:14:42PM +0200, iansdannapel@gmail.com wrote:
> > > From: Ian Dannapel <iansdannapel@gmail.com>
> > > 
> > > Add a new driver for loading binary firmware to volatile
> > > configuration RAM using "SPI passive programming" on Efinix FPGAs.
> > > 
> > > Signed-off-by: Ian Dannapel <iansdannapel@gmail.com>
> > > ---
> > >  drivers/fpga/Kconfig                    |  10 ++
> > >  drivers/fpga/Makefile                   |   1 +
> > >  drivers/fpga/efinix-trion-spi-passive.c | 211 ++++++++++++++++++++++++
> > >  3 files changed, 222 insertions(+)
> > >  create mode 100644 drivers/fpga/efinix-trion-spi-passive.c
> > > 
> > > diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
> > > index 37b35f58f0df..eb1e44c4e3e0 100644
> > > --- a/drivers/fpga/Kconfig
> > > +++ b/drivers/fpga/Kconfig
> > > @@ -83,6 +83,16 @@ config FPGA_MGR_XILINX_SPI
> > >  	  FPGA manager driver support for Xilinx FPGA configuration
> > >  	  over slave serial interface.
> > >  
> > > +config FPGA_MGR_EFINIX_SPI
> > > +	tristate "Efinix FPGA configuration over SPI passive"
> > > +	depends on SPI
> > > +	help
> > > +	  This option enables support for the FPGA manager driver to
> > > +	  configure Efinix Trion and Titanium Series FPGAs over SPI
> > > +	  using passive serial mode.
> > > +	  Warning: Do not activate this if there are other SPI devices
> > > +	  on the same bus as it might interfere with the transmission.
> > 
> > Sorry, this won't work. As you can see, the conflict usage of CS causes
> > several concerns. Just a text here is far from enough.
> > 
> > You need to actively work with SPI core/controller drivers to find a
> > solution that coordinate the usage of this pin.
> 
> Why does it even impact other SPI devices on the bus? It's not /their/
> CS line that is being modified here, it is the line for the FPGA's
> programming interface, right?
> What am I missing here that makes it any different to any other SPI
> device that may need it's CS toggled?

IIUC, now spi core or controller driver should fully responsible for
HW operations of CS. And every good behaved spi device driver should
declare their logical CS index defined by SPI controller and let SPI
core/controller driver to proxy the CS change.

But if this spi device driver directly aquires CS, it conflicts with
the controller and just fails.

Thanks,
Yilun

> 
> Cheers,
> Conor.



