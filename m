Return-Path: <linux-fpga+bounces-552-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 184B9910A80
	for <lists+linux-fpga@lfdr.de>; Thu, 20 Jun 2024 17:48:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF2891F22C79
	for <lists+linux-fpga@lfdr.de>; Thu, 20 Jun 2024 15:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B1701AF6A2;
	Thu, 20 Jun 2024 15:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QW+AsASQ"
X-Original-To: linux-fpga@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D55E81AD411;
	Thu, 20 Jun 2024 15:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718898465; cv=none; b=n0XcUZmHreMe48HEFVpHkENfYVVkXcaEHsTW5HeITaLNFvAgRk3HIkEifzTvhRzLyy3NFsBgmocyuVlOOxF7GYmJa7dmSWMsAnV3QqnWjrvALkBVNOdtopeByFd/WOXceaTPPnQNWb39yFI0AoEEBSaaGIkHsrQwc0mMcwZCdv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718898465; c=relaxed/simple;
	bh=5/4r+g6pHgKwY/Fk2BD767Lj770k7NNu62Lt2Q+TWiM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ncmrp0CyfVF5YZYlYgNjs9IAff1cgdaLmJ8il52SLIs7/LhJ32hkWnzikA/thZm04d/pt7uDtWgW5/8XWlvCF0/izeyTTbOq8pkAIXZkY4QMnJMZSbl+NsqK3ElcerJJZFjUMZOuH1sRpuvZ295SmorZl6MoeLuLLvQblw+l+dQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QW+AsASQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3702DC2BD10;
	Thu, 20 Jun 2024 15:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718898465;
	bh=5/4r+g6pHgKwY/Fk2BD767Lj770k7NNu62Lt2Q+TWiM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QW+AsASQVL2Agby9v0Cs1PwLbeYvEG1DMx4H/KWcN8Giy9g8pXbO33fl2W05H7WC2
	 FZ/1MWpz9rvdXjgRPZlHYQxfdb3J1rJ/tbprTiR+YPRDyeDDI4OC61Vz+RwAJFYZpO
	 1isDkWPH0vO7Gm6r0Kyp9x/zE1fxgY3tDyQ6yCWR6/Ptb3aceW3zSOCmr1bLnTtSCi
	 N4slOWVIP7kRxbk614Wx4Wm4juplKRVtNAW/lIVCxJC53fU8EPF24l5cSk+OXBtEtO
	 U8Cf20M+UKR19jE+I+04ei8v26D0KeQMXYWWk+0ywg2tgRjWceZxYV8JTdFNgWtBlX
	 P0pdgU7b9r12A==
Date: Thu, 20 Jun 2024 16:47:41 +0100
From: Conor Dooley <conor@kernel.org>
To: iansdannapel@gmail.com
Cc: mdf@kernel.org, hao.wu@intel.com, yilun.xu@intel.com, trix@redhat.com,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	linux-fpga@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] dt-bindings: fpga: Add Efinix serial SPI programming
 binding description
Message-ID: <20240620-rubdown-buffing-312d308c2d4d@spud>
References: <20240620144440.125374-1-iansdannapel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="/HleowjwsFznHLAc"
Content-Disposition: inline
In-Reply-To: <20240620144440.125374-1-iansdannapel@gmail.com>


--/HleowjwsFznHLAc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 20, 2024 at 04:44:40PM +0200, iansdannapel@gmail.com wrote:
> From: Ian Dannapel <iansdannapel@gmail.com>
>=20
> Add device tree binding documentation for configuring Efinix FPGA
> using serial SPI passive programming mode.
>=20
> Signed-off-by: Ian Dannapel <iansdannapel@gmail.com>
> ---
>  .../bindings/fpga/efnx,fpga-passive-spi.yaml  | 76 +++++++++++++++++++
>  1 file changed, 76 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/fpga/efnx,fpga-pass=
ive-spi.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/fpga/efnx,fpga-passive-spi=
=2Eyaml b/Documentation/devicetree/bindings/fpga/efnx,fpga-passive-spi.yaml
> new file mode 100644
> index 000000000000..855ceb3b89e8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/fpga/efnx,fpga-passive-spi.yaml
> @@ -0,0 +1,76 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/fpga/efnx,fpga-passive-spi.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Efinix SPI FPGA Manager
> +
> +description: |
> +  Efinix Trion and Titanium Series FPGAs support a method of loading the
> +  bitstream over what is referred to as "SPI Passive Programming".
> +  Only serial (1x bus width) is supported, setting the programming mode
> +  is not in the scope the this manager and must be done elsewhere.
> +
> +  References:
> +  - https://www.efinixinc.com/docs/an033-configuring-titanium-fpgas-v2.6=
=2Epdf
> +  - https://www.efinixinc.com/docs/an006-configuring-trion-fpgas-v6.0.pdf
> +
> +allOf:
> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - efnx,fpga-spi-passive

Ahh, here is the user. Can you please add specific compatibles for the
Trion and Titanium series FPGAs? And when you do, make the filename
match a compatible please.

Additionally, why "efnx" and not "efinix"?

> +
> +  spi-cpha: true
> +  spi-cpol: true
> +
> +  spi-max-frequency:
> +    maximum: 25000000
> +
> +  reg:
> +    maxItems: 1
> +
> +  reset-gpios:
> +    description:
> +      reset pin (low active)
> +    maxItems: 1
> +
> +  cs-gpios:
> +    description:
> +      chip-select pin (low active)
> +    maxItems: 1
> +
> +  done-gpios:
> +    description:
> +      optional programming done pin, referred as CDONE (high active)

Why not call it "cdone-gpios" if that;s what it is referred to as?

> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - reset-gpios
> +  - cs-gpios
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    &spi2 {
> +      #address-cells =3D <1>;
> +      #size-cells =3D <0>;
> +
> +      fpga_mgr_spi: fpga-mgr@0 {
> +        compatible =3D "efnx,fpga-spi-passive";
> +        spi-max-frequency =3D <25000000>;
> +        spi-cpha;
> +        spi-cpol;
> +        reg =3D <0>;

order of compatible, reg, others here please.

> +        reset-gpios =3D <&gpio4 17 GPIO_ACTIVE_LOW>;
> +        cs-gpios =3D <&gpio5 13 GPIO_ACTIVE_LOW>;
> +        done-gpios =3D <&gpio0 9 GPIO_ACTIVE_HIGH>;
> +      };
> +    };
> +...
> --=20
> 2.34.1
>=20

--/HleowjwsFznHLAc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZnRPHQAKCRB4tDGHoIJi
0tWiAP4yxHcPaggl8d52h5vRducLiRIqc0ChK7wbWA7I2gw+XAD/btmiZ+fEAYDc
mDGMvQV4MTsv17xVtsmvjLOVE+rqeg4=
=zaWj
-----END PGP SIGNATURE-----

--/HleowjwsFznHLAc--

