Return-Path: <linux-fpga+bounces-1074-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5BC3A4A9DC
	for <lists+linux-fpga@lfdr.de>; Sat,  1 Mar 2025 09:53:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 933A13B94D3
	for <lists+linux-fpga@lfdr.de>; Sat,  1 Mar 2025 08:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BCC21C5D59;
	Sat,  1 Mar 2025 08:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NTfUZZoO"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40386635;
	Sat,  1 Mar 2025 08:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740819215; cv=none; b=XtRJKwaQiubKpZflntgSH0vR6Cq7i+e1VfFBES70sp/odh+a8c7IOG7TjonOjyQ9rBgvolBERgkrpvH3DVDxEo1JwR0trvUzOA/wuf460g9vy8ZMXUdL4z2YdZIkKB+0OGV2XSXZ0ECi6eGkN8dcbptSjgrQdITT26eagvD2IY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740819215; c=relaxed/simple;
	bh=ar6TR2EgMbDce6X1p+ZsxCh9Alfb6QI+qnDMAqZmejg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WQq1hnGhDHLsmLZ0bD3qTBWmcoFCucbjDZlysz3yXU/wpfN8Ax/w+j058QeTS9U6nB/R6ZZd0fFVBANK7hN6sekSEK/Gr3/6yskwCKq1GkjK7wd5mfoFQmVO53Adl7r4l5p2pXfSKDDaefLTdRCW8UBvIe/c4zYOiKwdKd1ulCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NTfUZZoO; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740819215; x=1772355215;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ar6TR2EgMbDce6X1p+ZsxCh9Alfb6QI+qnDMAqZmejg=;
  b=NTfUZZoOQbZkxyBen0g1r0jN+NK9U43VGoBgCqrpZv1ATwF4TmFO9Y88
   s2cfIQm9L2n0EPuWF4YzIl6W3M84gVXOj1FSZJinkbdVQM6yjK6gUZbX6
   5Nl+HP2yfQqrybRQ1S5jHLtYRgzHWhEUUYfv2QnYYVBFUeCCvL/UO5vp1
   HR1bs6sHRPaO/440ivdJZwiCwX4M6MhiuVoIqKMTsURmr+/k4iGrVojRM
   Mzpgm+BblrbcXY0TgPcVTBjtZn23P3874FuFIrHukV8Q5MC+FmUdsk8ru
   Z/OjGnKO4cexIFEAcrsn8fjZsXvd+EJ1UaOAmOuL9AJHf0cJ4xYaqsCRy
   g==;
X-CSE-ConnectionGUID: DhGjtF9iTa2mI7rxSCKrTw==
X-CSE-MsgGUID: 9u/nDUezTkW6iRdMS4R+fA==
X-IronPort-AV: E=McAfee;i="6700,10204,11359"; a="45399275"
X-IronPort-AV: E=Sophos;i="6.13,324,1732608000"; 
   d="scan'208";a="45399275"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2025 00:53:34 -0800
X-CSE-ConnectionGUID: 6FtvhrIbSEiHaeprAZNMew==
X-CSE-MsgGUID: Yu+4gPYIQIew8WE56firig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,324,1732608000"; 
   d="scan'208";a="117731711"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa008.fm.intel.com with ESMTP; 01 Mar 2025 00:53:31 -0800
Date: Sat, 1 Mar 2025 16:51:32 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Kuhanh Murugasen Krishnan <kuhanh.murugasen.krishnan@intel.com>
Cc: Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
	Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
	linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
	kuhanh.murugasen.krishnan@altera.com,
	Ang Tien Sung <tien.sung.ang@intel.com>
Subject: Re: [PATCH] fpga: altera-cvp: PCIex8x8 ports
Message-ID: <Z8LKlNv9BiH6feaV@yilunxu-OptiPlex-7050>
References: <20250212223553.2717304-1-kuhanh.murugasen.krishnan@intel.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250212223553.2717304-1-kuhanh.murugasen.krishnan@intel.com>

On Thu, Feb 13, 2025 at 06:35:53AM +0800, Kuhanh Murugasen Krishnan wrote:
First of all, please rewrite your shortlog. It doesn't indicate what
you've done.

> Enabling the possibility of supporting multiple
> PCIe devices from Intel Altera FPGA but with different
> device ids. The current driver registers itself
> to all device IDs which causes an incorrect driver
> association.

Please first state what you've done and what's the problem.

> 
> Signed-off-by: Ang Tien Sung <tien.sung.ang@intel.com>
> Signed-off-by: Kuhanh Murugasen Krishnan <kuhanh.murugasen.krishnan@intel.com>
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

Does dev_id == 0x00 covers all supported devices? It's a little wield to
me, do you have some DOC?

Thanks,
Yilun

>  	{ }
>  };
>  MODULE_DEVICE_TABLE(pci, altera_cvp_id_tbl);
> -- 
> 2.25.1
> 
> 

