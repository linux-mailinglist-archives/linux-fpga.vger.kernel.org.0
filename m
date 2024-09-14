Return-Path: <linux-fpga+bounces-709-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6035979343
	for <lists+linux-fpga@lfdr.de>; Sat, 14 Sep 2024 22:02:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7350E1F21AA7
	for <lists+linux-fpga@lfdr.de>; Sat, 14 Sep 2024 20:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 343AE81742;
	Sat, 14 Sep 2024 20:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mpHylvlL"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A33771E871;
	Sat, 14 Sep 2024 20:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726344137; cv=none; b=eHbMNqEjcumWp8gAYjESg5Y8NUNwgX8v16ZtI4gLSd3/CCmS0WoO/5i2zIYdh5NlgI5s5kHQVecRzceNs8p09fLahHSxCtp4IkW1LYfaxG45ogOun7ci5T24VC72ZmPpig3D+Qc7wAq8TR4boN1KlsXZHE22AwE/q4+VfsVMwHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726344137; c=relaxed/simple;
	bh=9dUVbpJW4jJWQSo4KncGy0kT7E4QJ5g8bT5H/USDW+A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ex/JsEPSfkkbJx9dKQsBzLSAwTI5kCVD+6/SsmNX7+iUvhhN/X3vmEyWpOIg8LzhmNa8cowXn4xculcHjfLxpL3LbS375HgFe9MyVp8E/OC1g6KuecDDrDFhgZNP7OWz6Vl2S/yRKCskM6pdb5FFlMzlhqgp/0jh0jxniTpSoCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mpHylvlL; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-719232ade93so1698763b3a.2;
        Sat, 14 Sep 2024 13:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726344135; x=1726948935; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+Ofo5pDJUYMQ24jBO69i/k0FFrvSqnqt1LUGg2quvt0=;
        b=mpHylvlLJmWtqGxCiT1qTYfVt+v4hNzq41wnh90L+i/ZePi32W1bR8ShhCAJaSHCbA
         VabUxWXErZxRuAhUUgDYELVUYCEZkuHnGLBkhuv8zb8WL2gWcpD7d6agbmbERBISZTCO
         5UM2W9hIGplMKiZPApmazZo+4sGiM+kSYtFUW9uavHzB206aV0Zjem2VzB6Cq38/ISZS
         mwW/jrKjrXXytOOhtcbNPQoUtBRlG0qX3OHfojexAYK6Idh8CewaMkc2+DqSRaMMfq7H
         0Aj4mlOEbjWD/kYGKKZuswdwx00KemabR7PnPzQ10uPvHqybNy41HR9BBt847nTUMqPo
         DtsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726344135; x=1726948935;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+Ofo5pDJUYMQ24jBO69i/k0FFrvSqnqt1LUGg2quvt0=;
        b=FXnTf/cIMpyyKizOw29BQWraqejAbx9uK2/zVgk23i7msbleFBSzygsYVP/g6tTkMF
         9Ae9IqCy+iWJIwCyeV2nBETBmiQHIgXtWWokG/dnuJwUT4VcqOqvM6Ll1pls1glFTOoa
         GuJWpvZOdOeAREIIdC2mj1mClKo7QXgWgSNFe+WXbvdWKqxyp3Ll/K+OD3BdfbCl8IFJ
         kxQpQ3Q/a0aqNz+by/lzdiRoeRElFFbT32J40OrYl3bg8EZV51P53Bay5jxWX7EpSKjQ
         UukJbJXTBuXKrOdC31hstHZ10akGPHr7JRW6EIkvhVTVru6Hedgm+xb1YiNGu+gY6+E7
         apWg==
X-Forwarded-Encrypted: i=1; AJvYcCW4ICTOh6M7q0bm5DZhiSLi3tEtm8ee3t2aBifDbcyTafhvymKIRqoGmZA4nQBcS1+qOmSPoRvtobwIlQ==@vger.kernel.org, AJvYcCW55a724McfVOaqYLz2+R4uIrnjAvd1bvO2kmpW7JQ7T9bvgalZXmNCKhuK+r92PK2uvzQOhaYxUO6q@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8oizcfN6P2wC3Dt8HXLC0UKdrd3I7jriDEBJ0OwHAVVqp3Qfk
	FcEJQ2j5Z2enGeS/zwgAWqN4abJ2+jXnf8X0jN/CB6f/a0UMW8Bg
X-Google-Smtp-Source: AGHT+IEMXkGjnSf/8jktgEXXH/mMx/PLgKE6boDJZMCNK6utrJl9U8qLPHYhjNw0UMCKFI5OBnaSuw==
X-Received: by 2002:a05:6a00:b56:b0:718:532f:5a3 with SMTP id d2e1a72fcca58-71936a4b630mr12612667b3a.7.1726344134725;
        Sat, 14 Sep 2024 13:02:14 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:9233:d58b:c846:bbf8])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7db49992582sm1527723a12.74.2024.09.14.13.02.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Sep 2024 13:02:13 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: mdf@kernel.org
Cc: hao.wu@intel.com,
	yilun.xu@intel.com,
	trix@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-fpga@vger.kernel.org,
	devicetree@vger.kernel.org,
	Fabio Estevam <festevam@denx.de>
Subject: [PATCH] dt-bindings: fpga: altr,fpga-passive-serial: Convert to yaml
Date: Sat, 14 Sep 2024 17:02:05 -0300
Message-Id: <20240914200205.2472262-1-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fabio Estevam <festevam@denx.de>

Convert the Altera Passive Serial SPI FPGA Manager binding
from text file to yaml format to allow devicetree validation.

Signed-off-by: Fabio Estevam <festevam@denx.de>
---
 .../bindings/fpga/altera-passive-serial.txt   | 29 --------
 .../fpga/altr,fpga-passive-serial.yaml        | 74 +++++++++++++++++++
 2 files changed, 74 insertions(+), 29 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/fpga/altera-passive-serial.txt
 create mode 100644 Documentation/devicetree/bindings/fpga/altr,fpga-passive-serial.yaml

diff --git a/Documentation/devicetree/bindings/fpga/altera-passive-serial.txt b/Documentation/devicetree/bindings/fpga/altera-passive-serial.txt
deleted file mode 100644
index 48478bc07e29..000000000000
--- a/Documentation/devicetree/bindings/fpga/altera-passive-serial.txt
+++ /dev/null
@@ -1,29 +0,0 @@
-Altera Passive Serial SPI FPGA Manager
-
-Altera FPGAs support a method of loading the bitstream over what is
-referred to as "passive serial".
-The passive serial link is not technically SPI, and might require extra
-circuits in order to play nicely with other SPI slaves on the same bus.
-
-See https://www.altera.com/literature/hb/cyc/cyc_c51013.pdf
-
-Required properties:
-- compatible: Must be one of the following:
-	"altr,fpga-passive-serial",
-	"altr,fpga-arria10-passive-serial"
-- reg: SPI chip select of the FPGA
-- nconfig-gpios: config pin (referred to as nCONFIG in the manual)
-- nstat-gpios: status pin (referred to as nSTATUS in the manual)
-
-Optional properties:
-- confd-gpios: confd pin (referred to as CONF_DONE in the manual)
-
-Example:
-	fpga: fpga@0 {
-		compatible = "altr,fpga-passive-serial";
-		spi-max-frequency = <20000000>;
-		reg = <0>;
-		nconfig-gpios = <&gpio4 9 GPIO_ACTIVE_LOW>;
-		nstat-gpios = <&gpio4 11 GPIO_ACTIVE_LOW>;
-		confd-gpios = <&gpio4 12 GPIO_ACTIVE_LOW>;
-	};
diff --git a/Documentation/devicetree/bindings/fpga/altr,fpga-passive-serial.yaml b/Documentation/devicetree/bindings/fpga/altr,fpga-passive-serial.yaml
new file mode 100644
index 000000000000..ffb7cc54556f
--- /dev/null
+++ b/Documentation/devicetree/bindings/fpga/altr,fpga-passive-serial.yaml
@@ -0,0 +1,74 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/fpga/altr,fpga-passive-serial.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Altera Passive Serial SPI FPGA Manager
+
+maintainers:
+  - Fabio Estevam <festevam@denx.de>
+
+description: |
+  Altera FPGAs support a method of loading the bitstream over what is
+  referred to as "passive serial".
+  The passive serial link is not technically SPI, and might require extra
+  circuits in order to play nicely with other SPI slaves on the same bus.
+
+  See https://www.altera.com/literature/hb/cyc/cyc_c51013.pdf
+
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+properties:
+  compatible:
+    enum:
+      - altr,fpga-passive-serial
+      - altr,fpga-arria10-passive-serial
+
+  spi-max-frequency:
+    maximum: 20000000
+
+  reg:
+    maxItems: 1
+
+  nconfig-gpios:
+    description:
+      Config pin (referred to as nCONFIG in the manual).
+    maxItems: 1
+
+  nstat-gpios:
+    description:
+      Status pin (referred to as nSTATUS in the manual).
+    maxItems: 1
+
+  confd-gpios:
+    description:
+      confd pin (referred to as CONF_DONE in the manual)
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - nconfig-gpios
+  - nstat-gpios
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    spi {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      fpga@0 {
+        compatible = "altr,fpga-passive-serial";
+        reg = <0>;
+        nconfig-gpios = <&gpio4 18 GPIO_ACTIVE_LOW>;
+        nstat-gpios = <&gpio4 19 GPIO_ACTIVE_LOW>;
+        confd-gpios = <&gpio1 6 GPIO_ACTIVE_HIGH>;
+      };
+    };
+...
-- 
2.34.1


