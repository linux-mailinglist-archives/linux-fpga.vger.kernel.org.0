Return-Path: <linux-fpga+bounces-1280-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A151AFE32E
	for <lists+linux-fpga@lfdr.de>; Wed,  9 Jul 2025 10:50:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B30057B75D7
	for <lists+linux-fpga@lfdr.de>; Wed,  9 Jul 2025 08:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76F6D27F182;
	Wed,  9 Jul 2025 08:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nY9o6Ybb"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9DF272E63;
	Wed,  9 Jul 2025 08:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752051032; cv=none; b=L5R6MqDtegJlBLDiWZOzzE1QiQkCyFAiKlRQ0prYuYs7s3NY1Rh+SnVw66a5Kzth9XZiRtJvGGE5oJEI98np032K7jSRtd8bwHvyEGV/IqHDUQpDqRqQ4PSkaFNdPFHHYZwHYyXO0CHf0cXlTVJ9B+ly8t4L9Fjmfkan6HuNizI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752051032; c=relaxed/simple;
	bh=PmijWoo8arFesx63Y/hi1iglL6Yr53cGkDtSDwK7P+o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b1lXO31uAED9EurQES/ETGIkX4ArggqLXb95EPPAiL3+V8Y0fNSvuui09jpkmnEolqyYRbNzlySbUys6qWdaIlM3c9Q07VeiFgz+3HPl+WWFWEjQBg0s7P2oFvMeLy5Ul5KAsMnJxhzO4/CViFuD7H1ofwHN2aXiuc4H5wXx6CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nY9o6Ybb; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752051031; x=1783587031;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PmijWoo8arFesx63Y/hi1iglL6Yr53cGkDtSDwK7P+o=;
  b=nY9o6Ybbpbu9U4QkEZLYjvy9NLHViqN+AlwtDTrSw4FD8mi7gNuQ4/O0
   YLSP35Cu1aH4kZ6aplVVOyMuIQZlhVCurFHIG6n5twTG+/keDcYrw7XCM
   7XbJP3uVOnsJokn9keb+Eoh4Sg977rmoKX8x+u8xV4tNKw24LOQfxXg6d
   Z4DH/hC+NeWO/SS7BxIa4hskBm/1nsHvFZRyoZwE07lrS72KN2waaGATH
   +A763OsGg7HD1M3Q8IgldUaZ2JgXZO1AAZCIf54E39IUgtinohZSLFMvF
   eNydcTAbfkRl1re0rRZdEbIV7wFM0EZ1ePypJmKapXZqYGrKoYECmmTx3
   A==;
X-CSE-ConnectionGUID: cOfw2RvoRD6YwKI2Y3hATA==
X-CSE-MsgGUID: KJJcB5XYSsem96kXVQIMqA==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="58110196"
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="58110196"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2025 01:50:30 -0700
X-CSE-ConnectionGUID: VHTXJY2tQ+6+fRGT39xP7w==
X-CSE-MsgGUID: 0wOOL00WTG+9kuIJiQNzNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="186688596"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa001.fm.intel.com with ESMTP; 09 Jul 2025 01:50:29 -0700
Date: Wed, 9 Jul 2025 16:42:12 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Xu Yilun <yilun.xu@intel.com>, linux-fpga@vger.kernel.org,
	linux-kernel@vger.kernel.org, Moritz Fischer <mdf@kernel.org>,
	Wu Hao <hao.wu@intel.com>, Tom Rix <trix@redhat.com>
Subject: Re: [PATCH v2 1/1] fpga: altera-cvp: Use pci_find_vsec_capability()
 when probing FPGA device
Message-ID: <aG4rZNGgROrXXy+F@yilunxu-OptiPlex-7050>
References: <20250627112635.789872-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250627112635.789872-1-andriy.shevchenko@linux.intel.com>

On Fri, Jun 27, 2025 at 02:26:22PM +0300, Andy Shevchenko wrote:
> Currently altera_cvp_probe() open-codes pci_find_vsec_capability().
> Refactor the former to use the latter. No functional change intended.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> 
> v2: removed unused variable (LKP)
> 
>  drivers/fpga/altera-cvp.c | 20 +++++---------------
>  1 file changed, 5 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/fpga/altera-cvp.c b/drivers/fpga/altera-cvp.c
> index 5af0bd33890c..514d2ac18e5f 100644
> --- a/drivers/fpga/altera-cvp.c
> +++ b/drivers/fpga/altera-cvp.c
> @@ -22,9 +22,6 @@
>  #define TIMEOUT_US	2000	/* CVP STATUS timeout for USERMODE polling */
>  
>  /* Vendor Specific Extended Capability Registers */
> -#define VSE_PCIE_EXT_CAP_ID		0x0
> -#define VSE_PCIE_EXT_CAP_ID_VAL		0x000b	/* 16bit */
> -
>  #define VSE_CVP_STATUS			0x1c	/* 32bit */
>  #define VSE_CVP_STATUS_CFG_RDY		BIT(18)	/* CVP_CONFIG_READY */
>  #define VSE_CVP_STATUS_CFG_ERR		BIT(19)	/* CVP_CONFIG_ERROR */
> @@ -577,25 +574,18 @@ static int altera_cvp_probe(struct pci_dev *pdev,
>  {
>  	struct altera_cvp_conf *conf;
>  	struct fpga_manager *mgr;
> -	int ret, offset;
> -	u16 cmd, val;
> +	u16 cmd, offset;
>  	u32 regval;
> -
> -	/* Discover the Vendor Specific Offset for this device */
> -	offset = pci_find_next_ext_capability(pdev, 0, PCI_EXT_CAP_ID_VNDR);
> -	if (!offset) {
> -		dev_err(&pdev->dev, "No Vendor Specific Offset.\n");
> -		return -ENODEV;
> -	}
> +	int ret;
>  
>  	/*
>  	 * First check if this is the expected FPGA device. PCI config
>  	 * space access works without enabling the PCI device, memory
>  	 * space access is enabled further down.
>  	 */
> -	pci_read_config_word(pdev, offset + VSE_PCIE_EXT_CAP_ID, &val);
> -	if (val != VSE_PCIE_EXT_CAP_ID_VAL) {
> -		dev_err(&pdev->dev, "Wrong EXT_CAP_ID value 0x%x\n", val);
> +	offset = pci_find_vsec_capability(pdev, PCI_VENDOR_ID_ALTERA, 0);

Mm.. the original code seems broken. It doesn't check the VSEC ID. And
you filled '0'. Is '0' specified in any SPEC? I didn't see it as a
wildcard.

Anyway, we should describe the change and remove "No functional change
intended".

> +	if (!offset) {
> +		dev_err(&pdev->dev, "Wrong EXT_CAP_ID value\n");

Should be "VSEC ID not found"

Thanks,
Yilun

>  		return -ENODEV;
>  	}
>  
> -- 
> 2.47.2
> 
> 

