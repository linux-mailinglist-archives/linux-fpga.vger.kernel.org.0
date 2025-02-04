Return-Path: <linux-fpga+bounces-1038-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C261FA27C2F
	for <lists+linux-fpga@lfdr.de>; Tue,  4 Feb 2025 20:55:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4395F3A2F67
	for <lists+linux-fpga@lfdr.de>; Tue,  4 Feb 2025 19:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F78C219E86;
	Tue,  4 Feb 2025 19:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iLMplIup"
X-Original-To: linux-fpga@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF22219A99;
	Tue,  4 Feb 2025 19:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738698656; cv=none; b=HQ4DnLaNdR6YKUIJCyxJlIQL8jv5YF9YStHJRGsaYgM29uBxufjqxtY5gTP/1PlJkTeu7iziMZ1XrNZl2oCxRmQomv456njybriRoO/gJDlffLPLQcNqmECLKREwXJz49IKpGsGZ/i2s6RV+gfSwHJ9xQvdwkQrsMFpD9FQ1rcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738698656; c=relaxed/simple;
	bh=OovqO4nAjWOkKvXwDjcwT1vMzMriW/bXOE7S1Gw6O+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KEJnLBPEIpmx0lxO4iaZLLHaM/+qv/96T2Yhzq1RlXqbUDvp9ctYk9Ii3S0yZ/bhAoa/CKKWUIR/qPHpj4MnNhD9ya8AP6e46YHlL6ni32HmydiqPrJ44jna7kx45qdB4xauxCQ3XVbG9Aja3i25AP2j4e3ddCKhlkdDcmWn0mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iLMplIup; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6C01C4CEDF;
	Tue,  4 Feb 2025 19:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738698654;
	bh=OovqO4nAjWOkKvXwDjcwT1vMzMriW/bXOE7S1Gw6O+A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iLMplIupfkQeXhR/6mGPWqq+yyfUrrfa/Dhm8GeTPtvcNTypY0baYC3du/bYLFkMq
	 JlBGgSe3lzm8NMO7p7Db3M1lh6SP/njwz8Rk2hJSv0Fnx+zqi78KD5tApr7S8MOVjV
	 fTcwbqydRI6iPE1a3bnNDWu62vtvgc/vHJLv1l7dHEilmV30w/9CZo6F1jv3a5lquY
	 8N2CfRM5qnuRtT0M+8XGiXpM+4tK13M0HsZN6B08ceM8NyerXXtK+BnvguM8zfdpcz
	 JyxaF0Q6llIdohmT1go+a+qN+XNoT9UYmu3Wj+IMRCStb/8rfaEZXPljYLrPLAma2L
	 7eMX0z+f8e4dg==
Date: Tue, 4 Feb 2025 19:50:49 +0000
From: Conor Dooley <conor@kernel.org>
To: Mahesh Rao <mahesh.rao@intel.com>
Cc: Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Wu Hao <hao.wu@intel.com>, Ho Yin <adrian.ho.yin.ng@altera.com>,
	Niravkumar L Rabara <nirav.rabara@altera.com>,
	linux-fpga@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Mahesh Rao <mahesh.rao@altera.com>
Subject: Re: [PATCH v3 2/3] dt-bindings: firmware: stratix10: Convert to
 json-schema
Message-ID: <20250204-quintuple-chowder-59109fa8ff55@spud>
References: <20250204-socfpga_sip_svc_misc-v3-0-697f7f153cfa@intel.com>
 <20250204-socfpga_sip_svc_misc-v3-2-697f7f153cfa@intel.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Ae6c9eOCQf7+ch1f"
Content-Disposition: inline
In-Reply-To: <20250204-socfpga_sip_svc_misc-v3-2-697f7f153cfa@intel.com>


--Ae6c9eOCQf7+ch1f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 04, 2025 at 08:58:06PM +0800, Mahesh Rao wrote:
> Convert intel,stratix10-svc service layer devicetree
> binding file from freeform format to json-schema.
>=20
> Also added DT binding for optional stratix10-soc
> FPGA manager child node.
>=20
> Signed-off-by: Mahesh Rao <mahesh.rao@intel.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--Ae6c9eOCQf7+ch1f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ6JvmQAKCRB4tDGHoIJi
0hv6AQDL2BEpLLZYLr/aAh35VzjJvX3Y4W9xo3ASawXP3GbtYgEA4kiZaLP9Xi25
tsTICtC7lMaQBTK4FWfj9Vd6F0otfw8=
=vsa7
-----END PGP SIGNATURE-----

--Ae6c9eOCQf7+ch1f--

