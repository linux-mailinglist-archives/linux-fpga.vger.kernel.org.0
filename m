Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFFD36A4DDD
	for <lists+linux-fpga@lfdr.de>; Mon, 27 Feb 2023 23:18:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbjB0WRD (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 27 Feb 2023 17:17:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230154AbjB0WRB (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 27 Feb 2023 17:17:01 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E49F529E23;
        Mon, 27 Feb 2023 14:16:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7522560C4F;
        Mon, 27 Feb 2023 22:16:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 441BCC433D2;
        Mon, 27 Feb 2023 22:16:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677536218;
        bh=OLAhKikfvMU2wuyCBxDcxu9OcxDIG7wn+gzFNNSS2LA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rEzRzUKrj3jDGruk+xEddZcrntXRp0kq+4nj9UXPm7blo6WDX+rqljA9ROsFXSOiz
         owg9O0VO4rIRmWwzRktjQ5R/8QVUCsIQXAl43Un/SiKJsPhdODRnHwl9nHbMe5ZBDQ
         OmnxGWP1383XZtkoQkJD8umtbcQlqUlovpOmk9GaGZJWadQhGJ9EB1nJwx9XxSfDTB
         mofhfiTLX9YEFC/A9cLaOKyOugQLmVsqcbC1m3+N+GNYai1EW8UnY+8noWib9BrXx9
         SoVQD90gg6G9GZOEw4fncF4LixN2SsQz7bsq9LAvxdDSmY3K1SPRN0doamIugrb3lM
         lx8cePZAguxPA==
Date:   Mon, 27 Feb 2023 22:16:53 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Russ Weight <russell.h.weight@intel.com>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        Xu Yilun <yilun.xu@intel.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Tom Rix <trix@redhat.com>, linux-riscv@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fpga@vger.kernel.org
Subject: Re: [PATCH v1 0/6] PolarFire SoC Auto Update Support
Message-ID: <Y/0r1aR6Wik2KYBd@spud>
References: <20230217164023.14255-1-conor@kernel.org>
 <Y/ht1eHgtRrLxIhC@yilunxu-OptiPlex-7050>
 <Y/h1KFGSw13OabYw@wendy>
 <21bebf9d-eb27-5607-b0a9-274c46ef8aa3@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="oZi0E9zvZH+0qkiw"
Content-Disposition: inline
In-Reply-To: <21bebf9d-eb27-5607-b0a9-274c46ef8aa3@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


--oZi0E9zvZH+0qkiw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Russ,

On Mon, Feb 27, 2023 at 02:04:36PM -0800, Russ Weight wrote:
> On 2/24/23 00:28, Conor Dooley wrote:
> > On Fri, Feb 24, 2023 at 03:57:09PM +0800, Xu Yilun wrote:
> >> On 2023-02-17 at 16:40:17 +0000, Conor Dooley wrote:
> >>> This patchset adds support for the "Auto Update" feature on PolarFire
> >>> SoC that allows for writing an FPGA bistream to the SPI flash connect=
ed
> >>> to the system controller.
> >> I haven't fully checked the patches yet, just some quick comments:
> >>
> >> Since this feature is just to R/W the flash, and would not affect the
> >> runtime FPGA region, I don't think an FPGA manager is actually needed.
> >> Why not just use the MTD uAPI? There is a set of exsiting MTD uAPI &
> >> MTD tool if I remember correctly.
> > A lack of interest in opening up the system controller to userspace!
> > You're right in that the writing of the image can be done that way, and
> > while I was testing I used the userspace bits of mtd along the way - but
> > for validating that the image we are writing we rely on the system
> > controller.
> > I'm really not interested in exposing the system controller's
> > functionality, especially the bitstream manipulation parts, to userspace
> > due to the risk of input validation bugs, so at least that side of
> > things should remain in the kernel.
> > I suppose I could implement something custom in drivers/soc that does
> > the validation only, and push the rest out to userspace. Just seemed
> > fitting to do the whole lot in drivers/fpga.

> In case you haven't already looked at the new firmware-upload
> support in the firmware-loader, I'll give you some references
> here to see if it fit you needs. This would only support the
> write (not the read) but it would allow the controller to do
> validation on the write.
>=20
> The is the cover letter which shows a usage example:
> https://lore.kernel.org/lkml/20220421212204.36052-1-russell.h.weight@inte=
l.com/
>=20
> And this is a pointer to the latest documentation for it:
> https://docs.kernel.org/driver-api/firmware/fw_upload.html
>=20
> The only current user is: drivers/fpga/intel-m10-bmc-sec-update.c

Sounds interesting, I shall go and take a look. Just quickly, when you
say it wouldn't support the read, what exactly do you mean?
The only read that I am really interested in doing is reading the first
1K of flash as I need to RMW it, but I don't think that that's what you
mean.
Do you mean that I would not be able to dump the firmware using your
fw_upload interface? If so, that's an acceptable constraint IMO.

Your interface also circumvents us (Microchip) defining yet another
method for interacting with the FPGA, since from my nosing around,
everyone seems to do something different.

Cheers,
Conor.


--oZi0E9zvZH+0qkiw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY/0rvwAKCRB4tDGHoIJi
0r+IAP4wAN2eZl5ZZIhcWD47ZvM5gRJMjwQZYIsh50e8WJnPeAD/Spa80AeaY4RT
237fwTSQ7qtB3Ui47ifyETMLaC9V+wA=
=mVqh
-----END PGP SIGNATURE-----

--oZi0E9zvZH+0qkiw--
