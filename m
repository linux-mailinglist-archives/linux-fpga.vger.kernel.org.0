Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DD9730338B
	for <lists+linux-fpga@lfdr.de>; Tue, 26 Jan 2021 05:59:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729936AbhAZE6S (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 25 Jan 2021 23:58:18 -0500
Received: from mga12.intel.com ([192.55.52.136]:15030 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730961AbhAZBmy (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 25 Jan 2021 20:42:54 -0500
IronPort-SDR: 2hZBl9ZYwJtE3YDDK3uIkdgpd0rLjiXSBbbgTtUntpC92imeLN0rTvuY/znC9UYluPhNbu7BSb
 x5l/zhyULiew==
X-IronPort-AV: E=McAfee;i="6000,8403,9875"; a="159010474"
X-IronPort-AV: E=Sophos;i="5.79,375,1602572400"; 
   d="scan'208";a="159010474"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2021 17:42:01 -0800
IronPort-SDR: 5MlRWDw70QwTghgTgw6xLgpclTJUgcqtcmx9Wwwl0rkmGHRqKJTpq8D0FsnxmYyFfdT+4MbYJA
 QTZnQA9YnNaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,375,1602572400"; 
   d="scan'208";a="429512742"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.141])
  by orsmga001.jf.intel.com with ESMTP; 25 Jan 2021 17:41:58 -0800
Date:   Tue, 26 Jan 2021 09:37:40 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Tom Rix <trix@redhat.com>
Cc:     gregkh@linuxfoundation.org, mdf@kernel.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        lgoncalv@redhat.com, hao.wu@intel.com, yilun.xu@intel.com
Subject: Re: [PATCH v9 1/2] uio: uio_dfl: add userspace i/o driver for DFL bus
Message-ID: <20210126013740.GA3907@yilunxu-OptiPlex-7050>
References: <1611564563-9665-1-git-send-email-yilun.xu@intel.com>
 <1611564563-9665-2-git-send-email-yilun.xu@intel.com>
 <e9bb1ff8-f630-f1a3-985c-7e51369a733f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e9bb1ff8-f630-f1a3-985c-7e51369a733f@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Mon, Jan 25, 2021 at 11:00:38AM -0800, Tom Rix wrote:
> 
> On 1/25/21 12:49 AM, Xu Yilun wrote:
> > This patch supports the DFL drivers be written in userspace. This is
> > realized by exposing the userspace I/O device interfaces.
> >
> > The driver now only binds the ether group feature, which has no irq. So
> > the irq support is not implemented yet.
> >
> > Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> > ---
> > v9: switch to add a uio driver in drivers/uio
> > ---
> >  drivers/uio/Kconfig   | 13 ++++++++++
> >  drivers/uio/Makefile  |  1 +
> >  drivers/uio/uio_dfl.c | 66 +++++++++++++++++++++++++++++++++++++++++++++++++++
> 
> You should add this to the MAINTAINERS file.

OK. I could add recored the file under "FPGA DFL DRIVERS"

> 
> >  3 files changed, 80 insertions(+)
> >  create mode 100644 drivers/uio/uio_dfl.c
> >
> > diff --git a/drivers/uio/Kconfig b/drivers/uio/Kconfig
> > index 202ee81..44778f8 100644
> > --- a/drivers/uio/Kconfig
> > +++ b/drivers/uio/Kconfig
> > @@ -165,4 +165,17 @@ config UIO_HV_GENERIC
> >  	  to network and storage devices from userspace.
> >  
> >  	  If you compile this as a module, it will be called uio_hv_generic.
> > +
> > +config UIO_DFL
> > +	tristate "Generic driver for DFL bus"
> 
> The term 'DFL' will be unknown to folks in drivers/uio
> 
> I think it would be better if DFL was always prefixed 'FPGA DFL'

The bus is named as "DFL bus", how about we add the full name like the
following help message.

  tristate "Generic driver for DFL (Device Feature List) bus"

> 
> > +	depends on FPGA_DFL
> > +	help
> > +	  Generic DFL (Device Feature List) driver for Userspace I/O devices.
> > +	  It is useful to provide direct access to DFL devices from userspace.
> > +	  A sample userspace application using this driver is available for
> > +	  download in a git repository:
> > +
> > +	    git clone https://github.com/OPAE/opae-sdk.git
> > +
> > +	  If you compile this as a module, it will be called uio_dfl.
> 
> opae-sdk is pretty large and uncovered in the Documentation/fpga/dfl.rst.
> 
> Where in opae-sdk is this example ?

You can find the example in tools/libopaeuio/. I could add the path in
help message.

Thanks,
Yilun

> 
> If you can point me at the example, I will turn it into a selftest.
