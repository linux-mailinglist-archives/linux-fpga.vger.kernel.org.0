Return-Path: <linux-fpga+bounces-1450-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 89419C55E2E
	for <lists+linux-fpga@lfdr.de>; Thu, 13 Nov 2025 07:09:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 353FF4E19E7
	for <lists+linux-fpga@lfdr.de>; Thu, 13 Nov 2025 06:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 880E53161AA;
	Thu, 13 Nov 2025 06:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jr5bz9HH"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2804C26FA6E;
	Thu, 13 Nov 2025 06:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763014187; cv=none; b=l8D+CLI+cZ+nbZLwn14ULuDxNaN7XhIcdE5XzPjMIKfDsr1P3oXMcNSIEq3CHSAO3zWoK+k6WUqWDEREg5Tp+1Car/Web8Nu1CtjSKjKIi0TywuD3Q1L3e7hXb/BFvHc5E5otKFGUSXLVf8yOyc5lI4yuwItGzAbJdzD0TL8DsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763014187; c=relaxed/simple;
	bh=BVBILKlgJCkKXtdw4DxgNMURT+3UtG3hbWGyoVwug48=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B/JbAwQIKzHsTHpa+skHwtkzAzgY642ONjljR9S7XbM6q/5hBhLb7H7u4uPnIOjr1IgReYcRKJr/kTffYeLceCfkbvC5I04bPmpGGimlx7jDlOiVCDeeIsMXkg6sEWRuOdyPgMixpU74Rqo240PKksblgOCw+B1lNasBN9MsFFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jr5bz9HH; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763014185; x=1794550185;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BVBILKlgJCkKXtdw4DxgNMURT+3UtG3hbWGyoVwug48=;
  b=Jr5bz9HHZ9/DcFM7xBaC5Lm/iBYQPtyznDjZs0LgyuuhxHWix7tebweU
   72766WrpnO6SC7E1AAbcpb7E29evZ0q4ksE2wodfqggcuQv6Z9Hg5/EmW
   7XMO0DE4U5XiRqPO5goeHdQUQLzc1f1ccLx3AmimrGq21QkjgfXN3+/5e
   lV8ma3yIlMvi9UtJShcpHGKAAS0qCV9A+64ulo43OQ+mLXgcJQyeLHxL1
   4BmdkyR3RjdyaaNIjnN2vomCCdk/4R7pQMdTGmYv42iL9jac9O7BfHOya
   5MKjNOG7vMxhD9nWnTTtro38L+SVbkTozBUmvSrJr12622D9YFWCDYZ5Z
   w==;
X-CSE-ConnectionGUID: 43I/n0NcQjWQeFTdHy+9jA==
X-CSE-MsgGUID: 86VKSk40R92grM1vnUVbKA==
X-IronPort-AV: E=McAfee;i="6800,10657,11611"; a="52649697"
X-IronPort-AV: E=Sophos;i="6.19,301,1754982000"; 
   d="scan'208";a="52649697"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2025 22:09:44 -0800
X-CSE-ConnectionGUID: tJMXzMUWQu2wJc7dMTEskQ==
X-CSE-MsgGUID: mKflDs6FQKaVpm8tNy3g/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,301,1754982000"; 
   d="scan'208";a="188673776"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa006.jf.intel.com with ESMTP; 12 Nov 2025 22:09:41 -0800
Date: Thu, 13 Nov 2025 13:55:10 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
Cc: Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>, Dinh Nguyen <dinguyen@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Mahesh Rao <mahesh.rao@altera.com>,
	Ho Yin <adrian.ho.yin.ng@altera.com>,
	Niravkumar L Rabara <nirav.rabara@altera.com>,
	linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/2] arm64: dts: agilex5: add fpga-region and fpga-mgr
 nodes
Message-ID: <aRVyvjCny/I/rElC@yilunxu-OptiPlex-7050>
References: <cover.1763008269.git.khairul.anuar.romli@altera.com>
 <9a4ce6b2470328b9326402a2f00ff285be1793c3.1763008269.git.khairul.anuar.romli@altera.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a4ce6b2470328b9326402a2f00ff285be1793c3.1763008269.git.khairul.anuar.romli@altera.com>

On Thu, Nov 13, 2025 at 12:43:56PM +0800, Khairul Anuar Romli wrote:
> The Intel Agilex 5 SoC contains a programmable FPGA region that requires
> proper device tree description to enable FPGA manager support in the Linux
> kernel. Without the 'fpga-region' and 'fpga-mgr' nodes, the kernel cannot
> detect or manage the FPGA hardware correctly.
> 
> This patch adds a 'fpga-region' node with compatible = "fpga-region", along
> with appropriate #address-cells and #size-cells properties, to describe the
> FPGA region layout.
> 
> Also defines specific compatible string for Agilex5 and add Agilex string
> as fallback for stratix10-soc driver initialization.
> 
> Signed-off-by: Khairul Anuar Romli <khairul.anuar.romli@altera.com>

Reviewed-by: Xu Yilun <yilun.xu@intel.com>

