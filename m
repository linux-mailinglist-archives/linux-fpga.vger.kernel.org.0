Return-Path: <linux-fpga+bounces-735-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5C9B98419D
	for <lists+linux-fpga@lfdr.de>; Tue, 24 Sep 2024 11:06:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9A421C240C4
	for <lists+linux-fpga@lfdr.de>; Tue, 24 Sep 2024 09:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4E4017332A;
	Tue, 24 Sep 2024 09:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bA+OWzVh"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EEFC1547D8;
	Tue, 24 Sep 2024 09:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727168672; cv=none; b=m4YxDgAe/T1BNxIBGUrv+u/ChXp3E+fbi5iXN22tREhauY8w1riR9iEgupfUR4vbi5pFWkZRLzIM24MhbhHo33hfPl023CH2Q+XVcIIglCPKoMo/E8J5OScU1oTO5N1R5+ehURqBbP8NIZU9lRBlb1ZpqEd7ZJZ5HgzzQ4pb6qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727168672; c=relaxed/simple;
	bh=pIur/2YekNHbuCPnewpPzwoLVqBZdsGCMI6j2U9lMjg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=utbqRiPH+tk96BXz9VTfOZ+lcpkgQkgBfJJisi1kgz9iRAxLVGeNBS0IunF4VlAn67mvwfTEyZ4eY4cjC66D20BFiaHtOtDIEbAJllTrwN0C5ooSX1CtlqT5i1YrG2fgN8kv43vm8R3oXVo8qOVRRwD/q9lr3SEatbBHNlHw/sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bA+OWzVh; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727168671; x=1758704671;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pIur/2YekNHbuCPnewpPzwoLVqBZdsGCMI6j2U9lMjg=;
  b=bA+OWzVhfp1KtSoI4P2C9mNI9+7AqMlElCrodLOnLUUeaNtxOrVWVALH
   kOdD3HaucP5kg1sc857D3klgTdjpnQPMewQWBkmXEbYgBSOliGXBITHj+
   ft4eXEuLrMYuc8J2NdnZU3TlAUTVAjVrIwZUAURlIvDwS3IeO/fDxdzGA
   fxspR/WI45O8cs1lvfr53NRCVih7f2b7Lnl0SgUGx8cg0pC/AziACcg0l
   e+qACHif5IPI+4+a+ETJZ2baKvCzSYvYQsjiATN6Tu6BgwkfVRu1TWCvi
   3vNU8ag/Fa9NrXmeBmaFj9nHYkJv7ovDGqjTHtqPb4RIS/dNEXepkOoDC
   w==;
X-CSE-ConnectionGUID: VhuA+ivtSMGA5DZelPZBMw==
X-CSE-MsgGUID: I19P8SXoSaOylMQ1cSMCeA==
X-IronPort-AV: E=McAfee;i="6700,10204,11204"; a="26028131"
X-IronPort-AV: E=Sophos;i="6.10,254,1719903600"; 
   d="scan'208";a="26028131"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2024 02:04:30 -0700
X-CSE-ConnectionGUID: /dmdixhVRRWJdy6G2vMw0w==
X-CSE-MsgGUID: OfVKPM/gTTGwkk4XkhPoGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,254,1719903600"; 
   d="scan'208";a="72178821"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa008.jf.intel.com with ESMTP; 24 Sep 2024 02:04:26 -0700
Date: Tue, 24 Sep 2024 17:01:31 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Peter Colberg <peter.colberg@intel.com>
Cc: Wu Hao <hao.wu@intel.com>, Tom Rix <trix@redhat.com>,
	Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>,
	linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
	Russ Weight <russ.weight@linux.dev>,
	Marco Pagani <marpagan@redhat.com>,
	Matthew Gerlach <matthew.gerlach@linux.intel.com>,
	Russ Weight <russell.h.weight@intel.com>
Subject: Re: [PATCH v3 9/9] fpga: dfl: fix kernel warning on port
 release/assign for SRIOV
Message-ID: <ZvJ/6wHoU9VXJKh8@yilunxu-OptiPlex-7050>
References: <20240919203430.1278067-1-peter.colberg@intel.com>
 <20240919203430.1278067-10-peter.colberg@intel.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240919203430.1278067-10-peter.colberg@intel.com>

On Thu, Sep 19, 2024 at 04:34:30PM -0400, Peter Colberg wrote:
> From: Xu Yilun <yilun.xu@intel.com>
> 

Please describe what this patch does at the beginning. And below
background descriptions follow.

> With the Intel FPGA PAC D5005, DFL ports are registered as platform
> devices in PF mode. The port device must be removed from the host when
> the user wants to configure the port as a VF for use by a user-space
> driver, e.g., for pass-through to a virtual machine. The FME device
> ioctls DFL_FPGA_FME_PORT_RELEASE/ASSIGN are assigned for this purpose.
> 
> In the previous implementation, the port platform device is not
> completely destroyed on port release: it is removed from the system by
> platform_device_del(), but the platform device instance is retained.
> When DFL_FPGA_FME_PORT_ASSIGN is called, the platform device is added
> back with platform_device_add(), which conflicts with this comment of
> device_add(): "Do not call this routine more than once for any device
> structure", and would previously cause a kernel warning at runtime.
> 
> This patch completely unregisters the port platform device on release
> and registers a new device on assign. But the main work is to remove

The main work of this series, not this patch.

> the dependency on struct dfl_feature_platform_data for many internal DFL
> APIs. This structure holds many DFL enumeration infos for feature
> devices. Many DFL APIs are expected to work with these infos even when
> the port platform device is unregistered. But after this change, the
> platform_data will be freed on port release. Hence this patch introduces
> a new structure dfl_feature_dev_data, which acts similarly to the
> previous dfl_feature_platform_data. dfl_feature_platform_data then only
> needs a pointer to dfl_feature_dev_data to query DFL enumeration infos.
> 
> Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> Signed-off-by: Peter Colberg <peter.colberg@intel.com>
> Reviewed-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> ---
>  drivers/fpga/dfl-fme-br.c |   2 -
>  drivers/fpga/dfl.c        | 207 ++++++++++++++++++--------------------
>  drivers/fpga/dfl.h        |  57 +++++++----
>  3 files changed, 133 insertions(+), 133 deletions(-)
> 
> diff --git a/drivers/fpga/dfl-fme-br.c b/drivers/fpga/dfl-fme-br.c
> index 5c60a38ec76c..a298a041877b 100644
> --- a/drivers/fpga/dfl-fme-br.c
> +++ b/drivers/fpga/dfl-fme-br.c
> @@ -85,8 +85,6 @@ static void fme_br_remove(struct platform_device *pdev)
>  
>  	fpga_bridge_unregister(br);
>  
> -	if (priv->port_fdata)
> -		put_device(&priv->port_fdata->dev->dev);

I can't remember why all the get_device/put_device() are not needed anymore.

>  	if (priv->port_ops)
>  		dfl_fpga_port_ops_put(priv->port_ops);
>  }
> diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
> index 52f58d029ca4..a77d7692b170 100644
> --- a/drivers/fpga/dfl.c
> +++ b/drivers/fpga/dfl.c
> @@ -160,7 +160,7 @@ struct dfl_fpga_port_ops *dfl_fpga_port_ops_get(struct dfl_feature_dev_data *fda
>  
>  	list_for_each_entry(ops, &dfl_port_ops_list, node) {
>  		/* match port_ops using the name of platform device */
> -		if (!strcmp(fdata->dev->name, ops->name)) {
> +		if (!strcmp(fdata->pdev_name, ops->name)) {
>  			if (!try_module_get(ops->owner))
>  				ops = NULL;
>  			goto done;
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
> @@ -736,7 +734,6 @@ static void dfl_fpga_cdev_add_port_data(struct dfl_fpga_cdev *cdev,
>  {
>  	mutex_lock(&cdev->lock);
>  	list_add(&fdata->node, &cdev->port_dev_list);
> -	get_device(&fdata->dev->dev);
>  	mutex_unlock(&cdev->lock);
>  }
>  
> @@ -744,7 +741,6 @@ static struct dfl_feature_dev_data *
>  binfo_create_feature_dev_data(struct build_feature_devs_info *binfo)
>  {
>  	enum dfl_id_type type = binfo->type;
> -	struct platform_device *fdev = binfo->feature_dev;
>  	struct dfl_feature_info *finfo, *p;
>  	struct dfl_feature_dev_data *fdata;
>  	int ret, index = 0, res_idx = 0;
> @@ -752,18 +748,27 @@ binfo_create_feature_dev_data(struct build_feature_devs_info *binfo)
>  	if (WARN_ON_ONCE(type >= DFL_ID_MAX))
>  		return ERR_PTR(-EINVAL);
>  
> -	/*
> -	 * we do not need to care for the memory which is associated with
> -	 * the platform device. After calling platform_device_unregister(),
> -	 * it will be automatically freed by device's release() callback,
> -	 * platform_device_release().
> -	 */
> -	fdata = kzalloc(struct_size(fdata, features, binfo->feature_num), GFP_KERNEL);
> +	fdata = devm_kzalloc(binfo->dev, sizeof(*fdata), GFP_KERNEL);
>  	if (!fdata)
>  		return ERR_PTR(-ENOMEM);
>  
> -	fdata->dev = fdev;
> +	fdata->features = devm_kcalloc(binfo->dev, binfo->feature_num,
> +				       sizeof(*fdata->features), GFP_KERNEL);
> +	if (!fdata->features)
> +		return ERR_PTR(-ENOMEM);
> +
> +	fdata->resources = devm_kcalloc(binfo->dev, binfo->feature_num,
> +					sizeof(*fdata->resources), GFP_KERNEL);
> +	if (!fdata->resources)
> +		return ERR_PTR(-ENOMEM);
> +
>  	fdata->type = type;
> +
> +	fdata->pdev_id = dfl_id_alloc(type, binfo->dev);
> +	if (fdata->pdev_id < 0)
> +		return ERR_PTR(fdata->pdev_id);
> +
> +	fdata->pdev_name = dfl_devs[type].name;
>  	fdata->num = binfo->feature_num;
>  	fdata->dfl_cdev = binfo->cdev;
>  	fdata->id = FEATURE_DEV_ID_UNUSED;
> @@ -779,15 +784,6 @@ binfo_create_feature_dev_data(struct build_feature_devs_info *binfo)
>  	 */
>  	WARN_ON(fdata->disable_count);
>  
> -	fdev->dev.platform_data = fdata;
> -
> -	/* each sub feature has one MMIO resource */
> -	fdev->num_resources = binfo->feature_num;
> -	fdev->resource = kcalloc(binfo->feature_num, sizeof(*fdev->resource),
> -				 GFP_KERNEL);
> -	if (!fdev->resource)
> -		return ERR_PTR(-ENOMEM);
> -
>  	/* fill features and resource information for feature dev */
>  	list_for_each_entry_safe(finfo, p, &binfo->sub_features, node) {
>  		struct dfl_feature *feature = &fdata->features[index++];
> @@ -795,7 +791,6 @@ binfo_create_feature_dev_data(struct build_feature_devs_info *binfo)
>  		unsigned int i;
>  
>  		/* save resource information for each feature */
> -		feature->dev = fdev;
>  		feature->id = finfo->fid;
>  		feature->revision = finfo->revision;
>  		feature->dfh_version = finfo->dfh_version;
> @@ -804,8 +799,10 @@ binfo_create_feature_dev_data(struct build_feature_devs_info *binfo)
>  			feature->params = devm_kmemdup(binfo->dev,
>  						       finfo->params, finfo->param_size,
>  						       GFP_KERNEL);
> -			if (!feature->params)
> -				return ERR_PTR(-ENOMEM);
> +			if (!feature->params) {
> +				ret = -ENOMEM;
> +				goto err_free_id;
> +			}
>  
>  			feature->param_size = finfo->param_size;
>  		}
> @@ -823,19 +820,20 @@ binfo_create_feature_dev_data(struct build_feature_devs_info *binfo)
>  						      &finfo->mmio_res);
>  			if (IS_ERR(feature->ioaddr)) {
>  				ret = PTR_ERR(feature->ioaddr);
> -				return ERR_PTR(ret);
> +				goto err_free_id;
>  			}
>  		} else {
>  			feature->resource_index = res_idx;
> -			fdev->resource[res_idx++] = finfo->mmio_res;
> +			fdata->resources[res_idx++] = finfo->mmio_res;
>  		}
>  
>  		if (finfo->nr_irqs) {
>  			ctx = devm_kcalloc(binfo->dev, finfo->nr_irqs,
>  					   sizeof(*ctx), GFP_KERNEL);
> -			if (!ctx)
> -				return ERR_PTR(-ENOMEM);
> -
> +			if (!ctx) {
> +				ret = -ENOMEM;
> +				goto err_free_id;
> +			}
>  			for (i = 0; i < finfo->nr_irqs; i++)
>  				ctx[i].irq =
>  					binfo->irq_table[finfo->irq_base + i];
> @@ -848,36 +846,67 @@ binfo_create_feature_dev_data(struct build_feature_devs_info *binfo)
>  		kfree(finfo);
>  	}
>  
> +	fdata->resource_num = res_idx;
> +
>  	return fdata;
> +
> +err_free_id:
> +	dfl_id_free(type, fdata->pdev_id);
> +
> +	return ERR_PTR(ret);
>  }
>  
> -static int
> -build_info_create_dev(struct build_feature_devs_info *binfo)
> +/*
> + * register current feature device, it is called when we need to switch to
> + * another feature parsing or we have parsed all features on given device
> + * feature list.
> + */
> +static int feature_dev_register(struct dfl_feature_dev_data *fdata)
>  {
> -	enum dfl_id_type type = binfo->type;
> +	struct dfl_feature_platform_data pdata = {};
>  	struct platform_device *fdev;
> +	struct dfl_feature *feature;
> +	int ret;
>  
> -	/*
> -	 * we use -ENODEV as the initialization indicator which indicates
> -	 * whether the id need to be reclaimed
> -	 */
> -	fdev = platform_device_alloc(dfl_devs[type].name, -ENODEV);
> +	fdev = platform_device_alloc(fdata->pdev_name, fdata->pdev_id);

I see a part of the change is to delay the platform_device_alloc() so
that the feature platform device registration work could be gathered in
one function. Not sure if it is necessary for the port platform release
issue, or could be an independent enhancement patch.

I raise this cause I still feel hard to understand all these changes
in this patch and look for any chance to further split it.


BTW: Overall this series is much improved than the last version.

Thanks,
Yilun

