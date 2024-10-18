Return-Path: <linux-fpga+bounces-790-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 912009A4437
	for <lists+linux-fpga@lfdr.de>; Fri, 18 Oct 2024 18:58:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A893C283624
	for <lists+linux-fpga@lfdr.de>; Fri, 18 Oct 2024 16:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB61A2038B9;
	Fri, 18 Oct 2024 16:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="maZaoGJ+"
X-Original-To: linux-fpga@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8371320E312;
	Fri, 18 Oct 2024 16:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729270730; cv=none; b=ove5+4NMplHJ4ojojSZKsrO3l/fLG9Iixz1ZTUY/5LxH0wzs5Zxa0dRcswvjhoqgDJJA7sxi8S+mSROoL9HVJ1+ntKeinVi3aLF0mkqaMQQO1vgNrNpN88OlG+rNRHWMGR3nK4AhI07tnFUpB5ublLefvRq7Be7Ux9AhSr70+Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729270730; c=relaxed/simple;
	bh=KmFDIPqq/FGkhdEs2nrrL6xlOMgGPriCuUSmr1XNq+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JKds+dOYjH1Rv3rsW6eNtfV3wh1kNaBnYrq912lPKlMXUwvbzW2yCl+BXQkotbIfsX+384XX8FHOtpgby+occ9jDIzBc0mLvEhlR/Bu324RSRkLZ3GXvv7jj3YhdxcDQfKTLcoPMnRddHqyw+mdLfonQxgdMwpSI2XYRIoR9Ba0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=maZaoGJ+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF723C4CEC3;
	Fri, 18 Oct 2024 16:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729270730;
	bh=KmFDIPqq/FGkhdEs2nrrL6xlOMgGPriCuUSmr1XNq+U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=maZaoGJ+ADlxQ7yODd0ZuD/qMi8agvLf+ypYlCT7bRwYaSgFrAA/4kG6CEqwH0sJP
	 4WuS2q8zk+FrM0Xd/SmELc32Fi8Ea96D7gMYtTs/KYYoulz4ff+MZwyEXCeZNxV36M
	 znxutkYSErKONN0AVj/Yb3au6G9e+RaZpsupwBJtI1wu/nMrxfz+fC8iaMYFXHYYaL
	 7xqW6l6fK7Cpxi9eQxI7TeYTTbrkygR3QO3hu6fZuPf+CMRCUUJbZjawMkJ+hIEHVC
	 X+Xdqr7xs/6nnCOPdMO7F87zwfXNcaAwxJKkrr0q06SLpaI+ernKjltXb2CBr3Yjel
	 T9gMk+Bt0OkMA==
Date: Fri, 18 Oct 2024 17:58:44 +0100
From: Conor Dooley <conor@kernel.org>
To: Xu Yilun <yilun.xu@linux.intel.com>
Cc: iansdannapel@gmail.com, mdf@kernel.org, hao.wu@intel.com,
	yilun.xu@intel.com, trix@redhat.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, neil.armstrong@linaro.org,
	heiko.stuebner@cherry.de, rafal@milecki.pl,
	linus.walleij@linaro.org, linux-fpga@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] fpga: Add Efinix Trion & Titanium serial SPI
 programming driver
Message-ID: <20241018-chump-juvenile-dc368d3d2f2c@spud>
References: <20240927141445.157234-1-iansdannapel@gmail.com>
 <ZxG70kzjsvT3UBlQ@yilunxu-OptiPlex-7050>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="tJrW1TGs4m0tiOHr"
Content-Disposition: inline
In-Reply-To: <ZxG70kzjsvT3UBlQ@yilunxu-OptiPlex-7050>


--tJrW1TGs4m0tiOHr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 18, 2024 at 09:37:22AM +0800, Xu Yilun wrote:
> On Fri, Sep 27, 2024 at 04:14:42PM +0200, iansdannapel@gmail.com wrote:
> > From: Ian Dannapel <iansdannapel@gmail.com>
> >=20
> > Add a new driver for loading binary firmware to volatile
> > configuration RAM using "SPI passive programming" on Efinix FPGAs.
> >=20
> > Signed-off-by: Ian Dannapel <iansdannapel@gmail.com>
> > ---
> >  drivers/fpga/Kconfig                    |  10 ++
> >  drivers/fpga/Makefile                   |   1 +
> >  drivers/fpga/efinix-trion-spi-passive.c | 211 ++++++++++++++++++++++++
> >  3 files changed, 222 insertions(+)
> >  create mode 100644 drivers/fpga/efinix-trion-spi-passive.c
> >=20
> > diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
> > index 37b35f58f0df..eb1e44c4e3e0 100644
> > --- a/drivers/fpga/Kconfig
> > +++ b/drivers/fpga/Kconfig
> > @@ -83,6 +83,16 @@ config FPGA_MGR_XILINX_SPI
> >  	  FPGA manager driver support for Xilinx FPGA configuration
> >  	  over slave serial interface.
> > =20
> > +config FPGA_MGR_EFINIX_SPI
> > +	tristate "Efinix FPGA configuration over SPI passive"
> > +	depends on SPI
> > +	help
> > +	  This option enables support for the FPGA manager driver to
> > +	  configure Efinix Trion and Titanium Series FPGAs over SPI
> > +	  using passive serial mode.
> > +	  Warning: Do not activate this if there are other SPI devices
> > +	  on the same bus as it might interfere with the transmission.
>=20
> Sorry, this won't work. As you can see, the conflict usage of CS causes
> several concerns. Just a text here is far from enough.
>=20
> You need to actively work with SPI core/controller drivers to find a
> solution that coordinate the usage of this pin.

Why does it even impact other SPI devices on the bus? It's not /their/
CS line that is being modified here, it is the line for the FPGA's
programming interface, right?
What am I missing here that makes it any different to any other SPI
device that may need it's CS toggled?

Cheers,
Conor.

--tJrW1TGs4m0tiOHr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZxKTxAAKCRB4tDGHoIJi
0unKAP4h10isIjeybBw7doFylQ84VeFR2ViMNgdJM2A4tWYn7QEA/zAY7NQ4XxmE
/uliSNdw8wCGnHuO7wIKjrkl6mnoJQs=
=ipTB
-----END PGP SIGNATURE-----

--tJrW1TGs4m0tiOHr--

