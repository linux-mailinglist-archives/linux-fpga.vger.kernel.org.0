Return-Path: <linux-fpga+bounces-1436-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 43EF2C452FF
	for <lists+linux-fpga@lfdr.de>; Mon, 10 Nov 2025 08:18:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A3AEE346CCF
	for <lists+linux-fpga@lfdr.de>; Mon, 10 Nov 2025 07:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CF7A2253A0;
	Mon, 10 Nov 2025 07:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TX10oNJR"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E9F19995E;
	Mon, 10 Nov 2025 07:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762759078; cv=none; b=cclXMY2pKMOR6fmsFx48Y+TyGWOj0+5rGDINq2/JBed+9nFcBoAWj/2p/1K06wZCmYiB2YIrBTcowBN698iKQliv1LlzlKkmSXGRhGRdm7+6uco7vrkZT6AU34eO+8+DlLKqwqv8SXFvueYhVxB5sC2M5UDABKpSQ6GlWOdmov0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762759078; c=relaxed/simple;
	bh=7t+beYimeFmJd/MFQLBTiNbwGCIcOp2u+YvZwEIHi8M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y3cVVJ4pcwQut2PzkILiSLCix3PVq0Uk51yE6+ltD+RlM2xbKpcYalXhfovnTjg+CDN135iNrXPZ4dE4sfADson9wpK6eHTMpFjwoy9Jl65m15tJ5166qtbTg/0ofKRq75CY+WwlGbPH+f29XeLr6tQoH4qTseVBLi9LZt+cFvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TX10oNJR; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762759077; x=1794295077;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7t+beYimeFmJd/MFQLBTiNbwGCIcOp2u+YvZwEIHi8M=;
  b=TX10oNJRdHOtwIk+AEE3xwGA/ncuD+xxhdSGTcpSz8HwUb+PSSCtOGnr
   qmnIdKdA8QHl3BTaePwcczPWpzVrqxJgVtI0kInok5S9sLAXqyfB09QPG
   y7/ZjXW4GCMWPZKKlVuPkyCHfabwGjbHQEJFcTufJiVVWb9F67Rdq9Dac
   DUTf6c2DujPl1eVf89WyaPgck6IHSSLI6Ysc7iZri5rvMjZEoAP0bjKXG
   25zqPccO3Uv1Iu/ZBZnuiHj2da5UAWSwOoH0PV+7gnDudf6glonRVH5V9
   4AE+qRNDlg1c5waugsce1UKIhMhW0G/Ixvg9qb2me4BFBl52jQ75YH0Qu
   w==;
X-CSE-ConnectionGUID: Ivvh4WQ+Tre9TWgbg8UQcg==
X-CSE-MsgGUID: asmGyLmETcmA6ZBxQdrsBQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="64715989"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="64715989"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2025 23:17:56 -0800
X-CSE-ConnectionGUID: cPT/tiUxTTyZnrGowoVsvA==
X-CSE-MsgGUID: VG4x8iT+RC+50hwI9PpFNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,293,1754982000"; 
   d="scan'208";a="192986237"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa004.jf.intel.com with ESMTP; 09 Nov 2025 23:17:54 -0800
Date: Mon, 10 Nov 2025 15:03:32 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Xu Yilun <yilun.xu@intel.com>, linux-fpga@vger.kernel.org,
	linux-kernel@vger.kernel.org, Moritz Fischer <mdf@kernel.org>,
	Tom Rix <trix@redhat.com>
Subject: Re: [PATCH v3 1/1] fpga: altera-cvp: Use pci_find_vsec_capability()
 when probing FPGA device
Message-ID: <aRGORMJwvORUPOMp@yilunxu-OptiPlex-7050>
References: <20251109201729.3220460-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251109201729.3220460-1-andriy.shevchenko@linux.intel.com>

On Sun, Nov 09, 2025 at 09:16:37PM +0100, Andy Shevchenko wrote:
> Currently altera_cvp_probe() open-codes pci_find_vsec_capability().
> Refactor the former to use the latter.
> 
> With that done:
> - use the VSEC ID as per datasheet [1]
> - update the error message accordingly
> 
> Link: https://www.intel.com/content/www/us/en/docs/programmable/683763/23-1/vendor-specific-header-register.html [1]

Thanks for the Doc. It's clear now.

Reviewed-by: Xu Yilun <yilun.xu@intel.com>

Applied to for-next

> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

