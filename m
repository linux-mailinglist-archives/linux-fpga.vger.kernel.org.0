Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FE8B383BC2
	for <lists+linux-fpga@lfdr.de>; Mon, 17 May 2021 19:55:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236604AbhEQR4k (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 17 May 2021 13:56:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:33192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238410AbhEQR4i (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 17 May 2021 13:56:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 86E296109E;
        Mon, 17 May 2021 17:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1621274122;
        bh=MixphLvOv3k+oCQIdL0BA9Ee7KCkQLfl/euWe6o1iyc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F4q8Ar1aACuyia+IdZi/1JWreSYQdUGt6R+5RUK3NopPAN3c1aZSlm9RjJFWVJdhF
         1UDo0Guf15H6DJSt9BHgBwpaEFTmbRq+7EsNphu14c3uDGFUWlmfXt4v5sGYGXLhPM
         MjKIrN+M34+rKmcxF7IYk+jniDUUQrmCa33ZW9t8=
Date:   Mon, 17 May 2021 19:55:17 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Russ Weight <russell.h.weight@intel.com>
Cc:     Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
        Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org,
        moritzf@google.com
Subject: Re: [PATCH 01/12] fpga: sec-mgr: fpga security manager class driver
Message-ID: <YKKuBSLp5Fe0Zh0v@kroah.com>
References: <20210517023200.52707-1-mdf@kernel.org>
 <20210517023200.52707-2-mdf@kernel.org>
 <YKH8qH9m1j5ubl9y@kroah.com>
 <0c54779e-4ac6-e816-e290-f613cfe1fff3@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0c54779e-4ac6-e816-e290-f613cfe1fff3@intel.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Mon, May 17, 2021 at 10:45:40AM -0700, Russ Weight wrote:
> Hi Greg,
> 
> On 5/16/21 10:18 PM, Greg KH wrote:
> > On Sun, May 16, 2021 at 07:31:49PM -0700, Moritz Fischer wrote:
> >> From: Russ Weight <russell.h.weight@intel.com>
> >>
> >> Create the FPGA Security Manager class driver. The security
> >> manager provides interfaces to manage secure updates for the
> >> FPGA and BMC images that are stored in FLASH. The driver can
> >> also be used to update root entry hashes and to cancel code
> >> signing keys. The image type is encoded in the image file
> >> and is decoded by the HW/FW secure update engine.
> >>
> >> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> > Russ, you know the Intel rules here, why did you not get someone who has
> > knowledge of the kernel's driver model to review your patches before
> > sending them out?
> >
> > Basic driver model review comments below, I'm stopping after reviewing
> > this one as there's some big failures here...
> >
> >> +++ b/drivers/fpga/fpga-sec-mgr.c
> >> @@ -0,0 +1,296 @@
> >> +// SPDX-License-Identifier: GPL-2.0
> >> +/*
> >> + * FPGA Security Manager
> >> + *
> >> + * Copyright (C) 2019-2020 Intel Corporation, Inc.
> > What year is it?  :(
> Thanks - I'll fix the copyright dates.
> >
> >> + */
> >> +
> >> +#include <linux/fpga/fpga-sec-mgr.h>
> >> +#include <linux/idr.h>
> >> +#include <linux/module.h>
> >> +#include <linux/slab.h>
> >> +#include <linux/vmalloc.h>
> >> +
> >> +static DEFINE_IDA(fpga_sec_mgr_ida);
> >> +static struct class *fpga_sec_mgr_class;
> >> +
> >> +struct fpga_sec_mgr_devres {
> >> +	struct fpga_sec_mgr *smgr;
> >> +};
> >> +
> >> +#define to_sec_mgr(d) container_of(d, struct fpga_sec_mgr, dev)
> >> +
> >> +static ssize_t name_show(struct device *dev,
> >> +			 struct device_attribute *attr, char *buf)
> >> +{
> >> +	struct fpga_sec_mgr *smgr = to_sec_mgr(dev);
> >> +
> >> +	return sysfs_emit(buf, "%s\n", smgr->name);
> >> +}
> >> +static DEVICE_ATTR_RO(name);
> > What is wrong with the name of the device?  Please just use that and do
> > not have a "second name" of the thing.
> The purpose was to display the name of the parent driver. Should I change
> "name" to "parent"? Or drop this altogether?

How is "name" a "parent"?  To find the parent, just walk up the sysfs
tree.

> Please note that in this and other cases, I have been conforming to
> conventions already used in FPGA Manager class driver:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/fpga/fpga-mgr.c#n397

Maybe that needs to be fixed as well :)

But, why re-implement the same thing and not just use the existing class
framework and code?


> >> +EXPORT_SYMBOL_GPL(fpga_sec_mgr_create);
> > Why did you not register the device here.
> My original implementation created and registered the device in a single function:
> 
> https://marc.info/?l=linux-fpga&m=159926365226264&w=2
> 
> It was split up to conform to the conventions used by other class drivers in the FPGA
> framework: fpga-mgr.c, fpga-bridge.c, fpga-region.c

If you don't need things to be split, don't split it.  Or better yet,
use the existing code.

> > There used to be some lovely documentation in the kernel that said I was
> > allowed to yell at anyone who did something like this.  But that's
> > removed, so I'll just be quiet and ask you to think about why you would
> > ever want to provide an empty function, just to make the kernel core "be
> > quiet".  Did you perhaps think you were smarter than the kobject core
> > and this was the proper solution to make it "shut up" with it's crazy
> > warning that some over-eager developer added?  Or perhaps, that warning
> > was there on purpose, lovingly hand-added to help provide a HUGE HINT
> > that not providing a REAL release function was wrong.
> 
> In my original submission, this function was populated.
> 
> https://marc.info/?l=linux-fpga&m=159926365226264&w=2
> 
> Again, I was conforming to conventions used in the other class drivers in
> the FPGA framework, all of which have an empty *_dev_release()
> function:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/fpga/fpga-mgr.c#n782
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/fpga/fpga-bridge.c#n476
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/fpga/fpga-region.c#n317

Oh wow, that's totally wrong and broken, thanks for pointing it out.
Please fix that up first.

thanks,

greg k-h
