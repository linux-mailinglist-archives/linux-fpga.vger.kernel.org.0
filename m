Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0953C526785
	for <lists+linux-fpga@lfdr.de>; Fri, 13 May 2022 18:52:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382504AbiEMQt4 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 13 May 2022 12:49:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382497AbiEMQtx (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 13 May 2022 12:49:53 -0400
Received: from mail.pr-group.ru (mail.pr-group.ru [178.18.215.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D2DD527DC;
        Fri, 13 May 2022 09:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
        d=metrotek.ru; s=mail;
        h=from:subject:date:message-id:to:cc:mime-version:content-transfer-encoding:
         in-reply-to:references;
        bh=Y+q3Espln8Rodgx5Nn4tnLIErSJz4K4izMOM418Zr7I=;
        b=Zcaf7SnnF8CytZ36f7XT3WiBaHo2n41mAy5qjIErCPgYWkyKIdJPNQ00x4aFCY4Sd2wFakFxHijIP
         UMi3ZVhsDzdlin8MqnXuVAuJ6AUwjMioiIT3DGdUtc9NXvCCsayBHLhmoc3yPgdh4OZobN6WhcpdOt
         Qv/sjVRi9FIiKhGeM/j47ExlBtzRrSpG3SPbQUDmye0VYVgoyipC+9E+Qam4EaEN/jlvFCHrmKpLPX
         REqeKxmNHM+i/eyiRJzx6RKgHF9aoEX2WJaD25eowk0b7xXmGLyeuGee/AU8MLxA7p8vXcNPYMnGON
         FH4XM7X/2JTy826cX5lDdNrg3YZEwvQ==
X-Kerio-Anti-Spam:  Build: [Engines: 2.16.3.1424, Stamp: 3], Multi: [Enabled, t: (0.000009,0.007906)], BW: [Enabled, t: (0.000015,0.000001)], RTDA: [Enabled, t: (0.069878), Hit: No, Details: v2.39.0; Id: 15.52k2va.1g2v56i9t.q397; mclb], total: 0(700)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Level: 
X-Footer: bWV0cm90ZWsucnU=
Received: from localhost.localdomain ([178.70.36.174])
        (authenticated user i.bornyakov@metrotek.ru)
        by mail.pr-group.ru with ESMTPSA
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits));
        Fri, 13 May 2022 19:49:29 +0300
From:   Ivan Bornyakov <i.bornyakov@metrotek.ru>
Cc:     mdf@kernel.org, hao.wu@intel.com, yilun.xu@intel.com,
        trix@redhat.com, Conor.Dooley@microchip.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-fpga@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        system@metrotek.ru, Ivan Bornyakov <i.bornyakov@metrotek.ru>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v12 3/3] dt-bindings: fpga: add binding doc for microchip-spi fpga mgr
Date:   Fri, 13 May 2022 19:27:55 +0300
Message-Id: <20220513162755.16201-4-i.bornyakov@metrotek.ru>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220513162755.16201-1-i.bornyakov@metrotek.ru>
References: <20220513162755.16201-1-i.bornyakov@metrotek.ru>
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
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../fpga/microchip,mpf-spi-fpga-mgr.yaml      | 44 +++++++++++++++++++
 1 file changed, 44 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/fpga/microchip,mpf-spi-fpga-mgr.yaml

diff --git a/Documentation/devicetree/bindings/fpga/microchip,mpf-spi-fpga-mgr.yaml b/Documentation/devicetree/bindings/fpga/microchip,mpf-spi-fpga-mgr.yaml
new file mode 100644
index 000000000000..aee45cb15592
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
+    spi {
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
2.35.1


