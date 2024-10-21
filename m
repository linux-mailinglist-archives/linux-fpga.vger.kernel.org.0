Return-Path: <linux-fpga+bounces-793-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7937D9A67FC
	for <lists+linux-fpga@lfdr.de>; Mon, 21 Oct 2024 14:20:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A720A1C21FB9
	for <lists+linux-fpga@lfdr.de>; Mon, 21 Oct 2024 12:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FB481F4FB5;
	Mon, 21 Oct 2024 12:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M5NvzLEn"
X-Original-To: linux-fpga@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4963A1F4FB0;
	Mon, 21 Oct 2024 12:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729513091; cv=none; b=nJK9I3SMqoOdWQWb/n+Whb9PSWIeOFXtHCnIEkQ7SyPtFY2d/TdIOIaTJiR3rUBFobRhf1II287eEhhYK8Ao0NkuWJGSF+O9t6tV7Uug4t4a1SXHHYLJCnWD/QWKM8jgC6jwXiSDpGs+CqFGh1OvV3zHMYKg/K7stqWEXrpnwa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729513091; c=relaxed/simple;
	bh=fJF3sv1WK29g491H9+hsq1JOT1porgzkvgomaG6Ledw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DVNY+immZTyL/Xc39ETenLHBkvG94cNE6ZSejcO+Wndl74c5k5Fq9orpK/kNZs+zj690Yb441x6Jq3ifXn8B7U/Z2GJXw2r9PWaanzNTuleY4RF0likgVbrk4N0VoYLG2uJDQU3yXncMREAv+ky+B2hVbXFErMzJVuxHCHxZPzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M5NvzLEn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5B0AC4CEC3;
	Mon, 21 Oct 2024 12:18:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729513090;
	bh=fJF3sv1WK29g491H9+hsq1JOT1porgzkvgomaG6Ledw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M5NvzLEnUIfSqKtpJxwNDMzakIDzjY7CACpZ/ItWVCBMAppqUukiTWn21NbgAgPuO
	 /EdtycJo+5CkYX0osKx1t1bfv/uvbnOTvTQw40ZlYRG2PO4Z5m8YSEn1IIQVeCA5UW
	 8I4EsKn9JmEhP0AUNOXtlakZbSomGTo5prJdr5c/rlRlBT/LYtVBoLoj3znWcMVnNc
	 ygfKpAbsag0y3B03PbHHpkK3qJ0tiwA96ZWsCZFH4/tReON0RB8Z6bRA6NnYRmJmjf
	 WU8ltnuf3sFSpNykC7ejhoI9y276DrIp5pGKkqJ+VRq670+mrGpQ4IYfc8foWc46US
	 7JBeelvJY7eMA==
Date: Mon, 21 Oct 2024 13:18:05 +0100
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
Message-ID: <20241021-depravity-scale-6123da541538@spud>
References: <20240927141445.157234-1-iansdannapel@gmail.com>
 <ZxG70kzjsvT3UBlQ@yilunxu-OptiPlex-7050>
 <20241018-chump-juvenile-dc368d3d2f2c@spud>
 <ZxW4DJOES77ifOC9@yilunxu-OptiPlex-7050>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Wt9DGYSdOGciyjI4"
Content-Disposition: inline
In-Reply-To: <ZxW4DJOES77ifOC9@yilunxu-OptiPlex-7050>


--Wt9DGYSdOGciyjI4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2024 at 10:10:20AM +0800, Xu Yilun wrote:
> On Fri, Oct 18, 2024 at 05:58:44PM +0100, Conor Dooley wrote:
> > On Fri, Oct 18, 2024 at 09:37:22AM +0800, Xu Yilun wrote:
> > > On Fri, Sep 27, 2024 at 04:14:42PM +0200, iansdannapel@gmail.com wrot=
e:
> > > > From: Ian Dannapel <iansdannapel@gmail.com>
> > > >=20
> > > > Add a new driver for loading binary firmware to volatile
> > > > configuration RAM using "SPI passive programming" on Efinix FPGAs.
> > > >=20
> > > > Signed-off-by: Ian Dannapel <iansdannapel@gmail.com>
> > > > ---
> > > >  drivers/fpga/Kconfig                    |  10 ++
> > > >  drivers/fpga/Makefile                   |   1 +
> > > >  drivers/fpga/efinix-trion-spi-passive.c | 211 ++++++++++++++++++++=
++++
> > > >  3 files changed, 222 insertions(+)
> > > >  create mode 100644 drivers/fpga/efinix-trion-spi-passive.c
> > > >=20
> > > > diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
> > > > index 37b35f58f0df..eb1e44c4e3e0 100644
> > > > --- a/drivers/fpga/Kconfig
> > > > +++ b/drivers/fpga/Kconfig
> > > > @@ -83,6 +83,16 @@ config FPGA_MGR_XILINX_SPI
> > > >  	  FPGA manager driver support for Xilinx FPGA configuration
> > > >  	  over slave serial interface.
> > > > =20
> > > > +config FPGA_MGR_EFINIX_SPI
> > > > +	tristate "Efinix FPGA configuration over SPI passive"
> > > > +	depends on SPI
> > > > +	help
> > > > +	  This option enables support for the FPGA manager driver to
> > > > +	  configure Efinix Trion and Titanium Series FPGAs over SPI
> > > > +	  using passive serial mode.
> > > > +	  Warning: Do not activate this if there are other SPI devices
> > > > +	  on the same bus as it might interfere with the transmission.
> > >=20
> > > Sorry, this won't work. As you can see, the conflict usage of CS caus=
es
> > > several concerns. Just a text here is far from enough.
> > >=20
> > > You need to actively work with SPI core/controller drivers to find a
> > > solution that coordinate the usage of this pin.
> >=20
> > Why does it even impact other SPI devices on the bus? It's not /their/
> > CS line that is being modified here, it is the line for the FPGA's
> > programming interface, right?
> > What am I missing here that makes it any different to any other SPI
> > device that may need it's CS toggled?
>=20
> IIUC, now spi core or controller driver should fully responsible for
> HW operations of CS. And every good behaved spi device driver should
> declare their logical CS index defined by SPI controller and let SPI
> core/controller driver to proxy the CS change.
>=20
> But if this spi device driver directly aquires CS, it conflicts with
> the controller and just fails.

Right, I don't think you answered my question here at all, but just
reading over the kconfig text again I think I understand what it means.
I'd interpreted this as other devices being impacted by what this driver
is doing, but actually it is talking about other devices on the bus
interfering with this one because of how it handles the chip select.

--Wt9DGYSdOGciyjI4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZxZGfQAKCRB4tDGHoIJi
0orWAQDW1clt+xNoVd8+K4hwkETBaQSqcDeo3EyjcnhtdNtidAD/Tyrn1QgIt56w
C4eWfh6Id3Pl5G2xcXBOJXfI3Ese1Qk=
=Ue1A
-----END PGP SIGNATURE-----

--Wt9DGYSdOGciyjI4--

