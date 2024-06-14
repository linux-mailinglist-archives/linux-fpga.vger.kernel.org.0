Return-Path: <linux-fpga+bounces-545-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBE5390820F
	for <lists+linux-fpga@lfdr.de>; Fri, 14 Jun 2024 04:52:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDE231C22004
	for <lists+linux-fpga@lfdr.de>; Fri, 14 Jun 2024 02:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C436137C20;
	Fri, 14 Jun 2024 02:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="khxLqtb0"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB471374FE;
	Fri, 14 Jun 2024 02:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718333495; cv=none; b=BOJblZEcipUHAlQJnGCSiT6mAIRBoDf///TXHQmR8tXc3PxzRGEVGcUnjidreSZu5VAdienL8ATuP+WdANZZok9ksnvbiBgKfL6CnHVkWe4f6lxR0oiODCElD3p0thFjcROEhTmOf3hwkYpIyE4/R4vNsZN4mcQSocM3bnMqohc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718333495; c=relaxed/simple;
	bh=t6bCGIaBJnf264kqofmLb4/O4TTdgZNzhkHU/ELqBbM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RSLXlRuSzZkQ3Z8/LCuIpMdBBuiodBU/um/b6GIRKEWNeKoBqoqvmzcz36UEuy4c6qbkcAa4Pv/TFronLa2UFb32BCQXOWrk/kh0eTfzZTuaA9+wmPiP+h2Xw9RLu3Q1N4jleg4kBviCnmddg1FS0jeBi936AVdYtl3IZDBgCIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=khxLqtb0; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718333494; x=1749869494;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=t6bCGIaBJnf264kqofmLb4/O4TTdgZNzhkHU/ELqBbM=;
  b=khxLqtb0KrQO+sC09XroxSiUE0VWEl87RRD//mxtFQ5f1ikZY2l2x8bK
   qq5KOmaAgqk/JpJfV8/D4ObmwWLhcEN54tq6w8f740G9MiJYxvXbdHfMK
   9h9i5ytetp7pSq2cb1N6FwmpKfNfjRlc+Tq0S0Sjusd66LjPfzJ0mn3PD
   oPRF/Ei2V/bVyeO/EA858JU9RTSGhaBXRwgeiHLd4tCAwkqRitevRTWqv
   3NsYJCJvCaA5PT0TBg4xzGSXhzKDftskaPlCf/Ng1nBOzzJvJ7R7AdKwB
   rDqR5oLtj2NH21nj8Z0AdS8MdUPnmhxI3Sxy29HtsjvHsDi16L9Tc/y8d
   g==;
X-CSE-ConnectionGUID: MIps3CqhSIOqWjgCK38jjg==
X-CSE-MsgGUID: f0nF87CcTOWrT72jOkYX5A==
X-IronPort-AV: E=McAfee;i="6700,10204,11102"; a="32680059"
X-IronPort-AV: E=Sophos;i="6.08,236,1712646000"; 
   d="scan'208";a="32680059"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2024 19:51:33 -0700
X-CSE-ConnectionGUID: oWAIFTdfT1mfCQZj+UkqWg==
X-CSE-MsgGUID: EjxyDBZmQrCz+73Ek78TIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,236,1712646000"; 
   d="scan'208";a="41077678"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa007.jf.intel.com with ESMTP; 13 Jun 2024 19:51:31 -0700
Date: Fri, 14 Jun 2024 10:44:58 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: "Colberg, Peter" <peter.colberg@intel.com>
Cc: "Xu, Yilun" <yilun.xu@intel.com>,
	"linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
	"mdf@kernel.org" <mdf@kernel.org>, "Wu, Hao" <hao.wu@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"russ.weight@linux.dev" <russ.weight@linux.dev>,
	"Pagani, Marco" <marpagan@redhat.com>,
	"trix@redhat.com" <trix@redhat.com>,
	"russell.h.weight@intel.com" <russell.h.weight@intel.com>,
	"matthew.gerlach@linux.intel.com" <matthew.gerlach@linux.intel.com>
Subject: Re: [RFC PATCH v2 9/9] fpga: dfl: fix kernel warning on port
 release/assign for SRIOV
Message-ID: <ZmuuqlMJ4nU6m25U@yilunxu-OptiPlex-7050>
References: <20240409233942.828440-1-peter.colberg@intel.com>
 <20240409233942.828440-10-peter.colberg@intel.com>
 <ZifVYiMgssOFjM17@yilunxu-OptiPlex-7050>
 <97093c23ae13a1fdcc52f85e5658a39e8a5ce716.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <97093c23ae13a1fdcc52f85e5658a39e8a5ce716.camel@intel.com>

On Wed, Jun 12, 2024 at 10:16:29PM +0000, Colberg, Peter wrote:
> On Tue, 2024-04-23 at 23:36 +0800, Xu Yilun wrote:
> > On Tue, Apr 09, 2024 at 07:39:42PM -0400, Peter Colberg wrote:
> > > From: Xu Yilun <yilun.xu@intel.com>
> > > 
> > > DFL ports are registered as platform devices in PF mode. The port device
> > > should be removed from the host when the user wants to configure the
> > > port as a VF and pass through to a virtual machine. The FME device
> > > ioctls DFL_FPGA_FME_PORT_RELEASE/ASSIGN are designed for this purpose.
> > > 
> > > In the previous implementation, the port platform device is not completely
> > > destroyed on port release: it is removed from the system by
> > > platform_device_del(), but the platform device instance is retained.
> > > When the port assign ioctl is called, the platform device is added back by
> > > platform_device_add(), which conflicts with this comment of device_add():
> > > "Do not call this routine more than once for any device structure", and
> > > will cause a kernel warning at runtime.
> > > 
> > > This patch tries to completely unregister the port platform device on
> > > release and registers a new one on assign. But the main work is to remove
> > > the dependency on struct dfl_feature_platform_data for many internal DFL
> > > APIs. This structure holds many DFL enumeration infos for feature devices.
> > > Many DFL APIs are expected to work with these info even when the port
> > > platform device is unregistered. But with the change the platform_data will
> > > be freed in this case. So this patch introduces a new structure
> > > dfl_feature_dev_data for these APIs, which acts similarly to the previous
> > > dfl_feature_platform_data. The dfl_feature_platform_data then only needs a
> > > pointer to dfl_feature_dev_data to make the feature device driver work.
> > > 
> > > Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> > > Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> > > Signed-off-by: Peter Colberg <peter.colberg@intel.com>
> > > ---
> > > v2:
> > > - Split monolithic patch into series at request of maintainer
> > > - Substitute binfo->type for removed function feature_dev_id_type() in
> > >   parse_feature_irqs().
> > > - Return ERR_PTR(-ENOMEM) on !feature->params in
> > >   binfo_create_feature_dev_data().
> > > - Reorder cdev as first member of struct dfl_feature_platform_data
> > >   such that container_of() to obtain pdata evaluates to a no-op.
> > > - Align kernel-doc function name for __dfl_fpga_cdev_find_port_data().
> > > ---
> > >  drivers/fpga/dfl-afu-main.c |   9 +-
> > >  drivers/fpga/dfl-fme-br.c   |  24 +-
> > >  drivers/fpga/dfl-fme-main.c |   6 +-
> > >  drivers/fpga/dfl.c          | 430 +++++++++++++++++-------------------
> > >  drivers/fpga/dfl.h          |  86 +++++---
> > >  5 files changed, 281 insertions(+), 274 deletions(-)
> > > 
> > > diff --git a/drivers/fpga/dfl-afu-main.c b/drivers/fpga/dfl-afu-main.c
> > > index 42928cc7e42b..ead03b7aea70 100644
> > > --- a/drivers/fpga/dfl-afu-main.c
> > > +++ b/drivers/fpga/dfl-afu-main.c
> > > @@ -143,9 +143,8 @@ static int port_reset(struct platform_device *pdev)
> > >  	return ret;
> > >  }
> > >  
> > > -static int port_get_id(struct platform_device *pdev)
> > > +static int port_get_id(struct dfl_feature_dev_data *fdata)
> > >  {
> > > -	struct dfl_feature_dev_data *fdata = to_dfl_feature_dev_data(&pdev->dev);
> > >  	void __iomem *base;
> > >  
> > >  	base = dfl_get_feature_ioaddr_by_id(fdata, PORT_FEATURE_ID_HEADER);
> > > @@ -156,7 +155,8 @@ static int port_get_id(struct platform_device *pdev)
> > >  static ssize_t
> > >  id_show(struct device *dev, struct device_attribute *attr, char *buf)
> > >  {
> > > -	int id = port_get_id(to_platform_device(dev));
> > > +	struct dfl_feature_dev_data *fdata = to_dfl_feature_dev_data(dev);
> > > +	int id = port_get_id(fdata);
> > 
> 
> Thank you for the comprehensive review.
> 
> > My quick idea is we go with these steps:
> > 1. refactor struct dfl_feature_platform_data then replace all dev/pdev
> >    arguments with pdata when necessary.
> 
> Could you outline how far the refactoring should go? The main changes
> are introduced with the destruction of the platform device on port

Yes, exactly. And the goal is to make the change in a standalone patch
so that everyone can find it, rather than bury in other massive
replacements.

> release. If the refactoring retains the platform device but adds all
> the new members to pdata, I find that this patch would introduce non-
> trivial intermediate code that is then deleted in a subsequent patch.

That would not be a problem, as long as they clearly get explained, and
in one patch series. Sometimes we need intermediate code to ensure a
patch for one change, which makes people easy to read.

> 
> > 2. factor out fdata from pdata, add fdata helpers.
> > 3. massive pdata->fdata replacement.
> > 4. delete all unused pdata helpers.
> 
> The (roughly) reverse order seems to produce the smallest patch set:

I don't think 'smallest' is the major concern, but it's fine if you
firstly addressed other concerns. I cannot actually tell if it is
better until the code is seen. But to emphasize on, the core change is
splited out, the massive replacement patches are just replacements so
they can be easily overviewed and skipped.

Thanks,
Yilun 

> 
> 1. Replace function argument `struct device *dev` with `struct
> dfl_feature_platform_data *pdata` as needed.
> 2. #define dfl_feature_dev_data dfl_feature_platform_data and massive
> pdata -> fdata replacement.
> 3. Remove #define dfl_feature_dev_data, factor out dfl_feature_dev_data
> from dfl_feature_platform_data, and destroy platform device on release.
> 
> Thanks,
> Peter

