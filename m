Return-Path: <linux-fpga+bounces-1382-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97305C04EB4
	for <lists+linux-fpga@lfdr.de>; Fri, 24 Oct 2025 10:02:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 329F53AB0DE
	for <lists+linux-fpga@lfdr.de>; Fri, 24 Oct 2025 07:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC5582FABF5;
	Fri, 24 Oct 2025 07:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="v3iF3RAP"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B108525CC6C
	for <linux-fpga@vger.kernel.org>; Fri, 24 Oct 2025 07:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761292583; cv=none; b=HOOkFwljS12tmVly+knddyyFVvBDiTcDl7vuCV2CmR2Wq0ktTvo8LGTFBMUSMXT+EeWk+OwFGrbfKvEqpYE1/LbiYLFI4QqCcjcAduMjdQgyhmdSrRzTsjW5qal72Zco7ch+A9sYH00OTuoi0f60Kf9tgWrpa+Q/Nbf5LBVOcEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761292583; c=relaxed/simple;
	bh=nxy0zWX1h247nPbsMpYtj4rqvQKsZpsdIsqOdaa3i18=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NtipVm3X1HdUhS8FWlrTanSxvKDPDnjjcdKzzXH9RyQavRU3/7yx1UGtPIi0rchI9bIynQlfNARzpPTjzCGpOnwqJQ44viFlgvTTtUn3A+YgzQUrEcVGAepmQZNx6nSIZaKk4enUBHDJKCCUZlSBMzkrGVQBg7//aQjRHjK8LWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=v3iF3RAP; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-592f22b1e49so1559703e87.0
        for <linux-fpga@vger.kernel.org>; Fri, 24 Oct 2025 00:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1761292579; x=1761897379; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nxy0zWX1h247nPbsMpYtj4rqvQKsZpsdIsqOdaa3i18=;
        b=v3iF3RAPDCb1elFqO0VtoWQu+fW6ymU7UCcKEvvmYKNYTD2ooJnLd6jMbuJoUoN+Dn
         48jC0TXcnzK7hHI8l7XLLufqE40irxcJ4vQUvDf4zdOy47noMAAYnUg6+rKFE7kuW8KB
         USll7/Aewk1bIvHRDatF6iZ+ivUhLjYhiJEJEaA/t1MN12k63JvJ8Z2BqetAPfCPpfzc
         bXyJLqDmaG/v2uSkzQNDFkhtLwjQdE/QsFWa4lokn+PvuaNQ6Zeenb8G29xaiiFXP0S7
         FDqWxQyTvlalR9tZ8BC9oRxHctw1PO5qfa50RYj0lq81NdRESC/gWmdIjcg72jvCS2fV
         wJ4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761292579; x=1761897379;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nxy0zWX1h247nPbsMpYtj4rqvQKsZpsdIsqOdaa3i18=;
        b=N3Q/NgFuXAn+mzx6BNp77XCndJGam35RTjMypTrbL27qyReDMpjWBzIMWq6oE5eOOp
         7q2A9jNIRlXYedu2ttthfxOBfOTEzm1cHTrmvipeOR0D6IWPuxeq2IH8qZUSrLy8+pAM
         RHMs0F/iZCeqwbDsEVfEKTsQrC/u7+IaBMSncNQnOdRwUr2mnizB9mborsS5IGtC4eXI
         d/szeJsOiC4eZ/Ul3jOSTja/47T1idDSH6NpGueC5IyDFX/8UbdQnGXsFkG9e7azCyS8
         49w6+yee4EtZM6HtwnAidLpt4ObhOdrQAwR+uSXqXnFOAXbch+QZMnejvgR4/VdWKwyO
         QGsg==
X-Forwarded-Encrypted: i=1; AJvYcCVu0Nzw969tTgzEErqXfRbsWDUM7qVtHB3+G5socx3BTTBgOp8Swqu1jkWJk8DAN3ICQdD89/B7eYK0@vger.kernel.org
X-Gm-Message-State: AOJu0YzsYADFh6cZTRnvUsN0W9cjUsEIsUIaO8LMkxji1XTR1TtzcLIn
	CJyyhFAOwE+HnrLPZs15Ie3/+OwO2Mak8FFEj6ntCcDVeCxqb2HONf3QbvKphIq7PONVo5pwVki
	QnXaXUcio5TFkYO6X5AfNEhbU1N3NZmg6++r8cYrRow==
X-Gm-Gg: ASbGncuNKbWyEPE5WDe/JTWi3sNfiYdFy+jKPEprR0bpAFu8PQyiuYQwv/MBeDQJyCf
	uujs+0zkeHfgJlh83dO3VCfaEiuu7V9aY6hn+Hr5cE7zQWCVERBy5OHtyxuv8R+PdwiVkFr6Q40
	HUgBJbrK/MSNm0GbUkGpO2muXO1u+6Crz/AL9L1wixQVvxy7TubrbmUR6Nt9TfZeTQhHhY/eg2v
	7TeE1pecFsFWh/3lQLYwMa5TxRz/ghAgclW/t9CimCaiaoB5wEtQZ3jbKz6MeCb3gh44rnV/mZs
	7ypNSWbAitQpHao=
X-Google-Smtp-Source: AGHT+IHSnXZ/gyOux7cXwXN4jLtleYFyXBIE1/V6t/jovl+yJ4b+HMb04wimJ5i7xVzENgmv7b2GUJ2i/5ONH7mEpKM=
X-Received: by 2002:a05:6512:130c:b0:586:83e2:2295 with SMTP id
 2adb3069b0e04-591d85525f5mr9376212e87.45.1761292578695; Fri, 24 Oct 2025
 00:56:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251023143957.2899600-1-robh@kernel.org>
In-Reply-To: <20251023143957.2899600-1-robh@kernel.org>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 24 Oct 2025 09:56:07 +0200
X-Gm-Features: AS18NWBwXS6t25LKJEi_UKqvj6YhljrcGI4AFOhItyKPndeRwhvu3EmnTJe9vDc
Message-ID: <CAMRc=MdE=1cPDPQwPQA6mdBkbXF2pG=oQ_oR_YuasGzaPDsKtg@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: Remove extra blank lines
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Stephen Boyd <sboyd@kernel.org>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Andrzej Hajda <andrzej.hajda@intel.com>, Robert Foss <rfoss@kernel.org>, 
	Vinod Koul <vkoul@kernel.org>, Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>, 
	Guenter Roeck <linux@roeck-us.net>, Andi Shyti <andi.shyti@kernel.org>, 
	Jonathan Cameron <jic23@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Georgi Djakov <djakov@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Joerg Roedel <joro@8bytes.org>, 
	Jassi Brar <jassisinghbrar@gmail.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Lee Jones <lee@kernel.org>, Miquel Raynal <miquel.raynal@bootlin.com>, 
	Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Johannes Berg <johannes@sipsolutions.net>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Sebastian Reichel <sre@kernel.org>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	Mark Brown <broonie@kernel.org>, Mathieu Poirier <mathieu.poirier@linaro.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Olivia Mackall <olivia@selenic.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, 
	dmaengine@vger.kernel.org, linux-fpga@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-hwmon@vger.kernel.org, 
	linux-i2c@vger.kernel.org, linux-iio@vger.kernel.org, 
	linux-input@vger.kernel.org, linux-pm@vger.kernel.org, iommu@lists.linux.dev, 
	linux-media@vger.kernel.org, linux-mtd@lists.infradead.org, 
	netdev@vger.kernel.org, linux-wireless@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-phy@lists.infradead.org, 
	linux-pwm@vger.kernel.org, linux-remoteproc@vger.kernel.org, 
	linux-crypto@vger.kernel.org, linux-sound@vger.kernel.org, 
	linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 23, 2025 at 4:40=E2=80=AFPM Rob Herring (Arm) <robh@kernel.org>=
 wrote:
>
> Generally at most 1 blank line is the standard style for DT schema
> files. Remove the few cases with more than 1 so that the yamllint check
> for this can be enabled.
>
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---

For GPIO:

Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

