Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F26FD657880
	for <lists+linux-fpga@lfdr.de>; Wed, 28 Dec 2022 15:51:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233074AbiL1OuK (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 28 Dec 2022 09:50:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233073AbiL1OuJ (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 28 Dec 2022 09:50:09 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71F43B41;
        Wed, 28 Dec 2022 06:50:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 280DAB81719;
        Wed, 28 Dec 2022 14:50:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1E29C43392;
        Wed, 28 Dec 2022 14:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672239005;
        bh=st2aZQPAZqAuDALvTWTipwWXG6nYNaBsVrFY+I38dvI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ofOAEPdZyAJC7JdDAOCuIJpI6P+fWDwLPcYpxLpr5FGTdDnHy3LthFzsXs3rh/51p
         +85Ch9sVoMMsvm4ethsInCcexgUgdJvojnkFFzGhrJCkW/7xYNOBVmEh41ShswcoH/
         vblTeN6/hXiTVvIeYb0WrqO1hPG/Cn2wx83DUdqs2AaJkvwQG56d3WiZNUXCyqPNfM
         z57YH0XdvrcJefzT3u186GAp71cQ1GD4rPJ8GPtyOiSh2x4ATx1oJcdBWqQT/2c9dQ
         7IAWOziFN31upes6c7/7JF2qH+mU1htKziX0gOut4mnY+Yvj/pueNyFVAHQOXnVrYw
         hEgBoh+Fjry8g==
Date:   Wed, 28 Dec 2022 14:50:01 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Ivan Bornyakov <i.bornyakov@metrotek.ru>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        system@metrotek.ru
Subject: Re: [PATCH v3 2/3] fpga: microchip-spi: rewrite status polling in a
 time measurable way
Message-ID: <Y6xXmcCa4L9iz5qm@spud>
References: <20221227100450.2257-1-i.bornyakov@metrotek.ru>
 <20221227100450.2257-3-i.bornyakov@metrotek.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="+k8pTdWXhUpj/t3q"
Content-Disposition: inline
In-Reply-To: <20221227100450.2257-3-i.bornyakov@metrotek.ru>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


--+k8pTdWXhUpj/t3q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 27, 2022 at 01:04:49PM +0300, Ivan Bornyakov wrote:
> Original busy loop with retries count in mpf_poll_status() is not too
> reliable, as it takes different times on different systems. Replace it
> with read_poll_timeout() macro.
>=20
> While at it, fix polling stop condition to met function's original
> intention declared in the comment. The issue with original polling stop
> condition is that it stops if any of mask bits is set, while intention
> was to stop if all mask bits is set. This was not noticible because only
> MPF_STATUS_READY is passed as mask argument and it is BIT(1).
>=20
> Fixes: 5f8d4a900830 ("fpga: microchip-spi: add Microchip MPF FPGA manager=
")
> Signed-off-by: Ivan Bornyakov <i.bornyakov@metrotek.ru>
> ---
>  drivers/fpga/microchip-spi.c | 24 ++++++++++--------------
>  1 file changed, 10 insertions(+), 14 deletions(-)
>=20
> diff --git a/drivers/fpga/microchip-spi.c b/drivers/fpga/microchip-spi.c
> index e72fedd93a27..8d1d9476d0cc 100644
> --- a/drivers/fpga/microchip-spi.c
> +++ b/drivers/fpga/microchip-spi.c
> @@ -6,6 +6,7 @@
>  #include <asm/unaligned.h>
>  #include <linux/delay.h>
>  #include <linux/fpga/fpga-mgr.h>
> +#include <linux/iopoll.h>
>  #include <linux/module.h>
>  #include <linux/of_device.h>
>  #include <linux/spi/spi.h>
> @@ -33,7 +34,7 @@
> =20
>  #define	MPF_BITS_PER_COMPONENT_SIZE	22
> =20
> -#define	MPF_STATUS_POLL_RETRIES		10000
> +#define	MPF_STATUS_POLL_TIMEOUT		(2 * USEC_PER_SEC)
>  #define	MPF_STATUS_BUSY			BIT(0)
>  #define	MPF_STATUS_READY		BIT(1)
>  #define	MPF_STATUS_SPI_VIOLATION	BIT(2)
> @@ -197,21 +198,16 @@ static int mpf_ops_parse_header(struct fpga_manager=
 *mgr,
>  /* Poll HW status until busy bit is cleared and mask bits are set. */
>  static int mpf_poll_status(struct mpf_priv *priv, u8 mask)
>  {
> -	int status, retries =3D MPF_STATUS_POLL_RETRIES;
> +	int ret, status;
> =20
> -	while (retries--) {
> -		status =3D mpf_read_status(priv);
> -		if (status < 0)
> -			return status;
> -
> -		if (status & MPF_STATUS_BUSY)
> -			continue;
> -
> -		if (!mask || (status & mask))
> -			return status;
> -	}

Would you mind moving the small comment before the function down to here
and mentioning handling the failure case?
The current implementation is a bit easier to understand than the new
version that's wrapped in read_poll_timeout().

Otherwise, change seems like a good idea.
Acked-by: Conor Dooley <conor.dooley@microchip.com>

> +	ret =3D read_poll_timeout(mpf_read_status, status,
> +				(status < 0) ||
> +				((status & (MPF_STATUS_BUSY | mask)) =3D=3D mask),
> +	if (ret < 0)
> +		return ret;
> =20
> -	return -EBUSY;
> +	return status;
>  }
> =20
>  static int mpf_spi_write(struct mpf_priv *priv, const void *buf, size_t =
buf_size)
> --=20
> 2.38.2
>=20
>=20

--+k8pTdWXhUpj/t3q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY6xXmQAKCRB4tDGHoIJi
0ojBAQDaodmMFhTX1JcUQ7P9gZqx73+VFueROx+yv3Msvec1ngD/Q6BW5eZ1I22Y
Icgcw/pWs3wHFbUeZ4cIeuuc+wQtMwk=
=Qpli
-----END PGP SIGNATURE-----

--+k8pTdWXhUpj/t3q--
