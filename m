Return-Path: <linux-fpga+bounces-992-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 50E699FF5C3
	for <lists+linux-fpga@lfdr.de>; Thu,  2 Jan 2025 04:28:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F47F1882523
	for <lists+linux-fpga@lfdr.de>; Thu,  2 Jan 2025 03:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF365C13D;
	Thu,  2 Jan 2025 03:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Sn8qYxuT"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35CA817543;
	Thu,  2 Jan 2025 03:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735788526; cv=none; b=MMMvyx6emSVtn8iFk0vsRHRtVLDyxpti0QnUS1lFxmkkXAm8iQTC9juLq8H6Yo1uwDFK0V8jT6mVIqHy6Pwki29R0DWghC+4Ko1NNhH/Lfv+/H3yOhOB5G3i86NF5mjO69dGLEZtuKiMwJT0msa7kMSUSX0hXr3qKx9cqKKO6oY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735788526; c=relaxed/simple;
	bh=bJ1/AVbjtnQJNuDD5abSrCIcthNOmJy1qRHyRZSwglc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n0wWFb1zky8+h3GOSRcuOFJ7LYvAOc4Dp3jq8042sXVvCttWxqvN8+s1uLLqF82+IGPbVExo3n8MRA1qxTuZd7t03OINqxLW9wfpM3v/TlCHj80p/LemmtOdnCchCWtxFAXj+u4j0Y4+fxUC9nQOKhF92UJcIvBjYEJPMVMWu9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Sn8qYxuT; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735788524; x=1767324524;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bJ1/AVbjtnQJNuDD5abSrCIcthNOmJy1qRHyRZSwglc=;
  b=Sn8qYxuTN6eMYtHCJqc+AwyT8tGDU1eCy9JQ6VEAjRgzk5Ikdz3fdQUY
   YqQ5GFAUntGOrpCBCqVcHS5AvtBxOOMJp6fhY5w1S71suJPf6OGVj8A5R
   j0TSifK+Ga1l7fwDlz9LUb/5NqnxeZ/bhf+LLriKTIYavA14dtprq14me
   svk/GB/iV1PLeKAmLX2Y/8wzCv3/sphWemOLi9FsKFpSg+ZyU0tA+rE6f
   JcXDJ9StHgkl/h+5R0JgnaSjnVmvINB1OyHmO5aYhzwZSHRKmPER8elnl
   Vz6UO9GVBKT1pqs521lB4RI9AqVRTsv7BasOl06DdWe4DS6JDdmY5Tp1+
   g==;
X-CSE-ConnectionGUID: bop4SNZrRTiFg7RUg6AXJQ==
X-CSE-MsgGUID: trPbgRxGQ42pW5xQMkK1Aw==
X-IronPort-AV: E=McAfee;i="6700,10204,11302"; a="36244531"
X-IronPort-AV: E=Sophos;i="6.12,284,1728975600"; 
   d="scan'208";a="36244531"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jan 2025 19:28:43 -0800
X-CSE-ConnectionGUID: ddLkeflbSyWN/uYDWm0WLQ==
X-CSE-MsgGUID: xs+Ns/HCSWWszYIJRxqENg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,284,1728975600"; 
   d="scan'208";a="101886826"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa009.fm.intel.com with ESMTP; 01 Jan 2025 19:28:41 -0800
Date: Sun, 19 Mar 2023 23:38:21 +0800
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
Message-ID: <ZBcsbTG3PaDjNzUX@yilunxu-OptiPlex-7050>
References: <20241029091734.3288005-1-nava.kishore.manne@amd.com>
 <20241029091734.3288005-2-nava.kishore.manne@amd.com>
 <ZzwQrYeWVF6cRtgA@yilunxu-OptiPlex-7050>
 <DS7PR12MB6070AAA0C413DBF26F685207CD222@DS7PR12MB6070.namprd12.prod.outlook.com>
 <Z0Z6socXrmHQ26C0@yilunxu-OptiPlex-7050>
 <DS7PR12MB6070F3DD9119CD7955EF8AFCCD372@DS7PR12MB6070.namprd12.prod.outlook.com>
 <Z1gD7QvhSN8p6//v@yilunxu-OptiPlex-7050>
 <DS7PR12MB60706A47591D7F3CC6D41398CD062@DS7PR12MB6070.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DS7PR12MB60706A47591D7F3CC6D41398CD062@DS7PR12MB6070.namprd12.prod.outlook.com>

On Thu, Dec 19, 2024 at 09:47:12AM +0000, Manne, Nava kishore wrote:
> Hi Yilun,
> 
> > -----Original Message-----
> > From: Xu Yilun <yilun.xu@linux.intel.com>
> > Sent: Tuesday, December 10, 2024 2:34 PM
> > To: Manne, Nava kishore <nava.kishore.manne@amd.com>
> > Cc: git (AMD-Xilinx) <git@amd.com>; mdf@kernel.org; hao.wu@intel.com;
> > yilun.xu@intel.com; trix@redhat.com; robh@kernel.org; saravanak@google.com;
> > linux-kernel@vger.kernel.org; linux-fpga@vger.kernel.org;
> > devicetree@vger.kernel.org
> > Subject: Re: [RFC v2 1/1] fpga-region: Add generic IOCTL interface for runtime
> > FPGA programming
> > 
> > On Wed, Dec 04, 2024 at 06:40:18AM +0000, Manne, Nava kishore wrote:
> > > Hi Yilun,
> > >
> > > > -----Original Message-----
> > > > From: Xu Yilun <yilun.xu@linux.intel.com>
> > > > Sent: Wednesday, November 27, 2024 7:20 AM
> > > > To: Manne, Nava kishore <nava.kishore.manne@amd.com>
> > > > Cc: git (AMD-Xilinx) <git@amd.com>; mdf@kernel.org;
> > > > hao.wu@intel.com; yilun.xu@intel.com; trix@redhat.com;
> > > > robh@kernel.org; saravanak@google.com; linux-kernel@vger.kernel.org;
> > > > linux-fpga@vger.kernel.org; devicetree@vger.kernel.org
> > > > Subject: Re: [RFC v2 1/1] fpga-region: Add generic IOCTL interface
> > > > for runtime FPGA programming
> > > >
> > > > > > > + * struct fpga_region_ops - ops for low level FPGA region ops
> > > > > > > +for device
> > > > > > > + * enumeration/removal
> > > > > > > + * @region_status: returns the FPGA region status
> > > > > > > + * @region_config_enumeration: Configure and enumerate the FPGA
> > region.
> > > > > > > + * @region_remove: Remove all devices within the FPGA region
> > > > > > > + * (which are added as part of the enumeration).
> > > > > > > + */
> > > > > > > +struct fpga_region_ops {
> > > > > > > +	int (*region_status)(struct fpga_region *region);
> > > > > > > +	int (*region_config_enumeration)(struct fpga_region *region,
> > > > > > > +					 struct fpga_region_config_info
> > *config_info);
> > > > > >
> > > > > > My current concern is still about this combined API, it just
> > > > > > offloads all work to low level, but we have some common flows.
> > > > > > That's why we introduce a common FPGA reprograming API.
> > > > > >
> > > > > > I didn't see issue about the vendor specific pre configuration.
> > > > > > They are generally needed to initialize the struct
> > > > > > fpga_image_info, which is a common structure for
> > fpga_region_program_fpga().
> > > > > >
> > > > > > For port IDs(AFU) inputs for DFL, I think it could also be
> > > > > > changed (Don't have to be implemented in this patchset).
> > > > > > Previously DFL provides an uAPI for the whole device, so it
> > > > > > needs a port_id input to position which fpga_region within the
> > > > > > device for programming. But now, we are introducing a per
> > > > > > fpga_region programming interface, IIUC port_id
> > > > should not be needed anymore.
> > > > > >
> > > > > > The combined API is truly simple for leveraging the existing
> > > > > > of-fpga-region overlay apply mechanism. But IMHO that flow
> > > > > > doesn't fit our new uAPI well. That flow is to adapt the generic
> > > > > > configfs overlay interface, which comes to a dead end as you mentioned.
> > > > > >
> > > > > > My gut feeling for the generic programing flow should be:
> > > > > >
> > > > > >  1. Program the image to HW.
> > > > > >  2. Enumerate the programmed image (apply the DT overlay)
> > > > > >
> > > > > > Why we have to:
> > > > > >
> > > > > >  1. Start enumeration.
> > > > > >  2. On pre enumeration, programe the image.
> > > > > >  3. Real enumeration.
> > > > > >
> > > > >
> > > > > I agree with the approach of leveraging vendor-specific callbacks
> > > > > to handle the distinct phases of the FPGA programming process.
> > > > > Here's the proposed flow.
> > > > >
> > > > > Pre-Configuration:
> > > > > A vendor-specific callback extracts the required pre-configuration
> > > > > details and initializes struct fpga_image_info. This ensures that
> > > > > all vendor-specific
> > > >
> > > > Since we need to construct the fpga_image_info, initialize multiple
> > > > field as needed, I'm wondering if configfs could be a solution for the uAPI?
> > > >
> > >
> > > A configfs uAPI isn't necessary, we can manage this using the proposed IOCTL
> > flow.
> > > The POC code looks as follows.
> > 
> > I prefer more to configfs cause it provides standard FS way to create the
> > fpga_image_info object, e.g. which attributes are visible for OF/non-OF region, which
> > attributes come from image blob and can only be RO, etc.
> > 
> > Of couse ioctl() could achieve the same goal but would add much more specific rules
> > (maybe flags/types) for user to follow.
> > 
> 
> Agreed. Using ConfigFS is preferable because it provides a standardized filesystem
> interface for creating and managing the fpga_image_info object.
> 
> The proposed new user interface is outlined as follows:
> 
> # Mount ConfigFS filesystem
> mount -t configfs none /sys/kernel/config
> 
> # Upload Configuration and Load the Bitstream for the Targeted FPGA Region.
> 
> Configuration File Upload:
> Upload the configuration file containing the necessary metadata or settings required
> for configuring the FPGA region. This file may vary based on the vendor and includes
> important details specific to the vendor's requirements.
> 
> Vendor-Specific Callback: 
> A vendor-specific callback function extracts the relevant configuration data from the file.
> The format and contents of the configuration file can differ between vendors. The callback
> then initializes the struct fpga_image_info, ensuring all vendor-specific requirements are
> satisfied.
> 
> Device-Specific Considerations:
> For Open Firmware (OF) devices, fpga.dtbo files are used instead of fpga_config files.
> These .dtbo files contain all necessary information to populate the fpga_image_info.
> For non-OF devices, a vendor specific fpga.config files are used to provide the required
> data for initializing the fpga_image_info.

non-OF fpga images usually don't contain fpga_image_info data (e.g.
enable/disable_timeout_us). I think we don't have to force users embed
these data in fpga image, provide additional configfs attributes to
input these data is possible. For some FPGA regions (e.g. OF), these
attributes could be RO, some could be RW, depends on different FPGA
region drivers.

So I think we may have a Configuration File Upload interface, like:

  echo "config_file" > /sys/kernel/config/fpga/<region>/image

Some additional parameter interfaces, like:

  echo 10000 > /sys/kernel/config/fpga/<region>/enable_timeout
  ...

And a Configuration interface, like:

  # programming
  echo 1 > /sys/kernel/config/fpga/<region>/config
  # removing
  echo 0 > /sys/kernel/config/fpga/<region>/config

How do you think?

Thanks,
Yilun

> 
> FPGA Configuration:
> Once the configuration details are extracted and the fpga_image_info structure is initialized,
> the FPGA can be programmed accordingly.
> 
> echo "config_file" > /sys/kernel/config/fpga/<region>/config
> 
> 
> # Check the status of "region"
> cat /sys/kernel/config/fpga/<region>/status
> 
> # Remove "region"
> echo "remove" > /sys/kernel/config/fpga/<region>/remove
> 
> Looking forward to your feedback.
> 
> Regards,
> Navakishore.
> 

