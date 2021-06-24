Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 626E03B29CD
	for <lists+linux-fpga@lfdr.de>; Thu, 24 Jun 2021 09:59:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231707AbhFXIBv (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 24 Jun 2021 04:01:51 -0400
Received: from mga01.intel.com ([192.55.52.88]:49749 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231630AbhFXIBv (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 24 Jun 2021 04:01:51 -0400
IronPort-SDR: fhe5lwq18lnTVNxHH0U78HKGyXNDx1WaGPIlwJx+AWlAmSU5Cr42m/H6DnHq/kvg3A4Aore4ge
 ho54yKqv6gXg==
X-IronPort-AV: E=McAfee;i="6200,9189,10024"; a="229006955"
X-IronPort-AV: E=Sophos;i="5.83,296,1616482800"; 
   d="scan'208";a="229006955"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2021 00:59:31 -0700
IronPort-SDR: 9rrIp9l+o5YU/gZbNNmGk1pTfaV91pCI7CzngOK5/quyOfaBZ+JjbMuY1JCYe2jLtrc3uYBsBu
 /jGvwOe8AXHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,296,1616482800"; 
   d="scan'208";a="557249382"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.162])
  by fmsmga001.fm.intel.com with ESMTP; 24 Jun 2021 00:59:28 -0700
Date:   Thu, 24 Jun 2021 15:54:14 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     trix@redhat.com
Cc:     hao.wu@intel.com, mdf@kernel.org, michal.simek@xilinx.com,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 1/7] fpga-mgr: wrap the write_init() op
Message-ID: <20210624075414.GA44700@yilunxu-OptiPlex-7050>
References: <20210623182410.3787784-1-trix@redhat.com>
 <20210623182410.3787784-3-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210623182410.3787784-3-trix@redhat.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Wed, Jun 23, 2021 at 11:24:04AM -0700, trix@redhat.com wrote:
> From: Tom Rix <trix@redhat.com>
> 
> An FPGA manager should not be required to provide a
> write_init() op if there is nothing for it do.
> So add a wrapper and move the op checking.
> Default to success.
> 
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  drivers/fpga/fpga-mgr.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
> index ecb4c3c795fa5..87bbb940c9504 100644
> --- a/drivers/fpga/fpga-mgr.c
> +++ b/drivers/fpga/fpga-mgr.c
> @@ -69,6 +69,14 @@ void fpga_image_info_free(struct fpga_image_info *info)
>  }
>  EXPORT_SYMBOL_GPL(fpga_image_info_free);
>  
> +static int fpga_mgr_write_init(struct fpga_manager *mgr,
> +			       struct fpga_image_info *info,
> +			       const char *buf, size_t count)
> +{
> +	if (mgr->mops && mgr->mops->write_init)

Maybe we don't have to check mgr->mops, it is already checked on
creation.

The same concern to all the following patches.

Thanks,
Yilun

> +		return  mgr->mops->write_init(mgr, info, buf, count);
> +	return 0;
> +}
>  /*
>   * Call the low level driver's write_init function.  This will do the
>   * device-specific things to get the FPGA into the state where it is ready to
> @@ -83,9 +91,9 @@ static int fpga_mgr_write_init_buf(struct fpga_manager *mgr,
>  
>  	mgr->state = FPGA_MGR_STATE_WRITE_INIT;
>  	if (!mgr->mops->initial_header_size)
> -		ret = mgr->mops->write_init(mgr, info, NULL, 0);
> +		ret = fpga_mgr_write_init(mgr, info, NULL, 0);
>  	else
> -		ret = mgr->mops->write_init(
> +		ret = fpga_mgr_write_init(
>  		    mgr, info, buf, min(mgr->mops->initial_header_size, count));
>  
>  	if (ret) {
> @@ -569,7 +577,7 @@ struct fpga_manager *fpga_mgr_create(struct device *parent, const char *name,
>  	int id, ret;
>  
>  	if (!mops || !mops->write_complete || !mops->state ||
> -	    !mops->write_init || (!mops->write && !mops->write_sg) ||
> +	    (!mops->write && !mops->write_sg) ||
>  	    (mops->write && mops->write_sg)) {
>  		dev_err(parent, "Attempt to register without fpga_manager_ops\n");
>  		return NULL;
> -- 
> 2.26.3
