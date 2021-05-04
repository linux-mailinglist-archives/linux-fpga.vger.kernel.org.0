Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45809372B34
	for <lists+linux-fpga@lfdr.de>; Tue,  4 May 2021 15:41:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231211AbhEDNmE (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 4 May 2021 09:42:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:33570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231135AbhEDNmE (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 4 May 2021 09:42:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1248F61104;
        Tue,  4 May 2021 13:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620135669;
        bh=6NQxigFZCG3D0Bdqa3fWl/CtpOg9R/63tRn5BmqTr6s=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jG2F57jnuDGin8c0ysTwknKtOX/8pepHd6TSZNC5cR0EjFmJ+rnD0pkpj8CRo+ysX
         QotAHYpWnbv5Bmh4d1cQi7L39wPC/GwcW43hRkWFCXXfvbWmD0E1yIYcpwsZUMOzZx
         m9ewOdSyBHxjCKBYFYL3DmQ1V7bnDa6fAkQj9SS7tVXyCCTk3D7u2Mhwmwwf/0Bu7X
         10QVTARjP79PjWKmhGQauW1rUu90v9k35m3UDbtPaeTknvAJVTQZ+YNXtBhEncMnM0
         836WVdTeHQbLN8l1vI3iQlG0q6+/Kg5HiEpAA9uwEo5iw8O/YT2f36gd2wl1nI0BsU
         12nhGoNYZ0lJA==
Received: by mail-ej1-f42.google.com with SMTP id w3so13242476ejc.4;
        Tue, 04 May 2021 06:41:08 -0700 (PDT)
X-Gm-Message-State: AOAM531X/+nPSmUU6S0HrQQvlw7daXS0UQdCn3FvMACOXSPJydquRTRI
        cwPX8yYHQJVqBzroVYg/sz2UgmJqrJLHjF1lQA==
X-Google-Smtp-Source: ABdhPJxLAXZvmGOw29/Rpo3WSY9VevUrrbOLtVQZw+0qd1wZp2UVLFpoNUUmCsB7AssQ1Dj5f9AiMQh4U0+WgXrDHTo=
X-Received: by 2002:a17:906:1984:: with SMTP id g4mr21472910ejd.525.1620135667544;
 Tue, 04 May 2021 06:41:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210429140408.23194-1-nava.manne@xilinx.com> <20210429140408.23194-2-nava.manne@xilinx.com>
 <20210430194000.GA3742101@robh.at.kernel.org> <MWHPR02MB262372B79B43EC798C06F491C25A9@MWHPR02MB2623.namprd02.prod.outlook.com>
In-Reply-To: <MWHPR02MB262372B79B43EC798C06F491C25A9@MWHPR02MB2623.namprd02.prod.outlook.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 4 May 2021 08:40:53 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+pVg-wZAccCVrfSeDygpb80Z28Ke9TOJxNPeyUMWvLdA@mail.gmail.com>
Message-ID: <CAL_Jsq+pVg-wZAccCVrfSeDygpb80Z28Ke9TOJxNPeyUMWvLdA@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] dt-bindings: firmware: Add bindings for xilinx firmware
To:     Nava kishore Manne <navam@xilinx.com>
Cc:     Michal Simek <michals@xilinx.com>,
        "mdf@kernel.org" <mdf@kernel.org>,
        "trix@redhat.com" <trix@redhat.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "arnd@arndb.de" <arnd@arndb.de>, Rajan Vaja <RAJANV@xilinx.com>,
        Amit Sunil Dhamne <amitsuni@xlnx.xilinx.com>,
        Manish Narani <MNARANI@xilinx.com>,
        "zou_wei@huawei.com" <zou_wei@huawei.com>,
        Sai Krishna Potthuri <lakshmis@xilinx.com>,
        "iwamatsu@nigauri.org" <iwamatsu@nigauri.org>,
        Jiaying Liang <jliang@xilinx.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "chinnikishore369@gmail.com" <chinnikishore369@gmail.com>,
        git <git@xilinx.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Tue, May 4, 2021 at 4:34 AM Nava kishore Manne <navam@xilinx.com> wrote:
>
> Hi Rob,
>
>         Please find my response inline.
>
> > -----Original Message-----
> > From: Rob Herring <robh@kernel.org>
> > Sent: Saturday, May 1, 2021 1:10 AM
> > To: Nava kishore Manne <navam@xilinx.com>
> > Cc: Michal Simek <michals@xilinx.com>; mdf@kernel.org; trix@redhat.com;
> > gregkh@linuxfoundation.org; arnd@arndb.de; Rajan Vaja
> > <RAJANV@xilinx.com>; Amit Sunil Dhamne <amitsuni@xlnx.xilinx.com>;
> > Manish Narani <MNARANI@xilinx.com>; zou_wei@huawei.com; Sai Krishna
> > Potthuri <lakshmis@xilinx.com>; iwamatsu@nigauri.org; Jiaying Liang
> > <jliang@xilinx.com>; linus.walleij@linaro.org; devicetree@vger.kernel.org;
> > linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org; linux-
> > fpga@vger.kernel.org; chinnikishore369@gmail.com; git <git@xilinx.com>
> > Subject: Re: [PATCH v4 1/4] dt-bindings: firmware: Add bindings for xilinx
> > firmware
> >
> > On Thu, Apr 29, 2021 at 07:34:05PM +0530, Nava kishore Manne wrote:
> > > Add documentation to describe Xilinx firmware driver bindings.
> > > Firmware driver provides an interface to firmware APIs.
> > > Interface APIs can be used by any driver to communicate to Platform
> > > Management Unit.
> > >
> > > Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
> > > ---
> > > Changes for v4:
> > >                 -Added new yaml file for xilinx firmware
> > >                  as suggested by Rob.
> > >
> > >  .../firmware/xilinx/xlnx,zynqmp-firmware.yaml | 63
> > > +++++++++++++++++++
> > >  1 file changed, 63 insertions(+)
> > >  create mode 100644
> > > Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-
> > firmware
> > > .yaml
> >
> > What about the old doc?:
> >
>
> As you suggested i have added only the fpga node relevant info here so it's not representing the complete firmware file with other sub node like clk, Aes, ...etc.
> Once it completely mature we can deprecate the Old doc.
>
> > Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-
> > firmware.txt
> >
> > >
> > > diff --git
> > > a/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-
> > firmwa
> > > re.yaml
> > > b/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-
> > firmwa
> > > re.yaml
> > > new file mode 100644
> > > index 000000000000..4b97f005bed7
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-fi
> > > +++ rmware.yaml
> > > @@ -0,0 +1,63 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) %YAML 1.2
> > > +---
> > > +$id:
> > > +http://devicetree.org/schemas/firmware/xilinx/xlnx,zynqmp-firmware.ya
> > > +ml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Xilinx firmware driver
> > > +
> > > +maintainers:
> > > +  - Nava kishore Manne <nava.manne@xilinx.com>
> > > +
> > > +description:
> > > +  The zynqmp-firmware node describes the interface to platform
> > firmware.
> > > +  ZynqMP has an interface to communicate with secure firmware.
> > > +Firmware
> > > +  driver provides an interface to firmware APIs. Interface APIs can
> > > +be
> > > +  used by any driver to communicate to PMUFW(Platform Management
> > Unit).
> > > +  These requests include clock management, pin control, device
> > > +control,
> > > +  power management service, FPGA service and other platform
> > > +management
> > > +  services.
> > > +
> > > +properties:
> > > +  compatible:
> > > +    oneOf:
> > > +      - description:
> > > +          For implementations complying for Zynq Ultrascale+ MPSoC.
> > > +        const: xlnx,zynqmp-firmware
> > > +
> > > +      - description:
> > > +          For implementations complying for Versal.
> > > +        const: xlnx,versal-firmware
> > > +
> > > +  method:
> > > +    description: The method of calling the PM-API firmware layer.
> > > +                #  Permitted values are:
> > > +                #  - "smc" : SMC #0, following the SMCCC
> > > +                #  - "hvc" : HVC #0, following the SMCCC
> >
> > Drop the '#'. If you want to maintain the formatting, then use '|' after
> > 'description:' for a literal block.
> >
>
> Will fix in v5.
>
> > > +    $ref: /schemas/types.yaml#/definitions/string-array
> > > +    enum:
> > > +      - smc
> > > +      - hvc
> > > +
> > > +patternProperties:
> > > +  "fpga":
> >
> > So 'foofpgabar' is valid?
> >
>
> Yes, it's a valid for fpga node.

No, please make the node name more specific.

Rob
