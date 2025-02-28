Return-Path: <linux-fpga+bounces-1072-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 07625A4A18B
	for <lists+linux-fpga@lfdr.de>; Fri, 28 Feb 2025 19:29:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 140B87A8793
	for <lists+linux-fpga@lfdr.de>; Fri, 28 Feb 2025 18:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9C2C27426B;
	Fri, 28 Feb 2025 18:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jr2pyMZM"
X-Original-To: linux-fpga@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD9C1F4C85;
	Fri, 28 Feb 2025 18:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740767347; cv=none; b=A11VWzslD8kccaDcaU/CVTzH6RNP7usW+snKbwi2lw/QaiRsyt4fCAunM5G+2nt0xa4O1xSV8Z8sbwbkEP9eBtMy5UF1UJZx43EJUW7ES3KKlg9UxR/SILNtUHn7dqJ3wM6LJEl8lLqEG8Rf2Phg4VEKzTQiDgVBKJ1tPUxid6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740767347; c=relaxed/simple;
	bh=8rfbN9lNNqu4CaYs/gqLKzPE1yRFHM9492rIIuIEsIw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H0LYZSGsXpQCjdopqhH7Xi4QU2lxtRTVQffp01itR0uuhDIzeIYbS5vh7s3l2nkbhtXX6nooluVvdNNJNn34+xxgopZ9bewGIn28jx9l9ee1S/1xiIfb+YbegXx3g4DtL8vlA7Qm7v34pOqBsewZuuUVcfqi4D8kQW8zjNGk8m0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jr2pyMZM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BD1EC4CED6;
	Fri, 28 Feb 2025 18:29:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740767347;
	bh=8rfbN9lNNqu4CaYs/gqLKzPE1yRFHM9492rIIuIEsIw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jr2pyMZMej0fJcEh0WdcAr/PIZPUjpQ0aSo+bAyWzOqjk9XxBbMxj9pljkpNXYMMT
	 8YgR6YTrfD4bmYsiv86ifj2Qm9Sa1fCYsvu1Tmfw5cl9mH1dXoAv0BcN9mx+PO3PMJ
	 3jMRAAMruHjRTSP6B5XGMRaYT5x6aeK1uoIwX7BHIiNsSvsycsxKsqmJwmPwFEKD5Q
	 DRdeChV/3+ih8gslITlN8QvQnbw749jcwT0rCqwS+UgYjNL16LGPRZ9rftIVbsCGkn
	 OO9kzQ5IwgJJr0hRzfxNgAiAnJH145uc+DtEi0Y49LoS7uj/F++tIxz3wmwKOsSVw7
	 IMfIy92h1oDZQ==
Date: Fri, 28 Feb 2025 18:29:02 +0000
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
Subject: Re: [v4 1/3] dt-bindings: vendor-prefix: Add prefix for Efinix, Inc.
Message-ID: <20250228-bonsai-aqua-7909be8ac466@spud>
References: <20250228094732.54642-1-iansdannapel@gmail.com>
 <20250228094732.54642-2-iansdannapel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ZKOxp+ln9WYwtaD8"
Content-Disposition: inline
In-Reply-To: <20250228094732.54642-2-iansdannapel@gmail.com>


--ZKOxp+ln9WYwtaD8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 28, 2025 at 10:47:30AM +0100, iansdannapel@gmail.com wrote:
> From: Ian Dannapel <iansdannapel@gmail.com>
>=20
> Add entry for Efinix, Inc. (https://www.efinixinc.com/)
>=20
> Signed-off-by: Ian Dannapel <iansdannapel@gmail.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Doc=
umentation/devicetree/bindings/vendor-prefixes.yaml
> index 5079ca6ce1d1..f0e0da4e1ec0 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> @@ -438,6 +438,8 @@ patternProperties:
>      description: Emtop Embedded Solutions
>    "^eeti,.*":
>      description: eGalax_eMPIA Technology Inc
> +  "^efinix,.*":
> +    description: Efinix, Inc.
>    "^einfochips,.*":
>      description: Einfochips
>    "^eink,.*":
> --=20
> 2.43.0
>=20

--ZKOxp+ln9WYwtaD8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ8IAbgAKCRB4tDGHoIJi
0q22AQDQQnsMIZlCBZfy7MVBiqeuhbsI+GO/vHLDxSxgOxfNzQD+NKXmeouPoOZ4
+ESaZGkHcc8eBN/d7Etb5TOyOLzfCQs=
=atR4
-----END PGP SIGNATURE-----

--ZKOxp+ln9WYwtaD8--

