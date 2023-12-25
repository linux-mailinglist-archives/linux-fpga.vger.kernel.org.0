Return-Path: <linux-fpga+bounces-89-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61BCC81DE7F
	for <lists+linux-fpga@lfdr.de>; Mon, 25 Dec 2023 07:04:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 121881F2142D
	for <lists+linux-fpga@lfdr.de>; Mon, 25 Dec 2023 06:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56EAE1106;
	Mon, 25 Dec 2023 06:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PmIF6v9g"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79EC610FE
	for <linux-fpga@vger.kernel.org>; Mon, 25 Dec 2023 06:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703484261; x=1735020261;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=8f79OUvLC01amUasSEUepwOEdV+ZLJEnJMzpx6JOZLE=;
  b=PmIF6v9ghFAdA+Unc7rwtHOmklUa+flfdC6f/fc69+oFnpIwLGKqLH+t
   UJBnEmXqcsLW+v6ynPP3Eb8+RJIBPiIs8pwIpOON/vaqdi9NZZt/FSuwC
   gg7cd3J1wCrtee2inRvUNZA2+odBbw3qyTmI6grNiYCqqoglVGBhTbfk9
   me1gf7DLwHllmdzSCiaL8Dap4Q+Yfmi2K6fQuQDtaq2Ir7fWNvKO9WWN0
   yBG9O444Ek8cPay0gbJPpn4m+dS+tYwhwmWR2oqtl/ZL0cYYvMpLYxZss
   krsLaJLgvUI4IyWXLInWtgrIpismFjeFYe2BZhnEO1nyHUWG0QeTVoTgc
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10934"; a="395158227"
X-IronPort-AV: E=Sophos;i="6.04,302,1695711600"; 
   d="scan'208";a="395158227"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Dec 2023 22:04:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10934"; a="781183486"
X-IronPort-AV: E=Sophos;i="6.04,302,1695711600"; 
   d="scan'208";a="781183486"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmsmga007.fm.intel.com with ESMTP; 24 Dec 2023 22:04:17 -0800
Date: Mon, 25 Dec 2023 14:01:40 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
	Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
	linux-fpga@vger.kernel.org, kernel@pengutronix.de,
	Peter Colberg <peter.colberg@intel.com>,
	Michal Simek <michal.simek@amd.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 00/13] fpga: Convert to platform remove callback
 returning void
Message-ID: <ZYkaxIFf4rxiiDOR@yilunxu-OptiPlex-7050>
References: <cover.1703006638.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1703006638.git.u.kleine-koenig@pengutronix.de>

On Tue, Dec 19, 2023 at 06:31:58PM +0100, Uwe Kleine-König wrote:
> Hello,
> 
> this series converts all drivers below drivers/fpga to use
> .remove_new(). See commit 5c5a7680e67b ("platform: Provide a remove
> callback that returns no value") for an extended explanation and the
> eventual goal. The TL;DR; is to make it harder for driver authors to
> leak resources without noticing.
> 
> This is merge window material. All patches are pairwise independent of
> each other, so they could be applied individually. Getting them all in
> together would be nicer though :-)
> 
> Best regards
> Uwe
> 
> Uwe Kleine-König (13):
>   fpga: altera-fpga2sdram: Convert to platform remove callback returning void
>   fpga: altera-freeze-bridge: Convert to platform remove callback returning void
>   fpga: altera-hps2fpga: Convert to platform remove callback returning void
>   fpga: dfl-afu-main: Convert to platform remove callback returning void
>   fpga: dfl-fme-br: Convert to platform remove callback returning void
>   fpga: dfl-fme-main: Convert to platform remove callback returning void
>   fpga: dfl-fme-region: Convert to platform remove callback returning void
>   fpga: intel-m10-bmc-sec-update: Convert to platform remove callback returning void
>   fpga: of-fpga-region: Convert to platform remove callback returning void
>   fpga: socfpga-a10: Convert to platform remove callback returning void
>   fpga: stratix10-soc: Convert to platform remove callback returning void
>   fpga: xilinx-pr-decoupler: Convert to platform remove callback returning void
>   fpga: zynq-fpga: Convert to platform remove callback returning void
> 
>  drivers/fpga/altera-fpga2sdram.c        | 6 ++----
>  drivers/fpga/altera-freeze-bridge.c     | 6 ++----
>  drivers/fpga/altera-hps2fpga.c          | 6 ++----
>  drivers/fpga/dfl-afu-main.c             | 6 ++----
>  drivers/fpga/dfl-fme-br.c               | 6 ++----
>  drivers/fpga/dfl-fme-main.c             | 6 ++----
>  drivers/fpga/dfl-fme-region.c           | 6 ++----
>  drivers/fpga/intel-m10-bmc-sec-update.c | 6 ++----
>  drivers/fpga/of-fpga-region.c           | 6 ++----
>  drivers/fpga/socfpga-a10.c              | 6 ++----
>  drivers/fpga/stratix10-soc.c            | 6 ++----
>  drivers/fpga/xilinx-pr-decoupler.c      | 6 ++----
>  drivers/fpga/zynq-fpga.c                | 6 ++----
>  13 files changed, 26 insertions(+), 52 deletions(-)

Acked-by: Xu Yilun <yilun.xu@intel.com>

And applied this series to for-next for 6.8-rc1.

> 
> base-commit: aa4db8324c4d0e67aa4670356df4e9fae14b4d37
> -- 
> 2.42.0
> 
> 

