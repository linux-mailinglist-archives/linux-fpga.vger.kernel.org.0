Return-Path: <linux-fpga+bounces-566-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 936D491C293
	for <lists+linux-fpga@lfdr.de>; Fri, 28 Jun 2024 17:24:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48E351F22173
	for <lists+linux-fpga@lfdr.de>; Fri, 28 Jun 2024 15:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2B361C8FDB;
	Fri, 28 Jun 2024 15:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z3qvItiC"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F07441C8FC5;
	Fri, 28 Jun 2024 15:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719588262; cv=none; b=NS2HXDQUcmwRatQQeqfYQqGa4MoJsW007aoc49KZokWCrhPo7Alat30Zf+embmqyMwh382Li9tjwEo63QnnWQj9gh9heqy2HzrzRPWg9cUClC2S19ZCYYq8CvCC7pz+n45AV3kV3r2JwO6jqftfC5B3O13ULE5dQErWJjDGa4mQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719588262; c=relaxed/simple;
	bh=u7/YTPfkJAvo+RAL3M9xn1PEb7/40zQ1Yd5GJRvX0J0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=W9T3tZlc27sMzmK9+U2AZ2ZqpKNesXX7Iav/PsG+WA+KKVtxZvP3wqR7FLGn7YC7mU5c6qWiYli4aVBTJNJQIbFgc2MawHbqGRmUMl4tOWB5E7v3FjUE6w0wI/NwWdD+s87rpbxwNxYxxx1rJ70f8lIgK5SNuxWaw4XSUOEaDVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z3qvItiC; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a6fdd947967so76495866b.2;
        Fri, 28 Jun 2024 08:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719588259; x=1720193059; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UyhUDNd2cxLPE3+2Xa0aiyHUJwN9W1K/tIImYyLqEAM=;
        b=Z3qvItiCtatvaYWcOYn8IPjr6Fi1GaQOjGA3I78O409cYtJWk2VL3lgBN+TEVhroCg
         6oIbPdXprDLipc3PMIRIZ2nJIjwg9To1EhQRBjKDyuH+57alI7TmFIDNCvIhaEZmSDc4
         DTsg4ExaX12a0hkSWHlt/DpUy0SOAtBvTA8HpB3qhEXDzYS4CoAJcdNzjV41svKsVnio
         PRHdYdd8GFnkjM0K/exxY8tOOMvilyQa6OcnkobUSwyJQupGUQP9lU4oYgoPwUdsIHbe
         ZnOOA9McqWlaqcY3EpgZmRSPtMjzI2uyCui1q9sx3xTZ8OsnP3T8uvs49fu2+ishnp/U
         0Rrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719588259; x=1720193059;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UyhUDNd2cxLPE3+2Xa0aiyHUJwN9W1K/tIImYyLqEAM=;
        b=E7ASR84IVXDXXJ51w67yPrJ6bidGiTKgxdPficUxyYEaJvnUMi16563LnIIf8TAwpL
         xKhkjd/u5MLpvlibKW/ZuW3RFttLHDHcM5hOsuWMs+rtA1Gvyl989X7wkQDVbslK43c8
         gBWQTi9rrBFYPSQp9tqt1ocO2PPgwqKDLmjW4LSdyamwchhT4C6JpnD7l+4xh0aj/8xJ
         KmGz8NYFCz76lYHC/MC5YuZ2z4Oqk+o6l1XMMIPAojn+qiJSPpPL161yBkKRgDrpA2yw
         C2mWeqyZedMzuxDgUPKq8DOmxIaquKc7N6TbhTG5bJPIyVuiQgTZZAW4OrdytRFvVrNa
         X+GQ==
X-Forwarded-Encrypted: i=1; AJvYcCXFfmnjgPrRFU7V+GnQzgQPOfJP6T55DNw7gQVBvkJHllUAjRUeBR+F7OtSZYRJs+HpL/tF5xvQFMGQwR2Oj6Bk9yv89N6ZUT/dzCb9qDpeNNZQQh6VQM57w9JaeIO6soBO4qOBRsQdtilh/vsDLkG//P83q77thftAx+arR495y5YZeHY=
X-Gm-Message-State: AOJu0Yy+dF7dW6n7UATvA7A7iicLVJjVhtnF/AAyvdPGR/bRc28L3GLK
	wTuEGTqD8QtnjU09EvxstZ5xILVuAxrY9/fM/baFaYCA6zpoe2q4
X-Google-Smtp-Source: AGHT+IHg5M76Ad7N6AJt7tENSmeLfZGVCsP9tkhiUlBsWSzuzsGhyJIFqnALq5yXkUnyFjWSPpsF2w==
X-Received: by 2002:a17:906:a847:b0:a6f:6721:b065 with SMTP id a640c23a62f3a-a7245bb25e6mr1244135866b.32.1719588259199;
        Fri, 28 Jun 2024 08:24:19 -0700 (PDT)
Received: from iris-Ian.fritz.box (p200300eb5f2e9b00e0c268ab7636554b.dip0.t-ipconnect.de. [2003:eb:5f2e:9b00:e0c2:68ab:7636:554b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a72af0c9d06sm69644166b.18.2024.06.28.08.24.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 08:24:18 -0700 (PDT)
From: iansdannapel@gmail.com
To: Moritz Fischer <mdf@kernel.org>,
	Wu Hao <hao.wu@intel.com>,
	Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko.stuebner@cherry.de>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Sebastian Reichel <sre@kernel.org>,
	Chris Morgan <macromorgan@hotmail.com>,
	Michael Riesch <michael.riesch@wolfvision.net>,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
	Andre Przywara <andre.przywara@arm.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-fpga@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Ian Dannapel <iansdannapel@gmail.com>
Subject: [PATCH v2 3/3] dt-bindings: vendor-prefix: Add prefix for Efinix, Inc.
Date: Fri, 28 Jun 2024 17:23:48 +0200
Message-Id: <20240628152348.61133-4-iansdannapel@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240628152348.61133-1-iansdannapel@gmail.com>
References: <20240620144217.124733-1-iansdannapel@gmail.com>
 <20240628152348.61133-1-iansdannapel@gmail.com>
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
index fbf47f0bacf1..6175719c1fb6 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -422,6 +422,8 @@ patternProperties:
     description: Emtop Embedded Solutions
   "^eeti,.*":
     description: eGalax_eMPIA Technology Inc
+  "^efinix,.*":
+    description: Efinix, Inc.
   "^einfochips,.*":
     description: Einfochips
   "^eink,.*":
-- 
2.34.1


