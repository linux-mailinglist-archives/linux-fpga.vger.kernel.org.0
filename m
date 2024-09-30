Return-Path: <linux-fpga+bounces-751-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3AA9989A7A
	for <lists+linux-fpga@lfdr.de>; Mon, 30 Sep 2024 08:23:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A58DB214D9
	for <lists+linux-fpga@lfdr.de>; Mon, 30 Sep 2024 06:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84229433C4;
	Mon, 30 Sep 2024 06:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b="VozEvNlW"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mail.thorsis.com (mail.thorsis.com [217.92.40.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F8D23BE;
	Mon, 30 Sep 2024 06:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.92.40.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727677417; cv=none; b=dggTTqPesvqUh6KAOWuqTVssvFI/g4b6HRW7mV8LGF9EHSr5YBTZWzx/ebcyKc+mLuNGEV0e3gvE9X4jkB9b9PJcKsSHby/tX5U3CToruEo/U4puVPvxTcNONqg7p0MoNe3OGZfQJFN7D0w8laakbn1zGFcRH6g2RCiflqdNE+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727677417; c=relaxed/simple;
	bh=KacTsB1rDIoVQtRILrYR7CSH9zw8PB+63mpb1v0klqs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cbWvQxJIInDv+WtwRKm+UnrnYrLgWlT366+Bk5uSzGrL9QS10L94b2OntYxX6kkjM2HI6N9HBzoQTw2NakbivD4F8ISX2K6PgsT2njIrFOM4702AhTNkPAFOZXJbYGnenI5f1yvNR9KkciH6v4KzOAsAv8gq96xtqCbnQCgc1CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com; spf=pass smtp.mailfrom=thorsis.com; dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b=VozEvNlW; arc=none smtp.client-ip=217.92.40.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thorsis.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 480E01486A9B;
	Mon, 30 Sep 2024 08:23:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=dkim;
	t=1727677405; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=ibzyBjuzfNPPavMmEdBN1WsLI+EZeL5i4GIN1cYlFHk=;
	b=VozEvNlWldunq8C8NmKVlf2t3Mmb0692CEG8R6PG9YyCUd7AsHvI9SoDetP2/e0x2owL1P
	PVbw/sSwEQiNrHyK0JP5/wJwa4S23DuSwHA6CyENGCS0qOgj0HqcnDjrgY84wmLqnsdUYM
	KYs8H+mZuiR/rQzU9YultDmaLkLU+l3kWynFBR4g0aU/vb6CVdTQZxEKqhfjp6r06KLwcJ
	i+7XHvlup1hzGB54fUR2cHT7Y71MqBJjEBQJyELi0BOPSQ8WIZk/lRd1zvCfQoDQRiJIL9
	DIiAdxjHjXC/84Q/15+c4akbgN88kFa14jYzymtjk0f4Nn/ffItXRUJLGENcGA==
Date: Mon, 30 Sep 2024 08:23:12 +0200
From: Alexander Dahl <ada@thorsis.com>
To: iansdannapel@gmail.com
Cc: mdf@kernel.org, hao.wu@intel.com, yilun.xu@intel.com, trix@redhat.com,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	neil.armstrong@linaro.org, heiko.stuebner@cherry.de,
	rafal@milecki.pl, linus.walleij@linaro.org,
	linux-fpga@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] dt-bindings: vendor-prefix: Add prefix for Efinix,
 Inc.
Message-ID: <20240930-tranquil-glitch-f48685f77942@thorsis.com>
Mail-Followup-To: iansdannapel@gmail.com, mdf@kernel.org, hao.wu@intel.com,
	yilun.xu@intel.com, trix@redhat.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, neil.armstrong@linaro.org,
	heiko.stuebner@cherry.de, rafal@milecki.pl,
	linus.walleij@linaro.org, linux-fpga@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240927141445.157234-1-iansdannapel@gmail.com>
 <20240927141445.157234-3-iansdannapel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240927141445.157234-3-iansdannapel@gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Last-TLS-Session-Version: TLSv1.3

Hello Ian,

Am Fri, Sep 27, 2024 at 04:14:44PM +0200 schrieb iansdannapel@gmail.com:
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
> index b320a39de7fe..cb92df951fa7 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> @@ -430,6 +430,8 @@ patternProperties:
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


