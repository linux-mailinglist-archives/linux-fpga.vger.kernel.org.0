Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3F31303390
	for <lists+linux-fpga@lfdr.de>; Tue, 26 Jan 2021 05:59:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730043AbhAZE6d (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 25 Jan 2021 23:58:33 -0500
Received: from mga14.intel.com ([192.55.52.115]:36862 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732372AbhAZCpJ (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 25 Jan 2021 21:45:09 -0500
IronPort-SDR: 4FzgPWkLkKrJT5/46yApxVDuWLYoxOZISC7c+FeZ+SFUTJYfsP/gp4Z9mnDUW3DTP0fSFP4ohx
 91WYDMD24kag==
X-IronPort-AV: E=McAfee;i="6000,8403,9875"; a="179060470"
X-IronPort-AV: E=Sophos;i="5.79,375,1602572400"; 
   d="scan'208";a="179060470"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2021 18:44:26 -0800
IronPort-SDR: 0mLY8EDgJmwlZcGnqrZDfHjQ45RmKp4Li0V8hFPAUp7AlkxFr299tjqBpzpAv9WdtVfRLYETSj
 ilesyGXlUHmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,375,1602572400"; 
   d="scan'208";a="368954150"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.141])
  by orsmga002.jf.intel.com with ESMTP; 25 Jan 2021 18:44:24 -0800
Date:   Tue, 26 Jan 2021 10:40:05 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Moritz Fischer <mdf@kernel.org>
Cc:     Tom Rix <trix@redhat.com>, gregkh@linuxfoundation.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        lgoncalv@redhat.com, hao.wu@intel.com
Subject: Re: [PATCH v9 1/2] uio: uio_dfl: add userspace i/o driver for DFL bus
Message-ID: <20210126024005.GB3907@yilunxu-OptiPlex-7050>
References: <1611564563-9665-1-git-send-email-yilun.xu@intel.com>
 <1611564563-9665-2-git-send-email-yilun.xu@intel.com>
 <e9bb1ff8-f630-f1a3-985c-7e51369a733f@redhat.com>
 <YA98/8r+yOCurHAJ@epycbox.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YA98/8r+yOCurHAJ@epycbox.lan>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Mon, Jan 25, 2021 at 06:22:55PM -0800, Moritz Fischer wrote:
> On Mon, Jan 25, 2021 at 11:00:38AM -0800, Tom Rix wrote:
> > 
> > On 1/25/21 12:49 AM, Xu Yilun wrote:
> > > This patch supports the DFL drivers be written in userspace. This is
> > > realized by exposing the userspace I/O device interfaces.
> > >
> > > The driver now only binds the ether group feature, which has no irq. So
> > > the irq support is not implemented yet.
> > >
> > > Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> > > ---
> > > v9: switch to add a uio driver in drivers/uio
> > > ---
> > >  drivers/uio/Kconfig   | 13 ++++++++++
> > >  drivers/uio/Makefile  |  1 +
> > >  drivers/uio/uio_dfl.c | 66 +++++++++++++++++++++++++++++++++++++++++++++++++++
> > 
> > You should add this to the MAINTAINERS file.
> 
> This is covered by MAINTAINERS under drivers/uio.

Yes. But is it OK I also add the file in "FPGA DFL DRIVERS"? So DFL
developers would also be aware if there is change. It is a little
different from other feature driver, it is like a generic driver for
DFL bus.

> > 
> > >  3 files changed, 80 insertions(+)
> > >  create mode 100644 drivers/uio/uio_dfl.c
> > >
> > > diff --git a/drivers/uio/Kconfig b/drivers/uio/Kconfig
> > > index 202ee81..44778f8 100644
> > > --- a/drivers/uio/Kconfig
> > > +++ b/drivers/uio/Kconfig
> > > @@ -165,4 +165,17 @@ config UIO_HV_GENERIC
> > >  	  to network and storage devices from userspace.
> > >  
> > >  	  If you compile this as a module, it will be called uio_hv_generic.
> > > +
> > > +config UIO_DFL
> > > +	tristate "Generic driver for DFL bus"
> > 
> > The term 'DFL' will be unknown to folks in drivers/uio
> > 
> > I think it would be better if DFL was always prefixed 'FPGA DFL'
> > 
> > > +	depends on FPGA_DFL
> > > +	help
> > > +	  Generic DFL (Device Feature List) driver for Userspace I/O devices.
> > > +	  It is useful to provide direct access to DFL devices from userspace.
> > > +	  A sample userspace application using this driver is available for
> > > +	  download in a git repository:
> > > +
> > > +	    git clone https://github.com/OPAE/opae-sdk.git
> > > +
> > > +	  If you compile this as a module, it will be called uio_dfl.
> 
> I'm not sure KConfig is the right place for this.

Do you mean the OPAE link? I see several uio drivers provide their
userspace application link in Kconfig. I guess the uio drivers are
selected for these applications so it may be better pointing out where
they are.

Thanks,
Yilun
