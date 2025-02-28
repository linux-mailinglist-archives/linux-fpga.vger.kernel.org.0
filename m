Return-Path: <linux-fpga+bounces-1069-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CAEE3A495BA
	for <lists+linux-fpga@lfdr.de>; Fri, 28 Feb 2025 10:48:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9A7516369D
	for <lists+linux-fpga@lfdr.de>; Fri, 28 Feb 2025 09:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19CA425A642;
	Fri, 28 Feb 2025 09:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T1n8CRG7"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B45325A2DC;
	Fri, 28 Feb 2025 09:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740736067; cv=none; b=AyynYp8pVmP6KBNqX9lhHpF0ly1ZCovVHACLyXkMgqTFoSPqilHLW59evwjeHT1kwhMJRs018bFtvluSWGinWfI3LEWEAq1XHEzYWoPT6Zh9jtWqOCF6ESq7LPCgfpxsO6gAP8MDEwRVPF3KNF16SBnpIBzE5ek7c48Sjpi0ZVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740736067; c=relaxed/simple;
	bh=vWvF2ZI+n2vE//e/l0wi+I6GjILmE6L2iI7dQYd0HAY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NHhK3OWwF6UvIH/bw4ExY/61w4zgOZdkoiyPQUadN2drRQdktEVw4vjLBNdUh07Qp78Hq12CgOKzOeiQBYvQP62nllZxvjkaG2u8p6cumNyLKg3Ib5CcmG4kZxfVgxvEpey0PVTWGGuHSt0Mnx6jwiKXcN9evpVqau2hy93YN3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T1n8CRG7; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-abb9709b5b5so350521366b.2;
        Fri, 28 Feb 2025 01:47:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740736063; x=1741340863; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1YAdukzSAgHdk2sS0mm2OdNyl67yRSrsTC7t2Je3PGY=;
        b=T1n8CRG7lordd51O/cZl0p1xlLPb6XlewVauLnssWFTDVLUON4G2wbC+Cz6hP5FHA5
         VUCAZkHnFFpMpILKL6mSVtxNihq4V70Vtg96OQXZjqD8EeF30nvC0EaP/KGfBYtlPc8e
         L0j88u2UOOJ7dzPfdxkYJSjBsuhC3d10lKb+NCu4I+/f2Ak9M6fs2/kmlxNpyTTkZcRk
         IKIxBMB+y2F4/FBREBUa1UwJyIRwmV2+WURCtzgm5AcGvgBQD6jHuO6n/dLgCKKH+TF3
         x2hQuwdQRuPUE4rDQ5N05Rfto0EaZoBQb5WmaU7lm+ETryq4HRfV4txwRs1iAc/VtK61
         9ckw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740736063; x=1741340863;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1YAdukzSAgHdk2sS0mm2OdNyl67yRSrsTC7t2Je3PGY=;
        b=VuzZg+3HlgSEMRY9rT44A/LE1o9d8ZA5ixHp47Hi5N6nLJXod8QDAKz7PvKNPHB7mg
         N9J/sS2TRY6P84uzOl4+beNKz6pGlwHGBNgF4u57fc6fQfTgShsKSatZ3+7LncWBjq4x
         cwcMatkynsnQmKF9V3IcWfUAW8hKNXTtcI8MuWoQp59EogmXqONF5IRXw0dVG3cHbqBi
         +ItVgEmkROVMnkRnz4xh+tFapFpZ3zbov0Qx2tNt8K8ssEtQnzC3/MkvfmWaJ0WjYD7l
         32JAUZ4R4YnZfopynA7f3nY6qJwPiKRcYQ8Ghx7IZfigYVlJBw/4FciaMuejK2tttToB
         L9kQ==
X-Forwarded-Encrypted: i=1; AJvYcCWwe+BBB3uQIblwKcKM1U9McdyRM0QzTIu2AidLQxNFFUpUMUCmWtyqAE8cKH7u22TC+yBvS/2jiPJT@vger.kernel.org, AJvYcCX6/mzAM1HrkGHcrncef2DZDpfI10rtAyewvnE7b1mfyXfJZDAFR0PlwVyK1ZhHjSPKkhFsIuzmnyPcULBl@vger.kernel.org
X-Gm-Message-State: AOJu0YzhXwg03sHe+tY9c/6UeM160dsEzMMtsmq5Z1Q5Yn8kJI1Rmq2L
	zHkL64DkpnGgjekYOIbCND4Fenl0E8OqoSBi9iPp8FFPd3F95xMQDRR4LUFO
X-Gm-Gg: ASbGncuDEKqN4mvoS43QfQQsoFJWk+jA9oBIauX+eVDsfpVCoLLQJz3Im8+6JD+b0iN
	mZn1sD7g2f8LAdlOGxGOa2D6dFUAZg7l0gY6Ac6KkbV0iw3x8QjRB4zkNJzzxqS4GoXtsaEONsJ
	wsjnBAoXUaAzMby9qSTdv2bplPhqJz+KoHxsdXYLb9S1os3jCqZMOVfSH5eznVv+rm0U43FyHo8
	XBKRW/TnLXiBD4cQsZQyhxuAoFQmR2TIqH8uiwqu16ihHxYsOpwSuUEtggA1NllrJWprO7KfwAK
	/o+Wzi7WM6T2nZgX0C6vI28vsBIFdwi9kD9FkVhyuLc/ZL7HI16hizmxezJNVuBPM7A5SJahakn
	5EucDNIjaBsUcJtp4Gb64Mw==
X-Google-Smtp-Source: AGHT+IEocoSJArtJfL7oXc0bfmdynmPuxtZSNQ/1636Uc3XtvWgXbJeqnjFOB/x/j6STYBxXwjSLqg==
X-Received: by 2002:a17:907:1b09:b0:ab7:1012:3ccb with SMTP id a640c23a62f3a-abf25fb45b1mr234732566b.14.1740736062938;
        Fri, 28 Feb 2025 01:47:42 -0800 (PST)
Received: from iris-Ian.fritz.box (p200300eb5f0300004dcedf2362c26f55.dip0.t-ipconnect.de. [2003:eb:5f03:0:4dce:df23:62c2:6f55])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf1a60de5esm209289566b.100.2025.02.28.01.47.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 01:47:42 -0800 (PST)
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
Subject: [v4 2/3] dt-bindings: fpga: Add Efinix SPI programming bindings
Date: Fri, 28 Feb 2025 10:47:31 +0100
Message-ID: <20250228094732.54642-3-iansdannapel@gmail.com>
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

Add device tree bindings documentation for configuring Efinix FPGA
using serial SPI passive programming mode.

Signed-off-by: Ian Dannapel <iansdannapel@gmail.com>
---
 .../devicetree/bindings/fpga/efinix,spi.yaml  | 81 +++++++++++++++++++
 1 file changed, 81 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/fpga/efinix,spi.yaml

diff --git a/Documentation/devicetree/bindings/fpga/efinix,spi.yaml b/Documentation/devicetree/bindings/fpga/efinix,spi.yaml
new file mode 100644
index 000000000000..145c96f38e45
--- /dev/null
+++ b/Documentation/devicetree/bindings/fpga/efinix,spi.yaml
@@ -0,0 +1,81 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/fpga/efinix,spi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Efinix SPI FPGA Manager
+
+maintainers:
+  - Ian Dannapel <iansdannapel@gmail.com>
+
+description: |
+  Efinix FPGAs (Trion, Topaz, and Titanium families) support loading bitstreams
+  through "SPI Passive Mode".
+  Note 1: Only bus width 1x is supported.
+  Note 2: Additional pins hogs for bus width configuration must be set
+  elsewhere, if necessary.
+  Note 3: Topaz and Titanium support is based on documentation but remains
+  untested.
+
+  References:
+  - https://www.efinixinc.com/docs/an006-configuring-trion-fpgas-v6.3.pdf
+  - https://www.efinixinc.com/docs/an033-configuring-titanium-fpgas-v2.8.pdf
+  - https://www.efinixinc.com/docs/an061-configuring-topaz-fpgas-v1.1.pdf
+
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+properties:
+  compatible:
+    enum:
+      - efinix,trion-spi
+      - efinix,titanium-spi
+      - efinix,topaz-spi
+      - efinix,fpga-spi
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
+  reset-gpios:
+    description:
+      reset and re-configuration trigger pin (low active)
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
+  - reset-gpios
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    spi {
+      #address-cells = <1>;
+      #size-cells = <0>;
+      cs-gpios = <&gpio5 13 GPIO_ACTIVE_LOW>;
+      fpga-mgr@0 {
+        compatible = "efinix,trion-spi";
+        reg = <0>;
+        spi-max-frequency = <25000000>;
+        spi-cpha;
+        spi-cpol;
+        reset-gpios = <&gpio4 17 GPIO_ACTIVE_LOW>;
+        cdone-gpios = <&gpio0 9 GPIO_ACTIVE_HIGH>;
+      };
+    };
+...
-- 
2.43.0


