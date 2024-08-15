Return-Path: <linux-fpga+bounces-591-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B297952816
	for <lists+linux-fpga@lfdr.de>; Thu, 15 Aug 2024 05:02:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A6641F217AD
	for <lists+linux-fpga@lfdr.de>; Thu, 15 Aug 2024 03:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F3F9EEC0;
	Thu, 15 Aug 2024 03:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l8rbpYlY"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B78C144
	for <linux-fpga@vger.kernel.org>; Thu, 15 Aug 2024 03:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723690927; cv=none; b=ux4ZMYZC+pyg9mtlb8z0Sa3+EL+j7SXg6fQAHSNeeiF/1SZ0TFzi8Nr84YoiHI/VJfpezN4zVhEciPJ6e3L48lcWKQPE1XffDaSA8LnnXl+dSxNMtQC6xgLVNoXxBNYZiJU0ciZXDCF/N015mXhUOOs3qcYt10P6rROdtXLCAH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723690927; c=relaxed/simple;
	bh=NXsHMeGI10eXx6chKIAb94f8f941LTs8YgERcERymrM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NUpDVg+OO4t/Q3ZErVGW8C7K8312G6dknYOmapwACnKrLWj/JmEXtaRJubCGFuE+LLg+H1KAN2sOMyRLweYOAEmzVqPmj32dYe9Vii4t2nA22tHZwybfVWY7YlUGwmiHwE4yYfFdIlEc9P8ZKC2/8c2CqXazAlOmIjOQ6G7AJUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l8rbpYlY; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723690925; x=1755226925;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NXsHMeGI10eXx6chKIAb94f8f941LTs8YgERcERymrM=;
  b=l8rbpYlYRdXbUIm66X8zHbrk8mTMHFq1C48VLngEUSyXrJAPQ3RVbnkU
   WjhhJhD4FsiNRS9Gmh1qWXSFjZ29b5sosexJOUcAqZuhFpUuQKHKtJO43
   bRy/qWpuyFNQlxgKhM+DKlFz7CIfvBDhPSR4jNyJX3ctS2IBp9KxWZJfw
   tr8p94JLb9utlopyr6xTSOYcr15oHl6o3WtG7KDbmDqOXdTavmQ9+TJe/
   jzOAS9nwZR0HkEsi0qrx6KjFx8bTVYnf5E/5K+0L2QnoMuBbb2HebTClI
   vRrdpZave2G9QVfriOqshiWoqmNddH+K0SFPknNsiTZRNBVF0bx+b9TGv
   w==;
X-CSE-ConnectionGUID: 3WpmVtcRQp2s/fY58KSRGA==
X-CSE-MsgGUID: eWFvV+QMSjC7IbF0C8GjDw==
X-IronPort-AV: E=McAfee;i="6700,10204,11164"; a="32513981"
X-IronPort-AV: E=Sophos;i="6.10,147,1719903600"; 
   d="scan'208";a="32513981"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2024 20:02:04 -0700
X-CSE-ConnectionGUID: vydyk6lESIeHrz3P5ZKmnQ==
X-CSE-MsgGUID: xnMhzsPjQNeY/9R8TGrVkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,147,1719903600"; 
   d="scan'208";a="58890714"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa007.fm.intel.com with ESMTP; 14 Aug 2024 20:02:02 -0700
Date: Thu, 15 Aug 2024 10:59:52 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-fpga@vger.kernel.org, Moritz Fischer <mdf@kernel.org>,
	Wu Hao <hao.wu@intel.com>, Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>
Subject: Re: [PATCH v3 1/2] fpga: mgr: Rename 'timeout' variable as
 'time_left'
Message-ID: <Zr1vKIwjAeNBVdML@yilunxu-OptiPlex-7050>
References: <20240729104319.2658-1-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240729104319.2658-1-wsa+renesas@sang-engineering.com>

On Mon, Jul 29, 2024 at 12:42:22PM +0200, Wolfram Sang wrote:
> There is a confusing pattern in the kernel to use a variable named
> 'timeout' to store the result of
> wait_for_completion_interruptible_timeout() causing patterns like:
> 
>         timeout = wait_for_completion_interruptible_timeout(...)
>         if (!timeout) return -ETIMEDOUT;
> 
> with all kinds of permutations. Use 'time_left' as a variable to make the
> code self explaining.
> 
> Fix to the proper variable type 'long' while here.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

The prefix in shortlog "fpga: mgr: " is confusing, I changed it to "fpga:
socfpga: "

Others look good to me.

Acked-by: Xu Yilun <yilun.xu@intel.com>

Applied the series to for-next.

> ---
> 
> Change since v2: reworded shortlog
> 
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

