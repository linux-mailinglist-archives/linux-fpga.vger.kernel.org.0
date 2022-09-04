Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18A685AC3A3
	for <lists+linux-fpga@lfdr.de>; Sun,  4 Sep 2022 11:33:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233146AbiIDJaz (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 4 Sep 2022 05:30:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbiIDJay (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sun, 4 Sep 2022 05:30:54 -0400
Received: from mail.pr-group.ru (mail.pr-group.ru [178.18.215.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7C4F3AE5D;
        Sun,  4 Sep 2022 02:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
        d=metrotek.ru; s=mail;
        h=from:subject:date:message-id:to:cc:mime-version:content-type:in-reply-to:
         references;
        bh=PqeBpEnnPmllMIhmthofTdUEgeizN8inQGjDzYTEba8=;
        b=m95b5HkAAIa9pXzzRte5P+OB1TqFQUBrJxR5rfgHSgLlTARU4z0kV0rgSOZ18Mo3lUP+P1BK/NJc1
         bHCrfYlB1E0hbxj62o6fvUVPYcdRjoyOhGZWJ+wYFJQNaLKc2CStBmtjeA0s92KiRRDRCicb7bRFfY
         FHqgO8v0prT9qMa1mqDsjPEtVKP9bY15BdG+MLVjlNHfPt95DE0mddnM17l/qub2Wn1V3FjG0qMXSu
         2JsDA/ddUkxMKgVcOpfyYgjWMHXHgtxU1qDV7TrPkW7S3zhjMfkyrx7kzFX1ngyqqfrhDTvmklOHhS
         A9l/lkXs3/KYKFEmgTTcAMYzroh/f5Q==
X-Kerio-Anti-Spam:  Build: [Engines: 2.16.4.1445, Stamp: 3], Multi: [Enabled, t: (0.000011,0.026038)], BW: [Enabled, t: (0.000024,0.000002)], RTDA: [Enabled, t: (0.084246), Hit: No, Details: v2.41.0; Id: 15.52k0s3.1gc3td08h.57c; mclb], total: 0(700)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Level: 
X-Footer: bWV0cm90ZWsucnU=
Received: from x260 ([92.100.85.134])
        (authenticated user i.bornyakov@metrotek.ru)
        by mail.pr-group.ru with ESMTPSA
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits));
        Sun, 4 Sep 2022 12:30:41 +0300
Date:   Sun, 4 Sep 2022 12:04:10 +0300
From:   Ivan Bornyakov <i.bornyakov@metrotek.ru>
To:     Xu Yilun <yilun.xu@intel.com>
Cc:     mdf@kernel.org, hao.wu@intel.com, trix@redhat.com, dg@emlix.com,
        j.zink@pengutronix.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-fpga@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, system@metrotek.ru
Subject: Re: [PATCH v9 1/2] fpga: lattice-sysconfig-spi: add Lattice
 sysCONFIG FPGA manager
Message-ID: <20220904090410.cetopp34t33pc6uo@x260>
References: <20220830095405.31609-1-i.bornyakov@metrotek.ru>
 <20220830095405.31609-2-i.bornyakov@metrotek.ru>
 <YxOGh5Qu1SLzZKgU@yilunxu-OptiPlex-7050>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YxOGh5Qu1SLzZKgU@yilunxu-OptiPlex-7050>
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Sun, Sep 04, 2022 at 12:53:27AM +0800, Xu Yilun wrote:
> On 2022-08-30 at 12:54:04 +0300, Ivan Bornyakov wrote:
> > Add support to the FPGA manager for programming Lattice ECP5 and MachXO2
> > FPGAs over slave SPI sysCONFIG interface.
> > 
> > Signed-off-by: Ivan Bornyakov <i.bornyakov@metrotek.ru>
> > ---
> > 
> > ... snip ...
> > 
> > +static int sysconfig_spi_probe(struct spi_device *spi)
> > +{
> > +	const struct sysconfig_fpga_priv *fpga_priv;
> > +	const struct spi_device_id *dev_id;
> > +	struct device *dev = &spi->dev;
> > +	struct sysconfig_priv *priv;
> > +
> > +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> > +	if (!priv)
> > +		return -ENOMEM;
> > +
> > +	fpga_priv = of_device_get_match_data(dev);
> > +	if (!fpga_priv) {
> > +		dev_id = spi_get_device_id(spi);
> > +		if (!dev_id)
> > +			return -ENODEV;
> > +
> > +		fpga_priv = (const struct sysconfig_fpga_priv *)dev_id->driver_data;
> > +	}
> > +
> > +	if (!fpga_priv)
> > +		return -EINVAL;
> > +
> > +	if (spi->max_speed_hz > fpga_priv->spi_max_speed_hz) {
> > +		dev_err(dev, "SPI speed %u is too high, maximum speed is %u\n",
> > +			spi->max_speed_hz, fpga_priv->spi_max_speed_hz);
> > +		return -EINVAL;
> > +	}
> > +
> > +	priv->dev = dev;
> > +	priv->spi = spi;
> > +	priv->fpga_priv = fpga_priv;
> > +	priv->sysconfig_transfer = sysconfig_spi_transfer;
> > +	priv->sysconfig_fpga_mgr_ops.state = sysconfig_ops_state;
> > +	priv->sysconfig_fpga_mgr_ops.write_init = sysconfig_ops_write_init;
> 
> Why initialize the fpga_mgr_ops in spi driver? I think it should be the
> sysconfig core driver's job.
> 

The reasoning was that there is bus-specific write callback.

> > +	priv->sysconfig_fpga_mgr_ops.write = sysconfig_ops_spi_write;
> 
> We already have the transfer callback, why we need a special spi write
> here.
> 

Transfer callback performs transaction with single buffer on its input
(with optional read back). Paged write makes one write transaction with
two buffers, command + data, and it is only place where we need to
transfer several buffers. More of that, burst write needs locked bus.
IMHO, it is reasonable to have a bus-specific write.

> > +	priv->sysconfig_fpga_mgr_ops.write_complete = sysconfig_ops_write_complete;
> 
> same concern
> 
> > +
> > +	return sysconfig_probe(priv);
> > +}
> > +
> > 
> > ... snip ...
> > 
> > +int sysconfig_ops_write_init(struct fpga_manager *mgr,
> > +			     struct fpga_image_info *info,
> > +			     const char *buf, size_t count)
> > +{
> > +	const struct sysconfig_fpga_priv *fpga_priv;
> > +	struct sysconfig_priv *priv;
> > +	struct device *dev;
> > +	int ret;
> > +
> > +	dev = &mgr->dev;
> > +	priv = mgr->priv;
> > +	fpga_priv = priv->fpga_priv;
> > +
> > +	if (info->flags & FPGA_MGR_PARTIAL_RECONFIG) {
> > +		dev_err(dev, "Partial reconfiguration is not supported\n");
> > +		return -EOPNOTSUPP;
> > +	}
> > +
> > +	if (!fpga_priv->internal_flash) {
> > +		/* Write directly to SRAM */
> > +		ret = sysconfig_refresh(priv);
> > +		if (ret) {
> > +			dev_err(dev, "Failed to go to program mode\n");
> > +			return ret;
> > +		}
> > +	}
> > +
> > +	/* Enter ISC mode */
> > +	ret = sysconfig_isc_init(priv);
> > +	if (ret) {
> > +		dev_err(dev, "Failed to go to ISC mode\n");
> > +		return ret;
> > +	}
> > +
> > +	/* Initialize the Address Shift Register */
> > +	ret = sysconfig_lsc_init_addr(priv);
> > +	if (ret) {
> > +		dev_err(dev,
> > +			"Failed to initialize the Address Shift Register\n");
> > +		return ret;
> > +	}
> > +
> > +	if (fpga_priv->spi_burst_write) {
> > +		/* Prepare for SPI burst write */
> > +		ret = sysconfig_lsc_burst_init(priv);
> 
> Don't make the sysconfig.c dependent to sysconfig-spi.c, sysconfig.c
> should be common and workable without sysconfig-spi.c
> 

Agreed. How about separate this if-block to a bus-specific
sysconfig_ops_spi_write_init()?

> > +		if (ret)
> > +			dev_err(dev,
> > +				"Failed to prepare for bitstream burst write\n");
> > +	}
> > +
> > +	return ret;
> > +}
> > +
> > +static void sysconfig_cleanup(struct sysconfig_priv *priv)
> > +{
> > +	sysconfig_isc_erase(priv);
> > +	sysconfig_refresh(priv);
> > +}
> > 
> > ... snip ...
> > 
> > +int sysconfig_ops_write_complete(struct fpga_manager *mgr,
> > +				 struct fpga_image_info *info)
> > +{
> > +	const struct sysconfig_fpga_priv *fpga_priv;
> > +	struct sysconfig_priv *priv;
> > +	struct device *dev;
> > +	int ret;
> > +
> > +	dev = &mgr->dev;
> > +	priv = mgr->priv;
> > +	fpga_priv = priv->fpga_priv;
> > +
> > +	if (fpga_priv->spi_burst_write) {
> > +		ret = sysconfig_lsc_burst_complete(priv);
> 
> Same concern
> 

Same as above, how about sysconfig_ops_spi_write_complete()?

> > +		if (ret) {
> > +			dev_err(dev,
> > +				"Error while waiting bitstream write to finish\n");
> > +			goto fail;
> > +		}
> > +	}
> > +
> > +	if (fpga_priv->internal_flash) {
> > +		ret = sysconfig_isc_prog_done(priv);
> > +		if (!ret)
> > +			ret = sysconfig_refresh(priv);
> > +
> > +		if (ret) {
> > +			dev_err(dev, "Failed to enable Self-Download Mode\n");
> > +			goto fail;
> > +		}
> > +	}
> > +
> > +	ret = sysconfig_isc_finish(priv);
> > +
> > +fail:
> > +	if (ret)
> > +		sysconfig_cleanup(priv);
> > +
> > +	return ret;
> > +}
> > 
> > ... snip ...
> > 
> > +struct sysconfig_fpga_priv {
> > +	u32 spi_max_speed_hz;
> 
> Don't put bus specific stuff here, this should be common across all
> transport.
> 

Personally, I don't see why not. This struct is just a bunch of
FPGA-specific constants which may or may not be used by a bus-specific
sysCONFIG implementation. IMHO it is more convinient to define them in
one place.

> > +	u8 isc_enable_operand;
> > +	bool spi_burst_write;
> 
> same concern
> 
> > +	bool internal_flash;
> > +};
> > +
> > +extern const struct sysconfig_fpga_priv ecp5_data;
> > +extern const struct sysconfig_fpga_priv machxo2_data;
> > +
> > +struct sysconfig_priv {
> > +	struct fpga_manager_ops sysconfig_fpga_mgr_ops;
> > +	const struct sysconfig_fpga_priv *fpga_priv;
> > +	struct gpio_desc *program;
> > +	struct gpio_desc *init;
> > +	struct gpio_desc *done;
> > +	struct spi_device *spi;
> 
> same concern
> 

MachXO2's I2C isc_enable and lsc_refresh commands are 3-bytes long while
SPI variants are 4-bytes long. Having pointer to either spi_device or
i2c_client makes it easy to add quirks about transfer length to
sysconfig_isc_enable() and sysconfig_lsc_refresh() routines.

> > +	struct device *dev;
> > +	int (*sysconfig_transfer)(struct sysconfig_priv *priv,
> > +				  const void *tx_buf, size_t tx_len,
> > +				  void *rx_buf, size_t rx_len);
> > +};
> > +
> > +int sysconfig_poll_busy(struct sysconfig_priv *priv);
> > +int sysconfig_lsc_burst_init(struct sysconfig_priv *priv);
> > +int sysconfig_lsc_burst_complete(struct sysconfig_priv *priv);
> > +
> > +enum fpga_mgr_states sysconfig_ops_state(struct fpga_manager *mgr);
> > +int sysconfig_ops_write_init(struct fpga_manager *mgr,
> > +			     struct fpga_image_info *info,
> > +			     const char *buf, size_t count);
> > +int sysconfig_ops_write_complete(struct fpga_manager *mgr,
> > +				 struct fpga_image_info *info);
> > +
> > +int sysconfig_probe(struct sysconfig_priv *priv);
> > +
> > +#endif /* __LATTICE_SYSCONFIG_H */
> > -- 
> > 2.37.2
> > 
> > 

