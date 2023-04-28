Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBEC36F1D0C
	for <lists+linux-fpga@lfdr.de>; Fri, 28 Apr 2023 18:57:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbjD1Q4A (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 28 Apr 2023 12:56:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbjD1Qz7 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 28 Apr 2023 12:55:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9334E1FC3;
        Fri, 28 Apr 2023 09:55:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2F54D6449D;
        Fri, 28 Apr 2023 16:55:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 049E1C433EF;
        Fri, 28 Apr 2023 16:55:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682700957;
        bh=xj0NIzvVgCJvBTwvWFN6SAMCNUTQVUTdpSyWpNpNl8k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KNmfeAbx1Zo/ImwjopCtaCiKZRBGd3BpMzJgZls2FdFOx/oGeUTokC+NKVddIEQh7
         zzOsBHlwORGIkqKJeT4u3SVWEwld+h7BSKudUNaNYf53DSoOUDNTX6bbmsA2ZYl/cJ
         szY566mQnld9m17ClWfBk7nTUWDBcVW3q7Rb7seswhIVUq7s6zswA3U5BiZbQer9vy
         ZazEfZjd1y4XvWVH8wwoCcPOphzEjXWvjojPCE5bLaBVyBmh1BTQakgz9lMY0YpeN5
         qPLn+ZYOwBunbPsjWn6pFAcXfzxrXVUnRE9KKJwAUaO4Ebq9HjUyGk58IQTglC8gEu
         ioBxMt7bJDmOg==
Date:   Fri, 28 Apr 2023 17:55:52 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Ivan Bornyakov <i.bornyakov@metrotek.ru>
Cc:     linux-kernel@vger.kernel.org, Moritz Fischer <mdf@kernel.org>,
        Wu Hao <hao.wu@intel.com>, Xu Yilun <yilun.xu@intel.com>,
        Tom Rix <trix@redhat.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Vladimir Georgiev <v.georgiev@metrotek.ru>, system@metrotek.ru,
        linux-fpga@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 0/2] replace Ivan Bornyakov maintainership
Message-ID: <20230428-marine-halogen-57d4b3c2ca0f@spud>
References: <20230428140150.2592-1-i.bornyakov@metrotek.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="m8l/4nIjr6I81ows"
Content-Disposition: inline
In-Reply-To: <20230428140150.2592-1-i.bornyakov@metrotek.ru>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


--m8l/4nIjr6I81ows
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 28, 2023 at 05:01:48PM +0300, Ivan Bornyakov wrote:
> As I'm leaving Metrotek, hand over my maintainership duties to Vladimir.

As I said yesterday, good luck!

> ChangeLog:
> v1:
> https://lore.kernel.org/lkml/20230426073519.9167-1-i.bornyakov@metrotek.ru/
> v2:
>   * instead of replacing my Metrotek email to a shared Metrotek System
>     Team mailbox, assign Vladimir to my former maintainership.

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--m8l/4nIjr6I81ows
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZEv6mAAKCRB4tDGHoIJi
0useAP9+jA39d34FnLCJS+/xi4qzWK2rUMT+9RE7bzvH1kDXaQD/WXJD6YsaHWTT
TJKjZ9QchCKQ8oGlv8oPWAjE8I7vEAc=
=N8ks
-----END PGP SIGNATURE-----

--m8l/4nIjr6I81ows--
