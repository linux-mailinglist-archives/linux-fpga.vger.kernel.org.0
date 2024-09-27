Return-Path: <linux-fpga+bounces-738-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1142A9886BF
	for <lists+linux-fpga@lfdr.de>; Fri, 27 Sep 2024 16:15:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 900F71F22D3C
	for <lists+linux-fpga@lfdr.de>; Fri, 27 Sep 2024 14:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F572136326;
	Fri, 27 Sep 2024 14:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NC28D+2z"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE1D08175B;
	Fri, 27 Sep 2024 14:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727446495; cv=none; b=CdIWIc8qD8dGEix70MMR0BGZ8awmBfkg7bOExPH8JiDx+BSsOqzdPlmmyeYxNMN5NH+qFlOnvctTsStnoXa2KgxOJ13mplEde0sFViBvn4cSuTnpX4Hob77OzqDzpOr40gVBAde+3MfmjCSK+1mX2C4KJv2XtMLWFG+2awEkrU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727446495; c=relaxed/simple;
	bh=vMHdXezo8F6NytIi0yVum/WQLuQ1mWg0no4EG5bxbc0=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DPXGGEuqR/JrgPcuqqCf8JZmbQiOBPPw1+bB+Pjygzxgilm8TR7ghS5BPO5bTLXW8vBUQmkiau7aDtxuXf9tolSfofF5pC4doDVe1XvynCvN0FmBhd4tnqUN7qhEqsmj4SNrhL+1y530775PJ4yQD2Kh/DSUw2x075HRJLUnrSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NC28D+2z; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5c26815e174so2708244a12.0;
        Fri, 27 Sep 2024 07:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727446492; x=1728051292; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bkWDrxtzPAW+5+5JFN9vXC+mzeQg0UTeJoT6Itk6ArM=;
        b=NC28D+2zDqBRZVx3X240kanRxaMbtSXgAUZyM6Hs+w0z0+ar473iV4MS32gczHnLXI
         FkbfuaCzLie5BzVlwzuD73sbhnYqQ1tcZJ/0utGHvliRh0qkPIf0a+7TksFF9yckOgaK
         PpT0SlBOJL613eBaZC23qVNvGAiwfk40wKbsa+DucybUsHragtiz9AUPJVZ1riWDZivG
         xtI7vwRj35Zzk/oB7KiFT0ZwPtSSEx7nBVm7b2I5chS8s/UiV82MOy78vJzSv+2IimGk
         7UnqaZb7qqKySUeBTYTsubU8T2TYrFYPzX9HzCk8I+e1e0DuaizbYetFn8b0ghCqvP+b
         NXIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727446492; x=1728051292;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bkWDrxtzPAW+5+5JFN9vXC+mzeQg0UTeJoT6Itk6ArM=;
        b=WEUXvz0BESpdyyewmmWc5OBisG/GIy6uct99o/PuQSks2WmSWsdVeNFEkBpWs7bD1v
         wJWoXeyxyfbOnad8StIATid/jPv0x4P8PYypPd8KFKkid9I+841pYZeN1VgQm+owbFzZ
         xUZZBzykOp08Y/mVDjp7BZ/MPH3Qef/+7jbMeagIi2BWxyEa7djkdLrkyu5PBDyV9Yxk
         kEi6E8DTqB5jampdRP/zw/3j88D2r+WHFaW9fZ/sdS0P/XZjDQbzFycRYvHw7DaVfEqA
         46B1zM87ABf7LXG33wCmREC2+W0oqOnjDj4Nh5ElcxvP5QzD7Z1ymS2I+zI/XMG025Oz
         kQWw==
X-Forwarded-Encrypted: i=1; AJvYcCUPOgZ1a5B+BMvZ8nOMlW22QX5M+EVzfvaKhriErYTktKT1AqaGrdP8jmgnsWG/ji1DuZCrxwiIDIdCyJjo@vger.kernel.org, AJvYcCUiN0SpuF5tAo/t+Lu7c6j9hKmbVeOHswGvNS0jNn9f6AXQMrGhL7OWpNSMox6YXkiduZKsuGoWp249Kw==@vger.kernel.org, AJvYcCW550zqHk+umkfy/4OhQZRQ5i0KgUBiRw9+YvI0wMJC5Yv/7IM70b2Jmsn0GMsn2dmSUEZSoe5bwNsn@vger.kernel.org
X-Gm-Message-State: AOJu0Yxtc9OM2hljwOslIQO5UCE/crJBbxZUcEIPCIvZcZXQNXQE4Ou0
	HC7LlKHMo7elVApWxjRh8glVJwY07pkIQO8goZll4/ADPrDrbGYl
X-Google-Smtp-Source: AGHT+IFFiPrpsZ8zE8pgQpl9fyuJ59VucFBfawSTkII78dFLJg7RDgX50vDzgkxINpW6j1+5lUnBQA==
X-Received: by 2002:a05:6402:2318:b0:5c5:c060:420d with SMTP id 4fb4d7f45d1cf-5c882603693mr2265124a12.25.1727446491890;
        Fri, 27 Sep 2024 07:14:51 -0700 (PDT)
Received: from iris-Ian.fritz.box (p200300eb5f4f030052bd6081d2396adf.dip0.t-ipconnect.de. [2003:eb:5f4f:300:52bd:6081:d239:6adf])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c88248af00sm1184519a12.67.2024.09.27.07.14.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2024 07:14:51 -0700 (PDT)
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
Subject: [PATCH 2/3] dt-bindings: fpga: Add Efinix serial SPI programming bindings
Date: Fri, 27 Sep 2024 16:14:43 +0200
Message-Id: <20240927141445.157234-2-iansdannapel@gmail.com>
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

From: Ian Dannapel <iansdannapel@gmail.com>

Add device tree binding documentation for configuring Efinix FPGA
using serial SPI passive programming mode.

Signed-off-by: Ian Dannapel <iansdannapel@gmail.com>
---
 .../fpga/efinix,trion-spi-passive.yaml        | 85 +++++++++++++++++++
 1 file changed, 85 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/fpga/efinix,trion-spi-passive.yaml

diff --git a/Documentation/devicetree/bindings/fpga/efinix,trion-spi-passive.yaml b/Documentation/devicetree/bindings/fpga/efinix,trion-spi-passive.yaml
new file mode 100644
index 000000000000..ec6697fa6f44
--- /dev/null
+++ b/Documentation/devicetree/bindings/fpga/efinix,trion-spi-passive.yaml
@@ -0,0 +1,85 @@
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
+  Warning: The slave serial link is not technically SPI and therefore it is
+  not recommended to have other devices on the same bus since it might
+  interfere or be interfered by other transmissions.
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
+      fpga-mgr@0 {
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


