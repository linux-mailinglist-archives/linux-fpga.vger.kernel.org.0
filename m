Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92F186F0865
	for <lists+linux-fpga@lfdr.de>; Thu, 27 Apr 2023 17:30:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244206AbjD0P2b (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 27 Apr 2023 11:28:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243906AbjD0P2a (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 27 Apr 2023 11:28:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 358CBC0;
        Thu, 27 Apr 2023 08:28:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C56E662CBC;
        Thu, 27 Apr 2023 15:28:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2685C4339C;
        Thu, 27 Apr 2023 15:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682609308;
        bh=CjtjtM+bxkjNoLN4zboLyLAahQqacHVRbgYOMXYE92c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qxcFo18nC3laHT0NM+QGh9si1rZ3r1pETsC6I4fPyDk9Fz8hhAIaxLGAWHt0ZrPUQ
         xw+YoSiMcy8xSjHbll9ht6EOS5J7Xbf5noMupD5ujw8ld55uIIjnZf9+6QM3C3+Ccc
         wdbmSx/ZMJZNqb36Kf5pdB4X3BlMn3e9EAF8idHRBa+e7k9GofNSq70ML040RkM+2a
         oTBcteO5ddhZXeZDll4V44GLUFdndSJNNrjQCsKn50++GTFHpXpS+Z5JlaICE123qg
         xZ6Q8YsjeNZhzG0hVSFBD17uO8x0EhPUrJTQilpvZx/HuqV4tXBssUuSP/KI9ws/2l
         dsXzuNLPhAN6Q==
Date:   Thu, 27 Apr 2023 16:28:23 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Ivan Bornyakov <i.bornyakov@metrotek.ru>
Cc:     linux-kernel@vger.kernel.org, Moritz Fischer <mdf@kernel.org>,
        Wu Hao <hao.wu@intel.com>, Xu Yilun <yilun.xu@intel.com>,
        Tom Rix <trix@redhat.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor.dooley@microchip.com>, system@metrotek.ru,
        linux-fpga@vger.kernel.org, devicetree@vger.kernel.org,
        gregkh@linuxfoundation.org
Subject: Re: [PATCH 1/2] MAINTAINERS: update Microchip MPF FPGA reviewers
Message-ID: <20230427-episode-overdrawn-ed2d1d30cb34@spud>
References: <20230426073519.9167-1-i.bornyakov@metrotek.ru>
 <20230426073519.9167-2-i.bornyakov@metrotek.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="kMYOCI0sE7yqrONQ"
Content-Disposition: inline
In-Reply-To: <20230426073519.9167-2-i.bornyakov@metrotek.ru>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


--kMYOCI0sE7yqrONQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Ivan,

On Wed, Apr 26, 2023 at 10:35:18AM +0300, Ivan Bornyakov wrote:
> As I'm leaving Metrotek, I'll have no access to the hardware and my
> Metrotek email will be off soon.

Good luck so!

> Replace my email with Metrotek System
> Team collective inbox.

Hmm, I am not too sure about this. I've previously seen the likes of
Greg KH frowning on these sort of shared mailboxes.
I'd rather have this shared mailbox than no one (since I still only have
an *SoC* platform capable of testing this driver), but a person would be
ideal.

Cheers,
Conor.

>=20
> Signed-off-by: Ivan Bornyakov <i.bornyakov@metrotek.ru>
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f50945bb7d1b..94b185972aca 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8100,7 +8100,7 @@ F:	drivers/fpga/intel-m10-bmc-sec-update.c
> =20
>  MICROCHIP POLARFIRE FPGA DRIVERS
>  M:	Conor Dooley <conor.dooley@microchip.com>
> -R:	Ivan Bornyakov <i.bornyakov@metrotek.ru>
> +R:	system@metrotek.ru
>  L:	linux-fpga@vger.kernel.org
>  S:	Supported
>  F:	Documentation/devicetree/bindings/fpga/microchip,mpf-spi-fpga-mgr.yaml
> --=20
> 2.40.0
>=20
>=20

--kMYOCI0sE7yqrONQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZEqUlwAKCRB4tDGHoIJi
0qaOAP9hybinB8tCo9efGJTuBsNiObTyw1tSz9hC4ncAQWKFzQD+N9ydzlGfeVVj
sMt+bzSMTDnBP9FAnkHMr3O8NuOSsAo=
=bJ2k
-----END PGP SIGNATURE-----

--kMYOCI0sE7yqrONQ--
