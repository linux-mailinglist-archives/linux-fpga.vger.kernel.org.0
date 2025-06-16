Return-Path: <linux-fpga+bounces-1249-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5273CADAA79
	for <lists+linux-fpga@lfdr.de>; Mon, 16 Jun 2025 10:16:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 526FF7A1528
	for <lists+linux-fpga@lfdr.de>; Mon, 16 Jun 2025 08:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ADEE1BF33F;
	Mon, 16 Jun 2025 08:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xo/NIfof"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEADB20966B;
	Mon, 16 Jun 2025 08:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750061808; cv=none; b=dCBla3tZmKNvUR5mXXWOeUzWFkW9Yn79KN/u+GhoKQyqXs2XfVCXd+SRXZhimewB6wQtdOag/8DGqovtGjmWqtImMm3Xqi2sWcnJnO4nkfrjNl7sVyfLNfauRGKgu+mCgUvR0oin+jHXVyNjd9KXfmn5NZRN2eKVUb3wRQ1vjeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750061808; c=relaxed/simple;
	bh=ms63Y5bN5cNjm4BY6/NMSCVEFQghhTtMZ3/PHINoXYI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G5kXZhoex5j5R6GR+lFEv94fgHvxqwDg1uvJKOc6Lo7l9pUmsoJe5B1kRQWNL9tPJwY32MulzQHQwCxRycOjLCilmGuojenMRF9J+IEG4nehmKIkTR7NlGbhVNUFbGzgfVwAJjIHqK1yip0xcnHm7dUK+223Mgj2wY/OYbY6Mfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xo/NIfof; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750061807; x=1781597807;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ms63Y5bN5cNjm4BY6/NMSCVEFQghhTtMZ3/PHINoXYI=;
  b=Xo/NIfofkRbHW0PHnU+htIIssEYbjaKxMm4WPLEueTylnAwiGdojB8rs
   jyivAVwB56OU4usJ5gsqA4CDp9JR16bQM4Mhxo7ohpdkKQEFg5tC6H9G+
   YFD34O8De6D70823ks+sPDKi6w/Z/khcoRt+SjDb68b9oV3Zpa4aYWypc
   hUjXC9+/Vl5eT5cWuetp/wpOn3BsdSSP4csyedZQNcYhQ8D/qeQXWDJkT
   FLdR+Xp3Q14uH/791fcFrkGpShPKhwQQhR4MnMuxoGhEX4YnVKRqGevz5
   swj5P6AefXxmbaxwAszT0Ry2vpeVBwxEqeFP2pzeegQ04aQKyd6gb3Rdb
   g==;
X-CSE-ConnectionGUID: lVXWJ89jQGi8vyHtAqZUBw==
X-CSE-MsgGUID: M+jTFaNmQumyeb7DPR5hUw==
X-IronPort-AV: E=McAfee;i="6800,10657,11465"; a="52340983"
X-IronPort-AV: E=Sophos;i="6.16,240,1744095600"; 
   d="scan'208";a="52340983"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2025 01:16:45 -0700
X-CSE-ConnectionGUID: 72ugTpnMTyO5kECClA+jXA==
X-CSE-MsgGUID: yAKeyPt/Qy6W1ifsJP751w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,240,1744095600"; 
   d="scan'208";a="148252535"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa006.fm.intel.com with ESMTP; 16 Jun 2025 01:16:43 -0700
Date: Mon, 16 Jun 2025 16:09:33 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Jason Gunthorpe <jgg@ziepe.ca>, m.szyprowski@samsung.com
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, linux-fpga@vger.kernel.org,
	Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
	Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
	Michal Simek <michal.simek@amd.com>, stable@vger.kernel.org
Subject: Re: [PATCH] fpga: zynq-fpga: use sgtable-based scatterlist wrappers
Message-ID: <aE/RPUBPnE/Tn1OU@yilunxu-OptiPlex-7050>
References: <CGME20250527093152eucas1p24a904b0d973252ebc0d05034a276e9cf@eucas1p2.samsung.com>
 <20250527093137.505621-1-m.szyprowski@samsung.com>
 <20250527121128.GB123169@ziepe.ca>
 <aEvt4p2REHlW+EkV@yilunxu-OptiPlex-7050>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aEvt4p2REHlW+EkV@yilunxu-OptiPlex-7050>

On Fri, Jun 13, 2025 at 05:22:42PM +0800, Xu Yilun wrote:
> On Tue, May 27, 2025 at 09:11:28AM -0300, Jason Gunthorpe wrote:
> > On Tue, May 27, 2025 at 11:31:37AM +0200, Marek Szyprowski wrote:
> > > Use common wrappers operating directly on the struct sg_table objects to
> > > fix incorrect use of statterlists related calls. dma_unmap_sg() function
> > > has to be called with the number of elements originally passed to the
> > > dma_map_sg() function, not the one returned in sgtable's nents.
> > > 
> > > CC: stable@vger.kernel.org
> > > Fixes: 425902f5c8e3 ("fpga zynq: Use the scatterlist interface")
> > > Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> > > ---
> > >  drivers/fpga/zynq-fpga.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> 
> Reviewed-by: Xu Yilun <yilun.xu@intel.com>
> 
> Applied to for-next.

Hello, Marek:

I've removed the patch from for-next. Please fix the issue.

https://lore.kernel.org/all/20250616141151.64eb59e0@canb.auug.org.au/

Thanks,
Yilun


