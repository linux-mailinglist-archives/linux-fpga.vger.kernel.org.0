Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A132F3CBB3A
	for <lists+linux-fpga@lfdr.de>; Fri, 16 Jul 2021 19:33:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbhGPRgd (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 16 Jul 2021 13:36:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:60288 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229803AbhGPRgd (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Fri, 16 Jul 2021 13:36:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B3381613FB;
        Fri, 16 Jul 2021 17:33:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626456818;
        bh=cf8WxUiyJPqIMeZaZvs8bmw2NGyFNYO33dlQ1WqpQrQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QhDbbSYvSCyTW3hYRZhJQb/Q8R13s9FjRMH/XFprr/6AMpWEjgsCoXhgZOxuhHzon
         hyLnOsdx8fmBUHnicBp4dlktJuQnUaBO4BFl8A1bzRv9LcjNyXkwablWOj5cHuXNgf
         tBxbbNQ893BphhUEtEZO8l8IgHosM9sRvKqey02Vp9zso+WmZPqsZejVl4epuEdM3y
         aOoF/QPqXBHVZj/KCuUCv5z2WgMCPGepGSNZqBVkXPz2vVDLUpLRuq8hAlUElxyvXI
         TSIlSSMACzMcU1SQWiIu2xPfhGR31fBDbzTaQDXcCDjnWTmTcUCB1vXTDDT8WbJ+IF
         rUk+zSj4f5dFA==
Date:   Fri, 16 Jul 2021 18:33:35 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Martin =?iso-8859-1?Q?Hundeb=F8ll?= <martin@geanix.com>
Cc:     Wu Hao <hao.wu@intel.com>, Tom Rix <trix@redhat.com>,
        Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Martin =?iso-8859-1?Q?Hundeb=F8ll?= <mhu@silicom.dk>,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH v5 2/3] spi: spi-altera-dfl: support n5010 feature
 revision
Message-ID: <20210716173335.GC4137@sirena.org.uk>
References: <20210716135441.3235863-1-martin@geanix.com>
 <20210716135441.3235863-3-martin@geanix.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="raC6veAxrt5nqIoY"
Content-Disposition: inline
In-Reply-To: <20210716135441.3235863-3-martin@geanix.com>
X-Cookie: do {
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


--raC6veAxrt5nqIoY
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 16, 2021 at 03:54:40PM +0200, Martin Hundeb=F8ll wrote:
> From: Martin Hundeb=F8ll <mhu@silicom.dk>
>=20
> The Max10 BMC on the Silicom n5010 PAC is slightly different than the
> existing BMCs, so use a dedicated feature revision detect it.

Acked-by: Mark Brown <broonie@kernel.org>

--raC6veAxrt5nqIoY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmDxwu4ACgkQJNaLcl1U
h9DndAf+IqeWflVSPxKlrQ2Z+7ext9oSMMuq5l/EIJZmwdXPKSImWc8J0uocAxHw
+eWOQoyg6h96X3SyocivzrmsrVMUMmRvUZqT3tLIBqN4ihciC2HMCloVXpZpO8f5
N5Rg6IMsYqpV03IaRERfLtVt/jmXNF7SVL+1H/wdCFYJVywJDcG8XYF/Z3dtmvhW
kmOmGYimOAejLycEEZARLBD/zrRgOJ4fxgVAlHLEdT1gzYUJRhC6mpokpxtpH3fg
QJpNf9HNKF7r7E2jGAsC5CUjWE0KwPR9OI9E9+R2A8hEk2Nqdon+hfieZyYyhCiJ
w7oP4OEHfZEiPJZ46zTnkN4KhHyX5A==
=1O5g
-----END PGP SIGNATURE-----

--raC6veAxrt5nqIoY--
