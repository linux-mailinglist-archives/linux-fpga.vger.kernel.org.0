Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CBF940FE00
	for <lists+linux-fpga@lfdr.de>; Fri, 17 Sep 2021 18:38:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231830AbhIQQjl (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 17 Sep 2021 12:39:41 -0400
Received: from mail-pj1-f46.google.com ([209.85.216.46]:38425 "EHLO
        mail-pj1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbhIQQjl (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 17 Sep 2021 12:39:41 -0400
Received: by mail-pj1-f46.google.com with SMTP id g13-20020a17090a3c8d00b00196286963b9so10411511pjc.3;
        Fri, 17 Sep 2021 09:38:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SrqrNpWzeD/aTYmHufxXWMgS8DaaH14qLiFnZTS/9Sc=;
        b=PJGmCvHV9svmH2swHnB3yo4AU+d75N3C28zalAflCTyyFUnkKUQAppO+CeAEyVHTT8
         58IfmJXwcLY22IEts/e0dyBk7U0phqf0waREJDWQd1O1U6KThD9SnRTigulkxeU+rJt4
         RAqtDaP9rTVPO2NEVz+rEiNsdTOZzape3s4y/3zjhqrtEYPzdfJyufFp6k9fZDzTxMJA
         +DBorfrRUIrfUGxoY2w6TT8NnqGlcVnl3ky8CjcqUXvIplC0TAWukOqBIPCIxAPb0Fbb
         jDF0oQh4o8ordxGcL2WzIbfbnS1MrhExqfenYPc8aLf3kWeO5v0tYbOJoxcmJcf1oJzi
         2nqg==
X-Gm-Message-State: AOAM530vmNrloge9UYohqYcWSVdE3vHitRQgk//bdoxPMLf3tbCxt6gU
        wX6R2pCTjlwYAM8PfWfTi5E=
X-Google-Smtp-Source: ABdhPJxvD7IjhTwrOLfwTM6GvRP8r4vHp3UhAxUaZUXdqsq53TID8n+JhVJsrJshf2gZ07js83SHdg==
X-Received: by 2002:a17:90a:af8f:: with SMTP id w15mr21867581pjq.93.1631896698369;
        Fri, 17 Sep 2021 09:38:18 -0700 (PDT)
Received: from localhost ([2601:647:5b00:6f70:be34:681b:b1e9:776f])
        by smtp.gmail.com with ESMTPSA id n205sm6336557pfd.38.2021.09.17.09.38.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Sep 2021 09:38:17 -0700 (PDT)
Date:   Fri, 17 Sep 2021 09:38:16 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     Dave Airlie <airlied@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, Tom Rix <trix@redhat.com>,
        Moritz Fischer <mdf@kernel.org>, hao.wu@intel.com,
        LKML <linux-kernel@vger.kernel.org>, linux-fpga@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Add Tom Rix as fpga maintainer
Message-ID: <YUTEeCcCholiPLRO@epycbox.lan>
References: <20210914182333.3903389-1-trix@redhat.com>
 <YUDw0gvgdijpytfU@kroah.com>
 <25d1dac2-4f9f-b5f0-8ce8-b88442deac9d@redhat.com>
 <YUH9dg01Mtk+kO+C@kroah.com>
 <c0630361-69cf-992a-78bf-a1c8335acd28@redhat.com>
 <YUJdts/9kowAen+K@epycbox.lan>
 <ad209636-a819-5bd5-b643-1cda12201a73@redhat.com>
 <YUM9RMDb/uYESLaX@kroah.com>
 <CAPM=9twrdRfRSsDaaGb7s-D4TZeLaScTkkpFN+1qfbvGwkgyeQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPM=9twrdRfRSsDaaGb7s-D4TZeLaScTkkpFN+1qfbvGwkgyeQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Dave,

On Fri, Sep 17, 2021 at 10:21:27AM +1000, Dave Airlie wrote:
> On Thu, 16 Sept 2021 at 22:50, Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Thu, Sep 16, 2021 at 05:41:35AM -0700, Tom Rix wrote:
> > >
> > > On 9/15/21 1:55 PM, Moritz Fischer wrote:
> > > > On Wed, Sep 15, 2021 at 09:12:51AM -0700, Tom Rix wrote:
> > > > > On 9/15/21 7:04 AM, Greg KH wrote:
> > > > > > On Wed, Sep 15, 2021 at 06:23:16AM -0700, Tom Rix wrote:
> > > > > > > On 9/14/21 11:58 AM, Greg KH wrote:
> > > > > > > > [note, you got the maintainer's email address wrong on your cc: line
> > > > > > > >     I fixed it up...]
> > > > > > > >
> > > > > > > > On Tue, Sep 14, 2021 at 11:23:33AM -0700, trix@redhat.com wrote:
> > > > > > > > > From: Tom Rix <trix@redhat.com>
> > > > > > > > >
> > > > > > > > > I am the maintainer of the fpga/ subsystem for both the kernel and
> > > > > > > > > userspace for Red Hat.  I have been an active reviewer and contributor
> > > > > > > > > on for public fpga/ subsystem for the last year.  I would like to
> > > > > > > > > help out more.
> > > > > > > > >
> > > > > > > > > Since I am paid to do this work, change the status to Supported.
> > > > > > > > >
> > > > > > > > > Signed-off-by: Tom Rix <trix@redhat.com>
> > > > > > > > > ---
> > > > > > > > >     MAINTAINERS | 4 ++--
> > > > > > > > >     1 file changed, 2 insertions(+), 2 deletions(-)
> > > > > > > > >
> > > > > > > > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > > > > > > > index 04fa4edf100b83..0443d7ab826659 100644
> > > > > > > > > --- a/MAINTAINERS
> > > > > > > > > +++ b/MAINTAINERS
> > > > > > > > > @@ -7353,9 +7353,9 @@ F:  include/uapi/linux/fpga-dfl.h
> > > > > > > > >     FPGA MANAGER FRAMEWORK
> > > > > > > > >     M:    Moritz Fischer <mdf@kernel.org>
> > > > > > > > > -R:       Tom Rix <trix@redhat.com>
> > > > > > > > > +M:       Tom Rix <trix@redhat.com>
> > > > > > > > >     L:    linux-fpga@vger.kernel.org
> > > > > > > > > -S:       Maintained
> > > > > > > > > +S:       Supported
> > > > > > > > >     W:    http://www.rocketboards.org
> > > > > > > > >     Q:    http://patchwork.kernel.org/project/linux-fpga/list/
> > > > > > > > >     T:    git git://git.kernel.org/pub/scm/linux/kernel/git/mdf/linux-fpga.git
> > > > > > > > > --
> > > > > > > > > 2.26.3
> > > > > > > > >
> > > > > > > > Traditionally existing maintainers are the ones that add new
> > > > > > > > maintainers, it's not something that you just submit a patch for hoping
> > > > > > > > it will be accepted.
> > > > > > > >
> > > > > > > > What has changed since the last time you asked to do this?
> > > > > > > Because public and private requests have gone unanswered for so long, it is
> > > > > > > unclear if Moritz is still maintaining the subsystem.
> > > > > > He is, as is evident by the patches I accept from him each merge.
> > > > > >
> > > > > > > The nearly year old xrt patchset has been pending for 6 weeks with minor
> > > > > > > changes to one patch out of 14 needing reviews.
> > > > > > Code quality is not the maintainer's job, it's the developer's, so the
> > > > > > age and number of reviews is not any indication.
> > > > > https://lore.kernel.org/linux-fpga/20210802160521.331031-1-lizhi.hou@xilinx.com/
> > > > >
> > > > > The review is needed because Moritz asked for the changes v8 here
> > > > >
> > > > > https://lore.kernel.org/linux-fpga/YP42zE2ljx4hHj40@epycbox.lan/
> > > > >
> > > > > When the maintainer asks for the changes, they are responsible for the
> > > > > followup.
> > > > >
> > > > > > > The standard release patchset, which needs an opinion has on an api change,
> > > > > > > has been outstanding for 8 weeks.
> > > > > > Have a pointer to it?
> > > > > This was a change you requested. the recent patchset is
> > > > >
> > > > > https://lore.kernel.org/linux-fpga/20210914214327.94048-4-russell.h.weight@intel.com/
> > > > >
> > > > > The discussion around the api change is
> > > > >
> > > > > https://lore.kernel.org/linux-fpga/661d53d0-0ba4-d344-8da0-995a9b612905@redhat.com/
> > > > >
> > > > > In these toss up's if the maintainer does not weigh in as the tie breaker,
> > > > > the patch stalls.
> > > > >
> > > > > > > If maintainership depends on an approving maintainter, what happens when the
> > > > > > > approving maintainer has left ?
> > > > > > Vacations happen in the summer.  I've talked to Moritz many times, and
> > > > > > all is well here.
> > > > > Yes. in the xrt v9 patch Moritz announced late of a vacation with a return
> > > > > of 9/4.
> > > > >
> > > > > It has been 11 days.
> > > > I had a family issue that was unforseen combined with an unusual high
> > > > post-vacation workload at $dayjob when I got back.
> > > >
> > > > I'm still catching up, and will get to it when I can.
> > >
> > > I almost never take vacation because of the post vacation workload.
> >
> > That is not sustainable, nor a requirement of a kernel maintainer.
> >
> > > You not having backup is a problem.
> > >
> > > Please consider taking the help I am offering.
> >
> > You can not force yourself on others.  Moritz is doing a fine job,
> > please do not make it difficult.
> 
> I think it's probably up to Moritz to discuss this possibility with
> Tom, but we should not be dismissing potential comaintainer roles
> either, the bus factor is real, and being able to take time off
> without things grinding to a halt is a welcome feature for everyone.

I'm not generally opposed to having another maintainer to take patches
for the times I'm out or get hit by a bus. However, I don't feel like
being bullied into this.

Between off-list emails, attempts to go behind my back emailing people
complaining about me, declaring himself maintainer and pro-claiming
there's a new repo for linux-fpga over the last year and some, I've just
about had enough of this sh*t. This is not how this works.

There are plenty of folks around that also help out and that I'd much
rather work with at this point -- if just to skip the drama.

So for now NAK on this patch from my end.

Cheers,
Moritz
