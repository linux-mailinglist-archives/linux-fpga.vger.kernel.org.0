Return-Path: <linux-fpga+bounces-1086-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BEAA9A4BC5C
	for <lists+linux-fpga@lfdr.de>; Mon,  3 Mar 2025 11:34:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88D4018851C7
	for <lists+linux-fpga@lfdr.de>; Mon,  3 Mar 2025 10:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 646671F2BA4;
	Mon,  3 Mar 2025 10:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="fN4m84i5"
X-Original-To: linux-fpga@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A6C11F17E5;
	Mon,  3 Mar 2025 10:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740997971; cv=none; b=It0qnx/WM10QIiKtRT+FBrIrB9C6F5DzMryZlL1VR1qeaioD4JTeHXqS6fODllX8t6/wHo6smen1sl1C5p7hp9dtEMmqagfllFD8O2v7ZV8c9vuhLJlfyEIk0MSUoM/JcHdOde0jnxkFfjA1Oc+2SmCknU+dtpDYlxJ3e0Im41c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740997971; c=relaxed/simple;
	bh=fqF5ukVSFGV3EgFZXiEa4ck6u9+DJwi8aWwrJtLxWE8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LU/Bh0RbNCrQgkaHXRPMnVKZE7O9xbCBFS4TMzVpc/FpWLjtSzGWMxzxjRvp6y6H0TPzSuxw0MJRhr5KTSdS0LW/TpBT+UT87rw7jOh/hE1eCAe6NLzBwGGMSOasASn/JWJd57qm9IvAZxw2l5gzI1JVnL7zeBdm8k8x/c8YcPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=fN4m84i5; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1740997969; x=1772533969;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fqF5ukVSFGV3EgFZXiEa4ck6u9+DJwi8aWwrJtLxWE8=;
  b=fN4m84i5wuM2djRp1cyPu7EKug3xiDx+M3EJwEZdNsaGiZGpwpxEizut
   50geFW1oPgkLDeivXSPrxvNJlKY2CGC4YOOmRcW2mtqgfDxsOz/z+Avtz
   mWXpcLdjzmnUiG/zU0rRo2V92546KxR2eDmzRup85u3lSWy/tDcGJrlsA
   SB7dacCPLDxmV3fyMY/+TN0QUCWu+/Ni2AuUnwtKVthFHtM7Hlpa3RuW3
   izeHBkJh5n3LoOqPuhZb9nSGU/65cEY5ihzxLnrx4IyFrnYXO8Ec8Q2M4
   DNK8adAtLTFq3iyFQvE3YdqNF9+io9njdXcrUo5XKB4lcafRLc56ViVVd
   A==;
X-CSE-ConnectionGUID: I/+YZuCUTEWlY9bn8j7eEA==
X-CSE-MsgGUID: q+QHdo2+QKqpUxRb+G3ZWQ==
X-IronPort-AV: E=Sophos;i="6.13,329,1732604400"; 
   d="asc'?scan'208";a="38333761"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 Mar 2025 03:32:42 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 3 Mar 2025 03:32:33 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex01.mchp-main.com (10.10.85.143)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Mon, 3 Mar 2025 03:32:31 -0700
Date: Mon, 3 Mar 2025 10:31:44 +0000
From: Conor Dooley <conor.dooley@microchip.com>
To: Ian Dannapel <iansdannapel@gmail.com>
CC: Conor Dooley <conor@kernel.org>, <linux-fpga@vger.kernel.org>, Moritz
 Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>, Xu Yilun
	<yilun.xu@intel.com>, Tom Rix <trix@redhat.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, Jonathan
 Cameron <Jonathan.Cameron@huawei.com>, =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?=
	<rafal@milecki.pl>, Aradhya Bhatia <a-bhatia1@ti.com>, "open list:OPEN
 FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [v4 2/3] dt-bindings: fpga: Add Efinix SPI programming bindings
Message-ID: <20250303-imply-ferocity-bbb6d866b149@wendy>
References: <20250228094732.54642-1-iansdannapel@gmail.com>
 <20250228094732.54642-3-iansdannapel@gmail.com>
 <20250228-copilot-trekker-72a20709e9f7@spud>
 <CAKrir7hdyP-bPKkZOpK3cFp=rvH_MJ98DLKnsRni_BWsQEg5yw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="6qSyW+QWd6cb4mh+"
Content-Disposition: inline
In-Reply-To: <CAKrir7hdyP-bPKkZOpK3cFp=rvH_MJ98DLKnsRni_BWsQEg5yw@mail.gmail.com>

--6qSyW+QWd6cb4mh+
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 03, 2025 at 11:10:53AM +0100, Ian Dannapel wrote:
> Hi Conor, thanks for the quick response.
>=20
> On Fri, Feb 28, 2025 at 7:28=E2=80=AFPM Conor Dooley <conor@kernel.org> w=
rote:
> > > +description: |
> > > +  Efinix FPGAs (Trion, Topaz, and Titanium families) support loading=
 bitstreams
> > > +  through "SPI Passive Mode".
> > > +  Note 1: Only bus width 1x is supported.
> > > +  Note 2: Additional pins hogs for bus width configuration must be s=
et
> > > +  elsewhere, if necessary.
> > > +  Note 3: Topaz and Titanium support is based on documentation but r=
emains
> > > +  untested.
> >
> > Points 1 and 3 here seem to be driver limitations, and shouldn't really
> > be present in a document describing the hardware?
> >
> Yes, they are driver limitations and probably do not belong here.
>=20
> > > +properties:
> > > +  compatible:
> > > +    enum:
> > > +      - efinix,trion-spi
> > > +      - efinix,titanium-spi
> > > +      - efinix,topaz-spi
> >
> > > +      - efinix,fpga-spi
> >
> > What hardware does this device represent? Other ones are obvious matches
> > to the families you mention, but what is this one?

> The proposed compatible is a generic fallback for any Efinix FPGA Series.

If it is a fallback, your binding should look like:
compatible:
  items:
    - enum:
        - efinix,trion-spi
        - efinix,titanium-spi
        - efinix,topaz-spi
    - const: efinix,fpga-spi

|+static const struct of_device_id efinix_spi_of_match[] =3D {
|+       { .compatible =3D "efinix,trion-spi", },
|+       { .compatible =3D "efinix,titanium-spi", },
|+       { .compatible =3D "efinix,topaz-spi", },

And these three compatibles can/should be removed from the driver, since
the fallback is required.

|+       { .compatible =3D "efinix,fpga-spi", },
|+       {}
|+};


--6qSyW+QWd6cb4mh+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ8WFEAAKCRB4tDGHoIJi
0mjaAP9sKCcpox/aH/Z7wfpAn1ngc3aHe9qRSNM9Pg58kBau0gD/Z0MX38lEpA6u
9WckYxf5O3kqdLEngN8LcxlSx/Atggs=
=3tRF
-----END PGP SIGNATURE-----

--6qSyW+QWd6cb4mh+--

