Return-Path: <linux-fpga+bounces-1461-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C3FBC587AC
	for <lists+linux-fpga@lfdr.de>; Thu, 13 Nov 2025 16:48:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80A4C42003D
	for <lists+linux-fpga@lfdr.de>; Thu, 13 Nov 2025 15:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4465359718;
	Thu, 13 Nov 2025 15:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AcRoJkWa"
X-Original-To: linux-fpga@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7ECE359712;
	Thu, 13 Nov 2025 15:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763047094; cv=none; b=dNoVeS7EVx9HYwaI2G16TOa9S+icktSaeR+mIVgwB7raB8ncybX4wyfSh6lAGiD5rO2ZULa/+yAXVlUzFeG7WzI3h1OZ6kfrYvxwW5LeceTsMzgofdmzvh2QDT5iFhJdztrQN95H+0VBzFrqiBtSsQLOc7IxUzE54DHDzxeOXzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763047094; c=relaxed/simple;
	bh=akDGSZ8NZGTZE+dKZXPwbwewMZSsNcbWHubp3ouC8Uw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cqup4ZsQgT5chfN8fJ7cm1YX1ZSIWQoFIbiQ9Y3moCBjil/18hIxuYijz1nwWbBBUtg9FmhSGXNH8jsD9OblfDlZEUs3EWZtF7curHdD0EWPdlHyB6UHC8HCaPO9IjVn4wEjpIVX8Vqsadv19j2Y3hH10U1LIJtbgcZ7FV0rYG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AcRoJkWa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DC3AC4CEF5;
	Thu, 13 Nov 2025 15:18:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763047094;
	bh=akDGSZ8NZGTZE+dKZXPwbwewMZSsNcbWHubp3ouC8Uw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AcRoJkWaNM2t9ywADCDQ9VAaPdaWgy0McpjW69L9TLPWj+8c55kd44o/k2Yfp9Qql
	 fWCtbgh63URYfNm9VYmVbZnqLw0H7qFiKQti0aXagDP+8ggwLFgJLdf8ItQlrU+af6
	 cO2nSnlnhygjSjOKuBevIExtPHyzyAMpuX0QUI73DhkYpic9yl+9y5QX2sBX224b6p
	 /HXNt0q1O4Qj6b0AO1uiw2YjD2Xe1hF4cVb3VEyxE3uRqT4qdnf2Y0wIC4Njn09QFV
	 FshmUBPU+eHUl+tJ1SEh2Nde4+WZI63eVZ5f4S8U6qUN0umSFxGoRv9jWmZSoT8qgZ
	 mLHbVR5UhhOXg==
Date: Thu, 13 Nov 2025 15:18:08 +0000
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
Subject: Re: [PATCH v2 1/2] dt-bindings: fpga: stratix10: add support for
 Agilex5
Message-ID: <20251113-buckshot-deeply-4654ba05b940@spud>
References: <cover.1763008269.git.khairul.anuar.romli@altera.com>
 <e342dc1626ae07d6b1773ad9fa5232d38af76bc2.1763008269.git.khairul.anuar.romli@altera.com>
 <aRVx85JJHDD4yygV@yilunxu-OptiPlex-7050>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dlqke+i+nDLgcyhp"
Content-Disposition: inline
In-Reply-To: <aRVx85JJHDD4yygV@yilunxu-OptiPlex-7050>


--dlqke+i+nDLgcyhp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 13, 2025 at 01:51:47PM +0800, Xu Yilun wrote:
> On Thu, Nov 13, 2025 at 12:43:55PM +0800, Khairul Anuar Romli wrote:
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
> > Changes in v2:
> > 	- No changes in this patch

Should have been changed to permit the fallback compatible as discussed.
pw-bot: changes-requested


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
> Reviewed-by: Xu Yilun <yilun.xu@intel.com>
>=20
> > =20
> >  required:
> >    - compatible
> > --=20
> > 2.43.7
> >=20
> >=20

--dlqke+i+nDLgcyhp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaRX2sAAKCRB4tDGHoIJi
0rdYAQC7sQEVu7SKrMQ3KHq3DVBedYoFsFA1OVppngdT2j+vMQD/S3sHmlSllRZL
Gely8CY3d+X3HaLtpKLUeVi/q1zpIgQ=
=PhQO
-----END PGP SIGNATURE-----

--dlqke+i+nDLgcyhp--

