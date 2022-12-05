Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98997642FD9
	for <lists+linux-fpga@lfdr.de>; Mon,  5 Dec 2022 19:24:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231416AbiLESWZ (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 5 Dec 2022 13:22:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232064AbiLESWY (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 5 Dec 2022 13:22:24 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E4FA1B9E6;
        Mon,  5 Dec 2022 10:22:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0CB31B811E1;
        Mon,  5 Dec 2022 18:22:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB956C433C1;
        Mon,  5 Dec 2022 18:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670264540;
        bh=JAlMx8rOQfE1qIg0DQrKE6Z2s3EsrxH6OHPnY9U9BPE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sCWU6YpkiijTvok5jT3jZnYZuDItK0qN14jL/ejjWD+XqjmAc3ZoppKR2E1sYZIpq
         4DRJISUFsWxoVqTGYdBNy0YXdiOmZLYAEhsaisOpydYWqWNXywQUQijJgd0zjC6C35
         DZmNZedc6zcMwq4Xgvs47YIWuzqKRYKi7IR4lfxsK3Yl4WwbS3FArG9yVsz+xtIDzs
         93Uree4QSQMXvtNf8o6TIsds8cDXPGShIaSmG9gjCec6H4zRCbXD9iiC61VdfEGsfs
         X5M+0coyiavK8qU2Fi7lRTNwoy8lZZVXWWbqN2e10tGLjldj4p26W1mqCrmAN833xe
         mCRwmZk9d0OUg==
Date:   Mon, 5 Dec 2022 18:22:14 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Xu Yilun <yilun.xu@intel.com>
Cc:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        linux-fpga@vger.kernel.org, Wu Hao <hao.wu@intel.com>,
        Tom Rix <trix@redhat.com>, Moritz Fischer <mdf@kernel.org>,
        Lee Jones <lee@kernel.org>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        Russ Weight <russell.h.weight@intel.com>,
        Tianfei zhang <tianfei.zhang@intel.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Marco Pagani <marpagan@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 7/9] mfd: intel-m10-bmc: Add PMCI driver
Message-ID: <Y4421iAKIm44ghQR@sirena.org.uk>
References: <20221202100841.4741-1-ilpo.jarvinen@linux.intel.com>
 <20221202100841.4741-8-ilpo.jarvinen@linux.intel.com>
 <Y4ox5J0junaUYyT7@yilunxu-OptiPlex-7050>
 <855d463e-fb84-1910-f53-58e6b0a633a4@linux.intel.com>
 <Y43eejWSYIBIlUKB@sirena.org.uk>
 <Y44JaLtAnTll4gU0@yilunxu-OptiPlex-7050>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="v7aS8Ac+G9koXonX"
Content-Disposition: inline
In-Reply-To: <Y44JaLtAnTll4gU0@yilunxu-OptiPlex-7050>
X-Cookie: If it ain't broke, don't fix it.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


--v7aS8Ac+G9koXonX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 05, 2022 at 11:08:24PM +0800, Xu Yilun wrote:

> It is good for now to implement the indirect access interface in
> regmap_config, as intel-m10-bmc is the only one who uses it. But I'm not
> sure when a second IP block(like HSSI) in intel FPGA uses it, how to
> implement? A shared library?

The short answer is that I'm not really clear what this looks like so
it's hard to say.

Usually things for anything generic end up in drivers/base/regmap but it
should be generic in some way and thus far the code that's been posted
has been very much looking specific to a single device even where it's
been named as something generic.  I've not been able to extract a clear
picture of what the hardware that's being described is and the code has
looked like it's more some vaugely related designs than anything really
shared, it's really felt like people just want to just merge whatever
they have in which case just putting it in the driver is the most
expedient thing.

Clearly the concept of a register map accessed via indirection is a
generic thing but to implement that at the very least the underlying
register map should be another regmap rather than hard coded to MMIO.

> Some background about hardware:
> Several IP blocks in intel FPGA integrate the same mmio register layout
> (so called indirect access interface here) as the bridge to the IP's real
> registers address space. Like:

>  +---------+          +---------+
>  | m10 BMC |          |  HSSI   |
>  +---------+          +---------+
>  |indirect |          |indirect |
>  | access  |          | access  |
>  |  MMIOs  |          |  MMIOs  |
>  +----+----+          +----+----+
>       |                    |
>       |                    |
>  +----+-----+         +---------+
>  |m10 bmc   |         | HSSI    |
>  |registers |         |registers|
>  +----------+         +---------+

One of the things I've been unable to tell thus far is if this is a
single device with a consistent IP for register access (thus far I've
only seen clear evidence of one device) or if there's multiple devices
that have been designed this way for some unclear reason.  AIUI these
are IPs within a single FPGA which is the top level MFD here?  If this
is one FPGA then perhaps the top level driver for the FPGA ought to just
handle whatever weirdness the FPGA has?  The fact that there doesn't
seem to be a name for this stuff makes it seem device specific.

The code that I've seen posted has looked like the register layout isn't
shared, all the register offsets have been variable, but there's this
thing with there being what looks like a command queue/IO completion
thing which seemed to be the only kind of substantial thing being
shared.

--v7aS8Ac+G9koXonX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmOONtUACgkQJNaLcl1U
h9DX8wf9EbasQSYIUTpNZTNGVjo0Ntgeiy8/4GOY6p3BUIsaOViuZYm6WOJAAxpx
kCVDBjL+hRPQ5lKjxymYAOmQEMRJs0FvMJnMROSsKW64UxO3Mx14bB6KrZ++8w11
7hkVEgvFDz3E9OvnBqqg2yejlZiwEK8wWbr39OVX8fgBhw6UWiDsTo36poBxuD6W
+vQMKcNh620OuqzfJ1kHVfH4qx7otfzFMNWaUQVykV9WHizlb0k/bQn15ACxqbYe
t0ei+eOSHiLP5sDvkzliuGcS7Oh6A4DWYT6Seb/65eQnh94Nh2gXjr03FNJPTZZY
usydm5Y8qxnuK/RV2YbwdlGOaRWKPg==
=UKRi
-----END PGP SIGNATURE-----

--v7aS8Ac+G9koXonX--
