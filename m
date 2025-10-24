Return-Path: <linux-fpga+bounces-1386-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B550C06DBE
	for <lists+linux-fpga@lfdr.de>; Fri, 24 Oct 2025 17:03:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1828950444D
	for <lists+linux-fpga@lfdr.de>; Fri, 24 Oct 2025 15:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C1773233FD;
	Fri, 24 Oct 2025 15:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eapkqcC3"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9B430E0D0
	for <linux-fpga@vger.kernel.org>; Fri, 24 Oct 2025 15:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761318075; cv=none; b=Wb9KefficfoSwIVyyEF9CQB51NtFICT7Lu11uK6h0C3FTZAz1tjgpQ9D+I8N0JEe0tRZDuI0+RIULBvPAMudWes293Rg79gq+tdHCQlI07ZTWS5F0RCjC8yqjwlDL5Mg0HEETPkRH5l/qo0wxYtnbJjIdUV0sEeB6HimlflQ9qA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761318075; c=relaxed/simple;
	bh=Ipd+fJKM54dwFhjqVqY2/vt0B0gPimIr32J295wlB+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QZk2/7lvHAt827TA98jSOHaRjBFH7YvvAMnOC+GdyEw7S7saZTmnox/q+SU2TENwOHMGwFSqZMQlEIHLU1vJHeK1a7/13Ol+u55LTgD0MWxXZRrMCHr6+y9dPDBd7aGQYej+xAiIKcZ/eqfSYIEHtFsUVD2mtV8Kx5olrUiOTFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eapkqcC3; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b6cf07258e3so1708893a12.0
        for <linux-fpga@vger.kernel.org>; Fri, 24 Oct 2025 08:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761318071; x=1761922871; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ipd+fJKM54dwFhjqVqY2/vt0B0gPimIr32J295wlB+M=;
        b=eapkqcC3gDLEE0fjFzXqlUpmKvq26CySDN96HJfNC9kv7HhsNAtnUBRYeLKEIXbAn8
         YpOyEvQjCfQqLXG+3AqChnWMtVXL/diT3BurH2Zn/GeJulkqZMzRJpiuxH87jI6ypO4A
         oHiC2s2yTaPotu4xCvggyAwl+uMapNTq8fzLTNMT2P9YgB5b8+VnRU74JGrCCXUQ3K48
         ujKlTu6HCge7RYxJ6Fa1VzZehJHT1IwzdKhr+ZX4bOX+Ax97uIeYdwgv7jmgUUZs4ZsA
         /QWidY+fOpUplPG7CXpWIjQHF7bKNjHU1npOH6gc5sgpAxtau9u2Gj35C3JziPlBeVJE
         jmHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761318071; x=1761922871;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ipd+fJKM54dwFhjqVqY2/vt0B0gPimIr32J295wlB+M=;
        b=lj8nmkP+gd3gt8dPgPrzCkdr4pV4lQjLHf3KC0HazfaaJYue55ceRZ3c3pZuiIy/89
         oJwp+d7NrgByibPw3IwxXsSa4liou9bsGiD3wbLH97l7UxEFpuyOwMO4PlAdlwwTka/P
         Cl4GoH6/wD2F6ikeHcyu42PqY5jPBb0zwGOChRMCrmi8M3d2N+H5VCRrawM1WyPXO+5d
         7Zfioro1ilkqtlciZWoo9t2LXtDPqLry4UP/sxIDAEjBozctc8YIWhjAE/YO9YnoYIuT
         hWgMWYrvs6+YnUQvKwoFnJeaMM5zlxOs8YyFyRBswkP9bCRhI2RiMDEEkVdDO8DW1f5D
         YX+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXd/FmsfaRZFXBFPNAYG3Zryi3GtvM0ttCZ+FsKOKTNlZM2yQ/BpnA69WqcJ5WGH9iVOLtFZyOqNRLq@vger.kernel.org
X-Gm-Message-State: AOJu0YzfVaSbvFHTv1keLoE+bv+EmFIUnB7iHBvujvyAUIo52NkiplpZ
	bhkhXiRAob4gYsGp/Zblecmj54HCUQYOnjPl4eDXKjhOzYdcTpMI+uy3pWEGLMGT7PY=
X-Gm-Gg: ASbGncttewoRAScGymxKE9y8YV9AYyCeRWkBWjySMibUKyzOoEsstMwWWfRPSRBZQtR
	vS0YPCpnpOgNykcPHrwvhdtJGDV9WseEHaNa0y2pV4Z6K4ImQlPTB8dxiZTCHzOLMir24Zt5GJ7
	ykBCGQcfFB6YuoRWdzPX8lm7Zztth4DH2b/YZf5W62Bs2c5VwftVqSp9HMav+m1eH2TLdazZCBE
	4Jff1niFM8FdFR54W9ePvHlrcJ3EqkVluZ6s9pm+khImsURCHj81WxQYFLcYdjjhrTpTnP43y6H
	TU7nfqNn//Cq0De+YYk6NKhdQ/Ku3cwNx6g5+LlZU0Myx8VFrgdMeQD7c8JKxhSYZTTPgDg7qqc
	9eSNYxhVqB5U0Ug2fFkD0YXg76FMIm5wv2kL+hfE8F8vZSlfsxsFmVzd7d3a0f4LDpYYpP1tPVM
	lExxc=
X-Google-Smtp-Source: AGHT+IHuDfyfb1rJHT8ZJBZDENWXEuZEgoATFw7kevTr6Wui6O5rdZfaFJ1o7hmkdy/EeXDSX0H8pg==
X-Received: by 2002:a17:903:8c6:b0:28d:18fb:bb93 with SMTP id d9443c01a7336-290c9c8968cmr381787975ad.7.1761318070419;
        Fri, 24 Oct 2025 08:01:10 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:c4aa:f655:2dba:5bb5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2946e0f3794sm59537715ad.88.2025.10.24.08.01.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 08:01:09 -0700 (PDT)
Date: Fri, 24 Oct 2025 09:01:05 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Robert Foss <rfoss@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Guenter Roeck <linux@roeck-us.net>,
	Andi Shyti <andi.shyti@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Georgi Djakov <djakov@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Joerg Roedel <joro@8bytes.org>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Sebastian Reichel <sre@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Olivia Mackall <olivia@selenic.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org, dmaengine@vger.kernel.org,
	linux-fpga@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-hwmon@vger.kernel.org, linux-i2c@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-input@vger.kernel.org,
	linux-pm@vger.kernel.org, iommu@lists.linux.dev,
	linux-media@vger.kernel.org, linux-mtd@lists.infradead.org,
	netdev@vger.kernel.org, linux-wireless@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-phy@lists.infradead.org,
	linux-pwm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
	linux-crypto@vger.kernel.org, linux-sound@vger.kernel.org,
	linux-usb@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: Remove extra blank lines
Message-ID: <aPuUseub-Z60hrOx@p14s>
References: <20251023143957.2899600-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251023143957.2899600-1-robh@kernel.org>

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org> # remoteproc

