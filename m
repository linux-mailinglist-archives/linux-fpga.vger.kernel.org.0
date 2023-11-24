Return-Path: <linux-fpga+bounces-43-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D1E27F781E
	for <lists+linux-fpga@lfdr.de>; Fri, 24 Nov 2023 16:49:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E14C1C20E3B
	for <lists+linux-fpga@lfdr.de>; Fri, 24 Nov 2023 15:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 201C63173C;
	Fri, 24 Nov 2023 15:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Lgvtqm2v"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93E1119A2
	for <linux-fpga@vger.kernel.org>; Fri, 24 Nov 2023 07:49:11 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-544455a4b56so2793520a12.1
        for <linux-fpga@vger.kernel.org>; Fri, 24 Nov 2023 07:49:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700840950; x=1701445750; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0K2EXE8gQExfH+IDrBMFiSFCOrHiT67rlvW6OkLmIQc=;
        b=Lgvtqm2vdgbIyRYi0mXRPmujODsHOI9R0lt5uWHM6uqaH29oavWLw4gR6gFvif/kKk
         SEPwKtQnhasHtEuxUDbptLOk51p9CUY9JJNV5m+criervnkUV/l8Bg+uqriNSbukuL6g
         f0k15OIUzJpyHf4ItUHLlgaUOuvDlDFom6eKx1XdjF/3Wt7K89g74KA0VmlVbHgKQ6Lw
         YYr9Okc+9VLLQJ/tJNK9MAqOSQwDZRz5w7+NFONf6+hRAogY5TuWHqCaB1u/ucHF9LYs
         o1Fh/0Z4+DfUcw7jcY+3O27fpZSjU3vBK4Qa+hshSzgWPskhcwFoVtUrDg9KIxd5iIcw
         xfrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700840950; x=1701445750;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0K2EXE8gQExfH+IDrBMFiSFCOrHiT67rlvW6OkLmIQc=;
        b=TzjiGmONrCSFBAqT7fpQCS00WZ2V4th7w2I6nwpI8M1oQrYNqiAbG0fH44taJTGmxs
         sZ7lC8ypwfzSaZYl4oOTwKFN4UIEXj6VNsCpL3M5be78KViryfLJTUImLqnIpBqx4RSo
         QHiJj5hdeuDUdQhfBM97ZsDES6NTjMd8EfhspydvMgqhzV/v8JR3XS2qEG9Ob6fV38ii
         XWDvjGe52PEz/lMcUYE614LnQDUU+Z/HBrMtoz1G7RlymIAGW+oLpYLkH/FHU8D9KJO1
         fXNVJnJm10w0arKLc2duL9j7NV6liGem2Op4z5R/cBSp9Lj+uIQpjab732i942Fnp1iJ
         28Vg==
X-Gm-Message-State: AOJu0YyvS8dkjPXeSWsgVz12ZTYZhA0RrgY4o5ZnbjGiuJZ8fYuHM3mq
	73y3TXqeORz9oAdJQb3FyvcqGA==
X-Google-Smtp-Source: AGHT+IE6JEZIq2K7IIOxSgnJ5L7np3XYKNvUoPeNTphLa0M1kNcmMvyILOwbtufQRuoKg4a056MbiA==
X-Received: by 2002:a50:9e0f:0:b0:547:b96:1172 with SMTP id z15-20020a509e0f000000b005470b961172mr2620072ede.28.1700840950070;
        Fri, 24 Nov 2023 07:49:10 -0800 (PST)
Received: from [192.168.1.20] ([178.197.218.100])
        by smtp.gmail.com with ESMTPSA id m6-20020a056402430600b0054af73f3c72sm762887edc.11.2023.11.24.07.49.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Nov 2023 07:49:09 -0800 (PST)
Message-ID: <c2f9d247-752f-429d-8c20-e105b1117be2@linaro.org>
Date: Fri, 24 Nov 2023 16:49:07 +0100
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/3]fpga: Add encrypted Bitstream loading support
Content-Language: en-US
To: Nava kishore Manne <nava.kishore.manne@amd.com>, mdf@kernel.org,
 hao.wu@intel.com, yilun.xu@intel.com, trix@redhat.com, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 michal.simek@amd.com, mathieu.poirier@linaro.org, ben.levinsky@amd.com,
 sai.krishna.potthuri@amd.com, tanmay.shah@amd.com, dhaval.r.shah@amd.com,
 arnd@arndb.de, shubhrajyoti.datta@amd.com, linux-fpga@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20231122054404.3764288-1-nava.kishore.manne@amd.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20231122054404.3764288-1-nava.kishore.manne@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 22/11/2023 06:44, Nava kishore Manne wrote:
> For user-key encrypted bitstream loading use case, users can encrypt
> FPGA configuration Images with their own key.While decrypting the
> configuration Image the user needs to provide the same key.To support
> this use case with the existing FPGA manager framework is not possible
> because it doesn’t have a mechanism to get the required inputs from
> the user. So this patch series adds the required changes to the FPGA
> manager framework to support user-key encrypted bitstream image loading

Wasn't the entire point of encrypted FPGA bistreams that the key is
fused into the FPGA and the FPGA does the decrypting? Otherwise it's
like security through obscurity - the only trouble for attacker is to
decode DTB to find the filename of key, so actually not even really
obscure. Then the attacker retrieves the key and bitstream from
filesystem (by taking out the Zynq-based SoM out or booting from own
system or just accessing storage pins directly) and voila: encrypted key
is available.

Best regards,
Krzysztof


