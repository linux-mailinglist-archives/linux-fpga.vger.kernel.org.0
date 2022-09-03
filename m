Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E09E35ABF72
	for <lists+linux-fpga@lfdr.de>; Sat,  3 Sep 2022 17:00:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbiICO62 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sat, 3 Sep 2022 10:58:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbiICO61 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sat, 3 Sep 2022 10:58:27 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E39452809
        for <linux-fpga@vger.kernel.org>; Sat,  3 Sep 2022 07:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662217106; x=1693753106;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=vX3VASNoJU1qoG7Txk1/xvAb6k5JJwrksI9BSzQuEkk=;
  b=Cj+c4y+jv9FI0RDdpfNHprIE2cDgHFhjlqiRZTncLY8xZ6A7QX8d7OzP
   +xd01vBObIbo9SIR5Qo8tHiVCCifSd7efc3Nmlbk/ZsIrqutWlypo/KyE
   j0D5kLwRYCbQYN9+SQXCFjXnx1ffSqJPu+cObrk9hzb1k+w2MCyL9QCc7
   YZTFSwQ7pKFMl9AUZvbBEufiKv40MnUeGQa03Dj1cRPzGFwKKwZSgP5r0
   tETkV5q29aN4SQ8121DgAYvHZvYiMtKX9N59CIlJTaLpRhFS3bus1i3Yd
   87bJaXw1jclNR94G0+fsYMLwi8jUJc3W3FQZb7qhxTAT0xot2qLEefQ8k
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10459"; a="276561466"
X-IronPort-AV: E=Sophos;i="5.93,287,1654585200"; 
   d="scan'208";a="276561466"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2022 07:58:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,287,1654585200"; 
   d="scan'208";a="674722550"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmsmga008.fm.intel.com with ESMTP; 03 Sep 2022 07:58:25 -0700
Date:   Sat, 3 Sep 2022 22:49:01 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Johannes Zink <j.zink@pengutronix.de>
Cc:     linux-fpga@vger.kernel.org
Subject: Re: [PATCH 02/16] dt-bindings: fpga: machxo2-slave: add erasure
 properties
Message-ID: <YxNpXRubPe69ndFx@yilunxu-OptiPlex-7050>
References: <20220825141343.1375690-1-j.zink@pengutronix.de>
 <20220825141343.1375690-3-j.zink@pengutronix.de>
 <YwxtFjMILAlEF/uh@yilunxu-OptiPlex-7050>
 <9d5512768acb4d57f339942007402a9ed9483e84.camel@pengutronix.de>
 <YwzWt8KjyfdyqehI@yilunxu-OptiPlex-7050>
 <c8e119bd0f3739ce771bedf417c2d98285319270.camel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c8e119bd0f3739ce771bedf417c2d98285319270.camel@pengutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 2022-08-31 at 09:38:31 +0200, Johannes Zink wrote:
> Hi Yilun, 
> 
> On Mon, 2022-08-29 at 23:09 +0800, Xu Yilun wrote:
> > On 2022-08-29 at 10:41:42 +0200, Johannes Zink wrote:
> > > On Mon, 2022-08-29 at 15:39 +0800, Xu Yilun wrote:
> > > > On 2022-08-25 at 16:13:29 +0200, Johannes Zink wrote:
> > > > > This patch introduces additional memory areas of the machxo2-
> > > > > slave
> > > > > fpga
> > > > > to be erased.
> > > > > 
> > > > > Signed-off-by: Johannes Zink <j.zink@pengutronix.de>
> > > > > ---
> > > > >  .../bindings/fpga/lattice,machxo2-slave.yaml      | 15
> > > > > +++++++++++++++
> > > > >  1 file changed, 15 insertions(+)
> > > > > 
> > > > > diff --git
> > > > > a/Documentation/devicetree/bindings/fpga/lattice,machxo2-
> > > > > slave.yaml
> > > > > b/Documentation/devicetree/bindings/fpga/lattice,machxo2-
> > > > > slave.yaml
> > > > > index d05acd6b0fc6..78f0da8f772f 100644
> > > > > --- a/Documentation/devicetree/bindings/fpga/lattice,machxo2-
> > > > > slave.yaml
> > > > > +++ b/Documentation/devicetree/bindings/fpga/lattice,machxo2-
> > > > > slave.yaml
> > > > > @@ -26,6 +26,19 @@ properties:
> > > > >      enum:
> > > > >        - lattice,machxo2-slave-spi
> > > > >  
> > > > > +  lattice,erase-sram:
> > > > > +    type: boolean
> > > > > +    description: SRAM is to be erased during flash erase
> > > > > operation
> > > > > +
> > > > > +  lattice,erase-feature-row:
> > > > > +    type: boolean
> > > > > +    description: Feature row is to be erased during flash
> > > > > erase
> > > > > operation
> > > > > +
> > > > > +  lattice,erase-userflash:
> > > > > +    type: boolean
> > > > > +    description: |
> > > > > +      UFM (user flash memory) is to be erased during flash
> > > > > erase
> > > > > operation
> > > > 
> > > > In which conditions should we decide to erase each area?
> > > > 
> > > > Thanks,
> > > > Yilun
> > > 
> > > Hi Yilun, 
> > > 
> > > the flash regions to be erased depend on the system design or
> > > usecase.
> > > For example, if non-volatile configuration is stored in the user
> > > flash
> > > memory, you might want to keep it from being erased in an in-field
> > > upgrade, but you might want to clear it at factory bringup.
> > 
> > So these are all about user requirement, not the hardware
> > capabilities.
> > I think you should not put them here. If the user wants a different
> > erase option supported by HW, why the driver prevents it?
> > 
> > Thanks,
> > Yilun
> 
> I think it is rather a decision made by board-integrator, who will also
> write the DT, than a decision made by the user at runtime, because the
> integrator may decide to use the UFM (user flash memory) as a non-
> volatile storage, e.g. for mac addresses to a softcore ethernet mac
> implementation, or may decide to keep the security and readout-
> protection flags in the user row from being erased.
> 
> On the other hand I do not have a very strong preference to have these
> properties set via the device tree (I also guess that you may have
> different usecases in mind), it simply appeared to me to fit quite well
> when I thought about how this property is used. 
> 
> If you prefer this property to be set by another interface, please
> suggest how to hand these information into the driver, since I am not
> too familiar with the fpga-mgr framework and its interfaces. I can then
> migrate to it for v2.

I looked into the MACHOX2 driver & SPEC again, and found the major work
is to program the flash. I think this is actually not within the scope of
FPGA manager framework.

The FPGA manager focus on the reprogramming (or so called configuration in
MACHOX2 spec) of the FPGA region (FPGA active logic), and the removal &
enumeration of the devices within the region, before and after
reprogramming.

The existing MACHOX2 driver actually combines the reprograming of the
flash & the FPGA region, it hides many details about flash. Which is
barely OK at that time. But when you are trying to extend more
functionalities about flash, it is not proper here.

So my idea is to separate the 2 steps:
1. managing the flash, this should be implemented in other subsystem,
maybe MTD?
2. the configuration of the FPGA region retrieved from flash, this is
within the scope of FPGA manager. We don't have code now, maybe it's the
time to work on it.

Thanks,
Yilun

> 
> Best regards
> Johannes
> 
> > 
> > > 
> > > Best regards
> > > Johannes
> > > > 
> > > > > +
> > > > >  required:
> > > > >    - compatible
> > > > >    - reg
> > > > > @@ -42,5 +55,7 @@ examples:
> > > > >              compatible = "lattice,machxo2-slave-spi";
> > > > >              spi-max-frequency = <8000000>;
> > > > >              reg = <0>;
> > > > > +            lattice,erase-sram;
> > > > > +            lattice,erase-feature-row;
> > > > >          };
> > > > >      };
> > > > > -- 
> > > > > 2.30.2
> > > > > 
> > > > 
> > > 
> > > -- 
> > > Pengutronix e.K.                | Johannes Zink                  |
> > > Steuerwalder Str. 21            | https://www.pengutronix.de/    |
> > > 31137 Hildesheim, Germany       | Phone: +49-5121-206917-0       |
> > > Amtsgericht Hildesheim, HRA 2686| Fax:   +49-5121-206917-5555    |
> > > 
> > 
> 
> -- 
> Pengutronix e.K.                | Johannes Zink                  |
> Steuerwalder Str. 21            | https://www.pengutronix.de/    |
> 31137 Hildesheim, Germany       | Phone: +49-5121-206917-0       |
> Amtsgericht Hildesheim, HRA 2686| Fax:   +49-5121-206917-5555    |
> 
