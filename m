Return-Path: <linux-fpga+bounces-568-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF90091C34C
	for <lists+linux-fpga@lfdr.de>; Fri, 28 Jun 2024 18:07:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A3381F239DC
	for <lists+linux-fpga@lfdr.de>; Fri, 28 Jun 2024 16:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DC351C8FC6;
	Fri, 28 Jun 2024 16:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qb5KoASv"
X-Original-To: linux-fpga@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02F3A1C8FC3;
	Fri, 28 Jun 2024 16:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719590857; cv=none; b=JWw50DSCa3RpzfmMjpZnoA16NCLx6vI4awvDzIfB1MAsjjkMVsjCjOmZIomRfg60BMKWtK/2sGjvBHzy31yrrMQGkdgTvBemRDXi2m6OkRvyH55zzaUzEOLbeCPCmjO+0yQq1Rq2Vd83UtX7dB3h8wKigagGRpndYLb4mAteJkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719590857; c=relaxed/simple;
	bh=6LxtY49jDsVw/0AopONLbTm99sT9nlFRVwnYuBY4KBY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lrRBv18Gs5XgphK8cGR6iTuwF+rJmiDXGE3TWzS3ZQQ6Lr6pbuBnKASDrf+v3ky9Y8h0pf22vUBPFBzAl/EWUsHvmVhxXRGrF3nN9es4K3luO8AykDjwKdTqkOhmnGLVVZDrhP/lOOBhRJD7Mw5zTl+VJNOVbtjBuSuXqd6y1xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qb5KoASv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D804DC116B1;
	Fri, 28 Jun 2024 16:07:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719590856;
	bh=6LxtY49jDsVw/0AopONLbTm99sT9nlFRVwnYuBY4KBY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Qb5KoASvg9qnN13ml4xzw9BtB4EfqVyh/XzmB5zmYhsT8aVtC5GnuL/rWtkD0JtiM
	 vZek/wXWB7WhRWPjMkS8SJzD08mqBQw9Wi4Nw2GAIq4IIkkKdK626qSYh4iCqRBPfy
	 cekgsxhkfOhQMpbZpbw17EezC+jJc8aXxWRY2qOXja+iaKbWGjILOF7KcpL+j4Di//
	 nTCQDC4QdeaCInwj0hyJk1zv9vSNvVD8fHD/7NyL8gyWqean2PD/iTmZE4LWrZo3CU
	 p/v4vFgPp5CM2+sRvZP/5YLax6Dey54ZiyWSdERlOxW5heChZIvjIbSzR9aqgmXdn1
	 ABKU4MACEBYmQ==
Date: Fri, 28 Jun 2024 17:07:30 +0100
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
Subject: Re: [PATCH v2 2/3] dt-bindings: fpga: Add Efinix serial SPI
 programming bindings
Message-ID: <20240628-wind-security-002879d225b5@spud>
References: <20240620144217.124733-1-iansdannapel@gmail.com>
 <20240628152348.61133-1-iansdannapel@gmail.com>
 <20240628152348.61133-3-iansdannapel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="B1e1D9fkpt5Vkw7k"
Content-Disposition: inline
In-Reply-To: <20240628152348.61133-3-iansdannapel@gmail.com>


--B1e1D9fkpt5Vkw7k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    spi {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +      fpga_mgr_spi: fpga-mgr@0 {

nit: the label here isn't used and can be dropped.
Otherwise this looks okay to me,
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--B1e1D9fkpt5Vkw7k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZn7fwgAKCRB4tDGHoIJi
0pZ0AQDA0OySbczbwXcrTQ0Gaw6f2Ow5YADbDMpfMRUU5IewYgEA85pkZomawLT6
ecNYbrRl+TnmpRwu8ITVEvdfFlznQAY=
=k63c
-----END PGP SIGNATURE-----

--B1e1D9fkpt5Vkw7k--

