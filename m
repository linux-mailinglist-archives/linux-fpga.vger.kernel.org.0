Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C0E73D78A1
	for <lists+linux-fpga@lfdr.de>; Tue, 27 Jul 2021 16:39:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236701AbhG0Ojt (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 27 Jul 2021 10:39:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:33538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231466AbhG0Ojt (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 27 Jul 2021 10:39:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1C79061AF9;
        Tue, 27 Jul 2021 14:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1627396788;
        bh=xMQdYYRSplk1TL5gbMRBJ365qclfX0RcdEWRyhYvde0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bHX/J8Pttrz8wjTfzRQKuZOxSMEQlZb2XJL9iM0rGQ7MpCpVfK9yHcfzB7cDgwKAX
         870CqCkb9Y5C0f+PnHPQoOkaJyXsXC7pazRAXzwsLiTKacIXm0DdTK5vLN0rj7PVfx
         W6sIBk6K6TRqlEu+DfrZurjdAgzkY7RQldSlvgm8=
Date:   Tue, 27 Jul 2021 16:39:46 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Moritz Fischer <mdf@kernel.org>
Cc:     linux-fpga@vger.kernel.org
Subject: Re: [GIT PULL] FPGA Manager changes for 5.15-rc1
Message-ID: <YQAasvgaqFxPexLf@kroah.com>
References: <YP4kHpn7CDzCYrbU@epycbox.lan>
 <YP4lYQAedSyF2zAe@epycbox.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YP4lYQAedSyF2zAe@epycbox.lan>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Sun, Jul 25, 2021 at 08:00:49PM -0700, Moritz Fischer wrote:
> Hi Greg,
> 
> On Sun, Jul 25, 2021 at 07:55:26PM -0700, Moritz Fischer wrote:
> > The following changes since commit e73f0f0ee7541171d89f2e2491130c7771ba58d3:
> > 
> >   Linux 5.14-rc1 (2021-07-11 15:07:40 -0700)
> > 
> > are available in the Git repository at:
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/mdf/linux-fpga tags/fpga-for-5.15
> > 
> > for you to fetch changes up to c485d3bf3cc7790faed2b90c799a38caa2f69268:
> > 
> >   fpga: fpga-mgr: wrap the write_sg() op (2021-07-18 08:05:00 -0700)
> > 
> > ----------------------------------------------------------------
> > FPGA Manager Changes for 5.15-rc1
> > 
> > FPGA Manager
> > 
> > - Navin's change removes a duplicate word in a comment
> > - Tom's change fixes a spelling mistake
> > - Mauro's change fixes up documentation
> > - Tom's second set adds wrappers to allow drivers not having to
> >   implement empty functions by moving checks into fpga-mgr core code
> > - My changes address a bunch of warnings
> > 
> > DFL
> > 
> > - Martin's change adds a new PCI ID for Silicom N501x PAC cards
> > 
> > All patches have been reviewed on the mailing list, and have been in the
> > last linux-next releases (as part of my for-next branch).
> > 
> > I did get a complaint about one of the commit messages w/ a Fixes: tag
> > which would need a rebase to fix.
> > 
> > Some of the earlier patches were originally meant for 5.14 but missed
> > the merge window by a couple of days, hence the back-merge of 5.14-rc1.
> > 
> > Signed-offy-by: Moritz Fischer <mdf@kernel.org>
> > 
> > ----------------------------------------------------------------
> > Martin Hundebøll (1):
> >       fpga: dfl: pci: add device IDs for Silicom N501x PAC cards
> > 
> > Mauro Carvalho Chehab (1):
> >       docs: driver-api: fpga: avoid using UTF-8 chars
> > 
> > Moritz Fischer (5):
> >       Merge tag 'v5.14-rc1' into for-next
> >       fpga: altera-freeze-bridge: Address warning about unused variable
> >       fpga: xiilnx-spi: Address warning about unused variable
> >       fpga: xilinx-pr-decoupler: Address warning about unused variable
> >       fpga: zynqmp-fpga: Address warning about unused variable
> > 
> > Navin Sankar Velliangiri (1):
> >       fpga: fpga-bridge: removed repeated word
> > 
> > Tom Rix (8):
> >       fpga: fix spelling mistakes
> >       fpga: fpga-mgr: wrap the write_init() op
> >       fpga: fpga-mgr: make write_complete() op optional
> >       fpga: fpga-mgr: wrap the write() op
> >       fpga: fpga-mgr: wrap the status() op
> >       fpga: fpga-mgr: wrap the state() op
> >       fpga: fpga-mgr: wrap the fpga_remove() op
> >       fpga: fpga-mgr: wrap the write_sg() op
> > 
> >  Documentation/driver-api/fpga/fpga-bridge.rst      |  10 +-
> >  Documentation/driver-api/fpga/fpga-mgr.rst         |  12 +--
> >  Documentation/driver-api/fpga/fpga-programming.rst |   8 +-
> >  Documentation/driver-api/fpga/fpga-region.rst      |  20 ++--
> >  Documentation/fpga/dfl.rst                         |   4 +-
> >  drivers/fpga/altera-cvp.c                          |   2 +-
> >  drivers/fpga/altera-freeze-bridge.c                |   2 +
> >  drivers/fpga/dfl-fme-mgr.c                         |   6 --
> >  drivers/fpga/dfl-fme-pr.c                          |   2 +-
> >  drivers/fpga/dfl-n3000-nios.c                      |   2 +-
> >  drivers/fpga/dfl-pci.c                             |   5 +
> >  drivers/fpga/dfl.h                                 |   2 +-
> >  drivers/fpga/fpga-bridge.c                         |   8 +-
> >  drivers/fpga/fpga-mgr.c                            | 111 ++++++++++++++-------
> >  drivers/fpga/stratix10-soc.c                       |   6 --
> >  drivers/fpga/ts73xx-fpga.c                         |   6 --
> >  drivers/fpga/xilinx-pr-decoupler.c                 |   2 +
> >  drivers/fpga/xilinx-spi.c                          |   2 +
> >  drivers/fpga/zynq-fpga.c                           |   6 +-
> >  drivers/fpga/zynqmp-fpga.c                         |  10 +-
> >  include/linux/fpga/fpga-mgr.h                      |   2 +-
> >  21 files changed, 127 insertions(+), 101 deletions(-)
> 
> I realize the backwards merge is somewhat messy, as discussed you said
> to not rebase.
> 
> Alternatively there's a tag (fpga-for-5.15-early) with the changes
> rebased onto v5.14-rc1 that also addresses the 'Fixes: ' tag.
> 
> If you pull that instead then I could just merge that tag into my
> for-next branch and linux-next should be fine again.
> 
> When I localy tried it seemed to resolve fine with merge either of the
> branches involved (linux-next/master, char-misc-next, for-next).

I would take this, but I get the following warning (and if I ignore it,
you will get it from linux-next):

Commit: 6c17b7ff1d11 ("fpga: zynqmp-fpga: Address warning about unused variable")
	Fixes tag: Fixes: c09f7471127e ("fpga manager: Adding FPGA Manager support for
	Has these problem(s):
	        - Subject has leading but no trailing parentheses
	        - Subject has leading but no trailing quotes

So can you fix this up?  Might as well just rebase and redo the whole
tree, then you can add the additional patch you send after this to it as
well.

thanks,

greg k-h
