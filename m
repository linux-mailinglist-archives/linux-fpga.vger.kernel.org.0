Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75E57334500
	for <lists+linux-fpga@lfdr.de>; Wed, 10 Mar 2021 18:20:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233170AbhCJRU1 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 10 Mar 2021 12:20:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:47580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232925AbhCJRT5 (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 10 Mar 2021 12:19:57 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 892D864FCA;
        Wed, 10 Mar 2021 17:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615396796;
        bh=WdJcFgO9Ab4EwkwCGapjsq0NBHCfwsTezuqlatGj9W0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ewZT5AU2KxemL7xN1JnFvBkfiwHC4K35mYGZ0hZGYCP60VqGIEgP1/R0K55yEf5qV
         ing4qozOCFdAjrdV8NRKzn+qy0Lup29tWaI6WOGVaAdxAZ0wJkpvMI/poPVxmebpUZ
         EGowty58SmmBJqoSPG9aK1doEtusJSZI59XFz9huo0cbNvOExf147jReFm+Ddo2gnV
         o5r/FIZDP3/94zWqm65erfdgbSt7BrgX2Kt72cgmiCIijTZbV9UpM2nKZ0mFxPKHSH
         PwoJ4Y5wc0oK2w6D+nrzCjGDD999vvxUaSizZ/PoNnlM4XGKp7rda0HvzrbJb2gQtj
         RMPSnfS/z8ZGQ==
Received: by mail-qk1-f175.google.com with SMTP id a9so17577010qkn.13;
        Wed, 10 Mar 2021 09:19:56 -0800 (PST)
X-Gm-Message-State: AOAM533LswDUlct2mEyotFERjxElzzK8faux1nlGi50s9ldT0nUxMrtF
        rmiZ0ZRm/CSgWVooqEMLp1Z+GqdXsqd7SNqmhA==
X-Google-Smtp-Source: ABdhPJxHCUeEM1sl0CP7oLSOGr4ElsXStXMW1BKNcfVgP+4t9wFxrHd80qsCzG9xhSGiPXRgrhqPH64MxqoMe0+aVDA=
X-Received: by 2002:a05:620a:b02:: with SMTP id t2mr3811728qkg.128.1615396795357;
 Wed, 10 Mar 2021 09:19:55 -0800 (PST)
MIME-Version: 1.0
References: <20210304070224.22346-1-nava.manne@xilinx.com> <20210304070224.22346-3-nava.manne@xilinx.com>
 <20210308201944.GA2886704@robh.at.kernel.org> <MWHPR02MB26231DD759D8C9D1CB26EC1EC2919@MWHPR02MB2623.namprd02.prod.outlook.com>
 <CAL_JsqLDK5pNprA5RJq8VfTbQX=hP-8NUyY6Xsesz3TE6=YYeg@mail.gmail.com>
In-Reply-To: <CAL_JsqLDK5pNprA5RJq8VfTbQX=hP-8NUyY6Xsesz3TE6=YYeg@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 10 Mar 2021 10:19:44 -0700
X-Gmail-Original-Message-ID: <CAL_JsqKAP5Up7=qJEM6E0HuV2-faaVqTg+S=pdD8RpWyJ3KVcQ@mail.gmail.com>
Message-ID: <CAL_JsqKAP5Up7=qJEM6E0HuV2-faaVqTg+S=pdD8RpWyJ3KVcQ@mail.gmail.com>
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

On Wed, Mar 10, 2021 at 10:12 AM Rob Herring <robh@kernel.org> wrote:
>
> On Wed, Mar 10, 2021 at 3:50 AM Nava kishore Manne <navam@xilinx.com> wrote:
> >
> > Hi Rob,
> >
> >         Thanks for providing the review comments.
> > Please find my response inline.
> >
> > > -----Original Message-----
> > > From: Rob Herring <robh@kernel.org>
> > > Sent: Tuesday, March 9, 2021 1:50 AM
> > > To: Nava kishore Manne <navam@xilinx.com>
> > > Cc: mdf@kernel.org; trix@redhat.com; Michal Simek <michals@xilinx.com>;
> > > gregkh@linuxfoundation.org; Jolly Shah <JOLLYS@xilinx.com>; Rajan Vaja
> > > <RAJANV@xilinx.com>; arnd@arndb.de; Manish Narani
> > > <MNARANI@xilinx.com>; Amit Sunil Dhamne <amitsuni@xilinx.com>; Tejas
> > > Patel <tejasp@xlnx.xilinx.com>; linux-fpga@vger.kernel.org;
> > > devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; linux-arm-
> > > kernel@lists.infradead.org; chinnikishore369@gmail.com; Appana Durga
> > > Kedareswara Rao <appanad@xilinx.com>
> > > Subject: Re: [PATCH v3 2/3] dt-bindings: fpga: Add binding doc for versal fpga
> > > manager
> > >
> > > On Thu, Mar 04, 2021 at 12:32:23PM +0530, Nava kishore Manne wrote:
> > > > From: Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
> > > >
> > > > This patch adds binding doc for versal fpga manager driver.
> > >
> > > Why do you need a DT entry for this? Can't the Versal firmware driver
> > > instantiate the fpga-mgr device?
> > >
> > This dt entry is need to handle the fpga regions properly for both full and Partial bitstream loading use cases and it cannot be done by Versal firmware driver instantiate.
>
> Ah yes, I forgot about that.

Looking at this some more, please convert xlnx,zynqmp-firmware.txt to
schema and add the node for this there. We don't need a whole other
schema file just for a node and compatible. Also, looks like
xlnx,zynqmp-pcap-fpga.txt is the prior version of the same thing, so
it should be handled in the schema too.

Rob
