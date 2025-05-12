Return-Path: <linux-fpga+bounces-1208-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD086AB3BBF
	for <lists+linux-fpga@lfdr.de>; Mon, 12 May 2025 17:15:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FF973B40C4
	for <lists+linux-fpga@lfdr.de>; Mon, 12 May 2025 15:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB24A22A1C0;
	Mon, 12 May 2025 15:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="NPkMYGdq"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F0981720
	for <linux-fpga@vger.kernel.org>; Mon, 12 May 2025 15:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747062945; cv=none; b=eny6zKP4hlSnD5w9NpUeT2RKWlvHMfYiAUQynysZ4EBsTe42tZ5JhqM+Ld1Vqp3B0FlHpYrfXMNtGrkN4F5nVBHnqlLyuEWtfBwhL7we3QjSh77v1IaW7YRDUoIFWf9PP9qySmRpHPtUiGKIK43DI7cfOtmM9pAQTKvrjlKrj7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747062945; c=relaxed/simple;
	bh=zF4PQS8RQFM30N3ao4kEuN2RsoQHNBfVK/8QGFaitO8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IF4ELBE2mvZrtT5yXXBAESklrYqAW4kMbtvXtme9Oj16G6LbpDXfmxSU8OYoUElVelf2UkENucl55qRroRP0QR5HcvH7a+QEyuNeM9miKmD42fLxBPtV91wtNW06odr5zofh8Ug9CsFNp5YdquwlzbXTEVEmUF0FMMD75iuKIF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=NPkMYGdq; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-30a8c9906e5so5811756a91.1
        for <linux-fpga@vger.kernel.org>; Mon, 12 May 2025 08:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1747062943; x=1747667743; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d0n+Mfncf1dF7UbdvMh/Y3Vkt6ppEmOAhKQI7/Xctfs=;
        b=NPkMYGdqygEadNa9LBxCCsLaDWqp4GRfS8Ph/xx/qGxOGPd6hDtfGyacyAIcTs026J
         XJSoBBNAt5MhW+Ef40nJeLNLyYIq0IPafG8V/XqKhS7RAQUdxaQ7ZDj29uzdzT8esr4Y
         QfdsgqR63ugM64JgjPrM/r0nO3DgiRIhFkE6OcwINl9E10F2f+9iN9bN9dz2axCXfs7t
         Rgd9WAV1o/WeEORfTBRaCAMoC1DOhD+cZUcSGhwXhg5izye20HxjlROwGjLgGYOkAlCy
         C5S2GJWp/HDi0W5vvyT+FAAjmnOPikPwo+VfsbGnWY73IoV43GXQVQqNaNDRWSumS2Ff
         Bxcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747062943; x=1747667743;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d0n+Mfncf1dF7UbdvMh/Y3Vkt6ppEmOAhKQI7/Xctfs=;
        b=aYVFWDX1VLipRLwgoRKWBtyxmqpgmAndn0XfgKKgayNhSlfw77WZGGNt/UgB04N7So
         NPAfuCzRfBYRb776pToRzvgB9Fx6bUrr082k+DjE+qio9RzzjoWWTtT3Zap3HiTxrfFC
         4iKtXXkB0WYJO3BKJ4M1fPQdzhfjeajckMGOkAdyIAPGclAIBuw0Gk1KlSrXxV2903j8
         qsFZfyqHfSxh7JwhdwhQxJ2txlWF/R04viMgfJ0nF51kCkQF8j8hy+CS9w3QHcpWi0dp
         yMkkUfWdroT4QfpkFadolnD/hHO1bUB1UsQ7LF1evVwpood00iyaj4NJPtj2g5Fzns2L
         wf6w==
X-Forwarded-Encrypted: i=1; AJvYcCXwxT8QkJcHOTqikyetd4+6w+mPwHtOCF+ruMAQm70in9O7FcZbiWirf2bufHD1rXPanlTaa2QQcSXj@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6s7o+yy052oPesbyVF5tcUjfLYdDd12E8+1H4rEouweqdoiOC
	v+IUvHBIjImHM/Bp6x7T9Pnn1Ob+9WlogWzunVqmFkkxOYkzNJNa54WmcgDq6pXM/ZlqTf0zDDh
	k
X-Gm-Gg: ASbGncsubLn2Htm6Z7bzhg3/koDm52Xc+8ForoICluMNzNJHRHxwEQnq53UXIfSrrKN
	7xGXxUl0kL28iLK3/b4X7SFZafpQWXa1ub80bhVGu0YUIdGs8FO9Y18mlJA2QJF+EZTTg/NjRJu
	KiP6yqG2IDlhuuh5+V+HPxek8gFLRVVZ2rAo7WFHGFVlmWrkLvyvom0o/UE+XBk0dOkDzLQsCbB
	yGZtyBXMrsOWKCF8ppzp+xQLNO1VFZKXctvvuu2KtL17ErJwYzWtrSbY45aAUfpPhUur63CMbYW
	KZYPLaZ2bZk1657RzCrWrhXUe3+sdiSjKuErakx5QGNLppAd1IiIYHvUL2Sd0ozRR4aNJK0jYgU
	KAEpCU3h3UPbBL6ZY1j3DSnwKA1mL
X-Google-Smtp-Source: AGHT+IHZGDRNs+8vOMkC0p04fQzG/ssmfSh7XZKqv3ixjm0TN3TuT3LuzzKvBaCQb7HZ2b2RSV9r0w==
X-Received: by 2002:a05:6808:1582:b0:400:fa6b:dc93 with SMTP id 5614622812f47-4037fec216emr8370575b6e.39.1747062932740;
        Mon, 12 May 2025 08:15:32 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:fd2e:ffda:4c42:b314? ([2600:8803:e7e4:1d00:fd2e:ffda:4c42:b314])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-403802d369fsm1565218b6e.17.2025.05.12.08.15.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 May 2025 08:15:31 -0700 (PDT)
Message-ID: <44929bd2-4abf-4c7b-b3c0-382bd030800f@baylibre.com>
Date: Mon, 12 May 2025 10:15:29 -0500
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/7] include: linux: move adi-axi-common.h out of fpga
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
 Mark Brown <broonie@kernel.org>, Mike Turquette <mturquette@linaro.org>,
 Xu Yilun <yilun.xu@linux.intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20250512-dev-axi-clkgen-limits-v5-0-a86b9a368e05@analog.com>
 <20250512-dev-axi-clkgen-limits-v5-3-a86b9a368e05@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250512-dev-axi-clkgen-limits-v5-3-a86b9a368e05@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/12/25 9:46 AM, Nuno Sá via B4 Relay wrote:
> From: Nuno Sá <nuno.sa@analog.com>
> 
> The adi-axi-common.h header has some common defines used in various ADI
> IPs. However they are not specific for any fpga manager so it's
> questionable for the header to live under include/linux/fpga. Hence
> let's just move one directory up and update all users.
> 
> Suggested-by: Xu Yilun <yilun.xu@linux.intel.com>
> Acked-by: Xu Yilun <yilun.xu@intel.com>
> Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com> # for IIO
> Signed-off-by: Nuno Sá <nuno.sa@analog.com>
> ---
>  drivers/clk/clk-axi-clkgen.c              | 2 ++
>  drivers/dma/dma-axi-dmac.c                | 2 +-
>  drivers/hwmon/axi-fan-control.c           | 2 +-
>  drivers/iio/adc/adi-axi-adc.c             | 3 +--
>  drivers/iio/dac/adi-axi-dac.c             | 2 +-
>  drivers/pwm/pwm-axi-pwmgen.c              | 2 +-
>  drivers/spi/spi-axi-spi-engine.c          | 2 +-
>  include/linux/{fpga => }/adi-axi-common.h | 0
>  8 files changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/clk/clk-axi-clkgen.c b/drivers/clk/clk-axi-clkgen.c
> index 2a95f9b220234a1245024a821c50e1eb9c104ac9..31915f8f5565f2ef5d17c0b4a0c91a648005b3e6 100644
> --- a/drivers/clk/clk-axi-clkgen.c
> +++ b/drivers/clk/clk-axi-clkgen.c
> @@ -16,6 +16,8 @@
>  #include <linux/mod_devicetable.h>
>  #include <linux/err.h>
>  
> +#include <linux/adi-axi-common.h>
> +

This one is adding, not changing. Was it supposed to be in a later patch?

>  #define AXI_CLKGEN_V2_REG_RESET		0x40
>  #define AXI_CLKGEN_V2_REG_CLKSEL	0x44
>  #define AXI_CLKGEN_V2_REG_DRP_CNTRL	0x70

