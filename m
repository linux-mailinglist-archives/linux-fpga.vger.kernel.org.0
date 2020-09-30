Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1883327F00E
	for <lists+linux-fpga@lfdr.de>; Wed, 30 Sep 2020 19:16:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731428AbgI3RQL (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 30 Sep 2020 13:16:11 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:35699 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726574AbgI3RQK (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 30 Sep 2020 13:16:10 -0400
Received: by mail-pj1-f68.google.com with SMTP id jw11so145985pjb.0;
        Wed, 30 Sep 2020 10:16:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OGfKT1EdeRTBLMCIHN7iAx+JlnH5xpvcS0HZxF9GOsQ=;
        b=uMEhp22e234gCvLQz0NJEhFEq9bR4hVhqmb+qhQ0uvQh56RJaFzF5Aj1hayXv62+aP
         49s1yig7uE3uU/5yOG9nrcDGzQIN18hyGM3m+pBdU3zTvFf8JEDE84hKsVAy3vpoa2pa
         Ds/tnxbbNp+KbgosOv2eerRgIxc6f6eZO0gM+DDpRFj75QIV5dDj6gWYxM2DAK/BRqQA
         uChfah2/24P3jgebwdfFHuUL50rhM9TGTv01clLH5p4WspDhhGMXZ3SfdyagRonSora9
         a7JJ1ezXKKkgXYZHApk59FO7tiFgNiuSl8I79Pz95ExRn7i9/0klpiJhrI7+4P4Eeo93
         Fivw==
X-Gm-Message-State: AOAM5337b4ZZteOYC3JwROAHFkQGZB6EUSJmrIjlA/Mb3XbYMtAY+LSj
        +KZimj3nSZ6JtvNutz65w9ZvyEHbno8=
X-Google-Smtp-Source: ABdhPJwEuROhR3I5JOUYNFleBppzLex1izWU+bZnlnUSUKRMoA/k7aUAB+6w81q0vi0AR3xvfFJ+bQ==
X-Received: by 2002:a17:902:eb03:b029:d1:8c50:aafb with SMTP id l3-20020a170902eb03b02900d18c50aafbmr583117plb.29.1601486169726;
        Wed, 30 Sep 2020 10:16:09 -0700 (PDT)
Received: from localhost ([2601:647:5b00:1162:1ac0:17a6:4cc6:d1ef])
        by smtp.gmail.com with ESMTPSA id ih12sm2836512pjb.24.2020.09.30.10.16.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2020 10:16:09 -0700 (PDT)
Date:   Wed, 30 Sep 2020 10:16:07 -0700
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
Message-ID: <20200930171607.GA121420@archbook>
References: <20200929144417.89816-1-alexandru.ardelean@analog.com>
 <20200929144417.89816-14-alexandru.ardelean@analog.com>
 <20200929153040.GA114067@archbook>
 <CA+U=DspZ8cZzDDJWdbS=RkLifJRr7sjwQ9-ytMWkCqpfoCX6=w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+U=DspZ8cZzDDJWdbS=RkLifJRr7sjwQ9-ytMWkCqpfoCX6=w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Wed, Sep 30, 2020 at 08:22:23AM +0300, Alexandru Ardelean wrote:
> On Tue, Sep 29, 2020 at 6:30 PM Moritz Fischer <mdf@kernel.org> wrote:
> >
> > Hi Alexandru,
> >
> > On Tue, Sep 29, 2020 at 05:44:15PM +0300, Alexandru Ardelean wrote:
> > > From: Mathias Tausen <mta@gomspace.com>
> > >
> > > Since axi-clkgen is now supported on ZYNQMP, make sure the max/min
> > > frequencies of the PFD and VCO are respected.
> > >
> > > Signed-off-by: Mathias Tausen <mta@gomspace.com>
> > > Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> >
> > This patch still does not cover the PCIe Zynq plugged into ZynqMP linux
> > machine case.
> >
> > > ---
> > >  drivers/clk/clk-axi-clkgen.c | 9 +++++++++
> > >  1 file changed, 9 insertions(+)
> > >
> > > diff --git a/drivers/clk/clk-axi-clkgen.c b/drivers/clk/clk-axi-clkgen.c
> > > index 4342b7735590..2319bb1c5c08 100644
> > > --- a/drivers/clk/clk-axi-clkgen.c
> > > +++ b/drivers/clk/clk-axi-clkgen.c
> > > @@ -108,12 +108,21 @@ static uint32_t axi_clkgen_lookup_lock(unsigned int m)
> > >       return 0x1f1f00fa;
> > >  }
> > >
> > > +#ifdef ARCH_ZYNQMP
> > > +static const struct axi_clkgen_limits axi_clkgen_default_limits = {
> > > +     .fpfd_min = 10000,
> > > +     .fpfd_max = 450000,
> > > +     .fvco_min = 800000,
> > > +     .fvco_max = 1600000,
> > > +};
> > > +#else
> > >  static const struct axi_clkgen_limits axi_clkgen_default_limits = {
> > >       .fpfd_min = 10000,
> > >       .fpfd_max = 300000,
> > >       .fvco_min = 600000,
> > >       .fvco_max = 1200000,
> > >  };
> > > +#endif
> >
> > I still don't understand this. You have a way to determine which fabric
> > you are looking at with the FPGA info. Why not:
> >
> > [..] axi_clkgen_zynqmp_default_limits = {
> > };
> >
> > [..] axi_clkgen_default_limits = {
> > };
> >
> > Set them based on what you read back, i.e. determine which fabric you
> > are looking at *per clock gen* and use that info, rather than making a
> > compile time decision to support only one of them.
> >
> > Generally speaking #ifdef $ARCH should be a last resort solution.
> 
> The support for reading back the fabric parameters is implemented in
> the AXI CLKGEN PCORE version starting with 5.0.a
> Links:
> https://github.com/analogdevicesinc/hdl/commits/master/library/common/up_clkgen.v
> https://github.com/analogdevicesinc/hdl/commit/66823682b63c1037abdc3fc1dd4d4e63d3cfbc1a
> https://github.com/analogdevicesinc/hdl/commit/7dcb2050c7946fab5ea5a273eda7c53ea7b969a6
> 
> Before that version, these details aren't there, so the best you can
> do is assume compile-time ARCH defaults.

This is a property of the instance and not of the driver. If you can't
query the hardware to figure out what you're looking at, but have
different behaviours, please use different compatible strings and make
the default limits platform data.

Something like this:

static const struct of_device_id axi_clkgen_ids[] = {
	{
		.compatible = "foo-zynqmp",
		.data = &zynqmp_default_limits,
	},
	{
		.compatible = "bar-zynq",
		.data = &zynq_default_limits,
	},

	{ },
};

And pull the info out in your probe function, then you can have both
configurations and select via device-tree.

Thanks,
Moritz
