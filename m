Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEF42276879
	for <lists+linux-fpga@lfdr.de>; Thu, 24 Sep 2020 07:41:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726837AbgIXFls (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 24 Sep 2020 01:41:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726683AbgIXFls (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 24 Sep 2020 01:41:48 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 769CAC0613CE;
        Wed, 23 Sep 2020 22:41:48 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id 185so2414488oie.11;
        Wed, 23 Sep 2020 22:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BqoX/qWwWn9TAGtuNC2Hh+7x/VKXLyD4Jf3sDc3Y86s=;
        b=QTmr1jjT/WwYzJXthPpU4hBlgutTF3Yidgj25xfvh5MeWlPlMIAAKbE5Wox6PRbTzD
         dzsGzU9vyjC937mGliSOQ6PtvaD1+P1xRTIs1xfpaaVGn5slefZQ+xyQFq1kFtSqWlRw
         gqF3AzvRYyieg4tlQ67D7qpxHN5QFVDIt64gnETIiXD5B/WuAsUE31hnWXggCUglTHvl
         Yws+HqYCicHqrbug7LxIZaqSDWot7POogewmqeiGNuode42HdHVB5PT6t5kYcdNe81xX
         cSIQy6ar/Qd40otaYqD7MAXXT8umy85t38JtUe1BkNtZsBktNPMOTPCqm/DDIkPL4oEw
         /UEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BqoX/qWwWn9TAGtuNC2Hh+7x/VKXLyD4Jf3sDc3Y86s=;
        b=tOhesUWDAOLpXbpzt7ciAesDmeScFxr3grVeUmx6L0irU/R2JX9+ee2X//e84uXwDm
         txPPkem84Et9rnle6nY9T0ms2/CP60Qp8MRhI9lKzcy6a+gO2h3gF9VEHUrCbqXg6j3+
         NcU1hDD3167PeYaP5GIL33DCHkMIIv5hfZNFLS5QcLkggbWvqNmPNCq6w1yrlKdYQPTZ
         b52ISyy8iLqdMvm6Tp7exMkZR3S6hUdlV+Q84DUaI6Hon3lixctgEvFG2NHNYICWDeCA
         YECirsARxv/6LDKe0HyNk9BtZ1dXB4goCNOH33TCPDkZhMlvm8IM1W6c54ZjAYunx9OQ
         HhpA==
X-Gm-Message-State: AOAM532mgDnOFCpfxhzffIah/IYxihQx16iMZBsddJTbj4JOqvFnjeqE
        TK/6RLkDYLh7s0J3OAPoTTinI21AmGShqtak0Xo=
X-Google-Smtp-Source: ABdhPJw97YNhY3K70Whn/AYEDGpriLraB3VqIsCpZxmt2xpG3bhQUx6dxht1Eore5lxBP06DC3pmKxu70V8WKD3vA9g=
X-Received: by 2002:aca:72ca:: with SMTP id p193mr1567487oic.124.1600926107739;
 Wed, 23 Sep 2020 22:41:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200810134252.68614-1-alexandru.ardelean@analog.com>
 <20200810134252.68614-8-alexandru.ardelean@analog.com> <CA+U=Dsr41kKGXmgE1KjdTzAso3rwtNXAEoSy+Li=uym7G=D=Jw@mail.gmail.com>
 <20200915024138.GA1827@epycbox.lan> <160080374459.310579.14438590389388419207@swboyd.mtv.corp.google.com>
 <CA+U=DsrRo0t0Zit8ay5jytmCd5n=BcMHHbXpJMW90oAiur32+w@mail.gmail.com>
 <160090551301.310579.3934488165908158116@swboyd.mtv.corp.google.com> <20200924045314.GA91389@epycbox.lan>
In-Reply-To: <20200924045314.GA91389@epycbox.lan>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Thu, 24 Sep 2020 08:41:36 +0300
Message-ID: <CA+U=DsrSE=NdAYP46vEfrOAqnr7EhNfrEE5DhG64XY5VsQGTnQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] clk: axi-clk-gen: misc updates to the driver
To:     Moritz Fischer <mdf@kernel.org>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-clk@vger.kernel.org, linux-fpga@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Mircea Caprioru <mircea.caprioru@analog.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Thu, Sep 24, 2020 at 7:53 AM Moritz Fischer <mdf@kernel.org> wrote:
>
> Hi Stephen,
>
> On Wed, Sep 23, 2020 at 04:58:33PM -0700, Stephen Boyd wrote:
> > Quoting Alexandru Ardelean (2020-09-22 23:22:33)
> > > On Tue, Sep 22, 2020 at 10:42 PM Stephen Boyd <sboyd@kernel.org> wrote:
> > > >
> > > > Quoting Moritz Fischer (2020-09-14 19:41:38)
> > > > > On Mon, Sep 14, 2020 at 11:11:05AM +0300, Alexandru Ardelean wrote:
> > > > > > On Mon, Aug 10, 2020 at 4:41 PM Alexandru Ardelean
> > > > > > <alexandru.ardelean@analog.com> wrote:
> > > > > > >
> > > > > > > These patches synchronize the driver with the current state in the
> > > > > > > Analog Devices Linux tree:
> > > > > > >   https://github.com/analogdevicesinc/linux/
> > > > > > >
> > > > > > > They have been in the tree for about 2-3, so they did receive some
> > > > > > > testing.
> > > > > >
> > > > > > Ping on this series.
> > > > > > Do I need to do a re-send?
> > > >
> > > > I got this patch series twice. Not sure why.
> > >
> > > My fault here.
> > > Some Ctrl + R usage and not being attentive with the arguments.
> > > I think I added "*.patch" twice on the send-mail command.
> > > I did something similar [by accident] for some DMA patches.
> > > Apologies.
> > >
> > > I can do a re-send for this, if it helps.
> >
> > Sure. Please resend it.
> >
> > >
> > > >
> > > > >
> > > > > I've applied the FPGA one, the other ones should go through the clock
> > > > > tree I think?
> > > >
> > > > Doesn't patch 6 rely on the FPGA patch? How can that driver build
> > > > without the header file?
> > >
> > > Yes it does depend on the FPGA patch.
> > > We can drop patch 6 for now, pending a merge to Linus' tree and then
> > > wait for the trickle-down.
> > > I don't mind waiting for these patches.
> > > I have plenty of backlog that I want to run through, and cleanup and
> > > then upstream.
> > > So, there is no hurry.
> >
> > Can you send me a signed tag with that patch? I can base this patch
> > series on top of that. Or I can just apply it to clk tree and if nobody
> > changes it in the meantime merge should work out in linux-next and
> > linus' tree upstream.
>
> Long story short I messed up my pull-request to Greg and had to back out
> the patch anyways. In retrospect I think the patch should have gone
> through your tree anyways, so here's our chance to get it right.
>
> Feel free to take it with the rest of the changes through your tree.
>
> Note: When I applied the patch I fixed up the whitespace that checkpatch
> complained about so you might want to do that (or ask Alexandru to
> resend the patch).
>

I'll fixup the checkpatch stuff, re-send as a V3, and add your Acked-by.
Thanks & apologies for the mess-up on my part.

> Acked-by: Moritz Fischer <mdf@kernel.org>
>
> Sorry for the confusion and let me know if you still prefer a signed
> tag.
>
> - Moritz
