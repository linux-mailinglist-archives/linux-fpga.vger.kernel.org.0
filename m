Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B15955FF167
	for <lists+linux-fpga@lfdr.de>; Fri, 14 Oct 2022 17:30:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230502AbiJNP2r (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 14 Oct 2022 11:28:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230440AbiJNP2j (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 14 Oct 2022 11:28:39 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F326165528;
        Fri, 14 Oct 2022 08:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665761318; x=1697297318;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5z/eMgxqqUuDg2RjLvj72J5xElrEO8SgLrrsw5yzTWI=;
  b=Glh2OkpvxbfD/VinJqInH76DXRgcU/RbCZjd4m4f+v4fQ24Rty31c62M
   T4m8RNS/4qjcriGsg5Qi9OrXExaLPB/vZqVBtcxtcwANocubV+w7e3PsW
   JkxNhhId00W6X0eI/7YnuZMYcgCvTLbqjGqH0ya+MAUMK8Nyl92p76Z2M
   vFw2YSLzgwDypLrUrxqPTBuj4cyftEQZCdsUMURV14VdLkyAoFfmittCS
   NHTHKJ+kMnV+QbAYx5OhTSJVYoiGMIOweNPV7BAGI5DRTJDuZpXebqmt9
   iBbD6tBHNn+S0ilFCDNh/PpoiXFqdSZo3rjzbhRAVdtQoqdbLRc/7zuE4
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10500"; a="292758293"
X-IronPort-AV: E=Sophos;i="5.95,184,1661842800"; 
   d="scan'208";a="292758293"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2022 08:28:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10500"; a="956619071"
X-IronPort-AV: E=Sophos;i="5.95,184,1661842800"; 
   d="scan'208";a="956619071"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmsmga005.fm.intel.com with ESMTP; 14 Oct 2022 08:28:34 -0700
Date:   Fri, 14 Oct 2022 23:19:29 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Ivan Bornyakov <i.bornyakov@metrotek.ru>
Cc:     mdf@kernel.org, hao.wu@intel.com, trix@redhat.com, dg@emlix.com,
        j.zink@pengutronix.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-fpga@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, system@metrotek.ru
Subject: Re: [PATCH v17 1/2] fpga: lattice-sysconfig-spi: add Lattice
 sysCONFIG FPGA manager
Message-ID: <Y0l+AbjGSOyTaoqV@yilunxu-OptiPlex-7050>
References: <20221011193821.21828-1-i.bornyakov@metrotek.ru>
 <20221011193821.21828-2-i.bornyakov@metrotek.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221011193821.21828-2-i.bornyakov@metrotek.ru>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 2022-10-11 at 22:38:20 +0300, Ivan Bornyakov wrote:
> Add support to the FPGA manager for programming Lattice ECP5 FPGA over
> slave SPI sysCONFIG interface.
> 
> sysCONFIG interface core functionality is separate from both ECP5 and
> SPI specifics, so support for other FPGAs with different port types can
> be added in the future.
> 
> Signed-off-by: Ivan Bornyakov <i.bornyakov@metrotek.ru>

[...]

> +
> +static int sysconfig_read_busy(struct sysconfig_priv *priv)
> +{
> +	const u8 lsc_check_busy[] = SYSCONFIG_LSC_CHECK_BUSY;
> +	u8 busy;
> +	int ret;
> +
> +	ret = sysconfig_cmd_read(priv, lsc_check_busy, sizeof(lsc_check_busy),
> +				 &busy, sizeof(busy));
> +
> +	return ret ? : busy;
> +}
> +
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
> +
> +	return -ETIMEDOUT;

As mentioned by Ahmad, could read_poll_timeout() be used?

> +}
> +
> +static int sysconfig_read_status(struct sysconfig_priv *priv, u32 *status)
> +{
> +	const u8 lsc_read_status[] = SYSCONFIG_LSC_READ_STATUS;
> +	__be32 device_status;
> +	int ret;
> +
> +	ret = sysconfig_cmd_read(priv, lsc_read_status, sizeof(lsc_read_status),
> +				 &device_status, sizeof(device_status));
> +	if (ret)
> +		return ret;
> +
> +	*status = be32_to_cpu(device_status);
> +
> +	return 0;
> +}
> +
> +static int sysconfig_poll_status(struct sysconfig_priv *priv, u32 *status)
> +{
> +	int ret = sysconfig_poll_busy(priv);
> +
> +	if (ret)
> +		return ret;
> +
> +	return sysconfig_read_status(priv, status);
> +}
> +
> +static int sysconfig_poll_gpio(struct gpio_desc *gpio, bool is_active)
> +{
> +	unsigned long timeout;
> +	int value;
> +
> +	timeout = jiffies + msecs_to_jiffies(SYSCONFIG_POLL_GPIO_TIMEOUT_MS);
> +
> +	while (time_before(jiffies, timeout)) {
> +		value = gpiod_get_value(gpio);
> +		if (value < 0)
> +			return value;
> +
> +		if ((is_active && value) || (!is_active && !value))
> +			return 0;
> +
> +		usleep_range(SYSCONFIG_POLL_INTERVAL_US,
> +			     SYSCONFIG_POLL_INTERVAL_US * 2);
> +	}
> +
> +	return -ETIMEDOUT;

Same.

[...]

> +int sysconfig_probe(struct sysconfig_priv *priv)
> +{
> +	struct gpio_desc *program, *init, *done;
> +	struct device *dev = priv->dev;
> +	struct fpga_manager *mgr;
> +
> +	if (!dev)
> +		return -ENODEV;
> +
> +	if (!priv->bitstream_burst_write_init) {
> +		dev_err(dev,
> +			"Callback for preparation for bitstream burst write is not defined\n");
> +		return -EOPNOTSUPP;

-EINVAL is better?

> +	}
> +
> +	if (!priv->bitstream_burst_write) {
> +		dev_err(dev,
> +			"Callback for bitstream burst write is not defined\n");
> +		return -EOPNOTSUPP;
> +	}
> +
> +	if (!priv->bitstream_burst_write_complete) {
> +		dev_err(dev,
> +			"Callback for finishing bitstream burst write is not defined\n");
> +		return -EOPNOTSUPP;
> +	}

command_transfer is optional?

And I think different err log for each missing callback is too trivial,
maybe just say like "ops missing" if any mandatory callback is missing.

> +
> +	program = devm_gpiod_get_optional(dev, "program", GPIOD_OUT_LOW);
> +	if (IS_ERR(program))
> +		return dev_err_probe(dev, PTR_ERR(program),
> +				     "Failed to get PROGRAM GPIO\n");
> +
> +	init = devm_gpiod_get_optional(dev, "init", GPIOD_IN);
> +	if (IS_ERR(init))
> +		return dev_err_probe(dev, PTR_ERR(init),
> +				     "Failed to get INIT GPIO\n");
> +
> +	done = devm_gpiod_get_optional(dev, "done", GPIOD_IN);
> +	if (IS_ERR(done))
> +		return dev_err_probe(dev, PTR_ERR(done),
> +				     "Failed to get DONE GPIO\n");
> +
> +	priv->program = program;
> +	priv->init = init;
> +	priv->done = done;
> +
> +	mgr = devm_fpga_mgr_register(dev, "Lattice sysCONFIG FPGA Manager",
> +				     &sysconfig_fpga_mgr_ops, priv);
> +
> +	return PTR_ERR_OR_ZERO(mgr);
> +}
> +EXPORT_SYMBOL(sysconfig_probe);
