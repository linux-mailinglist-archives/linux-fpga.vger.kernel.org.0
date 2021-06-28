Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AFB33B597E
	for <lists+linux-fpga@lfdr.de>; Mon, 28 Jun 2021 09:08:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230287AbhF1HLD (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 28 Jun 2021 03:11:03 -0400
Received: from mga14.intel.com ([192.55.52.115]:48616 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230134AbhF1HLC (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 28 Jun 2021 03:11:02 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10028"; a="207717468"
X-IronPort-AV: E=Sophos;i="5.83,305,1616482800"; 
   d="scan'208";a="207717468"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2021 00:08:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,305,1616482800"; 
   d="scan'208";a="557466718"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.162])
  by orsmga004.jf.intel.com with ESMTP; 28 Jun 2021 00:08:33 -0700
Date:   Mon, 28 Jun 2021 15:03:15 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     trix@redhat.com
Cc:     mdf@kernel.org, hao.wu@intel.com, michal.simek@xilinx.com,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 4/4] fpga: use reimage ops in fpga_mgr_load()
Message-ID: <20210628070315.GF72330@yilunxu-OptiPlex-7050>
References: <20210625195849.837976-1-trix@redhat.com>
 <20210625195849.837976-6-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210625195849.837976-6-trix@redhat.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Fri, Jun 25, 2021 at 12:58:49PM -0700, trix@redhat.com wrote:
> From: Tom Rix <trix@redhat.com>
> 
> If the fpga_image_info flags FPGA_MGR_REIMAGE bit is set
> swap out the reconfig ops for the reimage ops and do
> the load.
> 
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  drivers/fpga/fpga-mgr.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
> index c8a6bfa037933..5e53a0508087a 100644
> --- a/drivers/fpga/fpga-mgr.c
> +++ b/drivers/fpga/fpga-mgr.c
> @@ -419,6 +419,9 @@ int fpga_mgr_load(struct fpga_manager *mgr, struct fpga_image_info *info)
>  {
>  	const struct fpga_manager_update_ops *uops = &mgr->mops->reconfig;
>  
> +	if (info->flags & FPGA_MGR_REIMAGE)
> +		uops = &mgr->mops->reimage;
> +

So seems there is no big difference on processing 'reconfig' & 'reimage'
in FPGA mgr framework. We may not have to introduce 2 sets of ops in
fpga_mgr.

Could we just reuse the fpga_mgr_ops for reimage? The
fpga_mgr_ops.write_init() will pass the fpga_image_info to device driver,
and driver could be aware of the REIMAGE flag. Just like the handling of
other flags in fpga_image_info.

Thanks,
Yilun

>  	if (info->sgt)
>  		return fpga_mgr_buf_load_sg(mgr, info, info->sgt, uops);
>  	if (info->buf && info->count)
> -- 
> 2.26.3
