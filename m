Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CADDA1D2524
	for <lists+linux-fpga@lfdr.de>; Thu, 14 May 2020 04:32:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725925AbgENCcn (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 13 May 2020 22:32:43 -0400
Received: from mga17.intel.com ([192.55.52.151]:42676 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725874AbgENCcn (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 13 May 2020 22:32:43 -0400
IronPort-SDR: 7bilBrIv/Q0bMGmXyKC4QYtzJEWqmZ1rbPYCvvBK74ERM0JW4hNsBqkygDru899RR9mf8Ob/9p
 hEMtbgN8rs7g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2020 19:32:43 -0700
IronPort-SDR: kOBrR6NviiqmngpOVTA0rTrYU9PmmIF3aA1kHHQHShcK54ygbj74hHlB4QQXs+S7htFV3Hpez+
 Yo7C6o5VJltw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,390,1583222400"; 
   d="scan'208";a="266086967"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.141])
  by orsmga006.jf.intel.com with ESMTP; 13 May 2020 19:32:41 -0700
Date:   Thu, 14 May 2020 10:29:35 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     hao.wu@intel.com, mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fpga: dfl: afu: Corrected error handling levels
Message-ID: <20200514022935.GE29933@yilunxu-OptiPlex-7050>
References: <1589397725-29697-1-git-send-email-jrdr.linux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1589397725-29697-1-git-send-email-jrdr.linux@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

The patch looks good to me.

Maybe we could add the Fixes tag:
  Fixes: fa8dda1edef9 (fpga: dfl: afu: add DFL_FPGA_PORT_DMA_MAP/UNMAP ioctls support)

Thanks,
Yilun

On Thu, May 14, 2020 at 12:52:05AM +0530, Souptick Joarder wrote:
> Corrected error handling goto sequnece. Level put_pages should
> be called when pinned pages >= 0 && pinned != npages. Level
> free_pages should be called when pinned pages < 0.
> 
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> ---
>  drivers/fpga/dfl-afu-dma-region.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/fpga/dfl-afu-dma-region.c b/drivers/fpga/dfl-afu-dma-region.c
> index 62f9244..5942343 100644
> --- a/drivers/fpga/dfl-afu-dma-region.c
> +++ b/drivers/fpga/dfl-afu-dma-region.c
> @@ -61,10 +61,10 @@ static int afu_dma_pin_pages(struct dfl_feature_platform_data *pdata,
>  				     region->pages);
>  	if (pinned < 0) {
>  		ret = pinned;
> -		goto put_pages;
> +		goto free_pages;
>  	} else if (pinned != npages) {
>  		ret = -EFAULT;
> -		goto free_pages;
> +		goto put_pages;
>  	}
>  
>  	dev_dbg(dev, "%d pages pinned\n", pinned);
> -- 
> 1.9.1
