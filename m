Return-Path: <linux-fpga+bounces-732-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41A17983D47
	for <lists+linux-fpga@lfdr.de>; Tue, 24 Sep 2024 08:45:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0698A28381B
	for <lists+linux-fpga@lfdr.de>; Tue, 24 Sep 2024 06:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B6591EB44;
	Tue, 24 Sep 2024 06:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PLiYPo4p"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC64481745;
	Tue, 24 Sep 2024 06:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727160289; cv=none; b=Q0d+w0rWyfsd0chhJTS4mf5nGY0r51XTVpQavCWQOvDBrZro1SYgM2Y4/Zy8CvyuojKn9m6mc2OuCM5rHxaXJASVefqps82p1+FB+L8yS8XXDaBfgXwsNwa5Vgs86KsICzbhXitnvynr/l66JoiBPbHolH/SmwHP1TBW4nKijIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727160289; c=relaxed/simple;
	bh=w6YX9s7qarswC+AVvU0XTJLTUutgn0bwti6HhT46QFo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r4RzmU0e5D5fl2xTBU52gleb5h+8hns+bUf34ldWzW5kxWMGkqm1arr3K2UKOMRVbiZCOQg8vCCwyp1QfJYiO+V1aR3GWXa+OX9GjkPBCE8Al0GtWEfndYiuDfOGgKS/l/cZfLwPRtfjWMxMJhXYxY2tM9llM6ELqx+mD/zDMek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PLiYPo4p; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727160288; x=1758696288;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=w6YX9s7qarswC+AVvU0XTJLTUutgn0bwti6HhT46QFo=;
  b=PLiYPo4pmt1GtQgUl5rg3kU+YPbjHf1kqDDPoyOw4SlMjvxsHGgCFQCX
   htoqnlSHC5B333TfyvTlRs51HckjxSgb9tTzb4IJHbSnjSSkONH0DWJIf
   YnqrFTpPboRP3qrTsRu4s2ElD0pY7eI/IC0VeAgyP7JTyn1T3uGp3KqEW
   fupcZCtG9n/CBVMPq14MHPocYlBwmKdwt7QMTnAPbyMcbkxEmHuqMqMwA
   erZwm4zjA/zj6uuRVUql7rZ3lxkv5SxQ+BSEIJxrtK32jPxFYV249IP/S
   gLOIBrEE5RF2/XIXeul9od5UFlPFLIiJ17qErQCwCciSrYPgonlKWOQAo
   Q==;
X-CSE-ConnectionGUID: xEZpQ+27QAy3n7lnPj1qSg==
X-CSE-MsgGUID: Mzobj75RRX+kEgYLi4/Y3g==
X-IronPort-AV: E=McAfee;i="6700,10204,11204"; a="25610812"
X-IronPort-AV: E=Sophos;i="6.10,253,1719903600"; 
   d="scan'208";a="25610812"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2024 23:44:47 -0700
X-CSE-ConnectionGUID: BGFrQMOETBaIXA2loN/MmA==
X-CSE-MsgGUID: 5jZrtRjRT+mdGeXGBpDpow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,253,1719903600"; 
   d="scan'208";a="71367109"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa009.jf.intel.com with ESMTP; 23 Sep 2024 23:44:44 -0700
Date: Tue, 24 Sep 2024 14:41:50 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Peter Colberg <peter.colberg@intel.com>
Cc: Wu Hao <hao.wu@intel.com>, Tom Rix <trix@redhat.com>,
	Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>,
	linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
	Russ Weight <russ.weight@linux.dev>,
	Marco Pagani <marpagan@redhat.com>,
	Matthew Gerlach <matthew.gerlach@linux.intel.com>
Subject: Re: [PATCH v3 2/9] fpga: dfl: omit unneeded null pointer check from
 {afu,fme}_open()
Message-ID: <ZvJfLplAyNTrPz+E@yilunxu-OptiPlex-7050>
References: <20240919203430.1278067-1-peter.colberg@intel.com>
 <20240919203430.1278067-3-peter.colberg@intel.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240919203430.1278067-3-peter.colberg@intel.com>

On Thu, Sep 19, 2024 at 04:34:23PM -0400, Peter Colberg wrote:
> The feature platform device is guaranteed to have an associated platform
> data. Refactor dfl_fpga_inode_to_feature_dev_data() to directly return
> the platform data and retrieve the device from the data.

These changelog better describes the change, but the short log does not.
Please update.

Thanks,
Yilun

> 
> Signed-off-by: Peter Colberg <peter.colberg@intel.com>
> Reviewed-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> ---
>  drivers/fpga/dfl-afu-main.c | 8 ++------
>  drivers/fpga/dfl-fme-main.c | 7 ++-----
>  drivers/fpga/dfl.h          | 6 +++---
>  3 files changed, 7 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/fpga/dfl-afu-main.c b/drivers/fpga/dfl-afu-main.c
> index 6b97c073849e..6125e2faada8 100644
> --- a/drivers/fpga/dfl-afu-main.c
> +++ b/drivers/fpga/dfl-afu-main.c
> @@ -595,14 +595,10 @@ static struct dfl_feature_driver port_feature_drvs[] = {
>  
>  static int afu_open(struct inode *inode, struct file *filp)
>  {
> -	struct platform_device *fdev = dfl_fpga_inode_to_feature_dev(inode);
> -	struct dfl_feature_platform_data *pdata;
> +	struct dfl_feature_platform_data *pdata = dfl_fpga_inode_to_feature_dev_data(inode);
> +	struct platform_device *fdev = pdata->dev;
>  	int ret;
>  
> -	pdata = dev_get_platdata(&fdev->dev);
> -	if (WARN_ON(!pdata))
> -		return -ENODEV;
> -
>  	mutex_lock(&pdata->lock);
>  	ret = dfl_feature_dev_use_begin(pdata, filp->f_flags & O_EXCL);
>  	if (!ret) {
> diff --git a/drivers/fpga/dfl-fme-main.c b/drivers/fpga/dfl-fme-main.c
> index 864924f68f5e..480a187289bb 100644
> --- a/drivers/fpga/dfl-fme-main.c
> +++ b/drivers/fpga/dfl-fme-main.c
> @@ -598,13 +598,10 @@ static long fme_ioctl_check_extension(struct dfl_feature_platform_data *pdata,
>  
>  static int fme_open(struct inode *inode, struct file *filp)
>  {
> -	struct platform_device *fdev = dfl_fpga_inode_to_feature_dev(inode);
> -	struct dfl_feature_platform_data *pdata = dev_get_platdata(&fdev->dev);
> +	struct dfl_feature_platform_data *pdata = dfl_fpga_inode_to_feature_dev_data(inode);
> +	struct platform_device *fdev = pdata->dev;
>  	int ret;
>  
> -	if (WARN_ON(!pdata))
> -		return -ENODEV;
> -
>  	mutex_lock(&pdata->lock);
>  	ret = dfl_feature_dev_use_begin(pdata, filp->f_flags & O_EXCL);
>  	if (!ret) {
> diff --git a/drivers/fpga/dfl.h b/drivers/fpga/dfl.h
> index 5063d73b0d82..2285215f444e 100644
> --- a/drivers/fpga/dfl.h
> +++ b/drivers/fpga/dfl.h
> @@ -398,14 +398,14 @@ int dfl_fpga_dev_ops_register(struct platform_device *pdev,
>  			      struct module *owner);
>  void dfl_fpga_dev_ops_unregister(struct platform_device *pdev);
>  
> -static inline
> -struct platform_device *dfl_fpga_inode_to_feature_dev(struct inode *inode)
> +static inline struct dfl_feature_platform_data *
> +dfl_fpga_inode_to_feature_dev_data(struct inode *inode)
>  {
>  	struct dfl_feature_platform_data *pdata;
>  
>  	pdata = container_of(inode->i_cdev, struct dfl_feature_platform_data,
>  			     cdev);
> -	return pdata->dev;
> +	return pdata;
>  }
>  
>  #define dfl_fpga_dev_for_each_feature(pdata, feature)			    \
> -- 
> 2.46.1
> 
> 

