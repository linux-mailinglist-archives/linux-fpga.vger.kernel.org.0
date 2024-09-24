Return-Path: <linux-fpga+bounces-734-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43010983F9C
	for <lists+linux-fpga@lfdr.de>; Tue, 24 Sep 2024 09:46:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C6871C229C7
	for <lists+linux-fpga@lfdr.de>; Tue, 24 Sep 2024 07:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DF4114D2BD;
	Tue, 24 Sep 2024 07:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E9lZaGYI"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D8E1494A3;
	Tue, 24 Sep 2024 07:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727163960; cv=none; b=PCC68L5DQV8O1hLkJq+7t232oCmMSfi7F6xatG8GV+Cn2z3gIpv6r5/wtNQrOzpOgkeVuHhOAvrUNmrmkPpMxiuiMzIe/LYxiTd2qX7hz8M4rwhi1/thMLTb8vcXxsQq6fiCluu35YNYQzZDT/wZy/KCCwUreOUCbCPhhfbx9W0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727163960; c=relaxed/simple;
	bh=zN/s5ZIuAhecqLXbsRHCxK97tt/OADzp9Qo3Ga1kqYM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qMyIS8zC7hfnn1wuyXombQVmjmEbtatdz81a4v+ad4u1vpHoMWnvHLJXcwZEwBYKznWiegx0N1MdPFMPD+TGplomVhiBUCgnyqb/sMd/b6L8RRDXuOHzldWkwEWEAQ0xfQkZWjkO+ZRyDLFmMD5ImuonTMsP2zZONw/OBOimBfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E9lZaGYI; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727163958; x=1758699958;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zN/s5ZIuAhecqLXbsRHCxK97tt/OADzp9Qo3Ga1kqYM=;
  b=E9lZaGYIrgIMN5hI8Ev3vu1XYZwTianqO6hVO6Jo0IekYRkzkYdA2maM
   HktYTrns0vzWiX3H95nLoW/L5pVKu4NnZ/eLA3SlmDFykfjT0aZ7fI8Zo
   nEgtVzclCca5RZGh6lK3bPbIVnnluwT/a48JrvBelO9/9vGWZqroyVJQb
   8EXL2z0rQxJfp8yeiesL/mOblspWxRtxOXfgGT2GYgfdZ/Yvn8wDFRiWl
   eT64VNDTEhHflwga5r0vJOwhdKThV/1GwmOWPqnXl31zJVKkf0QL0L3th
   D+GugaSBl8aYFvaRRVlkfxxW1+2gFoad2xabkGAenIKvJqbVBZ74WP6+N
   Q==;
X-CSE-ConnectionGUID: IrwE/AGHTDGCTgUuq4pEfg==
X-CSE-MsgGUID: KBg6q63fSv2XWaMm9+Rz5w==
X-IronPort-AV: E=McAfee;i="6700,10204,11204"; a="43660619"
X-IronPort-AV: E=Sophos;i="6.10,253,1719903600"; 
   d="scan'208";a="43660619"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2024 00:45:56 -0700
X-CSE-ConnectionGUID: MDrG7BL6RjOAvTqv1E7zgw==
X-CSE-MsgGUID: vS2IO8SjQAi3TO+4Q6HetQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,253,1719903600"; 
   d="scan'208";a="71476361"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa008.fm.intel.com with ESMTP; 24 Sep 2024 00:45:54 -0700
Date: Tue, 24 Sep 2024 15:42:59 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Peter Colberg <peter.colberg@intel.com>
Cc: Wu Hao <hao.wu@intel.com>, Tom Rix <trix@redhat.com>,
	Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>,
	linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
	Russ Weight <russ.weight@linux.dev>,
	Marco Pagani <marpagan@redhat.com>,
	Matthew Gerlach <matthew.gerlach@linux.intel.com>
Subject: Re: [PATCH v3 7/9] fpga: dfl: store FIU type in feature platform data
Message-ID: <ZvJtg/IFmZAiaJBT@yilunxu-OptiPlex-7050>
References: <20240919203430.1278067-1-peter.colberg@intel.com>
 <20240919203430.1278067-8-peter.colberg@intel.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240919203430.1278067-8-peter.colberg@intel.com>

On Thu, Sep 19, 2024 at 04:34:28PM -0400, Peter Colberg wrote:
> Remove the local function feature_dev_id_type() in favour of persisting
> the FIU type in struct dfl_feature_platform_data. Add type to struct
> build_feature_devs_info and drop argument to build_info_create_dev().
> 
> Signed-off-by: Peter Colberg <peter.colberg@intel.com>
> Reviewed-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> ---
>  drivers/fpga/dfl.c | 57 ++++++++++++++++++++++------------------------
>  drivers/fpga/dfl.h |  3 +++
>  2 files changed, 30 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
> index e644eb9fde39..9610ef1ec2ff 100644
> --- a/drivers/fpga/dfl.c
> +++ b/drivers/fpga/dfl.c
> @@ -119,17 +119,6 @@ static void dfl_id_free(enum dfl_id_type type, int id)
>  	mutex_unlock(&dfl_id_mutex);
>  }
>  
> -static enum dfl_id_type feature_dev_id_type(struct platform_device *pdev)
> -{
> -	int i;
> -
> -	for (i = 0; i < ARRAY_SIZE(dfl_devs); i++)
> -		if (!strcmp(dfl_devs[i].name, pdev->name))
> -			return i;
> -
> -	return DFL_ID_MAX;
> -}
> -
>  static enum dfl_id_type dfh_id_to_type(u16 id)
>  {
>  	int i;
> @@ -379,7 +368,7 @@ dfl_dev_add(struct dfl_feature_platform_data *pdata,
>  	if (ret)
>  		goto put_dev;
>  
> -	ddev->type = feature_dev_id_type(pdev);
> +	ddev->type = pdata->type;
>  	ddev->feature_id = feature->id;
>  	ddev->revision = feature->revision;
>  	ddev->dfh_version = feature->dfh_version;
> @@ -693,6 +682,7 @@ EXPORT_SYMBOL_GPL(dfl_fpga_dev_ops_unregister);
>   * @irq_table: Linux IRQ numbers for all irqs, indexed by local irq index of
>   *	       this device.
>   * @feature_dev: current feature device.
> + * @type: the current FIU type.
>   * @ioaddr: header register region address of current FIU in enumeration.
>   * @start: register resource start of current FIU.
>   * @len: max register resource length of current FIU.
> @@ -706,6 +696,7 @@ struct build_feature_devs_info {
>  	int *irq_table;
>  
>  	struct platform_device *feature_dev;
> +	enum dfl_id_type type;
>  	void __iomem *ioaddr;
>  	resource_size_t start;
>  	resource_size_t len;
> @@ -752,13 +743,12 @@ static void dfl_fpga_cdev_add_port_data(struct dfl_fpga_cdev *cdev,
>  static struct dfl_feature_platform_data *
>  binfo_create_feature_dev_data(struct build_feature_devs_info *binfo)
>  {
> +	enum dfl_id_type type = binfo->type;
>  	struct platform_device *fdev = binfo->feature_dev;
>  	struct dfl_feature_platform_data *pdata;
>  	struct dfl_feature_info *finfo, *p;
> -	enum dfl_id_type type;

Move this line up breaks the reverse Xmas tree, seems no need.

>  	int ret, index = 0, res_idx = 0;
>  
> -	type = feature_dev_id_type(fdev);
>  	if (WARN_ON_ONCE(type >= DFL_ID_MAX))
>  		return ERR_PTR(-EINVAL);
>  
> @@ -773,6 +763,7 @@ binfo_create_feature_dev_data(struct build_feature_devs_info *binfo)
>  		return ERR_PTR(-ENOMEM);
>  
>  	pdata->dev = fdev;
> +	pdata->type = type;
>  	pdata->num = binfo->feature_num;
>  	pdata->dfl_cdev = binfo->cdev;
>  	pdata->id = FEATURE_DEV_ID_UNUSED;
> @@ -861,14 +852,11 @@ binfo_create_feature_dev_data(struct build_feature_devs_info *binfo)
>  }
>  
>  static int
> -build_info_create_dev(struct build_feature_devs_info *binfo,
> -		      enum dfl_id_type type)
> +build_info_create_dev(struct build_feature_devs_info *binfo)
>  {
> +	enum dfl_id_type type = binfo->type;
>  	struct platform_device *fdev;
>  
> -	if (type >= DFL_ID_MAX)
> -		return -EINVAL;
> -
>  	/*
>  	 * we use -ENODEV as the initialization indicator which indicates
>  	 * whether the id need to be reclaimed
> @@ -905,7 +893,7 @@ static int build_info_commit_dev(struct build_feature_devs_info *binfo)
>  	if (ret)
>  		return ret;
>  
> -	if (feature_dev_id_type(binfo->feature_dev) == PORT_ID)
> +	if (binfo->type == PORT_ID)
>  		dfl_fpga_cdev_add_port_data(binfo->cdev, pdata);
>  	else
>  		binfo->cdev->fme_dev = get_device(&binfo->feature_dev->dev);
> @@ -919,6 +907,9 @@ static int build_info_commit_dev(struct build_feature_devs_info *binfo)
>  	 */
>  	binfo->feature_dev = NULL;
>  
> +	/* reset the binfo for next FIU */
> +	binfo->type = DFL_ID_MAX;
> +
>  	return 0;
>  }
>  
> @@ -931,8 +922,7 @@ static void build_info_free(struct build_feature_devs_info *binfo)
>  	 * build_info_create_dev()
>  	 */
>  	if (binfo->feature_dev && binfo->feature_dev->id >= 0) {
> -		dfl_id_free(feature_dev_id_type(binfo->feature_dev),
> -			    binfo->feature_dev->id);
> +		dfl_id_free(binfo->type, binfo->feature_dev->id);
>  
>  		list_for_each_entry_safe(finfo, p, &binfo->sub_features, node) {
>  			list_del(&finfo->node);
> @@ -1030,7 +1020,7 @@ static int parse_feature_irqs(struct build_feature_devs_info *binfo,
>  		 * Instead, features with interrupt functionality provide
>  		 * the information in feature specific registers.
>  		 */
> -		type = feature_dev_id_type(binfo->feature_dev);
> +		type = binfo->type;
>  		if (type == PORT_ID) {
>  			switch (fid) {
>  			case PORT_FEATURE_ID_UINT:
> @@ -1222,7 +1212,7 @@ static int parse_feature_port_afu(struct build_feature_devs_info *binfo,
>  	return create_feature_instance(binfo, ofst, size, FEATURE_ID_AFU);
>  }
>  
> -#define is_feature_dev_detected(binfo) (!!(binfo)->feature_dev)
> +#define is_feature_dev_detected(binfo) ((binfo)->type != DFL_ID_MAX)

Seems too early to make this change. The 2 fields don't always align in
this phase ..

>  
>  static int parse_feature_afu(struct build_feature_devs_info *binfo,
>  			     resource_size_t ofst)
> @@ -1232,7 +1222,7 @@ static int parse_feature_afu(struct build_feature_devs_info *binfo,
>  		return -EINVAL;
>  	}
>  
> -	switch (feature_dev_id_type(binfo->feature_dev)) {
> +	switch (binfo->type) {
>  	case PORT_ID:
>  		return parse_feature_port_afu(binfo, ofst);
>  	default:
> @@ -1278,6 +1268,7 @@ static void build_info_complete(struct build_feature_devs_info *binfo)
>  static int parse_feature_fiu(struct build_feature_devs_info *binfo,
>  			     resource_size_t ofst)
>  {
> +	enum dfl_id_type type;
>  	int ret = 0;
>  	u32 offset;
>  	u16 id;
> @@ -1299,8 +1290,14 @@ static int parse_feature_fiu(struct build_feature_devs_info *binfo,
>  	v = readq(binfo->ioaddr + DFH);
>  	id = FIELD_GET(DFH_ID, v);
>  
> +	type = dfh_id_to_type(id);
> +	if (type >= DFL_ID_MAX)
> +		return -EINVAL;
> +
> +	binfo->type = type;
> +
>  	/* create platform device for dfl feature dev */
> -	ret = build_info_create_dev(binfo, dfh_id_to_type(id));
> +	ret = build_info_create_dev(binfo);

.. like here, binfo->type is valid but binfo->feature_dev may not.

Thanks,
Yilun

