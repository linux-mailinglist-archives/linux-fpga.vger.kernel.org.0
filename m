Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C53477240EB
	for <lists+linux-fpga@lfdr.de>; Tue,  6 Jun 2023 13:32:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236058AbjFFLaf (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 6 Jun 2023 07:30:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231438AbjFFLad (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 6 Jun 2023 07:30:33 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6961CE6B;
        Tue,  6 Jun 2023 04:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1686051030; x=1717587030;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=1aExAnW0X+A3tng6Saz83alMvXHIqXbV7B43ICYiFko=;
  b=0kz0f6ftl+dWmvA6OomN27QYb3gp8v22MVIbQhof3Ji04/uRW4Gl47Xh
   zORySthIYTGel4QO9AYo1heTxtVD5nYsbkNq72aoltKSQ4qmC5CxUvYQH
   JzS1scTD11MpeD5oJ6riQLdfgfbDTOR1PnQO3k4/8l400fapnVdMjRn7I
   oyEK9SSvUW2QjuBtEyDZMixdlqvnW8XEXMmy/IKU93Kdt2apq0tt1I7O+
   4kIgP0FG/wZVvvkIEkScXhH+3CeoynvEQIupWUt6u6DuktuscGb5sT1x4
   v/chcDq9VZO2qE8WgqWs7AukCXugXmO//npf5DClBHTABMBAxTTxif2Nn
   A==;
X-IronPort-AV: E=Sophos;i="6.00,221,1681196400"; 
   d="asc'?scan'208";a="214842237"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 06 Jun 2023 04:30:29 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 6 Jun 2023 04:30:28 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Tue, 6 Jun 2023 04:30:26 -0700
Date:   Tue, 6 Jun 2023 12:30:02 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     <linux-spi@vger.kernel.org>, <linux-fpga@vger.kernel.org>
CC:     Mark Brown <broonie@kernel.org>, <conor@kernel.org>,
        Vladimir Georgiev <v.georgiev@metrotek.ru>,
        Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
        <valentina.fernandezalanis@microchip.com>
Subject: [BUG] microchip-spi programming issue
Message-ID: <20230606-reentry-undusted-3c44fd7b4325@wendy>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xfLKQE2FOloqk0AN"
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

--xfLKQE2FOloqk0AN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hey folks,

A customer has reported an issue with the microchip-spi FPGA manager
driver that's causing programming of the FPGA to fail.
The culprit has been identified as the CS being deasserted between
the two transfers in mpf_spi_frame_write()

static int mpf_spi_frame_write(struct mpf_priv *priv, const char *buf)
{
	struct spi_transfer xfers[2] = {
		{
			.tx_buf = &priv->tx,
			.len = 1,
		}, {
			.tx_buf = buf,
			.len = MPF_SPI_FRAME_SIZE,
		},
	};
	int ret;

	ret = mpf_poll_status(priv, 0);
	if (ret < 0)
		return ret;

	priv->tx = MPF_SPI_FRAME;

	return spi_sync_transfer(priv->spi, xfers, ARRAY_SIZE(xfers));
}

which the system controller on the FPGA does not like & returns an
error.

I went poking around to see if this might've been another instance of
controller-specific behaviour like we'd seen fixes for during the
initial upstreaming of the driver, but I am not so sure this time
around that the fault is in the FPGA manager driver.

In spi.h, the kerneldoc for struct spi_transfer reads:
 * All SPI transfers start with the relevant chipselect active.  Normally
 * it stays selected until after the last transfer in a message.  Drivers
 * can affect the chipselect signal using cs_change

If I am not misunderstanding the SPI core, spi_sync_transfer() converts
the array of transfers into a message containing several transfers and
the controller should keep CS asserted between both transfers in this
message, since cs_change has not been set.

Following on from that, how strong is "normally" in the comment above?
Is it valid for a controller to deassert CS even if cs_change is not
set? Or have I totally misunderstood things and there's something
invalid about how the transfers are being set up in the driver?

The issue was reported against v6.1.20, but there have been no changes
to the SPI core or FPGA manager drivers in 6.1 kernels since v6.1.20.
The programming is being done with an i.MX8MP so I assume that
"nxp,imx8mp-fspi" or "fsl,imx8mp-ecspi" are the compatibles for the
controller in question.
The driver for the former doesn't appear to have been changed since
v6.1.20 & for the latter there is a single change, which would seem
unrelated.
If this isn't just me misunderstanding the SPI core, I'll go and request
the exact configuration.

The obvious/interim fix is to make sure that only one transfer is done,
but that seems like a hack to me. Either telling me I misunderstood the
SPI core and/or any suggestions about the correct flags for the
transfers would be really appreciated.

Cheers,
Conor.


--xfLKQE2FOloqk0AN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZH8YugAKCRB4tDGHoIJi
0vdVAQDz9eiLGyRGPfSJXT2Hng9xahF3WufsBbtwf2bQ/k5UtQEA3zwb3huerOVx
1ZahsrgIbUBp4BWzXLsKOKolmfoDOw4=
=nx49
-----END PGP SIGNATURE-----

--xfLKQE2FOloqk0AN--
