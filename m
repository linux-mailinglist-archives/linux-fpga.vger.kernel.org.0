Return-Path: <linux-fpga+bounces-1118-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92505A63FA5
	for <lists+linux-fpga@lfdr.de>; Mon, 17 Mar 2025 06:27:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 932C73AF3D9
	for <lists+linux-fpga@lfdr.de>; Mon, 17 Mar 2025 05:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 226D2218AAA;
	Mon, 17 Mar 2025 05:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gxfY+ljv"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB9421882F
	for <linux-fpga@vger.kernel.org>; Mon, 17 Mar 2025 05:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742189218; cv=none; b=a981YwbevZuzHSAYxQWZgtpTd6lOi77LKT3pwwO+qdgA1m9ncvji5/npGdV5E78r3hcbmIMkFVjSoNn+Y330Q0jpnoVFsfOFRfeGUljDK9VoLED9bblkqQ/24BJmlwFm4XiRe9Ib1sWr+zk4JodHA41s8737hzae/laWfA6zfBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742189218; c=relaxed/simple;
	bh=7DHN5cVmz+pDkRxVTmBkDg2nk5LJ8wBCI4oxq/FHDIo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r11TfsNDnayXH8D/rKuavZZulFNBS3LtJqxT7ZDXXGKyp6ThzC7BRO3FMIpdYAYSsVhy0map4LQDFWROSn1O5uj6LUhKWdVFCwq2jeW5K19R+3jUUmZ9+5toFxNKYTsioXe19NxFtybiKK2YKav7hf7VNuvuoLHkH4skUgiYkrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gxfY+ljv; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43d0c18e84eso6933695e9.3
        for <linux-fpga@vger.kernel.org>; Sun, 16 Mar 2025 22:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742189214; x=1742794014; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2uXXvocDuD+66rt+lg39ttZUegKOYcDjUjA+UXfDUD4=;
        b=gxfY+ljvKh2ZWe4Hejdd0d4G4ILLXtYmxB5l7H4i1HcJJGLcyeGNdt+kQ6Z/s/sKJv
         W5D/GRaI9jDVTpxtDXDMTyhuQ2fTE+0BR7PNcl6MLz0mUrRAgN5TShSgUMjZYdJ7d0En
         KHSD6qKrN332OyO/giWjsBovsGFAcwLErEE/WPDLihaFIAONbZHSXUkXw9Q/Pk0I3hW1
         HO6+FVQUgIGcRcXy3ir2t7A5oDWxpEBaMR4Y+sYFUf2pLpTQZ9tPLk/CPqpcn/uVHksl
         w9AGjHRxKNNRblaUSfVVSfulBGxSqvcGXe/gQg5ZOVtNfR+qVDi7n6QEq2YsrMuWVMRt
         vI+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742189214; x=1742794014;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2uXXvocDuD+66rt+lg39ttZUegKOYcDjUjA+UXfDUD4=;
        b=TdnoI0fUjMSgwPXwC5Ftf5RI1NSBK0ji+x4eiGJGvtVfm1OxnSPgjIb86Y/GYrqrG8
         cOkiSPq5cmvnjHDZ/arox+5SxMx/WWEjOBXReDSk8slBiZbhqGsl/ncOCLcD5mt0BAJ6
         KNB0ZVBv1VGkzxmGrq3Z3UydEmSfD8hglLYDyPi8L44yeLK6jwZxtMdPHP/tq842Zaiz
         s3SN4BVOnBctMlprspbzyG590TMs+fLrt7RtEtOWYD8ONEZ9J34/W1i8zVPLA25vq4PG
         ouzirnXG6xH/U/kSW4LzWULyomDGKbV3OrfBdRmMPkMMypNq7j9CFgQbDwmthpa1zwhP
         gR3Q==
X-Forwarded-Encrypted: i=1; AJvYcCUwbeB+TOo8mcVc/1lxqS2mbuzE0Qan+9vRJabI0K8Puj9/fCbemgcOPspBrF5znRPPFjjHszYe6wiI@vger.kernel.org
X-Gm-Message-State: AOJu0Yzo7uHEahJZnO5BhLlkyeSV2W0RznNesnkn7DQD1LNVoByDdExW
	BBQAoVbz59kUGWh0eEE0T5M3i+rY8/N9UZPdCwtAAGB41ThtkHDQ69BvlwqBYs8=
X-Gm-Gg: ASbGncsN8ZftcsBNBSrBFaGJzRMF4pPySkhch8QVDjmzrOitI+NZJ1Ev8/DuKZf5DGO
	o1EuzqwRA4GTog0D//1R1SYOLGbwoMFQ7hBc09ipI9EXaRB4UfhB54FqG9hXfBqWe9xml5cx0y+
	OEb/GeqEh8Mo9H+RdR6OD4ZdX2iwCcEr5eFmh+PSU94SXIup+8AqvK/BoI/gJvpBwshmZPUv2nR
	T6w0ZVdLg6rtb1becN8JQjPErcC0o0Mfqd4Yb1sEtpEF+Kt45DVzM1A43wSc8YLNoKPhz74SCOO
	ukO69e3eITF4BvniOJHsoLjpruSWA+jTyjS9tE/8/GkVGM2rHw==
X-Google-Smtp-Source: AGHT+IHlSqR/SRDikVnKXDQ6JSQA1h4tlec7oNPPwqTDiIJRTQIqJhGODEAwWWCxkkVC/qZiyiG4Lg==
X-Received: by 2002:a05:600c:4511:b0:43b:c857:e9c8 with SMTP id 5b1f17b1804b1-43d1ece1af3mr114703135e9.31.1742189214587;
        Sun, 16 Mar 2025 22:26:54 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-43d200facfcsm93932215e9.32.2025.03.16.22.26.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Mar 2025 22:26:54 -0700 (PDT)
Date: Mon, 17 Mar 2025 08:26:50 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>
Cc: linux-clk@vger.kernel.org, linux-fpga@vger.kernel.org,
	Stephen Boyd <sboyd@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
	Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>
Subject: Re: [PATCH v2 6/6] clk: clk-axi-clkgen: fix coding style issues
Message-ID: <402a575c-5bfc-4dac-bac6-d7f4e7ee5462@stanley.mountain>
References: <20250313-dev-axi-clkgen-limits-v2-0-173ae2ad6311@analog.com>
 <20250313-dev-axi-clkgen-limits-v2-6-173ae2ad6311@analog.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250313-dev-axi-clkgen-limits-v2-6-173ae2ad6311@analog.com>

On Thu, Mar 13, 2025 at 03:14:48PM +0000, Nuno Sá wrote:
> @@ -224,8 +226,8 @@ static void axi_clkgen_calc_clk_params(unsigned int divider,
>  
>  		if (params->edge == 0 || frac_divider == 1)
>  			params->low--;
> -		if (((params->edge == 0) ^ (frac_divider == 1)) ||
                     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

> -			(divider == 2 && frac_divider == 1))
> +		if ((params->edge == 0 ^ frac_divider == 1) ||
                     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
This works, but the code was a lot easier to read with parentheses.

regards,
dan carpenter


