Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 929496DDA1E
	for <lists+linux-fpga@lfdr.de>; Tue, 11 Apr 2023 13:53:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbjDKLv6 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 11 Apr 2023 07:51:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjDKLv5 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 11 Apr 2023 07:51:57 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28238A3;
        Tue, 11 Apr 2023 04:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1681213917; x=1712749917;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IDNwN+L7zB55OJP9jBjVVnbHvsXbaSOmUpcPGO60Xi0=;
  b=y6tZ5QJqGx0WOu5sYUUvPTBL0Q+1hLNCRisloQAxHWy/BR057l2KG4Sh
   1AdESo3KeW8NHY8rDn7ezr7IzdYClYZozjKRUMVSd1N82627NyWlOjaiK
   b4KmMNVD3C1QUF0P5HqIir4hShgCDq0QwxpHJm5IQ1aUhnSqQoZRK0A69
   iyNouS3wKThWbHbx3EnxV8q7sJ8jkMNNmBy8SE8/J2dekItC1re8JKoXJ
   dHTJiOpkzbSkVQGRtSb+DUv4sb3UXRS2sU7fQAa31o2wHpNzqYX6lIYvD
   dW5mIpJXI7J+NYtuARQXWRuZuZ8USA/v4zwhZ3mBMZzxQh4kMdX83wTHE
   Q==;
X-IronPort-AV: E=Sophos;i="5.98,336,1673938800"; 
   d="asc'?scan'208";a="205928204"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 11 Apr 2023 04:51:56 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 11 Apr 2023 04:51:51 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Tue, 11 Apr 2023 04:51:49 -0700
Date:   Tue, 11 Apr 2023 12:51:34 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Xu Yilun <yilun.xu@intel.com>
CC:     <linux-fpga@vger.kernel.org>, <conor@kernel.org>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Tom Rix <trix@redhat.com>, <linux-riscv@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 6/7] fpga: add PolarFire SoC Auto Update support
Message-ID: <20230411-tinsmith-matchless-af5c7c41d23b@wendy>
References: <20230331071823.956087-1-conor.dooley@microchip.com>
 <20230331071823.956087-7-conor.dooley@microchip.com>
 <ZClfjuLa/pRATwCp@yilunxu-OptiPlex-7050>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="dLzJ91lPjUUfUd6j"
Content-Disposition: inline
In-Reply-To: <ZClfjuLa/pRATwCp@yilunxu-OptiPlex-7050>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

--dLzJ91lPjUUfUd6j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 02, 2023 at 06:57:18PM +0800, Xu Yilun wrote:
> On 2023-03-31 at 08:18:22 +0100, Conor Dooley wrote:
> > Add support for Auto Update reprogramming of the FPGA fabric on
> > PolarFire SoC, using the fw_upload mechanism a la the
> > intel-m10-bmc-sec-update driver.
>=20
> I'm not an expert of MTD and have several concerns about the mtd
> writing part:
>=20
> - This seems a generic case that writing a file content into the
>   driver restricted offset on mtd.

Right, writing at an offset is pretty generic.

> - Seems the firmware update interface could be created for mtd device,
>   like the nvmem interface?

I'm not entirely sure what you mean by this one.
Are you saying that there should be a generic way to do "firmware"
uploads to mtd devices, based on some sort of structure defined in
devicetree etc?
And perhaps then, this driver would register as a consumer of that
interface, pushing all of the direct mtd stuff out to that interface?

> - I assume the purpose of the fw upload interface is to protect
>   unexpected writing from user. So how to protect the mtd be
>   written by other user interfaces like mtdchar/block or nvmem?

I'm not very good with the security knobs so I don't have an answer for
you here (yet). But your assumption about the rationale here is correct
and I would like to block access.

> For other parts:
>=20
> - directory block check, fw upload don't touch this block, so why check
>   it in fw upload process.

I don't know what you mean. The mtd device could be empty and the
directory would need to be populated with the image address etc.
Or, it could previously have been used for something else, and then it
would be required to reconfigure it correctly for Auto Upgrade.

Maybe I am misunderstanding you?

>=20
> - image verification, no matter pass or fail, fw upload is actually done,
>   the flash is written and no way to rollback. So may remove from fw
>   upload process.

The FPGA is flash based, so writing to the mtd device is not going to
actually program the FPGA with this content. The original image/bitstream
in the mtd device is either going to be a) equivalent to what is already
programmed in the FPGA, b) not an upgrade over what is current in the
FPGA, c) something that was uploaded since the last time the device was
restarted.
I don't think that overwriting any of those is problematic, as if the
verification fails, the original bitstream will continue being used
until an image that does actually pass is provided.

Without doing the verification though, there's no way to tell for certain
if the FPGA is actually going to perform an upgrade to this new bitstream
once it is restarted, so I think there is value in keeping this.

If you're still very sceptical about whether this belongs in
drivers/fpga, I can always dump it in drivers/soc instead I guess.

Cheers,
Conor.


--dLzJ91lPjUUfUd6j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZDVJxgAKCRB4tDGHoIJi
0pQSAP97BT4XTrsoYV/lQtiljkj5kbrxBzArbNkTmg8edtrX3AD/YwdgiW+cA4vP
ZYY9qhOwvbAJtvjq6hlGsI6hYBRkIg4=
=9y6K
-----END PGP SIGNATURE-----

--dLzJ91lPjUUfUd6j--
