Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 040EA2AAF88
	for <lists+linux-fpga@lfdr.de>; Mon,  9 Nov 2020 03:34:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728038AbgKICek (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 8 Nov 2020 21:34:40 -0500
Received: from mga06.intel.com ([134.134.136.31]:51647 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727979AbgKICej (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Sun, 8 Nov 2020 21:34:39 -0500
IronPort-SDR: Z4F0vFRkMVNgNYbpbHMy58FXJKGzfgLwqZetjuFOKCdvm5qASW7LV0+YPc+FLPp5HKPu4LaM2r
 dpYCzIeWDwAQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9799"; a="231373440"
X-IronPort-AV: E=Sophos;i="5.77,462,1596524400"; 
   d="scan'208";a="231373440"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2020 18:34:39 -0800
IronPort-SDR: itYGC9v0LHGCxhP5S2nEKYai4kuU32UywDgXZQyMygnDAaDcqdvYTJ3aTOwrlUp9qD+ZeOXeZX
 am9fdUamWDZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,462,1596524400"; 
   d="scan'208";a="355474868"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.141])
  by fmsmga004.fm.intel.com with ESMTP; 08 Nov 2020 18:34:37 -0800
Date:   Mon, 9 Nov 2020 10:30:38 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Tom Rix <trix@redhat.com>, mdf@kernel.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        lgoncalv@redhat.com, hao.wu@intel.com, yilun.xu@intel.com
Subject: Re: [PATCH 1/2] fpga: dfl: add driver_override support
Message-ID: <20201109023038.GA3426@yilunxu-OptiPlex-7050>
References: <1602828151-24784-1-git-send-email-yilun.xu@intel.com>
 <1602828151-24784-2-git-send-email-yilun.xu@intel.com>
 <63d7730b-d9b8-c75d-16f6-3ebb507aabaa@redhat.com>
 <20201019040612.GA16172@yilunxu-OptiPlex-7050>
 <f767b9a0-1db8-7ced-6bd9-5ee1f58d40da@redhat.com>
 <20201020071158.GC28746@yilunxu-OptiPlex-7050>
 <20201020073259.GA3803984@kroah.com>
 <20201020085723.GE16172@yilunxu-OptiPlex-7050>
 <20201020092155.GA3879567@kroah.com>
 <20201021072532.GF16172@yilunxu-OptiPlex-7050>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201021072532.GF16172@yilunxu-OptiPlex-7050>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi Greg,

We created a 'driver_override' api for dfl bus, and a driver for
userspace I/O access for dfl devices.

Some new comments inline.

On Wed, Oct 21, 2020 at 03:25:32PM +0800, Xu Yilun wrote:
> Hi Greg,
> 
> On Tue, Oct 20, 2020 at 11:21:55AM +0200, Greg KH wrote:
> > On Tue, Oct 20, 2020 at 04:57:23PM +0800, Xu Yilun wrote:
> > > On Tue, Oct 20, 2020 at 09:32:59AM +0200, Greg KH wrote:
> > > > On Tue, Oct 20, 2020 at 03:11:58PM +0800, Xu Yilun wrote:
> > > > > I think it is normal case that a driver is successfully registered but
> > > > > doesn't match any device because it provides no id_table.
> > > > 
> > > > How is that "normal"?  What would ever cause that driver to be bound to
> > > > a device then?
> > > 
> > > This patchset adds the driver_override sysfs node, to let userspace
> > > specify which driver (by name matching) to be bound to a device. The
> > > driver "dfl-uio-pdev" doesn't provide an id_table, it could only be
> > > bound to a device whose driver_override is set to "dfl-uio-pdev".
> > > 
> > > Sorry, this is actually not "normal". Usually dfl drivers with valid id_table
> > > should be used to drive the dfl devices. But we also want to give an option
> > > for userspace to take full control of the device, some IP blocks in FPGA are
> > > written for specific purposes by FPGA user so a userspace driver may
> > > serve them better.
> > > 
> > > > 
> > > > And you better not say userspace is responsible for it...
> > > 
> > > Actually it is the userspace's decision which device they want to
> > > access directly ...
> > > 
> > > I'm not sure if this idea is OK. I see similar implementation for
> > > pci/platform devices.
> > 
> > That is there for debugging and for being able to support things when
> > the kernel is not updated with a new device id yet.
> 
> We are trying to use the driver_override for similar purposes on FPGA.
> The FPGA card could be reprogramed with a newly developed Hardware
> component by users. Sometimes only the FPGA users know which dfl device
> they want to operate on. This is why we give the option to users for
> direct I/O access.
> 
> Also FPGA users have the requirement for diagnostic of the newly
> developed components.
> 
> It is possible we define an id_table for dfl_uio_pdev driver, but then
> users have to modify the driver code everytime they create & reprogram
> a new HW component.
> 
> > 
> > The virtio people took this to a new extreme and use it to bind real
> > devices through to virtual machines, but really, that's horrid.  And
> > they have problems with it as is seen in random patches at times.

I searched the previous patches, it seems the main issue is the user
could unbind the vfio-pci for a device and bind it to another kernel
driver, while its iommu group is still being used by vfio for other
devices in the same group, then the integrity of the group is
compromised. The conclusion is the user should be responsible for the
correct operation of bind/unbind/driver_override/new_id ...

In this patchset, we use the driver_override for UIO case, I think the
issue doesn't impact it, is it?

> > 
> > Don't make this the only way to support this, that's not an ok api.

We are not going to match driver for every dfl device by user assignment.
We are developing generic kernel drivers for them, e.g. dfl-n3000-nios,
dfl-emif, as you can see in recent patches. They follows the generic
id_table matching.

We use the driver_override for UIO case. Similar to what you've mentioned,
FPGA users develop their own hardware components on FPGA, so they need to
run diagnostic tools for white-box test.
They also need to support some hardware designed for special purposes
and does not fit into one of the standard kernel subsystems.

The FPGA users are the developer of some hardware component, they have the
knowledge of the new dfl devices. So the driver_override give the option
to the users for driver assignment.

For these purposes, is it OK we use the driver_override?


Thanks,
Yilun


> > 
> > greg k-h
