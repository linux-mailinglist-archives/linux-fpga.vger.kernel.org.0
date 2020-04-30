Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 842331BEE8D
	for <lists+linux-fpga@lfdr.de>; Thu, 30 Apr 2020 05:12:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726345AbgD3DMN (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 29 Apr 2020 23:12:13 -0400
Received: from mail-pf1-f173.google.com ([209.85.210.173]:38854 "EHLO
        mail-pf1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726357AbgD3DMN (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 29 Apr 2020 23:12:13 -0400
Received: by mail-pf1-f173.google.com with SMTP id y25so2198824pfn.5;
        Wed, 29 Apr 2020 20:12:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SMIh/7yA/TcacM5ktTGAgddafFfMiqmeZDeRLLRUZ38=;
        b=N2mzXORPzsRrJudZJFe1GZB06YTGIF0fSTGsf1/Xur9WAeA23hlhOHaBO1APzaT+Qd
         HuSM4tyTmxTIsEKN6rAQsyO9alCiwcyM6x1fgox5zj5sj0FP+Kr86MiiTdwYodO0bSMy
         mRs3+hCPhs8H35EdmtGqltT4d6OVKCR0UEngFZp5U/GF2XiP4Qp+vk1iorA7r0oRkX8r
         VWvr/bHUiaVLU7BexWuvWlvRSFWIit6SXZOMLMMJQjcdXSImQ2U1bwrgcB9YQi0dfyNI
         yEXKOEsaT6TCQBO4TtebGpKq7haP3563aKU8QTUV6aMaZ2qeBWaX/XxxU5pPEPPD13Nz
         A4YA==
X-Gm-Message-State: AGi0PubGSjV5rgZM8rlT/4jHyvvYGBWEJszeq6c9r4iFii3zQk9qzExF
        tdNLhFuKTOWR1QbgUHjDFuk=
X-Google-Smtp-Source: APiQypImFjuz5sapmhHaxue1R17ZIKtmudlLldNmU5d8yRcooOIDtm3MCsQy/NjvrO7HHCc89emJww==
X-Received: by 2002:a63:ce17:: with SMTP id y23mr1251673pgf.194.1588216332547;
        Wed, 29 Apr 2020 20:12:12 -0700 (PDT)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id x13sm1998429pgh.63.2020.04.29.20.12.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 20:12:11 -0700 (PDT)
Date:   Wed, 29 Apr 2020 20:12:10 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     matthew.gerlach@linux.intel.com
Cc:     Xu Yilun <yilun.xu@intel.com>, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, mdf@kernel.org
Subject: Re: How to update a piece of flash for FPGA firmware?
Message-ID: <20200430031210.GA6168@epycbox.lan>
References: <20200428050135.GA27416@yilunxu-OptiPlex-7050>
 <alpine.LFD.2.21.2004281434001.59524@psera2-dell24.ra.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.21.2004281434001.59524@psera2-dell24.ra.intel.com>
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi Matthew, Yilun

On Tue, Apr 28, 2020 at 03:06:07PM -0700, matthew.gerlach@linux.intel.com wrote:
> Hi Yilun,
> 
> You raise some very interesting questions. Please see
> my comments below.
> 
> Matthew
> 
> On Tue, 28 Apr 2020, Xu Yilun wrote:
> 
> > Hi,
> > 
> > I wonder if an updating of FPGA Flash (but cannot reload) could be
> > implemented as fpga-mgr?
> > 
> > I have the pcie based FPGA card. The bitstream for FPGA static region is
> > stored on flash chip. Board will load the bitstream to FPGA on system
> > power cycle. The flash chip could be accessed through "PCIE -> ... ->
> > Flash update engine -> Flash". So the update of the FPGA static region is
> > basicly updating the flash chip through PCIE and rebooting system.
> 
> I think you mean power cycle when you say "rebooting system" above, but
> your point is worth highlighting.  During this flash update the
> FPGA is actually fully configured and running its application.  Typically,
> during a fpga-mgr update of the static region or partial reconfiguration
> region, the actual contents of the fpga region is "changing" during the
> update.

Yeah, this sounds more like a flash driver with MTD or maybe NVMEM?
That's probably how I'd do it. Depending on your (Q)SPI controller you
might already have a driver for that, and you'd just have to instantiate
it as a sub-device.

> 
> > 
> > Should I implement the flash update engine as a fpga-mgr device? On one
> > hand it is just a flash write, FPGA functionality is actually not
> > changed before reboot. Does fpga-mgr requires bitstream takes function
> > immediately after write_complete()? On the other hand, the flash write
> > do affects FPGA static region on next boot. Operating on the
> > corresponding fpga region makes kernel fully aware of what is being
> > done.
> 
> When an fpga-mgr is used in a device tree overlay flow, one gains
> the benefit the enumeration of the nodes in the overlay after the
> update has completed.

I'm not sure how to model 'on next reboot' part.
> 
> > 
> > Actually the FPGA card do has the capability to reload bitstream at
> > runtime. But it will cause the whole PCIE device lost, static region is
> > also destroyed. We need to rescan PCI to get it back. So I think
> > basically this is the same case as system reboot from FPGA's
> > perspective.
> 
> Yes, on those cards that have the ability to power cycle themselves (i.e.
> fully reconfigure the FPGA from flash), the PCIe connection to the card
> is broken because of a surprise link down PCIe error.  As you say a PCI
> rescan (i.e. re-enumeration of the entire card) is required.  Since
> the card has to be re-scanned at the PCI level anyway, there may not be much
> benefit to using the fpga-mgr in this flow.

Agreed.
> 
> I wonder if these kinds of more disruptive updates are better suited to
> something firmware updates rather than fpga updates?

Yeah.

Cheers,
Moritz

