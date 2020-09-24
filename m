Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8104C277461
	for <lists+linux-fpga@lfdr.de>; Thu, 24 Sep 2020 16:54:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728274AbgIXOyL (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 24 Sep 2020 10:54:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727859AbgIXOyL (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 24 Sep 2020 10:54:11 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 688EEC0613CE;
        Thu, 24 Sep 2020 07:54:11 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id a2so3362020otr.11;
        Thu, 24 Sep 2020 07:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AN04ZI3/fnyZPlEv/Hon+vuzpKMD4d8FN7QLN5Emzqo=;
        b=SsdFrQRB14hZj0kgjY0fCf4we4oTXJDB+lkNcJGOn12Hbna3LXXI1frb841MgSIfzm
         7se27U17y2iA2H4hyeFNnOGKoDKkVnPfcs6ropOYYFXZcPmB8QBbOT3Lbco5hQWgwzlD
         PGe8+ngiIeCq2bEaCtDYwkP6igZvKec31TlVwQ5XxGPw6Oe/sEMIoFv1IdPdOvrqI5m6
         cW5HA8VjiPtiDukUIBi4763le193N5Q7Z9sfNed4jgQj8hezplrxWNoRITGyyAlEMEsG
         ZCXPaVyPpKyFz9q66zzdfZWTSEG7xndj099BuLihXEmHRZPdRZV7GM/AUlVQygyDgkTW
         STvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AN04ZI3/fnyZPlEv/Hon+vuzpKMD4d8FN7QLN5Emzqo=;
        b=gXExDjfzVbwTBgY/EZhP4ZmrZOFJRxHbrsaWGsPEzaSAYo/2s/SMF2SbL1OsY/M2Cs
         ZstueNmkx+RZov+ccEPwsp7fy1LaoIUPeX4lKGe/yeuBVyKHMaJOd8kh8FcMPkBy/s60
         bscTnjpJMzhmIFSCP6zb6IKSAZKXN0SdJv6RmB68JYAFJ+LTvv5db7RLQvxDWG5mgS2i
         cgLtb155BKDk/c+pyfOL/hrJhNYrpZfB/PxsZIrvqkflYsC5ijC1PUT+e4aJDSF8XM1Y
         x1MFDXzHBiL8wft/OBMHHlsMlVvgrYXudGUxdxoi22zaaDUnL8Y/V+jP7ZCi7GzCS0+G
         gayg==
X-Gm-Message-State: AOAM530Vx1Es6Uj3Mw1DBpXbJdhbEjxBpH3WCOX1nOas8zk3OPN4l/Iw
        eDXkKV2kDz9HJQ31Y51hGMFlODEmTjGLMb3xnznomUaCcrqee1s/
X-Google-Smtp-Source: ABdhPJxc5PRt2xQ8XjuX6wuaCXgNyCMZ0I9s05pK6Xdx59CZri0Qrl5ywekA3HgFWyWeuvM2DvMiILRYEvASQOY5VDc=
X-Received: by 2002:a9d:7095:: with SMTP id l21mr36456otj.224.1600959250713;
 Thu, 24 Sep 2020 07:54:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200924065012.59605-1-alexandru.ardelean@analog.com>
 <20200924065012.59605-7-alexandru.ardelean@analog.com> <20200924142108.GA60306@archbook>
In-Reply-To: <20200924142108.GA60306@archbook>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Thu, 24 Sep 2020 17:53:59 +0300
Message-ID: <CA+U=Dsqujj=Mf6ES0zt+atEO835eRB+xV29X_68Ah1hTo-pysw@mail.gmail.com>
Subject: Re: [PATCH v3 6/6] clk: axi-clkgen: Add support for FPGA info
To:     Moritz Fischer <mdf@kernel.org>
Cc:     Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-clk@vger.kernel.org, linux-fpga@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Mircea Caprioru <mircea.caprioru@analog.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Thu, Sep 24, 2020 at 5:21 PM Moritz Fischer <mdf@kernel.org> wrote:
>
> On Thu, Sep 24, 2020 at 09:50:12AM +0300, Alexandru Ardelean wrote:
> > From: Mircea Caprioru <mircea.caprioru@analog.com>
> >
> > This patch adds support for vco maximum and minimum ranges in accordance
> > with fpga speed grade, voltage, device package, technology and family. This
> > new information is extracted from two new registers implemented in the ip
> > core: ADI_REG_FPGA_INFO and ADI_REG_FPGA_VOLTAGE, which are stored in the
> > 'include/linux/fpga/adi-axi-common.h' file as they are common to all ADI
> > FPGA cores.
> >
> > Signed-off-by: Mircea Caprioru <mircea.caprioru@analog.com>
> > Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> > ---
> >  drivers/clk/clk-axi-clkgen.c | 67 +++++++++++++++++++++++++++++++-----
> >  1 file changed, 59 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/clk/clk-axi-clkgen.c b/drivers/clk/clk-axi-clkgen.c
> > index 6ffc19e9d850..b03ea28270cb 100644
> > --- a/drivers/clk/clk-axi-clkgen.c
> > +++ b/drivers/clk/clk-axi-clkgen.c
> > @@ -8,6 +8,7 @@
> >
> >  #include <linux/platform_device.h>
> >  #include <linux/clk-provider.h>
> > +#include <linux/fpga/adi-axi-common.h>
> >  #include <linux/slab.h>
> >  #include <linux/io.h>
> >  #include <linux/of.h>
> > @@ -49,6 +50,7 @@
> >  struct axi_clkgen {
> >       void __iomem *base;
> >       struct clk_hw clk_hw;
> > +     unsigned int pcore_version;
> >  };
> >
> >  static uint32_t axi_clkgen_lookup_filter(unsigned int m)
> > @@ -101,15 +103,15 @@ static uint32_t axi_clkgen_lookup_lock(unsigned int m)
> >  }
> >
> >  #ifdef ARCH_ZYNQMP
> > -static const unsigned int fpfd_min = 10000;
> > -static const unsigned int fpfd_max = 450000;
> > -static const unsigned int fvco_min = 800000;
> > -static const unsigned int fvco_max = 1600000;
> > +static unsigned int fpfd_min = 10000;
> > +static unsigned int fpfd_max = 450000;
> > +static unsigned int fvco_min = 800000;
> > +static unsigned int fvco_max = 1600000;
> >  #else
> > -static const unsigned int fpfd_min = 10000;
> > -static const unsigned int fpfd_max = 300000;
> > -static const unsigned int fvco_min = 600000;
> > -static const unsigned int fvco_max = 1200000;
> > +static unsigned int fpfd_min = 10000;
> > +static unsigned int fpfd_max = 300000;
> > +static unsigned int fvco_min = 600000;
> > +static unsigned int fvco_max = 1200000;
> >  #endif
> Instead of modifying those wouldn't you want those to be part of your
> struct axi_clkgen? I understand that they're technically properties of the
> fabric you're implementing this IP block in, but are you sure you'll
> never have a system with more than one of those in two different FPGAs,
> are you never gonna use this beyond ARCH_ZYNQ/ZYNQMP/MICROBLAZE?
>
> What about a PCIe plugin card for a ZynqMP system with a Zynq on it?

That is a good point.
Will think about this, and re-implement it per axi_clkgen.
These FPGA can be combined in complex [sometimes weird] ways.

> >
> >  static void axi_clkgen_calc_params(unsigned long fin, unsigned long fout,
> > @@ -229,6 +231,49 @@ static void axi_clkgen_read(struct axi_clkgen *axi_clkgen,
> >       *val = readl(axi_clkgen->base + reg);
> >  }
> >
> > +static void axi_clkgen_setup_ranges(struct axi_clkgen *axi_clkgen)
> > +{
> > +     unsigned int reg_value;
> > +     unsigned int tech, family, speed_grade, voltage;
> > +
> > +     axi_clkgen_read(axi_clkgen, ADI_AXI_REG_FPGA_INFO, &reg_value);
> > +     tech = ADI_AXI_INFO_FPGA_TECH(reg_value);
> > +     family = ADI_AXI_INFO_FPGA_FAMILY(reg_value);
> > +     speed_grade = ADI_AXI_INFO_FPGA_SPEED_GRADE(reg_value);
> > +
> > +     axi_clkgen_read(axi_clkgen, ADI_AXI_REG_FPGA_VOLTAGE, &reg_value);
> > +     voltage = ADI_AXI_INFO_FPGA_VOLTAGE(reg_value);
> > +
> > +     switch (speed_grade) {
> > +     case ADI_AXI_FPGA_SPEED_GRADE_XILINX_1 ... ADI_AXI_FPGA_SPEED_GRADE_XILINX_1LV:
> > +             fvco_max = 1200000;
> > +             fpfd_max = 450000;
> > +             break;
> > +     case ADI_AXI_FPGA_SPEED_GRADE_XILINX_2 ... ADI_AXI_FPGA_SPEED_GRADE_XILINX_2LV:
> > +             fvco_max = 1440000;
> > +             fpfd_max = 500000;
> > +             if ((family == ADI_AXI_FPGA_FAMILY_XILINX_KINTEX) |
> > +                 (family == ADI_AXI_FPGA_FAMILY_XILINX_ARTIX)) {
> > +                     if (voltage < 950) {
> > +                             fvco_max = 1200000;
> > +                             fpfd_max = 450000;
> > +                     }
> > +             }
> > +             break;
> > +     case ADI_AXI_FPGA_SPEED_GRADE_XILINX_3:
> > +             fvco_max = 1600000;
> > +             fpfd_max = 550000;
> > +             break;
> > +     default:
> > +             break;
> > +     };
> > +
> > +     if (tech == ADI_AXI_FPGA_TECH_XILINX_ULTRASCALE_PLUS) {
> > +             fvco_max = 1600000;
> > +             fvco_min = 800000;
> > +     }
> > +}
> > +
> >  static int axi_clkgen_wait_non_busy(struct axi_clkgen *axi_clkgen)
> >  {
> >       unsigned int timeout = 10000;
> > @@ -524,6 +569,12 @@ static int axi_clkgen_probe(struct platform_device *pdev)
> >       if (IS_ERR(axi_clkgen->base))
> >               return PTR_ERR(axi_clkgen->base);
> >
> > +     axi_clkgen_read(axi_clkgen, ADI_AXI_REG_VERSION,
> > +                     &axi_clkgen->pcore_version);
> > +
> > +     if (ADI_AXI_PCORE_VER_MAJOR(axi_clkgen->pcore_version) > 0x04)
> > +             axi_clkgen_setup_ranges(axi_clkgen);
> > +
> >       init.num_parents = of_clk_get_parent_count(pdev->dev.of_node);
> >       if (init.num_parents < 1 || init.num_parents > 2)
> >               return -EINVAL;
> > --
> > 2.25.1
> >
> Thanks,
> Moritz
