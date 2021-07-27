Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90D103D7AAD
	for <lists+linux-fpga@lfdr.de>; Tue, 27 Jul 2021 18:13:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbhG0QNm (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 27 Jul 2021 12:13:42 -0400
Received: from mail-pj1-f46.google.com ([209.85.216.46]:51902 "EHLO
        mail-pj1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbhG0QNm (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 27 Jul 2021 12:13:42 -0400
Received: by mail-pj1-f46.google.com with SMTP id mt6so18523347pjb.1
        for <linux-fpga@vger.kernel.org>; Tue, 27 Jul 2021 09:13:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=+728+BYL1hD1p5GJgBuae2H0I5a/X6rfirNox4ZM0aM=;
        b=ICdzqGq6W7TXsM+Y6mniJY6qfTIQZVb41EECPpfI4T+2tpSCyi3ekCAolv45I6lB+9
         EhnlsYU31V/MpEVJZn9FHSm7LMcrQrjgBSmP7DlBPCMCFwmzhJn3DLm5DmehLlbp3iEm
         lyED/9lUDh9tSPzXyz9ZfUybNqOLz5ZUJH7dT3a1KEn6uFeZ5OH4eTC65jxfZoB4Y/+W
         5mLRP6A8EOqN6q7Ycb9bPEbgXpJ2Ca6y4Dm/oKJ+EqHS1pnpzK4nto3R7MJl8lPz9kd3
         zjgbpC7MzFjiIgatb6RdKUMFg6MoNIoaF+OsLxIXFUWMoSYgdSF8zgHWQ+kejJ20TDU/
         i+tg==
X-Gm-Message-State: AOAM532pPOGE7SMzfPkgCjG2WNBtKRQp9uNy86gyA1xbd7EqVjtI4r87
        f2XVCqXv1BLKtcDUn9jNU80=
X-Google-Smtp-Source: ABdhPJw49o97knpVKtpVlJy1nzCTvBTbVa9TT8Y2+Mqeojg8m/x7F/vgSp3jZsHHjsKhmKtkeDY37A==
X-Received: by 2002:a17:90b:1896:: with SMTP id mn22mr10799605pjb.148.1627402421420;
        Tue, 27 Jul 2021 09:13:41 -0700 (PDT)
Received: from localhost ([2601:647:5b00:6f70:be34:681b:b1e9:776f])
        by smtp.gmail.com with ESMTPSA id m2sm3438859pja.52.2021.07.27.09.13.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 09:13:40 -0700 (PDT)
Date:   Tue, 27 Jul 2021 09:13:39 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org
Subject: Re: [GIT PULL] FPGA Manager changes for 5.15-rc1
Message-ID: <YQAwszw/HLBUXmti@epycbox.lan>
References: <YP4kHpn7CDzCYrbU@epycbox.lan>
 <YP4lYQAedSyF2zAe@epycbox.lan>
 <YQAasvgaqFxPexLf@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YQAasvgaqFxPexLf@kroah.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Tue, Jul 27, 2021 at 04:39:46PM +0200, Greg KH wrote:
> On Sun, Jul 25, 2021 at 08:00:49PM -0700, Moritz Fischer wrote:
> > Hi Greg,
> > 
> > On Sun, Jul 25, 2021 at 07:55:26PM -0700, Moritz Fischer wrote:
> > > The following changes since commit e73f0f0ee7541171d89f2e2491130c7771ba58d3:
> > > 
> > >   Linux 5.14-rc1 (2021-07-11 15:07:40 -0700)
> > > 
> > > are available in the Git repository at:
> > > 
> > >   git://git.kernel.org/pub/scm/linux/kernel/git/mdf/linux-fpga tags/fpga-for-5.15
> > > 
> > > for you to fetch changes up to c485d3bf3cc7790faed2b90c799a38caa2f69268:
> > > 
> > >   fpga: fpga-mgr: wrap the write_sg() op (2021-07-18 08:05:00 -0700)
> > > 
> > > ----------------------------------------------------------------
> > > FPGA Manager Changes for 5.15-rc1
> > > 
> > > FPGA Manager
> > > 
> > > - Navin's change removes a duplicate word in a comment
> > > - Tom's change fixes a spelling mistake
> > > - Mauro's change fixes up documentation
> > > - Tom's second set adds wrappers to allow drivers not having to
> > >   implement empty functions by moving checks into fpga-mgr core code
> > > - My changes address a bunch of warnings
> > > 
> > > DFL
> > > 
> > > - Martin's change adds a new PCI ID for Silicom N501x PAC cards
> > > 
> > > All patches have been reviewed on the mailing list, and have been in the
> > > last linux-next releases (as part of my for-next branch).
> > > 
> > > I did get a complaint about one of the commit messages w/ a Fixes: tag
> > > which would need a rebase to fix.
> > > 
> > > Some of the earlier patches were originally meant for 5.14 but missed
> > > the merge window by a couple of days, hence the back-merge of 5.14-rc1.
> > > 
> > > Signed-offy-by: Moritz Fischer <mdf@kernel.org>
> > > 
> > > ----------------------------------------------------------------
> > > Martin Hundebøll (1):
> > >       fpga: dfl: pci: add device IDs for Silicom N501x PAC cards
> > > 
> > > Mauro Carvalho Chehab (1):
> > >       docs: driver-api: fpga: avoid using UTF-8 chars
> > > 
> > > Moritz Fischer (5):
> > >       Merge tag 'v5.14-rc1' into for-next
> > >       fpga: altera-freeze-bridge: Address warning about unused variable
> > >       fpga: xiilnx-spi: Address warning about unused variable
> > >       fpga: xilinx-pr-decoupler: Address warning about unused variable
> > >       fpga: zynqmp-fpga: Address warning about unused variable
> > > 
> > > Navin Sankar Velliangiri (1):
> > >       fpga: fpga-bridge: removed repeated word
> > > 
> > > Tom Rix (8):
> > >       fpga: fix spelling mistakes
> > >       fpga: fpga-mgr: wrap the write_init() op
> > >       fpga: fpga-mgr: make write_complete() op optional
> > >       fpga: fpga-mgr: wrap the write() op
> > >       fpga: fpga-mgr: wrap the status() op
> > >       fpga: fpga-mgr: wrap the state() op
> > >       fpga: fpga-mgr: wrap the fpga_remove() op
> > >       fpga: fpga-mgr: wrap the write_sg() op
> > > 
> > >  Documentation/driver-api/fpga/fpga-bridge.rst      |  10 +-
> > >  Documentation/driver-api/fpga/fpga-mgr.rst         |  12 +--
> > >  Documentation/driver-api/fpga/fpga-programming.rst |   8 +-
> > >  Documentation/driver-api/fpga/fpga-region.rst      |  20 ++--
> > >  Documentation/fpga/dfl.rst                         |   4 +-
> > >  drivers/fpga/altera-cvp.c                          |   2 +-
> > >  drivers/fpga/altera-freeze-bridge.c                |   2 +
> > >  drivers/fpga/dfl-fme-mgr.c                         |   6 --
> > >  drivers/fpga/dfl-fme-pr.c                          |   2 +-
> > >  drivers/fpga/dfl-n3000-nios.c                      |   2 +-
> > >  drivers/fpga/dfl-pci.c                             |   5 +
> > >  drivers/fpga/dfl.h                                 |   2 +-
> > >  drivers/fpga/fpga-bridge.c                         |   8 +-
> > >  drivers/fpga/fpga-mgr.c                            | 111 ++++++++++++++-------
> > >  drivers/fpga/stratix10-soc.c                       |   6 --
> > >  drivers/fpga/ts73xx-fpga.c                         |   6 --
> > >  drivers/fpga/xilinx-pr-decoupler.c                 |   2 +
> > >  drivers/fpga/xilinx-spi.c                          |   2 +
> > >  drivers/fpga/zynq-fpga.c                           |   6 +-
> > >  drivers/fpga/zynqmp-fpga.c                         |  10 +-
> > >  include/linux/fpga/fpga-mgr.h                      |   2 +-
> > >  21 files changed, 127 insertions(+), 101 deletions(-)
> > 
> > I realize the backwards merge is somewhat messy, as discussed you said
> > to not rebase.
> > 
> > Alternatively there's a tag (fpga-for-5.15-early) with the changes
> > rebased onto v5.14-rc1 that also addresses the 'Fixes: ' tag.
> > 
> > If you pull that instead then I could just merge that tag into my
> > for-next branch and linux-next should be fine again.
> > 
> > When I localy tried it seemed to resolve fine with merge either of the
> > branches involved (linux-next/master, char-misc-next, for-next).
> 
> I would take this, but I get the following warning (and if I ignore it,
> you will get it from linux-next):
> 
> Commit: 6c17b7ff1d11 ("fpga: zynqmp-fpga: Address warning about unused variable")
> 	Fixes tag: Fixes: c09f7471127e ("fpga manager: Adding FPGA Manager support for
> 	Has these problem(s):
> 	        - Subject has leading but no trailing parentheses
> 	        - Subject has leading but no trailing quotes
> 
> So can you fix this up?  Might as well just rebase and redo the whole
> tree, then you can add the additional patch you send after this to it as
> well.

The tag mentioned above 'fpga-for-5.15-early', is a rebase that fixes
this on top of v5.14-rc1 (which gets rid of the back-merge, too)

git://git.kernel.org/pub/scm/linux/kernel/git/mdf/linux-fpga tags/fpga-for-5.15-early

I didn't add the patch because it depends on changes in your tree (the
versal driver you applied), which would make for a weird tree if I don't
pull in your changes?

Let me know if you prefer the patch inside anyways or not and I can
send out a new pull request.

Thanks
Moritz
