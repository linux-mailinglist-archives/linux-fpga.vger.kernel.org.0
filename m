Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CE007241A6
	for <lists+linux-fpga@lfdr.de>; Tue,  6 Jun 2023 14:06:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbjFFMFG (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 6 Jun 2023 08:05:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237427AbjFFME6 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 6 Jun 2023 08:04:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAE4AE7D;
        Tue,  6 Jun 2023 05:04:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 70F3F63168;
        Tue,  6 Jun 2023 12:04:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92203C433D2;
        Tue,  6 Jun 2023 12:04:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686053096;
        bh=gI24mEk9GJ8z2rglqidSxiK3Kcnk+3OuZoRrJ0ettlM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Tr8OA1acWI1mFsmZmHVOLjHcyF+0aW3BwBVvN/jdNLlrZotr2Pdzvaa3zUdJ/Pdf+
         3xACEOi0dZvQKd2SSqZn5N6jd21hb46AmhdnbSdoKTwrYvVxZkx0Ar6JKHcQFVxVsq
         Ccl2GTlElBTEVrIHYNORUkSUMDbSU79N2YZhjcMxIDBbc5ToFknggKmUlhALLeyeV3
         wXyh/gPybhk86c0Rin0M/aNjyqvVi3/zVkVrhIMSwi6h3X5PL6oYa1qAAyjEmFF/lf
         c8VKynLke40mh/gjlmcoGTX+8AvBXXZ9jolWPB4iA/twACjjgPPuN4k3rX6dmBCyNY
         P2CPnzu12aU0w==
Date:   Tue, 6 Jun 2023 13:04:51 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     linux-spi@vger.kernel.org, linux-fpga@vger.kernel.org,
        conor@kernel.org, Vladimir Georgiev <v.georgiev@metrotek.ru>,
        Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
        valentina.fernandezalanis@microchip.com
Subject: Re: [BUG] microchip-spi programming issue
Message-ID: <6a01d7c9-8773-4206-bf8a-1f67cfe1dbb0@sirena.org.uk>
References: <20230606-reentry-undusted-3c44fd7b4325@wendy>
 <e0b6908a-7f13-425d-8f5a-e9e90a54a2c1@sirena.org.uk>
 <20230606-coyness-camper-45f410b9309f@wendy>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="VD5kmvRN7+LWbf6t"
Content-Disposition: inline
In-Reply-To: <20230606-coyness-camper-45f410b9309f@wendy>
X-Cookie: Keep out of the sunlight.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


--VD5kmvRN7+LWbf6t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 06, 2023 at 01:01:01PM +0100, Conor Dooley wrote:
> On Tue, Jun 06, 2023 at 12:55:58PM +0100, Mark Brown wrote:

> > It is obviously going to corrupt the transfer if we deassert chip select
> > without being asked, it is only valid to change it during a message if
> > cs_change is set.

> So, reading between the lines, I shouldn't have doubted myself and this
> is an issue in the SPI controller or its driver?

Yes.  Note that it may be that the hardware is limited and can't do
whatever it's being asked to do.

--VD5kmvRN7+LWbf6t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmR/IOIACgkQJNaLcl1U
h9DrbQf/QMf6ofECOQGRzGlLwLnq01FTDl3P5yhRVHYBExkKGUbvU3yjkj1cYec2
ex23KViE1dkxL73Estb7edp6G304kpxKdx3UpincAGlP+6dILEUzQek/WjaZNOjs
k4zkocphOKEbL53c2NOxApTYLXC53nG9+2xe6ovuzVTDyuZmgFeG5ziJVt3iRpZE
psz6I4rjQXewth7qrMZ8tug3ayzHF4DnK98b6Oc8KsR0MHiK/sV8fSNFGDlO9DNC
bO4LyluqiLS5D2xoqN8QLR05ezKjiFh7Jt1M3sXbcZha6i9Wr7TXJSYkd5uF2rFx
UbrjS4k+UfZK9sh4Qes/3gATAKpYLQ==
=16bI
-----END PGP SIGNATURE-----

--VD5kmvRN7+LWbf6t--
