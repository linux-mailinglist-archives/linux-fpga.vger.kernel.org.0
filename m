Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BAFF2E9081
	for <lists+linux-fpga@lfdr.de>; Mon,  4 Jan 2021 07:55:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727058AbhADGze (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 4 Jan 2021 01:55:34 -0500
Received: from mga04.intel.com ([192.55.52.120]:47382 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725830AbhADGze (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 4 Jan 2021 01:55:34 -0500
IronPort-SDR: ml73JsiLw06U0KNHurOulTEwDf52TzlFCjDX2/ndN0GbW67cESF7chfGubCrV+tuRh8mQBLc/L
 PxWEr0cPpb8w==
X-IronPort-AV: E=McAfee;i="6000,8403,9853"; a="174341016"
X-IronPort-AV: E=Sophos;i="5.78,473,1599548400"; 
   d="scan'208";a="174341016"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2021 22:54:53 -0800
IronPort-SDR: 2z+U459us5hzIQJW6mAIX6iCGGTsnurLhJrxl0BC4evJcdv3Lig4pgvnQ891X5j7smay7WjL7v
 UM400wT0vhMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,473,1599548400"; 
   d="scan'208";a="461839020"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.141])
  by fmsmga001.fm.intel.com with ESMTP; 03 Jan 2021 22:54:51 -0800
Date:   Mon, 4 Jan 2021 14:50:10 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     "Wu, Hao" <hao.wu@intel.com>
Cc:     "mdf@kernel.org" <mdf@kernel.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "trix@redhat.com" <trix@redhat.com>,
        "lgoncalv@redhat.com" <lgoncalv@redhat.com>
Subject: Re: [PATCH v5 2/2] Documentation: fpga: dfl: Add description for DFL
  UIO support
Message-ID: <20210104065010.GB4151@yilunxu-OptiPlex-7050>
References: <1609557182-20787-1-git-send-email-yilun.xu@intel.com>
 <1609557182-20787-3-git-send-email-yilun.xu@intel.com>
 <DM6PR11MB3819096D79EE63C4110EDBB485D20@DM6PR11MB3819.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR11MB3819096D79EE63C4110EDBB485D20@DM6PR11MB3819.namprd11.prod.outlook.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Mon, Jan 04, 2021 at 12:24:05PM +0800, Wu, Hao wrote:
> > Subject: [PATCH v5 2/2] Documentation: fpga: dfl: Add description for DFL
> > UIO support
> >
> > This patch adds description for UIO support for dfl devices on DFL
> > bus.
> >
> > Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> > ---
> > v2: no doc in v1, add it for v2.
> > v3: some documentation fixes.
> > v4: documentation change since the driver matching is changed.
> > v5: no change.
> > ---
> >  Documentation/fpga/dfl.rst | 24 ++++++++++++++++++++++++
> >  1 file changed, 24 insertions(+)
> >
> > diff --git a/Documentation/fpga/dfl.rst b/Documentation/fpga/dfl.rst
> > index 0404fe6..b8497f3 100644
> > --- a/Documentation/fpga/dfl.rst
> > +++ b/Documentation/fpga/dfl.rst
> > @@ -7,6 +7,7 @@ Authors:
> >  - Enno Luebbers <enno.luebbers@intel.com>
> >  - Xiao Guangrong <guangrong.xiao@linux.intel.com>
> >  - Wu Hao <hao.wu@intel.com>
> > +- Xu Yilun <yilun.xu@intel.com>
> >
> >  The Device Feature List (DFL) FPGA framework (and drivers according to
> >  this framework) hides the very details of low layer hardwares and provides
> > @@ -502,6 +503,29 @@ FME Partial Reconfiguration Sub Feature driver (see
> > drivers/fpga/dfl-fme-pr.c)
> >  could be a reference.
> >
> >
> > +UIO support for DFL devices
> > +===========================
> 
> I think the main purpose is to support userspace driver for DFL devices, and
> UIO is the option for now. Do you think if the title could be userspace driver
> support for DFL devices?

Yes, I could change it.

Thanks,
Yilun
