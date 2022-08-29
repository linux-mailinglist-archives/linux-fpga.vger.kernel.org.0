Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 114A75A4FE0
	for <lists+linux-fpga@lfdr.de>; Mon, 29 Aug 2022 17:10:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbiH2PIc (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 29 Aug 2022 11:08:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbiH2PIb (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 29 Aug 2022 11:08:31 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72F44915F7;
        Mon, 29 Aug 2022 08:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661785710; x=1693321710;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=weji2E4AUA2TCOGEXrAtqAPWWstyHsAZYp8zZkqwjN0=;
  b=GEUm89MGvO9C7fK5tp2U0wztTdqVKsmFDCDvbM0YPSQiJqLtU8V/U3SH
   ZLO6YFdwuE7+xwQjUgSZ3SSCLv8WbZLFWRFNLZo5O85WciU+K7KPA1oaw
   uKPFIE53+x/BxE+h8N8K0nhae8awgWjCKcyaI0zUuDMn/JwENfKZfB/nh
   7kazJA5kMQBg9YHm6FhTpOCyraN4UxlBs9UK9elhBmglF0TXbtJQiJJx5
   px1DQSvcZTwYXnmIWHR58SGnNHwXKtGbdZm1BuYgILB8xH6zZS1kf74MV
   Eri03Wjs75OVXdLcId7lfeTiKe2KXHjr0ixe8PK+03SShPL3uJ8/A4moP
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10454"; a="292493237"
X-IronPort-AV: E=Sophos;i="5.93,272,1654585200"; 
   d="scan'208";a="292493237"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2022 07:55:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,272,1654585200"; 
   d="scan'208";a="672405074"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmsmga008.fm.intel.com with ESMTP; 29 Aug 2022 07:54:44 -0700
Date:   Mon, 29 Aug 2022 22:45:26 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Johannes Zink <j.zink@pengutronix.de>
Cc:     linux-fpga@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        kernel@pengutronix.de
Subject: Re: [PATCH 16/16] fpga: machxo2: add configuration over i2c
Message-ID: <YwzRBmXMV4o8aGO4@yilunxu-OptiPlex-7050>
References: <20220825141343.1375690-1-j.zink@pengutronix.de>
 <20220825141343.1375690-17-j.zink@pengutronix.de>
 <YwyLOSKy6kUFsFOB@yilunxu-OptiPlex-7050>
 <2800bc77abb68c721feb5569608684414ae3f6be.camel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2800bc77abb68c721feb5569608684414ae3f6be.camel@pengutronix.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 2022-08-29 at 15:21:19 +0200, Johannes Zink wrote:
> Hi Yilun, 
> 
> On Mon, 2022-08-29 at 17:47 +0800, Xu Yilun wrote:
> > On 2022-08-25 at 16:13:43 +0200, Johannes Zink wrote:
> > > From: Peter Jensen <pdj@bang-olufsen.dk>
> > > 
> > > The configuration flash of the machxo2 fpga can also be erased and
> > > written over i2c instead of spi. Add this functionality to the
> > > refactored common driver. Since some commands are shorter over I2C
> > > than
> > > they are over SPI some quirks are added to the common driver in
> > > order to
> > > account for that.
> > > 
> > > Signed-off-by: Peter Jensen <pdj@bang-olufsen.dk>
> > > Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
> > > Signed-off-by: Johannes Zink <j.zink@pengutronix.de>
> > > ---
> 
> [snip]
> > 
> 
> > > +static int machxo2_i2c_get_status(struct machxo2_common_priv *bus,
> > > u32 *status)
> > > +{
> > > +       struct machxo2_i2c_priv *i2cPriv =
> > > to_machxo2_i2c_priv(bus);
> > > +       struct i2c_client *client = i2cPriv->client;
> > > +       u8 read_status[] = LSC_READ_STATUS;
> > 
> > The command word could also be bus agnostic. I think a callback like
> > write_then_read(bus, txbuf, n_tx, rxbuf, n_rx) could be a better
> > abstraction.
> 
> I agree. The only command reading from the fpga is the get_status 
> functionality but your proposal provides a cleaner implementation. 
> I will add it in v2.
> > 
> > > +       __be32 tmp;
> > > +       int ret;
> > > +       struct i2c_msg msg[] = {
> > > +               {
> > > +                       .addr = client->addr,
> > > +                       .flags = 0,
> > > +                       .buf = read_status,
> > > +                       .len = ARRAY_SIZE(read_status),
> > > +               }, {
> > > +                       .addr = client->addr,
> > > +                       .flags = I2C_M_RD,
> > > +                       .buf = (u8 *) &tmp,
> > > +                       .len = sizeof(tmp)
> > > +               }
> > > +       };
> > > +
> > > +       ret = i2c_transfer(client->adapter, msg, ARRAY_SIZE(msg));
> > > +       if (ret < 0)
> > > +               return ret;
> > > +       if (ret != ARRAY_SIZE(msg))
> > > +               return -EIO;
> > > +       *status = be32_to_cpu(tmp);
> > > +
> > > +       return 0;
> > > +}
> > > +
> > > +static int machxo2_i2c_write(struct machxo2_common_priv *common,
> > > +                            struct machxo2_cmd *cmds, size_t
> > > cmd_count)
> > > +{
> > > +       struct machxo2_i2c_priv *i2c_priv =
> > > to_machxo2_i2c_priv(common);
> > > +       struct i2c_client *client = i2c_priv->client;
> > > +       size_t i;
> > > +       int ret;
> > > +
> > > +       for (i = 0; i < cmd_count; i++) {
> > > +               struct i2c_msg msg[] = {
> > > +                       {
> > > +                               .addr = client->addr,
> > > +                               .buf = cmds[i].cmd,
> > > +                               .len = cmds[i].cmd_len,
> > > +                       },
> > > +               };
> > > +
> > > +               ret = i2c_transfer(client->adapter, msg,
> > > ARRAY_SIZE(msg));
> > > +               if (ret < 0)
> > > +                       return ret;
> > > +               if (ret != ARRAY_SIZE(msg))
> > > +                       return -EIO;
> > > +               if (cmds[i].delay_us)
> > > +                       usleep_range(cmds[i].delay_us,
> > > cmds[i].delay_us +
> > > +                                    cmds[i].delay_us / 4);
> > > +               if (i < cmd_count - 1) /* on any iteration except
> > > for the last one... */
> > > +                       ret = machxo2_wait_until_not_busy(common);
> > 
> > Seems no need to implement the loop and wait in transportation layer,
> > they are common. A callback like write(bus, txbuf, n_tx) is better?
> > 
> > Thanks,
> > Yilun
> 
> I have chosen this implementation mostly due to the fact that I don't
> have a SPI machxo2 device to test against, so I am intentionally
> keeping changes to a minimum. 
> 
> Moving the wait between single commands into the transport layer is not
> functionally equivalent, e.g. the ISC_ENABLE - ISC_ERASE command
> sequence in the machxo2_write_init function would require two separate
> messages with a wait time between them, which would deassert the CS
> line between sending the messages via SPI if not sent as a sequence of
> SPI transfers. For some of the commands, the fpga requires a delay
> between the different commands, which was implemented by setting the
> delay property of the spi transfer objects in the original driver.

Not sure if it is really a problem, but I remember SPI has various APIs
to deal with different requirements.

> 
> This implementation tries to mimic the timing behaviour of the SPI
> transfer delay property for the I2C implementation. 

Could you firstly try on that until we have real problem? Ideally this
is a cleaner implementation, is it?

Thanks,
Yilun

> 
> Best regards
> Johannes
> 
> > 
> > > +       }
> > > +
> > > +       return 0;
> > > +}
> > > +
> > > +static int machxo2_i2c_probe(struct i2c_client *client,
> > > +                       const struct i2c_device_id *id)
> > > +{
> > > +       struct device *dev = &client->dev;
> > > +       struct machxo2_i2c_priv *priv;
> > > +
> > > +       priv = devm_kzalloc(dev, sizeof(struct machxo2_i2c_priv),
> > > GFP_KERNEL);
> > > +       if (!priv)
> > > +               return -ENOMEM;
> > > +
> > > +       priv->client = client;
> > > +       priv->common.get_status = machxo2_i2c_get_status;
> > > +       priv->common.write_commands = machxo2_i2c_write;
> > > +
> > > +       /* Commands are usually 4b, but these aren't for i2c */
> > > +       priv->common.enable_3b = true;
> > > +       priv->common.refresh_3b = true;
> > > +
> > > +       return machxo2_common_init(&priv->common, dev);
> > > +}
> > > +
> > > +static const struct of_device_id of_match[] = {
> > > +       { .compatible = "lattice,machxo2-slave-i2c", },
> > > +       { },
> > > +};
> > > +MODULE_DEVICE_TABLE(of, of_match);
> > > +
> > > +static const struct i2c_device_id lattice_ids[] = {
> > > +       { "machxo2-slave-i2c", 0 },
> > > +       { },
> > > +};
> > > +MODULE_DEVICE_TABLE(i2c, lattice_ids);
> > > +
> > > +static struct i2c_driver machxo2_i2c_driver = {
> > > +       .driver = {
> > > +               .name = "machxo2-slave-i2c",
> > > +               .of_match_table = of_match_ptr(of_match),
> > > +       },
> > > +       .probe = machxo2_i2c_probe,
> > > +       .id_table = lattice_ids,
> > > +};
> > > +
> > > +module_i2c_driver(machxo2_i2c_driver);
> > > +
> > > +MODULE_AUTHOR("Peter Jensen <pdj@bang-olufsen.dk>");
> > > +MODULE_DESCRIPTION("Load Lattice FPGA firmware over I2C");
> > > +MODULE_LICENSE("GPL");
> > > -- 
> > > 2.30.2
> > > 
> > 
> 
> -- 
> Pengutronix e.K.                | Johannes Zink                  |
> Steuerwalder Str. 21            | https://www.pengutronix.de/    |
> 31137 Hildesheim, Germany       | Phone: +49-5121-206917-0       |
> Amtsgericht Hildesheim, HRA 2686| Fax:   +49-5121-206917-5555    |
> 
