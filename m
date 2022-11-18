Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 035A062F6A7
	for <lists+linux-fpga@lfdr.de>; Fri, 18 Nov 2022 14:57:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235097AbiKRNzd (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 18 Nov 2022 08:55:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiKRNzc (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 18 Nov 2022 08:55:32 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BDE7B855;
        Fri, 18 Nov 2022 05:55:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 01B74B823F6;
        Fri, 18 Nov 2022 13:55:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF3EFC433C1;
        Fri, 18 Nov 2022 13:55:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668779728;
        bh=006qr9oYoYJFVvrQlwKwWJ+Nb1CztoyzU6igHLHaelE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H8E6aUojKsYXBij4/nMnweRJtJALbPUbbursOUMSkhBXOfdoOmqPqdwl02vJR6mtR
         2/iMqI3qFBsRwd60Caph3DkqnuVWi2BgiPiPOtXyH1I1i5nMjzysnHCwLAlJQwr4dd
         g58rk+D5uckRaLR7o3vlthEKItIOB+YPxz8r66h9m1HfFl1X15Vy1tZfo1EzC504it
         /KAAktb2WHy6JwhSSShvoy+bbLoBxYWTeJwPRhk2qLdK95u1tsOOuf/jgQb5KlJ7EL
         P7btic65c0NZe7a1wXMp6fFyi8b7u9YyMtKIZd0hjwHF2K4qjPGjaxslEwG5VZxtnn
         QWx9fAa8VKLmw==
Date:   Fri, 18 Nov 2022 13:55:24 +0000
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
Message-ID: <Y3eOzOmTeTKBoPrd@sirena.org.uk>
References: <20221117120515.37807-1-ilpo.jarvinen@linux.intel.com>
 <20221117120515.37807-8-ilpo.jarvinen@linux.intel.com>
 <Y3Y4vWr/CGbaH0HQ@sirena.org.uk>
 <a089f1a0-c0f4-e1a2-d084-fd83e28e7e33@linux.intel.com>
 <Y3ZTSSLUqHil4dfl@sirena.org.uk>
 <a82565d-c282-7ace-e759-6514c29cca1c@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="JH8OS51MHJ9k4NZm"
Content-Disposition: inline
In-Reply-To: <a82565d-c282-7ace-e759-6514c29cca1c@linux.intel.com>
X-Cookie: Ego sum ens omnipotens.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


--JH8OS51MHJ9k4NZm
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 18, 2022 at 02:49:45PM +0200, Ilpo J=E4rvinen wrote:
> On Thu, 17 Nov 2022, Mark Brown wrote:

> > No, what I'm objecting to there is pretty much the same thing I'm
> > saying here - this doesn't seem like it's a particularly generic
> > implementation and I'm really not clear that there'd be anything
> > meaningful left by the time the implementation assumptions are
> > removed.

> That's probably because it sounds to me you're trying to extend its=20
> genericness beyond the domain where it's generic. That is, you're looking=
=20
> for genericness outside of IPs (that have their own driver each) in Intel=
=20
> FPGA domain.

This just says it's adding "indirect regmap support" - there's
nothing here saying that it's some Intel specific thing but it's
quite specific to some IPs.  Perhaps you have some name for this
interface?  You're only adding one user here which isn't helping
make the case that this is something generic.

> Please also keep in mind that we're talking about an FPGA device here, a=
=20
> device that is capable of implementing other devices that fall under=20
> various drivers/xx/. Obviously each would have a driver of their own so
> there is no as strong only single device/driver mapping here as you might=
=20
> be thinking.

I can't tell what you're trying to say here.  Are you saying that
this is somehow baked into some FPGA design so that it's memory
mapped with only a few registers showing to the rest of the
system rather than just having a substantial memory mapped
window like is typically used for FPGAs, but someohow this
register window stuff is implemented in the soft IP so people are
just throwng vaugely similar interfaces into a random host mapped
register layout?

Whatever's going on here this clearly isn't a generic
implementation of an indirect register map.

--JH8OS51MHJ9k4NZm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmN3jswACgkQJNaLcl1U
h9Ce1QgAhK2FEMpjV/iceG4YFkCUw1Xa6K2xhzZX8Ng/xIVxFHaS1m++ql+vy4Bg
QZgAeCo6ke27iSBphALanSkW5+GnC7p2VZxEH72UibEaLm9VKl8+w9QdAnbSuAy0
rO5NoRyL5xHYi8O7e/H9TQ47eEOtk9uB37SJgWjlymtMxec9LiKZam8PK2oMpEqP
lg1Cm0Vtpzc06Fkci/vfffVsyjQTrMUaj22C/RC9st0eDCbdyER9RKpMU4jhe5c+
/6zx0OlDeADduCdTrvvrWAsUInwIUKfOp0+GVQXLqs83zQU+9VcrwwpLlDtDh+Ie
ZX/7zUCqgOk1hbk7e418uzcIkqdtqg==
=puhU
-----END PGP SIGNATURE-----

--JH8OS51MHJ9k4NZm--
