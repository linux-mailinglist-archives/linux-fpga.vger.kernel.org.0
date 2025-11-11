Return-Path: <linux-fpga+bounces-1444-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 246E3C4F59C
	for <lists+linux-fpga@lfdr.de>; Tue, 11 Nov 2025 19:00:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C4D3D34C9B2
	for <lists+linux-fpga@lfdr.de>; Tue, 11 Nov 2025 18:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A58DC3A1D1E;
	Tue, 11 Nov 2025 18:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZwY9UsEj"
X-Original-To: linux-fpga@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F6126657D;
	Tue, 11 Nov 2025 18:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762884014; cv=none; b=m0DYf0kU6iMLQLte6N58loN8avz9aqkoQwj7rSJwWtGRSbNUREwVmJOnkNh8bWPiSq131QDSz447KeRV/bEmugTVob8ROFcMbvtXMartmzL7J23kIzcQHKDSa1YOcD3KUZkt0bY0BnLnGB1qRr0McKXd7VGk10pRHOClANESiVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762884014; c=relaxed/simple;
	bh=8EXIkw6/zRp9qTNsy3uSXwzG+vr+zTWHdU/ZYlli4rc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BjQqZEjdTTRXldKEz3xZJrCi3kcivl/a41SYntzeSQ24RNZJRBfyelCeMaYjs4MeRStZGQGj03rU3Pj1bHITbNTe3z53DrHPmvbxfbCiZLKwdbgWwGnIqKl4twj0jZEgjaTysyLB//CDiSRYh9E7zfWOi5wo22EKDeKkSoSJaPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZwY9UsEj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F186C113D0;
	Tue, 11 Nov 2025 18:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762884014;
	bh=8EXIkw6/zRp9qTNsy3uSXwzG+vr+zTWHdU/ZYlli4rc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZwY9UsEjkLEssUGiG3TVR4STNlZmyFEM3fzwil65N4ll3XIE5CYFJ9rBfHLbCa+KE
	 j3xY5aEKSfatbeN6MWEIfytDLtIsylBSA7hPwAJxOB49pp6imk/tVWGpxl5BKaXg87
	 6FhS6BCloP+y2BQ7nOKHtMfhoq9+UsrrMzKQdVHdta9b8jPlwFTv4OE87oSmKbOhUv
	 o5IJo5Oh398H/VMOBRhOOXuzxQmIjvuF+uWRawFeKccubdQ7vlhP0QU5HXNWkSXasX
	 jjYce/H4aFMiWqMrD4+rOc93dN4HCXw8/PjkCP+n3JTOXWVB+i6lffUtjTeSUoPwAp
	 rbz1bJs9KwAHg==
Date: Tue, 11 Nov 2025 18:00:08 +0000
From: Conor Dooley <conor@kernel.org>
To: Xu Yilun <yilun.xu@linux.intel.com>
Cc: Khairul Anuar Romli <khairul.anuar.romli@altera.com>,
	Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>, Dinh Nguyen <dinguyen@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Mahesh Rao <mahesh.rao@altera.com>,
	Ho Yin <adrian.ho.yin.ng@altera.com>,
	Niravkumar L Rabara <nirav.rabara@altera.com>,
	linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: fpga: stratix10: add support for Agilex5
Message-ID: <20251111-skewer-sturdily-989457c9fa70@spud>
References: <cover.1762835252.git.khairul.anuar.romli@altera.com>
 <0e3986dd9a2c4e46466a7430b2573d170d2a718a.1762835252.git.khairul.anuar.romli@altera.com>
 <aRL7/Hjb1Z/OrC91@yilunxu-OptiPlex-7050>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="carrje968T1m2UPU"
Content-Disposition: inline
In-Reply-To: <aRL7/Hjb1Z/OrC91@yilunxu-OptiPlex-7050>


--carrje968T1m2UPU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 11, 2025 at 05:03:56PM +0800, Xu Yilun wrote:
> On Tue, Nov 11, 2025 at 03:48:31PM +0800, Khairul Anuar Romli wrote:
> > The Agilex 5 SoC FPGA manager introduces updated hardware features and
> > register maps that require explicit binding support to enable correct
> > initialization and control through the FPGA manager subsystem.
> >=20
> > It allows FPGA manager drivers detect and configure Agilex 5 FPGA manag=
ers
> > properly. This changes also keep device tree bindings up to date with
> > hardware platforms changes.
> >=20
> > Signed-off-by: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
> > ---
> >  .../devicetree/bindings/fpga/intel,stratix10-soc-fpga-mgr.yaml   | 1 +
> >  1 file changed, 1 insertion(+)
> >=20
> > diff --git a/Documentation/devicetree/bindings/fpga/intel,stratix10-soc=
-fpga-mgr.yaml b/Documentation/devicetree/bindings/fpga/intel,stratix10-soc=
-fpga-mgr.yaml
> > index 6e536d6b28a9..b531522cca07 100644
> > --- a/Documentation/devicetree/bindings/fpga/intel,stratix10-soc-fpga-m=
gr.yaml
> > +++ b/Documentation/devicetree/bindings/fpga/intel,stratix10-soc-fpga-m=
gr.yaml
> > @@ -23,6 +23,7 @@ properties:
> >      enum:
> >        - intel,stratix10-soc-fpga-mgr
> >        - intel,agilex-soc-fpga-mgr
> > +      - intel,agilex5-soc-fpga-mgr
>=20
> I'm not quite familar about dt rules, but since these are all software
> defined strings, do we really have to write down every version even if
> they behave exactly the same? Seems a waste of time.

Sort of. You "have" to add a new string to the binding, because there
may end up being bugs that only manifest in one SoC etc, and having the
string pre-emptively is helpful. I'm not familiar with these particular
fpga managers, but if it has some way of identifying it's own version,
then doing that dynamically instead of having specific compatibles is
often permitted.

What is a waste of time is adding it to the driver. When the driver diff
looks like:
|--- a/drivers/fpga/stratix10-soc.c
|+++ b/drivers/fpga/stratix10-soc.c
|@@ -448,6 +448,7 @@ static void s10_remove(struct platform_device *pdev)
| static const struct of_device_id s10_of_match[] =3D {
|        {.compatible =3D "intel,stratix10-soc-fpga-mgr"},
|        {.compatible =3D "intel,agilex-soc-fpga-mgr"},
|+       {.compatible =3D "intel,agilex5-soc-fpga-mgr"},
|        {},
| };

That's a solid indicator that there should be a fallback compatible used
here, as the devices behave identically. A devicetree node would then
contain
compatible =3D "intel,agilex5-soc-fpga-mgr", "intel,agilex-soc-fpga-mgr";
instead of
compatible =3D "intel,agilex5-soc-fpga-mgr";
and the driver would match on the second compatible in the list.

pw-bot: changes-requested

Cheers,
Conor.

--carrje968T1m2UPU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaRN5qAAKCRB4tDGHoIJi
0kkNAP92uSfOfJiT8nbwOb9bK75/kFtvXOM5RDHQGx4Gqlbc4QD/btSqX/CZOjsk
lyWzwCIP9xoYU77H/6JOO7+GLkQ8kw4=
=tBy/
-----END PGP SIGNATURE-----

--carrje968T1m2UPU--

