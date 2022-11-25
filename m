Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62612639017
	for <lists+linux-fpga@lfdr.de>; Fri, 25 Nov 2022 19:55:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbiKYSxu (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 25 Nov 2022 13:53:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiKYSxr (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 25 Nov 2022 13:53:47 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 222F31E70E;
        Fri, 25 Nov 2022 10:53:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C9E34B82BF7;
        Fri, 25 Nov 2022 18:53:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87C12C433D6;
        Fri, 25 Nov 2022 18:53:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669402423;
        bh=m9DmreRsp3qm+OBs9c7PwmWAYIsMOGxzO+D37vTFY/Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kw2da1MqwcjZgn6L89tWiGvKo0b2JLIIcVq+9GzOCEexQ13Sdf47gxY2WeNtVrthX
         yILwPnh3hDmpxHWGbjEsaZzHBVrcfgLwg8eTKjUk9EubUhu9gLPkyuUXcH33HssRXp
         B2cfT24m7dsOLwLTY3xEbco9nmsbdVePxhx9HGIdnsnxneu1YGseIB9p4ek2srPqrN
         QPF+HjBJt8rlgsL6ptE6Z6oELFQHX8oXhrKVMvl29ptIOCIO+2gChlaJOD3HZVz3lb
         EjIlodgs5tO3lj2MMCIWQtC8kZwYWhI1eXDjq1zN1Nt6ByD9xqr+YEAZYmWfGMv2HN
         GoNX3Hki6K5ug==
Date:   Fri, 25 Nov 2022 18:53:37 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     linux-fpga@vger.kernel.org, Xu Yilun <yilun.xu@intel.com>,
        Wu Hao <hao.wu@intel.com>, Tom Rix <trix@redhat.com>,
        Moritz Fischer <mdf@kernel.org>, Lee Jones <lee@kernel.org>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        Russ Weight <russell.h.weight@intel.com>,
        Tianfei zhang <tianfei.zhang@intel.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Marco Pagani <marpagan@redhat.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 07/11] regmap: indirect: Add indirect regmap support
Message-ID: <Y4EPMbc+KCuDpuxJ@sirena.org.uk>
References: <20221117120515.37807-1-ilpo.jarvinen@linux.intel.com>
 <20221117120515.37807-8-ilpo.jarvinen@linux.intel.com>
 <Y3Y4vWr/CGbaH0HQ@sirena.org.uk>
 <a089f1a0-c0f4-e1a2-d084-fd83e28e7e33@linux.intel.com>
 <Y3ZTSSLUqHil4dfl@sirena.org.uk>
 <a82565d-c282-7ace-e759-6514c29cca1c@linux.intel.com>
 <Y3eOzOmTeTKBoPrd@sirena.org.uk>
 <a97ce076-4ca6-5f1b-eba4-4068dcb64b3d@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3F/01jOFRbO3fGT2"
Content-Disposition: inline
In-Reply-To: <a97ce076-4ca6-5f1b-eba4-4068dcb64b3d@linux.intel.com>
X-Cookie: Time and tide wait for no man.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


--3F/01jOFRbO3fGT2
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 21, 2022 at 03:37:40PM +0200, Ilpo J=E4rvinen wrote:

> Previously you were against saying it clearly that it's Intel FPGA=20
> specific when Matthew proposed changing the name to not sound something=
=20
> too generic. If you're ok with that now, I'm happy to make such change.

Saying it's for some Intel FPGA just makes it sound like it should only
live within the driver for that FPGA.  The issue with there being only
one user:

> > Perhaps you have some name for this
> > interface?  You're only adding one user here which isn't helping
> > make the case that this is something generic.

is part of it, as is the fact that the naming is so very generic.  Even
"Intel FPGA" seems to be heading to the generic side, this is presumably
some specific thing rather than just something that everyone using a
FPGA from Intel is going to need.  The issue with this being overly
specific isn't just the name, it's the code as well.

> > I can't tell what you're trying to say here.  Are you saying that
> > this is somehow baked into some FPGA design so that it's memory
> > mapped with only a few registers showing to the rest of the
> > system rather than just having a substantial memory mapped
> > window like is typically used for FPGAs, but someohow this
> > register window stuff is implemented in the soft IP so people are
> > just throwng vaugely similar interfaces into a random host mapped
> > register layout?
>=20
> What I tried to say the users are not expected to be nicely confined into=
=20
> drivers/mfd/ (and a single driver in there).

So this interface is part of the physical IP surrounding the actual
programmable bit of a FPGA or something?  That doesn't seem entirely
right though given the fact that the registers are apparently one of the
things that gets moved around a lot.  I still have no idea what this
hardware actually looks like or what this code is trying to represent,
especially given the very few things that you are trying to
parameterise.  It's really not obvious there's even any point in trying
to share this code at the abstraction level you've gone for.

Do you have any examples of even a second user that isn't this one MFD
which you can share?

> You didn't answer at all my question about where to place the code?
> I'm repeating it with the context below since you cut it off:

I keep telling you to either make this so that it's actually generic or
just have register get/set operations in the regmap for the device using
it.  As things stand with the code you've sent there's a bunch of things
like the way it's doing direct MMIO (which means it only works on top of
memory mapped devices) and the absolute requirement for an idle command
and a wait for completion which clearly look like this is device specific.

> Whether that is "generic" enough to reside in drivers/base/regmap can
> of course be debated but lets say I put it into drivers/mfd/ along with=
=20
> the code currently using it. By doing that, we'll postpone this discussio=
n=20
> to the point when the first driver using it outside of drivers/mfd/ comes=
=20
> by. At that point, having the indirect code in drivers/mfd/ is shown to=
=20
> be a wrong choice.

> It's of course nothing that couldn't be fixed by patches moving the code=
=20
> around to some more preferred location. And that location likely turns ou=
t=20
> to be drivers/base/regmap, no? Or do you have a better place for it in=20
> that case?

If you think this should be shared via regmap then make it shareable.
That needs more work than just repainting the name.

--3F/01jOFRbO3fGT2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmOBDzAACgkQJNaLcl1U
h9BIRQf/SIePGloROG+aH1fiQ/rM6HTduYZzQGL8uh9F7UopIHC/NMsPzlq7FR7P
Js+8wSigBiuoW+xKYw+IsgqJDQCVR9rTdxzhRJ9LUXBn5vyamYyGKnBo58XpK5g0
wHo7++T/755N6k7S6/at+PzNramNqRIG0jaknuO6KkiIvpXFFCinUMcjAuTEKkPk
XcxhnvUAgwPKXroEBJ7XwsIhPzFbu/ltcnoHdKqzUseAeJRfcQT1zfXn/4FG59p0
9/Eav+JKz8xD5bA/JiJ8rPPE2UGBJpEm/m/z6a6/Quyn3wvzZG1f6/XCB5FU0o3H
h4grJUPgAJh363cWCdfHxuhebDA+/A==
=tsLN
-----END PGP SIGNATURE-----

--3F/01jOFRbO3fGT2--
