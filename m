Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E4DF3B715E
	for <lists+linux-fpga@lfdr.de>; Tue, 29 Jun 2021 13:36:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233485AbhF2Li3 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 29 Jun 2021 07:38:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:33110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233465AbhF2Li2 (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 29 Jun 2021 07:38:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 81A5761DC0;
        Tue, 29 Jun 2021 11:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624966561;
        bh=pYliXn2M4VfrJX8TzwqqkNaDbTWyLeW26vN692MeXFs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JB41puISmEDTBggcW/EYaznSop6rFYX2iLsu8IUr4Ib1HOx7mcN/kow8Ne2CpoPcc
         LKfikAk8ni6eiIS4p3lmSxFeyD60q0BqG0S4JSJySkh+Z0/GfbtAzDIt0b5Oe82mK8
         4/tFYGv8W2xerL90zBreG6phNFPT8o2y6SZh3cuKXg3QnAWDjAJb5V+JsISGWpi/oz
         v3PKi9+Zs0z0F4YSE6ZSmulEELDL7kErk0HxD9E619m4z4owRFzSUDK2GR7YMSRIAx
         otRJYxDE+Pzj/CUjq3I/jkD0n1f/nvcyOusrutZ6dWj06AfZ16DWb1H88OJ/1/GCX0
         ZzBmdxGOl1hcw==
Date:   Tue, 29 Jun 2021 12:35:33 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Moritz Fischer <mdf@kernel.org>
Cc:     Martin =?iso-8859-1?Q?Hundeb=F8ll?= <martin@geanix.com>,
        Wu Hao <hao.wu@intel.com>, Tom Rix <trix@redhat.com>,
        Xu Yilun <yilun.xu@intel.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Lee Jones <lee.jones@linaro.org>,
        Martin =?iso-8859-1?Q?Hundeb=F8ll?= <mhu@silicom.dk>,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH v2 3/5] spi: spi-altera-dfl: support n5010 feature
 revision
Message-ID: <20210629113533.GA4613@sirena.org.uk>
References: <20210625074213.654274-1-martin@geanix.com>
 <20210625074213.654274-4-martin@geanix.com>
 <YNoJSxnm4g1vufbB@epycbox.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="liOOAslEiF7prFVr"
Content-Disposition: inline
In-Reply-To: <YNoJSxnm4g1vufbB@epycbox.lan>
X-Cookie: Use extra care when cleaning on stairs.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


--liOOAslEiF7prFVr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 28, 2021 at 10:39:23AM -0700, Moritz Fischer wrote:

> Since this depends on the previous patch: Mark do you want to take both
> patches once they're reviewed? From what I can tell the BMC and HWMON
> don't directly depend on it, so taking them through SPI tree might be
> easiest.

> Alternatively I can provide a tag for the DFL change for you to pull.

Sure, I can do whichever - I guess me applying both is probably
simplest?

--liOOAslEiF7prFVr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmDbBYQACgkQJNaLcl1U
h9BVYQf+JHlDZbFReYVDmGaonZ6Kw48CZV8LHo+jLUaByBMUiETh7/O8ynfZXJEK
/Hh2rsQls2ie/mwegg7Zp6cyMfCprAeM5b7hNAx1T9fKC0Q8SixDqadBX5mhuFXy
S/cjjvc11+oBy/qpiguv9cKOb3uxs7dkCTYyHrUqPAWraCUw5U1NktIKSY+mALsz
X44jgAhHhklyPeoqSWtgszclt6W3I9+337q80QasWuxVLeYoujWd4M0j+5ClLzv1
ccYKrOOKOUmu7ilTzPZoGC9qlPNg16Nefo3BsGiK6ZUniWiQspHCpSbwBQzy5Yvl
jL9yactFQlx5XCt8wSetmfJFw6ynMA==
=4W2f
-----END PGP SIGNATURE-----

--liOOAslEiF7prFVr--
