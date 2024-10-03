Return-Path: <linux-fpga+bounces-752-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BA6C98ED35
	for <lists+linux-fpga@lfdr.de>; Thu,  3 Oct 2024 12:42:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E613EB20B44
	for <lists+linux-fpga@lfdr.de>; Thu,  3 Oct 2024 10:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AAFD14E2CC;
	Thu,  3 Oct 2024 10:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VW6RQD/l"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F87113A24A;
	Thu,  3 Oct 2024 10:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727952169; cv=none; b=XwNw3jDOuQ09rQdkgZHtcwk3BC7VtvuxH4F+DfaW/xK/G06FAJAxloTl4lIFYs68Jx0mSUYQlw3TJE72/kaUoIBCe6ch9epox5FO8qDH3K5dkY1cDwpAbW1M5gZiu/US8e9Ct04/OB7gnMvOVkC4OwyujeKhrNHKxDXTVlrtLyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727952169; c=relaxed/simple;
	bh=1z1JGA6U/odpvegzu5+AYDKhQPlTvvq6gUhBfx3KIQ4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mlSR4JIa/UfB3PqFls+3QFeb+fvMBgIkmcNptqCpysacEEOrQ3sSgFb+CCqO7FfpkKUDDotBlZttRBNv79Kkq6phDtWtOwqILwuIhphkknRZEi/ijNEv6+lzCf35zqiuZn4z3ydTPO9Bc3rIpBtb89+i1Pyn7Gc8EFoceG83S+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VW6RQD/l; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7db90a28cf6so1263223a12.0;
        Thu, 03 Oct 2024 03:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727952167; x=1728556967; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ujiQHahtbaEY1X1bz4oE4Y4jHXdqg8dZdzZ+KxxOoFs=;
        b=VW6RQD/lu2Hc1X5BzAxYmSh9Jv5dm4DBW+EuxeQ+MG3Bi8Rd8q5NElB3uyUlhLEJLE
         SsM0gRzpqL+bWs3t7Psk8pZ8zewRwKFwKG8+890FZ3zMTuTBS0sEOwR8tw1QfZnNpR/v
         SmQxEriy12wYePUu8Xn+14ecboy0J6jLjPnsUuKV4MgNyLE1vf665nTxhES2Pb2KA7K9
         lAWqeu7ZC9Xqdn97ABPwOA29fCnMxBxYyng98Dwb+dFpV7PY5dbee+NlloYE0z3JZEdE
         UFT9A2Ma2w8R52ujiaUb5BwAWIp08FXUTeAHr6N5AIxOua1hyIg63NH4iNJ/SdU1m+Sm
         XuZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727952167; x=1728556967;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ujiQHahtbaEY1X1bz4oE4Y4jHXdqg8dZdzZ+KxxOoFs=;
        b=e4VPYstGxnHakMFFViTX0JWw2yCAJa5oPFzJXrvuFbGS7sKc5P6c9/KCikdBgLA74E
         zEeqjj0w8zxQNUGdtprpdCq1ZN5Ia6VKfRhBZmbVYmVznUKGLKEPJkbNoGpklheKoI9h
         ojkjZNgpxiezLgRUKRLCr5hRdfWTMFb5803cXs4gWqFLb1VzHzAMeDNoxSU1pT/XhCKr
         KHJLt7/p9Y8U89/7JS8mqy14eYkp+JupuLtJB4/o1JzWkssloFolJOYYp/VOsTbAWlTv
         oK0A8fIPBy7Noa1Kn1UFrQip6lZ5rIxdT8Mrwy/MWvEndm2rOmrXL7bNPFt3i+zAmAbP
         sbKw==
X-Forwarded-Encrypted: i=1; AJvYcCV+WPYLUqemy/P+j4+LU0Io+RcLMPYbEgpfgW/HuxpmXgvHfCkpvdZvYAb5JUNkhnUjBXrvy2aFnHg5@vger.kernel.org, AJvYcCWNDzniV+FeYgQlF1/h+Um/dm4gFtwJkEaPk0e7wILlz5rhJ1U6e/EAC9cZcBT7uCSjZ0H50Z+Uis1adA==@vger.kernel.org
X-Gm-Message-State: AOJu0YziDDHbbQaQn+B7NzdH7qYgz2JDP8zQF6OpqQmNIOUK6ZEGA8sS
	LFriNwPHHLGpwhPbDncXdy5qA5C2l5TDDmNeIvx09ZgIw7CMYrpuW6tU5g==
X-Google-Smtp-Source: AGHT+IFvxzNhIvczmb9INlw6qh/XNIabnid1kXj+lxTj6P0lKEG5/6WZHr/RmAq10UNUB9G6M9KFnA==
X-Received: by 2002:a17:90b:148f:b0:2d8:7445:7ab2 with SMTP id 98e67ed59e1d1-2e1b392f6e7mr3370317a91.20.1727952166770;
        Thu, 03 Oct 2024 03:42:46 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:b9a4:a119:38d1:3e69])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e1bfb1c102sm1228285a91.23.2024.10.03.03.42.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 03:42:46 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: robh@kernel.org
Cc: krzk+dt@kernel.org,
	conor+dt@kernel.org,
	mdf@kernel.org,
	hao.wu@intel.com,
	yilun.xu@intel.com,
	trix@redhat.com,
	linux-fpga@vger.kernel.org,
	devicetree@vger.kernel.org,
	Fabio Estevam <festevam@denx.de>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH RESEND] dt-bindings: fpga: altr,fpga-passive-serial: Convert to yaml
Date: Thu,  3 Oct 2024 07:42:30 -0300
Message-Id: <20241003104230.1628813-1-festevam@gmail.com>
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
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
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


