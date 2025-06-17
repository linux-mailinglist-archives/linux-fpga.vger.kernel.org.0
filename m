Return-Path: <linux-fpga+bounces-1251-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05BBBADC5E3
	for <lists+linux-fpga@lfdr.de>; Tue, 17 Jun 2025 11:14:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0368C3B52FD
	for <lists+linux-fpga@lfdr.de>; Tue, 17 Jun 2025 09:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B495F291157;
	Tue, 17 Jun 2025 09:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="YCEjUtBY"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD3E821B184
	for <linux-fpga@vger.kernel.org>; Tue, 17 Jun 2025 09:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750151663; cv=none; b=Ff18Yjd0MlKIcisbXHPDXRvGxRSlUjy2LuAGwpVAYpfLpYR8oEy80Txgh5/DtJgMx6jWEswvIx21050ClTR8ENuJm6kO/mcFtUXD3ij4jWFmpeJG0J1O4GyTqC6sZT6RdDG5m6KKvtxe6ael41Gpjyz0vsdBLj8hGqMwinhb8a8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750151663; c=relaxed/simple;
	bh=Pg+a11153qJ1ibrfg8vK0qJ81vAzJN95tmjWPPAy6Iw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KkPl+N/fEpBnAEpr/O5rJ/TmsnBaDE2vHEMGtaZyP9GwPvjVXvoWGkASJ/WsRTk+mBCwJxqNhD3zKMKWMST1y38yodir9RNi2z1ctlZerZ9/Nng6g/yCTBA3eIvdRzIN04SKy125bnJa2fq4qinHnNKik1v/NLjsF4E0cdb89L4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=YCEjUtBY; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3a4fd1ba177so330374f8f.0
        for <linux-fpga@vger.kernel.org>; Tue, 17 Jun 2025 02:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1750151660; x=1750756460; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UnaoVN6uaaPExRjDgZo8b3KkCScwP4IUmjW/6H1GBX0=;
        b=YCEjUtBYQRSjsyyi0+bN2bxbBRgBocCrj6p65LOMSZlCyBry9mFsAUTfWdC0J5ZwhM
         p/R0L/eAc8n1gkb6fFX9Xy3LtYq9FRLjjbHWZzLp5no9x0PO2AxT2bVsmL0gr9yx4DdW
         T3oKYA/dtUYnIdz21a4MCHuuywHr04pDvUHFnAWo76VAtDKETVzcLfaFJtJT/vrLNuOT
         IsmXdOHtHt1AlDsWrC4grYd6OZ55mGGh17mujWWeO2xVmza00jDeh1lU+Y8kAmV8iSr3
         BJCwt5YUl3NaXlRlYhSn/KunIZt/bsJNBcStNtxsj6/NfQPf+A8fBx2nQ9kjYl1askgA
         hGsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750151660; x=1750756460;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UnaoVN6uaaPExRjDgZo8b3KkCScwP4IUmjW/6H1GBX0=;
        b=by2JzOjQBB0cseLXOgixjqqbBxdSGQQTpF84pjZXYGhDUldrgs8icWHOYtboY79aoe
         H/oBd0xMKVuM4RxGB7IB2XSXBiNl9Anf3logs0s3aW5TE1+ujINEks7bDAWqEUXzp+uS
         woQzhaR5FseqJmMqMvqu535I7eIALS/M0yxyjpr3hG2DKjg1+0Tg4KuUuIBGAQhyWbm9
         jMoKvS8LpKcTzapyxMjR3pZlZ+bUs17OqEOdVkuv2nAVN/frIXFpNOpRDH/2Xxs6/TIK
         2yDQYXzANGC0lk4vHbdqeKYg2+YdVqD3KVYrUgN++c+5jGJ3VU4d/3v0jH/teXWWgoA5
         N4Yg==
X-Forwarded-Encrypted: i=1; AJvYcCVSgzhXDgFe5BI9jqF5Uo4ZKkBQlSOnuxUn4Ozjxi2DWHCT/Ylm4AGgXFtaIDGvL0vhpg54ixfRKM5j@vger.kernel.org
X-Gm-Message-State: AOJu0YzMBylv2oczTO2+RulxvBxq0XwR+KRki9Spqqlt0vM+bm4fO/Wh
	F2IZxrtH6gCborYNlnq1tjx9GljQVTkBit3N8rkbQXWJfbEMSjtkycroNZJS8g2dOa8=
X-Gm-Gg: ASbGncuzY/VHai15XuqSNtXaK9Wzgdey9wKq5inWfCFOYkDxs/pJcAdf0ndKoNSTGCo
	6OLk/Q1Ygpr7T2aFs+3SnFgyWZaJDLjET6FVjghBtNPlfz+oM64TXyfMtDEvsD1FQhwQwrFenmu
	IGodiYGc0UGEyow3H6XRwlab93O1qT43dEDzm/kDYaDieSFIoyoMFzoxts4AtsiXXBg4SxS502o
	Y3mgxmoWUM5HhW5tCJq8azr2L4ZrU0DXDQ9rQSZflC2hSj8PEMUsXNAbEPGLievPkQ1I7VMC3c+
	+p8TFa2FzcnRW2EAhExXDd5YHq+MhL8j74375kl9yLmsJqyzNu8KUDXc4UFuxG0=
X-Google-Smtp-Source: AGHT+IHTn2wDMsbvMniANLwl39rjbgUv/TbrwZjrJk9B4M+SEDhL4V7ekAYBvqmllDgC3dCpG6O08g==
X-Received: by 2002:a05:6000:2504:b0:3a4:e624:4ec9 with SMTP id ffacd0b85a97d-3a572384087mr10329583f8f.3.1750151660151;
        Tue, 17 Jun 2025 02:14:20 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:90df:ded7:9cbf:4074])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a568a633ddsm13280685f8f.26.2025.06.17.02.14.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 02:14:19 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: linux-kernel@vger.kernel.org,
	monstr@monstr.eu,
	git@xilinx.com,
	Michal Simek <michal.simek@amd.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Xu Yilun <yilun.xu@intel.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Moritz Fischer <mdf@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>,
	Srinivas Neeli <srinivas.neeli@amd.com>,
	Tom Rix <trix@redhat.com>,
	Wu Hao <hao.wu@intel.com>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	"moderated list:ARM/ZYNQ ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	"open list:FPGA MANAGER FRAMEWORK" <linux-fpga@vger.kernel.org>,
	"open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Subject: Re: [PATCH v3] dt-bindings: gpio: gpio-xilinx: Mark clocks as required property
Date: Tue, 17 Jun 2025 11:14:16 +0200
Message-ID: <175015165194.21779.15497760973651030426.b4-ty@linaro.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <94151cfbcff5e4ae05894981c7e398b605d4b00a.1750059796.git.michal.simek@amd.com>
References: <94151cfbcff5e4ae05894981c7e398b605d4b00a.1750059796.git.michal.simek@amd.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Mon, 16 Jun 2025 09:43:18 +0200, Michal Simek wrote:
> On Microblaze platforms there is no need to handle clocks because the
> system is starting with clocks enabled (can be described via fixed clock
> node or clock-frequency property or not described at all).
> With using soft IPs with SOC platforms there is mandatory to handle clocks
> as is explained in commit 60dbdc6e08d6 ("dt-bindings: net: emaclite: Add
> clock support").
> That's why make clock as required in dt binding because it is present in
> both configurations and should be described even there is no way how to
> handle it on Microblaze systems.
> 
> [...]

Applied, thanks!

[1/1] dt-bindings: gpio: gpio-xilinx: Mark clocks as required property
      https://git.kernel.org/brgl/linux/c/d03b53c9139352b744ed007bf562bd35517bacff

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

