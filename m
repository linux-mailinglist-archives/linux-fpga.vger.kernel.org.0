Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A9D35A132C
	for <lists+linux-fpga@lfdr.de>; Thu, 25 Aug 2022 16:16:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237536AbiHYOOs (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 25 Aug 2022 10:14:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241679AbiHYOOb (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 25 Aug 2022 10:14:31 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E39DAB6D46
        for <linux-fpga@vger.kernel.org>; Thu, 25 Aug 2022 07:14:19 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <jzi@pengutronix.de>)
        id 1oRDcf-0002xK-HC; Thu, 25 Aug 2022 16:14:17 +0200
Received: from [2a0a:edc0:0:1101:1d::39] (helo=dude03.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <jzi@pengutronix.de>)
        id 1oRDce-001unD-JS; Thu, 25 Aug 2022 16:14:16 +0200
Received: from jzi by dude03.red.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <jzi@pengutronix.de>)
        id 1oRDcc-005xwd-6P; Thu, 25 Aug 2022 16:14:14 +0200
From:   Johannes Zink <j.zink@pengutronix.de>
To:     linux-fpga@vger.kernel.org
Cc:     devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, kernel@pengutronix.de,
        Johannes Zink <j.zink@pengutronix.de>
Subject: [PATCH 13/16] fpga: machxo2: add optional additional flash areas to be erased
Date:   Thu, 25 Aug 2022 16:13:40 +0200
Message-Id: <20220825141343.1375690-14-j.zink@pengutronix.de>
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

This patch allows additional flash areas to be erased, i.e. not only the
configuration flash, but also sram, feature row and UFM (user flash
memory) can be erased.

Signed-off-by: Johannes Zink <j.zink@pengutronix.de>
---
 drivers/fpga/machxo2-common.c | 40 +++++++++++++++++++++++++++++------
 drivers/fpga/machxo2-common.h |  1 +
 2 files changed, 35 insertions(+), 6 deletions(-)

diff --git a/drivers/fpga/machxo2-common.c b/drivers/fpga/machxo2-common.c
index 71f886a60cba..d93c304cceb9 100644
--- a/drivers/fpga/machxo2-common.c
+++ b/drivers/fpga/machxo2-common.c
@@ -10,10 +10,13 @@
 
 #include <linux/delay.h>
 #include <linux/bitfield.h>
+#include <linux/byteorder/generic.h>
+#include <asm-generic/unaligned.h>
 #include <linux/fpga/fpga-mgr.h>
 #include <linux/gpio/consumer.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/property.h>
 #include "machxo2-common.h"
 
 #define MACHXO2_LOW_DELAY_USEC          5
@@ -41,6 +44,16 @@
 #define MACHXO2_ERR_EESDMEOF	7 /* SDM EOF */
 #define MACHXO2_FAIL		BIT(13)
 
+/*
+ * second byte ('operand') of ISC_ERASE can be ORed with the
+ * following bitmasks to not only erase configuration flash,
+ * but also SRAM, Feature Row or UFM, respectively. See MachXO2
+ * Programming and Configuration Usage Guide
+ */
+#define ISC_ERASE_SRAM		BIT(16)
+#define ISC_ERASE_FEATURE_ROW	BIT(17)
+#define ISC_ERASE_UFM		BIT(19)
+
 
 static inline u8 get_err(u32 status)
 {
@@ -90,13 +103,13 @@ static int machxo2_wait_until_not_busy(struct machxo2_common_priv *priv)
 static int machxo2_cleanup(struct fpga_manager *mgr)
 {
 	struct machxo2_common_priv *priv = mgr->priv;
-	u8 erase[] = ISC_ERASE;
 	u8 refresh[] = LSC_REFRESH;
 	struct machxo2_cmd cmd = {};
 	int ret;
 
-	cmd.cmd = erase;
-	cmd.cmd_len = sizeof(erase);
+	cmd.cmd = (u8 *)&priv->erase_cmd;
+	cmd.cmd_len = sizeof(priv->erase_cmd);
+
 	ret = priv->write_commands(priv, &cmd, 1);
 	if (ret)
 		goto fail;
@@ -143,7 +156,6 @@ static int machxo2_write_init(struct fpga_manager *mgr,
 {
 	struct machxo2_common_priv *priv = mgr->priv;
 	u8 enable[] = ISC_ENABLE;
-	u8 erase[] = ISC_ERASE;
 	u8 initaddr[] = LSC_INITADDRESS;
 	struct machxo2_cmd cmd[2] = {};
 	u32 status;
@@ -162,8 +174,9 @@ static int machxo2_write_init(struct fpga_manager *mgr,
 	cmd[0].cmd_len = sizeof(enable);
 	cmd[0].delay_us = MACHXO2_LOW_DELAY_USEC;
 
-	cmd[1].cmd = erase;
-	cmd[1].cmd_len = sizeof(erase);
+	cmd[1].cmd = (u8 *)&priv->erase_cmd;
+	cmd[1].cmd_len = sizeof(priv->erase_cmd);
+
 	ret = priv->write_commands(priv, cmd, 2);
 	if (ret)
 		goto fail;
@@ -302,6 +315,21 @@ static const struct fpga_manager_ops machxo2_ops = {
 int machxo2_common_init(struct machxo2_common_priv *priv, struct device *dev)
 {
 	struct fpga_manager *mgr;
+	u8 erase[] = ISC_ERASE;
+	u32 erase_cmd;
+
+	erase_cmd = get_unaligned_be32(erase);
+
+	if (device_property_read_bool(dev, "lattice,erase-sram"))
+		erase_cmd |= ISC_ERASE_SRAM;
+
+	if (device_property_read_bool(dev, "lattice,erase-feature-row"))
+		erase_cmd |= ISC_ERASE_FEATURE_ROW;
+
+	if (device_property_read_bool(dev, "lattice,erase-userflash"))
+		erase_cmd |= ISC_ERASE_UFM;
+
+	priv->erase_cmd = cpu_to_be32(erase_cmd);
 
 	priv->dev = dev;
 
diff --git a/drivers/fpga/machxo2-common.h b/drivers/fpga/machxo2-common.h
index a16060602a3f..1b54154f91b1 100644
--- a/drivers/fpga/machxo2-common.h
+++ b/drivers/fpga/machxo2-common.h
@@ -31,6 +31,7 @@ struct machxo2_common_priv {
 			     struct machxo2_cmd *cmds, size_t cmd_count);
 	int (*get_status)(struct machxo2_common_priv *priv, u32 *status);
 	struct device *dev;
+	__be32 erase_cmd;
 };
 
 int machxo2_common_init(struct machxo2_common_priv *priv, struct device *dev);
-- 
2.30.2

