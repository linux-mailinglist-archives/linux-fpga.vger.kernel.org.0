Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96956578551
	for <lists+linux-fpga@lfdr.de>; Mon, 18 Jul 2022 16:26:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234991AbiGROZG (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 18 Jul 2022 10:25:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231416AbiGROZE (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 18 Jul 2022 10:25:04 -0400
Received: from mail.pr-group.ru (mail.pr-group.ru [178.18.215.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4893B487;
        Mon, 18 Jul 2022 07:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
        d=metrotek.ru; s=mail;
        h=from:subject:date:message-id:to:cc:mime-version:content-type:in-reply-to:
         references;
        bh=Rl8pC9UcnSTeUcI1LkcNsRHcFxoGaPb3eZk6TNA2rpI=;
        b=C1tF3RokzigG7wsUY2VEHj4B/CjylCnyXlCfLB3oq9uUulFrP1sIY5t0FgDfb2+6IMLXtRGbG2Z5b
         RB8RJsI9OA1DlRUUPr5hZS2DoFTaEMZQmXBwutyqHvMM/2TnFfLNZEcPKodbUnT+JGVoQfdM0vsbiO
         eOevfS3VWW9SADyfNkJZqyjDvAV9mLfG+UuZzXWFCQiLtqXOliAMw7UuK+Uh6OERKam7feVAPg10DY
         nS63bGAb52A7a3Hi91os81ExsEslpWQ81DsdISnf6lchWjpn8ZA6ASM2oPypxOnN3gANTXI6O0vbNc
         j7rABmGWKJ9Lg15ojsYt46pQq+GtUZQ==
X-Kerio-Anti-Spam:  Build: [Engines: 2.16.3.1424, Stamp: 3], Multi: [Enabled, t: (0.000008,0.012603)], BW: [Enabled, t: (0.000025,0.000002)], RTDA: [Enabled, t: (0.114981), Hit: No, Details: v2.40.0; Id: 15.52kbog.1g88r530o.3bqi8; mclb], total: 0(700)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Level: 
X-Footer: bWV0cm90ZWsucnU=
Received: from h-e2.ddg ([85.143.252.66])
        (authenticated user i.bornyakov@metrotek.ru)
        by mail.pr-group.ru with ESMTPSA
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits));
        Mon, 18 Jul 2022 17:24:48 +0300
Date:   Mon, 18 Jul 2022 17:24:27 +0300
From:   Ivan Bornyakov <i.bornyakov@metrotek.ru>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     mdf@kernel.org, hao.wu@intel.com, yilun.xu@intel.com,
        trix@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-fpga@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        system@metrotek.ru
Subject: Re: [PATCH v3 2/2] dt-bindings: fpga: add binding doc for ecp5-spi
 fpga mgr
Message-ID: <20220718142427.vhwswafw7sa5ec6v@h-e2.ddg>
References: <20220718114928.22092-1-i.bornyakov@metrotek.ru>
 <20220718114928.22092-3-i.bornyakov@metrotek.ru>
 <d15fcfa1-91ce-70fa-143f-748ead9a4337@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d15fcfa1-91ce-70fa-143f-748ead9a4337@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Mon, Jul 18, 2022 at 03:58:22PM +0200, Krzysztof Kozlowski wrote:
> On 18/07/2022 13:49, Ivan Bornyakov wrote:
> > Add Device Tree Binding doc for Lattice ECP5 FPGA manager using slave
> > SPI to load .bit formatted uncompressed bitstream image.
> > 
> > Signed-off-by: Ivan Bornyakov <i.bornyakov@metrotek.ru>
> > ---
> >  .../bindings/fpga/lattice,ecp5-fpga-mgr.yaml  | 73 +++++++++++++++++++
> >  1 file changed, 73 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/fpga/lattice,ecp5-fpga-mgr.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/fpga/lattice,ecp5-fpga-mgr.yaml b/Documentation/devicetree/bindings/fpga/lattice,ecp5-fpga-mgr.yaml
> > new file mode 100644
> > index 000000000000..bb10fd316f94
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/fpga/lattice,ecp5-fpga-mgr.yaml
> > @@ -0,0 +1,73 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/fpga/lattice,ecp5-fpga-mgr.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Lattice ECP5 Slave SPI FPGA manager.
> > +
> > +maintainers:
> > +  - Ivan Bornyakov <i.bornyakov@metrotek.ru>
> > +
> > +description:
> > +  FPGA Manager capable to program Lattice ECP5 with uncompressed bitstream
> > +  image in .bit format over SPI.
> 
> The same question as before - you need to explain what is the hardware
> (not Linux API or Linux subsystem).
> 

I really don't know what to say aside from "thing that capable to
program FPGA". Is there a good exmple of proper wording in
Documentation/devicetree/bindings/fpga/?
Otherwise I would ask FPGA Manager framework maintainers assistance on
how to describe a FPGA Manager driver.

> > +
> > +allOf:
> > +  - $ref: /schemas/spi/spi-peripheral-props.yaml
> > +
> > +properties:
> > +  reg:
> > +    maxItems: 1
> > +
> > +  spi-max-frequency:
> > +    maximum: 60000000
> > +
> > +  compatible:
> > +    enum:
> > +      - lattice,ecp5-fpga-mgr
> 
> Compatible goes first in the list of properties. Change here was not
> requested, so I am surprised to see different coding style.
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
> > +      Indicates that the FPGA is ready to be configured.
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
> > +        #address-cells = <1>;
> > +        #size-cells = <0>;
> > +
> > +        fpga-mgr@0 {
> > +            compatible = "lattice,ecp5-fpga-mgr";
> > +            spi-max-frequency = <20000000>;
> > +            reg = <0>;
> 
> compatible then reg, then rest of properties.
> 
> 
> 
> Best regards,
> Krzysztof

