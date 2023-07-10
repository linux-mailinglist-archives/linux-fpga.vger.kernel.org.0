Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E46974D0A9
	for <lists+linux-fpga@lfdr.de>; Mon, 10 Jul 2023 10:55:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230515AbjGJIxs (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 10 Jul 2023 04:53:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231710AbjGJIxs (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 10 Jul 2023 04:53:48 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC28F114;
        Mon, 10 Jul 2023 01:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688979225; x=1720515225;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uBJGqaFxJ3a3tF/c0/ROZm4CGHziFIx1oyQtLeh/Uzg=;
  b=XlhnBLM48ChsC6a4oc2qez+m5WaV29V9hXuPODgLTTOUIG4R8Cq+GcWu
   LuybE6HYVrXaUIydQA+/S1jVS4ktJ9pj+XBxETXaL5ZL3YgehhqA9iKYO
   TBjA0P9QMLWrSxiEA77D4x9waI6sfK5uGg+h77yGeQVyHNmUZcoOBCI5g
   jL7I/z/m7cgA49rWu2xHYrZaBsEdfPx1d4vkrGWX56STaI/46gwwWPCt5
   3XLt9Om+dxp3ZuyVmnnkiPpi+xgLQJFPTd+1FKBeEWf/jzwb7Yu/OozZl
   HmPAjIEG1XtfHy786bcjAxu7+O7cwpLnmkCF0G6Xq8TGihxdvQvmrlkob
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10766"; a="430365153"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="430365153"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2023 01:53:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10766"; a="750278887"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="750278887"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orsmga008.jf.intel.com with ESMTP; 10 Jul 2023 01:53:33 -0700
Date:   Mon, 10 Jul 2023 16:52:06 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Yangtao Li <frank.li@vivo.com>
Cc:     Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Tom Rix <trix@redhat.com>, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/8] fpga: fpga-mgr: ts73xx: Convert to
 devm_platform_ioremap_resource()
Message-ID: <ZKvGttvtqT6Ze4Er@yilunxu-OptiPlex-7050>
References: <20230705094655.44753-1-frank.li@vivo.com>
 <20230705094655.44753-7-frank.li@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230705094655.44753-7-frank.li@vivo.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 2023-07-05 at 17:46:54 +0800, Yangtao Li wrote:
> Use devm_platform_ioremap_resource() to simplify code.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>

Acked-by: Xu Yilun <yilun.xu@intel.com>

Applied.

> ---
>  drivers/fpga/ts73xx-fpga.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/fpga/ts73xx-fpga.c b/drivers/fpga/ts73xx-fpga.c
> index 8e6e9c840d9d..4e1d2a4d3df4 100644
> --- a/drivers/fpga/ts73xx-fpga.c
> +++ b/drivers/fpga/ts73xx-fpga.c
> @@ -103,7 +103,6 @@ static int ts73xx_fpga_probe(struct platform_device *pdev)
>  	struct device *kdev = &pdev->dev;
>  	struct ts73xx_fpga_priv *priv;
>  	struct fpga_manager *mgr;
> -	struct resource *res;
>  
>  	priv = devm_kzalloc(kdev, sizeof(*priv), GFP_KERNEL);
>  	if (!priv)
> @@ -111,8 +110,7 @@ static int ts73xx_fpga_probe(struct platform_device *pdev)
>  
>  	priv->dev = kdev;
>  
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	priv->io_base = devm_ioremap_resource(kdev, res);
> +	priv->io_base = devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(priv->io_base))
>  		return PTR_ERR(priv->io_base);
>  
> -- 
> 2.39.0
> 
