Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DC805FBBDA
	for <lists+linux-fpga@lfdr.de>; Tue, 11 Oct 2022 22:08:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbiJKUHE (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 11 Oct 2022 16:07:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbiJKUHA (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 11 Oct 2022 16:07:00 -0400
Received: from mail.pr-group.ru (mail.pr-group.ru [178.18.215.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDDE44A810;
        Tue, 11 Oct 2022 13:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
        d=metrotek.ru; s=mail;
        h=from:subject:date:message-id:to:cc:mime-version:content-transfer-encoding:
         in-reply-to:references;
        bh=Btkb2gtW6RKewRf9IoFqqlzQlwIj6C4A6/4lF9dHJ4A=;
        b=Z1rcR2IMykIb8yRNbUCPWUmmXUL68PM2dGik2pE/31Ws0qHWN3Xb9ThVZ623O2ttDQw4uaP1DoXbO
         VhAqDEqb2SVja+dazAnfeoZ25pl28ObO77W5qHN1GKPuWL6+TOWO/YtN+1MmAl30GXylMT0jJXWj9P
         2+HuGacWfsTu/Mu7rSwZLRU7s6kBwkXli9+k0KH4hrQYI2fuBrxTHsyRUhmXUQeFw4yH0T/HKhR+7Y
         tSLaWGNcL1RWRdZero1CkXS7GTampJMat1+1qROdLSzCH1Do7025qstDZYY9kwb9rF+sphGhguGOlw
         YSa7NJvBvwB0ynNjD3QvCKKNPU5iVaw==
X-Kerio-Anti-Spam:  Build: [Engines: 2.16.4.1445, Stamp: 3], Multi: [Enabled, t: (0.000011,0.012708)], BW: [Enabled, t: (0.000022,0.000001)], RTDA: [Enabled, t: (0.138666), Hit: No, Details: v3.20.0; Id: 17.52g4ru.1gf4ag4uf.4726345], total: 0(700)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Level: 
X-Footer: bWV0cm90ZWsucnU=
Received: from localhost.localdomain ([92.100.86.33])
        (authenticated user i.bornyakov@metrotek.ru)
        by mail.pr-group.ru with ESMTPSA
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits));
        Tue, 11 Oct 2022 23:06:38 +0300
From:   Ivan Bornyakov <i.bornyakov@metrotek.ru>
To:     mdf@kernel.org, hao.wu@intel.com, yilun.xu@intel.com,
        trix@redhat.com, dg@emlix.com, j.zink@pengutronix.de,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     Ivan Bornyakov <i.bornyakov@metrotek.ru>,
        linux-fpga@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        system@metrotek.ru,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v17 2/2] dt-bindings: fpga: document Lattice sysCONFIG FPGA manager
Date:   Tue, 11 Oct 2022 22:38:21 +0300
Message-Id: <20221011193821.21828-3-i.bornyakov@metrotek.ru>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221011193821.21828-1-i.bornyakov@metrotek.ru>
References: <20221011193821.21828-1-i.bornyakov@metrotek.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Add Device Tree Binding doc for configuring Lattice ECP5 FPGA over
Slave SPI sysCONFIG interface.

Signed-off-by: Ivan Bornyakov <i.bornyakov@metrotek.ru>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/fpga/lattice,sysconfig.yaml      | 81 +++++++++++++++++++
 1 file changed, 81 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/fpga/lattice,sysconfig.yaml

diff --git a/Documentation/devicetree/bindings/fpga/lattice,sysconfig.yaml b/Documentation/devicetree/bindings/fpga/lattice,sysconfig.yaml
new file mode 100644
index 000000000000..4fb05eb84e2a
--- /dev/null
+++ b/Documentation/devicetree/bindings/fpga/lattice,sysconfig.yaml
@@ -0,0 +1,81 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/fpga/lattice,sysconfig.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Lattice Slave SPI sysCONFIG FPGA manager
+
+maintainers:
+  - Ivan Bornyakov <i.bornyakov@metrotek.ru>
+
+description: |
+  Lattice sysCONFIG port, which is used for FPGA configuration, among others,
+  have Slave Serial Peripheral Interface. Only full reconfiguration is
+  supported.
+
+  Programming of ECP5 is done by writing uncompressed bitstream image in .bit
+  format into FPGA's SRAM configuration memory.
+
+properties:
+  compatible:
+    enum:
+      - lattice,sysconfig-ecp5
+
+  reg:
+    maxItems: 1
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
+
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: lattice,sysconfig-ecp5
+    then:
+      properties:
+        spi-max-frequency:
+          maximum: 60000000
+
+unevaluatedProperties: false
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
+            compatible = "lattice,sysconfig-ecp5";
+            reg = <0>;
+            spi-max-frequency = <20000000>;
+            program-gpios = <&gpio3 4 GPIO_ACTIVE_LOW>;
+            init-gpios = <&gpio3 3 GPIO_ACTIVE_LOW>;
+            done-gpios = <&gpio3 2 GPIO_ACTIVE_HIGH>;
+        };
+    };
-- 
2.35.1


