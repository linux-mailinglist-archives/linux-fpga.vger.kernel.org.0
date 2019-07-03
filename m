Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E4D55EFE0
	for <lists+linux-fpga@lfdr.de>; Thu,  4 Jul 2019 02:00:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727398AbfGDAAq (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 3 Jul 2019 20:00:46 -0400
Received: from mga05.intel.com ([192.55.52.43]:17869 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727100AbfGDAAq (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 3 Jul 2019 20:00:46 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Jul 2019 17:00:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,449,1557212400"; 
   d="scan'208";a="363198396"
Received: from hao-dev.bj.intel.com (HELO localhost) ([10.238.157.65])
  by fmsmga006.fm.intel.com with ESMTP; 03 Jul 2019 17:00:44 -0700
Date:   Thu, 4 Jul 2019 07:44:02 +0800
From:   Wu Hao <hao.wu@intel.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Ananda Ravuri <ananda.ravuri@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, Alan Tull <atull@kernel.org>
Subject: Re: [PATCH 04/15] fpga: dfl: fme: support 512bit data width PR
Message-ID: <20190703234402.GC15825@hao-dev>
References: <20190628004951.6202-1-mdf@kernel.org>
 <20190628004951.6202-5-mdf@kernel.org>
 <20190703175601.GA14034@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190703175601.GA14034@kroah.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Wed, Jul 03, 2019 at 07:56:01PM +0200, Greg KH wrote:
> On Thu, Jun 27, 2019 at 05:49:40PM -0700, Moritz Fischer wrote:
> > From: Wu Hao <hao.wu@intel.com>
> > 
> > In early partial reconfiguration private feature, it only
> > supports 32bit data width when writing data to hardware for
> > PR. 512bit data width PR support is an important optimization
> > for some specific solutions (e.g. XEON with FPGA integrated),
> > it allows driver to use AVX512 instruction to improve the
> > performance of partial reconfiguration. e.g. programming one
> > 100MB bitstream image via this 512bit data width PR hardware
> > only takes ~300ms, but 32bit revision requires ~3s per test
> > result.
> > 
> > Please note now this optimization is only done on revision 2
> > of this PR private feature which is only used in integrated
> > solution that AVX512 is always supported. This revision 2
> > hardware doesn't support 32bit PR.
> > 
> > Signed-off-by: Ananda Ravuri <ananda.ravuri@intel.com>
> > Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> > Signed-off-by: Wu Hao <hao.wu@intel.com>
> > Acked-by: Alan Tull <atull@kernel.org>
> > Signed-off-by: Moritz Fischer <mdf@kernel.org>
> > ---
> >  drivers/fpga/dfl-fme-main.c |   3 +
> >  drivers/fpga/dfl-fme-mgr.c  | 113 +++++++++++++++++++++++++++++++-----
> >  drivers/fpga/dfl-fme-pr.c   |  43 +++++++++-----
> >  drivers/fpga/dfl-fme.h      |   2 +
> >  drivers/fpga/dfl.h          |   5 ++
> >  5 files changed, 135 insertions(+), 31 deletions(-)
> > 
> > diff --git a/drivers/fpga/dfl-fme-main.c b/drivers/fpga/dfl-fme-main.c
> > index 086ad2420ade..076d74f6416d 100644
> > --- a/drivers/fpga/dfl-fme-main.c
> > +++ b/drivers/fpga/dfl-fme-main.c
> > @@ -21,6 +21,8 @@
> >  #include "dfl.h"
> >  #include "dfl-fme.h"
> >  
> > +#define DRV_VERSION	"0.8"
> > +
> >  static ssize_t ports_num_show(struct device *dev,
> >  			      struct device_attribute *attr, char *buf)
> >  {
> > @@ -277,3 +279,4 @@ MODULE_DESCRIPTION("FPGA Management Engine driver");
> >  MODULE_AUTHOR("Intel Corporation");
> >  MODULE_LICENSE("GPL v2");
> >  MODULE_ALIAS("platform:dfl-fme");
> > +MODULE_VERSION(DRV_VERSION);
> 
> No, we ripped out these useless "driver version" things all over the
> place, please do not add them back in again.  They mean nothing and
> confuse people to no end.
> 
> I'll not take this patch, sorry.

Let me remove them from these patches, and generate a new version quickly.

Thanks for the review and comments.

Hao

> 
> greg k-h
