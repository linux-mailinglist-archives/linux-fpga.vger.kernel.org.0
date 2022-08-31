Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C8785A7755
	for <lists+linux-fpga@lfdr.de>; Wed, 31 Aug 2022 09:15:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbiHaHNa (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 31 Aug 2022 03:13:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231190AbiHaHMP (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 31 Aug 2022 03:12:15 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 286BB8B993
        for <linux-fpga@vger.kernel.org>; Wed, 31 Aug 2022 00:10:44 -0700 (PDT)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=irc.pengutronix.de)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <j.zink@pengutronix.de>)
        id 1oTHrk-0002aZ-5A; Wed, 31 Aug 2022 09:10:24 +0200
Message-ID: <916071152279b3f0f494d6dcb992d72ec337c77f.camel@pengutronix.de>
Subject: Re: [PATCH 04/16] dt-bindings: fpga: machxo2-slave: add
 lattice,machxo2-slave-i2c compatible
From:   Johannes Zink <j.zink@pengutronix.de>
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-fpga@vger.kernel.org,
        Moritz Fischer <mdf@kernel.org>, kernel@pengutronix.de,
        Xu Yilun <yilun.xu@intel.com>, Wu Hao <hao.wu@intel.com>
Date:   Wed, 31 Aug 2022 09:10:08 +0200
In-Reply-To: <20220830204047.GA2021641-robh@kernel.org>
References: <20220825141343.1375690-1-j.zink@pengutronix.de>
         <20220825141343.1375690-5-j.zink@pengutronix.de>
         <20220830204047.GA2021641-robh@kernel.org>
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

On Tue, 2022-08-30 at 15:40 -0500, Rob Herring wrote:
> On Thu, Aug 25, 2022 at 04:13:31PM +0200, Johannes Zink wrote:
> > Lattice MachXO2 FPGAs allow reconfiguration over I2C as well as
> > over
> > SPI. Add the I2C option to the binding as well.
> > 
> > Signed-off-by: Johannes Zink <j.zink@pengutronix.de>
> > ---
> >  .../bindings/fpga/lattice,machxo2-slave.yaml         | 12
> > ++++++++++++
> >  1 file changed, 12 insertions(+)
> > 
> > diff --git
> > a/Documentation/devicetree/bindings/fpga/lattice,machxo2-slave.yaml
> > b/Documentation/devicetree/bindings/fpga/lattice,machxo2-slave.yaml
> > index 03dc134ec7b8..d48d92f27c92 100644
> > --- a/Documentation/devicetree/bindings/fpga/lattice,machxo2-
> > slave.yaml
> > +++ b/Documentation/devicetree/bindings/fpga/lattice,machxo2-
> > slave.yaml
> > @@ -21,10 +21,22 @@ allOf:
> >              const: lattice,machxo2-slave-spi
> >      then:
> >        $ref: /schemas/spi/spi-peripheral-props.yaml#
> 
> Okay, I guess you do need the if/then. Technically, you don't need it
> til this patch, but that's fine.
> 
> The allOf/if part should go after 'required' section though.

ack.
> 
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            const: lattice,machxo2-slave-i2c
> > +    then:
> > +      properties:
> > +        reg:
> > +          description: I2C address
> > +          maxItems: 1
> 
> 'reg' is needed in either case. The only conditional part is the 
> description which you don't need. So this can be dropped.

ack. I will revisit both for v2.

Best regards
Johannes
> 
> > +
> >  properties:
> >    compatible:
> >      enum:
> >        - lattice,machxo2-slave-spi
> > +      - lattice,machxo2-slave-i2c
> >  
> >    program-gpios:
> >      maxItems: 1
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

