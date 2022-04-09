Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E7B04FA53B
	for <lists+linux-fpga@lfdr.de>; Sat,  9 Apr 2022 07:51:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbiDIFtt (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sat, 9 Apr 2022 01:49:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232726AbiDIFts (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sat, 9 Apr 2022 01:49:48 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50E8D21813;
        Fri,  8 Apr 2022 22:47:42 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Kb3zw5D7zz4xR1;
        Sat,  9 Apr 2022 15:47:40 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1649483261;
        bh=TlaRdfUL8TWbLMMzPZD0xEBDDFHBJrTDLpIKVVNj178=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fPK4RELuP0u27nws7S8gbegJTKMd1Y2PdBV9buGZSO9NT+IpunltMIwLVx2cbb6Vu
         /zEPh1lTT46QWc4strsezvGPgdDL48vh4G9u4uKIlVrRkYFdeElgajJgDDJtV8ZYTK
         htGJSJnklZcpYumnd7ierIq2n+KRHgJsvacirZPBnortbbCam+9ag/W7dElei1rBaP
         dhD35l/6hHhh2PLuyEQtjZMmeXXDtJkU6J9mtS6JMZ1spbFR1fanxgP/90P1j6QqWp
         XWFt8FF28cbJRIGvxlOnRV9pDXqPGaPO3nTeE91+77+g2OILFgNTIMGETOXIrgEImp
         FeZGRiPFL7qkQ==
Date:   Sat, 9 Apr 2022 15:47:39 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Moritz Fischer <mdf@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org,
        Xu Yilun <yilun.xu@intel.com>, Wu Hao <hao.wu@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] MAINTAINERS: Update linux-fpga repository location
Message-ID: <20220409154739.1a85472d@canb.auug.org.au>
In-Reply-To: <20220408022002.22957-1-mdf@kernel.org>
References: <20220408022002.22957-1-mdf@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/WQolCI/D+ghByf=zJPnB8M6";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

--Sig_/WQolCI/D+ghByf=zJPnB8M6
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Moritz,

On Thu,  7 Apr 2022 19:20:02 -0700 Moritz Fischer <mdf@kernel.org> wrote:
>
> As maintainer team we have decided to move the linux-fpga development
> to a shared repository with shared access.
>=20
> Cc: Xu Yilun <yilun.xu@intel.com>
> Cc: Wu Hao <hao.wu@intel.com>
> Cc: Stephen Rothwell <sfr@canb.auug.org.au>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Moritz Fischer <mdf@kernel.org>
> ---
>=20
> Hi Stephen,
>=20
> can you help us update the linux-next part accordingly?

I have done so, but you forgot to create the "fixes" branch in the new
tree.  Also, did you want more contacts listed for the tree (apart from
yourself)?

--=20
Cheers,
Stephen Rothwell

--Sig_/WQolCI/D+ghByf=zJPnB8M6
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEyBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJRHfwACgkQAVBC80lX
0GyTCwf4ii8zjQxzZDEYqzmMEHVKA4LxEryf5XPk2FaCwOV0/wdQckKjG0aYFL84
H+P0skRzpR2pY10LMPVi7Tc8CJfBeKjf4fhr5wZQmVqAqhdcOFODhPd6jH9AJQzY
yFu6qiqBSHsoqZivtH58cjQASw+t0GW0KfJR9Pw5vqKGMMeQq0kqpAo5gBARhSsX
SlyU9KklrqQlMTBqRxJwcjv4N+uGcKIrEwimBwxIUZ1G5G3NcCEgTENfJumMBWMz
2xLlg1qbuLk1H47ElHa40ZK1h5etQ4OzkwkAHfs2OQdLs3l0sLeOfdiMSl8zYvW+
DesxyLwgBQt2oDZjFvEcIPFQDSUv
=P4na
-----END PGP SIGNATURE-----

--Sig_/WQolCI/D+ghByf=zJPnB8M6--
