Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 572522FFC5D
	for <lists+linux-fpga@lfdr.de>; Fri, 22 Jan 2021 06:51:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726168AbhAVFvN (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 22 Jan 2021 00:51:13 -0500
Received: from mga18.intel.com ([134.134.136.126]:36489 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726103AbhAVFvN (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Fri, 22 Jan 2021 00:51:13 -0500
IronPort-SDR: w7Ga0/ZUvWeTgh3y3c7j2NaGKydDMjMR3svCaTO48BtYEdtn1Y4c4afNd0x7pWVr2T7btw6kLE
 aGaErB4u1trA==
X-IronPort-AV: E=McAfee;i="6000,8403,9871"; a="167072899"
X-IronPort-AV: E=Sophos;i="5.79,365,1602572400"; 
   d="scan'208";a="167072899"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2021 21:50:31 -0800
IronPort-SDR: XZkSWNq3AXELCUn582T8uPYolhF1zi7yBXVmJ4mdoQbbIVOFduwW2efVYYKn7BIVapXa9ikVXx
 o1pAW5YYvOVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,365,1602572400"; 
   d="scan'208";a="385622504"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.141])
  by orsmga008.jf.intel.com with ESMTP; 21 Jan 2021 21:50:29 -0800
Date:   Fri, 22 Jan 2021 13:46:02 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Moritz Fischer <mdf@kernel.org>
Cc:     Tom Rix <trix@redhat.com>, Greg KH <gregkh@linuxfoundation.org>,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        lgoncalv@redhat.com, hao.wu@intel.com, yilun.xu@intel.com
Subject: Re: [PATCH v6 1/2] fpga: dfl: add the userspace I/O device support
  for DFL devices
Message-ID: <20210122054602.GC1943@yilunxu-OptiPlex-7050>
References: <1610502848-30345-1-git-send-email-yilun.xu@intel.com>
 <1610502848-30345-2-git-send-email-yilun.xu@intel.com>
 <YARbgGU6lr3zZaKP@kroah.com>
 <YARkTFMrotPo45ic@epycbox.lan>
 <1d205328-6ffa-0f77-0bdf-0f4b822edc3a@redhat.com>
 <YAneI4AmuYqqqyUs@epycbox.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YAneI4AmuYqqqyUs@epycbox.lan>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Thu, Jan 21, 2021 at 12:03:47PM -0800, Moritz Fischer wrote:
> Hi Tom,
> 
> On Thu, Jan 21, 2021 at 06:30:20AM -0800, Tom Rix wrote:
> > 
> > On 1/17/21 8:22 AM, Moritz Fischer wrote:
> > > Greg,
> > >
> > > On Sun, Jan 17, 2021 at 04:45:04PM +0100, Greg KH wrote:
> > >> On Wed, Jan 13, 2021 at 09:54:07AM +0800, Xu Yilun wrote:
> > >>> This patch supports the DFL drivers be written in userspace. This is
> > >>> realized by exposing the userspace I/O device interfaces.
> > >>>
> > >>> The driver leverages the uio_pdrv_genirq, it adds the uio_pdrv_genirq
> > >>> platform device with the DFL device's resources, and let the generic UIO
> > >>> platform device driver provide support to userspace access to kernel
> > >>> interrupts and memory locations.
> > >> Why doesn't the existing uio driver work for this, why do you need a new
> > >> one?
> > >>
> > >>> ---
> > >>>  drivers/fpga/Kconfig        | 10 +++++
> > >>>  drivers/fpga/Makefile       |  1 +
> > >>>  drivers/fpga/dfl-uio-pdev.c | 93 +++++++++++++++++++++++++++++++++++++++++++++
> > >> uio drivers traditionally go in drivers/uio/ and start with "uio", so
> > >> shouldn't this be drivers/uio/uio_dfl_pdev.c to match the same naming
> > >> scheme?
> > > I had considered suggesting that, but ultimately this driver only
> > > creates a 'uio_pdrv_genirq' platform device, so it didn't seem like a
> > > good fit.
> > >> But again, you need to explain in detail, why the existing uio driver
> > >> doesn't work properly, or why you can't just add a few lines to an
> > >> existing one.
> > > Ultimately there are three options I see:
> > > 1) Do what Xu does, which is re-use the 'uio_pdrv_genirq' uio driver by
> > >   creating a platform device for it as sub-device of the dfl device that
> > >   we bind to uio_pdrv_genirq
> > > 2) Add a module_dfl_driver part to drivers/uio/uio_pdrv_genirq.c and
> > >   corresponding id table
> > > 3) Create a new uio_dfl_genirq kind of driver that uses the dfl bus and
> > >   that would make sense to then put into drivers/uio. (This would
> > >   duplicate code in uio_pdrv_genirq to some extend)
> > >
> > > Overall I think in terms of code re-use I think Xu's choice might be
> > > less new code as it simply wraps the uio platform device driver, and
> > > allows for defining the resources passed to the UIO driver to be defined
> > > by hardware through a DFL.
> > >
> > > I've seen the pattern that Xu proposed used in other places like the
> > > macb network driver where you'd have macb_main (the platform driver) and
> > > macb_pci that wraps it for a pci usage.
> > >
> > > - Moritz
> > 
> > Thinking of this problem more generally.
> > 
> > Every fpga will have a handful of sub devices.
> > 
> > Do we want to carry them in the fpga subsystem or carry them in the other subsystems ?
> 
> Yeah no we really don't. I think that was the point of the whole DFL
> bus :)
> > 
> > Consider the short term reviewing and long term maintenance of the sub devices by the subsystem maintainers.
> > 
> > It easier for them if the sub devices are in the other subsystems.
> 
> Agreed.
> > 
> > 
> > Applying this to specifically for dfl_uio.
> > 
> > No one from the uio subsystem reviewing this change is a problem.
> 
> Greg will.
> > I think this change needs to go to the uio subsystem.
> 
> Yeah I've thought about this some for the last few days, maybe it's
> easier that way.
> 
> Tbh, there's so little code here even if we went with option 3 above
> it's probably fairly short. It would set a better prcedent.
> 
> Xu, how do you feel about giving that a spin? See if option 3 will be
> way more code.

Yes, I'll try to put it to drivers/uio.

I see the implementation in vfio_platform.c/vfio_amba.c/vfio_platform_common.c.
I'm wondering if we could handle it in that way.

Thanks,
yilun
