Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED51527FB8E
	for <lists+linux-fpga@lfdr.de>; Thu,  1 Oct 2020 10:37:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725894AbgJAIhU (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 1 Oct 2020 04:37:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbgJAIhT (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 1 Oct 2020 04:37:19 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A92DC0613D0;
        Thu,  1 Oct 2020 01:37:18 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id w16so4760114oia.2;
        Thu, 01 Oct 2020 01:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xbBHygX1heLxaYCjPMy1vAAXEmLYpFjFFAGMzRaL4bY=;
        b=kB33dhntTrVeTSLZKMCk7V8VzSzNzP4782HrVWDCHpN9O7Y5Xw+xw6oIKVd3L154YN
         W1Mz52yTtqXEexJsbLpwvHdt7qVnKHuK8ewLlR7dc9MD3AmOy3u3k7gmEdLy/bPOKgxD
         CwQQbScSwceFYBFLHqBbhx0OoxI77koA0jkEdMQXV/GY/8Zvm6+OANXgrfiiexKLuaP4
         6qtHh0se2eUP/K9l3mppuovT+d2DuXaowdLhSY0OQ0T9wyf08CWPdiRe1doPS7UZcFfv
         5+SyjCWnA0WYYijGgSVZGG6wuXBF6N1OTNxFSWsWGd8L/rpP9UsnYlr0Zt5S3kt6KjeF
         /IUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xbBHygX1heLxaYCjPMy1vAAXEmLYpFjFFAGMzRaL4bY=;
        b=jjj8k/dc7g/VEusMtT9d0cnD+EhmG20x+tTJGnj8qF1K4oNavEcbXHcbXnKxmD3k75
         HHGwdWF2xb21Bu6uQBk3k1U5RfsVq1ZlzmYwrfal7c7AMH9p7wREloTnKM1UQjmJ3dcZ
         0Fk4dw9o9V7xsNd3HOwPIh7PlbqDL5VGKrscXLZRsWRVpWroHpTuC6iqLjKYwjX5ZpEk
         udWDPkYnyXMOQcjbvG/eof4Of97jkklCJPXYIY1SM+l7QsLJnkL285ShOdNMHiQBP9ob
         7SbOkLoC2O1z8x31OGLfMCk4qZe+yJiBEsqbN58OtjdoMnImeuB+Ye9H0acBfCrGJyLt
         onyQ==
X-Gm-Message-State: AOAM533B8mh/3xHUyLMR8lrglDlO6Yitv7I9PxO1hJI+mjV+dw39H4gC
        e4whRomCaYDp5Bw097RFPwKxWOYyUldFvjTFcWs=
X-Google-Smtp-Source: ABdhPJxogPARhdU4vLoSxPtC0Zma5EsGdc7Z6TTd299cZt/1uLKT9J/Ll0mEHGnkf6nK35pYUQ/vCiGFVUwjDM5/GK0=
X-Received: by 2002:aca:44c6:: with SMTP id r189mr1258472oia.140.1601541437448;
 Thu, 01 Oct 2020 01:37:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200929144417.89816-1-alexandru.ardelean@analog.com>
 <20200929144417.89816-14-alexandru.ardelean@analog.com> <20200929153040.GA114067@archbook>
 <CA+U=DspZ8cZzDDJWdbS=RkLifJRr7sjwQ9-ytMWkCqpfoCX6=w@mail.gmail.com>
 <20200930171607.GA121420@archbook> <CA+U=DsruOC=uyDVDLz0HCO06_7AGfQEpD=YoYddf3S-3Gs3QiA@mail.gmail.com>
In-Reply-To: <CA+U=DsruOC=uyDVDLz0HCO06_7AGfQEpD=YoYddf3S-3Gs3QiA@mail.gmail.com>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Thu, 1 Oct 2020 11:37:06 +0300
Message-ID: <CA+U=DsruVL-TS4EXG2056-zvUji8QF8aXjH2SnxU_cH+MnB1rA@mail.gmail.com>
Subject: Re: [PATCH v4 5/7] clk: axi-clkgen: Respect ZYNQMP PFD/VCO frequency limits
To:     Moritz Fischer <mdf@kernel.org>
Cc:     Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-clk@vger.kernel.org, linux-fpga@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Thu, Oct 1, 2020 at 8:18 AM Alexandru Ardelean
<ardeleanalex@gmail.com> wrote:
>
> On Wed, Sep 30, 2020 at 8:16 PM Moritz Fischer <mdf@kernel.org> wrote:
> >
> > On Wed, Sep 30, 2020 at 08:22:23AM +0300, Alexandru Ardelean wrote:
> > > On Tue, Sep 29, 2020 at 6:30 PM Moritz Fischer <mdf@kernel.org> wrote:
> > > >
> > > > Hi Alexandru,
> > > >
> > > > On Tue, Sep 29, 2020 at 05:44:15PM +0300, Alexandru Ardelean wrote:
> > > > > From: Mathias Tausen <mta@gomspace.com>
> > > > >
> > > > > Since axi-clkgen is now supported on ZYNQMP, make sure the max/min
> > > > > frequencies of the PFD and VCO are respected.
> > > > >
> > > > > Signed-off-by: Mathias Tausen <mta@gomspace.com>
> > > > > Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> > > >
> > > > This patch still does not cover the PCIe Zynq plugged into ZynqMP linux
> > > > machine case.
> > > >
> > > > > ---
> > > > >  drivers/clk/clk-axi-clkgen.c | 9 +++++++++
> > > > >  1 file changed, 9 insertions(+)
> > > > >
> > > > > diff --git a/drivers/clk/clk-axi-clkgen.c b/drivers/clk/clk-axi-clkgen.c
> > > > > index 4342b7735590..2319bb1c5c08 100644
> > > > > --- a/drivers/clk/clk-axi-clkgen.c
> > > > > +++ b/drivers/clk/clk-axi-clkgen.c
> > > > > @@ -108,12 +108,21 @@ static uint32_t axi_clkgen_lookup_lock(unsigned int m)
> > > > >       return 0x1f1f00fa;
> > > > >  }
> > > > >
> > > > > +#ifdef ARCH_ZYNQMP
> > > > > +static const struct axi_clkgen_limits axi_clkgen_default_limits = {
> > > > > +     .fpfd_min = 10000,
> > > > > +     .fpfd_max = 450000,
> > > > > +     .fvco_min = 800000,
> > > > > +     .fvco_max = 1600000,
> > > > > +};
> > > > > +#else
> > > > >  static const struct axi_clkgen_limits axi_clkgen_default_limits = {
> > > > >       .fpfd_min = 10000,
> > > > >       .fpfd_max = 300000,
> > > > >       .fvco_min = 600000,
> > > > >       .fvco_max = 1200000,
> > > > >  };
> > > > > +#endif
> > > >
> > > > I still don't understand this. You have a way to determine which fabric
> > > > you are looking at with the FPGA info. Why not:
> > > >
> > > > [..] axi_clkgen_zynqmp_default_limits = {
> > > > };
> > > >
> > > > [..] axi_clkgen_default_limits = {
> > > > };
> > > >
> > > > Set them based on what you read back, i.e. determine which fabric you
> > > > are looking at *per clock gen* and use that info, rather than making a
> > > > compile time decision to support only one of them.
> > > >
> > > > Generally speaking #ifdef $ARCH should be a last resort solution.
> > >
> > > The support for reading back the fabric parameters is implemented in
> > > the AXI CLKGEN PCORE version starting with 5.0.a
> > > Links:
> > > https://github.com/analogdevicesinc/hdl/commits/master/library/common/up_clkgen.v
> > > https://github.com/analogdevicesinc/hdl/commit/66823682b63c1037abdc3fc1dd4d4e63d3cfbc1a
> > > https://github.com/analogdevicesinc/hdl/commit/7dcb2050c7946fab5ea5a273eda7c53ea7b969a6
> > >
> > > Before that version, these details aren't there, so the best you can
> > > do is assume compile-time ARCH defaults.
> >
> > This is a property of the instance and not of the driver. If you can't
> > query the hardware to figure out what you're looking at, but have
> > different behaviours, please use different compatible strings and make
> > the default limits platform data.
> >
> > Something like this:
> >
> > static const struct of_device_id axi_clkgen_ids[] = {
> >         {
> >                 .compatible = "foo-zynqmp",
> >                 .data = &zynqmp_default_limits,
> >         },
> >         {
> >                 .compatible = "bar-zynq",
> >                 .data = &zynq_default_limits,
> >         },
> >
> >         { },
> > };
> >
>
> oh, apologies for not thinking about this;
> i'll spin this up

at this point, i also need to do a device-tree binding conversion to yaml;
[which i finished just now];
so, this series has grown a bit more;

i'm thinking of splitting this series now;
i'll send the DT binding conversion first/separately;
then i'll re-send Lars' patches [for fractional dividers] separately;
they don't touch on this ZynqMP discussion;
after that, i'll resume on this part;

mind you: it's not that i am trying to avoid anyone [with this split],
but it will require Rob's review for the binding thing, and that adds
another speed to the review;
so, splitting things, will help with things going at each reviewer's rate;

>
> thanks
> Alex
>
> > And pull the info out in your probe function, then you can have both
> > configurations and select via device-tree.
> >
> > Thanks,
> > Moritz
