Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F24D140DA4C
	for <lists+linux-fpga@lfdr.de>; Thu, 16 Sep 2021 14:49:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239723AbhIPMue (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 16 Sep 2021 08:50:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:49954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239777AbhIPMub (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 16 Sep 2021 08:50:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 655036113E;
        Thu, 16 Sep 2021 12:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1631796551;
        bh=Mk5da+lUykvl7N4jH/HQw6t2J5LD4E7HxNChEW5xYv8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EUTKjb9k9W0vdjbmnYNhQYEwUC2tHVWnWRBIPWb5iqyUe59kw+wI5ZiMrQqZI0DYe
         gtQCIdj3oa+wsKKsDYnyknffE8lqy25dYOMyI7Ui57aZ1ZFmj8PC0GzmdwAr7dSHmk
         1qQncVOhMU+K2IUdFSilY9kXFCMW3eqOS4/2TnsI=
Date:   Thu, 16 Sep 2021 14:49:08 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Tom Rix <trix@redhat.com>
Cc:     Moritz Fischer <mdf@kernel.org>, hao.wu@intel.com,
        linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Add Tom Rix as fpga maintainer
Message-ID: <YUM9RMDb/uYESLaX@kroah.com>
References: <20210914182333.3903389-1-trix@redhat.com>
 <YUDw0gvgdijpytfU@kroah.com>
 <25d1dac2-4f9f-b5f0-8ce8-b88442deac9d@redhat.com>
 <YUH9dg01Mtk+kO+C@kroah.com>
 <c0630361-69cf-992a-78bf-a1c8335acd28@redhat.com>
 <YUJdts/9kowAen+K@epycbox.lan>
 <ad209636-a819-5bd5-b643-1cda12201a73@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad209636-a819-5bd5-b643-1cda12201a73@redhat.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Thu, Sep 16, 2021 at 05:41:35AM -0700, Tom Rix wrote:
> 
> On 9/15/21 1:55 PM, Moritz Fischer wrote:
> > On Wed, Sep 15, 2021 at 09:12:51AM -0700, Tom Rix wrote:
> > > On 9/15/21 7:04 AM, Greg KH wrote:
> > > > On Wed, Sep 15, 2021 at 06:23:16AM -0700, Tom Rix wrote:
> > > > > On 9/14/21 11:58 AM, Greg KH wrote:
> > > > > > [note, you got the maintainer's email address wrong on your cc: line
> > > > > >     I fixed it up...]
> > > > > > 
> > > > > > On Tue, Sep 14, 2021 at 11:23:33AM -0700, trix@redhat.com wrote:
> > > > > > > From: Tom Rix <trix@redhat.com>
> > > > > > > 
> > > > > > > I am the maintainer of the fpga/ subsystem for both the kernel and
> > > > > > > userspace for Red Hat.  I have been an active reviewer and contributor
> > > > > > > on for public fpga/ subsystem for the last year.  I would like to
> > > > > > > help out more.
> > > > > > > 
> > > > > > > Since I am paid to do this work, change the status to Supported.
> > > > > > > 
> > > > > > > Signed-off-by: Tom Rix <trix@redhat.com>
> > > > > > > ---
> > > > > > >     MAINTAINERS | 4 ++--
> > > > > > >     1 file changed, 2 insertions(+), 2 deletions(-)
> > > > > > > 
> > > > > > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > > > > > index 04fa4edf100b83..0443d7ab826659 100644
> > > > > > > --- a/MAINTAINERS
> > > > > > > +++ b/MAINTAINERS
> > > > > > > @@ -7353,9 +7353,9 @@ F:	include/uapi/linux/fpga-dfl.h
> > > > > > >     FPGA MANAGER FRAMEWORK
> > > > > > >     M:	Moritz Fischer <mdf@kernel.org>
> > > > > > > -R:	Tom Rix <trix@redhat.com>
> > > > > > > +M:	Tom Rix <trix@redhat.com>
> > > > > > >     L:	linux-fpga@vger.kernel.org
> > > > > > > -S:	Maintained
> > > > > > > +S:	Supported
> > > > > > >     W:	http://www.rocketboards.org
> > > > > > >     Q:	http://patchwork.kernel.org/project/linux-fpga/list/
> > > > > > >     T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mdf/linux-fpga.git
> > > > > > > -- 
> > > > > > > 2.26.3
> > > > > > > 
> > > > > > Traditionally existing maintainers are the ones that add new
> > > > > > maintainers, it's not something that you just submit a patch for hoping
> > > > > > it will be accepted.
> > > > > > 
> > > > > > What has changed since the last time you asked to do this?
> > > > > Because public and private requests have gone unanswered for so long, it is
> > > > > unclear if Moritz is still maintaining the subsystem.
> > > > He is, as is evident by the patches I accept from him each merge.
> > > > 
> > > > > The nearly year old xrt patchset has been pending for 6 weeks with minor
> > > > > changes to one patch out of 14 needing reviews.
> > > > Code quality is not the maintainer's job, it's the developer's, so the
> > > > age and number of reviews is not any indication.
> > > https://lore.kernel.org/linux-fpga/20210802160521.331031-1-lizhi.hou@xilinx.com/
> > > 
> > > The review is needed because Moritz asked for the changes v8 here
> > > 
> > > https://lore.kernel.org/linux-fpga/YP42zE2ljx4hHj40@epycbox.lan/
> > > 
> > > When the maintainer asks for the changes, they are responsible for the
> > > followup.
> > > 
> > > > > The standard release patchset, which needs an opinion has on an api change,
> > > > > has been outstanding for 8 weeks.
> > > > Have a pointer to it?
> > > This was a change you requested. the recent patchset is
> > > 
> > > https://lore.kernel.org/linux-fpga/20210914214327.94048-4-russell.h.weight@intel.com/
> > > 
> > > The discussion around the api change is
> > > 
> > > https://lore.kernel.org/linux-fpga/661d53d0-0ba4-d344-8da0-995a9b612905@redhat.com/
> > > 
> > > In these toss up's if the maintainer does not weigh in as the tie breaker,
> > > the patch stalls.
> > > 
> > > > > If maintainership depends on an approving maintainter, what happens when the
> > > > > approving maintainer has left ?
> > > > Vacations happen in the summer.  I've talked to Moritz many times, and
> > > > all is well here.
> > > Yes. in the xrt v9 patch Moritz announced late of a vacation with a return
> > > of 9/4.
> > > 
> > > It has been 11 days.
> > I had a family issue that was unforseen combined with an unusual high
> > post-vacation workload at $dayjob when I got back.
> > 
> > I'm still catching up, and will get to it when I can.
> 
> I almost never take vacation because of the post vacation workload.

That is not sustainable, nor a requirement of a kernel maintainer.

> You not having backup is a problem.
> 
> Please consider taking the help I am offering.

You can not force yourself on others.  Moritz is doing a fine job,
please do not make it difficult.

thanks,

greg k-h
