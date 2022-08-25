Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A6DE5A134B
	for <lists+linux-fpga@lfdr.de>; Thu, 25 Aug 2022 16:18:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238992AbiHYOQz (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 25 Aug 2022 10:16:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240615AbiHYOOf (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 25 Aug 2022 10:14:35 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46C1DB5A6E
        for <linux-fpga@vger.kernel.org>; Thu, 25 Aug 2022 07:14:21 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <jzi@pengutronix.de>)
        id 1oRDcg-0002z4-B8; Thu, 25 Aug 2022 16:14:18 +0200
Received: from [2a0a:edc0:0:1101:1d::39] (helo=dude03.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <jzi@pengutronix.de>)
        id 1oRDcf-001unZ-Cu; Thu, 25 Aug 2022 16:14:17 +0200
Received: from jzi by dude03.red.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <jzi@pengutronix.de>)
        id 1oRDcb-005xw3-UZ; Thu, 25 Aug 2022 16:14:13 +0200
From:   Johannes Zink <j.zink@pengutronix.de>
To:     linux-fpga@vger.kernel.org
Cc:     devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, kernel@pengutronix.de,
        Johannes Zink <j.zink@pengutronix.de>
Subject: [PATCH 01/16] dt-bindings: fpga: convert Lattice MachXO2 Slave binding to YAML
Date:   Thu, 25 Aug 2022 16:13:28 +0200
Message-Id: <20220825141343.1375690-2-j.zink@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220825141343.1375690-1-j.zink@pengutronix.de>
References: <20220825141343.1375690-1-j.zink@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: jzi@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-fpga@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

This commit prepares adding additional properties to the machxo2-slave
device. No functional changes.

Signed-off-by: Johannes Zink <j.zink@pengutronix.de>
---
 .../bindings/fpga/lattice,machxo2-slave.yaml  | 46 +++++++++++++++++++
 .../bindings/fpga/lattice-machxo2-spi.txt     | 29 ------------
 2 files changed, 46 insertions(+), 29 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/fpga/lattice,machxo2-slave.yaml
 delete mode 100644 Documentation/devicetree/bindings/fpga/lattice-machxo2-spi.txt

diff --git a/Documentation/devicetree/bindings/fpga/lattice,machxo2-slave.yaml b/Documentation/devicetree/bindings/fpga/lattice,machxo2-slave.yaml
new file mode 100644
index 000000000000..d05acd6b0fc6
--- /dev/null
+++ b/Documentation/devicetree/bindings/fpga/lattice,machxo2-slave.yaml
@@ -0,0 +1,46 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/fpga/lattice,machxo2-slave.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Lattice MachXO2 Slave FPGA Manager Device Tree Bindings
+
+maintainers:
+  - Johannes Zink <j.zink@pengutronix.de>
+
+description: |
+  Device used for loading the bitstream of Lattice MachXO2 FPGAs. The
+  programming sequence is described in FPGA-TN-02155 on www.latticesemi.com
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: lattice,machxo2-slave-spi
+    then:
+      $ref: /schemas/spi/spi-peripheral-props.yaml#
+properties:
+  compatible:
+    enum:
+      - lattice,machxo2-slave-spi
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    spi0 {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        fpga@0 {
+            compatible = "lattice,machxo2-slave-spi";
+            spi-max-frequency = <8000000>;
+            reg = <0>;
+        };
+    };
diff --git a/Documentation/devicetree/bindings/fpga/lattice-machxo2-spi.txt b/Documentation/devicetree/bindings/fpga/lattice-machxo2-spi.txt
deleted file mode 100644
index a8c362eb160c..000000000000
--- a/Documentation/devicetree/bindings/fpga/lattice-machxo2-spi.txt
+++ /dev/null
@@ -1,29 +0,0 @@
-Lattice MachXO2 Slave SPI FPGA Manager
-
-Lattice MachXO2 FPGAs support a method of loading the bitstream over
-'slave SPI' interface.
-
-See 'MachXO2ProgrammingandConfigurationUsageGuide.pdf' on www.latticesemi.com
-
-Required properties:
-- compatible: should contain "lattice,machxo2-slave-spi"
-- reg: spi chip select of the FPGA
-
-Example for full FPGA configuration:
-
-	fpga-region0 {
-		compatible = "fpga-region";
-		fpga-mgr = <&fpga_mgr_spi>;
-		#address-cells = <0x1>;
-		#size-cells = <0x1>;
-	};
-
-	spi1: spi@2000 {
-        ...
-
-		fpga_mgr_spi: fpga-mgr@0 {
-			compatible = "lattice,machxo2-slave-spi";
-			spi-max-frequency = <8000000>;
-			reg = <0>;
-		};
-	};
-- 
2.30.2

