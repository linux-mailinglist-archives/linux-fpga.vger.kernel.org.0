Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8FCE40C6FA
	for <lists+linux-fpga@lfdr.de>; Wed, 15 Sep 2021 16:04:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237774AbhIOOGD (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 15 Sep 2021 10:06:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:55588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237735AbhIOOGA (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 15 Sep 2021 10:06:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8F1A161263;
        Wed, 15 Sep 2021 14:04:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1631714681;
        bh=sxwyQHm8J7Frh3PMOdFYOpyVkPKUyLtc+ZF4sh99oyc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ahm5bAq5spknX6iyVjCaRUrlFeHMLd1qhZ9J/2Pmp1m4DccDqaf3PTOYOLCwC1kPs
         mpnBRXya0qk1Jy+MtbBPaKW/3SmF6ns8ivqiVirgRFhePoNn2L7K46Q21ZRIIteWah
         fNOok2T/SB1SkoBjRvk+3NW+H9f69wU8rZ5+NY9U=
Date:   Wed, 15 Sep 2021 16:04:38 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Tom Rix <trix@redhat.com>
Cc:     mdf@kernel.org, hao.wu@intel.com, linux-kernel@vger.kernel.org,
        linux-fpga@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Add Tom Rix as fpga maintainer
Message-ID: <YUH9dg01Mtk+kO+C@kroah.com>
References: <20210914182333.3903389-1-trix@redhat.com>
 <YUDw0gvgdijpytfU@kroah.com>
 <25d1dac2-4f9f-b5f0-8ce8-b88442deac9d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <25d1dac2-4f9f-b5f0-8ce8-b88442deac9d@redhat.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Wed, Sep 15, 2021 at 06:23:16AM -0700, Tom Rix wrote:
> 
> On 9/14/21 11:58 AM, Greg KH wrote:
> > [note, you got the maintainer's email address wrong on your cc: line
> >   I fixed it up...]
> > 
> > On Tue, Sep 14, 2021 at 11:23:33AM -0700, trix@redhat.com wrote:
> > > From: Tom Rix <trix@redhat.com>
> > > 
> > > I am the maintainer of the fpga/ subsystem for both the kernel and
> > > userspace for Red Hat.  I have been an active reviewer and contributor
> > > on for public fpga/ subsystem for the last year.  I would like to
> > > help out more.
> > > 
> > > Since I am paid to do this work, change the status to Supported.
> > > 
> > > Signed-off-by: Tom Rix <trix@redhat.com>
> > > ---
> > >   MAINTAINERS | 4 ++--
> > >   1 file changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index 04fa4edf100b83..0443d7ab826659 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -7353,9 +7353,9 @@ F:	include/uapi/linux/fpga-dfl.h
> > >   FPGA MANAGER FRAMEWORK
> > >   M:	Moritz Fischer <mdf@kernel.org>
> > > -R:	Tom Rix <trix@redhat.com>
> > > +M:	Tom Rix <trix@redhat.com>
> > >   L:	linux-fpga@vger.kernel.org
> > > -S:	Maintained
> > > +S:	Supported
> > >   W:	http://www.rocketboards.org
> > >   Q:	http://patchwork.kernel.org/project/linux-fpga/list/
> > >   T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mdf/linux-fpga.git
> > > -- 
> > > 2.26.3
> > > 
> > Traditionally existing maintainers are the ones that add new
> > maintainers, it's not something that you just submit a patch for hoping
> > it will be accepted.
> > 
> > What has changed since the last time you asked to do this?
> 
> Because public and private requests have gone unanswered for so long, it is
> unclear if Moritz is still maintaining the subsystem.

He is, as is evident by the patches I accept from him each merge.

> The nearly year old xrt patchset has been pending for 6 weeks with minor
> changes to one patch out of 14 needing reviews.

Code quality is not the maintainer's job, it's the developer's, so the
age and number of reviews is not any indication.

> The standard release patchset, which needs an opinion has on an api change,
> has been outstanding for 8 weeks.

Have a pointer to it?

> If maintainership depends on an approving maintainter, what happens when the
> approving maintainer has left ?

Vacations happen in the summer.  I've talked to Moritz many times, and
all is well here.

greg k-h
