Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 602CC3BF51B
	for <lists+linux-fpga@lfdr.de>; Thu,  8 Jul 2021 07:33:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbhGHFfr (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 8 Jul 2021 01:35:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbhGHFfr (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 8 Jul 2021 01:35:47 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E87AC06175F
        for <linux-fpga@vger.kernel.org>; Wed,  7 Jul 2021 22:33:06 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m1Med-0005qp-RM; Thu, 08 Jul 2021 07:32:55 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m1MeZ-000300-1z; Thu, 08 Jul 2021 07:32:51 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m1MeY-0007HF-QD; Thu, 08 Jul 2021 07:32:50 +0200
Date:   Thu, 8 Jul 2021 07:32:32 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Xu Yilun <yilun.xu@intel.com>
Cc:     Tom Rix <trix@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Wu Hao <hao.wu@intel.com>,
        Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org
Subject: Re: [PATCH] bus: Make remove callback return void
Message-ID: <20210708053232.phruotxefsoqyhzq@pengutronix.de>
References: <20210706095037.1425211-1-u.kleine-koenig@pengutronix.de>
 <4c7210e4-76e4-07fe-a40c-a58e331d0a6e@redhat.com>
 <20210708021913.GB12358@yilunxu-OptiPlex-7050>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xmgq4o3jbkgraaz5"
Content-Disposition: inline
In-Reply-To: <20210708021913.GB12358@yilunxu-OptiPlex-7050>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-fpga@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


--xmgq4o3jbkgraaz5
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Thu, Jul 08, 2021 at 10:19:13AM +0800, Xu Yilun wrote:
> On Tue, Jul 06, 2021 at 06:52:09AM -0700, Tom Rix wrote:
> > On 7/6/21 2:50 AM, Uwe Kleine-K=F6nig wrote:
> > >   drivers/fpga/dfl.c                        | 4 +---
> > Reviewed-by: Tom Rix <trix@redhat.com>
> Reviewed-by: Xu Yilun <yilun.xu@intel.com>

Note there is already a v2 out. See
https://lore.kernel.org/lkml/20210706154803.1631813-5-u.kleine-koenig@pengu=
tronix.de .

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--xmgq4o3jbkgraaz5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmDmjegACgkQwfwUeK3K
7AmHqgf7BmG51FI4Db8X2wcyosweFIvawskXYfYmZraLxltZ8d76NuuIJUmw5/j3
HJfOfWl0hhYJsrTQVSbOnaOG32y4GQ4b7yqzxJVCog/L5HSxXeG06em6BoiypgXV
9Vj1l+qcpoE9pljM8mxHpLLDUQOoAERrreZ7Qri+/sXrbvwOni9xRSOYLoXLnkFy
yUdANl/t217x2v2Lzjqy4c3y4IpiPw98mqaiXxnlY8Fdhnh76C8fJ2Ex7AbKmQsM
bQk6+ts2XSbQwIAPbwv7g42yafrwFDr4mXGXcDTq6pss4VrrYjAjA5mT38yIxhpO
WzWJhnzN+s1iCV7r6Z9ilJyyizyl3Q==
=GBSF
-----END PGP SIGNATURE-----

--xmgq4o3jbkgraaz5--
