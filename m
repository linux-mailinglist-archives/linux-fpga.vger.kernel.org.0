Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 735485A20EE
	for <lists+linux-fpga@lfdr.de>; Fri, 26 Aug 2022 08:34:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236285AbiHZGdK (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 26 Aug 2022 02:33:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245025AbiHZGdI (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 26 Aug 2022 02:33:08 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A81C1C91B
        for <linux-fpga@vger.kernel.org>; Thu, 25 Aug 2022 23:33:08 -0700 (PDT)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=irc.pengutronix.de)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <j.zink@pengutronix.de>)
        id 1oRStt-0007pU-87; Fri, 26 Aug 2022 08:33:05 +0200
Message-ID: <b65b274e797fef70ee5824953d4bcda2c32d3624.camel@pengutronix.de>
Subject: Re: [PATCH 00/16] Add support for Lattice MachXO2 programming via
 I2C
From:   Johannes Zink <j.zink@pengutronix.de>
To:     Ivan Bornyakov <i.bornyakov@metrotek.ru>
Cc:     devicetree@vger.kernel.org, linux-fpga@vger.kernel.org,
        robh+dt@kernel.org, mdf@kernel.org, kernel@pengutronix.de,
        yilun.xu@intel.com, hao.wu@intel.com
Date:   Fri, 26 Aug 2022 08:32:49 +0200
In-Reply-To: <20220825152514.9926-1-i.bornyakov@metrotek.ru>
References: <20220825152514.9926-1-i.bornyakov@metrotek.ru>
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

On Thu, 2022-08-25 at 18:25 +0300, Ivan Bornyakov wrote:
> Hi, Johannes!

Hi Ivan,
> 
> I just came across your patches. Surprisingly, our work interferes.
> 
> I recently posted patch-series for configuring ECP5 and was asked to
> make
> generalized sysCONFIG driver with support for both ECP5 and MachXO2,
> which
> I did. 

That looks very interesting indeed.

> Sadly I don't have hardware with MachXO2, but you clearly do :)
> 
> Please, take a look at
> 
>  
> https://lore.kernel.org/linux-fpga/20220825112433.14583-1-i.bornyakov@metrotek.ru/
> 
> and please help test MachXO2 variant. When we pull this off, you may
> add I2C
> interface on top.
> 
> 
> 

my hardware has only I2C connected to the MachXO2 (hence the patch
series...), so I cannot test your patches directly. 

Since adding I2C requires some quirks with respect to the programming
commands (some are differ to the SPI ones, ...) it will take me some
time to add my patches on top of yours in order to test, but after
having had a short glance at your patch series, I think it should be
feasible.

Though, I think you should allow the program-gpios, init-gpios and
done-gpios for machxo2 and have them as optional, at least for machxo2.

Best regards
Johannes

-- 
Pengutronix e.K.                | Johannes Zink                  |
Steuerwalder Str. 21            | https://www.pengutronix.de/    |
31137 Hildesheim, Germany       | Phone: +49-5121-206917-0       |
Amtsgericht Hildesheim, HRA 2686| Fax:   +49-5121-206917-5555    |

