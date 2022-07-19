Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A4DB579651
	for <lists+linux-fpga@lfdr.de>; Tue, 19 Jul 2022 11:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237203AbiGSJ0y (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 19 Jul 2022 05:26:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237179AbiGSJ00 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 19 Jul 2022 05:26:26 -0400
Received: from mail.pr-group.ru (mail.pr-group.ru [178.18.215.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96384205D1;
        Tue, 19 Jul 2022 02:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
        d=metrotek.ru; s=mail;
        h=from:subject:date:message-id:to:cc:mime-version:content-transfer-encoding:
         in-reply-to:references;
        bh=9lawGXSlctRioIAgWyzdnPUI+D9SXfpVriP3oerE2NY=;
        b=eXY+qxt6cVTLKLb6lgpSHn/Tze49zfYEczIGHgj3P6NaVuPe8ULYoOcz11eQF5AxkQw3coeiHFWJI
         5gTQMLLT0R4eR0weOmX7GaxHgUabeh/+4ZUdwhBSvMaTSn+xjyC632fN5QD8l7RXY8RgvsiGuaqbkW
         Q7T2bDcrP/NecUUAH6Ae7trPPS0K8axMzpMh+PzVEEP7HSmxjVskg5DrKyiCnb64kgAlR4LMb8Jok+
         XUKDlNpdmTHeXCUB9iDjX2zz9+onqDZrI1JbfI5zD9Y95XKWvs4IC7uyM6L1fbWB29p5LXi7U8zoJq
         MQX+CVk2sz7ccABy5tIGv0O3WsW78+g==
X-Kerio-Anti-Spam:  Build: [Engines: 2.16.3.1424, Stamp: 3], Multi: [Enabled, t: (0.000010,0.011320)], BW: [Enabled, t: (0.000020,0.000001)], RTDA: [Enabled, t: (0.113640), Hit: No, Details: v2.40.0; Id: 15.52k3pm.1g8asevbt.22i; mclb], total: 0(700)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Level: 
X-Footer: bWV0cm90ZWsucnU=
Received: from h-e2.ddg ([85.143.252.66])
        (authenticated user i.bornyakov@metrotek.ru)
        by mail.pr-group.ru with ESMTPSA
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits));
        Tue, 19 Jul 2022 12:26:10 +0300
From:   Ivan Bornyakov <i.bornyakov@metrotek.ru>
To:     mdf@kernel.org, hao.wu@intel.com, yilun.xu@intel.com,
        trix@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     Ivan Bornyakov <i.bornyakov@metrotek.ru>,
        linux-fpga@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, system@metrotek.ru
Subject: [PATCH v4 2/2] dt-bindings: fpga: add binding doc for ecp5-spi fpga mgr
Date:   Tue, 19 Jul 2022 12:25:39 +0300
Message-Id: <20220719092539.6748-3-i.bornyakov@metrotek.ru>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220719092539.6748-1-i.bornyakov@metrotek.ru>
References: <20220719092539.6748-1-i.bornyakov@metrotek.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Add Device Tree Binding doc for Lattice ECP5 FPGA manager using slave
SPI to load .bit formatted uncompressed bitstream image.

Signed-off-by: Ivan Bornyakov <i.bornyakov@metrotek.ru>
---
 .../bindings/fpga/lattice,ecp5-fpga-mgr.yaml  | 75 +++++++++++++++++++
 1 file changed, 75 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/fpga/lattice,ecp5-fpga-mgr.yaml

diff --git a/Documentation/devicetree/bindings/fpga/lattice,ecp5-fpga-mgr.yaml b/Documentation/devicetree/bindings/fpga/lattice,ecp5-fpga-mgr.yaml
new file mode 100644
index 000000000000..7d2bd386b533
--- /dev/null
+++ b/Documentation/devicetree/bindings/fpga/lattice,ecp5-fpga-mgr.yaml
@@ -0,0 +1,75 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/fpga/lattice,ecp5-fpga-mgr.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Lattice ECP5 Slave SPI FPGA manager.
+
+maintainers:
+  - Ivan Bornyakov <i.bornyakov@metrotek.ru>
+
+description:
+  Lattice ECP5 sysCONFIG port, which is used for device configuration, among
+  others, have Slave Serial Peripheral Interface. The driver is to program
+  Lattice ECP5 FPGA with uncompressed bitstream image in .bit format over SPI.
+  Only full reconfiguration is supported.
+
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml
+
+properties:
+  compatible:
+    enum:
+      - lattice,ecp5-fpga-mgr
+
+  reg:
+    maxItems: 1
+
+  spi-max-frequency:
+    maximum: 60000000
+
+  program-gpios:
+    description:
+      A GPIO line connected to PROGRAMN (active low) pin of the device.
+      Initiates configuration sequence.
+    maxItems: 1
+
+  init-gpios:
+    description:
+      A GPIO line connected to INITN (active low) pin of the device.
+      Indicates that the FPGA is ready to be configured.
+    maxItems: 1
+
+  done-gpios:
+    description:
+      A GPIO line connected to DONE (active high) pin of the device.
+      Indicates that the configuration sequence is complete.
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - program-gpios
+  - init-gpios
+  - done-gpios
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        fpga-mgr@0 {
+            compatible = "lattice,ecp5-fpga-mgr";
+            reg = <0>;
+            spi-max-frequency = <20000000>;
+            program-gpios = <&gpio3 4 GPIO_ACTIVE_LOW>;
+            init-gpios = <&gpio3 3 GPIO_ACTIVE_LOW>;
+            done-gpios = <&gpio3 2 GPIO_ACTIVE_HIGH>;
+        };
+    };
-- 
2.37.1


