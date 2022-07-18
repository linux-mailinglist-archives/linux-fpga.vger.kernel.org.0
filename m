Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DB41577F81
	for <lists+linux-fpga@lfdr.de>; Mon, 18 Jul 2022 12:20:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234076AbiGRKS0 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 18 Jul 2022 06:18:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234028AbiGRKSW (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 18 Jul 2022 06:18:22 -0400
Received: from mail.pr-group.ru (mail.pr-group.ru [178.18.215.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 081401C913;
        Mon, 18 Jul 2022 03:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
        d=metrotek.ru; s=mail;
        h=from:subject:date:message-id:to:cc:mime-version:content-transfer-encoding:
         in-reply-to:references;
        bh=5/FAUSr7rD53CB44v/5gazrz/qXYw+k0RFzlnAZEjRM=;
        b=AvOPxN3VwIWVhtGZlP+WMwFWYYJCrn+k/3fQ8OgUtDC6S40qFq2A3mFg3q8yf4wd3Qt5PdGaz4O5t
         Y2SHKPAE1y9soPxLGgMbVONi/czdzU9doAsoXDq5JMlFUqaUQebdovD8jiFS0zfa2zn4Ov07oYOq8R
         8nxm/bWoQ7tyz2vUPNd22hT/D7BvuHgV6nsI9X2Yhe2Xg1IDhSR4FtcB2FK+joI5J1u/tOUfr4UVgF
         1mZLua3NiweYq+3ABi0Yo3j4SHG2+g45rnpoQM0GTbPyl8xHrsYIpCxnNoGS1UUmGtsaobsvpUP4j3
         GSNQJVZ7kBl//DJS5tkKJc+u63TiY/g==
X-Kerio-Anti-Spam:  Build: [Engines: 2.16.3.1424, Stamp: 3], Multi: [Enabled, t: (0.000008,0.010467)], BW: [Enabled, t: (0.000025,0.000001)], RTDA: [Enabled, t: (0.073008), Hit: No, Details: v2.40.0; Id: 15.52k6aa.1g88d19th.2v5i8; mclb], total: 0(700)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Level: 
X-Footer: bWV0cm90ZWsucnU=
Received: from h-e2.ddg ([85.143.252.66])
        (authenticated user i.bornyakov@metrotek.ru)
        by mail.pr-group.ru with ESMTPSA
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits));
        Mon, 18 Jul 2022 13:18:04 +0300
From:   Ivan Bornyakov <i.bornyakov@metrotek.ru>
To:     mdf@kernel.org, hao.wu@intel.com, yilun.xu@intel.com,
        trix@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     Ivan Bornyakov <i.bornyakov@metrotek.ru>,
        linux-fpga@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, system@metrotek.ru
Subject: [PATCH v2 2/2] dt-bindings: fpga: add binding doc for ecp5-spi fpga mgr
Date:   Mon, 18 Jul 2022 13:17:35 +0300
Message-Id: <20220718101735.26696-3-i.bornyakov@metrotek.ru>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220718101735.26696-1-i.bornyakov@metrotek.ru>
References: <20220718101735.26696-1-i.bornyakov@metrotek.ru>
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
index 000000000000..95c24e4c6023
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
+        ##size-cells = <0>;
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


