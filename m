Return-Path: <linux-fpga+bounces-740-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB0369886C8
	for <lists+linux-fpga@lfdr.de>; Fri, 27 Sep 2024 16:15:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D459281D21
	for <lists+linux-fpga@lfdr.de>; Fri, 27 Sep 2024 14:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 959F516631C;
	Fri, 27 Sep 2024 14:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V3F8DFKY"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E782115C147;
	Fri, 27 Sep 2024 14:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727446504; cv=none; b=Fl0kuKQj8/U2fbS9DDzUvLN6Yk8dqXI8h8AwcTAH/gRiZCB/hKz+QhwBu4ZUIifABlZ9vVuI8Kri2qHYCfIkhP3w9VGSB7LD/RRijtGLjfTQtm+x9tOqkzBt2zsWWUc5Zj/z8Em7MQRB+M02Kn4EYyxDRhfxgRnkXw4nOdC1Qxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727446504; c=relaxed/simple;
	bh=bCodM7u/G/hFWvqfvgM+YkzR5lSFFh1iKEmEioXKdu0=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AfhStvpHzvYEfIoaFar1g1M4/sfd+xRN63mwJOYAhoRK4isbx+0FvZkgDtOzixIY+79x6xcZzpndsy39suqaQQ95VBRWiYP+8MtNxBqkrqmt3eMxwubRXbTbNuIbYS8T81q1U/qlfHZnKXBC7Ohmj1PIv/pM7KQcHu/4OqXdu7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V3F8DFKY; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5c26815e174so2708470a12.0;
        Fri, 27 Sep 2024 07:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727446501; x=1728051301; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TPMq+KLafMILl1+WLX5VkxY2Y44HaKn4j8J45uEkcxc=;
        b=V3F8DFKYnCgtqHnMR+ZAn+rY/xSg47DoT4mrGb4aC5p+tSm8d/d7AfUHOUPYeHI9h+
         B139IgOlJsIzWLXJ+s/Zsq2u5KPoScWvIGV51rvBeNan/jstwm2xSeQ4drXV8adGCwIZ
         3Nf7+vgUZSkq9WfgmOmgFUp1wKu0wFnXTCBqOp6pYyR9sNA22xuf7pTXRU0V3S1E6EEb
         2UjqExDyIpUuEgnCxYEVfsE46JMXNNZ813s7i3IhK5CuJ4NGokV2BIbCeDPKU0wSdzL7
         yN7TvZUQKZDj5cEQwqYDz+9LFqAJXnHhT/QL1SIRLx7uphklPbSDXWmvfWelJ2GBk4GA
         FWVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727446501; x=1728051301;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TPMq+KLafMILl1+WLX5VkxY2Y44HaKn4j8J45uEkcxc=;
        b=NUoMsq1sauT/GIxHYE/bWbGrinLTJgAMKsOqAsdP+UF00PEq/tTRtAZLs9qa3eP5Ws
         +jtrcOmwVhMBwaaNLXM31OkuCsjVJwkh9/VQhz9DgyRXQ905J2WEkAywR3dXdv2HVPoK
         jaOpyhM2iirc1NlophwM5D85jYsjapas+ZgcScQtwQLPXld1NfU837OXfYvwlfLGk+ZB
         RcrosFqJOvBKn75IFwVv70NVuFERAatUOI32ejyTQ90c1GwHlAElNFJXv5yJivM4eVVd
         EhtCFeRSr+T+9tai2pac02vpc1YUbZLjKqg0n+zWihDeHr22HgyQv3i8q/XarEBwhgdN
         ZR9w==
X-Forwarded-Encrypted: i=1; AJvYcCUNsZXQez3XXewyvLDlF02xENMqWxEnDinsF8rt/DvXF6zT8iDJu3a1UyGH0aFfp4VssQLlDEWc/RtZTQ==@vger.kernel.org, AJvYcCXEPuo7rnNulTifWM8sUlWh7k5z871iskS+yw5anXi2Ohkr3GFp9m78fOGFZ5WxKGhor0yCGcoCUdbk0ofQ@vger.kernel.org, AJvYcCXi6F2tZES8n0Eps2iGdh2qO2vyQ+6APLX6bP7ztVBpF3ZvTwcXc+7wrcFitcLXTKQNDZBPPBmQSvyi@vger.kernel.org
X-Gm-Message-State: AOJu0YwOFqtLN8yB0jz+t82qHvQUK9e+PviFV2cIwXyWDiV9um5ieIa+
	V8FA6yLusMD4JRePiqYpWQJhqC98d7O9BoVH8CPux6/Y9wg27GTejCD2cyfU
X-Google-Smtp-Source: AGHT+IE7VnSyY1c0tBPtnzTg0/6HMnzJ5CKQLPsGP6ULg2Oh8zxxAgsp0vUcW2FDN2kPzTs/2mQJTQ==
X-Received: by 2002:a05:6402:2318:b0:5c5:c060:420d with SMTP id 4fb4d7f45d1cf-5c882603693mr2265431a12.25.1727446500914;
        Fri, 27 Sep 2024 07:15:00 -0700 (PDT)
Received: from iris-Ian.fritz.box (p200300eb5f4f030052bd6081d2396adf.dip0.t-ipconnect.de. [2003:eb:5f4f:300:52bd:6081:d239:6adf])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c88248af00sm1184519a12.67.2024.09.27.07.14.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2024 07:15:00 -0700 (PDT)
From: iansdannapel@gmail.com
To: mdf@kernel.org,
	hao.wu@intel.com,
	yilun.xu@intel.com,
	trix@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	neil.armstrong@linaro.org,
	heiko.stuebner@cherry.de,
	rafal@milecki.pl,
	linus.walleij@linaro.org,
	iansdannapel@gmail.com,
	linux-fpga@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/3] Summary of changes
Date: Fri, 27 Sep 2024 16:14:45 +0200
Message-Id: <20240927141445.157234-4-iansdannapel@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240927141445.157234-1-iansdannapel@gmail.com>
References: <20240927141445.157234-1-iansdannapel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Dear Linux FPGA Maintainers,

I did not found a way to use the struct spi_transfer to manage the chip
select the way this fpga programming requires. Since the chip select is 
managed by this driver alone, it may interfere with the communication 
with other devices on the bus, which I tried to make clear in the 
documentation.

Patch 1:
- improved kconfig help: added warning on spi interference
- fixed: efinix_spi_probe() warn: passing zero to 'PTR_ERR'
- improved function naming: efinix_spi_*()
- fixed: fpga_manager_ops.write could be called multiple times during 
one time reprogramming
[attached: v3-0001-fpga-Add-Efinix-Trion-Titanium-serial-SPI-program.patch]

Patch 2:
- added warning on spi interference
- removed unused label on example
[attached: v3-0003-dt-bindings-fpga-Add-Efinix-serial-SPI-programmin.patch]

Patch 3:
- no changes
[attached: v3-0003-dt-bindings-vendor-prefix-Add-prefix-for-Efinix-I.patch]

Signed-off-by: Ian Dannapel <iansdannapel@gmail.com>

