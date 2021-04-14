Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0B5335F60F
	for <lists+linux-fpga@lfdr.de>; Wed, 14 Apr 2021 16:22:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347390AbhDNOTA (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 14 Apr 2021 10:19:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:60444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348303AbhDNOTA (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 14 Apr 2021 10:19:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0BAFA61019;
        Wed, 14 Apr 2021 14:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618409918;
        bh=3+BEa1WIe58IawQ6VmmJOzqBr5VUedP15td9Yp8Hja8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=feFFbNfOb3QXsKWsPk5qK67Fa/JDO38PJ0hTsOQQDTVm2vzZJorf+dx9KnXdGttx2
         BqVxz+jkwyvDxrpbueTxNYalvNf/sDyFrt41EACC2a43y9zJN1cIdcwwmiZ5Tt5QQD
         cTsTTdn5tadgscWz9VU1Rv6czywdfdGkBZyL7uWEnR5S0MDKv2bUBfIoU0F4pgvBlM
         i095pHpIZcAVpWVEKuXP+dFwkQM4ZqS4EDFNbsNd1T0SgL4S0ic3MyzehZ/Oi/9Q2y
         LTAnxz5LAYHOEOgD/D7gEh7ihzy7xltXj6X/QcAqwGlcs7+A9jAGACM7FSBnNrqj4f
         CeAlPmcNbx4SQ==
Date:   Wed, 14 Apr 2021 15:18:16 +0100
From:   Mark Brown <broonie@kernel.org>
To:     matthew.gerlach@linux.intel.com
Cc:     hao.wu@intel.com, trix@redhat.com, mdf@kernel.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        yilun.xu@intel.com, jdelvare@suse.com, linux@roeck-us.net,
        lee.jones@linaro.org, linux-hwmon@vger.kernel.org,
        russell.h.weight@intel.com, linux-spi@vger.kernel.org
Subject: Re: [PATCH v2 1/2] spi: Add DFL bus driver for Altera SPI Master
Message-ID: <20210414141816.GD4535@sirena.org.uk>
References: <20210413225835.459662-1-matthew.gerlach@linux.intel.com>
 <20210413225835.459662-2-matthew.gerlach@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zbGR4y+acU1DwHSi"
Content-Disposition: inline
In-Reply-To: <20210413225835.459662-2-matthew.gerlach@linux.intel.com>
X-Cookie: George Orwell was an optimist.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


--zbGR4y+acU1DwHSi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 13, 2021 at 03:58:34PM -0700, matthew.gerlach@linux.intel.com wrote:

> +++ b/drivers/spi/spi-altera-dfl.c
> @@ -0,0 +1,222 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * DFL bus driver for Altera SPI Master
> + *

Please make the entire comment a C++ one so things look more
intentional.

> +	memset(&pdevinfo, 0, sizeof(pdevinfo));
> +
> +	pdevinfo.name = "subdev_spi_altera";
> +	pdevinfo.id = PLATFORM_DEVID_AUTO;
> +	pdevinfo.parent = dev;
> +	pdevinfo.data = &pdata;
> +	pdevinfo.size_data = sizeof(pdata);
> +
> +	return platform_device_register_full(&pdevinfo);

Don't create a platform device here, extend the spi-altera driver to
register with both DFL and platform buses.

--zbGR4y+acU1DwHSi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmB2+acACgkQJNaLcl1U
h9AI6gf+NS9LzXREWWKJsIJdM7epyzoLnZtHG1CXXEPLU7ng5Ii9GchDNM6fJMyt
4F48+okJW2olNPq03QY8LHEPCjXGMqGbIoWMSUH4F/L+sUfNKyDHg6lCWLgYzkHk
qhjIMFuZflh0WEFJbWAUNWm2WTJEgEFgyf6fNOgoReaOkOfE5T8foZgEd54FSbxB
EifEY/L+VSTZXBOlDibAEiMizeKXjIBvQ4g8la4lJesFmQcgDJg/4qr+400WJM/s
Cy2G2gN15tB2mDYr7gcQkUy50r2Vx4kgXbePBF3cGFoRBLq4wnuRqMf4zGsZKA/n
ehLYl0S92Jzn94vcINKp8J2HN1cGiQ==
=eB6p
-----END PGP SIGNATURE-----

--zbGR4y+acU1DwHSi--
