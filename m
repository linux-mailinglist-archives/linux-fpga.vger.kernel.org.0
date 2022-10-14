Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01B235FF4EC
	for <lists+linux-fpga@lfdr.de>; Fri, 14 Oct 2022 22:58:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbiJNU43 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 14 Oct 2022 16:56:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbiJNU41 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 14 Oct 2022 16:56:27 -0400
Received: from mail.pr-group.ru (mail.pr-group.ru [178.18.215.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3811E1C4937;
        Fri, 14 Oct 2022 13:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
        d=metrotek.ru; s=mail;
        h=from:subject:date:message-id:to:cc:mime-version:content-transfer-encoding:
         in-reply-to:references;
        bh=M4xO9IqxnWbsC4nyc5lGTD297hCkmftCcGG9wBbB0gQ=;
        b=QxwQD16oQxSgWiS4dBEwovO8aRRBuIfCf7uinDvySG6SOi61PGq2eACf4BwagJr/0Jm3wDLpAExWt
         HhpnBLPJRAf81bZHybDUalA2GcoUalzJp3VNQkUuR9KB5Z7pQLdvOB0B0Ekje9XyWDoBXEhmf0vBkK
         NCFuxC2oWI4Wuu7BfMfUXSF14NjYLq9iqSA4XoOB+1Z289ZxgEzjDiuvc+oCgn37PN4YvAVv8lSkzq
         ZqNwl1TwbAT01RRJVoDf1+bbfJ94PpFnD0LN3DhHqarSIVIcXKPXQ57Jo8281Tjx+Gk53pK0foQGFd
         O8VpyskYXWGKqnalxuYbREqwLyTGRRQ==
X-Kerio-Anti-Spam:  Build: [Engines: 2.16.4.1445, Stamp: 3], Multi: [Enabled, t: (0.000011,0.012807)], BW: [Enabled, t: (0.000019,0.000001)], RTDA: [Enabled, t: (0.082592), Hit: No, Details: v2.42.0; Id: 15.52ka0b.1gfc4h48j.cdus; mclb], total: 0(700)
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLACK autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: 
X-Footer: bWV0cm90ZWsucnU=
Received: from localhost.localdomain ([92.100.86.33])
        (authenticated user i.bornyakov@metrotek.ru)
        by mail.pr-group.ru with ESMTPSA
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits));
        Fri, 14 Oct 2022 23:56:14 +0300
From:   Ivan Bornyakov <i.bornyakov@metrotek.ru>
To:     mdf@kernel.org, hao.wu@intel.com, yilun.xu@intel.com,
        trix@redhat.com, dg@emlix.com, j.zink@pengutronix.de,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     Ivan Bornyakov <i.bornyakov@metrotek.ru>,
        linux-fpga@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        system@metrotek.ru,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v18 2/2] dt-bindings: fpga: document Lattice sysCONFIG FPGA manager
Date:   Fri, 14 Oct 2022 23:27:50 +0300
Message-Id: <20221014202750.20542-3-i.bornyakov@metrotek.ru>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221014202750.20542-1-i.bornyakov@metrotek.ru>
References: <20221014202750.20542-1-i.bornyakov@metrotek.ru>
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
2.37.3


