Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54B78578145
	for <lists+linux-fpga@lfdr.de>; Mon, 18 Jul 2022 13:51:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234447AbiGRLuP (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 18 Jul 2022 07:50:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233990AbiGRLuO (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 18 Jul 2022 07:50:14 -0400
Received: from mail.pr-group.ru (mail.pr-group.ru [178.18.215.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F53F193EB;
        Mon, 18 Jul 2022 04:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
        d=metrotek.ru; s=mail;
        h=from:subject:date:message-id:to:cc:mime-version:content-transfer-encoding:
         in-reply-to:references;
        bh=6PLhnSCVS/0Hp1d4l6TlOyBGg/E0V6oM0LNabEHe2X8=;
        b=jThlrAxAbFmIWfmP0oGThJeVUwCaYGksDyNluumcdxPqezX2agAYkOr1qgnkbr90wfwYmnFyvfebm
         8oTVqXhcz2adVKcnpzpZlMD6MzvFB+MBXzG6+vEIC5RkHf6fD8In3Cc6hBGs/tjPMU5mVY550oTCKr
         73PbQYVe9RTy3zvv8fmAsXygON6QJofXwtkf+I7uovlpP+he5eVa/r3Kwcgf+d1pre9n2M23RtEr3r
         I5gOeVK9Z7F7iWGj8wF6IwPE+eefquunuTN6B3V07lLtcwARlNhqW8O0BuR3tUsBWvDGUi67zS8xDR
         kwaFmtDjtRf8OmzxX9aNGQTW2jwEtvw==
X-Kerio-Anti-Spam:  Build: [Engines: 2.16.3.1424, Stamp: 3], Multi: [Enabled, t: (0.000008,0.010833)], BW: [Enabled, t: (0.000019,0.000001)], RTDA: [Enabled, t: (0.151769), Hit: No, Details: v2.40.0; Id: 15.52k488.1g88i9g99.38vcp; mclb], total: 0(700)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Level: 
X-Footer: bWV0cm90ZWsucnU=
Received: from h-e2.ddg ([85.143.252.66])
        (authenticated user i.bornyakov@metrotek.ru)
        by mail.pr-group.ru with ESMTPSA
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits));
        Mon, 18 Jul 2022 14:49:57 +0300
From:   Ivan Bornyakov <i.bornyakov@metrotek.ru>
To:     mdf@kernel.org, hao.wu@intel.com, yilun.xu@intel.com,
        trix@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     Ivan Bornyakov <i.bornyakov@metrotek.ru>,
        linux-fpga@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, system@metrotek.ru
Subject: [PATCH v3 2/2] dt-bindings: fpga: add binding doc for ecp5-spi fpga mgr
Date:   Mon, 18 Jul 2022 14:49:28 +0300
Message-Id: <20220718114928.22092-3-i.bornyakov@metrotek.ru>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220718114928.22092-1-i.bornyakov@metrotek.ru>
References: <20220718114928.22092-1-i.bornyakov@metrotek.ru>
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
 .../bindings/fpga/lattice,ecp5-fpga-mgr.yaml  | 73 +++++++++++++++++++
 1 file changed, 73 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/fpga/lattice,ecp5-fpga-mgr.yaml

diff --git a/Documentation/devicetree/bindings/fpga/lattice,ecp5-fpga-mgr.yaml b/Documentation/devicetree/bindings/fpga/lattice,ecp5-fpga-mgr.yaml
new file mode 100644
index 000000000000..bb10fd316f94
--- /dev/null
+++ b/Documentation/devicetree/bindings/fpga/lattice,ecp5-fpga-mgr.yaml
@@ -0,0 +1,73 @@
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
+  FPGA Manager capable to program Lattice ECP5 with uncompressed bitstream
+  image in .bit format over SPI.
+
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml
+
+properties:
+  reg:
+    maxItems: 1
+
+  spi-max-frequency:
+    maximum: 60000000
+
+  compatible:
+    enum:
+      - lattice,ecp5-fpga-mgr
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
+            spi-max-frequency = <20000000>;
+            reg = <0>;
+            program-gpios = <&gpio3 4 GPIO_ACTIVE_LOW>;
+            init-gpios = <&gpio3 3 GPIO_ACTIVE_LOW>;
+            done-gpios = <&gpio3 2 GPIO_ACTIVE_HIGH>;
+        };
+    };
-- 
2.37.1


