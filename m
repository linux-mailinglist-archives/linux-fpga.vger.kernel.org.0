Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79884509220
	for <lists+linux-fpga@lfdr.de>; Wed, 20 Apr 2022 23:35:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353194AbiDTVgw (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 20 Apr 2022 17:36:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237756AbiDTVgv (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 20 Apr 2022 17:36:51 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C977C46142;
        Wed, 20 Apr 2022 14:34:02 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KkDSk4XBnz4xXs;
        Thu, 21 Apr 2022 07:33:58 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1650490439;
        bh=lNulJ0gQn8G6+yul2/45wg7sbMZtqY5S1QclA2Rfwyc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NbkhvBEuYBggx+VafRAWmF2jxU7gH19Kf6RYRp/HR2q11dFZmvee0K/CHPqwTcRYN
         VkDjV7jpMxY6n8LgZmjqP/aCdn6V4dAvxGWWbj8HK6xcxkhhn8Eu1dnsRA1vwIKMHq
         0UwMq1y5PuhbMbAnwLkYYhUo+iCaJUDj8IeT/Z7zl7vfuPO/1mQNIuW2QicPVYnnAw
         qjfZvBy3QLq3huyEutth6rKsJil0cw0XajXwcEOadZp1x+C0kVu3ZaFBpRGTYDa98r
         rY+iZQD8Vv/z+TdvQ0TKbKzcn8Dt0lrgItEG5bIoi6DsPDVFeainhFVgXNSuWKWdUn
         Scf6U7VGzBANg==
Date:   Thu, 21 Apr 2022 07:33:57 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Moritz Fischer <mdf@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org,
        Xu Yilun <yilun.xu@intel.com>, Wu Hao <hao.wu@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] MAINTAINERS: Update linux-fpga repository location
Message-ID: <20220421073357.07bb69ec@canb.auug.org.au>
In-Reply-To: <Yl+KW2BfkEYXeQz8@archbook>
References: <20220408022002.22957-1-mdf@kernel.org>
        <20220409154739.1a85472d@canb.auug.org.au>
        <Yl+KW2BfkEYXeQz8@archbook>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/MEgvWSOY=h3dig+.BLAkWI_";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

--Sig_/MEgvWSOY=h3dig+.BLAkWI_
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Moritz,

On Tue, 19 Apr 2022 21:21:47 -0700 Moritz Fischer <mdf@kernel.org> wrote:
>
> On Sat, Apr 09, 2022 at 03:47:39PM +1000, Stephen Rothwell wrote:
> > Hi Moritz,
> >=20
> > On Thu,  7 Apr 2022 19:20:02 -0700 Moritz Fischer <mdf@kernel.org> wrot=
e: =20
> > >
> > > As maintainer team we have decided to move the linux-fpga development
> > > to a shared repository with shared access.
> > >=20
> > > Cc: Xu Yilun <yilun.xu@intel.com>
> > > Cc: Wu Hao <hao.wu@intel.com>
> > > Cc: Stephen Rothwell <sfr@canb.auug.org.au>
> > > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > Signed-off-by: Moritz Fischer <mdf@kernel.org>
> > > ---
> > >=20
> > > Hi Stephen,
> > >=20
> > > can you help us update the linux-next part accordingly? =20
> >=20
> > I have done so, but you forgot to create the "fixes" branch in the new
> > tree.  Also, did you want more contacts listed for the tree (apart from
> > yourself)? =20
>=20
> Fixed. Thanks!
>=20
> If you could add Xu Yilun and Wu Hao as contacts that'd be great!

Done.

--=20
Cheers,
Stephen Rothwell

--Sig_/MEgvWSOY=h3dig+.BLAkWI_
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJgfEUACgkQAVBC80lX
0GyCjwf6AlD/Hgfi5wrFGsk0x6swTtz7TLKugkQ4rO2GRSlrWgf0vOZRtqprTjuT
Uk+opD0rd89zlrwDticrhcP4GCFbMx81nsuP9aWSdZh1MFo59hoyqePT9+UE/YeK
krfwm3OqrtwAcD1x9etLr7ct0hambcfuMRAwmcbCDCXBt79DOFcdQ/y1qLYQZEf5
rf7KlEnV4R9QNqwHYMn6hLSq+FDsWrsWets+rkIkBGBWs4og9TzVX3mIDrc90OWl
QYRvpZOHnFoX7UhqtM37VwrJOdKk/n4VDp3y86EcUwtn78xo4ykLdsTHK0TMRMz+
zR+K1rvfPSIgH63i/JBOrNAWHnabmQ==
=Nk29
-----END PGP SIGNATURE-----

--Sig_/MEgvWSOY=h3dig+.BLAkWI_--
