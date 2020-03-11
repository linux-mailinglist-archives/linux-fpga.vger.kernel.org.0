Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E856180E48
	for <lists+linux-fpga@lfdr.de>; Wed, 11 Mar 2020 04:04:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727945AbgCKDE4 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 10 Mar 2020 23:04:56 -0400
Received: from mga12.intel.com ([192.55.52.136]:50823 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727506AbgCKDE4 (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 10 Mar 2020 23:04:56 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Mar 2020 20:04:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,539,1574150400"; 
   d="scan'208";a="289237204"
Received: from hao-dev.bj.intel.com (HELO localhost) ([10.238.157.65])
  by FMSMGA003.fm.intel.com with ESMTP; 10 Mar 2020 20:04:53 -0700
Date:   Wed, 11 Mar 2020 10:43:56 +0800
From:   Wu Hao <hao.wu@intel.com>
To:     Xu Yilun <yilun.xu@intel.com>
Cc:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, Luwei Kang <luwei.kang@intel.com>
Subject: Re: [PATCH 4/7] fpga: dfl: afu: add interrupt support for error
 reporting
Message-ID: <20200311024356.GA26202@hao-dev>
References: <1583749790-10837-1-git-send-email-yilun.xu@intel.com>
 <1583749790-10837-5-git-send-email-yilun.xu@intel.com>
 <20200310103921.GD28396@hao-dev>
 <20200310164738.GC30868@yilunxu-OptiPlex-7050>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200310164738.GC30868@yilunxu-OptiPlex-7050>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Wed, Mar 11, 2020 at 12:47:38AM +0800, Xu Yilun wrote:
> On Tue, Mar 10, 2020 at 06:39:21PM +0800, Wu Hao wrote:
> > On Mon, Mar 09, 2020 at 06:29:47PM +0800, Xu Yilun wrote:
> > > Error reporting interrupt is very useful to notify users that some
> > > errors are detected by the hardware. Once users are notified, they
> > > could query hardware logged error states, no need to continuously
> > > poll on these states.
> > > 
> > > This patch follows the common DFL interrupt notification and handling
> > > mechanism, implements two ioctl commands below for user to query
> > > hardware capability, and set/unset interrupt triggers.
> > > 
> > >  Ioctls:
> > >  * DFL_FPGA_PORT_ERR_GET_INFO
> > >    get error reporting feature info, including num_irqs which is used to
> > >    determine whether/how many interrupts it supports.
> > > 
> > >  * DFL_FPGA_PORT_ERR_SET_IRQ
> > >    set/unset given eventfds as error interrupt triggers.
> > > 
> > > Signed-off-by: Luwei Kang <luwei.kang@intel.com>
> > > Signed-off-by: Wu Hao <hao.wu@intel.com>
> > > Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> > > ---
> > >  drivers/fpga/dfl-afu-error.c  | 69 +++++++++++++++++++++++++++++++++++++++++++
> > >  drivers/fpga/dfl-afu-main.c   |  4 +++
> > >  include/uapi/linux/fpga-dfl.h | 34 +++++++++++++++++++++
> > >  3 files changed, 107 insertions(+)
> > > 
> > > diff --git a/drivers/fpga/dfl-afu-error.c b/drivers/fpga/dfl-afu-error.c
> > > index c1467ae..a2c5454 100644
> > > --- a/drivers/fpga/dfl-afu-error.c
> > > +++ b/drivers/fpga/dfl-afu-error.c
> > > @@ -15,6 +15,7 @@
> > >   */
> > >  
> > >  #include <linux/uaccess.h>
> > > +#include <linux/fpga-dfl.h>
> > >  
> > >  #include "dfl-afu.h"
> > >  
> > > @@ -219,6 +220,73 @@ static void port_err_uinit(struct platform_device *pdev,
> > >  	afu_port_err_mask(&pdev->dev, true);
> > >  }
> > >  
> > > +static long
> > > +port_err_get_info(struct platform_device *pdev,
> > > +		  struct dfl_feature *feature, unsigned long arg)
> > > +{
> > > +	struct dfl_fpga_port_err_info info;
> > > +
> > > +	info.flags = 0;
> > > +	info.capability = 0;
> > 
> > as flags and capability are not used at this moment, so actually it only exposes
> > irq information to user. I understand flags and capability are used for
> > future extension, but it may not work without argsz, as we never know what
> > comes next, e.g. a capability requires > 32bit can't fit into this ioctl.
> > So maybe just a ioctl for IRQ_INFO is enough for now.
> > 
> > How do you think?
> 
> Yes the flags & capability are for future extension.
> 
> The capability field is planned to a bitmask, each bit could indicate the feature
> has some capability or not. So it could describe up to 32 capabilities.
> I think it would be enough for one sub feature.
> 
> With this field, users could get a general description of capabilities with one
> ioctl. If some capability has more detailed info, we may add addtional ioctl to
> fetch it. This is how it works without argsz. Does it make sense?
> 
> And same definition for flag field. The flag fields could contain some
> bool running state represented by each bit.

This should work for some cases, but kernel doc (core-api/ioctl.rst) says it's
better to avoid bitfield completely. I understand it's possible to extend this
ioctl with flags and capability, even we can define if flags = A, then given 
capability = definition B, if flags = C, then capbaility definition is D, to
maximum the usage for extension, but it may make this interface very very
complicated to users. This should be the same reason why you didn't put irq
info into capability directly. Another reason is, in my understanding, it
choices ioctl to expose irq info becasue user must use ioctl to set irq, for
other capabilities which doesn't use device file, then some sysfs may be enough
for their own functions.

Thanks
Hao
