Return-Path: <linux-fpga+bounces-1186-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2DD1AA9A4E
	for <lists+linux-fpga@lfdr.de>; Mon,  5 May 2025 19:21:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5985617C281
	for <lists+linux-fpga@lfdr.de>; Mon,  5 May 2025 17:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1671C25C6EA;
	Mon,  5 May 2025 17:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Xt3gdcLq"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 333D0268FDB
	for <linux-fpga@vger.kernel.org>; Mon,  5 May 2025 17:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746465678; cv=none; b=KmPw9kPQkdqqUiBGsvLAY4IUxBfWCrd+63poqCwvaDw9KeUYYX6wqTDxpLt889m0kGAfc01yexwJMpReDzXvmNhGgwAfYtxPlhXL2hohbi8/TT/JrqEZZ2ClmE/WnXSNYaK/BP25ZA3FYBIrkEeACLEYZhSSdpcQ1HFAAUCHJeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746465678; c=relaxed/simple;
	bh=ED0YEr0axl5zx/4gKF6UrVnXHUt5MRwQZrtasEJIvN4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=roXJ5MaYGKPeq+dyb0AShOAVxd5XfzfSeYTY1F6tFy7TbhOrLlPSaDWwQA3wcIXeKYmISPRWd8dzxo7hZZzS+61xKWWXnlBrxClGE2VR6MdmAVf7hPSHO4Jcu5FiMFeVzFpqi3jFGYqGHFra65rZUUdPWxPBV5E+ZdDKe0cM278=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Xt3gdcLq; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-2c2504fa876so1610822fac.0
        for <linux-fpga@vger.kernel.org>; Mon, 05 May 2025 10:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1746465674; x=1747070474; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2/G+nBnNesW1TDGe9R775N3Td+u+vfQ6F72XRRWzOa0=;
        b=Xt3gdcLqIK0AP5dFYU2TLbBxeDa/TAnxULksakBJHQNQFLs3qzLgDwi8F+1XGo3NxX
         R0PV/p6yYWyZLddHxP5m/SA0kHOK4njge0WD981pdkho2Lx1jKGOpoL73cm+lbtj82Gm
         3Rusl09vLPBvdnkb6WzchcQoBtbMspHPINYFjoKxuP8WXqC7bPrJnT510vTYUXtrqXNv
         upgoncQerKPOWiMuZoGcpBEoEOImYdL5SVR3kLLl8hOv2VBQPhzazRnzSA6YvNo6EK88
         1ouyu0UxgmMH3ghd27VsZ+qMZJVqHgM/FnL4zhBEIpQRQmkm4tg39aouYyGNNpAdNE9q
         2KFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746465674; x=1747070474;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2/G+nBnNesW1TDGe9R775N3Td+u+vfQ6F72XRRWzOa0=;
        b=nfV/wKvJZGSB/RXrHotql+WQaLnbpu8SBRKBMSt6xG5/MsQtwS07pKx6DWSNqnx3G9
         B9MdnFCiMUJrca8Z6FGkXnnkUX7IhOzhReVrzIJsE7v8i+fnbaZsR+hZTghVnPLJfDUK
         pmK0yixIhE2obU2MjnJTnZjQuYq5tSLzyO8a/+2uqE3sct4lgr3JXHRmNvpoZPtOBzFt
         UL1UEaUreo+5hUxYVAAD6vtzX5gOeWi0o+KYqUFVqjPmQqhf9r5MxiEph0kSBEQ1lMzH
         Yn7BmE1A853Gkx9jt6ptT3ulsTJ9DVMxrbZVG84KnmAFk8FiN/LdUQDgRr9QedY+ExU2
         IdFA==
X-Forwarded-Encrypted: i=1; AJvYcCU8b1RXIt+TJYdufsfePLiTvObQytOARD41gHyigtotXEupR2MRDHF+rqThHBuTlCHV8sB68ez5nwh1@vger.kernel.org
X-Gm-Message-State: AOJu0YzdYFYUwopfR8OHxPv9FscuS8QMHRyMFptPaHbeiULeh4FPwNDn
	GJ7DAd1U0LQlkzFou46zXJ1JCZ2JuO1a90x4xTXy/dK62WnB81kGvjfxEmMah/Y=
X-Gm-Gg: ASbGnct4JZhz9qYI2T8m3QKK33WO+wUePmweSHPL1GqBukOB0TOK/QoJUn3XSlIiy/t
	UOv4p4V/BLXOEqx/NE8qbSRS8R8atLcOXfh3GrVNZUZBiyVu2p1BCjUQ0nOE+X98PA4LcUqEGW2
	e88WJZ1pjO716a2ZnXEoOOseGssm/bmskV4nYwvsJSC+98bi7A/uBPSDP1LLP8ohjYqBcplMIjC
	z11Pf3pmtKNDNxF03PODT42T2k3x3An3o6D/SmAGZ6RVVKZRtKlRBhBBUoA8mV73Sd4Ycz7DbY/
	Fp2/a0ugRb0BEY+X1lF6vJGyU1cN67920tgxSWSjmjY7uOn8LtpNHauC9i88ycAxTBbUo9nq9BI
	kl2mNWSxrrz3YnoE=
X-Google-Smtp-Source: AGHT+IE/IoVpJPAJ8LqGJDHQZ7X4gmy2K04E7oj2S0s4rKeDTv7fvaB2eoCocspZ2xh2Gh0s5XTIOQ==
X-Received: by 2002:a05:6870:91d3:b0:2d5:cb5:2193 with SMTP id 586e51a60fabf-2db391b23b2mr162206fac.35.1746465674086;
        Mon, 05 May 2025 10:21:14 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:2151:6806:9b7:545d? ([2600:8803:e7e4:1d00:2151:6806:9b7:545d])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-731d31a23c5sm1590259a34.8.2025.05.05.10.21.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 May 2025 10:21:13 -0700 (PDT)
Message-ID: <79c256ab-3d21-481c-ab9d-eca643d3d998@baylibre.com>
Date: Mon, 5 May 2025 12:21:12 -0500
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/7] include: fpga: adi-axi-common: add new helper
 macros
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
References: <20250505-dev-axi-clkgen-limits-v4-0-3ad5124e19e1@analog.com>
 <20250505-dev-axi-clkgen-limits-v4-4-3ad5124e19e1@analog.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <20250505-dev-axi-clkgen-limits-v4-4-3ad5124e19e1@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/5/25 11:41 AM, Nuno Sá via B4 Relay wrote:
> From: Nuno Sá <nuno.sa@analog.com>
> 
> Add new helper macros and enums to help identifying the platform and some
> characteristics of it at runtime.
> 
> Signed-off-by: Nuno Sá <nuno.sa@analog.com>
> ---
>  include/linux/adi-axi-common.h | 35 +++++++++++++++++++++++++++++++++++

Since this file was moved in the previous patch, should we drop "fpga:" from the
subject of this patch?

>  1 file changed, 35 insertions(+)
> 
> diff --git a/include/linux/adi-axi-common.h b/include/linux/adi-axi-common.h
> index 141ac3f251e6f256526812b9d55cd440a2a46e76..a832ef9b37473ca339a2a2ff8a4a5716d428fd29 100644
> --- a/include/linux/adi-axi-common.h
> +++ b/include/linux/adi-axi-common.h
> @@ -12,6 +12,8 @@
>  #define ADI_AXI_COMMON_H_
>  
>  #define ADI_AXI_REG_VERSION			0x0000
> +#define ADI_AXI_REG_FPGA_INFO			0x001C
> +#define ADI_AXI_REG_FPGA_VOLTAGE		0x0140

Doesn't the voltage register only apply to AXI CLKGEN and therefore would
belong in the clock driver rather than here? 0x1C seems to be the last of the
defined "common to all IP cores" address before we possibly get into
core-specific register definitions starting at 0x40.

I guess there are 1 or 2 other cores that define it at the same place, but it
still seems not-global.

>  
>  #define ADI_AXI_PCORE_VER(major, minor, patch)	\
>  	(((major) << 16) | ((minor) << 8) | (patch))
> @@ -20,4 +22,37 @@
>  #define ADI_AXI_PCORE_VER_MINOR(version)	(((version) >> 8) & 0xff)
>  #define ADI_AXI_PCORE_VER_PATCH(version)	((version) & 0xff)
>  
> +#define ADI_AXI_INFO_FPGA_TECH(info)            (((info) >> 24) & 0xff)
> +#define ADI_AXI_INFO_FPGA_FAMILY(info)          (((info) >> 16) & 0xff)
> +#define ADI_AXI_INFO_FPGA_SPEED_GRADE(info)     (((info) >> 8) & 0xff)

I guess we don't care about the DEV_PACKAGE field?

> +#define ADI_AXI_INFO_FPGA_VOLTAGE(val)          ((val) & 0xffff)

This VOLTAGE also goes applies to the first comment.


