Return-Path: <linux-fpga+bounces-936-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E83E49D1415
	for <lists+linux-fpga@lfdr.de>; Mon, 18 Nov 2024 16:12:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06317B224BC
	for <lists+linux-fpga@lfdr.de>; Mon, 18 Nov 2024 14:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4846D1A9B3C;
	Mon, 18 Nov 2024 14:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ddLCclG/"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 924031991A5;
	Mon, 18 Nov 2024 14:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731941678; cv=none; b=QkjMDtmydFY7mr4Kc2IE0tw2m7oDBq779LJh9HGrK10lmUjJc4gzcuFlsgdES/4FPxBBEytNnRIj0ZObLL8EvLG9YNJ/vGrdMTx5Sb3G8397OtaiQrk4oez7owQ149POsX60WLogSny3cQjlhh7o9RqhGUOXJUZXhfzCGKhcwz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731941678; c=relaxed/simple;
	bh=W7Iw+nwV/pvu+lZwClyli84z5GYvXURSdRLGRQzVuSU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mfkQXggyu6SllpEvbHPKthOP4gqC4SoV5DUCh8mU4bZiLtbVhJdijIfumus/zzdxlPsKif4+r+6S3DIHDCfUulVWhb77gHpUzH798JexWjt7UIcf+iY7R3blGagniMhlHYRMBcRAvoLdlSYJBn+bylvVfnn3tTqIP5Lx6ywaDRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ddLCclG/; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731941677; x=1763477677;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=W7Iw+nwV/pvu+lZwClyli84z5GYvXURSdRLGRQzVuSU=;
  b=ddLCclG/J6KmWJxc1SuR/lk8vkaguB9w0po38pBZpbTNlEVDeAJ4UIYk
   +fYnBQjbAHERt5/bLnZ8z5CX560TrjC446dAV2QYWlIpQiu7Br+1/XQyb
   jatMZ/ws1emTwIiu4WE3cKiQ0LuI6Vqyf95cNoEP61TBMVyr4+pSoNPuG
   jQ3T1M4HXsuadEpWQOIcugTP6h+Mx24zZDUkq4CdJ90OvJubiQebKdHcm
   lyHdeGqOr7skRaxTI2DPqzWZa1g3/eL6ltZ3hyHqtoSJ3KQ95lN3KN8bl
   QZmXSLQwuKuHpXu2OixT8i2G2xjHxIGklbPYTpOfk7/Ot9aU5le4c5JIB
   Q==;
X-CSE-ConnectionGUID: 8fZrTui9SGmMSxuZ5w5kdw==
X-CSE-MsgGUID: PyFTitp/SQClWmpqY7jZ0A==
X-IronPort-AV: E=McAfee;i="6700,10204,11260"; a="31955262"
X-IronPort-AV: E=Sophos;i="6.12,164,1728975600"; 
   d="scan'208";a="31955262"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2024 06:54:36 -0800
X-CSE-ConnectionGUID: sGxlG9pBSj+Fm5miKVpypw==
X-CSE-MsgGUID: riC4UFwQTWm2brj89PKtRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="94289909"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa003.jf.intel.com with ESMTP; 18 Nov 2024 06:54:33 -0800
Date: Mon, 18 Nov 2024 22:51:40 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Peter Colberg <peter.colberg@intel.com>
Cc: Wu Hao <hao.wu@intel.com>, Tom Rix <trix@redhat.com>,
	Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>,
	linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
	Russ Weight <russ.weight@linux.dev>,
	Marco Pagani <marpagan@redhat.com>,
	Matthew Gerlach <matthew.gerlach@linux.intel.com>,
	Basheer Ahmed Muddebihal <basheer.ahmed.muddebihal@linux.intel.com>
Subject: Re: [PATCH v4 16/19] fpga: dfl: allocate platform device after
 feature device data
Message-ID: <ZztUfN8ySl0ck3h4@yilunxu-OptiPlex-7050>
References: <20241025223714.394533-1-peter.colberg@intel.com>
 <20241025223714.394533-17-peter.colberg@intel.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241025223714.394533-17-peter.colberg@intel.com>

On Fri, Oct 25, 2024 at 06:37:11PM -0400, Peter Colberg wrote:
> Delay calling platform_device_alloc() from build_info_create_dev() to
> feature_dev_register(), now that the feature device data contains all
> necessary data to create the feature device. This completes the new
> function feature_dev_register(), which will be reused in a subsequent
> commit to fully recreate the feature device when assigning a port.
> 
> Signed-off-by: Peter Colberg <peter.colberg@intel.com>
> Reviewed-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> Reviewed-by: Basheer Ahmed Muddebihal <basheer.ahmed.muddebihal@linux.intel.com>
> ---
> Changes since v3:
> - New patch extracted from last patch of v3 series.
> ---
>  drivers/fpga/dfl.c | 59 +++++++++++++++++-----------------------------
>  1 file changed, 22 insertions(+), 37 deletions(-)
> 
> diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
> index a9ec37278b2d..d9cef150ed0d 100644
> --- a/drivers/fpga/dfl.c
> +++ b/drivers/fpga/dfl.c
> @@ -681,7 +681,6 @@ EXPORT_SYMBOL_GPL(dfl_fpga_dev_ops_unregister);
>   * @nr_irqs: number of irqs for all feature devices.
>   * @irq_table: Linux IRQ numbers for all irqs, indexed by local irq index of
>   *	       this device.
> - * @feature_dev: current feature device.
>   * @type: the current FIU type.
>   * @ioaddr: header register region address of current FIU in enumeration.
>   * @start: register resource start of current FIU.
> @@ -695,7 +694,6 @@ struct build_feature_devs_info {
>  	unsigned int nr_irqs;
>  	int *irq_table;
>  
> -	struct platform_device *feature_dev;
>  	enum dfl_id_type type;
>  	void __iomem *ioaddr;
>  	resource_size_t start;
> @@ -750,7 +748,6 @@ static void dfl_id_free_action(void *arg)
>  static struct dfl_feature_dev_data *
>  binfo_create_feature_dev_data(struct build_feature_devs_info *binfo)
>  {
> -	struct platform_device *fdev = binfo->feature_dev;
>  	enum dfl_id_type type = binfo->type;
>  	struct dfl_feature_info *finfo, *p;
>  	struct dfl_feature_dev_data *fdata;
> @@ -773,7 +770,6 @@ binfo_create_feature_dev_data(struct build_feature_devs_info *binfo)
>  	if (!fdata->resources)
>  		return ERR_PTR(-ENOMEM);
>  
> -	fdata->dev = fdev;
>  	fdata->type = type;
>  
>  	fdata->pdev_id = dfl_id_alloc(type, binfo->dev);
> @@ -784,8 +780,6 @@ binfo_create_feature_dev_data(struct build_feature_devs_info *binfo)
>  	if (ret)
>  		return ERR_PTR(ret);
>  
> -	fdev->id = fdata->pdev_id;
> -
>  	fdata->pdev_name = dfl_devs[type].name;
>  	fdata->num = binfo->feature_num;
>  	fdata->dfl_cdev = binfo->cdev;
> @@ -809,7 +803,6 @@ binfo_create_feature_dev_data(struct build_feature_devs_info *binfo)
>  		unsigned int i;
>  
>  		/* save resource information for each feature */
> -		feature->dev = fdev;
>  		feature->id = finfo->fid;
>  		feature->revision = finfo->revision;
>  		feature->dfh_version = finfo->dfh_version;
> @@ -868,18 +861,6 @@ binfo_create_feature_dev_data(struct build_feature_devs_info *binfo)
>  static int
>  build_info_create_dev(struct build_feature_devs_info *binfo)
>  {
> -	enum dfl_id_type type = binfo->type;
> -	struct platform_device *fdev;
> -
> -	/*
> -	 * we use -ENODEV as the initialization indicator which indicates
> -	 * whether the id need to be reclaimed
> -	 */
> -	fdev = platform_device_alloc(dfl_devs[type].name, -ENODEV);
> -	if (!fdev)
> -		return -ENOMEM;
> -
> -	binfo->feature_dev = fdev;
>  	binfo->feature_num = 0;
>  
>  	INIT_LIST_HEAD(&binfo->sub_features);
> @@ -895,27 +876,43 @@ build_info_create_dev(struct build_feature_devs_info *binfo)
>  static int feature_dev_register(struct dfl_feature_dev_data *fdata)
>  {
>  	struct dfl_feature_platform_data pdata = {};
> -	struct platform_device *fdev = fdata->dev;
> +	struct platform_device *fdev;
> +	struct dfl_feature *feature;
>  	int ret;
>  
> +	fdev = platform_device_alloc(fdata->pdev_name, fdata->pdev_id);
> +	if (!fdev)
> +		return -ENOMEM;
> +
> +	fdata->dev = fdev;
> +
>  	fdev->dev.parent = &fdata->dfl_cdev->region->dev;
>  	fdev->dev.devt = dfl_get_devt(dfl_devs[fdata->type].devt_type, fdev->id);
>  
> +	dfl_fpga_dev_for_each_feature(fdata, feature)
> +		feature->dev = fdev;
> +
>  	ret = platform_device_add_resources(fdev, fdata->resources,
>  					    fdata->resource_num);
>  	if (ret)
> -		return ret;
> +		goto err_put_dev;
>  
>  	pdata.fdata = fdata;
>  	ret = platform_device_add_data(fdev, &pdata, sizeof(pdata));
>  	if (ret)
> -		return ret;
> +		goto err_put_dev;
>  
>  	ret = platform_device_add(fdev);
>  	if (ret)
> -		return ret;
> +		goto err_put_dev;
>  
>  	return 0;
> +
> +err_put_dev:
> +	platform_device_put(fdev);
> +	fdata->dev = NULL;

Do we also need to clean up all the feature->dev?

Thanks,
Yilun

> +
> +	return ret;
>  }
>  
>  static void feature_dev_unregister(struct dfl_feature_dev_data *fdata)
> @@ -940,16 +937,7 @@ static int build_info_commit_dev(struct build_feature_devs_info *binfo)
>  	if (binfo->type == PORT_ID)
>  		dfl_fpga_cdev_add_port_data(binfo->cdev, fdata);
>  	else
> -		binfo->cdev->fme_dev = get_device(&binfo->feature_dev->dev);
> -
> -	/*
> -	 * reset it to avoid build_info_free() freeing their resource.
> -	 *
> -	 * The resource of successfully registered feature devices
> -	 * will be freed by platform_device_unregister(). See the
> -	 * comments in build_info_create_dev().
> -	 */
> -	binfo->feature_dev = NULL;
> +		binfo->cdev->fme_dev = get_device(&fdata->dev->dev);
>  
>  	/* reset the binfo for next FIU */
>  	binfo->type = DFL_ID_MAX;
> @@ -966,8 +954,6 @@ static void build_info_free(struct build_feature_devs_info *binfo)
>  		kfree(finfo);
>  	}
>  
> -	platform_device_put(binfo->feature_dev);
> -
>  	devm_kfree(binfo->dev, binfo);
>  }
>  
> @@ -1262,8 +1248,7 @@ static int parse_feature_afu(struct build_feature_devs_info *binfo,
>  	case PORT_ID:
>  		return parse_feature_port_afu(binfo, ofst);
>  	default:
> -		dev_info(binfo->dev, "AFU belonging to FIU %s is not supported yet.\n",
> -			 binfo->feature_dev->name);
> +		dev_info(binfo->dev, "AFU belonging to FIU is not supported yet.\n");
>  	}
>  
>  	return 0;
> -- 
> 2.47.0
> 
> 

