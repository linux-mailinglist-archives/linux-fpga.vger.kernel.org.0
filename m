Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 815355A1351
	for <lists+linux-fpga@lfdr.de>; Thu, 25 Aug 2022 16:20:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237417AbiHYOS2 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 25 Aug 2022 10:18:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241968AbiHYOOe (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 25 Aug 2022 10:14:34 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DDC8B6D52
        for <linux-fpga@vger.kernel.org>; Thu, 25 Aug 2022 07:14:20 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <jzi@pengutronix.de>)
        id 1oRDcf-0002xQ-I8; Thu, 25 Aug 2022 16:14:17 +0200
Received: from [2a0a:edc0:0:1101:1d::39] (helo=dude03.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <jzi@pengutronix.de>)
        id 1oRDce-001unE-Jg; Thu, 25 Aug 2022 16:14:16 +0200
Received: from jzi by dude03.red.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <jzi@pengutronix.de>)
        id 1oRDcc-005xwU-42; Thu, 25 Aug 2022 16:14:14 +0200
From:   Johannes Zink <j.zink@pengutronix.de>
To:     linux-fpga@vger.kernel.org
Cc:     devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, kernel@pengutronix.de,
        Johannes Zink <j.zink@pengutronix.de>
Subject: [PATCH 10/16] fpga: machxo2-spi: prepare extraction of common code
Date:   Thu, 25 Aug 2022 16:13:37 +0200
Message-Id: <20220825141343.1375690-11-j.zink@pengutronix.de>
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

This commit introduces a machxo2_common_priv structure which is used
instead of holding the driver's spi_device directly as priv member of the
fpga_mgr structure.

Additionally it serves as a container for a machxo2_spi_priv
struct, this prepares the addition of i2c as another bus in a later commit.

Signed-off-by: Johannes Zink <j.zink@pengutronix.de>
---
 drivers/fpga/machxo2-spi.c | 80 +++++++++++++++++++++++++-------------
 1 file changed, 52 insertions(+), 28 deletions(-)

diff --git a/drivers/fpga/machxo2-spi.c b/drivers/fpga/machxo2-spi.c
index d696b1cfb18a..5f1d6505f828 100644
--- a/drivers/fpga/machxo2-spi.c
+++ b/drivers/fpga/machxo2-spi.c
@@ -15,6 +15,7 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/spi/spi.h>
+#include <linux/container_of.h>
 
 /* MachXO2 Programming Guide - sysCONFIG Programming Commands */
 #define IDCODE_PUB		{0xe0, 0x00, 0x00, 0x00}
@@ -57,13 +58,27 @@
 #define MACHXO2_ERR_ESDMEOF	7 /* SDM EOF */
 #define MACHXO2_FAIL		BIT(13)
 
+struct machxo2_common_priv {
+};
+
+struct machxo2_spi_priv {
+	struct machxo2_common_priv common;
+	struct spi_device *spi;
+};
+
+static inline struct machxo2_spi_priv *to_machxo2_spi_priv(struct machxo2_common_priv *priv)
+{
+	return container_of(priv, struct machxo2_spi_priv, common);
+}
+
 static inline u8 get_err(u32 status)
 {
 	return FIELD_GET(MACHXO2_ERR, status);
 }
 
-static int get_status(struct spi_device *spi, u32 *status)
+static int get_status(struct machxo2_common_priv *priv, u32 *status)
 {
+	struct spi_device *spi = to_machxo2_spi_priv(priv)->spi;
 	struct spi_transfer transfers[2] = {};
 	u8 cmd[] = LSC_READ_STATUS;
 	__be32 tmp;
@@ -107,13 +122,13 @@ static void dump_status_reg(u32 status)
 		  !!FIELD_GET(MACHXO2_DVER, status), get_err_string(get_err(status)));
 }
 
-static int machxo2_wait_until_not_busy(struct spi_device *spi)
+static int machxo2_wait_until_not_busy(struct machxo2_common_priv *priv)
 {
 	u32 status;
 	int ret, loop = 0;
 
 	do {
-		ret = get_status(spi, &status);
+		ret = get_status(priv, &status);
 		if (ret)
 			return ret;
 		if (++loop >= MACHXO2_MAX_BUSY_LOOP)
@@ -129,8 +144,10 @@ struct machxo2_cmd {
 	u16 delay_us;
 };
 
-static int machxo2_write_spi(struct spi_device *spi, struct machxo2_cmd *cmds, size_t cmd_count)
+static int machxo2_write_spi(struct machxo2_common_priv *priv,
+			     struct machxo2_cmd *cmds, size_t cmd_count)
 {
+	struct spi_device *spi = to_machxo2_spi_priv(priv)->spi;
 	struct spi_transfer *transfers;
 	int i, ret;
 
@@ -154,7 +171,7 @@ static int machxo2_write_spi(struct spi_device *spi, struct machxo2_cmd *cmds, s
 
 static int machxo2_cleanup(struct fpga_manager *mgr)
 {
-	struct spi_device *spi = mgr->priv;
+	struct machxo2_common_priv *priv = mgr->priv;
 	u8 erase[] = ISC_ERASE;
 	u8 refresh[] = LSC_REFRESH;
 	struct machxo2_cmd cmd = {};
@@ -162,18 +179,18 @@ static int machxo2_cleanup(struct fpga_manager *mgr)
 
 	cmd.cmd = erase;
 	cmd.cmd_len = sizeof(erase);
-	ret = machxo2_write_spi(spi, &cmd, 1);
+	ret = machxo2_write_spi(priv, &cmd, 1);
 	if (ret)
 		goto fail;
 
-	ret = machxo2_wait_until_not_busy(spi);
+	ret = machxo2_wait_until_not_busy(priv);
 	if (ret)
 		goto fail;
 
 	cmd.cmd = refresh;
 	cmd.cmd_len = sizeof(refresh);
 	cmd.delay_us = MACHXO2_REFRESH_USEC;
-	ret = machxo2_write_spi(spi, &cmd, 1);
+	ret = machxo2_write_spi(priv, &cmd, 1);
 	if (ret)
 		goto fail;
 
@@ -192,10 +209,10 @@ static bool machxo2_status_done(unsigned long status)
 
 static enum fpga_mgr_states machxo2_spi_state(struct fpga_manager *mgr)
 {
-	struct spi_device *spi = mgr->priv;
+	struct machxo2_common_priv *priv = mgr->priv;
 	u32 status;
 
-	get_status(spi, &status);
+	get_status(priv, &status);
 	if (machxo2_status_done(status))
 		return FPGA_MGR_STATE_OPERATING;
 
@@ -206,7 +223,7 @@ static int machxo2_write_init(struct fpga_manager *mgr,
 			      struct fpga_image_info *info,
 			      const char *buf, size_t count)
 {
-	struct spi_device *spi = mgr->priv;
+	struct machxo2_common_priv *priv = mgr->priv;
 	u8 enable[] = ISC_ENABLE;
 	u8 erase[] = ISC_ERASE;
 	u8 initaddr[] = LSC_INITADDRESS;
@@ -220,7 +237,7 @@ static int machxo2_write_init(struct fpga_manager *mgr,
 		return -ENOTSUPP;
 	}
 
-	get_status(spi, &status);
+	get_status(priv, &status);
 	dump_status_reg(status);
 
 	cmd[0].cmd = enable;
@@ -234,11 +251,11 @@ static int machxo2_write_init(struct fpga_manager *mgr,
 	if (ret)
 		goto fail;
 
-	ret = machxo2_wait_until_not_busy(spi);
+	ret = machxo2_wait_until_not_busy(priv);
 	if (ret)
 		goto fail;
 
-	get_status(spi, &status);
+	get_status(priv, &status);
 	if (status & MACHXO2_FAIL) {
 		ret = -EINVAL;
 		goto fail;
@@ -247,11 +264,11 @@ static int machxo2_write_init(struct fpga_manager *mgr,
 
 	cmd[0].cmd = initaddr;
 	cmd[0].cmd_len = sizeof(initaddr);
-	ret = machxo2_write_spi(spi, &cmd[0], 1);
+	ret = machxo2_write_spi(priv, &cmd[0], 1);
 	if (ret)
 		goto fail;
 
-	get_status(spi, &status);
+	get_status(priv, &status);
 	dump_status_reg(status);
 
 	return 0;
@@ -264,7 +281,7 @@ static int machxo2_write_init(struct fpga_manager *mgr,
 static int machxo2_write(struct fpga_manager *mgr, const char *buf,
 			 size_t count)
 {
-	struct spi_device *spi = mgr->priv;
+	struct machxo2_common_priv *priv = mgr->priv;
 	u8 progincr[] = LSC_PROGINCRNV;
 	u8 payload[MACHXO2_BUF_SIZE];
 	struct machxo2_cmd cmd = {};
@@ -275,7 +292,7 @@ static int machxo2_write(struct fpga_manager *mgr, const char *buf,
 		dev_err(&mgr->dev, "Malformed payload.\n");
 		return -EINVAL;
 	}
-	get_status(spi, &status);
+	get_status(priv, &status);
 	dump_status_reg(status);
 
 	cmd.cmd = payload;
@@ -289,13 +306,13 @@ static int machxo2_write(struct fpga_manager *mgr, const char *buf,
 		cmd.cmd = payload;
 		cmd.cmd_len = MACHXO2_BUF_SIZE;
 		cmd.delay_us = MACHXO2_HIGH_DELAY_USEC;
-		ret = machxo2_write_spi(spi, &cmd, 1);
+		ret = machxo2_write_spi(priv, &cmd, 1);
 		if (ret) {
 			dev_err(&mgr->dev, "Error loading the bitstream.\n");
 			return ret;
 		}
 	}
-	get_status(spi, &status);
+	get_status(priv, &status);
 	dump_status_reg(status);
 
 	return 0;
@@ -304,7 +321,7 @@ static int machxo2_write(struct fpga_manager *mgr, const char *buf,
 static int machxo2_write_complete(struct fpga_manager *mgr,
 				  struct fpga_image_info *info)
 {
-	struct spi_device *spi = mgr->priv;
+	struct machxo2_common_priv *priv = mgr->priv;
 	struct machxo2_cmd cmd = {};
 	u8 progdone[] = ISC_PROGRAMDONE;
 	u8 refresh[] = LSC_REFRESH;
@@ -313,14 +330,14 @@ static int machxo2_write_complete(struct fpga_manager *mgr,
 
 	cmd.cmd = progdone;
 	cmd.cmd_len = sizeof(progdone);
-	ret = machxo2_write_spi(spi, &cmd, 1);
+	ret = machxo2_write_spi(priv, &cmd, 1);
 	if (ret)
 		goto fail;
-	ret = machxo2_wait_until_not_busy(spi);
+	ret = machxo2_wait_until_not_busy(priv);
 	if (ret)
 		goto fail;
 
-	get_status(spi, &status);
+	get_status(priv, &status);
 	dump_status_reg(status);
 	if (!(status & MACHXO2_DONE)) {
 		machxo2_cleanup(mgr);
@@ -333,12 +350,12 @@ static int machxo2_write_complete(struct fpga_manager *mgr,
 	cmd.delay_us = MACHXO2_REFRESH_USEC;
 
 	do {
-		ret = machxo2_write_spi(spi, &cmd, 1);
+		ret = machxo2_write_spi(priv, &cmd, 1);
 		if (ret)
 			goto fail;
 
 		/* check refresh status */
-		get_status(spi, &status);
+		get_status(priv, &status);
 		dump_status_reg(status);
 		if (machxo2_status_done(status))
 			break;
@@ -349,7 +366,7 @@ static int machxo2_write_complete(struct fpga_manager *mgr,
 		}
 	} while (1);
 
-	get_status(spi, &status);
+	get_status(priv, &status);
 	dump_status_reg(status);
 
 	return 0;
@@ -368,6 +385,7 @@ static const struct fpga_manager_ops machxo2_ops = {
 
 static int machxo2_spi_probe(struct spi_device *spi)
 {
+	struct machxo2_spi_priv *priv;
 	struct device *dev = &spi->dev;
 	struct fpga_manager *mgr;
 
@@ -376,8 +394,14 @@ static int machxo2_spi_probe(struct spi_device *spi)
 		return -EINVAL;
 	}
 
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->spi = spi;
+
 	mgr = devm_fpga_mgr_register(dev, "Lattice MachXO2 SPI FPGA Manager",
-				     &machxo2_ops, spi);
+				     &machxo2_ops, &priv->common);
 	return PTR_ERR_OR_ZERO(mgr);
 }
 
-- 
2.30.2

