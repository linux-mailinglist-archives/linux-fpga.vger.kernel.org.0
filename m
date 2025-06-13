Return-Path: <linux-fpga+bounces-1240-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DBAEAD87DC
	for <lists+linux-fpga@lfdr.de>; Fri, 13 Jun 2025 11:30:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCFA23AAA48
	for <lists+linux-fpga@lfdr.de>; Fri, 13 Jun 2025 09:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82ECE291C31;
	Fri, 13 Jun 2025 09:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TPtRdN9Y"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C717C279DCC;
	Fri, 13 Jun 2025 09:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749806988; cv=none; b=PA784qfsoiV4aX0U8rel9GP29t2j6a3RjivelPjME5ZYaPE6LG9uJdWOUkYouoGEj+0V1icU37h1V3Efh6b4RTjKZJSN275ClAN0LJPT4mVnSAlY/78u7vdty+tQNI9hYZd5BttVjSxD58HjH7jGwVdaVCbbwpyG8Od+NKmJpog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749806988; c=relaxed/simple;
	bh=E1WZU7XgXZDJxyz0ZT4s8zdvA03SF/sCKkUP96jndZM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tVGOl+YjLN2DRgG0HI2mI0eU0sqRU3azMbeCg270+iccgYOmpXq+88IgDznaPacNjNn8lPTD8FUFI8CKSp0iOJX5iRcYR3DniJCtO2qFc29CuoIOJb6RdZjIYSB2/381eIM83c4ZVSI6cckFavxaHI/LunwhLrV9GaZ6KMZDk/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TPtRdN9Y; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749806987; x=1781342987;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=E1WZU7XgXZDJxyz0ZT4s8zdvA03SF/sCKkUP96jndZM=;
  b=TPtRdN9YU/otDUKkXm4kR6jMuSdpfBHy/nnBFwz8fdB1FitfFeNNZSwL
   CXSRQjWEoB+TgmiLavDFqruFNxIhAxqraND3PzAMqNwyR6Lmr1nhCXoRd
   fcnGJTekjR35GLgOuXOjqH+WGqMeArML/BIifR6L9ecwJxnB4NWyq2adS
   J2m7r55ZLTA6XKORTJxFgDCMpoVbIbWZfkeitSzK3uy+HfUbaFVZ9wVw/
   gAd3w4u3QzABX/vxs6HLF6b7DI1uvvGTStaJZdymHs/A9z2tSe8ZjVXSC
   Wx2SD6DNe9AdlztCYaSb1JymsVMO1dW6sSJ1VWAiCD+sew8P4I+o4wvdG
   A==;
X-CSE-ConnectionGUID: sc3FIlsWTkamP9UinYhoig==
X-CSE-MsgGUID: I/Vn0jPtS76zw8CiFu5zeQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11462"; a="51937985"
X-IronPort-AV: E=Sophos;i="6.16,233,1744095600"; 
   d="scan'208";a="51937985"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2025 02:29:46 -0700
X-CSE-ConnectionGUID: ijEeAeJTR+6ZwdSMExHm6A==
X-CSE-MsgGUID: O3HxHEzFRk+bw7qvsO7tQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,233,1744095600"; 
   d="scan'208";a="152675082"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa005.fm.intel.com with ESMTP; 13 Jun 2025 02:29:43 -0700
Date: Fri, 13 Jun 2025 17:22:42 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, linux-fpga@vger.kernel.org,
	Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
	Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
	Michal Simek <michal.simek@amd.com>, stable@vger.kernel.org
Subject: Re: [PATCH] fpga: zynq-fpga: use sgtable-based scatterlist wrappers
Message-ID: <aEvt4p2REHlW+EkV@yilunxu-OptiPlex-7050>
References: <CGME20250527093152eucas1p24a904b0d973252ebc0d05034a276e9cf@eucas1p2.samsung.com>
 <20250527093137.505621-1-m.szyprowski@samsung.com>
 <20250527121128.GB123169@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250527121128.GB123169@ziepe.ca>

On Tue, May 27, 2025 at 09:11:28AM -0300, Jason Gunthorpe wrote:
> On Tue, May 27, 2025 at 11:31:37AM +0200, Marek Szyprowski wrote:
> > Use common wrappers operating directly on the struct sg_table objects to
> > fix incorrect use of statterlists related calls. dma_unmap_sg() function
> > has to be called with the number of elements originally passed to the
> > dma_map_sg() function, not the one returned in sgtable's nents.
> > 
> > CC: stable@vger.kernel.org
> > Fixes: 425902f5c8e3 ("fpga zynq: Use the scatterlist interface")
> > Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> > ---
> >  drivers/fpga/zynq-fpga.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Xu Yilun <yilun.xu@intel.com>

Applied to for-next.

> 
> Jason
> 

