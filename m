Return-Path: <linux-fpga+bounces-976-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B36A9EAB4F
	for <lists+linux-fpga@lfdr.de>; Tue, 10 Dec 2024 10:07:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AD88164A4E
	for <lists+linux-fpga@lfdr.de>; Tue, 10 Dec 2024 09:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E491231C88;
	Tue, 10 Dec 2024 09:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LsMzy5t5"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ACBF1B14FA;
	Tue, 10 Dec 2024 09:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733821622; cv=none; b=QEu8HZH6S28ZbNHF9mp3AKIjdt23dd2OK+jjIolZf15ITPHegkCyZi5wi4MjNlJ1ZDvfLK5WzZb3CRqgGxBLv7uvngXQiGi9MlMIKMs4vX9+oiGRnJXfI2b5qDa1+vPfX0hPzppgA7w1GP2Hb29fLtm70xh6dDa0HEMIqq21vb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733821622; c=relaxed/simple;
	bh=JSgeQGlVtBEPa2HNmBDtKw1WT+11BoxQYBOeQXtMxZw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hsYFnlVJMXiTMtd/GtmyXaCprOsdQcarwU/bs+iw5cRPx1bWvH3yc0p8O7DLA1+mwsOCDiLLeNwurfC58vQHLOzrkqSbNJ3z9LWa01bMvxEX0BE0CgDKR3mYIh36edME70rnmqSesv0VgUKBPRFkZdcxuzhclENYLh9v1MDGRms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LsMzy5t5; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733821620; x=1765357620;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JSgeQGlVtBEPa2HNmBDtKw1WT+11BoxQYBOeQXtMxZw=;
  b=LsMzy5t51IrwKjJ+y1WS5vaDcwRJ9QPBdZhBBkekH7tf05lgm+yrEJdQ
   7kMhGS3OVLVLye947rxj7btXwqKGXQebmz47QUHXrhaZD7jywzVO1/QEI
   1yU8pkyCnmrrlAanEbCrSdCqWuIBPR1CMqQIsosRtLF+FjBaWark1JIOw
   Le8dI7jfdZ6xADZk8uAw4SkOrj/FptBWx9L8cgvX9nWT4fz38kYIjVRpp
   bTKEtCbJOhfew4zxQ4MEPm+fkTSq2/UUQxhCYtJ+AsdWJRlWmB5CTV+Qc
   Hv7HBKnHRuCADP1L5MPniY/eciE4grBjiojGaDq2NRDo4R/gXKe20gCiM
   g==;
X-CSE-ConnectionGUID: MtZAu0ycS3yOOyGsrU0uAA==
X-CSE-MsgGUID: pVhCVtupSYaSOCwxxCOfEg==
X-IronPort-AV: E=McAfee;i="6700,10204,11281"; a="44828131"
X-IronPort-AV: E=Sophos;i="6.12,222,1728975600"; 
   d="scan'208";a="44828131"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2024 01:06:59 -0800
X-CSE-ConnectionGUID: iRCEOdfURB+z/6siuqimIg==
X-CSE-MsgGUID: C0UPB8POSF2NwL8g/gInWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,222,1728975600"; 
   d="scan'208";a="95683861"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa010.fm.intel.com with ESMTP; 10 Dec 2024 01:06:57 -0800
Date: Tue, 10 Dec 2024 17:03:41 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: "Manne, Nava kishore" <nava.kishore.manne@amd.com>
Cc: "git (AMD-Xilinx)" <git@amd.com>, "mdf@kernel.org" <mdf@kernel.org>,
	"hao.wu@intel.com" <hao.wu@intel.com>,
	"yilun.xu@intel.com" <yilun.xu@intel.com>,
	"trix@redhat.com" <trix@redhat.com>,
	"robh@kernel.org" <robh@kernel.org>,
	"saravanak@google.com" <saravanak@google.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [RFC v2 1/1] fpga-region: Add generic IOCTL interface for
 runtime FPGA programming
Message-ID: <Z1gD7QvhSN8p6//v@yilunxu-OptiPlex-7050>
References: <20241029091734.3288005-1-nava.kishore.manne@amd.com>
 <20241029091734.3288005-2-nava.kishore.manne@amd.com>
 <ZzwQrYeWVF6cRtgA@yilunxu-OptiPlex-7050>
 <DS7PR12MB6070AAA0C413DBF26F685207CD222@DS7PR12MB6070.namprd12.prod.outlook.com>
 <Z0Z6socXrmHQ26C0@yilunxu-OptiPlex-7050>
 <DS7PR12MB6070F3DD9119CD7955EF8AFCCD372@DS7PR12MB6070.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DS7PR12MB6070F3DD9119CD7955EF8AFCCD372@DS7PR12MB6070.namprd12.prod.outlook.com>

On Wed, Dec 04, 2024 at 06:40:18AM +0000, Manne, Nava kishore wrote:
> Hi Yilun,
> 
> > -----Original Message-----
> > From: Xu Yilun <yilun.xu@linux.intel.com>
> > Sent: Wednesday, November 27, 2024 7:20 AM
> > To: Manne, Nava kishore <nava.kishore.manne@amd.com>
> > Cc: git (AMD-Xilinx) <git@amd.com>; mdf@kernel.org; hao.wu@intel.com;
> > yilun.xu@intel.com; trix@redhat.com; robh@kernel.org; saravanak@google.com;
> > linux-kernel@vger.kernel.org; linux-fpga@vger.kernel.org;
> > devicetree@vger.kernel.org
> > Subject: Re: [RFC v2 1/1] fpga-region: Add generic IOCTL interface for runtime
> > FPGA programming
> > 
> > > > > + * struct fpga_region_ops - ops for low level FPGA region ops for
> > > > > +device
> > > > > + * enumeration/removal
> > > > > + * @region_status: returns the FPGA region status
> > > > > + * @region_config_enumeration: Configure and enumerate the FPGA region.
> > > > > + * @region_remove: Remove all devices within the FPGA region
> > > > > + * (which are added as part of the enumeration).
> > > > > + */
> > > > > +struct fpga_region_ops {
> > > > > +	int (*region_status)(struct fpga_region *region);
> > > > > +	int (*region_config_enumeration)(struct fpga_region *region,
> > > > > +					 struct fpga_region_config_info *config_info);
> > > >
> > > > My current concern is still about this combined API, it just
> > > > offloads all work to low level, but we have some common flows.
> > > > That's why we introduce a common FPGA reprograming API.
> > > >
> > > > I didn't see issue about the vendor specific pre configuration. They
> > > > are generally needed to initialize the struct fpga_image_info, which
> > > > is a common structure for fpga_region_program_fpga().
> > > >
> > > > For port IDs(AFU) inputs for DFL, I think it could also be changed
> > > > (Don't have to be implemented in this patchset). Previously DFL
> > > > provides an uAPI for the whole device, so it needs a port_id input
> > > > to position which fpga_region within the device for programming. But
> > > > now, we are introducing a per fpga_region programming interface, IIUC port_id
> > should not be needed anymore.
> > > >
> > > > The combined API is truly simple for leveraging the existing
> > > > of-fpga-region overlay apply mechanism. But IMHO that flow doesn't
> > > > fit our new uAPI well. That flow is to adapt the generic configfs
> > > > overlay interface, which comes to a dead end as you mentioned.
> > > >
> > > > My gut feeling for the generic programing flow should be:
> > > >
> > > >  1. Program the image to HW.
> > > >  2. Enumerate the programmed image (apply the DT overlay)
> > > >
> > > > Why we have to:
> > > >
> > > >  1. Start enumeration.
> > > >  2. On pre enumeration, programe the image.
> > > >  3. Real enumeration.
> > > >
> > >
> > > I agree with the approach of leveraging vendor-specific callbacks to
> > > handle the distinct phases of the FPGA programming process.
> > > Here's the proposed flow.
> > >
> > > Pre-Configuration:
> > > A vendor-specific callback extracts the required pre-configuration
> > > details and initializes struct fpga_image_info. This ensures that all
> > > vendor-specific
> > 
> > Since we need to construct the fpga_image_info, initialize multiple field as needed,
> > I'm wondering if configfs could be a solution for the uAPI?
> > 
> 
> A configfs uAPI isn't necessary, we can manage this using the proposed IOCTL flow. 
> The POC code looks as follows.

I prefer more to configfs cause it provides standard FS way to create
the fpga_image_info object, e.g. which attributes are visible for
OF/non-OF region, which attributes come from image blob and can only be
RO, etc.

Of couse ioctl() could achieve the same goal but would add much more
specific rules (maybe flags/types) for user to follow.

Thanks,
Yilun

> 
> static long fpga_region_device_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
> {
> 	struct fpga_region *region =  (struct fpga_region *)(file->private_data);
> 	struct fpga_region_config_info config_info;
> 	void __user *argp = (void __user *)arg;
> 	struct device *dev = &region->dev;
> 	struct fpga_image_info *info;
> 	int err;
> 
> 	switch (cmd) {
> 	case FPGA_REGION_IOCTL_LOAD:
> 		if (copy_from_user(&config_info, argp, sizeof(struct fpga_region_config_info)))
> 		return -EFAULT;
> 
> 		info = fpga_image_info_alloc(dev);
> 		if (!info)
> 			return ERR_PTR(-ENOMEM);
> 
> 		/* A vendor-specific callback extracts the required pre-configuration
> 		 * details and initializes struct fpga_image_info. This ensures that all
> 		 * vendor-specific requirements are handled before proceeding to
> 		 * the programming phase.
> 		 */
> 		err = region->region_ops->region_preconfig(region, &config_info, info);
> 		if (err)
> 			return err;
> 
> 		/* The common API fpga_region_program_fpga() is used to program
> 		 * the image to hardware.
> 		 */
> 		region->info = info;
> 		err = fpga_region_program_fpga(region);
> 		if (err) {
> 			fpga_image_info_free(info);
> 			region->info = NULL;
> 		}
> 
> 		/* A vendor-specific callback is used for real enumeration, enabling
> 		 * hardware specific customization.
> 		 */
> 		err = region->region_ops->region_enumeration(region, &config_info);
> 
> 		break;
> 
> 	case FPGA_REGION_IOCTL_REMOVE:
> 		if (copy_from_user(&config_info, argp, sizeof(struct fpga_region_config_info)))
> 			return -EFAULT;
> 
> 		err = region->region_ops->region_remove(region, &config_info);
> 		if (err)
> 			return err;
> 
> 		fpga_image_info_free(region->info);
> 
> 		break;
> 
> 	case FPGA_REGION_IOCTL_STATUS:
> 		unsigned int status;
> 
> 		status = region->region_ops->region_status(region);
> 
> 		if (copy_to_user((void __user *)arg, &status, sizeof(status)))
> 			err = -EFAULT;
> 
> 		break;
> 
> 	default:
> 		err = -ENOTTY;
> 	}
> 
> 	return err;
> }
> 
> Regards,
> Navakishore.

