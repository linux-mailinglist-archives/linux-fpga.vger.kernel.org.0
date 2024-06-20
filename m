Return-Path: <linux-fpga+bounces-546-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 132E291015B
	for <lists+linux-fpga@lfdr.de>; Thu, 20 Jun 2024 12:21:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4CC9281541
	for <lists+linux-fpga@lfdr.de>; Thu, 20 Jun 2024 10:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 237511A8C2B;
	Thu, 20 Jun 2024 10:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="GTZJLFBT"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDEB81A8C04
	for <linux-fpga@vger.kernel.org>; Thu, 20 Jun 2024 10:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718878875; cv=none; b=aTV+PpF8UyFH1J+6YxZrAYbILZVOaOptMbXE4IGja2N6BdC4Zffs0vjcEGHe/xQ9CN3G+yJXLym7Sh4v3ULmit1d3TqI3s6AB1yu29CGX3XSpDBOxo4KyDfXHocwK6NkQORpD+QKBqQYYIK0Q3/+A6WlE896RDbJb0KUXld4aOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718878875; c=relaxed/simple;
	bh=VySAUnc5zyycJcWSlkBDQsdcG2gx5xBxSB4r0CBXKsc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i43Nf/QwWkUsYQU0rKf/Cc2E/yKTcdi53XTnGae4nYr+XONHPRmHULuFqcgl3svMn+3k7a9EmIHNylV133IQ40meNnB2GABUiR6ZDXeu9scMMqPzbrEuJCVXx3N0C+RFWDJWknHhji8vmRbfys/j9Hg5SSf3GRGgt/h3ah1EAC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=GTZJLFBT; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=6QvP
	0748bCUTqO0uAOaBSr5w4kgzYGCPnOBesJKCbVI=; b=GTZJLFBTtLk78TI/p/eD
	ectdwK0IgGoe6CvaiIkqJVKbTWCCaebezaECDEUs+dEI3RUOXRX+pd6qxfFTmUq6
	ZOgMT0V4llgzBaMJrUDVWPAP8bNp1waN1c255iJ5+r1dShbe7VPKsL4d85q5x5zT
	BZHVD5qSZaZ3HvleYoyQlmgDHS+FaLL65pj9qfBjWLqyT1uauKWknokJlFqnV225
	NPHp9ysKRs9yKXBsY2ZR6e0/h5la5MtjZZxfgFesxT+NOGwF4mQ025FqMuPRXHCf
	TP7ck/HjXk0ROhcfJVumhbEQDx8nOn+tuFHv04DM+3wBVBI/455N2eOZFUYVtP9S
	QQ==
Received: (qmail 976563 invoked from network); 20 Jun 2024 12:21:10 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 20 Jun 2024 12:21:10 +0200
X-UD-Smtp-Session: l3s3148p1@iAh8rE8bMrogAwDPXzjQABqqX1QYyOSW
Date: Thu, 20 Jun 2024 12:21:10 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Xu Yilun <yilun.xu@linux.intel.com>
Cc: linux-crypto@vger.kernel.org, Moritz Fischer <mdf@kernel.org>, 
	Wu Hao <hao.wu@intel.com>, Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>, 
	linux-fpga@vger.kernel.org
Subject: Re: [PATCH 1/2] fpga: socfpga: use 'time_left' variable with
 wait_for_completion_interruptible_timeout()
Message-ID: <g5xw3icobdq2cuubqzmfvkph5jd3ag7shbxkntnotposuxviis@ewfw2cyc4g7k>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Xu Yilun <yilun.xu@linux.intel.com>, linux-crypto@vger.kernel.org, Moritz Fischer <mdf@kernel.org>, 
	Wu Hao <hao.wu@intel.com>, Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>, 
	linux-fpga@vger.kernel.org
References: <20240502210038.11480-1-wsa+renesas@sang-engineering.com>
 <20240502210038.11480-2-wsa+renesas@sang-engineering.com>
 <ZmgGiuu/5Eqxb0uR@yilunxu-OptiPlex-7050>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tb3ejhpz355vq5oq"
Content-Disposition: inline
In-Reply-To: <ZmgGiuu/5Eqxb0uR@yilunxu-OptiPlex-7050>


--tb3ejhpz355vq5oq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Yilun,

> Sorry for late reply.

No worries, thank you for the review.

> First of all, please limit your subject/shortlog/summary within 70
> chars.

I'll try but it will be hard when it contains such a long function name.

> > There is a confusing pattern in the kernel to use a variable named 'tim=
eout' to
>=20
> Please make the changelog line wrapped at less than 75 chars.

Good point. My scripts reformat generated paragraphs now accordingly.

> > +	int ret =3D 0;
> > +	long time_left;
>=20
> Please use reverse xmas tree when it is easy to follow.

Will fix.

All the best,

   Wolfram


--tb3ejhpz355vq5oq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmZ0ApIACgkQFA3kzBSg
KbYWBA//eSJ+HBgKDygwObdBJzw3riwudWm2kfTqZbQBg0v9ZvT75hrAf2jgODY0
2viatD/wLDc9MQrSF23+gK7XG/PrqOMTmy146d4oW6iTF4D+WVr2h+dF1eJRhOHS
PPV9THjycPreR/leGqlSc/f/npETprYEyPv/AwEQYziL3wPW7KHXASSjGGTmKKqc
lzTzYmkmVbsPcDNwV47OlUY7ClQSS2oxHpxC0MbU2tyLngM/56/nBd+BSaLkCqQz
wUlYMmIeDTZzXGH+iDUsPvjrpcQ8pzdzFIhfj5psATkoEeJKdpaqw4fCktNL5mmY
k3yT7gqIXdcE5YfKLrwhcfEzh+XAFIbj3rprfT72zCIh9FWTHkMFh7tDJSXL0tH9
ggdXtva6t5crumoOGkzbkKlMl/SAxAB9ZpfwMFqeoIYOcTCbeJ+psKQsI8tzV9dU
LlUVsNphLAzN0KvyUpojoK+AM5Sf9E0NH72fTcNJovKjSPsBzULDhwOclx7idXqq
EA9dtjoJMMPHiPKEhJSJaN3p+v2Qbi0ObXKCNv2n4F1hmiRtyj9GgCAECZWPdhKZ
Ciuo/aIe7cT5iWJYWzP8yiG9YVfhEfwv+CvC2CnUmo7UbQ8rAOxXx9yocwCMcK+L
UPNvV2Fv2+4TrJwr+uRJ4KonbWmMQvcFUB2JAhZj9l8ybCyefA4=
=pYHh
-----END PGP SIGNATURE-----

--tb3ejhpz355vq5oq--

