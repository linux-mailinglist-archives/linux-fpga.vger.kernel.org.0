Return-Path: <linux-fpga+bounces-1076-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 32FD1A4AA0C
	for <lists+linux-fpga@lfdr.de>; Sat,  1 Mar 2025 10:40:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F9F41896C93
	for <lists+linux-fpga@lfdr.de>; Sat,  1 Mar 2025 09:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D3031C245C;
	Sat,  1 Mar 2025 09:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LwQ4VI4v"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01BCA1E49F;
	Sat,  1 Mar 2025 09:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740822037; cv=none; b=mRJh457ybEBJDIVBAen/P4jf6jN72AlpP9kF0ra6PF9hgU4mSThZxpTDDnteMCBe4zeL3Af3AHMv97wAmk2xGoSlw8tYC0aW7slmxDmKLDWS7dS4yrVJ6JX3kU5bxMJSiQRnq1wbqq4cdQw95Yx4sEJauj0MUYuDpmkdSNZhUvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740822037; c=relaxed/simple;
	bh=PVtjqg7V6hVzbns1e2Ylsht4bjRtweQTzIYjEsn412g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D270k+l5guZwHkl8UpKsib/ZriEFWHi5Ibh8r9OciKvIRUFp4oBfDgLbG6uyvdYXdMoRcr7K1ZN+heSfqU7m5gyXx9HBRMv5Gtu/GDQM9fJhshcZvdCcsCPIWaRDAuL/94sENq0U7jb1LN68xp+tC95e8vapG0k4VDCtB1/Vo9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LwQ4VI4v; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740822036; x=1772358036;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PVtjqg7V6hVzbns1e2Ylsht4bjRtweQTzIYjEsn412g=;
  b=LwQ4VI4vzmrf6CSRe5EnqjNr2vjkYJudce+R4WTqaMSIj8hb037dVV41
   EE1HDHmqUvG7lQATMlmFIxTrmapJ4xicxQudeC40BDINdS9GGAdMV9FA3
   LJUV6IJgj/EqzeGRvylEGJRmAkux+NsmmLYUdMSpJMtBeWcLxRfrhuJYA
   1YKBJEA7iRVC1HUPt1VAABPCKcoJpMY6/g/aO5t5u4SChJhHkVYA0NekO
   97bXHRO0xEOuVbNp77FgrRlNRtsThc/ey67l4+GK8ll1+yLJaw2AMmXX8
   SB9P/2AE3HQPe+dd859lQfdkRddBe1JPavBN1iLm7i0aYexx/ifMOIN17
   w==;
X-CSE-ConnectionGUID: RsMkOppdRK+qmnwWO3I4/A==
X-CSE-MsgGUID: TEDj0L5nRPqmNTZeYDc6vg==
X-IronPort-AV: E=McAfee;i="6700,10204,11359"; a="59163365"
X-IronPort-AV: E=Sophos;i="6.13,325,1732608000"; 
   d="scan'208";a="59163365"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2025 01:40:36 -0800
X-CSE-ConnectionGUID: f++ZMiK+Q12LESZOQPk02w==
X-CSE-MsgGUID: +oSGjjpyTimK4Fx3bMtc8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,325,1732608000"; 
   d="scan'208";a="122163655"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa005.fm.intel.com with ESMTP; 01 Mar 2025 01:40:33 -0800
Date: Sat, 1 Mar 2025 17:38:34 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
	Xu Yilun <yilun.xu@intel.com>, Arnd Bergmann <arnd@arndb.de>,
	Tom Rix <trix@redhat.com>, linux-fpga@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fpga: versal: remove incorrect of_match_ptr annotation
Message-ID: <Z8LVmt9LCrhF6n1Y@yilunxu-OptiPlex-7050>
References: <20250225163510.4168911-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250225163510.4168911-1-arnd@kernel.org>

On Tue, Feb 25, 2025 at 05:35:07PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Building with W=1 shows a warning about versal_fpga_of_match being unused when
> CONFIG_OF is disabled:
> 
>     drivers/fpga/versal-fpga.c:62:34: error: unused variable 'versal_fpga_of_match' [-Werror,-Wunused-const-variable]
> 
> Acked-by: Xu Yilun <yilun.xu@intel.com>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Sorry, I thought someone would take the whole series.

Applied to for-next.

Thanks,
Yilun

