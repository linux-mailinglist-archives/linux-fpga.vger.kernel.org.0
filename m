Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EB8C5A7710
	for <lists+linux-fpga@lfdr.de>; Wed, 31 Aug 2022 09:09:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230419AbiHaHHo (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 31 Aug 2022 03:07:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230447AbiHaHHe (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 31 Aug 2022 03:07:34 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D350B24B8
        for <linux-fpga@vger.kernel.org>; Wed, 31 Aug 2022 00:07:33 -0700 (PDT)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=irc.pengutronix.de)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <j.zink@pengutronix.de>)
        id 1oTHot-0002Fy-Vm; Wed, 31 Aug 2022 09:07:28 +0200
Message-ID: <116168b9e870353d7f607e11f91e4dcc3650ef40.camel@pengutronix.de>
Subject: Re: [PATCH 02/16] dt-bindings: fpga: machxo2-slave: add erasure
 properties
From:   Johannes Zink <j.zink@pengutronix.de>
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-fpga@vger.kernel.org,
        Moritz Fischer <mdf@kernel.org>, kernel@pengutronix.de,
        Xu Yilun <yilun.xu@intel.com>, Wu Hao <hao.wu@intel.com>
Date:   Wed, 31 Aug 2022 09:07:11 +0200
In-Reply-To: <20220830203642.GA2011859-robh@kernel.org>
References: <20220825141343.1375690-1-j.zink@pengutronix.de>
         <20220825141343.1375690-3-j.zink@pengutronix.de>
         <20220830203642.GA2011859-robh@kernel.org>
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

On Tue, 2022-08-30 at 15:36 -0500, Rob Herring wrote:
> On Thu, Aug 25, 2022 at 04:13:29PM +0200, Johannes Zink wrote:
> > This patch introduces additional memory areas of the machxo2-slave
> > fpga
> > to be erased.
> 
> Why?
> 

Depending on the bitstream loaded to the FPGA, parts of the Flash
Memory or SRAM can hold configuration data which is non-volatile over
erase cycles. With this property, the board integrator, who knows about
the fpga design, can decide whether these areas shall be erased on
update or not. As an example, think of MAC addresses for a softcore
network interface stored in UFM (user flash memory), the board
integrator might want to decide to protect this memory area over
reflashing the fpga.

> > 
> > Signed-off-by: Johannes Zink <j.zink@pengutronix.de>
> > ---
> >  .../bindings/fpga/lattice,machxo2-slave.yaml      | 15
> > +++++++++++++++
> >  1 file changed, 15 insertions(+)
> > 
> > diff --git
> > a/Documentation/devicetree/bindings/fpga/lattice,machxo2-slave.yaml
> > b/Documentation/devicetree/bindings/fpga/lattice,machxo2-slave.yaml
> > index d05acd6b0fc6..78f0da8f772f 100644
> > --- a/Documentation/devicetree/bindings/fpga/lattice,machxo2-
> > slave.yaml
> > +++ b/Documentation/devicetree/bindings/fpga/lattice,machxo2-
> > slave.yaml
> > @@ -26,6 +26,19 @@ properties:
> >      enum:
> >        - lattice,machxo2-slave-spi
> >  
> > +  lattice,erase-sram:
> > +    type: boolean
> > +    description: SRAM is to be erased during flash erase operation
> > +
> > +  lattice,erase-feature-row:
> > +    type: boolean
> > +    description: Feature row is to be erased during flash erase
> > operation
> > +
> > +  lattice,erase-userflash:
> > +    type: boolean
> > +    description: |
> > +      UFM (user flash memory) is to be erased during flash erase
> > operation
> 
> These seem like policy. It this something that's really static to a 
> particular board rather than something the user would configure each 
> time.

From the usecases I can think of, for a given board with a given FPGA
design this is static. 

Best regards
Johannes

> 
> Rob
> 
> 

-- 
Pengutronix e.K.                | Johannes Zink                  |
Steuerwalder Str. 21            | https://www.pengutronix.de/    |
31137 Hildesheim, Germany       | Phone: +49-5121-206917-0       |
Amtsgericht Hildesheim, HRA 2686| Fax:   +49-5121-206917-5555    |

