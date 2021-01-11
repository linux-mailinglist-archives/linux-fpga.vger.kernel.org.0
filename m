Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52EBB2F1BEA
	for <lists+linux-fpga@lfdr.de>; Mon, 11 Jan 2021 18:10:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389322AbhAKRKW (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 11 Jan 2021 12:10:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389161AbhAKRKW (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 11 Jan 2021 12:10:22 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02534C061795;
        Mon, 11 Jan 2021 09:10:07 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id o6so293530iob.10;
        Mon, 11 Jan 2021 09:10:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VmWiaEl9Mk+AWYmB55oakmWLp7f5/lt/KLd9lphAi0k=;
        b=XHwT0fjbS3EM/AycGDSOKcwmTWbHHbGdUodBhFt3YZKBd4FqLqwkEBbn0JfAeRCE6t
         /0Jax83meTLibD2Qyy0AOO2kNJGXJkSF+a2d7+5UDpp0q8XXEWC6+IVB8wjwYfAqwCRH
         wPxFo2qU4hzXfpuNYqP5HjegcJh07sv67OfjOmR3ocCUec1xpbLpsteP4hjWsxHlgpea
         gYjVeyVS1DI86/rOXT+yqJwkLRgXHeZbGJ9C7VK1dIrZvbtrO0MG9YwiMaa5QPv3dAug
         4YzqyyUR8Rc0/OQMxEUx9s4xHthgAYrARt2ZJQBfB6IqjI75RBWOZHr6gmHUPQy+kgFi
         HVnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VmWiaEl9Mk+AWYmB55oakmWLp7f5/lt/KLd9lphAi0k=;
        b=S0zWJPx87BsB+kMs6WSuMyl0VlVHjppgJV4yrFXZp0s0EyX9DZkmTXewa/VJgXAutW
         jqJi7hY15817j92XOPoWOXWJIVWKuu4mN4eM/nniAdoLVRPKJVF3/cfP5/BK860w36rO
         Cl58FeVtK+lRDomBVcq1fhrrCwaUF2Lebu/Y0ftVOiPHmHhDNR1305mRsJgGTWHC1xAy
         73u/r2k2cJevU7Okc00x9pKpdcNLxVhtRJ7+I/znQ+i0mcf10kkbl9zrNzJlfck5XYlH
         KoTvHsh6uVZ0EDiQyqfyxyAsLlXVHcFf9EXeMD8mt0gueP/u2f2px/998rMvTRdzNJls
         mXxA==
X-Gm-Message-State: AOAM5319pyTNKBgzzvgO9L/W5S16VQ+7eJ3+Y5v6v/zrrweEtRtMwTzL
        /ewNQrt6cDdLZJbkXmvnFY3UMQUhmNzhDNSLGQ0=
X-Google-Smtp-Source: ABdhPJyBn64lL/hCRW6UD1V8FHbeY4N+SR/1HdOW6M2mhjRKM9GR42hI/ZWeJbhBs8PGHLBOXCvaxD8ZRFl2UKIAPWg=
X-Received: by 2002:a02:9107:: with SMTP id a7mr693168jag.12.1610385006372;
 Mon, 11 Jan 2021 09:10:06 -0800 (PST)
MIME-Version: 1.0
References: <20210111112113.27242-1-lukas.bulwahn@gmail.com> <X/x07V2WqhmkIMcr@archbook>
In-Reply-To: <X/x07V2WqhmkIMcr@archbook>
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Mon, 11 Jan 2021 18:10:01 +0100
Message-ID: <CAKXUXMwTRC+NBZ=KDfZCMwjSxt+B_gg7F74apxCE=wp7C3d-Ag@mail.gmail.com>
Subject: Re: [PATCH -next] fpga: dfl-pci: rectify ReST formatting
To:     Moritz Fischer <mdf@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wu Hao <hao.wu@intel.com>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        linux-fpga@vger.kernel.org, Tom Rix <trix@redhat.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Mon, Jan 11, 2021 at 4:55 PM Moritz Fischer <mdf@kernel.org> wrote:
>
> Hi Lukas,
>
> On Mon, Jan 11, 2021 at 12:21:13PM +0100, Lukas Bulwahn wrote:
> > Commit fa41d10589be ("fpga: dfl-pci: locate DFLs by PCIe vendor specific
> > capability") provides documentation to the FPGA Device Feature List (DFL)
> Nit: Do you want to make this a Fixes: tag instead?

IMHO, it is just adjusting the mark-up of the documentation and that
does not deserve a Fixes: tag.

Also, in the past, I got more frequent rejections when adding Fixes:
tags for such patches compared to proposals adding a Fixes: tag. So, I
settled for not adding Fixes: tags for such minor adjustment patches.

Lukas

> > Framework Overview, but introduced new documentation warnings:
> >
> >   ./Documentation/fpga/dfl.rst:
> >     505: WARNING: Title underline too short.
> >     523: WARNING: Unexpected indentation.
> >     523: WARNING: Blank line required after table.
> >     524: WARNING: Block quote ends without a blank line; unexpected unindent.
> >
> > Rectify ReST formatting in ./Documentation/fpga/dfl.rst.
> >
> > Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> Acked-by: Moritz Fischer <mdf@kernel.org>
> > ---
> > applies cleanly on next-20210111
> >
> > Moritz, Matthew, please ack.
> >
> > Greg, please pick this doc fixup to your fpga -next tree on top of
> > the commit above.
> >
> >  Documentation/fpga/dfl.rst | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/fpga/dfl.rst b/Documentation/fpga/dfl.rst
> > index ea8cefc18bdb..c41ac76ffaae 100644
> > --- a/Documentation/fpga/dfl.rst
> > +++ b/Documentation/fpga/dfl.rst
> > @@ -502,7 +502,7 @@ FME Partial Reconfiguration Sub Feature driver (see drivers/fpga/dfl-fme-pr.c)
> >  could be a reference.
> >
> >  Location of DFLs on a PCI Device
> > -===========================
> > +================================
> >  The original method for finding a DFL on a PCI device assumed the start of the
> >  first DFL to offset 0 of bar 0.  If the first node of the DFL is an FME,
> >  then further DFLs in the port(s) are specified in FME header registers.
> > @@ -514,6 +514,7 @@ data begins with a 4 byte vendor specific register for the number of DFLs follow
> >  Offset/BIR vendor specific registers for each DFL. Bits 2:0 of Offset/BIR register
> >  indicates the BAR, and bits 31:3 form the 8 byte aligned offset where bits 2:0 are
> >  zero.
> > +::
> >
> >          +----------------------------+
> >          |31     Number of DFLS      0|
> > --
> > 2.17.1
> >
>
> Thanks for doing this, I was about to send that same patch myself.
>
> - Moritz
