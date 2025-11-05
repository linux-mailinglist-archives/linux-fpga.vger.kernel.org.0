Return-Path: <linux-fpga+bounces-1412-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D3C58C33B9E
	for <lists+linux-fpga@lfdr.de>; Wed, 05 Nov 2025 03:01:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63C1A189616C
	for <lists+linux-fpga@lfdr.de>; Wed,  5 Nov 2025 02:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41CB9156C40;
	Wed,  5 Nov 2025 02:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YBsLzCBT"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7510313D891;
	Wed,  5 Nov 2025 02:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762308080; cv=none; b=buNVg0LSMvyMEWK8LllUts6IhLuuGcDSAKLT1fZb5992RrWMI5fwNJ9fBz2vVWHy3A1r9kdeGyPj7p5u3Y0g7/vmdHSTqn/6KOSID+MoMxfyBSOmQMzCeFo7A0hwHkd1MHLzwJjwuxYOuxgCcwPCc2yvSF2/5AXUKPN67MGpgRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762308080; c=relaxed/simple;
	bh=TzCnMsVJgRwM/eGBU5/aQEhc83IJDbUe1+6PYOL4AqM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cpun/foxvjJQgUmasyycA2kEGqOR8RdXHbF3guOhheMV6eBIGHojpdQJVuxnNWNJ1eKBA65tfyxTJWQndgb63LBtYAHTBL2EJZHKPvh2qgit7sjC8P9ea2WUtQggnJRcSayEKRraLKK0gwUem3+5uD3dVNfKybZto5KQDFHwbrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YBsLzCBT; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762308079; x=1793844079;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TzCnMsVJgRwM/eGBU5/aQEhc83IJDbUe1+6PYOL4AqM=;
  b=YBsLzCBTgD9aQyYrMeRVRa9aFyLKCbpjnnASIGKWq4kEsyhdj2EYGL3x
   H//LT3P2AzW2FkSo0aKHph8sAhhyAcnJECqJSsxqVQC289Wy8hdnRYVO/
   MRQrV75mwYRTxLmEy9EOP882F+UTtDD/VCuNNpD4plAx0H963AXkWvbwn
   BiutLwkT0spsmWINindlx0uxJMX5q6pvRbABmLWnFYg4mru+YxrXtyhqi
   /ipEhviz6C4Es7v0im52pvOmf50cpnk5//VR02fQECHbQAxLeXeh7oiIJ
   mhi/VbGscXmDd1K3Xvl3keHNwwcxSsMxyMjALr9xCDmlSVTXDUwuDZbxU
   g==;
X-CSE-ConnectionGUID: eo/CLSOQTLK6MkwpOwaqfg==
X-CSE-MsgGUID: H4td/KJTS8KTj2IddKUZug==
X-IronPort-AV: E=McAfee;i="6800,10657,11603"; a="64514484"
X-IronPort-AV: E=Sophos;i="6.19,280,1754982000"; 
   d="scan'208";a="64514484"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2025 18:01:17 -0800
X-CSE-ConnectionGUID: 9AWY8PmdT8SWhfX0VWBW/A==
X-CSE-MsgGUID: Hhui5basQSG7nISfC/AAUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,280,1754982000"; 
   d="scan'208";a="210811249"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa002.fm.intel.com with ESMTP; 04 Nov 2025 18:01:15 -0800
Date: Wed, 5 Nov 2025 09:47:08 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Ian Abbott <abbotti@mev.co.uk>
Cc: linux-fpga@vger.kernel.org, Moritz Fischer <mdf@kernel.org>,
	Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] fpga: Add dummy definitions of API functions
Message-ID: <aQqsnFl8uakMAsH+@yilunxu-OptiPlex-7050>
References: <20251104153013.154463-1-abbotti@mev.co.uk>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251104153013.154463-1-abbotti@mev.co.uk>

On Tue, Nov 04, 2025 at 03:27:01PM +0000, Ian Abbott wrote:
> Add dummy definitions of the FPGA API functions for build testing
> 
> 1) fpga: altera-pr-ip: Add dummy definitions of API functions
> 2) fpga: bridge: Add dummy definitions of API functions
> 3) fpga: manager: Add dummy definitions of API functions
> 4) fpga: region: Add dummy definitions of API functions

Sorry I don't get the idea. Why should someone use FPGA APIs without
selecting CONIG_FPGA_XXX? Better make the changes along with the use
case patches.

Thanks,
Yilun

> 
>  include/linux/fpga/altera-pr-ip-core.h |  8 ++-
>  include/linux/fpga/fpga-bridge.h       | 75 ++++++++++++++++++++++++++-
>  include/linux/fpga/fpga-mgr.h          | 95 +++++++++++++++++++++++++++++++---
>  include/linux/fpga/fpga-region.h       | 44 ++++++++++++++--
>  4 files changed, 207 insertions(+), 15 deletions(-)
> 

