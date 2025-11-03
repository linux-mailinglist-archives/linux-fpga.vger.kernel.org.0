Return-Path: <linux-fpga+bounces-1402-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6111CC2AA9E
	for <lists+linux-fpga@lfdr.de>; Mon, 03 Nov 2025 09:59:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3145B4ECD1A
	for <lists+linux-fpga@lfdr.de>; Mon,  3 Nov 2025 08:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC40B2E3715;
	Mon,  3 Nov 2025 08:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cewlsmQm"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8EEF2E1C6F;
	Mon,  3 Nov 2025 08:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762160335; cv=none; b=lAJEKPsH/Ye1nuy0vzQKijljq7ggy7nby33RObRI9ieG0EyFFQOR9wL6LouyDr2tlnL4mPahUP5o5ISI9UPnB/0aQp0XUGz2IjsCgCS9OTh46z0f+1pLs2tLCamp8A8y56XiSgCRtcNm1N+doEapmUE8KtloL+t89N9jFgmwKqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762160335; c=relaxed/simple;
	bh=kyXRFhNZF3YdGGUinVbbVFRuVlkKQVdWx2ofydZcw6w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m2EIMj69T46dI7m2SwZnjcX2nljitit3KcNJ3ExHQFJQBlBCbVrV84MIl3rqOVjsct+d3/N48M5FM/XFH0Ld6eaQbMM8UdEPHDm6hVtcZ+bHykEBhkKJAv5zf1V1YZMM9Dw70BVYHTy6reYMNh4gfIOkkh1BGzkDLWrbxqgFlX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cewlsmQm; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762160334; x=1793696334;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kyXRFhNZF3YdGGUinVbbVFRuVlkKQVdWx2ofydZcw6w=;
  b=cewlsmQmU/XiJaL7zkQrQCFgEiAwyrw7qEuWwBazc7RnOcjkGcLPsBXz
   7G2wTCzgHVcjRxkA8ro5V/2KaIRQiFwCGra5qf37k7tQDdUy948a7Sc5z
   7AQVXL5jqhEh7AS91h6LTIqrpSKq5dnP1IuHn8IqjK2EnnbQmGNPH69yS
   aUU4+z283FdOdCNM4fIZX23nYWg2ByhfIBofNV+NpqmYFYH1jFY8WrZrh
   PjNhkgYsW1xDaCwDY5e2ZCVmA44fEzyZPGLxksuDl/PFRqkfKQOspCQgq
   ZNbzxTri3dzCGcTGd8l31vjiGcvX+54i987FvA6E7rDr6r6zTbS1UCRlj
   w==;
X-CSE-ConnectionGUID: HwQi7OKZQ0qd1ijGoiVF2g==
X-CSE-MsgGUID: ESWMJK/jSEumc0mSLVBaLQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11601"; a="75582384"
X-IronPort-AV: E=Sophos;i="6.19,275,1754982000"; 
   d="scan'208";a="75582384"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2025 00:58:22 -0800
X-CSE-ConnectionGUID: Zz5XKvBGQQCxotpwplrFhA==
X-CSE-MsgGUID: 2Hdrn2n3QxOtDLyPS5vWCw==
X-ExtLoop1: 1
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa003.fm.intel.com with ESMTP; 03 Nov 2025 00:58:20 -0800
Date: Mon, 3 Nov 2025 16:44:18 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Kuhanh Murugasen Krishnan <kuhanh.murugasen.krishnan@altera.com>
Cc: Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>, linux-fpga@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RESEND][PATCH 1/1] fpga: altera-cvp: Limit driver registration
 to specific device ID
Message-ID: <aQhrYucpkGBWI2zL@yilunxu-OptiPlex-7050>
References: <cover.1761764670.git.kuhanh.murugasen.krishnan@altera.com>
 <0b6877dd7422e8c797bb42bf071fd85cf8a0af09.1761764670.git.kuhanh.murugasen.krishnan@altera.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0b6877dd7422e8c797bb42bf071fd85cf8a0af09.1761764670.git.kuhanh.murugasen.krishnan@altera.com>

On Thu, Oct 30, 2025 at 03:05:44AM +0800, Kuhanh Murugasen Krishnan wrote:
> From: "Murugasen Krishnan, Kuhanh" <kuhanh.murugasen.krishnan@altera.com>

Is this your first post?

https://lore.kernel.org/all/20250212223553.2717304-1-kuhanh.murugasen.krishnan@intel.com/

Please mark the patch v2 if this patch is for the same issue. And please
firstly response the talk and make clear all previous concerns, rather than
just sent the patch and left.

> 
> The Altera CvP driver previously used PCI_ANY_ID, which caused it to
> bind to all PCIe devices with the Altera vendor ID. This led to
> incorrect driver association when multiple PCIe devices with different
> device IDs were present on the same platform.
> 
> Update the device ID table to use 0x00 instead of PCI_ANY_ID so that
> the driver only attaches to the intended device.

So could you please answer the previous concern here?

Does dev_id 0x00 covers all supported devices? Do you have any DOC for
this?

> 
> Reviewed-by: Dinh Nguyen <dinguyen@kernel.org>

I didn't see where the tag is from. Generally we don't prefer a
Reviewed-by tag firstly appear from other than the person named.

Thanks,
Yilun

> Signed-off-by: Ang Tien Sung <tien.sung.ang@altera.com>
> Signed-off-by: Murugasen Krishnan, Kuhanh <kuhanh.murugasen.krishnan@altera.com>
> ---
>  drivers/fpga/altera-cvp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/fpga/altera-cvp.c b/drivers/fpga/altera-cvp.c
> index 5af0bd33890c..97e9d4d981ad 100644
> --- a/drivers/fpga/altera-cvp.c
> +++ b/drivers/fpga/altera-cvp.c
> @@ -560,7 +560,7 @@ static int altera_cvp_probe(struct pci_dev *pdev,
>  static void altera_cvp_remove(struct pci_dev *pdev);
>  
>  static struct pci_device_id altera_cvp_id_tbl[] = {
> -	{ PCI_VDEVICE(ALTERA, PCI_ANY_ID) },
> +	{ PCI_VDEVICE(ALTERA, 0x00) },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(pci, altera_cvp_id_tbl);
> -- 
> 2.25.1
> 
> 

