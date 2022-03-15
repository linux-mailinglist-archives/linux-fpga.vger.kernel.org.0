Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F07BD4D9FC3
	for <lists+linux-fpga@lfdr.de>; Tue, 15 Mar 2022 17:17:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349943AbiCOQRH (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 15 Mar 2022 12:17:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240489AbiCOQRH (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 15 Mar 2022 12:17:07 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AECA749CA9;
        Tue, 15 Mar 2022 09:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647360955; x=1678896955;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2GljXTe3wNrzf4qT4Ab198zPDt4+ZO0/lR6hJ/aDYaw=;
  b=U/Gaevzzq5Mxys1ay4tvV/Tvc3E81tRaYw0pqQbqjyeyQwTB8K3Kl12S
   8KfpEYuJkTbp2xzf29K0lauWXGAXtSnilDFoocIInhByGCPWQ5hbyFLvu
   2M3hhRodNOgi9sxcSSDXVmWwNg5CnD9zqxUc0T48epQolhin6rMlCQ1FW
   XfHTLmSSk3h6WMRZS89wPwQExu4H9G8pdojxaCYQ9l/EWe/FOEZ68Yd8H
   DJxiJucRdifRTxm6Y9ez5Oa8/7Nr+5jnI6Io6pl28Q5yv2CzHcwQVG4nW
   GMoHUEKCt5ucwkUFIEN2/Eu2QugWKRkCWWIrrECF74V3VGFMj2p1GUkra
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="256074638"
X-IronPort-AV: E=Sophos;i="5.90,184,1643702400"; 
   d="scan'208";a="256074638"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2022 09:15:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,184,1643702400"; 
   d="scan'208";a="556997948"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.135])
  by orsmga008.jf.intel.com with ESMTP; 15 Mar 2022 09:15:53 -0700
Date:   Wed, 16 Mar 2022 00:08:55 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Nava kishore Manne <navam@xilinx.com>
Cc:     "mdf@kernel.org" <mdf@kernel.org>,
        "hao.wu@intel.com" <hao.wu@intel.com>,
        "trix@redhat.com" <trix@redhat.com>,
        Michal Simek <michals@xilinx.com>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 2/6] fpga: zynqmp: Initialized variables before using it
Message-ID: <20220315160855.GA121107@yilunxu-OptiPlex-7050>
References: <20220308094519.1816649-1-nava.manne@xilinx.com>
 <20220308094519.1816649-3-nava.manne@xilinx.com>
 <20220311142814.GA97487@yilunxu-OptiPlex-7050>
 <SN6PR02MB4576FB4490F96E593E09D4B9C2109@SN6PR02MB4576.namprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR02MB4576FB4490F96E593E09D4B9C2109@SN6PR02MB4576.namprd02.prod.outlook.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Tue, Mar 15, 2022 at 11:48:11AM +0000, Nava kishore Manne wrote:
> Hi Yilun,
> 
> 	Thanks for providing the review comments.
> Please find my response inline.
> 
> > -----Original Message-----
> > From: Xu Yilun <yilun.xu@intel.com>
> > Sent: Friday, March 11, 2022 7:58 PM
> > To: Nava kishore Manne <navam@xilinx.com>
> > Cc: mdf@kernel.org; hao.wu@intel.com; trix@redhat.com; Michal Simek
> > <michals@xilinx.com>; linux-fpga@vger.kernel.org; linux-
> > kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org
> > Subject: Re: [PATCH 2/6] fpga: zynqmp: Initialized variables before using it
> > 
> > On Tue, Mar 08, 2022 at 03:15:15PM +0530, Nava kishore Manne wrote:
> > > This patch initialized variables with the proper value.
> > > Addresses-Coverity: "uninit_use: Using uninitialized value"
> > >
> > > Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
> > > ---
> > >  drivers/fpga/zynqmp-fpga.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/fpga/zynqmp-fpga.c b/drivers/fpga/zynqmp-fpga.c
> > > index c60f20949c47..e931d69819a7 100644
> > > --- a/drivers/fpga/zynqmp-fpga.c
> > > +++ b/drivers/fpga/zynqmp-fpga.c
> > > @@ -41,7 +41,7 @@ static int zynqmp_fpga_ops_write(struct
> > fpga_manager *mgr,
> > >  				 const char *buf, size_t size)
> > >  {
> > >  	struct zynqmp_fpga_priv *priv;
> > > -	dma_addr_t dma_addr;
> > > +	dma_addr_t dma_addr = 0;
> > 
> > The first use of this variable is as an output parameter:
> > 
> > 	kbuf = dma_alloc_coherent(priv->dev, size, &dma_addr,
> > GFP_KERNEL);
> > 
> > So I don't think it needs to be initialized as 0.
> > 
> 
> This issue is found by Coverity Scan, Whether this param is input/output this fix will not impact the actual functionality.
> In order to fix the issues reported by the Coverity tool, this fix is needed.

I didn't see issues about this piece of code, so I don't think we need
the fix just to make the tool happy. Maybe the tool could be improved to
help us better.

Thanks,
Yilun

> 
> Regards,
> Navakishore.
