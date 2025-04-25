Return-Path: <linux-fpga+bounces-1174-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B78E7A9BD0D
	for <lists+linux-fpga@lfdr.de>; Fri, 25 Apr 2025 04:49:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E9264C00B8
	for <lists+linux-fpga@lfdr.de>; Fri, 25 Apr 2025 02:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAF28149C4D;
	Fri, 25 Apr 2025 02:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fa8wa+o2"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD0915278E;
	Fri, 25 Apr 2025 02:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745549373; cv=none; b=ZmLNtPzC3cchjmjath9uxbdedNEs1WVU0PHq4xllJD2Icymp5B71YjUZCzp7dScvWdJupbhQ882z72h9k3gojW1ri3OQAg5OAS2Iips5TuktlUaRVFKHXcYKS9+SI4jrBYyaRAfU+byFtIyPEPZgWqb+2ieQy1xZb6TAXxIh2rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745549373; c=relaxed/simple;
	bh=8E8IPQ8U3c2ao7zZDmLXSVYieew5+uk0JR1rHWGzBoU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=axRa8CQ74ea6qSMbILLOFGY98KOVk5J0EPSH6w38+q99RNenYf1OoZNb5wIhC95AdHIS7WmheShXASovAut3ILcbtUhAjrNdd/x59E0MaQ1hFrca02psqppeCxFvssrWi3YhdUy2DFI1jZpmBgIUHXyDgi7+lOd1GRUbdRVnYaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fa8wa+o2; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745549372; x=1777085372;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8E8IPQ8U3c2ao7zZDmLXSVYieew5+uk0JR1rHWGzBoU=;
  b=fa8wa+o2th3yWcR1gUXuRF1UU1g8VTmw8x8wuWViRLNikc+SKK6+m1Pt
   9WyEv/TetFqWtg9F/qrVYPYAHlSeGIWGm0I5e5YL2bKKxo+mOuqUF9/WL
   dvWFFQerF/5ou0q8Ky/wYfupBiQEuwCnpeRDPhCq+nbuyK3FoQCO3PUjR
   Vo5OyzE0z729MSlJoHZLheDuzLn4c/lnr6jl8pFm+bT0MwjW2wOalEqAQ
   4psBmXTzeHubVK6dBL8QUr4LZdiNHM9YDtM3uXTP//xmMHQDGaSGWnadN
   2tqkowWOABcfeuXZnaHn+zxcOPbWHOUwirKCm8Y/dObhQHxz0dWw/hs0P
   A==;
X-CSE-ConnectionGUID: xb3NQ+f2TVSqrDoQV6Q1Jw==
X-CSE-MsgGUID: QWTD2tL9QdiEUuwBPu6fxA==
X-IronPort-AV: E=McAfee;i="6700,10204,11413"; a="47338898"
X-IronPort-AV: E=Sophos;i="6.15,237,1739865600"; 
   d="scan'208";a="47338898"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2025 19:49:31 -0700
X-CSE-ConnectionGUID: mpvrp5zDSty4AMy8tcCmIQ==
X-CSE-MsgGUID: yy+q4g9SQBaoBD2IoB/oLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,237,1739865600"; 
   d="scan'208";a="133769368"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa008.jf.intel.com with ESMTP; 24 Apr 2025 19:49:28 -0700
Date: Fri, 25 Apr 2025 10:44:51 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: "Gerlach, Matthew" <matthew.gerlach@altera.com>
Cc: Peter Colberg <peter.colberg@altera.com>, Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
	linux-fpga@vger.kernel.org, Peter Colberg <peter@colberg.org>
Subject: Re: [PATCH] fpga: m10bmc-sec: change contact for secure update driver
Message-ID: <aAr3I65zkNDu//il@yilunxu-OptiPlex-7050>
References: <20250317210136.72816-1-peter.colberg@altera.com>
 <2b218680-ea43-43af-96a8-33f2609510f5@altera.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2b218680-ea43-43af-96a8-33f2609510f5@altera.com>

On Mon, Mar 17, 2025 at 03:34:46PM -0700, Gerlach, Matthew wrote:
> 
> On 3/17/2025 2:01 PM, Peter Colberg wrote:
> > Change the maintainer for the Intel MAX10 BMC Secure Update driver from
> > Peter Colberg to Matthew Gerlach and update the ABI documentation.
> > 
> > Signed-off-by: Peter Colberg <peter.colberg@altera.com>
> Acked-by: Matthew Gerlach <matthew.gerlach@altera.com>

Acked-by: Xu Yilun <yilun.xu@intel.com>

Applied to for-next.

