Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2D8F27E02F
	for <lists+linux-fpga@lfdr.de>; Wed, 30 Sep 2020 07:23:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727903AbgI3FWg (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 30 Sep 2020 01:22:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727886AbgI3FWf (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 30 Sep 2020 01:22:35 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B0DDC061755;
        Tue, 29 Sep 2020 22:22:35 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id m13so619906otl.9;
        Tue, 29 Sep 2020 22:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gXPEpCD36sORdHbXZaBk37GGY2DgwKqMqWNlWUiThV0=;
        b=MJa0DHcym7G8SLtVvKLUWyYzBKKXwal5ikzIWF8XcrY5tKOsoMaNDg/YQ6mHSz3zJS
         nvFw6D/l4LQgF3mYg1ZH1/kFianO8Byd8jpfK5Ua4H3ocHzyiiYXE/pwmaXrmnpfJkND
         ldWdw5SVZOfKq5fRMlIKP1l2sgbh5RnR0M02pEP94Fhnli9azdqKjbCpSgdpRJoYdBYI
         vTPCSFSnSuO59oFYjhecepEJZUdFD26jCVpvbeST6SItueppyKNxn0xKrDdHq0rnZdtN
         UvbD4KX+ijnZCAD9eoMuRBw6IEdUwzve3LNR0SVUJzopOiX/S/nM5hjg74WvxGOP3Pdl
         8+0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gXPEpCD36sORdHbXZaBk37GGY2DgwKqMqWNlWUiThV0=;
        b=PtPgJk81PKBnptNth/aV23KoGg4lzf4Js+gEQtzCd/L1VGGk5Qw4Ohum+c/KVvftnJ
         /PDtbmhUmAgAXBW+4uR4V3kj+1B55S44ZnAFvFHmJNTSxtJKHPynzPi6W6Bwk/sSQNrp
         wX8PViLK640KKgQ9VZ0j/bbH2FPxQNbUV8PQj+acDm1T1R8pf4R8vt9YFFrI/Wy6al0/
         d5I8O/QbZtmhgZtY5XQIHpVKAiEJ5RuIxsr0g/e4/ByK5KQsJIpDUF3/0Ln8Rch/4lG7
         a+ORKEuUufaGpb2txqGRUJSqTPFLAJWVWXJOJsZLRN8PfXtfcWmZaaowx6NwV+zZU82b
         Bf5A==
X-Gm-Message-State: AOAM5326FHfbuh8IF8KbSBHMtUEmQLVPR0ZGqGXngbdqCA2EcCYADq8W
        u7dVCSeGUQBZtfDF6jMIVYKeoPp7Cm+nyXLtZToll/M/4m0W9Q==
X-Google-Smtp-Source: ABdhPJwFekZ0Kpb6Lv1MevPdUo1YKW82lNzB0hjf/yn+1Rt8PvejB0HHsTEtV6yEmg+LJNN5QRAPY5AEZdMQ7SJmYIo=
X-Received: by 2002:a9d:7095:: with SMTP id l21mr514266otj.224.1601443354767;
 Tue, 29 Sep 2020 22:22:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200929144417.89816-1-alexandru.ardelean@analog.com>
 <20200929144417.89816-14-alexandru.ardelean@analog.com> <20200929153040.GA114067@archbook>
In-Reply-To: <20200929153040.GA114067@archbook>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Wed, 30 Sep 2020 08:22:23 +0300
Message-ID: <CA+U=DspZ8cZzDDJWdbS=RkLifJRr7sjwQ9-ytMWkCqpfoCX6=w@mail.gmail.com>
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

On Tue, Sep 29, 2020 at 6:30 PM Moritz Fischer <mdf@kernel.org> wrote:
>
> Hi Alexandru,
>
> On Tue, Sep 29, 2020 at 05:44:15PM +0300, Alexandru Ardelean wrote:
> > From: Mathias Tausen <mta@gomspace.com>
> >
> > Since axi-clkgen is now supported on ZYNQMP, make sure the max/min
> > frequencies of the PFD and VCO are respected.
> >
> > Signed-off-by: Mathias Tausen <mta@gomspace.com>
> > Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
>
> This patch still does not cover the PCIe Zynq plugged into ZynqMP linux
> machine case.
>
> > ---
> >  drivers/clk/clk-axi-clkgen.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >
> > diff --git a/drivers/clk/clk-axi-clkgen.c b/drivers/clk/clk-axi-clkgen.c
> > index 4342b7735590..2319bb1c5c08 100644
> > --- a/drivers/clk/clk-axi-clkgen.c
> > +++ b/drivers/clk/clk-axi-clkgen.c
> > @@ -108,12 +108,21 @@ static uint32_t axi_clkgen_lookup_lock(unsigned int m)
> >       return 0x1f1f00fa;
> >  }
> >
> > +#ifdef ARCH_ZYNQMP
> > +static const struct axi_clkgen_limits axi_clkgen_default_limits = {
> > +     .fpfd_min = 10000,
> > +     .fpfd_max = 450000,
> > +     .fvco_min = 800000,
> > +     .fvco_max = 1600000,
> > +};
> > +#else
> >  static const struct axi_clkgen_limits axi_clkgen_default_limits = {
> >       .fpfd_min = 10000,
> >       .fpfd_max = 300000,
> >       .fvco_min = 600000,
> >       .fvco_max = 1200000,
> >  };
> > +#endif
>
> I still don't understand this. You have a way to determine which fabric
> you are looking at with the FPGA info. Why not:
>
> [..] axi_clkgen_zynqmp_default_limits = {
> };
>
> [..] axi_clkgen_default_limits = {
> };
>
> Set them based on what you read back, i.e. determine which fabric you
> are looking at *per clock gen* and use that info, rather than making a
> compile time decision to support only one of them.
>
> Generally speaking #ifdef $ARCH should be a last resort solution.

The support for reading back the fabric parameters is implemented in
the AXI CLKGEN PCORE version starting with 5.0.a
Links:
https://github.com/analogdevicesinc/hdl/commits/master/library/common/up_clkgen.v
https://github.com/analogdevicesinc/hdl/commit/66823682b63c1037abdc3fc1dd4d4e63d3cfbc1a
https://github.com/analogdevicesinc/hdl/commit/7dcb2050c7946fab5ea5a273eda7c53ea7b969a6

Before that version, these details aren't there, so the best you can
do is assume compile-time ARCH defaults.

Looking at patch 7 [in this series], the axi_clkgen only updates these
defaults if the PCORE version is above version 4.x.x
https://lore.kernel.org/linux-clk/20200929144417.89816-16-alexandru.ardelean@analog.com/T/#u

Now, the question would be: do we still support PCORE versions before 5.0.a?
Depending on the answer to this question, I would be fine with the
proposed change here.

> >
> >  static void axi_clkgen_calc_params(const struct axi_clkgen_limits *limits,
> >       unsigned long fin, unsigned long fout,
> > --
> > 2.17.1
> >
>
> Cheers,
> Moritz
