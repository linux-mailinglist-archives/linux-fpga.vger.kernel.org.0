Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70C385AD401
	for <lists+linux-fpga@lfdr.de>; Mon,  5 Sep 2022 15:35:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237855AbiIENdn (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 5 Sep 2022 09:33:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237907AbiIENdk (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 5 Sep 2022 09:33:40 -0400
Received: from mail.pr-group.ru (mail.pr-group.ru [178.18.215.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D1A24A13F;
        Mon,  5 Sep 2022 06:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
        d=metrotek.ru; s=mail;
        h=from:subject:date:message-id:to:cc:mime-version:content-transfer-encoding:
         in-reply-to:references;
        bh=PuPLL0CONGpVXEiqjDZEK8eY52IwnN+4YFhtPkE5SvE=;
        b=BKi//YxMV5MEBr/sr2A7s6/4wulB43AJWIr89tz46MUmXFelLfBsLMocNu23FkgRiiCB+Uxfgav/R
         WQ7fCMs+KHWjOcj0Baf+Gstec1/oEyWrNyZ5Q2mlZAXIlcWMd0ZfX3m4l8QwDfLIGn2J/MRm6FoHAE
         L7pXNzAq6ALOTmzTrL0RUODZgo3Ms0VEK6qNFZT4DgTpgsk5o4KC1EnsJOfmF5EZFM6HoZ/p/GSVoT
         Ci//8/LLpTR4f3npVrtO48c/EkmkhMJjMNjJ9nLCEwhRXhBwd0E10zgyP4Wl6yE5iAekaZaTcY1UNF
         K73GS0KNa6wx9OBF0fKpFAASZB/8lYQ==
X-Kerio-Anti-Spam:  Build: [Engines: 2.16.4.1445, Stamp: 3], Multi: [Enabled, t: (0.000010,0.014927)], BW: [Enabled, t: (0.000018,0.000001)], RTDA: [Enabled, t: (0.078016), Hit: No, Details: v2.41.0; Id: 15.52k1e7.1gc6tmdrm.cj; mclb], total: 0(700)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Level: 
X-Footer: bWV0cm90ZWsucnU=
Received: from h-e2.ddg ([85.143.252.66])
        (authenticated user i.bornyakov@metrotek.ru)
        by mail.pr-group.ru with ESMTPSA
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits));
        Mon, 5 Sep 2022 16:33:31 +0300
From:   Ivan Bornyakov <i.bornyakov@metrotek.ru>
To:     mdf@kernel.org, hao.wu@intel.com, yilun.xu@intel.com,
        trix@redhat.com, dg@emlix.com, j.zink@pengutronix.de,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     Ivan Bornyakov <i.bornyakov@metrotek.ru>,
        linux-fpga@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        system@metrotek.ru,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v10 2/2] dt-bindings: fpga: document Lattice sysCONFIG FPGA manager
Date:   Mon,  5 Sep 2022 16:32:05 +0300
Message-Id: <20220905133205.17039-3-i.bornyakov@metrotek.ru>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220905133205.17039-1-i.bornyakov@metrotek.ru>
References: <20220905133205.17039-1-i.bornyakov@metrotek.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Add Device Tree Binding doc for configuring Lattice ECP5 and MachXO2
FPGAs over Slave SPI sysCONFIG interface.

Signed-off-by: Ivan Bornyakov <i.bornyakov@metrotek.ru>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/fpga/lattice,sysconfig.yaml      | 102 ++++++++++++++++++
 1 file changed, 102 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/fpga/lattice,sysconfig.yaml

diff --git a/Documentation/devicetree/bindings/fpga/lattice,sysconfig.yaml b/Documentation/devicetree/bindings/fpga/lattice,sysconfig.yaml
new file mode 100644
index 000000000000..17f1e0c50bc4
--- /dev/null
+++ b/Documentation/devicetree/bindings/fpga/lattice,sysconfig.yaml
@@ -0,0 +1,102 @@
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
+  Programming of MachXO2 is done by writing configuration data into device's
+  internal non-volatile Flash memory, then Self-Download of data from Flash
+  into SRAM is issued.
+
+properties:
+  compatible:
+    enum:
+      - lattice,ecp5-fpga-mgr
+      - lattice,machxo2-fpga-mgr
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
+            const: lattice,machxo2-fpga-mgr
+    then:
+      properties:
+        spi-max-frequency:
+          maximum: 66000000
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: lattice,ecp5-fpga-mgr
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
+            compatible = "lattice,ecp5-fpga-mgr";
+            reg = <0>;
+            spi-max-frequency = <20000000>;
+            program-gpios = <&gpio3 4 GPIO_ACTIVE_LOW>;
+            init-gpios = <&gpio3 3 GPIO_ACTIVE_LOW>;
+            done-gpios = <&gpio3 2 GPIO_ACTIVE_HIGH>;
+        };
+
+        fpga-mgr@1 {
+            compatible = "lattice,machxo2-fpga-mgr";
+            reg = <1>;
+            spi-max-frequency = <20000000>;
+        };
+    };
-- 
2.37.2


