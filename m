Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 994401AAF7C
	for <lists+linux-fpga@lfdr.de>; Wed, 15 Apr 2020 19:25:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410958AbgDORZK (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 15 Apr 2020 13:25:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:39334 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2410926AbgDORZJ (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 15 Apr 2020 13:25:09 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7B03A20787;
        Wed, 15 Apr 2020 17:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586971508;
        bh=FkuOn46zboCeaH/kC7OTYEmrjuYmf/mObtZLVHd0mLQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2EGgI2oXgl1tefayxMrDf20ma/E+k8hzgWkV832YPqkrOKAx0VGpyGTRl9uWvKF0b
         Hkcxj8i57WNmExGt497020XdbUXFg4ATiYtR9DVGYXwwjvlouac8aehtOXja75jDox
         3AdQ/iBbk4i67KTWRKmf72YPOscKVL8R7ERUX15Y=
Date:   Wed, 15 Apr 2020 19:25:06 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Moritz Fischer <moritz.fischer.private@gmail.com>
Cc:     Moritz Fischer <moritzf@google.com>, linux-fpga@vger.kernel.org
Subject: Re: [GIT PULL] FPGA Manager (late) fixes for 5.7
Message-ID: <20200415172506.GB3661754@kroah.com>
References: <20200331035459.GA3472@epycbox.lan>
 <CAJYdmeP+wwLN7fc_6UgFAKOk5yR=OradHtH0MXVhR_TBQD7M5A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJYdmeP+wwLN7fc_6UgFAKOk5yR=OradHtH0MXVhR_TBQD7M5A@mail.gmail.com>
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Wed, Apr 15, 2020 at 09:05:50AM -0700, Moritz Fischer wrote:
> On Mon, Mar 30, 2020 at 8:55 PM Moritz Fischer <mdf@kernel.org> wrote:
> >
> > The following changes since commit bb6d3fb354c5ee8d6bde2d576eb7220ea09862b9:
> >
> >   Linux 5.6-rc1 (2020-02-09 16:08:48 -0800)
> >
> > are available in the Git repository at:
> >
> >   git://git.kernel.org/pub/scm/linux/kernel/git/mdf/linux-fpga.git/ fpga-fixes-for-5.7
> >
> > for you to fetch changes up to 3c2760b78f90db874401d97e3c17829e2e36f400:
> >
> >   fpga: dfl: pci: fix return value of cci_pci_sriov_configure (2020-03-30 20:45:30 -0700)
> >
> > ----------------------------------------------------------------
> > FPGA Manager fixes for 5.7-rc1
> >
> > Here are two (late) fixes for 5.7-rc1 merge window.
> >
> > Xu's change addresses an issue with a wrong return value.
> >
> > Shubhrajyoti's change makes the Zynq FPGA driver return -EPROBE_DEFER on
> >
> > All patches have been reviewed on the mailing list, and have been in the
> > last few linux-next releases (as part of my for-next branch) without issues.
> >
> > Signed-off-by: Moritz Fischer <mdf@kernel.org>
> >
> > ----------------------------------------------------------------
> > Shubhrajyoti Datta (1):
> >       fpga: zynq: Remove clk_get error message for probe defer
> >
> > Xu Yilun (1):
> >       fpga: dfl: pci: fix return value of cci_pci_sriov_configure
> >
> >  drivers/fpga/dfl-pci.c   | 6 ++++--
> >  drivers/fpga/zynq-fpga.c | 3 ++-
> >  2 files changed, 6 insertions(+), 3 deletions(-)
> 
> Ping

I couldn't do anything until after -rc1 came out, and now I'm working on
catching up.  Don't worry, it's not lost...

greg k-h
