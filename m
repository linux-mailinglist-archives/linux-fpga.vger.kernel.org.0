Return-Path: <linux-fpga+bounces-332-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 781D887B838
	for <lists+linux-fpga@lfdr.de>; Thu, 14 Mar 2024 08:03:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 093E8283DFF
	for <lists+linux-fpga@lfdr.de>; Thu, 14 Mar 2024 07:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A00DDF59;
	Thu, 14 Mar 2024 07:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S6Nt9uBw"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB45A5664
	for <linux-fpga@vger.kernel.org>; Thu, 14 Mar 2024 07:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710399775; cv=none; b=P/zQzU2Ud2GfFvfIulPCT/Kcb8roJ6MG9dgpfSeAiIxjfzmVcrlVOutdsKOyhj1km4QhvEL5tu5envFyDhb/43h/79B0qMQQ9O3bycoXJlageMei0aTdlTTBfeCOvaGOdzo7h2oCs18cfG7tSAsSRUI1r6aBF/Midio7dAv2e9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710399775; c=relaxed/simple;
	bh=gltKRNHkGYhjnfPA1nbl8ExWD565N0Jl+xIBswKees4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fc9GQC4K+iZYND67KasXVuRrsTLUo1D0BzuuVmwUhr8/oPVIfLy2h77DUG924IbC6zqBnKgrdlq5xYJSLkGRNtOoWAq6jzOQuA/shFA2TSPSBGO7CsYFH+sj/9y+e7uKof8rSTK8S9ECYRFP5QjKIAaAtuZIrgRoD2s/mEkor08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=S6Nt9uBw; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-33e8e9a4edaso699632f8f.2
        for <linux-fpga@vger.kernel.org>; Thu, 14 Mar 2024 00:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710399771; x=1711004571; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0urfCLsc7Z4YHkUv8RROpJvzN1pyQGtClFTbqTjWmMM=;
        b=S6Nt9uBw1hosm5vpZF17YyPbguPNOccD4eshJdHRvyuu/hteMQw/rGuv2p9VRFyxqZ
         a6hbyRv5Z58EJ207A6KVT0mxRmH9AG4PfZNxKo2MWGNWRTM3yX77sB/eAjh+IIF2+OkN
         mJEsmHolxHJnrraqhGC72zb27RTdGrwk6zx8P34UEwLMeGIgEuYOocJ56IEO35nv2pkV
         hCsvdgkxPCxSmoLPGOhKXRHVo3FTav1Iq2qQ0Ph4f4FcK7hvQ62PZKwMhA1CnEiIJBUa
         OVZiro+O7TclAssvK4SaX8z0f17i988OZSFLk5AP9sd78MmqMGU3tdV/baRgmR74Lbe6
         BKqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710399771; x=1711004571;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0urfCLsc7Z4YHkUv8RROpJvzN1pyQGtClFTbqTjWmMM=;
        b=KSV4MOKZ6xObfQNedjWkI16QYJZPOKfEvcUkcukNjmxabVJq0OQ1m5oAvBLA0NBB4e
         KfpXY7H+0Ok6sNVwWFw1L9dv93JsCEVBpaAYM592JxHt/1gX4VIML/ZwE0N4Fs8MF4C3
         wsPsVgt3ZowGUie56P0Ce2toovYQnURd8XYAHyOfQXms5T8kKMssE1V0jwAoU5rgMDyJ
         iO5Y+9A0TP2+8vf1L6Kbj+kUiF+2vDQkE06EGpno4VHK5DUFuNG456MpMWR4xfwG1Syc
         olNOR4QLldBO257lqf7q2M/oA2b0S9ll0Cwdt7WRQfq2EVXNUW/udjPVBZ+o83XG7jyX
         JbzQ==
X-Forwarded-Encrypted: i=1; AJvYcCV9VvJ5WNMoBQiNJ5y4loi6Tv+RCshexpd2As8oJxHkC1Cp80Y2aq3dIF+1I7idAxb+cT1UQ59uoBEGiGsBuO9orx3GGrVxx9fZbw==
X-Gm-Message-State: AOJu0YzF7nU9xa1QbHNG4sTCeySwhXfo0aYwK9Fa7hdrJv4jK5V6lZ3n
	fHdyXLUhxcp/SVixPN1Tvqe0y6WQtFrbizNNFG2WuIrmgh6u572ZZyYm2BnjBJY=
X-Google-Smtp-Source: AGHT+IF8/NyD2OqhndZPqt6vi3pgpH6Zn/atEOSYCSM1zN5o8jFxuOk2VY157837mDGAdIgozI/gbw==
X-Received: by 2002:a5d:68cc:0:b0:33e:6efa:757e with SMTP id p12-20020a5d68cc000000b0033e6efa757emr645561wrw.22.1710399771304;
        Thu, 14 Mar 2024 00:02:51 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id v29-20020adfa1dd000000b0033ec3c2e410sm15902wrv.23.2024.03.14.00.02.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Mar 2024 00:02:50 -0700 (PDT)
Message-ID: <59ba59f4-a1ab-4959-bf52-a7dca795536f@linaro.org>
Date: Thu, 14 Mar 2024 08:02:49 +0100
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/3] dt-bindings: fpga: xlnx,fpga-selectmap: add DT
 schema
Content-Language: en-US
To: Charles Perry <charles.perry@savoirfairelinux.com>, mdf@kernel.org
Cc: avandiver@markem-imaje.com, bcody@markem-imaje.com,
 Wu Hao <hao.wu@intel.com>, Xu Yilun <yilun.xu@intel.com>,
 Tom Rix <trix@redhat.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Michal Simek <michal.simek@amd.com>,
 linux-fpga@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20240313225746.489253-1-charles.perry@savoirfairelinux.com>
 <20240313225746.489253-3-charles.perry@savoirfairelinux.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240313225746.489253-3-charles.perry@savoirfairelinux.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 13/03/2024 23:57, Charles Perry wrote:
> Document the SelectMAP interface of Xilinx 7 series FPGA.
> 
> Signed-off-by: Charles Perry <charles.perry@savoirfairelinux.com>
> ---
> Changes since v4: (from Yilun and Krzysztof review)


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


