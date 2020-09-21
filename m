Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 584F62733CD
	for <lists+linux-fpga@lfdr.de>; Mon, 21 Sep 2020 22:47:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727131AbgIUUrB (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 21 Sep 2020 16:47:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:54574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726427AbgIUUrB (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 21 Sep 2020 16:47:01 -0400
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6739923119;
        Mon, 21 Sep 2020 20:47:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600721220;
        bh=FRGy9KeA6keJo6DKkOX4ggOgStSJdUoqElo7gyeL9j4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=WTLCoU09L74MbsHW3c51FAba8XeNPyoMEb6kDvCy70mMz0v4QVIdTF+LJ8FA0OINw
         W0NeRiVoAFlRluCOjZ2ljCVEykV0u4bfSXcMTnY6PFlmmz1N3yeqflJJbEwwOAjlCf
         HFMkWPkjrRPdjeV/3y+DCB+XujzPvcP5H8W7HBLk=
Received: by mail-ej1-f50.google.com with SMTP id i26so19652564ejb.12;
        Mon, 21 Sep 2020 13:47:00 -0700 (PDT)
X-Gm-Message-State: AOAM532ZbgTvkrDtXKXraduaYkhSRb5kvsYxrEGQtf41BAhWvDji5z9m
        k3Szqt4vYR8CRwVW3ah8NURh5yPMCX/GFE83UPA=
X-Google-Smtp-Source: ABdhPJwextx6DPFoHEhzUmdYxoVG7PFDk92TVavYB2IIsWcYehjEUAQ7Gx3BazMMe+dArHl8o4S3EHeHVy/zDaATj+o=
X-Received: by 2002:a17:906:4046:: with SMTP id y6mr1442868ejj.148.1600721218818;
 Mon, 21 Sep 2020 13:46:58 -0700 (PDT)
MIME-Version: 1.0
References: <1600666280-25651-1-git-send-email-yilun.xu@intel.com>
 <1600666280-25651-2-git-send-email-yilun.xu@intel.com> <20200921072311.GA6133@kozik-lap>
 <20200921203104.GA35580@epycbox.lan>
In-Reply-To: <20200921203104.GA35580@epycbox.lan>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Mon, 21 Sep 2020 22:46:45 +0200
X-Gmail-Original-Message-ID: <CAJKOXPeHRQ14mBGJ7mSg=97H+c+bGJwpss=ADL1z_gW4ac0ESA@mail.gmail.com>
Message-ID: <CAJKOXPeHRQ14mBGJ7mSg=97H+c+bGJwpss=ADL1z_gW4ac0ESA@mail.gmail.com>
Subject: Re: [PATCH v3] memory: dfl-emif: add the DFL EMIF private feature driver
To:     Moritz Fischer <mdf@kernel.org>
Cc:     Xu Yilun <yilun.xu@intel.com>, linux-fpga@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        trix@redhat.com, lgoncalv@redhat.com,
        Russ Weight <russell.h.weight@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

WhOn Mon, 21 Sep 2020 at 22:31, Moritz Fischer <mdf@kernel.org> wrote:
>
> Hi Krzysztof,
>
> On Mon, Sep 21, 2020 at 09:23:11AM +0200, Krzysztof Kozlowski wrote:
> > On Mon, Sep 21, 2020 at 01:31:20PM +0800, Xu Yilun wrote:
> > > This driver is for the EMIF private feature implemented under FPGA
> > > Device Feature List (DFL) framework. It is used to expose memory
> > > interface status information as well as memory clearing control.
> > >
> > > The purpose of memory clearing block is to zero out all private memory
> > > when FPGA is to be reprogrammed. This gives users a reliable method to
> > > prevent potential data leakage.
> > >
> > > Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> > > Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> > > ---
> > > v2: Adjust the position of this driver in Kconfig.
> > >     Improves the name of the Kconfig option.
> > >     Change the include dfl-bus.h to dfl.h, cause the previous patchset
> > >      renames the file.
> > >     Some minor fixes and comment improvement.
> > > v3: Adjust the position of the driver in Makefile.
> > > ---
> > >  .../ABI/testing/sysfs-bus-dfl-devices-emif         |  25 +++
> > >  drivers/memory/Kconfig                             |   9 +
> > >  drivers/memory/Makefile                            |   2 +
> > >  drivers/memory/dfl-emif.c                          | 207 +++++++++++++++++++++
> > >  4 files changed, 243 insertions(+)
> > >  create mode 100644 Documentation/ABI/testing/sysfs-bus-dfl-devices-emif
> > >  create mode 100644 drivers/memory/dfl-emif.c
> > >
> >
> > Hi Moritz,
> >
> > Since this depends on dfl patches, I would need a stable tag with them
> > or you can take it directly:
> > Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
> >
> > Best regards,
> > Krzysztof
>
> The FPGA patches go through Greg's tree. For the time being it's
> probably easiest if I take the changes through my tree once Greg pulled
> my tree.

Yes.

>
> Do you have any feedback to better handle this sort of subsystem
> spanning changesets for me?

The easiest through a separate branch. Assuming that such need for
sharing patches is known.

If the patches touch generic things, which could be used by other
drivers/subsystems, or if it is known that there will be someone
depending on them, the easiest is to put them on separate branch which
you later merge into your for-next. You send to Greg your for-next. If
these patches are needed by someone else, e.g. me, you prepare a tag
on them and send a pull request with that tag. I pull it and send
these (and only these!) along with other patches. No duplication of
commits, only two merges.

Recent example was here:
https://lore.kernel.org/lkml/20200819191722.GA38371@sirena.org.uk/
where Mark Brown wanted these through his tree, but later work on
Samsung ARM depended on them.

Best regards,
Krzysztof
