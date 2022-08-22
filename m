Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B85C59B89C
	for <lists+linux-fpga@lfdr.de>; Mon, 22 Aug 2022 07:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232072AbiHVE6d (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 22 Aug 2022 00:58:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231694AbiHVE6c (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 22 Aug 2022 00:58:32 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8FDBE0E1;
        Sun, 21 Aug 2022 21:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661144311; x=1692680311;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/rA08EkKshgmbDIpcT1/pWksM4Su7kRxSiCqNoDLNEs=;
  b=nW4fMCJmW5ex5URirrhpeR8yvubYEuroknsNG6SijULXApGXGHqZsjom
   frMR/6ugGcoFdeukhj7lm+mKbvktquo7HeqVmXETrzZQdk3IZrQMNxb9U
   +xKzbcDf1fbu4P8FgSdUaL1IYXhpNUPeqR1oGaprDACW7p8YyPVxiNpXJ
   9D4Ehv1DEmk6nW0orFGaR/V2WZymrsEmcZJmT9QFDw8LomXvwnbTFLKQC
   8kmffL8mB7ZK+T139OksXa6496m4i+b8waukKcIcivKc7L2EdKDPhqsPE
   IytooClf+RXogoBAV6Yzd8av0Y7ZR/bcES7nLTydjlt3fpLn9slYkOHn/
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10446"; a="280289702"
X-IronPort-AV: E=Sophos;i="5.93,254,1654585200"; 
   d="scan'208";a="280289702"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2022 21:58:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,254,1654585200"; 
   d="scan'208";a="936880202"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmsmga005.fm.intel.com with ESMTP; 21 Aug 2022 21:58:27 -0700
Date:   Mon, 22 Aug 2022 12:49:16 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Russ Weight <russell.h.weight@intel.com>
Cc:     Peter Colberg <peter.colberg@intel.com>, Wu Hao <hao.wu@intel.com>,
        Tom Rix <trix@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        matthew.gerlach@linux.intel.com,
        basheer.ahmed.muddebihal@intel.com, tianfei.zhang@intel.com,
        marpagan@redhat.com, lgoncalv@redhat.com
Subject: Re: [PATCH v1] uio: dfl: add IOPLL user-clock feature id
Message-ID: <YwMKzC6HwjYqDxIs@yilunxu-OptiPlex-7050>
References: <20220817213746.4986-1-peter.colberg@intel.com>
 <Yv29ev8OKyEYcaf/@yilunxu-OptiPlex-7050>
 <acdf9c04-0816-5995-da90-c53153ffac59@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acdf9c04-0816-5995-da90-c53153ffac59@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 2022-08-18 at 17:38:35 -0600, Russ Weight wrote:
> 
> 
> On 8/17/22 21:18, Xu Yilun wrote:
> > On 2022-08-17 at 17:37:46 -0400, Peter Colberg wrote:
> >> Add a Device Feature List (DFL) feature id for the configurable
> >> IOPLL user clock source, which can be used to configure the clock
> >> speeds that are used for RTL logic that is programmed into the
> >> Partial Reconfiguration (PR) region of an FPGA.
> > Why not use linux clock framework for this IOPLL? And let the PR
> > driver set it togeter with the RTL logic reporgramming?
> 
> Hi Yilun,
> 
> We previously explored the possibility of plugging into the linux
> clock framework. For this device, setting a desired frequency is
> heavily dependent on a table of values that must be programmed in
> order to achieve the desired clock speeds.
> 
> Here is an example table, indexed by frequency. The first element
> in each entry is the frequency in kHz:
> 
> https://github.com/OPAE/opae-sdk/blob/master/libraries/plugins/xfpga/usrclk/fpga_user_clk_freq.h
> 
> We previously experimented with a kernel-space driver. The
> implementation exported a sysfs node into which the table values for
> the desired frequency would be written in order to set the desired
> frequency. The function of the driver was to execute the logic
> required to program the device. We did not think this implementation
> should be up-streamed.
> 
> It isn't practical to upstream the frequency tables as they are
> subject to change for future devices. For example, if the reference
> frequency changed in a future device, a whole new table of values would
> have to be added for the new device. In a recent transition to a new
> device, the range of frequencies was increased which required an
> extension to an existing table.

Making a table for the inputs & outputs is always a easier way to get
things done, but the trade off is, as you said, extension to the table
every time for new outputs.

So do we really need all parameters to be in a table, or these are
actually the outcome of some calculation? Is it possible just
Implementing the calculation.

If I remember correctly, linux clk framework enables a generic clk
caculation mechanism. It encourages people to model the internal
refclk, plls (and deviders?) separately and construct the clk tree.
Then the specified calculation could be simpler for each clk driver.

I'm not sure the clk framework fits all your need, but please
investigate it firstly.

> 
> A previous implementation of the user clock was also implemented in
> user-space. The kernel driver exported each of the registers, but
> all of the logic was implemented in user-space. The kernel portion
> can be viewed here:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/fpga/dfl-afu-main.c#n380
> 
> This is our reasoning in choosing to implement this driver in
> user-space. Would you consider a uio based user-space driver to
> be acceptable for in this case?

As usual, we firstly make clear why existing framework cannot fit the
case and should be implemented in userspace, then everything would be
OK.

Thanks,
Yilun

> 
> - Russ
> 
> 
> >
> > Thanks,
> > Yilun
> >
> >> The DFL feature id table can be found at:
> >> https://github.com/OPAE/dfl-feature-id
> >>
> >> Signed-off-by: Peter Colberg <peter.colberg@intel.com>
> >> ---
> >>  drivers/uio/uio_dfl.c | 2 ++
> >>  1 file changed, 2 insertions(+)
> >>
> >> diff --git a/drivers/uio/uio_dfl.c b/drivers/uio/uio_dfl.c
> >> index 8f39cc8bb034..69e93f3e7faf 100644
> >> --- a/drivers/uio/uio_dfl.c
> >> +++ b/drivers/uio/uio_dfl.c
> >> @@ -46,10 +46,12 @@ static int uio_dfl_probe(struct dfl_device *ddev)
> >>  
> >>  #define FME_FEATURE_ID_ETH_GROUP	0x10
> >>  #define FME_FEATURE_ID_HSSI_SUBSYS	0x15
> >> +#define PORT_FEATURE_ID_IOPLL_USRCLK	0x14
> >>  
> >>  static const struct dfl_device_id uio_dfl_ids[] = {
> >>  	{ FME_ID, FME_FEATURE_ID_ETH_GROUP },
> >>  	{ FME_ID, FME_FEATURE_ID_HSSI_SUBSYS },
> >> +	{ PORT_ID, PORT_FEATURE_ID_IOPLL_USRCLK },
> >>  	{ }
> >>  };
> >>  MODULE_DEVICE_TABLE(dfl, uio_dfl_ids);
> >> -- 
> >> 2.28.0
> >>
> 
