Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADA4A5A1327
	for <lists+linux-fpga@lfdr.de>; Thu, 25 Aug 2022 16:16:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235192AbiHYOOn (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 25 Aug 2022 10:14:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241601AbiHYOO2 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 25 Aug 2022 10:14:28 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC3D2B5A4B
        for <linux-fpga@vger.kernel.org>; Thu, 25 Aug 2022 07:14:17 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <jzi@pengutronix.de>)
        id 1oRDce-0002wJ-6X; Thu, 25 Aug 2022 16:14:16 +0200
Received: from [2a0a:edc0:0:1101:1d::39] (helo=dude03.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <jzi@pengutronix.de>)
        id 1oRDcd-001umk-Bv; Thu, 25 Aug 2022 16:14:15 +0200
Received: from jzi by dude03.red.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <jzi@pengutronix.de>)
        id 1oRDcc-005xwg-6z; Thu, 25 Aug 2022 16:14:14 +0200
From:   Johannes Zink <j.zink@pengutronix.de>
To:     linux-fpga@vger.kernel.org
Cc:     devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, kernel@pengutronix.de,
        Johannes Zink <j.zink@pengutronix.de>
Subject: [PATCH 14/16] fpga: machxo2: add program initialization signalling via gpio
Date:   Thu, 25 Aug 2022 16:13:41 +0200
Message-Id: <20220825141343.1375690-15-j.zink@pengutronix.de>
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

Before initiating the programming sequence, this patch generates a low
pulse on FPGA's program_n pin which enables the FPGA's in circuit
programming interface.

Signed-off-by: Johannes Zink <j.zink@pengutronix.de>
---
 drivers/fpga/machxo2-common.c | 15 +++++++++++++++
 drivers/fpga/machxo2-common.h |  1 +
 2 files changed, 16 insertions(+)

diff --git a/drivers/fpga/machxo2-common.c b/drivers/fpga/machxo2-common.c
index d93c304cceb9..ccf9a50fc590 100644
--- a/drivers/fpga/machxo2-common.c
+++ b/drivers/fpga/machxo2-common.c
@@ -167,6 +167,17 @@ static int machxo2_write_init(struct fpga_manager *mgr,
 		return -ENOTSUPP;
 	}
 
+	if (priv->fpga_program_n) {
+		/* set fpga in program mode. The timing is chosen very
+		 * conservatively, since the MachXO2 Family Datasheet
+		 * indicates a low pulse longer than 55ns will be accepted
+		 */
+		gpiod_set_value_cansleep(priv->fpga_program_n, 1);
+		usleep_range(1000, 1500);
+		gpiod_set_value_cansleep(priv->fpga_program_n, 0);
+		usleep_range(1000, 1500);
+	}
+
 	priv->get_status(priv, &status);
 	dump_status_reg(priv->dev, status);
 
@@ -331,6 +342,10 @@ int machxo2_common_init(struct machxo2_common_priv *priv, struct device *dev)
 
 	priv->erase_cmd = cpu_to_be32(erase_cmd);
 
+	priv->fpga_program_n = devm_gpiod_get_optional(dev,
+						       "lattice,program",
+						       GPIOD_OUT_LOW);
+
 	priv->dev = dev;
 
 	mgr = devm_fpga_mgr_register(dev, "Lattice MachXO2 SPI FPGA Manager",
diff --git a/drivers/fpga/machxo2-common.h b/drivers/fpga/machxo2-common.h
index 1b54154f91b1..0f9f53b48152 100644
--- a/drivers/fpga/machxo2-common.h
+++ b/drivers/fpga/machxo2-common.h
@@ -32,6 +32,7 @@ struct machxo2_common_priv {
 	int (*get_status)(struct machxo2_common_priv *priv, u32 *status);
 	struct device *dev;
 	__be32 erase_cmd;
+	struct gpio_desc *fpga_program_n;
 };
 
 int machxo2_common_init(struct machxo2_common_priv *priv, struct device *dev);
-- 
2.30.2

