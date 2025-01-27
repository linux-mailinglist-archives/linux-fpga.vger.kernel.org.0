Return-Path: <linux-fpga+bounces-1020-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C9DC8A1DB8F
	for <lists+linux-fpga@lfdr.de>; Mon, 27 Jan 2025 18:51:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 319BC7A2606
	for <lists+linux-fpga@lfdr.de>; Mon, 27 Jan 2025 17:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D73DE186E26;
	Mon, 27 Jan 2025 17:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pxem3p8G"
X-Original-To: linux-fpga@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F28617C224;
	Mon, 27 Jan 2025 17:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738000263; cv=none; b=fXPENLBVl1Frnst5x3N2+ZW05lFiEMvusGPsBBJB9xjBu9FCOM0qR3UZL25M0qeZlOLwZeZx83WunHTcMl1CN0QwUEjVSUkdDIfJxrS9kRn9NsMb42RfqSoGVT+qHpIm/HeYHQmCw0edEWCNMHswcQn7CY2BZav1jaNWXdgUSxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738000263; c=relaxed/simple;
	bh=IeTCcvQEisr6CkVqokJme6NmzUrMdXyWgz64L5KANvs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qf/OtYRUEby2tuHD041pFhMLEY4Wx7Q2zKQ+Vb4FhQVXD7A1vllHiTh80LgTRRsXJapNNLaMqD48hG8QZW+eoJtaCGHb4vYEzy1mUkJQAaHyc+IbrE3UVU8vRoZVrTtDtY9uSGyiyOTImKL4/i3+24vF0hEqDe+xu+7RtFW4biM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pxem3p8G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0B3DC4CED2;
	Mon, 27 Jan 2025 17:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738000263;
	bh=IeTCcvQEisr6CkVqokJme6NmzUrMdXyWgz64L5KANvs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Pxem3p8GUhsE3BXpT/RE78TL6fV4Fme7XY7kYoSYXuqHHjbqsOAR50EUUBZ9AYBoD
	 3ZlkyO2yiKWYgqICyLQbPZ/FsVpe+tYfpgIi5JkNglF6yUODyHCLmZFuwA4kTwoNYf
	 +EoFsmllOCqPHZkVRjlXbg2GJKtRqqaqdi9hv3zkHm2OeyZws9gOa9o/BrcBKDR+s9
	 YhEl44bevk0pAEhMNBcBvILBphLW3bvWiQtcoTSNUVNXFq7WFKEuoKXxmOq0Q0XaOF
	 VcldK+o3S2de2JzHzft5H69XxfUzkpImbAItswXNU6fTwt0yIB5sovta4aTaWBexIU
	 9EXabjMpwYULw==
Date: Mon, 27 Jan 2025 17:50:58 +0000
From: Conor Dooley <conor@kernel.org>
To: Mahesh Rao <mahesh.rao@intel.com>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, dinguyen@kernel.org,
	hao.wu@intel.com, krzk+dt@kernel.org,
	krzysztof.kozlowski@linaro.org, linux-fpga@vger.kernel.org,
	linux-kernel@vger.kernel.org, mahesh.rao@altera.com, mdf@kernel.org,
	robh@kernel.org, trix@redhat.com, yilun.xu@intel.com
Subject: Re: [PATCH 2/3] dt-bindings: firmware: stratix10: Convert to
 json-schema
Message-ID: <20250127-bunt-tremble-b13b319d6575@spud>
References: <20250122-decode-celtic-fb7a491957bb@spud>
 <20250127170705.12988-1-mahesh.rao@intel.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="C5tprECUZk2KV6Hi"
Content-Disposition: inline
In-Reply-To: <20250127170705.12988-1-mahesh.rao@intel.com>


--C5tprECUZk2KV6Hi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 28, 2025 at 01:07:05AM +0800, Mahesh Rao wrote:
> Hi Conor Dooley,
>=20
> On Wed, 22 Jan 2025 18:40:41 +0000, Conor Dooley wrote:
> > > Convert intel,stratix10-svc service layer devicetree binding file from
> > > freeform format to json-schema.
> >=20
>=20
> > > +
> > > +  method:
> > > +    enum: [smc, hvc]
> > > +    description: supervisory call method to be used for the service =
layer.
> >=20
> > This looks to be missing a type (string) and an explanation of what "sm=
c" and
> > "hvc" are.
> >=20
>=20
> Thanks for pointing out , will do the change in next revision.
>=20
> > > +
> > > +  fpga-mgr:
> > > +    $ref: /schemas/fpga/intel,stratix10-soc-fpga-mgr.yaml
> > > +    description: Optional child node for fpga manager to perform fab=
ric
> > configuration.
> >=20
> > This is new and not justified in your commit message. Please explain wh=
ere
> > this has come from in v2.
> >=20
> > Cheers,
> > Conor.
> >=20
>=20
> Sure, this is an optional child node/driver present in the device tree for
> the Agilex SoC devices, but it was not mentioned in the text documentatio=
n.
> Therefore, I had included it here. I will provide more details about this
> change in the next version.

Aye, the change itself is fine. Just mention what the rationale for
adding it is and you're good.

--C5tprECUZk2KV6Hi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ5fHggAKCRB4tDGHoIJi
0qS9AP9EDgZ0iRT6T2wpRtOcjzLPWNpMTLB4i3FUVTzdwdnldgEAskvMbUG3Sv/u
uMMt+fcRlAAnj0uoZrHXTr5+bHNWVwE=
=gpoJ
-----END PGP SIGNATURE-----

--C5tprECUZk2KV6Hi--

