Return-Path: <linux-fpga+bounces-558-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B30391348D
	for <lists+linux-fpga@lfdr.de>; Sat, 22 Jun 2024 16:58:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C89F1C2197B
	for <lists+linux-fpga@lfdr.de>; Sat, 22 Jun 2024 14:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2535C16F299;
	Sat, 22 Jun 2024 14:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y5cgCzM3"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2581416F919;
	Sat, 22 Jun 2024 14:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719068323; cv=none; b=BtBrP5jeuJhchjIgfbswktXgGiqgtFzVzJ4Q5rxizhh9HOewE/qXByfmngOqy0pZbBtcZpsqlOdP7ikS/Y777gmKnPy5Kf3SNM7XF9YwV7WgbTD1fO94kycreTOVPhOrKxcZWSHD3eQ+0Ba4uPUdtxApZE5+xY4LnJSBCPTFj58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719068323; c=relaxed/simple;
	bh=RAJamOHQFLD7T/Afj2Bx+Jy9uD0NgfQeuqeD1ZE59Yw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g7ZrDoQ+yJDd0SERNu0KztOUJYNbIhQNf1pokWfaOsCiRSdY9hENDpyI9s3qhZ3oqVPdpVLEeQWOfR0jpFDyBrCNRL5sVYBt79rxbV4x6x9I4gUQ8TidbUchfQnkr36PF7/dXBQYvbFiAzYX5H6MSueQCC9+wI33fBnp2ejYY4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y5cgCzM3; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719068321; x=1750604321;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RAJamOHQFLD7T/Afj2Bx+Jy9uD0NgfQeuqeD1ZE59Yw=;
  b=Y5cgCzM3bGNlDCu1xLkbBocYXEBNYcDIXClaO7BKfuIeyegoM3MkhRBQ
   k5qG/WSwqwNz7b64s7E+0AdBeEnVMtTdoE06ICsG5L42LMEVZj1ClD+Q4
   GUgNbxXOUlGNSbL8StFZPzSUzGHqczohqh8hU8gUxraif06e/XrWArEuk
   OTIaIxjxzqgQ5GlHDkIQgNN9usmZhtGtnu87vvuMOCKhLHTf7Iw101SIc
   E2LQ2VAen4ghMTI81iAi/SJ7xGoQHMJjIrns09LLLm0kkxm8CAD8b1Lz2
   1uQIYp7DOhkie3oG0pzqQGp9K/YT2+J2Y6y2brYR+Lyr7Nnx4kgW2L1XQ
   A==;
X-CSE-ConnectionGUID: i1kUiCnHTTu+5BJ2Hxv+xQ==
X-CSE-MsgGUID: re0g1MlwQzix1X3J4LYE2Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11111"; a="33551795"
X-IronPort-AV: E=Sophos;i="6.08,257,1712646000"; 
   d="scan'208";a="33551795"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2024 07:58:40 -0700
X-CSE-ConnectionGUID: XEd85cBTTHyGNmXt/9McUQ==
X-CSE-MsgGUID: TGxm2aztSDCjYMPl9S45lw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,257,1712646000"; 
   d="scan'208";a="80376137"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa001.jf.intel.com with ESMTP; 22 Jun 2024 07:58:39 -0700
Date: Sat, 22 Jun 2024 22:51:54 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-kernel@vger.kernel.org, Moritz Fischer <mdf@kernel.org>,
	Wu Hao <hao.wu@intel.com>, Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>, linux-fpga@vger.kernel.org
Subject: Re: [PATCH v2 1/2] fpga: socfpga: use 'time_left' variable with
 wait_for_completion*()
Message-ID: <ZnblCkmLCnID3jXB@yilunxu-OptiPlex-7050>
References: <20240620115022.24409-1-wsa+renesas@sang-engineering.com>
 <20240620115022.24409-2-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240620115022.24409-2-wsa+renesas@sang-engineering.com>

On Thu, Jun 20, 2024 at 01:50:21PM +0200, Wolfram Sang wrote:

Still for the shortlog, How about:

  Rename the 'timeout' variable as 'time_left'

Thanks,
Yilun

> There is a confusing pattern in the kernel to use a variable named
> 'timeout' to store the result of
> wait_for_completion_interruptible_timeout() causing patterns like:
> 
>         timeout = wait_for_completion_interruptible_timeout(...)
>         if (!timeout) return -ETIMEDOUT;
> 
> with all kinds of permutations. Use 'time_left' as a variable to make
> the code self explaining.
> 
> Fix to the proper variable type 'long' while here.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
> 
> Change since v1:
> * use reverse-xmas-tree for variable init
> * keep chars/line limits in commit message
> 
>  drivers/fpga/socfpga.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/fpga/socfpga.c b/drivers/fpga/socfpga.c
> index 723ea0ad3f09..f772b754aa76 100644
> --- a/drivers/fpga/socfpga.c
> +++ b/drivers/fpga/socfpga.c
> @@ -301,16 +301,17 @@ static irqreturn_t socfpga_fpga_isr(int irq, void *dev_id)
>  
>  static int socfpga_fpga_wait_for_config_done(struct socfpga_fpga_priv *priv)
>  {
> -	int timeout, ret = 0;
> +	long time_left;
> +	int ret = 0;
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

