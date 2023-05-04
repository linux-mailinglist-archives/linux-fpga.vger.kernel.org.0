Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 884466F6369
	for <lists+linux-fpga@lfdr.de>; Thu,  4 May 2023 05:33:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbjEDDcH (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 3 May 2023 23:32:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjEDDcG (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 3 May 2023 23:32:06 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D9D9198A;
        Wed,  3 May 2023 20:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683171125; x=1714707125;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rjq6kEAE37ZXdqXsLJPk3r0TYSNxOiuwP3NhKVSX78M=;
  b=bAVU7kA3YwKmBs0gKRttJAWAuNNZkJcFNLM9TzlAOp2jNJXRDMlrRO7y
   7WnMzjAFdrcvzjl0kk/Aej4VeG3i1PPZXaeoRz4rnDDpc/NkV3Ik1Kvbr
   TxCCU6scZwBu5++U7eqc8cAiz1Me1d4Vx/z1VhbJux5rXzayaBgVelFm/
   rziyewYyMCjhR7na9hg8fipWJvniA/1gngFN3G353T5qt2QROXp92zxSs
   b6nl8Omn9H8EFP6RsDW1k1VFtl5q4STou0I5Fl0NeUW/7jiO/1cTL9Yen
   pNv8Kh3UN9MfqosRJB6YhEpyW+eofjcsS9ceRRuH26WPp4/HVi46VilsV
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10699"; a="411998246"
X-IronPort-AV: E=Sophos;i="5.99,249,1677571200"; 
   d="scan'208";a="411998246"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2023 20:32:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10699"; a="786354576"
X-IronPort-AV: E=Sophos;i="5.99,249,1677571200"; 
   d="scan'208";a="786354576"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by FMSMGA003.fm.intel.com with ESMTP; 03 May 2023 20:32:01 -0700
Date:   Thu, 4 May 2023 19:32:13 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Ivan Bornyakov <i.bornyakov@metrotek.ru>
Cc:     Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Tom Rix <trix@redhat.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Vladimir Georgiev <v.georgiev@metrotek.ru>, system@metrotek.ru,
        linux-fpga@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/2] dt-bindings: fpga: replace Ivan Bornyakov
 maintainership
Message-ID: <ZFOXvQAjA5bri+Zb@yilunxu-OptiPlex-7050>
References: <20230428140150.2592-1-i.bornyakov@metrotek.ru>
 <20230428140150.2592-3-i.bornyakov@metrotek.ru>
 <20230428220415.GA351049-robh@kernel.org>
 <20230429082919.i4pmerf4qeckl3w6@x260>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230429082919.i4pmerf4qeckl3w6@x260>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 2023-04-29 at 11:29:19 +0300, Ivan Bornyakov wrote:
> On Fri, Apr 28, 2023 at 05:04:15PM -0500, Rob Herring wrote:
> > On Fri, Apr 28, 2023 at 05:01:50PM +0300, Ivan Bornyakov wrote:
> > > As I'm leaving Metrotek, hand over Lattice Slave SPI sysCONFIG FPGA
> > > manager and Microchip Polarfire FPGA manager maintainership duties to
> > > Vladimir.
> > > 
> > > Signed-off-by: Ivan Bornyakov <i.bornyakov@metrotek.ru>
> > > Signed-off-by: Vladimir Georgiev <v.georgiev@metrotek.ru>
> > 
> > The patch sender's Sob goes last. And only Vladimir should add his Sob 
> > (when an author or sender).
> > 
> 
> For the moment, when I'm still sender, would it be alright if we replace
> Vladimir's "Signed-off-by" to "Acked-by"?

Yes. I actually need an "Acked-by" that sent from Vladimir.

> 
> > > ---
> > >  Documentation/devicetree/bindings/fpga/lattice,sysconfig.yaml   | 2 +-
> > >  .../devicetree/bindings/fpga/microchip,mpf-spi-fpga-mgr.yaml    | 2 +-
> > >  2 files changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/fpga/lattice,sysconfig.yaml b/Documentation/devicetree/bindings/fpga/lattice,sysconfig.yaml
> > > index 4fb05eb84e2a..164331eb6275 100644
> > > --- a/Documentation/devicetree/bindings/fpga/lattice,sysconfig.yaml
> > > +++ b/Documentation/devicetree/bindings/fpga/lattice,sysconfig.yaml
> > > @@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
> > >  title: Lattice Slave SPI sysCONFIG FPGA manager
> > >  
> > >  maintainers:
> > > -  - Ivan Bornyakov <i.bornyakov@metrotek.ru>
> > > +  - Vladimir Georgiev <v.georgiev@metrotek.ru>
> > >  
> > >  description: |
> > >    Lattice sysCONFIG port, which is used for FPGA configuration, among others,
> > > diff --git a/Documentation/devicetree/bindings/fpga/microchip,mpf-spi-fpga-mgr.yaml b/Documentation/devicetree/bindings/fpga/microchip,mpf-spi-fpga-mgr.yaml
> > > index 527532f039ce..a157eecfb5fc 100644
> > > --- a/Documentation/devicetree/bindings/fpga/microchip,mpf-spi-fpga-mgr.yaml
> > > +++ b/Documentation/devicetree/bindings/fpga/microchip,mpf-spi-fpga-mgr.yaml
> > > @@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
> > >  title: Microchip Polarfire FPGA manager.
> > >  
> > >  maintainers:
> > > -  - Ivan Bornyakov <i.bornyakov@metrotek.ru>
> > > +  - Vladimir Georgiev <v.georgiev@metrotek.ru>
> > >  
> > >  description:
> > >    Device Tree Bindings for Microchip Polarfire FPGA Manager using slave SPI to
> > > -- 
> > > 2.40.0
> > > 
> > > 
> 
