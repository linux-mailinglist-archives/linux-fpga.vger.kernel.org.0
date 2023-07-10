Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F46A74D09A
	for <lists+linux-fpga@lfdr.de>; Mon, 10 Jul 2023 10:50:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230325AbjGJItK (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 10 Jul 2023 04:49:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230167AbjGJItK (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 10 Jul 2023 04:49:10 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DDB5C2;
        Mon, 10 Jul 2023 01:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688978949; x=1720514949;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xqv7COd6hx5eNITZ+ROLIM2dvqJtaATG8L0ZEM94FuE=;
  b=O5/LSjoVtGpYu62sjcwmK9XW+eQtZSqmahTbjxcSKFvOblO6se3Nqhq2
   kp+tZalqMrwTigkBEKuc48bwl74XpVBg+K6sxqgXqowLKgmCUKJoBxNA3
   5fmCiAC+k6oYCfbDrVCt5cxCuCf2lWGNZgGtVT/OPO/K1wcNY22JCrZMk
   b9i2iHcRoGYPwcF9B0h2eDySm9t7ksxgJuz+h0xEwYAmuzdoX03ggmO8q
   Wrr9xm0woQVD464lu6mcFsKiOM6fDOmRTVK6wg/DesGjL0gfGxGLGajKb
   BOG/3POjqTiK83VE5cDGSoi4bw9rx1ZL2ZammeUlXSe70AIHZP3OhK9O3
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10766"; a="427982141"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="427982141"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2023 01:48:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10766"; a="790720541"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="790720541"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmsmga004.fm.intel.com with ESMTP; 10 Jul 2023 01:48:47 -0700
Date:   Mon, 10 Jul 2023 16:47:20 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Yangtao Li <frank.li@vivo.com>
Cc:     Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Tom Rix <trix@redhat.com>, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/8] fpga: fpga-mgr: socfpga: Convert to
 devm_platform_ioremap_resource()
Message-ID: <ZKvFmIQ2T3Zt2/Lj@yilunxu-OptiPlex-7050>
References: <20230705094655.44753-1-frank.li@vivo.com>
 <20230705094655.44753-6-frank.li@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230705094655.44753-6-frank.li@vivo.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 2023-07-05 at 17:46:53 +0800, Yangtao Li wrote:
> Use devm_platform_ioremap_resource() to simplify code.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>

Acked-by: Xu Yilun <yilun.xu@intel.com>

Applied.

> ---
>  drivers/fpga/socfpga.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/fpga/socfpga.c b/drivers/fpga/socfpga.c
> index 7e0741f99696..723ea0ad3f09 100644
> --- a/drivers/fpga/socfpga.c
> +++ b/drivers/fpga/socfpga.c
> @@ -545,20 +545,17 @@ static int socfpga_fpga_probe(struct platform_device *pdev)
>  	struct device *dev = &pdev->dev;
>  	struct socfpga_fpga_priv *priv;
>  	struct fpga_manager *mgr;
> -	struct resource *res;
>  	int ret;
>  
>  	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
>  	if (!priv)
>  		return -ENOMEM;
>  
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	priv->fpga_base_addr = devm_ioremap_resource(dev, res);
> +	priv->fpga_base_addr = devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(priv->fpga_base_addr))
>  		return PTR_ERR(priv->fpga_base_addr);
>  
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> -	priv->fpga_data_addr = devm_ioremap_resource(dev, res);
> +	priv->fpga_data_addr = devm_platform_ioremap_resource(pdev, 1);
>  	if (IS_ERR(priv->fpga_data_addr))
>  		return PTR_ERR(priv->fpga_data_addr);
>  
> -- 
> 2.39.0
> 
