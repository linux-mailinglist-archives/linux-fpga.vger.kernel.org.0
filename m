Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F47B74D032
	for <lists+linux-fpga@lfdr.de>; Mon, 10 Jul 2023 10:39:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbjGJIh6 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 10 Jul 2023 04:37:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbjGJIhv (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 10 Jul 2023 04:37:51 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F3CFC3;
        Mon, 10 Jul 2023 01:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688978270; x=1720514270;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=taRbItooKPqksE9UGA1vfQS3CJR7SSXKhTeZ7I4oIyE=;
  b=PHJbx9BhKALdpKtbrjEJIRRa5eQoDINx/SnoWRRa80Ot58P3jYhklV5T
   7qEIyi++h8Go6jjlv1GAz+mitA8mDtBdFrmTR4buLZfYQiKyu8/Th2dgr
   uwPDGLbqe9VVSQyKJDKnXoSS0VmuAGmXJjedTR0MJpMTNUDX4JSNEXcpl
   vE0gsG5DFaAVpHlaKwgJtZwSmzf1DtHrPgMly15wTFzMnB3nbQqRqsAua
   aqZsk0mWVMa0pe6gqex4SAWJ3HaigM3VOvx7gjhkVxaZLTpy9RqT3mFm1
   pBjW/yNhpdjqGenvKi0doWkPfRdh4uMbZ2+OmsuD8YhMqm0cT5Y/OmuXN
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10766"; a="427980257"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="427980257"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2023 01:37:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10766"; a="697930973"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="697930973"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orsmga006.jf.intel.com with ESMTP; 10 Jul 2023 01:37:47 -0700
Date:   Mon, 10 Jul 2023 16:36:20 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Yangtao Li <frank.li@vivo.com>
Cc:     Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Tom Rix <trix@redhat.com>, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/8] fpga: socfpga-a10: Convert to
 devm_platform_ioremap_resource()
Message-ID: <ZKvDBBX5PHnzMIMv@yilunxu-OptiPlex-7050>
References: <20230705094655.44753-1-frank.li@vivo.com>
 <20230705094655.44753-4-frank.li@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230705094655.44753-4-frank.li@vivo.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 2023-07-05 at 17:46:51 +0800, Yangtao Li wrote:
> Use devm_platform_ioremap_resource() to simplify code.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>  drivers/fpga/socfpga-a10.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/fpga/socfpga-a10.c b/drivers/fpga/socfpga-a10.c
> index ac8e89b8a5cc..b7b6e0bdb3d9 100644
> --- a/drivers/fpga/socfpga-a10.c
> +++ b/drivers/fpga/socfpga-a10.c
> @@ -471,7 +471,6 @@ static int socfpga_a10_fpga_probe(struct platform_device *pdev)
>  	struct a10_fpga_priv *priv;
>  	void __iomem *reg_base;
>  	struct fpga_manager *mgr;
> -	struct resource *res;
>  	int ret;
>  
>  	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> @@ -479,14 +478,12 @@ static int socfpga_a10_fpga_probe(struct platform_device *pdev)
>  		return -ENOMEM;
>  
>  	/* First mmio base is for register access */
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	reg_base = devm_ioremap_resource(dev, res);
> +	reg_base = devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(reg_base))
>  		return PTR_ERR(reg_base);
>  
>  	/* Second mmio base is for writing FPGA image data */
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> -	priv->fpga_data_addr = devm_ioremap_resource(dev, res);
> +	priv->fpga_data_addr = devm_platform_ioremap_resource(pdev, 1);
>  	if (IS_ERR(priv->fpga_data_addr))
>  		return PTR_ERR(priv->fpga_data_addr);
>  
> @@ -494,7 +491,7 @@ static int socfpga_a10_fpga_probe(struct platform_device *pdev)
>  	priv->regmap = devm_regmap_init_mmio(dev, reg_base,
>  					     &socfpga_a10_fpga_regmap_config);
>  	if (IS_ERR(priv->regmap))
> -		return -ENODEV;
> +		return PTR_ERR(priv->regmap);

It's good. But please seperate the patch and specify in changelog.

>  
>  	priv->clk = devm_clk_get(dev, NULL);
>  	if (IS_ERR(priv->clk)) {
> -- 
> 2.39.0
> 
