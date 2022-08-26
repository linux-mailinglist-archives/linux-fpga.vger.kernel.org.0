Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 847085A23AA
	for <lists+linux-fpga@lfdr.de>; Fri, 26 Aug 2022 11:03:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245273AbiHZJB5 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 26 Aug 2022 05:01:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbiHZJB4 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 26 Aug 2022 05:01:56 -0400
Received: from mail.pr-group.ru (mail.pr-group.ru [178.18.215.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF12AD39B9;
        Fri, 26 Aug 2022 02:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
        d=metrotek.ru; s=mail;
        h=from:subject:date:message-id:to:cc:mime-version:content-type:in-reply-to:
         references;
        bh=PqdOCysNyoeX+3vKTwVHuyFennZ69yEbZJEUljzyxto=;
        b=hOdAqTCPt5A4bXYLTKZWTHQVs2Qa92cyeVhq3jk/663xTIWQoEuWkfyPt2c1IZe5m8s8tc1pNYdTM
         IFOgoKFwRBnkt8Y3/HyMDNWcJyPFq115dlhqlZjfj8WzYliijtAoL3eP/tiI90oD+roT9SrZ1HvcaG
         3JDSxknJeoJqjs6gCYWdYHk4ijfsUTRtt1hNnXdwU3IH2NJIn49bTkyy+BJEvHDMc5MlOZ25j7Z0a+
         6TdSedpOZQ/KFS36sY2RpMTL7mSYxMQVf2i6M0f1NcnexiySNRFmOBtXIKmOsXmA9fAX/hyl4AnS2T
         AILLbP6RaV2C5Z8c15wVeHDNHiPdISQ==
X-Kerio-Anti-Spam:  Build: [Engines: 2.16.4.1445, Stamp: 3], Multi: [Enabled, t: (0.000010,0.011247)], BW: [Enabled, t: (0.000014,0.000001)], RTDA: [Enabled, t: (0.076999), Hit: No, Details: v2.41.0; Id: 15.52k1ho.1gbcm5ev6.14n; mclb], total: 0(700)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Level: 
X-Footer: bWV0cm90ZWsucnU=
Received: from h-e2.ddg ([85.143.252.66])
        (authenticated user i.bornyakov@metrotek.ru)
        by mail.pr-group.ru with ESMTPSA
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits));
        Fri, 26 Aug 2022 12:01:40 +0300
Date:   Fri, 26 Aug 2022 12:00:42 +0300
From:   Ivan Bornyakov <i.bornyakov@metrotek.ru>
To:     Sascha Hauer <sha@pengutronix.de>
Cc:     j.zink@pengutronix.de, devicetree@vger.kernel.org,
        linux-fpga@vger.kernel.org, robh+dt@kernel.org, mdf@kernel.org,
        kernel@pengutronix.de, yilun.xu@intel.com, hao.wu@intel.com
Subject: Re: [PATCH 00/16] Add support for Lattice MachXO2 programming via I2C
Message-ID: <20220826090042.jhngyeufei55b5c2@h-e2.ddg>
References: <20220825141343.1375690-1-j.zink@pengutronix.de>
 <20220825152514.9926-1-i.bornyakov@metrotek.ru>
 <20220826082539.GA12909@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220826082539.GA12909@pengutronix.de>
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Fri, Aug 26, 2022 at 10:25:39AM +0200, Sascha Hauer wrote:
> Hi Ivan,
> 
> On Thu, Aug 25, 2022 at 06:25:14PM +0300, Ivan Bornyakov wrote:
> > Hi, Johannes!
> > 
> > I just came across your patches. Surprisingly, our work interferes.
> > 
> > I recently posted patch-series for configuring ECP5 and was asked to make
> > generalized sysCONFIG driver with support for both ECP5 and MachXO2, which
> > I did. Sadly I don't have hardware with MachXO2, but you clearly do :)
> > 
> > Please, take a look at
> > 
> > https://lore.kernel.org/linux-fpga/20220825112433.14583-1-i.bornyakov@metrotek.ru/
> > 
> > and please help test MachXO2 variant. When we pull this off, you may add I2C
> > interface on top.
> 
> You are adding a new driver for something we already have a driver for
> in the tree.

My intent was to add new driver and drop old one once the new driver is
proven to be working.

> The final goal should be that we only have a single driver
> for sysconfig based FPGAs in the tree.

It is.

> Johannes' series is a step in
> that direction: He cleans up the existing driver and starts abstracting
> out common sysconfig functions so that they can be used by both the I2C
> and SPI interface. He just told me that the abstraction is likely not
> enough to integrate ECP5 support right away, one reason being that the
> machxo2 has a flash whereas the ECP5 does not.
> 
> Unless you can explain why the existing driver is broken beyond repair
> I think we should rather incrementally improve the existing driver
> instead of adding a new one with a conflicting compatible.

Yeah, conflicting compatible was my oversight.

> So despite you were in the room earlier I think you should rather base
> your work on Johannes' series.

We on par here. You guys didn't join ongoing work, I didn't rework
existing driver.

> 
> Just my 2 cents, maybe one of the maintainers has a few words on it.
> 
> Sascha
> 
> 
> -- 
> Pengutronix e.K.                           |                             |
> Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
> 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

