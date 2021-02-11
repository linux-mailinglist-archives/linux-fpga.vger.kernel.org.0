Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17D263184EE
	for <lists+linux-fpga@lfdr.de>; Thu, 11 Feb 2021 06:33:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229451AbhBKFdD (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 11 Feb 2021 00:33:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbhBKFdB (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 11 Feb 2021 00:33:01 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B2B3C061574;
        Wed, 10 Feb 2021 21:32:21 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id f2so4516747ioq.2;
        Wed, 10 Feb 2021 21:32:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/bjxWyo8EHZChCtIGa6LfncRDoH9g7vkAZn+7FO1D1k=;
        b=N3wotLaa/M63+18wddRMT5RQK5r7dNU7CzM2rc1tv244oqqpYspfaapPTcJ1ikbDC4
         LAli2gwGvpWpgyWLxrpeLVqf4xV3gZACd8skC+aQWKAJ54cZNvclwBjUlMHnkwfIBlg/
         qwlQBQlZSuyohctqCDrlWdvQzQBADUJYAR0x/f2+Gn6G4jH2BtNM92u+W3enPowTHqp+
         Dzo9A4c8C7O6BsmjPBhYFDj2xyDmgU0GR5sxOGJkd/ik4k0/WM/YdtGi/6wzsh3GIe6P
         JZPS9/Vn0d9PMC387ZA4Mijvhu/oVynsYtKKQeSKxh2tLqS1cXazMuwxVpSLYqkW7yO5
         Nwmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/bjxWyo8EHZChCtIGa6LfncRDoH9g7vkAZn+7FO1D1k=;
        b=XbpicoP4+yDuCCaG4Rw0/AEpPGLfSpbIYcgyXJf7RISULTSmHVbxy/NpPTFDM805sz
         cm9rJkn6TVlCUXHMTWQgfoHWNFZYFeZe6iY5mSZ3jWNTaTdB+UeLOMHJMDNqcTzn6PjG
         iNbl2BUj8VTm+DEYisHBcSI0+TY7fLmRCgF0ZTiAcJhdTdvGyO0EQupzEVVHi1LOG3Y0
         NxechFFbpM2DafHF+Cw8mx6abJ31GFviwdPHrmIPmZ1nlrj+2fHFPBg2kWDX+Kf5smm6
         iI93rIab2rcAwyM6Tf/mNFcy+XTQ1wpvfNEi5DCot44w5j2Ejl67vepcRKToqRVbk0XR
         ZWvQ==
X-Gm-Message-State: AOAM533TKCCX9afaDzAeqgyRFsYHnxM87MhRGR0BK+XTAtXtgUiwdM1o
        7dG5S5DDGul6lNDF3XpAkjyziDiH2cVRVYsU6oqQHMDh0QHoyA==
X-Google-Smtp-Source: ABdhPJyw8DbXMjYDf+mX26hs3wzHYaAOrqDQQKzg02MV+xQLowswFSkaEWhU8MMpKhV4NqEACkrebsp12DOfNYG8pyE=
X-Received: by 2002:a6b:4003:: with SMTP id k3mr3916301ioa.105.1613021540531;
 Wed, 10 Feb 2021 21:32:20 -0800 (PST)
MIME-Version: 1.0
References: <20210210101535.47979-1-alexandru.ardelean@analog.com> <YCSryh6kOhA+0xHc@epycbox.lan>
In-Reply-To: <YCSryh6kOhA+0xHc@epycbox.lan>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Thu, 11 Feb 2021 07:32:09 +0200
Message-ID: <CA+U=Dso5uCyjd8v1Xo5iWsUacchfbtuR+6NMgivEAv9TZNezcA@mail.gmail.com>
Subject: Re: [PATCH 1/2] include: fpga: adi-axi-common.h: add definitions for
 supported FPGAs
To:     Moritz Fischer <mdf@kernel.org>
Cc:     Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-clk@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-fpga@vger.kernel.org,
        Mircea Caprioru <mircea.caprioru@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Thu, Feb 11, 2021 at 6:00 AM Moritz Fischer <mdf@kernel.org> wrote:
>
> Alexandru,
>
> On Wed, Feb 10, 2021 at 12:15:34PM +0200, Alexandru Ardelean wrote:
> > From: Mircea Caprioru <mircea.caprioru@analog.com>
> >
> > All (newer) FPGA IP cores supported by Analog Devices, store informatio=
n in
>
> Nit: extra ',' ?
> > the synthesized designs. This information describes various parameters,
> > including the family of boards on which this is deployed, speed-grade, =
and
> > so on.
> >
> > Currently, some of these definitions are deployed mostly on Xilinx boar=
ds,
> > but they have been considered also for FPGA boards from other vendors.
> Let's add them together with the code that uses them.
> >
> > The register definitions are described at this link:
> >   https://wiki.analog.com/resources/fpga/docs/hdl/regmap
> > (the 'Base (common to all cores)' section).
> >
> > Acked-by: Moritz Fischer <mdf@kernel.org>
> This patchset is very different from the reviewed one earlier. Please
> don't just copy Acked-by's.

Apologies
I think it got some more reviews and I just kept the tag.
Sloppy on my part.

>
> > Signed-off-by: Mircea Caprioru <mircea.caprioru@analog.com>
> > Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> > ---
> >
> > This is a continuation of this old set:
> > https://lore.kernel.org/linux-clk/20200929144417.89816-1-alexandru.arde=
lean@analog.com/
> >
> > Particularly patches:
> >   https://lore.kernel.org/linux-clk/20200929144417.89816-15-alexandru.a=
rdelean@analog.com/
> >   https://lore.kernel.org/linux-clk/20200929144417.89816-16-alexandru.a=
rdelean@analog.com/
> >
> > That was v4, but this patchset was split away from it, to resolve
> > discussion on some other patches in that set.
> >
> > The other patches were accepted here:
> >   https://lore.kernel.org/linux-clk/20210201151245.21845-1-alexandru.ar=
delean@analog.com/
> >
> >  include/linux/fpga/adi-axi-common.h | 103 ++++++++++++++++++++++++++++
> >  1 file changed, 103 insertions(+)
> >
> > diff --git a/include/linux/fpga/adi-axi-common.h b/include/linux/fpga/a=
di-axi-common.h
> > index 141ac3f251e6..1a7f18e3a384 100644
> > --- a/include/linux/fpga/adi-axi-common.h
> > +++ b/include/linux/fpga/adi-axi-common.h
> > @@ -13,6 +13,9 @@
> >
> >  #define ADI_AXI_REG_VERSION                  0x0000
> >
> > +#define ADI_AXI_REG_FPGA_INFO                        0x001C
> > +#define ADI_AXI_REG_FPGA_VOLTAGE             0x0140
> > +
> >  #define ADI_AXI_PCORE_VER(major, minor, patch)       \
> >       (((major) << 16) | ((minor) << 8) | (patch))
> >
> > @@ -20,4 +23,104 @@
> >  #define ADI_AXI_PCORE_VER_MINOR(version)     (((version) >> 8) & 0xff)
> >  #define ADI_AXI_PCORE_VER_PATCH(version)     ((version) & 0xff)
> >
> > +#define ADI_AXI_INFO_FPGA_VOLTAGE(val)               ((val) & 0xffff)
> > +
> > +#define ADI_AXI_INFO_FPGA_TECH(info)         (((info) >> 24) & 0xff)
> > +#define ADI_AXI_INFO_FPGA_FAMILY(info)               (((info) >> 16) &=
 0xff)
> > +#define ADI_AXI_INFO_FPGA_SPEED_GRADE(info)  (((info) >> 8) & 0xff)
> > +#define ADI_AXI_INFO_FPGA_DEV_PACKAGE(info)  ((info) & 0xff)
>
> Do we really need all the macros?

No.
I can trim them to a minimum.

> > +
> > +/**
> > + * FPGA Technology definitions
> > + */
> > +#define ADI_AXI_FPGA_TECH_XILINX_UNKNOWN             0
> > +#define ADI_AXI_FPGA_TECH_XILINS_SERIES7             1
> > +#define ADI_AXI_FPGA_TECH_XILINX_ULTRASCALE          2
> > +#define ADI_AXI_FPGA_TECH_XILINX_ULTRASCALE_PLUS     3
> > +
> > +#define ADI_AXI_FPGA_TECH_INTEL_UNKNOWN                      100
> > +#define ADI_AXI_FPGA_TECH_INTEL_CYCLONE_5            101
> > +#define ADI_AXI_FPGA_TECH_INTEL_CYCLONE_10           102
> > +#define ADI_AXI_FPGA_TECH_INTEL_ARRIA_10             103
> > +#define ADI_AXI_FPGA_TECH_INTEL_STRATIX_10           104
> > +
> > +/**
> > + * FPGA Family definitions
> > + */
> > +#define ADI_AXI_FPGA_FAMILY_UNKNOWN                  0
> > +
> > +#define ADI_AXI_FPGA_FAMILY_XILINX_ARTIX             1
> > +#define ADI_AXI_FPGA_FAMILY_XILINX_KINTEX            2
> > +#define ADI_AXI_FPGA_FAMILY_XILINX_VIRTEX            3
> > +#define ADI_AXI_FPGA_FAMILY_XILINX_ZYNQ                      4
> > +
> > +#define ADI_AXI_FPGA_FAMILY_INTEL_SX                 1
> > +#define ADI_AXI_FPGA_FAMILY_INTEL_GX                 2
> > +#define ADI_AXI_FPGA_FAMILY_INTEL_GT                 3
> > +#define ADI_AXI_FPGA_FAMILY_INTEL_GZ                 4
> > +
> > +/**
> > + * FPGA Speed-grade definitions
> > + */
> > +#define ADI_AXI_FPGA_SPEED_GRADE_UNKNOWN             0
> > +
> > +#define ADI_AXI_FPGA_SPEED_GRADE_XILINX_1            10
> > +#define ADI_AXI_FPGA_SPEED_GRADE_XILINX_1L           11
> > +#define ADI_AXI_FPGA_SPEED_GRADE_XILINX_1H           12
> > +#define ADI_AXI_FPGA_SPEED_GRADE_XILINX_1HV          13
> > +#define ADI_AXI_FPGA_SPEED_GRADE_XILINX_1LV          14
> > +#define ADI_AXI_FPGA_SPEED_GRADE_XILINX_2            20
> > +#define ADI_AXI_FPGA_SPEED_GRADE_XILINX_2L           21
> > +#define ADI_AXI_FPGA_SPEED_GRADE_XILINX_2LV          22
> > +#define ADI_AXI_FPGA_SPEED_GRADE_XILINX_3            30
> > +
> > +#define ADI_AXI_FPGA_SPEED_GRADE_INTEL_1             1
> > +#define ADI_AXI_FPGA_SPEED_GRADE_INTEL_2             2
> > +#define ADI_AXI_FPGA_SPEED_GRADE_INTEL_3             3
> > +#define ADI_AXI_FPGA_SPEED_GRADE_INTEL_4             4
> > +#define ADI_AXI_FPGA_SPEED_GRADE_INTEL_5             5
> > +#define ADI_AXI_FPGA_SPEED_GRADE_INTEL_6             6
> > +#define ADI_AXI_FPGA_SPEED_GRADE_INTEL_7             7
> > +#define ADI_AXI_FPGA_SPEED_GRADE_INTEL_8             8
> > +#define ADI_AXI_FPGA_SPEED_GRADE_INTEL_9             9
> > +
> > +/**
> > + * FPGA Device Package definitions
> > + */
> > +#define ADI_AXI_FPGA_DEV_PACKAGE_UNKNOWN             0
> > +
> > +#define ADI_AXI_FPGA_DEV_PACKAGE_XILINX_RF           1
> > +#define ADI_AXI_FPGA_DEV_PACKAGE_XILINX_FL           2
> > +#define ADI_AXI_FPGA_DEV_PACKAGE_XILINX_FF           3
> > +#define ADI_AXI_FPGA_DEV_PACKAGE_XILINX_FB           4
> > +#define ADI_AXI_FPGA_DEV_PACKAGE_XILINX_HC           5
> > +#define ADI_AXI_FPGA_DEV_PACKAGE_XILINX_FH           6
> > +#define ADI_AXI_FPGA_DEV_PACKAGE_XILINX_CS           7
> > +#define ADI_AXI_FPGA_DEV_PACKAGE_XILINX_CP           8
> > +#define ADI_AXI_FPGA_DEV_PACKAGE_XILINX_FT           9
> > +#define ADI_AXI_FPGA_DEV_PACKAGE_XILINX_FG           10
> > +#define ADI_AXI_FPGA_DEV_PACKAGE_XILINX_SB           11
> > +#define ADI_AXI_FPGA_DEV_PACKAGE_XILINX_RB           12
> > +#define ADI_AXI_FPGA_DEV_PACKAGE_XILINX_RS           13
> > +#define ADI_AXI_FPGA_DEV_PACKAGE_XILINX_CL           14
> > +#define ADI_AXI_FPGA_DEV_PACKAGE_XILINX_SF           15
> > +#define ADI_AXI_FPGA_DEV_PACKAGE_XILINX_BA           16
> > +#define ADI_AXI_FPGA_DEV_PACKAGE_XILINX_FA           17
> > +#define ADI_AXI_FPGA_DEV_PACKAGE_XILINX_FS           18
> > +#define ADI_AXI_FPGA_DEV_PACKAGE_XILINX_FI           19
> > +
> > +#define ADI_AXI_FPGA_DEV_PACKAGE_INTEL_BGA           1
> > +#define ADI_AXI_FPGA_DEV_PACKAGE_INTEL_PGA           2
> > +#define ADI_AXI_FPGA_DEV_PACKAGE_INTEL_FBGA          3
> > +#define ADI_AXI_FPGA_DEV_PACKAGE_INTEL_HBGA          4
> > +#define ADI_AXI_FPGA_DEV_PACKAGE_INTEL_PDIP          5
> > +#define ADI_AXI_FPGA_DEV_PACKAGE_INTEL_EQFP          6
> > +#define ADI_AXI_FPGA_DEV_PACKAGE_INTEL_PLCC          7
> > +#define ADI_AXI_FPGA_DEV_PACKAGE_INTEL_PQFP          8
> > +#define ADI_AXI_FPGA_DEV_PACKAGE_INTEL_RQFP          9
> > +#define ADI_AXI_FPGA_DEV_PACKAGE_INTEL_TQFP          10
> > +#define ADI_AXI_FPGA_DEV_PACKAGE_INTEL_UBGA          11
> > +#define ADI_AXI_FPGA_DEV_PACKAGE_INTEL_UFBGA         12
> > +#define ADI_AXI_FPGA_DEV_PACKAGE_INTEL_MBGA          13
>
> What is using those? Do these package impact anything behavioral?

So, these should get defined in ADI FPGA projects.
The initial idea was to be able to read this in drivers and adjust
behavior (usually speed) according to each parameter.
Then some drivers could have used this to do some tunings.
Maybe also pass these in userspace and have the application decide.
I don't think there was some finalization on the idea (yet).

[I know how this sounds, but] The more I try to explain it, the less I
get convinced by this patch.
I pick up some of the patches in our tree and try to make sense of
them through upstreaming.
Sometimes when I pick them, it's not always obvious to me whether
they're worth it or not.
=C2=AF\_(=E3=83=84)_/=C2=AF


> > +
> >  #endif /* ADI_AXI_COMMON_H_ */
> > --
> > 2.17.1
> >
>
> - Moritz
>
> PS: The subject line could use a bit of work, too :)

Will think about it :)
