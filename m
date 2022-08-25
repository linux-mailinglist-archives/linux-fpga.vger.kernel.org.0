Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16B475A132B
	for <lists+linux-fpga@lfdr.de>; Thu, 25 Aug 2022 16:16:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240109AbiHYOOr (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 25 Aug 2022 10:14:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237536AbiHYOOb (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 25 Aug 2022 10:14:31 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B50862A90
        for <linux-fpga@vger.kernel.org>; Thu, 25 Aug 2022 07:14:18 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <jzi@pengutronix.de>)
        id 1oRDce-0002wR-MG; Thu, 25 Aug 2022 16:14:16 +0200
Received: from [2a0a:edc0:0:1101:1d::39] (helo=dude03.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <jzi@pengutronix.de>)
        id 1oRDcd-001umn-Sp; Thu, 25 Aug 2022 16:14:15 +0200
Received: from jzi by dude03.red.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <jzi@pengutronix.de>)
        id 1oRDcb-005xw6-VN; Thu, 25 Aug 2022 16:14:13 +0200
From:   Johannes Zink <j.zink@pengutronix.de>
To:     linux-fpga@vger.kernel.org
Cc:     devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, kernel@pengutronix.de,
        Johannes Zink <j.zink@pengutronix.de>
Subject: [PATCH 02/16] dt-bindings: fpga: machxo2-slave: add erasure properties
Date:   Thu, 25 Aug 2022 16:13:29 +0200
Message-Id: <20220825141343.1375690-3-j.zink@pengutronix.de>
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

This patch introduces additional memory areas of the machxo2-slave fpga
to be erased.

Signed-off-by: Johannes Zink <j.zink@pengutronix.de>
---
 .../bindings/fpga/lattice,machxo2-slave.yaml      | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/Documentation/devicetree/bindings/fpga/lattice,machxo2-slave.yaml b/Documentation/devicetree/bindings/fpga/lattice,machxo2-slave.yaml
index d05acd6b0fc6..78f0da8f772f 100644
--- a/Documentation/devicetree/bindings/fpga/lattice,machxo2-slave.yaml
+++ b/Documentation/devicetree/bindings/fpga/lattice,machxo2-slave.yaml
@@ -26,6 +26,19 @@ properties:
     enum:
       - lattice,machxo2-slave-spi
 
+  lattice,erase-sram:
+    type: boolean
+    description: SRAM is to be erased during flash erase operation
+
+  lattice,erase-feature-row:
+    type: boolean
+    description: Feature row is to be erased during flash erase operation
+
+  lattice,erase-userflash:
+    type: boolean
+    description: |
+      UFM (user flash memory) is to be erased during flash erase operation
+
 required:
   - compatible
   - reg
@@ -42,5 +55,7 @@ examples:
             compatible = "lattice,machxo2-slave-spi";
             spi-max-frequency = <8000000>;
             reg = <0>;
+            lattice,erase-sram;
+            lattice,erase-feature-row;
         };
     };
-- 
2.30.2

