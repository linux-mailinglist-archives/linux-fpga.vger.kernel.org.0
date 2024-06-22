Return-Path: <linux-fpga+bounces-559-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B40D8913499
	for <lists+linux-fpga@lfdr.de>; Sat, 22 Jun 2024 17:01:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5979F1F22C74
	for <lists+linux-fpga@lfdr.de>; Sat, 22 Jun 2024 15:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9458E16F0FD;
	Sat, 22 Jun 2024 15:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VbSn58YY"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE26814C5A4;
	Sat, 22 Jun 2024 15:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719068489; cv=none; b=rMnPUwH40IkJ8PED2YWfGRY1XIcNBSHQcllyLYNlMbfQKJvxlpuvuVsTZTJMIbG418pVMcH4AQUmaiwdyuGpTsyAx9ScsQXp/1IawPakHyTvRpIRFvv/Y5OBglZoElAwECJv6jGd23BKrJ2PeRrroFzUicbXaUaJsr9bBrXR+Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719068489; c=relaxed/simple;
	bh=/I2FzXfzr5E8m3MNh2ua4UevzX34OEH4iCs54nu6u6k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cSq4+aXbQK7SBwQGrCRvf0hrq51LTI7b/5SMPaM6KXttBErwo/XuULpPBOzfk8WkMUoDnD+8IzBg9VyxW+dN6tUDOf/e+B+ncKZgRCfwOgylGOisLQwN6jfrHKPXKKw8Bi/uXOsBsL5vxkrqa+7HPGZ6tOMGOnl3qv2rgudfrNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VbSn58YY; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719068488; x=1750604488;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/I2FzXfzr5E8m3MNh2ua4UevzX34OEH4iCs54nu6u6k=;
  b=VbSn58YYVYsD6FM08cKN9K5K0M6LiOiT9rjvWrD8/wzSwxGiNMe4UKsX
   M/CzNk+4ZmI2znwYOXKh1Qe5phD0B+hJGkKuKhjUwrzZoUg1+6lBTdAy0
   ltl8tAek2acrhMbYU46KNRoXrIhNTKPfsBcCbYnU8yJ24YVQfiZBFtmkl
   7fGcsyvhYxBzLEPGcd30eIjc8uPCgFycjgNuvGvWPebEpn4VSfo6H0hYj
   wwpblwF26R6G9YD4xikOtT1+0dlPs8YK8p9G9yT+W9zKhEqQOWbBGbLVT
   rOjRZSnoAjrn25VQ8pnW7iyu/8PJbmiOT+6W0PpWNYATt5pKHlsyoZ92j
   g==;
X-CSE-ConnectionGUID: +YCXGa5JSJaIPTm92Cc7hQ==
X-CSE-MsgGUID: v63g6BrvQCervFlZxJucAA==
X-IronPort-AV: E=McAfee;i="6700,10204,11111"; a="38610213"
X-IronPort-AV: E=Sophos;i="6.08,257,1712646000"; 
   d="scan'208";a="38610213"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2024 08:01:27 -0700
X-CSE-ConnectionGUID: Y4HbPF1xQhWtOGz7D4If0g==
X-CSE-MsgGUID: pJttqjAnS1KJWgixI5m8Ng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,258,1712646000"; 
   d="scan'208";a="43541216"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa008.jf.intel.com with ESMTP; 22 Jun 2024 08:01:26 -0700
Date: Sat, 22 Jun 2024 22:54:40 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-kernel@vger.kernel.org, Michal Simek <michal.simek@amd.com>,
	Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
	Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
	linux-fpga@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 2/2] fpga: zynq-fpga: use 'time_left' variable with
 wait_for_completion_timeout()
Message-ID: <ZnblsA42uTfU8Yx5@yilunxu-OptiPlex-7050>
References: <20240620115022.24409-1-wsa+renesas@sang-engineering.com>
 <20240620115022.24409-3-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240620115022.24409-3-wsa+renesas@sang-engineering.com>

On Thu, Jun 20, 2024 at 01:50:22PM +0200, Wolfram Sang wrote:

Please check the same shortlog problem for all your patches

Thanks,
Yilun

> There is a confusing pattern in the kernel to use a variable named
> 'timeout' to store the result of wait_for_completion_timeout() causing
> patterns like:
> 
>         timeout = wait_for_completion_timeout(...)
>         if (!timeout) return -ETIMEDOUT;
> 
> with all kinds of permutations. Use 'time_left' as a variable to make
> the code self explaining.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Acked-by: Michal Simek <michal.simek@amd.com>
> ---
> 
> Change since v1: added ack (Thanks Michal)
> 
>  drivers/fpga/zynq-fpga.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/fpga/zynq-fpga.c b/drivers/fpga/zynq-fpga.c
> index 0ac93183d201..4db3d80e10b0 100644
> --- a/drivers/fpga/zynq-fpga.c
> +++ b/drivers/fpga/zynq-fpga.c
> @@ -387,7 +387,7 @@ static int zynq_fpga_ops_write(struct fpga_manager *mgr, struct sg_table *sgt)
>  	const char *why;
>  	int err;
>  	u32 intr_status;
> -	unsigned long timeout;
> +	unsigned long time_left;
>  	unsigned long flags;
>  	struct scatterlist *sg;
>  	int i;
> @@ -427,8 +427,8 @@ static int zynq_fpga_ops_write(struct fpga_manager *mgr, struct sg_table *sgt)
>  	zynq_step_dma(priv);
>  	spin_unlock_irqrestore(&priv->dma_lock, flags);
>  
> -	timeout = wait_for_completion_timeout(&priv->dma_done,
> -					      msecs_to_jiffies(DMA_TIMEOUT_MS));
> +	time_left = wait_for_completion_timeout(&priv->dma_done,
> +						msecs_to_jiffies(DMA_TIMEOUT_MS));
>  
>  	spin_lock_irqsave(&priv->dma_lock, flags);
>  	zynq_fpga_set_irq(priv, 0);
> @@ -452,7 +452,7 @@ static int zynq_fpga_ops_write(struct fpga_manager *mgr, struct sg_table *sgt)
>  
>  	if (priv->cur_sg ||
>  	    !((intr_status & IXR_D_P_DONE_MASK) == IXR_D_P_DONE_MASK)) {
> -		if (timeout == 0)
> +		if (time_left == 0)
>  			why = "DMA timed out";
>  		else
>  			why = "DMA did not complete";
> -- 
> 2.43.0
> 
> 

