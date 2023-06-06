Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 662AF72419E
	for <lists+linux-fpga@lfdr.de>; Tue,  6 Jun 2023 14:03:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234572AbjFFMBh (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 6 Jun 2023 08:01:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237319AbjFFMBb (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 6 Jun 2023 08:01:31 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E37A10DD;
        Tue,  6 Jun 2023 05:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1686052888; x=1717588888;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0NveGh3+v/mbacpSMq9RfkTdTaBlT11Ahypy+/GRzF8=;
  b=tYMMaGYgAZdWN26KRswNEkVP11aHsMyNi6bxnH2luBKxUsSE8M6Krfew
   JthXp2lXiXhYarqVS1O3RlJBRiVSoBBFNuzY0qUvb2vSeJbi6APGmDHXv
   oReAPtN15YRkTOfS9C8NSH8eabfRtGDepQ6noLt/KzUfjACj6KTOR7lx+
   eoaeJah+dBPDvjYJRl5CFl7rOmmI6NAaIND6iaiMhJLGV0hYm9QyGo1Qy
   MJH7ONG3oUXhTWlgTvVpmyzdn/nkDrbqIPUYM1O5Bz0x1pyngRUxXzj/W
   XkI5TpxQfiJ3yJi5oe2yzo+agWlgFdoeHSvQILVu40B2g+ucvAQYCc/jf
   A==;
X-IronPort-AV: E=Sophos;i="6.00,221,1681196400"; 
   d="asc'?scan'208";a="216412131"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 06 Jun 2023 05:01:27 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 6 Jun 2023 05:01:27 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Tue, 6 Jun 2023 05:01:25 -0700
Date:   Tue, 6 Jun 2023 13:01:01 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Mark Brown <broonie@kernel.org>
CC:     <linux-spi@vger.kernel.org>, <linux-fpga@vger.kernel.org>,
        <conor@kernel.org>, Vladimir Georgiev <v.georgiev@metrotek.ru>,
        "Moritz Fischer" <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
        <valentina.fernandezalanis@microchip.com>
Subject: Re: [BUG] microchip-spi programming issue
Message-ID: <20230606-coyness-camper-45f410b9309f@wendy>
References: <20230606-reentry-undusted-3c44fd7b4325@wendy>
 <e0b6908a-7f13-425d-8f5a-e9e90a54a2c1@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="PO6HYvHvd2q2NxYN"
Content-Disposition: inline
In-Reply-To: <e0b6908a-7f13-425d-8f5a-e9e90a54a2c1@sirena.org.uk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

--PO6HYvHvd2q2NxYN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 06, 2023 at 12:55:58PM +0100, Mark Brown wrote:
> On Tue, Jun 06, 2023 at 12:30:02PM +0100, Conor Dooley wrote:
>=20
> > Following on from that, how strong is "normally" in the comment above?
> > Is it valid for a controller to deassert CS even if cs_change is not
> > set? Or have I totally misunderstood things and there's something
> > invalid about how the transfers are being set up in the driver?
>=20
> It is obviously going to corrupt the transfer if we deassert chip select
> without being asked, it is only valid to change it during a message if
> cs_change is set.

So, reading between the lines, I shouldn't have doubted myself and this
is an issue in the SPI controller or its driver?

Cheers,
Conor.


--PO6HYvHvd2q2NxYN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZH8f/QAKCRB4tDGHoIJi
0gcyAQC+Dde3YDSUMbm6G/T5NI5mUDNlMcFEdT7MgO66KCaf8wD+JL4s5lsPVSjb
Phneab+lNvwbJCIN+QliD7PUv7vtFQI=
=rcOB
-----END PGP SIGNATURE-----

--PO6HYvHvd2q2NxYN--
