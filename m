Return-Path: <linux-fpga+bounces-1363-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41AC6B82DD6
	for <lists+linux-fpga@lfdr.de>; Thu, 18 Sep 2025 06:14:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B9F31C2148D
	for <lists+linux-fpga@lfdr.de>; Thu, 18 Sep 2025 04:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D29CA24418F;
	Thu, 18 Sep 2025 04:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Dcn2fNIy"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4047241686
	for <linux-fpga@vger.kernel.org>; Thu, 18 Sep 2025 04:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758168875; cv=none; b=YkzqgKF0+d2nGTGXkvslvMcVjCkZ3dKc5IZo2D/mgR4orBybt3Vk1Llc/RA5o2are0NNGfMeQL3kRsTng7faH30ZQlXi0ve+3qe1D0gPihC5sgRZT0n27EoG8dkQF3xe3xl86tc9mRIXrwZ7rKsbrPQwKb3SHkDng7oChhUwWFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758168875; c=relaxed/simple;
	bh=N7R0MimVgJSfBbZGytyTLpP8konL1KyVlkR8kasN5l0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BBEgaDZtoEX6TwkCpuCxg+vDnE26laKeGjwoqpD+Vh8q3ist8PMliwAJWrw08kEpOwj5kvkEXKf8J7iLCcQGHBOVzLLvZ2wi2me8f85aicBXMZKPaj0gSYC3x37Xl4/awG+Iz2dzxZLW9CvX8ikm12U0+Qjlt59btBn42PrJGoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Dcn2fNIy; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758168874; x=1789704874;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=N7R0MimVgJSfBbZGytyTLpP8konL1KyVlkR8kasN5l0=;
  b=Dcn2fNIyTGnKFPJ6U0BOUBkZeWB2SxqXaliLYJsVXCG0jjWL0GAtLFKS
   TCV2SswRfIP5NO4+nOFED4AfNUC0dd46Ss/cJ8U6GD1zZ9XCuehINXvC+
   RHAqgMY9st7rvryg2JH2v9HMAqtoAi/O9nnBSFR4waQp4jCOs9aHuYlvJ
   gvYJlojBX0rI5V2M9zPltSh5BOH0GhhwVhYJo2HSJLJ5EbNGcbeeSG3mu
   x1IG9LcXPU+I3Hn68YzjH9qkrSHlWdPro1WEoq4Q1s5gWcmtXTYXLtu8R
   t7JmuoQ5PEnN3lZFtDS/YBypjzOJtWgrw6dgsSlVOfGpdzDaDl47IquNm
   g==;
X-CSE-ConnectionGUID: yrDTHoWNQNalHD+J/C2YbQ==
X-CSE-MsgGUID: Dizw0DdpSTmTBcXUW3ayPg==
X-IronPort-AV: E=McAfee;i="6800,10657,11556"; a="60555137"
X-IronPort-AV: E=Sophos;i="6.18,274,1751266800"; 
   d="scan'208";a="60555137"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2025 21:14:33 -0700
X-CSE-ConnectionGUID: FQvNuNeITh+qk6hYmRW+4Q==
X-CSE-MsgGUID: VS1P3hftSVmpUx92v92d3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,274,1751266800"; 
   d="scan'208";a="180556462"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa005.jf.intel.com with ESMTP; 17 Sep 2025 21:14:31 -0700
Date: Thu, 18 Sep 2025 12:02:45 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: "Xu, Yilun" <yilun.xu@intel.com>
Cc: "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
	"Gerlach, Matthew" <matthew.gerlach@intel.com>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Subject: Re: FW: [PATCH] MAINTAINERS: change maintainer for Intel MAX10 BMC
 secure updates
Message-ID: <aMuEZRqck9ebuxOG@yilunxu-OptiPlex-7050>
References: <20250916155152.411121-1-matthew.gerlach@altera.com>
 <PH0PR11MB562884BA1B9C6215B3B5BD658B16A@PH0PR11MB5628.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR11MB562884BA1B9C6215B3B5BD658B16A@PH0PR11MB5628.namprd11.prod.outlook.com>

On Thu, Sep 18, 2025 at 04:09:14AM +0000, Xu, Yilun wrote:
> 
> -----Original Message-----
> From: Matthew Gerlach <matthew.gerlach@altera.com> 
> Sent: Tuesday, September 16, 2025 11:52 PM
> To: Xu, Yilun <yilun.xu@intel.com>; linux-kernel@vger.kernel.org
> Cc: Gerlach, MatthewH (Altera Corp) <matthew.gerlach@altera.com>
> Subject: [PATCH] MAINTAINERS: change maintainer for Intel MAX10 BMC secure updates
> 
> Xu Yilun has kindly agreed to take over maintaining Intel MAX10 BMC secure updates, since I will be leaving Altera.
> 
> Signed-off-by: Matthew Gerlach <matthew.gerlach@altera.com>

Signed-off-by: Xu Yilun <yilun.xu@intel.com>

> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 9da37c8dee69..b9c1bf9b9dee 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -12689,7 +12689,7 @@ F:	drivers/mfd/intel-m10-bmc*
>  F:	include/linux/mfd/intel-m10-bmc.h
>  
>  INTEL MAX10 BMC SECURE UPDATES
> -M:	Matthew Gerlach <matthew.gerlach@altera.com>
> +M:	Xu Yilun <yilun.xu@intel.com>
>  L:	linux-fpga@vger.kernel.org
>  S:	Maintained
>  F:	Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-sec-update
> --
> 2.35.3
> 

