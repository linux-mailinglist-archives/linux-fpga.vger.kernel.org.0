Return-Path: <linux-fpga+bounces-1292-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6769CB1B93F
	for <lists+linux-fpga@lfdr.de>; Tue,  5 Aug 2025 19:22:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 312726258E7
	for <lists+linux-fpga@lfdr.de>; Tue,  5 Aug 2025 17:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36474299952;
	Tue,  5 Aug 2025 17:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dN0z/cJl"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B352957C2
	for <linux-fpga@vger.kernel.org>; Tue,  5 Aug 2025 17:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754414549; cv=none; b=lnkU9U3bUrFNHbjla8qipS3Fy2i8rf5uU7f8alSvqtrNpwM9LVEODtcnZiczHNdbSnH53LMTIuhvBAe9Srbk5ELFgq9DTUDMPuhGT9nAkpkZ/J1+c2OwGc9UdMXTPpxbL5i9jyEcsshVA5CM+TB0Zvv21TJiURRsQFGNngferT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754414549; c=relaxed/simple;
	bh=sZQTRfzpyLVdbzbv6MHaoiycUCflFoa/qdyXzU/UoN0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rMBvytSjFCxmIV0Mh6H9dPO6Vi2dMF08zdBIjkRqYZcfRql1BPVmMuObC1tYGJR0R/jdREWV/3kBx4AplkNuQF8rmXWxcfcG6ZeZWGoKEvGmFdvOxBOEwJoBRk/yHBl5PfxGfb8xHZuBCOlj84iyWaB89P5d4Nqo7wnziQXcvI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dN0z/cJl; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754414547; x=1785950547;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sZQTRfzpyLVdbzbv6MHaoiycUCflFoa/qdyXzU/UoN0=;
  b=dN0z/cJlbnXZlB+ht2eMkcr9ZecGqx+v0mHw9V1fCVn9TMje+YxF4fIp
   dHlveOcrq6JhFoC9YS8LFnEnndfAp6QBz0jedTQHobAFApM85B+nwtiFp
   0F07iYJspn6X0p1WhXpPlLEtKCucl0rwEXD92k9aNOrtb74XxUuTWiusD
   S6TcmbEvlcsGbfFB77hX/zK45MRBuswoBtFjUsf+wKyHqH3FFd107L/bk
   yf/AR7fRi2Of6QbMhCYHI+LgyttAF4zTXXZsKb6YSBM+/iQbHlTaThTxw
   eVAFTIS3x2tasCq6KeUsIbj1DRueiURk9Zam9WZyE2PKaj2isg7A7+9Xa
   A==;
X-CSE-ConnectionGUID: lq7DpQRYQSqNVOt5KNm4EQ==
X-CSE-MsgGUID: WnKl7hCHR4GpluaAAZY9Dg==
X-IronPort-AV: E=McAfee;i="6800,10657,11513"; a="68172047"
X-IronPort-AV: E=Sophos;i="6.17,268,1747724400"; 
   d="scan'208";a="68172047"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2025 10:22:26 -0700
X-CSE-ConnectionGUID: 41f0INIpTROn/uj5tbm1nQ==
X-CSE-MsgGUID: ZcHzwvgvRbilSQQ6FXPd1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,268,1747724400"; 
   d="scan'208";a="188227403"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa002.fm.intel.com with ESMTP; 05 Aug 2025 10:22:24 -0700
Date: Wed, 6 Aug 2025 01:12:46 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Pavel Pisa <pisa@fel.cvut.cz>, linux-fpga@vger.kernel.org,
	Michal Simek <michal.simek@amd.com>,
	Jason Gunthorpe <jgg@nvidia.com>, Xu Yilun <yilun.xu@intel.com>,
	Pavel Hronek <hronepa1@fel.cvut.cz>,
	Jiri Novak <jnovak@fel.cvut.cz>,
	Ondrej Ille <ondrej.ille@gmail.com>
Subject: Re: AMD/Xilinx Zynq FPGA manager stopped to work after
 6.16.0-g283564a43383
Message-ID: <aJI7juhONZp/8XfI@yilunxu-OptiPlex-7050>
References: <CGME20250804134826eucas1p1350956e17ae463332a69eaa67dc2f8d7@eucas1p1.samsung.com>
 <202508041548.22955.pisa@fel.cvut.cz>
 <a3b997b5-d8b7-4c72-89fc-7d2d21031351@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a3b997b5-d8b7-4c72-89fc-7d2d21031351@samsung.com>

> Well, my fault. I forgot that dma_map_sgtable() returns only the error 
> code or zero on success, not the number of mapped segments. It looks 
> that the easiest way to fix this issue is to revert my commit 
> 37e00703228a ("zynq_fpga: use sgtable-based scatterlist wrappers"). I'm 

Instead of reverting, can we fix like this?

---

diff --git a/drivers/fpga/zynq-fpga.c b/drivers/fpga/zynq-fpga.c
index 0be0d569589d..b7629a0e4813 100644
--- a/drivers/fpga/zynq-fpga.c
+++ b/drivers/fpga/zynq-fpga.c
@@ -405,12 +405,12 @@ static int zynq_fpga_ops_write(struct fpga_manager *mgr, struct sg_table *sgt)
                }
        }

-       priv->dma_nelms =
-           dma_map_sgtable(mgr->dev.parent, sgt, DMA_TO_DEVICE, 0);
-       if (priv->dma_nelms == 0) {
+       err = dma_map_sgtable(mgr->dev.parent, sgt, DMA_TO_DEVICE, 0);
+       if (err) {
                dev_err(&mgr->dev, "Unable to DMA map (TO_DEVICE)\n");
-               return -ENOMEM;
+               return err;
        }
+       priv->dma_nelms = sgt->nents;

        /* enable clock */
        err = clk_enable(priv->clk);

Thanks,
Yilun

