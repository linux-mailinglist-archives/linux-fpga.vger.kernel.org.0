Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 749D320674E
	for <lists+linux-fpga@lfdr.de>; Wed, 24 Jun 2020 00:42:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387599AbgFWWmX (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 23 Jun 2020 18:42:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387603AbgFWWmV (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 23 Jun 2020 18:42:21 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6453AC0619C1;
        Tue, 23 Jun 2020 15:42:21 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id k6so267332ili.6;
        Tue, 23 Jun 2020 15:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RPkcQXV410KGvavlVCIVYCWsyuTzlov4RUjatz1vzaA=;
        b=IujNulTy12IJopV54aPDo96MaQ8AuvJmgkk1CoSOzSLpuqgHq7sgjQoCkguIDgYDwc
         zD2zOD1EKHh55I4Y8iknpyCTK51Ny28Q3fB5M1lLfgAyOeHZ+i+pWl6sO03u1KNMvPJ2
         FDcHW/zuVPR241Fyvknrg87pb1y8l4/2JBww7ftnRQM3JWLwWcbYbuDGsgKBnT0zfqx9
         RsIj1+NiR0cY2c3Q4PR8eUf/IySurGEEz9Ia5UPt4Jzdav9RKp4KEv+VJcFTFqIdghD1
         E1K2TUg8yYmuNc644Xl5u9ZXRIK5l756WquDjz8XTRv1cUcb3X8wXu814KW7CIqEIo5y
         qv7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RPkcQXV410KGvavlVCIVYCWsyuTzlov4RUjatz1vzaA=;
        b=grKF8mwYYPAsM3QjNjkKiR3KHyXLe/BoOshUrX1RNfygFvv8HYWPo8bsKJbNh99C4r
         IdSf4euCdthsqfzjqETvMUkzk+TmHxSZSuHIGduCR2etHwoIYC9S+DTcHWrfjR0t3H39
         ACQR8jQpeUThZqKL7T17t82W/7yqS2swhH/tgD4sG8EFU13SW3z4Z0ZipGn9M19JNcwv
         fZR+EMHh5sEcL2C5sn37qiKURhB7C4l7mRMLA82IDBWr2weNfymAAL7eZDZsb49gaid2
         5YbqXUHVx8grQvfQ4LXAeshyvWWpIwruE6ixV03J/71nmtNMsp0RSB9+1MABBl0MoFvH
         U2sA==
X-Gm-Message-State: AOAM530b5h2pYDAOxxnBHOX5mMDSY7ixU9F8+13ZijjWEGJGE92qq0qR
        PiQFQW9cSf4KRbNxhvMw1m3QVL7EytW6fJjwZcU=
X-Google-Smtp-Source: ABdhPJxTrJ6Dkq29+wII4eC4MiZK97MSBRGyjZBojzDstkyR1TH7oSUKHg41Slo1xys6gBGBRejCcsmGa/3Z27cA7kk=
X-Received: by 2002:a92:b704:: with SMTP id k4mr24955972ili.129.1592952140677;
 Tue, 23 Jun 2020 15:42:20 -0700 (PDT)
MIME-Version: 1.0
References: <1592280528-6350-1-git-send-email-yilun.xu@intel.com>
 <20200622064806.GA5101@yilunxu-OptiPlex-7050> <c9a33ee6-67f2-36b8-0870-ebc038b929ce@redhat.com>
 <20200623052613.GB23037@yilunxu-OptiPlex-7050>
In-Reply-To: <20200623052613.GB23037@yilunxu-OptiPlex-7050>
From:   Moritz Fischer <moritz.fischer.private@gmail.com>
Date:   Tue, 23 Jun 2020 15:42:07 -0700
Message-ID: <CAJYdmeM7ec4PMtRV+qJrMDA9V+yCEv-zPAnSCFjx1V2Ca-aw9g@mail.gmail.com>
Subject: Re: [PATCH v7 0/7] Add interrupt support to FPGA DFL drivers
To:     Xu Yilun <yilun.xu@intel.com>
Cc:     Tom Rix <trix@redhat.com>, linux-fpga@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        bhu@redhat.com, mtosatti@redhat.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        jun.j.tian@intel.com, Wu Hao <hao.wu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Will look at it this week.

- Moritz

On Mon, Jun 22, 2020 at 10:30 PM Xu Yilun <yilun.xu@intel.com> wrote:
>
> On Mon, Jun 22, 2020 at 05:27:20AM -0700, Tom Rix wrote:
> > In addition to reviewing, I have run these changes on the pac a10 card and while i do not have an afu using interrupts, I have exercised some of the new interfaces.
> >
> > The most useful i have submitted to selftests drivers/fpga.  In the future, this would be a good place to put other fpga unit tests.
> >
> > The selftest patch depends on this change.
> >
> > So you can also add
> >
> > Tested-by: Tom Rix <trix@redhat.com>
>
> Yes I'll add your Tested-by tag.
>
> Thanks,
> Yilun
>
> >
> > Tom
> >
> > On 6/21/20 11:48 PM, Xu Yilun wrote:
> > > Hi Moritz:
> > >
> > > Could you please help review the patchset when you have time?
> > >
> > > You have already reviewed the first 3 patches some time ago. The
> > > comments are all fixed. Hao and Redhat guys also have done several
> > > rounds of review. The patches are all Acked-by Hao, reviewed by
> > > Marcelo & Tom.
> > >
> > > There is little change to the code for several months, seems it stays
> > > ready and just need your final Ack.
> > >
> > > Actually this is the last feature for our first generation PAC A10 Card,
> > > and is important for users to have the full support.
> > >
> > > We really need your help on code review ...
> > >
> > > Many thanks!
> > > Yilun
> > >
> > > On Tue, Jun 16, 2020 at 12:08:41PM +0800, Xu Yilun wrote:
> > >> This patchset add interrupt support to FPGA DFL drivers.
> > >>
> > >> With these patches, DFL driver will parse and assign interrupt resources
> > >> for enumerated feature devices and their sub features.
> > >>
> > >> This patchset also introduces a set of APIs for user to monitor DFL
> > >> interrupts. Three sub features (DFL FME error, DFL AFU error and user
> > >> interrupt) drivers now support these APIs.
> > >>
> > >> Patch #1: DFL framework change. Accept interrupt info input from DFL bus
> > >>           driver, and add interrupt parsing and assignment for feature
> > >>           sub devices.
> > >> Patch #2: DFL pci driver change, add interrupt info on DFL enumeration.
> > >> Patch #3: DFL framework change. Add helper functions for feature sub
> > >>           device drivers to handle interrupt and notify users.
> > >> Patch #4: Add interrupt support for AFU error reporting sub feature.
> > >> Patch #5: Add interrupt support for FME global error reporting sub
> > >>           feature.
> > >> Patch #6: Add interrupt support for a new sub feature, to handle user
> > >>           interrupts implemented in AFU.
> > >> Patch #7: Documentation for DFL interrupt handling.
> > >>
> > >> Main changes from v1:
> > >>  - Early validating irq table for each feature in parse_feature_irq()
> > >>    in Patch #1.
> > >>  - Changes IOCTL interfaces. use DFL_FPGA_FME/PORT_XXX_GET_IRQ_NUM
> > >>    instead of DFL_FPGA_FME/PORT_XXX_GET_INFO, delete flag field for
> > >>    DFL_FPGA_FME/PORT_XXX_SET_IRQ param
> > >>
> > >> Main changes from v2:
> > >>  - put parse_feature_irqs() inside create_feature_instance().
> > >>  - refines code for dfl_fpga_set_irq_triggers, delete local variable j.
> > >>  - put_user() instead of copy_to_user() for DFL_FPGA_XXX_GET_IRQ_NUM IOCTL
> > >>
> > >> Main changes from v3:
> > >>  - rebased to 5.7-rc1.
> > >>  - fail the dfl enumeration when irq parsing error happens.
> > >>  - Add 2 helper functions in dfl.c to handle generic irq ioctls in feature
> > >>    drivers.
> > >>
> > >> Main changes from v4:
> > >>  - Minor fixes for Hao's comments.
> > >>
> > >> Main changes from v5:
> > >>  - Remove unnecessary type casting in Patch #1 & #3.
> > >>  - Minor fixes for Moritz's comments.
> > >>
> > >> Main changes from v6:
> > >>  - Add the header file <linux/interrupt.h> for Patch #1, to fix build
> > >>    error on ARCH=xtensa
> > >>  - Minor fixes in Patch #2 & #3.
> > >>
> > >> Xu Yilun (7):
> > >>   fpga: dfl: parse interrupt info for feature devices on enumeration
> > >>   fpga: dfl: pci: add irq info for feature devices enumeration
> > >>   fpga: dfl: introduce interrupt trigger setting API
> > >>   fpga: dfl: afu: add interrupt support for port error reporting
> > >>   fpga: dfl: fme: add interrupt support for global error reporting
> > >>   fpga: dfl: afu: add AFU interrupt support
> > >>   Documentation: fpga: dfl: add descriptions for interrupt related
> > >>     interfaces.
> > >>
> > >>  Documentation/fpga/dfl.rst    |  19 +++
> > >>  drivers/fpga/dfl-afu-error.c  |  17 +++
> > >>  drivers/fpga/dfl-afu-main.c   |  32 +++++
> > >>  drivers/fpga/dfl-fme-error.c  |  18 +++
> > >>  drivers/fpga/dfl-fme-main.c   |   6 +
> > >>  drivers/fpga/dfl-pci.c        |  76 +++++++++--
> > >>  drivers/fpga/dfl.c            | 310 ++++++++++++++++++++++++++++++++++++++++++
> > >>  drivers/fpga/dfl.h            |  57 ++++++++
> > >>  include/uapi/linux/fpga-dfl.h |  82 +++++++++++
> > >>  9 files changed, 608 insertions(+), 9 deletions(-)
> > >>
> > >> --
> > >> 2.7.4
