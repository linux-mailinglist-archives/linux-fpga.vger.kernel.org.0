Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB4B4596C09
	for <lists+linux-fpga@lfdr.de>; Wed, 17 Aug 2022 11:32:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234641AbiHQJai (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 17 Aug 2022 05:30:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230518AbiHQJac (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 17 Aug 2022 05:30:32 -0400
Received: from mail.pr-group.ru (mail.pr-group.ru [178.18.215.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92DDA5A824;
        Wed, 17 Aug 2022 02:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
        d=metrotek.ru; s=mail;
        h=from:subject:date:message-id:to:cc:mime-version:content-type:in-reply-to:
         references;
        bh=B1hmJLzhgp+cCdKeDExeQqbkP18e8HhH601vV+E1w50=;
        b=SXOXeg0hXtXaVqOOnK5acOIEm8TnPQJxV5wFYx4mSwxEoLkg1SF2ceF0q4XC8E52IuKOWgzTwwff8
         GXTaypsIplyq9skK2OOme1XHNtGh9+gJV1UxKQo+3L9t/Lq2uSIJLBY49eqtcriHlkoZcEdBjbmWcu
         ywLD1UhtAxKNTjM5C7gkkbThg2UK/T8Z71T8oQSFrNdtfzLNoEmDJ37EJi3KeANAfYrg2aGL0OGeog
         +scBNcI0UVRdRncwg6FI0JZ2Z3VSWAp7+nvaDALG5h11YNccmhAErBJ6Vrn28g1/gAZE9wBWO8P2/2
         uxcrEJA9EVm5WQYjGWz8OK2aq8vhlOA==
X-Kerio-Anti-Spam:  Build: [Engines: 2.16.3.1424, Stamp: 3], Multi: [Enabled, t: (0.000014,0.007457)], BW: [Enabled, t: (0.000014,0.000001)], RTDA: [Enabled, t: (0.074159), Hit: No, Details: v2.41.0; Id: 15.52kaaj.1gali6mdc.ev6o; mclb], total: 0(700)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Level: 
X-Footer: bWV0cm90ZWsucnU=
Received: from x260 ([92.100.85.134])
        (authenticated user i.bornyakov@metrotek.ru)
        by mail.pr-group.ru with ESMTPSA
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits));
        Wed, 17 Aug 2022 12:29:55 +0300
Date:   Wed, 17 Aug 2022 12:04:13 +0300
From:   Ivan Bornyakov <i.bornyakov@metrotek.ru>
To:     Xu Yilun <yilun.xu@intel.com>
Cc:     mdf@kernel.org, hao.wu@intel.com, trix@redhat.com, dg@emlix.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-fpga@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, system@metrotek.ru
Subject: Re: [PATCH v6 1/2] fpga: ecp5-spi: add Lattice ECP5 FPGA manager
Message-ID: <20220817090413.ywf7wescwj2manif@x260>
References: <20220815132157.8083-1-i.bornyakov@metrotek.ru>
 <20220815132157.8083-2-i.bornyakov@metrotek.ru>
 <Yvr6SY5WGXlYiLig@yilunxu-OptiPlex-7050>
 <20220816045841.irhr5vigemdqknaw@x260>
 <Yvs0jieXsyzhn8q9@yilunxu-OptiPlex-7050>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yvs0jieXsyzhn8q9@yilunxu-OptiPlex-7050>
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Tue, Aug 16, 2022 at 02:09:18PM +0800, Xu Yilun wrote:
> On 2022-08-16 at 07:58:41 +0300, Ivan Bornyakov wrote:
> > On Tue, Aug 16, 2022 at 10:00:41AM +0800, Xu Yilun wrote:
> > > On 2022-08-15 at 16:21:56 +0300, Ivan Bornyakov wrote:
> > > > Add support to the FPGA manager for programming Lattice ECP5 FPGA over
> > > > slave SPI interface with .bit formatted uncompressed bitstream image.
> > > 
> > > Not sure if something is missed.
> > > 
> > > https://lore.kernel.org/all/20220729145757.GA2601292@yilunxu-OptiPlex-7050/
> > > 
> > > I was considering if a generic driver for lattice slave SPI sysCONFIG
> > > interface could be introduced. From machxo2 & ecp5 Programming Usage
> > > Guide, or others in this series, they basically use the same reconfigure
> > > interface & protocol.
> > > 
> > > Thanks,
> > > Yilun
> > > 
> > 
> > I only have HW with ECP5, can't vouch for the rest.
> 
> I understand your concern, but having separate drivers for the same IP on
> different boards makes the maintaining harder.
> 
> We don't have to make everything fine, but start with machxo2 and ecp5
> first. If the change affects machxo2, other people may help.
> 
> Thanks,
> Yilun
> 

Hi, Yilun.

To clear things out, considering what Daniel said in
https://lore.kernel.org/linux-fpga/20220816074216.GA31706@homes.emlix.com/
you still don't want separate ECP5 driver, or this v6 is OK and review
continues?

