Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F7B45A7844
	for <lists+linux-fpga@lfdr.de>; Wed, 31 Aug 2022 09:59:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbiHaH5M (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 31 Aug 2022 03:57:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230199AbiHaH5B (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 31 Aug 2022 03:57:01 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3BB52BB18
        for <linux-fpga@vger.kernel.org>; Wed, 31 Aug 2022 00:57:00 -0700 (PDT)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=irc.pengutronix.de)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <j.zink@pengutronix.de>)
        id 1oTIam-00011N-SC; Wed, 31 Aug 2022 09:56:56 +0200
Message-ID: <6c1b1ed1b1f89a232ba2e6d0fa71636f28311f94.camel@pengutronix.de>
Subject: Re: [PATCH 15/16] fpga: machxo2: extend erase timeout for machxo2
 FPGA
From:   Johannes Zink <j.zink@pengutronix.de>
To:     Xu Yilun <yilun.xu@intel.com>
Cc:     devicetree@vger.kernel.org, linux-fpga@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Moritz Fischer <mdf@kernel.org>, kernel@pengutronix.de,
        Wu Hao <hao.wu@intel.com>
Date:   Wed, 31 Aug 2022 09:56:39 +0200
In-Reply-To: <YwzT5imor+I4Bf1q@yilunxu-OptiPlex-7050>
References: <20220825141343.1375690-1-j.zink@pengutronix.de>
         <20220825141343.1375690-16-j.zink@pengutronix.de>
         <YwyGWELZ7WfCE3FS@yilunxu-OptiPlex-7050>
         <c93207c6ec63c70918ae0989ec67f37771504123.camel@pengutronix.de>
         <YwzT5imor+I4Bf1q@yilunxu-OptiPlex-7050>
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

Hi Yilun, 

On Mon, 2022-08-29 at 22:57 +0800, Xu Yilun wrote:
> On 2022-08-29 at 12:51:19 +0200, Johannes Zink wrote:
> > Hi Yilun, 
> > 
> > On Mon, 2022-08-29 at 17:26 +0800, Xu Yilun wrote:
> > > On 2022-08-25 at 16:13:42 +0200, Johannes Zink wrote:
> > > > Measurements showed that some FPGAs take significantly longer
> > > > than
> > > > the
> > > > default wait function supplied. The datasheet inidicates up to
> > > > 30
> > > > seconds erase times for some MachXO2 FPGAs, depending on the
> > > > number
> > > > of
> > > > LUTs (and the corresponding configuration flash size).
> > > > 
> > > > Signed-off-by: Johannes Zink <j.zink@pengutronix.de>
> > > > ---

[snip]
 
> > > > +static inline int machxo2_wait_until_not_busy_timeout(struct
> > > > machxo2_common_priv *priv)
> > > > +{
> > > > +       int ret, pollret;
> > > > +       u32 status = MACHXO2_BUSY;
> > > > +
> > > > +       pollret = read_poll_timeout(priv->get_status, ret,
> > > > +                                   (ret && ret != -EAGAIN) ||
> > > > !(status & MACHXO2_BUSY),
> > > > +                                   MACHXO2_ERASE_USEC_SLEEP,
> > > > MACHXO2_MAX_ERASE_USEC,
> > > > +                                   true, priv, &status);
> > > 
> > > Why just taking care of erase timeout? I see the busy wait in
> > > many
> > > places.
> > > 
> > 
> > Erasing the flash memory takes significantly longer than the other
> > operations (up to 30s), which is why I decided to use this separate
> > implementation. For other commands the fpga indicates no-more-busy
> > much
> > faster than for the erase_flash command.
> 
> It is almost always better to have a relatively measureable timeout,
> unless it is really time critical. Apparently spi/i2c transfer is not
> time critical itself. So since you have implemented a better
> function,
> why not use it?
> 
> Thanks,
> Yilun

That's a fair point. I will look in the datasheet how long the timeouts
on the other operations should be set and will replace the former busy
wait implementation in v2. I would not expect any breakage from that.

Best regards
Johannes

-- 
Pengutronix e.K.                | Johannes Zink                  |
Steuerwalder Str. 21            | https://www.pengutronix.de/    |
31137 Hildesheim, Germany       | Phone: +49-5121-206917-0       |
Amtsgericht Hildesheim, HRA 2686| Fax:   +49-5121-206917-5555    |

