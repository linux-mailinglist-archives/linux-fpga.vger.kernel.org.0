Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDC1D22915A
	for <lists+linux-fpga@lfdr.de>; Wed, 22 Jul 2020 08:54:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728063AbgGVGyU (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 22 Jul 2020 02:54:20 -0400
Received: from mga14.intel.com ([192.55.52.115]:46954 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728049AbgGVGyT (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 22 Jul 2020 02:54:19 -0400
IronPort-SDR: I8YTVBs9Xk9bvIIoNAp0XOrQ25BmbSnY74JLGaR4ov+CUzEvOSOEKJCvr5Z9O82CCDPIC/2oEL
 GO8CUEnwGaKQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9689"; a="149446598"
X-IronPort-AV: E=Sophos;i="5.75,381,1589266800"; 
   d="scan'208";a="149446598"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2020 23:54:18 -0700
IronPort-SDR: xGGOMz3HOd6VHBenhxMVsFU7TUuTprOtPprL9IMDIiNyLAVBjVtbm2S8E01zfnKRbSd+39WTCu
 z7DYNEw5b9iQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,381,1589266800"; 
   d="scan'208";a="288185871"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.141])
  by orsmga006.jf.intel.com with ESMTP; 21 Jul 2020 23:54:16 -0700
Date:   Wed, 22 Jul 2020 14:51:07 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Tom Rix <trix@redhat.com>
Cc:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, lgoncalv@redhat.com,
        Wu Hao <hao.wu@intel.com>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        Russ Weight <russell.h.weight@intel.com>
Subject: Re: [PATCH 1/2] fpga: dfl: map feature mmio resources in their own
  feature drivers
Message-ID: <20200722065107.GA7791@yilunxu-OptiPlex-7050>
References: <1594791498-14495-1-git-send-email-yilun.xu@intel.com>
 <1594791498-14495-2-git-send-email-yilun.xu@intel.com>
 <9cec52cb-13aa-8b99-ef75-22eefa9f1710@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9cec52cb-13aa-8b99-ef75-22eefa9f1710@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Sorry, I missed some comments. Reply inline.

> > +	/* release I/O mappings for next step enumeration */
> > +	cci_pci_iounmap_bars(pcidev, mapped_bars);
> There is no iounmap_bars in error handling, likely need to add this.

The memory allocated by pcim_iomap_xxx will be released along with
pcidev destory.

> > +
> >  	/* start enumeration with prepared enumeration information */
> >  	cdev = dfl_fpga_feature_devs_enumerate(info);
> >  	if (IS_ERR(cdev)) {
> > diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
> > index 649958a..7dc6411 100644
> > --- a/drivers/fpga/dfl.c
> > +++ b/drivers/fpga/dfl.c
> > @@ -250,6 +250,11 @@ int dfl_fpga_check_port_id(struct platform_device *pdev, void *pport_id)
> >  }
> >  EXPORT_SYMBOL_GPL(dfl_fpga_check_port_id);
> >  
> > +static bool is_header_feature(struct dfl_feature *feature)
> > +{
> > +	return feature->id == FEATURE_ID_FIU_HEADER;
> Could this be a macro ?

Yes

> > +}
> > +
> >  /**
> >   * dfl_fpga_dev_feature_uinit - uinit for sub features of dfl feature device
> >   * @pdev: feature device.
> > @@ -273,8 +278,20 @@ static int dfl_feature_instance_init(struct platform_device *pdev,
> >  				     struct dfl_feature *feature,
> >  				     struct dfl_feature_driver *drv)
> >  {
> > +	void __iomem *base;
> >  	int ret = 0;
> >  
> > +	if (!is_header_feature(feature)) {
> > +		base = devm_platform_ioremap_resource(pdev,
> > +						      feature->resource_index);
> > +		if (IS_ERR(base)) {
> > +			dev_err(&pdev->dev, "fail to get iomem resource!\n");
> > +			return PTR_ERR(base);
> > +		}
> > +
> > +		feature->ioaddr = base;
> > +	}
> > +
> >  	if (drv->ops->init) {
> >  		ret = drv->ops->init(pdev, feature);
> >  		if (ret)
> > @@ -427,7 +444,9 @@ EXPORT_SYMBOL_GPL(dfl_fpga_dev_ops_unregister);
> >   * @irq_table: Linux IRQ numbers for all irqs, indexed by local irq index of
> >   *	       this device.
> >   * @feature_dev: current feature device.
> > - * @ioaddr: header register region address of feature device in enumeration.
> > + * @ioaddr: header register region address of current FIU in enumeration.
> > + * @start: register resource start of current FIU.
> > + * @len: max register resource length of current FIU.
> >   * @sub_features: a sub features linked list for feature device in enumeration.
> >   * @feature_num: number of sub features for feature device in enumeration.
> >   */
> > @@ -439,6 +458,9 @@ struct build_feature_devs_info {
> >  
> >  	struct platform_device *feature_dev;
> >  	void __iomem *ioaddr;
> > +	resource_size_t start;
> > +	resource_size_t len;
> > +
> extra whitespace, remove

Yes

> >  	struct list_head sub_features;
> >  	int feature_num;
> >  };
> > @@ -484,10 +506,7 @@ static int build_info_commit_dev(struct build_feature_devs_info *binfo)
> >  	struct dfl_feature_platform_data *pdata;
> >  	struct dfl_feature_info *finfo, *p;
> >  	enum dfl_id_type type;
> > -	int ret, index = 0;
> > -
> > -	if (!fdev)
> > -		return 0;
> > +	int ret, index = 0, res_idx = 0;
> >  
> >  	type = feature_dev_id_type(fdev);
> >  	if (WARN_ON_ONCE(type >= DFL_ID_MAX))
> > @@ -530,16 +549,30 @@ static int build_info_commit_dev(struct build_feature_devs_info *binfo)
> >  
> >  	/* fill features and resource information for feature dev */
> >  	list_for_each_entry_safe(finfo, p, &binfo->sub_features, node) {
> > -		struct dfl_feature *feature = &pdata->features[index];
> > +		struct dfl_feature *feature = &pdata->features[index++];
> >  		struct dfl_feature_irq_ctx *ctx;
> >  		unsigned int i;
> >  
> >  		/* save resource information for each feature */
> >  		feature->dev = fdev;
> >  		feature->id = finfo->fid;
> > -		feature->resource_index = index;
> > -		feature->ioaddr = finfo->ioaddr;
> > -		fdev->resource[index++] = finfo->mmio_res;
> > +
> > +		/*
> > +		 * map header resource for dfl bus device. Don't add header
> > +		 * resource to feature devices, or the resource tree will be
> > +		 * disordered and cause warning on resource release
> > +		 */
> > +		if (is_header_feature(feature)) {
> > +			feature->resource_index = -1;
> > +			feature->ioaddr =
> > +				devm_ioremap_resource(binfo->dev,
> > +						      &finfo->mmio_res);
> > +			if (IS_ERR(feature->ioaddr))
> > +				return PTR_ERR(feature->ioaddr);
> feature->ioaddr is garbage, is this ok ?

It should be OK. We will not touch this field during cleaning up.

> > +static bool is_feature_dev_detected(struct build_feature_devs_info *binfo)
> > +{
> > +	return !!binfo->feature_dev;
> Another macro.

Yes

> > +}
> > +
> > +static void dfl_binfo_shift(struct build_feature_devs_info *binfo,
> > +			    resource_size_t ofst)
> shift? where is shifting happening.  A better name would be dfl_binfo_update or dfl_binfo_increment

I'll delete this function, it is not useful.

Thanks,
Yilun
