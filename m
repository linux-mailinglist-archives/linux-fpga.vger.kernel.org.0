Return-Path: <linux-fpga+bounces-1299-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 55C3CB1C26B
	for <lists+linux-fpga@lfdr.de>; Wed,  6 Aug 2025 10:50:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C28E18A3306
	for <lists+linux-fpga@lfdr.de>; Wed,  6 Aug 2025 08:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A2A3289340;
	Wed,  6 Aug 2025 08:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Iwz43wOF"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED701E766E;
	Wed,  6 Aug 2025 08:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754470237; cv=none; b=ZkR8O1kf3+nGvim0BYXHZHsOE4FIvmiS65IxNn35tqCyUtXnWRvmOaZbju5d/QWJkKtnuOntsqe3TX7pBNuIxCYwGw3hAGJPGZFW6rSQp/IingqOnxqF03z/JTZr8vC8RI8gTHxcmLeSeYED5+d+MXh2gGNMrc4f7YmKETI6YNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754470237; c=relaxed/simple;
	bh=NsHZR6WcK1x2Kavd0OOKi+xCCiUlX6GuvSFuWPYw4j8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hdBO91DnCoj92yD8P/VaDcsTr1NSKGxkrfR5aQ7BtS7wSBcev/VYzqFvHe36haKf12FcFc/1eaNqxlgt3wdcu//w1vxwIs6S+ZbXTaDeJtsYMCJW+VnoM6OR8ur48PCWMs/thVyLU+RwuwH0ou7FLd8FTnAWGFoIO+Dj6SPgYfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Iwz43wOF; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754470235; x=1786006235;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NsHZR6WcK1x2Kavd0OOKi+xCCiUlX6GuvSFuWPYw4j8=;
  b=Iwz43wOFtaGGqiqgLi6jD4oQ2WcPnahj4zQsTE7iDg/mFGs96pQ+xWN6
   di/Z2WyFhfDgVeWmWJEP6xbwX3Hy8nB/NCTiDpwFt7inhsy17+6ttmUy4
   mKL5iINimNIoONMut3FP6M6DGX4b1Yp4fs5atHL6PWzJNLoFMl7ZIvyKm
   A5ps7rAQqewnBP2prwMigWVPQGCyGzGdswC/3FTzt6ekbVu5BLiPgd1y8
   4+aJQYaCAt0uVD/CJZsDYl50i6XGePPSeSNjyIse30KLhl/vFLNc6rwb5
   0kNfkxp2KSBJi36aiafptDUCRepWbVpzveWLgEXKWMxT1PtQTzJ+bs0CG
   w==;
X-CSE-ConnectionGUID: zVwCHwZ1S+6LPbyO42/AGQ==
X-CSE-MsgGUID: ltSAz7m3QIOx/VRasCJCNw==
X-IronPort-AV: E=McAfee;i="6800,10657,11513"; a="68154723"
X-IronPort-AV: E=Sophos;i="6.17,268,1747724400"; 
   d="scan'208";a="68154723"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2025 01:50:35 -0700
X-CSE-ConnectionGUID: qyn0KyoUSAK5R7721BaHTQ==
X-CSE-MsgGUID: vcNEnXMjTmOhoPsta+HjOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,268,1747724400"; 
   d="scan'208";a="169172084"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa004.jf.intel.com with ESMTP; 06 Aug 2025 01:50:33 -0700
Date: Wed, 6 Aug 2025 16:40:53 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: xiehongyu1@kylinos.cn
Cc: yilun.xu@intel.com, trix@redhat.com, linux-kernel@vger.kernel.org,
	linux-fpga@vger.kernel.org, mdf@kernel.org
Subject: Re: [PATCH v1] fpga: afu: fix potential intege overflow
Message-ID: <aJMVFUQXdMPo+l3i@yilunxu-OptiPlex-7050>
References: <20250804082523.419159-1-xiehongyu1@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250804082523.419159-1-xiehongyu1@kylinos.cn>

On Mon, Aug 04, 2025 at 04:25:23PM +0800, xiehongyu1@kylinos.cn wrote:
> From: Hongyu Xie <xiehongyu1@kylinos.cn>
> 
> Overflow Scenarios:
> 1, region->offset + region->size Overflow:
>   When region->offset is close to U64_MAX and region->size is
> sufficiently large, the addition result may wrap around to a
> very small value (e.g., 0 or near 0).
>   In this case, even if the target range [offset, offset+size)
> falls within the region, the condition region->offset +
> region->size >= offset + size will fail due to the wrapped
> value being small. This causes the function to erroneously
> return -EINVAL.
> 
> 2, offset + size Overflow:
>   When offset is close to U64_MAX and size is large, offset +
> size wraps around to a small value.
> 
>   Here, region->offset + region->size (which would be a large
> value if not overflowing) might incorrectly satisfy
> region->offset + region->size >= offset + size due to the
> wrapped small value. This leads to a false match, even though
> the actual range [offset, offset+size) spans the wrap-around
> boundary and does not belong to this region.
> 
> So fix these two scenarios.
> 
> Signed-off-by: Hongyu Xie <xiehongyu1@kylinos.cn>
> ---
>  drivers/fpga/dfl-afu-region.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/fpga/dfl-afu-region.c b/drivers/fpga/dfl-afu-region.c
> index b11a5b21e666..449c2ae809bd 100644
> --- a/drivers/fpga/dfl-afu-region.c
> +++ b/drivers/fpga/dfl-afu-region.c
> @@ -157,7 +157,8 @@ int afu_mmio_region_get_by_offset(struct dfl_feature_dev_data *fdata,
>  	afu = dfl_fpga_fdata_get_private(fdata);
>  	for_each_region(region, afu)
>  		if (region->offset <= offset &&
> -		    region->offset + region->size >= offset + size) {
> +		    region->size >= size &&
> +		    (offset - region->offset) <= (region->size - size)) {

You don't have to use these tricks, they make the code hard to
understand. If you care about the overflow, just pick some helpers from
overflow.h

And don't check region->offset + region->size for every get, they should
be properly initialized at the very beginning.

Thanks,
Yilun

>  			*pregion = *region;
>  			goto exit;
>  		}
> -- 
> 2.25.1
> 
> 

