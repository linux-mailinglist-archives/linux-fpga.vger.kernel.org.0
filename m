Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 752A15FF2F6
	for <lists+linux-fpga@lfdr.de>; Fri, 14 Oct 2022 19:26:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbiJNRY4 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 14 Oct 2022 13:24:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230333AbiJNRYz (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 14 Oct 2022 13:24:55 -0400
Received: from mail.pr-group.ru (mail.pr-group.ru [178.18.215.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9A3112743;
        Fri, 14 Oct 2022 10:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
        d=metrotek.ru; s=mail;
        h=from:subject:date:message-id:to:cc:mime-version:content-type:in-reply-to:
         references;
        bh=RG/Vz5vpl6JLRZINCyPYzhVyP5bdJxcuNZFvRAX9Res=;
        b=ZW1LfKEsUOx5oiUNL6oMb+2iBiPoBtUSS4QyAwpwiXS8nNm4UHqo8CbM831GT3Dw+0z5HN2Yw9KeT
         u0UfLEKaiZMzl1v1IJzMFJpxxe9vzt9z3k/R/0xhwQyEyky/5UsXJillfs/Un+Gu8w0v+Lqzhiy1CR
         nBs9nY8dw6FYC0up65jD/AG69dewevlF7ifTuiSBx9h1D/v2YknEbAkbc6V63rRuNvn3VBmllDjMs/
         jFM9RfJG745GcOE3eOcshDz4TvIUqROPfQagz1eLpbW00cGwRspU1tH0WdCwv+IdwvNX4k8yVkVzPF
         e7N/jSrPLJIWcGdZ5yjer2JXfieuumg==
X-Kerio-Anti-Spam:  Build: [Engines: 2.16.4.1445, Stamp: 3], Multi: [Enabled, t: (0.000010,0.017186)], BW: [Enabled, t: (0.000014,0.000001)], RTDA: [Enabled, t: (0.085087), Hit: No, Details: v2.42.0; Id: 15.52kqks.1gfbodkce.6tsu; mclb], total: 0(700)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Level: 
X-Footer: bWV0cm90ZWsucnU=
Received: from x260 ([92.100.86.33])
        (authenticated user i.bornyakov@metrotek.ru)
        by mail.pr-group.ru with ESMTPSA
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits));
        Fri, 14 Oct 2022 20:24:36 +0300
Date:   Fri, 14 Oct 2022 19:56:20 +0300
From:   Ivan Bornyakov <i.bornyakov@metrotek.ru>
To:     Xu Yilun <yilun.xu@intel.com>
Cc:     mdf@kernel.org, hao.wu@intel.com, trix@redhat.com, dg@emlix.com,
        j.zink@pengutronix.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-fpga@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, system@metrotek.ru
Subject: Re: [PATCH v17 1/2] fpga: lattice-sysconfig-spi: add Lattice
 sysCONFIG FPGA manager
Message-ID: <20221014165620.stw763ve7jlda54z@x260>
References: <20221011193821.21828-1-i.bornyakov@metrotek.ru>
 <20221011193821.21828-2-i.bornyakov@metrotek.ru>
 <Y0l+AbjGSOyTaoqV@yilunxu-OptiPlex-7050>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y0l+AbjGSOyTaoqV@yilunxu-OptiPlex-7050>
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Fri, Oct 14, 2022 at 11:19:29PM +0800, Xu Yilun wrote:
> On 2022-10-11 at 22:38:20 +0300, Ivan Bornyakov wrote:
> > Add support to the FPGA manager for programming Lattice ECP5 FPGA over
> > slave SPI sysCONFIG interface.
> > 
> > sysCONFIG interface core functionality is separate from both ECP5 and
> > SPI specifics, so support for other FPGAs with different port types can
> > be added in the future.
> > 
> > Signed-off-by: Ivan Bornyakov <i.bornyakov@metrotek.ru>
> 
> [...]
> 
> > +
> > +static int sysconfig_read_busy(struct sysconfig_priv *priv)
> > +{
> > +	const u8 lsc_check_busy[] = SYSCONFIG_LSC_CHECK_BUSY;
> > +	u8 busy;
> > +	int ret;
> > +
> > +	ret = sysconfig_cmd_read(priv, lsc_check_busy, sizeof(lsc_check_busy),
> > +				 &busy, sizeof(busy));
> > +
> > +	return ret ? : busy;
> > +}
> > +
> > +static int sysconfig_poll_busy(struct sysconfig_priv *priv)
> > +{
> > +	unsigned long timeout;
> > +	int ret;
> > +
> > +	timeout = jiffies + msecs_to_jiffies(SYSCONFIG_POLL_BUSY_TIMEOUT_MS);
> > +
> > +	while (time_before(jiffies, timeout)) {
> > +		ret = sysconfig_read_busy(priv);
> > +		if (ret <= 0)
> > +			return ret;
> > +
> > +		usleep_range(SYSCONFIG_POLL_INTERVAL_US,
> > +			     SYSCONFIG_POLL_INTERVAL_US * 2);
> > +	}
> > +
> > +	return -ETIMEDOUT;
> 
> As mentioned by Ahmad, could read_poll_timeout() be used?
> 

Surely, it could. IMHO it's just easier to read this way...

> > +}
> > +
> > +static int sysconfig_read_status(struct sysconfig_priv *priv, u32 *status)
> > +{
> > +	const u8 lsc_read_status[] = SYSCONFIG_LSC_READ_STATUS;
> > +	__be32 device_status;
> > +	int ret;
> > +
> > +	ret = sysconfig_cmd_read(priv, lsc_read_status, sizeof(lsc_read_status),
> > +				 &device_status, sizeof(device_status));
> > +	if (ret)
> > +		return ret;
> > +
> > +	*status = be32_to_cpu(device_status);
> > +
> > +	return 0;
> > +}
> > +
> > +static int sysconfig_poll_status(struct sysconfig_priv *priv, u32 *status)
> > +{
> > +	int ret = sysconfig_poll_busy(priv);
> > +
> > +	if (ret)
> > +		return ret;
> > +
> > +	return sysconfig_read_status(priv, status);
> > +}
> > +
> > +static int sysconfig_poll_gpio(struct gpio_desc *gpio, bool is_active)
> > +{
> > +	unsigned long timeout;
> > +	int value;
> > +
> > +	timeout = jiffies + msecs_to_jiffies(SYSCONFIG_POLL_GPIO_TIMEOUT_MS);
> > +
> > +	while (time_before(jiffies, timeout)) {
> > +		value = gpiod_get_value(gpio);
> > +		if (value < 0)
> > +			return value;
> > +
> > +		if ((is_active && value) || (!is_active && !value))
> > +			return 0;
> > +
> > +		usleep_range(SYSCONFIG_POLL_INTERVAL_US,
> > +			     SYSCONFIG_POLL_INTERVAL_US * 2);
> > +	}
> > +
> > +	return -ETIMEDOUT;
> 
> Same.
> 
> [...]
> 
> > +int sysconfig_probe(struct sysconfig_priv *priv)
> > +{
> > +	struct gpio_desc *program, *init, *done;
> > +	struct device *dev = priv->dev;
> > +	struct fpga_manager *mgr;
> > +
> > +	if (!dev)
> > +		return -ENODEV;
> > +
> > +	if (!priv->bitstream_burst_write_init) {
> > +		dev_err(dev,
> > +			"Callback for preparation for bitstream burst write is not defined\n");
> > +		return -EOPNOTSUPP;
> 
> -EINVAL is better?
> 
> > +	}
> > +
> > +	if (!priv->bitstream_burst_write) {
> > +		dev_err(dev,
> > +			"Callback for bitstream burst write is not defined\n");
> > +		return -EOPNOTSUPP;
> > +	}
> > +
> > +	if (!priv->bitstream_burst_write_complete) {
> > +		dev_err(dev,
> > +			"Callback for finishing bitstream burst write is not defined\n");
> > +		return -EOPNOTSUPP;
> > +	}
> 
> command_transfer is optional?
> 
> And I think different err log for each missing callback is too trivial,
> maybe just say like "ops missing" if any mandatory callback is missing.
> 
> > +
> > +	program = devm_gpiod_get_optional(dev, "program", GPIOD_OUT_LOW);
> > +	if (IS_ERR(program))
> > +		return dev_err_probe(dev, PTR_ERR(program),
> > +				     "Failed to get PROGRAM GPIO\n");
> > +
> > +	init = devm_gpiod_get_optional(dev, "init", GPIOD_IN);
> > +	if (IS_ERR(init))
> > +		return dev_err_probe(dev, PTR_ERR(init),
> > +				     "Failed to get INIT GPIO\n");
> > +
> > +	done = devm_gpiod_get_optional(dev, "done", GPIOD_IN);
> > +	if (IS_ERR(done))
> > +		return dev_err_probe(dev, PTR_ERR(done),
> > +				     "Failed to get DONE GPIO\n");
> > +
> > +	priv->program = program;
> > +	priv->init = init;
> > +	priv->done = done;
> > +
> > +	mgr = devm_fpga_mgr_register(dev, "Lattice sysCONFIG FPGA Manager",
> > +				     &sysconfig_fpga_mgr_ops, priv);
> > +
> > +	return PTR_ERR_OR_ZERO(mgr);
> > +}
> > +EXPORT_SYMBOL(sysconfig_probe);

