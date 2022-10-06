Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E52CB5F654D
	for <lists+linux-fpga@lfdr.de>; Thu,  6 Oct 2022 13:38:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbiJFLhO (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 6 Oct 2022 07:37:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbiJFLhN (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 6 Oct 2022 07:37:13 -0400
Received: from mail.pr-group.ru (mail.pr-group.ru [178.18.215.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3D475282D;
        Thu,  6 Oct 2022 04:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
        d=metrotek.ru; s=mail;
        h=from:subject:date:message-id:to:cc:mime-version:content-type:in-reply-to:
         references;
        bh=GIY3bZi9HVXnvzyS5oqZMEDPucc/o9GlOvOqUP5eDF4=;
        b=ZgCCrz5AG8mTIuEGbaaSfXnrU6UKmmZa93dVuv7dmjF3czqQjtw9djJdHHKCogw4Sv1UOIGYQuezr
         tSGxwTaUJb/XYaOka8Me3wb3btZ24S0li7dbjWVi9ZUrWX7H/1oLNraI6mlwP01l+lh43NOJlt+e0F
         KWDZHROHatUGXDWyjAeIi+OkfjJstCH+uqPMlzfMA2PCSnltYd2WmwO3uqxDRM9oflMFbGSb+GN+aG
         Eu2nk99KfOg13WsjdM+zs2ycpfUmxGDz7GoemcrLAP9N9jkH8fzomMFg9BuPx2+1A4KSKtaWJ5t4r8
         5ED4p9+AYctkiiTazPHKe54uotyLS4Q==
X-Kerio-Anti-Spam:  Build: [Engines: 2.16.4.1445, Stamp: 3], Multi: [Enabled, t: (0.000008,0.010061)], BW: [Enabled, t: (0.000015,0.000001)], RTDA: [Enabled, t: (0.084681), Hit: No, Details: v2.42.0; Id: 15.52k1ra.1gemhbbfc.5bcm; mclb], total: 0(700)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Level: 
X-Footer: bWV0cm90ZWsucnU=
Received: from x260 ([92.100.86.33])
        (authenticated user i.bornyakov@metrotek.ru)
        by mail.pr-group.ru with ESMTPSA
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits));
        Thu, 6 Oct 2022 14:37:00 +0300
Date:   Thu, 6 Oct 2022 14:09:04 +0300
From:   Ivan Bornyakov <i.bornyakov@metrotek.ru>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     mdf@kernel.org, hao.wu@intel.com, yilun.xu@intel.com,
        trix@redhat.com, dg@emlix.com, j.zink@pengutronix.de,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        devicetree@vger.kernel.org, system@metrotek.ru,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
Subject: Re: [PATCH v14 1/2] fpga: lattice-sysconfig-spi: add Lattice
 sysCONFIG FPGA manager
Message-ID: <20221006110904.mj4wrcotmakfih6z@x260>
References: <20221006074449.24082-1-i.bornyakov@metrotek.ru>
 <20221006074449.24082-2-i.bornyakov@metrotek.ru>
 <20221006081801.xqnnvn6k7rmjokvt@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221006081801.xqnnvn6k7rmjokvt@pengutronix.de>
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Thu, Oct 06, 2022 at 10:18:01AM +0200, Marc Kleine-Budde wrote:
> On 06.10.2022 10:44:48, Ivan Bornyakov wrote:
> > Add support to the FPGA manager for programming Lattice ECP5 FPGA over
> > slave SPI sysCONFIG interface.
> > 
> > sysCONFIG interface core functionality is separate from both ECP5 and
> > SPI specifics, so support for other FPGAs with different port types can
> > be added in the future.
> > 
> > Signed-off-by: Ivan Bornyakov <i.bornyakov@metrotek.ru>
> > ---
> 
> [...]
> 
> > +static int sysconfig_spi_bitstream_burst_init(struct sysconfig_priv *priv)
> > +{
> > +	const u8 lsc_bitstream_burst[] = SYSCONFIG_LSC_BITSTREAM_BURST;
> 
> I think you're not allowed to use stack memory for SPI transfers. Better
> clarify this with the SPI people.
> 

You are right. Documentation/spi/spi-summary.rst says:

  - Follow standard kernel rules, and provide DMA-safe buffers in
    your messages.

Thanks for pointing out.

> > +	struct spi_device *spi = to_spi_device(priv->dev);
> > +	struct spi_transfer xfer = {
> > +		.tx_buf = lsc_bitstream_burst,
> > +		.len = sizeof(lsc_bitstream_burst),
> > +		.cs_change = 1,
> > +	};
> > +	struct spi_message msg;
> > +	int ret;
> > +
> > +	spi_message_init_with_transfers(&msg, &xfer, 1);
> > +
> > +	/*
> > +	 * Lock SPI bus for exclusive usage until FPGA programming is done.
> > +	 * SPI bus will be released in sysconfig_spi_bitstream_burst_complete().
> > +	 */
> > +	spi_bus_lock(spi->controller);
> > +
> > +	ret = spi_sync_locked(spi, &msg);
> > +	if (ret)
> > +		spi_bus_unlock(spi->controller);
> > +
> > +	return ret;
> > +}
> 
> regards,
> Marc
> 
> -- 
> Pengutronix e.K.                 | Marc Kleine-Budde           |
> Embedded Linux                   | https://www.pengutronix.de  |
> Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
> Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |



