Return-Path: <linux-fpga+bounces-710-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA25397A5DC
	for <lists+linux-fpga@lfdr.de>; Mon, 16 Sep 2024 18:21:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05C1AB2CA80
	for <lists+linux-fpga@lfdr.de>; Mon, 16 Sep 2024 16:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22E3F15ADB1;
	Mon, 16 Sep 2024 16:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ygvl71to"
X-Original-To: linux-fpga@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5DB715B108;
	Mon, 16 Sep 2024 16:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726503308; cv=none; b=HMem1Lum6ICcMnQ9gaPDjwgOeDyL7TLP8Pp98EbBsAAzRxHmoqL3hoV5O10S3h5TRHAhDz/Ozl8Dr7cJwz6szVB7hWFS/KLaal2ZLONL4sltIb0gNmeCRhf0ampxOn4QUYPUbmPDXur5MpeIipFnMS1idLkMX8T0Kouq30H6x14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726503308; c=relaxed/simple;
	bh=6XBJZh0B2ZTNxz+ZvFXaI35O1L4pdkrvvc43S0ipv7c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aDXO9UmwF6hBiEh3vkk0CCZC/Z0lZMvEv4SMSNH5/dWJXGGThxltRpYy42MPPjCAF4NgUJIoO1CKtHqo9eoB8VZLgokNe+iwuVrSe6D3aFb1AsahrYZna2UtaAkH1ASHsMVHGSY6hob6C/mxWK5DYkxVXSdezrUnmjMiiK0VbhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ygvl71to; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21B6AC4CED0;
	Mon, 16 Sep 2024 16:15:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726503307;
	bh=6XBJZh0B2ZTNxz+ZvFXaI35O1L4pdkrvvc43S0ipv7c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ygvl71to9Ba1QSlLQRpHYy8BzzEIAZJARx42f+LQcX7hQgMzYqEOim3paPNNHlFNH
	 mTXSJcxhNibOZk+jvnji9U2PvZQM668o4TH75HvOKrw/mt3/gmJp57N4kfLuOesx05
	 /VJpGI9CL9kmX09OTQprOQ9BNDQVSuut7KpHW3t2Q1u0bjPSwVWQkUAp5MtljVRqsk
	 R/u90/a6BqPxtVXhgwDpeUHqcc/C3qq1o2Oj12saGMDZr4z4wtUrV8UfcK0NVZjIt5
	 /Yie5Uwk+J4rTbKdIXiUEZ2lkLg+RisWqLCb1lMDbAA+8a7zy0SnsTAA0XNebuqux1
	 1EgMyPGJq+rOg==
Date: Mon, 16 Sep 2024 17:15:03 +0100
From: Conor Dooley <conor@kernel.org>
To: Fabio Estevam <festevam@gmail.com>
Cc: mdf@kernel.org, hao.wu@intel.com, yilun.xu@intel.com, trix@redhat.com,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	linux-fpga@vger.kernel.org, devicetree@vger.kernel.org,
	Fabio Estevam <festevam@denx.de>
Subject: Re: [PATCH] dt-bindings: fpga: altr,fpga-passive-serial: Convert to
 yaml
Message-ID: <20240916-vineyard-uncrown-cb154b202707@spud>
References: <20240914200205.2472262-1-festevam@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="dtcdw6lAY16y2fFv"
Content-Disposition: inline
In-Reply-To: <20240914200205.2472262-1-festevam@gmail.com>


--dtcdw6lAY16y2fFv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 14, 2024 at 05:02:05PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <festevam@denx.de>
>=20
> Convert the Altera Passive Serial SPI FPGA Manager binding
> from text file to yaml format to allow devicetree validation.
>=20
> Signed-off-by: Fabio Estevam <festevam@denx.de>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

--dtcdw6lAY16y2fFv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZuhZhgAKCRB4tDGHoIJi
0l0XAP0Wm1kpUxRc2OZ98qXe+qla5XE6VqWXamr/W3WGpcUpVwD+PS2fC9qJixPv
R6FXM5m6Rx8uUMYEFmaq4m86O4sq/wI=
=kUZF
-----END PGP SIGNATURE-----

--dtcdw6lAY16y2fFv--

