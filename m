Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE35E279C19
	for <lists+linux-fpga@lfdr.de>; Sat, 26 Sep 2020 21:22:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729291AbgIZTWW (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sat, 26 Sep 2020 15:22:22 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35826 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729272AbgIZTWV (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sat, 26 Sep 2020 15:22:21 -0400
Received: by mail-pg1-f193.google.com with SMTP id g29so5074460pgl.2;
        Sat, 26 Sep 2020 12:22:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+imMscn/HVK+1FWfnqZEjtQuxH46jNYSbI5zZ9CnKxM=;
        b=oDFCUjmCtws4zMXJB3PLfHOTfE2ycnGRiGywMovZk4d03Qgv4wIYjXc7pddN7iEopX
         EQIOcHEmHkEUHa/qKpJvlaFhr7d8DR7Uql8kJeG5hGfIe5bul7JnZ5LuVn8REFHhhrJ3
         dn6980l/Rohplp113cQV9G6WPLW9VHmXZ+1jUH/jLStn6fJ7k9qs7WMTnw9NmMYkbon9
         FFTHc2z4jn/SXnNyex9yCjcvC9rOHenGHQNSEodFvFrDAJFjMRcHloLt7wjcZrxc50KK
         ya8UbrLGF9D4swW+AjosXbN1CrSvE7sFPkJhEQNOtFd0w9me/dyPR6Gzi0XicN7RpHSE
         FnSg==
X-Gm-Message-State: AOAM532kjCaeJJAlEU15LyHTUwR6rmxcXVJ38na0tCoGRM7sddzGfE9u
        l8lzP6ADoiqIR541370TCf4=
X-Google-Smtp-Source: ABdhPJzism8NRCZYXL9d31EJrItFkitoFQKRVGK49NzfWujFAZE2Rs2dVtxC3C7EDy7WEQvDPPUgyg==
X-Received: by 2002:a63:4822:: with SMTP id v34mr3550077pga.342.1601148140493;
        Sat, 26 Sep 2020 12:22:20 -0700 (PDT)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id o19sm6415517pfp.64.2020.09.26.12.22.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2020 12:22:19 -0700 (PDT)
Date:   Sat, 26 Sep 2020 12:22:19 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Xu Yilun <yilun.xu@intel.com>, Moritz Fischer <mdf@kernel.org>,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        trix@redhat.com, lgoncalv@redhat.com, hao.wu@intel.com
Subject: Re: [PATCH v3 1/5] fpga: dfl: rename the bus type "dfl" to "fpga-dfl"
Message-ID: <20200926192219.GA18625@epycbox.lan>
References: <1600966801-30586-1-git-send-email-yilun.xu@intel.com>
 <1600966801-30586-2-git-send-email-yilun.xu@intel.com>
 <20200924172700.GA79736@archbook>
 <20200926022346.GA5623@yilunxu-OptiPlex-7050>
 <20200926060913.GA637197@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200926060913.GA637197@kroah.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi Greg,

On Sat, Sep 26, 2020 at 08:09:13AM +0200, Greg KH wrote:
> On Sat, Sep 26, 2020 at 10:23:46AM +0800, Xu Yilun wrote:
> > Hi greg,
> > 
> > About the bus naming, I summarized some questions we've discussed to check
> > with you. See inline.
> > 
> > On Thu, Sep 24, 2020 at 10:27:00AM -0700, Moritz Fischer wrote:
> > > Hi Xu,
> > > 
> > > On Fri, Sep 25, 2020 at 12:59:57AM +0800, Xu Yilun wrote:
> > > > Now the DFL device drivers could be made as independent modules and put
> > > > in different subsystems according to their functionalities. So the name
> > > > should be descriptive and unique in the whole kernel.
> > > > 
> > > > The patch changes the naming of dfl bus related structures, functions,
> > > > APIs and documentations.
> > > > 
> > > > Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> > > > ---
> > > >  Documentation/ABI/testing/sysfs-bus-dfl      |  15 --
> > > >  Documentation/ABI/testing/sysfs-bus-fpga-dfl |  15 ++
> > > >  MAINTAINERS                                  |   2 +-
> > > >  drivers/fpga/dfl.c                           | 254 ++++++++++++++-------------
> > > >  drivers/fpga/dfl.h                           |  77 ++++----
> > > >  5 files changed, 184 insertions(+), 179 deletions(-)
> > > >  delete mode 100644 Documentation/ABI/testing/sysfs-bus-dfl
> > > >  create mode 100644 Documentation/ABI/testing/sysfs-bus-fpga-dfl
> > > > 
> > > > diff --git a/Documentation/ABI/testing/sysfs-bus-dfl b/Documentation/ABI/testing/sysfs-bus-dfl
> > > > deleted file mode 100644
> > > > index 23543be..0000000
> > > > --- a/Documentation/ABI/testing/sysfs-bus-dfl
> > > > +++ /dev/null
> > > > @@ -1,15 +0,0 @@
> > > > -What:		/sys/bus/dfl/devices/dfl_dev.X/type
> > > > -Date:		Aug 2020
> > > > -KernelVersion:	5.10
> > > > -Contact:	Xu Yilun <yilun.xu@intel.com>
> > > > -Description:	Read-only. It returns type of DFL FIU of the device. Now DFL
> > > > -		supports 2 FIU types, 0 for FME, 1 for PORT.
> > > > -		Format: 0x%x
> > > > -
> > > > -What:		/sys/bus/dfl/devices/dfl_dev.X/feature_id
> > > > -Date:		Aug 2020
> > > > -KernelVersion:	5.10
> > > > -Contact:	Xu Yilun <yilun.xu@intel.com>
> > > > -Description:	Read-only. It returns feature identifier local to its DFL FIU
> > > > -		type.
> > > > -		Format: 0x%x
> > > 
> > > You're changing userland facing ABI. I think that's something to avoid,
> > > please check with Greg on the rules since this hasn't been in a release yet.
> > > 
> > 
> > I'm going to change the name of bus stuff for other subsystems, to be
> > aligned, I also consider change the bus_type.name and dfl dev_name. But
> > it will cause the changing of user ABIs. No user case for these user ABI
> > now cause they are just queued, is it good I change them?
> 
> Why change the user name here?  No need for that, right?  Unless you
> really want to, and think that no one will notice.  If so, fine, change
> them :)

Let's leave it as is -- An FPGA is one possible implementation and as for
other buses, you wouldn't call it fpga-usb or usb-fpga just because the
USB bus is implemented in an FPGA if it behaves like a normal USB bus.
Having an ASIC based DFL bus show up under dfl-fpga / fpga-dfl in sysfs
would be super confusing.

> > It is mentioned that although Device Feature List is introduced in FPGA,
> > but it doesn't limit the usage in FPGA only. It's just a method to
> > discover features from a device, for sure it can be extended and used
> > in other devices too. So it can be bigger namespace than FPGA. Like in
> > our existing code, we picked dfl_fpga (DFL based FPGA) for uapi (ioctl)
> > and internal functions. This is suggested by Alan (The previous FPGA
> > maintainer). It's possible to have "DFL based XXX" in the future, even
> > currently only FPGA uses DFL. This is the reason we thought just "dfl"
> > in the whole kernel space is OK.
> > So, is there a chance we keep the "dfl" naming in the whole kernel?
> 
> No one knows what "DFL" is, and odds are, if a different subsystem wants
> to use it, they will have their own variant, right?
> 
> And why didn't you all use device tree?  How did this sneak in past
> everyone?

DFL is a pretty efficient implementation in terms of resource
utilization on the FPGA end (a couple of registers / memories) vs
several kilobytes of memory for a device-tree blob.

The hardware using DFL to describe its internal structure exists in the
form of deployed accelerator cards and telling all its users to go and
change their hardware design would be feasible -- If you think about an
FPGA as a (albeit reconfigurable) ASIC you wouldn't go and tell people
to redesign their ASIC to use Device-Tree? :)

I'm not sure where the 'sneaking in' anything comes from. It's been
reviewed on the list (and by yourself back then). If you feel any of
this wasn't kosher, let's talk about it, to make sure it doesn't happen
again.

Cheers,
Moritz
