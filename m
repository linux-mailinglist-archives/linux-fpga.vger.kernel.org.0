Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38601269C6B
	for <lists+linux-fpga@lfdr.de>; Tue, 15 Sep 2020 05:18:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725953AbgIODSH (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 14 Sep 2020 23:18:07 -0400
Received: from mga18.intel.com ([134.134.136.126]:6343 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726019AbgIODSG (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 14 Sep 2020 23:18:06 -0400
IronPort-SDR: v3zL10ZwT09P6hRGVGH3S07rRVy1juKD1uHpQVqgNaVJoum1N7IkNmoSOfstB+XbAl1aSAknqE
 4ma+jfc0U3TQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9744"; a="146934396"
X-IronPort-AV: E=Sophos;i="5.76,428,1592895600"; 
   d="scan'208";a="146934396"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2020 20:18:03 -0700
IronPort-SDR: Z5KRvSstoA78fP+zfJc7mtdGhxa3G8wtpNupx5NWV753z1a0c7LlBZLn+1fWcTqdm/vNuic1bc
 9/suMbWJ7i4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,428,1592895600"; 
   d="scan'208";a="338494370"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.141])
  by fmsmga002.fm.intel.com with ESMTP; 14 Sep 2020 20:18:01 -0700
Date:   Tue, 15 Sep 2020 11:13:39 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Moritz Fischer <mdf@kernel.org>
Cc:     "Wu, Hao" <hao.wu@intel.com>, Tom Rix <trix@redhat.com>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "masahiroy@kernel.org" <masahiroy@kernel.org>,
        "lgoncalv@redhat.com" <lgoncalv@redhat.com>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        "Weight, Russell H" <russell.h.weight@intel.com>
Subject: Re: [PATCH 1/3] fpga: dfl: move dfl_device_id to mod_devicetable.h
Message-ID: <20200915031339.GC9950@yilunxu-OptiPlex-7050>
References: <1599544129-17594-1-git-send-email-yilun.xu@intel.com>
 <1599544129-17594-2-git-send-email-yilun.xu@intel.com>
 <aaa2d9a5-f5ae-d026-91c9-730403f04050@redhat.com>
 <20200910084106.GB16318@yilunxu-OptiPlex-7050>
 <ad9ba1cf-e02f-c09e-f639-2df60f080e5f@redhat.com>
 <DM6PR11MB3819E2EA499781899B7384F385240@DM6PR11MB3819.namprd11.prod.outlook.com>
 <20200914213232.GA1040@epycbox.lan>
 <20200915025516.GB9950@yilunxu-OptiPlex-7050>
 <20200915031014.GB1827@epycbox.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200915031014.GB1827@epycbox.lan>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Mon, Sep 14, 2020 at 08:10:14PM -0700, Moritz Fischer wrote:
> On Tue, Sep 15, 2020 at 10:55:17AM +0800, Xu Yilun wrote:
> > On Mon, Sep 14, 2020 at 02:32:32PM -0700, Moritz Fischer wrote:
> > > Hao,
> > > 
> > > On Fri, Sep 11, 2020 at 06:50:18AM +0000, Wu, Hao wrote:
> > > > > On 9/10/20 1:41 AM, Xu Yilun wrote:
> > > > > > On Wed, Sep 09, 2020 at 05:55:33AM -0700, Tom Rix wrote:
> > > > > >> On 9/7/20 10:48 PM, Xu Yilun wrote:
> > > > > >>> In order to support MODULE_DEVICE_TABLE() for dfl device driver, this
> > > > > >>> patch moves struct dfl_device_id to mod_devicetable.h
> > > > > >>>
> > > > > >>> Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> > > > > >>> Signed-off-by: Wu Hao <hao.wu@intel.com>
> > > > > >>> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> > > > > >>> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> > > > > >>> ---
> > > > > >>>  drivers/fpga/dfl.h              | 13 +------------
> > > > > >>>  include/linux/mod_devicetable.h | 12 ++++++++++++
> > > > > >>>  2 files changed, 13 insertions(+), 12 deletions(-)
> > > > > >>>
> > > > > >>> diff --git a/drivers/fpga/dfl.h b/drivers/fpga/dfl.h
> > > > > >>> index 5dc758f..d5b0760 100644
> > > > > >>> --- a/drivers/fpga/dfl.h
> > > > > >>> +++ b/drivers/fpga/dfl.h
> > > > > >>> @@ -26,6 +26,7 @@
> > > > > >>>  #include <linux/slab.h>
> > > > > >>>  #include <linux/uuid.h>
> > > > > >>>  #include <linux/fpga/fpga-region.h>
> > > > > >>> +#include <linux/mod_devicetable.h>
> > > > 
> > > > Please fix the order for the new one, other places to good to me.
> > > > Acked-by: Wu Hao <hao.wu@intel.com>  for DFL related changes after this fix.
> > > 
> > > Do you mean the order of the includes, like alphabeticized? If it's
> > > minor I can fix it up when applying.
> > 
> > I think it is the alphabetic of head files. I could sent v2 patchset for
> > this fix as well as other fixes.
> 
> Alright, works for me. Can you do that?

Yes, I'm working on it. :)

Thanks,
Yilun

> 
> - Moritz
