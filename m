Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 026DA360874
	for <lists+linux-fpga@lfdr.de>; Thu, 15 Apr 2021 13:44:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232268AbhDOLpM (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 15 Apr 2021 07:45:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:60770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231549AbhDOLpL (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 15 Apr 2021 07:45:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CD35D61132;
        Thu, 15 Apr 2021 11:44:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618487088;
        bh=PihK5dfas/WVMlw9t+kHCah/aAVGAaBd50HblG0mcrc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=See5n71LngVdG5j2SzEVbcUQ2hvHx2B+L+ERVu2U/XyaQFxyeX7+daxG2naDoH6yY
         sogE77A6RBcoHmmbBRdEjb+uGFuVIhfHCSJlya8NGzdqoojUeoB1N2EepZJ+bG7JqM
         o8oltkl937XvKf8cXtUrPBG3HDUzOU1odg1ipkp4sp1o1VnMTHv8p4+mLVtdAxCya+
         3/a7FStPOdKSE3dJwPcVRPVzZm8GbySNpbWLUAm9M9xkPlOF8WNtQtxLersm/95MSI
         2TMVV22t+6izgn+he0iL7qLAErLQ6o+3d+FdEntp6mscdiQ6QLRlO0jgH0J1DS0HBW
         V6HvxNw+WcvJg==
Date:   Thu, 15 Apr 2021 12:44:24 +0100
From:   Mark Brown <broonie@kernel.org>
To:     matthew.gerlach@linux.intel.com
Cc:     hao.wu@intel.com, trix@redhat.com, mdf@kernel.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        yilun.xu@intel.com, jdelvare@suse.com, linux@roeck-us.net,
        lee.jones@linaro.org, linux-hwmon@vger.kernel.org,
        russell.h.weight@intel.com, linux-spi@vger.kernel.org
Subject: Re: [PATCH v2 1/2] spi: Add DFL bus driver for Altera SPI Master
Message-ID: <20210415114424.GA5514@sirena.org.uk>
References: <20210413225835.459662-1-matthew.gerlach@linux.intel.com>
 <20210413225835.459662-2-matthew.gerlach@linux.intel.com>
 <20210414141816.GD4535@sirena.org.uk>
 <alpine.DEB.2.22.394.2104141203480.482712@rhweight-WRK1>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="UlVJffcvxoiEqYs2"
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2104141203480.482712@rhweight-WRK1>
X-Cookie: VMS must die!
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 14, 2021 at 12:09:50PM -0700, matthew.gerlach@linux.intel.com wrote:
> On Wed, 14 Apr 2021, Mark Brown wrote:

> > Don't create a platform device here, extend the spi-altera driver to
> > register with both DFL and platform buses.

> Are you suggesting something like the SPI driver for the Designware
> controller where there is spi-dw-core.c and bus specific code like
> spi-dw-pci.c and spi-dw-mmioc.c?

Yes, exactly.

--UlVJffcvxoiEqYs2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmB4JxcACgkQJNaLcl1U
h9An/Af/VFqnGaFp0qF5AyIs2gQj+NbPJA3hBIMLLMcz/tC6Q5pKphaA7Pr3+fKT
hPQVYO+H7biwiX0WQ+BJZPnMo/7gDUEmOBnc+KvOIl/0q8FouNOoeaMsw+ScY3Kv
fgHKSBD7ZS+29tHY+aN5jAQfAmjt6p/kpNyVEXQgUFiAQx1XKgSNrKzsAg1Ilcag
LMXlyNukME0pC0Xu2lAZRAWlQsNLmq4k4bOckqR1nBRM8W271uO/i5/Q0+ybKxP8
iFBSpZKfQ/na4GTVmNcFc6n2bc6CgwRAPng7lV2BX3gddCUnQ9N3VnEJZ7ubsZp3
WFC0lKcGgWzXy3AE20kaJVDaFoYuHQ==
=XEtk
-----END PGP SIGNATURE-----

--UlVJffcvxoiEqYs2--
