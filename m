Return-Path: <linux-fpga+bounces-939-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED6B79D141B
	for <lists+linux-fpga@lfdr.de>; Mon, 18 Nov 2024 16:12:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AD041F220B5
	for <lists+linux-fpga@lfdr.de>; Mon, 18 Nov 2024 15:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 941DE1AED3F;
	Mon, 18 Nov 2024 15:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MZ3yufXq"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C19FF1AA1F1;
	Mon, 18 Nov 2024 15:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731942727; cv=none; b=Jvl8MTyCUnqSlXey51LV9XZFhavSeNrpLwSqHtr2hhvpz0igie9sOS4rJuYNK7P47sJjWWvzJB2ji9TeHD3ApVk9ZBjfCbIihqRK++IXKmhQgPn6UPTVsm4rfRY+0nRH+itfexcVNYLm2zPDWqEKQHD0jzxW5QxfS5TQhmTCAks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731942727; c=relaxed/simple;
	bh=e+6TGWeze1du0twh0dAjcga/QpJzm4lJ2Zj3KW40l+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LVsV+Gs8f2HtiFVaaAOIfV3b7NTimL5VwlMGwJtsPdh8kwGhBN0EoB1GJZxE1aAxpTLSaXi/TfilKh55+BO5U2QlVp71rV0ju6aESX8Md5iN9MLKXNzXazhfgG0Uz6079anoBgT7nbl11JrcRq4g/is5cngJ4FDGaZgsRBo1XsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MZ3yufXq; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731942725; x=1763478725;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=e+6TGWeze1du0twh0dAjcga/QpJzm4lJ2Zj3KW40l+0=;
  b=MZ3yufXqkSXeHXFlVpBFzhVMNdec3Oz2PExZZlZuhmpc/NiZMHwBKMsr
   pTthJbOsKI82I+kjw512AN9FDfxUCYOQZxQcknsQ37MPRlOc/9OOEE//Q
   tskGuVyMymiP/ctC8EVDXmdl5g02p76JH7RGWoNDhz8+VItL/Ei7oy3k1
   QbONnxCsx/6PKgTfE19G3VC/dCrMzyOR68MHonb4n+6gkhzbxBecn8Njo
   ei9fM8j+zmMbaFniKfVd3gsYNPnXahzcyopnTjEaUdFzYApZ2V6A/kvtL
   rZMoQWoSGjX+9fC9UCnW8kX9/TNxUQwSPMaG73OkoUB+eVCvPClYAzmcF
   w==;
X-CSE-ConnectionGUID: vtJM4ZolTNKSnsR5MezBoQ==
X-CSE-MsgGUID: jG39sfXYSx6K6sc1YrMOGg==
X-IronPort-AV: E=McAfee;i="6700,10204,11260"; a="31841440"
X-IronPort-AV: E=Sophos;i="6.12,164,1728975600"; 
   d="scan'208";a="31841440"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2024 07:12:04 -0800
X-CSE-ConnectionGUID: XMfkiXedS+CtE2Xukq5FNQ==
X-CSE-MsgGUID: w8ZuklYiSbyDsxpGD95KWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,164,1728975600"; 
   d="scan'208";a="120113954"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa002.jf.intel.com with ESMTP; 18 Nov 2024 07:12:03 -0800
Date: Mon, 18 Nov 2024 23:09:09 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Peter Colberg <peter.colberg@intel.com>
Cc: Wu Hao <hao.wu@intel.com>, Tom Rix <trix@redhat.com>,
	Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>,
	linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
	Russ Weight <russ.weight@linux.dev>,
	Marco Pagani <marpagan@redhat.com>,
	Matthew Gerlach <matthew.gerlach@linux.intel.com>,
	Basheer Ahmed Muddebihal <basheer.ahmed.muddebihal@linux.intel.com>,
	Russ Weight <russell.h.weight@intel.com>
Subject: Re: [PATCH v4 19/19] fpga: dfl: destroy/recreate feature platform
 device on port release/assign
Message-ID: <ZztYlcidn3zU2vn5@yilunxu-OptiPlex-7050>
References: <20241025223714.394533-1-peter.colberg@intel.com>
 <20241025223714.394533-20-peter.colberg@intel.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241025223714.394533-20-peter.colberg@intel.com>

On Fri, Oct 25, 2024 at 06:37:14PM -0400, Peter Colberg wrote:
> From: Xu Yilun <yilun.xu@intel.com>
> 
> Now that the internal DFL APIs have been converted to consume DFL
> enumeration info from a separate structure, dfl_feature_dev_data, which
> lifetime is independent of the feature device, proceed to completely
> destroy and recreate the feature platform device on port release and
> assign, respectively. This resolves a longstanding issue in the use of
> platform_device_add(), which states to "not call this routine more than
> once for any device structure" and which used to print a kernel warning.
> 
> The function feature_dev_unregister() resets the device pointer in the
> feature data to NULL to signal that the feature platform device has been
> destroyed. This substitutes the previous device_is_registered() checks.

Acked-by: Xu Yilun <yilun.xu@intel.com>

for this patch and all other patches that I didn't comment in this
series.

Thanks.

> 
> Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> Signed-off-by: Peter Colberg <peter.colberg@intel.com>
> Reviewed-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> Reviewed-by: Basheer Ahmed Muddebihal <basheer.ahmed.muddebihal@linux.intel.com>

