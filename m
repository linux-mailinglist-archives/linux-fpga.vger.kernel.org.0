Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DACE72666B
	for <lists+linux-fpga@lfdr.de>; Wed,  7 Jun 2023 18:50:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230466AbjFGQsm (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 7 Jun 2023 12:48:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230490AbjFGQsk (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 7 Jun 2023 12:48:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2AB41FE0;
        Wed,  7 Jun 2023 09:48:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 574C364199;
        Wed,  7 Jun 2023 16:48:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A709DC433EF;
        Wed,  7 Jun 2023 16:48:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686156514;
        bh=n8N386uhIBu7wn1ff1cXpf6dSOZgZZ5Yf+kqEYdk9LI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HSDex1ikUsdYYpS2Eg2y7DNEohKb6ns4cBvfZwWU5ltprvDtPpPFQaLCIVYAKcx53
         tepAlISqo6rgoYjlMjsnk3MGAbI2G/sr6b6POJitC3eMahO9JBtlji0xZFCuZ+83xu
         OS3az1NZrdTZu32JmxP0koEz4n0Ius9YKI4tjksWBDgvAwIiZOYDSTK5L5qU98fiUZ
         NJ5ddLhxLuTczmbBhUS14iJbNlLvDzkquMSSKeVQayGUU/pWX4ick6eCo1J2JmQGhp
         u7mfr09qBWY9X2p/5G47YP68gLutiYG12dOXtcWkdA8FiYg+xSRo9IBbfIjAc0b+lF
         upm9v/2i1cmtw==
Date:   Wed, 7 Jun 2023 17:48:30 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        linux-spi@vger.kernel.org, linux-fpga@vger.kernel.org,
        Vladimir Georgiev <v.georgiev@metrotek.ru>,
        Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
        valentina.fernandezalanis@microchip.com
Subject: Re: [BUG] microchip-spi programming issue
Message-ID: <20230607-pacemaker-subtitle-90abc2aaffc0@spud>
References: <20230606-reentry-undusted-3c44fd7b4325@wendy>
 <e0b6908a-7f13-425d-8f5a-e9e90a54a2c1@sirena.org.uk>
 <20230606-coyness-camper-45f410b9309f@wendy>
 <6a01d7c9-8773-4206-bf8a-1f67cfe1dbb0@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="GTrgBSOdihzE6Dr1"
Content-Disposition: inline
In-Reply-To: <6a01d7c9-8773-4206-bf8a-1f67cfe1dbb0@sirena.org.uk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


--GTrgBSOdihzE6Dr1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 06, 2023 at 01:04:51PM +0100, Mark Brown wrote:
> On Tue, Jun 06, 2023 at 01:01:01PM +0100, Conor Dooley wrote:
> > On Tue, Jun 06, 2023 at 12:55:58PM +0100, Mark Brown wrote:
>=20
> > > It is obviously going to corrupt the transfer if we deassert chip sel=
ect
> > > without being asked, it is only valid to change it during a message if
> > > cs_change is set.
>=20
> > So, reading between the lines, I shouldn't have doubted myself and this
> > is an issue in the SPI controller or its driver?
>=20
> Yes.  Note that it may be that the hardware is limited and can't do
> whatever it's being asked to do.

Yah, looks like they were using the ecspi on an imx8mp & there are
apparently known issues there with the generation of CS on it.
GPIO CS seems to do the job for them though, so one problem less for me
to worry about :)

--GTrgBSOdihzE6Dr1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZIC03gAKCRB4tDGHoIJi
0t6rAP9C0iwillTa1c9QtDl4St+4NOJkHmrWRpwgBUfvs/s95QEA/xEuQKwOIyXV
6sAtnRUMTqJ3v94+tFMPxKAegK9afgE=
=TIE3
-----END PGP SIGNATURE-----

--GTrgBSOdihzE6Dr1--
