Return-Path: <linux-fpga+bounces-540-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CEA69035FC
	for <lists+linux-fpga@lfdr.de>; Tue, 11 Jun 2024 10:23:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4AA11B282CA
	for <lists+linux-fpga@lfdr.de>; Tue, 11 Jun 2024 08:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A7F7175550;
	Tue, 11 Jun 2024 08:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xy5ALjan"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A85A217555C;
	Tue, 11 Jun 2024 08:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718094180; cv=none; b=E33XF9m4WbswG6y072FIDtqwwgqZk11Q2uOdR0yyLb9rh25Q7+PD3GLJIErafigmyUxE5qxU1xrpRYIRY8fF9Di+qOI6mrVml8dTxXB4LbxgEZSxXc+HzNmnFYJEy/8Wd88prZy3JN0RSMRnFhRCgA1eFvzEW/+k1N28VgwVhCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718094180; c=relaxed/simple;
	bh=786a5wY0QXYHrNG/L0TQ605yN2Wh/vHaRq3S4UiZJ8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WPwVtKbGZ9eTfgBKODrEOhkZVBdNT0YxTDndGnoKEfdl9ox3AHE4PPFGyQjEWydaHpkGwEliKBSy4URjlNpSjR/3HlBK+hjlW1Ipbs3LLon19jDEbFi3BdE9J1bCrzIRMT4NnPDnt2QH4JGeoPhe+JGyjrqHyuPJtULd36bEA7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xy5ALjan; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718094178; x=1749630178;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=786a5wY0QXYHrNG/L0TQ605yN2Wh/vHaRq3S4UiZJ8o=;
  b=Xy5ALjanCSn7Q3IBW+dH0mlxoEHE/IpPIuotwT1biEKlDODaPAzp0iiD
   KTpiUL3VWLbK+sG+o0WFw5oLVnY2ZC8xYfVHJuO6LVXJ0Q5FexIEuNveC
   H+c3DilhwLHhUg51hIIBPWVE5ZvA9Nw65RgoVhdya3wbhU79jQb6sed1q
   KZLLnWFy+mDCJZtmlTz0uHhJnul7jpF2coFY8Pll+/d66ngteCAbgLQ1f
   bwJOiLe9GQXBpHo8Q6CkWvp7g+2iNE+GTrxWw1/QYAUZgahdkWFiv82J+
   0Z1pksOv5hnwy2Wo4usNKcAeQLQLHpo9OvfK1BgSW2F9PpgqVYw0svGsO
   g==;
X-CSE-ConnectionGUID: SLsxXUR5Syy5+pDYGJPkuw==
X-CSE-MsgGUID: I9fHnb+BTsCiv8oyAsobyA==
X-IronPort-AV: E=McAfee;i="6600,9927,11099"; a="14940532"
X-IronPort-AV: E=Sophos;i="6.08,229,1712646000"; 
   d="scan'208";a="14940532"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2024 01:22:58 -0700
X-CSE-ConnectionGUID: 8z/dgvKdROqOfJTML1wGpA==
X-CSE-MsgGUID: otyFK9PySg+mj5B5YkqoUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,229,1712646000"; 
   d="scan'208";a="39300182"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa010.jf.intel.com with ESMTP; 11 Jun 2024 01:22:56 -0700
Date: Tue, 11 Jun 2024 16:16:28 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: linux@treblig.org
Cc: mdf@kernel.org, hao.wu@intel.com, linux-fpga@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fpga: altera-fpga2sdram: remove unused struct 'prop_map'
Message-ID: <ZmgH3FakPP2w/ksI@yilunxu-OptiPlex-7050>
References: <20240530205245.125513-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240530205245.125513-1-linux@treblig.org>

On Thu, May 30, 2024 at 09:52:45PM +0100, linux@treblig.org wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>

This is only needed if the person sending the patch is not the author.

> 
> 'prop_map' has been unused since the original
> commit e5f8efa5c8bf ("ARM: socfpga: fpga bridge driver support").

Please use 'fixes:' tag.

Thanks,
Yilun

> 
> Remove it.
> 
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> ---
>  drivers/fpga/altera-fpga2sdram.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/drivers/fpga/altera-fpga2sdram.c b/drivers/fpga/altera-fpga2sdram.c
> index 6b60ca004345..f4de3fea0b2d 100644
> --- a/drivers/fpga/altera-fpga2sdram.c
> +++ b/drivers/fpga/altera-fpga2sdram.c
> @@ -75,12 +75,6 @@ static int alt_fpga2sdram_enable_set(struct fpga_bridge *bridge, bool enable)
>  	return _alt_fpga2sdram_enable_set(bridge->priv, enable);
>  }
>  
> -struct prop_map {
> -	char *prop_name;
> -	u32 *prop_value;
> -	u32 prop_max;
> -};
> -
>  static const struct fpga_bridge_ops altera_fpga2sdram_br_ops = {
>  	.enable_set = alt_fpga2sdram_enable_set,
>  	.enable_show = alt_fpga2sdram_enable_show,
> -- 
> 2.45.1
> 
> 

