Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62B3E643B89
	for <lists+linux-fpga@lfdr.de>; Tue,  6 Dec 2022 03:49:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233817AbiLFCrr (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 5 Dec 2022 21:47:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233500AbiLFCrZ (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 5 Dec 2022 21:47:25 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5362525C73;
        Mon,  5 Dec 2022 18:46:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670294818; x=1701830818;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4z0LtPoJHsEVq07UVq/A8UAwlUflOHZ+FQEJxvUNZJk=;
  b=UowXesNSK8ycVwgwYIYXt31Eo/1zHdDuVEr6rJHBrf+oi+uVL0bEwMlC
   TbApCGpIMGzR9nQuNqVaTuCprIUsQT2VJUFMMEHn/mBPfB2QFXBB18DOM
   +t7z0jS4jDFVl6r7jPV+BgUgRIq++ueVZ9/JU84cvN1tBxUvM4LchLXdh
   UUpb+H2o75EGW1va627cDAtPsu4Ld+9LpYg0TSbA6jbnfS1RGdQfcPsTO
   Us1QC1hVBUL+NmOf/Z4VIy4vEAfeOcCfk5+y2EjfTcNKWdcCNeRd0osJ3
   ueUY0Elkw+n7iqefeSZ7M/EBTTzrl1XwCLZh3UhMIKcF0lhqQbjmmxN7A
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10552"; a="315226806"
X-IronPort-AV: E=Sophos;i="5.96,220,1665471600"; 
   d="scan'208";a="315226806"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2022 18:46:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10552"; a="974911247"
X-IronPort-AV: E=Sophos;i="5.96,220,1665471600"; 
   d="scan'208";a="974911247"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmsmga005.fm.intel.com with ESMTP; 05 Dec 2022 18:46:55 -0800
Date:   Tue, 6 Dec 2022 10:37:10 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        linux-fpga@vger.kernel.org, Wu Hao <hao.wu@intel.com>,
        Tom Rix <trix@redhat.com>, Moritz Fischer <mdf@kernel.org>,
        Lee Jones <lee@kernel.org>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        Russ Weight <russell.h.weight@intel.com>,
        Tianfei zhang <tianfei.zhang@intel.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Marco Pagani <marpagan@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 7/9] mfd: intel-m10-bmc: Add PMCI driver
Message-ID: <Y46q1jMEp5a8cgSG@yilunxu-OptiPlex-7050>
References: <20221202100841.4741-1-ilpo.jarvinen@linux.intel.com>
 <20221202100841.4741-8-ilpo.jarvinen@linux.intel.com>
 <Y4ox5J0junaUYyT7@yilunxu-OptiPlex-7050>
 <855d463e-fb84-1910-f53-58e6b0a633a4@linux.intel.com>
 <Y43eejWSYIBIlUKB@sirena.org.uk>
 <Y44JaLtAnTll4gU0@yilunxu-OptiPlex-7050>
 <Y4421iAKIm44ghQR@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y4421iAKIm44ghQR@sirena.org.uk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 2022-12-05 at 18:22:14 +0000, Mark Brown wrote:
> On Mon, Dec 05, 2022 at 11:08:24PM +0800, Xu Yilun wrote:
> 
> > It is good for now to implement the indirect access interface in
> > regmap_config, as intel-m10-bmc is the only one who uses it. But I'm not
> > sure when a second IP block(like HSSI) in intel FPGA uses it, how to
> > implement? A shared library?
> 
> The short answer is that I'm not really clear what this looks like so
> it's hard to say.
> 
> Usually things for anything generic end up in drivers/base/regmap but it
> should be generic in some way and thus far the code that's been posted
> has been very much looking specific to a single device even where it's
> been named as something generic.  I've not been able to extract a clear
> picture of what the hardware that's being described is and the code has

I'm trying to describe it later in this thread.

> looked like it's more some vaugely related designs than anything really
> shared, it's really felt like people just want to just merge whatever
> they have in which case just putting it in the driver is the most
> expedient thing.

I agree.

> 
> Clearly the concept of a register map accessed via indirection is a
> generic thing but to implement that at the very least the underlying
> register map should be another regmap rather than hard coded to MMIO.
> 
> > Some background about hardware:
> > Several IP blocks in intel FPGA integrate the same mmio register layout
> > (so called indirect access interface here) as the bridge to the IP's real
> > registers address space. Like:
> 
> >  +---------+          +---------+
> >  | m10 BMC |          |  HSSI   |
> >  +---------+          +---------+
> >  |indirect |          |indirect |
> >  | access  |          | access  |
> >  |  MMIOs  |          |  MMIOs  |
> >  +----+----+          +----+----+
> >       |                    |
> >       |                    |
> >  +----+-----+         +---------+
> >  |m10 bmc   |         | HSSI    |
> >  |registers |         |registers|
> >  +----------+         +---------+
> 
> One of the things I've been unable to tell thus far is if this is a
> single device with a consistent IP for register access (thus far I've
> only seen clear evidence of one device) or if there's multiple devices
> that have been designed this way for some unclear reason.  AIUI these

Multiple devices, or a series of similar Intel PCIe based FPGA card.

> are IPs within a single FPGA which is the top level MFD here?  If this

Yes, the Intel FPGA PCI device acts similarly as top level MFD, but it has
its own enumeration mechanism for these IPs, called Device Feature
list(DFL).

 +--------------------------------------------------------------------+
 |        Intel PCIe based FPGA device                                |
 |                                                                    |
 |    +---------+--next--->+---------+---next--->+--------+---> [...] |
 |    | node for|          | node for|           |node for|           |
 |    | m10 BMC |          |  HSSI   |           | Another|           |
 |    +---------+          +---------+           | IP     |           |
 |    |indirect |          |indirect |           +--------+           |
 |    | access  |          | access  |           |specific|           |
 |    |  MMIOs  |          |  MMIOs  |           | MMIOs  |           |
 |    +----+----+          +----+----+           +--------+           |
 |         |                    |                                     |
 |         |                    |                                     |
 |    +----+-----+         +---------+                                |
 |    |m10 bmc   |         | HSSI    |                                |
 |    |registers |         |registers|                                |
 |    +----------+         +---------+                                |
 +--------------------------------------------------------------------+

> is one FPGA then perhaps the top level driver for the FPGA ought to just
> handle whatever weirdness the FPGA has?  The fact that there doesn't

I think this could be a choice. A helper in top level driver that deal
with the creation of the regmap for sub device drivers.

> seem to be a name for this stuff makes it seem device specific.
> 
> The code that I've seen posted has looked like the register layout isn't
> shared, all the register offsets have been variable, but there's this
> thing with there being what looks like a command queue/IO completion
> thing which seemed to be the only kind of substantial thing being
> shared.

Yes, the indirect access register block are embedded in each IP's
MMIO space, its base or offset is specific to each IP. But within
each copy of the indirect access register block, the layout is the
same.

And thanks for your detailed explaination.
Yilun
