Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEBC174D078
	for <lists+linux-fpga@lfdr.de>; Mon, 10 Jul 2023 10:43:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233146AbjGJImJ (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 10 Jul 2023 04:42:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233145AbjGJIlk (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 10 Jul 2023 04:41:40 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 683122105;
        Mon, 10 Jul 2023 01:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688978432; x=1720514432;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PWMWTKWa9eroulpnl9IksCXkxYnbagB8hdIk8T4ZrmI=;
  b=USzIIWuw079uBvh3sXXd/BXBYnqoBfcmNqV4ntwyOaKyzRCA7+F2g4BL
   2mJslv3teLBooxJocWlduqirlZQRkiY/6VoXnzi3C2oExXrBxLtjXZULy
   oKCesTt52LVlVUYU7LJYVbxaStWFenigmPuPGWCVFESqJOY2IVYUcngFg
   QzF0V2SEDk+dC2paJOuP5BSvLuOr4A+uoLT619uIzDpIStMYSvs7wnFGi
   HKHbnNR37zv+CSx/nbcCA+4b5uE1kRgmJ+UjxgH6W8V/6xT1B+FZpGSp0
   QKr0qex1ibC4Wk4U9l2+A6zbhLmTvryZQ+vNaKS3DQ0U1CFxDJoQduXdY
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10766"; a="430362205"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="430362205"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2023 01:40:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10766"; a="750275606"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="750275606"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orsmga008.jf.intel.com with ESMTP; 10 Jul 2023 01:40:29 -0700
Date:   Mon, 10 Jul 2023 16:39:02 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Yangtao Li <frank.li@vivo.com>
Cc:     Wu Hao <hao.wu@intel.com>, Tom Rix <trix@redhat.com>,
        Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/8] fpga: dfl-fme-mgr: Convert to
 devm_platform_ioremap_resource()
Message-ID: <ZKvDpkSNt5aTQXhs@yilunxu-OptiPlex-7050>
References: <20230705094655.44753-1-frank.li@vivo.com>
 <20230705094655.44753-3-frank.li@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230705094655.44753-3-frank.li@vivo.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 2023-07-05 at 17:46:50 +0800, Yangtao Li wrote:
> Use devm_platform_ioremap_resource() to simplify code.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>

Acked-by: Xu Yilun <yilun.xu@intel.com>

Applied.

> ---
>  drivers/fpga/dfl-fme-mgr.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/fpga/dfl-fme-mgr.c b/drivers/fpga/dfl-fme-mgr.c
> index af0785783b52..ab228d8837a0 100644
> --- a/drivers/fpga/dfl-fme-mgr.c
> +++ b/drivers/fpga/dfl-fme-mgr.c
> @@ -280,7 +280,6 @@ static int fme_mgr_probe(struct platform_device *pdev)
>  	struct device *dev = &pdev->dev;
>  	struct fme_mgr_priv *priv;
>  	struct fpga_manager *mgr;
> -	struct resource *res;
>  
>  	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
>  	if (!priv)
> @@ -290,8 +289,7 @@ static int fme_mgr_probe(struct platform_device *pdev)
>  		priv->ioaddr = pdata->ioaddr;
>  
>  	if (!priv->ioaddr) {
> -		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -		priv->ioaddr = devm_ioremap_resource(dev, res);
> +		priv->ioaddr = devm_platform_ioremap_resource(pdev, 0);
>  		if (IS_ERR(priv->ioaddr))
>  			return PTR_ERR(priv->ioaddr);
>  	}
> -- 
> 2.39.0
> 
