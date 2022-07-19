Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34A2657985E
	for <lists+linux-fpga@lfdr.de>; Tue, 19 Jul 2022 13:26:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234762AbiGSLYZ (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 19 Jul 2022 07:24:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234527AbiGSLYX (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 19 Jul 2022 07:24:23 -0400
Received: from mail.pr-group.ru (mail.pr-group.ru [178.18.215.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45D1F222A7;
        Tue, 19 Jul 2022 04:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
        d=metrotek.ru; s=mail;
        h=from:subject:date:message-id:to:cc:mime-version:content-transfer-encoding:
         in-reply-to:references;
        bh=01VYwKsEP5PHOAwrwZ5OBrhS5+NLvCnbkbUBqarEJ4U=;
        b=BBRWYnznOVo2rw3xwGcOzPGXJz65vFDhaL7J6ZaY1LH/khmpF38zlpbuBpZ4fNZVUfHB/AAyCo085
         sHpB+JZ+VCUhGWE+0oapYJNsJ8hn0wlUE45ExH96afoTfMbndK8Zl+8JYd6i5uJaJbJoVkTVKZR718
         RGIg0Ks9BcX+FJZp4bbublI6SDB4bERBkbGCWnhNgq6fM+x7syar1rs53AVHKpe4JPKHCcJjEXg365
         yuDSmwCNZD8lA6H2xiRiTBIYa/e8rurGgbLQNugbv/M5Bvj4sCDQ7tfzzQ7Bh5DJVs7m74Xg5UjBKZ
         dqVkMFH5/3UpFy/8W7ptjDKVqezrXEw==
X-Kerio-Anti-Spam:  Build: [Engines: 2.16.3.1424, Stamp: 3], Multi: [Enabled, t: (0.000009,0.010963)], BW: [Enabled, t: (0.000016,0.000001)], RTDA: [Enabled, t: (0.072829), Hit: No, Details: v2.40.0; Id: 15.52kd5h.1g8b36uva.7a7; mclb], total: 0(700)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Level: 
X-Footer: bWV0cm90ZWsucnU=
Received: from h-e2.ddg ([85.143.252.66])
        (authenticated user i.bornyakov@metrotek.ru)
        by mail.pr-group.ru with ESMTPSA
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits));
        Tue, 19 Jul 2022 14:24:07 +0300
From:   Ivan Bornyakov <i.bornyakov@metrotek.ru>
To:     mdf@kernel.org, hao.wu@intel.com, yilun.xu@intel.com,
        trix@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     Ivan Bornyakov <i.bornyakov@metrotek.ru>,
        linux-fpga@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, system@metrotek.ru,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v5 2/2] dt-bindings: fpga: add binding doc for ecp5-spi fpga mgr
Date:   Tue, 19 Jul 2022 14:23:35 +0300
Message-Id: <20220719112335.9528-3-i.bornyakov@metrotek.ru>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220719112335.9528-1-i.bornyakov@metrotek.ru>
References: <20220719112335.9528-1-i.bornyakov@metrotek.ru>
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
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/fpga/lattice,ecp5-fpga-mgr.yaml  | 74 +++++++++++++++++++
 1 file changed, 74 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/fpga/lattice,ecp5-fpga-mgr.yaml

diff --git a/Documentation/devicetree/bindings/fpga/lattice,ecp5-fpga-mgr.yaml b/Documentation/devicetree/bindings/fpga/lattice,ecp5-fpga-mgr.yaml
new file mode 100644
index 000000000000..34693a3c2f1e
--- /dev/null
+++ b/Documentation/devicetree/bindings/fpga/lattice,ecp5-fpga-mgr.yaml
@@ -0,0 +1,74 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/fpga/lattice,ecp5-fpga-mgr.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Lattice ECP5 Slave SPI FPGA manager
+
+maintainers:
+  - Ivan Bornyakov <i.bornyakov@metrotek.ru>
+
+description:
+  Lattice ECP5 sysCONFIG port, which is used for device configuration, among
+  others, have Slave Serial Peripheral Interface. Only full reconfiguration
+  with uncompressed bitstream image in .bit format is supported.
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


