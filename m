Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF6995A22C8
	for <lists+linux-fpga@lfdr.de>; Fri, 26 Aug 2022 10:18:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245279AbiHZIQ5 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 26 Aug 2022 04:16:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343601AbiHZIQs (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 26 Aug 2022 04:16:48 -0400
Received: from mail.pr-group.ru (mail.pr-group.ru [178.18.215.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AED0D4758;
        Fri, 26 Aug 2022 01:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
        d=metrotek.ru; s=mail;
        h=from:subject:date:message-id:to:cc:mime-version:content-type:
         content-transfer-encoding:in-reply-to:references;
        bh=GgM9jd2gfjdVIiQkM15Sjc/NpQmQKqWnNl2+Tz982U0=;
        b=YTHGiGWauR9+kRWkYLgKVFYGPbBU968unR1+7JEcqiNKxy2Jw4CkFLn6uanf5sq+8wI0nzNOh2ZNS
         81MpJXS47bHa3EJ7PlPB0ljhGsXLsQWfBo//7ouDtyodpZoXJFN7Zwd12ZHLUW1G1cSXv2WCilm71C
         toBLJrgoSkmJribf5kmUojgndRoTlMLgjrePvxYBwBYo5vPDhlUrvuBIrTcJymWGpfQi2q8VfmAwAc
         e/WtmHnqWDkwzhODJZF4j4DQ3HyDzTxFrCQZ/IbWBeN4GAYQDK+tDgwizOcen2ZWJc+EBWVJ4/3lew
         UKl9dcWy2A1o/T9iyp0egQPshU5nc0Q==
X-Kerio-Anti-Spam:  Build: [Engines: 2.16.4.1445, Stamp: 3], Multi: [Enabled, t: (0.000017,0.009778)], BW: [Enabled, t: (0.000017,0.000001)], RTDA: [Enabled, t: (0.084197), Hit: No, Details: v2.41.0; Id: 15.52katr.1gbcjiluu.1gj; mclb], total: 0(700)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Level: 
X-Footer: bWV0cm90ZWsucnU=
Received: from h-e2.ddg ([85.143.252.66])
        (authenticated user i.bornyakov@metrotek.ru)
        by mail.pr-group.ru with ESMTPSA
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits));
        Fri, 26 Aug 2022 11:16:28 +0300
Date:   Fri, 26 Aug 2022 11:15:30 +0300
From:   Ivan Bornyakov <i.bornyakov@metrotek.ru>
To:     Johannes Zink <j.zink@pengutronix.de>
Cc:     devicetree@vger.kernel.org, linux-fpga@vger.kernel.org,
        robh+dt@kernel.org, mdf@kernel.org, kernel@pengutronix.de,
        yilun.xu@intel.com, hao.wu@intel.com
Subject: Re: [PATCH 00/16] Add support for Lattice MachXO2 programming via I2C
Message-ID: <20220826081530.qd4or3fo275m7tyj@h-e2.ddg>
References: <20220825152514.9926-1-i.bornyakov@metrotek.ru>
 <b65b274e797fef70ee5824953d4bcda2c32d3624.camel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b65b274e797fef70ee5824953d4bcda2c32d3624.camel@pengutronix.de>
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Fri, Aug 26, 2022 at 08:32:49AM +0200, Johannes Zink wrote:
> On Thu, 2022-08-25 at 18:25 +0300, Ivan Bornyakov wrote:
> > Hi, Johannes!
> 
> Hi Ivan,
> > 
> > I just came across your patches. Surprisingly, our work interferes.
> > 
> > I recently posted patch-series for configuring ECP5 and was asked to
> > make
> > generalized sysCONFIG driver with support for both ECP5 and MachXO2,
> > which
> > I did. 
> 
> That looks very interesting indeed.
> 
> > Sadly I don't have hardware with MachXO2, but you clearly do :)
> > 
> > Please, take a look at
> > 
> >  
> > https://lore.kernel.org/linux-fpga/20220825112433.14583-1-i.bornyakov@metrotek.ru/
> > 
> > and please help test MachXO2 variant. When we pull this off, you may
> > add I2C
> > interface on top.
> > 
> > 
> > 
> 
> my hardware has only I2C connected to the MachXO2 (hence the patch
> series...), so I cannot test your patches directly.

That's unfortunate, anyway please join the review so your changes would
be easier to apply on top.

> 
> Since adding I2C requires some quirks with respect to the programming
> commands (some are differ to the SPI ones, ...) it will take me some
> time to add my patches on top of yours in order to test, but after
> having had a short glance at your patch series, I think it should be
> feasible.
> 
> Though, I think you should allow the program-gpios, init-gpios and
> done-gpios for machxo2 and have them as optional, at least for machxo2.
> 
> Best regards
> Johannes
> 
> -- 
> Pengutronix e.K.                | Johannes Zink                  |
> Steuerwalder Str. 21            | https://www.pengutronix.de/    |
> 31137 Hildesheim, Germany       | Phone: +49-5121-206917-0       |
> Amtsgericht Hildesheim, HRA 2686| Fax:   +49-5121-206917-5555    |
> 

