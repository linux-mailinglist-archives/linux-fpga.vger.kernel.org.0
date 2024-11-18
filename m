Return-Path: <linux-fpga+bounces-938-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 545FA9D1400
	for <lists+linux-fpga@lfdr.de>; Mon, 18 Nov 2024 16:07:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B13F2848FA
	for <lists+linux-fpga@lfdr.de>; Mon, 18 Nov 2024 15:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C7AE1B2190;
	Mon, 18 Nov 2024 15:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PgsEHG+m"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD6711AF0D9;
	Mon, 18 Nov 2024 15:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731942275; cv=none; b=CzAs+cSx0RyidEr6mghs1fKHWW3PnHVjtR8+CvySG4gFM0V7g21rAIq7x4Ce1WzhlrRsb6WH2gGuErht4QmMeGKGqPEeY3QkNYV0qCeVnT9ZOMWT+tbrMWywDhriu8h8J65oqop8wjPeakX/CnFZxxnHvapGPf6Fugy0I6DBPZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731942275; c=relaxed/simple;
	bh=AxrAbrUfDjsuOht0iKt6S7v4BepfaPNcGuKPqMfKkZg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VrPS3BRxf8Uqw/gw9Gf+i1v9qyHs24rpbE3iQDiezbx89w+zKLkPBYkOganoTYpd+4QixCTY3592BYy8KIt09dWHxPPfjsMISj6MqdklmYfKJ2o2lKz/ZBf+ROHRVCgbEJMKjTNjHPpdXF6JLmSFK18mOn2S/UrqxDAfHO9iris=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PgsEHG+m; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731942274; x=1763478274;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AxrAbrUfDjsuOht0iKt6S7v4BepfaPNcGuKPqMfKkZg=;
  b=PgsEHG+m3khWB4yy1QkujqGTXjFRWKM/dusN4LJruXFP2at1ngCh7nrW
   yVD5nJmgQkU3cyXPbV0W2DFV/1O9okwfE0dnswCRQhhgNsGwjmHQPGUwn
   mpLASu3GQOncU8ZzMD66UvlmxUzvtDXNBhvMSLneiQS1VU5dlsyd0POD5
   NSblbfyH7UvGzk0cFyq9Vy5BzSb8sqPP24uTlrirWT0KTTW1TdkR5anNt
   z/18RrnDXaCgAKPNwVuKP30RknmZFIdyUeIkh1SU0FaQC4UYwpeOVaF5v
   mf/oKV0tRUokaznUnxtiDarge5Mrzt03Om+IsEP7zxbq5IQuObyIeyGTQ
   g==;
X-CSE-ConnectionGUID: Br9c0obdQqGjuJyz0qgtWA==
X-CSE-MsgGUID: OAhmYjtyRsuco5nJLfOC4g==
X-IronPort-AV: E=McAfee;i="6700,10204,11260"; a="54398718"
X-IronPort-AV: E=Sophos;i="6.12,164,1728975600"; 
   d="scan'208";a="54398718"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2024 07:04:28 -0800
X-CSE-ConnectionGUID: U0Ny3rg7Q7qMSFJAtiUo+Q==
X-CSE-MsgGUID: Milcz6sWTiy9plKF+7eC2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,164,1728975600"; 
   d="scan'208";a="89170902"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa010.jf.intel.com with ESMTP; 18 Nov 2024 07:04:25 -0800
Date: Mon, 18 Nov 2024 23:01:32 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Peter Colberg <peter.colberg@intel.com>
Cc: Wu Hao <hao.wu@intel.com>, Tom Rix <trix@redhat.com>,
	Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>,
	linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
	Russ Weight <russ.weight@linux.dev>,
	Marco Pagani <marpagan@redhat.com>,
	Matthew Gerlach <matthew.gerlach@linux.intel.com>,
	Basheer Ahmed Muddebihal <basheer.ahmed.muddebihal@linux.intel.com>
Subject: Re: [PATCH v4 18/19] fpga: dfl: drop unneeded get_device() and
 put_device() of feature device
Message-ID: <ZztWzI/AYv9A8Pla@yilunxu-OptiPlex-7050>
References: <20241025223714.394533-1-peter.colberg@intel.com>
 <20241025223714.394533-19-peter.colberg@intel.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241025223714.394533-19-peter.colberg@intel.com>

On Fri, Oct 25, 2024 at 06:37:13PM -0400, Peter Colberg wrote:
> The feature device data was originally stored as platform data, hence
> the memory allocation was tied to the lifetime of the feature device.

Good to know the reason.

Thanks,
Yilun

