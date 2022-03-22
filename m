Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CBC54E381B
	for <lists+linux-fpga@lfdr.de>; Tue, 22 Mar 2022 05:59:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236574AbiCVExd (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 22 Mar 2022 00:53:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236560AbiCVExc (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 22 Mar 2022 00:53:32 -0400
Received: from mail.pr-group.ru (mail.pr-group.ru [178.18.215.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AE8682D2E;
        Mon, 21 Mar 2022 21:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
        d=metrotek.ru; s=mail;
        h=from:subject:date:message-id:to:cc:mime-version:content-transfer-encoding:
         in-reply-to:references;
        bh=CKLX5KrV+QnDJKYWiBEwK8mRCIHVCAVHILurpqHNKKw=;
        b=hsndZg/2r0oLfjULarb89O3MxgvkNBKYSmjBOWrapBeS7OxSFqroDRlRycQnUVpmJiXx15Iuayksq
         OkOd+lLfsAyNB6kRyeWsMnSUEqAKzFfdx+KwC2x/LgZsu2WvEQABhDLpYI/xP4Fv/ibxLgpjPnS8hb
         /6OF3NExr6OocOpRNtGvwlSvHJBAx0OkEbi5Yw/RJhdgsPiFfKZ7+CPKcPi2ghuwr4FrEuuCuGSYq9
         Oy1kURWvNbLan2NJAxHVV1RiSE01A6uUE23OBc/xFHudyvlK1sjAElIG+EWb1KNhVNgbXIIrrFXrbB
         icTMQ0Jp8xrtAOyDnAtTzi7+jAE4B5w==
X-Kerio-Anti-Spam:  Build: [Engines: 2.16.2.1410, Stamp: 3], Multi: [Enabled, t: (0.000012,0.007487)], BW: [Enabled, t: (0.000029,0.000002)], RTDA: [Enabled, t: (0.065288), Hit: No, Details: v2.28.0; Id: 15.52kaot.1funveveo.1sim; mclb], total: 0(700)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Level: 
X-Footer: bWV0cm90ZWsucnU=
Received: from localhost.localdomain ([178.70.66.234])
        (authenticated user i.bornyakov@metrotek.ru)
        by mail.pr-group.ru with ESMTPSA
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits));
        Tue, 22 Mar 2022 07:51:45 +0300
From:   Ivan Bornyakov <i.bornyakov@metrotek.ru>
Cc:     Ivan Bornyakov <i.bornyakov@metrotek.ru>, mdf@kernel.org,
        hao.wu@intel.com, yilun.xu@intel.com, trix@redhat.com,
        conor.dooley@microchip.com, robh+dt@kernel.org, system@metrotek.ru,
        linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v7 2/2] dt-bindings: fpga: add binding doc for microchip-spi fpga mgr
Date:   Tue, 22 Mar 2022 07:32:19 +0300
Message-Id: <20220322043219.23770-3-i.bornyakov@metrotek.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220322043219.23770-1-i.bornyakov@metrotek.ru>
References: <20220322043219.23770-1-i.bornyakov@metrotek.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Add Device Tree Binding doc for Microchip Polarfire FPGA Manager using
slave SPI to load .dat formatted bitstream image.

Signed-off-by: Ivan Bornyakov <i.bornyakov@metrotek.ru>
---
 .../fpga/microchip,mpf-spi-fpga-mgr.yaml      | 44 +++++++++++++++++++
 1 file changed, 44 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/fpga/microchip,mpf-spi-fpga-mgr.yaml

diff --git a/Documentation/devicetree/bindings/fpga/microchip,mpf-spi-fpga-mgr.yaml b/Documentation/devicetree/bindings/fpga/microchip,mpf-spi-fpga-mgr.yaml
new file mode 100644
index 000000000000..15c4505334ac
--- /dev/null
+++ b/Documentation/devicetree/bindings/fpga/microchip,mpf-spi-fpga-mgr.yaml
@@ -0,0 +1,44 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/fpga/microchip,mpf-spi-fpga-mgr.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Microchip Polarfire FPGA manager.
+
+maintainers:
+  - Ivan Bornyakov <i.bornyakov@metrotek.ru>
+
+description:
+  Device Tree Bindings for Microchip Polarfire FPGA Manager using slave SPI to
+  load the bitstream in .dat format.
+
+properties:
+  compatible:
+    enum:
+      - microchip,mpf-spi-fpga-mgr
+
+  reg:
+    description: SPI chip select
+    maxItems: 1
+
+  spi-max-frequency: true
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    spi@2008000 {
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            fpga_mgr@0 {
+                    compatible = "microchip,mpf-spi-fpga-mgr";
+                    spi-max-frequency = <20000000>;
+                    reg = <0>;
+            };
+    };
-- 
2.34.1


