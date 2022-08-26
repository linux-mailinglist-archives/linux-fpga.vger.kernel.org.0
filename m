Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 895835A2273
	for <lists+linux-fpga@lfdr.de>; Fri, 26 Aug 2022 09:58:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245624AbiHZH4U (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 26 Aug 2022 03:56:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245678AbiHZH4U (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 26 Aug 2022 03:56:20 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 837359F1B8
        for <linux-fpga@vger.kernel.org>; Fri, 26 Aug 2022 00:56:19 -0700 (PDT)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=irc.pengutronix.de)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <j.zink@pengutronix.de>)
        id 1oRUCP-0002Dv-QL; Fri, 26 Aug 2022 09:56:17 +0200
Message-ID: <6f685c47b8564399606d7cf6110713eb4b114784.camel@pengutronix.de>
Subject: Re: [PATCH 03/16] dt-bindings: fpga: machxo2-slave: add pin for
 program sequence init
From:   Johannes Zink <j.zink@pengutronix.de>
To:     Rob Herring <robh@kernel.org>
Cc:     linux-fpga@vger.kernel.org, devicetree@vger.kernel.org,
        Moritz Fischer <mdf@kernel.org>, kernel@pengutronix.de,
        Wu Hao <hao.wu@intel.com>, Rob Herring <robh+dt@kernel.org>,
        Xu Yilun <yilun.xu@intel.com>
Date:   Fri, 26 Aug 2022 09:56:01 +0200
In-Reply-To: <1661453479.997595.1486941.nullmailer@robh.at.kernel.org>
References: <20220825141343.1375690-1-j.zink@pengutronix.de>
         <20220825141343.1375690-4-j.zink@pengutronix.de>
         <1661453479.997595.1486941.nullmailer@robh.at.kernel.org>
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

On Thu, 2022-08-25 at 13:51 -0500, Rob Herring wrote:
> On Thu, 25 Aug 2022 16:13:30 +0200, Johannes Zink wrote:
> > This commit adds a pin which initiates the FPGA programming
> > sequence
> > once pulsed low.
> > 
> > Signed-off-by: Johannes Zink <j.zink@pengutronix.de>
> > ---
> >  .../devicetree/bindings/fpga/lattice,machxo2-slave.yaml    | 7
> > +++++++
> >  1 file changed, 7 insertions(+)
> > 
> 
> My bot found errors running 'make DT_CHECKER_FLAGS=-m
> dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> Error: Documentation/devicetree/bindings/fpga/lattice,machxo2-
> slave.example.dts:28.51-52 syntax error
> FATAL ERROR: Unable to parse input tree
> make[1]: *** [scripts/Makefile.lib:384:
> Documentation/devicetree/bindings/fpga/lattice,machxo2-
> slave.example.dtb] Error 1
> make[1]: *** Waiting for unfinished jobs....
> make: *** [Makefile:1420: dt_binding_check] Error 2
> 
> doc reference errors (make refcheckdocs):
> 
> See https://patchwork.ozlabs.org/patch/
> 
> This check can fail if there are any dependencies. The base for a
> patch
> series is generally the most recent rc1.
> 
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up
> to
> date:
> 
> pip3 install dtschema --upgrade
> 
> Please check and re-submit.
> 
> 
Hi, 

I was able to reproduce the error and will fix it in v2. 

Thanks and best regards
Johannes

-- 
Pengutronix e.K.                | Johannes Zink                  |
Steuerwalder Str. 21            | https://www.pengutronix.de/    |
31137 Hildesheim, Germany       | Phone: +49-5121-206917-0       |
Amtsgericht Hildesheim, HRA 2686| Fax:   +49-5121-206917-5555    |

