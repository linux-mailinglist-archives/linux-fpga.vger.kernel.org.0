Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 675883A1B92
	for <lists+linux-fpga@lfdr.de>; Wed,  9 Jun 2021 19:13:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231297AbhFIRPo (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 9 Jun 2021 13:15:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:53780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230152AbhFIRPo (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 9 Jun 2021 13:15:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EE50F613C8;
        Wed,  9 Jun 2021 17:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1623258829;
        bh=mrltbATYx5NNXTNMp4PuZw7n1trAAIuzp8ITORE+/CY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cY7eMAwWJm/208m+Lz3ay4y3HYlxptutAfcsiHAlOpVTmwL4NIMV10xDYf2RMHSJ3
         wQER/46JyYW3jc49MNldlS3coNujZCqLLlKFGhJvuPA3awOG2lV0QKuUj9L9fhJ1HI
         8lhffABS9K/XCj+KNSI35PsWgGiYxJq7FMcgIQ70=
Date:   Wed, 9 Jun 2021 19:13:47 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Tom Rix <trix@redhat.com>
Cc:     mdf@kernel.org, hao.wu@intel.com, michal.simek@xilinx.com,
        nava.manne@xilinx.com, dinguyen@kernel.org,
        krzysztof.kozlowski@canonical.com, yilun.xu@intel.com,
        arnd@arndb.de, fpacheco@redhat.com, richard.gong@intel.com,
        luca@lucaceresoli.net, linux-kernel@vger.kernel.org,
        linux-fpga@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 0/4] fpga: reorganize to subdirs
Message-ID: <YMD2yxtsQN16MoPA@kroah.com>
References: <20210609142208.3085451-1-trix@redhat.com>
 <YMDV7R52QUTFhpHH@kroah.com>
 <2738ee7a-448f-c327-c430-13fb44da45ec@redhat.com>
 <YMDueTEHGWuAcknP@kroah.com>
 <a35f5fda-a202-dc66-4445-b3ce333a55e6@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a35f5fda-a202-dc66-4445-b3ce333a55e6@redhat.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Wed, Jun 09, 2021 at 09:50:39AM -0700, Tom Rix wrote:
> 
> On 6/9/21 9:38 AM, Greg KH wrote:
> > On Wed, Jun 09, 2021 at 08:08:06AM -0700, Tom Rix wrote:
> > > On 6/9/21 7:53 AM, Greg KH wrote:
> > > > On Wed, Jun 09, 2021 at 07:22:03AM -0700, trix@redhat.com wrote:
> > > > > From: Tom Rix <trix@redhat.com>
> > > > > 
> > > > > The incoming xrt patchset has a toplevel subdir xrt/
> > > > > The current fpga/ uses a single dir with filename prefixes to subdivide owners
> > > > > For consistency, there should be only one way to organize the fpga/ dir.
> > > > > Because the subdir model scales better, refactor to use it.
> > > > > The discussion wrt xrt is here:
> > > > > https://lore.kernel.org/linux-fpga/68e85a4f-4a10-1ff9-0443-aa565878c855@redhat.com/
> > > > > 
> > > > > Follow drivers/net/ethernet/ which has control configs
> > > > > NET_VENDOR_BLA that map to drivers/net/ethernet/bla
> > > > > Since fpgas do not have many vendors, drop the 'VENDOR' and use
> > > > > FPGA_BLA.
> > > > > 
> > > > > There are several new subdirs
> > > > > altera/
> > > > > dfl/
> > > > > lattice/
> > > > > xilinx/
> > > > > 
> > > > > Each subdir has a Kconfig that has a new/reused
> > > > > 
> > > > > if FPGA_BLA
> > > > >     ... existing configs ...
> > > > > endif FPGA_BLA
> > > > > 
> > > > > Which is sourced into the main fpga/Kconfig
> > > > > 
> > > > > Each subdir has a Makefile whose transversal is controlled in the
> > > > > fpga/Makefile by
> > > > > 
> > > > > obj-$(CONFIG_FPGA_BLA) += bla/
> > > > > 
> > > > > Some cleanup to arrange thing alphabetically and make fpga/Makefile's
> > > > > whitespace look more like net/'s
> > > > > 
> > > > > Changes from
> > > > > v1
> > > > >     Drop renaming files
> > > > >     Cleanup makefiles
> > > > You can rename the files, you just can not rename the .ko objects
> > > > without everyone knowing what you are doing and you trying to bury it in
> > > > the middle of a differently described patch.
> > > > 
> > > > If you want to do that, do you?  I don't really understand why you want
> > > > to move things around right now other than "we have 40 files in one
> > > > directory, ick!".
> > > I am trying to resolve the layout inconsistency between what we have and
> > > what the xrt patchset does.
> > Why does it matter?  New stuff can be added to a new dir, why worry
> > about old stuff?  What does it hurt?
> > 
> > > The big issue is the files vs dirs.
> > > 
> > > Over specified filenames is secondary, so I dropped them.
> > > 
> > > 40 files in one dir is itself not a problem.
> > > 
> > > having 40 files and an xrt/ is.
> > Why is that a "problem"?
> > 
> > > fpga/ layout should be consistent so the Makefile and Kconfig are easier to
> > > maintain.
> > Is it somehow hard to maintain today?  Seems pretty trivial to me...
> 
> This change was to help move xrt along.
> 
> If you are fine with xrt/, I will drop this patchset.

Who has objected to xrt/ being the only new subdirectory?

My main complaints here are:
	- these patches were not tested
	- you renamed kernel modules "accidentally"
	- you forgot SPDX lines
	- lack of description of why these files being moved was
	  necessary in the changelog where you moved the files

Remember, patch 0/X never shows up in changelogs...

You can do better :)

greg k-h
