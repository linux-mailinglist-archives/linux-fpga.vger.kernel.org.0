Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C125A5A134F
	for <lists+linux-fpga@lfdr.de>; Thu, 25 Aug 2022 16:20:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236753AbiHYOS3 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 25 Aug 2022 10:18:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241950AbiHYOOd (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 25 Aug 2022 10:14:33 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BDC6A3D6A
        for <linux-fpga@vger.kernel.org>; Thu, 25 Aug 2022 07:14:20 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <jzi@pengutronix.de>)
        id 1oRDcf-0002xZ-Lv; Thu, 25 Aug 2022 16:14:17 +0200
Received: from [2a0a:edc0:0:1101:1d::39] (helo=dude03.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <jzi@pengutronix.de>)
        id 1oRDce-001unJ-OI; Thu, 25 Aug 2022 16:14:16 +0200
Received: from jzi by dude03.red.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <jzi@pengutronix.de>)
        id 1oRDcc-005xwa-5o; Thu, 25 Aug 2022 16:14:14 +0200
From:   Johannes Zink <j.zink@pengutronix.de>
To:     linux-fpga@vger.kernel.org
Cc:     devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, kernel@pengutronix.de,
        Johannes Zink <j.zink@pengutronix.de>
Subject: [PATCH 12/16] fpga: machxo2: improve status register dump
Date:   Thu, 25 Aug 2022 16:13:39 +0200
Message-Id: <20220825141343.1375690-13-j.zink@pengutronix.de>
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

Since the previous patches introduce a priv datastructure, the dev
pointer can now be stored upon init. This allows the dump_status_reg
function to use dev_dbg instead of a raw pr_debug.

No functional changes.

Signed-off-by: Johannes Zink <j.zink@pengutronix.de>
---
 drivers/fpga/machxo2-common.c | 28 +++++++++++++++-------------
 drivers/fpga/machxo2-common.h |  1 +
 2 files changed, 16 insertions(+), 13 deletions(-)

diff --git a/drivers/fpga/machxo2-common.c b/drivers/fpga/machxo2-common.c
index 33127ee67d19..71f886a60cba 100644
--- a/drivers/fpga/machxo2-common.c
+++ b/drivers/fpga/machxo2-common.c
@@ -63,12 +63,12 @@ static const char *get_err_string(u8 err)
 	return "Unknown";
 }
 
-static void dump_status_reg(u32 status)
+static void dump_status_reg(struct device *dev, u32 status)
 {
-        pr_debug("machxo2 status: 0x%08X - done=%d, cfgena=%d, busy=%d, fail=%d, devver=%d, err=%s\n",
-                  status, !!FIELD_GET(MACHXO2_DONE, status), !!FIELD_GET(MACHXO2_ENAB, status),
-                  !!FIELD_GET(MACHXO2_BUSY, status), !!FIELD_GET(MACHXO2_FAIL, status),
-                  !!FIELD_GET(MACHXO2_DVER, status), get_err_string(get_err(status)));
+	dev_dbg(dev, "0x%08X - done=%d, cfgena=%d, busy=%d, fail=%d, devver=%d, err=%s\n",
+		status, !!FIELD_GET(MACHXO2_DONE, status), !!FIELD_GET(MACHXO2_ENAB, status),
+		!!FIELD_GET(MACHXO2_BUSY, status), !!FIELD_GET(MACHXO2_FAIL, status),
+		!!FIELD_GET(MACHXO2_DVER, status), get_err_string(get_err(status)));
 }
 
 static int machxo2_wait_until_not_busy(struct machxo2_common_priv *priv)
@@ -156,7 +156,7 @@ static int machxo2_write_init(struct fpga_manager *mgr,
 	}
 
 	priv->get_status(priv, &status);
-	dump_status_reg(status);
+	dump_status_reg(priv->dev, status);
 
 	cmd[0].cmd = enable;
 	cmd[0].cmd_len = sizeof(enable);
@@ -177,7 +177,7 @@ static int machxo2_write_init(struct fpga_manager *mgr,
 		ret = -EINVAL;
 		goto fail;
 	}
-	dump_status_reg(status);
+	dump_status_reg(priv->dev, status);
 
 	cmd[0].cmd = initaddr;
 	cmd[0].cmd_len = sizeof(initaddr);
@@ -186,7 +186,7 @@ static int machxo2_write_init(struct fpga_manager *mgr,
 		goto fail;
 
 	priv->get_status(priv, &status);
-	dump_status_reg(status);
+	dump_status_reg(priv->dev, status);
 
 	return 0;
 fail:
@@ -210,7 +210,7 @@ static int machxo2_write(struct fpga_manager *mgr, const char *buf,
 		return -EINVAL;
 	}
 	priv->get_status(priv, &status);
-	dump_status_reg(status);
+	dump_status_reg(priv->dev, status);
 	cmd.cmd = payload;
 	cmd.cmd_len = MACHXO2_BUF_SIZE;
 	cmd.delay_us = MACHXO2_HIGH_DELAY_USEC;
@@ -229,7 +229,7 @@ static int machxo2_write(struct fpga_manager *mgr, const char *buf,
 		}
 	}
 	priv->get_status(priv, &status);
-	dump_status_reg(status);
+	dump_status_reg(priv->dev, status);
 
 	return 0;
 }
@@ -254,7 +254,7 @@ static int machxo2_write_complete(struct fpga_manager *mgr,
 		goto fail;
 
 	priv->get_status(priv, &status);
-	dump_status_reg(status);
+	dump_status_reg(priv->dev, status);
 	if (!(status & MACHXO2_DONE)) {
 		machxo2_cleanup(mgr);
 		ret = -EINVAL;
@@ -272,7 +272,7 @@ static int machxo2_write_complete(struct fpga_manager *mgr,
 
 		/* check refresh status */
 		priv->get_status(priv, &status);
-		dump_status_reg(status);
+		dump_status_reg(priv->dev, status);
 		if (machxo2_status_done(status))
 			break;
 		if (++refreshloop == MACHXO2_MAX_REFRESH_LOOP) {
@@ -283,7 +283,7 @@ static int machxo2_write_complete(struct fpga_manager *mgr,
 	} while (1);
 
 	priv->get_status(priv, &status);
-	dump_status_reg(status);
+	dump_status_reg(priv->dev, status);
 
 	return 0;
 fail:
@@ -303,6 +303,8 @@ int machxo2_common_init(struct machxo2_common_priv *priv, struct device *dev)
 {
 	struct fpga_manager *mgr;
 
+	priv->dev = dev;
+
 	mgr = devm_fpga_mgr_register(dev, "Lattice MachXO2 SPI FPGA Manager",
 				     &machxo2_ops, priv);
 
diff --git a/drivers/fpga/machxo2-common.h b/drivers/fpga/machxo2-common.h
index 908203644209..a16060602a3f 100644
--- a/drivers/fpga/machxo2-common.h
+++ b/drivers/fpga/machxo2-common.h
@@ -30,6 +30,7 @@ struct machxo2_common_priv {
 	int (*write_commands)(struct machxo2_common_priv *priv,
 			     struct machxo2_cmd *cmds, size_t cmd_count);
 	int (*get_status)(struct machxo2_common_priv *priv, u32 *status);
+	struct device *dev;
 };
 
 int machxo2_common_init(struct machxo2_common_priv *priv, struct device *dev);
-- 
2.30.2

