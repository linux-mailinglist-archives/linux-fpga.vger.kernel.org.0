Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D60501BF0EB
	for <lists+linux-fpga@lfdr.de>; Thu, 30 Apr 2020 09:12:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726575AbgD3HL7 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 30 Apr 2020 03:11:59 -0400
Received: from mga17.intel.com ([192.55.52.151]:62850 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726337AbgD3HL7 (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 30 Apr 2020 03:11:59 -0400
IronPort-SDR: zIhMdhHpwuhMbIax0Hc/mkjk0Aa6hPeSl1PYaY2VJABA3Pxk1/4BM9ahyMzvAaAVdc8ZDzA3Yv
 DHlmC8YuCDSg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2020 00:11:58 -0700
IronPort-SDR: C0A6tRiBbpq82fp2h6tIIO/ByrLbb/xDotajYFIx7MY7VuRtVYhIhdzXbXsJEjuNjfvnXsKQQ3
 cdhohQm9uDCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,334,1583222400"; 
   d="scan'208";a="261681955"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.141])
  by orsmga006.jf.intel.com with ESMTP; 30 Apr 2020 00:11:56 -0700
Date:   Thu, 30 Apr 2020 15:09:03 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Moritz Fischer <mdf@kernel.org>
Cc:     matthew.gerlach@linux.intel.com, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: How to update a piece of flash for FPGA firmware?
Message-ID: <20200430070903.GA31302@yilunxu-OptiPlex-7050>
References: <20200428050135.GA27416@yilunxu-OptiPlex-7050>
 <alpine.LFD.2.21.2004281434001.59524@psera2-dell24.ra.intel.com>
 <20200430031210.GA6168@epycbox.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200430031210.GA6168@epycbox.lan>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi Moritz & Matthew:

Thanks a lot for the comments! It helps a lot so we could keep working on
right direction. 

For "next boot" or "rescan" case, it cause rebuild the fpga-region. So
maybe we don't have to model it in fpga class.

Yilun

On Wed, Apr 29, 2020 at 08:12:10PM -0700, Moritz Fischer wrote:
> Hi Matthew, Yilun
> 
> On Tue, Apr 28, 2020 at 03:06:07PM -0700, matthew.gerlach@linux.intel.com wrote:
> > Hi Yilun,
> > 
> > You raise some very interesting questions. Please see
> > my comments below.
> > 
> > Matthew
> > 
> > On Tue, 28 Apr 2020, Xu Yilun wrote:
> > 
> > > Hi,
> > > 
> > > I wonder if an updating of FPGA Flash (but cannot reload) could be
> > > implemented as fpga-mgr?
> > > 
> > > I have the pcie based FPGA card. The bitstream for FPGA static region is
> > > stored on flash chip. Board will load the bitstream to FPGA on system
> > > power cycle. The flash chip could be accessed through "PCIE -> ... ->
> > > Flash update engine -> Flash". So the update of the FPGA static region is
> > > basicly updating the flash chip through PCIE and rebooting system.
> > 
> > I think you mean power cycle when you say "rebooting system" above, but
> > your point is worth highlighting.  During this flash update the
> > FPGA is actually fully configured and running its application.  Typically,
> > during a fpga-mgr update of the static region or partial reconfiguration
> > region, the actual contents of the fpga region is "changing" during the
> > update.
> 
> Yeah, this sounds more like a flash driver with MTD or maybe NVMEM?
> That's probably how I'd do it. Depending on your (Q)SPI controller you
> might already have a driver for that, and you'd just have to instantiate
> it as a sub-device.
> 
> > 
> > > 
> > > Should I implement the flash update engine as a fpga-mgr device? On one
> > > hand it is just a flash write, FPGA functionality is actually not
> > > changed before reboot. Does fpga-mgr requires bitstream takes function
> > > immediately after write_complete()? On the other hand, the flash write
> > > do affects FPGA static region on next boot. Operating on the
> > > corresponding fpga region makes kernel fully aware of what is being
> > > done.
> > 
> > When an fpga-mgr is used in a device tree overlay flow, one gains
> > the benefit the enumeration of the nodes in the overlay after the
> > update has completed.
> 
> I'm not sure how to model 'on next reboot' part.
> > 
> > > 
> > > Actually the FPGA card do has the capability to reload bitstream at
> > > runtime. But it will cause the whole PCIE device lost, static region is
> > > also destroyed. We need to rescan PCI to get it back. So I think
> > > basically this is the same case as system reboot from FPGA's
> > > perspective.
> > 
> > Yes, on those cards that have the ability to power cycle themselves (i.e.
> > fully reconfigure the FPGA from flash), the PCIe connection to the card
> > is broken because of a surprise link down PCIe error.  As you say a PCI
> > rescan (i.e. re-enumeration of the entire card) is required.  Since
> > the card has to be re-scanned at the PCI level anyway, there may not be much
> > benefit to using the fpga-mgr in this flow.
> 
> Agreed.
> > 
> > I wonder if these kinds of more disruptive updates are better suited to
> > something firmware updates rather than fpga updates?
> 
> Yeah.
> 
> Cheers,
> Moritz
