Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1DA8574D94
	for <lists+linux-fpga@lfdr.de>; Thu, 14 Jul 2022 14:30:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237787AbiGNM2A (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 14 Jul 2022 08:28:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231721AbiGNM17 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 14 Jul 2022 08:27:59 -0400
Received: from mail.pr-group.ru (mail.pr-group.ru [178.18.215.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 445021CFC3;
        Thu, 14 Jul 2022 05:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
        d=metrotek.ru; s=mail;
        h=from:subject:date:message-id:to:cc:mime-version:content-transfer-encoding:
         in-reply-to:references;
        bh=0Q3bhArdusZeLQoNXIpOd+baan20fcaHIGQ/15fTlTU=;
        b=CKomOUxGi4koCxEQnepKxzV/0On8S9ZJ9lfh9sIGTzG9ibVmiF4lZXbvLUACkP5bRjKtgmzmIGvIK
         luF05zE7ddkTcVKXDkYcWrf0TRsjRIyrME1PK5xSXsHmUyQ2GFnfCu1jF842NLKQeUDRdbF1X96wv1
         GNCOSmPd4FvB/r3sSv1BX3nLGYhvyMdfPA5TFt4FwmbXWjVmmZshShuDtG0tLS2uWhYBqVruq/8fGu
         7K2S8qdW3u+6NOsubIXjfHIcoGAHchvCftwtaSTSfz5zbDxQOnRCcCgbQd21ZalZmpN0V6xTIQ2Spz
         bXH95oMck3U1bt6OjLFQTQootToj7Ng==
X-Kerio-Anti-Spam:  Build: [Engines: 2.16.3.1424, Stamp: 3], Multi: [Enabled, t: (0.000008,0.010508)], BW: [Enabled, t: (0.000020,0.000001)], RTDA: [Enabled, t: (0.079403), Hit: No, Details: v2.40.0; Id: 15.52k6in.1g7uar8jn.1m6s8; mclb], total: 0(700)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Level: 
X-Footer: bWV0cm90ZWsucnU=
Received: from h-e2.ddg ([85.143.252.66])
        (authenticated user i.bornyakov@metrotek.ru)
        by mail.pr-group.ru with ESMTPSA
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits));
        Thu, 14 Jul 2022 15:27:23 +0300
From:   Ivan Bornyakov <i.bornyakov@metrotek.ru>
To:     mdf@kernel.org, hao.wu@intel.com, yilun.xu@intel.com,
        trix@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     Ivan Bornyakov <i.bornyakov@metrotek.ru>,
        linux-fpga@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, system@metrotek.ru
Subject: [PATCH 2/2] dt-bindings: fpga: add binding doc for ecp5-spi fpga mgr
Date:   Thu, 14 Jul 2022 15:26:57 +0300
Message-Id: <20220714122657.17972-3-i.bornyakov@metrotek.ru>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220714122657.17972-1-i.bornyakov@metrotek.ru>
References: <20220714122657.17972-1-i.bornyakov@metrotek.ru>
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
 .../fpga/lattice,ecp5-spi-fpga-mgr.yaml       | 71 +++++++++++++++++++
 1 file changed, 71 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/fpga/lattice,ecp5-spi-fpga-mgr.yaml

diff --git a/Documentation/devicetree/bindings/fpga/lattice,ecp5-spi-fpga-mgr.yaml b/Documentation/devicetree/bindings/fpga/lattice,ecp5-spi-fpga-mgr.yaml
new file mode 100644
index 000000000000..79868f9c84e2
--- /dev/null
+++ b/Documentation/devicetree/bindings/fpga/lattice,ecp5-spi-fpga-mgr.yaml
@@ -0,0 +1,71 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/fpga/lattice,ecp5-spi-fpga-mgr.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Lattice ECP5 FPGA manager.
+
+maintainers:
+  - Ivan Bornyakov <i.bornyakov@metrotek.ru>
+
+description:
+  Device Tree Bindings for Lattice ECP5 FPGA Manager using slave SPI to
+  load the uncompressed bitstream in .bit format.
+
+properties:
+  compatible:
+    enum:
+      - lattice,ecp5-spi-fpga-mgr
+
+  reg:
+    description: SPI chip select
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
+      Indicates the FPGA is ready to be configured.
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
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            fpga_mgr@0 {
+                    compatible = "lattice,ecp5-spi-fpga-mgr";
+                    spi-max-frequency = <20000000>;
+                    reg = <0>;
+                    program-gpios = <&gpio3 4 GPIO_ACTIVE_LOW>;
+                    init-gpios = <&gpio3 3 GPIO_ACTIVE_LOW>;
+                    done-gpios = <&gpio3 2 GPIO_ACTIVE_HIGH>;
+            };
+    };
-- 
2.37.0


