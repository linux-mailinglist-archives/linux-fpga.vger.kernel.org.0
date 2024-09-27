Return-Path: <linux-fpga+bounces-742-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9188B988716
	for <lists+linux-fpga@lfdr.de>; Fri, 27 Sep 2024 16:26:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3A481C20B05
	for <lists+linux-fpga@lfdr.de>; Fri, 27 Sep 2024 14:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CFB6763F8;
	Fri, 27 Sep 2024 14:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X1ZQma4i"
X-Original-To: linux-fpga@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0FB918B1A;
	Fri, 27 Sep 2024 14:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727447179; cv=none; b=Oa/BxLChxEUlRoGq6ALumEZQfsd4jWxjt4nfksQcegz38AfSKE06Wi3UgfbG2MXnfyLqBFlY7Q55FMhyrFf4pJZXpaYRAkyN5oKuAdRUyHBCvu4dlwGRAuZxeCSl2F9YUGGgoFWF43SRZ5nuKQSk6KZjYopTv86oQyKaVNfk/gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727447179; c=relaxed/simple;
	bh=rWNx8G6u4wjPkAWMYzAUZrCuVOjtknEM26E8OkXCZGQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=C/YxWWMqtBBT4zk8iv5nLdU8kz+tgSKMV+TbxEKk3VgQbt7RoUx00/GxeJXKNx4W19FrsiOQEOTiuIE3BwsyrVby89B3jZKgvDSCFcKu7716Wh1lUnePa24AGMiGmmLsg+vLhlxY9DzcQNXLwAJ3F090tgxb1vLCC3m24xaOImI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X1ZQma4i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7F54C4CEC6;
	Fri, 27 Sep 2024 14:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727447178;
	bh=rWNx8G6u4wjPkAWMYzAUZrCuVOjtknEM26E8OkXCZGQ=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=X1ZQma4iONGSerivD0KqONYPChTg6SHZ3kKK8DuL9B65UM0pE4kjk/5X35eQEZiKp
	 skllGtfQuFRxIzGWemVbo20mTKsImfA5f080Kzpwz9e3IB7rwRH9WcZFH1VGyg804N
	 PCe4No9kYSpjymD50GMst/dq6szWNQyk6HujZV+9SDpEEVLFszjOkuiC8co0Kyl5fm
	 88aOdqvzZjTRLJ27QenKGLOBC3P4Od6SSFGu1HYVqf/gv+Ozf3aVROGlRBgEqJpEjg
	 EbCtetxJS/8/78JknLYY5M+/LGUvQHJIKanSQX1/ulEm1LGGqBkHSaLprcRkaD7w4C
	 itE08vTMyw2GQ==
Message-ID: <dd9ae106-3c39-423b-9413-5a7ca57f7aec@kernel.org>
Date: Fri, 27 Sep 2024 16:26:11 +0200
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] dt-bindings: fpga: Add Efinix serial SPI programming
 bindings
To: iansdannapel@gmail.com, mdf@kernel.org, hao.wu@intel.com,
 yilun.xu@intel.com, trix@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, neil.armstrong@linaro.org, heiko.stuebner@cherry.de,
 rafal@milecki.pl, linus.walleij@linaro.org, linux-fpga@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240927141445.157234-1-iansdannapel@gmail.com>
 <20240927141445.157234-2-iansdannapel@gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20240927141445.157234-2-iansdannapel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 27/09/2024 16:14, iansdannapel@gmail.com wrote:
> From: Ian Dannapel <iansdannapel@gmail.com>
> 
> Add device tree binding documentation for configuring Efinix FPGA
> using serial SPI passive programming mode.
> 
> Signed-off-by: Ian Dannapel <iansdannapel@gmail.com>
> ---
>  .../fpga/efinix,trion-spi-passive.yaml        | 85 +++++++++++++++++++
>  1 file changed, 85 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/fpga/efinix,trion-spi-passive.yaml
> 
> diff --git a/Documentation/devicetree/bindings/fpga/efinix,trion-spi-passive.yaml b/Documentation/devicetree/bindings/fpga/efinix,trion-spi-passive.yaml
> new file mode 100644
> index 000000000000..ec6697fa6f44
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/fpga/efinix,trion-spi-passive.yaml
> @@ -0,0 +1,85 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/fpga/efinix,trion-spi-passive.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Efinix SPI FPGA Manager
> +
> +maintainers:
> +  - Ian Dannapel <iansdannapel@gmail.com>
> +
> +description: |
> +  Efinix Trion and Titanium Series FPGAs support a method of loading the
> +  bitstream over what is referred to as "SPI Passive Programming".
> +  Only serial (1x bus width) is supported, setting the programming mode
> +  is not in the scope the this manager and must be done elsewhere.
> +
> +  Warning: The slave serial link is not technically SPI and therefore it is
> +  not recommended to have other devices on the same bus since it might
> +  interfere or be interfered by other transmissions.
> +
> +  References:
> +  - https://www.efinixinc.com/docs/an033-configuring-titanium-fpgas-v2.6.pdf
> +  - https://www.efinixinc.com/docs/an006-configuring-trion-fpgas-v6.0.pdf
> +
> +allOf:
> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - efinix,trion-spi-passive
> +      - efinix,titanium-spi-passive

1. Your driver suggests these are compatible, so make them compatible
with using fallback.

2. What is "spi-passive"? Compatible is supposed to be the name of the
device, so I assume this is "trion"? Can trion be anything else than fpga?

> +
> +  spi-cpha: true
> +
> +  spi-cpol: true
> +
> +  spi-max-frequency:
> +    maximum: 25000000
> +
> +  reg:
> +    maxItems: 1
> +
> +  creset-gpios:

reset-gpios

Do not invent own properties.

> +    description:
> +      reset and re-configuration trigger pin (low active)
> +    maxItems: 1
> +
> +  cs-gpios:
> +    description:
> +      chip-select pin (low active)

Eee? That's a property of controller, not child. Aren't you duplicating
existing controller property?

> +    maxItems: 1
> +
> +  cdone-gpios:
> +    description:
> +      optional configuration done status pin (high active)
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - creset-gpios
> +  - cs-gpios
> +
> +additionalProperties: false

unevaluatedProperties instead

> +



Best regards,
Krzysztof


