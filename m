Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 602215A7894
	for <lists+linux-fpga@lfdr.de>; Wed, 31 Aug 2022 10:10:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231177AbiHaIIw (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 31 Aug 2022 04:08:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230323AbiHaIIu (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 31 Aug 2022 04:08:50 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A7BFC579D
        for <linux-fpga@vger.kernel.org>; Wed, 31 Aug 2022 01:08:47 -0700 (PDT)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=irc.pengutronix.de)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <j.zink@pengutronix.de>)
        id 1oTImE-0003kh-BA; Wed, 31 Aug 2022 10:08:46 +0200
Message-ID: <597f3d2b7d2b236aa118d283c4d23ba2bd577466.camel@pengutronix.de>
Subject: Re: [PATCH 03/16] dt-bindings: fpga: machxo2-slave: add pin for
 program sequence init
From:   Johannes Zink <j.zink@pengutronix.de>
To:     Xu Yilun <yilun.xu@intel.com>
Cc:     linux-fpga@vger.kernel.org
Date:   Wed, 31 Aug 2022 10:08:31 +0200
In-Reply-To: <6e253f526b51b854e857432dce185595e2540ace.camel@pengutronix.de>
References: <20220825141343.1375690-1-j.zink@pengutronix.de>
         <20220825141343.1375690-4-j.zink@pengutronix.de>
         <YwxukXtb5pJBKlq7@yilunxu-OptiPlex-7050>
         <a42d72cd71c96ca675f5bb0cf59128c7f1cb04bb.camel@pengutronix.de>
         <YwzZYM6GU0GiqBiq@yilunxu-OptiPlex-7050>
         <6e253f526b51b854e857432dce185595e2540ace.camel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: j.zink@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-fpga@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Wed, 2022-08-31 at 09:51 +0200, Johannes Zink wrote:
> Hi Yilun, 
> On Mon, 2022-08-29 at 23:21 +0800, Xu Yilun wrote:
> > On 2022-08-29 at 11:01:16 +0200, Johannes Zink wrote:
> > > On Mon, 2022-08-29 at 15:45 +0800, Xu Yilun wrote:
> > > > On 2022-08-25 at 16:13:30 +0200, Johannes Zink wrote:
> > > > > This commit adds a pin which initiates the FPGA programming
> > > > > sequence
> > > > > once pulsed low.
> > > > 
> > > > Why we don't have to use this pin before?
> > > > 
> > > > Thanks,
> > > > Yilun
> > > > 
> > > 
> > > According to the MachXO2 Programming and Configuration User Guide
> > > (FPGA-TN-02155-4.4) one of the 3 following methods can be used to
> > > enter
> > > the programming mode: 
> > > 
> > > - asserting a low pulse on the program gpio
> > > - cycling power to the MachXO2
> > > - sending the refresh command using a configuration port
> > > 
> > > In most cases, the refresh command being sent on initialization
> > > of
> > > the
> > > driver (as in the orignal driver) will do the job, but since you
> > > can
> > > deactivate the configuration ports, asserting the program gpio is
> > > the
> > > safe way to enter programming mode. Since the original driver did
> > > not
> > > support setting it, I added it as optional to the binding in
> > > order
> > > not
> > > to introduce any breakage. 
> > 
> > So do we need to skip the 3rd method if we already have the 2nd?
> > 
> > Thanks,
> > Yilun 
> 
> the datasheet suggests that the methods are not mutually exclusive,
> so
> doing both will not hurt. Since I want to keep backwards
> compatibility
> with the existing driver (which only supports the 3rd option: sending
> the refresh command), i'd rather not drop it in order not to
> introduce
> any breakage. 
> 

On a quick side note: Sending the refresh command is required in any
case, if using the "Slave SPI" mode (i.e. flashing the bitstream via
SPI) or the I2C mode. So according to the MachXO2 Programming and
Configuration Usage Guide, this is strictly non-optional.

Best regards
Johannes

> However, in my application I cannot power-cycle the FPGA (method 2)
> and
> the configuration port is disabled after in-factory initial
> programming
> via a security bit in the Feature Row Flash Area, which only leaves
> me
> with Method 1 (asserting a low pulse on the program_n pin of the
> FPGA)
> to enter programming mode for flashing another bitstream to the
> FPGA. 
> 
> This patch adds support for exactly this pin, while for other system
> setups both of the other methods will work just as they did before.
> 
> Best regards
> Johannes
> 
> > 
> > > 
> > > Best regards
> > > Johannes
> > > 
> > > > > 
> > > > > Signed-off-by: Johannes Zink <j.zink@pengutronix.de>
> > > > > ---
> > > > >  .../devicetree/bindings/fpga/lattice,machxo2-slave.yaml    |
> > > > > 7
> > > > > +++++++
> > > > >  1 file changed, 7 insertions(+)
> > > > > 
> > > > > diff --git
> > > > > a/Documentation/devicetree/bindings/fpga/lattice,machxo2-
> > > > > slave.yaml
> > > > > b/Documentation/devicetree/bindings/fpga/lattice,machxo2-
> > > > > slave.yaml
> > > > > index 78f0da8f772f..03dc134ec7b8 100644
> > > > > --- a/Documentation/devicetree/bindings/fpga/lattice,machxo2-
> > > > > slave.yaml
> > > > > +++ b/Documentation/devicetree/bindings/fpga/lattice,machxo2-
> > > > > slave.yaml
> > > > > @@ -26,6 +26,12 @@ properties:
> > > > >      enum:
> > > > >        - lattice,machxo2-slave-spi
> > > > >  
> > > > > +  program-gpios:
> > > > > +    maxItems: 1
> > > > > +    description: |
> > > > > +      GPIO Output tied to the FPGA's n_program pin to
> > > > > initiate
> > > > > a
> > > > > +      programming sequence. This pin is active low.
> > > > > +
> > > > >    lattice,erase-sram:
> > > > >      type: boolean
> > > > >      description: SRAM is to be erased during flash erase
> > > > > operation
> > > > > @@ -57,5 +63,6 @@ examples:
> > > > >              reg = <0>;
> > > > >              lattice,erase-sram;
> > > > >              lattice,erase-feature-row;
> > > > > +            lattice,program-gpios = <&gpio1 2
> > > > > GPIO_ACTIVE_LOW>
> > > > >          };
> > > > >      };
> > > > > -- 
> > > > > 2.30.2
> > > > > 
> > > > 
> > > 
> 

-- 
Pengutronix e.K.                | Johannes Zink                  |
Steuerwalder Str. 21            | https://www.pengutronix.de/    |
31137 Hildesheim, Germany       | Phone: +49-5121-206917-0       |
Amtsgericht Hildesheim, HRA 2686| Fax:   +49-5121-206917-5555    |

