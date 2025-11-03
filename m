Return-Path: <linux-fpga+bounces-1404-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB1A7C2CB4C
	for <lists+linux-fpga@lfdr.de>; Mon, 03 Nov 2025 16:27:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C49151887A89
	for <lists+linux-fpga@lfdr.de>; Mon,  3 Nov 2025 15:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46FA231D743;
	Mon,  3 Nov 2025 15:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Noq6qYzG"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE3F31DD99
	for <linux-fpga@vger.kernel.org>; Mon,  3 Nov 2025 15:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762182689; cv=none; b=EwOigCdtnb1v42UAfAIT9WDVe4CsPfjW/UfkF4Sc4WhtFObNtlznWEfO02zXRMwKmxqagE2ybNqZfJmekTmBj6jcFVtN0eEkyFSb7dWLkfNWwZDSfonk30/Frxk0+sMcDQ4IiOdo0Y08yd1u5gcbpI7sEKZuVWY9NK9qvEdc+28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762182689; c=relaxed/simple;
	bh=UeDgY71wV8ofQXQesgt6uqtl6ZZTF82xlAoJVei4Y0U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oppFaV8gV99miN4wSEpf9/gIzPMq+WNkTewuEMRqtHABQnxl/TGYIW0QOpbvCt5ZJHwRXCFwZQ1GOJKYks/GMlpAajXSgxGOlIItOtwllMgog+pKgkYyMoFdY9oLfrteGO2/w3Sr0r8oK9NCO265oepWMlZXvIDT++9AG6tajZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Noq6qYzG; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762182687; x=1793718687;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UeDgY71wV8ofQXQesgt6uqtl6ZZTF82xlAoJVei4Y0U=;
  b=Noq6qYzGAL6j51LAUB60RPHmt4mCl2KaVQyuz4kY3HGMZEhCatXcwgDL
   NLCpYsAkFEKo/r63D2II+NP67NCsSDuInOfcYPrYSvJfDrVIv+aQ14lIs
   AtYOv8rcIGNtENJBcKSR9z+dcLUSuyUhKP1KrdWnlyPJhUUQZf04V24oP
   sfLfaUGmuFIYcTPGLmZFf7vmhXxEE4wP/cU7CXueqxDaUET0S8z/BKe+m
   j2AI/NoKdIj17N5AcUPjo5IoZdJWEmrzvNWqKvGHGFkRux63fW3Zz8C7J
   aLQeAGqaeFad4A/VLJmViFPLJQFSTxHpyNT+LHjft2PQigJdRIhV3Ark0
   Q==;
X-CSE-ConnectionGUID: x5rfhukRRKeJ9EC2IbkHeA==
X-CSE-MsgGUID: 2V6KrjztQP2V28KHpNiSHA==
X-IronPort-AV: E=McAfee;i="6800,10657,11602"; a="75369405"
X-IronPort-AV: E=Sophos;i="6.19,276,1754982000"; 
   d="scan'208";a="75369405"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2025 07:11:27 -0800
X-CSE-ConnectionGUID: jOo6XgyURpGwQ6djYe+b/g==
X-CSE-MsgGUID: Auf+C3PYTN6fRnpuUPpRYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,276,1754982000"; 
   d="scan'208";a="210411583"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa002.fm.intel.com with ESMTP; 03 Nov 2025 07:11:25 -0800
Date: Mon, 3 Nov 2025 22:57:23 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: mdf@kernel.org, yilun.xu@intel.com, trix@redhat.com,
	linux-fpga@vger.kernel.org
Subject: Re: [PATCH] fpga: xilinx-spi: Add missing spi_device_id table
Message-ID: <aQjC0yIFp7SLcBeM@yilunxu-OptiPlex-7050>
References: <20251026110237.986279-1-festevam@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251026110237.986279-1-festevam@gmail.com>

On Sun, Oct 26, 2025 at 08:02:37AM -0300, Fabio Estevam wrote:
> The "xlnx,fpga-slave-serial" devicetree compatible string currently misses
> its SPI device ID entry. Without an spi_device_id table, the driver still
> works with device tree, but triggers the following runtime warning when
> registered via SPI core:
> 
> SPI driver xlnx-slave-spi has no spi_device_id for xlnx,fpga-slave-serial
> 
> Fix it by adding a corresponding spi_device_id table entry.
> 
> Signed-off-by: Fabio Estevam <festevam@gmail.com>
> ---
>  drivers/fpga/xilinx-spi.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/fpga/xilinx-spi.c b/drivers/fpga/xilinx-spi.c
> index 8756504340de..26348a768bbc 100644
> --- a/drivers/fpga/xilinx-spi.c
> +++ b/drivers/fpga/xilinx-spi.c
> @@ -57,6 +57,12 @@ static int xilinx_spi_probe(struct spi_device *spi)
>  	return xilinx_core_probe(core);
>  }
>  
> +static const struct spi_device_id xilinx_spi_ids[] = {
> +	{ "fpga-slave-serial" },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(spi, xilinx_spi_ids);
> +
>  #ifdef CONFIG_OF
>  static const struct of_device_id xlnx_spi_of_match[] = {
>  	{
> @@ -73,6 +79,7 @@ static struct spi_driver xilinx_slave_spi_driver = {
>  		.of_match_table = of_match_ptr(xlnx_spi_of_match),
>  	},
>  	.probe = xilinx_spi_probe,
> +	.id_table       = xilinx_spi_ids,

One whitespace is enough, I fixed it in place.

Others look good to me.

Reviewed-by: Xu Yilun <yilun.xu@linux.intel.com>

Applied to for-next, thanks

>  };
>  
>  module_spi_driver(xilinx_slave_spi_driver)
> -- 
> 2.34.1
> 
> 

