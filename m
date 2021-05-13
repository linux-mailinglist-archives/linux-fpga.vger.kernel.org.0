Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02E5C37F9B9
	for <lists+linux-fpga@lfdr.de>; Thu, 13 May 2021 16:35:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234512AbhEMOgJ (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 13 May 2021 10:36:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:56170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234494AbhEMOgH (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 13 May 2021 10:36:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A894761439;
        Thu, 13 May 2021 14:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620916497;
        bh=xxfQlMD0wezKXwFYz7D8jYYCXmAAXgZnJxiZiy+zERw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=h9wyMZvJCnfOcphUqpJuu+DGLjnYKSne2kKoyNvvrQCh5yv9WAiU+VhRuXZMyRYlA
         ZZdofZvciEmZE6ny7W2LbRmDjsXyMboATkOt+TlpKxuE3imtxfa0KTMNXV3My7aoc2
         bb1XkXIhUE9z5vw7QrOd6NN8s9ir+/DkCoWn1yZJAt/p1sTIpgBBTcK6aq7G3UyT7W
         /JfCpNRrmioEpTw0sw5i0aCP1at7gFzqTrBLdw6l7OEfpFke4l53G3e+dB2Pxd+AGG
         SrKYnhoYYAbF1uQP+GOEBJ2WbphdD8h4nFv4xIH8Pwlofcc9dKcIfG2zwBDWCa4SS5
         E/wpodRAxHxTw==
Received: by mail-ed1-f50.google.com with SMTP id c22so31210098edn.7;
        Thu, 13 May 2021 07:34:57 -0700 (PDT)
X-Gm-Message-State: AOAM5310bsc2BIdpsdaXF5mNOa31Re80jsIaCR3jqxZtphQFUJZT+wNJ
        Q04Xr1ptb0HYSiD/IXpF3ehycHcwvC1WRjqRSg==
X-Google-Smtp-Source: ABdhPJwEpp9Y9Fpl5bmyoUu5TLouC2jnXOjbcycNr9lgu5xw7SEYdFpsCB7SACyUOYBlugxVcIxqW33hPAfKM5Cv6Ls=
X-Received: by 2002:a50:c446:: with SMTP id w6mr47224146edf.62.1620916496110;
 Thu, 13 May 2021 07:34:56 -0700 (PDT)
MIME-Version: 1.0
References: <20210504102227.15475-1-nava.manne@xilinx.com> <20210504102227.15475-3-nava.manne@xilinx.com>
 <20210513023104.GA909876@robh.at.kernel.org> <MWHPR02MB262309A8DC5BD857CBB01446C2519@MWHPR02MB2623.namprd02.prod.outlook.com>
In-Reply-To: <MWHPR02MB262309A8DC5BD857CBB01446C2519@MWHPR02MB2623.namprd02.prod.outlook.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 13 May 2021 09:34:43 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+mHsrgQOrT48gaoqBOUuMf5mxeVauM74RDxELiA8fXKg@mail.gmail.com>
Message-ID: <CAL_Jsq+mHsrgQOrT48gaoqBOUuMf5mxeVauM74RDxELiA8fXKg@mail.gmail.com>
Subject: Re: [RFC PATCH 2/4] fpga: Add new properties to support user-key
 encrypted bitstream loading
To:     Nava kishore Manne <navam@xilinx.com>
Cc:     "mdf@kernel.org" <mdf@kernel.org>,
        "trix@redhat.com" <trix@redhat.com>,
        Michal Simek <michals@xilinx.com>,
        "arnd@arndb.de" <arnd@arndb.de>, Rajan Vaja <RAJANV@xilinx.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        Amit Sunil Dhamne <amitsuni@xlnx.xilinx.com>,
        Tejas Patel <tejasp@xlnx.xilinx.com>,
        "zou_wei@huawei.com" <zou_wei@huawei.com>,
        Manish Narani <MNARANI@xilinx.com>,
        Sai Krishna Potthuri <lakshmis@xilinx.com>,
        Jiaying Liang <jliang@xilinx.com>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>, git <git@xilinx.com>,
        "chinnikishore369@gmail.com" <chinnikishore369@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Thu, May 13, 2021 at 5:55 AM Nava kishore Manne <navam@xilinx.com> wrote=
:
>
> Hi Rob,
>
>         Please find my response inline.
>
> > -----Original Message-----
> > From: Rob Herring <robh@kernel.org>
> > Sent: Thursday, May 13, 2021 8:01 AM
> > To: Nava kishore Manne <navam@xilinx.com>
> > Cc: mdf@kernel.org; trix@redhat.com; Michal Simek <michals@xilinx.com>;
> > arnd@arndb.de; Rajan Vaja <RAJANV@xilinx.com>;
> > gregkh@linuxfoundation.org; linus.walleij@linaro.org; Amit Sunil Dhamne
> > <amitsuni@xlnx.xilinx.com>; Tejas Patel <tejasp@xlnx.xilinx.com>;
> > zou_wei@huawei.com; Manish Narani <MNARANI@xilinx.com>; Sai Krishna
> > Potthuri <lakshmis@xilinx.com>; Jiaying Liang <jliang@xilinx.com>; linu=
x-
> > fpga@vger.kernel.org; devicetree@vger.kernel.org; linux-
> > kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org; git
> > <git@xilinx.com>; chinnikishore369@gmail.com
> > Subject: Re: [RFC PATCH 2/4] fpga: Add new properties to support user-k=
ey
> > encrypted bitstream loading
> >
> > On Tue, May 04, 2021 at 03:52:25PM +0530, Nava kishore Manne wrote:
> > > This patch Adds =E2=80=98encrypted-key-name=E2=80=99 and
> > > =E2=80=98encrypted-user-key-fpga-config=E2=80=99 properties to suppor=
t user-key
> > > encrypted bitstream loading use case.
> > >
> > > Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
> > > ---
> > >  Documentation/devicetree/bindings/fpga/fpga-region.txt | 5 +++++
> > >  1 file changed, 5 insertions(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/fpga/fpga-region.txt
> > > b/Documentation/devicetree/bindings/fpga/fpga-region.txt
> > > index d787d57491a1..957dc6cbcd9e 100644
> > > --- a/Documentation/devicetree/bindings/fpga/fpga-region.txt
> > > +++ b/Documentation/devicetree/bindings/fpga/fpga-region.txt
> > > @@ -177,6 +177,9 @@ Optional properties:
> > >     it indicates that the FPGA has already been programmed with this
> > image.
> > >     If this property is in an overlay targeting a FPGA region, it is =
a
> > >     request to program the FPGA with that image.
> > > +- encrypted-key-name : should contain the name of an encrypted key f=
ile
> > located
> > > +   on the firmware search path. It will be used to decrypt the FPGA
> > image
> > > +   file.
> > >  - fpga-bridges : should contain a list of phandles to FPGA Bridges t=
hat must
> > be
> > >     controlled during FPGA programming along with the parent FPGA
> > bridge.
> > >     This property is optional if the FPGA Manager handles the bridges=
.
> > > @@ -187,6 +190,8 @@ Optional properties:
> > >  - external-fpga-config : boolean, set if the FPGA has already been
> > configured
> > >     prior to OS boot up.
> > >  - encrypted-fpga-config : boolean, set if the bitstream is encrypted
> > > +- encrypted-user-key-fpga-config : boolean, set if the bitstream is
> > encrypted
> > > +   with user key.
> >
> > What's the relationship with encrypted-fpga-config? Both present or
> > mutually exclusive? Couldn't this be implied by encrypted-key-name bein=
g
> > present?
> >
>
> In Encryption we have two kinds of use case one is Encrypted Bitstream lo=
ading with Device-key and
> Other one is Encrypted Bitstream loading with User-key. encrypted-fpga-co=
nfig and encrypted-user-key-fpga-config
> are mutually exclusive. To differentiate both the use cases I have added =
this new flag and Aes Key file(encrypted-key-name)
> is needed only for encrypted-user-key-fpga-config use cases.

If encrypted-key-name is required for a user key, then why do you need
encrypted-user-key-fpga-config also?

IOW, why have 3 properties (that's 9 possible combinations) for 2 modes?

Rob
