Return-Path: <linux-fpga+bounces-977-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A38ED9EAB81
	for <lists+linux-fpga@lfdr.de>; Tue, 10 Dec 2024 10:11:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF9F2188BB2D
	for <lists+linux-fpga@lfdr.de>; Tue, 10 Dec 2024 09:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81126231CA0;
	Tue, 10 Dec 2024 09:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MFNrg76K"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8435231CA8;
	Tue, 10 Dec 2024 09:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733821867; cv=none; b=OE6dJTETIza1Lps1z8xJvQv6eT2LXc9jyGj21m0JCGPY4/a3Erg7TOyE0yOWi1bsEgYYC8GeP4HdMBaVfwW3aT/6X5Jkr9Z+131MjykfnvmjVHdQ9dh+REVezT/1xEAHhy2iQLS9Wc070mO8byAb5OYvsTS48mHl6yC5329hRO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733821867; c=relaxed/simple;
	bh=K7q8ur2I754XLDpe3veQv4i82Utv3gqUbaOjkBdxSkw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CSxicST/UaBQixjBvTiP0PDdYv4g8deYW924LVyPUhs//5FXoIqLS4EC47DEXNBp/OQK3ncukIsPFXBc9u55XXtys/BOpPP6WX/hfGj3lBR1lLvkG2oAe8bNq6WeAjUaRK6qt/HR0Blww9PaDq85gpl+15IPFMnpuxdDyAxMlX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MFNrg76K; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733821866; x=1765357866;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=K7q8ur2I754XLDpe3veQv4i82Utv3gqUbaOjkBdxSkw=;
  b=MFNrg76KsgSjJgVJNcE2Sw69IuoldSfnRIWlfRNwXfcE/xvoExq2A/2c
   ugHBDvQAaTtIjdQmTGJzqsCGkI/UulHzbul0l7CW9JUYd9FRG1tlRcATx
   4n6padMMlzjXLT+wcmR2xv0BwjrMY2VfQLbksZSjYSV8bKO8+7tGVXjax
   OUbGjFhid/+uz9I6KxfBrgnAu0zFZMuSa3Vr+8T+FRe2yDZEtsNWPRuEC
   mLkJdAII11yIbZJL3/hgBtus22+A7K5L8dPUmHSlW7NhFuOdk9JS1QuyY
   Hjpgzpl9QyT8/DmCMHVCGaq9iuay0d648jOgi7lg1nPEVpEilTZ2aXWx4
   w==;
X-CSE-ConnectionGUID: aExNAmxeTuOe6r8DhSYQwA==
X-CSE-MsgGUID: Xo+G+aidRWWAPYu/cCvEvA==
X-IronPort-AV: E=McAfee;i="6700,10204,11281"; a="33491110"
X-IronPort-AV: E=Sophos;i="6.12,222,1728975600"; 
   d="scan'208";a="33491110"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2024 01:11:05 -0800
X-CSE-ConnectionGUID: vwV80PtXQ3usQcvcxS0IeQ==
X-CSE-MsgGUID: rHabBjFJSyGMTYwOEGo22Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,222,1728975600"; 
   d="scan'208";a="95177582"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa007.fm.intel.com with ESMTP; 10 Dec 2024 01:10:54 -0800
Date: Tue, 10 Dec 2024 17:07:39 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Peter Colberg <peter.colberg@intel.com>
Cc: Wu Hao <hao.wu@intel.com>, Tom Rix <trix@redhat.com>,
	Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>,
	linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
	Russ Weight <russ.weight@linux.dev>,
	Marco Pagani <marpagan@redhat.com>,
	Matthew Gerlach <matthew.gerlach@linux.intel.com>,
	Basheer Ahmed Muddebihal <basheer.ahmed.muddebihal@linux.intel.com>
Subject: Re: [PATCH v5 00/18] fpga: dfl: fix kernel warning on port
 release/assign for SRIOV
Message-ID: <Z1gE2+q5Y766OHZt@yilunxu-OptiPlex-7050>
References: <20241120011035.230574-1-peter.colberg@intel.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241120011035.230574-1-peter.colberg@intel.com>

On Tue, Nov 19, 2024 at 08:10:16PM -0500, Peter Colberg wrote:
> With the Intel FPGA PAC D5005, DFL ports are registered as platform
> devices in PF mode. The port device must be removed from the host when
> the user wants to configure the port as a VF for use by a user-space
> driver, e.g., for pass-through to a virtual machine. The FME device
> ioctls DFL_FPGA_FME_PORT_RELEASE/ASSIGN are assigned for this purpose.
> 
> In the previous implementation, the port platform device is not
> completely destroyed on port release: it is removed from the system by
> platform_device_del(), but the platform device instance is retained.
> When DFL_FPGA_FME_PORT_ASSIGN is called, the platform device is added
> back with platform_device_add(), which conflicts with this comment of
> device_add(): "Do not call this routine more than once for any device
> structure", and would previously cause a kernel warning at runtime.
> 
> This patch completely unregisters the port platform device on release
> and registers a new device on assign. But the main work is to remove
> the dependency on struct dfl_feature_platform_data for many internal DFL
> APIs. This structure holds many DFL enumeration infos for feature
> devices. Many DFL APIs are expected to work with these infos even when
> the port platform device is unregistered. But after this change, the
> platform_data will be freed on port release. Hence this patch introduces
> a new structure dfl_feature_dev_data, which acts similarly to the
> previous dfl_feature_platform_data. dfl_feature_platform_data then only
> needs a pointer to dfl_feature_dev_data to query DFL enumeration infos.
> 
> Link: https://lore.kernel.org/all/DM6PR11MB3819F9CCD0A6126B55BCB47685FB9@DM6PR11MB3819.namprd11.prod.outlook.com/T/#t
> Link: https://patchwork.kernel.org/project/linux-fpga/cover/20240409233942.828440-1-peter.colberg@intel.com/
> Link: https://patchwork.kernel.org/project/linux-fpga/cover/20240919203430.1278067-1-peter.colberg@intel.com/
> Link: https://patchwork.kernel.org/project/linux-fpga/cover/20241025223714.394533-1-peter.colberg@intel.com/

Applied this series to for-next.

Thanks,
Yilun

