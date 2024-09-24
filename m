Return-Path: <linux-fpga+bounces-731-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B3DC983D27
	for <lists+linux-fpga@lfdr.de>; Tue, 24 Sep 2024 08:31:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0706B21FC9
	for <lists+linux-fpga@lfdr.de>; Tue, 24 Sep 2024 06:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4A229479;
	Tue, 24 Sep 2024 06:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RKPgnC4N"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1021323D7;
	Tue, 24 Sep 2024 06:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727159460; cv=none; b=uEse7ZjsXwYlVNwoFowBPkgw30m6LCh4kttL42O0nrVPFjJqLkuu0RuUp1b+v1kXJI3q1DxZHgoPciJy53IMuEm6/YwLr6+UJgT4KCGd+hmravucfahQNaJpq+muzEWNaWgDNcG83gNSmVuq9qQpZuSOiG6HpusnVmxCdn5qbhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727159460; c=relaxed/simple;
	bh=E6fzYzwT3BCslLledFKYuahBn2wEZFrz6E5UoYeg1xw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TJ0jTJonXrffMYiD+45AWatTEK/zCQ4fQmR2iXXD/OGN6Gkq9xASjxSljwgCtCS0uOyiZzCrWoABOoR+TeSBXOGAC51e5lFSiHw7J1xRPM2taKDkqfB3dU3g5faFJUAB16UTXvVCj32vJ5e6kEpDHK+fgCdNKoqrUv2k3s1WVvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RKPgnC4N; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727159459; x=1758695459;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=E6fzYzwT3BCslLledFKYuahBn2wEZFrz6E5UoYeg1xw=;
  b=RKPgnC4NkHuVrumB+azGxHnfP7eR4sZqZ2oJMVt76HsZWykmjo4+iva+
   AkYr87SNivN2Ek1LbES1TQEq/ouUpycSbic8NwszHsQxCeYBKvHfxE/79
   m/o17tNH1Vew4Y6DRuw6Mm/oHOJClf8fF8Gp3pzjpkX3Dz89/tRWtTDSh
   nnp7OtL9sGmzpzqmhUzr/ycJHyM6SUkMQIjyZUL9K1RME6TywlA7uzg4z
   G2oZE9Nv4dNo1BxIojif9WaQZ9QkmVj6zf7cMEw3qGr5Szdtq2ZbnfbUC
   r7/2DdbwWy0aDmtp4OlcV8KGNaeiwHDdjcKCT9Wcmk1089NNGA8HyBgS8
   w==;
X-CSE-ConnectionGUID: UCoIA5BgS++sNdaPMYPMbg==
X-CSE-MsgGUID: o83cCnavQOiAhltcUgjPLg==
X-IronPort-AV: E=McAfee;i="6700,10204,11204"; a="26000831"
X-IronPort-AV: E=Sophos;i="6.10,253,1719903600"; 
   d="scan'208";a="26000831"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2024 23:30:58 -0700
X-CSE-ConnectionGUID: Mn6uhWiCT/CLa9Gft5B4Dg==
X-CSE-MsgGUID: 6kNU3YgsTsmTQjj4Nz2Ztw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,253,1719903600"; 
   d="scan'208";a="71748290"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa007.jf.intel.com with ESMTP; 23 Sep 2024 23:30:56 -0700
Date: Tue, 24 Sep 2024 14:28:00 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Peter Colberg <peter.colberg@intel.com>
Cc: Wu Hao <hao.wu@intel.com>, Tom Rix <trix@redhat.com>,
	Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>,
	linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
	Russ Weight <russ.weight@linux.dev>,
	Marco Pagani <marpagan@redhat.com>,
	Matthew Gerlach <matthew.gerlach@linux.intel.com>
Subject: Re: [PATCH v3 2/9] fpga: dfl: omit unneeded null pointer check from
 {afu,fme}_open()
Message-ID: <ZvJb8HhT+5ArWDsL@yilunxu-OptiPlex-7050>
References: <20240919203430.1278067-1-peter.colberg@intel.com>
 <20240919203430.1278067-3-peter.colberg@intel.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240919203430.1278067-3-peter.colberg@intel.com>

On Thu, Sep 19, 2024 at 04:34:23PM -0400, Peter Colberg wrote:
> The feature platform device is guaranteed to have an associated platform
> data. Refactor dfl_fpga_inode_to_feature_dev_data() to directly return
> the platform data and retrieve the device from the data.

The code is good. But please elaborate on the purpose of these
intermediate change.

Thanks,
Yilun

