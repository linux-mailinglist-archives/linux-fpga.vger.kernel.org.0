Return-Path: <linux-fpga+bounces-712-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D040B97B948
	for <lists+linux-fpga@lfdr.de>; Wed, 18 Sep 2024 10:23:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3502EB231B1
	for <lists+linux-fpga@lfdr.de>; Wed, 18 Sep 2024 08:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FFBD175D32;
	Wed, 18 Sep 2024 08:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="THUK2y5w"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B46132105;
	Wed, 18 Sep 2024 08:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726647773; cv=none; b=s8+LuRS0/DFqUYtLOMG+QzNWPC6kZAmzxrK0GoXp8B5lCGAax1igiE312S05sKKyeW+JceBakjPcGEaHtWUMmq4GUQ3lhnlqL1pMlpOdBOjMOG8WczhKUEGwWkYCtgLywkPuW+lz9i+J7gFLjlJYdijtPZiMEXA5mtNKs35riq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726647773; c=relaxed/simple;
	bh=LojxUU3x/uZccgFR5R3AeUdTvX07sQhrz1DVu2meqJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eAFiiNjIPmkrCcQQi0D2oZh64gATX1sd28fu6Di/oKS+S61UAj8UClegHfZjfYUls3Rhh6TTCP0qjS6P1L53WMTrLDW5bbS+nCVNLbbzB+sC1lk/RWJHq1/WjUGgMZwZjARhiOtLsCRZsNKn2Aruh7CQrcOJQ3ZAxWEzbrUbkWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=THUK2y5w; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726647771; x=1758183771;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LojxUU3x/uZccgFR5R3AeUdTvX07sQhrz1DVu2meqJ0=;
  b=THUK2y5wKyEgI5MRXwn2e3nOhtuugkwuW5IIDA/ddcqZcQ16l9FM5Wfi
   5xQ8X+k5tBW/3gpIFBRjfROjoi9/GYO0gObuQe3wF6bL/rXvYW7btJyNI
   jpJiBVNQlw9DLKZQj0Ac9bDX3B/FIHrDecdPtB8w/hcX8ptMf0lkLPXGp
   40rW/P+QL543e7G+WualTnAyHwSA7vouXhDc7dGPCGz/Jsh7qo8ADB8Ve
   +mtF1cZ4ZYPuYLiVNt5PAlBL9RGU1Lwgh2IzE6q6OrWQ3haceAq/408xF
   R1jmQQc1opXplzafz5orr95oAGL+LRAtmYlk2l9mTI5vPHacuoaB5KxHs
   w==;
X-CSE-ConnectionGUID: tdnGr8piTn6EbNag3Pt3LA==
X-CSE-MsgGUID: NYohTC/2TLqdvcTcMRS3dg==
X-IronPort-AV: E=McAfee;i="6700,10204,11198"; a="25363808"
X-IronPort-AV: E=Sophos;i="6.10,238,1719903600"; 
   d="scan'208";a="25363808"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2024 01:22:50 -0700
X-CSE-ConnectionGUID: 0ow3PrdfRbuhqk6+bYw64g==
X-CSE-MsgGUID: jKoubgzwTsCXxY6F61BcGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,238,1719903600"; 
   d="scan'208";a="69463985"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa009.fm.intel.com with ESMTP; 18 Sep 2024 01:22:47 -0700
Date: Wed, 18 Sep 2024 16:19:59 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: "Manne, Nava kishore" <nava.kishore.manne@amd.com>
Cc: "git (AMD-Xilinx)" <git@amd.com>, "mdf@kernel.org" <mdf@kernel.org>,
	"hao.wu@intel.com" <hao.wu@intel.com>,
	"yilun.xu@intel.com" <yilun.xu@intel.com>,
	"trix@redhat.com" <trix@redhat.com>,
	"robh@kernel.org" <robh@kernel.org>,
	"saravanak@google.com" <saravanak@google.com>,
	"linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [RFC 1/1] of-fpga-region: Add sysfs interface support for FPGA
 configuration
Message-ID: <ZuqNL41bgpPZ9QQ7@yilunxu-OptiPlex-7050>
References: <20240726063819.2274324-1-nava.kishore.manne@amd.com>
 <20240726063819.2274324-2-nava.kishore.manne@amd.com>
 <Zqe7yoAMIJ+Qv8YC@yilunxu-OptiPlex-7050>
 <DS7PR12MB6070C9991ED88DFFADA7EC3CCDB22@DS7PR12MB6070.namprd12.prod.outlook.com>
 <ZrEX9HlAOlUtgnTj@yilunxu-OptiPlex-7050>
 <DS7PR12MB60702067EE3B40A4256F90D3CD612@DS7PR12MB6070.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DS7PR12MB60702067EE3B40A4256F90D3CD612@DS7PR12MB6070.namprd12.prod.outlook.com>

On Tue, Sep 17, 2024 at 11:16:08AM +0000, Manne, Nava kishore wrote:
> > -----Original Message-----
> > From: Xu Yilun <yilun.xu@linux.intel.com>
> > Sent: Monday, August 5, 2024 11:51 PM
> > To: Manne, Nava kishore <nava.kishore.manne@amd.com>
> > Cc: git (AMD-Xilinx) <git@amd.com>; mdf@kernel.org; hao.wu@intel.com;
> > yilun.xu@intel.com; trix@redhat.com; robh@kernel.org; saravanak@google.com;
> > linux-fpga@vger.kernel.org; linux-kernel@vger.kernel.org;
> > devicetree@vger.kernel.org
> > Subject: Re: [RFC 1/1] of-fpga-region: Add sysfs interface support for FPGA
> > configuration
> > 
> > On Thu, Aug 01, 2024 at 04:25:42AM +0000, Manne, Nava kishore wrote:
> > > Hi Yilun,
> > >
> > > > -----Original Message-----
> > > > From: Xu Yilun <yilun.xu@linux.intel.com>
> > > > Sent: Monday, July 29, 2024 9:27 PM
> > > > To: Manne, Nava kishore <nava.kishore.manne@amd.com>
> > > > Cc: git (AMD-Xilinx) <git@amd.com>; mdf@kernel.org;
> > > > hao.wu@intel.com; yilun.xu@intel.com; trix@redhat.com;
> > > > robh@kernel.org; saravanak@google.com; linux-fpga@vger.kernel.org;
> > > > linux- kernel@vger.kernel.org; devicetree@vger.kernel.org
> > > > Subject: Re: [RFC 1/1] of-fpga-region: Add sysfs interface support
> > > > for FPGA configuration
> > > >
> > > > On Fri, Jul 26, 2024 at 12:08:19PM +0530, Nava kishore Manne wrote:
> > > > > Adds sysfs interface as part of the of-fpga-region. This newly
> > > > > added sysfs interface uses Device Tree Overlay (DTO) files to
> > > > > configure/reprogram an FPGA while an operating system is
> > > > > running.This solution will not change the existing sequence When a
> > > > > DT overlay that targets an FPGA Region is applied.
> > > > > 	- Disable appropriate FPGA bridges.
> > > > > 	- Program the FPGA using the FPGA manager.
> > > > > 	- Enable the FPGA bridges.
> > > > > 	- The Device Tree overlay is accepted into the live tree.
> > > > > 	- Child devices are populated.
> > > > >
> > > > > When the overlay is removed, the child nodes will be removed, and
> > > > > the FPGA Region will disable the bridges.
> > > > >
> > > > > Usage:
> > > > > To configure/reprogram an FPGA region:
> > > > > echo "fpga.dtbo" > /sys/class/fpga_region/<region>/device/load
> > > >
> > > > IIRC, last time we are considering some generic interface for both
> > > > OF & non- OF FPGA region, but this is still OF specific.
> > > >
> > > At AMD, we exclusively use OF for FPGA configuration/reconfiguration, utilizing
> > overlay files as outlined in the fpga-region.txt documentation.
> > > However, some devices, like dfl.c those relying solely on the FPGA region, do not
> > use OF.
> > > For these non-OF devices, should we expect them to follow the fpga-region.txt
> > guidelines for FPGA configuration/reconfiguration?
> > 
> > I assume it is Documentation/devicetree/bindings/fpga/fpga-region.yaml.
> > 
> > No, Non-OF devices don't have to follow the DT binding.
> > 
> > > If so, it may be advantageous to develop a common interface for both OF and
> > non-OF.
> > > If not, it might be more appropriate to establish distinct interfaces to cater to their
> > specific requirements.
> > 
> > I think each vendor may have specific way for device enumeration, but that doesn't
> > mean we need distinct user interfaces. For all FPGA devices, we should avoid the
> > situation that the HW is changed but system SW knows nothing. So the common
> > needs are:
> > 
> >  - Find out and remove all devices within the fpga region before
> >    reprograming.
> >  - Re-enumerate devices in fpga region after reprograming.
> > 
> > I expect the fpga region class could generally enforce a flow for the reprograming
> > interface. And of-fpga-region could specifically implement it using DT overlay.
> > 
> 
> To address the vendor-specific nature(either of or non-of) of device enumeration
> in FPGA regions, As you suggested, we can develop a common programming
> interface that abstracts these vendor-specifc differences. This can be achieved
> by integrating vendor-specific callbacks(ex: of and non-of) for device configuration,
> enumeration and removal to fpga-region. 
> 
> I have outlined the top-level framework changes here:
> 
> diff --git a/drivers/fpga/fpga-region.c b/drivers/fpga/fpga-region.c index b364a929425c..7d4b755dc8e0 100644
> --- a/drivers/fpga/fpga-region.c
> +++ b/drivers/fpga/fpga-region.c
> @@ -213,6 +213,7 @@ fpga_region_register_full(struct device *parent, const struct fpga_region_info *
>  	region->compat_id = info->compat_id;
>  	region->priv = info->priv;
>  	region->get_bridges = info->get_bridges;
> +	region->region_ops = info->region_ops;
>  
>  	mutex_init(&region->mutex);
>  	INIT_LIST_HEAD(&region->bridge_list);
> @@ -257,17 +258,46 @@ EXPORT_SYMBOL_GPL(fpga_region_register_full);
>   */
>  struct fpga_region *
>  fpga_region_register(struct device *parent, struct fpga_manager *mgr,
> +		     struct fpga_region_ops *region_ops,
>  		     int (*get_bridges)(struct fpga_region *))  {
>  	struct fpga_region_info info = { 0 };
>  
>  	info.mgr = mgr;
>  	info.get_bridges = get_bridges;
> +	info.region_ops = region_ops;
>  
>  	return fpga_region_register_full(parent, &info);  }  EXPORT_SYMBOL_GPL(fpga_region_register);
>  
> +static int fpga_region_device_open(struct inode *inode, struct file *file) {
> +	struct miscdevice *miscdev = file->private_data;
> +	struct fpga_region *region = container_of(miscdev, struct fpga_region, 
> +miscdev);
> +
> +	file->private_data = region;
> +
> +	return 0;
> +}
> +
> +static long fpga_region_device_ioctl(struct file *file, unsigned int cmd, unsigned long arg) {
> +	char __user *argp = (char __user *)arg;
> +	struct fpga_region *region =  (struct fpga_region *)(file->private_data);
> +	int err;
> +
> +	switch (cmd) {
> +	case FPGA_REGION_IOCTL_LOAD:
> +		err = region->region_ops->fpga_region_config_enumerate (region, argp);

Not sure "void *args" is a proposal or something yet to be decided.
I think we should try best not to give up parameter type and have a clear API
definition.

> +		break;
> +	case FPGA_REGION_IOCTL_REMOVE:
> +		err = region->region_ops->fpga_region_remove(region, argp);
> +		break;
> +	case FPGA_REGION_IOCTL_STATUS:
> +		err = region->region_ops->fpga_region_status(region, argp);
> +	default:
> +		err = -ENOTTY;
> +}
> +
>  /**
>   * fpga_region_unregister - unregister an FPGA region
>   * @region: FPGA region
> diff --git a/include/linux/fpga/fpga-region.h b/include/linux/fpga/fpga-region.h
> index 9d4d32909340..725fdcbab3d8 100644
> --- a/include/linux/fpga/fpga-region.h
> +++ b/include/linux/fpga/fpga-region.h
> @@ -9,6 +9,20 @@
>  
>  struct fpga_region;
>  
> +/**
> + * struct fpga_region_ops - ops for low level FPGA region ops for 
> +device
> + * enumeration/removal
> + * @region_status: returns the FPGA region status
> + * @region_config_enumeration: Configure and enumerate the FPGA region.

region config could be a common existing operation, fpga_region_program_fpga().
So maybe only enumeration is needed?

> + * @region_remove: Remove all devices within the fpga region
> + * (which are added as part of the enumeration).
> + */
> +struct fpga_region_ops {
> +	int (*region_status)(struct fpga_region *bridge);
> +	int (*region_config_enumeration)(struct fpga_region *region, void *args);
> +	void (*region_remove)(struct fpga_region *region, void *args); };
> +
>  /**
>   * struct fpga_region_info - collection of parameters an FPGA Region
>   * @mgr: fpga region manager
> @@ -26,6 +40,7 @@ struct fpga_region_info {
>  	struct fpga_compat_id *compat_id;
>  	void *priv;
>  	int (*get_bridges)(struct fpga_region *region);
> +	struct fpga_region_ops *region_ops;
>  };
>  
>  /**
> @@ -48,6 +63,7 @@ struct fpga_region {
>  	struct fpga_compat_id *compat_id;
>  	void *priv;
>  	int (*get_bridges)(struct fpga_region *region);
> +	struct fpga_region_ops *region_ops;
>  };
>  
>  #define to_fpga_region(d) container_of(d, struct fpga_region, dev)
> 
> In this approach, we utilized an IOCTL-based user interface, but it doesn't have
> to be confined to IOCTL. We can also use sysfs or configfs, or other appropriate
> options as we finalized on it.
> 
> This call-backs approach works for both OF and non-OF devices. 
> If this aligns with your expectations, I can do the necessary changes

There are still much to discuss, but yes this is a good start.

Thanks,
Yilun

> for one vendor specific interface (of-fpga-region.c) devices and submit
> the RFC patch shortly.
> 
> 
> Regards,
> Navakishore.

