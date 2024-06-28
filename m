Return-Path: <linux-fpga+bounces-567-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04F8F91C313
	for <lists+linux-fpga@lfdr.de>; Fri, 28 Jun 2024 18:01:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 352981C22B4D
	for <lists+linux-fpga@lfdr.de>; Fri, 28 Jun 2024 16:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3A7A1C0DCC;
	Fri, 28 Jun 2024 16:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D7ZgCR7W"
X-Original-To: linux-fpga@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B77182B9;
	Fri, 28 Jun 2024 16:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719590443; cv=none; b=eb1RMUAagDVlG91eHgS3fXHdM2CG+IJtBFqXaXi//bFQQCYADAvbrDyAXqi9bcpmvIX0qCK9e6k40BOhwxDhtPMeOFFrwGlJqOmoWqHtgOXXvx30OQ4RDnNWddaePPXEVk29uXmxrqA1Ute+K+QBLIJU12NVArMOMqPX0c9vooI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719590443; c=relaxed/simple;
	bh=d9+vGavIHjuofdvT9YcleeT1YhLvXjb51TCcEY2RgGI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QG6p5I7mWbETR8k5QuCwF89wMK8zeEUK6QTUR9Oc6Fv3abVsoqdd+KjswDl3PquCrbzbyJYum/HeoLvuNeYATu4sdceNfClN6880Z/UBRx3Dem69xZIlPmX+ICP6OuH9TXIWp49/955akJknUQNKQJXPZ/YVYDfLY4n+oi/pqOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D7ZgCR7W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8531DC116B1;
	Fri, 28 Jun 2024 16:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719590443;
	bh=d9+vGavIHjuofdvT9YcleeT1YhLvXjb51TCcEY2RgGI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D7ZgCR7W1RR8XTrsAVAvb9of2sucd2e/K7kgGry628m8JzAo1AVQQ3GIflWbdACVL
	 YStgSOV9OrFI0jajAUxoKcPucGwGuKhuROG6JYZGBE+8K1KrVnSMrmo8CHlXp6ssJg
	 8CQh6QBXjXLkAXk5V1L5PJSopXMRP3G2KfvH54DxcqRE0NxMIdkkI7/YcHIKSQoQC0
	 gtGKYP1Deu1YwN0XY5+eBqUtU5DB7ENCUkQtoaKQ75/KMA89c+XLk7LLm8IPQCcFKb
	 JVFwG7p/+SLFGmKDDCoTwrwzVdRaUGmRBRl7eldy6YWTnC6eRu2STatYDtcuvv5iLL
	 TrUuypIzv/9IQ==
Date: Fri, 28 Jun 2024 17:00:37 +0100
From: Conor Dooley <conor@kernel.org>
To: iansdannapel@gmail.com
Cc: Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
	Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko.stuebner@cherry.de>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Sebastian Reichel <sre@kernel.org>,
	Chris Morgan <macromorgan@hotmail.com>,
	Michael Riesch <michael.riesch@wolfvision.net>,
	=?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
	Andre Przywara <andre.przywara@arm.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-fpga@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] dt-bindings: vendor-prefix: Add prefix for
 Efinix, Inc.
Message-ID: <20240628-hash-prior-4efcc411aeb6@spud>
References: <20240620144217.124733-1-iansdannapel@gmail.com>
 <20240628152348.61133-1-iansdannapel@gmail.com>
 <20240628152348.61133-4-iansdannapel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="++Rd30xAIlfdFz2F"
Content-Disposition: inline
In-Reply-To: <20240628152348.61133-4-iansdannapel@gmail.com>


--++Rd30xAIlfdFz2F
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 28, 2024 at 05:23:48PM +0200, iansdannapel@gmail.com wrote:
> From: Ian Dannapel <iansdannapel@gmail.com>
>=20
> Add entry for Efinix, Inc. (https://www.efinixinc.com/)
>=20
> Signed-off-by: Ian Dannapel <iansdannapel@gmail.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--++Rd30xAIlfdFz2F
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZn7eJQAKCRB4tDGHoIJi
0t8gAP4p60AjNbDpk3hf65X2ivbOdXhL6s3iRXN8vLWp6k7TgwEA7D/ZwuyqkDAm
Tf/kqqN12Tje3F4e97Kr2c9hOkF7JQI=
=Rxew
-----END PGP SIGNATURE-----

--++Rd30xAIlfdFz2F--

