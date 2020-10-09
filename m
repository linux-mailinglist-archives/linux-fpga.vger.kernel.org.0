Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C3CB289A9A
	for <lists+linux-fpga@lfdr.de>; Fri,  9 Oct 2020 23:28:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391527AbgJIV2o (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 9 Oct 2020 17:28:44 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40759 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731533AbgJIV2n (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 9 Oct 2020 17:28:43 -0400
Received: by mail-pf1-f196.google.com with SMTP id w21so7918267pfc.7;
        Fri, 09 Oct 2020 14:28:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HkS5betriYfUMMEyXyZ2TAxnZzhJKiHHjsPRgrF4ICM=;
        b=TtxoXZjsTfAEv0uTh1LnCXdOiOHhz1Gb3G5p1huey1PdMZsOhdHFGVYNS/ycwCGBU9
         C6vanpOE9fOLhVla+3leBimomHVqXS5SNtmFOSYG8xGs+Q1RzhcM8RjGb7DlDHNfu0St
         v+6lLpUQngOnE8+3RKn0fdY0YsSqztaw8/59ds09kKTDFQgmL+4qrRxkVvtWJz967rX0
         N/QgehHGAZMmFAyunPlNOXULIq398FvH54+zzfNjBSvWYvfpXAY/phQaBvHdnYgTcdj3
         cOTpu3uAzG/a7esX2CmL7gs9YPcN46qc8oKDLQF3DrUVHun/9YocEZujWGzWB+IA8veq
         51kw==
X-Gm-Message-State: AOAM532ZvuYCLz0n/1FA4ExYaVY7IBtij6SlSvDVBj/mccGxicb5VcO0
        zkTx+Fl/FQqaR7xCr3/JjFjdtpntMe8=
X-Google-Smtp-Source: ABdhPJwT0vp/kDcTjxK3SKXBCOTGlW2J3tdSpO/dt5YBHSUMcAwtjbhKbuCGiijoLoEPJn1IFFmVxA==
X-Received: by 2002:aa7:81d5:0:b029:142:2501:39fa with SMTP id c21-20020aa781d50000b0290142250139famr14236539pfn.73.1602278922186;
        Fri, 09 Oct 2020 14:28:42 -0700 (PDT)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id o17sm12579401pji.30.2020.10.09.14.28.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2020 14:28:41 -0700 (PDT)
Date:   Fri, 9 Oct 2020 14:28:39 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     Xu Yilun <yilun.xu@intel.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, trix@redhat.com, lgoncalv@redhat.com,
        hao.wu@intel.com
Subject: Re: [PATCH v3 1/5] fpga: dfl: rename the bus type "dfl" to "fpga-dfl"
Message-ID: <20201009212839.GB2531@epycbox.lan>
References: <20200926192219.GA18625@epycbox.lan>
 <20200927055108.GA701198@kroah.com>
 <20200927073754.GB16433@yilunxu-OptiPlex-7050>
 <20200927075401.GA748141@kroah.com>
 <20200927083647.GC16433@yilunxu-OptiPlex-7050>
 <20200929012323.GD16433@yilunxu-OptiPlex-7050>
 <20200929041900.GA113620@archbook>
 <20201009062059.GB24324@yilunxu-OptiPlex-7050>
 <20201009064118.GA655664@kroah.com>
 <20201009073424.GA15377@yilunxu-OptiPlex-7050>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201009073424.GA15377@yilunxu-OptiPlex-7050>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi Xu,

On Fri, Oct 09, 2020 at 03:34:24PM +0800, Xu Yilun wrote:
> On Fri, Oct 09, 2020 at 08:41:18AM +0200, Greg KH wrote:
> > On Fri, Oct 09, 2020 at 02:20:59PM +0800, Xu Yilun wrote:
> > > Hi Greg:
> > > 
> > > On Mon, Sep 28, 2020 at 09:19:00PM -0700, Moritz Fischer wrote:
> > > > Hi Xu,
> > > > 
> > > > On Tue, Sep 29, 2020 at 09:23:23AM +0800, Xu Yilun wrote:
> > > > > Hi moritz:
> > > > > 
> > > > > On Sun, Sep 27, 2020 at 04:36:47PM +0800, Xu Yilun wrote:
> > > > > > Hi Greg,
> > > > > > 
> > > > > > On Sun, Sep 27, 2020 at 09:54:01AM +0200, Greg KH wrote:
> > > > > > > On Sun, Sep 27, 2020 at 03:37:54PM +0800, Xu Yilun wrote:
> > > > > > > > Hi Greg,
> > > > > > > > 
> > > > > > > > On Sun, Sep 27, 2020 at 07:51:08AM +0200, Greg KH wrote:
> > > > > > > > > On Sat, Sep 26, 2020 at 12:22:19PM -0700, Moritz Fischer wrote:
> > > > > > > > > > Hi Greg,
> > > > > > > > > > 
> > > > > > > > > > On Sat, Sep 26, 2020 at 08:09:13AM +0200, Greg KH wrote:
> > > > > > > > > > > On Sat, Sep 26, 2020 at 10:23:46AM +0800, Xu Yilun wrote:
> > > > > > > > > > > > Hi greg,
> > > > > > > > > > > > 
> > > > > > > > > > > > About the bus naming, I summarized some questions we've discussed to check
> > > > > > > > > > > > with you. See inline.
> > > > > > > > > > > > 
> > > > > > > > > > > > On Thu, Sep 24, 2020 at 10:27:00AM -0700, Moritz Fischer wrote:
> > > > > > > > > > > > > Hi Xu,
> > > > > > > > > > > > > 
> > > > > > > > > > > > > On Fri, Sep 25, 2020 at 12:59:57AM +0800, Xu Yilun wrote:
> > > > > > > > > > > > > > Now the DFL device drivers could be made as independent modules and put
> > > > > > > > > > > > > > in different subsystems according to their functionalities. So the name
> > > > > > > > > > > > > > should be descriptive and unique in the whole kernel.
> > > > > > > > > > > > > > 
> > > > > > > > > > > > > > The patch changes the naming of dfl bus related structures, functions,
> > > > > > > > > > > > > > APIs and documentations.
> > > > > > > > > > > > > > 
> > > > > > > > > > > > > > Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> > > > > > > > > > > > > > ---
> > > > > > > > > > > > > >  Documentation/ABI/testing/sysfs-bus-dfl      |  15 --
> > > > > > > > > > > > > >  Documentation/ABI/testing/sysfs-bus-fpga-dfl |  15 ++
> > > > > > > > > > > > > >  MAINTAINERS                                  |   2 +-
> > > > > > > > > > > > > >  drivers/fpga/dfl.c                           | 254 ++++++++++++++-------------
> > > > > > > > > > > > > >  drivers/fpga/dfl.h                           |  77 ++++----
> > > > > > > > > > > > > >  5 files changed, 184 insertions(+), 179 deletions(-)
> > > > > > > > > > > > > >  delete mode 100644 Documentation/ABI/testing/sysfs-bus-dfl
> > > > > > > > > > > > > >  create mode 100644 Documentation/ABI/testing/sysfs-bus-fpga-dfl
> > > > > > > > > > > > > > 
> > > > > > > > > > > > > > diff --git a/Documentation/ABI/testing/sysfs-bus-dfl b/Documentation/ABI/testing/sysfs-bus-dfl
> > > > > > > > > > > > > > deleted file mode 100644
> > > > > > > > > > > > > > index 23543be..0000000
> > > > > > > > > > > > > > --- a/Documentation/ABI/testing/sysfs-bus-dfl
> > > > > > > > > > > > > > +++ /dev/null
> > > > > > > > > > > > > > @@ -1,15 +0,0 @@
> > > > > > > > > > > > > > -What:		/sys/bus/dfl/devices/dfl_dev.X/type
> > > > > > > > > > > > > > -Date:		Aug 2020
> > > > > > > > > > > > > > -KernelVersion:	5.10
> > > > > > > > > > > > > > -Contact:	Xu Yilun <yilun.xu@intel.com>
> > > > > > > > > > > > > > -Description:	Read-only. It returns type of DFL FIU of the device. Now DFL
> > > > > > > > > > > > > > -		supports 2 FIU types, 0 for FME, 1 for PORT.
> > > > > > > > > > > > > > -		Format: 0x%x
> > > > > > > > > > > > > > -
> > > > > > > > > > > > > > -What:		/sys/bus/dfl/devices/dfl_dev.X/feature_id
> > > > > > > > > > > > > > -Date:		Aug 2020
> > > > > > > > > > > > > > -KernelVersion:	5.10
> > > > > > > > > > > > > > -Contact:	Xu Yilun <yilun.xu@intel.com>
> > > > > > > > > > > > > > -Description:	Read-only. It returns feature identifier local to its DFL FIU
> > > > > > > > > > > > > > -		type.
> > > > > > > > > > > > > > -		Format: 0x%x
> > > > > > > > > > > > > 
> > > > > > > > > > > > > You're changing userland facing ABI. I think that's something to avoid,
> > > > > > > > > > > > > please check with Greg on the rules since this hasn't been in a release yet.
> > > > > > > > > > > > > 
> > > > > > > > > > > > 
> > > > > > > > > > > > I'm going to change the name of bus stuff for other subsystems, to be
> > > > > > > > > > > > aligned, I also consider change the bus_type.name and dfl dev_name. But
> > > > > > > > > > > > it will cause the changing of user ABIs. No user case for these user ABI
> > > > > > > > > > > > now cause they are just queued, is it good I change them?
> > > > > > > > > > > 
> > > > > > > > > > > Why change the user name here?  No need for that, right?  Unless you
> > > > > > > > > > > really want to, and think that no one will notice.  If so, fine, change
> > > > > > > > > > > them :)
> > > > > > > > > > 
> > > > > > > > > > Let's leave it as is -- An FPGA is one possible implementation and as for
> > > > > > > > > > other buses, you wouldn't call it fpga-usb or usb-fpga just because the
> > > > > > > > > > USB bus is implemented in an FPGA if it behaves like a normal USB bus.
> > > > > > > > > > Having an ASIC based DFL bus show up under dfl-fpga / fpga-dfl in sysfs
> > > > > > > > > > would be super confusing.
> > > > > > 
> > > > > > I thought we have consensus that "dfl" could be used out of fpga domain.
> > > > > > And we are all good that we keep the user ABIs & the bus name - "dfl", so "dfl"
> > > > > > is good as a global name from linux user's point of view, is it?
> > > > > > 
> > > > > > But why we reject the "dfl" in kernel code domain? I thought it is very
> > > > > > similar situation.
> > > > > > 
> > > > > > 
> > > > > > I think we have 2 options, to make the dfl self-consistent:
> > > > > > 
> > > > > > 1. "dfl-fpga" for everything - bus name, user ABIs, structures & APIs for
> > > > > >    other kernel subsystems. Then we lose the chance to support ASIC based DFL,
> > > > > >    it would be hard if we change user ABIs later.
> > > > > > 
> > > > > > 2. "dfl" for everything.
> > > > > > 
> > > > > > BTW, no ASIC based DFL devices in kernel today.
> > > > > > 
> > > > > > I fully understand the word "naming is hard" now, help me :)
> > > > > 
> > > > > Seems now we have different opinions on this:
> > > > > 
> > > > > - Hao thinks self-consistent is important to dfl framework.
> > > > Agreed. I mostly care about userspace facing ABI, though.
> > > > 
> > > > > - "dfl" for everything seems not preferable to Greg.
> > > > Maybe now that we re-explained, we can take another look at that?
> > > > 
> > > > > - From your previous mail, I assume you prefer to keep the bus name as "dfl"
> > > > > but change the stuff for other subsystem, is it?
> > > > 
> > > > I mostly think we should keep DFL generic where it touches userspace and
> > > > defines ABI, since we cannot change it afterwards.
> > > > 
> > > > I rest my point with the bus being independent of FPGAs despite the FPGA
> > > > being the (currently) only user.
> > > > 
> > > > > So I got a little stuck here.
> > > > > 
> > > > > Do you think "dfl-fpga" for everything would be an acceptable solution
> > > > > for you?
> > > > 
> > > > I just think it doesn't make a lot of sense to call it fpga-dfl or
> > > > dfl-fpga. But if everyone else disagrees ... naming is hard :-)
> > > 
> > > Hi Greg,
> > > 
> > > We made some re-explanation why "dfl" could be independent of the fpga
> > > subsystem in this mail thread. And now the name "dfl" for all bus stuff is good
> > > to Moritz, Hao & Yilun. Could you help take another look at this?
> > 
> > What is "this"?  I don't see any fpga patches in my inbox anywhere...
> 
> Sorry, the discussion lasts more than 2 weeks, so I'm trying to collect
> the comments here.
> 
> We are trying to confirm if the new added bus name "dfl" should be
> OK, instead of "fpga-dfl"? Cause dfl could be an enumeration method
> independent of the fpga subsystem, although the FPGA is currently the
> only user.
> 
> 
> The first mail is
> 	[GIT PULL] FPGA Manager additional changes for 5.10
> 	https://lore.kernel.org/linux-fpga/20200921000855.GA15612@epycbox.lan/T/#u
> 
> In this mail you have some comments for this patch:
> 
> 	0002-fpga-dfl-move-dfl_device_id-to-mod_devicetable.h.patch
> 	https://lore.kernel.org/linux-fpga/20200915035909.GA2217@epycbox.lan/T/#u
> 
> 	[Greg's comments]
> 	- dfl_device_id is not descriptive, it means nothing to anyone outside
> 	  of the fpga subsystem.
> 	- fpga_dfl_device_id perhaps instead?  That gives people a chance to know
> 	  where to look for this
> 
> 	[More Greg's comments]
> 	You are now "playing in the namespace of the whole kernel", so yes, you
> 	need to be as descriptive as possible so that everyone knows what is
> 	happening as all subsystems touch these files.
> 
> 	No one knows what "dfl_" means.  Heck, I have no idea, I keep thinking
> 	"Device Firmware Loader" or something like that.
> 
> 	So making it obvious, and unique, and "short enough" is the requirement.
> 
> 	Naming is hard :)
> 
> 
> And then we are trying to explain "dfl" could be an enumeration method
> independent of the fpga subsystem, so we want to keep the naming "dfl".
> 
> 	[Hao's comments]
> 	Actually Device Feature List is introduced in FPGA, but it doesn't limit
> 	the usage in FPGA only. It's just a method to discover features from a
> 	device in case we don't have Device Tree, for sure it can be extended and used
> 	in other devices too. So it can be bigger namespace than FPGA. This is the
> 	reason we picked dfl_fpga (DFL based FPGA) before (suggested by Alan),
> 	for sure it's possible to have "DFL based XXX" in the future, even
> 	currently only FPGA uses DFL. This is the reason I think bus type "dfl" sounds ok
> 	in bus code submission review, DFL based FPGA has its own dfl_fpga specific
> 	ioctl definition, but bus for driver matching can be reused, so it seems
> 	we fine, if we need to support other devices reusing DFL.
> 
> 	[Moritz's comments] in this mail thread:
> 	Let's leave it as is -- An FPGA is one possible implementation and as for
> 	other buses, you wouldn't call it fpga-usb or usb-fpga
> 	just because the USB bus is implemented in an FPGA if it behaves like a
> 	normal USB bus.
> 	Having an ASIC based DFL bus show up under dfl-fpga /
> 	fpga-dfl in sysfs would be super confusing.
> 										
> 	I mostly think we should keep DFL generic where it touches userspace and
> 	defines ABI, since we cannot change it afterwards.
> 
> 	I rest my point with the bus being independent of FPGAs despite
> 	the FPGA being the (currently) only user.
> 
> 	I just think it doesn't make a lot of sense to call it
> 	fpga-dfl or dfl-fpga. But if everyone else disagrees ... naming is hard :-)
> 
> 
> Also the main code for dfl bus (we name it "dfl" in this patch) is already merged to
> linux-next, see this patch:
> 
> 	fpga: dfl: create a dfl bus type to support DFL devices
> 	https://lore.kernel.org/linux-fpga/20200905003231.GB3157@epycbox.lan/T/#u	
> 
> So we also want to keep the naming of bus stuff aligned with the name of user
> ABIs, to keep the driver self-consistent.
> 
> 
> Hope I make things clear.
> 
> Thanks,
> Yilun

Can you resend your latest, and CC Greg?

We're pretty late in the cycle, so this is gonna wait till the next cycle most likely.
The one patch that introduces the bus doesn't collidee with the plan, so
what is queued right now for 5.10 in Greg's tree is fine.

Thanks,
Moritz
