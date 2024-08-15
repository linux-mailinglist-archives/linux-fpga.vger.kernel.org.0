Return-Path: <linux-fpga+bounces-592-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41979952818
	for <lists+linux-fpga@lfdr.de>; Thu, 15 Aug 2024 05:04:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74C181C218F2
	for <lists+linux-fpga@lfdr.de>; Thu, 15 Aug 2024 03:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAB87208B0;
	Thu, 15 Aug 2024 03:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CH0HhV0z"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB200C144;
	Thu, 15 Aug 2024 03:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723691049; cv=none; b=Xz1F8J5mqle3FbbG4bJzPOJs7xUR5xCVRAXZkQxe/beQx8SQLwbJc+6ssEO6EtzvhQiz/HGPv/mRTGwPdq8D+e4AkCjhLm8oRQV0hOJrVDxuKW/pnNG7dabPiFK/LZJxum3OEiP0FENyNBVeUyDyj8Xaurr9rHu1iQCMBUj2wrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723691049; c=relaxed/simple;
	bh=tEQ232Q9V7kx9F54SNAa+UawZRUkDcFU0hANE+CDX8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gjG57rDQXsP3wxe9tIt+Bv62bKmrEMNOm1IZRUo4ga1bkA8YX53RPP5j8PeklTg/o6GYwqEcuztPrEBsF2vVwvzJ45TKzVKnTYrNR+IZN/9RBHG7Bss3XPacOWukQ2ZimSvE8ATvD+DnP9zXTDoVSJEqSUQ0G3drNZCSmtkJg+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CH0HhV0z; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723691048; x=1755227048;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tEQ232Q9V7kx9F54SNAa+UawZRUkDcFU0hANE+CDX8g=;
  b=CH0HhV0z948JCANAuQD1xv+Ap1nY3fFdiK3y6jTk++ic54JkvJIVJHRo
   VHcVewj3qlebMgsLTztZMB3T+sIZHq1AhXy7zZ/hqaXsVj1rDKDtOq0Ft
   3tjTV759+1JzYnHrAt3b5vUEvlwIjqdjU7C86ql08oIOoeWitH5/TFtg3
   U+jpYc+RKczIDi4kf/L/8SCSHVRxcRoFgORqRnn0c0jQVefFQiNKu+1r1
   Z7QpB8uQbOFSUG+b+MasEPuPkp2+l2P6GqXIV6gGINRcDdoYIoduTwH5r
   8UFQVcjyzLveCtWaeq8GwZx0Oy8Ex2tESnoa6mqAuwRUpS4zlMpIRDkkI
   g==;
X-CSE-ConnectionGUID: uB3chFQlTt+68Kpm536SlA==
X-CSE-MsgGUID: glwR3SNOQDiUWlaaBJc+fA==
X-IronPort-AV: E=McAfee;i="6700,10204,11164"; a="21810298"
X-IronPort-AV: E=Sophos;i="6.10,147,1719903600"; 
   d="scan'208";a="21810298"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2024 20:04:07 -0700
X-CSE-ConnectionGUID: Ni9/2nzUTsKBg+TeFvgzCA==
X-CSE-MsgGUID: aCiM9HXWQ26YGIYRu1b/Gg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,147,1719903600"; 
   d="scan'208";a="59801420"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa007.jf.intel.com with ESMTP; 14 Aug 2024 20:04:04 -0700
Date: Thu, 15 Aug 2024 11:01:53 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Marco Pagani <marpagan@redhat.com>
Cc: Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
	Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
	linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org
Subject: Re: [PATCH 0/3] Simplify and improve fpga test suites using deferred
 actions
Message-ID: <Zr1vocN2TrepUcMY@yilunxu-OptiPlex-7050>
References: <20240725125031.308195-1-marpagan@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240725125031.308195-1-marpagan@redhat.com>

On Thu, Jul 25, 2024 at 02:50:28PM +0200, Marco Pagani wrote:
> Use deferred actions to simplify fpga test suites and avoid potential
> memory leaks when test cases fail. Deferred actions are executed when a
> test is completed either successfully or unsuccessfully (e.g., due to a
> failed assertion).
> 
> Marco Pagani (3):
>   Simplify and improve the fpga manager test suite using deferred
>     actions
>   Simplify and improve the fpga bridge test suite using deferred actions
>   Simplify and improve the fpga region test suite using deferred actions

Don't forget the prefix in shortlog. I added "fpga: " for them.

Others look good to me.

Acked-by: Xu Yilun <yilun.xu@intel.com>

Applied this series to for-next.

Thanks,
Yilun

> 
>  drivers/fpga/tests/fpga-bridge-test.c | 25 +++++++---------
>  drivers/fpga/tests/fpga-mgr-test.c    | 28 +++++++++++-------
>  drivers/fpga/tests/fpga-region-test.c | 41 ++++++++++++++++-----------
>  3 files changed, 52 insertions(+), 42 deletions(-)
> 
> 
> base-commit: 3a0fa8e97d3024de199634667900b6a90bbe43d0
> -- 
> 2.45.2
> 
> 

