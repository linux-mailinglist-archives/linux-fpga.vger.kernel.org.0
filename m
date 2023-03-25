Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CA3B6C8C4F
	for <lists+linux-fpga@lfdr.de>; Sat, 25 Mar 2023 08:51:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231461AbjCYHtf (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sat, 25 Mar 2023 03:49:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbjCYHtf (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sat, 25 Mar 2023 03:49:35 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A353CC2B;
        Sat, 25 Mar 2023 00:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679730574; x=1711266574;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FI9l8yK3Z4jLS2d3SFwLHKy3poC9MnSFlslPOykU5N8=;
  b=K6pfWbbKK65K5SwcxNQe2gyhKHTzfoqC0jUaM2U0u+qK8Z6z11ucsdV8
   lQ1sIIeu+Fxf8l370/NOvAqYg747owFRCJ4t4o00yzOn+jz/X+OWSoKSU
   mlRHmIaXMRJPf0WDeBaWOHBxBuubYtNchmHy6BeSV5buhXBPMBABEtsZO
   PsgX/1lxv/DwqGD5T+C9cgicR1ZeJ6mr0uTfgNOqcxXkCfSQeuNkVcL9C
   64ptp01VnazWsAT2u2xWT5zrtJmr1wcWpQNQFe0vxt59odIgBezfM3gxU
   A2hBdLDzXeWKjsQQW2EDGyKdAB9cUw2ya/aJuFnQukyQTmw6Yb/Os0073
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10659"; a="339973554"
X-IronPort-AV: E=Sophos;i="5.98,290,1673942400"; 
   d="scan'208";a="339973554"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2023 00:49:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10659"; a="793713002"
X-IronPort-AV: E=Sophos;i="5.98,290,1673942400"; 
   d="scan'208";a="793713002"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmsmga002.fm.intel.com with ESMTP; 25 Mar 2023 00:49:31 -0700
Date:   Sat, 25 Mar 2023 15:38:04 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Tom Rix <trix@redhat.com>
Cc:     Michal Simek <michal.simek@amd.com>, linux-kernel@vger.kernel.org,
        monstr@monstr.eu, michal.simek@xilinx.com, git@xilinx.com,
        Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-fpga@vger.kernel.org
Subject: Re: [PATCH] fpga: xilinx-pr-decoupler: Use readl wrapper instead of
 pure readl
Message-ID: <ZB6k3B64h4r1WQQZ@yilunxu-OptiPlex-7050>
References: <0381e4e8061c2fee182a104768e84feff3a82d25.1679412800.git.michal.simek@amd.com>
 <18e45db9-0b7d-abc3-5564-93968819f877@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <18e45db9-0b7d-abc3-5564-93968819f877@redhat.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 2023-03-21 at 10:10:14 -0700, Tom Rix wrote:
> 
> On 3/21/23 8:33 AM, Michal Simek wrote:
> > Driver has IO wrappers but xlnx_pr_decouple_read() is not used and readl is
> > used instead which is just wrong.
> > It is also generating sparse issue that xlnx_pr_decouple_read() is unused.
> > 
> > Signed-off-by: Michal Simek <michal.simek@amd.com>
> > ---
> > 
> > Created based on discussion with Tom here
> > https://lore.kernel.org/r/20230317230617.1673923-1-trix@redhat.com
> > ---
> >   drivers/fpga/xilinx-pr-decoupler.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/fpga/xilinx-pr-decoupler.c b/drivers/fpga/xilinx-pr-decoupler.c
> > index 2d9c491f7be9..b76d85449b8f 100644
> > --- a/drivers/fpga/xilinx-pr-decoupler.c
> > +++ b/drivers/fpga/xilinx-pr-decoupler.c
> > @@ -69,7 +69,7 @@ static int xlnx_pr_decoupler_enable_show(struct fpga_bridge *bridge)
> >   	if (err)
> >   		return err;
> > -	status = readl(priv->io_base);
> > +	status = xlnx_pr_decouple_read(priv, CTRL_OFFSET);
> 
> Thanks for the change.
> 
> Reviewed-by: Tom Rix <trix@redhat.com>

Acked-by: Xu Yilun <yilun.xu@intel.com>

Applied.

> 
> >   	clk_disable(priv->clk);
> 
