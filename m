Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D93326D35C
	for <lists+linux-fpga@lfdr.de>; Thu, 17 Sep 2020 08:01:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726106AbgIQGBx (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 17 Sep 2020 02:01:53 -0400
Received: from mail-pl1-f176.google.com ([209.85.214.176]:41384 "EHLO
        mail-pl1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725267AbgIQGBx (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 17 Sep 2020 02:01:53 -0400
Received: by mail-pl1-f176.google.com with SMTP id m15so543564pls.8
        for <linux-fpga@vger.kernel.org>; Wed, 16 Sep 2020 23:01:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=htPWFzXEtPCljZej7MGAWJgRVEBkVUflkKPt890o6yQ=;
        b=kQOVaVnFLcKFRS9dzZwggZkRELHyFw3P1RueyYdYMYAGu5LMEgiCltW/2dJPKS437A
         EerJbA3R8f4maHwQ+dud74WOR5k/Dv1xGwF7JjBVStx+Y9jQAz+XFZJ9sYunS7cnwGl9
         QRipL3n6qj9ZgiKJmJIkXGaLHvuHNOQaJ5lBMnkkQMUKOSfC/3Z89XSmV2CZP0xJhPw8
         9C8fk3qpo1Q9Aw9TDP4nGSemKFB/mjOebEH8rL/qpovDJ4dR/DWsmaWhLMP3kfyx1kPr
         n44p0uUXfeLm0/pgLS3TlD6MepCBAUIjnQWufDlQNVnxiePEU9gTqFZCzq1RVyEsjyGP
         SnoQ==
X-Gm-Message-State: AOAM530GV/VzS/kaELm4wMJnLWOnY9Sff1noYN8Rm9AegMxZ79YZiEKD
        egLKbLtqK1SCyq+72JgMj4U=
X-Google-Smtp-Source: ABdhPJw0XD0A0vuqJ1O7zA+DgUlEJpjehBvem0ypT6qt6T/tyCpuY/MuEhpcbuQH4dGSL6rHVjWHaw==
X-Received: by 2002:a17:90a:f30c:: with SMTP id ca12mr6926217pjb.102.1600322512377;
        Wed, 16 Sep 2020 23:01:52 -0700 (PDT)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id co3sm4534630pjb.31.2020.09.16.23.01.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2020 23:01:51 -0700 (PDT)
Date:   Wed, 16 Sep 2020 23:01:50 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     Tom Rix <trix@redhat.com>
Cc:     Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>
Subject: Re: RFC improving amount of content in 5.11
Message-ID: <20200917060150.GA1084338@epycbox.lan>
References: <3295710c-5e82-7b97-43de-99b9870a8c8c@redhat.com>
 <20200914211012.GA22855@archbook>
 <0e51e17e-691f-04ef-699a-e0816c216375@redhat.com>
 <20200915213324.GA29697@epycbox.lan>
 <be3844bc-8f5a-6e29-1ecb-debe51739eb0@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <be3844bc-8f5a-6e29-1ecb-debe51739eb0@redhat.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Tom,

On Wed, Sep 16, 2020 at 08:07:42AM -0700, Tom Rix wrote:
> 
> On 9/15/20 2:33 PM, Moritz Fischer wrote:
> > Tom,
> >
> > On Tue, Sep 15, 2020 at 01:58:52PM -0700, Tom Rix wrote:
> >
> >> A non trival change takes 8 revisions, with about 1 week per revision.
> > I don't consider that to be out of the norm, especially if you want
> > multiple people to give feedback on a changeset. This is a result of the
> > distributed nature of people working across several timezones.
> >
> > I generally prefer to go a bit slower and get it right rather than
> > having to redo or realize we got the interfaces wrong -- some of which
> > have to stay stable.
> >
> >> Gives us 1 or 2 changes per release.
> >>
> >> In the easy case, a new card is in the same family, will have 4 new ip blocks
> >>
> >> and a change to glue it all together change, 5 patch sets.
> > So far I haven't seen that happen that many times.
> >
> >> So we can handle 1 or 2 cards year.
> > Again I haven't seen more than that in the past.
> >> But if we can cut the review down to 2 weeks, we could do maybe 5-10 cards per year.
> >>
> >>
> >> Then the downside if we do not keep up.
> >>
> >> every card has a custom out of tree driver available on a limited set of distros.
> >>
> >> which i believe is the current state of things.
> > Tbh, this is easy to fix as vendor by just submitting the code earlier
> > and in smaller chunks. People can send out RFCs early and then we can
> > discuss designs and not just show up with 20+ patch series and expect them
> > to be merged as is (ideally within 2-3 revisions) even more so if they
> > span several subsystems.
> >
> > The kernel never has cared about corporate timelines, and as vendor if
> > you care about timely hardware support (and want to avoid out-of-tree
> > nightmares) start early with your upstreaming efforts. That has always
> > been the case.
> >
> >>>> So I was wondering what we can do generally and i can do specifically
> >>>> to improve this.
> >>>>
> >>>> My comment
> >>>> Though we are a low volume list, anything non trivial takes about 8 revisions.
> >>>> My suggestion is that we all try to give the developer our big first
> >>>> pass review within a week of the patch landing and try to cut the
> >>>> revisions down to 3.
> >>> It's unfortunate that it takes so long to get things moving, I agree,
> >>> but with everything that's going on - bear in mind people deal different
> >>> with situations like the present - it is what it is.
> >>>
> >>> My current dayjob doesn't pay me for working on this so the time I dedicate
> >>> to this comes out of my spare time and weekends - Personally I'd rather
> >>> not burn out and keep functioning in the long run.
> >> I understand, in the past i have worked as a maintainer when it was not my day job, it's hard.
> >>
> >> I am fortunate, fpga kernel and userspace is my day job.Ã‚Â  Over the last couple of months, i have been
> >>
> >> consistently spending a couple hours a day fixing random kernel problems as well as getting linux-fpga
> >>
> >> reviews out within a day or two so i know i have the bandwidth to devote.
> >>
> >>
> >> So I am asking what else can I do ?
> >>
> >> Would helping out with staging the PR's be help ?
> > As you pointed out above, the bottleneck is review velocity, I don't
> > know what staging PRs helps with that.
> >
> >> Could i move up to a maintainer ?
> > The problem is I'd still like to review the patches that go into my
> > subsystem. I appreciate your help with the reviews, and it's been
> > helpful so far. I don't think having an addtional maintainer will help
> > with that at this point.
> 
> We agree slow reviews are throttling the content in the releases.
> 
> Is this a temporary situation with your work or is it steady state?

Tbh, I don't appreciate the tone you're taking with your emails:

Starting a conversation with how disappointed you are is generally not a
great way to get people on board with anything.

I'll let you know when I need help beyond the reviews, as I already told
you earlier in the replies to your off-list emails.

I am not generally opposed to the idea of bringing on new maintainers --
Hao has done a great job for the DFL code so far -- but as of now I do
not see an immediate benefit (or need) in terms of process to adding more
FPGA maintainers.

> Are slow reviews the only problem ?

Since the FPGA pull requests go through Greg's tree they need to be sent
out earlier than a pull request to Linus, if you send out a patchset
around rc4 don't expect it to go in in that release if it requires a
non-trivial amount of review -- if you have patches just send them.

> Which is getting back to my original RFC on how can we improve the amount of content in the releases ?

Send patches earlier (ideally start with an RFC if you intend larger
changes) and in smaller batches, which will save you time later in the
process.

- Moritz
