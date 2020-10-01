Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAEDA280788
	for <lists+linux-fpga@lfdr.de>; Thu,  1 Oct 2020 21:08:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729927AbgJATIz (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 1 Oct 2020 15:08:55 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:54661 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729418AbgJATIz (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 1 Oct 2020 15:08:55 -0400
Received: by mail-pj1-f67.google.com with SMTP id j19so2521096pjl.4;
        Thu, 01 Oct 2020 12:08:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/ZLkWSujX7jWnugEZQTqIhwyIUES1ySLBrdFnfFWe2Y=;
        b=RHr9uc/IUQKIQP6csQQ+b1rv/cTACiLcO8waNroP6RjIBfFkgE+IjxFCwVXCCFm5HR
         31C3MWpMMVhKYYH9myldwpOnk2cHyscGxWk5Dj/kDR5Wq0xsj9td/5Lw0W65H5z9GbSZ
         jVy3X6MUObjB6vehnQMMkDrQ0DSseIj7a6YFxUvQ1lNC+bOfnCB/YYYNoFsf0NVgbr0a
         ZACK5Al3bcmfXnGwkn31v/aEhfAnWsxy2xB0pCmarp2TeGAypKBa1c3afd4RMylt8Dxz
         gGmBN1bLqu9paubcGaKiO/+yyYh6rAor0DK03t+pC1eLU5K4OOM7PqwnKadMjKV2VrUa
         6jvg==
X-Gm-Message-State: AOAM530CUprg6wPcTa3dGfRuYYZGuDCd2D2EIt81djITgMX8k8Oq6I2h
        qZjkeVnzTKED7q6csGqUhpU=
X-Google-Smtp-Source: ABdhPJxzY2rHqgv6i+7QwwFXStNiGA11JiUI+CplH1qGeVnrhKi67tLaYkDY6T4NY9EIk0ce4/SyWA==
X-Received: by 2002:a17:90a:6b04:: with SMTP id v4mr1362413pjj.101.1601579334156;
        Thu, 01 Oct 2020 12:08:54 -0700 (PDT)
Received: from localhost ([2601:647:5b00:1162:1ac0:17a6:4cc6:d1ef])
        by smtp.gmail.com with ESMTPSA id i36sm6084425pgm.43.2020.10.01.12.08.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2020 12:08:53 -0700 (PDT)
Date:   Thu, 1 Oct 2020 12:08:52 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     Alexandru Ardelean <ardeleanalex@gmail.com>
Cc:     Moritz Fischer <mdf@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-clk@vger.kernel.org, linux-fpga@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Mathias Tausen <mta@gomspace.com>
Subject: Re: [PATCH v4 5/7] clk: axi-clkgen: Respect ZYNQMP PFD/VCO frequency
 limits
Message-ID: <20201001190852.GE121420@archbook>
References: <20200929144417.89816-1-alexandru.ardelean@analog.com>
 <20200929144417.89816-14-alexandru.ardelean@analog.com>
 <20200929153040.GA114067@archbook>
 <CA+U=DspZ8cZzDDJWdbS=RkLifJRr7sjwQ9-ytMWkCqpfoCX6=w@mail.gmail.com>
 <20200930171607.GA121420@archbook>
 <CA+U=DsruOC=uyDVDLz0HCO06_7AGfQEpD=YoYddf3S-3Gs3QiA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+U=DsruOC=uyDVDLz0HCO06_7AGfQEpD=YoYddf3S-3Gs3QiA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Thu, Oct 01, 2020 at 08:18:59AM +0300, Alexandru Ardelean wrote:
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

No worries :) 

Moritz
