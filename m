Return-Path: <linux-fpga+bounces-271-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3908850A0F
	for <lists+linux-fpga@lfdr.de>; Sun, 11 Feb 2024 16:40:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77E05281C4E
	for <lists+linux-fpga@lfdr.de>; Sun, 11 Feb 2024 15:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1982A5B693;
	Sun, 11 Feb 2024 15:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fMi9hPO9"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2265B673
	for <linux-fpga@vger.kernel.org>; Sun, 11 Feb 2024 15:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707666029; cv=none; b=mw2IJ5sUiZD6Wwv2yNEcxXsuYE2FdgdA5PV8CDjzQaOy+Q6WwJUyd9TnAFluDSobMFEZ5g1hpIVWbnj8CznUrWJBhHhqOUgqJbBlXhUxiF7krSwbzjo3isdJPYMRpTGDWHzLRcTrIZavhtmBz5F16wPSFag631MGMYCTELqtVv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707666029; c=relaxed/simple;
	bh=Hc9v4u7yTW8JsSZ99J2ZDRFE+upmV6PCfwAXPY/as/g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qttirprxdi80/EHnIlSdtkl6pert+JtAmauzK+NCktZUj/ojmnlIFQT178jEUNUX/K09M1ne8z1BEeeoNBuQ5G2BrByQQk8apX4da2XfJQ12n0Hgg7tvL+7kzumPhQtnckQIfdb2yfrMyWWshZMaygynM9mZ0q7Kg7zP9NRYXSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fMi9hPO9; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3392b045e0aso1643982f8f.2
        for <linux-fpga@vger.kernel.org>; Sun, 11 Feb 2024 07:40:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707666024; x=1708270824; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SVMew82xjwtf8k7+keXQc74rmr1ViKC0ozZEYJBxp7Y=;
        b=fMi9hPO92jPSbkZ9ui3twypsRtYA3QCkJKnT6++azajBDdmTqkbaRkNbxmp63at6uD
         RQGX1AXSXPGUGE2UdGygQx5iyru+h6pnUMQijSgyXoNC63vIUTDCysmw6facvvNgiYKW
         kZvxner7U175Qi4AT39bIlwNog1v7QT1AvQOrXWojtoYqgYgG1VPtNQMPHyT8T2i0qUa
         rAxmfKD8A3akQkbLrOvC/J3i8FLGmlq6atq2Lp+3QB7vs0X6d2VB/+zOAFVTypjq+g5x
         TXhUzEWSiaA296IkWcSZ67ZnIkXw8zEMcO13qLIDl/oeJhonB0OrJXkPkwlV0PlVreux
         a2Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707666024; x=1708270824;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SVMew82xjwtf8k7+keXQc74rmr1ViKC0ozZEYJBxp7Y=;
        b=W1z0mE0P/MaaguOUwubfVg3GGy4+JCCQt7fGoGIp0R0BPk4kVUQBkryjEqiTWyjFxH
         aDichOxCuMnpw5x4wpnm/bopeD64LvoARSR+hVYKr3Of/rbUz/MtpwwPvaFxx91FOPX8
         iNZClfhILqWuJ5noppXUyfe+F11lR+Rk9I7p8yEmSehpfe3y9uzreR6daS1bQpiMKt0u
         QNox+2A8DW69pmbgZyRH3aXz11zG125ruCjCJj4AS+tZzsuLZN5WUPL41x4VhsYIxBkl
         FnSOcVgo7WdBXMAtLfliGWUixS5F+yjsRht6VUJGZct8EuMpSSCEckm0d5f+Bwsq27gJ
         UfMw==
X-Forwarded-Encrypted: i=1; AJvYcCWU5Ep/IAn1gFszSK68FBKGwbiyrt8iqqxX+eYnwmVM0n0kVNtv9Z86WPO/7+Q3nAjYuZNkC7wUCGOP6/0WBhIlwood3G4Uff/pPQ==
X-Gm-Message-State: AOJu0YyERWVeQHGZJsDjSQKD55SPM8vt9YepkIiRq0BZ9BOn9v6bJk+c
	uipAxpF/RUz07vqw2qGEffkONryi6awjwPFYwvOeuhmGSAorqX68sLP99+5ClyI=
X-Google-Smtp-Source: AGHT+IE7cGSNkeRSRwvwSCCrTJU9J282tJla6a4fbIRSaC0WQ1E4dlqgzx4CI8BUziOjmGHvNnhJyQ==
X-Received: by 2002:a5d:6486:0:b0:33b:2300:9cdc with SMTP id o6-20020a5d6486000000b0033b23009cdcmr4887054wri.46.1707666024531;
        Sun, 11 Feb 2024 07:40:24 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXb4IEphRUiAkPg6ucJR6ptA44EPq3L6qDXC4hgjAqX/Hy7oNo/AxozPoT182mYxhVjpk8p5fCKSpvbokimI9rSQnIQSvj8bxo2JybXVZK+MtHRtQPhQ2AfGxL7dRF6fvarfBFjSQ8wqLe2JuGXtmQ16miKyckw3KlnVccg3mZ7uVpaun/VMt0TXNrGQwO/5ezVHj1UXSA9IUJgBQxtfmyP+IHSZIcN6d1zV/iIoCihaA2UlfwPO0LrIzmZ1E27pgS5BkP4jdh3h7uJdfBirJspYPYQXTyxNWYTE/ApjSh3H/C2qUD2f7T4L0/bNsnsEBNYycirC+zN5C8kPd3m/ZekpZaz6HiBORMSAbWtAomuec8KnmSKf0WF2eM6oiz98tGp0uMgOeFvAWuEg3V7/ITbALupm4IbuVx8INery+0dvgapC4zfFg3Hvc6vs3fr7vOPx+ZGSWakajErDxTQjgBuO10mDwXT05gp0btzOkD9QhJcvdUy/aESGmK+TOTuYehdjmXlJCRa
Received: from [192.168.1.20] ([178.197.223.6])
        by smtp.gmail.com with ESMTPSA id n12-20020a05600c500c00b004109a5ccd7fsm3885151wmr.47.2024.02.11.07.40.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Feb 2024 07:40:24 -0800 (PST)
Message-ID: <5d1d4bd7-a431-457d-b7f8-141bb609284b@linaro.org>
Date: Sun, 11 Feb 2024 16:40:22 +0100
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/5] fpga: xilinx-core: rename "prog_b" and "init-b"
 gpios
Content-Language: en-US
To: Charles Perry <charles.perry@savoirfairelinux.com>, mdf@kernel.org
Cc: avandiver@markem-imaje.com, bcody@markem-imaje.com,
 Wu Hao <hao.wu@intel.com>, Xu Yilun <yilun.xu@intel.com>,
 Tom Rix <trix@redhat.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Michal Simek <michal.simek@amd.com>,
 kishore Manne <nava.kishore.manne@amd.com>, linux-fpga@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20240207180142.79625-1-charles.perry@savoirfairelinux.com>
 <20240207180142.79625-4-charles.perry@savoirfairelinux.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240207180142.79625-4-charles.perry@savoirfairelinux.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 07/02/2024 19:01, Charles Perry wrote:
> New bindings use "prog" and "init". The legacy name is used as a
> fallback.
> 
> Signed-off-by: Charles Perry <charles.perry@savoirfairelinux.com>
> ---
>  drivers/fpga/xilinx-core.c | 28 ++++++++++++++++++++++++++--
>  1 file changed, 26 insertions(+), 2 deletions(-)
> 

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


