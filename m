Return-Path: <linux-fpga+bounces-195-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8328B84362A
	for <lists+linux-fpga@lfdr.de>; Wed, 31 Jan 2024 06:43:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8B061C26194
	for <lists+linux-fpga@lfdr.de>; Wed, 31 Jan 2024 05:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFFC03D992;
	Wed, 31 Jan 2024 05:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IYe3npgp"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 111303D982
	for <linux-fpga@vger.kernel.org>; Wed, 31 Jan 2024 05:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706679825; cv=none; b=pTX8p2GA9DHQycxEZv5vtvh8sePL1QXfEuCHIah0Mu88HlfBwOu5+GL5gi+r2gAEHgyo9DD9OJUsy+wfUrgEykLEyT8hnrFWvej6Up6xSqGYh5xmVn8O6tc8CRpFpXVhNFI/51wI4cujF+p/CsrwG1YN2J2/jpemPlq9qnmj+GQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706679825; c=relaxed/simple;
	bh=Tcb7EvZ7CF8K0fkMJwChWAO7kgbOJfPWxzgUv0R1F0U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KURNdzsjZr1CQdZI+oEsxxWyTtromiSCJ5XXmTcEIpLtnPWhIUM060q5xDJFLQt61u08LbKUCpyrs8Wlu08+BFjPtZAj6maGL6VZNKpzMLNgH2Ou5S4pLGsrnUQpytjrMqcy1EaohQV3gxAyvbbGpTQ+7Z17T34BASqevAROr8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IYe3npgp; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3392b045e0aso3283879f8f.2
        for <linux-fpga@vger.kernel.org>; Tue, 30 Jan 2024 21:43:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706679822; x=1707284622; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Z6paO3eoxO/TfvLc58kRuFFfKLKXd3dLqXEc7Va4H4A=;
        b=IYe3npgpVgXmB6ksEA+VPYQQ7l5eKvI18zL+FAC+c6CMpYpjF9VG42EB5k5g/E1TGI
         fu/AfqNyCG8nmTRGyWlzqmWFPrfZOypZQMvQSRtv1+F0pBAqNUWee8ZdmasM93IG1q2o
         Dx4/GzS74bdizvfyug/QWgwr2veSGekOo8PexFs45zBDA5wKW7as69e983JWsPu4Fd7+
         C0jfHo95RNmye42w5nby8qsHKopYF8PJ+W0ciUlXiHR/H6PSTzTg/WEUREcvg4whsE6I
         KPstOnY71Npe6ZtpAn1/QL2+nMj5aRcBrOpX40k5m0L2CbrXZy2nw/VgAB4xE5pVYMOO
         D9lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706679822; x=1707284622;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z6paO3eoxO/TfvLc58kRuFFfKLKXd3dLqXEc7Va4H4A=;
        b=S8f834Em0/aBLGMW+ENhcEN9NnRO5cY+7DxmcvOAkHtFUgjOc49l7stLC5MDoia9Ey
         uyeRqQamu6YmsmUwQ7m7cSCU8K0VoIyflPekqqCVdY+7YzSkK5jIgCjE3cKcSDIZcdAP
         MAERsegOFHRBpX0SP+Fsbj578YmGXcBAaeEEvrrmX1I1CQOKab8RdYQ7c2ZUFrhVRbGu
         tjmP5tzVDHoAyliL5dB5EMI1Muj7rrm8prrzrZcewDSXnR8nIIPvKD+R+PyBDFJB442s
         ZDSkRa4MXhh7NmbcGrTrpRVF0wWVfSTfpFy23Fpcl/HA2Sebdw9yW2ZQjEPsxtbHkX3n
         iokw==
X-Gm-Message-State: AOJu0YxjD1oqAOslprj71o0Glpbb1J9h6dpakfSKc37CchLImF+1aIQk
	izm/xAlSD6sgTJJCRoW4lytOBLQGSOXP7mikzTZmOf7q4ZnTQLnSsVzUPlTmhqw=
X-Google-Smtp-Source: AGHT+IE3FuFxpDZMN/qaH8Qvlb1Bni7EQMvftW5X6bNwAjF2dsc8Ac7zFpnPHnALypt/FgdcBNQOsA==
X-Received: by 2002:a5d:5348:0:b0:33a:ea38:6453 with SMTP id t8-20020a5d5348000000b0033aea386453mr410173wrv.45.1706679822271;
        Tue, 30 Jan 2024 21:43:42 -0800 (PST)
Received: from localhost ([102.140.226.10])
        by smtp.gmail.com with ESMTPSA id eo9-20020a056000428900b0033ae9e7f6b6sm8191928wrb.111.2024.01.30.21.43.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 21:43:41 -0800 (PST)
Date: Wed, 31 Jan 2024 08:43:37 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: linux-fpga@vger.kernel.org, kernel-janitors@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Moritz Fischer <mdf@kernel.org>, Tom Rix <trix@redhat.com>,
	Wu Hao <hao.wu@intel.com>, Xu Yilun <yilun.xu@intel.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Kunwu Chan <chentao@kylinos.cn>
Subject: Re: fpga: dfl: fme: Return directly after a failed devm_kasprintf()
 call in fme_perf_pmu_register()
Message-ID: <5a3a1c80-47ae-45c7-86ca-8aa40566551b@moroto.mountain>
References: <d94376b6-12e8-45bb-a9be-4887bb316d35@web.de>
 <b7e2e9d1-5e3e-44b2-a4b7-327d334b776d@moroto.mountain>
 <e760bd1b-30bf-489f-b745-128d05397feb@web.de>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e760bd1b-30bf-489f-b745-128d05397feb@web.de>

On Tue, Jan 30, 2024 at 06:09:14PM +0100, Markus Elfring wrote:
> >> Thus return directly after a failed devm_kasprintf() call.
> >>
> >> Fixes: 724142f8c42a7 ("fpga: dfl: fme: add performance reporting support")
> >
> > This basically doesn't affect runtime because perf_pmu_register() checks
> > for NULL so no need for a Fixes tag.
> 
> I suggest to clarify this view a bit more also according to statements
> like the following.
> 
> 1. https://elixir.bootlin.com/linux/v6.8-rc2/source/kernel/events/core.c#L11532
>    perf_pmu_register:
>    …
> 	pmu->name = name;
>    …

The check is right before that on line 11527.

https://elixir.bootlin.com/linux/v6.8-rc2/source/kernel/events/core.c#L11527

regards,
dan carpenter


