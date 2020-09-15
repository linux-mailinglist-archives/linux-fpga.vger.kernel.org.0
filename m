Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69730269C35
	for <lists+linux-fpga@lfdr.de>; Tue, 15 Sep 2020 04:59:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726067AbgIOC7m (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 14 Sep 2020 22:59:42 -0400
Received: from mga11.intel.com ([192.55.52.93]:51420 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726045AbgIOC7m (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 14 Sep 2020 22:59:42 -0400
IronPort-SDR: MHxmn/Zlgf3OiJaqGqpuEvYBTsfAl6m/oWGDZLBJ/0vnZiv7ElUS/MlEFrqa0SLn99t+RN2o2C
 3lot6/FyKKXw==
X-IronPort-AV: E=McAfee;i="6000,8403,9744"; a="156622308"
X-IronPort-AV: E=Sophos;i="5.76,428,1592895600"; 
   d="scan'208";a="156622308"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2020 19:59:41 -0700
IronPort-SDR: opEiUrKYdI2KWFuS5toA8jBpI7xsdN4wPSbROCjvfm2AKOfZ+9P4feww3FmY1nFWLvYs2eSXQd
 YpSIGCfgRN6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,428,1592895600"; 
   d="scan'208";a="451120905"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.141])
  by orsmga004.jf.intel.com with ESMTP; 14 Sep 2020 19:59:39 -0700
Date:   Tue, 15 Sep 2020 10:55:17 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Moritz Fischer <mdf@kernel.org>
Cc:     "Wu, Hao" <hao.wu@intel.com>, Tom Rix <trix@redhat.com>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "masahiroy@kernel.org" <masahiroy@kernel.org>,
        "lgoncalv@redhat.com" <lgoncalv@redhat.com>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        "Weight, Russell H" <russell.h.weight@intel.com>,
        yilun.xu@intel.com
Subject: Re: [PATCH 1/3] fpga: dfl: move dfl_device_id to mod_devicetable.h
Message-ID: <20200915025516.GB9950@yilunxu-OptiPlex-7050>
References: <1599544129-17594-1-git-send-email-yilun.xu@intel.com>
 <1599544129-17594-2-git-send-email-yilun.xu@intel.com>
 <aaa2d9a5-f5ae-d026-91c9-730403f04050@redhat.com>
 <20200910084106.GB16318@yilunxu-OptiPlex-7050>
 <ad9ba1cf-e02f-c09e-f639-2df60f080e5f@redhat.com>
 <DM6PR11MB3819E2EA499781899B7384F385240@DM6PR11MB3819.namprd11.prod.outlook.com>
 <20200914213232.GA1040@epycbox.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200914213232.GA1040@epycbox.lan>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Mon, Sep 14, 2020 at 02:32:32PM -0700, Moritz Fischer wrote:
> Hao,
> 
> On Fri, Sep 11, 2020 at 06:50:18AM +0000, Wu, Hao wrote:
> > > On 9/10/20 1:41 AM, Xu Yilun wrote:
> > > > On Wed, Sep 09, 2020 at 05:55:33AM -0700, Tom Rix wrote:
> > > >> On 9/7/20 10:48 PM, Xu Yilun wrote:
> > > >>> In order to support MODULE_DEVICE_TABLE() for dfl device driver, this
> > > >>> patch moves struct dfl_device_id to mod_devicetable.h
> > > >>>
> > > >>> Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> > > >>> Signed-off-by: Wu Hao <hao.wu@intel.com>
> > > >>> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> > > >>> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> > > >>> ---
> > > >>>  drivers/fpga/dfl.h              | 13 +------------
> > > >>>  include/linux/mod_devicetable.h | 12 ++++++++++++
> > > >>>  2 files changed, 13 insertions(+), 12 deletions(-)
> > > >>>
> > > >>> diff --git a/drivers/fpga/dfl.h b/drivers/fpga/dfl.h
> > > >>> index 5dc758f..d5b0760 100644
> > > >>> --- a/drivers/fpga/dfl.h
> > > >>> +++ b/drivers/fpga/dfl.h
> > > >>> @@ -26,6 +26,7 @@
> > > >>>  #include <linux/slab.h>
> > > >>>  #include <linux/uuid.h>
> > > >>>  #include <linux/fpga/fpga-region.h>
> > > >>> +#include <linux/mod_devicetable.h>
> > 
> > Please fix the order for the new one, other places to good to me.
> > Acked-by: Wu Hao <hao.wu@intel.com>  for DFL related changes after this fix.
> 
> Do you mean the order of the includes, like alphabeticized? If it's
> minor I can fix it up when applying.

I think it is the alphabetic of head files. I could sent v2 patchset for
this fix as well as other fixes.

Thanks,
Yilun.

> 
> Thanks,
> Moritz
