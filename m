Return-Path: <linux-fpga+bounces-1042-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CFC2FA2A0E0
	for <lists+linux-fpga@lfdr.de>; Thu,  6 Feb 2025 07:24:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D53D918880E7
	for <lists+linux-fpga@lfdr.de>; Thu,  6 Feb 2025 06:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2E1F22489C;
	Thu,  6 Feb 2025 06:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Cay6dfjS"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B68FF17548;
	Thu,  6 Feb 2025 06:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738823053; cv=none; b=MrxAzfSugNf+1zl5mWWqqz5rWbFT9Jdy7AeUfPgNmvL8otAUqNkHDWm2kAJFwxiurI6W4oCbT8c1oia12kkvTwQYeALoPtutv1CrZJE11NrUq2Uy/k5xeygel+21CRnqTiKEjCUjgcZ1qplejBFST1KPNy/N71gp7dWNmqcdqzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738823053; c=relaxed/simple;
	bh=c3wpzPfdqLCGAmYcDTPh2m3lzATJMiwuTyny02HoFmc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iA/5GmG6mFt70KfZMgZNvAdl0/mhFD/AcRN3EY1AMbqmEdVwUpP8VhfNloqU9zhEelvU/dM4go9D+RFPsm71ZZ6JCDun7PRh2b98QGbxK8tYE/wGrpQMyoB0O3xRQ/f6jwck3yCuevVonPJPMYiMteff+7awZjjqX0elAXTUstA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Cay6dfjS; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738823052; x=1770359052;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=c3wpzPfdqLCGAmYcDTPh2m3lzATJMiwuTyny02HoFmc=;
  b=Cay6dfjSJZOPHnrrsepFB7I8MZPtJd5QXrkm9Mk0qp7LVEcNXX5BB/bN
   hlGjtgz7pn8fQ7uXwN7Cl2hy5hDtc+RIfCOkl2fSfQ667q8gQ3e585qw9
   D5JS+q4CL0lzmrWWDjFNaSTsHhg29LrQgBivttKMnzEKUF/QMcwH6BSw7
   yJSWujdRGtycNtQPXTN7W/jQnkii0BlcWAB1od/4gl7FVDD9I8hUkYhhW
   hgmUex5jbSplTbbjOSJSb3lNxFGnjNcnCNO3EB6l5AI5qjP0PqZT+BzMH
   kSSpnTXT890b0omd9+gZoXbknmksp5v6E2iUjfRqc9a8A1OjIlySySOLL
   A==;
X-CSE-ConnectionGUID: 37PGi6FHT+a3XeCXWfY6BQ==
X-CSE-MsgGUID: AO19pTADTbqEDGuiB/FPMA==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="39110549"
X-IronPort-AV: E=Sophos;i="6.13,263,1732608000"; 
   d="scan'208";a="39110549"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2025 22:24:12 -0800
X-CSE-ConnectionGUID: rd/jEDFqR0m1qcxUNxGE/w==
X-CSE-MsgGUID: 9rBTEl1NTLmbjbzGj348cQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,263,1732608000"; 
   d="scan'208";a="116150366"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa004.fm.intel.com with ESMTP; 05 Feb 2025 22:24:08 -0800
Date: Thu, 6 Feb 2025 14:23:16 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Mahesh Rao <mahesh.rao@intel.com>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, dinguyen@kernel.org,
	hao.wu@intel.com, krzk+dt@kernel.org,
	krzysztof.kozlowski@linaro.org, linux-fpga@vger.kernel.org,
	linux-kernel@vger.kernel.org, mahesh.rao@altera.com, mdf@kernel.org,
	robh@kernel.org, trix@redhat.com, yilun.xu@intel.com
Subject: Re: [PATCH 3/3] firmware: stratix10-svc: Add
 of_platform_default_populate()
Message-ID: <Z6RVVGriTgZIM22k@yilunxu-OptiPlex-7050>
References: <Z5XyR9QE3kcQDOPe@yilunxu-OptiPlex-7050>
 <20250129180113.17219-1-mahesh.rao@intel.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250129180113.17219-1-mahesh.rao@intel.com>

On Thu, Jan 30, 2025 at 02:01:13AM +0800, Mahesh Rao wrote:
> Hi Yilun,
> Thanks for reviewing the patch.
> 
> On Sun, 26 Jan 2025 16:28:55 +0800, Xu Yilun wrote:
> > > Add of_platform_default_populate() to stratix10-svc driver as the
> > > firmware/svc node was moved out of soc.
> > > This fixes the failed probing of child drivers of svc node.
> > >
> > > Fixes: 23c3ebed382a ("arm64: dts: socfpga: agilex: move firmware out
> > > of soc node")
> 
> > > +	ret = of_platform_default_populate(dev_of_node(dev), NULL, dev);
> > > +	if (ret < 0) {
> > 
> > 	if (ret)  is just fine.
> 
> ok ,I will make the change.
> 
> > 
> > > +		of_platform_depopulate(dev);
> > > +		goto err_unregister_fcs_dev;
> > 
> > You wanna destroy everything even if some child drivers work?
> 
> Currently, there is no requirement to retain the driver if a child component fails.
> we will handle it if it is needed in the future.

Does the previous "soc" style population did the same way?

Thanks,
Yilun

> 
> > And do we need to do depopulation on driver remove?
> 
> I think yes , I have missed this. I will add depopulate in the remove callback().
> 
> > I'm actually a little confused how to handle populate() fail and depopulate().
> 
> I think this was a mistake on my side. I will make the change in next revision.
> 
> Best Regards,
> Mahesh Rao

