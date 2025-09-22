Return-Path: <linux-fpga+bounces-1366-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90F05B93797
	for <lists+linux-fpga@lfdr.de>; Tue, 23 Sep 2025 00:22:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CCE73A78AA
	for <lists+linux-fpga@lfdr.de>; Mon, 22 Sep 2025 22:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDC0C2D77E2;
	Mon, 22 Sep 2025 22:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="YZkVO44L"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1BF525D540
	for <linux-fpga@vger.kernel.org>; Mon, 22 Sep 2025 22:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758579717; cv=none; b=JjMlA+NrLpgzyyJanF9G6mUSj+sEaapnNOYfqx8xYIYp1jF4XmQWk7KXRQFijTfnfJKuJhDDiaBRag31dQN+8H2vTYlV2660RCvKcJGFeuVuHg7vZf5wwEgwwWNMm9JYYVdLFr/+xw3qsnN8DoTdH9pI0r9kIp+g020ON9iZd3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758579717; c=relaxed/simple;
	bh=5oqT/+EskjT95UQ02iVrfraL+q6+UfPBzDvXMw+0rI4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cqluzpOmLzimWYRr5XNd/ogrjVzvcTGZRZFIb4R++LGuUmaDGY38VnwbSvpo2CfVGTnpYSA65C1e/8KTkptehF1T504hL9HZFmBx+ptFDqaVvGIowwAXllgauu7TB5/lyibAAaMSZkEYtLN1ggO+OPDtQw1S3jR/4c2QjExIgv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=YZkVO44L; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-786e9b51248so475364a34.0
        for <linux-fpga@vger.kernel.org>; Mon, 22 Sep 2025 15:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1758579715; x=1759184515; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DTLhvXVhX7GssWdco0zg+2qQigdBymvGbS2zk9aZ/b4=;
        b=YZkVO44LUNY3vxt7kxWyDXeNqzyuR++Rz818D7Si+mbLdRujhscDfTcJzV+TqsPESd
         2cP7Ix3AvbcWkWPDbnFJ07ZKzmLi/Io5PX+14qJM7gJ/L5EtVqOBF5nrN2gF8urJs9Sw
         NnRA5Yb4vRvEd0C43wdbp2udt7YSKl7WZ3KzPNx6JViGUOhsKJCIRGLuQJHAHoELtC9l
         3+5M5tt98zdj/R0mRkSNU+3RHAI4eh2hSs6Ue2ANQiEnxyGkDMjT06If4TnfbtV/hlFy
         HcvKk6P6HmuA91N9vmGDEtsy6P/TrCK1g1MUPuEVLZrdHmLHslSFPhdcwaCnaFiBWHkg
         xMPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758579715; x=1759184515;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DTLhvXVhX7GssWdco0zg+2qQigdBymvGbS2zk9aZ/b4=;
        b=pxNzuu4gxJNloYBbKHB4qwOyxQ/y8pB7yPUHDnp2ezeN61RTexW97Ld+RkDk8h33p7
         RuFnG0AT8SpcIPxWo8fSj6qZkNYPqO0M8eYP2n20ZjnL0ePHhZ2U4rSkMGUvDlvDXUA+
         ohxOHjL/K+kuorlASkaCrJGYDa4nyYt278rEYDYPSlQoaFgbzXBRMvdFMJgEV1tWUxwy
         verbKcAs9Nzomnld1t6sSfeWLdDDkbYAg/0agSimB3iKN6aJiEldHczWazWbMSHvGFJE
         89rS0/lLI3NFfyNLxDqOTwu8pzGvG/f0mJlIRid96U87kLmz7GhMQfnxrwFeKIOJabTt
         5SXw==
X-Forwarded-Encrypted: i=1; AJvYcCVUIr3vQFTUpn6KnJ5ebH1NeJpu7s17pYfBa68qoIkCcwvFKaCNywTNgMVsKgpchBQbW3yYriYzsdy6@vger.kernel.org
X-Gm-Message-State: AOJu0YxuoG7Yi1G26vB37mAkyqTA84Bd9XUdK14gXR0OaJY5PJ68FeLR
	X0v4H/ec1MX/cvyn/7CYC/9KZn1ZX/5sGZ03otiU1uofKMvEiITm/b/c0PGsEqTYsTk=
X-Gm-Gg: ASbGncttzjTXiTqHyZtjM/C1mP3e9Fdtxt30D+8LRr6qlbd0eQHrgs3uWqyWyySuH8K
	fGbkCmJWM5PHdFTyaf6i0m/P8ren+lpyrqoqbncIrk+PPpe7Lr9B3dCgZTNoRRbcyzcaIlARVRd
	j9h5/cLWbLgC7h7WSCRN0rkXtT4VlmwaPE42muV7sLOtO41HUQrH1XIX9AUspRFKh5ttsFlS4mD
	vvfEKu+ZXYCZyDdB3mPTizQ0pg7/LOg1ur8IWH0xoxSibj3NOdh7z3eCQ+MeR1+QeqgNBG6B08p
	+yzKNZEYX5qlg7pxWTsuRe4gU6RjamEHdIWCyXoAfJTE9RgNwkEqSDgnbwY9ZL/ly9Y2OhPCL56
	A/1UntgqGopVKheXnDUUtIRdEA/0Svmrp0m7DO0P24ERgFv7Ynm8ZQhNXHcPY6aoo9gMoRK4oqB
	TM3yIzyKMESQ==
X-Google-Smtp-Source: AGHT+IHIwhkhaTyaeI4QExDUkUooOZb2rugZFLrr3rg3bIJULREQlPjANVdD95uXqhOHKDLwlVrzPw==
X-Received: by 2002:a05:6830:3891:b0:78e:fd71:8e02 with SMTP id 46e09a7af769-79157d59395mr176216a34.25.1758579714829;
        Mon, 22 Sep 2025 15:21:54 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:505f:96cd:1359:fff4? ([2600:8803:e7e4:1d00:505f:96cd:1359:fff4])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-625d881ffd9sm4392310eaf.3.2025.09.22.15.21.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Sep 2025 15:21:54 -0700 (PDT)
Message-ID: <d1778ced-1660-424c-97eb-72a35152f13f@baylibre.com>
Date: Mon, 22 Sep 2025 17:21:52 -0500
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v7 0/7] clk: clk-axi-clkgen: improvements and some
 fixes
To: Stephen Boyd <sboyd@kernel.org>,
 =?UTF-8?Q?Nuno_S=C3=A1_via_B4_Relay?=
 <devnull+nuno.sa.analog.com@kernel.org>, dmaengine@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-fpga@vger.kernel.org,
 linux-hwmon@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-pwm@vger.kernel.org, linux-spi@vger.kernel.org, nuno.sa@analog.com
Cc: Michael Turquette <mturquette@baylibre.com>,
 Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
 Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
 Vinod Koul <vkoul@kernel.org>, Jean Delvare <jdelvare@suse.com>,
 Guenter Roeck <linux@roeck-us.net>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Trevor Gamblin <tgamblin@baylibre.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 Mark Brown <broonie@kernel.org>, Mike Turquette <mturquette@linaro.org>,
 Xu Yilun <yilun.xu@linux.intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20250627-dev-axi-clkgen-limits-v7-0-e4f3b1f76189@analog.com>
 <175847570323.4354.7019519707280531872@lazor>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <175847570323.4354.7019519707280531872@lazor>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/21/25 12:28 PM, Stephen Boyd wrote:
> Quoting Nuno Sá via B4 Relay (2025-06-27 07:59:09)
>> This series starts with a small fix and then a bunch of small
>> improvements. The main change though is to allow detecting of
>> struct axi_clkgen_limits during probe().
>> ---
>> Changes in v7:
>>  - Just include new tags.
>>
>> - Link to v6: https://lore.kernel.org/r/20250519-dev-axi-clkgen-limits-v6-0-bc4b3b61d1d4@analog.com
>> - Link to v5: https://lore.kernel.org/r/20250512-dev-axi-clkgen-limits-v5-0-a86b9a368e05@analog.com
>> - Link to v4: https://lore.kernel.org/r/20250505-dev-axi-clkgen-limits-v4-0-3ad5124e19e1@analog.com
>> - Link to v3: https://lore.kernel.org/r/20250421-dev-axi-clkgen-limits-v3-0-4203b4fed2c9@analog.com
>> - Link to v2: https://lore.kernel.org/r/20250313-dev-axi-clkgen-limits-v2-0-173ae2ad6311@analog.com
>> - Link to v1: https://lore.kernel.org/r/20250219-dev-axi-clkgen-limits-v1-0-26f7ef14cd9c@analog.com
>>
>> ---
>> Nuno Sá (7):
>>       clk: clk-axi-clkgen: fix fpfd_max frequency for zynq
>>       clk: clk-axi-clkgen: make sure to include mod_devicetable.h
>>       include: linux: move adi-axi-common.h out of fpga
>>       include: adi-axi-common: add new helper macros
>>       clk: clk-axi-clkgen: detect axi_clkgen_limits at runtime
>>       clk: clk-axi-clkgen move to min/max()
>>       clk: clk-axi-clkgen: fix coding style issues
> 
> What is the merge strategy for this series?
> 
FYI, v6 of this series was pick up and merged in v6.17-rc1.
So I don't think there is anything else to do here.

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/log/drivers/clk/clk-axi-clkgen.c

