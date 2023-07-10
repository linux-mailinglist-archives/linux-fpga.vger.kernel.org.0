Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 419C374D08A
	for <lists+linux-fpga@lfdr.de>; Mon, 10 Jul 2023 10:47:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231236AbjGJIpu (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 10 Jul 2023 04:45:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230167AbjGJIp0 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 10 Jul 2023 04:45:26 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B72F4E67;
        Mon, 10 Jul 2023 01:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688978640; x=1720514640;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1zM/gpodLaV7OJJExvISyfwG0UqSf+pC2kfSVD3HiTk=;
  b=Rp2zBKP0oknkddquE3R3KLNxsPkXii3LbZPolEVx43QCXfvsJoVVrxCY
   pGMZPxKgcE7kvo3CN6uXFtEWJRPz/VcGDrQWzvXaM6nhyxhj6P4GLHr/W
   IYnTzDjJwKlOIKqulr/4b1aCkb7ClmwzTLmcgJe/m6nQJCJfGge8DgB1s
   C1fUjXWiGyBGJPwmYpElyXfwBfTBgs7Kqk5Am2Md1FcY+E+Z/9IoWIc1y
   Q4JjZewLaWfY0HglRmFEaESlmG+7DYSdBvEj6z+2UGkKmKqD/Slil2riv
   1C0TCNDae3VpbhQF/96pQNT8J+EJDwi2AXyKlvXDNs1pLHjcc0A4Lfze1
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10766"; a="430362967"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="430362967"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2023 01:43:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10766"; a="750276443"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="750276443"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orsmga008.jf.intel.com with ESMTP; 10 Jul 2023 01:43:49 -0700
Date:   Mon, 10 Jul 2023 16:42:22 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Michal Simek <michal.simek@amd.com>
Cc:     Yangtao Li <frank.li@vivo.com>, Moritz Fischer <mdf@kernel.org>,
        Wu Hao <hao.wu@intel.com>, Tom Rix <trix@redhat.com>,
        linux-fpga@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/8] fpga: xilinx-pr-decoupler: Convert to
 devm_platform_ioremap_resource()
Message-ID: <ZKvEbrMOXqmDkXfg@yilunxu-OptiPlex-7050>
References: <20230705094655.44753-1-frank.li@vivo.com>
 <20230705094655.44753-5-frank.li@vivo.com>
 <8aa1704a-f34e-1bf2-76cc-1324b0a0404a@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8aa1704a-f34e-1bf2-76cc-1324b0a0404a@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 2023-07-07 at 06:55:33 +0200, Michal Simek wrote:
> 
> 
> On 7/5/23 11:46, Yangtao Li wrote:
> > Use devm_platform_ioremap_resource() to simplify code.
> > 
> > Signed-off-by: Yangtao Li <frank.li@vivo.com>
> > ---
> >   drivers/fpga/xilinx-pr-decoupler.c | 4 +---
> >   1 file changed, 1 insertion(+), 3 deletions(-)
> > 
> > diff --git a/drivers/fpga/xilinx-pr-decoupler.c b/drivers/fpga/xilinx-pr-decoupler.c
> > index b76d85449b8f..208d9560f56d 100644
> > --- a/drivers/fpga/xilinx-pr-decoupler.c
> > +++ b/drivers/fpga/xilinx-pr-decoupler.c
> > @@ -108,7 +108,6 @@ static int xlnx_pr_decoupler_probe(struct platform_device *pdev)
> >   	struct xlnx_pr_decoupler_data *priv;
> >   	struct fpga_bridge *br;
> >   	int err;
> > -	struct resource *res;
> >   	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
> >   	if (!priv)
> > @@ -122,8 +121,7 @@ static int xlnx_pr_decoupler_probe(struct platform_device *pdev)
> >   			priv->ipconfig = match->data;
> >   	}
> > -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > -	priv->io_base = devm_ioremap_resource(&pdev->dev, res);
> > +	priv->io_base = devm_platform_ioremap_resource(pdev, 0);
> >   	if (IS_ERR(priv->io_base))
> >   		return PTR_ERR(priv->io_base);
> 
> Acked-by: Michal Simek <michal.simek@amd.com>

Acked-by: Xu Yilun <yilun.xu@intel.com>

Applied.

> 
> M
