Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80B3D5A22F4
	for <lists+linux-fpga@lfdr.de>; Fri, 26 Aug 2022 10:27:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245114AbiHZIZr (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 26 Aug 2022 04:25:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245069AbiHZIZq (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 26 Aug 2022 04:25:46 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9825026573
        for <linux-fpga@vger.kernel.org>; Fri, 26 Aug 2022 01:25:44 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1oRUer-0006ip-Uw; Fri, 26 Aug 2022 10:25:41 +0200
Received: from sha by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1oRUep-00077G-Qx; Fri, 26 Aug 2022 10:25:39 +0200
Date:   Fri, 26 Aug 2022 10:25:39 +0200
To:     Ivan Bornyakov <i.bornyakov@metrotek.ru>
Cc:     j.zink@pengutronix.de, devicetree@vger.kernel.org,
        linux-fpga@vger.kernel.org, robh+dt@kernel.org, mdf@kernel.org,
        kernel@pengutronix.de, yilun.xu@intel.com, hao.wu@intel.com
Subject: Re: [PATCH 00/16] Add support for Lattice MachXO2 programming via I2C
Message-ID: <20220826082539.GA12909@pengutronix.de>
References: <20220825141343.1375690-1-j.zink@pengutronix.de>
 <20220825152514.9926-1-i.bornyakov@metrotek.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220825152514.9926-1-i.bornyakov@metrotek.ru>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
User-Agent: Mutt/1.10.1 (2018-07-13)
From:   Sascha Hauer <sha@pengutronix.de>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: sha@pengutronix.de
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

Hi Ivan,

On Thu, Aug 25, 2022 at 06:25:14PM +0300, Ivan Bornyakov wrote:
> Hi, Johannes!
> 
> I just came across your patches. Surprisingly, our work interferes.
> 
> I recently posted patch-series for configuring ECP5 and was asked to make
> generalized sysCONFIG driver with support for both ECP5 and MachXO2, which
> I did. Sadly I don't have hardware with MachXO2, but you clearly do :)
> 
> Please, take a look at
> 
> https://lore.kernel.org/linux-fpga/20220825112433.14583-1-i.bornyakov@metrotek.ru/
> 
> and please help test MachXO2 variant. When we pull this off, you may add I2C
> interface on top.

You are adding a new driver for something we already have a driver for
in the tree. The final goal should be that we only have a single driver
for sysconfig based FPGAs in the tree. Johannes' series is a step in
that direction: He cleans up the existing driver and starts abstracting
out common sysconfig functions so that they can be used by both the I2C
and SPI interface. He just told me that the abstraction is likely not
enough to integrate ECP5 support right away, one reason being that the
machxo2 has a flash whereas the ECP5 does not.

Unless you can explain why the existing driver is broken beyond repair
I think we should rather incrementally improve the existing driver
instead of adding a new one with a conflicting compatible.
So despite you were in the room earlier I think you should rather base
your work on Johannes' series.

Just my 2 cents, maybe one of the maintainers has a few words on it.

Sascha


-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
