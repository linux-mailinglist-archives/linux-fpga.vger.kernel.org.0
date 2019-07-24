Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1FAB72FBE
	for <lists+linux-fpga@lfdr.de>; Wed, 24 Jul 2019 15:20:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727455AbfGXNUs (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 24 Jul 2019 09:20:48 -0400
Received: from mga04.intel.com ([192.55.52.120]:13080 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726981AbfGXNUr (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 24 Jul 2019 09:20:47 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Jul 2019 06:20:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,303,1559545200"; 
   d="scan'208";a="368787055"
Received: from hao-dev.bj.intel.com (HELO localhost) ([10.238.157.65])
  by fmsmga005.fm.intel.com with ESMTP; 24 Jul 2019 06:20:44 -0700
Date:   Wed, 24 Jul 2019 21:03:47 +0800
From:   Wu Hao <hao.wu@intel.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-doc@vger.kernel.org, atull@kernel.org,
        Xu Yilun <yilun.xu@intel.com>
Subject: Re: [PATCH v3 09/12] fpga: dfl: afu: add STP (SignalTap) support
Message-ID: <20190724130346.GA8463@hao-dev>
References: <1563857495-26692-1-git-send-email-hao.wu@intel.com>
 <1563857495-26692-10-git-send-email-hao.wu@intel.com>
 <20190724101109.GE29532@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190724101109.GE29532@kroah.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Wed, Jul 24, 2019 at 12:11:09PM +0200, Greg KH wrote:
> On Tue, Jul 23, 2019 at 12:51:32PM +0800, Wu Hao wrote:
> > STP (SignalTap) is one of the private features under the port for
> > debugging. This patch adds private feature driver support for it
> > to allow userspace applications to mmap related mmio region and
> > provide STP service.
> > 
> > Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> > Signed-off-by: Wu Hao <hao.wu@intel.com>
> > Acked-by: Moritz Fischer <mdf@kernel.org>
> > Acked-by: Alan Tull <atull@kernel.org>
> > Signed-off-by: Moritz Fischer <mdf@kernel.org>
> > ---
> >  drivers/fpga/dfl-afu-main.c | 34 ++++++++++++++++++++++++++++++++++
> >  1 file changed, 34 insertions(+)
> > 
> > diff --git a/drivers/fpga/dfl-afu-main.c b/drivers/fpga/dfl-afu-main.c
> > index 15dd4cb..395f96e 100644
> > --- a/drivers/fpga/dfl-afu-main.c
> > +++ b/drivers/fpga/dfl-afu-main.c
> > @@ -514,6 +514,36 @@ static void port_afu_uinit(struct platform_device *pdev,
> >  	.uinit = port_afu_uinit,
> >  };
> >  
> > +static int port_stp_init(struct platform_device *pdev,
> > +			 struct dfl_feature *feature)
> > +{
> > +	struct resource *res = &pdev->resource[feature->resource_index];
> > +
> > +	dev_dbg(&pdev->dev, "PORT STP Init.\n");
> 
> ftrace is your friend, no need to do a lot of "look I am here!"
> messages.

Hi Greg,

Thanks for the code review!

Sure, let me remove them.

> 
> > +
> > +	return afu_mmio_region_add(dev_get_platdata(&pdev->dev),
> > +				   DFL_PORT_REGION_INDEX_STP,
> > +				   resource_size(res), res->start,
> > +				   DFL_PORT_REGION_MMAP | DFL_PORT_REGION_READ |
> > +				   DFL_PORT_REGION_WRITE);
> > +}
> > +
> > +static void port_stp_uinit(struct platform_device *pdev,
> > +			   struct dfl_feature *feature)
> > +{
> > +	dev_dbg(&pdev->dev, "PORT STP UInit.\n");
> 
> Same here.
> 
> Why have this function at all if it does not do anything?

Let me remove them in the next version. actually uinit callback is
always required in current code, i will add one more patch to change
it, and remove all uinit functions who do nothing, it does save code.

Thanks for the comments.
Hao

> 
> 
> thanks,
> 
> greg k-h
