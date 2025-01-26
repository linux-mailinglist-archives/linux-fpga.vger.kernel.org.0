Return-Path: <linux-fpga+bounces-1004-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C0CEA1C6FF
	for <lists+linux-fpga@lfdr.de>; Sun, 26 Jan 2025 09:29:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3882718867B6
	for <lists+linux-fpga@lfdr.de>; Sun, 26 Jan 2025 08:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B04C713C689;
	Sun, 26 Jan 2025 08:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W78w2Ide"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 901CD1482F5;
	Sun, 26 Jan 2025 08:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737880162; cv=none; b=WRI7k6tmzJ2vxGkQXVWux+pVXKudN2V7a6XDwbRww3wW5kENQRod3puWDHVvd06wPiYijPGJXI1yhDrw5NKq6hCGywiNvwkwXi037WGRytp91JLY50yau3ziYWG4wTIj2HH3g/g2y74L5oF0wvskvFsEJqwoRN6vp4WU+oE71yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737880162; c=relaxed/simple;
	bh=id30FrHgdekIhpGO6P9y7Sf203U4VQx52sSlCxi/MH4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oKE2Eqdxfp3J+DxWOMvnaMR16eeXb35HTUYrLrYthBhiWocaXaZP4/vLz34SiIi2G4a3HBrJKnCAlbSy6YpEqQ7vJBRVKhMicCwt+WbOyYPK9MZDUM3PUFYXS9LJNLovrXjk/ENLeZiGiiLoEIeiNSM74b+4jP+cZ+SfsTs7kcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W78w2Ide; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737880160; x=1769416160;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=id30FrHgdekIhpGO6P9y7Sf203U4VQx52sSlCxi/MH4=;
  b=W78w2IdehAetIw3p/gI1gGmPzFv+Cvm2RdbKUI7Tj3qfXP1r9UJVWu7U
   tzQ4ECqvvyjM1a8gAQixP1nhsOykp7MWyBkeWrOSHW6DxZ2WcyuPIavXC
   81r1Tn2L9EIn3oOdd3K762HU1UAzvqicubLgfK7u/GetAawL4LmcwKR1C
   lMOgMFpoZH15RXLJ46fjJ+i1DmHFvLPGtvGB4f6fr2o4mtSrqLMsA2RV9
   flQxcsAC8gVax4qZPSJtqc2Lq0sjlQpe1oFv3ZIFEYE0FGxy4XAQNS69N
   yYKHwHQtLvoNT+/OmNd4BLxJXrDl5rIf/HTs5a13WHYw2v+ZRBYXjzeDk
   g==;
X-CSE-ConnectionGUID: mCm0+3F9ScyYFZUbcbChZA==
X-CSE-MsgGUID: vVgvKrvETtuYswSqNji96w==
X-IronPort-AV: E=McAfee;i="6700,10204,11326"; a="60829893"
X-IronPort-AV: E=Sophos;i="6.13,236,1732608000"; 
   d="scan'208";a="60829893"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2025 00:29:19 -0800
X-CSE-ConnectionGUID: vgDsUFFGTbmSgjbMTztW4A==
X-CSE-MsgGUID: 2r9dY8huQC6Mgauwd/PaUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,236,1732608000"; 
   d="scan'208";a="139015778"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa002.jf.intel.com with ESMTP; 26 Jan 2025 00:29:16 -0800
Date: Sun, 26 Jan 2025 16:28:55 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Mahesh Rao <mahesh.rao@intel.com>
Cc: Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
	Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	linux-fpga@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Mahesh Rao <mahesh.rao@altera.com>
Subject: Re: [PATCH 3/3] firmware: stratix10-svc: Add
 of_platform_default_populate()
Message-ID: <Z5XyR9QE3kcQDOPe@yilunxu-OptiPlex-7050>
References: <20250122-socfpga_sip_svc_misc-v1-0-cbdcd034ae34@intel.com>
 <20250122-socfpga_sip_svc_misc-v1-3-cbdcd034ae34@intel.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250122-socfpga_sip_svc_misc-v1-3-cbdcd034ae34@intel.com>

On Wed, Jan 22, 2025 at 01:58:45PM +0800, Mahesh Rao wrote:
> Add of_platform_default_populate() to stratix10-svc
> driver as the firmware/svc node was moved out of soc.
> This fixes the failed probing of child drivers of
> svc node.
> 
> Fixes: 23c3ebed382a ("arm64: dts: socfpga: agilex: move firmware out of soc node")
> 
> Signed-off-by: Mahesh Rao <mahesh.rao@intel.com>
> ---
>  drivers/firmware/stratix10-svc.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/firmware/stratix10-svc.c b/drivers/firmware/stratix10-svc.c
> index c5c78b869561b0c1e9602823ad1f501e98e3ce51..15a7207f7753dcd4e94da4aa9a6162fedb577fe9 100644
> --- a/drivers/firmware/stratix10-svc.c
> +++ b/drivers/firmware/stratix10-svc.c
> @@ -1227,13 +1227,19 @@ static int stratix10_svc_drv_probe(struct platform_device *pdev)
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
> +	}
> +
> +	ret = of_platform_default_populate(dev_of_node(dev), NULL, dev);
> +	if (ret < 0) {

	if (ret)  is just fine.

> +		of_platform_depopulate(dev);
> +		goto err_unregister_fcs_dev;

You wanna destroy everything even if some child drivers work?
And do we need to do depopulation on driver remove?
I'm actually a little confused how to handle populate() fail and
depopulate().

Thanks,
Yilun

>  	}
>  
>  	dev_set_drvdata(dev, svc);
> @@ -1242,7 +1248,9 @@ static int stratix10_svc_drv_probe(struct platform_device *pdev)
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
> 
> -- 
> 2.35.3
> 
> 

