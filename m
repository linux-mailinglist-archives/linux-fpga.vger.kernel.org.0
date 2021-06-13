Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B434F3A5AA6
	for <lists+linux-fpga@lfdr.de>; Sun, 13 Jun 2021 23:34:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232106AbhFMVg2 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 13 Jun 2021 17:36:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232099AbhFMVg1 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sun, 13 Jun 2021 17:36:27 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A44F8C061766
        for <linux-fpga@vger.kernel.org>; Sun, 13 Jun 2021 14:34:14 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id l184so7084987pgd.8
        for <linux-fpga@vger.kernel.org>; Sun, 13 Jun 2021 14:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nigauri-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fQPf7c77rDLEgZ1NfrHpGynYMU3QOBuFHK0NQ0eYdKU=;
        b=I4rQb98ZvZq5VRimgDKX8o2Ui8lYV4llSJ0YifEcVtOgqrTvfjzLRH9BAJabux9iAh
         1XlE4M0C0WXnvoGFxr83//KgDLI1Z9Y8+9+Y8CEM4d7XndiarrMCCMunR/0H2kYRJn1d
         6dqXa+0BqIRIywGKqz8yh24Zy8ESSV0KHhBlGHEUrGkgyDmWqruftZYqg/qFKG2mLBfR
         5hScJ+JnWHyfhklaJYrblIH80QEPFOo601LMYILYXsOdmlb6ti4YSRpmCsJGISkgYPUc
         6Y47NiQPZaBUDoOB09SU+oUvVjxolyytF+EoaLg7Da3fjJgsvF3B0JsW8yG60VKmdAOr
         kXKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fQPf7c77rDLEgZ1NfrHpGynYMU3QOBuFHK0NQ0eYdKU=;
        b=ryNk5QSWJjngao3SI7as1nHBAdoHJng82HgcB2CZvcM0bNTfiCBimLUrgGBPRICy8U
         FQX5FFm+Ie9RBeK/fztkBX69lE7g3dC/vK8zWRndKXxW9BaDkHYvEUDocw+5brGYgVUI
         7+9TtdClQBxhIEvV3Yx0N2d9ddVpGc8EtKvHieM6ThkB9/rC2smk+QOzU+XVVsMLzSv0
         zTmd3RFM6yJUF6IxogOVeHbANTDmsDbPal9x18DSCD1Tf1nKd32dMYPPA7e8HGcKAgJY
         EoEpYYnllERgI2EiPsHxUXTuKWcalgBtjGeFBciCLz3eRGgQElrB6DxCQiCCozECjtf/
         FPgw==
X-Gm-Message-State: AOAM531Br9k/gj72ftD3fxWccW56UwOi+tc/awQxP7jX4McWbPPfHSiP
        BkyfLuRj5PxCucuPJPT3baJP
X-Google-Smtp-Source: ABdhPJyWTSUWdUGBSqjkId0mBIC3EQCsvBcw43h4nBlKyS3iBK9oYiPXKKT1n54KWv4cs0hnqBm+Vw==
X-Received: by 2002:aa7:8003:0:b029:2eb:2f8f:a320 with SMTP id j3-20020aa780030000b02902eb2f8fa320mr19168146pfi.70.1623620053936;
        Sun, 13 Jun 2021 14:34:13 -0700 (PDT)
Received: from localhost ([2405:6581:5360:1800:7285:c2ff:fec2:8f97])
        by smtp.gmail.com with ESMTPSA id 11sm10305193pfh.182.2021.06.13.14.34.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jun 2021 14:34:13 -0700 (PDT)
From:   Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
To:     robh@kernel.org, gregkh@linuxfoundation.org,
        michal.simek@xilinx.com
Cc:     linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-fpga@vger.kernel.org, shubhrajyoti.datta@xilinx.com,
        navam@xilinx.com, peter.crosthwaite@xilinx.com,
        soren.brinkmann@xilinx.com,
        Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Subject: [PATCH] dt-bindings: serial: convert Cadence UART bindings to YAML
Date:   Mon, 14 Jun 2021 06:33:59 +0900
Message-Id: <20210613213359.296400-1-iwamatsu@nigauri.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Convert serial for Cadence UART bindings documentation to YAML.

Signed-off-by: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
---
 .../devicetree/bindings/serial/cdns,uart.txt  | 27 --------
 .../devicetree/bindings/serial/cdns,uart.yaml | 68 +++++++++++++++++++
 2 files changed, 68 insertions(+), 27 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/serial/cdns,uart.txt
 create mode 100644 Documentation/devicetree/bindings/serial/cdns,uart.yaml

diff --git a/Documentation/devicetree/bindings/serial/cdns,uart.txt b/Documentation/devicetree/bindings/serial/cdns,uart.txt
deleted file mode 100644
index 4efc560f90abbd..00000000000000
--- a/Documentation/devicetree/bindings/serial/cdns,uart.txt
+++ /dev/null
@@ -1,27 +0,0 @@
-Binding for Cadence UART Controller
-
-Required properties:
-- compatible :
-  Use "xlnx,xuartps","cdns,uart-r1p8" for Zynq-7xxx SoC.
-  Use "xlnx,zynqmp-uart","cdns,uart-r1p12" for Zynq Ultrascale+ MPSoC.
-- reg: Should contain UART controller registers location and length.
-- interrupts: Should contain UART controller interrupts.
-- clocks: Must contain phandles to the UART clocks
-  See ../clocks/clock-bindings.txt for details.
-- clock-names: Tuple to identify input clocks, must contain "uart_clk" and "pclk"
-  See ../clocks/clock-bindings.txt for details.
-
-
-Optional properties:
-- cts-override : Override the CTS modem status signal. This signal will
-  always be reported as active instead of being obtained from the modem status
-  register. Define this if your serial port does not use this pin
-
-Example:
-	uart@e0000000 {
-		compatible = "cdns,uart-r1p8";
-		clocks = <&clkc 23>, <&clkc 40>;
-		clock-names = "uart_clk", "pclk";
-		reg = <0xE0000000 0x1000>;
-		interrupts = <0 27 4>;
-	};
diff --git a/Documentation/devicetree/bindings/serial/cdns,uart.yaml b/Documentation/devicetree/bindings/serial/cdns,uart.yaml
new file mode 100644
index 00000000000000..ce467fa464bfd0
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/cdns,uart.yaml
@@ -0,0 +1,68 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/serial/cdns,uart.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Cadence UART Controller Device Tree Bindings
+
+maintainers:
+  - Michal Simek <michal.simek@xilinx.com>
+
+allOf:
+  - $ref: /schemas/serial.yaml#
+
+properties:
+  compatible:
+    oneOf:
+      - description: UART controller for Zynq-7xxx SoC
+        items:
+          - enum:
+            - xlnx,xuartps
+            - cdns,uart-r1p8
+      - description: UART controller for Zynq Ultrascale+ MPSoC
+        items:
+          - enum:
+            - xlnx,zynqmp-uart
+            - cdns,uart-r1p12
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 2
+
+  clock-names:
+    items:
+      - const: uart_clk
+      - const: pclk
+
+  cts-override:
+    description: |
+      Override the CTS modem status signal. This signal will
+      always be reported as active instead of being obtained
+      from the modem status register. Define this if your serial
+      port does not use this pin.
+    type: boolean
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+
+additionalProperties: false
+
+examples:
+  - |
+    serial@e0000000 {
+      compatible = "cdns,uart-r1p8";
+      clocks = <&clkc 23>, <&clkc 40>;
+      clock-names = "uart_clk", "pclk";
+      reg = <0xE0000000 0x1000>;
+      interrupts = <0 27 4>;
+    };
-- 
2.32.0

