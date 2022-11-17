Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22F8362DFDD
	for <lists+linux-fpga@lfdr.de>; Thu, 17 Nov 2022 16:31:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230365AbiKQP3W (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 17 Nov 2022 10:29:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233886AbiKQP3V (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 17 Nov 2022 10:29:21 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D155BE092;
        Thu, 17 Nov 2022 07:29:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5C8ECB820CC;
        Thu, 17 Nov 2022 15:29:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C1E3C433D6;
        Thu, 17 Nov 2022 15:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668698957;
        bh=Hvwc01/3yDHo0mlCHTJoRvYzt4sg7OWQTAH1M11emsI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V2okfJdKufjQ4NeD/iKu8qeqau2EJS429bP41ytUbUllmt8oCRioOFShYvqcxI0Ev
         6FuclaeBw0eSh28b2I8B1J8q+0liN62wfNmuO42sFkFWJAQqL4OgWH53ro9QgMf59f
         xVxiDwgnReFMEjiwljUKhIEH3q2BSejaPDFE5TH9VQJzDP6VR8q4ij9AFZrSfJ1rfP
         mLnMAQrOM7HPdk4QdwWI4mBcNVXaA+Q58WHb4AOzTYN8J3wxk8GWBcn1fPEjezhKEw
         aX/hp0n4UapYYnWaKFX8AyWITzlPgyo+vadLrW4B2eE+u6NElVBLC73z3S+Ac8/fZt
         7OhitODm1aisA==
Date:   Thu, 17 Nov 2022 15:29:13 +0000
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
Message-ID: <Y3ZTSSLUqHil4dfl@sirena.org.uk>
References: <20221117120515.37807-1-ilpo.jarvinen@linux.intel.com>
 <20221117120515.37807-8-ilpo.jarvinen@linux.intel.com>
 <Y3Y4vWr/CGbaH0HQ@sirena.org.uk>
 <a089f1a0-c0f4-e1a2-d084-fd83e28e7e33@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hXPPuvu63nVhkBT8"
Content-Disposition: inline
In-Reply-To: <a089f1a0-c0f4-e1a2-d084-fd83e28e7e33@linux.intel.com>
X-Cookie: Ego sum ens omnipotens.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


--hXPPuvu63nVhkBT8
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 17, 2022 at 04:35:23PM +0200, Ilpo J=E4rvinen wrote:
> On Thu, 17 Nov 2022, Mark Brown wrote:
> > On Thu, Nov 17, 2022 at 02:05:11PM +0200, Ilpo J=E4rvinen wrote:

> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * Indirect Register Access.
> > > + *
> > > + * Copyright (C) 2020-2022 Intel Corporation, Inc.
> > > + */
> > > +#include <linux/debugfs.h>

> > Please make the entire comment a C++ one so things look more
> > intentional.

> Eh, all/most SPDX-License-Identifier lines are done like this one?!?

The SPDX header has to be a C++ comment, please make the rest of
this a C++ comment.

> > > +	ret =3D readl_poll_timeout(ctx->base + ctx->indirect_cfg->ack_offse=
t, ack,
> > > +				 (ack & ctx->indirect_cfg->ack_mask) =3D=3D ctx->indirect_cfg->a=
ck_mask,
> > > +				 ctx->indirect_cfg->sleep_us, ctx->indirect_cfg->timeout_us);

> > This all looks very specific to one particular implementation,
> > requiring a particular set of memory mapped registers and
> > operations - things like the initial read of the command for
> > example. It's not clear to me how much reuse this is likely to
> > see outside of the one driver you're trying to add - if you want
> > to implement something device specific you can just provide
> > the custom operations in the device's regmap configuration rather
> > than having to provide a bus.  Why add a bus?

> The point of not doing it in a particular driver is that the users will=
=20
> be spread around more than into a single driver. This is a generic=20
> mechanism for accessing registers of IPs on Intel FPGA. The point being=
=20
> that IPs can use this common mechanism rather than each coming up their=
=20
> own way.

You're saying that this is generic but it's really not looking
very generic at all, like I say there's a bunch of assumptions in
the code that look entirely specific to your implementation here.
Any abstraction and reusability seems extremely unclear, I'm not
seeing what this is doing that is diffrent to the driver using
this providing it's own register read and write operations.

> Mark Brown objected earlier naming it something related to Intel FPGAs [1]
> but I certainly know it still fixes the operations like you note even if=
=20
> the offsets and values are now "customizable" (they weren't in the=20
> earliest versions of this patch).

> [1] https://lore.kernel.org/all/YqB9O8HhZV2tXo8g@sirena.org.uk/T/#m75d4ab=
dfd00f05866d837246ddc357a8af53cf99

No, what I'm objecting to there is pretty much the same thing I'm
saying here - this doesn't seem like it's a particularly generic
implementation and I'm really not clear that there'd be anything
meaningful left by the time the implementation assumptions are
removed.

--hXPPuvu63nVhkBT8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmN2U0gACgkQJNaLcl1U
h9CMgQf+LcsUGEjp5K9RINt2UFzzr0AC44juz2HVQXIT1ghNwm7LejrvCHyX3fjN
59PX8uDliKh47ReihFqW30u7H7LYn+N/iNPn2CtuInXAQctZBClQVFmi/5y/DTwz
qlgoUBk2FEyhQaU1QV5ulcPWHpt72/bjs1LqW7npMkbn+fuTNH6kPrPjGXqxMXt2
iD0MZOkPAnGUGmAlDzL+Lgwa8EMTGA1hrVWKDBNxeB2k4g6bVrFYB4GlertIoplu
swbzW1TxeklB69gmwkq7Y6RNEew3Xlr2Fts6WAyzJsmxgXmrUNV99ZBEp0ZxzyrF
+ynReAJhYZ1YbW9r6aBFZZJHMQSBfA==
=4fZ7
-----END PGP SIGNATURE-----

--hXPPuvu63nVhkBT8--
