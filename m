Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC6898428E
	for <lists+linux-fpga@lfdr.de>; Wed,  7 Aug 2019 04:38:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727541AbfHGCiY (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 6 Aug 2019 22:38:24 -0400
Received: from mga11.intel.com ([192.55.52.93]:39432 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726238AbfHGCiY (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 6 Aug 2019 22:38:24 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Aug 2019 19:38:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,353,1559545200"; 
   d="scan'208";a="374254553"
Received: from hao-dev.bj.intel.com (HELO localhost) ([10.238.157.65])
  by fmsmga006.fm.intel.com with ESMTP; 06 Aug 2019 19:38:22 -0700
Date:   Wed, 7 Aug 2019 10:21:14 +0800
From:   Wu Hao <hao.wu@intel.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-doc@vger.kernel.org, atull@kernel.org,
        Xu Yilun <yilun.xu@intel.com>
Subject: Re: [PATCH v4 06/12] fpga: dfl: afu: export __port_enable/disable
 function.
Message-ID: <20190807022114.GB24158@hao-dev>
References: <1564914022-3710-1-git-send-email-hao.wu@intel.com>
 <1564914022-3710-7-git-send-email-hao.wu@intel.com>
 <20190805155240.GB8107@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190805155240.GB8107@kroah.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Mon, Aug 05, 2019 at 05:52:40PM +0200, Greg KH wrote:
> On Sun, Aug 04, 2019 at 06:20:16PM +0800, Wu Hao wrote:
> > As these two functions are used by other private features. e.g.
> > in error reporting private feature, it requires to check port status
> > and reset port for error clearing.
> > 
> > Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> > Signed-off-by: Wu Hao <hao.wu@intel.com>
> > Acked-by: Moritz Fischer <mdf@kernel.org>
> > Acked-by: Alan Tull <atull@kernel.org>
> > Signed-off-by: Moritz Fischer <mdf@kernel.org>
> > ---
> > v2: rebased
> > ---
> >  drivers/fpga/dfl-afu-main.c | 25 ++++++++++++++-----------
> >  drivers/fpga/dfl-afu.h      |  3 +++
> >  2 files changed, 17 insertions(+), 11 deletions(-)
> > 
> > diff --git a/drivers/fpga/dfl-afu-main.c b/drivers/fpga/dfl-afu-main.c
> > index e013afb..e312179 100644
> > --- a/drivers/fpga/dfl-afu-main.c
> > +++ b/drivers/fpga/dfl-afu-main.c
> > @@ -22,14 +22,16 @@
> >  #include "dfl-afu.h"
> >  
> >  /**
> > - * port_enable - enable a port
> > + * __port_enable - enable a port
> >   * @pdev: port platform device.
> >   *
> >   * Enable Port by clear the port soft reset bit, which is set by default.
> >   * The AFU is unable to respond to any MMIO access while in reset.
> > - * port_enable function should only be used after port_disable function.
> > + * __port_enable function should only be used after __port_disable function.
> > + *
> > + * The caller needs to hold lock for protection.
> >   */
> > -static void port_enable(struct platform_device *pdev)
> > +void __port_enable(struct platform_device *pdev)
> 
> worst global function name ever.
> 
> Don't polute the global namespace like this for a single driver.  If you
> REALLY need it, then use a prefix that shows it is your individual
> dfl_special_sauce_platform_device_only type thing.

Oh.. Sure.. Let me fix the naming in the next version.

Thanks
Hao

> 
> thanks,
> 
> greg k-h
