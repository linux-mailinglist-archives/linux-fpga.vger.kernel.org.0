Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D3506577F7
	for <lists+linux-fpga@lfdr.de>; Wed, 28 Dec 2022 15:44:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbiL1Om0 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 28 Dec 2022 09:42:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbiL1OmZ (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 28 Dec 2022 09:42:25 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32B07F001;
        Wed, 28 Dec 2022 06:42:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4A740B81711;
        Wed, 28 Dec 2022 14:42:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2098C433D2;
        Wed, 28 Dec 2022 14:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672238541;
        bh=xbPBhB2yqYTTsAvDEFw3ghE/1/l/diLVG1mJwQAEiCc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mrizdCUQ9/0d3EZ1Xok5ItRvHlgXzqHkKiaUn3J0PcB0bsVwnm/jMkTAUMK2cLXhx
         XHak2yhgMsZppLPq0BZxjLO3SAU9FeUakTYUN21sjQsylOZYG7ZpH3eaBwLyDFcpPJ
         cXLgwmLPnM0Kw5I6DT0tncz/xKZdSc9Ig6whKbPoeX6y22jVU09six5MofgFn/Zi1W
         4KqqZpesQHoSvXPy6011j+eSt5rSb1Ekjx0o1sMS8UwAldoFuHSxtgaeaiSH82pL4d
         AfWovOOnWDUrBDTJNfwwM19QVQFwS/D5bQBkpFHZMoF/6N5wA1hnM5wT9RB8xYBCsN
         PwUnl/18QX/fw==
Date:   Wed, 28 Dec 2022 14:42:16 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Ivan Bornyakov <i.bornyakov@metrotek.ru>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        system@metrotek.ru
Subject: Re: [PATCH v3 1/3] fpga: microchip-spi: move SPI I/O buffers out of
 stack
Message-ID: <Y6xVyCt5tXwnKhfw@spud>
References: <20221227100450.2257-1-i.bornyakov@metrotek.ru>
 <20221227100450.2257-2-i.bornyakov@metrotek.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="9mcttTVEGBOS8687"
Content-Disposition: inline
In-Reply-To: <20221227100450.2257-2-i.bornyakov@metrotek.ru>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


--9mcttTVEGBOS8687
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Ivan,

Given the time of year, I don't have my proper setup to actually go an
test this (or the other patches).

On Tue, Dec 27, 2022 at 01:04:48PM +0300, Ivan Bornyakov wrote:
> As spi-summary doc says:
>  > I/O buffers use the usual Linux rules, and must be DMA-safe.
>  > You'd normally allocate them from the heap or free page pool.
>  > Don't use the stack, or anything that's declared "static".
>=20
> Replace spi_write() with spi_write_then_read(), which is dma-safe for
> on-stack buffers. Use allocated buffers for transfers used in
> spi_sync_transfer().
>=20
> Although everything works OK with stack-located I/O buffers, better
> follow the doc to be safe.
>=20
> Fixes: 5f8d4a900830 ("fpga: microchip-spi: add Microchip MPF FPGA manager=
")
> Signed-off-by: Ivan Bornyakov <i.bornyakov@metrotek.ru>

The changes look fine though...
Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

> ---
>  drivers/fpga/microchip-spi.c | 93 ++++++++++++++++++------------------
>  1 file changed, 47 insertions(+), 46 deletions(-)
>=20
> diff --git a/drivers/fpga/microchip-spi.c b/drivers/fpga/microchip-spi.c
> index 7436976ea904..e72fedd93a27 100644
> --- a/drivers/fpga/microchip-spi.c
> +++ b/drivers/fpga/microchip-spi.c
> @@ -42,46 +42,55 @@
>  struct mpf_priv {
>  	struct spi_device *spi;
>  	bool program_mode;
> +	u8 tx __aligned(ARCH_KMALLOC_MINALIGN);
> +	u8 rx __aligned(ARCH_KMALLOC_MINALIGN);
>  };
> =20
> -static int mpf_read_status(struct spi_device *spi)
> +static int mpf_read_status(struct mpf_priv *priv)
>  {
> -	u8 status =3D 0, status_command =3D MPF_SPI_READ_STATUS;
> -	struct spi_transfer xfers[2] =3D { 0 };
> -	int ret;
> -
>  	/*
>  	 * HW status is returned on MISO in the first byte after CS went
>  	 * active. However, first reading can be inadequate, so we submit
>  	 * two identical SPI transfers and use result of the later one.
>  	 */
> -	xfers[0].tx_buf =3D &status_command;
> -	xfers[1].tx_buf =3D &status_command;
> -	xfers[0].rx_buf =3D &status;
> -	xfers[1].rx_buf =3D &status;
> -	xfers[0].len =3D 1;
> -	xfers[1].len =3D 1;
> -	xfers[0].cs_change =3D 1;
> +	struct spi_transfer xfers[2] =3D {
> +		{
> +			.tx_buf =3D &priv->tx,
> +			.rx_buf =3D &priv->rx,
> +			.len =3D 1,
> +			.cs_change =3D 1,
> +		}, {
> +			.tx_buf =3D &priv->tx,
> +			.rx_buf =3D &priv->rx,
> +			.len =3D 1,
> +		},
> +	};
> +	u8 status;
> +	int ret;
> +
> +	priv->tx =3D MPF_SPI_READ_STATUS;
> +
> +	ret =3D spi_sync_transfer(priv->spi, xfers, 2);
> +	if (ret)
> +		return ret;
> =20
> -	ret =3D spi_sync_transfer(spi, xfers, 2);
> +	status =3D priv->rx;
> =20
>  	if ((status & MPF_STATUS_SPI_VIOLATION) ||
>  	    (status & MPF_STATUS_SPI_ERROR))
> -		ret =3D -EIO;
> +		return -EIO;
> =20
> -	return ret ? : status;
> +	return status;
>  }
> =20
>  static enum fpga_mgr_states mpf_ops_state(struct fpga_manager *mgr)
>  {
>  	struct mpf_priv *priv =3D mgr->priv;
> -	struct spi_device *spi;
>  	bool program_mode;
>  	int status;
> =20
> -	spi =3D priv->spi;
>  	program_mode =3D priv->program_mode;
> -	status =3D mpf_read_status(spi);
> +	status =3D mpf_read_status(priv);
> =20
>  	if (!program_mode && !status)
>  		return FPGA_MGR_STATE_OPERATING;
> @@ -186,12 +195,12 @@ static int mpf_ops_parse_header(struct fpga_manager=
 *mgr,
>  }
> =20
>  /* Poll HW status until busy bit is cleared and mask bits are set. */
> -static int mpf_poll_status(struct spi_device *spi, u8 mask)
> +static int mpf_poll_status(struct mpf_priv *priv, u8 mask)
>  {
>  	int status, retries =3D MPF_STATUS_POLL_RETRIES;
> =20
>  	while (retries--) {
> -		status =3D mpf_read_status(spi);
> +		status =3D mpf_read_status(priv);
>  		if (status < 0)
>  			return status;
> =20
> @@ -205,32 +214,32 @@ static int mpf_poll_status(struct spi_device *spi, =
u8 mask)
>  	return -EBUSY;
>  }
> =20
> -static int mpf_spi_write(struct spi_device *spi, const void *buf, size_t=
 buf_size)
> +static int mpf_spi_write(struct mpf_priv *priv, const void *buf, size_t =
buf_size)
>  {
> -	int status =3D mpf_poll_status(spi, 0);
> +	int status =3D mpf_poll_status(priv, 0);
> =20
>  	if (status < 0)
>  		return status;
> =20
> -	return spi_write(spi, buf, buf_size);
> +	return spi_write_then_read(priv->spi, buf, buf_size, NULL, 0);
>  }
> =20
> -static int mpf_spi_write_then_read(struct spi_device *spi,
> +static int mpf_spi_write_then_read(struct mpf_priv *priv,
>  				   const void *txbuf, size_t txbuf_size,
>  				   void *rxbuf, size_t rxbuf_size)
>  {
>  	const u8 read_command[] =3D { MPF_SPI_READ_DATA };
>  	int ret;
> =20
> -	ret =3D mpf_spi_write(spi, txbuf, txbuf_size);
> +	ret =3D mpf_spi_write(priv, txbuf, txbuf_size);
>  	if (ret)
>  		return ret;
> =20
> -	ret =3D mpf_poll_status(spi, MPF_STATUS_READY);
> +	ret =3D mpf_poll_status(priv, MPF_STATUS_READY);
>  	if (ret < 0)
>  		return ret;
> =20
> -	return spi_write_then_read(spi, read_command, sizeof(read_command),
> +	return spi_write_then_read(priv->spi, read_command, sizeof(read_command=
),
>  				   rxbuf, rxbuf_size);
>  }
> =20
> @@ -242,7 +251,6 @@ static int mpf_ops_write_init(struct fpga_manager *mg=
r,
>  	const u8 isc_en_command[] =3D { MPF_SPI_ISC_ENABLE };
>  	struct mpf_priv *priv =3D mgr->priv;
>  	struct device *dev =3D &mgr->dev;
> -	struct spi_device *spi;
>  	u32 isc_ret =3D 0;
>  	int ret;
> =20
> @@ -251,9 +259,7 @@ static int mpf_ops_write_init(struct fpga_manager *mg=
r,
>  		return -EOPNOTSUPP;
>  	}
> =20
> -	spi =3D priv->spi;
> -
> -	ret =3D mpf_spi_write_then_read(spi, isc_en_command, sizeof(isc_en_comm=
and),
> +	ret =3D mpf_spi_write_then_read(priv, isc_en_command, sizeof(isc_en_com=
mand),
>  				      &isc_ret, sizeof(isc_ret));
>  	if (ret || isc_ret) {
>  		dev_err(dev, "Failed to enable ISC: spi_ret %d, isc_ret %u\n",
> @@ -261,7 +267,7 @@ static int mpf_ops_write_init(struct fpga_manager *mg=
r,
>  		return -EFAULT;
>  	}
> =20
> -	ret =3D mpf_spi_write(spi, program_mode, sizeof(program_mode));
> +	ret =3D mpf_spi_write(priv, program_mode, sizeof(program_mode));
>  	if (ret) {
>  		dev_err(dev, "Failed to enter program mode: %d\n", ret);
>  		return ret;
> @@ -274,11 +280,9 @@ static int mpf_ops_write_init(struct fpga_manager *m=
gr,
> =20
>  static int mpf_ops_write(struct fpga_manager *mgr, const char *buf, size=
_t count)
>  {
> -	u8 spi_frame_command[] =3D { MPF_SPI_FRAME };
>  	struct spi_transfer xfers[2] =3D { 0 };
>  	struct mpf_priv *priv =3D mgr->priv;
>  	struct device *dev =3D &mgr->dev;
> -	struct spi_device *spi;
>  	int ret, i;
> =20
>  	if (count % MPF_SPI_FRAME_SIZE) {
> @@ -287,18 +291,18 @@ static int mpf_ops_write(struct fpga_manager *mgr, =
const char *buf, size_t count
>  		return -EINVAL;
>  	}
> =20
> -	spi =3D priv->spi;
> -
> -	xfers[0].tx_buf =3D spi_frame_command;
> -	xfers[0].len =3D sizeof(spi_frame_command);
> +	xfers[0].tx_buf =3D &priv->tx;
> +	xfers[0].len =3D 1;
> =20
>  	for (i =3D 0; i < count / MPF_SPI_FRAME_SIZE; i++) {
>  		xfers[1].tx_buf =3D buf + i * MPF_SPI_FRAME_SIZE;
>  		xfers[1].len =3D MPF_SPI_FRAME_SIZE;
> =20
> -		ret =3D mpf_poll_status(spi, 0);
> -		if (ret >=3D 0)
> -			ret =3D spi_sync_transfer(spi, xfers, ARRAY_SIZE(xfers));
> +		ret =3D mpf_poll_status(priv, 0);
> +		if (ret >=3D 0) {
> +			priv->tx =3D MPF_SPI_FRAME;
> +			ret =3D spi_sync_transfer(priv->spi, xfers, ARRAY_SIZE(xfers));
> +		}
> =20
>  		if (ret) {
>  			dev_err(dev, "Failed to write bitstream frame %d/%zu\n",
> @@ -317,12 +321,9 @@ static int mpf_ops_write_complete(struct fpga_manage=
r *mgr,
>  	const u8 release_command[] =3D { MPF_SPI_RELEASE };
>  	struct mpf_priv *priv =3D mgr->priv;
>  	struct device *dev =3D &mgr->dev;
> -	struct spi_device *spi;
>  	int ret;
> =20
> -	spi =3D priv->spi;
> -
> -	ret =3D mpf_spi_write(spi, isc_dis_command, sizeof(isc_dis_command));
> +	ret =3D mpf_spi_write(priv, isc_dis_command, sizeof(isc_dis_command));
>  	if (ret) {
>  		dev_err(dev, "Failed to disable ISC: %d\n", ret);
>  		return ret;
> @@ -330,7 +331,7 @@ static int mpf_ops_write_complete(struct fpga_manager=
 *mgr,
> =20
>  	usleep_range(1000, 2000);
> =20
> -	ret =3D mpf_spi_write(spi, release_command, sizeof(release_command));
> +	ret =3D mpf_spi_write(priv, release_command, sizeof(release_command));
>  	if (ret) {
>  		dev_err(dev, "Failed to exit program mode: %d\n", ret);
>  		return ret;
> --=20
> 2.38.2
>=20
>=20

--9mcttTVEGBOS8687
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY6xVyAAKCRB4tDGHoIJi
0pvjAQDtilP3wgIaMeXEjpYCl/sJwcplBAj3FE0l9IDfMxyyAQD/QDLPvzwTXNo1
RD/jIAf22Jfq5ttLAdhH694u0O+d0Aw=
=5rWK
-----END PGP SIGNATURE-----

--9mcttTVEGBOS8687--
