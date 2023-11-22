Return-Path: <linux-fpga+bounces-33-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EDA17F4D3B
	for <lists+linux-fpga@lfdr.de>; Wed, 22 Nov 2023 17:50:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 479752810CD
	for <lists+linux-fpga@lfdr.de>; Wed, 22 Nov 2023 16:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83C3C4F21B;
	Wed, 22 Nov 2023 16:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eO3sCieP"
X-Original-To: linux-fpga@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD874E62E;
	Wed, 22 Nov 2023 16:50:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84E08C433C7;
	Wed, 22 Nov 2023 16:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700671844;
	bh=Gy6ICgLvnTaxWqv9MeYnCJN9AaV4Dv5/UPWRNSFp3n8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eO3sCiePyO9mju04v/x+bzylbjrmjfLSXFi24QPC7IrjsqVwpV345L93YY432JMAY
	 4uUghDamU1fVxyA8H7hZowYS5tX2tm3CuVFdUh0AHKLs7oJeHO1pYVsAA6B59l8Fbb
	 6VItSWg2kYQfm/gj4CHChRNtiWDr1geCJ3irm1Ag/gNeysgcYxvOO5PK9rPtKXjMmS
	 LG7vfpuC9lwQQWv3uy6pk7gecJkI8sStxZWpXyaYwzXIvPaLEI0ZOvpQX8CI1g0NIi
	 /VDKiflfgrmZM5Ufwn3KRAZec9J1OQE/dPpiyRrpp32w1/egGH1cLQanEsJTbJp5k+
	 Z9AQdxDV0XPaQ==
Date: Wed, 22 Nov 2023 16:50:37 +0000
From: Conor Dooley <conor@kernel.org>
To: Nava kishore Manne <nava.kishore.manne@amd.com>
Cc: mdf@kernel.org, hao.wu@intel.com, yilun.xu@intel.com, trix@redhat.com,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, michal.simek@amd.com,
	mathieu.poirier@linaro.org, ben.levinsky@amd.com,
	sai.krishna.potthuri@amd.com, tanmay.shah@amd.com,
	dhaval.r.shah@amd.com, arnd@arndb.de, shubhrajyoti.datta@amd.com,
	linux-fpga@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC PATCH 1/3] dt-bindings: fpga: Add support for user-key
 encrypted bitstream loading
Message-ID: <20231122-exert-gleeful-e4476851c489@spud>
References: <20231122054404.3764288-1-nava.kishore.manne@amd.com>
 <20231122054404.3764288-2-nava.kishore.manne@amd.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="fQgRGi9CRaM/leib"
Content-Disposition: inline
In-Reply-To: <20231122054404.3764288-2-nava.kishore.manne@amd.com>


--fQgRGi9CRaM/leib
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 22, 2023 at 11:14:02AM +0530, Nava kishore Manne wrote:
> Adds =E2=80=98encrypted-key-name=E2=80=99 property to support user-key en=
crypted
> bitstream loading use case.
>=20
> Signed-off-by: Nava kishore Manne <nava.kishore.manne@amd.com>
> ---
>  .../devicetree/bindings/fpga/fpga-region.txt  | 32 +++++++++++++++++++

Is there a reason that this has not yet been converted to yaml?

>  1 file changed, 32 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/fpga/fpga-region.txt b/Doc=
umentation/devicetree/bindings/fpga/fpga-region.txt
> index 528df8a0e6d8..309334558b3f 100644
> --- a/Documentation/devicetree/bindings/fpga/fpga-region.txt
> +++ b/Documentation/devicetree/bindings/fpga/fpga-region.txt
> @@ -177,6 +177,9 @@ Optional properties:
>  	it indicates that the FPGA has already been programmed with this image.
>  	If this property is in an overlay targeting an FPGA region, it is a
>  	request to program the FPGA with that image.
> +- encrypted-key-name : should contain the name of an encrypted key file =
located
> +	on the firmware search path. It will be used to decrypt the FPGA image
> +	file with user-key.

I might be misreading things, but your driver code seems to assume that
this is an aes key. Nothing here seems to document that this is supposed
to be a key of a particular type.

Cheers,
Conor.

>  - fpga-bridges : should contain a list of phandles to FPGA Bridges that =
must be
>  	controlled during FPGA programming along with the parent FPGA bridge.
>  	This property is optional if the FPGA Manager handles the bridges.
> @@ -459,6 +462,35 @@ programming is the FPGA based bridge of fpga_region1.
>  	};
>  };
> =20
> +Device Tree Example: Configure/Reconfigure Encrypted Image With User Key
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Users can encrypt FPGA configuration Images with their own key. While de=
crypting
> +the configuration Image the user needs to provide the same key.
> +"encrypted-key-name" Specifies the name of the FPGA image encrypted key =
file on
> +the firmware search path. The search path is described in the firmware c=
lass
> +documentation.
> +
> +/dts-v1/;
> +/plugin/;
> +
> +&fpga_region0 {
> +	#address-cells =3D <1>;
> +	#size-cells =3D <1>;
> +
> +	firmware-name =3D "soc_image2.rbf";
> +	encrypted-key-name =3D "key.nky";
> +
> +	gpio@10040 {
> +		compatible =3D "altr,pio-1.0";
> +		reg =3D <0x10040 0x20>;
> +		clocks =3D <0x2>;
> +		altr,ngpio =3D <0x4>;
> +		#gpio-cells =3D <0x2>;
> +		gpio-controller;
> +	};
> +};
> +
>  Constraints
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =20
> --=20
> 2.25.1
>=20

--fQgRGi9CRaM/leib
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZV4xXQAKCRB4tDGHoIJi
0loFAP9yglWDOnl90C+JIFNKoS8fMwEsVxZA1KeM+gtNfT8IBAEAjdZP9R4ySbJQ
anmnejBPkAFFim8ousuPXHi+3dEazAM=
=4Jh2
-----END PGP SIGNATURE-----

--fQgRGi9CRaM/leib--

