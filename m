Return-Path: <linux-fpga+bounces-991-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEF8F9FC9E4
	for <lists+linux-fpga@lfdr.de>; Thu, 26 Dec 2024 10:20:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6068016197E
	for <lists+linux-fpga@lfdr.de>; Thu, 26 Dec 2024 09:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87EE415DBAE;
	Thu, 26 Dec 2024 09:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fz0FHfmT"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF20713FD83;
	Thu, 26 Dec 2024 09:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735204814; cv=none; b=JVkSExxgVsvPm2dUsvpZKWWRlOuhcJPbDhMONRAOXLr66gNMT7noLkhlkyd7dq3wx6jVrEUBdCMva/e9dn8dOyRcBibttAF66nKGqYSiE5vw5cP4qyjezjoGH9FAZXlheZnmtWpcVdgpukv31+0ZLkT40xbz0Y0XRk9lAfiCa8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735204814; c=relaxed/simple;
	bh=gXKfLuIYTRoGA1GaTUcq2e2NJJNp2JrtJSL0j6xuSno=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RlbCbuqN5jBD1/SKBV7QR+Avj7EJvAoJXdK4op1qOtJUxWUbyDSt5+Fex79gIEpZ8IT8SmdUq1YN9dBAWUtkDxjeqWDh0VrtmGCWkuOfpJPg5OkrYYdt72wBNTOXA4KUuGq3muBSzC7shT8QCRODSqGogMTWLl+8GYryRCHbSNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fz0FHfmT; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735204812; x=1766740812;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gXKfLuIYTRoGA1GaTUcq2e2NJJNp2JrtJSL0j6xuSno=;
  b=fz0FHfmTrgF7zXNrMLFj+x9jKdbgIhMZQdDeY7SfhOhZJBgRFDbTPT7f
   3vVETR1R0kVs8LSWj3SsBAW76miMKohuUl7Le1Si83hpHpnK4hqD3QUo2
   uvzJRAoYNot8MXPRBKzmCkZAqvlJ1zVcsirXrn2c1hbBGWDc1zBDLRefI
   QGgDDZaKtapaDfpUnKEFlzxJ7OcX4taSVUfPKRcUHQZvZs43erbPOJ32L
   genfA4Fbjr10Sr+/FXGnb5VPU6K4p6G60Akn6etiSyR/QYEx9PJ2kqTne
   JVXb0ge1RtSC3/okewrV5KfoTGiFTlvQZxCtVF8gbfLdftApEUC1vT4dL
   w==;
X-CSE-ConnectionGUID: 9ZBxvBBER2WxQVbwWK0p0w==
X-CSE-MsgGUID: K81a2uGATL648mgDgpjVPw==
X-IronPort-AV: E=McAfee;i="6700,10204,11296"; a="35760949"
X-IronPort-AV: E=Sophos;i="6.12,265,1728975600"; 
   d="scan'208";a="35760949"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Dec 2024 01:20:12 -0800
X-CSE-ConnectionGUID: zBS1q9FJRRuD2P3wTKsbkQ==
X-CSE-MsgGUID: uMGoqNQiQVSwpXYnSMZcXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,265,1728975600"; 
   d="scan'208";a="104853907"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa004.jf.intel.com with ESMTP; 26 Dec 2024 01:20:10 -0800
Date: Mon, 13 Mar 2023 05:30:01 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Yidong Zhang <yidong.zhang@amd.com>
Cc: linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org,
	mdf@kernel.org, hao.wu@intel.com, yilun.xu@intel.com,
	lizhi.hou@amd.com, DMG Karthik <Karthik.DMG@amd.com>,
	Nishad Saraf <nishads@amd.com>,
	Prapul Krishnamurthy <prapulk@amd.com>
Subject: Re: [PATCH V1 1/3] drivers/fpga/amd: Add new driver for AMD Versal
 PCIe card
Message-ID: <ZA5EWexVjo7onYuR@yilunxu-OptiPlex-7050>
References: <20241007220128.3023169-1-yidong.zhang@amd.com>
 <ZxH9Xjd0eU/7IDGC@yilunxu-OptiPlex-7050>
 <56421e2e-062c-407b-b731-0c1d585a1277@amd.com>
 <Zzw5MOb6dUD6BLYh@yilunxu-OptiPlex-7050>
 <f9abc70d-2d07-4506-a227-af297eb77058@amd.com>
 <ZA4T3rawY7rEIhxp@yilunxu-OptiPlex-7050>
 <f5994bad-afa1-4268-b631-0afcc7c8ce75@amd.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f5994bad-afa1-4268-b631-0afcc7c8ce75@amd.com>

On Wed, Dec 25, 2024 at 10:10:06PM -0800, Yidong Zhang wrote:
> 
> 
> On 3/12/23 11:03, Xu Yilun wrote:
> > Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> > 
> > 
> > On Sun, Dec 22, 2024 at 05:53:30PM -0800, Yidong Zhang wrote:
> > > 
> > > 
> > > On 11/18/24 23:07, Xu Yilun wrote:
> > > > 
> > > > > > > +obj-$(CONFIG_AMD_VERSAL_MGMT)                        += amd-vmgmt.o
> > > > > > IMHO the naming vmgmt is hard to understand, any better idea?
> > > > > The "v" stand for Versal. We would change to amd-vpci for Versal based pcie
> > > > "v" + "pci" is quite a misleading term, maybe just versal-pci?
> > > 
> > > Hi Yilun,
> > > 
> > > I sent the V2 patch and refactored the driver as versal-pci now.
> > > One more thing that I kept in V2 was the firmware_upload. I forgot to
> > > mention that I'd love to switch to the newly proposed interface once
> > > it is ready. I saw the proposal was now as config_fs and it was not merged
> > 
> > Good to know that.
> > 
> > I didn't start reviewing the v2 yet. But one thing is that now the
> > versal-pci FPGA manager has no user because of the ongoing uAPI, so
> > cannot be merged, and I won't pay much effort on this series for now.
> 
> Hi Yilun,
> 
> Can we add this as TODO in the future when the uAPI solution is ready to
> switch? We spent some time to refactor the driver and address most of your

Sorry, generally kernel won't merge code that has no user, which means
the code are not tested.

> comments in the V2. Hopefully, can you please start reviewing the fpga_mgr
> and other driver code?

Yes, I can review the code when possible. But will not merge it.

> 
> We'd think that we use the firmware_upload for 1st approach and start
> letting user use this driver.
> 
> We definitely will switch to the new uAPI as soon as it is ready in the
> linux fpga driver. But we'd not like this uAPI holds up everything we
> already spent times.

If you want speed up, then collaborate to develop/review the dependent
patchset, that's how the community works. I actually don't want to be
the only reviewer in this mail list, and others just send patches.

Thanks,
Yilun

