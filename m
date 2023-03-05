Return-Path: <linux-fpga+bounces-986-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC9E99F692C
	for <lists+linux-fpga@lfdr.de>; Wed, 18 Dec 2024 15:57:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D28711624AC
	for <lists+linux-fpga@lfdr.de>; Wed, 18 Dec 2024 14:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4CF61C5F1E;
	Wed, 18 Dec 2024 14:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eVWdU3E4"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB98C1C5CCE;
	Wed, 18 Dec 2024 14:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734533818; cv=none; b=Wlizvp2xDnwl/hVRKmZhrvafHU84Rd2TsoY7B3+x3zaZrS7JX3Otzw/gTytihSwlmL/Sk8Nzvcp+hlB+t/ttuWfpLfLuIPUqPhB8xlpQSW9an5KxPgZug8KEh/K0OKYTLmu/kczPWtGxphh+Yq116OSqetHCZpFGiI5ONPnuaQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734533818; c=relaxed/simple;
	bh=EEtPUszuXT6YM29QIDUi/KWDkZuTaxeUlF4hCpp6QiA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t2PI5bGqJ3m8TykeHgESCgCXAfXKlbiMaVm7t1kbkKPXqeVuYsChC0g9CzlTVFVbgn9vniP70XECixo03FCpYs4El0XtkxIAPiF7W6hPAeJM2RZz24zWKMb/1xhEdy5zghFit+GhvKG/hVzQPTZ4mDS6WE/mgiOOAAan+VyaD5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eVWdU3E4; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734533817; x=1766069817;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EEtPUszuXT6YM29QIDUi/KWDkZuTaxeUlF4hCpp6QiA=;
  b=eVWdU3E4iFJuHFBRGNlYrr1VvTeqxiWaK4SHLIq1Z0NNV00hXND7ErCD
   Lzme2MJ/yCtg7+aPqLeaF1L+lejWkf7iaOG6Q6plqZXD2w5TSHltEyRT3
   TaT41VXloeEEU8oQGA2Wl+0kZeWI2K6ulNaI7Z1xFTBF9AawkDBxebam/
   E1LHFg7KWpidwjsvbTRBeQ7BktLm4uKahlCz+AZeTN9lQ2CsAB5U58ury
   A76ixVI3d0BVT9CIu6PIQYuNoJZGnRda0/xBFYeGVRSpzEoRDxMOclXCL
   IpiyUY2I9ZjFVjdglWFV4buT4O833RsSb2jIag1Ndt5+GxYkYSnKBLGgN
   w==;
X-CSE-ConnectionGUID: gtCb2iE1TTCldHz8+uEW1w==
X-CSE-MsgGUID: VV+w5SSORC69j8sIu3corA==
X-IronPort-AV: E=McAfee;i="6700,10204,11290"; a="45501152"
X-IronPort-AV: E=Sophos;i="6.12,244,1728975600"; 
   d="scan'208";a="45501152"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2024 06:56:56 -0800
X-CSE-ConnectionGUID: OtXuNC54SP6uETvAb5fZjA==
X-CSE-MsgGUID: tTgYLri/QvOvX6lBZFDEzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,244,1728975600"; 
   d="scan'208";a="97729934"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa007.fm.intel.com with ESMTP; 18 Dec 2024 06:56:54 -0800
Date: Sun, 5 Mar 2023 11:06:54 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: "Colberg, Peter" <peter.colberg@intel.com>
Cc: "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"oe-kbuild-all@lists.linux.dev" <oe-kbuild-all@lists.linux.dev>,
	"matthew.gerlach@linux.intel.com" <matthew.gerlach@linux.intel.com>,
	"basheer.ahmed.muddebihal@linux.intel.com" <basheer.ahmed.muddebihal@linux.intel.com>
Subject: Re: [linux-next:master 2636/3192] drivers/fpga/dfl.c:154: warning:
 Function parameter or struct member 'fdata' not described in
 'dfl_fpga_port_ops_get'
Message-ID: <ZAQHTiJm59ZK0GXn@yilunxu-OptiPlex-7050>
References: <202412120500.aF6jnlmu-lkp@intel.com>
 <0003df208122ac05e5e364edb729a9ceb9cf96b1.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0003df208122ac05e5e364edb729a9ceb9cf96b1.camel@intel.com>

> These warnings may be resolved by amending commit a25cd37037c8 ("fpga:
> dfl: refactor internal DFL APIs to take/return feature device data").
> 
> --- a/drivers/fpga/dfl.c
> +++ b/drivers/fpga/dfl.c
> @@ -145,7 +145,7 @@ static LIST_HEAD(dfl_port_ops_list);
>  
>  /**
>   * dfl_fpga_port_ops_get - get matched port ops from the global list
> - * @pdata: platform data to match with associated port ops.
> + * @fdata: feature dev data to match with associated port ops.
>   * Return: matched port ops on success, NULL otherwise.
>   *
>   * Please note that must dfl_fpga_port_ops_put after use the port_ops.
> @@ -211,7 +211,7 @@ EXPORT_SYMBOL_GPL(dfl_fpga_port_ops_del);
>  
>  /**
>   * dfl_fpga_check_port_id - check the port id
> - * @pdata: port platform data.
> + * @fdata: port feature dev data.
>   * @pport_id: port id to compare.
>   *
>   * Return: 1 if port device matches with given port id, otherwise 0.

I've fixed, ran scripts/kernel-doc and pushed for all 3 patches.

Thanks,
Yilun

