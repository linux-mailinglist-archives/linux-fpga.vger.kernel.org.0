Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D09985037AD
	for <lists+linux-fpga@lfdr.de>; Sat, 16 Apr 2022 19:02:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232657AbiDPRDL (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sat, 16 Apr 2022 13:03:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232651AbiDPRDK (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sat, 16 Apr 2022 13:03:10 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC1D264719;
        Sat, 16 Apr 2022 10:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650128436; x=1681664436;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=c41hGLHaAehdnBiHkOfPD2fC/yD5IiZ95Pu4yRuFNdQ=;
  b=lCr/dbNB89qGPJt8IL6ZjkNpEVK26XQ67133LX25i9vNkP8RuRbjjMaB
   gfe361BgLrm+krMkh+5wi7nbiEq9DGFHAcqGQOAKX7yHKWVW/KWtMuXI1
   rkP366puqnkTW7j+2vFS6ecG8bNG6VGCF84G4rYiiURMX3/nvk+Z+G1GT
   wT65BZd3XYGGrjdMFur2VwWqBXWpwJR4FIxxWmFK/Kl4Mj4ekRVrMkP3c
   oN+OQFfhoenPxdGOXzjOSJfz6POzZJuWl9oYslLbaqAx8kK4LRhEwkxzo
   oOjkcjQ5OHzlPWYMhSGHk7rD6MZYyuvmoJUl2NXMukMZjkW8CRL+P9EgN
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10318"; a="262767296"
X-IronPort-AV: E=Sophos;i="5.90,264,1643702400"; 
   d="scan'208";a="262767296"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2022 10:00:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,264,1643702400"; 
   d="scan'208";a="701369843"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.135])
  by fmsmga001.fm.intel.com with ESMTP; 16 Apr 2022 10:00:33 -0700
Date:   Sun, 17 Apr 2022 00:53:01 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Nava kishore Manne <nava.manne@xilinx.com>
Cc:     mdf@kernel.org, hao.wu@intel.com, trix@redhat.com,
        michal.simek@xilinx.com, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        git@xilinx.com
Subject: Re: [PATCH v4 3/5] fpga: fpga-mgr: fix kernel-doc warnings
Message-ID: <20220416165301.GG301222@yilunxu-OptiPlex-7050>
References: <20220416133719.3382895-1-nava.manne@xilinx.com>
 <20220416133719.3382895-4-nava.manne@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220416133719.3382895-4-nava.manne@xilinx.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Sat, Apr 16, 2022 at 07:07:17PM +0530, Nava kishore Manne wrote:
> warnings: No description found for return value of 'xxx'
> 
> In-order to fix the above kernel-doc warnings added the
> 'Return' description for 'devm_fpga_mgr_register_full()'
> and 'devm_fpga_mgr_register()' API's.

                                 APIs.

> 
> Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>

With the minor fix, please add my Acked-by.

Acked-by: Xu Yilun <yilun.xu@intel.com>

> ---
> Changes for v2:
>                 -Replaced s/@return:/Return:/
> Changes for v3:
>                -Updated commit description.
> Changes for v4:
>                -Updated commit description.
> 
>  drivers/fpga/fpga-mgr.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
> index a699cc8e2fa6..0f2b28538f17 100644
> --- a/drivers/fpga/fpga-mgr.c
> +++ b/drivers/fpga/fpga-mgr.c
> @@ -730,6 +730,8 @@ static void devm_fpga_mgr_unregister(struct device *dev, void *res)
>   * @parent:	fpga manager device from pdev
>   * @info:	parameters for fpga manager
>   *
> + * Return:  fpga manager pointer on success, negative error code otherwise.
> + *
>   * This is the devres variant of fpga_mgr_register_full() for which the unregister
>   * function will be called automatically when the managing device is detached.
>   */
> @@ -763,6 +765,8 @@ EXPORT_SYMBOL_GPL(devm_fpga_mgr_register_full);
>   * @mops:	pointer to structure of fpga manager ops
>   * @priv:	fpga manager private data
>   *
> + * Return:  fpga manager pointer on success, negative error code otherwise.
> + *
>   * This is the devres variant of fpga_mgr_register() for which the
>   * unregister function will be called automatically when the managing
>   * device is detached.
> -- 
> 2.25.1
