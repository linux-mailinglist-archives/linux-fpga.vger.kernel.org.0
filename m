Return-Path: <linux-fpga+bounces-147-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2493B833549
	for <lists+linux-fpga@lfdr.de>; Sat, 20 Jan 2024 16:32:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 528531C2136E
	for <lists+linux-fpga@lfdr.de>; Sat, 20 Jan 2024 15:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FA50D2F3;
	Sat, 20 Jan 2024 15:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fum0yRz/"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8FC810940;
	Sat, 20 Jan 2024 15:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.134.136.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705764762; cv=none; b=K3OEbDEtgI4/pPt5L9ifri/ZBPyJKvtRoGH7knnnoLs4C6AaiJjpmXUnlX3GW6yLfg1DW65V7M9suKEZinyH+RBABgtaYGNOv/aN6bw+hs9/glcbJX3EJvW/Uho17apkPZo283ge1POZpNalxOGs6ZC1rFJZrDegIbe6l93fXlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705764762; c=relaxed/simple;
	bh=ZVLH7u/U6jxX5Y2VaOnTwNwg893pSmh33v6yA/+MIGM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qENaFWDAwnTwy8eulQJF2bLcmB3ybICJEJ5iuZeVIFFxjGTRLCGtQbzeQfeRj7WFDe2JKvOp0i1pKRRlf4KIdwRDy5X2oGCFHvGBhNZWSsmkBCg9igKS5Q0kT6ddOhScy9SjRyPwgxJYIDalbr4pSvS2six8QStHw4AzkwYrPuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fum0yRz/; arc=none smtp.client-ip=134.134.136.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705764760; x=1737300760;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=ZVLH7u/U6jxX5Y2VaOnTwNwg893pSmh33v6yA/+MIGM=;
  b=fum0yRz/r//ePIE0dZ6rUzcDpv7gbSZHABpke0RgJ7Ux51Sjc6ERwc4Y
   pdMEIXhsONq5DU0iUCfy10Nh7VHDqtGIrHk2vE3Ty605vlf7X75NF5bFK
   tCg9NgWDXwy4w82gBShj9M7rCa9C8fodQSWCQtAH3pHuux15Y5gZ5SS8a
   a71WQam/+Qe3VyzLmU0cluYLqav11Qd6DdWabAK/r4D3LofBPXCZ4RYPt
   6AcN8iCTrvetNWBXOBn7goXke6VljUL/BC00s1YqZAvKxUvvm8hl64QZl
   SvOaLuk3FuvGfeKhc2vrU6D2YUZT5UKoy3dcFITXrGEaQjrabzSqFhkXk
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10959"; a="465217793"
X-IronPort-AV: E=Sophos;i="6.05,208,1701158400"; 
   d="scan'208";a="465217793"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2024 07:32:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10959"; a="875607176"
X-IronPort-AV: E=Sophos;i="6.05,208,1701158400"; 
   d="scan'208";a="875607176"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by FMSMGA003.fm.intel.com with ESMTP; 20 Jan 2024 07:32:36 -0800
Date: Sat, 20 Jan 2024 23:29:24 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Mark Brown <broonie@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	linux-spi@vger.kernel.org, kernel@pengutronix.de,
	Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
	Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
	linux-fpga@vger.kernel.org
Subject: Re: [PATCH 01/33] fpga: ice40-spi: Follow renaming of SPI "master"
 to "controller"
Message-ID: <Zavm1K/1wvQlRHcy@yilunxu-OptiPlex-7050>
References: <cover.1705348269.git.u.kleine-koenig@pengutronix.de>
 <caef8566918e708daee60c211ab2d12b926f95a5.1705348269.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <caef8566918e708daee60c211ab2d12b926f95a5.1705348269.git.u.kleine-koenig@pengutronix.de>

On Mon, Jan 15, 2024 at 09:12:47PM +0100, Uwe Kleine-König wrote:
> In commit 8caab75fd2c2 ("spi: Generalize SPI "master" to "controller"")
> some functions and struct members were renamed. To not break all drivers
> compatibility macros were provided.
> 
> To be able to remove these compatibility macros push the renaming into
> this driver.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Acked-by: Xu Yilun <yilun.xu@intel.com>

> ---
>  drivers/fpga/ice40-spi.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/fpga/ice40-spi.c b/drivers/fpga/ice40-spi.c
> index 7cbb3558b844..c0028ae4c5b7 100644
> --- a/drivers/fpga/ice40-spi.c
> +++ b/drivers/fpga/ice40-spi.c
> @@ -66,7 +66,7 @@ static int ice40_fpga_ops_write_init(struct fpga_manager *mgr,
>  	}
>  
>  	/* Lock the bus, assert CRESET_B and SS_B and delay >200ns */
> -	spi_bus_lock(dev->master);
> +	spi_bus_lock(dev->controller);
>  
>  	gpiod_set_value(priv->reset, 1);
>  
> @@ -94,7 +94,7 @@ static int ice40_fpga_ops_write_init(struct fpga_manager *mgr,
>  	ret = spi_sync_locked(dev, &message);
>  
>  fail:
> -	spi_bus_unlock(dev->master);
> +	spi_bus_unlock(dev->controller);
>  
>  	return ret;
>  }
> -- 
> 2.43.0
> 
> 

