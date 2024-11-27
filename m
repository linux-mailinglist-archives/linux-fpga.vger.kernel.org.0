Return-Path: <linux-fpga+bounces-972-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 873549DA07A
	for <lists+linux-fpga@lfdr.de>; Wed, 27 Nov 2024 02:52:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FD90165DBF
	for <lists+linux-fpga@lfdr.de>; Wed, 27 Nov 2024 01:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03EED1DFFC;
	Wed, 27 Nov 2024 01:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IqnU1riJ"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D581C18E0E;
	Wed, 27 Nov 2024 01:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732672365; cv=none; b=PIBRsOUXUU0rZzLmAfKQXTMqqgASp2mpaXzvjue5YHmVy33Inyu1SvPYk4AjV6OKXEygGDobvrlnaumHiP2SXUQ7mKKkJnOxLLn91Dpto7WnvOSufA0BJbRACgn1F+LPVnn1Nh9zv2RdjlZVs/XY2L4S9X/gs/nWsCEc6u9qU+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732672365; c=relaxed/simple;
	bh=u8XBNmwneoxB5iJSOE8owpe1u+lvHw247qoEVK8QUCw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TqDpKFS6KO2OzWf/NfkRN336Mc+5Lf82zn7EgO/O9UbaixYSOASK4IszSPklzVquyRrcpnqfllkh/53AWurxGnyCYpRLMAp+fAaldutg9+zdecBSbAor4RyU7bALJMXK6qAd72CfuZtfVUgwbdy892bJ3ait6wo6iU3SBKGxx+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IqnU1riJ; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732672365; x=1764208365;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=u8XBNmwneoxB5iJSOE8owpe1u+lvHw247qoEVK8QUCw=;
  b=IqnU1riJJMOdaCoHvuhmY46tyJD6dvI54f/P2Pnme6WC3xR5vVWy3Fj8
   MMb8lxFFMu/HdAmobFTJaYWSrut7UWKYErlxAKXhkNWGZ3Tmsj7mtS+1l
   P7ogF2pn/XUV+blOYUemk5o69JDlaxhVPJLGbRJSjELMxh3YjiGE0D3ms
   xUe31JWyIsVDQTVyTSjT9yKW9686SsoFmjOs7bE+d4tILYWQgSn/P38V+
   TkdNjrGrpbIOHA6qRel8nb65hUwQxbBXUXfLszjtTGJWwUr26EN+EVecw
   WsX4l/hoyzNx3B11HhQLmc8WAxX5bEcJZznwuAT3G2HXvkfcn4EKeMF3N
   A==;
X-CSE-ConnectionGUID: 2yAN82ijS3uSpDaZktAQyQ==
X-CSE-MsgGUID: c6UJnGTKT02i/CA0opHeQA==
X-IronPort-AV: E=McAfee;i="6700,10204,11268"; a="36522200"
X-IronPort-AV: E=Sophos;i="6.12,188,1728975600"; 
   d="scan'208";a="36522200"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2024 17:52:44 -0800
X-CSE-ConnectionGUID: vVheyF9cQl+zWAixouNtOw==
X-CSE-MsgGUID: +iGyTpcfSn+/pU+XeSIWEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,188,1728975600"; 
   d="scan'208";a="92110771"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa010.fm.intel.com with ESMTP; 26 Nov 2024 17:52:40 -0800
Date: Wed, 27 Nov 2024 09:49:38 +0800
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
Message-ID: <Z0Z6socXrmHQ26C0@yilunxu-OptiPlex-7050>
References: <20241029091734.3288005-1-nava.kishore.manne@amd.com>
 <20241029091734.3288005-2-nava.kishore.manne@amd.com>
 <ZzwQrYeWVF6cRtgA@yilunxu-OptiPlex-7050>
 <DS7PR12MB6070AAA0C413DBF26F685207CD222@DS7PR12MB6070.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DS7PR12MB6070AAA0C413DBF26F685207CD222@DS7PR12MB6070.namprd12.prod.outlook.com>

> > > + * struct fpga_region_ops - ops for low level FPGA region ops for
> > > +device
> > > + * enumeration/removal
> > > + * @region_status: returns the FPGA region status
> > > + * @region_config_enumeration: Configure and enumerate the FPGA region.
> > > + * @region_remove: Remove all devices within the FPGA region
> > > + * (which are added as part of the enumeration).
> > > + */
> > > +struct fpga_region_ops {
> > > +	int (*region_status)(struct fpga_region *region);
> > > +	int (*region_config_enumeration)(struct fpga_region *region,
> > > +					 struct fpga_region_config_info *config_info);
> > 
> > My current concern is still about this combined API, it just offloads all work to low
> > level, but we have some common flows. That's why we introduce a common FPGA
> > reprograming API.
> > 
> > I didn't see issue about the vendor specific pre configuration. They are generally
> > needed to initialize the struct fpga_image_info, which is a common structure for
> > fpga_region_program_fpga().
> > 
> > For port IDs(AFU) inputs for DFL, I think it could also be changed (Don't have to be
> > implemented in this patchset). Previously DFL provides an uAPI for the whole
> > device, so it needs a port_id input to position which fpga_region within the device for
> > programming. But now, we are introducing a per fpga_region programming interface,
> > IIUC port_id should not be needed anymore.
> > 
> > The combined API is truly simple for leveraging the existing of-fpga-region overlay
> > apply mechanism. But IMHO that flow doesn't fit our new uAPI well. That flow is to
> > adapt the generic configfs overlay interface, which comes to a dead end as you
> > mentioned.
> > 
> > My gut feeling for the generic programing flow should be:
> > 
> >  1. Program the image to HW.
> >  2. Enumerate the programmed image (apply the DT overlay)
> > 
> > Why we have to:
> > 
> >  1. Start enumeration.
> >  2. On pre enumeration, programe the image.
> >  3. Real enumeration.
> > 
> 
> I agree with the approach of leveraging vendor-specific callbacks to handle
> the distinct phases of the FPGA programming process. 
> Here's the proposed flow.
>  
> Pre-Configuration:
> A vendor-specific callback extracts the required pre-configuration details
> and initializes struct fpga_image_info. This ensures that all vendor-specific

Since we need to construct the fpga_image_info, initialize multiple
field as needed, I'm wondering if configfs could be a solution for the
uAPI?

> requirements are handled before proceeding to the programming phase.
>  
> Programming:
> The common API fpga_region_program_fpga() is used to program the image
> to hardware. This standardizes the programming logic, minimizing duplication
> and ensuring consistency across implementations.
>  
> Enumeration:
> A vendor-specific callback is used for real enumeration, enabling hardware
> specific customization while keeping the flow flexible and adaptable
> 
> This approach provides a clean separation of responsibilities, with
> vendor-specific logic confined to the pre-configuration and enumeration
> phases, while the programming phase leverages a common API.
> It simplifies maintenance and aligns well with the Program -> Enumerate flow.

Generally I'm good to this flow.

Thanks,
Yilun

>  
> Looking forward to your feedback.
> 
> 
> Regards,
> Navakishore.

