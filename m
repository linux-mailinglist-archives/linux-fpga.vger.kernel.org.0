Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D98A5FAD8D
	for <lists+linux-fpga@lfdr.de>; Tue, 11 Oct 2022 09:32:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbiJKHa0 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 11 Oct 2022 03:30:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbiJKHaY (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 11 Oct 2022 03:30:24 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82961399C2
        for <linux-fpga@vger.kernel.org>; Tue, 11 Oct 2022 00:30:23 -0700 (PDT)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[127.0.0.1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1oi9iB-0005L5-Ui; Tue, 11 Oct 2022 09:30:00 +0200
Message-ID: <a755902d-f2ef-126a-c7aa-d75b264fa076@pengutronix.de>
Date:   Tue, 11 Oct 2022 09:29:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
Subject: Re: [PATCH v16 1/2] fpga: lattice-sysconfig-spi: add Lattice
 sysCONFIG FPGA manager
To:     Ivan Bornyakov <i.bornyakov@metrotek.ru>, mdf@kernel.org,
        hao.wu@intel.com, yilun.xu@intel.com, trix@redhat.com,
        dg@emlix.com, j.zink@pengutronix.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     devicetree@vger.kernel.org, system@metrotek.ru,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
References: <20221010172734.26037-1-i.bornyakov@metrotek.ru>
 <20221010172734.26037-2-i.bornyakov@metrotek.ru>
Content-Language: en-US
In-Reply-To: <20221010172734.26037-2-i.bornyakov@metrotek.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-fpga@vger.kernel.org
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hello Ivan,

On 10.10.22 19:27, Ivan Bornyakov wrote:
> Add support to the FPGA manager for programming Lattice ECP5 FPGA over
> slave SPI sysCONFIG interface.
> 
> sysCONFIG interface core functionality is separate from both ECP5 and
> SPI specifics, so support for other FPGAs with different port types can
> be added in the future.
> 
> Signed-off-by: Ivan Bornyakov <i.bornyakov@metrotek.ru>

I found a small issue with the probe function, see below. While at it,
I noted two nitpicks you could address.

> +static int sysconfig_spi_bitstream_burst_init(struct sysconfig_priv *priv)
> +{
> +	const u8 lsc_bitstream_burst[] = SYSCONFIG_LSC_BITSTREAM_BURST;
> +	struct spi_device *spi = to_spi_device(priv->dev);
> +	struct spi_transfer xfer = { 0 };

Nitpick: You want to zero all members. Using {} makes your
intention clearer even if they are functionally equivalent.

> +static int sysconfig_poll_busy(struct sysconfig_priv *priv)
> +{
> +	unsigned long timeout;
> +	int ret;
> +
> +	timeout = jiffies + msecs_to_jiffies(SYSCONFIG_POLL_BUSY_TIMEOUT_MS);
> +
> +	while (time_before(jiffies, timeout)) {
> +		ret = sysconfig_read_busy(priv);
> +		if (ret <= 0)
> +			return ret;
> +
> +		usleep_range(SYSCONFIG_POLL_INTERVAL_US,
> +			     SYSCONFIG_POLL_INTERVAL_US * 2);
> +	}

Nitpick: I believe you could rewrite that using read_poll_timeout().

> +int sysconfig_probe(struct sysconfig_priv *priv)

[snip]

> +	program = devm_gpiod_get_optional(dev, "program", GPIOD_OUT_LOW);
> +	if (IS_ERR(program)) {
> +		ret = PTR_ERR(program);
> +		dev_err(dev, "Failed to get PROGRAM GPIO: %d\n", ret);
> +		return ret;

This would print an error message for -EPROBE_DEFER, which just confuses users.
Please use dev_err_probe instead here and elsewhere in the probe function
to avoid this.

Cheers,
Ahmad

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
