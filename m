Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E04A45F6277
	for <lists+linux-fpga@lfdr.de>; Thu,  6 Oct 2022 10:20:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230503AbiJFISc (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 6 Oct 2022 04:18:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230516AbiJFISb (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 6 Oct 2022 04:18:31 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8696C7F277
        for <linux-fpga@vger.kernel.org>; Thu,  6 Oct 2022 01:18:30 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1ogM4x-0002S2-VO; Thu, 06 Oct 2022 10:18:04 +0200
Received: from pengutronix.de (unknown [IPv6:2a01:4f8:1c1c:29e9:22:41ff:fe00:1400])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 7C604F5F5E;
        Thu,  6 Oct 2022 08:18:02 +0000 (UTC)
Date:   Thu, 6 Oct 2022 10:18:01 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Ivan Bornyakov <i.bornyakov@metrotek.ru>
Cc:     mdf@kernel.org, hao.wu@intel.com, yilun.xu@intel.com,
        trix@redhat.com, dg@emlix.com, j.zink@pengutronix.de,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        devicetree@vger.kernel.org, system@metrotek.ru,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
Subject: Re: [PATCH v14 1/2] fpga: lattice-sysconfig-spi: add Lattice
 sysCONFIG FPGA manager
Message-ID: <20221006081801.xqnnvn6k7rmjokvt@pengutronix.de>
References: <20221006074449.24082-1-i.bornyakov@metrotek.ru>
 <20221006074449.24082-2-i.bornyakov@metrotek.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cstclkxk6l4zuxkt"
Content-Disposition: inline
In-Reply-To: <20221006074449.24082-2-i.bornyakov@metrotek.ru>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-fpga@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


--cstclkxk6l4zuxkt
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 06.10.2022 10:44:48, Ivan Bornyakov wrote:
> Add support to the FPGA manager for programming Lattice ECP5 FPGA over
> slave SPI sysCONFIG interface.
>=20
> sysCONFIG interface core functionality is separate from both ECP5 and
> SPI specifics, so support for other FPGAs with different port types can
> be added in the future.
>=20
> Signed-off-by: Ivan Bornyakov <i.bornyakov@metrotek.ru>
> ---

[...]

> +static int sysconfig_spi_bitstream_burst_init(struct sysconfig_priv *pri=
v)
> +{
> +	const u8 lsc_bitstream_burst[] =3D SYSCONFIG_LSC_BITSTREAM_BURST;

I think you're not allowed to use stack memory for SPI transfers. Better
clarify this with the SPI people.

> +	struct spi_device *spi =3D to_spi_device(priv->dev);
> +	struct spi_transfer xfer =3D {
> +		.tx_buf =3D lsc_bitstream_burst,
> +		.len =3D sizeof(lsc_bitstream_burst),
> +		.cs_change =3D 1,
> +	};
> +	struct spi_message msg;
> +	int ret;
> +
> +	spi_message_init_with_transfers(&msg, &xfer, 1);
> +
> +	/*
> +	 * Lock SPI bus for exclusive usage until FPGA programming is done.
> +	 * SPI bus will be released in sysconfig_spi_bitstream_burst_complete().
> +	 */
> +	spi_bus_lock(spi->controller);
> +
> +	ret =3D spi_sync_locked(spi, &msg);
> +	if (ret)
> +		spi_bus_unlock(spi->controller);
> +
> +	return ret;
> +}

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--cstclkxk6l4zuxkt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmM+jzYACgkQrX5LkNig
013jTQf/W1QkhJsjQBwilMHgV5rq0CQ0bnolb+yuXRoE9sEDr34/oExbkJJ/PKbz
FTDUXsv05ZZIdSDuLKmLCwRypTW2vJXQT5fTUNUIAs/DBZZZBJYrROXyeGbauhW3
Ph67IMnJM7D45cCX2Q8r5yA0OkFIqm2s/jkIQvfG9GAtU5if6CHnSqXyhqBfrl90
33EOOFjdP8P5Vxq13z2B9fH81PcaEUVrsvGIYS+hrnnTSQ3BQPkjDjJzukucSxIw
480927VcumzgUfSuUVNZWme/qPnlQoaKaUCTQJxyuZgPoX3MomsWybzFRCLrjYxp
ScEO6jcg2J/euusBd31G8wumdmLYlA==
=XPet
-----END PGP SIGNATURE-----

--cstclkxk6l4zuxkt--
