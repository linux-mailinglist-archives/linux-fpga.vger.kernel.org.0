Return-Path: <linux-fpga+bounces-927-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D38139C3720
	for <lists+linux-fpga@lfdr.de>; Mon, 11 Nov 2024 04:47:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7375F1F21E41
	for <lists+linux-fpga@lfdr.de>; Mon, 11 Nov 2024 03:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 206622C18C;
	Mon, 11 Nov 2024 03:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KxuA9Zbo"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E0E1184F;
	Mon, 11 Nov 2024 03:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731296866; cv=none; b=i0Om7p7v1whLhiXVnCL6gsnREEOYCMPWlpVyZVbWh8xYXvrgRdlLTbbZ42u4gOJ5cx4WQX4H6Rr3PfJg68tG2L06GVF8g31QGOt5URb0nVx2/0LL+/sSzSomZJXfVCoRfTBvRP6dWZRHkg1WCU42hdiGAimA4IkzUUCWnkc9TLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731296866; c=relaxed/simple;
	bh=alkdc62O/qq+P1005nwlDTA80rR8H65BGJRqrWQj13c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XAuSm2/KG9VAEthZA1X/D/lLJT1Rmv+7gDuZ77mbLi8jynDuXyJz8eyuaVXM4Vl+fPNQGj704ESOzpZdhpKDKwYfWtiuaQ3fN3aB1qV6wyNSIWkPr9rzPqwr797r+IIcqaWbPqGvGjqGPam/adeMwHh4VAkLqr/h6f68Hs+AGdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KxuA9Zbo; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731296865; x=1762832865;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=alkdc62O/qq+P1005nwlDTA80rR8H65BGJRqrWQj13c=;
  b=KxuA9ZboJmK2duoylQPc4t9px4YG14LnDUtPywWSSoXSjeFCsf9b3Sw9
   vnCebeH1H5c0F8j+FYmUjk0RVWXlzYf+k8Yi9XIXijtKN6tbPV69fOQ2b
   +N6ESDr4Af+5c72N4rqTfTcMl50LmwrEUvqzRTVvyFiGPJ/ldrVxHrWIZ
   PDNQQCKc6zXVWDgxcNvso/zvpV0UPCMJ2Wa4sBz7sCwsFUKAIEmIWj2nM
   4laABRLOfheUPHNKu8gqyYZUK+XUJe/u5TKzsqQ5vkiFOeAdKlCMnvxbb
   rlfFbbLM9EkEHtcnei6YYAWq2xLqPoXlDJMeZKAOyDJFh/SUPxLk2t/rB
   g==;
X-CSE-ConnectionGUID: FwO/cGafQoOV9EgWDNPU7Q==
X-CSE-MsgGUID: Aw1yxrCRQ4iU76v8uRWfDQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11252"; a="33956632"
X-IronPort-AV: E=Sophos;i="6.12,144,1728975600"; 
   d="scan'208";a="33956632"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2024 19:47:44 -0800
X-CSE-ConnectionGUID: vnCxt3TrR9SBrEVL53/voQ==
X-CSE-MsgGUID: EVu8N+ZfSQC2gB2Ppe6InA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,144,1728975600"; 
   d="scan'208";a="87164397"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa010.fm.intel.com with ESMTP; 10 Nov 2024 19:47:42 -0800
Date: Mon, 11 Nov 2024 11:43:55 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
	Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
	Peter Colberg <peter.colberg@intel.com>,
	Michal Simek <michal.simek@amd.com>, linux-fpga@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] fpga: Switch back to struct platform_driver::remove()
Message-ID: <ZzF9e1yS9GnUiyD8@yilunxu-OptiPlex-7050>
References: <20241108160002.252517-2-u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241108160002.252517-2-u.kleine-koenig@baylibre.com>

On Fri, Nov 08, 2024 at 05:00:02PM +0100, Uwe Kleine-König wrote:
> After commit 0edb555a65d1 ("platform: Make platform_driver::remove()
> return void") .remove() is (again) the right callback to implement for
> platform drivers.
> 
> Convert all platform drivers below drivers/fpga to use .remove(), with
> the eventual goal to drop struct platform_driver::remove_new(). As
> .remove() and .remove_new() have the same prototypes, conversion is done
> by just changing the structure member name in the driver initializer.
> 
> A few white space changes are included to make indention consistent.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>

Acked-by: Xu Yilun <yilun.xu@intel.com>

Applied to for-next and submitted to v6.13-rc1

Thanks,
Yilun

