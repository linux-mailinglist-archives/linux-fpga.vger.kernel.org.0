Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10CF326AFA1
	for <lists+linux-fpga@lfdr.de>; Tue, 15 Sep 2020 23:34:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727785AbgIOVek (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 15 Sep 2020 17:34:40 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:33671 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728055AbgIOVd0 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 15 Sep 2020 17:33:26 -0400
Received: by mail-pj1-f66.google.com with SMTP id md22so511793pjb.0
        for <linux-fpga@vger.kernel.org>; Tue, 15 Sep 2020 14:33:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=GFh7ajfbWSuS+rfbWz8fNYVYIhfjalw39XaWjJq7j3c=;
        b=lD3AYyu/Am1KPvdmiSVUttPSoA0iI/UKxxE/vDqTs/IhXgMWTAxkciuVSjwXYgrp1s
         ESm4/2tMgIUi6Cwu8t/xuDwjr0qSZAWAAx8RiLt/UNb/4l4iZsXKNowBH8SVMarc8s1p
         h+HKRkbAiwDGaO4XY65tfqWK2WBJl9d/ohz02exvp53tLN97ITe0o9o01Ig+GKwzKAQc
         22guXRtiCl4aBtmk85qKkxcacAol910B9Qf8dj0ZoOqKrbjbodAvcHmucjN4llyzm5xf
         d/Lwr9wAtha7mrSdcElQSkTESHyJQMHiIwqsq6mqrXPM2FktnJ7WoOWLOP7Y/Nt1jmIU
         W49Q==
X-Gm-Message-State: AOAM533lnJHU/7eKK7zrmdVfEmG6kbWGYHYFjwX1r78IwXWJ8jQjyWH8
        gWYWbPBX9JesRxFi3XTW9qg=
X-Google-Smtp-Source: ABdhPJzTaYcuAh3DR2nfkt5FzJ+d5XAqVKWpj6Pa2O2iafX5Gb7/tQC97u1veXUJHCRjDpEs3h7DsA==
X-Received: by 2002:a17:90a:a78d:: with SMTP id f13mr1191936pjq.69.1600205605959;
        Tue, 15 Sep 2020 14:33:25 -0700 (PDT)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id g26sm881610pfr.105.2020.09.15.14.33.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 14:33:25 -0700 (PDT)
Date:   Tue, 15 Sep 2020 14:33:24 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     Tom Rix <trix@redhat.com>
Cc:     Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>
Subject: Re: RFC improving amount of content in 5.11
Message-ID: <20200915213324.GA29697@epycbox.lan>
References: <3295710c-5e82-7b97-43de-99b9870a8c8c@redhat.com>
 <20200914211012.GA22855@archbook>
 <0e51e17e-691f-04ef-699a-e0816c216375@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0e51e17e-691f-04ef-699a-e0816c216375@redhat.com>
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Tom,

On Tue, Sep 15, 2020 at 01:58:52PM -0700, Tom Rix wrote:

> A non trival change takes 8 revisions, with about 1 week per revision.

I don't consider that to be out of the norm, especially if you want
multiple people to give feedback on a changeset. This is a result of the
distributed nature of people working across several timezones.

I generally prefer to go a bit slower and get it right rather than
having to redo or realize we got the interfaces wrong -- some of which
have to stay stable.

> Gives us 1 or 2 changes per release.
> 
> In the easy case, a new card is in the same family, will have 4 new ip blocks
> 
> and a change to glue it all together change, 5 patch sets.

So far I haven't seen that happen that many times.

> So we can handle 1 or 2 cards year.

Again I haven't seen more than that in the past.
> 
> But if we can cut the review down to 2 weeks, we could do maybe 5-10 cards per year.
> 
> 
> Then the downside if we do not keep up.
> 
> every card has a custom out of tree driver available on a limited set of distros.
> 
> which i believe is the current state of things.

Tbh, this is easy to fix as vendor by just submitting the code earlier
and in smaller chunks. People can send out RFCs early and then we can
discuss designs and not just show up with 20+ patch series and expect them
to be merged as is (ideally within 2-3 revisions) even more so if they
span several subsystems.

The kernel never has cared about corporate timelines, and as vendor if
you care about timely hardware support (and want to avoid out-of-tree
nightmares) start early with your upstreaming efforts. That has always
been the case.

> >> So I was wondering what we can do generally and i can do specifically
> >> to improve this.
> >>
> >> My comment
> >> Though we are a low volume list, anything non trivial takes about 8 revisions.
> >> My suggestion is that we all try to give the developer our big first
> >> pass review within a week of the patch landing and try to cut the
> >> revisions down to 3.
> > It's unfortunate that it takes so long to get things moving, I agree,
> > but with everything that's going on - bear in mind people deal different
> > with situations like the present - it is what it is.
> >
> > My current dayjob doesn't pay me for working on this so the time I dedicate
> > to this comes out of my spare time and weekends - Personally I'd rather
> > not burn out and keep functioning in the long run.
> 
> I understand, in the past i have worked as a maintainer when it was not my day job, it's hard.
> 
> I am fortunate, fpga kernel and userspace is my day job.  Over the last couple of months, i have been
> 
> consistently spending a couple hours a day fixing random kernel problems as well as getting linux-fpga
> 
> reviews out within a day or two so i know i have the bandwidth to devote.
> 
> 
> So I am asking what else can I do ?
> 
> Would helping out with staging the PR's be help ?

As you pointed out above, the bottleneck is review velocity, I don't
know what staging PRs helps with that.

> 
> Could i move up to a maintainer ?

The problem is I'd still like to review the patches that go into my
subsystem. I appreciate your help with the reviews, and it's been
helpful so far. I don't think having an addtional maintainer will help
with that at this point.

- Moritz
