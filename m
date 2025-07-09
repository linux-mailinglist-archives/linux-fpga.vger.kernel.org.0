Return-Path: <linux-fpga+bounces-1279-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41FB9AFDFF0
	for <lists+linux-fpga@lfdr.de>; Wed,  9 Jul 2025 08:29:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F4071BC0C4F
	for <lists+linux-fpga@lfdr.de>; Wed,  9 Jul 2025 06:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A622926C3A6;
	Wed,  9 Jul 2025 06:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IbjmRnP8"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD98F26C385;
	Wed,  9 Jul 2025 06:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752042565; cv=none; b=ZBk8B38rOeJ6/nY4aEPQfbFE18aSQO42YOQrZof/RGfMKh9ux3LJk0Pd7hVJ7sUyq2Vw+uxklIW+Dvc1LKjS7niobXEnwHsWdZC6tIoPZlRW9TmZQIS2lcaXezUS5FOycs30VTzFO6tU8yW60z/md3lRJKjzWmG9aYdWL4sDu/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752042565; c=relaxed/simple;
	bh=KjKlezOc87/x+FrYSWyzyuQtDcuJRRffC14mJhcaCuY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t+TtYhi7xZ8OD3JIuKFddbJIwYTVXevOkHuCcg6KC3mUsjdtfi7A39Q+0LY5LwzUaZSgeQAK2abWzXL2sV5rROnziicr0N4PJEDn0Nx6qWzBhRZ4Rkjg19xtBS7qYLIUuxM6962sa6PCGx/HgaPPWfyAFnLekD1DZZOqJG0SEFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IbjmRnP8; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752042564; x=1783578564;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=KjKlezOc87/x+FrYSWyzyuQtDcuJRRffC14mJhcaCuY=;
  b=IbjmRnP847X8bCgw3f4A6Pkk+g9aJEuD96O/BlKbUDpC073CEOex1Ys1
   tksWtqIbk4R1LFRmQCZsQFOJZNLj7EGyZqgJXgTwWZhkPLnyDWx5Vnkh3
   RQVw07Ymj9igS013SDpKdo+ewwthGDjdjVhuSbZFoCoha1uZHY/fWfkh6
   aQhgSysLCv+Mf9vxVy9DCqwg/ArzrElf9LX98nsBrZNVix6UfqKvYEke/
   jIN+Jy1zNGRuxr0KtOwCBpv/mBRLINtqJxl6viVibqsgZGKv2kSvfEsSO
   U+QzRM/HELr0zH5qvpCFpxicWBfHG3YJBRu8JgkmXUpQclUuHCljaxuTu
   g==;
X-CSE-ConnectionGUID: qhzJjJvDTyiJUYGtl1hm/A==
X-CSE-MsgGUID: xjsgLRikRBaScAD5winWLw==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="54435349"
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="54435349"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 23:29:23 -0700
X-CSE-ConnectionGUID: NHNnpI1PSQizcvA19THisg==
X-CSE-MsgGUID: q/EM6XpLRR+UT0MEgoTXHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="186652707"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa001.fm.intel.com with ESMTP; 08 Jul 2025 23:29:20 -0700
Date: Wed, 9 Jul 2025 14:21:02 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: "Manne, Nava kishore" <nava.kishore.manne@amd.com>
Cc: "mdf@kernel.org" <mdf@kernel.org>,
	"hao.wu@intel.com" <hao.wu@intel.com>,
	"yilun.xu@intel.com" <yilun.xu@intel.com>,
	"trix@redhat.com" <trix@redhat.com>,
	"robh@kernel.org" <robh@kernel.org>,
	"saravanak@google.com" <saravanak@google.com>,
	"linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"git (AMD-Xilinx)" <git@amd.com>
Subject: Re: [RFC v3 1/1] fpga-region: Introduce ConfigFS interface for
 runtime FPGA configuration
Message-ID: <aG4KTuLExZCMw8rC@yilunxu-OptiPlex-7050>
References: <20250519033950.2669858-1-nava.kishore.manne@amd.com>
 <20250519033950.2669858-2-nava.kishore.manne@amd.com>
 <aDxrUD9YjnFkWy3M@yilunxu-OptiPlex-7050>
 <DS7PR12MB607015CAB2781E16A4EC110ECD74A@DS7PR12MB6070.namprd12.prod.outlook.com>
 <aEv48IZSinWjJgBt@yilunxu-OptiPlex-7050>
 <DS7PR12MB6070BC635C899C637EDE71F3CD7CA@DS7PR12MB6070.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DS7PR12MB6070BC635C899C637EDE71F3CD7CA@DS7PR12MB6070.namprd12.prod.outlook.com>

> I’ve implemented the FPGA Region ConfigFS interface with the following hierarchy:
> 
> /configfs
> └── fpga_regions             ← Registered via configfs_register_subsystem()
>       └── region0                ← Added using configfs_add_default_group()
>            └── my_image      ← Created via mkdir from userspace
>                 ├── firmware    ← Write firmware name here
>                 └── config        ← Trigger programming/unloading

Yes this is good to me.

> Observation:
> If configfs is not mounted before configfs_add_default_group() is invoked
> (e.g., when regions are registered early via base DTB), the path
> /configfs/fpga_regions/region0 does not appear in userspace,
> even though it’s properly initialized in the kernel.
> 
> This appears to be due to how default groups function.
> they require the configfs filesystem to be mounted prior to the group
> addition in order to be visible. As a result, the mount order becomes
> a strict dependency, which may affect or break early-boot FPGA flows
> where regions are created before configfs is available.

I don't have answer here. But IIUC you are describing some generic
problem of configfs_add_default_group(). According to configfs.rst,
subsystem is also a config_group so it doesn't make sense to me a
subsystem works but a default subgroup can't. Unless configfs people
have proper justification, your observation is a bug and should try to
fix it.

> 
> Proposal:
> Use configfs_register_subsystem(&region->cfg_subsys) for each FPGA region
> instead of relying on configfs_add_default_group().

This seems a workaround. I don't prefer we give up on it so early...

Thanks,
Yilun

> 
> This approach places each FPGA region directly under /configfs/region0,
> avoiding the timing issues associated with default groups.
> The interface becomes available as soon as configfs is mounted.
> regardless of when the region was registered
> (boot time via base DTB or dynamically via overlays).
> 
> New user hierarchy:
> /configfs
> └── region0              ← Region appears as its own root node
>       └── my_image   ← Created via mkdir from userspace
>            ├── firmware ← Write firmware name here
>            └── config     ← Trigger programming/unloading
> 
> Would like to know if this approach looks good, or if there are better
> suggestions to handle this scenario?
> 
> Regards,
> Navakishore.

