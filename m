Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 520521BCF62
	for <lists+linux-fpga@lfdr.de>; Wed, 29 Apr 2020 00:04:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbgD1WEh (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 28 Apr 2020 18:04:37 -0400
Received: from mga02.intel.com ([134.134.136.20]:13558 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725934AbgD1WEg (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 28 Apr 2020 18:04:36 -0400
IronPort-SDR: 7A9YF1c+TMb08MV2ZPgmy8qz+pw8Qq+9b0zRE8tOS/xdX++yaj8t+GwIeHvTtgEk64eeinNX8p
 LawRfEUrDuoQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2020 15:04:36 -0700
IronPort-SDR: l7M6V/bjnoYBNCtL9HPR7FeFyttpjX6WR+y0CL4huH55MgwCiaTD7IbXtPAVPJfcbTZ2xSJSQ3
 cTZUntqq7+Wg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,328,1583222400"; 
   d="scan'208";a="282292044"
Received: from psera2-dell24.ra.intel.com ([10.54.154.157])
  by fmsmga004.fm.intel.com with ESMTP; 28 Apr 2020 15:04:36 -0700
Date:   Tue, 28 Apr 2020 15:06:07 -0700 (PDT)
From:   matthew.gerlach@linux.intel.com
X-X-Sender: lab@psera2-dell24.ra.intel.com
To:     Xu Yilun <yilun.xu@intel.com>
cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        mdf@kernel.org
Subject: Re: How to update a piece of flash for FPGA firmware?
In-Reply-To: <20200428050135.GA27416@yilunxu-OptiPlex-7050>
Message-ID: <alpine.LFD.2.21.2004281434001.59524@psera2-dell24.ra.intel.com>
References: <20200428050135.GA27416@yilunxu-OptiPlex-7050>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi Yilun,

You raise some very interesting questions. Please see
my comments below.

Matthew

On Tue, 28 Apr 2020, Xu Yilun wrote:

> Hi,
>
> I wonder if an updating of FPGA Flash (but cannot reload) could be
> implemented as fpga-mgr?
>
> I have the pcie based FPGA card. The bitstream for FPGA static region is
> stored on flash chip. Board will load the bitstream to FPGA on system
> power cycle. The flash chip could be accessed through "PCIE -> ... ->
> Flash update engine -> Flash". So the update of the FPGA static region is
> basicly updating the flash chip through PCIE and rebooting system.

I think you mean power cycle when you say "rebooting system" above, but
your point is worth highlighting.  During this flash update the
FPGA is actually fully configured and running its application.  Typically,
during a fpga-mgr update of the static region or partial reconfiguration
region, the actual contents of the fpga region is "changing" during the 
update.

>
> Should I implement the flash update engine as a fpga-mgr device? On one
> hand it is just a flash write, FPGA functionality is actually not
> changed before reboot. Does fpga-mgr requires bitstream takes function
> immediately after write_complete()? On the other hand, the flash write
> do affects FPGA static region on next boot. Operating on the
> corresponding fpga region makes kernel fully aware of what is being
> done.

When an fpga-mgr is used in a device tree overlay flow, one gains
the benefit the enumeration of the nodes in the overlay after the
update has completed.

>
> Actually the FPGA card do has the capability to reload bitstream at
> runtime. But it will cause the whole PCIE device lost, static region is
> also destroyed. We need to rescan PCI to get it back. So I think
> basically this is the same case as system reboot from FPGA's
> perspective.

Yes, on those cards that have the ability to power cycle themselves (i.e. 
fully reconfigure the FPGA from flash), the PCIe connection to the card
is broken because of a surprise link down PCIe error.  As you say a PCI 
rescan (i.e. re-enumeration of the entire card) is required.  Since
the card has to be re-scanned at the PCI level anyway, there may not be 
much benefit to using the fpga-mgr in this flow.

I wonder if these kinds of more disruptive updates are better suited to 
something firmware updates rather than fpga updates?

>
> Thanks
> Yilun
>
