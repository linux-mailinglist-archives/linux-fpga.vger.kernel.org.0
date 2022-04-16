Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2B695037B7
	for <lists+linux-fpga@lfdr.de>; Sat, 16 Apr 2022 19:25:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231343AbiDPRZq (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sat, 16 Apr 2022 13:25:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232486AbiDPRZp (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sat, 16 Apr 2022 13:25:45 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63EE43617C;
        Sat, 16 Apr 2022 10:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650129793; x=1681665793;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=O8A8q9HHgooEGvDV6a8J2Tz8DqMrdYKyUmLas5F/Zxs=;
  b=aZBdiCgRiryAHdRt2qcJ0ndUBklTjzXrtKu0gwcgb43rVcO639ocx9KD
   c+5EFT4tY2iJiTfbgetqkcUcj7M5VvwdqN429qBWYFzjFrtlH+aJFYz77
   SWDz3hL3hlmHqqYNwIGvjuBrqMFNHwCQBxXHjPH5TshVtRSv01MAWqZ1O
   cfsKXhnP0K9ue6ccHkOkycpTft9Op9/eY633oF3NbWZYT3pSFO8ueTOOx
   m1b3+JGgyPaHXaCVm4r5IrRJ/krbERj/6JE3DqSlBP1MMKU2OUSU3fzei
   vAm5wKvcJl2I7/NK46u4gbXnj4cYtt1JERynI6JrHzHoi8zyocGs4R+OT
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10318"; a="262170468"
X-IronPort-AV: E=Sophos;i="5.90,264,1643702400"; 
   d="scan'208";a="262170468"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2022 10:23:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,264,1643702400"; 
   d="scan'208";a="574891786"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.135])
  by orsmga008.jf.intel.com with ESMTP; 16 Apr 2022 10:23:10 -0700
Date:   Sun, 17 Apr 2022 01:15:38 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Nava kishore Manne <nava.manne@xilinx.com>
Cc:     mdf@kernel.org, hao.wu@intel.com, trix@redhat.com,
        michal.simek@xilinx.com, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        git@xilinx.com
Subject: Re: [PATCH v4 2/5] fpga: fix for coding style issues
Message-ID: <20220416171538.GB302575@yilunxu-OptiPlex-7050>
References: <20220416133719.3382895-1-nava.manne@xilinx.com>
 <20220416133719.3382895-3-nava.manne@xilinx.com>
 <20220416170257.GA302575@yilunxu-OptiPlex-7050>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220416170257.GA302575@yilunxu-OptiPlex-7050>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Sun, Apr 17, 2022 at 01:02:57AM +0800, Xu Yilun wrote:
> On Sat, Apr 16, 2022 at 07:07:16PM +0530, Nava kishore Manne wrote:
> > fixes the below checks reported by checkpatch.pl
> > Lines should not end with a '('
> > Alignment should match open parenthesis
> 
> Please help format the commit log, like:
> 
> fixes the below checks reported by checkpatch.pl:
> 
> - Lines should not end with a '('
> - Alignment should match open parenthesis
> 
> > 
> > Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
> 
> With the minor fixes, please add my Acked-by.
> 
> Acked-by: Xu Yilun <yilun.xu@intel.com>

Sorry, please also check Joe's comments

Thanks,
Yilun

> 
> > ---
> > Changes for v2:
> >                 -None.
> > Changes for v3:
> >                -Fixed similar issue exists in "drivers/fpga/*".
> > Changes for v4:
> >                -None.
> > 
> >  drivers/fpga/fpga-mgr.c    | 4 ++--
> >  drivers/fpga/fpga-region.c | 7 ++++---
> >  2 files changed, 6 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
> > index d49a9ce34568..a699cc8e2fa6 100644
> > --- a/drivers/fpga/fpga-mgr.c
> > +++ b/drivers/fpga/fpga-mgr.c
> > @@ -151,8 +151,8 @@ static int fpga_mgr_write_init_buf(struct fpga_manager *mgr,
> >  	if (!mgr->mops->initial_header_size)
> >  		ret = fpga_mgr_write_init(mgr, info, NULL, 0);
> >  	else
> > -		ret = fpga_mgr_write_init(
> > -		    mgr, info, buf, min(mgr->mops->initial_header_size, count));
> > +		ret = fpga_mgr_write_init(mgr, info, buf,
> > +					  min(mgr->mops->initial_header_size, count));
> >  
> >  	if (ret) {
> >  		dev_err(&mgr->dev, "Error preparing FPGA for writing\n");
> > diff --git a/drivers/fpga/fpga-region.c b/drivers/fpga/fpga-region.c
> > index b0ac18de4885..3864bf4f8920 100644
> > --- a/drivers/fpga/fpga-region.c
> > +++ b/drivers/fpga/fpga-region.c
> > @@ -18,9 +18,10 @@
> >  static DEFINE_IDA(fpga_region_ida);
> >  static struct class *fpga_region_class;
> >  
> > -struct fpga_region *fpga_region_class_find(
> > -	struct device *start, const void *data,
> > -	int (*match)(struct device *, const void *))
> > +struct fpga_region *fpga_region_class_find(struct device *start,
> > +					   const void *data,
> > +					   int (*match)(struct device *,
> > +							const void *))
> >  {
> >  	struct device *dev;
> >  
> > -- 
> > 2.25.1
