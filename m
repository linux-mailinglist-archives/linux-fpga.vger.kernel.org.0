Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38B573A19FB
	for <lists+linux-fpga@lfdr.de>; Wed,  9 Jun 2021 17:43:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232750AbhFIPpH (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 9 Jun 2021 11:45:07 -0400
Received: from mga07.intel.com ([134.134.136.100]:39708 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233598AbhFIPpG (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 9 Jun 2021 11:45:06 -0400
IronPort-SDR: keyPYSOt2S6OW4RbyLbVuX75H1QNtC3zw68dAZrLJXaE6SHexCF/4xtL7BQOkbIyNVoQJ+lkGm
 Wituwt0Ior6Q==
X-IronPort-AV: E=McAfee;i="6200,9189,10010"; a="268952182"
X-IronPort-AV: E=Sophos;i="5.83,261,1616482800"; 
   d="scan'208";a="268952182"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2021 08:43:07 -0700
IronPort-SDR: Exq2UIMY/uIFfPSOGa6jpJErQksksl5+B4mU0XRIBNCYmAO5S4gj5esi4MOMd89Pvx9BigUp1w
 D5OJZ+95jc2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,261,1616482800"; 
   d="scan'208";a="449983765"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.162])
  by fmsmga008.fm.intel.com with ESMTP; 09 Jun 2021 08:43:04 -0700
Date:   Wed, 9 Jun 2021 23:37:25 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Russ Weight <russell.h.weight@intel.com>
Cc:     mdf@kernel.org, linux-fpga@vger.kernel.org, trix@redhat.com,
        lgoncalv@redhat.com, hao.wu@intel.com, matthew.gerlach@intel.com,
        richard.gong@intel.com
Subject: Re: [PATCH v1 2/5] fpga: altera-pr-ip: Remove fpga_mgr_unregister()
 call
Message-ID: <20210609153725.GB1994229@yilunxu-OptiPlex-7050>
References: <20210609004925.238044-1-russell.h.weight@intel.com>
 <20210609004925.238044-3-russell.h.weight@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210609004925.238044-3-russell.h.weight@intel.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Tue, Jun 08, 2021 at 05:49:22PM -0700, Russ Weight wrote:
> The altera-pr-ip driver uses the devm_fpga_mgr_register() call, so it is
> unnecessary to call fpga_mgr_unregister(). Also, mgr is no longer stored
> in the dev.driver_data, so remove the call to dev_get_drvdata().
> 
> alt_pr_unregister() is now an empty function, but is left intact because
> it is an exported symbol.

I don't see this function be called anywhere, so could we just remove
it?

Any impact we remove an exported symbol that is not used?

Thanks,
Yilun

> 
> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> ---
>  drivers/fpga/altera-pr-ip-core.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/fpga/altera-pr-ip-core.c b/drivers/fpga/altera-pr-ip-core.c
> index 5b130c4d9882..c150a084e440 100644
> --- a/drivers/fpga/altera-pr-ip-core.c
> +++ b/drivers/fpga/altera-pr-ip-core.c
> @@ -201,11 +201,7 @@ EXPORT_SYMBOL_GPL(alt_pr_register);
>  
>  void alt_pr_unregister(struct device *dev)
>  {
> -	struct fpga_manager *mgr = dev_get_drvdata(dev);
> -
>  	dev_dbg(dev, "%s\n", __func__);
> -
> -	fpga_mgr_unregister(mgr);
>  }
>  EXPORT_SYMBOL_GPL(alt_pr_unregister);
>  
> -- 
> 2.25.1
