Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE99D5A0F09
	for <lists+linux-fpga@lfdr.de>; Thu, 25 Aug 2022 13:28:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239097AbiHYL00 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 25 Aug 2022 07:26:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241548AbiHYL0Z (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 25 Aug 2022 07:26:25 -0400
Received: from mail.pr-group.ru (mail.pr-group.ru [178.18.215.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 959886BD53;
        Thu, 25 Aug 2022 04:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
        d=metrotek.ru; s=mail;
        h=from:subject:date:message-id:to:cc:mime-version:content-transfer-encoding:
         in-reply-to:references;
        bh=K3VpJkw9tEa+HvAMHqXTLzBe8mZdLAZPPmOrPYfRi5w=;
        b=BA35LFrTyCY/ChguZvkx78iWYyF1KyFWpbxhBencG3JvOjeKUHYHtmU045W33E18TGRyJpF1n3peQ
         CTIE6ZWWNC9kAr6/qQmzIOII/xsI9W63kd6YaJtdPOKKWgBbAuzUgZw4z1bvB5+3d+0LnN5XJNJOWS
         afRAG7L9dobiqxBvPdsifZhJFxwc9/sMmJa7mgISxblezCxQTvE2NmTf6xJ+mYsfCp8N/OhoiQGzTF
         kx6Sq16Q5zJXTOxIn4P+hBkI7b7GlUiVAwx2MBXnHZNM107C7EKIPn2a4/2892dDR+7clkxR1l5jWW
         7T45Klr+I2rO4yFfrcSz538m1fFGL4g==
X-Kerio-Anti-Spam:  Build: [Engines: 2.16.4.1445, Stamp: 3], Multi: [Enabled, t: (0.000012,0.014863)], BW: [Enabled, t: (0.000016,0.000001)], RTDA: [Enabled, t: (0.085401), Hit: No, Details: v2.41.0; Id: 15.52k4qu.1gbac0kml.7isp; mclb], total: 0(700)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Level: 
X-Footer: bWV0cm90ZWsucnU=
Received: from h-e2.ddg ([85.143.252.66])
        (authenticated user i.bornyakov@metrotek.ru)
        by mail.pr-group.ru with ESMTPSA
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits));
        Thu, 25 Aug 2022 14:25:49 +0300
From:   Ivan Bornyakov <i.bornyakov@metrotek.ru>
To:     mdf@kernel.org, hao.wu@intel.com, yilun.xu@intel.com,
        trix@redhat.com, dg@emlix.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     Ivan Bornyakov <i.bornyakov@metrotek.ru>,
        linux-fpga@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, system@metrotek.ru
Subject: [PATCH v8 2/2] dt-bindings: fpga: document Lattice sysCONFIG FPGA manager
Date:   Thu, 25 Aug 2022 14:24:33 +0300
Message-Id: <20220825112433.14583-3-i.bornyakov@metrotek.ru>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220825112433.14583-1-i.bornyakov@metrotek.ru>
References: <20220825112433.14583-1-i.bornyakov@metrotek.ru>
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
---
 .../bindings/fpga/lattice,sysconfig.yaml      | 109 ++++++++++++++++++
 1 file changed, 109 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/fpga/lattice,sysconfig.yaml

diff --git a/Documentation/devicetree/bindings/fpga/lattice,sysconfig.yaml b/Documentation/devicetree/bindings/fpga/lattice,sysconfig.yaml
new file mode 100644
index 000000000000..3ea338a05bb5
--- /dev/null
+++ b/Documentation/devicetree/bindings/fpga/lattice,sysconfig.yaml
@@ -0,0 +1,109 @@
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
+        program-gpios: false
+        init-gpios: false
+        done-gpios: false
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
+      required:
+        - program-gpios
+        - init-gpios
+        - done-gpios
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


