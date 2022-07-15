Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F1B1575F1C
	for <lists+linux-fpga@lfdr.de>; Fri, 15 Jul 2022 12:07:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233892AbiGOKFO (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 15 Jul 2022 06:05:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230388AbiGOKFC (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 15 Jul 2022 06:05:02 -0400
Received: from mail.pr-group.ru (mail.pr-group.ru [178.18.215.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC41B26AE6;
        Fri, 15 Jul 2022 03:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
        d=metrotek.ru; s=mail;
        h=from:subject:date:message-id:to:cc:mime-version:content-type:in-reply-to:
         references;
        bh=16lJt+/F2KwxyLeIbmfKR6Rvu0CsLyTh4mYqwqLB9E8=;
        b=VirwO6UBdVu8IBKTFLo6bKeyXn27aluDDBYOeHMXQ9kCZWvHczOp/EktgRCrBUQ0wnzhCWr3W4jmf
         B3ZBu1uC2fXKPJsQnTJnfx3JAcgcLHUEt7Ck2FSicoi91PaNRX7E6PsxLTKrg1YoqUCnN+wlX/Bw7U
         PfW5/GVU5Kot57/DwThazQcp80xA9vPHmvNshi3aFzAVuFeN9ZTtDM6AjmrkEvfUu/muoigbf1OIUJ
         TeA7jE01zvqOeC6T133q0OkP7Jwq1lOi6DEUZlJCaartHgx9xwZNzM7xeuG7HnADPZ420s8T0Dojo0
         uOFkVFYws+bg2I54st6GB2gVZCTUJYQ==
X-Kerio-Anti-Spam:  Build: [Engines: 2.16.3.1424, Stamp: 3], Multi: [Enabled, t: (0.000009,0.014599)], BW: [Enabled, t: (0.000025,0.000002)], RTDA: [Enabled, t: (0.076283), Hit: No, Details: v2.40.0; Id: 15.52kail.1g80l1u67.1r2rc; mclb], total: 0(700)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Level: 
X-Footer: bWV0cm90ZWsucnU=
Received: from h-e2.ddg ([85.143.252.66])
        (authenticated user i.bornyakov@metrotek.ru)
        by mail.pr-group.ru with ESMTPSA
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits));
        Fri, 15 Jul 2022 13:04:15 +0300
Date:   Fri, 15 Jul 2022 13:03:56 +0300
From:   Ivan Bornyakov <i.bornyakov@metrotek.ru>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     mdf@kernel.org, hao.wu@intel.com, yilun.xu@intel.com,
        trix@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-fpga@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        system@metrotek.ru
Subject: Re: [PATCH 2/2] dt-bindings: fpga: add binding doc for ecp5-spi fpga
 mgr
Message-ID: <20220715100356.fwjomifweifn6zsr@h-e2.ddg>
References: <20220714122657.17972-1-i.bornyakov@metrotek.ru>
 <20220714122657.17972-3-i.bornyakov@metrotek.ru>
 <044a9736-a4ec-c250-7755-c80a5bcbe38b@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <044a9736-a4ec-c250-7755-c80a5bcbe38b@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Fri, Jul 15, 2022 at 11:33:54AM +0200, Krzysztof Kozlowski wrote:
> On 14/07/2022 14:26, Ivan Bornyakov wrote:
> > Add Device Tree Binding doc for Lattice ECP5 FPGA manager using slave
> > SPI to load .bit formatted uncompressed bitstream image.
> > 
> > Signed-off-by: Ivan Bornyakov <i.bornyakov@metrotek.ru>
> > ---
> >  .../fpga/lattice,ecp5-spi-fpga-mgr.yaml       | 71 +++++++++++++++++++
> >  1 file changed, 71 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/fpga/lattice,ecp5-spi-fpga-mgr.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/fpga/lattice,ecp5-spi-fpga-mgr.yaml b/Documentation/devicetree/bindings/fpga/lattice,ecp5-spi-fpga-mgr.yaml
> > new file mode 100644
> > index 000000000000..79868f9c84e2
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/fpga/lattice,ecp5-spi-fpga-mgr.yaml
> > @@ -0,0 +1,71 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/fpga/lattice,ecp5-spi-fpga-mgr.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Lattice ECP5 FPGA manager.
> > +
> > +maintainers:
> > +  - Ivan Bornyakov <i.bornyakov@metrotek.ru>
> > +
> > +description:
> > +  Device Tree Bindings for Lattice ECP5 FPGA Manager using slave SPI to
> > +  load the uncompressed bitstream in .bit format.
> 
> s/Device Tree Bindings for//
> 
> Instead describe the hardware you are adding bindings for. What is a
> "Manager"? It is so broad and unspecific... It is some dedicated
> hardware to communicate with FPGA or you just called this regular FPGA
> interface exposed to the CPU/SoC?
> 

"FPGA Manager" is a kernel subsystem that exports a set of functions for
programming an FPGA with a bitstream image.
See Documentation/driver-api/fpga/fpga-mgr.rst

> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - lattice,ecp5-spi-fpga-mgr
> 
> Do not encode interface name in compatible so no "spi".
> 

Recently when I submitted FPGA manager for Microchip PolarFire, I was
asked the opposite, to add "spi" in compatible. The reason was that FPGA
can be programmed through other interfaces as well.

> > +
> > +  reg:
> > +    description: SPI chip select
> > +    maxItems: 1
> > +
> > +  spi-max-frequency:
> > +    maximum: 60000000
> 
> Reference spi/spi-peripheral-props.yaml in allOf
> 
> > +
> > +  program-gpios:
> > +    description:
> > +      A GPIO line connected to PROGRAMN (active low) pin of the device.
> > +      Initiates configuration sequence.
> > +    maxItems: 1
> > +
> > +  init-gpios:
> > +    description:
> > +      A GPIO line connected to INITN (active low) pin of the device.
> > +      Indicates the FPGA is ready to be configured.
> > +    maxItems: 1
> > +
> > +  done-gpios:
> > +    description:
> > +      A GPIO line connected to DONE (active high) pin of the device.
> > +      Indicates that the configuration sequence is complete.
> > +    maxItems: 1
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - program-gpios
> > +  - init-gpios
> > +  - done-gpios
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/gpio/gpio.h>
> > +
> > +    spi {
> > +            #address-cells = <1>;
> 
> Wrong indentation. 4-spaces for DTS example.
> 
> > +            #size-cells = <0>;
> > +
> > +            fpga_mgr@0 {
> 
> No underscores in node names.
> 
> > +                    compatible = "lattice,ecp5-spi-fpga-mgr";
> > +                    spi-max-frequency = <20000000>;
> > +                    reg = <0>;
> > +                    program-gpios = <&gpio3 4 GPIO_ACTIVE_LOW>;
> > +                    init-gpios = <&gpio3 3 GPIO_ACTIVE_LOW>;
> > +                    done-gpios = <&gpio3 2 GPIO_ACTIVE_HIGH>;
> > +            };
> > +    };
> 
> 
> Best regards,
> Krzysztof

