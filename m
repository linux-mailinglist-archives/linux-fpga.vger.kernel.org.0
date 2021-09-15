Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80D2740CE6C
	for <lists+linux-fpga@lfdr.de>; Wed, 15 Sep 2021 22:55:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231689AbhIOU4k (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 15 Sep 2021 16:56:40 -0400
Received: from mail-pj1-f54.google.com ([209.85.216.54]:39608 "EHLO
        mail-pj1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231490AbhIOU4k (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 15 Sep 2021 16:56:40 -0400
Received: by mail-pj1-f54.google.com with SMTP id c13-20020a17090a558d00b00198e6497a4fso5881234pji.4;
        Wed, 15 Sep 2021 13:55:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kyKayYUu/Gs1O2PFgnxcnIjOBY4qEl7gAKwPm2fa9Qs=;
        b=50QRZJY+QJ3OnQYh9sh+h6e5n604wAxz3PFKMt0Rh9SSiE5g/zaqRUdmJ5HaRG4wFQ
         zzranX/up8GSkyG1paG8BNX0QATIem+/SqeJKShxl7EAq35e1ccdzQE8Mxji3H5t5T2z
         UbiduO8mhPnn4f9Y6I3bam37Gj6B1FnxiFJYxhGYuXWbDc7/wJIauRSc45bUtEDOUPnp
         kDyXB0bzioBRc3x3WG2+VxQD/ShwLR2qNo5mD4QuHSiSQwdM2SZfpRFJXKhOzjDq7qUe
         OGiN8d/ZOqPoFUDyUaq3Xu0pDG69GIxvxBclAz0qXnF2TZD4Q6G7IXIKWaV8/WVhg23p
         aq5w==
X-Gm-Message-State: AOAM532sYBTpAO0u3Z9/Wz4QK3WGGoRLj7jK9C/JS/9IYcq0m7PlJBRp
        NEIwCE89EsqhpNaGBgU2OmfgceD+JB8=
X-Google-Smtp-Source: ABdhPJw5D4Q88+9q/sCxN+l8nPfVaS8kfpRQv+qVlCExwd89PQL/mPL1Ww7631sEJXJ9zJWBWrARcg==
X-Received: by 2002:a17:902:8494:b0:13b:9365:6f12 with SMTP id c20-20020a170902849400b0013b93656f12mr1319469plo.19.1631739320520;
        Wed, 15 Sep 2021 13:55:20 -0700 (PDT)
Received: from localhost ([2601:647:5b00:6f70:be34:681b:b1e9:776f])
        by smtp.gmail.com with ESMTPSA id i12sm5447990pjv.19.2021.09.15.13.55.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Sep 2021 13:55:19 -0700 (PDT)
Date:   Wed, 15 Sep 2021 13:55:18 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     Tom Rix <trix@redhat.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, mdf@kernel.org,
        hao.wu@intel.com, linux-kernel@vger.kernel.org,
        linux-fpga@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Add Tom Rix as fpga maintainer
Message-ID: <YUJdts/9kowAen+K@epycbox.lan>
References: <20210914182333.3903389-1-trix@redhat.com>
 <YUDw0gvgdijpytfU@kroah.com>
 <25d1dac2-4f9f-b5f0-8ce8-b88442deac9d@redhat.com>
 <YUH9dg01Mtk+kO+C@kroah.com>
 <c0630361-69cf-992a-78bf-a1c8335acd28@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c0630361-69cf-992a-78bf-a1c8335acd28@redhat.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Wed, Sep 15, 2021 at 09:12:51AM -0700, Tom Rix wrote:
> 
> On 9/15/21 7:04 AM, Greg KH wrote:
> > On Wed, Sep 15, 2021 at 06:23:16AM -0700, Tom Rix wrote:
> > > On 9/14/21 11:58 AM, Greg KH wrote:
> > > > [note, you got the maintainer's email address wrong on your cc: line
> > > >    I fixed it up...]
> > > > 
> > > > On Tue, Sep 14, 2021 at 11:23:33AM -0700, trix@redhat.com wrote:
> > > > > From: Tom Rix <trix@redhat.com>
> > > > > 
> > > > > I am the maintainer of the fpga/ subsystem for both the kernel and
> > > > > userspace for Red Hat.  I have been an active reviewer and contributor
> > > > > on for public fpga/ subsystem for the last year.  I would like to
> > > > > help out more.
> > > > > 
> > > > > Since I am paid to do this work, change the status to Supported.
> > > > > 
> > > > > Signed-off-by: Tom Rix <trix@redhat.com>
> > > > > ---
> > > > >    MAINTAINERS | 4 ++--
> > > > >    1 file changed, 2 insertions(+), 2 deletions(-)
> > > > > 
> > > > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > > > index 04fa4edf100b83..0443d7ab826659 100644
> > > > > --- a/MAINTAINERS
> > > > > +++ b/MAINTAINERS
> > > > > @@ -7353,9 +7353,9 @@ F:	include/uapi/linux/fpga-dfl.h
> > > > >    FPGA MANAGER FRAMEWORK
> > > > >    M:	Moritz Fischer <mdf@kernel.org>
> > > > > -R:	Tom Rix <trix@redhat.com>
> > > > > +M:	Tom Rix <trix@redhat.com>
> > > > >    L:	linux-fpga@vger.kernel.org
> > > > > -S:	Maintained
> > > > > +S:	Supported
> > > > >    W:	http://www.rocketboards.org
> > > > >    Q:	http://patchwork.kernel.org/project/linux-fpga/list/
> > > > >    T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mdf/linux-fpga.git
> > > > > -- 
> > > > > 2.26.3
> > > > > 
> > > > Traditionally existing maintainers are the ones that add new
> > > > maintainers, it's not something that you just submit a patch for hoping
> > > > it will be accepted.
> > > > 
> > > > What has changed since the last time you asked to do this?
> > > Because public and private requests have gone unanswered for so long, it is
> > > unclear if Moritz is still maintaining the subsystem.
> > He is, as is evident by the patches I accept from him each merge.
> > 
> > > The nearly year old xrt patchset has been pending for 6 weeks with minor
> > > changes to one patch out of 14 needing reviews.
> > Code quality is not the maintainer's job, it's the developer's, so the
> > age and number of reviews is not any indication.
> 
> https://lore.kernel.org/linux-fpga/20210802160521.331031-1-lizhi.hou@xilinx.com/
> 
> The review is needed because Moritz asked for the changes v8 here
> 
> https://lore.kernel.org/linux-fpga/YP42zE2ljx4hHj40@epycbox.lan/
> 
> When the maintainer asks for the changes, they are responsible for the
> followup.
> 
> > > The standard release patchset, which needs an opinion has on an api change,
> > > has been outstanding for 8 weeks.
> > Have a pointer to it?
> 
> This was a change you requested. the recent patchset is
> 
> https://lore.kernel.org/linux-fpga/20210914214327.94048-4-russell.h.weight@intel.com/
> 
> The discussion around the api change is
> 
> https://lore.kernel.org/linux-fpga/661d53d0-0ba4-d344-8da0-995a9b612905@redhat.com/
> 
> In these toss up's if the maintainer does not weigh in as the tie breaker,
> the patch stalls.
> 
> > 
> > > If maintainership depends on an approving maintainter, what happens when the
> > > approving maintainer has left ?
> > Vacations happen in the summer.  I've talked to Moritz many times, and
> > all is well here.
> 
> Yes. in the xrt v9 patch Moritz announced late of a vacation with a return
> of 9/4.
> 
> It has been 11 days.

I had a family issue that was unforseen combined with an unusual high
post-vacation workload at $dayjob when I got back.

I'm still catching up, and will get to it when I can.
 
- Moritz
