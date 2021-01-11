Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C44A62F1B07
	for <lists+linux-fpga@lfdr.de>; Mon, 11 Jan 2021 17:36:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730458AbhAKQfo (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 11 Jan 2021 11:35:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726997AbhAKQfo (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 11 Jan 2021 11:35:44 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01291C061786;
        Mon, 11 Jan 2021 08:35:04 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id r9so185272ioo.7;
        Mon, 11 Jan 2021 08:35:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KSxKKoTB7p9I30pNhP00kFn1ACWIHU12YNUj/6khzSI=;
        b=scFMssqAHrdOsn8AL32eTozLU4jibIHnvedDqRIuMQLinPICMZ0/7DPcjLuAZW963I
         lRgJDUOUZF7jDsov0iVjq7SMyPWh1grgMh+b8Bak8q5j5mx8wWWszAInFoh6/yvEGUSj
         9aPFCShhzh+CGS9e/4939fv4YB3xs/7IJ8NV2o12iQnzvMIBQN4mVu/soZ34nLG6Ulc/
         eRUhmoO1/gkRsswdocbhUljNIiIkTHMR4Zh7Xzy1kv0olKWiS0hl82N1HtmRvJIEq9VO
         BgDCb6vevATFp5uK/IaCuwSSw+VfVRIY63g6hib/pR9/JSj0s/f7fazOv/E/21q0L8q2
         QhTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KSxKKoTB7p9I30pNhP00kFn1ACWIHU12YNUj/6khzSI=;
        b=KfdN2me013Zi6GSf8SQWtLVgUTpMxZ22LnfyGr8KVC2z3ISiYF3K9esaJaeKMlcq7L
         2+Ww5KTZzaTDubYeAGKUneCd0cC3smBNK90LE2UT+2+cjYpsIw4oRYLySjL7wtEpYiMv
         8rqNoznumMhj9Rf+JEBQ6fbWFv7qXvjZvw44BFGbyFF7Ii9DtrRb0aylaOsOuhoaQxIJ
         383s0MGO6O6uRQoJj7Jm0cGr02i9FJnso7J+4h0x4Khxe8Y1kLRC8x2lflGNfKtO2OgR
         TcmilUSNxp+sQNhH39GvcNuLQ5YEdMNtvA7oIm5s4/zvaQSlT1LVNDWLMW8+RHLEr8+n
         D4Vg==
X-Gm-Message-State: AOAM532uBFrXx9dt1DRSTBabiDJfkBxJ7NV3NgAqM6kjhJ+Ahyh8TJCD
        kBp311xO3SPG/Y4VNWWDHs2etf2OECtngFWXzVQ=
X-Google-Smtp-Source: ABdhPJxTLbsfah3xMGMJDkpJzkOgAe3Jvi3T1bv0QSf54plIZlaHifmkIPgoLiewHWXKQnJ0Kq8KksY8DXm+ffUH0Ik=
X-Received: by 2002:a6b:6d1a:: with SMTP id a26mr86945iod.158.1610382903261;
 Mon, 11 Jan 2021 08:35:03 -0800 (PST)
MIME-Version: 1.0
References: <20210111112113.27242-1-lukas.bulwahn@gmail.com> <X/x0j+hWRdJ6U/MG@kroah.com>
In-Reply-To: <X/x0j+hWRdJ6U/MG@kroah.com>
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Mon, 11 Jan 2021 17:34:57 +0100
Message-ID: <CAKXUXMzR2J895_+ZsRqcJ___Pu0HnRfiiFFrGfehQe8J4kQrgg@mail.gmail.com>
Subject: Re: [PATCH -next] fpga: dfl-pci: rectify ReST formatting
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Wu Hao <hao.wu@intel.com>, Moritz Fischer <mdf@kernel.org>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        linux-fpga@vger.kernel.org, Tom Rix <trix@redhat.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Mon, Jan 11, 2021 at 4:52 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Mon, Jan 11, 2021 at 12:21:13PM +0100, Lukas Bulwahn wrote:
> > Commit fa41d10589be ("fpga: dfl-pci: locate DFLs by PCIe vendor specific
> > capability") provides documentation to the FPGA Device Feature List (DFL)
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
>

> You forgot a Reported-by: tag for the person who notified you of this :(

Greg, would you believe that I run 'make htmldocs' on linux-next myself?

Of course, Stephen Rothwell reports such documentation warnings as
well, but I take care independent of Stephen's reporting.

Lukas
