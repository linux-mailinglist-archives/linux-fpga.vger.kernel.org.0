Return-Path: <linux-fpga+bounces-565-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 58B8A91C290
	for <lists+linux-fpga@lfdr.de>; Fri, 28 Jun 2024 17:24:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAA691F22121
	for <lists+linux-fpga@lfdr.de>; Fri, 28 Jun 2024 15:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17BB81C8FAB;
	Fri, 28 Jun 2024 15:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LP8PC4b/"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5403B1C68BB;
	Fri, 28 Jun 2024 15:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719588260; cv=none; b=bUHRkfxGKyo7fn8xWqL72lvjdSXy8tG6/9m7QZ+r+MBp90zYEljwltzJ+iRDuPL97s8ZF5LR/izFdERyvvZjdfnTnv7todCY0YiljTtdysZ2HWT5Zh38IKQ+BBJPYN9h8toq43O//hf9GtJ6xJapfsXeo+LOrHC2MYL8E+SD/ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719588260; c=relaxed/simple;
	bh=u7IYOMTzp9xREiAi4wg3Mj/pxSjba5iiHOxXxGrFGWc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pnKMUO4NjKMTy4Hw1LXf7iQLOvDgm6tcPsbLN0pHXT8ysQ3+jXAQFd2l2NE5yH0vsnSWvbmHzMxEqE6irecwsEmrjZp8VAh4taAqBb4WKLM4/cMy/+ngWg4ndDIFGIr6DjaOCxhry+5hd+jaqcUrPySm+r3EMYb84FMmQQ1Lx2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LP8PC4b/; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-57d1d614049so1034044a12.1;
        Fri, 28 Jun 2024 08:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719588257; x=1720193057; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g84bRW4nhMKxUt85kPwWVaoKgwu5Ry9pS3Tn/2CKkV4=;
        b=LP8PC4b/Td+JrfT5wORf6OUxEg+fTpsBZMVsEWJuMTjTXlpFIGKGNIrkNv8UjfvzVY
         /4NiXetIpAI9tgP9QiKyfZwV2//bSSLP008ExVJ/5zD3rUIPU/8dtJXkeZO92qc6DgJZ
         0jxxeSVtC0efsspLp0xTlHN9Gi0pjelnlTGs4cv9WgS/mpTKaAVYuzS42F2UfpZUnKKx
         8Pg2W0ODV4pvhx2dMFY5uPUYMngK8CdcI6Oj7qvvLaQ+ASS0DuQDEPPB+emDOK0nqyo1
         WM2j1yAqHu0nBWeXmzcfoqCarVadlLnAuZfzztnU1OhdsUHjqj6YZVHKTX9h035wbsGQ
         TycQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719588257; x=1720193057;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g84bRW4nhMKxUt85kPwWVaoKgwu5Ry9pS3Tn/2CKkV4=;
        b=n78wAjtV/qH0dJUEX+ThNqgyhodIW+c0yUIfGO75tyrSrfQPkw5G8jigcTU308m+af
         1VdnVHWc37qNPhG7dzN4LiFhGKG8rNpB2TVgDQnQaTWxiTbS74rjnYVBDjtSjVDA9gmN
         jCRFiAkS6Rk9+/H65Mp9ZzjOdB+MXU2iC2kseQDU16qpjuKoOpvkE0a7r9GgU2HCv3EH
         e0SP0v8zN0hwYVywim2G8HJxATYO8yg96f6ctWNUHZyJvFDFkBAUob4IOUN7MxKt9WBz
         GmHHdwFSdA18v3DMmF2Hj9E7vXzalmLeScbeqzqoWP8TILEGqhV+k1/xcGX/KdZhg7g+
         VTpA==
X-Forwarded-Encrypted: i=1; AJvYcCWZ+qzvyBqGLP14CXxHmTbvvaCzajAAasN8RmmFWQkAJZbBN/tCyMvtODPS/NCnYUbWM7hNC3dqpvnORn9luyYL7cxYHfDrlyffXHp4ScL3qQCR6Brsg3gwyIBGJ1q/4GpEVnroVIzU8cTDjcwbElghFhoxW2VeDamNZjJmd+bVJzzJOk8=
X-Gm-Message-State: AOJu0Yyk5YrYETNURSF6FuGDsA0DlHCxkEV1etmo14NHHSgFIViNy2IZ
	w6fMieSTBDgBZBtq//EB5xi8k71D0UPQxqgTBMQuwBfctJkntwqhXiL1DQea
X-Google-Smtp-Source: AGHT+IFN7jAipskD97GNCEauY07Bihj0lh+hHZxojUbtOj5vE8jdgonvZ72fKB4aBg7wup8Oo0MkuQ==
X-Received: by 2002:a17:906:591:b0:a6f:5f8f:6c43 with SMTP id a640c23a62f3a-a7245c809e9mr1209900066b.56.1719588256409;
        Fri, 28 Jun 2024 08:24:16 -0700 (PDT)
Received: from iris-Ian.fritz.box (p200300eb5f2e9b00e0c268ab7636554b.dip0.t-ipconnect.de. [2003:eb:5f2e:9b00:e0c2:68ab:7636:554b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a72af0c9d06sm69644166b.18.2024.06.28.08.24.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 08:24:16 -0700 (PDT)
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
Subject: [PATCH v2 2/3] dt-bindings: fpga: Add Efinix serial SPI programming bindings
Date: Fri, 28 Jun 2024 17:23:47 +0200
Message-Id: <20240628152348.61133-3-iansdannapel@gmail.com>
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

Add device tree binding documentation for configuring Efinix FPGA
using serial SPI passive programming mode.

Signed-off-by: Ian Dannapel <iansdannapel@gmail.com>
---
 .../fpga/efinix,trion-spi-passive.yaml        | 81 +++++++++++++++++++
 1 file changed, 81 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/fpga/efinix,trion-spi-passive.yaml

diff --git a/Documentation/devicetree/bindings/fpga/efinix,trion-spi-passive.yaml b/Documentation/devicetree/bindings/fpga/efinix,trion-spi-passive.yaml
new file mode 100644
index 000000000000..d44a9d0627b6
--- /dev/null
+++ b/Documentation/devicetree/bindings/fpga/efinix,trion-spi-passive.yaml
@@ -0,0 +1,81 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/fpga/efinix,trion-spi-passive.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Efinix SPI FPGA Manager
+
+maintainers:
+  - Ian Dannapel <iansdannapel@gmail.com>
+
+description: |
+  Efinix Trion and Titanium Series FPGAs support a method of loading the
+  bitstream over what is referred to as "SPI Passive Programming".
+  Only serial (1x bus width) is supported, setting the programming mode
+  is not in the scope the this manager and must be done elsewhere.
+
+  References:
+  - https://www.efinixinc.com/docs/an033-configuring-titanium-fpgas-v2.6.pdf
+  - https://www.efinixinc.com/docs/an006-configuring-trion-fpgas-v6.0.pdf
+
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+properties:
+  compatible:
+    enum:
+      - efinix,trion-spi-passive
+      - efinix,titanium-spi-passive
+
+  spi-cpha: true
+
+  spi-cpol: true
+
+  spi-max-frequency:
+    maximum: 25000000
+
+  reg:
+    maxItems: 1
+
+  creset-gpios:
+    description:
+      reset and re-configuration trigger pin (low active)
+    maxItems: 1
+
+  cs-gpios:
+    description:
+      chip-select pin (low active)
+    maxItems: 1
+
+  cdone-gpios:
+    description:
+      optional configuration done status pin (high active)
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - creset-gpios
+  - cs-gpios
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    spi {
+      #address-cells = <1>;
+      #size-cells = <0>;
+      fpga_mgr_spi: fpga-mgr@0 {
+        compatible = "efinix,trion-spi-passive";
+        reg = <0>;
+        spi-max-frequency = <25000000>;
+        spi-cpha;
+        spi-cpol;
+        creset-gpios = <&gpio4 17 GPIO_ACTIVE_LOW>;
+        cs-gpios = <&gpio5 13 GPIO_ACTIVE_LOW>;
+        cdone-gpios = <&gpio0 9 GPIO_ACTIVE_HIGH>;
+      };
+    };
+...
-- 
2.34.1


