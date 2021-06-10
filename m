Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FD773A25B2
	for <lists+linux-fpga@lfdr.de>; Thu, 10 Jun 2021 09:43:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbhFJHpK (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 10 Jun 2021 03:45:10 -0400
Received: from mga18.intel.com ([134.134.136.126]:47535 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230117AbhFJHpJ (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 10 Jun 2021 03:45:09 -0400
IronPort-SDR: Wu74kMaMULzo2JKTpSc2CewyFfTT4qXfqEjrtRxKMOIKnVkk5zu716fLj7yNSPAaKwu9p9p3vI
 WvcfOB6KuOqw==
X-IronPort-AV: E=McAfee;i="6200,9189,10010"; a="192563430"
X-IronPort-AV: E=Sophos;i="5.83,263,1616482800"; 
   d="scan'208";a="192563430"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2021 00:43:11 -0700
IronPort-SDR: Yc6/ilOYIQgzYl9USbpCIeILZChe4zWlzCsR2lqxwYelj7KCK43G33NbtJRqeNr1MDXRMEXPal
 8eEC4yI6qzEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,263,1616482800"; 
   d="scan'208";a="482730644"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.162])
  by orsmga001.jf.intel.com with ESMTP; 10 Jun 2021 00:43:04 -0700
Date:   Thu, 10 Jun 2021 15:37:24 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Russ Weight <russell.h.weight@intel.com>
Cc:     mdf@kernel.org, linux-fpga@vger.kernel.org, trix@redhat.com,
        lgoncalv@redhat.com, hao.wu@intel.com, matthew.gerlach@intel.com,
        richard.gong@intel.com
Subject: Re: [PATCH v2 1/8] fpga: altera-pr-ip: Remove function
 alt_pr_unregister
Message-ID: <20210610073724.GA2007225@yilunxu-OptiPlex-7050>
References: <20210609221135.261837-1-russell.h.weight@intel.com>
 <20210609221135.261837-2-russell.h.weight@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210609221135.261837-2-russell.h.weight@intel.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Looks good to me.

Reviewed-by: Xu Yilun <yilun.xu@intel.com>

On Wed, Jun 09, 2021 at 03:11:28PM -0700, Russ Weight wrote:
> Remove the alt_pr_unregister() function; it is no longer used.
> 
> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> ---
> v2:
>   - The first version of this patch was entitled:
>     "fpga: altera-pr-ip: Remove function alt_pr_unregister". This version of the
>     patch removes the alt_pr_unregister() function altogether, instead of just
>     removing portions of it.
> ---
>  drivers/fpga/altera-pr-ip-core.c       | 10 ----------
>  include/linux/fpga/altera-pr-ip-core.h |  1 -
>  2 files changed, 11 deletions(-)
> 
> diff --git a/drivers/fpga/altera-pr-ip-core.c b/drivers/fpga/altera-pr-ip-core.c
> index 5b130c4d9882..dfdf21ed34c4 100644
> --- a/drivers/fpga/altera-pr-ip-core.c
> +++ b/drivers/fpga/altera-pr-ip-core.c
> @@ -199,16 +199,6 @@ int alt_pr_register(struct device *dev, void __iomem *reg_base)
>  }
>  EXPORT_SYMBOL_GPL(alt_pr_register);
>  
> -void alt_pr_unregister(struct device *dev)
> -{
> -	struct fpga_manager *mgr = dev_get_drvdata(dev);
> -
> -	dev_dbg(dev, "%s\n", __func__);
> -
> -	fpga_mgr_unregister(mgr);
> -}
> -EXPORT_SYMBOL_GPL(alt_pr_unregister);
> -
>  MODULE_AUTHOR("Matthew Gerlach <matthew.gerlach@linux.intel.com>");
>  MODULE_DESCRIPTION("Altera Partial Reconfiguration IP Core");
>  MODULE_LICENSE("GPL v2");
> diff --git a/include/linux/fpga/altera-pr-ip-core.h b/include/linux/fpga/altera-pr-ip-core.h
> index 0b08ac20ab16..a6b4c07858cc 100644
> --- a/include/linux/fpga/altera-pr-ip-core.h
> +++ b/include/linux/fpga/altera-pr-ip-core.h
> @@ -13,6 +13,5 @@
>  #include <linux/io.h>
>  
>  int alt_pr_register(struct device *dev, void __iomem *reg_base);
> -void alt_pr_unregister(struct device *dev);
>  
>  #endif /* _ALT_PR_IP_CORE_H */
> -- 
> 2.25.1
