Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C89A5B6E04
	for <lists+linux-fpga@lfdr.de>; Tue, 13 Sep 2022 15:10:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232195AbiIMNI6 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 13 Sep 2022 09:08:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232141AbiIMNIy (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 13 Sep 2022 09:08:54 -0400
Received: from mail.pr-group.ru (mail.pr-group.ru [178.18.215.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C2F04330B;
        Tue, 13 Sep 2022 06:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
        d=metrotek.ru; s=mail;
        h=from:subject:date:message-id:to:cc:mime-version:content-transfer-encoding:
         in-reply-to:references;
        bh=UiLD4vdGkvAzJzlfra6fE27y4vGQRvd6UByg2CmDO3k=;
        b=c0KEDeDHsZKrnL41OaT8tkuMS48iw62OpL3EoaEggscqhoY0WHr/tO+d8Iz4BSypYknu8LI2x9rGo
         TuvZ4nK+CKpNsGEuuErf91EUf/pzEPYft7e++NsjPpU4zNQ/e59ZuhfqPceEx9wBTOOrUd4QYEgs0m
         RqfugImG1DW7m6jWnx5uxFM6MRsjELSexP25t8jEL6d57KVZ1m8Vhq+1XcBSn3xguMUTCX6k3UP/MM
         Ukmnh3kA0t4Ylo/j5RZsKDw/21wKwQqnFnMdysoAp6Wmksk5PyPfkggp9lyN4MArqO1UYOwn9V84gx
         u1/FJc1u8ncnqj1Fxw+K0u/QimLUYXg==
X-Kerio-Anti-Spam:  Build: [Engines: 2.16.4.1445, Stamp: 3], Multi: [Enabled, t: (0.000010,0.014670)], BW: [Enabled, t: (0.000017,0.000001)], RTDA: [Enabled, t: (0.088602), Hit: No, Details: v2.41.0; Id: 15.52k2f4.1gcrferus.77n; mclb], total: 0(700)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Level: 
X-Footer: bWV0cm90ZWsucnU=
Received: from h-e2.ddg ([85.143.252.66])
        (authenticated user i.bornyakov@metrotek.ru)
        by mail.pr-group.ru with ESMTPSA
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits));
        Tue, 13 Sep 2022 16:08:45 +0300
From:   Ivan Bornyakov <i.bornyakov@metrotek.ru>
To:     mdf@kernel.org, hao.wu@intel.com, yilun.xu@intel.com,
        trix@redhat.com, dg@emlix.com, j.zink@pengutronix.de,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     Ivan Bornyakov <i.bornyakov@metrotek.ru>,
        linux-fpga@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        system@metrotek.ru,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v11 2/2] dt-bindings: fpga: document Lattice sysCONFIG FPGA manager
Date:   Tue, 13 Sep 2022 16:07:14 +0300
Message-Id: <20220913130714.31404-3-i.bornyakov@metrotek.ru>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220913130714.31404-1-i.bornyakov@metrotek.ru>
References: <20220913130714.31404-1-i.bornyakov@metrotek.ru>
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
index 000000000000..93c8be1794a1
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
+      - lattice,sysconfig-ecp5
+      - lattice,sysconfig-machxo2
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
+            const: lattice,sysconfig-machxo2
+    then:
+      properties:
+        spi-max-frequency:
+          maximum: 66000000
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
+
+        fpga-mgr@1 {
+            compatible = "lattice,sysconfig-machxo2";
+            reg = <1>;
+            spi-max-frequency = <20000000>;
+        };
+    };
-- 
2.37.3


