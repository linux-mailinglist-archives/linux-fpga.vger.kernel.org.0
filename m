Return-Path: <linux-fpga+bounces-1282-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 927E5AFF6BD
	for <lists+linux-fpga@lfdr.de>; Thu, 10 Jul 2025 04:21:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75A883BBD9B
	for <lists+linux-fpga@lfdr.de>; Thu, 10 Jul 2025 02:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36D2727E1C3;
	Thu, 10 Jul 2025 02:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DmF9uvpQ"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A544E158DD4;
	Thu, 10 Jul 2025 02:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752114114; cv=none; b=dx1knhMqMru8T7NbTsINU8Ye7+Y9akBMvdKSolsikOX/L77jsAZOfnYNrKtWneW66gxePp5EkWV9wJK2VbvuksJqMZuzyQF4k+ITcfjIijigJMo/m6Df+h1jnGrEokMJxAANTvRzVY9QbV38/ZOhw1h/Fm95Ig1o5IToYk/3lAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752114114; c=relaxed/simple;
	bh=tl+HqryMhX1Ag/VCMsDe44ltKEHJccM4klUEFyXrXG4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EWxrXI6GmLyFZmtpYiSF9LICqOu+kLOzV9Y5UEXvhm/kYL/mOecdaq0ppmX+w2W7YiM0fS6z2YdpiTox0cwfiPeZrza1+h46EHvVAxMKC0SZNZh7OKnRBrCfareVuhbMCJDNIly4HHma8hNihHg3JxxQcvUiI8tbr1vcOCsX4QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DmF9uvpQ; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752114113; x=1783650113;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tl+HqryMhX1Ag/VCMsDe44ltKEHJccM4klUEFyXrXG4=;
  b=DmF9uvpQ6tQLzmZuKhNC5qPOJoWUYvSg0aVd418CzRY9Ek/KpZf+F7mm
   XVkVdEf+0re0+eFp0AvvwSQhxSZSTsQaXkssOBu6eAajC7IQp32xYI2v/
   AU7TZwtqET1fF7+acHQZf2omDheFs+QUiB0SmcUvzuUTpTC9KT5ZweYKE
   R/R7XO5Bi3quJRdCv7MhywOiumENpOxIoOuaIy1j9fFtL6vQCc6EfIcxG
   wJdvd9uZR/RTsbBfqit8ZU4HyWMjF3nF4jx4nG8isFISdaMV1wFDMdv73
   W+D7sVukFKFacYqqk63xUHifsp9IPA2Jb4a3CuV+K861Z8fWQenzHuc1F
   A==;
X-CSE-ConnectionGUID: bkt2WQwYSEeqYwfgWgbUnQ==
X-CSE-MsgGUID: mLF3dIRETbSEpn0iPwa/yg==
X-IronPort-AV: E=McAfee;i="6800,10657,11489"; a="54478790"
X-IronPort-AV: E=Sophos;i="6.16,299,1744095600"; 
   d="scan'208";a="54478790"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2025 19:21:52 -0700
X-CSE-ConnectionGUID: OZV4UDnsQJqDsORDkpp8Gg==
X-CSE-MsgGUID: 5/kbpgNHTV+0vnIkEmEFYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,299,1744095600"; 
   d="scan'208";a="186926398"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa001.fm.intel.com with ESMTP; 09 Jul 2025 19:21:50 -0700
Date: Thu, 10 Jul 2025 10:13:31 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Kuhanh Murugasen Krishnan <kuhanh.murugasen.krishnan@intel.com>
Cc: Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
	Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
	linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
	Kuhanh Murugasen Krishnan <kuhanh.murugasen.krishnan@altera.com>,
	Khairul Anuar Romli <khairul.anuar.romli@altera.com>
Subject: Re: [PATCH] fpga: altera-cvp: Add FPGA Configuration Framework
 dependency
Message-ID: <aG8hy2vQa6uIKS1f@yilunxu-OptiPlex-7050>
References: <20250613092414.3198092-1-kuhanh.murugasen.krishnan@intel.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250613092414.3198092-1-kuhanh.murugasen.krishnan@intel.com>

On Fri, Jun 13, 2025 at 05:24:14PM +0800, Kuhanh Murugasen Krishnan wrote:
> From: "Murugasen Krishnan, Kuhanh" <kuhanh.murugasen.krishnan@altera.com>
> 
> Altera CvP FPGA Manager driver depends on FPGA
> Configuration Framework drivers to be loaded in
> the kernel. Updating FPGA_MGR_ALTERA_CVP in Kconfig
> depends on to include FPGA.

Is that necessary? We've already included all FPGA drivers in "if FPGA".

Thanks,
Yilun

> 
> Signed-off-by: Murugasen Krishnan, Kuhanh <kuhanh.murugasen.krishnan@altera.com>
> ---
>  drivers/fpga/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
> index 37b35f58f0df..6f741348bfbc 100644
> --- a/drivers/fpga/Kconfig
> +++ b/drivers/fpga/Kconfig
> @@ -47,7 +47,7 @@ config FPGA_MGR_ALTERA_PS_SPI
>  
>  config FPGA_MGR_ALTERA_CVP
>  	tristate "Altera CvP FPGA Manager"
> -	depends on PCI
> +	depends on PCI && FPGA
>  	help
>  	  FPGA manager driver support for Arria-V, Cyclone-V, Stratix-V,
>  	  Arria 10 and Stratix10 Altera FPGAs using the CvP interface over PCIe.
> -- 
> 2.25.1
> 
> 

