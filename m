Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48411279F4D
	for <lists+linux-fpga@lfdr.de>; Sun, 27 Sep 2020 09:42:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728580AbgI0Hmh (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 27 Sep 2020 03:42:37 -0400
Received: from mga18.intel.com ([134.134.136.126]:65160 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727614AbgI0Hmh (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Sun, 27 Sep 2020 03:42:37 -0400
IronPort-SDR: 3CIEROAxgSr6gmYLMfIMI98DjgWKiJROw1pZ3lGBI2WUcXIWJcGt/e0yJIY59LaLzN8RyvzXdb
 yJySyR8kC+9g==
X-IronPort-AV: E=McAfee;i="6000,8403,9756"; a="149623672"
X-IronPort-AV: E=Sophos;i="5.77,309,1596524400"; 
   d="scan'208";a="149623672"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2020 00:42:35 -0700
IronPort-SDR: PB4usEZVimfQXoJwj3TmbvNy4UwFRN9je09LOKs8fpxCsPM5QPRCDA5wEL2MeqLwy/qHdHOAp/
 qtnHYE8wHJvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,309,1596524400"; 
   d="scan'208";a="311405104"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.141])
  by orsmga006.jf.intel.com with ESMTP; 27 Sep 2020 00:42:32 -0700
Date:   Sun, 27 Sep 2020 15:37:54 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, trix@redhat.com, lgoncalv@redhat.com,
        hao.wu@intel.com, yilun.xu@intel.com
Subject: Re: [PATCH v3 1/5] fpga: dfl: rename the bus type "dfl" to "fpga-dfl"
Message-ID: <20200927073754.GB16433@yilunxu-OptiPlex-7050>
References: <1600966801-30586-1-git-send-email-yilun.xu@intel.com>
 <1600966801-30586-2-git-send-email-yilun.xu@intel.com>
 <20200924172700.GA79736@archbook>
 <20200926022346.GA5623@yilunxu-OptiPlex-7050>
 <20200926060913.GA637197@kroah.com>
 <20200926192219.GA18625@epycbox.lan>
 <20200927055108.GA701198@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200927055108.GA701198@kroah.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi Greg,

On Sun, Sep 27, 2020 at 07:51:08AM +0200, Greg KH wrote:
> On Sat, Sep 26, 2020 at 12:22:19PM -0700, Moritz Fischer wrote:
> > Hi Greg,
> > 
> > On Sat, Sep 26, 2020 at 08:09:13AM +0200, Greg KH wrote:
> > > On Sat, Sep 26, 2020 at 10:23:46AM +0800, Xu Yilun wrote:
> > > > Hi greg,
> > > > 
> > > > About the bus naming, I summarized some questions we've discussed to check
> > > > with you. See inline.
> > > > 
> > > > On Thu, Sep 24, 2020 at 10:27:00AM -0700, Moritz Fischer wrote:
> > > > > Hi Xu,
> > > > > 
> > > > > On Fri, Sep 25, 2020 at 12:59:57AM +0800, Xu Yilun wrote:
> > > > > > Now the DFL device drivers could be made as independent modules and put
> > > > > > in different subsystems according to their functionalities. So the name
> > > > > > should be descriptive and unique in the whole kernel.
> > > > > > 
> > > > > > The patch changes the naming of dfl bus related structures, functions,
> > > > > > APIs and documentations.
> > > > > > 
> > > > > > Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> > > > > > ---
> > > > > >  Documentation/ABI/testing/sysfs-bus-dfl      |  15 --
> > > > > >  Documentation/ABI/testing/sysfs-bus-fpga-dfl |  15 ++
> > > > > >  MAINTAINERS                                  |   2 +-
> > > > > >  drivers/fpga/dfl.c                           | 254 ++++++++++++++-------------
> > > > > >  drivers/fpga/dfl.h                           |  77 ++++----
> > > > > >  5 files changed, 184 insertions(+), 179 deletions(-)
> > > > > >  delete mode 100644 Documentation/ABI/testing/sysfs-bus-dfl
> > > > > >  create mode 100644 Documentation/ABI/testing/sysfs-bus-fpga-dfl
> > > > > > 
> > > > > > diff --git a/Documentation/ABI/testing/sysfs-bus-dfl b/Documentation/ABI/testing/sysfs-bus-dfl
> > > > > > deleted file mode 100644
> > > > > > index 23543be..0000000
> > > > > > --- a/Documentation/ABI/testing/sysfs-bus-dfl
> > > > > > +++ /dev/null
> > > > > > @@ -1,15 +0,0 @@
> > > > > > -What:		/sys/bus/dfl/devices/dfl_dev.X/type
> > > > > > -Date:		Aug 2020
> > > > > > -KernelVersion:	5.10
> > > > > > -Contact:	Xu Yilun <yilun.xu@intel.com>
> > > > > > -Description:	Read-only. It returns type of DFL FIU of the device. Now DFL
> > > > > > -		supports 2 FIU types, 0 for FME, 1 for PORT.
> > > > > > -		Format: 0x%x
> > > > > > -
> > > > > > -What:		/sys/bus/dfl/devices/dfl_dev.X/feature_id
> > > > > > -Date:		Aug 2020
> > > > > > -KernelVersion:	5.10
> > > > > > -Contact:	Xu Yilun <yilun.xu@intel.com>
> > > > > > -Description:	Read-only. It returns feature identifier local to its DFL FIU
> > > > > > -		type.
> > > > > > -		Format: 0x%x
> > > > > 
> > > > > You're changing userland facing ABI. I think that's something to avoid,
> > > > > please check with Greg on the rules since this hasn't been in a release yet.
> > > > > 
> > > > 
> > > > I'm going to change the name of bus stuff for other subsystems, to be
> > > > aligned, I also consider change the bus_type.name and dfl dev_name. But
> > > > it will cause the changing of user ABIs. No user case for these user ABI
> > > > now cause they are just queued, is it good I change them?
> > > 
> > > Why change the user name here?  No need for that, right?  Unless you
> > > really want to, and think that no one will notice.  If so, fine, change
> > > them :)
> > 
> > Let's leave it as is -- An FPGA is one possible implementation and as for
> > other buses, you wouldn't call it fpga-usb or usb-fpga just because the
> > USB bus is implemented in an FPGA if it behaves like a normal USB bus.
> > Having an ASIC based DFL bus show up under dfl-fpga / fpga-dfl in sysfs
> > would be super confusing.
> > 
> > > > It is mentioned that although Device Feature List is introduced in FPGA,
> > > > but it doesn't limit the usage in FPGA only. It's just a method to
> > > > discover features from a device, for sure it can be extended and used
> > > > in other devices too. So it can be bigger namespace than FPGA. Like in
> > > > our existing code, we picked dfl_fpga (DFL based FPGA) for uapi (ioctl)
> > > > and internal functions. This is suggested by Alan (The previous FPGA
> > > > maintainer). It's possible to have "DFL based XXX" in the future, even
> > > > currently only FPGA uses DFL. This is the reason we thought just "dfl"
> > > > in the whole kernel space is OK.
> > > > So, is there a chance we keep the "dfl" naming in the whole kernel?
> > > 
> > > No one knows what "DFL" is, and odds are, if a different subsystem wants
> > > to use it, they will have their own variant, right?

DFL is a method to discover devices. If a different subsystem (e.g. ASIC based
DFL bus) want to use DFL and follows the DFL spec, they could just use the DFL
stuff for enumeration, no need to have new variants.

> > > 
> > > And why didn't you all use device tree?  How did this sneak in past
> > > everyone?
> > 
> > DFL is a pretty efficient implementation in terms of resource
> > utilization on the FPGA end (a couple of registers / memories) vs
> > several kilobytes of memory for a device-tree blob.
> > 
> > The hardware using DFL to describe its internal structure exists in the
> > form of deployed accelerator cards and telling all its users to go and
> > change their hardware design would be feasible -- If you think about an
> > FPGA as a (albeit reconfigurable) ASIC you wouldn't go and tell people
> > to redesign their ASIC to use Device-Tree? :)
> > 
> > I'm not sure where the 'sneaking in' anything comes from. It's been
> > reviewed on the list (and by yourself back then). If you feel any of
> > this wasn't kosher, let's talk about it, to make sure it doesn't happen
> > again.
> 
> I can't remember reviewing it, sorry, too many patches, I probably was
> only worrying about functionality issues, not what the code actually did
> :)
> 
> So it's fine, just a surprise to me, no big deal.

I'm glad that we made it clear. And the bus name & user APIs cound be
kept as "dfl". So I assume the name "dfl" is OK to be used and could
be recognized by people out of FPGA domain, is it?

If so, I still want to keep the name "dfl_device_id" in mod_devicetable.h
as well. We want to keep the device id name of the bus aligned with the
bus name. And it would be confusing as well if a driver for ASIC based
DFL device uses the "dfl_fpga_device_id" structure.

How do you think?

Thanks,
Yilun

> 
> thanks,
> 
> greg k-h
