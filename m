Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB8FA27392F
	for <lists+linux-fpga@lfdr.de>; Tue, 22 Sep 2020 05:17:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728436AbgIVDRj (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 21 Sep 2020 23:17:39 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39841 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728386AbgIVDRi (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 21 Sep 2020 23:17:38 -0400
Received: by mail-pg1-f194.google.com with SMTP id d13so10778863pgl.6;
        Mon, 21 Sep 2020 20:17:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zRZaria47CVi1lDFzYKI56Fnp059Wif+DaIlvUEMWGU=;
        b=g4HYU/0pHbUc7i0H6b5sL5x+NXeYEih3i18IOpbQj8W2QI0+dviSCdmXhfi2pb+PYH
         1zqgE0bd0x/zAHs7jpTOAdSMXM6r+ENhA79dJy2m+O20F74t4WvY0dTT+U71YSnxxLX/
         0dLUJSU1yKwH59gVyzkgO1JrFrwCCXmMvZe/TO0PDMVGz/3h0mbR1+dsAbIBjikfFw++
         bvvuRN85qGL+7IfiyrUd5xssVomICXalwam0kwXDlCaQRL+2WpmENz/LGK1hYYRRfm6p
         6JhyPynRfzaNoedm0Qg0WG7c1C59Akxsy6bjwUYI1JNUwMgiX3rPplnIo9fdywchVLxP
         CZnw==
X-Gm-Message-State: AOAM532xReAotGK/yttue2ox4w/A7bSY8uuunDDflECpkD8/SIt1zoM3
        BPs7OjH10HE+BRWvjyG10VU=
X-Google-Smtp-Source: ABdhPJygMNmppaVjHKO+bzyfeDkiG8zmau+rxQaBUTSy/O0EZmn4TjXemJJ+O/07Z8WXY9p7hcaiAQ==
X-Received: by 2002:a17:902:74ca:b029:d2:2cc0:5389 with SMTP id f10-20020a17090274cab02900d22cc05389mr2494230plt.15.1600744657833;
        Mon, 21 Sep 2020 20:17:37 -0700 (PDT)
Received: from localhost ([2601:647:5b00:1162:1ac0:17a6:4cc6:d1ef])
        by smtp.gmail.com with ESMTPSA id j1sm12757426pgp.93.2020.09.21.20.17.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2020 20:17:37 -0700 (PDT)
Date:   Mon, 21 Sep 2020 20:17:36 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>,
        linux-fpga@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        trix@redhat.com, lgoncalv@redhat.com,
        Russ Weight <russell.h.weight@intel.com>
Subject: Re: [PATCH v3] memory: dfl-emif: add the DFL EMIF private feature
 driver
Message-ID: <20200922031736.GA55292@archbook>
References: <1600666280-25651-1-git-send-email-yilun.xu@intel.com>
 <1600666280-25651-2-git-send-email-yilun.xu@intel.com>
 <20200921072311.GA6133@kozik-lap>
 <20200921203104.GA35580@epycbox.lan>
 <CAJKOXPeHRQ14mBGJ7mSg=97H+c+bGJwpss=ADL1z_gW4ac0ESA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJKOXPeHRQ14mBGJ7mSg=97H+c+bGJwpss=ADL1z_gW4ac0ESA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi Krzysztof,

On Mon, Sep 21, 2020 at 10:46:45PM +0200, Krzysztof Kozlowski wrote:
> WhOn Mon, 21 Sep 2020 at 22:31, Moritz Fischer <mdf@kernel.org> wrote:
> >
> > Hi Krzysztof,
> >
> > On Mon, Sep 21, 2020 at 09:23:11AM +0200, Krzysztof Kozlowski wrote:
> > > On Mon, Sep 21, 2020 at 01:31:20PM +0800, Xu Yilun wrote:
> > > > This driver is for the EMIF private feature implemented under FPGA
> > > > Device Feature List (DFL) framework. It is used to expose memory
> > > > interface status information as well as memory clearing control.
> > > >
> > > > The purpose of memory clearing block is to zero out all private memory
> > > > when FPGA is to be reprogrammed. This gives users a reliable method to
> > > > prevent potential data leakage.
> > > >
> > > > Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> > > > Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> > > > ---
> > > > v2: Adjust the position of this driver in Kconfig.
> > > >     Improves the name of the Kconfig option.
> > > >     Change the include dfl-bus.h to dfl.h, cause the previous patchset
> > > >      renames the file.
> > > >     Some minor fixes and comment improvement.
> > > > v3: Adjust the position of the driver in Makefile.
> > > > ---
> > > >  .../ABI/testing/sysfs-bus-dfl-devices-emif         |  25 +++
> > > >  drivers/memory/Kconfig                             |   9 +
> > > >  drivers/memory/Makefile                            |   2 +
> > > >  drivers/memory/dfl-emif.c                          | 207 +++++++++++++++++++++
> > > >  4 files changed, 243 insertions(+)
> > > >  create mode 100644 Documentation/ABI/testing/sysfs-bus-dfl-devices-emif
> > > >  create mode 100644 drivers/memory/dfl-emif.c
> > > >
> > >
> > > Hi Moritz,
> > >
> > > Since this depends on dfl patches, I would need a stable tag with them
> > > or you can take it directly:
> > > Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
> > >
> > > Best regards,
> > > Krzysztof
> >
> > The FPGA patches go through Greg's tree. For the time being it's
> > probably easiest if I take the changes through my tree once Greg pulled
> > my tree.
> 
> Yes.
> 
> >
> > Do you have any feedback to better handle this sort of subsystem
> > spanning changesets for me?
> 
> The easiest through a separate branch. Assuming that such need for
> sharing patches is known.
> 
> If the patches touch generic things, which could be used by other
> drivers/subsystems, or if it is known that there will be someone
> depending on them, the easiest is to put them on separate branch which
> you later merge into your for-next. You send to Greg your for-next. If
> these patches are needed by someone else, e.g. me, you prepare a tag
> on them and send a pull request with that tag. I pull it and send
> these (and only these!) along with other patches. No duplication of
> commits, only two merges.
> 
> Recent example was here:
> https://lore.kernel.org/lkml/20200819191722.GA38371@sirena.org.uk/
> where Mark Brown wanted these through his tree, but later work on
> Samsung ARM depended on them.
> 
> Best regards,
> Krzysztof

Appreciate the explanation, that makes sense. Thanks for taking the
time. I'll do this moving forward.

Cheers,
Moritz
