Return-Path: <linux-fpga+bounces-1209-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D87C1AB3BD3
	for <lists+linux-fpga@lfdr.de>; Mon, 12 May 2025 17:19:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4834D3BB986
	for <lists+linux-fpga@lfdr.de>; Mon, 12 May 2025 15:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA75523A99E;
	Mon, 12 May 2025 15:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ox1TmMNK"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3015239E81
	for <linux-fpga@vger.kernel.org>; Mon, 12 May 2025 15:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747063159; cv=none; b=LKE3TYZBI+IxsnBqrgAZdUbMErQYGwlSZOxtIjLRh2d7tam7Xvw7qDr84D/OkTPTeAdAWV33w2NBHpzSuFOWtMYAaqTHb21/8/UwZxhJQB+dfvfq4c945BEd0DKdgVRD4LiAR4q76Ivp2RGL1tqIj/Ru4cCQDJwao28Gynrqzxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747063159; c=relaxed/simple;
	bh=YLRhKQPiXdebeEoWu36rYII0+EGFuA/AZrvLs65tpPc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nX/a8bjeXkPpbn1cvRncd5aWTUiP0RWFoj8hsnQa2xt9NmCL4upsb2kkreplv9TJc65jb39ds1O9/e3daINDBWrFq2dxAYM08NQTZYfaTjllOJEXZFQKdFbi9WQkULBboAA5d2UDsLt8IKwYDKH+WQE/krngV3RySt+EvkX8eP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ox1TmMNK; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3feaedb531dso960580b6e.3
        for <linux-fpga@vger.kernel.org>; Mon, 12 May 2025 08:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1747063157; x=1747667957; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uB97RORFeCN+m++iQb4oHIgwP6lqwFalZZAX+MQgG3w=;
        b=ox1TmMNKgrKcBcX3tpbmId1cWVUXHh8yZUEIFLXQhYBgniJIgCV6w++of692fHNA5R
         2dE4jD+YbstQn/sBNZ80boqZ96gZG02al23FqNwgVnoYIBSKOGA6uAo207P+dvL0KFiQ
         AYiY+LN21yNxw0nLGBQ67My5fPwnlhRsHl914YN9/VCz867SWBhc20exn5WuP/8WtFuQ
         uE6+kqTtqJU6pF5lo04l7U/d7Wy7RmO9T2SjLaATvYb9WHD8iBCyCmlyJOKQhv3S1haS
         1Oql08n8BuafKsjFe0gqC5eKNg+UJkUvM/y8bwDOF/iBN/1NtZU78eEFKuX2nOUNH5X+
         cstA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747063157; x=1747667957;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uB97RORFeCN+m++iQb4oHIgwP6lqwFalZZAX+MQgG3w=;
        b=A92vc1q9jXveoeuaWRkLhuxlhfLchHay4lSjGujrsybubH50jSen7JZPlvIeB4mbWj
         FDP9n2KTgQ06jFTM31/8xUtA2uAy8BDjtAVXHd26er1W346ZzkrnRstPJzaAUKPUVa05
         BLh+HFj1amfEfZg6CThfSJj8/vBBMUzFZ6BsC9P0VCuAC0jMEPaCRxpI6ct9DlKGFIlv
         v7w0MAWdYTaxSfSfIz7pNosXH6ZOpFRvifUgu1rsAt3p2DrgUwIJ0siMt7XeLJ8VJ9X7
         Iri3oVl2yV6dipXoJb4lzeRCkdiHBirJn2ac9JCJxCKxvAJ+exImAwTgsYLhYS3PX5+1
         ecYg==
X-Forwarded-Encrypted: i=1; AJvYcCWbRsNBMukKdds9hQbdYZ3pm3cjWUzqjq9qJYx0xpBIqSlNBzo9BIIlgfjWdsogABtZbhSYq7ovZy4j@vger.kernel.org
X-Gm-Message-State: AOJu0YwTdEWKbqSh3KnFW+BD/eLSOHS5efcM+kBZv2JtglKj7WXUuGXe
	XHDzv039KzHHH9adwpVK6/8EKghKv2QL02xtr2rBEEJJ5pImPZflBqFhY704F9w=
X-Gm-Gg: ASbGnctnF9FKwY+Vn+hatDVPSBBp0AdzNOBLUwMILrmht/x/a8AAuA0H+kRXIew29D8
	Tn9ZjWtWAOr7RGAzrl0boAbbQVqskv66ALt+dPIZv1IT+w6GHDfaCSrlh8CL7wAt7OxYXUGDVMi
	Hqk1fbK4b1nTRVxyGZWgYqcORFNJxmIYRaOxYkw3n9Gwkqa/mHbPFj/LNUha33TAZIyZznyPLkU
	e2NLENr8D9otInUl7/3MYOENHuz2OJ5Z9a98FlKkx4KlHHm6naFOR27G/6CTd4sRUDTIlZfBkBl
	VkSwHCOwAehD1LnB2KVNoqBpNh996NRhvP+OIKrRZwAfXaYWTQzAdAvpe+gWdEmhGlJuW2t3z71
	gHvfWwwQkd+65iDmdECDlOn8SuySq
X-Google-Smtp-Source: AGHT+IF4wUVmJBZ3K8txZjwLLOWfdyKyYz1MbDWVE24RIYHa/SNfHkpPunaTfB6E0UsECakCsaE/HA==
X-Received: by 2002:a05:6808:1409:b0:3f6:ab0d:8dc0 with SMTP id 5614622812f47-403800d6897mr7978911b6e.24.1747063156758;
        Mon, 12 May 2025 08:19:16 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:fd2e:ffda:4c42:b314? ([2600:8803:e7e4:1d00:fd2e:ffda:4c42:b314])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4038038920asm1571039b6e.34.2025.05.12.08.19.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 May 2025 08:19:16 -0700 (PDT)
Message-ID: <945f9653-f5b2-479c-92c5-396f0d0e8b26@baylibre.com>
Date: Mon, 12 May 2025 10:19:14 -0500
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 7/7] clk: clk-axi-clkgen: fix coding style issues
To: nuno.sa@analog.com, linux-clk@vger.kernel.org,
 linux-fpga@vger.kernel.org, dmaengine@vger.kernel.org,
 linux-hwmon@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-pwm@vger.kernel.org, linux-spi@vger.kernel.org
Cc: Stephen Boyd <sboyd@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Moritz Fischer
 <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>, Xu Yilun <yilun.xu@intel.com>,
 Tom Rix <trix@redhat.com>, Vinod Koul <vkoul@kernel.org>,
 Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Trevor Gamblin <tgamblin@baylibre.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 Mark Brown <broonie@kernel.org>, Mike Turquette <mturquette@linaro.org>
References: <20250512-dev-axi-clkgen-limits-v5-0-a86b9a368e05@analog.com>
 <20250512-dev-axi-clkgen-limits-v5-7-a86b9a368e05@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250512-dev-axi-clkgen-limits-v5-7-a86b9a368e05@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/12/25 9:46 AM, Nuno Sá via B4 Relay wrote:
> From: Nuno Sá <nuno.sa@analog.com>
> 
> This is just cosmetics and so no functional changes intended.
> 
> While at it, sort header in alphabetical order.
> 
> Signed-off-by: Nuno Sá <nuno.sa@analog.com>
> ---
>  drivers/clk/clk-axi-clkgen.c | 85 ++++++++++++++++++++++----------------------
>  1 file changed, 43 insertions(+), 42 deletions(-)
> 
> diff --git a/drivers/clk/clk-axi-clkgen.c b/drivers/clk/clk-axi-clkgen.c
> index 40ca03204010a15078f90935effbe58c4c3a00bf..a268d5ccf5798dd20cc1328369c2c9c45b37282a 100644
> --- a/drivers/clk/clk-axi-clkgen.c
> +++ b/drivers/clk/clk-axi-clkgen.c
> @@ -6,18 +6,18 @@
>   *  Author: Lars-Peter Clausen <lars@metafoo.de>
>   */
>  
> +#include <linux/adi-axi-common.h>

Could have just added this one here in the first place. :-)

>  #include <linux/bits.h>
> -#include <linux/platform_device.h>
>  #include <linux/clk.h>
>  #include <linux/clk-provider.h>
> -#include <linux/slab.h>
> +#include <linux/err.h>
>  #include <linux/io.h>
> -#include <linux/of.h>
>  #include <linux/module.h>
>  #include <linux/mod_devicetable.h>
> -#include <linux/err.h>
> -
> -#include <linux/adi-axi-common.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +#include <linux/types.h>
>  

