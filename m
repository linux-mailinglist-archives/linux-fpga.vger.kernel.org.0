Return-Path: <linux-fpga+bounces-556-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3120D9122B5
	for <lists+linux-fpga@lfdr.de>; Fri, 21 Jun 2024 12:43:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 536E91C23C25
	for <lists+linux-fpga@lfdr.de>; Fri, 21 Jun 2024 10:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBFF9171E75;
	Fri, 21 Jun 2024 10:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="sq1Ew4Lx"
X-Original-To: linux-fpga@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A0E616D33A;
	Fri, 21 Jun 2024 10:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718966605; cv=none; b=LhYOvU3HNTaTr11Ryp2C/osV6kyEpRoX1hRmsMQjT6iCOZ73vFQKrCFfFVVYZA1ZpsOrplVLRcKvW4rGyG8YTKslkxDgxXyj8+REq8d+3P8Pdpq6MT+3AGJMkeajp5q4pv5lFZPfpchBfspbIU6pBBABu2FKnADu8BTP7FMWZF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718966605; c=relaxed/simple;
	bh=IZnQNKQcDyMpuRjvn+CDx6ivUi2HBYIERMvXDIRo5N4=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EQCWmGb/Z/qxCylwRvWwbKIKfQIphwMA65jD0juHGSCI/P9AxgI2Y4/+wS70zYAPgWkJwIihkdp/UZbt9+txXBeN5uPWZ0GBxneZ6+7Ss3sSv2PFi/t2r0a0PIb/nn4wK/KNj7gE0dCpgschVZgITlcjcpddBXWJRASuSPHqARY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=sq1Ew4Lx; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1718966603; x=1750502603;
  h=date:from:to:subject:message-id:references:mime-version:
   in-reply-to;
  bh=IZnQNKQcDyMpuRjvn+CDx6ivUi2HBYIERMvXDIRo5N4=;
  b=sq1Ew4Lx97+8oW2iGupqOFjVuZZ1E+Z0rgTJ0kU+mAt52am6/R0dS5sW
   x1P3kDfq3a+f8htnFViXfe+97lHd+Zf7GOzD8sP0nfiKrQM3ivEJrCh//
   /KS1w3rajbhh0kOSkIbLuJy6k7hY/PkwIEn6kIUSJFZWzImx2Ucufm/1e
   Sp72tPtUH+XxUyHsF9Y9rpBA+jzKrSevPQIY/Q1MSQLlknxdVxQx1yqem
   aUCDALgRT08w7HaouOwrGlH8CbWZ6cwNPvN+EyU2eh/X9EEHPPhQiHc2J
   VXiTl76zmJ0rmy0b97ZexgCJqU3aKZ+5nuW0kXJWMwt0e/EXg1DIucFg9
   Q==;
X-CSE-ConnectionGUID: Efk0HLtdQoyfmo6ObaiG9A==
X-CSE-MsgGUID: 24mJEfUDRF2iLaBiwXtWfw==
X-IronPort-AV: E=Sophos;i="6.08,254,1712646000"; 
   d="asc'?scan'208";a="28316196"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 Jun 2024 03:43:22 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 21 Jun 2024 03:43:11 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex04.mchp-main.com (10.10.85.152)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Fri, 21 Jun 2024 03:43:09 -0700
Date: Fri, 21 Jun 2024 11:42:50 +0100
From: Conor Dooley <conor.dooley@microchip.com>
To: Conor Dooley <conor@kernel.org>, <iansdannapel@gmail.com>,
	<mdf@kernel.org>, <hao.wu@intel.com>, <yilun.xu@intel.com>,
	<trix@redhat.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <linux-fpga@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] dt-bindings: fpga: Add Efinix serial SPI programming
 binding description
Message-ID: <20240621-promptly-railroad-8b83cd213282@wendy>
References: <20240620144440.125374-1-iansdannapel@gmail.com>
 <20240620-rubdown-buffing-312d308c2d4d@spud>
 <20240621-operation-trapezoid-844948baa860@thorsis.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="UQWwXbW7nYjmx+9s"
Content-Disposition: inline
In-Reply-To: <20240621-operation-trapezoid-844948baa860@thorsis.com>

--UQWwXbW7nYjmx+9s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 21, 2024 at 10:11:24AM +0200, Alexander Dahl wrote:
> Am Thu, Jun 20, 2024 at 04:47:41PM +0100 schrieb Conor Dooley:
> > On Thu, Jun 20, 2024 at 04:44:40PM +0200, iansdannapel@gmail.com wrote:
> > > From: Ian Dannapel <iansdannapel@gmail.com>
> > >=20
> > > Add device tree binding documentation for configuring Efinix FPGA
> > > using serial SPI passive programming mode.
> > >=20
> > > Signed-off-by: Ian Dannapel <iansdannapel@gmail.com>
> > > ---
> > >  .../bindings/fpga/efnx,fpga-passive-spi.yaml  | 76 +++++++++++++++++=
++
> > >  1 file changed, 76 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/fpga/efnx,fpga-=
passive-spi.yaml
> > >=20
> > > diff --git a/Documentation/devicetree/bindings/fpga/efnx,fpga-passive=
-spi.yaml b/Documentation/devicetree/bindings/fpga/efnx,fpga-passive-spi.ya=
ml
> > > new file mode 100644
> > > index 000000000000..855ceb3b89e8
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/fpga/efnx,fpga-passive-spi.ya=
ml
> > > @@ -0,0 +1,76 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/fpga/efnx,fpga-passive-spi.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Efinix SPI FPGA Manager
> > > +
> > > +description: |
> > > +  Efinix Trion and Titanium Series FPGAs support a method of loading=
 the
> > > +  bitstream over what is referred to as "SPI Passive Programming".
> > > +  Only serial (1x bus width) is supported, setting the programming m=
ode
> > > +  is not in the scope the this manager and must be done elsewhere.
> > > +
> > > +  References:
> > > +  - https://www.efinixinc.com/docs/an033-configuring-titanium-fpgas-=
v2.6.pdf
> > > +  - https://www.efinixinc.com/docs/an006-configuring-trion-fpgas-v6.=
0.pdf
> > > +
> > > +allOf:
> > > +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> > > +
> > > +properties:
> > > +  compatible:
> > > +    enum:
> > > +      - efnx,fpga-spi-passive
> >=20
> > Ahh, here is the user. Can you please add specific compatibles for the
> > Trion and Titanium series FPGAs? And when you do, make the filename
> > match a compatible please.
> >=20
> > Additionally, why "efnx" and not "efinix"?
>=20
> FWIW, there already is "altr,fpga-passive-serial" for Altera devices.
>=20
> Not sure why Altera got this short vendor prefix, but that was 2013
> with commit 5db17a71a526 ("of: add vendor prefix for Altera Corp.")
> and we probably never know?

I think that was the stock ticker name for Altera.

> The method of transferring the configuration data over SPI into the
> FPGA is comparable.  I would go so far to claim a single driver could
> support both device families for passive configuration over SPI.  I've
> done that in a non-public driver for U-Boot few months ago, and used
> "efinix,fpga-passive-serial" as a compatible there.  The difference is
> basically Altera requiring more GPIOs considered, and Efinix keeping
> the SPI clock on for some time after data is already transfered.

That'd prob be helpful to comment on the driver patch. I'd still like to
see device specific compatibles here for the trion and titanium though.

Thanks,
Conor.

--UQWwXbW7nYjmx+9s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZnVZKgAKCRB4tDGHoIJi
0gZSAQDqlDo1xAYJ4/GeyETk0Bz7ymm1MdkQONKwauwXvxEGAQD/VMjKhnkITsG7
+q2ZN93g1i58IH9Q+MyMd2fYx2QuHg8=
=VM7l
-----END PGP SIGNATURE-----

--UQWwXbW7nYjmx+9s--

