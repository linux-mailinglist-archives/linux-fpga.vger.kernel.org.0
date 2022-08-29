Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BCAF5A479C
	for <lists+linux-fpga@lfdr.de>; Mon, 29 Aug 2022 12:53:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbiH2Kvk (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 29 Aug 2022 06:51:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbiH2Kvj (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 29 Aug 2022 06:51:39 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A742E5D0DC
        for <linux-fpga@vger.kernel.org>; Mon, 29 Aug 2022 03:51:38 -0700 (PDT)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=irc.pengutronix.de)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <j.zink@pengutronix.de>)
        id 1oScMg-0003TI-J2; Mon, 29 Aug 2022 12:51:34 +0200
Message-ID: <c93207c6ec63c70918ae0989ec67f37771504123.camel@pengutronix.de>
Subject: Re: [PATCH 15/16] fpga: machxo2: extend erase timeout for machxo2
 FPGA
From:   Johannes Zink <j.zink@pengutronix.de>
To:     Xu Yilun <yilun.xu@intel.com>
Cc:     devicetree@vger.kernel.org, linux-fpga@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Moritz Fischer <mdf@kernel.org>, kernel@pengutronix.de,
        Wu Hao <hao.wu@intel.com>
Date:   Mon, 29 Aug 2022 12:51:19 +0200
In-Reply-To: <YwyGWELZ7WfCE3FS@yilunxu-OptiPlex-7050>
References: <20220825141343.1375690-1-j.zink@pengutronix.de>
         <20220825141343.1375690-16-j.zink@pengutronix.de>
         <YwyGWELZ7WfCE3FS@yilunxu-OptiPlex-7050>
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

On Mon, 2022-08-29 at 17:26 +0800, Xu Yilun wrote:
> On 2022-08-25 at 16:13:42 +0200, Johannes Zink wrote:
> > Measurements showed that some FPGAs take significantly longer than
> > the
> > default wait function supplied. The datasheet inidicates up to 30
> > seconds erase times for some MachXO2 FPGAs, depending on the number
> > of
> > LUTs (and the corresponding configuration flash size).
> > 
> > Signed-off-by: Johannes Zink <j.zink@pengutronix.de>
> > ---
> >  drivers/fpga/machxo2-common.c | 28 ++++++++++++++++++++++++++--
> >  1 file changed, 26 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/fpga/machxo2-common.c b/drivers/fpga/machxo2-
> > common.c
> > index ccf9a50fc590..e8967cdee2c6 100644
> > --- a/drivers/fpga/machxo2-common.c
> > +++ b/drivers/fpga/machxo2-common.c
> > @@ -17,6 +17,8 @@
> >  #include <linux/module.h>
> >  #include <linux/of.h>
> >  #include <linux/property.h>
> > +#include <linux/iopoll.h>
> > +#include <linux/time.h>
> >  #include "machxo2-common.h"
> >  
> >  #define MACHXO2_LOW_DELAY_USEC          5
> > @@ -24,6 +26,8 @@
> >  #define MACHXO2_REFRESH_USEC            4800
> >  #define MACHXO2_MAX_BUSY_LOOP           128
> >  #define MACHXO2_MAX_REFRESH_LOOP        16
> > +#define MACHXO2_MAX_ERASE_USEC          (30 * USEC_PER_SEC)
> > +#define MACHXO2_ERASE_USEC_SLEEP        (20 * USEC_PER_MSEC)
> >  
> >  #define MACHXO2_PAGE_SIZE               16
> >  #define MACHXO2_BUF_SIZE                (MACHXO2_PAGE_SIZE + 4)
> > @@ -54,6 +58,18 @@
> >  #define ISC_ERASE_FEATURE_ROW  BIT(17)
> >  #define ISC_ERASE_UFM          BIT(19)
> >  
> > +static inline int machxo2_wait_until_not_busy_timeout(struct
> > machxo2_common_priv *priv)
> > +{
> > +       int ret, pollret;
> > +       u32 status = MACHXO2_BUSY;
> > +
> > +       pollret = read_poll_timeout(priv->get_status, ret,
> > +                                   (ret && ret != -EAGAIN) ||
> > !(status & MACHXO2_BUSY),
> > +                                   MACHXO2_ERASE_USEC_SLEEP,
> > MACHXO2_MAX_ERASE_USEC,
> > +                                   true, priv, &status);
> 
> Why just taking care of erase timeout? I see the busy wait in many
> places.
> 

Erasing the flash memory takes significantly longer than the other
operations (up to 30s), which is why I decided to use this separate
implementation. For other commands the fpga indicates no-more-busy much
faster than for the erase_flash command.

> > +
> > +       return ret ?: pollret;
> > +}
> >  
> >  static inline u8 get_err(u32 status)
> >  {
> > @@ -114,6 +130,12 @@ static int machxo2_cleanup(struct fpga_manager
> > *mgr)
> >         if (ret)
> >                 goto fail;
> >  
> > +       ret = machxo2_wait_until_not_busy_timeout(priv);
> > +       if (ret) {
> > +               dev_err(&mgr->dev, "Erase operation failed (%d)",
> > ret);
> > +               goto fail;
> > +       }
> > +
> >         ret = machxo2_wait_until_not_busy(priv);
> 
> Is this line still needed?

agreed, this line should become obsolete, since if we reach this point
the fpga is not indicating busy any longer or the wait has been aborted
due to an error. I will remove it in v2.

> 
> >         if (ret)
> >                 goto fail;
> > @@ -192,9 +214,11 @@ static int machxo2_write_init(struct
> > fpga_manager *mgr,
> >         if (ret)
> >                 goto fail;
> >  
> > -       ret = machxo2_wait_until_not_busy(priv);
> > -       if (ret)
> > +       ret = machxo2_wait_until_not_busy_timeout(priv);
> > +       if (ret) {
> > +               dev_err(&mgr->dev, "Erase operation failed (%d)",
> > ret);
> >                 goto fail;
> > +       }
> >  
> >         priv->get_status(priv, &status);
> >         if (status & MACHXO2_FAIL) {
> > -- 
> > 2.30.2
> > 
> 
> 

-- 
Pengutronix e.K.                | Johannes Zink                  |
Steuerwalder Str. 21            | https://www.pengutronix.de/    |
31137 Hildesheim, Germany       | Phone: +49-5121-206917-0       |
Amtsgericht Hildesheim, HRA 2686| Fax:   +49-5121-206917-5555    |

