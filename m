Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E6F49177AE4
	for <lists+linux-fpga@lfdr.de>; Tue,  3 Mar 2020 16:48:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729603AbgCCPrV (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 3 Mar 2020 10:47:21 -0500
Received: from mga11.intel.com ([192.55.52.93]:1722 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729537AbgCCPrV (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 3 Mar 2020 10:47:21 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Mar 2020 07:47:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,511,1574150400"; 
   d="scan'208";a="228954360"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.141])
  by orsmga007.jf.intel.com with ESMTP; 03 Mar 2020 07:47:19 -0800
Date:   Tue, 3 Mar 2020 23:45:22 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     John Garry <john.garry@huawei.com>, luis.f.tanica@seagate.com
Cc:     linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org,
        gregkh@linuxfoundation.org, arnd@arndb.de
Subject: Re: LPC Bus Driver
Message-ID: <20200303154522.GA24568@yilunxu-OptiPlex-7050>
References: <6daf1bb266a24c239aed34d8661fc5eaMW2PR20MB210660F6B17CB90ACD0B6E7CA0E70@MW2PR20MB2106.namprd20.prod.outlook.com>
 <797cec65-5504-ee85-3fe4-fe2b4c90991f@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <797cec65-5504-ee85-3fe4-fe2b4c90991f@huawei.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Tue, Mar 03, 2020 at 10:13:36AM +0000, John Garry wrote:
> + add fpga list and Greg+Arnd for misc drivers
> 
> Hi Luis,
> 
> >
> >We have this board with our own SoC, which is connected to an external CPLD (FPGA) via LPC (low pin count) bus.
> >I've been doing some research to see what the best way of designing the drivers for it would be, and came across the Hisilicon LPC driver stuff (which I believe you're the maintainer for).
> >
> >Just a little background. Let's say our host (ARM) has a custom LPC controller. The LPC controller let's us perform reads/writes of CPLD registers via LPC bus. This CPLD is the only slave device attached to that bus and we only use it for reading/writing certain
> >  registers (e.g., we use it to access some system information and for resetting the ARM during reboot).
> >
> >I was looking at the regmap framework and that seemed a good way to go.
> 
> I thought that regmap only allows mapping in MMIO regions for multiplexing
> access from multiple drivers or accessing registers outside the device HW
> registers, but you seem to need to manually generate the LPC bus accesses to
> access registers on the slave device.

I'm not familar with LPC controller, but seems it could not perform
read/write by one memory access or io access instruction

I didn't find an existing bus_type for LPC bus, so I think regmap is a
good way. When you have implemented the regmap for LPC bus, you need to
access the CPLD registers by regmap_read/write, and just pass CPLD local
register addr as parameter.

> 
> If this FPGA is the only device which will ever be on this LPC bus, then
> could you encode the LPC accesses directly in the FPGA driver?
> 
> > But then I saw the logic_pio stuff as well and now I'm not sure what the
> best approach would be anymore
> 
> Logic PIO is for IO Port accesses. It could serve your purpose, but you
> would need to use IO port accesses for your slave driver, like inb and outb.

I quickly checked the logic PIO. When you implemented logic_pio for your lpc
and CPLD, you create an map from IO port addr to CPLD register addr. You
need to use inb/outb to access CPLD register (with some uncertain IO addrs?)

I'm not sure why it is needed to access non-pio devices using PIO, it
may be of some special purpose? 

Regmap may be a general choise.

> 
> As another alternative, it might be worth considering writing an I2C
> controller driver for your LPC host, i.e. model as an I2C bus, and have an
> I2C client driver for the LPC slave (FPGA). I think that there are examples
> of this in the kernel.

How the host cpu is connected to LPC host?
Why an I2C controller driver for LPC host? The LPC bus is compatible to i2c bus?

Thanks,
Yilun

> 
> All the best,
> john
