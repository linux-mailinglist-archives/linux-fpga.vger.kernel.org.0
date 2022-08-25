Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96EFA5A132A
	for <lists+linux-fpga@lfdr.de>; Thu, 25 Aug 2022 16:16:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241397AbiHYOOt (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 25 Aug 2022 10:14:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241695AbiHYOOb (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 25 Aug 2022 10:14:31 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AADDA2A88
        for <linux-fpga@vger.kernel.org>; Thu, 25 Aug 2022 07:14:19 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <jzi@pengutronix.de>)
        id 1oRDcf-0002wx-6Y; Thu, 25 Aug 2022 16:14:17 +0200
Received: from [2a0a:edc0:0:1101:1d::39] (helo=dude03.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <jzi@pengutronix.de>)
        id 1oRDce-001un4-B5; Thu, 25 Aug 2022 16:14:16 +0200
Received: from jzi by dude03.red.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <jzi@pengutronix.de>)
        id 1oRDcb-005xw9-W6; Thu, 25 Aug 2022 16:14:13 +0200
From:   Johannes Zink <j.zink@pengutronix.de>
To:     linux-fpga@vger.kernel.org
Cc:     devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, kernel@pengutronix.de,
        Johannes Zink <j.zink@pengutronix.de>
Subject: [PATCH 03/16] dt-bindings: fpga: machxo2-slave: add pin for program sequence init
Date:   Thu, 25 Aug 2022 16:13:30 +0200
Message-Id: <20220825141343.1375690-4-j.zink@pengutronix.de>
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

This commit adds a pin which initiates the FPGA programming sequence
once pulsed low.

Signed-off-by: Johannes Zink <j.zink@pengutronix.de>
---
 .../devicetree/bindings/fpga/lattice,machxo2-slave.yaml    | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/fpga/lattice,machxo2-slave.yaml b/Documentation/devicetree/bindings/fpga/lattice,machxo2-slave.yaml
index 78f0da8f772f..03dc134ec7b8 100644
--- a/Documentation/devicetree/bindings/fpga/lattice,machxo2-slave.yaml
+++ b/Documentation/devicetree/bindings/fpga/lattice,machxo2-slave.yaml
@@ -26,6 +26,12 @@ properties:
     enum:
       - lattice,machxo2-slave-spi
 
+  program-gpios:
+    maxItems: 1
+    description: |
+      GPIO Output tied to the FPGA's n_program pin to initiate a
+      programming sequence. This pin is active low.
+
   lattice,erase-sram:
     type: boolean
     description: SRAM is to be erased during flash erase operation
@@ -57,5 +63,6 @@ examples:
             reg = <0>;
             lattice,erase-sram;
             lattice,erase-feature-row;
+            lattice,program-gpios = <&gpio1 2 GPIO_ACTIVE_LOW>
         };
     };
-- 
2.30.2

