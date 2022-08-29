Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67C9F5A4DFF
	for <lists+linux-fpga@lfdr.de>; Mon, 29 Aug 2022 15:26:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbiH2NZL (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 29 Aug 2022 09:25:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbiH2NYt (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 29 Aug 2022 09:24:49 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E438D8A7C9
        for <linux-fpga@vger.kernel.org>; Mon, 29 Aug 2022 06:22:05 -0700 (PDT)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=irc.pengutronix.de)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <j.zink@pengutronix.de>)
        id 1oSehr-00082j-Ii; Mon, 29 Aug 2022 15:21:35 +0200
Message-ID: <2800bc77abb68c721feb5569608684414ae3f6be.camel@pengutronix.de>
Subject: Re: [PATCH 16/16] fpga: machxo2: add configuration over i2c
From:   Johannes Zink <j.zink@pengutronix.de>
To:     Xu Yilun <yilun.xu@intel.com>
Cc:     linux-fpga@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        kernel@pengutronix.de
Date:   Mon, 29 Aug 2022 15:21:19 +0200
In-Reply-To: <YwyLOSKy6kUFsFOB@yilunxu-OptiPlex-7050>
References: <20220825141343.1375690-1-j.zink@pengutronix.de>
         <20220825141343.1375690-17-j.zink@pengutronix.de>
         <YwyLOSKy6kUFsFOB@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: j.zink@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-fpga@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi Yilun, 

On Mon, 2022-08-29 at 17:47 +0800, Xu Yilun wrote:
> On 2022-08-25 at 16:13:43 +0200, Johannes Zink wrote:
> > From: Peter Jensen <pdj@bang-olufsen.dk>
> > 
> > The configuration flash of the machxo2 fpga can also be erased and
> > written over i2c instead of spi. Add this functionality to the
> > refactored common driver. Since some commands are shorter over I2C
> > than
> > they are over SPI some quirks are added to the common driver in
> > order to
> > account for that.
> > 
> > Signed-off-by: Peter Jensen <pdj@bang-olufsen.dk>
> > Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
> > Signed-off-by: Johannes Zink <j.zink@pengutronix.de>
> > ---

[snip]
> 

> > +static int machxo2_i2c_get_status(struct machxo2_common_priv *bus,
> > u32 *status)
> > +{
> > +       struct machxo2_i2c_priv *i2cPriv =
> > to_machxo2_i2c_priv(bus);
> > +       struct i2c_client *client = i2cPriv->client;
> > +       u8 read_status[] = LSC_READ_STATUS;
> 
> The command word could also be bus agnostic. I think a callback like
> write_then_read(bus, txbuf, n_tx, rxbuf, n_rx) could be a better
> abstraction.

I agree. The only command reading from the fpga is the get_status 
functionality but your proposal provides a cleaner implementation. 
I will add it in v2.
> 
> > +       __be32 tmp;
> > +       int ret;
> > +       struct i2c_msg msg[] = {
> > +               {
> > +                       .addr = client->addr,
> > +                       .flags = 0,
> > +                       .buf = read_status,
> > +                       .len = ARRAY_SIZE(read_status),
> > +               }, {
> > +                       .addr = client->addr,
> > +                       .flags = I2C_M_RD,
> > +                       .buf = (u8 *) &tmp,
> > +                       .len = sizeof(tmp)
> > +               }
> > +       };
> > +
> > +       ret = i2c_transfer(client->adapter, msg, ARRAY_SIZE(msg));
> > +       if (ret < 0)
> > +               return ret;
> > +       if (ret != ARRAY_SIZE(msg))
> > +               return -EIO;
> > +       *status = be32_to_cpu(tmp);
> > +
> > +       return 0;
> > +}
> > +
> > +static int machxo2_i2c_write(struct machxo2_common_priv *common,
> > +                            struct machxo2_cmd *cmds, size_t
> > cmd_count)
> > +{
> > +       struct machxo2_i2c_priv *i2c_priv =
> > to_machxo2_i2c_priv(common);
> > +       struct i2c_client *client = i2c_priv->client;
> > +       size_t i;
> > +       int ret;
> > +
> > +       for (i = 0; i < cmd_count; i++) {
> > +               struct i2c_msg msg[] = {
> > +                       {
> > +                               .addr = client->addr,
> > +                               .buf = cmds[i].cmd,
> > +                               .len = cmds[i].cmd_len,
> > +                       },
> > +               };
> > +
> > +               ret = i2c_transfer(client->adapter, msg,
> > ARRAY_SIZE(msg));
> > +               if (ret < 0)
> > +                       return ret;
> > +               if (ret != ARRAY_SIZE(msg))
> > +                       return -EIO;
> > +               if (cmds[i].delay_us)
> > +                       usleep_range(cmds[i].delay_us,
> > cmds[i].delay_us +
> > +                                    cmds[i].delay_us / 4);
> > +               if (i < cmd_count - 1) /* on any iteration except
> > for the last one... */
> > +                       ret = machxo2_wait_until_not_busy(common);
> 
> Seems no need to implement the loop and wait in transportation layer,
> they are common. A callback like write(bus, txbuf, n_tx) is better?
> 
> Thanks,
> Yilun

I have chosen this implementation mostly due to the fact that I don't
have a SPI machxo2 device to test against, so I am intentionally
keeping changes to a minimum. 

Moving the wait between single commands into the transport layer is not
functionally equivalent, e.g. the ISC_ENABLE - ISC_ERASE command
sequence in the machxo2_write_init function would require two separate
messages with a wait time between them, which would deassert the CS
line between sending the messages via SPI if not sent as a sequence of
SPI transfers. For some of the commands, the fpga requires a delay
between the different commands, which was implemented by setting the
delay property of the spi transfer objects in the original driver.

This implementation tries to mimic the timing behaviour of the SPI
transfer delay property for the I2C implementation. 

Best regards
Johannes

> 
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> > +static int machxo2_i2c_probe(struct i2c_client *client,
> > +                       const struct i2c_device_id *id)
> > +{
> > +       struct device *dev = &client->dev;
> > +       struct machxo2_i2c_priv *priv;
> > +
> > +       priv = devm_kzalloc(dev, sizeof(struct machxo2_i2c_priv),
> > GFP_KERNEL);
> > +       if (!priv)
> > +               return -ENOMEM;
> > +
> > +       priv->client = client;
> > +       priv->common.get_status = machxo2_i2c_get_status;
> > +       priv->common.write_commands = machxo2_i2c_write;
> > +
> > +       /* Commands are usually 4b, but these aren't for i2c */
> > +       priv->common.enable_3b = true;
> > +       priv->common.refresh_3b = true;
> > +
> > +       return machxo2_common_init(&priv->common, dev);
> > +}
> > +
> > +static const struct of_device_id of_match[] = {
> > +       { .compatible = "lattice,machxo2-slave-i2c", },
> > +       { },
> > +};
> > +MODULE_DEVICE_TABLE(of, of_match);
> > +
> > +static const struct i2c_device_id lattice_ids[] = {
> > +       { "machxo2-slave-i2c", 0 },
> > +       { },
> > +};
> > +MODULE_DEVICE_TABLE(i2c, lattice_ids);
> > +
> > +static struct i2c_driver machxo2_i2c_driver = {
> > +       .driver = {
> > +               .name = "machxo2-slave-i2c",
> > +               .of_match_table = of_match_ptr(of_match),
> > +       },
> > +       .probe = machxo2_i2c_probe,
> > +       .id_table = lattice_ids,
> > +};
> > +
> > +module_i2c_driver(machxo2_i2c_driver);
> > +
> > +MODULE_AUTHOR("Peter Jensen <pdj@bang-olufsen.dk>");
> > +MODULE_DESCRIPTION("Load Lattice FPGA firmware over I2C");
> > +MODULE_LICENSE("GPL");
> > -- 
> > 2.30.2
> > 
> 

-- 
Pengutronix e.K.                | Johannes Zink                  |
Steuerwalder Str. 21            | https://www.pengutronix.de/    |
31137 Hildesheim, Germany       | Phone: +49-5121-206917-0       |
Amtsgericht Hildesheim, HRA 2686| Fax:   +49-5121-206917-5555    |

