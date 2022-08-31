Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BB9C5A775C
	for <lists+linux-fpga@lfdr.de>; Wed, 31 Aug 2022 09:18:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231134AbiHaHQv (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 31 Aug 2022 03:16:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbiHaHQS (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 31 Aug 2022 03:16:18 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C77A54CAE
        for <linux-fpga@vger.kernel.org>; Wed, 31 Aug 2022 00:12:48 -0700 (PDT)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=irc.pengutronix.de)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <j.zink@pengutronix.de>)
        id 1oTHtx-0002yb-Qu; Wed, 31 Aug 2022 09:12:41 +0200
Message-ID: <94f0bdab9875ebf13b386135cd2d53b39f299d71.camel@pengutronix.de>
Subject: Re: [PATCH 01/16] dt-bindings: fpga: convert Lattice MachXO2 Slave
 binding to YAML
From:   Johannes Zink <j.zink@pengutronix.de>
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-fpga@vger.kernel.org,
        Moritz Fischer <mdf@kernel.org>, kernel@pengutronix.de,
        Xu Yilun <yilun.xu@intel.com>, Wu Hao <hao.wu@intel.com>
Date:   Wed, 31 Aug 2022 09:12:26 +0200
In-Reply-To: <20220830203055.GA2003370-robh@kernel.org>
References: <20220825141343.1375690-1-j.zink@pengutronix.de>
         <20220825141343.1375690-2-j.zink@pengutronix.de>
         <20220830203055.GA2003370-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: j.zink@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-fpga@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi Rob,

On Tue, 2022-08-30 at 15:30 -0500, Rob Herring wrote:
> On Thu, Aug 25, 2022 at 04:13:28PM +0200, Johannes Zink wrote:
> > This commit prepares adding additional properties to the machxo2-
> > slave
> > device. No functional changes.
> 
> Please use get_maintainers.pl so *all* the maintainers/lists get
> Cc'ed. 
> 

ok, will do that in the future.

> > 
> > Signed-off-by: Johannes Zink <j.zink@pengutronix.de>
> > ---
> >  .../bindings/fpga/lattice,machxo2-slave.yaml  | 46
> > +++++++++++++++++++
> >  .../bindings/fpga/lattice-machxo2-spi.txt     | 29 ------------
> >  2 files changed, 46 insertions(+), 29 deletions(-)
> >  create mode 100644
> > Documentation/devicetree/bindings/fpga/lattice,machxo2-slave.yaml
> >  delete mode 100644 Documentation/devicetree/bindings/fpga/lattice-
> > machxo2-spi.txt
> > 
> > diff --git
> > a/Documentation/devicetree/bindings/fpga/lattice,machxo2-slave.yaml
> > b/Documentation/devicetree/bindings/fpga/lattice,machxo2-slave.yaml
> > new file mode 100644
> > index 000000000000..d05acd6b0fc6
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/fpga/lattice,machxo2-
> > slave.yaml
> > @@ -0,0 +1,46 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id:  
> > http://devicetree.org/schemas/fpga/lattice,machxo2-slave.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Lattice MachXO2 Slave FPGA Manager Device Tree Bindings
> > +
> > +maintainers:
> > +  - Johannes Zink <j.zink@pengutronix.de>
> > +
> > +description: |
> > +  Device used for loading the bitstream of Lattice MachXO2 FPGAs.
> > The
> > +  programming sequence is described in FPGA-TN-02155 on  
> > www.latticesemi.com
> > +
> > +allOf:
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            const: lattice,machxo2-slave-spi
> > +    then:
> > +      $ref: /schemas/spi/spi-peripheral-props.yaml#
> 
> You don't need the 'if' because the schema is only applied if the 
> compatible matches.
> 
> Blank line needed here.

ack, will fix it in v2

Best regards
Johannes

> 
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - lattice,machxo2-slave-spi
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +
> > +unevaluatedProperties: false
> > +
> > +examples:
> > +  - |
> > +    spi0 {
> > +        #address-cells = <1>;
> > +        #size-cells = <0>;
> > +
> > +        fpga@0 {
> > +            compatible = "lattice,machxo2-slave-spi";
> > +            spi-max-frequency = <8000000>;
> > +            reg = <0>;
> > +        };
> > +    };
> > diff --git a/Documentation/devicetree/bindings/fpga/lattice-
> > machxo2-spi.txt b/Documentation/devicetree/bindings/fpga/lattice-
> > machxo2-spi.txt
> > deleted file mode 100644
> > index a8c362eb160c..000000000000
> > --- a/Documentation/devicetree/bindings/fpga/lattice-machxo2-
> > spi.txt
> > +++ /dev/null
> > @@ -1,29 +0,0 @@
> > -Lattice MachXO2 Slave SPI FPGA Manager
> > -
> > -Lattice MachXO2 FPGAs support a method of loading the bitstream
> > over
> > -'slave SPI' interface.
> > -
> > -See 'MachXO2ProgrammingandConfigurationUsageGuide.pdf' on  
> > www.latticesemi.com
> > -
> > -Required properties:
> > -- compatible: should contain "lattice,machxo2-slave-spi"
> > -- reg: spi chip select of the FPGA
> > -
> > -Example for full FPGA configuration:
> > -
> > -       fpga-region0 {
> > -               compatible = "fpga-region";
> > -               fpga-mgr = <&fpga_mgr_spi>;
> > -               #address-cells = <0x1>;
> > -               #size-cells = <0x1>;
> > -       };
> > -
> > -       spi1: spi@2000 {
> > -        ...
> > -
> > -               fpga_mgr_spi: fpga-mgr@0 {
> > -                       compatible = "lattice,machxo2-slave-spi";
> > -                       spi-max-frequency = <8000000>;
> > -                       reg = <0>;
> > -               };
> > -       };
> > -- 
> > 2.30.2
> > 
> > 
> 
> 

-- 
Pengutronix e.K.                | Johannes Zink                  |
Steuerwalder Str. 21            | https://www.pengutronix.de/    |
31137 Hildesheim, Germany       | Phone: +49-5121-206917-0       |
Amtsgericht Hildesheim, HRA 2686| Fax:   +49-5121-206917-5555    |

