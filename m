Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5AB32948EA
	for <lists+linux-fpga@lfdr.de>; Wed, 21 Oct 2020 09:30:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440975AbgJUHat (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 21 Oct 2020 03:30:49 -0400
Received: from mga02.intel.com ([134.134.136.20]:34335 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2408056AbgJUHas (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 21 Oct 2020 03:30:48 -0400
IronPort-SDR: LoLdUGPu9XTTzK5wzgTmWVq7xcHdklouYGK9de3AoWZbcn5CtlkXpiVG+A0GguANBlPNVVNgjh
 w+bkyG6UVCJw==
X-IronPort-AV: E=McAfee;i="6000,8403,9780"; a="154278586"
X-IronPort-AV: E=Sophos;i="5.77,400,1596524400"; 
   d="scan'208";a="154278586"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2020 00:30:45 -0700
IronPort-SDR: bBM6nDfNp4Yg8K6VyS/CH+0GkbwCCZGoMVAwValT/SJuobHGwFpBZUz9Rm6AhTNSMgqCEpCDKj
 wnojZWjkfVdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,400,1596524400"; 
   d="scan'208";a="522657611"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.141])
  by fmsmga006.fm.intel.com with ESMTP; 21 Oct 2020 00:30:43 -0700
Date:   Wed, 21 Oct 2020 15:25:32 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Tom Rix <trix@redhat.com>, mdf@kernel.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        lgoncalv@redhat.com, hao.wu@intel.com, yilun.xu@intel.com
Subject: Re: [PATCH 1/2] fpga: dfl: add driver_override support
Message-ID: <20201021072532.GF16172@yilunxu-OptiPlex-7050>
References: <1602828151-24784-1-git-send-email-yilun.xu@intel.com>
 <1602828151-24784-2-git-send-email-yilun.xu@intel.com>
 <63d7730b-d9b8-c75d-16f6-3ebb507aabaa@redhat.com>
 <20201019040612.GA16172@yilunxu-OptiPlex-7050>
 <f767b9a0-1db8-7ced-6bd9-5ee1f58d40da@redhat.com>
 <20201020071158.GC28746@yilunxu-OptiPlex-7050>
 <20201020073259.GA3803984@kroah.com>
 <20201020085723.GE16172@yilunxu-OptiPlex-7050>
 <20201020092155.GA3879567@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201020092155.GA3879567@kroah.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi Greg,

On Tue, Oct 20, 2020 at 11:21:55AM +0200, Greg KH wrote:
> On Tue, Oct 20, 2020 at 04:57:23PM +0800, Xu Yilun wrote:
> > On Tue, Oct 20, 2020 at 09:32:59AM +0200, Greg KH wrote:
> > > On Tue, Oct 20, 2020 at 03:11:58PM +0800, Xu Yilun wrote:
> > > > I think it is normal case that a driver is successfully registered but
> > > > doesn't match any device because it provides no id_table.
> > > 
> > > How is that "normal"?  What would ever cause that driver to be bound to
> > > a device then?
> > 
> > This patchset adds the driver_override sysfs node, to let userspace
> > specify which driver (by name matching) to be bound to a device. The
> > driver "dfl-uio-pdev" doesn't provide an id_table, it could only be
> > bound to a device whose driver_override is set to "dfl-uio-pdev".
> > 
> > Sorry, this is actually not "normal". Usually dfl drivers with valid id_table
> > should be used to drive the dfl devices. But we also want to give an option
> > for userspace to take full control of the device, some IP blocks in FPGA are
> > written for specific purposes by FPGA user so a userspace driver may
> > serve them better.
> > 
> > > 
> > > And you better not say userspace is responsible for it...
> > 
> > Actually it is the userspace's decision which device they want to
> > access directly ...
> > 
> > I'm not sure if this idea is OK. I see similar implementation for
> > pci/platform devices.
> 
> That is there for debugging and for being able to support things when
> the kernel is not updated with a new device id yet.

We are trying to use the driver_override for similar purposes on FPGA.
The FPGA card could be reprogramed with a newly developed Hardware
component by users. Sometimes only the FPGA users know which dfl device
they want to operate on. This is why we give the option to users for
direct I/O access.

Also FPGA users have the requirement for diagnostic of the newly
developed components.

It is possible we define an id_table for dfl_uio_pdev driver, but then
users have to modify the driver code everytime they create & reprogram
a new HW component.

> 
> The virtio people took this to a new extreme and use it to bind real
> devices through to virtual machines, but really, that's horrid.  And
> they have problems with it as is seen in random patches at times.

Sorry I didn't have much knowledge on this.
Does the sysfs 'driver_override' or 'new_id' have problems, or the
userspace direct I/O access mechanism (UIO/VFIO) has problems?

If it is the former, I could consider some other way to generate the UIO
devices for DFL. But could you help specify more about the issues?

Thanks very much,
Yilun

> 
> Don't make this the only way to support this, that's not an ok api.
> 
> greg k-h
