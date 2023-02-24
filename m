Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27E536A17FA
	for <lists+linux-fpga@lfdr.de>; Fri, 24 Feb 2023 09:30:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229494AbjBXI25 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 24 Feb 2023 03:28:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjBXI24 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 24 Feb 2023 03:28:56 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E5FE15885;
        Fri, 24 Feb 2023 00:28:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1677227334; x=1708763334;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SIn1p7e4VSan5YSb/O/jBQErVaCbUiyyEKP8M4PMU5w=;
  b=c2v7CEfaVgB0l24ub09wcQKkz+AQgABhQsa1pg/a6puVxEaWnaOEuwrv
   MxIE1TVSoqn752YXYgQuH49rxNtIwZI7kDMTZz/Sho/E1auLC/1xWIRKw
   x3EUsXOw3FvBbsjaHgAM0taU9Nhx1uL6g9yP/d15hjwxZ1K00qKW9sjJy
   6RtwiXP/yDu3L1R+wDg4clwjWN/g+hnI6xE27kfafNNX6b3vFrQ5Nyjpf
   CvSkBkEaGXUpluKc6lfJoTg2oBEOv1WQfYOc60u1RwhfTosmobAQWq21Q
   clBDO9VsN8FdJ7Wm0yrJuyHvKySZdLDnVOTPf80qMTugPDugX1TdbwMuP
   g==;
X-IronPort-AV: E=Sophos;i="5.97,324,1669100400"; 
   d="asc'?scan'208";a="202385503"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 Feb 2023 01:28:54 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 24 Feb 2023 01:28:53 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16 via Frontend
 Transport; Fri, 24 Feb 2023 01:28:51 -0700
Date:   Fri, 24 Feb 2023 08:28:24 +0000
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Xu Yilun <yilun.xu@intel.com>
CC:     Conor Dooley <conor@kernel.org>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Tom Rix <trix@redhat.com>, <linux-riscv@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-fpga@vger.kernel.org>
Subject: Re: [PATCH v1 0/6] PolarFire SoC Auto Update Support
Message-ID: <Y/h1KFGSw13OabYw@wendy>
References: <20230217164023.14255-1-conor@kernel.org>
 <Y/ht1eHgtRrLxIhC@yilunxu-OptiPlex-7050>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="MKpYTFhinBTffULG"
Content-Disposition: inline
In-Reply-To: <Y/ht1eHgtRrLxIhC@yilunxu-OptiPlex-7050>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

--MKpYTFhinBTffULG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 24, 2023 at 03:57:09PM +0800, Xu Yilun wrote:
> On 2023-02-17 at 16:40:17 +0000, Conor Dooley wrote:

> > This patchset adds support for the "Auto Update" feature on PolarFire
> > SoC that allows for writing an FPGA bistream to the SPI flash connected
> > to the system controller.
>=20
> I haven't fully checked the patches yet, just some quick comments:
>=20
> Since this feature is just to R/W the flash, and would not affect the
> runtime FPGA region, I don't think an FPGA manager is actually needed.
> Why not just use the MTD uAPI? There is a set of exsiting MTD uAPI &
> MTD tool if I remember correctly.

A lack of interest in opening up the system controller to userspace!
You're right in that the writing of the image can be done that way, and
while I was testing I used the userspace bits of mtd along the way - but
for validating that the image we are writing we rely on the system
controller.
I'm really not interested in exposing the system controller's
functionality, especially the bitstream manipulation parts, to userspace
due to the risk of input validation bugs, so at least that side of
things should remain in the kernel.
I suppose I could implement something custom in drivers/soc that does
the validation only, and push the rest out to userspace. Just seemed
fitting to do the whole lot in drivers/fpga.

Cheers,
Conor.


--MKpYTFhinBTffULG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY/h1GAAKCRB4tDGHoIJi
0jYZAP0b4isZi20eYfPCosiKMCfUgAK5+YFO5MSqE1BKfxYw5wD9F8vB/xfqYImD
Iw3UauhLpsnOEvidjzCRFdckvVP+gwY=
=Xgqy
-----END PGP SIGNATURE-----

--MKpYTFhinBTffULG--
