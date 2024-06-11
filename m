Return-Path: <linux-fpga+bounces-541-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F94E903847
	for <lists+linux-fpga@lfdr.de>; Tue, 11 Jun 2024 12:00:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E74D1C2326C
	for <lists+linux-fpga@lfdr.de>; Tue, 11 Jun 2024 10:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDF5017107E;
	Tue, 11 Jun 2024 10:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NW503o1b"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A43156E4;
	Tue, 11 Jun 2024 10:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718100025; cv=none; b=BZbUp2iu45HASfSno6c6ZfgOKFCKJFxpIMI7qw8svm8i9rMbMIrS7aOjODe3szIs6QivMuBOxXraT2fBGa7CLM8t0NWVOqMrQ9FRH4ICRZ9+9tQgPFE3lmBV30YodH5nciyMJieqcYmPozK61l+7+NkWRRCu/SuqHxDOW0v/Acc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718100025; c=relaxed/simple;
	bh=reuenXmwGEIcJGmpB8cV2S2SV9wZJfvnXCYDCOBk/Q0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ipvvkekddFiKnKRTg+Fp0ZGG8+Tlfc4PknW9Q/47scf+5L/YPypeUTNx2GmElVxazU7AgwTq3APLHc61UXt/X+QquM4RU5B13A2vpBKGpw2qREHZreep90TRzU1Bh/UkGU9lCHL8tsbMy+h40qkjc6vcIHP+AvMGOGcP+XHdF7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NW503o1b; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718100025; x=1749636025;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=reuenXmwGEIcJGmpB8cV2S2SV9wZJfvnXCYDCOBk/Q0=;
  b=NW503o1bZGwelaOiVtP/ke04+VQZqufXeeu0yPFiAiKRxRPMMj4iQZip
   eNJivNYv+Le/ZUd9rxEnA/PJBpL9KVO4g8+xcNWdkuBgqN9ggQkxFrpQ9
   bja9SL6TK6qXwuw2P6g/b+AZI6HXyeX9oN4Jxp65DjdCoux4PhOLifPZS
   oOdUnRZU2hjaHYhCS2aLTBG2T7kV1MNLcmzW+eUUuls1DCnK7tVXC4as5
   7l6zbcsf8BXoLzlDr5El5iIsmP4a+RZZJPknkL3Og6OkomXhBXpuRbiYp
   s/aro8LWoZVHT7J2KARicpVEpCG83DBUFCwo7uSgQz+3R2mSM9t2kIJ10
   w==;
X-CSE-ConnectionGUID: ome21UNgQ2+cnZMoE+wxlA==
X-CSE-MsgGUID: 4LKlpGjoToCzI3EcOOvbEA==
X-IronPort-AV: E=McAfee;i="6600,9927,11099"; a="14630996"
X-IronPort-AV: E=Sophos;i="6.08,229,1712646000"; 
   d="scan'208";a="14630996"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2024 03:00:24 -0700
X-CSE-ConnectionGUID: WEFvd2UNTnW3FU/sPMafYg==
X-CSE-MsgGUID: PgBW8CbETT+B7RMpjOEytA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,229,1712646000"; 
   d="scan'208";a="70550460"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa001.fm.intel.com with ESMTP; 11 Jun 2024 03:00:21 -0700
Date: Tue, 11 Jun 2024 17:53:52 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Marco Pagani <marpagan@redhat.com>
Cc: Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
	Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
	linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 RESEND] Revert "fpga: disable KUnit test suites when
 module support is enabled"
Message-ID: <ZmgesCLjje6Q0yXh@yilunxu-OptiPlex-7050>
References: <20240604102536.59010-1-marpagan@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240604102536.59010-1-marpagan@redhat.com>

On Tue, Jun 04, 2024 at 12:25:35PM +0200, Marco Pagani wrote:
> This reverts commit a3fad2e92c76587fe262a1a4a122045b29885354.
> 
> The core components of the subsystem no longer assume that low-level
> modules register a driver for the parent device and rely on its owner
> pointer to take the module's refcount. KUnit test suites can now be safely
> re-enabled with loadable module support.
> 
> Signed-off-by: Marco Pagani <marpagan@redhat.com>

Acked-by: Xu Yilun <yilun.xu@intel.com>

Applied to for-next.

> ---
> 
> v2: reworked commit message
> ---
>  drivers/fpga/tests/Kconfig | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/fpga/tests/Kconfig b/drivers/fpga/tests/Kconfig
> index d4e55204c092..e4a64815f16d 100644
> --- a/drivers/fpga/tests/Kconfig
> +++ b/drivers/fpga/tests/Kconfig
> @@ -1,6 +1,6 @@
>  config FPGA_KUNIT_TESTS
> -	bool "KUnit test for the FPGA subsystem" if !KUNIT_ALL_TESTS
> -	depends on FPGA=y && FPGA_REGION=y && FPGA_BRIDGE=y && KUNIT=y && MODULES=n
> +	tristate "KUnit test for the FPGA subsystem" if !KUNIT_ALL_TESTS
> +	depends on FPGA && FPGA_REGION && FPGA_BRIDGE && KUNIT=y
>  	default KUNIT_ALL_TESTS
>          help
>            This builds unit tests for the FPGA subsystem
> 
> base-commit: b7c0e1ecee403a43abc89eb3e75672b01ff2ece9
> -- 
> 2.45.1
> 
> 

