Return-Path: <linux-fpga+bounces-942-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 651E09D1D31
	for <lists+linux-fpga@lfdr.de>; Tue, 19 Nov 2024 02:23:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A8AA282D6D
	for <lists+linux-fpga@lfdr.de>; Tue, 19 Nov 2024 01:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF2D04594A;
	Tue, 19 Nov 2024 01:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FWlu8oH6"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF6318E25;
	Tue, 19 Nov 2024 01:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731979330; cv=none; b=Wv5ejjXGggDTIcEccqBV7o0aq2j+8wgNikiq3ETxVob+tdVRDTPjWOICMl7fESN6OCWFoaT337AzwQFauLTrk7STDDljpPbDHdXAhxC0c85Rkic285OujJa7PBXXHrs4WyPt7Up/4gyA5Pe4QYIa6aAzIFPgSYCtkADHqjJAVMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731979330; c=relaxed/simple;
	bh=j/UXodRjiGEdeWbjsTbY6zpGiVX/1d5jHK7zp4eOHWw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RzjUC7JSQJ1ghdYdzcmdoqNZk2NRMzTHMo4hyG4ksvMAKCgFgBJeFHVYEhGbdwNPf7VhS/DCoIFbGpWEPqs5kNgmKnkSI5/FPRhiOa4sV10MeosCXdHTzb3bUk97UwH7ibuMZ9wPzMW+BydOmrSpaMk2vDXw8UMe9NPiG79Blsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FWlu8oH6; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731979329; x=1763515329;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=j/UXodRjiGEdeWbjsTbY6zpGiVX/1d5jHK7zp4eOHWw=;
  b=FWlu8oH6oH4ZvIdD29AAG+I35cQS+XARFz1yyzIUKR9K/YgXKwIfY0u3
   nKajyxQWNv0MngQiuLTHqotl1VH8ljMjLj3h1kuMWa+AJWwSYhAGSGDA4
   /dqDQaUGi42yWU5BA0JJX4Mte1ZOilVBt5WCmx5a1IFIXrYvPUHcHO4n6
   knlR7fy69W8t7NU03NubFR9lMNUZohaAyL7cLf8lxQIoVc+vbULr7/EYc
   EkmUJ9GekO92qGhYFhN8FLGgSJp0J2k1ujKInt4SjgyPyVPFliNyNP4lC
   I/turgco//eHRJ+ZKV7cFHO9vXmqpU8MuohPZAkDXoiReOOJ16/BJ+1Me
   A==;
X-CSE-ConnectionGUID: KaHxjnlYTE6T68Zp++0EjA==
X-CSE-MsgGUID: Y953zC9oQrqgd4GdcgwgZA==
X-IronPort-AV: E=McAfee;i="6700,10204,11260"; a="32110011"
X-IronPort-AV: E=Sophos;i="6.12,165,1728975600"; 
   d="scan'208";a="32110011"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2024 17:22:08 -0800
X-CSE-ConnectionGUID: nNRQ9EeGR/uAQia51Ct7PQ==
X-CSE-MsgGUID: M52M3w5WQ4KY6krbalh1LQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="94452959"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa003.jf.intel.com with ESMTP; 18 Nov 2024 17:22:05 -0800
Date: Tue, 19 Nov 2024 09:19:12 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: "Colberg, Peter" <peter.colberg@intel.com>
Cc: "Xu, Yilun" <yilun.xu@intel.com>,
	"linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
	"mdf@kernel.org" <mdf@kernel.org>, "Wu, Hao" <hao.wu@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"russ.weight@linux.dev" <russ.weight@linux.dev>,
	"Pagani, Marco" <marpagan@redhat.com>,
	"trix@redhat.com" <trix@redhat.com>,
	"basheer.ahmed.muddebihal@linux.intel.com" <basheer.ahmed.muddebihal@linux.intel.com>,
	"matthew.gerlach@linux.intel.com" <matthew.gerlach@linux.intel.com>
Subject: Re: [PATCH v4 15/19] fpga: dfl: convert is_feature_dev_detected() to
 use FIU type
Message-ID: <ZzvnkPzZ7FBPgonr@yilunxu-OptiPlex-7050>
References: <20241025223714.394533-1-peter.colberg@intel.com>
 <20241025223714.394533-16-peter.colberg@intel.com>
 <ZztQAsDCyRqGm6UW@yilunxu-OptiPlex-7050>
 <bad311610de9738e88982fabc46c04b15cdc3650.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bad311610de9738e88982fabc46c04b15cdc3650.camel@intel.com>

On Mon, Nov 18, 2024 at 11:00:28PM +0000, Colberg, Peter wrote:
> On Mon, 2024-11-18 at 22:32 +0800, Xu Yilun wrote:
> > On Fri, Oct 25, 2024 at 06:37:10PM -0400, Peter Colberg wrote:
> > > Use binfo->type instead of binfo->feature_dev to decide whether a
> > > feature device was detected during feature parsing. A subsequent
> > > commit will delay the allocation of the feature platform device
> > > to feature_dev_register() and remove binfo->feature_dev.
> > > 
> > > This commit does not introduce any functional changes.
> > > 
> > > Signed-off-by: Peter Colberg <peter.colberg@intel.com>
> > > Reviewed-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> > > Reviewed-by: Basheer Ahmed Muddebihal <basheer.ahmed.muddebihal@linux.intel.com>
> > > ---
> > > Changes since v3:
> > > - New patch extracted from last patch of v3 series.
> > > ---
> > >  drivers/fpga/dfl.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
> > > index 758673b0290a..a9ec37278b2d 100644
> > > --- a/drivers/fpga/dfl.c
> > > +++ b/drivers/fpga/dfl.c
> > > @@ -1248,7 +1248,7 @@ static int parse_feature_port_afu(struct build_feature_devs_info *binfo,
> > >  return create_feature_instance(binfo, ofst, size, FEATURE_ID_AFU);
> > >  }
> > >  
> > > -#define is_feature_dev_detected(binfo) (!!(binfo)->feature_dev)
> > > +#define is_feature_dev_detected(binfo) ((binfo)->type != DFL_ID_MAX)
> > 
> > I still doesn't get why put the change here. How it resolves my concern
> > compared to v3?
> 
> Could you elaborate on your concern? I moved this change into a
> separate commit so that it is not lost in other changes, but I don't

I did't mean this change had to be separated, I doubt it impacts the
functionality when it was applied. After the series were all applied the
issue may be fixed but people review patches one by one.

> see how the two definitions would not be functionally equivalent. Would
> it help to extend the commit description along the following lines?
> 
>    1. Before this series, binfo->feature_dev was initialized to NULL by
>       devm_kzalloc() in dfl_fpga_feature_devs_enumerate(). After this
>       series, binfo->type is initialized to DFL_ID_MAX in
>       dfl_fpga_feature_devs_enumerate().
>    2. Before this series, binfo->feature_dev was set to a non-NULL
>       pointer in build_info_create_dev(), which in turn was called from

So at the point of *this patch* is applied, binfo->feature_dev & binfo->type
don't initialize at the same time, there is some gap the caller of
is_feature_dev_detected() would get a different result, e.g.
when build_info_create_dev() fails, binfo->type holds valid DFL_ID but
binfo->feature_dev is NULL.

>       parse_feature_fiu(). After this series, binfo->type is set to a
>       non-DFL_ID_MAX value, as returned by dfh_id_to_type(), in
>       parse_feature_fiu().
>    3. Before this series, binfo->feature_dev was reset to NULL at the
>       end of build_info_commit_dev(). After this series, binfo->type is
>       reset to DFL_ID_MAX at the end of build_info_commit_dev().
> 
> Thanks,
> Peter
> 
> > 
> > Thanks,
> > Yilun
> > 
> > >  
> > >  static int parse_feature_afu(struct build_feature_devs_info *binfo,
> > >  resource_size_t ofst)
> > > -- 
> > > 2.47.0
> > > 
> > > 
> 

