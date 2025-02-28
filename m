Return-Path: <linux-fpga+bounces-1068-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EFD32A495C2
	for <lists+linux-fpga@lfdr.de>; Fri, 28 Feb 2025 10:48:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E9DF3A18E5
	for <lists+linux-fpga@lfdr.de>; Fri, 28 Feb 2025 09:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B280B25A2B3;
	Fri, 28 Feb 2025 09:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PKEVsygn"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC8CC258CEC;
	Fri, 28 Feb 2025 09:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740736064; cv=none; b=OAWqZvcBpuscdC4gYXP0s5hskYrLy5ZtfymGuEr0KtJDfOC0I5RgjJtgRJnI1UARCfCAyAEI+Dqn+BgpvKHV2NdBvXZt6mUU5POUh02nXLoHrkN/4C4Lq7kRRwtno6Xcn19IAS7Xi7Wy5S3jcPes5eNWVC8WJeRZfhoQLzQ2VnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740736064; c=relaxed/simple;
	bh=iGftiqL71bbhW6OyXghoFbHOaXQUNWvZWkWS15q4IQ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HH2Md1jpi06JZKbuCf4QKTdT/j+flFdzEgpEVbo1LKW21+86M0UqFYKptV6zfVcGpAno++xHGHgyGzlAWm088shkKKDBrhNwWCxw9X3CHqlwmbvZSI97rsp+eMnqpVhN86fyOInC3Wg/FWnG5lisZQlPX5u0BHfvwBWx5rqanEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PKEVsygn; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ab78e6edb99so257166966b.2;
        Fri, 28 Feb 2025 01:47:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740736061; x=1741340861; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lSwbc0Ocosx+IYbNPNu2RmJuzW8p4optBGLY8UNnRq0=;
        b=PKEVsygnf0D6MLx9YNRYOQPovJqdEpTd6pw2965Ui83B6RYBvTJQSAPkyFB6cREULp
         0te5hJQKXbw0gBUevPfwvfXMSMsCD0X7W5rR+3FzQy9q7mmZzYChfa/McmDphEUaQ37C
         UHlpV+zLqjCMMjKYWtVFKNYbVCEt44GZEwCmysAbCWvz7yyaC/BqqqRMYJsEo9rOF1QQ
         t7MbgEfEuz5na2i+bXWdKEtRvBiAlb4bgBGbHaWQRZieZIKimo6bdWHzpSc+KUNx7gpP
         WYJF3ei9R+/jdDUHneqAR4SwAazArPc0P1442jdt7uWPgtp7G8jPaWUiGOcfJ+3caL96
         +94g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740736061; x=1741340861;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lSwbc0Ocosx+IYbNPNu2RmJuzW8p4optBGLY8UNnRq0=;
        b=cWGR4DZhbNcBQ9dszLf//Le+ZR0gS4A9fgDCJrsE59yVze94GaSaPyXT3XSWhLV214
         uvMy39bkyImXsgjNz/zhT/VmQJZK4VuC63U2VUJF+DAwYT1nyiznCe9Dy1kAedQ+2J6j
         ZVMTweS+xO0t4qp/5EOoekbRqV5KDi1CXPaGcsGReAjsy/M754EOMTkF89f2FfsyWodK
         hZwMoR9kHLDn7ne0T0amMI8sO+52ypJxrxLIkOThMzuxag7WhGWt+fkAmRAb1paRztL9
         NWEMSui3pVLLdOD3WFKL1p51UkdIyadyI82nHFrPP6J363uqvxDZokmQaFO+jOsyAm6t
         qHuQ==
X-Forwarded-Encrypted: i=1; AJvYcCUcGzjFZH2Ag+mGLPCd05d/8d2QWcuBU4JMdF/zEkRn4EX8Qm175qPp41ltMuj4TyPDPTKv9a3OYxPA@vger.kernel.org, AJvYcCXEPi5XbXddQ20+OV7Bo9rzjnGgbOv8QrGkP9WblZLso1Xj2Air9ye7Y/JeRneDCH1FulBckew0fq89wBAp@vger.kernel.org
X-Gm-Message-State: AOJu0YwcK4LaZvgj5fugeBPvkKFxxFGAyvKwZhtvaTLwjRAndk2wp6vj
	RlmYDQ0ijOKi0QD4/c4kLIuwq+HJ+hhNotJatHjc7Z9E8dHBFX3UJVdEeVpC
X-Gm-Gg: ASbGncsJilt1vOiZQpfAZGHe0Jty6Uboe7vsqo0LmHXxFnvPg4woX+Nz+raY41TFES2
	NziB3q5p+u/l5eCkErRcDPMo4LeHBsUslp4hs4FKC0AflDCQYIUDL9JjIMxceyMX7UISXNIwllY
	QBTAvvqsxvY/ITD8k2phWHx0BLzhdCbqoKHLYKcKuuy8uvUa0t8HNdpjsaFN45ymsOP9BODsgK6
	rW3eYb28qBHBgL0Q7Jj64HHJyi5VP7iHnXk3yyAGQSgVb45F2jjmrgIncIRz2XsCjeBzL+BSMXB
	7QrMujx3QxPQQwitrLUz4CSBYwdqGqyuaP0qBJFzLcfdziN6u+SzFRZIZLQR/KYLjxK/f4PSdK1
	ov8GguXnF4zisL290lhKkWg==
X-Google-Smtp-Source: AGHT+IFpXEmznOoObI43h9IF5p/EadTZulJMuW5Ustxl017DDa7LRvUEIMc66rIZIJBBT8vBVVPiKw==
X-Received: by 2002:a17:907:781:b0:abe:f6f5:93fa with SMTP id a640c23a62f3a-abf261d3b82mr299485766b.33.1740736060878;
        Fri, 28 Feb 2025 01:47:40 -0800 (PST)
Received: from iris-Ian.fritz.box (p200300eb5f0300004dcedf2362c26f55.dip0.t-ipconnect.de. [2003:eb:5f03:0:4dce:df23:62c2:6f55])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf1a60de5esm209289566b.100.2025.02.28.01.47.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 01:47:40 -0800 (PST)
From: iansdannapel@gmail.com
To: linux-fpga@vger.kernel.org
Cc: Moritz Fischer <mdf@kernel.org>,
	Wu Hao <hao.wu@intel.com>,
	Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
	Aradhya Bhatia <a-bhatia1@ti.com>,
	Ian Dannapel <iansdannapel@gmail.com>,
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Subject: [v4 1/3] dt-bindings: vendor-prefix: Add prefix for Efinix, Inc.
Date: Fri, 28 Feb 2025 10:47:30 +0100
Message-ID: <20250228094732.54642-2-iansdannapel@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250228094732.54642-1-iansdannapel@gmail.com>
References: <20250228094732.54642-1-iansdannapel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ian Dannapel <iansdannapel@gmail.com>

Add entry for Efinix, Inc. (https://www.efinixinc.com/)

Signed-off-by: Ian Dannapel <iansdannapel@gmail.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 5079ca6ce1d1..f0e0da4e1ec0 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -438,6 +438,8 @@ patternProperties:
     description: Emtop Embedded Solutions
   "^eeti,.*":
     description: eGalax_eMPIA Technology Inc
+  "^efinix,.*":
+    description: Efinix, Inc.
   "^einfochips,.*":
     description: Einfochips
   "^eink,.*":
-- 
2.43.0


