Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E67DD3A1B20
	for <lists+linux-fpga@lfdr.de>; Wed,  9 Jun 2021 18:38:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231783AbhFIQkP (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 9 Jun 2021 12:40:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:37700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230027AbhFIQkO (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 9 Jun 2021 12:40:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6F56B610A1;
        Wed,  9 Jun 2021 16:38:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1623256700;
        bh=+RFAsW+BaB3yvovWMXUbFjPkdC4MfCKQ/OHeDLLypOo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Gz1l5VeehUfuEU6uicGlld1GwqCqBHYgpO85Pmfr4E/YdbaxulWCSv6b0/qeNw1WG
         UrWc8Fiy6UDCIU06XQ6J/0l8agXXwVZkozQ+6KSMd/MYgVjPGu+PkjH5Koa7dHPA7N
         U3d3ykLDZGypq2nCWAzNdvniD/CGFax2paWCvLI4=
Date:   Wed, 9 Jun 2021 18:38:17 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Tom Rix <trix@redhat.com>
Cc:     mdf@kernel.org, hao.wu@intel.com, michal.simek@xilinx.com,
        nava.manne@xilinx.com, dinguyen@kernel.org,
        krzysztof.kozlowski@canonical.com, yilun.xu@intel.com,
        arnd@arndb.de, fpacheco@redhat.com, richard.gong@intel.com,
        luca@lucaceresoli.net, linux-kernel@vger.kernel.org,
        linux-fpga@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 0/4] fpga: reorganize to subdirs
Message-ID: <YMDueTEHGWuAcknP@kroah.com>
References: <20210609142208.3085451-1-trix@redhat.com>
 <YMDV7R52QUTFhpHH@kroah.com>
 <2738ee7a-448f-c327-c430-13fb44da45ec@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2738ee7a-448f-c327-c430-13fb44da45ec@redhat.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Wed, Jun 09, 2021 at 08:08:06AM -0700, Tom Rix wrote:
> 
> On 6/9/21 7:53 AM, Greg KH wrote:
> > On Wed, Jun 09, 2021 at 07:22:03AM -0700, trix@redhat.com wrote:
> > > From: Tom Rix <trix@redhat.com>
> > > 
> > > The incoming xrt patchset has a toplevel subdir xrt/
> > > The current fpga/ uses a single dir with filename prefixes to subdivide owners
> > > For consistency, there should be only one way to organize the fpga/ dir.
> > > Because the subdir model scales better, refactor to use it.
> > > The discussion wrt xrt is here:
> > > https://lore.kernel.org/linux-fpga/68e85a4f-4a10-1ff9-0443-aa565878c855@redhat.com/
> > > 
> > > Follow drivers/net/ethernet/ which has control configs
> > > NET_VENDOR_BLA that map to drivers/net/ethernet/bla
> > > Since fpgas do not have many vendors, drop the 'VENDOR' and use
> > > FPGA_BLA.
> > > 
> > > There are several new subdirs
> > > altera/
> > > dfl/
> > > lattice/
> > > xilinx/
> > > 
> > > Each subdir has a Kconfig that has a new/reused
> > > 
> > > if FPGA_BLA
> > >    ... existing configs ...
> > > endif FPGA_BLA
> > > 
> > > Which is sourced into the main fpga/Kconfig
> > > 
> > > Each subdir has a Makefile whose transversal is controlled in the
> > > fpga/Makefile by
> > > 
> > > obj-$(CONFIG_FPGA_BLA) += bla/
> > > 
> > > Some cleanup to arrange thing alphabetically and make fpga/Makefile's
> > > whitespace look more like net/'s
> > > 
> > > Changes from
> > > v1
> > >    Drop renaming files
> > >    Cleanup makefiles
> > You can rename the files, you just can not rename the .ko objects
> > without everyone knowing what you are doing and you trying to bury it in
> > the middle of a differently described patch.
> > 
> > If you want to do that, do you?  I don't really understand why you want
> > to move things around right now other than "we have 40 files in one
> > directory, ick!".
> 
> I am trying to resolve the layout inconsistency between what we have and
> what the xrt patchset does.

Why does it matter?  New stuff can be added to a new dir, why worry
about old stuff?  What does it hurt?

> The big issue is the files vs dirs.
> 
> Over specified filenames is secondary, so I dropped them.
> 
> 40 files in one dir is itself not a problem.
> 
> having 40 files and an xrt/ is.

Why is that a "problem"?

> fpga/ layout should be consistent so the Makefile and Kconfig are easier to
> maintain.

Is it somehow hard to maintain today?  Seems pretty trivial to me...

thanks,

greg k-h
