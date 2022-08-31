Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7861A5A77AE
	for <lists+linux-fpga@lfdr.de>; Wed, 31 Aug 2022 09:40:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbiHaHiv (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 31 Aug 2022 03:38:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbiHaHiv (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 31 Aug 2022 03:38:51 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0D11BFC78
        for <linux-fpga@vger.kernel.org>; Wed, 31 Aug 2022 00:38:48 -0700 (PDT)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=irc.pengutronix.de)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <j.zink@pengutronix.de>)
        id 1oTIJD-0005uX-76; Wed, 31 Aug 2022 09:38:47 +0200
Message-ID: <c8e119bd0f3739ce771bedf417c2d98285319270.camel@pengutronix.de>
Subject: Re: [PATCH 02/16] dt-bindings: fpga: machxo2-slave: add erasure
 properties
From:   Johannes Zink <j.zink@pengutronix.de>
To:     Xu Yilun <yilun.xu@intel.com>
Cc:     linux-fpga@vger.kernel.org
Date:   Wed, 31 Aug 2022 09:38:31 +0200
In-Reply-To: <YwzWt8KjyfdyqehI@yilunxu-OptiPlex-7050>
References: <20220825141343.1375690-1-j.zink@pengutronix.de>
         <20220825141343.1375690-3-j.zink@pengutronix.de>
         <YwxtFjMILAlEF/uh@yilunxu-OptiPlex-7050>
         <9d5512768acb4d57f339942007402a9ed9483e84.camel@pengutronix.de>
         <YwzWt8KjyfdyqehI@yilunxu-OptiPlex-7050>
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

Hi Yilun, 

On Mon, 2022-08-29 at 23:09 +0800, Xu Yilun wrote:
> On 2022-08-29 at 10:41:42 +0200, Johannes Zink wrote:
> > On Mon, 2022-08-29 at 15:39 +0800, Xu Yilun wrote:
> > > On 2022-08-25 at 16:13:29 +0200, Johannes Zink wrote:
> > > > This patch introduces additional memory areas of the machxo2-
> > > > slave
> > > > fpga
> > > > to be erased.
> > > > 
> > > > Signed-off-by: Johannes Zink <j.zink@pengutronix.de>
> > > > ---
> > > >  .../bindings/fpga/lattice,machxo2-slave.yaml      | 15
> > > > +++++++++++++++
> > > >  1 file changed, 15 insertions(+)
> > > > 
> > > > diff --git
> > > > a/Documentation/devicetree/bindings/fpga/lattice,machxo2-
> > > > slave.yaml
> > > > b/Documentation/devicetree/bindings/fpga/lattice,machxo2-
> > > > slave.yaml
> > > > index d05acd6b0fc6..78f0da8f772f 100644
> > > > --- a/Documentation/devicetree/bindings/fpga/lattice,machxo2-
> > > > slave.yaml
> > > > +++ b/Documentation/devicetree/bindings/fpga/lattice,machxo2-
> > > > slave.yaml
> > > > @@ -26,6 +26,19 @@ properties:
> > > >      enum:
> > > >        - lattice,machxo2-slave-spi
> > > >  
> > > > +  lattice,erase-sram:
> > > > +    type: boolean
> > > > +    description: SRAM is to be erased during flash erase
> > > > operation
> > > > +
> > > > +  lattice,erase-feature-row:
> > > > +    type: boolean
> > > > +    description: Feature row is to be erased during flash
> > > > erase
> > > > operation
> > > > +
> > > > +  lattice,erase-userflash:
> > > > +    type: boolean
> > > > +    description: |
> > > > +      UFM (user flash memory) is to be erased during flash
> > > > erase
> > > > operation
> > > 
> > > In which conditions should we decide to erase each area?
> > > 
> > > Thanks,
> > > Yilun
> > 
> > Hi Yilun, 
> > 
> > the flash regions to be erased depend on the system design or
> > usecase.
> > For example, if non-volatile configuration is stored in the user
> > flash
> > memory, you might want to keep it from being erased in an in-field
> > upgrade, but you might want to clear it at factory bringup.
> 
> So these are all about user requirement, not the hardware
> capabilities.
> I think you should not put them here. If the user wants a different
> erase option supported by HW, why the driver prevents it?
> 
> Thanks,
> Yilun

I think it is rather a decision made by board-integrator, who will also
write the DT, than a decision made by the user at runtime, because the
integrator may decide to use the UFM (user flash memory) as a non-
volatile storage, e.g. for mac addresses to a softcore ethernet mac
implementation, or may decide to keep the security and readout-
protection flags in the user row from being erased.

On the other hand I do not have a very strong preference to have these
properties set via the device tree (I also guess that you may have
different usecases in mind), it simply appeared to me to fit quite well
when I thought about how this property is used. 

If you prefer this property to be set by another interface, please
suggest how to hand these information into the driver, since I am not
too familiar with the fpga-mgr framework and its interfaces. I can then
migrate to it for v2.

Best regards
Johannes

> 
> > 
> > Best regards
> > Johannes
> > > 
> > > > +
> > > >  required:
> > > >    - compatible
> > > >    - reg
> > > > @@ -42,5 +55,7 @@ examples:
> > > >              compatible = "lattice,machxo2-slave-spi";
> > > >              spi-max-frequency = <8000000>;
> > > >              reg = <0>;
> > > > +            lattice,erase-sram;
> > > > +            lattice,erase-feature-row;
> > > >          };
> > > >      };
> > > > -- 
> > > > 2.30.2
> > > > 
> > > 
> > 
> > -- 
> > Pengutronix e.K.                | Johannes Zink                  |
> > Steuerwalder Str. 21            | https://www.pengutronix.de/    |
> > 31137 Hildesheim, Germany       | Phone: +49-5121-206917-0       |
> > Amtsgericht Hildesheim, HRA 2686| Fax:   +49-5121-206917-5555    |
> > 
> 

-- 
Pengutronix e.K.                | Johannes Zink                  |
Steuerwalder Str. 21            | https://www.pengutronix.de/    |
31137 Hildesheim, Germany       | Phone: +49-5121-206917-0       |
Amtsgericht Hildesheim, HRA 2686| Fax:   +49-5121-206917-5555    |

