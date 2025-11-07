Return-Path: <linux-fpga+bounces-1430-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B43FBC3EC08
	for <lists+linux-fpga@lfdr.de>; Fri, 07 Nov 2025 08:30:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B79AF4EA4A9
	for <lists+linux-fpga@lfdr.de>; Fri,  7 Nov 2025 07:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3F69284881;
	Fri,  7 Nov 2025 07:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DeucpyDe"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8741A24DD1F;
	Fri,  7 Nov 2025 07:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762500617; cv=none; b=WP2+dfURmOQJ0G/ZxIuuGa6hvligRYS6rUbU5z3ouy4D0y41oI9cIw1frjYnfpklSkOE7n+GQezmvGTFPm7VHaDreTeHGM9rO+gY472tOi35a9x5oc3ARmyVdn3Ho5oX9qy9A2x+eLZiehihKLp9oEz/JBiVdvPVIUvCSINtvb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762500617; c=relaxed/simple;
	bh=tcWdh+ZE5GMQBD15qGMG2as3Gr64RSNKFEWcV+w3lfo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fr7zc9Fj9uxgUbDT6FCmWfoL8Q3sWU0ciRLs01Hpfv2FchkbqYH8hXcBcGsU15ucXsFlLiEalyD3sbGLw5CYkZA2RWI+G6/qIv6tifg42a18Ynw/0tRPL/dghrXKFkhHvjl4FmyLa2cv97D90XbXinSggraoOXMoGWN+2vM8pKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DeucpyDe; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762500616; x=1794036616;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tcWdh+ZE5GMQBD15qGMG2as3Gr64RSNKFEWcV+w3lfo=;
  b=DeucpyDelYHQ2wze8bp9Tag/DPp8JzlRwN6o/27ioZkG3ht7c2VXLkq7
   ZnL+DpQFRRYElH6Jm0AHbzpLrNL009TMCGKUFNsqgIMZzIKIp84bGhwnU
   mwzDMI/fMw+XgRAPUz2cvhXARvhylGUQFx0WVAbRZU7ZOnAikRy0eKSs7
   UdskKb6Mo1RxBCNzAT4GRcpaQ1nTS8rg+Q9NXBy4UuaPaE5DusPYncVqf
   S7xq6m/IX0VuojJ6jtkc14TPpXhUIYRgua+DRVLBw4XF25OrFQkl+nxFk
   SGDqWZL02No6QgU9JJLplIyXR9VmCatHM8WRS0dQrvx+/e64hHvtlPkIM
   w==;
X-CSE-ConnectionGUID: hfvBEjXDQViv/HAYdGULAQ==
X-CSE-MsgGUID: 4/zRIhdOQQqiQajKZiWv1g==
X-IronPort-AV: E=McAfee;i="6800,10657,11605"; a="63856221"
X-IronPort-AV: E=Sophos;i="6.19,286,1754982000"; 
   d="scan'208";a="63856221"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2025 23:30:15 -0800
X-CSE-ConnectionGUID: 7jz5mZcrS5mJ6ql5iG1oCw==
X-CSE-MsgGUID: GeIzQDx1Rt2lJfHhh6gIcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,286,1754982000"; 
   d="scan'208";a="192068890"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa003.jf.intel.com with ESMTP; 06 Nov 2025 23:30:13 -0800
Date: Fri, 7 Nov 2025 15:16:00 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-fpga@vger.kernel.org, Moritz Fischer <mdf@kernel.org>,
	Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] fpga: stratix10-soc: add COMPILE_TEST support
Message-ID: <aQ2csK4TtTOFmyLj@yilunxu-OptiPlex-7050>
References: <20251106185938.6419-1-rosenp@gmail.com>
 <20251106185938.6419-3-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251106185938.6419-3-rosenp@gmail.com>

On Thu, Nov 06, 2025 at 10:59:38AM -0800, Rosen Penev wrote:
> Allow the buildbots to find compilation issues.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  drivers/fpga/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
> index 311313f3b282..f2e2776acdd5 100644
> --- a/drivers/fpga/Kconfig
> +++ b/drivers/fpga/Kconfig
> @@ -60,7 +60,7 @@ config FPGA_MGR_ZYNQ_FPGA
>  
>  config FPGA_MGR_STRATIX10_SOC
>  	tristate "Intel Stratix10 SoC FPGA Manager"
> -	depends on (ARCH_INTEL_SOCFPGA && INTEL_STRATIX10_SERVICE)
> +	depends on (ARCH_INTEL_SOCFPGA && INTEL_STRATIX10_SERVICE) || COMPILE_TEST

I don't think it works without INTEL_STRATIX10_SERVICE, maybe:

	depends on ARCH_INTEL_SOCFPGA || COMPILE_TEST
	depends on INTEL_STRATIX10_SERVICE

But INTEL_STRATIX10_SERVICE depends on HAVE_ARM_SMCCC, and they all
require arch configurations...

>  	help
>  	  FPGA manager driver support for the Intel Stratix10 SoC.
>  
> -- 
> 2.51.2
> 
> 

