Return-Path: <linux-fpga+bounces-1043-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10352A2A1C6
	for <lists+linux-fpga@lfdr.de>; Thu,  6 Feb 2025 08:07:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B83F1887159
	for <lists+linux-fpga@lfdr.de>; Thu,  6 Feb 2025 07:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 926CB1FE461;
	Thu,  6 Feb 2025 07:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KmdDjhgS"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7057145B3E;
	Thu,  6 Feb 2025 07:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738825623; cv=none; b=aR6lgaKw6aK6UfpVFN5JII0R8lo3ESDfXho+cMAwmd5e1X8Qt1sobn02LxGcPapMCZHMRZszvjDMYXfTID+hdBcOSUoJ87du4jkk5zxZvS+yYheybmVdI7PrRyM8RS9bx2Lpyt7FFQbPbOA2tRxrKOLiKLozQgLOCL9T7olouTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738825623; c=relaxed/simple;
	bh=4s/rd6ox4/7YQRDgSwO2fPO7qLeAZL+viGcf5t53deQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CJWGwbEWa1sxacgCYMveKiCNz9xbu3kmGz5IF2Du2J75m5/dJewY9cDUB+fV0lCfTRTl5Mjlz0qCuVuWs+Eyy+IopcoAU+Zx9hArdAGNreac3JcPDilRWVDfIsY4UGnyaNgJIiI39kEYrGnTx9Vi/f/HKYT3UzsoCe6x9uvlRYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KmdDjhgS; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738825621; x=1770361621;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4s/rd6ox4/7YQRDgSwO2fPO7qLeAZL+viGcf5t53deQ=;
  b=KmdDjhgSLdE2AqpmlwKIpYDdGv309Q2UM3CpzcanJTt2YNKC2urcAGpP
   i4PFN7+KpE9yONaLaC2U56i/3lg87xT4jOfZuQrER8gwZq+HdHHMEjUA+
   fKrWsKXFJV7o9GgY4zdYZnJyGPJgqM5KSCGTCNqa2R3PRXHhvEc4/Rky/
   hMJHizYz6tfZR/Tc28chQ9qtOKB4IQG0EmmHChKg2gmT6d6kHAoqU0WVv
   B+wZAwAxWzZBNfJn9LVVSmzkmpLtp4kwr5m2GB9KneeOc28jHmg8UH/A4
   BDYT8T5VHOoO5m6Cs7+lrSzH9QBZBRXP55Rb/7n6E0SsLGwFhSVFWg6HF
   g==;
X-CSE-ConnectionGUID: HF9xww6BQQmgu0wPNz5s/Q==
X-CSE-MsgGUID: DdR73e9vR5y/0gYByR15Sg==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="50840507"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="50840507"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2025 23:07:01 -0800
X-CSE-ConnectionGUID: Ek0RWKdIQEqcK8J84mFO1A==
X-CSE-MsgGUID: GeKq7cOFTQOPH6MIsu9jTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,263,1732608000"; 
   d="scan'208";a="116160577"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa004.fm.intel.com with ESMTP; 05 Feb 2025 23:06:58 -0800
Date: Thu, 6 Feb 2025 15:06:05 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Mahesh Rao <mahesh.rao@intel.com>
Cc: Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Wu Hao <hao.wu@intel.com>, Ho Yin <adrian.ho.yin.ng@altera.com>,
	Niravkumar L Rabara <nirav.rabara@altera.com>,
	linux-fpga@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Mahesh Rao <mahesh.rao@altera.com>
Subject: Re: [PATCH v3 3/3] firmware: stratix10-svc: Add
 of_platform_default_populate()
Message-ID: <Z6RfXSzMEVPlZAj6@yilunxu-OptiPlex-7050>
References: <20250204-socfpga_sip_svc_misc-v3-0-697f7f153cfa@intel.com>
 <20250204-socfpga_sip_svc_misc-v3-3-697f7f153cfa@intel.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250204-socfpga_sip_svc_misc-v3-3-697f7f153cfa@intel.com>

On Tue, Feb 04, 2025 at 08:58:07PM +0800, Mahesh Rao wrote:
> Add of_platform_default_populate() to stratix10-svc
> driver as the firmware/svc node was moved out of soc.
> This fixes the failed probing of child drivers of
> svc node.
> 
> Fixes: 23c3ebed382a ("arm64: dts: socfpga: agilex: move firmware out of soc node")
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Mahesh Rao <mahesh.rao@intel.com>
> ---
>  drivers/firmware/stratix10-svc.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/firmware/stratix10-svc.c b/drivers/firmware/stratix10-svc.c
> index 3c52cb73237a43aac6984e497d75bab389e3eb9d..e3f990d888d71829f0ab22b8a59aa7af0316bea0 100644
> --- a/drivers/firmware/stratix10-svc.c
> +++ b/drivers/firmware/stratix10-svc.c
> @@ -1224,22 +1224,28 @@ static int stratix10_svc_drv_probe(struct platform_device *pdev)
>  	if (!svc->intel_svc_fcs) {
>  		dev_err(dev, "failed to allocate %s device\n", INTEL_FCS);
>  		ret = -ENOMEM;
> -		goto err_unregister_dev;
> +		goto err_unregister_rsu_dev;
>  	}
>  
>  	ret = platform_device_add(svc->intel_svc_fcs);
>  	if (ret) {
>  		platform_device_put(svc->intel_svc_fcs);
> -		goto err_unregister_dev;
> +		goto err_unregister_rsu_dev;
>  	}
>  
> +	ret = of_platform_default_populate(dev_of_node(dev), NULL, dev);

I checked of_platform_populate/of_platform_bus_create() and see these
functions will not error out if some sub device registration fails. So
LGTM.

Reviewed-by: Xu Yilun <yilun.xu@intel.com>

> +	if (ret)
> +		goto err_unregister_fcs_dev;
> +
>  	dev_set_drvdata(dev, svc);
>  
>  	pr_info("Intel Service Layer Driver Initialized\n");
>  
>  	return 0;
>  
> -err_unregister_dev:
> +err_unregister_fcs_dev:
> +	platform_device_unregister(svc->intel_svc_fcs);
> +err_unregister_rsu_dev:
>  	platform_device_unregister(svc->stratix10_svc_rsu);
>  err_free_kfifo:
>  	kfifo_free(&controller->svc_fifo);
> @@ -1253,6 +1259,8 @@ static void stratix10_svc_drv_remove(struct platform_device *pdev)
>  	struct stratix10_svc *svc = dev_get_drvdata(&pdev->dev);
>  	struct stratix10_svc_controller *ctrl = platform_get_drvdata(pdev);
>  
> +	of_platform_depopulate(ctrl->dev);
> +
>  	platform_device_unregister(svc->intel_svc_fcs);
>  	platform_device_unregister(svc->stratix10_svc_rsu);
>  
> 
> -- 
> 2.35.3
> 
> 

