Return-Path: <linux-fpga+bounces-937-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EBADF9D13D6
	for <lists+linux-fpga@lfdr.de>; Mon, 18 Nov 2024 16:01:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3F9C1F23334
	for <lists+linux-fpga@lfdr.de>; Mon, 18 Nov 2024 15:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5F261AA1C6;
	Mon, 18 Nov 2024 15:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QbPfpbLH"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E081991DB;
	Mon, 18 Nov 2024 15:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731942062; cv=none; b=VpxOyG0gslMHOyHJyaNoHiEFWTEf9spnbuHXcXYalWf2JwAspVNiIP9rlqf2GTUfKuhKw/w71Xi41CmxkHzpGxBvdfa1Qnq3ELUTZoAUXmV2Tgx6x4rQ52XVg1OWH36i+iZj/r/SHZwHdtuahDD5Q0ykygefKG0EWbnAJJTDW2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731942062; c=relaxed/simple;
	bh=igJQtacPhIM9ztn/DHiLLB8CIzFq/PkCp1VV0gLJ29o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C+kO1vl1DL55FuBMAXVhpTi8wWmCxV0FOLrVUA7xK51A3M7StmBIaITY7gDjIO6lJ6aH0QwjdLYmkpSDFD405+UMg7qJkNX5LgnzMC8gqeewMyOVsb1O9QSMLxRoYeX2sU3r6qrackjSJzA3CmBoCzvDpCXn2iRuVAdGlySaffA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QbPfpbLH; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731942061; x=1763478061;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=igJQtacPhIM9ztn/DHiLLB8CIzFq/PkCp1VV0gLJ29o=;
  b=QbPfpbLHglt8X2AL8TULm7qbndLBigYLK+TD3A7urdGzEV8i75KKzRYK
   /oApUd7H/fVAwjj4JD4HUmf4qXbJ3KJwxP3iqw/rsprm7Ih2LQ0ulqrrv
   vNpx/6HhRCYrgB/6FQZ3FnLiorih5E2u/D18nZfLSvnxNa6205TpgeSwW
   rbjxfgeLyYSEZQuDsk44g8B5UweFa6redMq0NkXchDKpmPfIXpao/TMFO
   llSwh81HBcR2GYlGLhlO0y7SWDPJsM5c8/oQ6Ia+Lwk1iI3/TRvuNnOw/
   WSWpilfuEg/U9bsIZCbOFsZPoP4AUbcwojyrSQhbjE37ulklnALVzhbek
   g==;
X-CSE-ConnectionGUID: Wkk+Vt0QQ9WpUcXcTzXNfA==
X-CSE-MsgGUID: 0zHT0ec6Slyuqv/EgalLqg==
X-IronPort-AV: E=McAfee;i="6700,10204,11260"; a="42532138"
X-IronPort-AV: E=Sophos;i="6.12,164,1728975600"; 
   d="scan'208";a="42532138"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2024 07:01:01 -0800
X-CSE-ConnectionGUID: lUmt5vy+Qey91SmHNCEM4g==
X-CSE-MsgGUID: jZMmC9XvSXeX+aqrxbDwLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,164,1728975600"; 
   d="scan'208";a="126789252"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa001.jf.intel.com with ESMTP; 18 Nov 2024 07:00:58 -0800
Date: Mon, 18 Nov 2024 22:58:05 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Peter Colberg <peter.colberg@intel.com>
Cc: Wu Hao <hao.wu@intel.com>, Tom Rix <trix@redhat.com>,
	Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>,
	linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
	Russ Weight <russ.weight@linux.dev>,
	Marco Pagani <marpagan@redhat.com>,
	Matthew Gerlach <matthew.gerlach@linux.intel.com>,
	Basheer Ahmed Muddebihal <basheer.ahmed.muddebihal@linux.intel.com>
Subject: Re: [PATCH v4 17/19] fpga: dfl: remove unneeded function
 build_info_create_dev()
Message-ID: <ZztV/d8PPk2f33wk@yilunxu-OptiPlex-7050>
References: <20241025223714.394533-1-peter.colberg@intel.com>
 <20241025223714.394533-18-peter.colberg@intel.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241025223714.394533-18-peter.colberg@intel.com>

On Fri, Oct 25, 2024 at 06:37:12PM -0400, Peter Colberg wrote:
> Now that the platform device allocation has been moved from
> build_info_create_dev() to feature_dev_register(), the former
> no longer serves its original purpose and may be removed.

may be removed? It is removed in this patch, please be confirmative.

Thanks,
Yilun

> 
> Signed-off-by: Peter Colberg <peter.colberg@intel.com>
> Reviewed-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> Reviewed-by: Basheer Ahmed Muddebihal <basheer.ahmed.muddebihal@linux.intel.com>
> ---
> Changes since v3:
> - New patch extracted from last patch of v3 series.
> ---
>  drivers/fpga/dfl.c | 17 ++---------------
>  1 file changed, 2 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
> index d9cef150ed0d..a2459b0cbc68 100644
> --- a/drivers/fpga/dfl.c
> +++ b/drivers/fpga/dfl.c
> @@ -858,16 +858,6 @@ binfo_create_feature_dev_data(struct build_feature_devs_info *binfo)
>  	return fdata;
>  }
>  
> -static int
> -build_info_create_dev(struct build_feature_devs_info *binfo)
> -{
> -	binfo->feature_num = 0;
> -
> -	INIT_LIST_HEAD(&binfo->sub_features);
> -
> -	return 0;
> -}
> -
>  /*
>   * register current feature device, it is called when we need to switch to
>   * another feature parsing or we have parsed all features on given device
> @@ -1316,11 +1306,8 @@ static int parse_feature_fiu(struct build_feature_devs_info *binfo,
>  		return -EINVAL;
>  
>  	binfo->type = type;
> -
> -	/* create platform device for dfl feature dev */
> -	ret = build_info_create_dev(binfo);
> -	if (ret)
> -		return ret;
> +	binfo->feature_num = 0;
> +	INIT_LIST_HEAD(&binfo->sub_features);
>  
>  	ret = create_feature_instance(binfo, 0, 0, 0);
>  	if (ret)
> -- 
> 2.47.0
> 
> 

