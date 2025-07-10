Return-Path: <linux-fpga+bounces-1281-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E8DEAFF6AD
	for <lists+linux-fpga@lfdr.de>; Thu, 10 Jul 2025 04:18:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1458518974AD
	for <lists+linux-fpga@lfdr.de>; Thu, 10 Jul 2025 02:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AFF519D065;
	Thu, 10 Jul 2025 02:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="njsVZi27"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 519C1264FB3;
	Thu, 10 Jul 2025 02:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752113903; cv=none; b=YI00wZJp0mXc2RaB9Aj/vXnGBwiB3EJMi6V2kf5B3FosFz8xLuKgsaSujuwSjBO1O63H62cs0wK9u6dG+dMZ5cXeLeeHAd8rxA25BAldO6lFn+XViiYgEdhIYVV+lXZ6uGwESKmJ1Ixrp2iwjpkdDORgJhDXLWXKBIrdMd+AFbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752113903; c=relaxed/simple;
	bh=YncpeWYjw31dFey/cwnZPymn2+vmtnLzfzSuuDjkjEE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ArTbcdKY2E5q88MVluLPGQc993UNLQ6vwFQ5tuPOPpl5ZOfF6dPGczrg1YleHIzsGoENk9VOEchpefpso+27/ZgmKqOthPh/f7DciFaZFlVOMNQOO8Y2ULleX/0R0IgdQ0BKPOwJl8uSIMUWaEjtLOc/VuRFeLCScizfA58qQR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=njsVZi27; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752113902; x=1783649902;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YncpeWYjw31dFey/cwnZPymn2+vmtnLzfzSuuDjkjEE=;
  b=njsVZi27lClZ+YOJ3vMd/yzlgDjisu40dglLLRk+iBZfMrIF2rrbYdkA
   paC1P0AnB2sNGd0DNZiSm6DxuIX/SQlP/y39IhUNVMwC3lX1gCx07LI6V
   N/UG1DWIC1+p9AhALTZCZN5uTlAR2+8+ckSXCrEGf2ZBYf8DiYW+MfxSZ
   GG2MxDp+zp3sPkRKDXLbXe2xW5HDxseF8h5XojcCSr4LCJP0c0BoUkHUe
   IZNCQRSESnJk0rI4kuJJGqcGtuw8UoKMTWYJH8LiztD1sf4VOHe39tOux
   9BaYM3wiCr+joIRlDkmfQd4PIqpZkfLCTSxxpm/4lZ/k757rAB4iF2QUy
   Q==;
X-CSE-ConnectionGUID: PB5NGTC6TbiJyxGhpD8Z+w==
X-CSE-MsgGUID: LLBl3FqNT/Wf3uTMStvHQg==
X-IronPort-AV: E=McAfee;i="6800,10657,11489"; a="42012168"
X-IronPort-AV: E=Sophos;i="6.16,299,1744095600"; 
   d="scan'208";a="42012168"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2025 19:18:20 -0700
X-CSE-ConnectionGUID: SRXOa2pITreNuddkTH38qw==
X-CSE-MsgGUID: xZHymS2NTSi2P2hP07/uIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,299,1744095600"; 
   d="scan'208";a="160227380"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa005.fm.intel.com with ESMTP; 09 Jul 2025 19:17:47 -0700
Date: Thu, 10 Jul 2025 10:09:28 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: linux-fpga@vger.kernel.org, Moritz Fischer <mdf@kernel.org>,
	Wu Hao <hao.wu@intel.com>, Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>, Michal Simek <michal.simek@amd.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, stable@vger.kernel.org
Subject: Re: [PATCH v2] zynq_fpga: use sgtable-based scatterlist wrappers
Message-ID: <aG8g2AchbLRJT9jU@yilunxu-OptiPlex-7050>
References: <CGME20250616120941eucas1p2329f4080332615953fa77ba5ad0c0155@eucas1p2.samsung.com>
 <20250616120932.1090614-1-m.szyprowski@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250616120932.1090614-1-m.szyprowski@samsung.com>

On Mon, Jun 16, 2025 at 02:09:32PM +0200, Marek Szyprowski wrote:
> Use common wrappers operating directly on the struct sg_table objects to
> fix incorrect use of statterlists related calls. dma_unmap_sg() function
> has to be called with the number of elements originally passed to the
> dma_map_sg() function, not the one returned in sgtable's nents.
> 
> CC: stable@vger.kernel.org
> Fixes: 425902f5c8e3 ("fpga zynq: Use the scatterlist interface")
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>

Applied to for-next.
Thanks.

> ---
> v2:
> - fixed build break (missing flags parameter)
> ---
>  drivers/fpga/zynq-fpga.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git drivers/fpga/zynq-fpga.c drivers/fpga/zynq-fpga.c
> index f7e08f7ea9ef..0be0d569589d 100644
> --- drivers/fpga/zynq-fpga.c
> +++ drivers/fpga/zynq-fpga.c
> @@ -406,7 +406,7 @@ static int zynq_fpga_ops_write(struct fpga_manager *mgr, struct sg_table *sgt)
>  	}
>  
>  	priv->dma_nelms =
> -	    dma_map_sg(mgr->dev.parent, sgt->sgl, sgt->nents, DMA_TO_DEVICE);
> +	    dma_map_sgtable(mgr->dev.parent, sgt, DMA_TO_DEVICE, 0);
>  	if (priv->dma_nelms == 0) {
>  		dev_err(&mgr->dev, "Unable to DMA map (TO_DEVICE)\n");
>  		return -ENOMEM;
> @@ -478,7 +478,7 @@ static int zynq_fpga_ops_write(struct fpga_manager *mgr, struct sg_table *sgt)
>  	clk_disable(priv->clk);
>  
>  out_free:
> -	dma_unmap_sg(mgr->dev.parent, sgt->sgl, sgt->nents, DMA_TO_DEVICE);
> +	dma_unmap_sgtable(mgr->dev.parent, sgt, DMA_TO_DEVICE, 0);
>  	return err;
>  }
>  
> -- 
> 2.34.1
> 
> 

