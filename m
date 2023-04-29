Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C56946F23B6
	for <lists+linux-fpga@lfdr.de>; Sat, 29 Apr 2023 10:31:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230473AbjD2I3r (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sat, 29 Apr 2023 04:29:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230392AbjD2I3q (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sat, 29 Apr 2023 04:29:46 -0400
Received: from mail.pr-group.ru (mail.pr-group.ru [178.18.215.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51D3BC4;
        Sat, 29 Apr 2023 01:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
        d=metrotek.ru; s=mail;
        h=from:subject:date:message-id:to:cc:mime-version:content-type:in-reply-to:
         references;
        bh=wV5/bUVnxzyoz+DHrrNFYHs9nH2tXsBCXhVViKPUfIE=;
        b=FfqNmYkmBhnmProI20j6LSAjpS7armO7Lgt0t7LnFt4PHv8xvH20ZaxvgBitPEDcFD98TZQH2HVdv
         d2/TEavl7rGzecD6ccAXmAI1dT0C2inZlRksp79As4xqGMh8eNwV7Av1nNBqYvuDEFAv7Bi+WLlIXM
         6mHAoqFhm1yWGdTaM3lduI1ewP+uDSbJCABHa1q3p2URYdinr3AxliP0xw6EnTUI4Rl8lbenIXvDmi
         T0qXCeDCvzk3vP4MVu9DQCRLhrBFrCKQZmFdX+pZfjtBLTTyjGJzjAGg6DZ1GXVHKdhlQY7GWV+Ntl
         RwjgxcbKR9CUZzbM6r57UpHbRI6Gj+g==
X-Kerio-Anti-Spam:  Build: [Engines: 2.17.2.1477, Stamp: 3], Multi: [Enabled, t: (0.000009,0.011910)], BW: [Enabled, t: (0.000021,0.000001)], RTDA: [Enabled, t: (0.087680), Hit: No, Details: v2.49.0; Id: 15.2t292.1gv6234a5.11v62; mclb], total: 0(700)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Level: 
X-Footer: bWV0cm90ZWsucnU=
Received: from x260 ([78.37.166.219])
        (authenticated user i.bornyakov@metrotek.ru)
        by mail.pr-group.ru with ESMTPSA
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits));
        Sat, 29 Apr 2023 11:29:22 +0300
Date:   Sat, 29 Apr 2023 11:29:19 +0300
From:   Ivan Bornyakov <i.bornyakov@metrotek.ru>
To:     Rob Herring <robh@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Moritz Fischer <mdf@kernel.org>,
        Wu Hao <hao.wu@intel.com>, Xu Yilun <yilun.xu@intel.com>,
        Tom Rix <trix@redhat.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Vladimir Georgiev <v.georgiev@metrotek.ru>, system@metrotek.ru,
        linux-fpga@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/2] dt-bindings: fpga: replace Ivan Bornyakov
 maintainership
Message-ID: <20230429082919.i4pmerf4qeckl3w6@x260>
References: <20230428140150.2592-1-i.bornyakov@metrotek.ru>
 <20230428140150.2592-3-i.bornyakov@metrotek.ru>
 <20230428220415.GA351049-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230428220415.GA351049-robh@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Fri, Apr 28, 2023 at 05:04:15PM -0500, Rob Herring wrote:
> On Fri, Apr 28, 2023 at 05:01:50PM +0300, Ivan Bornyakov wrote:
> > As I'm leaving Metrotek, hand over Lattice Slave SPI sysCONFIG FPGA
> > manager and Microchip Polarfire FPGA manager maintainership duties to
> > Vladimir.
> > 
> > Signed-off-by: Ivan Bornyakov <i.bornyakov@metrotek.ru>
> > Signed-off-by: Vladimir Georgiev <v.georgiev@metrotek.ru>
> 
> The patch sender's Sob goes last. And only Vladimir should add his Sob 
> (when an author or sender).
> 

For the moment, when I'm still sender, would it be alright if we replace
Vladimir's "Signed-off-by" to "Acked-by"?

> > ---
> >  Documentation/devicetree/bindings/fpga/lattice,sysconfig.yaml   | 2 +-
> >  .../devicetree/bindings/fpga/microchip,mpf-spi-fpga-mgr.yaml    | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/fpga/lattice,sysconfig.yaml b/Documentation/devicetree/bindings/fpga/lattice,sysconfig.yaml
> > index 4fb05eb84e2a..164331eb6275 100644
> > --- a/Documentation/devicetree/bindings/fpga/lattice,sysconfig.yaml
> > +++ b/Documentation/devicetree/bindings/fpga/lattice,sysconfig.yaml
> > @@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
> >  title: Lattice Slave SPI sysCONFIG FPGA manager
> >  
> >  maintainers:
> > -  - Ivan Bornyakov <i.bornyakov@metrotek.ru>
> > +  - Vladimir Georgiev <v.georgiev@metrotek.ru>
> >  
> >  description: |
> >    Lattice sysCONFIG port, which is used for FPGA configuration, among others,
> > diff --git a/Documentation/devicetree/bindings/fpga/microchip,mpf-spi-fpga-mgr.yaml b/Documentation/devicetree/bindings/fpga/microchip,mpf-spi-fpga-mgr.yaml
> > index 527532f039ce..a157eecfb5fc 100644
> > --- a/Documentation/devicetree/bindings/fpga/microchip,mpf-spi-fpga-mgr.yaml
> > +++ b/Documentation/devicetree/bindings/fpga/microchip,mpf-spi-fpga-mgr.yaml
> > @@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
> >  title: Microchip Polarfire FPGA manager.
> >  
> >  maintainers:
> > -  - Ivan Bornyakov <i.bornyakov@metrotek.ru>
> > +  - Vladimir Georgiev <v.georgiev@metrotek.ru>
> >  
> >  description:
> >    Device Tree Bindings for Microchip Polarfire FPGA Manager using slave SPI to
> > -- 
> > 2.40.0
> > 
> > 

