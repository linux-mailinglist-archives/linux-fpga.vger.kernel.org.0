Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A1261B8388
	for <lists+linux-fpga@lfdr.de>; Sat, 25 Apr 2020 05:59:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726040AbgDYD7w (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 24 Apr 2020 23:59:52 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39120 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbgDYD7w (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 24 Apr 2020 23:59:52 -0400
Received: by mail-pl1-f193.google.com with SMTP id k18so4504639pll.6;
        Fri, 24 Apr 2020 20:59:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dDEQdduqyEgfM9DImQqMjrWboE5jm0ENHVrvQ2k14Ak=;
        b=njzXqWfJCj+wc+WMmGrOn2jp2aO24qURuI7EoBL3akUHZCbu/zWm7QO+2+yoB1dVuu
         9NuMX6jvkBmn06DqD37Bmc/wXenNZOQRnsGUwOcK5PBmjmDmLZvrX3BM6oB6MkdrQpUs
         //PQKKLyKdu2RZYwejieLX+lF6siWZ+iWMjJORrE1ONg8ZHZu6Jvj+igg8Tz1cyaSSz2
         3fateCoWQV5BV+erZ3dbZSFzJ6LQ0WBUqcR3ZqIttPlVxEhqlK9d60SOAQ1Ij+b8wzqR
         Z5MZhugaXZ62qZCwb69k7xkKD+mFoXyilurh2Pza+UKj8IZNptAfbBUae8rLUYgGuc5C
         6/wg==
X-Gm-Message-State: AGi0Pub76yOnAurl6inqj5+EakzAmj9WN4U18i169ryBL9jPdTCSvkZZ
        uOkmOgL3dZ2BGXUnJBJCZgw=
X-Google-Smtp-Source: APiQypJSVI8J39Hhgtl8VpG+V/GfyNQ951YeD7kqLw3i7+qv25guwQSz5A2LEeMHm9/d3rz2heg4pQ==
X-Received: by 2002:a17:90a:d0c3:: with SMTP id y3mr3994426pjw.25.1587787191386;
        Fri, 24 Apr 2020 20:59:51 -0700 (PDT)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id 7sm6270235pga.15.2020.04.24.20.59.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2020 20:59:50 -0700 (PDT)
Date:   Fri, 24 Apr 2020 20:59:49 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     Sascha Hauer <s.hauer@pengutronix.de>
Cc:     Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: How to upload fpga firmware
Message-ID: <20200425035949.GA11710@epycbox.lan>
References: <20200422114432.GM1694@pengutronix.de>
 <20200423013648.GA2430@epycbox.lan>
 <20200423062331.GR1694@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200423062331.GR1694@pengutronix.de>
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi Sascha,

On Thu, Apr 23, 2020 at 08:23:31AM +0200, Sascha Hauer wrote:
> Hi Moritz,
> 
> On Wed, Apr 22, 2020 at 06:36:48PM -0700, Moritz Fischer wrote:
> > Hi Sascha,
> > 
> > On Wed, Apr 22, 2020 at 01:44:32PM +0200, Sascha Hauer wrote:
> > > Hi,
> > > 
> > > I wonder what can be done with the mainline state of drivers/fpga/. The
> > > entry to the framework seems to be fpga_mgr_load(). The only user of
> > > this function is fpga_region_program_fpga(). This in turn is only called
> > > in response of applying a device tree overlay. A device tree overlay is
> > > applied with of_overlay_fdt_apply() which has no users in the Kernel.
> > 
> > Yes. It is waiting for dt_overlays one way or another. I personally
> > don't currently have the bandwidth to work actively on this.
> > 
> > > My current task is to load a firmware to a FPGA. The code all seems to
> > > be there in the Kernel, it only lacks a way to trigger it. I am not very
> > > interested in device tree overlays since the FPGA appears as a PCI
> > > device (although applying a dtbo could enable the PCIe controller device
> > > tree node). Is there some mainline way to upload FPGA firmware? At the
> > > moment we are using the attached patch to trigger loading the firmware
> > > from userspace. Would something like this be acceptable for mainline?
> > 
> > We've looked into this sort of patches over the years and never came to
> > a general interface that really works.
> > 
> > The OPAE folks (and other users I know of) usually use FPGA Manager with
> > a higher layer on top of it that moves the bitstream into the kernel via
> > an ioctl().
> > 
> > One concept I had toyed with mentally, but haven't really gotten around
> > to implement is a 'discoverable' region, that would deal with the
> > necessary re-enumeration via a callback and have a sysfs interface
> > similar to what the patch below has.
> > This would essentially cover use-cases where you have a discoverable
> > device implemented in FPGA logic, such as say an FPGA hanging off of
> > PCIe bus that can get loaded over USB, a CPLD or some other side-band
> > mechanism. After loading the image you'd have to rescan the PCIe bus -
> > which - imho is the kernel's job.
> > 
> > What I really wanna avoid is creating another /dev/fpga0 / /dev/xdevcfg
> > that completely leaves the kernel in the dark about the fact that it
> > reconfigures a bit of hardware hanging off the bus.
> 
> Yes, makes sense. While this would suffice my needs at the moment it
> really sounds like a dead end.
> 
> > 
> > In my ideal world you'd create a pci driver that binds to your device,
> > and creates mfd style subdevices for whatever you'd want your design to
> > do. One of these devices would be an FPGA and a FPGA region attached to
> > that FPGA manager. Your top level driver would co-ordinate the fact that
> > you are re-programming parts of the FPGA and create / destroy devices as
> > needed for the hardware contained in the bitstream.
> 
> In my case there is no pci device visible before loading the firmware,
> so creating a pci driver is not an option. Maybe pci host controllers
> could register themselves as fpga-bridges. With this we could put the
> pci host controller (or the pci device, AFAIK there is a PCI device tree
> binding) where the fpga is connected into the fpga-bridges phandles list
> of the fpga-region.

Can you talk a bit more about the system you're working with? Is there
some sort of sideband mechanism to load the image? What exposes the
image loading capaibility? A CPLD, an ASIC, USB device, JTAG?

What does the topology look like?

Sideband  -----> FPGA
PCIe      -----> FPGA

It also depends a bit on the use-case: After you program the bitstream,
do you need to runtime re-program it? Does it do partial
reconfiguration? Are there subdevices inside your device, or is the
whole thing a discoverable PCI device afterwards?

Cheers,
Moritz
