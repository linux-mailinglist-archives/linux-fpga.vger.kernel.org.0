Return-Path: <linux-fpga+bounces-41-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BA5D7F7433
	for <lists+linux-fpga@lfdr.de>; Fri, 24 Nov 2023 13:49:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4375D281CFA
	for <lists+linux-fpga@lfdr.de>; Fri, 24 Nov 2023 12:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAC201864D;
	Fri, 24 Nov 2023 12:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LpqsmpXj"
X-Original-To: linux-fpga@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71D61799E;
	Fri, 24 Nov 2023 12:49:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97706C433C8;
	Fri, 24 Nov 2023 12:49:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700830145;
	bh=0/fjlCNQfvRSIG2DQIR0FRU4Xx3x1rDhMmjCSc2dHTE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LpqsmpXjNkQvLIxL/ylXUZ91zdM7G+iqppgN2q7cz2T4+sGCGpPVZdZYRXvKojtif
	 JM1HZFTmyyVMXmO/BbzyQ1IraS78klmcvBQdJCm1GsPKnnbzwQ+818lecrSVzitWTN
	 2uhykAVa1811461fU36jc0eW6sVL+OaFoRntPPbx75HzI5hNu740qxbX+QZUh3lY1J
	 VPs1Xa0LdBXirImjN7pSx+f9R0UyAq/8sI8izlhzDjvfjHVL5qpzznGNeczlnflsk7
	 CQa9N7TiTQfB5l9jnLNPWdF0A2GJAarSigH0aXAUHITc9K1pmVrwOwcXyzQA8RvTJ4
	 wsrCRFJonRdIA==
Date: Fri, 24 Nov 2023 12:48:59 +0000
From: Conor Dooley <conor@kernel.org>
To: "Manne, Nava kishore" <nava.kishore.manne@amd.com>
Cc: "mdf@kernel.org" <mdf@kernel.org>,
	"hao.wu@intel.com" <hao.wu@intel.com>,
	"yilun.xu@intel.com" <yilun.xu@intel.com>,
	"trix@redhat.com" <trix@redhat.com>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"Simek, Michal" <michal.simek@amd.com>,
	"mathieu.poirier@linaro.org" <mathieu.poirier@linaro.org>,
	"Levinsky, Ben" <ben.levinsky@amd.com>,
	"Potthuri, Sai Krishna" <sai.krishna.potthuri@amd.com>,
	"Shah, Tanmay" <tanmay.shah@amd.com>,
	"dhaval.r.shah@amd.com" <dhaval.r.shah@amd.com>,
	"arnd@arndb.de" <arnd@arndb.de>,
	"Datta, Shubhrajyoti" <shubhrajyoti.datta@amd.com>,
	"linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [RFC PATCH 1/3] dt-bindings: fpga: Add support for user-key
 encrypted bitstream loading
Message-ID: <20231124-tweezers-slug-0349a2188802@spud>
References: <20231122054404.3764288-1-nava.kishore.manne@amd.com>
 <20231122054404.3764288-2-nava.kishore.manne@amd.com>
 <20231122-exert-gleeful-e4476851c489@spud>
 <DM6PR12MB3993F0EC4930E68C54299B36CDB8A@DM6PR12MB3993.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="i9ugnADt+2no1y19"
Content-Disposition: inline
In-Reply-To: <DM6PR12MB3993F0EC4930E68C54299B36CDB8A@DM6PR12MB3993.namprd12.prod.outlook.com>


--i9ugnADt+2no1y19
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 24, 2023 at 06:35:19AM +0000, Manne, Nava kishore wrote:
> Hi Conor,
>=20
> 	Thanks for providing the review comments.
> Please find my response inline.
>=20
> > -----Original Message-----
> > From: Conor Dooley <conor@kernel.org>
> > Sent: Wednesday, November 22, 2023 10:21 PM
> > To: Manne, Nava kishore <nava.kishore.manne@amd.com>
> > Cc: mdf@kernel.org; hao.wu@intel.com; yilun.xu@intel.com;
> > trix@redhat.com; robh+dt@kernel.org; krzysztof.kozlowski+dt@linaro.org;
> > conor+dt@kernel.org; Simek, Michal <michal.simek@amd.com>;
> > mathieu.poirier@linaro.org; Levinsky, Ben <ben.levinsky@amd.com>;
> > Potthuri, Sai Krishna <sai.krishna.potthuri@amd.com>; Shah, Tanmay
> > <tanmay.shah@amd.com>; dhaval.r.shah@amd.com; arnd@arndb.de;
> > Datta, Shubhrajyoti <shubhrajyoti.datta@amd.com>; linux-
> > fpga@vger.kernel.org; devicetree@vger.kernel.org; linux-
> > kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org
> > Subject: Re: [RFC PATCH 1/3] dt-bindings: fpga: Add support for user-key
> > encrypted bitstream loading
> >=20
> > On Wed, Nov 22, 2023 at 11:14:02AM +0530, Nava kishore Manne wrote:
> > > Adds =E2=80=98encrypted-key-name=E2=80=99 property to support user-ke=
y encrypted
> > > bitstream loading use case.
> > >
> > > Signed-off-by: Nava kishore Manne <nava.kishore.manne@amd.com>
> > > ---
> > >  .../devicetree/bindings/fpga/fpga-region.txt  | 32
> > > +++++++++++++++++++
> >=20
> > Is there a reason that this has not yet been converted to yaml?
> >=20
> I am not sure about the complication involved here why it's not converted=
 to yaml format.
> Due to time constraints, I couldn=E2=80=99t spend much time so I have use=
d this existing legacy format
> to add my changes.
>=20
> > >  1 file changed, 32 insertions(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/fpga/fpga-region.txt
> > > b/Documentation/devicetree/bindings/fpga/fpga-region.txt
> > > index 528df8a0e6d8..309334558b3f 100644
> > > --- a/Documentation/devicetree/bindings/fpga/fpga-region.txt
> > > +++ b/Documentation/devicetree/bindings/fpga/fpga-region.txt
> > > @@ -177,6 +177,9 @@ Optional properties:
> > >  	it indicates that the FPGA has already been programmed with this
> > image.
> > >  	If this property is in an overlay targeting an FPGA region, it is a
> > >  	request to program the FPGA with that image.
> > > +- encrypted-key-name : should contain the name of an encrypted key f=
ile
> > located
> > > +	on the firmware search path. It will be used to decrypt the FPGA
> > image
> > > +	file with user-key.
> >=20
> > I might be misreading things, but your driver code seems to assume that=
 this
> > is an aes key. Nothing here seems to document that this is supposed to =
be a
> > key of a particular type.
> >=20
>=20
> Yes, these changes are intended to add the support for Aes user-key encry=
pted bitstream loading use case.
> Will fix it in v2, something like below.
> aes-key-file-name : Should contain the AES key file name on the firmware =
search path.
> 		      The key file contains the AES key and it will be used to decrypt =
the FPGA image.

Then when someone comes along looking for a different type of encryption
we will end up with national-pride-foo-file-name etc. I think I'd rather
have a second property that notes what type of cipher is being used and
if that property is not present default to AES.

--i9ugnADt+2no1y19
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZWCbuwAKCRB4tDGHoIJi
0vV7AQCqNqM2cmGU/BCfxWj5TJvLx3rZlbmMCQx94IZ0wEBgcgD/SwPOUEDaTgm7
9HEV331ZuK9GycuqRUL7gyLlrRb7Fgw=
=n0AP
-----END PGP SIGNATURE-----

--i9ugnADt+2no1y19--

