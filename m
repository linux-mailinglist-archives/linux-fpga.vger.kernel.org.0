Return-Path: <linux-fpga+bounces-570-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD6A29238FA
	for <lists+linux-fpga@lfdr.de>; Tue,  2 Jul 2024 10:57:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E2361C20A68
	for <lists+linux-fpga@lfdr.de>; Tue,  2 Jul 2024 08:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B8D014F9E4;
	Tue,  2 Jul 2024 08:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b="wM+GaF8k"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mail.thorsis.com (mail.thorsis.com [217.92.40.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9726148303;
	Tue,  2 Jul 2024 08:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.92.40.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719910635; cv=none; b=eY7f4kni68lnbFf2FEYngQVP28j9ArahEgAHhViPlHwvPW4PBwhftcWJnHMOihGFbTgs8ZUheW31hTT3B8TC89eKaXRn2Zmbeuku3HPmRwgnYOlfrPA4nYOKW8HSDsIAlRaGQ5ctjG3taTRav39azkVLrrhLBf8B+eS2ZyhH6ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719910635; c=relaxed/simple;
	bh=k8ltUBy7tIu3sTitWeJizzHjGemAAUqdiwnUig0vyMY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E5tYiSEiTmY5hm7u1JuLrVF+rCw6FJj636pSSUyhspaDClmR9S5U43opi+jegqoG2/Bybst0X2YmLTCNyq12tQKAtAX9IwqeRQj7fOISZqOZyoFMuSpxPALiJkCUTkxg5jys0Xvw1+QGvF6w6XxjDlBLJVwvIBFsJdk50BJ0m7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com; spf=pass smtp.mailfrom=thorsis.com; dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b=wM+GaF8k; arc=none smtp.client-ip=217.92.40.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thorsis.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D39931480778;
	Tue,  2 Jul 2024 10:57:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=dkim;
	t=1719910630; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=ihwSEeAUbYbmh/Ao3Mg4/4pnp9Tll7MaTdNMncYB7Rw=;
	b=wM+GaF8k20vVhtAkte5r7+0EFpiBdf4tY27YqjYn8ttwc2ZCYuSgJqGiLt0L94MrJG8YZi
	9+7tjzzbXwRSv7fb8MQGQHjMo+pO4pmeea2ftvfx9pAXUDY83QjxKQ5GcdOMnlPsPxAwIK
	E72uZzDVoAR+AlVGZJ0hv9YpO4ZTrAlkgSWrRw00o1I1c9hvdmO7Yh/p/JNEakxQKWb5h1
	6VZY/UJ4oLafiVR29GjKVx9peeKQMiq7J3n9wcyYNycU7RCF4acpdKSwGFBkFPSj69bEk2
	odZZjhEHmGsJh4T+MtVI/r0RhVXGSyMIS03B7e2Grcxh7E0R+Vkvav8VusRorQ==
Date: Tue, 2 Jul 2024 10:57:05 +0200
From: Alexander Dahl <ada@thorsis.com>
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
Message-ID: <20240702-abreast-tree-672e096750b7@thorsis.com>
Mail-Followup-To: iansdannapel@gmail.com, Moritz Fischer <mdf@kernel.org>,
	Wu Hao <hao.wu@intel.com>, Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>, Rob Herring <robh@kernel.org>,
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
References: <20240620144217.124733-1-iansdannapel@gmail.com>
 <20240628152348.61133-1-iansdannapel@gmail.com>
 <20240628152348.61133-4-iansdannapel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240628152348.61133-4-iansdannapel@gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Last-TLS-Session-Version: TLSv1.3

Hei hei,

Am Fri, Jun 28, 2024 at 05:23:48PM +0200 schrieb iansdannapel@gmail.com:
> From: Ian Dannapel <iansdannapel@gmail.com>
> 
> Add entry for Efinix, Inc. (https://www.efinixinc.com/)
> 
> Signed-off-by: Ian Dannapel <iansdannapel@gmail.com>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> index fbf47f0bacf1..6175719c1fb6 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> @@ -422,6 +422,8 @@ patternProperties:
>      description: Emtop Embedded Solutions
>    "^eeti,.*":
>      description: eGalax_eMPIA Technology Inc
> +  "^efinix,.*":
> +    description: Efinix, Inc.
>    "^einfochips,.*":
>      description: Einfochips
>    "^eink,.*":

Acked-by: Alexander Dahl <ada@thorsis.com>

Greets
Alex

> -- 
> 2.34.1
> 
> 

