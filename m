Return-Path: <linux-fpga+bounces-934-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 040E99D1345
	for <lists+linux-fpga@lfdr.de>; Mon, 18 Nov 2024 15:39:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEB6A2845A9
	for <lists+linux-fpga@lfdr.de>; Mon, 18 Nov 2024 14:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1FB71991A5;
	Mon, 18 Nov 2024 14:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b/Uxpe86"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F275A1AA1E4;
	Mon, 18 Nov 2024 14:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731940531; cv=none; b=UfAZ+egI8GXl0M3oWh/CzfPdnsDbZrAR7fZK4SB7qWFoki5VxPl5MhKhtd8CWWx28VDjplYBBt60dYV1V62+ZdqR+/cCIeen25l0Td1NkFuFB8YkNVp3kEnDaaZd/4yCS7MZaJitw/6cKzF0mhmcUHT51t8zh6o9iYSufYIOFoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731940531; c=relaxed/simple;
	bh=k2EDNNE2MH6cAr2jzyt5WJSQPAhgBLY2X5+jVYr1hhc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O3c3r3+lSJnUN4bvtPPI1JDiVM+9VUXJ2BVAXw6lSPEXsPhGUhnAt9UO9NXhgLykkQhajKNsAE7RtkKSLPqRMtm9v4suxZEKi0mRGvCWrYxtyiTMzBWGnlqhuYN6pMD2tQoGEhbf62BNPtt2RF8XaaNyTFyEHxTIAO7A11zVR2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b/Uxpe86; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731940530; x=1763476530;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=k2EDNNE2MH6cAr2jzyt5WJSQPAhgBLY2X5+jVYr1hhc=;
  b=b/Uxpe86dvWYfoqUFWEQlDTwZUcAW4c64ALjPDJ5gfRYDC+1UkYvsGkh
   iESuUttNbUTop7T5ZpZgimyQqLkapYA4NJ/GP9wRPEgLKC1uUlTMN+M8G
   F8MZxhXitx4/+FFTQKR9ayP8TgsXnpzGr2z7gnOL3aAXCkmIRLx8caPHK
   yW/eHDy97DN4MSurUk7SYH/E4vPg4gtciWiUGDo5NGgBObGMP7OhiDxFC
   nw/HtOcqPw8DXocRrSa62mnTLgqxp9RWUrAncGxQRaUWAcolK2om8v/f0
   bGLfjkV7dlHWFzhdqMmtlJu5uldxamf4lit/+vdF1Z0Q3rQ7NJEX2KGaA
   Q==;
X-CSE-ConnectionGUID: tb5zbOADSROTRFbpFVcz+w==
X-CSE-MsgGUID: mAfNe+zgS9utkFAi2PsDcQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11260"; a="57307721"
X-IronPort-AV: E=Sophos;i="6.12,164,1728975600"; 
   d="scan'208";a="57307721"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2024 06:35:29 -0800
X-CSE-ConnectionGUID: T0NN7DUFTmy4g7Tdhhr4uA==
X-CSE-MsgGUID: aJ/8+fAHSdCMRLAXjHyAvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,164,1728975600"; 
   d="scan'208";a="88806588"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa006.fm.intel.com with ESMTP; 18 Nov 2024 06:35:27 -0800
Date: Mon, 18 Nov 2024 22:32:34 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Peter Colberg <peter.colberg@intel.com>
Cc: Wu Hao <hao.wu@intel.com>, Tom Rix <trix@redhat.com>,
	Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>,
	linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
	Russ Weight <russ.weight@linux.dev>,
	Marco Pagani <marpagan@redhat.com>,
	Matthew Gerlach <matthew.gerlach@linux.intel.com>,
	Basheer Ahmed Muddebihal <basheer.ahmed.muddebihal@linux.intel.com>
Subject: Re: [PATCH v4 15/19] fpga: dfl: convert is_feature_dev_detected() to
 use FIU type
Message-ID: <ZztQAsDCyRqGm6UW@yilunxu-OptiPlex-7050>
References: <20241025223714.394533-1-peter.colberg@intel.com>
 <20241025223714.394533-16-peter.colberg@intel.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241025223714.394533-16-peter.colberg@intel.com>

On Fri, Oct 25, 2024 at 06:37:10PM -0400, Peter Colberg wrote:
> Use binfo->type instead of binfo->feature_dev to decide whether a
> feature device was detected during feature parsing. A subsequent
> commit will delay the allocation of the feature platform device
> to feature_dev_register() and remove binfo->feature_dev.
> 
> This commit does not introduce any functional changes.
> 
> Signed-off-by: Peter Colberg <peter.colberg@intel.com>
> Reviewed-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> Reviewed-by: Basheer Ahmed Muddebihal <basheer.ahmed.muddebihal@linux.intel.com>
> ---
> Changes since v3:
> - New patch extracted from last patch of v3 series.
> ---
>  drivers/fpga/dfl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
> index 758673b0290a..a9ec37278b2d 100644
> --- a/drivers/fpga/dfl.c
> +++ b/drivers/fpga/dfl.c
> @@ -1248,7 +1248,7 @@ static int parse_feature_port_afu(struct build_feature_devs_info *binfo,
>  	return create_feature_instance(binfo, ofst, size, FEATURE_ID_AFU);
>  }
>  
> -#define is_feature_dev_detected(binfo) (!!(binfo)->feature_dev)
> +#define is_feature_dev_detected(binfo) ((binfo)->type != DFL_ID_MAX)

I still doesn't get why put the change here. How it resolves my concern
compared to v3?

Thanks,
Yilun

>  
>  static int parse_feature_afu(struct build_feature_devs_info *binfo,
>  			     resource_size_t ofst)
> -- 
> 2.47.0
> 
> 

