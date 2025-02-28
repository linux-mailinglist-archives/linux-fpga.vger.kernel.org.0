Return-Path: <linux-fpga+bounces-1071-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 80D21A4A187
	for <lists+linux-fpga@lfdr.de>; Fri, 28 Feb 2025 19:28:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75D03173B3C
	for <lists+linux-fpga@lfdr.de>; Fri, 28 Feb 2025 18:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F99C27426D;
	Fri, 28 Feb 2025 18:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g3txBAsk"
X-Original-To: linux-fpga@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C6527426B;
	Fri, 28 Feb 2025 18:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740767312; cv=none; b=snRg/lfG+tzpy3rppyTpsoqoVnGmsfQIU34YvzypXEqy0P6s9HTLha27pDNCL8rmYCupiJpqzgw2EtLUfjVeL95glUQaN/mpYZKMIWHtg0jppXeZXJGbc8STwj1qSNiDYWGJoZst1hFCCnNuvk/ZduI97hs/RMUuqwGMHGu1BX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740767312; c=relaxed/simple;
	bh=fRUw9J5isgo7CUkPjJBB6fyMf/RKunUPdzbqGU6YYbk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XcVs+8/LtYXXrYVKyGPZT9e3hwYL7pD4qe8gHUQcoLvEBoCSZExd3l5Q+IheJVPJzVGxuuYRTgFkHheh+1zvKwNrF4pw7Dhqw7MpnDfpV27fo0c9yfy8pS17DfGqqxyDr5N5eryAT/GtUSJtYfDhjvLlYJk4VJinswqY4zEMY9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g3txBAsk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36E5FC4CED6;
	Fri, 28 Feb 2025 18:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740767312;
	bh=fRUw9J5isgo7CUkPjJBB6fyMf/RKunUPdzbqGU6YYbk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g3txBAsksgq2aXXjgt3f2Pt4PahUNBA/lP/kw5mjXNKqL38Q9qffUVGRt3+urhUQx
	 dlz4ICsa1Fu33s2cUFhCvFQk6QcLI/ipQgP0jSQh51dsj+B0mCHA1K2SBRANW6k6y5
	 7UdZu394U03hXGPI6A4fxYjqfv+5AiUF2UPF/x+hiDyfjEDzZgjDTO6ctf0HqE74/i
	 QmzA5cFclWw3xvxEpckilWXSXusqF+2bJNRsPCGoKI7FqMCMhVM2/Tic18EJyKu1vB
	 g2mFElQ4FBzQPqerHB5kjJmXuxpAPsNqbQ17cRVfClXKWUysPGj7vPSzdsWBV+MN31
	 hMFrXu4w9wFog==
Date: Fri, 28 Feb 2025 18:28:27 +0000
From: Conor Dooley <conor@kernel.org>
To: iansdannapel@gmail.com
Cc: linux-fpga@vger.kernel.org, Moritz Fischer <mdf@kernel.org>,
	Wu Hao <hao.wu@intel.com>, Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	=?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
	Aradhya Bhatia <a-bhatia1@ti.com>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [v4 2/3] dt-bindings: fpga: Add Efinix SPI programming bindings
Message-ID: <20250228-copilot-trekker-72a20709e9f7@spud>
References: <20250228094732.54642-1-iansdannapel@gmail.com>
 <20250228094732.54642-3-iansdannapel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="AS3vEBsZDnj/RgTT"
Content-Disposition: inline
In-Reply-To: <20250228094732.54642-3-iansdannapel@gmail.com>


--AS3vEBsZDnj/RgTT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 28, 2025 at 10:47:31AM +0100, iansdannapel@gmail.com wrote:
> From: Ian Dannapel <iansdannapel@gmail.com>
>=20
> Add device tree bindings documentation for configuring Efinix FPGA
> using serial SPI passive programming mode.
>=20
> Signed-off-by: Ian Dannapel <iansdannapel@gmail.com>
> ---
>  .../devicetree/bindings/fpga/efinix,spi.yaml  | 81 +++++++++++++++++++
>  1 file changed, 81 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/fpga/efinix,spi.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/fpga/efinix,spi.yaml b/Doc=
umentation/devicetree/bindings/fpga/efinix,spi.yaml
> new file mode 100644
> index 000000000000..145c96f38e45
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/fpga/efinix,spi.yaml

Filename matching a compatible please.

> @@ -0,0 +1,81 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/fpga/efinix,spi.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Efinix SPI FPGA Manager
> +
> +maintainers:
> +  - Ian Dannapel <iansdannapel@gmail.com>
> +
> +description: |
> +  Efinix FPGAs (Trion, Topaz, and Titanium families) support loading bit=
streams
> +  through "SPI Passive Mode".
> +  Note 1: Only bus width 1x is supported.
> +  Note 2: Additional pins hogs for bus width configuration must be set
> +  elsewhere, if necessary.
> +  Note 3: Topaz and Titanium support is based on documentation but remai=
ns
> +  untested.

Points 1 and 3 here seem to be driver limitations, and shouldn't really
be present in a document describing the hardware?

> +
> +  References:
> +  - https://www.efinixinc.com/docs/an006-configuring-trion-fpgas-v6.3.pdf
> +  - https://www.efinixinc.com/docs/an033-configuring-titanium-fpgas-v2.8=
=2Epdf
> +  - https://www.efinixinc.com/docs/an061-configuring-topaz-fpgas-v1.1.pdf
> +
> +allOf:
> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - efinix,trion-spi
> +      - efinix,titanium-spi
> +      - efinix,topaz-spi

> +      - efinix,fpga-spi

What hardware does this device represent? Other ones are obvious matches
to the families you mention, but what is this one?

Cheers,
Conor.

> +
> +  spi-cpha: true
> +
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
> +      reset and re-configuration trigger pin (low active)
> +    maxItems: 1
> +
> +  cdone-gpios:
> +    description:
> +      optional configuration done status pin (high active)
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - reset-gpios
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    spi {
> +      #address-cells =3D <1>;
> +      #size-cells =3D <0>;
> +      cs-gpios =3D <&gpio5 13 GPIO_ACTIVE_LOW>;
> +      fpga-mgr@0 {
> +        compatible =3D "efinix,trion-spi";
> +        reg =3D <0>;
> +        spi-max-frequency =3D <25000000>;
> +        spi-cpha;
> +        spi-cpol;
> +        reset-gpios =3D <&gpio4 17 GPIO_ACTIVE_LOW>;
> +        cdone-gpios =3D <&gpio0 9 GPIO_ACTIVE_HIGH>;
> +      };
> +    };
> +...
> --=20
> 2.43.0
>=20

--AS3vEBsZDnj/RgTT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ8IASgAKCRB4tDGHoIJi
0thJAQD4jSzMiXmJNGF3+fTuX3iqDrBrj7De8ZSSs9QXN5XNrQD/dmoWXwwVtGRl
ZcTDYcWkEyhtzlIdRr+Goyx79zmRAgU=
=s0W/
-----END PGP SIGNATURE-----

--AS3vEBsZDnj/RgTT--

