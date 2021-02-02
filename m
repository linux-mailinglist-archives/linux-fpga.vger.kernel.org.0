Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB23C30B500
	for <lists+linux-fpga@lfdr.de>; Tue,  2 Feb 2021 03:05:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbhBBCE4 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 1 Feb 2021 21:04:56 -0500
Received: from mga09.intel.com ([134.134.136.24]:10335 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229621AbhBBCEz (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 1 Feb 2021 21:04:55 -0500
IronPort-SDR: 2i9hCs4Rf3a5UCPl0C5Uhr2v9yLu1YITpix/XKj+TC9IEyGiKLngGxbG1UZOdlWbuZAxKFy6Wl
 DzDeA21eiheQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9882"; a="180927387"
X-IronPort-AV: E=Sophos;i="5.79,393,1602572400"; 
   d="scan'208";a="180927387"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2021 18:04:14 -0800
IronPort-SDR: Ya1tBNlSrP/D+LJj+jmlcaG6sbh7cYOKsHxXEOVZ8gVRNVejU+OfKVUA5gmLGcegSFJy8BEKY2
 CwCEpIhsxyAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,393,1602572400"; 
   d="scan'208";a="371776200"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.141])
  by orsmga002.jf.intel.com with ESMTP; 01 Feb 2021 18:04:10 -0800
Date:   Tue, 2 Feb 2021 09:59:47 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     "Wu, Hao" <hao.wu@intel.com>
Cc:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "mdf@kernel.org" <mdf@kernel.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "trix@redhat.com" <trix@redhat.com>,
        "lgoncalv@redhat.com" <lgoncalv@redhat.com>
Subject: Re: [PATCH v10 2/2] Documentation: fpga: dfl: Add description for
 DFL  UIO support
Message-ID: <20210202015947.GA18237@yilunxu-OptiPlex-7050>
References: <1612157883-18616-1-git-send-email-yilun.xu@intel.com>
 <1612157883-18616-3-git-send-email-yilun.xu@intel.com>
 <DM6PR11MB3819D4E1E69EE4FE405864F685B69@DM6PR11MB3819.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR11MB3819D4E1E69EE4FE405864F685B69@DM6PR11MB3819.namprd11.prod.outlook.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Mon, Feb 01, 2021 at 08:59:06PM +0800, Wu, Hao wrote:
> > Subject: [PATCH v10 2/2] Documentation: fpga: dfl: Add description for DFL UIO
> > support
> >
> > This patch adds description for UIO support for dfl devices on DFL
> > bus.
> >
> > Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> > Reviewed-by: Tom Rix <trix@redhat.com>
> > ---
> > v2: no doc in v1, add it for v2.
> > v3: some documentation fixes.
> > v4: documentation change since the driver matching is changed.
> > v5: no change.
> > v6: improve the title of the userspace driver support section.
> >     some word improvement.
> > v7: rebased to next-20210119
> > v8: some doc fixes.
> > v9: some doc change since we switch to the driver in drivers/uio.
> > v10: no change.
> > ---
> >  Documentation/fpga/dfl.rst | 23 +++++++++++++++++++++++
> >  1 file changed, 23 insertions(+)
> >
> > diff --git a/Documentation/fpga/dfl.rst b/Documentation/fpga/dfl.rst
> > index c41ac76..e35cf87 100644
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
> > @@ -530,6 +531,28 @@ Being able to specify more than one DFL per BAR has
> > been considered, but it
> >  was determined the use case did not provide value.  Specifying a single DFL
> >  per BAR simplifies the implementation and allows for extra error checking.
> >
> > +
> > +Userspace driver support for DFL devices
> > +========================================
> > +The purpose of an FPGA is to be reprogrammed with newly developed
> > hardware
> > +components. New hardware can instantiate a new private feature in the DFL,
> > and
> > +then present a DFL device in the system. In some cases users may need a
> > +userspace driver for the DFL device:
> > +
> > +* Users may need to run some diagnostic test for their hardware.
> > +* Users may prototype the kernel driver in user space.
> > +* Some hardware is designed for specific purposes and does not fit into one of
> > +  the standard kernel subsystems.
> > +
> > +This requires direct access to MMIO space and interrupt handling from
> > +userspace. The uio_dfl module exposes the UIO device interfaces for this
> > +purpose.
> 
> Current uio_dfl doesn't have interrupt handling support, right? I guess we need
> to make sure no confusion on the description here. other place looks good to me.

Will fix it.

Thanks,
Yilun
