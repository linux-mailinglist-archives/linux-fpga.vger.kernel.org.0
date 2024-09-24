Return-Path: <linux-fpga+bounces-733-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F823983E06
	for <lists+linux-fpga@lfdr.de>; Tue, 24 Sep 2024 09:18:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1EAE2819CC
	for <lists+linux-fpga@lfdr.de>; Tue, 24 Sep 2024 07:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9087812C544;
	Tue, 24 Sep 2024 07:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QNvH2NIL"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B9871A270;
	Tue, 24 Sep 2024 07:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727162312; cv=none; b=KKXJ46rk0ga1yfP1scaJse+WFd6q2AU68Sa9zTKYTIkLB7f4e5f2U6/7MA1Moig95DhoMm32zxoPTX+vlchyH6Ydie990mIbWa+45z33okLfFQ0HjgxSQ0I6FgH6VdFkt/+AAk/osf9G76wYUw19iwGROL1WGBMfGpbokl3O3Cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727162312; c=relaxed/simple;
	bh=13W/S/960G9LH0E9Svih4veY12utj/2kO1lJZ5f++Zc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a4SjlZ1Wf/eWh6ySWdEbD4yFjo9N3BckW/CQsbnAdY3H0y+C9aoZTSmMyXlq0dXcPPIT/G+QqpDxomG5I/3nc9sZpX1oEXIj4TcBNzyJSflBpXFxG+qc3oCCWUVpsxmpFGAxuqXqsyuPIzFSvmxQKh/hW3pdpxPO5I5q7JHmDAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QNvH2NIL; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727162311; x=1758698311;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=13W/S/960G9LH0E9Svih4veY12utj/2kO1lJZ5f++Zc=;
  b=QNvH2NILzk3WId/sf5Bt2zgmVxqR99PL1ZCybble8Dex5S4XATuFxkCj
   01J19/u1Kx7yhOQdX+Q5m4M5h0FIxrQqpl4YuRm+51fcBu/ZFVWwdkulO
   ExOg6UYQ0xItJ3TvIFwSnjh6jkEDppX0g4vTGpVQ4shszIdQ2a3VG1WGL
   yRSGy1xi+962gZYGJbJYklDFjlPDzeV7XmJFvm32uv54qGOV6sJvrdOVk
   do0FUIitVX9sQj98vXirIaYmax2z5ozYKgUFz5sRFMNBGNFirgg7EtDxn
   4rmv+nOxCPt7B9Ju/GN92cEBqSXOJrrLKJgFpFC44LCk4QFdFVqHBezvD
   g==;
X-CSE-ConnectionGUID: Ofq8ZvD8SNSKGlg1E7m5cA==
X-CSE-MsgGUID: 6l3QP7hCTIGb0WQSFh9T3g==
X-IronPort-AV: E=McAfee;i="6700,10204,11204"; a="43609262"
X-IronPort-AV: E=Sophos;i="6.10,253,1719903600"; 
   d="scan'208";a="43609262"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2024 00:18:21 -0700
X-CSE-ConnectionGUID: SkMfx9QNTiyf2DADT11LzQ==
X-CSE-MsgGUID: QknmVD9hT8Gu9DiQtT+PyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,253,1719903600"; 
   d="scan'208";a="71327431"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa009.fm.intel.com with ESMTP; 24 Sep 2024 00:18:17 -0700
Date: Tue, 24 Sep 2024 15:15:23 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Peter Colberg <peter.colberg@intel.com>
Cc: Wu Hao <hao.wu@intel.com>, Tom Rix <trix@redhat.com>,
	Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>,
	linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
	Russ Weight <russ.weight@linux.dev>,
	Marco Pagani <marpagan@redhat.com>,
	Matthew Gerlach <matthew.gerlach@linux.intel.com>
Subject: Re: [PATCH v3 6/9] fpga: dfl: factor out feature data creation from
 build_info_commit_dev()
Message-ID: <ZvJnC7hHISkbOo2n@yilunxu-OptiPlex-7050>
References: <20240919203430.1278067-1-peter.colberg@intel.com>
 <20240919203430.1278067-7-peter.colberg@intel.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240919203430.1278067-7-peter.colberg@intel.com>

On Thu, Sep 19, 2024 at 04:34:27PM -0400, Peter Colberg wrote:
> Add a separate function binfo_create_feature_dev_data() which allocates
> and populates the feature platform data, and call the function from
> build_info_commit_dev() which registers the feature platform device.
> 
> Signed-off-by: Peter Colberg <peter.colberg@intel.com>
> Reviewed-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> ---
>  drivers/fpga/dfl.c | 74 ++++++++++++++++++++++++++--------------------
>  1 file changed, 42 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
> index 4c79d433d216..e644eb9fde39 100644
> --- a/drivers/fpga/dfl.c
> +++ b/drivers/fpga/dfl.c
> @@ -749,12 +749,8 @@ static void dfl_fpga_cdev_add_port_data(struct dfl_fpga_cdev *cdev,
>  	mutex_unlock(&cdev->lock);
>  }
>  
> -/*
> - * register current feature device, it is called when we need to switch to
> - * another feature parsing or we have parsed all features on given device
> - * feature list.
> - */
> -static int build_info_commit_dev(struct build_feature_devs_info *binfo)
> +static struct dfl_feature_platform_data *
> +binfo_create_feature_dev_data(struct build_feature_devs_info *binfo)
>  {
>  	struct platform_device *fdev = binfo->feature_dev;
>  	struct dfl_feature_platform_data *pdata;
> @@ -764,7 +760,7 @@ static int build_info_commit_dev(struct build_feature_devs_info *binfo)
>  
>  	type = feature_dev_id_type(fdev);
>  	if (WARN_ON_ONCE(type >= DFL_ID_MAX))
> -		return -EINVAL;
> +		return ERR_PTR(-EINVAL);
>  
>  	/*
>  	 * we do not need to care for the memory which is associated with
> @@ -774,7 +770,7 @@ static int build_info_commit_dev(struct build_feature_devs_info *binfo)
>  	 */
>  	pdata = kzalloc(struct_size(pdata, features, binfo->feature_num), GFP_KERNEL);
>  	if (!pdata)
> -		return -ENOMEM;
> +		return ERR_PTR(-ENOMEM);
>  
>  	pdata->dev = fdev;
>  	pdata->num = binfo->feature_num;
> @@ -799,7 +795,7 @@ static int build_info_commit_dev(struct build_feature_devs_info *binfo)
>  	fdev->resource = kcalloc(binfo->feature_num, sizeof(*fdev->resource),
>  				 GFP_KERNEL);
>  	if (!fdev->resource)
> -		return -ENOMEM;
> +		return ERR_PTR(-ENOMEM);
>  
>  	/* fill features and resource information for feature dev */
>  	list_for_each_entry_safe(finfo, p, &binfo->sub_features, node) {
> @@ -818,7 +814,7 @@ static int build_info_commit_dev(struct build_feature_devs_info *binfo)
>  						       finfo->params, finfo->param_size,
>  						       GFP_KERNEL);
>  			if (!feature->params)
> -				return -ENOMEM;
> +				return ERR_PTR(-ENOMEM);
>  
>  			feature->param_size = finfo->param_size;
>  		}
> @@ -834,8 +830,10 @@ static int build_info_commit_dev(struct build_feature_devs_info *binfo)
>  			feature->ioaddr =
>  				devm_ioremap_resource(binfo->dev,
>  						      &finfo->mmio_res);
> -			if (IS_ERR(feature->ioaddr))
> -				return PTR_ERR(feature->ioaddr);
> +			if (IS_ERR(feature->ioaddr)) {
> +				ret = PTR_ERR(feature->ioaddr);
> +				return ERR_PTR(ret);

Why change the type back and forth?

  return feature->ioaddr;

is it OK?

Thanks,
Yilun

