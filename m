Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 096EF642806
	for <lists+linux-fpga@lfdr.de>; Mon,  5 Dec 2022 13:07:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbiLEMF1 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 5 Dec 2022 07:05:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbiLEMF0 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 5 Dec 2022 07:05:26 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACC96C76A;
        Mon,  5 Dec 2022 04:05:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2B4C7B80EDA;
        Mon,  5 Dec 2022 12:05:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BA28C433D7;
        Mon,  5 Dec 2022 12:05:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670241921;
        bh=Sg7hSBYis/7NJ7gp8kAsTusDuRcfqiLMNUytPo5WSiY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KUW5ObfBGL1ygvaNqOREvi1HSGTyVkGDXPfihbiOoVJkEnAODHZQfvECnAtTB/C9A
         4MG3Owee35IONtxBdoClACL5KoFCQ28cdlYd6JhUEygbi/OrlU6/40iSz4nz1W1Ml/
         3rNCpFoLJM74d1PngmDU7bvFmlKpInpTAu/VIczOjym3ep6Nw0o4ahfRiECRVY7OiT
         p3QoxwnTiZByzTbfa43cr6AgdsZ73JrfUYZAU0OKM7ZxFE5qE52b1QkoC+mtlRs1Le
         9CcY+5NqKjPqeUHTntKGfAj81lSS/cBBtXfP1YZc5ztLl29782gAnwgoVvTeHo7g2v
         aNpE5HvA+cCRA==
Date:   Mon, 5 Dec 2022 12:05:14 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     Xu Yilun <yilun.xu@intel.com>, linux-fpga@vger.kernel.org,
        Wu Hao <hao.wu@intel.com>, Tom Rix <trix@redhat.com>,
        Moritz Fischer <mdf@kernel.org>, Lee Jones <lee@kernel.org>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        Russ Weight <russell.h.weight@intel.com>,
        Tianfei zhang <tianfei.zhang@intel.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Marco Pagani <marpagan@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 7/9] mfd: intel-m10-bmc: Add PMCI driver
Message-ID: <Y43eejWSYIBIlUKB@sirena.org.uk>
References: <20221202100841.4741-1-ilpo.jarvinen@linux.intel.com>
 <20221202100841.4741-8-ilpo.jarvinen@linux.intel.com>
 <Y4ox5J0junaUYyT7@yilunxu-OptiPlex-7050>
 <855d463e-fb84-1910-f53-58e6b0a633a4@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="eKKE6fgqZADZWzdx"
Content-Disposition: inline
In-Reply-To: <855d463e-fb84-1910-f53-58e6b0a633a4@linux.intel.com>
X-Cookie: If it ain't broke, don't fix it.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


--eKKE6fgqZADZWzdx
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 05, 2022 at 11:51:15AM +0200, Ilpo J=E4rvinen wrote:
> On Sat, 3 Dec 2022, Xu Yilun wrote:
> > On 2022-12-02 at 12:08:39 +0200, Ilpo J=E4rvinen wrote:

> > > +struct regmap *__devm_m10_regmap_indirect(struct device *dev,

> > We name the file intel-m10-bmc-pmci-xxx.c, and this function
> > xx_m10_regmap_xx(). But I can see the implementation is just about the =
indirect
> > bus which from your commit message could be used by various DFL features
> > like HSSI or PMCI. So is it better we put the implementation in
> > drivers/fpga and name the file dfl-indirect-regmap.c and the
> > initialization function dfl_indirect_regmap_init()?

> I guess that would be doable unless Mark objects. My understanding was=20
> that he preferred to have in the driver that is currently using it.

> Mark, any opinion on this?

The above does not look good.  As I have said several times now drivers
implementing their own regmap operations should use the reg_read() and
reg_write() operations in regmap_config when allocating their regmap
unless they're doing something unusual.  There are a few cases where it
makes sense but nothing I've seen here makes it look like this is one of
them.  Most of the current users don't fit.

Please, just implement a normal driver using a normal regmap_config as
I've repeatedly said you should if you don't want to provide something
generic.

--eKKE6fgqZADZWzdx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmON3nkACgkQJNaLcl1U
h9Co7Qf/eIz7h6ibggGjkJrx3WaPVwE60Kkxjo2FsG52Nc0CbeV9PYzJZD4Y8cTd
j2GO5Y0k91Sq+K01GdWIUXoBuU6j9cj5PVTh7oSMTLoE9VRgyDKzz8E44heZRdI/
N1mGPiAykoqoiftA7oD//33t4klMzLdp2Rylg+uFRzOi+U+qdSOHMrAheUQ9U0oh
miqElD3SlnJCbEIuhP3l0PYmQ0nTi/+GlXIbQWp6LSZeDCpdlQxnDgi/8ObLp4KT
efZMN6bdv68UcWpNQdbXiwZru1jOs5IGg60MES8gTpQWM4PxVv/uEE1rvAmL9dCp
jcmtWY37whnNfjf5vUGq4IPMMTy5vw==
=CtcO
-----END PGP SIGNATURE-----

--eKKE6fgqZADZWzdx--
