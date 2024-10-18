Return-Path: <linux-fpga+bounces-784-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38EDC9A3223
	for <lists+linux-fpga@lfdr.de>; Fri, 18 Oct 2024 03:40:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B4D91C22222
	for <lists+linux-fpga@lfdr.de>; Fri, 18 Oct 2024 01:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9952F558BC;
	Fri, 18 Oct 2024 01:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oIRpCoyn"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76345674E;
	Fri, 18 Oct 2024 01:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729215649; cv=none; b=eqmt/Zof2VQAPLEpBLw7zCl7e5hE7UPS7pJlAN7TJASlVN4R9GEWUHQ08NGKO+nR21rz+RWrTpNF5r3bU0D8dCfLDfqpleEmwYBMWCbP2qTK3jISfEGPV0Mtb7Z40vhGeVWenMx9oMo45K8g29ghUY+8YsOUpuXAvQ60DW22GcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729215649; c=relaxed/simple;
	bh=gnx+T2ezsb+2zjEA9UUOW2YV70qdikkVin4OJPOZuCg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FzY7LDxScCdeWWTfpO4XccVkxVN0vpQ0WTl9qaPACyOse0/nJ+5hMQhXL4btky56pfy8hyToMcd2tu8quLF9vKAycQBl56UeeqLFg1UPmVbKVSeBbGLl016MYNtu4LyPnmeBa1pT6nksmknhjQQQdOw2LHaM+Pdit1p7DyVuD8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oIRpCoyn; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729215648; x=1760751648;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gnx+T2ezsb+2zjEA9UUOW2YV70qdikkVin4OJPOZuCg=;
  b=oIRpCoyn0sVoI7vgljHGSsmDY54e1YvVawjzJvWFtOZlpL/aaRjBN+Xu
   RbBL+spwGDix8VxevMVIULbaqWDsnaF1zhkaXTxJG6Q33wc4jzmw9Np6z
   01h8x+jtGCaVuu/7ydUWCvGMv0mflHmq22nq6FPAMwooFhqnqWZ/fhsFY
   lyoXEPGJ5OtjTFyHS25gsfTRfSWF2gzc3utC/inZIgcg/6xDdGYTAE1JW
   GA+cW41WcnS0bfxIYcFe5XADOpZdenJMzdmlxFRRrQB0ImAtjfRoV5mmB
   GrdjYapwPOuaeC/kCb44cSp4+SUpA3idh996JtBiMIg8mbG3I6xxDQ5yz
   Q==;
X-CSE-ConnectionGUID: 7AFuOB5WSrGfdTgTVO+lLg==
X-CSE-MsgGUID: cIrqoMhWSaOnxCRgeiC8NA==
X-IronPort-AV: E=McAfee;i="6700,10204,11228"; a="31600069"
X-IronPort-AV: E=Sophos;i="6.11,212,1725346800"; 
   d="scan'208";a="31600069"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 18:40:47 -0700
X-CSE-ConnectionGUID: z6JeZNnfTPie96BeQlwMoA==
X-CSE-MsgGUID: CYi6Ge/mRDKNDUqFFnbDbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,212,1725346800"; 
   d="scan'208";a="83293289"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa005.fm.intel.com with ESMTP; 17 Oct 2024 18:40:43 -0700
Date: Fri, 18 Oct 2024 09:37:22 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: iansdannapel@gmail.com
Cc: mdf@kernel.org, hao.wu@intel.com, yilun.xu@intel.com, trix@redhat.com,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	neil.armstrong@linaro.org, heiko.stuebner@cherry.de,
	rafal@milecki.pl, linus.walleij@linaro.org,
	linux-fpga@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] fpga: Add Efinix Trion & Titanium serial SPI
 programming driver
Message-ID: <ZxG70kzjsvT3UBlQ@yilunxu-OptiPlex-7050>
References: <20240927141445.157234-1-iansdannapel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240927141445.157234-1-iansdannapel@gmail.com>

On Fri, Sep 27, 2024 at 04:14:42PM +0200, iansdannapel@gmail.com wrote:
> From: Ian Dannapel <iansdannapel@gmail.com>
> 
> Add a new driver for loading binary firmware to volatile
> configuration RAM using "SPI passive programming" on Efinix FPGAs.
> 
> Signed-off-by: Ian Dannapel <iansdannapel@gmail.com>
> ---
>  drivers/fpga/Kconfig                    |  10 ++
>  drivers/fpga/Makefile                   |   1 +
>  drivers/fpga/efinix-trion-spi-passive.c | 211 ++++++++++++++++++++++++
>  3 files changed, 222 insertions(+)
>  create mode 100644 drivers/fpga/efinix-trion-spi-passive.c
> 
> diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
> index 37b35f58f0df..eb1e44c4e3e0 100644
> --- a/drivers/fpga/Kconfig
> +++ b/drivers/fpga/Kconfig
> @@ -83,6 +83,16 @@ config FPGA_MGR_XILINX_SPI
>  	  FPGA manager driver support for Xilinx FPGA configuration
>  	  over slave serial interface.
>  
> +config FPGA_MGR_EFINIX_SPI
> +	tristate "Efinix FPGA configuration over SPI passive"
> +	depends on SPI
> +	help
> +	  This option enables support for the FPGA manager driver to
> +	  configure Efinix Trion and Titanium Series FPGAs over SPI
> +	  using passive serial mode.
> +	  Warning: Do not activate this if there are other SPI devices
> +	  on the same bus as it might interfere with the transmission.

Sorry, this won't work. As you can see, the conflict usage of CS causes
several concerns. Just a text here is far from enough.

You need to actively work with SPI core/controller drivers to find a
solution that coordinate the usage of this pin.

Thanks
Yilun

