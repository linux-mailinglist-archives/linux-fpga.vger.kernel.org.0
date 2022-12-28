Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07D1D6578FF
	for <lists+linux-fpga@lfdr.de>; Wed, 28 Dec 2022 15:56:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233230AbiL1Oyv (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 28 Dec 2022 09:54:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233210AbiL1Oyn (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 28 Dec 2022 09:54:43 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C19F71054B;
        Wed, 28 Dec 2022 06:54:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5ED4161551;
        Wed, 28 Dec 2022 14:54:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA994C433F2;
        Wed, 28 Dec 2022 14:54:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672239281;
        bh=NZwhw7d38GyHGWUDKGLMHzNFbaaGXR/hg1EwwvTghJk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VL5BJeAAJid8yj56gfZCPiXLARSl5qWGc+vtmyyd/XxmC8m+XNI0ptjH7tBYVaKty
         3Rm0RW2jZ3iZ/XKCHW+5XBN6E5AZDy8yduuwHUzqZ1NiNN6AN5IN4HJ5dDQOdsNT+a
         XOBAfnMLS/l5AOI7iI6xr5ARXwBUnN7eEmsSGlUw5KCXntx1geJObvH8JTp0fbuUeo
         l61ScHOEkEoaLC/+Ymtir2bx7HFaZN9cAqGKGSWrpHHRGuZRjgtvtzE60HndkB7BjZ
         j1KAMYUuTDWIR/gShmKPv1EAx6ZxWVidh8VNMN2mYpnHeXNcHkXI1Q3UNrm6dlV/W8
         niIj1kv45guAw==
Date:   Wed, 28 Dec 2022 14:54:37 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Ivan Bornyakov <i.bornyakov@metrotek.ru>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        system@metrotek.ru
Subject: Re: [PATCH v3 3/3] fpga: microchip-spi: separate data frame write
 routine
Message-ID: <Y6xYrYgaapspY/md@spud>
References: <20221227100450.2257-1-i.bornyakov@metrotek.ru>
 <20221227100450.2257-4-i.bornyakov@metrotek.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="iB/4Ohoo3u3W/wuK"
Content-Disposition: inline
In-Reply-To: <20221227100450.2257-4-i.bornyakov@metrotek.ru>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


--iB/4Ohoo3u3W/wuK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 27, 2022 at 01:04:50PM +0300, Ivan Bornyakov wrote:
> mpf_ops_write() function writes bitstream data to the FPGA by a smaller
> frames. Introduce mpf_spi_frame_write() function which is for writing a
> single data frame and use it in mpf_ops_write().
>=20
> No functional changes intended.
>=20
> Signed-off-by: Ivan Bornyakov <i.bornyakov@metrotek.ru>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Without another user for the new function I'm not super pushed, but I
suppose it does make things a little more readable.

Thanks,
Conor.

> ---
>  drivers/fpga/microchip-spi.c | 36 +++++++++++++++++++++++-------------
>  1 file changed, 23 insertions(+), 13 deletions(-)
>=20
> diff --git a/drivers/fpga/microchip-spi.c b/drivers/fpga/microchip-spi.c
> index 8d1d9476d0cc..ea92e5d106fa 100644
> --- a/drivers/fpga/microchip-spi.c
> +++ b/drivers/fpga/microchip-spi.c
> @@ -274,9 +274,30 @@ static int mpf_ops_write_init(struct fpga_manager *m=
gr,
>  	return 0;
>  }
> =20
> +static int mpf_spi_frame_write(struct mpf_priv *priv, const char *buf)
> +{
> +	struct spi_transfer xfers[2] =3D {
> +		{
> +			.tx_buf =3D &priv->tx,
> +			.len =3D 1,
> +		}, {
> +			.tx_buf =3D buf,
> +			.len =3D MPF_SPI_FRAME_SIZE,
> +		},
> +	};
> +	int ret;
> +
> +	ret =3D mpf_poll_status(priv, 0);
> +	if (ret < 0)
> +		return ret;
> +
> +	priv->tx =3D MPF_SPI_FRAME;
> +
> +	return spi_sync_transfer(priv->spi, xfers, ARRAY_SIZE(xfers));
> +}
> +
>  static int mpf_ops_write(struct fpga_manager *mgr, const char *buf, size=
_t count)
>  {
> -	struct spi_transfer xfers[2] =3D { 0 };
>  	struct mpf_priv *priv =3D mgr->priv;
>  	struct device *dev =3D &mgr->dev;
>  	int ret, i;
> @@ -287,19 +308,8 @@ static int mpf_ops_write(struct fpga_manager *mgr, c=
onst char *buf, size_t count
>  		return -EINVAL;
>  	}
> =20
> -	xfers[0].tx_buf =3D &priv->tx;
> -	xfers[0].len =3D 1;
> -
>  	for (i =3D 0; i < count / MPF_SPI_FRAME_SIZE; i++) {
> -		xfers[1].tx_buf =3D buf + i * MPF_SPI_FRAME_SIZE;
> -		xfers[1].len =3D MPF_SPI_FRAME_SIZE;
> -
> -		ret =3D mpf_poll_status(priv, 0);
> -		if (ret >=3D 0) {
> -			priv->tx =3D MPF_SPI_FRAME;
> -			ret =3D spi_sync_transfer(priv->spi, xfers, ARRAY_SIZE(xfers));
> -		}
> -
> +		ret =3D mpf_spi_frame_write(priv, buf + i * MPF_SPI_FRAME_SIZE);
>  		if (ret) {
>  			dev_err(dev, "Failed to write bitstream frame %d/%zu\n",
>  				i, count / MPF_SPI_FRAME_SIZE);
> --=20
> 2.38.2
>=20
>=20

--iB/4Ohoo3u3W/wuK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY6xYrQAKCRB4tDGHoIJi
0o2uAP9RoLqCzqctLk5pl5qdVSCVCA1KX7rdMDwNU5xmGFopCAD+J3btygzZTZP6
jKdqBy/ibWS24S82CvGsdcbfVLk/mgU=
=yEWb
-----END PGP SIGNATURE-----

--iB/4Ohoo3u3W/wuK--
