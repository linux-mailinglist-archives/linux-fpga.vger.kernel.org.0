Return-Path: <linux-fpga+bounces-1429-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DEF7CC3EB5F
	for <lists+linux-fpga@lfdr.de>; Fri, 07 Nov 2025 08:12:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E902188C076
	for <lists+linux-fpga@lfdr.de>; Fri,  7 Nov 2025 07:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77541306D3D;
	Fri,  7 Nov 2025 07:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CmEEzx0w"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE542C325F;
	Fri,  7 Nov 2025 07:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762499543; cv=none; b=q2D0ls8LE2GjcQRioDgOfb87fApH6BHU07YolxzZlZY3Xc5xWdGchDusj7+/Iv+MVLS2F+jDJAMp/3eCHC/7a9wlD1SXpJKaj33BXLmjtmn3hAu1fGolJf2/s6vAPF+Ts9Y+m/GyMwHV6oprjSvc5ml58sanqwfleEvmkJjXR6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762499543; c=relaxed/simple;
	bh=PrudV2jAOie1dt1jMSBj4uL3MDg1leyyQ1JSB+kumCE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZCUQuyVWRJrlNglHl6Zlig1HUy8QZbXK4o2I484/hJgfMeIHV5P/XmTpghQ0mo25dxYoMzN7gY0/8dHWS1jwv688iAHqIeOjfQF6I3U9EDMa49Exz02tonPW79fRaYFV5uqsR8GtENJtoS/kbgGPw3raem01ghbO39jqAvHQc9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CmEEzx0w; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762499542; x=1794035542;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PrudV2jAOie1dt1jMSBj4uL3MDg1leyyQ1JSB+kumCE=;
  b=CmEEzx0wnxMqCCZ5OtvvadqFjrN15NxqADw1po7tdRDPzcxRT16oFctv
   6ymDqtzRW6yb8JTHSsaZOHcEEe9TRlhEtHK5Osd3cRF2l2I89QTm+M5eF
   awt2eRS5v4REGalb2Ddpj1ytpmJNr058OUU4Pi+nSun+F6sveGNIWLHjz
   ARzit9USvDmKDExTu24T435Pq4cFt9pcHvqaoaVdrPqa2vcG1+T7Phd2k
   4aya7WiKB6GQU4H2yI5S4n5Jv+BGBC/BsIR5ipVALfdjLVqjtFGiQ9V5J
   NBHO6cUJ9Wj7362KvQGAncmVm+kcWDqqc+vT+fx+z4jNR9gZrnHYa+Rab
   A==;
X-CSE-ConnectionGUID: XbXolToQSAGaoSr2j4Svkg==
X-CSE-MsgGUID: 2P7UAmTiQxig3urhuUGWBw==
X-IronPort-AV: E=McAfee;i="6800,10657,11605"; a="90117899"
X-IronPort-AV: E=Sophos;i="6.19,286,1754982000"; 
   d="scan'208";a="90117899"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2025 23:12:21 -0800
X-CSE-ConnectionGUID: geqqei3bSbKyDLpA8UsGag==
X-CSE-MsgGUID: SmxjGJT1RrKBPSjoHdSttw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,286,1754982000"; 
   d="scan'208";a="218625722"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa002.jf.intel.com with ESMTP; 06 Nov 2025 23:12:19 -0800
Date: Fri, 7 Nov 2025 14:58:06 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-fpga@vger.kernel.org, Moritz Fischer <mdf@kernel.org>,
	Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] fpga: stratix10-soc: add missing header
Message-ID: <aQ2Yfh5kWCIJ4VsN@yilunxu-OptiPlex-7050>
References: <20251106185938.6419-1-rosenp@gmail.com>
 <20251106185938.6419-2-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251106185938.6419-2-rosenp@gmail.com>

On Thu, Nov 06, 2025 at 10:59:37AM -0800, Rosen Penev wrote:
> linux/sizes.h is needed for SZ_512K.

Does it always fail or only with COMPILE_TEST?

Please add "fixes" & Cc stable kernel if it always fail.

> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  drivers/fpga/stratix10-soc.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/fpga/stratix10-soc.c b/drivers/fpga/stratix10-soc.c
> index 0a295ccf1644..ab309cbf21c6 100644
> --- a/drivers/fpga/stratix10-soc.c
> +++ b/drivers/fpga/stratix10-soc.c
> @@ -11,6 +11,7 @@
>  #include <linux/of.h>
>  #include <linux/of_platform.h>
>  #include <linux/platform_device.h>
> +#include <linux/sizes.h>
>  
>  /*
>   * FPGA programming requires a higher level of privilege (EL3), per the SoC
> -- 
> 2.51.2
> 
> 

