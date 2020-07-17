Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F25B12240D5
	for <lists+linux-fpga@lfdr.de>; Fri, 17 Jul 2020 18:54:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbgGQQyk (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 17 Jul 2020 12:54:40 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:45384 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726221AbgGQQyj (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 17 Jul 2020 12:54:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595004873;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EDGHOVH9hRpqpgBeVlpolKSQiGlIX3DAEfNPwy8l+ds=;
        b=b7NUVfA13Kj9Y8NQQwarLhwtieEaAhdpBUjKxZeOYmSG8hJaujvCt6NqvEhedI2jm3dITL
        lPzuHCnRqjArQq4QGDTLhA1/WkRNLVz+lMZC7OxkXQg3o/mHJZUgMKuTur9URR9yJ1Z+oA
        C2QCCdqdK2QEIuuHyu+EdG/6IoWE33o=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-148-SkWjrsmsNXKDBvHF5-7d0Q-1; Fri, 17 Jul 2020 12:52:16 -0400
X-MC-Unique: SkWjrsmsNXKDBvHF5-7d0Q-1
Received: by mail-pl1-f200.google.com with SMTP id a8so6906943plm.7
        for <linux-fpga@vger.kernel.org>; Fri, 17 Jul 2020 09:51:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=EDGHOVH9hRpqpgBeVlpolKSQiGlIX3DAEfNPwy8l+ds=;
        b=VhYaT6tzUeP8B+DO9VBEnhPR1vriK9PshO7h87dI1T2/D5RjvjYlSqEarMYGzCfKMK
         N5pAo9utfje7iSU/YxQ9TOYSR52Wcks5hdO+n1/+UkQyrNd+ONat1spA5QnyV3PrqJ+W
         Uk7NURsM/hxaAiisRdTmthFgrWIGTzZMqisFStC/S/7+PAuP4Q7Itb2TjmGg6WJNtrQN
         oNsY8gUUsMVaWUbr/2qNXP2bad8noPuiuZvmC45zrt1krrEdqXvRV8XFwVoRZwK0fjh8
         N6dukEfgkTkV1rYaVQEiRaQ+iw1SqNCXPnaJi6aN4vVJHp6vCLORU3pzy9UQfbaErD12
         C2EQ==
X-Gm-Message-State: AOAM530+cEaYXn3J7zNe2Ot6QwcMWuN6VrnX7/zhV3RM1ml0bWSLR2n6
        +LgWGem5W0vsiMtOy/FmsdpoVJJ9HO0AleamwMjC46tJkECnnqdR3jnp0zccwu2WuuKU7d3K9gX
        dNLzE/6sSfnvhjo3cpDkCIw==
X-Received: by 2002:a17:90b:1296:: with SMTP id fw22mr10925561pjb.20.1595004696646;
        Fri, 17 Jul 2020 09:51:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzggbymc/rhfGBkznmJntRTp9uu1f1aZuvgHX56kcKp9bftbDZsCKbgqC7BZcboNjtyBGb8jw==
X-Received: by 2002:a17:90b:1296:: with SMTP id fw22mr10925529pjb.20.1595004696143;
        Fri, 17 Jul 2020 09:51:36 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id q5sm8367296pfc.130.2020.07.17.09.51.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jul 2020 09:51:35 -0700 (PDT)
Subject: Re: [PATCH 1/2] fpga: dfl: map feature mmio resources in their own
 feature drivers
To:     Xu Yilun <yilun.xu@intel.com>, mdf@kernel.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     lgoncalv@redhat.com, Wu Hao <hao.wu@intel.com>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        Russ Weight <russell.h.weight@intel.com>
References: <1594791498-14495-1-git-send-email-yilun.xu@intel.com>
 <1594791498-14495-2-git-send-email-yilun.xu@intel.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <9cec52cb-13aa-8b99-ef75-22eefa9f1710@redhat.com>
Date:   Fri, 17 Jul 2020 09:51:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <1594791498-14495-2-git-send-email-yilun.xu@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Mostly little stuff.

Consider refactoring create_feature_instance.

Tom

> diff --git a/drivers/fpga/dfl-pci.c b/drivers/fpga/dfl-pci.c
> index e220bec..22dc025 100644
> --- a/drivers/fpga/dfl-pci.c
> +++ b/drivers/fpga/dfl-pci.c
> @@ -39,6 +39,11 @@ static void __iomem *cci_pci_ioremap_bar(struct pci_dev *pcidev, int bar)
>  	return pcim_iomap_table(pcidev)[bar];
>  }
>  
> +static void cci_pci_iounmap_bars(struct pci_dev *pcidev, int mapped_bars)
> +{
> +	pcim_iounmap_regions(pcidev, mapped_bars);
> +}

A singleton, called only one place. Consider replacing with a direct call.


> +
>  static int cci_pci_alloc_irq(struct pci_dev *pcidev)
>  {
>  	int ret, nvec = pci_msix_vec_count(pcidev);
> @@ -123,7 +128,7 @@ static int *cci_pci_create_irq_table(struct pci_dev *pcidev, unsigned int nvec)
>  static int cci_enumerate_feature_devs(struct pci_dev *pcidev)
>  {
>  	struct cci_drvdata *drvdata = pci_get_drvdata(pcidev);
> -	int port_num, bar, i, nvec, ret = 0;
> +	int port_num, bar, i, nvec, mapped_bars, ret = 0;

Shouldn't mapped_bars be at least unsigned and maybe either uint32_t or uint64_t ?

I see pcim_ioumap_regions has int as parameter. boo

>  	struct dfl_fpga_enum_info *info;
>  	struct dfl_fpga_cdev *cdev;
>  	resource_size_t start, len;
> @@ -163,6 +168,8 @@ static int cci_enumerate_feature_devs(struct pci_dev *pcidev)
>  		goto irq_free_exit;
>  	}
>  
> +	mapped_bars = BIT(0);
> +
>  	/*
>  	 * PF device has FME and Ports/AFUs, and VF device only has one
>  	 * Port/AFU. Check them and add related "Device Feature List" info
> @@ -172,7 +179,7 @@ static int cci_enumerate_feature_devs(struct pci_dev *pcidev)
>  		start = pci_resource_start(pcidev, 0);
>  		len = pci_resource_len(pcidev, 0);
>  
> -		dfl_fpga_enum_info_add_dfl(info, start, len, base);
> +		dfl_fpga_enum_info_add_dfl(info, start, len);
>  
>  		/*
>  		 * find more Device Feature Lists (e.g. Ports) per information
> @@ -200,22 +207,26 @@ static int cci_enumerate_feature_devs(struct pci_dev *pcidev)
>  			if (!base)
>  				continue;
>  
> +			mapped_bars |= BIT(bar);
> +
>  			start = pci_resource_start(pcidev, bar) + offset;
>  			len = pci_resource_len(pcidev, bar) - offset;
>  
> -			dfl_fpga_enum_info_add_dfl(info, start, len,
> -						   base + offset);
> +			dfl_fpga_enum_info_add_dfl(info, start, len);
>  		}
>  	} else if (dfl_feature_is_port(base)) {
>  		start = pci_resource_start(pcidev, 0);
>  		len = pci_resource_len(pcidev, 0);
>  
> -		dfl_fpga_enum_info_add_dfl(info, start, len, base);
> +		dfl_fpga_enum_info_add_dfl(info, start, len);
>  	} else {
>  		ret = -ENODEV;
>  		goto irq_free_exit;
>  	}
>  
> +	/* release I/O mappings for next step enumeration */
> +	cci_pci_iounmap_bars(pcidev, mapped_bars);
There is no iounmap_bars in error handling, likely need to add this.
> +
>  	/* start enumeration with prepared enumeration information */
>  	cdev = dfl_fpga_feature_devs_enumerate(info);
>  	if (IS_ERR(cdev)) {
> diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
> index 649958a..7dc6411 100644
> --- a/drivers/fpga/dfl.c
> +++ b/drivers/fpga/dfl.c
> @@ -250,6 +250,11 @@ int dfl_fpga_check_port_id(struct platform_device *pdev, void *pport_id)
>  }
>  EXPORT_SYMBOL_GPL(dfl_fpga_check_port_id);
>  
> +static bool is_header_feature(struct dfl_feature *feature)
> +{
> +	return feature->id == FEATURE_ID_FIU_HEADER;
Could this be a macro ?
> +}
> +
>  /**
>   * dfl_fpga_dev_feature_uinit - uinit for sub features of dfl feature device
>   * @pdev: feature device.
> @@ -273,8 +278,20 @@ static int dfl_feature_instance_init(struct platform_device *pdev,
>  				     struct dfl_feature *feature,
>  				     struct dfl_feature_driver *drv)
>  {
> +	void __iomem *base;
>  	int ret = 0;
>  
> +	if (!is_header_feature(feature)) {
> +		base = devm_platform_ioremap_resource(pdev,
> +						      feature->resource_index);
> +		if (IS_ERR(base)) {
> +			dev_err(&pdev->dev, "fail to get iomem resource!\n");
> +			return PTR_ERR(base);
> +		}
> +
> +		feature->ioaddr = base;
> +	}
> +
>  	if (drv->ops->init) {
>  		ret = drv->ops->init(pdev, feature);
>  		if (ret)
> @@ -427,7 +444,9 @@ EXPORT_SYMBOL_GPL(dfl_fpga_dev_ops_unregister);
>   * @irq_table: Linux IRQ numbers for all irqs, indexed by local irq index of
>   *	       this device.
>   * @feature_dev: current feature device.
> - * @ioaddr: header register region address of feature device in enumeration.
> + * @ioaddr: header register region address of current FIU in enumeration.
> + * @start: register resource start of current FIU.
> + * @len: max register resource length of current FIU.
>   * @sub_features: a sub features linked list for feature device in enumeration.
>   * @feature_num: number of sub features for feature device in enumeration.
>   */
> @@ -439,6 +458,9 @@ struct build_feature_devs_info {
>  
>  	struct platform_device *feature_dev;
>  	void __iomem *ioaddr;
> +	resource_size_t start;
> +	resource_size_t len;
> +
extra whitespace, remove
>  	struct list_head sub_features;
>  	int feature_num;
>  };
> @@ -484,10 +506,7 @@ static int build_info_commit_dev(struct build_feature_devs_info *binfo)
>  	struct dfl_feature_platform_data *pdata;
>  	struct dfl_feature_info *finfo, *p;
>  	enum dfl_id_type type;
> -	int ret, index = 0;
> -
> -	if (!fdev)
> -		return 0;
> +	int ret, index = 0, res_idx = 0;
>  
>  	type = feature_dev_id_type(fdev);
>  	if (WARN_ON_ONCE(type >= DFL_ID_MAX))
> @@ -530,16 +549,30 @@ static int build_info_commit_dev(struct build_feature_devs_info *binfo)
>  
>  	/* fill features and resource information for feature dev */
>  	list_for_each_entry_safe(finfo, p, &binfo->sub_features, node) {
> -		struct dfl_feature *feature = &pdata->features[index];
> +		struct dfl_feature *feature = &pdata->features[index++];
>  		struct dfl_feature_irq_ctx *ctx;
>  		unsigned int i;
>  
>  		/* save resource information for each feature */
>  		feature->dev = fdev;
>  		feature->id = finfo->fid;
> -		feature->resource_index = index;
> -		feature->ioaddr = finfo->ioaddr;
> -		fdev->resource[index++] = finfo->mmio_res;
> +
> +		/*
> +		 * map header resource for dfl bus device. Don't add header
> +		 * resource to feature devices, or the resource tree will be
> +		 * disordered and cause warning on resource release
> +		 */
> +		if (is_header_feature(feature)) {
> +			feature->resource_index = -1;
> +			feature->ioaddr =
> +				devm_ioremap_resource(binfo->dev,
> +						      &finfo->mmio_res);
> +			if (IS_ERR(feature->ioaddr))
> +				return PTR_ERR(feature->ioaddr);
feature->ioaddr is garbage, is this ok ?
> +		} else {
> +			feature->resource_index = res_idx;
> +			fdev->resource[res_idx++] = finfo->mmio_res;
> +		}
>  
>  		if (finfo->nr_irqs) {
>  			ctx = devm_kcalloc(binfo->dev, finfo->nr_irqs,
> @@ -582,19 +615,13 @@ static int build_info_commit_dev(struct build_feature_devs_info *binfo)
>  
>  static int
>  build_info_create_dev(struct build_feature_devs_info *binfo,
> -		      enum dfl_id_type type, void __iomem *ioaddr)
> +		      enum dfl_id_type type)
>  {
>  	struct platform_device *fdev;
> -	int ret;
>  
>  	if (type >= DFL_ID_MAX)
>  		return -EINVAL;
>  
> -	/* we will create a new device, commit current device first */
> -	ret = build_info_commit_dev(binfo);
> -	if (ret)
> -		return ret;
> -
>  	/*
>  	 * we use -ENODEV as the initialization indicator which indicates
>  	 * whether the id need to be reclaimed
> @@ -605,7 +632,7 @@ build_info_create_dev(struct build_feature_devs_info *binfo,
>  
>  	binfo->feature_dev = fdev;
>  	binfo->feature_num = 0;
> -	binfo->ioaddr = ioaddr;
> +
>  	INIT_LIST_HEAD(&binfo->sub_features);
>  
>  	fdev->id = dfl_id_alloc(type, &fdev->dev);
> @@ -747,18 +774,17 @@ static int parse_feature_irqs(struct build_feature_devs_info *binfo,
>   */
>  static int
>  create_feature_instance(struct build_feature_devs_info *binfo,
> -			struct dfl_fpga_enum_dfl *dfl, resource_size_t ofst,
> -			resource_size_t size, u64 fid)
> +			resource_size_t ofst, resource_size_t size, u64 fid)
>  {
>  	unsigned int irq_base, nr_irqs;
>  	struct dfl_feature_info *finfo;
>  	int ret;
>  
>  	/* read feature size and id if inputs are invalid */
> -	size = size ? size : feature_size(dfl->ioaddr + ofst);
> -	fid = fid ? fid : feature_id(dfl->ioaddr + ofst);
> +	size = size ? size : feature_size(binfo->ioaddr + ofst);
> +	fid = fid ? fid : feature_id(binfo->ioaddr + ofst);

This is complicated. based on fiu,afu or private  calling.  Why not have a function ptr

struct build_feature_devs_info {

void (*find_info) (...)

}

find_info_fiu (..) {

size = feature_size(..)

fid = feature_id(..)

}

>  
> -	if (dfl->len - ofst < size)
> +	if (binfo->len - ofst < size)
>  		return -EINVAL;
>  
>  	ret = parse_feature_irqs(binfo, ofst, fid, &irq_base, &nr_irqs);
> @@ -770,12 +796,11 @@ create_feature_instance(struct build_feature_devs_info *binfo,
>  		return -ENOMEM;
>  
>  	finfo->fid = fid;
> -	finfo->mmio_res.start = dfl->start + ofst;
> +	finfo->mmio_res.start = binfo->start + ofst;
>  	finfo->mmio_res.end = finfo->mmio_res.start + size - 1;
>  	finfo->mmio_res.flags = IORESOURCE_MEM;
>  	finfo->irq_base = irq_base;
>  	finfo->nr_irqs = nr_irqs;
> -	finfo->ioaddr = dfl->ioaddr + ofst;
>  
>  	list_add_tail(&finfo->node, &binfo->sub_features);
>  	binfo->feature_num++;
> @@ -784,7 +809,6 @@ create_feature_instance(struct build_feature_devs_info *binfo,
>  }
>  
>  static int parse_feature_port_afu(struct build_feature_devs_info *binfo,
> -				  struct dfl_fpga_enum_dfl *dfl,
>  				  resource_size_t ofst)
>  {
>  	u64 v = readq(binfo->ioaddr + PORT_HDR_CAP);
> @@ -792,11 +816,10 @@ static int parse_feature_port_afu(struct build_feature_devs_info *binfo,
>  
>  	WARN_ON(!size);
>  
> -	return create_feature_instance(binfo, dfl, ofst, size, FEATURE_ID_AFU);
> +	return create_feature_instance(binfo, ofst, size, FEATURE_ID_AFU);
>  }
>  
>  static int parse_feature_afu(struct build_feature_devs_info *binfo,
> -			     struct dfl_fpga_enum_dfl *dfl,
>  			     resource_size_t ofst)
>  {
>  	if (!binfo->feature_dev) {
> @@ -806,7 +829,7 @@ static int parse_feature_afu(struct build_feature_devs_info *binfo,
>  
>  	switch (feature_dev_id_type(binfo->feature_dev)) {
>  	case PORT_ID:
> -		return parse_feature_port_afu(binfo, dfl, ofst);
> +		return parse_feature_port_afu(binfo, ofst);
>  	default:
>  		dev_info(binfo->dev, "AFU belonging to FIU %s is not supported yet.\n",
>  			 binfo->feature_dev->name);
> @@ -815,35 +838,91 @@ static int parse_feature_afu(struct build_feature_devs_info *binfo,
>  	return 0;
>  }
>  
> +static bool is_feature_dev_detected(struct build_feature_devs_info *binfo)
> +{
> +	return !!binfo->feature_dev;
Another macro.
> +}
> +
> +static void dfl_binfo_shift(struct build_feature_devs_info *binfo,
> +			    resource_size_t ofst)
shift? where is shifting happening.  A better name would be dfl_binfo_update or dfl_binfo_increment
> +{
> +	binfo->start = binfo->start + ofst;
> +	binfo->len = binfo->len - ofst;
> +}
> +
> +static int dfl_binfo_prepare(struct build_feature_devs_info *binfo,
> +			     resource_size_t start, resource_size_t len)
> +{
> +	struct device *dev = binfo->dev;
> +	void __iomem *ioaddr;
> +
> +	if (!devm_request_mem_region(dev, start, len, dev_name(dev))) {
> +		dev_err(dev, "request region fail, start:%pa, len:%pa\n",
> +			&start, &len);
> +		return -ENOMEM;
> +	}
> +
> +	ioaddr = devm_ioremap(dev, start, len);
> +	if (!ioaddr) {
> +		dev_err(dev, "ioremap region fail, start:%pa, len:%pa\n",
> +			&start, &len);
> +		devm_release_mem_region(dev, start, len);
> +		return -EFAULT;
> +	}
> +
> +	binfo->start = start;
> +	binfo->len = len;
> +	binfo->ioaddr = ioaddr;
> +
> +	return 0;
> +}
> +
> +static void dfl_binfo_finish(struct build_feature_devs_info *binfo)
> +{
> +	devm_iounmap(binfo->dev, binfo->ioaddr);
> +	devm_release_mem_region(binfo->dev, binfo->start, binfo->len);
> +}
> +
>  static int parse_feature_fiu(struct build_feature_devs_info *binfo,
> -			     struct dfl_fpga_enum_dfl *dfl,
>  			     resource_size_t ofst)
>  {
>  	u32 id, offset;
>  	u64 v;
>  	int ret = 0;
>  
> -	v = readq(dfl->ioaddr + ofst + DFH);
> +	if (is_feature_dev_detected(binfo)) {
> +		dfl_binfo_finish(binfo);
> +
> +		ret = build_info_commit_dev(binfo);
> +		if (ret)
> +			return ret;
> +
> +		dfl_binfo_prepare(binfo, binfo->start + ofst,
> +				  binfo->len - ofst);
Check status of dfl_binfo_prepare
> +	} else {
> +		dfl_binfo_shift(binfo, ofst);
> +	}
> +
> +	v = readq(binfo->ioaddr + DFH);
>  	id = FIELD_GET(DFH_ID, v);
>  
>  	/* create platform device for dfl feature dev */
> -	ret = build_info_create_dev(binfo, dfh_id_to_type(id),
> -				    dfl->ioaddr + ofst);
> +	ret = build_info_create_dev(binfo, dfh_id_to_type(id));
>  	if (ret)
>  		return ret;
>  
> -	ret = create_feature_instance(binfo, dfl, ofst, 0, 0);
> +	ret = create_feature_instance(binfo, 0, 0, 0);
>  	if (ret)
>  		return ret;
>  	/*
>  	 * find and parse FIU's child AFU via its NEXT_AFU register.
>  	 * please note that only Port has valid NEXT_AFU pointer per spec.
>  	 */
> -	v = readq(dfl->ioaddr + ofst + NEXT_AFU);
> +	v = readq(binfo->ioaddr + NEXT_AFU);
>  
>  	offset = FIELD_GET(NEXT_AFU_NEXT_DFH_OFST, v);
>  	if (offset)
> -		return parse_feature_afu(binfo, dfl, ofst + offset);
> +		return parse_feature_afu(binfo, offset);
>  
>  	dev_dbg(binfo->dev, "No AFUs detected on FIU %d\n", id);
>  
> @@ -851,16 +930,15 @@ static int parse_feature_fiu(struct build_feature_devs_info *binfo,
>  }
>  
>  static int parse_feature_private(struct build_feature_devs_info *binfo,
> -				 struct dfl_fpga_enum_dfl *dfl,
>  				 resource_size_t ofst)
>  {
>  	if (!binfo->feature_dev) {
>  		dev_err(binfo->dev, "the private feature %llx does not belong to any AFU.\n",
> -			(unsigned long long)feature_id(dfl->ioaddr + ofst));
> +			(unsigned long long)feature_id(binfo->ioaddr + ofst));
>  		return -EINVAL;
>  	}
>  
> -	return create_feature_instance(binfo, dfl, ofst, 0, 0);
> +	return create_feature_instance(binfo, ofst, 0, 0);
>  }
>  
>  /**
> @@ -868,24 +946,24 @@ static int parse_feature_private(struct build_feature_devs_info *binfo,
>   *
>   * @binfo: build feature devices information.
>   * @dfl: device feature list to parse
> - * @ofst: offset to feature header on this device feature list
> + * @ofst: offset to current FIU header
>   */
>  static int parse_feature(struct build_feature_devs_info *binfo,
> -			 struct dfl_fpga_enum_dfl *dfl, resource_size_t ofst)
> +			 resource_size_t ofst)
>  {
>  	u64 v;
>  	u32 type;
>  
> -	v = readq(dfl->ioaddr + ofst + DFH);
> +	v = readq(binfo->ioaddr + ofst + DFH);
>  	type = FIELD_GET(DFH_TYPE, v);
>  
>  	switch (type) {
>  	case DFH_TYPE_AFU:
> -		return parse_feature_afu(binfo, dfl, ofst);
> +		return parse_feature_afu(binfo, ofst);
>  	case DFH_TYPE_PRIVATE:
> -		return parse_feature_private(binfo, dfl, ofst);
> +		return parse_feature_private(binfo, ofst);
>  	case DFH_TYPE_FIU:
> -		return parse_feature_fiu(binfo, dfl, ofst);
> +		return parse_feature_fiu(binfo, ofst);
>  	default:
>  		dev_info(binfo->dev,
>  			 "Feature Type %x is not supported.\n", type);
> @@ -897,12 +975,18 @@ static int parse_feature(struct build_feature_devs_info *binfo,
>  static int parse_feature_list(struct build_feature_devs_info *binfo,
>  			      struct dfl_fpga_enum_dfl *dfl)
>  {
> -	void __iomem *start = dfl->ioaddr;
> -	void __iomem *end = dfl->ioaddr + dfl->len;
> +	resource_size_t start, end;
>  	int ret = 0;
>  	u32 ofst = 0;
>  	u64 v;
>  
> +	ret = dfl_binfo_prepare(binfo, dfl->start, dfl->len);
> +	if (ret)
> +		return ret;
> +
> +	start = dfl->start;
> +	end = start + dfl->len;
> +
>  	/* walk through the device feature list via DFH's next DFH pointer. */
>  	for (; start < end; start += ofst) {
>  		if (end - start < DFH_SIZE) {
> @@ -910,11 +994,11 @@ static int parse_feature_list(struct build_feature_devs_info *binfo,
>  			return -EINVAL;
>  		}
>  
> -		ret = parse_feature(binfo, dfl, start - dfl->ioaddr);
> +		ret = parse_feature(binfo, start - binfo->start);
>  		if (ret)
>  			return ret;
>  
> -		v = readq(start + DFH);
> +		v = readq(binfo->ioaddr + start - binfo->start + DFH);
>  		ofst = FIELD_GET(DFH_NEXT_HDR_OFST, v);
>  
>  		/* stop parsing if EOL(End of List) is set or offset is 0 */
> @@ -923,6 +1007,8 @@ static int parse_feature_list(struct build_feature_devs_info *binfo,
>  	}
>  
>  	/* commit current feature device when reach the end of list */
> +	dfl_binfo_finish(binfo);
> +
>  	return build_info_commit_dev(binfo);
>  }
>  
> @@ -976,7 +1062,6 @@ EXPORT_SYMBOL_GPL(dfl_fpga_enum_info_free);
>   * @info: ptr to dfl_fpga_enum_info
>   * @start: mmio resource address of the device feature list.
>   * @len: mmio resource length of the device feature list.
> - * @ioaddr: mapped mmio resource address of the device feature list.
>   *
>   * One FPGA device may have one or more Device Feature Lists (DFLs), use this
>   * function to add information of each DFL to common data structure for next
> @@ -985,8 +1070,7 @@ EXPORT_SYMBOL_GPL(dfl_fpga_enum_info_free);
>   * Return: 0 on success, negative error code otherwise.
>   */
>  int dfl_fpga_enum_info_add_dfl(struct dfl_fpga_enum_info *info,
> -			       resource_size_t start, resource_size_t len,
> -			       void __iomem *ioaddr)
> +			       resource_size_t start, resource_size_t len)
>  {
>  	struct dfl_fpga_enum_dfl *dfl;
>  
> @@ -996,7 +1080,6 @@ int dfl_fpga_enum_info_add_dfl(struct dfl_fpga_enum_info *info,
>  
>  	dfl->start = start;
>  	dfl->len = len;
> -	dfl->ioaddr = ioaddr;
>  
>  	list_add_tail(&dfl->node, &info->dfls);
>  
> diff --git a/drivers/fpga/dfl.h b/drivers/fpga/dfl.h
> index a32dfba..f605c28 100644
> --- a/drivers/fpga/dfl.h
> +++ b/drivers/fpga/dfl.h
> @@ -441,22 +441,18 @@ struct dfl_fpga_enum_info {
>   *
>   * @start: base address of this device feature list.
>   * @len: size of this device feature list.
> - * @ioaddr: mapped base address of this device feature list.
>   * @node: node in list of device feature lists.
>   */
>  struct dfl_fpga_enum_dfl {
>  	resource_size_t start;
>  	resource_size_t len;
extra white space
>  
> -	void __iomem *ioaddr;
> -
>  	struct list_head node;
>  };
>  
>  struct dfl_fpga_enum_info *dfl_fpga_enum_info_alloc(struct device *dev);
>  int dfl_fpga_enum_info_add_dfl(struct dfl_fpga_enum_info *info,
> -			       resource_size_t start, resource_size_t len,
> -			       void __iomem *ioaddr);
> +			       resource_size_t start, resource_size_t len);
>  int dfl_fpga_enum_info_add_irq(struct dfl_fpga_enum_info *info,
>  			       unsigned int nr_irqs, int *irq_table);
>  void dfl_fpga_enum_info_free(struct dfl_fpga_enum_info *info);

