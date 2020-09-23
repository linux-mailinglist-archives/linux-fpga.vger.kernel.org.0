Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2FE1275156
	for <lists+linux-fpga@lfdr.de>; Wed, 23 Sep 2020 08:22:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726615AbgIWGWp (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 23 Sep 2020 02:22:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbgIWGWp (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 23 Sep 2020 02:22:45 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86D8EC061755;
        Tue, 22 Sep 2020 23:22:45 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id m7so23899020oie.0;
        Tue, 22 Sep 2020 23:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y1PEerqJBDKeVBRTs0AFfG0uBufIRHhe7sa6qP1v9O8=;
        b=YS/aemuJmv/c98UY/vzAb87zvn86VHm7Ri3vNiPv8JzhSK8AaATSbok0ic2zQLyt+u
         kFkFnE+BNTgaLhipZnw2rZyCJ6QPbjCt6QX9vMSkksp3Oxe1YpEgKG7WCabf5I8QBC3+
         Th3BYcf+C4bgheq+FcoGXu7hDDZlOnf2QGQL0xQwPKlP6dYoM1neskoXuuibwd2LGG87
         P5OM0bx5UTVpukbmf5UQVnMPkP18gPGcpqpwK/3EmUtZJ/BgGgqEPIkNpibm2dABO2r7
         fV0WNcujZueluOJaLTFljW8JpGs8BDvAx7Gc/QPLA7McpJuFED0oWVusKZijXj45zi7B
         dXow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y1PEerqJBDKeVBRTs0AFfG0uBufIRHhe7sa6qP1v9O8=;
        b=AKEyNWeJu/Wq7HYcU5niGQZ3gfQWa5UeUlrJMZ/BEpzPwLtHUhCrv7TwvILx6KX5dN
         oH6VHNOOjwn8rB2+1nmXSFlpj6Ye00bfQerKDjwgYHGrHyQZwIPyx0HXcKQYIae1ygh1
         Wb4nvou/X1stG+N0UTvsSv5X+xx4kqzCp8PS8BIbkumCp4gzZjwxmayk2UsRXCbZrxV6
         ckogoM8ZJwkOmjeH6H5NPnJzJYsnsCpBpCTvR0Qodf5HSBu4EILGF3ZkughEd1og5JP8
         irhUK6cIbVCtQbBO7cQJOo/EhMEwEOTl7qzolrFxNdB4kzLUjC2sfu3RS6FNcS5SvJHT
         MVhA==
X-Gm-Message-State: AOAM530RTbrQ88f5jPlOli4sxIaJxVXVjE/a+kvO38Cc5QpVBA63a8Kn
        WBTO6BnXlajaXo5CPAInZHSZcQpTmQkAk7Zn8r0=
X-Google-Smtp-Source: ABdhPJzBfZX320BL45BvcOhOnTnM/7E23YnE6sTcmqXS2fzz6pc8bMuZV+vlMXfm2TGf+eV4hjTGE3sl2sdSX5C7fJ8=
X-Received: by 2002:aca:72ca:: with SMTP id p193mr4684049oic.124.1600842164940;
 Tue, 22 Sep 2020 23:22:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200810134252.68614-1-alexandru.ardelean@analog.com>
 <20200810134252.68614-8-alexandru.ardelean@analog.com> <CA+U=Dsr41kKGXmgE1KjdTzAso3rwtNXAEoSy+Li=uym7G=D=Jw@mail.gmail.com>
 <20200915024138.GA1827@epycbox.lan> <160080374459.310579.14438590389388419207@swboyd.mtv.corp.google.com>
In-Reply-To: <160080374459.310579.14438590389388419207@swboyd.mtv.corp.google.com>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Wed, 23 Sep 2020 09:22:33 +0300
Message-ID: <CA+U=DsrRo0t0Zit8ay5jytmCd5n=BcMHHbXpJMW90oAiur32+w@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] clk: axi-clk-gen: misc updates to the driver
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Moritz Fischer <mdf@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-clk@vger.kernel.org, linux-fpga@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Mircea Caprioru <mircea.caprioru@analog.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Tue, Sep 22, 2020 at 10:42 PM Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting Moritz Fischer (2020-09-14 19:41:38)
> > On Mon, Sep 14, 2020 at 11:11:05AM +0300, Alexandru Ardelean wrote:
> > > On Mon, Aug 10, 2020 at 4:41 PM Alexandru Ardelean
> > > <alexandru.ardelean@analog.com> wrote:
> > > >
> > > > These patches synchronize the driver with the current state in the
> > > > Analog Devices Linux tree:
> > > >   https://github.com/analogdevicesinc/linux/
> > > >
> > > > They have been in the tree for about 2-3, so they did receive some
> > > > testing.
> > >
> > > Ping on this series.
> > > Do I need to do a re-send?
>
> I got this patch series twice. Not sure why.

My fault here.
Some Ctrl + R usage and not being attentive with the arguments.
I think I added "*.patch" twice on the send-mail command.
I did something similar [by accident] for some DMA patches.
Apologies.

I can do a re-send for this, if it helps.

>
> >
> > I've applied the FPGA one, the other ones should go through the clock
> > tree I think?
>
> Doesn't patch 6 rely on the FPGA patch? How can that driver build
> without the header file?

Yes it does depend on the FPGA patch.
We can drop patch 6 for now, pending a merge to Linus' tree and then
wait for the trickle-down.
I don't mind waiting for these patches.
I have plenty of backlog that I want to run through, and cleanup and
then upstream.
So, there is no hurry.
