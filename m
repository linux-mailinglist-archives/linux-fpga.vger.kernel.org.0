Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AA4C74D0B3
	for <lists+linux-fpga@lfdr.de>; Mon, 10 Jul 2023 10:57:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbjGJI4J (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 10 Jul 2023 04:56:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231986AbjGJI4D (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 10 Jul 2023 04:56:03 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46B13E40;
        Mon, 10 Jul 2023 01:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688979358; x=1720515358;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=664qAjZzrPJKlFFIMH/+AQs2HvURbTM/1kF3QMuprbU=;
  b=bJWGBj+9qksZOhav5Ni7OrIh1ecTti8R4zUxwuvBo6XCCVc2Mo64b+0/
   tVjzYivWTsf2Se9epehGB69r0R4uSHuKS7+WDjuVD7p47hAc0ZSZBCoS1
   BcrKXWnGXZbcedwvjh1+rsSFCfaMaBMP+/D6df2AWF07XlmbD12E+Vqrz
   cdRDq8QXRyBC9uiz6dWxoKACcFzLWf8I+u0Y+1jN6DhXI7f2ItpMXrmWZ
   ArVeNQJHbLOjyHq7W7KJYCgB+to2RqtNOctO1FqORmcVPveHq47AQ5WlA
   DOXy1soJNt9I7X5UEHxCGpWQPN8cbKKYovpiZF49LhAWy7xgXQ9bfG4L9
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10766"; a="427983568"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="427983568"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2023 01:55:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10766"; a="697932259"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="697932259"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orsmga006.jf.intel.com with ESMTP; 10 Jul 2023 01:55:56 -0700
Date:   Mon, 10 Jul 2023 16:54:28 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Michal Simek <michal.simek@amd.com>
Cc:     Yangtao Li <frank.li@vivo.com>, Moritz Fischer <mdf@kernel.org>,
        Wu Hao <hao.wu@intel.com>, Tom Rix <trix@redhat.com>,
        linux-fpga@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 8/8] fpga: zynq-fpga: Convert to
 devm_platform_ioremap_resource()
Message-ID: <ZKvHRLJlpF9YCnPA@yilunxu-OptiPlex-7050>
References: <20230705094655.44753-1-frank.li@vivo.com>
 <20230705094655.44753-8-frank.li@vivo.com>
 <73eaa72b-9ee2-3aca-b5b9-bc53e6a40467@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <73eaa72b-9ee2-3aca-b5b9-bc53e6a40467@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 2023-07-07 at 06:55:49 +0200, Michal Simek wrote:
> 
> 
> On 7/5/23 11:46, Yangtao Li wrote:
> > Use devm_platform_ioremap_resource() to simplify code.
> > 
> > Signed-off-by: Yangtao Li <frank.li@vivo.com>
> > ---
> >   drivers/fpga/zynq-fpga.c | 4 +---
> >   1 file changed, 1 insertion(+), 3 deletions(-)
> > 
> > diff --git a/drivers/fpga/zynq-fpga.c b/drivers/fpga/zynq-fpga.c
> > index f8214cae9b6e..96611d424a10 100644
> > --- a/drivers/fpga/zynq-fpga.c
> > +++ b/drivers/fpga/zynq-fpga.c
> > @@ -555,7 +555,6 @@ static int zynq_fpga_probe(struct platform_device *pdev)
> >   	struct device *dev = &pdev->dev;
> >   	struct zynq_fpga_priv *priv;
> >   	struct fpga_manager *mgr;
> > -	struct resource *res;
> >   	int err;
> >   	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> > @@ -563,8 +562,7 @@ static int zynq_fpga_probe(struct platform_device *pdev)
> >   		return -ENOMEM;
> >   	spin_lock_init(&priv->dma_lock);
> > -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > -	priv->io_base = devm_ioremap_resource(dev, res);
> > +	priv->io_base = devm_platform_ioremap_resource(pdev, 0);
> >   	if (IS_ERR(priv->io_base))
> >   		return PTR_ERR(priv->io_base);
> 
> Acked-by: Michal Simek <michal.simek@amd.com>

Acked-by: Xu Yilun <yilun.xu@intel.com>

Applied.

> 
> M
