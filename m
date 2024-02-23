Return-Path: <linux-fpga+bounces-292-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF8EE861C51
	for <lists+linux-fpga@lfdr.de>; Fri, 23 Feb 2024 20:14:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 995F228682D
	for <lists+linux-fpga@lfdr.de>; Fri, 23 Feb 2024 19:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC50B143C4B;
	Fri, 23 Feb 2024 19:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dpBx4YYF"
X-Original-To: linux-fpga@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A25231420C1;
	Fri, 23 Feb 2024 19:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708715642; cv=none; b=fWJRAQ4xEeIuZnPuUzEcpL9gtSfmxUdDBdV5ep+dCNHfI2mExmQ2JqtahD5cBB11svq9NaJABGNGWF4RMmSqtRs/ew9D/zZgkx1Kt5312yP52ghlEA32mhY6K6qlxjERsSadPXyISxN2ibC5H6FFyuY428HDwno6P+CQS+dLqWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708715642; c=relaxed/simple;
	bh=cj//DlVPM+8k23LrNze3wHLdXva2PZF6sH1KLL3tuNw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lYBqRCtBrC5lQWrBkfqa+nzoVKvwWvRTSbp6/vns6n0us52jvYh4a+EkbeG+jr/0H12cBHTWigbdDqR/Kc89baYYeyzFy0uQud+8JVdYscR7/YyLFojzPEaHgBWew+vjjImsDKhPopIFYHHn8PIJVNlTfrDntro5Bwy/pmuUxtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dpBx4YYF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9424C433F1;
	Fri, 23 Feb 2024 19:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708715642;
	bh=cj//DlVPM+8k23LrNze3wHLdXva2PZF6sH1KLL3tuNw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dpBx4YYFI/f8bXAmv6mpw8ZV/hjkU/nV9iHJnf9LCBIDC4VN8OkXs/+Ez5H6VxjUV
	 mNTjEbHX9mEaveZoA0kkwt029CweE5RQ4OXAkdLmWlSDwrE1wPjEdARS+gXT1IwklT
	 bbQoYtJ+Nj5z+GWeIk4jqE8xsrz1M5khfW8NNUtyVLD6UWK+MV52IflS2TiqxjOGTD
	 JBWpNsz7wzF1VkTvHJGrXURy/sRfSuknZ1MCmZi0ZLPTIQtk8EpdVsSSblClyI86ke
	 bqZMoqBMg5a9dwm7vZO6eV+YtYetAliFzkswS6T3XuId9e4XllUzhF3ZjBT8LM/M+l
	 OHgEcuudPYueQ==
Date: Fri, 23 Feb 2024 19:13:57 +0000
From: Conor Dooley <conor@kernel.org>
To: Marco Felsch <m.felsch@pengutronix.de>
Cc: conor.dooley@microchip.com, v.georgiev@metrotek.ru, mdf@kernel.org,
	hao.wu@intel.com, yilun.xu@intel.com, trix@redhat.com,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	linux-fpga@vger.kernel.org, devicetree@vger.kernel.org,
	kernel@pengutronix.de
Subject: Re: [PATCH] dt-bindings: fpga: microchip,mpf-spi-fpga-mgr: document
 CPOL/CPHA support
Message-ID: <20240223-polio-debating-241fc4ab2262@spud>
References: <20240221191247.3643671-1-m.felsch@pengutronix.de>
 <20240222-rotten-truck-cf5e4b681ac1@spud>
 <20240222200230.ulhguouu37nm6inu@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="LVEg82uQrEH/J5n+"
Content-Disposition: inline
In-Reply-To: <20240222200230.ulhguouu37nm6inu@pengutronix.de>


--LVEg82uQrEH/J5n+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 22, 2024 at 09:02:30PM +0100, Marco Felsch wrote:
> On 24-02-22, Conor Dooley wrote:
> > On Wed, Feb 21, 2024 at 08:12:47PM +0100, Marco Felsch wrote:
> > > Microchip FPGAs can communicate in different modes, so document them =
to
> > > avoid dt-validate warnings.
> >=20
> > Are you sure it can "communicate in different modes"?
>=20
> No I'm not but I didn't found an overview within the FPGA datasheet [1]
> which modes are supported. What I did found was an note which says:
>=20
> """
> 1. Parameters are referenced to the active edge of SCK, which depends on
> the configured SPI protocol (for example, Motorola SPI mode uses rising
> edge as active edge if SPO =3D 0)
> """
>=20
> Therefore I thought that this can be configured somehow differently.
>=20
> [1] https://www.microsemi.com/document-portal/doc_view/136519-ds0141-pola=
rfire-fpga-datasheet
>=20
> > The documentation actually says "Motorla SPI Mode 3 is required to
> > communicate with M2S, M2GL, and MPF devices using dedicated system
> > controller SPI port" with mode 3 being SPO =3D SPH =3D 1:
> > https://www.microsemi.com/document-portal/doc_view/137543-spi-directc-s=
p1-v2-0-user-guide
>=20
> Thanks for the Pointer, there are plenty documents for the Polarfire
> FPGA.
>=20
> > I suspect the answer is that it can actually communicate in different
> > modes (because I don't recall setting those options), but the binding
> > should enforce the correct way of doing it IMO.
>=20
> Sure, I will rephrase my commit message to:
>=20
> """
> dt-bindings: fpga: microchip,mpf-spi-fpga-mgr: document CPOL/CPHA
>=20
> Using the dedicated system controller SPI port requires Motorola SPI
> Mode 3 according the SPI-DirectC v2.0 User Guid [1]. So require the
> spi-cpol and spi-cpha to be set.
>=20
> [1] https://www.microsemi.com/document-portal/doc_view/137543-spi-directc=
-sp1-v2-0-user-guide
> """

You say require here, but don't actually make them required.
I think we probably should actually make them required, since the docs
say they should be used, but I'd like to look at it a bit more though
before that, since it does work on the setup I had without them.

I'd say do s/require/allow/ and I'll try to do some testing as to
whether we should actually mark the properties as required.

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--LVEg82uQrEH/J5n+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZdjudQAKCRB4tDGHoIJi
0hNYAP9cbxllgl0uVLb/u1KpIl7a+NKaL1NE0dzgGmNknrUARQEA/GEf6Txnwnpd
evDGJOj58Poiwnpsnn8u2fLiid59/Qs=
=iefM
-----END PGP SIGNATURE-----

--LVEg82uQrEH/J5n+--

