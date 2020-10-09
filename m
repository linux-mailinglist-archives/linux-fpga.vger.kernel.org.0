Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD4EB2883C6
	for <lists+linux-fpga@lfdr.de>; Fri,  9 Oct 2020 09:39:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732123AbgJIHjX (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 9 Oct 2020 03:39:23 -0400
Received: from mga14.intel.com ([192.55.52.115]:20144 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730740AbgJIHjW (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Fri, 9 Oct 2020 03:39:22 -0400
IronPort-SDR: clo5kdxY4+OHG/tAcionz377OxPJdHk0FkC/yUv+CDV2jK8yTRESfQb1ekYuGGucEwPUuRAikk
 0MJ1db2n1nlg==
X-IronPort-AV: E=McAfee;i="6000,8403,9768"; a="164665915"
X-IronPort-AV: E=Sophos;i="5.77,354,1596524400"; 
   d="scan'208";a="164665915"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2020 00:39:21 -0700
IronPort-SDR: yl0fEf6bGxikKOXaWUA2pkuCgshS/28IXiKUBETHdGh/TMF/t1FwaIgQuKIdn9BFDUIUSiwuMO
 QAOik+BULk+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,354,1596524400"; 
   d="scan'208";a="528822317"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.141])
  by orsmga005.jf.intel.com with ESMTP; 09 Oct 2020 00:39:19 -0700
Date:   Fri, 9 Oct 2020 15:34:24 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, trix@redhat.com, lgoncalv@redhat.com,
        hao.wu@intel.com, yilun.xu@intel.com
Subject: Re: [PATCH v3 1/5] fpga: dfl: rename the bus type "dfl" to "fpga-dfl"
Message-ID: <20201009073424.GA15377@yilunxu-OptiPlex-7050>
References: <20200926060913.GA637197@kroah.com>
 <20200926192219.GA18625@epycbox.lan>
 <20200927055108.GA701198@kroah.com>
 <20200927073754.GB16433@yilunxu-OptiPlex-7050>
 <20200927075401.GA748141@kroah.com>
 <20200927083647.GC16433@yilunxu-OptiPlex-7050>
 <20200929012323.GD16433@yilunxu-OptiPlex-7050>
 <20200929041900.GA113620@archbook>
 <20201009062059.GB24324@yilunxu-OptiPlex-7050>
 <20201009064118.GA655664@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201009064118.GA655664@kroah.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Fri, Oct 09, 2020 at 08:41:18AM +0200, Greg KH wrote:
> On Fri, Oct 09, 2020 at 02:20:59PM +0800, Xu Yilun wrote:
> > Hi Greg:
> > 
> > On Mon, Sep 28, 2020 at 09:19:00PM -0700, Moritz Fischer wrote:
> > > Hi Xu,
> > > 
> > > On Tue, Sep 29, 2020 at 09:23:23AM +0800, Xu Yilun wrote:
> > > > Hi moritz:
> > > > 
> > > > On Sun, Sep 27, 2020 at 04:36:47PM +0800, Xu Yilun wrote:
> > > > > Hi Greg,
> > > > > 
> > > > > On Sun, Sep 27, 2020 at 09:54:01AM +0200, Greg KH wrote:
> > > > > > On Sun, Sep 27, 2020 at 03:37:54PM +0800, Xu Yilun wrote:
> > > > > > > Hi Greg,
> > > > > > > 
> > > > > > > On Sun, Sep 27, 2020 at 07:51:08AM +0200, Greg KH wrote:
> > > > > > > > On Sat, Sep 26, 2020 at 12:22:19PM -0700, Moritz Fischer wrote:
> > > > > > > > > Hi Greg,
> > > > > > > > > 
> > > > > > > > > On Sat, Sep 26, 2020 at 08:09:13AM +0200, Greg KH wrote:
> > > > > > > > > > On Sat, Sep 26, 2020 at 10:23:46AM +0800, Xu Yilun wrote:
> > > > > > > > > > > Hi greg,
> > > > > > > > > > > 
> > > > > > > > > > > About the bus naming, I summarized some questions we've discussed to check
> > > > > > > > > > > with you. See inline.
> > > > > > > > > > > 
> > > > > > > > > > > On Thu, Sep 24, 2020 at 10:27:00AM -0700, Moritz Fischer wrote:
> > > > > > > > > > > > Hi Xu,
> > > > > > > > > > > > 
> > > > > > > > > > > > On Fri, Sep 25, 2020 at 12:59:57AM +0800, Xu Yilun wrote:
> > > > > > > > > > > > > Now the DFL device drivers could be made as independent modules and put
> > > > > > > > > > > > > in different subsystems according to their functionalities. So the name
> > > > > > > > > > > > > should be descriptive and unique in the whole kernel.
> > > > > > > > > > > > > 
> > > > > > > > > > > > > The patch changes the naming of dfl bus related structures, functions,
> > > > > > > > > > > > > APIs and documentations.
> > > > > > > > > > > > > 
> > > > > > > > > > > > > Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> > > > > > > > > > > > > ---
> > > > > > > > > > > > >  Documentation/ABI/testing/sysfs-bus-dfl      |  15 --
> > > > > > > > > > > > >  Documentation/ABI/testing/sysfs-bus-fpga-dfl |  15 ++
> > > > > > > > > > > > >  MAINTAINERS                                  |   2 +-
> > > > > > > > > > > > >  drivers/fpga/dfl.c                           | 254 ++++++++++++++-------------
> > > > > > > > > > > > >  drivers/fpga/dfl.h                           |  77 ++++----
> > > > > > > > > > > > >  5 files changed, 184 insertions(+), 179 deletions(-)
> > > > > > > > > > > > >  delete mode 100644 Documentation/ABI/testing/sysfs-bus-dfl
> > > > > > > > > > > > >  create mode 100644 Documentation/ABI/testing/sysfs-bus-fpga-dfl
> > > > > > > > > > > > > 
> > > > > > > > > > > > > diff --git a/Documentation/ABI/testing/sysfs-bus-dfl b/Documentation/ABI/testing/sysfs-bus-dfl
> > > > > > > > > > > > > deleted file mode 100644
> > > > > > > > > > > > > index 23543be..0000000
> > > > > > > > > > > > > --- a/Documentation/ABI/testing/sysfs-bus-dfl
> > > > > > > > > > > > > +++ /dev/null
> > > > > > > > > > > > > @@ -1,15 +0,0 @@
> > > > > > > > > > > > > -What:		/sys/bus/dfl/devices/dfl_dev.X/type
> > > > > > > > > > > > > -Date:		Aug 2020
> > > > > > > > > > > > > -KernelVersion:	5.10
> > > > > > > > > > > > > -Contact:	Xu Yilun <yilun.xu@intel.com>
> > > > > > > > > > > > > -Description:	Read-only. It returns type of DFL FIU of the device. Now DFL
> > > > > > > > > > > > > -		supports 2 FIU types, 0 for FME, 1 for PORT.
> > > > > > > > > > > > > -		Format: 0x%x
> > > > > > > > > > > > > -
> > > > > > > > > > > > > -What:		/sys/bus/dfl/devices/dfl_dev.X/feature_id
> > > > > > > > > > > > > -Date:		Aug 2020
> > > > > > > > > > > > > -KernelVersion:	5.10
> > > > > > > > > > > > > -Contact:	Xu Yilun <yilun.xu@intel.com>
> > > > > > > > > > > > > -Description:	Read-only. It returns feature identifier local to its DFL FIU
> > > > > > > > > > > > > -		type.
> > > > > > > > > > > > > -		Format: 0x%x
> > > > > > > > > > > > 
> > > > > > > > > > > > You're changing userland facing ABI. I think that's something to avoid,
> > > > > > > > > > > > please check with Greg on the rules since this hasn't been in a release yet.
> > > > > > > > > > > > 
> > > > > > > > > > > 
> > > > > > > > > > > I'm going to change the name of bus stuff for other subsystems, to be
> > > > > > > > > > > aligned, I also consider change the bus_type.name and dfl dev_name. But
> > > > > > > > > > > it will cause the changing of user ABIs. No user case for these user ABI
> > > > > > > > > > > now cause they are just queued, is it good I change them?
> > > > > > > > > > 
> > > > > > > > > > Why change the user name here?  No need for that, right?  Unless you
> > > > > > > > > > really want to, and think that no one will notice.  If so, fine, change
> > > > > > > > > > them :)
> > > > > > > > > 
> > > > > > > > > Let's leave it as is -- An FPGA is one possible implementation and as for
> > > > > > > > > other buses, you wouldn't call it fpga-usb or usb-fpga just because the
> > > > > > > > > USB bus is implemented in an FPGA if it behaves like a normal USB bus.
> > > > > > > > > Having an ASIC based DFL bus show up under dfl-fpga / fpga-dfl in sysfs
> > > > > > > > > would be super confusing.
> > > > > 
> > > > > I thought we have consensus that "dfl" could be used out of fpga domain.
> > > > > And we are all good that we keep the user ABIs & the bus name - "dfl", so "dfl"
> > > > > is good as a global name from linux user's point of view, is it?
> > > > > 
> > > > > But why we reject the "dfl" in kernel code domain? I thought it is very
> > > > > similar situation.
> > > > > 
> > > > > 
> > > > > I think we have 2 options, to make the dfl self-consistent:
> > > > > 
> > > > > 1. "dfl-fpga" for everything - bus name, user ABIs, structures & APIs for
> > > > >    other kernel subsystems. Then we lose the chance to support ASIC based DFL,
> > > > >    it would be hard if we change user ABIs later.
> > > > > 
> > > > > 2. "dfl" for everything.
> > > > > 
> > > > > BTW, no ASIC based DFL devices in kernel today.
> > > > > 
> > > > > I fully understand the word "naming is hard" now, help me :)
> > > > 
> > > > Seems now we have different opinions on this:
> > > > 
> > > > - Hao thinks self-consistent is important to dfl framework.
> > > Agreed. I mostly care about userspace facing ABI, though.
> > > 
> > > > - "dfl" for everything seems not preferable to Greg.
> > > Maybe now that we re-explained, we can take another look at that?
> > > 
> > > > - From your previous mail, I assume you prefer to keep the bus name as "dfl"
> > > > but change the stuff for other subsystem, is it?
> > > 
> > > I mostly think we should keep DFL generic where it touches userspace and
> > > defines ABI, since we cannot change it afterwards.
> > > 
> > > I rest my point with the bus being independent of FPGAs despite the FPGA
> > > being the (currently) only user.
> > > 
> > > > So I got a little stuck here.
> > > > 
> > > > Do you think "dfl-fpga" for everything would be an acceptable solution
> > > > for you?
> > > 
> > > I just think it doesn't make a lot of sense to call it fpga-dfl or
> > > dfl-fpga. But if everyone else disagrees ... naming is hard :-)
> > 
> > Hi Greg,
> > 
> > We made some re-explanation why "dfl" could be independent of the fpga
> > subsystem in this mail thread. And now the name "dfl" for all bus stuff is good
> > to Moritz, Hao & Yilun. Could you help take another look at this?
> 
> What is "this"?  I don't see any fpga patches in my inbox anywhere...

Sorry, the discussion lasts more than 2 weeks, so I'm trying to collect
the comments here.

We are trying to confirm if the new added bus name "dfl" should be
OK, instead of "fpga-dfl"? Cause dfl could be an enumeration method
independent of the fpga subsystem, although the FPGA is currently the
only user.


The first mail is
	[GIT PULL] FPGA Manager additional changes for 5.10
	https://lore.kernel.org/linux-fpga/20200921000855.GA15612@epycbox.lan/T/#u

In this mail you have some comments for this patch:

	0002-fpga-dfl-move-dfl_device_id-to-mod_devicetable.h.patch
	https://lore.kernel.org/linux-fpga/20200915035909.GA2217@epycbox.lan/T/#u

	[Greg's comments]
	- dfl_device_id is not descriptive, it means nothing to anyone outside
	  of the fpga subsystem.
	- fpga_dfl_device_id perhaps instead?  That gives people a chance to know
	  where to look for this

	[More Greg's comments]
	You are now "playing in the namespace of the whole kernel", so yes, you
	need to be as descriptive as possible so that everyone knows what is
	happening as all subsystems touch these files.

	No one knows what "dfl_" means.  Heck, I have no idea, I keep thinking
	"Device Firmware Loader" or something like that.

	So making it obvious, and unique, and "short enough" is the requirement.

	Naming is hard :)


And then we are trying to explain "dfl" could be an enumeration method
independent of the fpga subsystem, so we want to keep the naming "dfl".

	[Hao's comments]
	Actually Device Feature List is introduced in FPGA, but it doesn't limit
	the usage in FPGA only. It's just a method to discover features from a
	device in case we don't have Device Tree, for sure it can be extended and used
	in other devices too. So it can be bigger namespace than FPGA. This is the
	reason we picked dfl_fpga (DFL based FPGA) before (suggested by Alan),
	for sure it's possible to have "DFL based XXX" in the future, even
	currently only FPGA uses DFL. This is the reason I think bus type "dfl" sounds ok
	in bus code submission review, DFL based FPGA has its own dfl_fpga specific
	ioctl definition, but bus for driver matching can be reused, so it seems
	we fine, if we need to support other devices reusing DFL.

	[Moritz's comments] in this mail thread:
	Let's leave it as is -- An FPGA is one possible implementation and as for
	other buses, you wouldn't call it fpga-usb or usb-fpga
	just because the USB bus is implemented in an FPGA if it behaves like a
	normal USB bus.
	Having an ASIC based DFL bus show up under dfl-fpga /
	fpga-dfl in sysfs would be super confusing.
										
	I mostly think we should keep DFL generic where it touches userspace and
	defines ABI, since we cannot change it afterwards.

	I rest my point with the bus being independent of FPGAs despite
	the FPGA being the (currently) only user.

	I just think it doesn't make a lot of sense to call it
	fpga-dfl or dfl-fpga. But if everyone else disagrees ... naming is hard :-)


Also the main code for dfl bus (we name it "dfl" in this patch) is already merged to
linux-next, see this patch:

	fpga: dfl: create a dfl bus type to support DFL devices
	https://lore.kernel.org/linux-fpga/20200905003231.GB3157@epycbox.lan/T/#u	

So we also want to keep the naming of bus stuff aligned with the name of user
ABIs, to keep the driver self-consistent.


Hope I make things clear.

Thanks,
Yilun
