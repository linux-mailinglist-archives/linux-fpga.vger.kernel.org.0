Return-Path: <linux-fpga+bounces-290-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAD0B85FF33
	for <lists+linux-fpga@lfdr.de>; Thu, 22 Feb 2024 18:23:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 087701C217FE
	for <lists+linux-fpga@lfdr.de>; Thu, 22 Feb 2024 17:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A04991552E7;
	Thu, 22 Feb 2024 17:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U5wfFBM+"
X-Original-To: linux-fpga@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78362154C0D;
	Thu, 22 Feb 2024 17:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708622589; cv=none; b=e7699K0xDqPsQHi6pSBlVtvN38/k1A4AyjbFAkVOdxBOun8uQm8SRiHNjfpzG5i8K8e58uZi2HYRY3oOW9t6SvQjfzMl+SB0BRjhoxW82lDf62Q9rNI32y/yT4aTGszoFdVXHM/OhWTK2w6s9ZBD08zo8+FJVbOYLuwsNi00oZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708622589; c=relaxed/simple;
	bh=whE7yGI1jDtv+L8JN0rRe8ZMguT96zB+uF5cIX3kmb4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H05gav3wDqDrF+/uXTbUpGJG6moSEFiqRUeuNA6iggllGgflhrVpnV9pCUwZZIu/5iL8yqbC0JvtnvH2XtXQFhkfFQNlSi9FlUsjdbw9JpDD2MQeyNaRa1d+IkVByJX0GAXAh6q0Uh7NCZX0Qk4bDog0mIl0o+w9ZEY4VP2uQbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U5wfFBM+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2E8BC433C7;
	Thu, 22 Feb 2024 17:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708622589;
	bh=whE7yGI1jDtv+L8JN0rRe8ZMguT96zB+uF5cIX3kmb4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U5wfFBM+hzmcbaABMJE470Ntk+lgCi7AqGPSqbZqV9nvzvcIdOg6n0iPZ4DJvKq+K
	 1pxM6ooCO9fNKyH/n41/ul7zFudrVaa5Pk+yonXqVWVMMTQz1abvRsaKVdUouVNhU5
	 ZCMsgI+4mNY22npdFAhIfZ05mTUmafjk+PS3rWrxcX6OE4VXmVVNGfnWcKnElXMnij
	 CG7h7NtKu4k0K5xbonJCU1VoqPwFt+bf3zL5mRNtP1waXIFQgQQOHy/kdh8oR8XRZF
	 5a1kbub+ebNtkevzxQm0NZ4LSWPfaSb2GM+lJ1R9WRAeKaOS3ReMbCWKDamT/BMbzr
	 alWgaGLUrmKPg==
Date: Thu, 22 Feb 2024 17:23:04 +0000
From: Conor Dooley <conor@kernel.org>
To: Marco Felsch <m.felsch@pengutronix.de>
Cc: conor.dooley@microchip.com, v.georgiev@metrotek.ru, mdf@kernel.org,
	hao.wu@intel.com, yilun.xu@intel.com, trix@redhat.com,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	linux-fpga@vger.kernel.org, devicetree@vger.kernel.org,
	kernel@pengutronix.de
Subject: Re: [PATCH] dt-bindings: fpga: microchip,mpf-spi-fpga-mgr: document
 CPOL/CPHA support
Message-ID: <20240222-rotten-truck-cf5e4b681ac1@spud>
References: <20240221191247.3643671-1-m.felsch@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="2O3aSUv9rd47PiBb"
Content-Disposition: inline
In-Reply-To: <20240221191247.3643671-1-m.felsch@pengutronix.de>


--2O3aSUv9rd47PiBb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2024 at 08:12:47PM +0100, Marco Felsch wrote:
> Microchip FPGAs can communicate in different modes, so document them to
> avoid dt-validate warnings.

Are you sure it can "communicate in different modes"? The documentation
actually says "Motorla SPI Mode 3 is required to communicate with M2S,
M2GL, and MPF devices using dedicated system controller SPI port" with
mode 3 being SPO =3D SPH =3D 1:
https://www.microsemi.com/document-portal/doc_view/137543-spi-directc-sp1-v=
2-0-user-guide

I suspect the answer is that it can actually communicate in different
modes (because I don't recall setting those options), but the binding
should enforce the correct way of doing it IMO.

Cheers,
Conor.

>=20
> Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> ---
>  .../devicetree/bindings/fpga/microchip,mpf-spi-fpga-mgr.yaml   | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/fpga/microchip,mpf-spi-fpg=
a-mgr.yaml b/Documentation/devicetree/bindings/fpga/microchip,mpf-spi-fpga-=
mgr.yaml
> index a157eecfb5fc..bb9a7d16db60 100644
> --- a/Documentation/devicetree/bindings/fpga/microchip,mpf-spi-fpga-mgr.y=
aml
> +++ b/Documentation/devicetree/bindings/fpga/microchip,mpf-spi-fpga-mgr.y=
aml
> @@ -22,6 +22,9 @@ properties:
>      description: SPI chip select
>      maxItems: 1
> =20
> +  spi-cpol: true
> +  spi-cpha: true
> +
>  required:
>    - compatible
>    - reg
> --=20
> 2.39.2
>=20
>=20

--2O3aSUv9rd47PiBb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZdeC+AAKCRB4tDGHoIJi
0oHjAQDn+CtPxsHmH1HbAnZxGrFN2XNw9ZiIecm7+uMc0TL60gEAiz9XnYW94d0n
V5purDR7N3JY473miS4tnfziAcnS9A0=
=nkrk
-----END PGP SIGNATURE-----

--2O3aSUv9rd47PiBb--

