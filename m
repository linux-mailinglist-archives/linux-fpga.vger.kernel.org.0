Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A3EC5A82B3
	for <lists+linux-fpga@lfdr.de>; Wed, 31 Aug 2022 18:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbiHaQHg (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 31 Aug 2022 12:07:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbiHaQHf (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 31 Aug 2022 12:07:35 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B59143E6A
        for <linux-fpga@vger.kernel.org>; Wed, 31 Aug 2022 09:07:34 -0700 (PDT)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=irc.pengutronix.de)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <j.zink@pengutronix.de>)
        id 1oTQFV-00054L-2N; Wed, 31 Aug 2022 18:07:29 +0200
Message-ID: <37ca25e23d9f7678c14074546ed3ed5d7bf6104e.camel@pengutronix.de>
Subject: Re: [PATCH 16/16] fpga: machxo2: add configuration over i2c
From:   Johannes Zink <j.zink@pengutronix.de>
To:     Xu Yilun <yilun.xu@intel.com>
Cc:     devicetree@vger.kernel.org, linux-fpga@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Moritz Fischer <mdf@kernel.org>, kernel@pengutronix.de,
        Wu Hao <hao.wu@intel.com>
Date:   Wed, 31 Aug 2022 18:07:11 +0200
In-Reply-To: <YwzRBmXMV4o8aGO4@yilunxu-OptiPlex-7050>
References: <20220825141343.1375690-1-j.zink@pengutronix.de>
         <20220825141343.1375690-17-j.zink@pengutronix.de>
         <YwyLOSKy6kUFsFOB@yilunxu-OptiPlex-7050>
         <2800bc77abb68c721feb5569608684414ae3f6be.camel@pengutronix.de>
         <YwzRBmXMV4o8aGO4@yilunxu-OptiPlex-7050>
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

On Mon, 2022-08-29 at 22:45 +0800, Xu Yilun wrote:
> On 2022-08-29 at 15:21:19 +0200, Johannes Zink wrote:
> > Hi Yilun, 
> > 
> > On Mon, 2022-08-29 at 17:47 +0800, Xu Yilun wrote:
> > > On 2022-08-25 at 16:13:43 +0200, Johannes Zink wrote:
> > > > From: Peter Jensen <pdj@bang-olufsen.dk>
> > > > 
> > > > The configuration flash of the machxo2 fpga can also be erased
> > > > and
> > > > written over i2c instead of spi. Add this functionality to the
> > > > refactored common driver. Since some commands are shorter over
> > > > I2C
> > > > than
> > > > they are over SPI some quirks are added to the common driver in
> > > > order to
> > > > account for that.
> > > > 
> > > > Signed-off-by: Peter Jensen <pdj@bang-olufsen.dk>
> > > > Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
> > > > Signed-off-by: Johannes Zink <j.zink@pengutronix.de>
> > > > ---
[snip]
> > > > 
> > 
> > > 
> > > > +
> > > > +static int machxo2_i2c_write(struct machxo2_common_priv
> > > > *common,
> > > > +                            struct machxo2_cmd *cmds, size_t
> > > > cmd_count)
> > > > +{
> > > > +       struct machxo2_i2c_priv *i2c_priv =
> > > > to_machxo2_i2c_priv(common);
> > > > +       struct i2c_client *client = i2c_priv->client;
> > > > +       size_t i;
> > > > +       int ret;
> > > > +
> > > > +       for (i = 0; i < cmd_count; i++) {
> > > > +               struct i2c_msg msg[] = {
> > > > +                       {
> > > > +                               .addr = client->addr,
> > > > +                               .buf = cmds[i].cmd,
> > > > +                               .len = cmds[i].cmd_len,
> > > > +                       },
> > > > +               };
> > > > +
> > > > +               ret = i2c_transfer(client->adapter, msg,
> > > > ARRAY_SIZE(msg));
> > > > +               if (ret < 0)
> > > > +                       return ret;
> > > > +               if (ret != ARRAY_SIZE(msg))
> > > > +                       return -EIO;
> > > > +               if (cmds[i].delay_us)
> > > > +                       usleep_range(cmds[i].delay_us,
> > > > cmds[i].delay_us +
> > > > +                                    cmds[i].delay_us / 4);
> > > > +               if (i < cmd_count - 1) /* on any iteration
> > > > except
> > > > for the last one... */
> > > > +                       ret =
> > > > machxo2_wait_until_not_busy(common);
> > > 
> > > Seems no need to implement the loop and wait in transportation
> > > layer,
> > > they are common. A callback like write(bus, txbuf, n_tx) is
> > > better?
> > > 
> > > Thanks,
> > > Yilun
> > 
> > I have chosen this implementation mostly due to the fact that I
> > don't
> > have a SPI machxo2 device to test against, so I am intentionally
> > keeping changes to a minimum. 
> > 
> > Moving the wait between single commands into the transport layer is
> > not
> > functionally equivalent, e.g. the ISC_ENABLE - ISC_ERASE command
> > sequence in the machxo2_write_init function would require two
> > separate
> > messages with a wait time between them, which would deassert the CS
> > line between sending the messages via SPI if not sent as a sequence
> > of
> > SPI transfers. For some of the commands, the fpga requires a delay
> > between the different commands, which was implemented by setting
> > the
> > delay property of the spi transfer objects in the original driver.
> 
> Not sure if it is really a problem, but I remember SPI has various
> APIs
> to deal with different requirements.

I assume this could probably be implemented by clearing the cs_change
bit in the SPI transfer, though just sending multiple transfers in
sequence with the appropriate timing appears a bit more elegant to me,
since it doesn't reimplement the behaviour for spi, it simply extends
the i2c part for what is not supported natively in the i2c api. Either
way, some sort of waiting has to be implemented (please see my comment
below).

Also, please bear in mind that I do not have SPI connected on my board,
which is why I opted to stay as close as possible to the original
implementation and only refactor the spi transfers with functionally
equivalent code in order to keep the risk of breaking things as low as
possible.

> 
> > 
> > This implementation tries to mimic the timing behaviour of the SPI
> > transfer delay property for the I2C implementation. 
> 
> Could you firstly try on that until we have real problem? Ideally
> this
> is a cleaner implementation, is it?

The delays themselves are required by the device family datasheet and
by the sysConfig protocol definition, as part of the command sequence
timing. 

Since I have no SPI connected on my hardware, I am only able to test
the I2C implementation, which works well with the timings taken from
the original spi driver (except for the erase timeout, which needs to
be extended as seen in Patch 15 of this series). Extending the delay
times such that usleep_range can be used has proven to be acceptable,
at least for the i2c implementation. 

Best regards
Johannes

> 
> Thanks,
> Yilun
> 
> > 
> > Best regards
> > Johannes
> > 
> > > 
> > > > +       }
> > > > +
> > > > +       return 0;
> > > > +}
> > > > +
> > > > +static int machxo2_i2c_probe(struct i2c_client *client,
> > > > +                       const struct i2c_device_id *id)
> > > > +{
> > > > +       struct device *dev = &client->dev;
> > > > +       struct machxo2_i2c_priv *priv;
> > > > +
> > > > +       priv = devm_kzalloc(dev, sizeof(struct
> > > > machxo2_i2c_priv),
> > > > GFP_KERNEL);
> > > > +       if (!priv)
> > > > +               return -ENOMEM;
> > > > +
> > > > +       priv->client = client;
> > > > +       priv->common.get_status = machxo2_i2c_get_status;
> > > > +       priv->common.write_commands = machxo2_i2c_write;
> > > > +
> > > > +       /* Commands are usually 4b, but these aren't for i2c */
> > > > +       priv->common.enable_3b = true;
> > > > +       priv->common.refresh_3b = true;
> > > > +
> > > > +       return machxo2_common_init(&priv->common, dev);
> > > > +}
> > > > +
> > > > +static const struct of_device_id of_match[] = {
> > > > +       { .compatible = "lattice,machxo2-slave-i2c", },
> > > > +       { },
> > > > +};
> > > > +MODULE_DEVICE_TABLE(of, of_match);
> > > > +
> > > > +static const struct i2c_device_id lattice_ids[] = {
> > > > +       { "machxo2-slave-i2c", 0 },
> > > > +       { },
> > > > +};
> > > > +MODULE_DEVICE_TABLE(i2c, lattice_ids);
> > > > +
> > > > +static struct i2c_driver machxo2_i2c_driver = {
> > > > +       .driver = {
> > > > +               .name = "machxo2-slave-i2c",
> > > > +               .of_match_table = of_match_ptr(of_match),
> > > > +       },
> > > > +       .probe = machxo2_i2c_probe,
> > > > +       .id_table = lattice_ids,
> > > > +};
> > > > +
> > > > +module_i2c_driver(machxo2_i2c_driver);
> > > > +
> > > > +MODULE_AUTHOR("Peter Jensen <pdj@bang-olufsen.dk>");
> > > > +MODULE_DESCRIPTION("Load Lattice FPGA firmware over I2C");
> > > > +MODULE_LICENSE("GPL");
> > > > -- 
> > > > 2.30.2
-- 
Pengutronix e.K.                | Johannes Zink                  |
Steuerwalder Str. 21            | https://www.pengutronix.de/    |
31137 Hildesheim, Germany       | Phone: +49-5121-206917-0       |
Amtsgericht Hildesheim, HRA 2686| Fax:   +49-5121-206917-5555    |

