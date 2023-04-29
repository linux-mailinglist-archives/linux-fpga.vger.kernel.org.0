Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F261D6F2418
	for <lists+linux-fpga@lfdr.de>; Sat, 29 Apr 2023 12:06:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231187AbjD2KE4 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sat, 29 Apr 2023 06:04:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231171AbjD2KEx (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sat, 29 Apr 2023 06:04:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CD90199A;
        Sat, 29 Apr 2023 03:04:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CB43960B58;
        Sat, 29 Apr 2023 10:04:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97972C433D2;
        Sat, 29 Apr 2023 10:04:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682762687;
        bh=p78umAC5OpkpEgUA5xcweZbpCVLztdigB+lWCL5328I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RRjz4VvHYf4nAHMepOblXzhwVVAlBbw0mkWnaeguyLHpNDz7iQpeVwYl7oJj0LST7
         t7tVGawT63JfxXgwKZZEei5CPO+VXxg8rGx3aqhuQpZUeXiGCu4iBgmNuK5iI1CSGt
         sv/8hJrTWuCeG95XkrtXL28hKPhZxJ2dYm6zaaefWh3Gwfj4eY6m4t3wyds/MjBJYm
         DwEUVlJU1fbbs3ZgLdURFuatvpfeN65LLgLCz3DkJd1vHSXVbQhLDGgJrVAf0mhaN7
         zGVG0aMN7fa8Cgm9qjMB66sYe2ezJF7o1846+GUGFwvD2PEzEAd+94sde0vjx7utNF
         8+HNvRQiZ4obQ==
Date:   Sat, 29 Apr 2023 11:04:42 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Ivan Bornyakov <i.bornyakov@metrotek.ru>
Cc:     Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Vladimir Georgiev <v.georgiev@metrotek.ru>, system@metrotek.ru,
        linux-fpga@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/2] dt-bindings: fpga: replace Ivan Bornyakov
 maintainership
Message-ID: <20230429-rewind-blinks-63543b3a83f1@spud>
References: <20230428140150.2592-1-i.bornyakov@metrotek.ru>
 <20230428140150.2592-3-i.bornyakov@metrotek.ru>
 <20230428220415.GA351049-robh@kernel.org>
 <20230429082919.i4pmerf4qeckl3w6@x260>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="HqnRuV5juQ/i4ibo"
Content-Disposition: inline
In-Reply-To: <20230429082919.i4pmerf4qeckl3w6@x260>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


--HqnRuV5juQ/i4ibo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 29, 2023 at 11:29:19AM +0300, Ivan Bornyakov wrote:
> On Fri, Apr 28, 2023 at 05:04:15PM -0500, Rob Herring wrote:
> > On Fri, Apr 28, 2023 at 05:01:50PM +0300, Ivan Bornyakov wrote:
> > > As I'm leaving Metrotek, hand over Lattice Slave SPI sysCONFIG FPGA
> > > manager and Microchip Polarfire FPGA manager maintainership duties to
> > > Vladimir.
> > >=20
> > > Signed-off-by: Ivan Bornyakov <i.bornyakov@metrotek.ru>
> > > Signed-off-by: Vladimir Georgiev <v.georgiev@metrotek.ru>
> >=20
> > The patch sender's Sob goes last. And only Vladimir should add his Sob=
=20
> > (when an author or sender).
> >=20
>=20
> For the moment, when I'm still sender, would it be alright if we replace
> Vladimir's "Signed-off-by" to "Acked-by"?

Yeah, should be.

--HqnRuV5juQ/i4ibo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZEzrugAKCRB4tDGHoIJi
0iMpAQCp20r56fIs7IhQI4pSgTJ14sp00dSPt/oL09wXazY6CwEAwWQT1U96Ma4v
MWnLKmQpEwpPE5Wk6EB/Pvq/H+tXpQs=
=/PVN
-----END PGP SIGNATURE-----

--HqnRuV5juQ/i4ibo--
