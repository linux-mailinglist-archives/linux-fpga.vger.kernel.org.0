Return-Path: <linux-fpga+bounces-539-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B36F3903570
	for <lists+linux-fpga@lfdr.de>; Tue, 11 Jun 2024 10:17:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B38231C21F03
	for <lists+linux-fpga@lfdr.de>; Tue, 11 Jun 2024 08:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0569174EFA;
	Tue, 11 Jun 2024 08:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kTA8umuq"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E26171075;
	Tue, 11 Jun 2024 08:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718093842; cv=none; b=drZtHqqNGfNGFZXcYI4LMrJ7CUBfvnMsYwgdqhyy3tfedpfSJCFos28E8UKX3wowNCU2Zh18jgb3aPa9E66e575ciVPin77CqdjTT/IlVa/DqaffJJeslwx4wqN11vsO4RiJEEYrWdcl8M3BgHABNZSOLUoWCm745Utp7f3unUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718093842; c=relaxed/simple;
	bh=IYRrcBe4GylyFRXsIQPGJ9H2aZqm92cfOkhCwvHZWC8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FaoAt1/WkttSvdnKxXs+XjP/k6ZPnKLAxDM3Gqxjigr2hXVb3C0dRxJgJOPsTUTJdCrdGfTxJ59RUx6+NNVraXpolbpUzo17QxHc7qD//EO7Z1drd00mg+a2Dq7EvxKVOYaG//tO9KrT2hoInxXNV+3pGboexKiHjF3vBkvMfKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kTA8umuq; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718093841; x=1749629841;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IYRrcBe4GylyFRXsIQPGJ9H2aZqm92cfOkhCwvHZWC8=;
  b=kTA8umuqEAL3oM7QjbXCKpLLaTTbBpc9ksK4x1+xqPD/VIl6Km7YUxVu
   OCs26Ay4upI7aWBu1VfRYkMM25CRA5PG6EyzwLZ8fh3TTVhsDzATGw3Ix
   aluTqt7o+InpVT5JwcM7vVvI2eaC7sXKJjcykpIMdiLO2EyCQM/NC4Rgq
   tvrBUlfCkFPrm+bpPhqczrPWwq791Bm6sfhDqljYzUEKxV1ZWuCV18uM/
   hWXPCiYrESa5EkOpG50bCRSg/wgo5hm5/dopy6ewx6Qx3ZA1HcZR0hFAg
   ehM5qH/CBrHUsy2/TawO5xq2Igepsi2Z6dosOucf9FoDNAWEbaC9AuXbe
   g==;
X-CSE-ConnectionGUID: mh+4jld/Sjqbv2R6sCkAFw==
X-CSE-MsgGUID: bb/ypK/iSLOq9UHcwsSz7A==
X-IronPort-AV: E=McAfee;i="6600,9927,11099"; a="25368068"
X-IronPort-AV: E=Sophos;i="6.08,229,1712646000"; 
   d="scan'208";a="25368068"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2024 01:17:21 -0700
X-CSE-ConnectionGUID: ghY+OA50TGeJ0lirHyCfrQ==
X-CSE-MsgGUID: ltE0LWriSfSBxd/pHCg9vQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,229,1712646000"; 
   d="scan'208";a="39422866"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa010.fm.intel.com with ESMTP; 11 Jun 2024 01:17:19 -0700
Date: Tue, 11 Jun 2024 16:10:50 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-crypto@vger.kernel.org, Moritz Fischer <mdf@kernel.org>,
	Wu Hao <hao.wu@intel.com>, Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>, linux-fpga@vger.kernel.org
Subject: Re: [PATCH 1/2] fpga: socfpga: use 'time_left' variable with
 wait_for_completion_interruptible_timeout()
Message-ID: <ZmgGiuu/5Eqxb0uR@yilunxu-OptiPlex-7050>
References: <20240502210038.11480-1-wsa+renesas@sang-engineering.com>
 <20240502210038.11480-2-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240502210038.11480-2-wsa+renesas@sang-engineering.com>

On Thu, May 02, 2024 at 11:00:36PM +0200, Wolfram Sang wrote:
Sorry for late reply.

First of all, please limit your subject/shortlog/summary within 70
chars.

> There is a confusing pattern in the kernel to use a variable named 'timeout' to

Please make the changelog line wrapped at less than 75 chars.

> store the result of wait_for_completion_interruptible_timeout() causing patterns like:
> 
> 	timeout = wait_for_completion_interruptible_timeout(...)
> 	if (!timeout) return -ETIMEDOUT;
> 
> with all kinds of permutations. Use 'time_left' as a variable to make the code
> self explaining.
> 
> Fix to the proper variable type 'long' while here.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>  drivers/fpga/socfpga.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/fpga/socfpga.c b/drivers/fpga/socfpga.c
> index 723ea0ad3f09..b08b4bb8f650 100644
> --- a/drivers/fpga/socfpga.c
> +++ b/drivers/fpga/socfpga.c
> @@ -301,16 +301,17 @@ static irqreturn_t socfpga_fpga_isr(int irq, void *dev_id)
>  
>  static int socfpga_fpga_wait_for_config_done(struct socfpga_fpga_priv *priv)
>  {
> -	int timeout, ret = 0;
> +	int ret = 0;
> +	long time_left;

Please use reverse xmas tree when it is easy to follow.

The code change is good to me.

Thanks,
Yilun

>  
>  	socfpga_fpga_disable_irqs(priv);
>  	init_completion(&priv->status_complete);
>  	socfpga_fpga_enable_irqs(priv, SOCFPGA_FPGMGR_MON_CONF_DONE);
>  
> -	timeout = wait_for_completion_interruptible_timeout(
> +	time_left = wait_for_completion_interruptible_timeout(
>  						&priv->status_complete,
>  						msecs_to_jiffies(10));
> -	if (timeout == 0)
> +	if (time_left == 0)
>  		ret = -ETIMEDOUT;
>  
>  	socfpga_fpga_disable_irqs(priv);
> -- 
> 2.43.0
> 
> 

