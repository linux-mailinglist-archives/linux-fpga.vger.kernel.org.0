Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3932B423904
	for <lists+linux-fpga@lfdr.de>; Wed,  6 Oct 2021 09:35:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237384AbhJFHhF (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 6 Oct 2021 03:37:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:45698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231221AbhJFHhE (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 6 Oct 2021 03:37:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C23BD6115A;
        Wed,  6 Oct 2021 07:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1633505713;
        bh=bJAjzvK0+Pb2TRwikorQUUcJhaPoD2wk3TULWpYDQtE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SS8dqC9dB1A4V5ZJPgqf1Fdsfz5TsV7RjNtKabGuJlur4ml/dbop5n3pXUnEA26kl
         d1vzQbCspUubCHjZx9JdOCKEkaLA/fAdKUflMXNj621z9g3xNmLd21uB6zAKp6NsHd
         34yq42HLCQ/bUCaSAfccog4hTyJ8fAGblBubjy7U=
Date:   Wed, 6 Oct 2021 09:35:03 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Moritz Fischer <mdf@kernel.org>
Cc:     yilun.xu@intel.com, hao.wu@intel.com, linux-fpga@vger.kernel.org,
        moritzf@google.com
Subject: Re: [GIT PULL] FPGA Manager changes for 5.16-rc1
Message-ID: <YV1Rp6eQCEdvGnTZ@kroah.com>
References: <YVyZJAOnAphoe/Vh@epycbox.lan>
 <YVygXlJxzJaXUANu@kroah.com>
 <YVyhWw9et/5NEggO@epycbox.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YVyhWw9et/5NEggO@epycbox.lan>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Tue, Oct 05, 2021 at 12:02:51PM -0700, Moritz Fischer wrote:
> On Tue, Oct 05, 2021 at 08:58:38PM +0200, Greg KH wrote:
> > On Tue, Oct 05, 2021 at 11:27:48AM -0700, Moritz Fischer wrote:
> > > The following changes since commit 6880fa6c56601bb8ed59df6c30fd390cc5f6dd8f:
> > > 
> > >   Linux 5.15-rc1 (2021-09-12 16:28:37 -0700)
> > > 
> > > are available in the Git repository at:
> > > 
> > >   git://git.kernel.org/pub/scm/linux/kernel/git/mdf/linux-fpga tags/fpga-maintainer-update
> > > 
> > > for you to fetch changes up to 57b44817a8d63e75394bc21849f585ded53de8bb:
> > > 
> > >   MAINTAINERS: Drop outdated FPGA Manager website (2021-10-02 09:07:09 -0700)
> > > 
> > > ----------------------------------------------------------------
> > > FPGA Manager changes for 5.16
> > > 
> > > The first patch adds Hao and Yilun as additional maintainers
> > > for the FPGA Manager subsystem.
> > > 
> > > The second patch removes a now stale reference to a product specific
> > > website that no longer reflects the FPGA Manager subsystem.
> > > 
> > > All patches have been reviewed on the mailing list, and have been in the
> > > last few linux-next releases (as part of my for-next branch) without issues.
> > > 
> > > Signed-off-by: Moritz Fischer <mdf@kernel.org>
> > > 
> > > ----------------------------------------------------------------
> > > Moritz Fischer (2):
> > >       MAINTAINERS: Add Hao and Yilun as maintainers
> > >       MAINTAINERS: Drop outdated FPGA Manager website
> > 
> > These are trivial, shouldn't we work to get these into 5.15-final?  I
> > can gladly take them into my branch for that if you don't mind.
> 
> All the same to me :) I figured they're not fixes, so that's why for
> next release.

Now merged for this release.

thanks,

greg k-h
