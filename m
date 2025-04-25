Return-Path: <linux-fpga+bounces-1176-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9F2EA9BDA6
	for <lists+linux-fpga@lfdr.de>; Fri, 25 Apr 2025 06:35:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E96351BA3B80
	for <lists+linux-fpga@lfdr.de>; Fri, 25 Apr 2025 04:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0059F215F52;
	Fri, 25 Apr 2025 04:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b/ba33Qk"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 650241C8621;
	Fri, 25 Apr 2025 04:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745555712; cv=none; b=TiQRRKfqfa3KJ8Axk9mbfL8867OAMIcidu4/l3H1QwdC9mg9JFrca1UvrvpGatIAjBCTfGmLF+DGqwHzJgYzZ4lfaqVkhddkJJUnnxFYgOOOocrA0xs8E/QfU47tSBguKjt2vhZU+KSZziprEzMOEQQvqNFDMxSN/Ni8r1lu4Go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745555712; c=relaxed/simple;
	bh=zFyR+2o7S0aUhjQmUVl3U33tj4FHp8BKub3BSNHl6wY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U+9TpLkpIBg8WURBp8+ule9AWRWuB0BOtZaq4EUby+xu/llptHLLqe92pjUKZ4ri7/2tsn2I8j++yRbJSxikaS+fWxloIIGEyhCMl49wnpftb1p9Eukaw/E8+075z7AtsiCA4bKDS27lnjGRfgYevZfAkos1b65JpalaXRpxahc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b/ba33Qk; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745555712; x=1777091712;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zFyR+2o7S0aUhjQmUVl3U33tj4FHp8BKub3BSNHl6wY=;
  b=b/ba33QkNloD//9+XrG1Jt1cF21CUVXyhbVTvWZNHkJd8Fww+1ZXkufe
   vZ5nb+kktbi2Y5/bzc3rqj6Pz20coPHWpd1lmLUTz/9qW+HnTvyt7zJEk
   QQFHL0Yoak9t9NeCrD8Xfpo/nv+5mmkNrRiq22SnXMuPeFhBiaN/avxj1
   cLfjqYc5DYU84E+OHnUG5HLYck5GteGi3uza/CzLPoXJBSGRiKcp7JJvs
   0kn2EDdn6BMZp23w6sEnDy+fdwDnZutUfOCrx2tSveuMAzwP2KuADvOI6
   B/Ecu+YUPUbx1cef3G1QWI84eBpeNasd+q+cXGARqYmywsgE64uCKpDSC
   Q==;
X-CSE-ConnectionGUID: 7zZQ7Yb8SCmZZGCX6YPRJA==
X-CSE-MsgGUID: rs/Ib9i5RmqWjdXEpEdN2A==
X-IronPort-AV: E=McAfee;i="6700,10204,11413"; a="47226321"
X-IronPort-AV: E=Sophos;i="6.15,238,1739865600"; 
   d="scan'208";a="47226321"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2025 21:35:11 -0700
X-CSE-ConnectionGUID: a5diDpipRK+sn2VbOI8q7A==
X-CSE-MsgGUID: Y0y1V/sdS+yAeW6i4Gp4uQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,238,1739865600"; 
   d="scan'208";a="137644770"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa003.jf.intel.com with ESMTP; 24 Apr 2025 21:35:08 -0700
Date: Fri, 25 Apr 2025 12:30:30 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Qasim Ijaz <qasdev00@gmail.com>
Cc: mdf@kernel.org, hao.wu@intel.com, yilun.xu@intel.com, trix@redhat.com,
	akpm@linux-foundation.org, marpagan@redhat.com, arnd@arndb.de,
	linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
	Marco Pagani <marco.pagani@linux.dev>
Subject: Re: [PATCH v2 RESEND] fpga: fix potential null pointer deref in
 fpga_mgr_test_img_load_sgt()
Message-ID: <aAsP5qZ9+kGcmps0@yilunxu-OptiPlex-7050>
References: <20250422153737.5264-1-qasdev00@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250422153737.5264-1-qasdev00@gmail.com>

On Tue, Apr 22, 2025 at 04:37:37PM +0100, Qasim Ijaz wrote:
> fpga_mgr_test_img_load_sgt() allocates memory for sgt using
> kunit_kzalloc() however it does not check if the allocation failed. 
> It then passes sgt to sg_alloc_table(), which passes it to
> __sg_alloc_table(). This function calls memset() on sgt in an attempt to
> zero it out. If the allocation fails then sgt will be NULL and the
> memset will trigger a NULL pointer dereference.
> 
> Fix this by checking the allocation with KUNIT_ASSERT_NOT_ERR_OR_NULL().
> 
> Reviewed-by: Marco Pagani <marco.pagani@linux.dev>
> Fixes: ccbc1c302115 ("fpga: add an initial KUnit suite for the FPGA Manager")
> Signed-off-by: Qasim Ijaz <qasdev00@gmail.com>

Acked-by: Xu Yilun <yilun.xu@intel.com>

Applied to for-next.

> ---
> v2:
> - Remove stable CC tag since its just a kunit test
> 
>  drivers/fpga/tests/fpga-mgr-test.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/fpga/tests/fpga-mgr-test.c b/drivers/fpga/tests/fpga-mgr-test.c
> index 9cb37aefbac4..1902ebf5a298 100644
> --- a/drivers/fpga/tests/fpga-mgr-test.c
> +++ b/drivers/fpga/tests/fpga-mgr-test.c
> @@ -263,6 +263,7 @@ static void fpga_mgr_test_img_load_sgt(struct kunit *test)
>  	img_buf = init_test_buffer(test, IMAGE_SIZE);
>  
>  	sgt = kunit_kzalloc(test, sizeof(*sgt), GFP_KERNEL);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, sgt);
>  	ret = sg_alloc_table(sgt, 1, GFP_KERNEL);
>  	KUNIT_ASSERT_EQ(test, ret, 0);
>  	sg_init_one(sgt->sgl, img_buf, IMAGE_SIZE);
> -- 
> 2.39.5
> 
> 

