Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6615327F900
	for <lists+linux-fpga@lfdr.de>; Thu,  1 Oct 2020 07:19:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725925AbgJAFTM (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 1 Oct 2020 01:19:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbgJAFTL (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 1 Oct 2020 01:19:11 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46878C061755;
        Wed, 30 Sep 2020 22:19:11 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id i17so4306012oig.10;
        Wed, 30 Sep 2020 22:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ie0a1UsGFIJaOJf2QVyq/RdJnac7pJAhnP5x4dXZ+FY=;
        b=lRzGIg/vjuj0z5H/xZuyllsEGhz6Dc5pOG0qiu1mWw8v7c2yTMVt460EkQM44uELtZ
         euaz518L279swNhIs9+5f8zG8HnUWPtMym0oKGjcA/58sO+gbWrCDZOtVLwIu4lT2a0m
         jc1koQ/jH6HbIaUZikiFhWzZJZbBtOHB50CDL9R/X+IkCPnGIwBZLgxe2zcBGjzD4IIf
         mKAdtD4aD/z2mebnpoUPeulC6/4Mkoi5rF3yS9SEQg1wBhEX/8qDHYmG5QqfY9qi4V/c
         AESUdShILoR5l+Ebz/YsJQ3y7pKSJnMbD0ItioYPrk0zLPB9ocpIrd+Ga0Ff8vj99Y7V
         TPoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ie0a1UsGFIJaOJf2QVyq/RdJnac7pJAhnP5x4dXZ+FY=;
        b=s/z2MGIvx4AYMgQxylpqGyjbdaIwqP3D/49K+UIeICSO2t9HAOGYg5fpndKaBZskpa
         31gMl3Ix/UTZHDPe05UsOffe7wXQbDLGALxzz0WExt4I57lF1oVxUGJ7iAPJGUY9jUZp
         yZFrOlyFqrY7kNG1NkP57l/wBVgiQ73w04iHhihXtzbWGAEQy1d9DNhshF1ZeYx1E+35
         JXVBf4vf5XAOhdOH1XUAgme6TtgGQhR/QoBQk2YptDEuOeimaeCaI4/ztuUksL8G2kwL
         zekuDOiE+ab3vpSjQVzrTIVcAyh/WcY9lewKpFS081CGMsL4MpCqS+FNhw8Enju14LiV
         eO1g==
X-Gm-Message-State: AOAM533Pd4hH9Xe06/O86K3tvSyhy0k3SrJ7hKznmVLwhInNpMybkZhL
        XtVBzJDdzjs+hW4iuOcHTSG9bt4rnN1VpsKenPU=
X-Google-Smtp-Source: ABdhPJw/Sdki71uLxb2bw6clzgDL96BFMgK0FrqBxSzkOUN28/mcwZ/BkgvQhPNNTpG2ydAFR0xyz0ovp5jwlcJPF5c=
X-Received: by 2002:aca:44c6:: with SMTP id r189mr942624oia.140.1601529550566;
 Wed, 30 Sep 2020 22:19:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200929144417.89816-1-alexandru.ardelean@analog.com>
 <20200929144417.89816-14-alexandru.ardelean@analog.com> <20200929153040.GA114067@archbook>
 <CA+U=DspZ8cZzDDJWdbS=RkLifJRr7sjwQ9-ytMWkCqpfoCX6=w@mail.gmail.com> <20200930171607.GA121420@archbook>
In-Reply-To: <20200930171607.GA121420@archbook>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Thu, 1 Oct 2020 08:18:59 +0300
Message-ID: <CA+U=DsruOC=uyDVDLz0HCO06_7AGfQEpD=YoYddf3S-3Gs3QiA@mail.gmail.com>
Subject: Re: [PATCH v4 5/7] clk: axi-clkgen: Respect ZYNQMP PFD/VCO frequency limits
To:     Moritz Fischer <mdf@kernel.org>
Cc:     Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-clk@vger.kernel.org, linux-fpga@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Mathias Tausen <mta@gomspace.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Wed, Sep 30, 2020 at 8:16 PM Moritz Fischer <mdf@kernel.org> wrote:
>
> On Wed, Sep 30, 2020 at 08:22:23AM +0300, Alexandru Ardelean wrote:
> > On Tue, Sep 29, 2020 at 6:30 PM Moritz Fischer <mdf@kernel.org> wrote:
> > >
> > > Hi Alexandru,
> > >
> > > On Tue, Sep 29, 2020 at 05:44:15PM +0300, Alexandru Ardelean wrote:
> > > > From: Mathias Tausen <mta@gomspace.com>
> > > >
> > > > Since axi-clkgen is now supported on ZYNQMP, make sure the max/min
> > > > frequencies of the PFD and VCO are respected.
> > > >
> > > > Signed-off-by: Mathias Tausen <mta@gomspace.com>
> > > > Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> > >
> > > This patch still does not cover the PCIe Zynq plugged into ZynqMP linux
> > > machine case.
> > >
> > > > ---
> > > >  drivers/clk/clk-axi-clkgen.c | 9 +++++++++
> > > >  1 file changed, 9 insertions(+)
> > > >
> > > > diff --git a/drivers/clk/clk-axi-clkgen.c b/drivers/clk/clk-axi-clkgen.c
> > > > index 4342b7735590..2319bb1c5c08 100644
> > > > --- a/drivers/clk/clk-axi-clkgen.c
> > > > +++ b/drivers/clk/clk-axi-clkgen.c
> > > > @@ -108,12 +108,21 @@ static uint32_t axi_clkgen_lookup_lock(unsigned int m)
> > > >       return 0x1f1f00fa;
> > > >  }
> > > >
> > > > +#ifdef ARCH_ZYNQMP
> > > > +static const struct axi_clkgen_limits axi_clkgen_default_limits = {
> > > > +     .fpfd_min = 10000,
> > > > +     .fpfd_max = 450000,
> > > > +     .fvco_min = 800000,
> > > > +     .fvco_max = 1600000,
> > > > +};
> > > > +#else
> > > >  static const struct axi_clkgen_limits axi_clkgen_default_limits = {
> > > >       .fpfd_min = 10000,
> > > >       .fpfd_max = 300000,
> > > >       .fvco_min = 600000,
> > > >       .fvco_max = 1200000,
> > > >  };
> > > > +#endif
> > >
> > > I still don't understand this. You have a way to determine which fabric
> > > you are looking at with the FPGA info. Why not:
> > >
> > > [..] axi_clkgen_zynqmp_default_limits = {
> > > };
> > >
> > > [..] axi_clkgen_default_limits = {
> > > };
> > >
> > > Set them based on what you read back, i.e. determine which fabric you
> > > are looking at *per clock gen* and use that info, rather than making a
> > > compile time decision to support only one of them.
> > >
> > > Generally speaking #ifdef $ARCH should be a last resort solution.
> >
> > The support for reading back the fabric parameters is implemented in
> > the AXI CLKGEN PCORE version starting with 5.0.a
> > Links:
> > https://github.com/analogdevicesinc/hdl/commits/master/library/common/up_clkgen.v
> > https://github.com/analogdevicesinc/hdl/commit/66823682b63c1037abdc3fc1dd4d4e63d3cfbc1a
> > https://github.com/analogdevicesinc/hdl/commit/7dcb2050c7946fab5ea5a273eda7c53ea7b969a6
> >
> > Before that version, these details aren't there, so the best you can
> > do is assume compile-time ARCH defaults.
>
> This is a property of the instance and not of the driver. If you can't
> query the hardware to figure out what you're looking at, but have
> different behaviours, please use different compatible strings and make
> the default limits platform data.
>
> Something like this:
>
> static const struct of_device_id axi_clkgen_ids[] = {
>         {
>                 .compatible = "foo-zynqmp",
>                 .data = &zynqmp_default_limits,
>         },
>         {
>                 .compatible = "bar-zynq",
>                 .data = &zynq_default_limits,
>         },
>
>         { },
> };
>

oh, apologies for not thinking about this;
i'll spin this up

thanks
Alex

> And pull the info out in your probe function, then you can have both
> configurations and select via device-tree.
>
> Thanks,
> Moritz
