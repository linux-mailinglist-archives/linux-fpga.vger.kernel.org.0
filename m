Return-Path: <linux-fpga+bounces-544-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56DBD908198
	for <lists+linux-fpga@lfdr.de>; Fri, 14 Jun 2024 04:27:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DEB07B21527
	for <lists+linux-fpga@lfdr.de>; Fri, 14 Jun 2024 02:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0C3B1448D8;
	Fri, 14 Jun 2024 02:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nef0P9Jz"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035D7811E0;
	Fri, 14 Jun 2024 02:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718332067; cv=none; b=cTwDodTg5uMSS2pGS6MYrLKKgVM7taL3mJMCjM0s6iRsN+OSAlaYTEC1UwD+fZEFTF/DDjn4V2o6y287CA8m4dFIsejRCfhJ/Rhl4i1mpvrHMBbjjCQsRBFWYnmOCFja/gN15Uof1UXEobRUMcDqWfH6/9vFAUUWNCSYiRLPtqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718332067; c=relaxed/simple;
	bh=TXXVNjzYH9dxXvW19XQWjL2z6vcfgWTA8Sc5YpQH4UY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oxQozxo0kEMB1cs2goV9l2B1uK+xEL8I7+LzcT3aC+8o+dM0+ugnjylcVCuLeIS9W9/rx9q+DnA+hjnETQoIBZXtJjRzH8EMpVuKXjYPHZQ//C9nc51SXcZU00TitEoscumWQNk58CEVQ6r/tL99/n8fId6/A1vtURSP9LIQTUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nef0P9Jz; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718332066; x=1749868066;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TXXVNjzYH9dxXvW19XQWjL2z6vcfgWTA8Sc5YpQH4UY=;
  b=nef0P9JzeRqcRcdSHTZyAMJDNZHvuAd3jHAtcTi/UkF3oGDFP3PPHgm1
   XJVxRY/8+OOABbZYKtk74PErplv+S4AWzMYZZV1pC39kjM1SJnixIuqg4
   2Wdjv7OZ8/q0qmVIo/ONAHIMaU+YS1U0/DYdfhvEveD4dDwfD3vZPijGC
   DVxIJ2cXb5+yGzFq5d3aTPstJp8e+P2ROGOlo/Z/X00SJNq6i8HTMAGi6
   enDLZpL5r9Dt+G/LKsYAru7vhuX+ctV9DVw5bMcV3MKlDc+4+61q6Fb0J
   gekh7Gt9Ff7v8e6Q0mStxBFRgUR/DG9vZ8oYkpNYp3yaHmr616cWIg0eo
   A==;
X-CSE-ConnectionGUID: qXIwkCUqTSy053c6//a5fg==
X-CSE-MsgGUID: rKGpTxE9RwyqKSw6yuLatg==
X-IronPort-AV: E=McAfee;i="6700,10204,11102"; a="18125318"
X-IronPort-AV: E=Sophos;i="6.08,236,1712646000"; 
   d="scan'208";a="18125318"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2024 19:27:45 -0700
X-CSE-ConnectionGUID: 0XX4DzhhQv+r0wAZaaJX7A==
X-CSE-MsgGUID: MtHgo/43RZKk9/rQmraiXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,236,1712646000"; 
   d="scan'208";a="44874865"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa004.fm.intel.com with ESMTP; 13 Jun 2024 19:27:44 -0700
Date: Fri, 14 Jun 2024 10:21:11 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: "Dr. David Alan Gilbert" <linux@treblig.org>
Cc: mdf@kernel.org, hao.wu@intel.com, linux-fpga@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fpga: altera-fpga2sdram: remove unused struct 'prop_map'
Message-ID: <ZmupF3dsgkSYPRN/@yilunxu-OptiPlex-7050>
References: <20240530205245.125513-1-linux@treblig.org>
 <ZmgH3FakPP2w/ksI@yilunxu-OptiPlex-7050>
 <Zmgp01iGuYb-hHLK@gallifrey>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zmgp01iGuYb-hHLK@gallifrey>

On Tue, Jun 11, 2024 at 10:41:23AM +0000, Dr. David Alan Gilbert wrote:
> * Xu Yilun (yilun.xu@linux.intel.com) wrote:
> > On Thu, May 30, 2024 at 09:52:45PM +0100, linux@treblig.org wrote:
> > > From: "Dr. David Alan Gilbert" <linux@treblig.org>
> > 
> > This is only needed if the person sending the patch is not the author.
> > 
> > > 
> > > 'prop_map' has been unused since the original
> > > commit e5f8efa5c8bf ("ARM: socfpga: fpga bridge driver support").
> > 
> > Please use 'fixes:' tag.
> 
> I've avoided using fixes: on this series because it's not a bug;
> stable and downstream maintainers use Fixes: to indicate that they
> should pick up a patch on top of something they already have; there's
> no need for anyone to backport this.

It's good to me.

Acked-by: Xu Yilun <yilun.xu@intel.com>

Applied to for-next.

