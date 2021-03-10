Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 330E63344E3
	for <lists+linux-fpga@lfdr.de>; Wed, 10 Mar 2021 18:13:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230270AbhCJRNC (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 10 Mar 2021 12:13:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:46070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230508AbhCJRMz (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 10 Mar 2021 12:12:55 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 702A664FC9;
        Wed, 10 Mar 2021 17:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615396375;
        bh=D/FvI5/EvO4EQdDa5GWti/ww8XzdvJWo3ytxEGELswA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=aZ9DKgy4t4SQc/wfZY7YNMuardIEG6m6h/L2bxF+Lp3KvFYxPlB+gkQplCI4/pRfP
         SCpPZKdSvin/oHHjqZfH5U4G3kdS7i/l7tYWx3WxutqvU0negQTgyPzd633UA+H/fN
         SLZVGsFiyqDfRjnBQZd/DoqrvYyBNZTnw7rISwTvIJrteFRnRH5HTT2CSl2nC0Erny
         GXVKYjmTm+qFInqS0TRGakzRAy+qyYTVlYTUJfkPDG9ZVO+TlutPZ9Agr4ao31JMHF
         5+gPE9eeetHzTtrOw3AUJ7OACpXkvmQUnshmecXp9YVBTj28RJO0S5m9ftSSh2ZLPU
         JfQvo4XjkCV6w==
Received: by mail-qk1-f178.google.com with SMTP id 130so17561082qkh.11;
        Wed, 10 Mar 2021 09:12:55 -0800 (PST)
X-Gm-Message-State: AOAM532Tqz6xMNXGzWMjJ/jIZuO2fiXqEyWJPMwZ9AyGB/FbEiTuacnh
        3cIMyj5ArC9uz0FLED/AKiYWrmpCxnkf7Lgv8g==
X-Google-Smtp-Source: ABdhPJyfKgPuAg+Rwsvx7DwP4g0N3ToASB+7PwyV0TZLLMh4KMaYeuKkiqIM9jYP1rGrOPqxQPdORYY86IUq0hFIcd4=
X-Received: by 2002:a37:d82:: with SMTP id 124mr3599750qkn.311.1615396374676;
 Wed, 10 Mar 2021 09:12:54 -0800 (PST)
MIME-Version: 1.0
References: <20210304070224.22346-1-nava.manne@xilinx.com> <20210304070224.22346-3-nava.manne@xilinx.com>
 <20210308201944.GA2886704@robh.at.kernel.org> <MWHPR02MB26231DD759D8C9D1CB26EC1EC2919@MWHPR02MB2623.namprd02.prod.outlook.com>
In-Reply-To: <MWHPR02MB26231DD759D8C9D1CB26EC1EC2919@MWHPR02MB2623.namprd02.prod.outlook.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 10 Mar 2021 10:12:43 -0700
X-Gmail-Original-Message-ID: <CAL_JsqLDK5pNprA5RJq8VfTbQX=hP-8NUyY6Xsesz3TE6=YYeg@mail.gmail.com>
Message-ID: <CAL_JsqLDK5pNprA5RJq8VfTbQX=hP-8NUyY6Xsesz3TE6=YYeg@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] dt-bindings: fpga: Add binding doc for versal fpga manager
To:     Nava kishore Manne <navam@xilinx.com>
Cc:     "mdf@kernel.org" <mdf@kernel.org>,
        "trix@redhat.com" <trix@redhat.com>,
        Michal Simek <michals@xilinx.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Jolly Shah <JOLLYS@xilinx.com>, Rajan Vaja <RAJANV@xilinx.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        Manish Narani <MNARANI@xilinx.com>,
        Amit Sunil Dhamne <amitsuni@xilinx.com>,
        Tejas Patel <tejasp@xlnx.xilinx.com>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "chinnikishore369@gmail.com" <chinnikishore369@gmail.com>,
        Appana Durga Kedareswara Rao <appanad@xilinx.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Wed, Mar 10, 2021 at 3:50 AM Nava kishore Manne <navam@xilinx.com> wrote:
>
> Hi Rob,
>
>         Thanks for providing the review comments.
> Please find my response inline.
>
> > -----Original Message-----
> > From: Rob Herring <robh@kernel.org>
> > Sent: Tuesday, March 9, 2021 1:50 AM
> > To: Nava kishore Manne <navam@xilinx.com>
> > Cc: mdf@kernel.org; trix@redhat.com; Michal Simek <michals@xilinx.com>;
> > gregkh@linuxfoundation.org; Jolly Shah <JOLLYS@xilinx.com>; Rajan Vaja
> > <RAJANV@xilinx.com>; arnd@arndb.de; Manish Narani
> > <MNARANI@xilinx.com>; Amit Sunil Dhamne <amitsuni@xilinx.com>; Tejas
> > Patel <tejasp@xlnx.xilinx.com>; linux-fpga@vger.kernel.org;
> > devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; linux-arm-
> > kernel@lists.infradead.org; chinnikishore369@gmail.com; Appana Durga
> > Kedareswara Rao <appanad@xilinx.com>
> > Subject: Re: [PATCH v3 2/3] dt-bindings: fpga: Add binding doc for versal fpga
> > manager
> >
> > On Thu, Mar 04, 2021 at 12:32:23PM +0530, Nava kishore Manne wrote:
> > > From: Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
> > >
> > > This patch adds binding doc for versal fpga manager driver.
> >
> > Why do you need a DT entry for this? Can't the Versal firmware driver
> > instantiate the fpga-mgr device?
> >
> This dt entry is need to handle the fpga regions properly for both full and Partial bitstream loading use cases and it cannot be done by Versal firmware driver instantiate.

Ah yes, I forgot about that.

Rob
