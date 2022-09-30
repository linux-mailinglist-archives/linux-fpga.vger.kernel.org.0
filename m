Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81D225F0306
	for <lists+linux-fpga@lfdr.de>; Fri, 30 Sep 2022 04:55:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbiI3Cxh (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 29 Sep 2022 22:53:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbiI3Cxg (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 29 Sep 2022 22:53:36 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EB561005D4
        for <linux-fpga@vger.kernel.org>; Thu, 29 Sep 2022 19:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664506415; x=1696042415;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zRqLZj03qIMUhluzDTUVw/XNcfD1uZcr5FKPJNGxaB0=;
  b=gaUYyLKVOjOyfD9CRZWs40dk8KtqfxpedLDMOH3aShqBi48R8BVftaS5
   eoPd0RiPdPJjIRajCmv3t6kzUMzD91LtuLqxMGI/Dsxc++rFnMmKEhCGT
   imqh8TIYTAByuCPFX8GzL3fVCJhCvkPe2trZswDW6qSTfNutNp+vvt0VZ
   jIcrbc7TaueVZ16K0TOO578aaIynaki992XQG9hhQikbnIhdPj9i9ZeOt
   Y1ntIqoXbkqjom62b2Myt0+HCCMdKQnC6X9vOmF7j0IuNi4AYdKn22+3/
   gHV0SIc514VYvx6be6rhUH0+Gbz+vECvGeAOLflEwcqzV6+niWo71beD5
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10485"; a="282450395"
X-IronPort-AV: E=Sophos;i="5.93,357,1654585200"; 
   d="scan'208";a="282450395"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2022 19:53:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10485"; a="691084679"
X-IronPort-AV: E=Sophos;i="5.93,357,1654585200"; 
   d="scan'208";a="691084679"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmsmga004.fm.intel.com with ESMTP; 29 Sep 2022 19:53:10 -0700
Date:   Fri, 30 Sep 2022 10:44:20 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Russ Weight <russell.h.weight@intel.com>
Cc:     Yang Yingliang <yangyingliang@huawei.com>,
        linux-fpga@vger.kernel.org, mdf@kernel.org, hao.wu@intel.com
Subject: Re: [PATCH -next resend] fpga: zynq: Switch to use dev_err_probe()
 helper
Message-ID: <YzZYBB+xrJV4SxXs@yilunxu-OptiPlex-7050>
References: <20220926141729.2292311-1-yangyingliang@huawei.com>
 <c6981606-882e-b801-25ae-012da56d8309@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c6981606-882e-b801-25ae-012da56d8309@intel.com>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 2022-09-26 at 09:09:37 -0700, Russ Weight wrote:
> 
> 
> On 9/26/22 07:17, Yang Yingliang wrote:
> > In the probe path, dev_err() can be replaced with dev_err_probe()
> > which will check if error code is -EPROBE_DEFER and prints the
> > error name. It also sets the defer probe reason which can be
> > checked later through debugfs. It's more simple in error path.
> >
> > Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> Reviewed-by: Russ Weight <russell.h.weight@intel.com>

Acked-by: Xu Yilun <yilun.xu@intel.com>

> > ---
> > Resend for adding SoB.
> > ---
> >  drivers/fpga/zynq-fpga.c | 8 +++-----
> >  1 file changed, 3 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/fpga/zynq-fpga.c b/drivers/fpga/zynq-fpga.c
> > index 426aa34c6a0d..ae0da361e6c6 100644
> > --- a/drivers/fpga/zynq-fpga.c
> > +++ b/drivers/fpga/zynq-fpga.c
> > @@ -582,11 +582,9 @@ static int zynq_fpga_probe(struct platform_device *pdev)
> >  		return priv->irq;
> >  
> >  	priv->clk = devm_clk_get(dev, "ref_clk");
> > -	if (IS_ERR(priv->clk)) {
> > -		if (PTR_ERR(priv->clk) != -EPROBE_DEFER)
> > -			dev_err(dev, "input clock not found\n");
> > -		return PTR_ERR(priv->clk);
> > -	}
> > +	if (IS_ERR(priv->clk))
> > +		return dev_err_probe(dev, PTR_ERR(priv->clk),
> > +				     "input clock not found\n");
> >  
> >  	err = clk_prepare_enable(priv->clk);
> >  	if (err) {
> 
