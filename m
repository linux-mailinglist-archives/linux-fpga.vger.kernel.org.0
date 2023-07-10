Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8830D74D060
	for <lists+linux-fpga@lfdr.de>; Mon, 10 Jul 2023 10:42:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233184AbjGJIkv (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 10 Jul 2023 04:40:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233082AbjGJIkL (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 10 Jul 2023 04:40:11 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B66910D0;
        Mon, 10 Jul 2023 01:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688978390; x=1720514390;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Mh/SGf7MIOtuRngbfxmxx0FBXJ+TjttlQQwEUWCBbcU=;
  b=W1hYOOggg5D0YbyZkc32E/147PotIJCSPCdAr4uH55/Qv5eVClRvnlhq
   +DW9lqHAWIAcVognwFrrV90h6uRjp8/TwiUTWt+Sg9F18Pv5lhx22AQ71
   no2DjhbteMWGO9lHexy0hp0Ru8C9oYT/Mh4WVYLCBnl4vSyWuMPdg3Tm2
   eiTZ90ml7DO+ZZueGHrgRcp+wh/lOh/6LXVezMAVfoRbkLn5VDfW/Jru4
   LF077GGA/CNRtUWKL6n3Zijf6MezgYG8pd9rcn3SVsN5mq/2qkHQrkrJ1
   jIuTTWkR3qa3+RobPJIY1EdTKQEjoEI34yHt64i6ZC86kqvdL/i6/HeX6
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10766"; a="430362044"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="430362044"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2023 01:39:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10766"; a="810736494"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="810736494"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by FMSMGA003.fm.intel.com with ESMTP; 10 Jul 2023 01:39:47 -0700
Date:   Mon, 10 Jul 2023 16:38:20 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Yangtao Li <frank.li@vivo.com>
Cc:     Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Tom Rix <trix@redhat.com>, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/8] fpga: bridge: Convert to
 devm_platform_ioremap_resource()
Message-ID: <ZKvDfNWGB3DJMkJ8@yilunxu-OptiPlex-7050>
References: <20230705094655.44753-1-frank.li@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230705094655.44753-1-frank.li@vivo.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 2023-07-05 at 17:46:48 +0800, Yangtao Li wrote:
> Use devm_platform_ioremap_resource() to simplify code.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>

Acked-by: Xu Yilun <yilun.xu@intel.com>

Applied.

> ---
>  drivers/fpga/altera-freeze-bridge.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/fpga/altera-freeze-bridge.c b/drivers/fpga/altera-freeze-bridge.c
> index 445f4b011167..bb6b02ec2d21 100644
> --- a/drivers/fpga/altera-freeze-bridge.c
> +++ b/drivers/fpga/altera-freeze-bridge.c
> @@ -213,14 +213,12 @@ static int altera_freeze_br_probe(struct platform_device *pdev)
>  	void __iomem *base_addr;
>  	struct altera_freeze_br_data *priv;
>  	struct fpga_bridge *br;
> -	struct resource *res;
>  	u32 status, revision;
>  
>  	if (!np)
>  		return -ENODEV;
>  
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	base_addr = devm_ioremap_resource(dev, res);
> +	base_addr = devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(base_addr))
>  		return PTR_ERR(base_addr);
>  
> -- 
> 2.39.0
> 
