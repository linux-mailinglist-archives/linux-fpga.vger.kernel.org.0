Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D36E5A1329
	for <lists+linux-fpga@lfdr.de>; Thu, 25 Aug 2022 16:16:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239029AbiHYOOq (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 25 Aug 2022 10:14:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240109AbiHYOOb (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 25 Aug 2022 10:14:31 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEB69B5E7E
        for <linux-fpga@vger.kernel.org>; Thu, 25 Aug 2022 07:14:18 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <jzi@pengutronix.de>)
        id 1oRDce-0002wl-Of; Thu, 25 Aug 2022 16:14:16 +0200
Received: from [2a0a:edc0:0:1101:1d::39] (helo=dude03.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <jzi@pengutronix.de>)
        id 1oRDcd-001umo-U2; Thu, 25 Aug 2022 16:14:15 +0200
Received: from jzi by dude03.red.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <jzi@pengutronix.de>)
        id 1oRDcc-005xwR-3O; Thu, 25 Aug 2022 16:14:14 +0200
From:   Johannes Zink <j.zink@pengutronix.de>
To:     linux-fpga@vger.kernel.org
Cc:     devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, kernel@pengutronix.de,
        Johannes Zink <j.zink@pengutronix.de>
Subject: [PATCH 09/16] fpga: machxo2-spi: simplify spi write commands
Date:   Thu, 25 Aug 2022 16:13:36 +0200
Message-Id: <20220825141343.1375690-10-j.zink@pengutronix.de>
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

Refactor the spi transfer preparation into a separate function. This
commit prepares moving the non-spi-specific part of the programming
sequence into a separate file.

Signed-off-by: Johannes Zink <j.zink@pengutronix.de>
---
 drivers/fpga/machxo2-spi.c | 128 +++++++++++++++++++++++--------------
 1 file changed, 79 insertions(+), 49 deletions(-)

diff --git a/drivers/fpga/machxo2-spi.c b/drivers/fpga/machxo2-spi.c
index 7f7d1066ddee..d696b1cfb18a 100644
--- a/drivers/fpga/machxo2-spi.c
+++ b/drivers/fpga/machxo2-spi.c
@@ -65,7 +65,7 @@ static inline u8 get_err(u32 status)
 static int get_status(struct spi_device *spi, u32 *status)
 {
 	struct spi_transfer transfers[2] = {};
-	static const u8 cmd[] = LSC_READ_STATUS;
+	u8 cmd[] = LSC_READ_STATUS;
 	__be32 tmp;
 	int ret;
 
@@ -107,7 +107,7 @@ static void dump_status_reg(u32 status)
 		  !!FIELD_GET(MACHXO2_DVER, status), get_err_string(get_err(status)));
 }
 
-static int wait_until_not_busy(struct spi_device *spi)
+static int machxo2_wait_until_not_busy(struct spi_device *spi)
 {
 	u32 status;
 	int ret, loop = 0;
@@ -123,29 +123,57 @@ static int wait_until_not_busy(struct spi_device *spi)
 	return 0;
 }
 
+struct machxo2_cmd {
+	u8 *cmd;
+	size_t cmd_len;
+	u16 delay_us;
+};
+
+static int machxo2_write_spi(struct spi_device *spi, struct machxo2_cmd *cmds, size_t cmd_count)
+{
+	struct spi_transfer *transfers;
+	int i, ret;
+
+	transfers = kcalloc(cmd_count, sizeof(*transfers), GFP_KERNEL);
+	for (i = 0; i < cmd_count; i++) {
+		transfers[i].tx_buf = cmds[i].cmd;
+		transfers[i].len = cmds[i].cmd_len;
+
+		if (cmds[i].delay_us) {
+			transfers[i].delay.value = cmds[i].delay_us;
+			transfers[i].delay.unit = SPI_DELAY_UNIT_USECS;
+		}
+	}
+
+	ret = spi_sync_transfer(spi, transfers, cmd_count);
+
+	kfree(transfers);
+
+	return ret;
+}
+
 static int machxo2_cleanup(struct fpga_manager *mgr)
 {
 	struct spi_device *spi = mgr->priv;
-	static const u8 erase[] = ISC_ERASE;
-	static const u8 refresh[] = LSC_REFRESH;
-	struct spi_transfer tx = {};
+	u8 erase[] = ISC_ERASE;
+	u8 refresh[] = LSC_REFRESH;
+	struct machxo2_cmd cmd = {};
 	int ret;
 
-	tx.tx_buf = &erase;
-	tx.len = sizeof(erase);
-	ret = spi_sync_transfer(spi, &tx, 1);
+	cmd.cmd = erase;
+	cmd.cmd_len = sizeof(erase);
+	ret = machxo2_write_spi(spi, &cmd, 1);
 	if (ret)
 		goto fail;
 
-	ret = wait_until_not_busy(spi);
+	ret = machxo2_wait_until_not_busy(spi);
 	if (ret)
 		goto fail;
 
-	tx.tx_buf = &refresh;
-	tx.len = sizeof(refresh);
-	tx.delay.value = MACHXO2_REFRESH_USEC;
-	tx.delay.unit = SPI_DELAY_UNIT_USECS;
-	ret = spi_sync_transfer(spi, &tx, 1);
+	cmd.cmd = refresh;
+	cmd.cmd_len = sizeof(refresh);
+	cmd.delay_us = MACHXO2_REFRESH_USEC;
+	ret = machxo2_write_spi(spi, &cmd, 1);
 	if (ret)
 		goto fail;
 
@@ -179,10 +207,10 @@ static int machxo2_write_init(struct fpga_manager *mgr,
 			      const char *buf, size_t count)
 {
 	struct spi_device *spi = mgr->priv;
-	struct spi_transfer tx[2] = {};
-	static const u8 enable[] = ISC_ENABLE;
-	static const u8 erase[] = ISC_ERASE;
-	static const u8 initaddr[] = LSC_INITADDRESS;
+	u8 enable[] = ISC_ENABLE;
+	u8 erase[] = ISC_ERASE;
+	u8 initaddr[] = LSC_INITADDRESS;
+	struct machxo2_cmd cmd[2] = {};
 	u32 status;
 	int ret;
 
@@ -195,18 +223,18 @@ static int machxo2_write_init(struct fpga_manager *mgr,
 	get_status(spi, &status);
 	dump_status_reg(status);
 
-	tx[0].tx_buf = &enable;
-	tx[0].len = sizeof(enable);
-	tx[0].delay.value = MACHXO2_LOW_DELAY_USEC;
-	tx[0].delay.unit = SPI_DELAY_UNIT_USECS;
+	cmd[0].cmd = enable;
+	cmd[0].cmd_len = sizeof(enable);
+	cmd[0].delay_us = MACHXO2_LOW_DELAY_USEC;
+
+	cmd[1].cmd = erase;
+	cmd[1].cmd_len = sizeof(erase);
+	ret = machxo2_write_spi(spi, cmd, ARRAY_SIZE(cmd));
 
-	tx[1].tx_buf = &erase;
-	tx[1].len = sizeof(erase);
-	ret = spi_sync_transfer(spi, tx, ARRAY_SIZE(tx));
 	if (ret)
 		goto fail;
 
-	ret = wait_until_not_busy(spi);
+	ret = machxo2_wait_until_not_busy(spi);
 	if (ret)
 		goto fail;
 
@@ -217,9 +245,9 @@ static int machxo2_write_init(struct fpga_manager *mgr,
 	}
 	dump_status_reg(status);
 
-	tx[0].tx_buf = &initaddr;
-	tx[0].len = sizeof(initaddr);
-	ret = spi_sync_transfer(spi, &tx[0], 1);
+	cmd[0].cmd = initaddr;
+	cmd[0].cmd_len = sizeof(initaddr);
+	ret = machxo2_write_spi(spi, &cmd[0], 1);
 	if (ret)
 		goto fail;
 
@@ -237,8 +265,9 @@ static int machxo2_write(struct fpga_manager *mgr, const char *buf,
 			 size_t count)
 {
 	struct spi_device *spi = mgr->priv;
-	static const u8 progincr[] = LSC_PROGINCRNV;
+	u8 progincr[] = LSC_PROGINCRNV;
 	u8 payload[MACHXO2_BUF_SIZE];
+	struct machxo2_cmd cmd = {};
 	u32 status;
 	int i, ret;
 
@@ -248,17 +277,19 @@ static int machxo2_write(struct fpga_manager *mgr, const char *buf,
 	}
 	get_status(spi, &status);
 	dump_status_reg(status);
+
+	cmd.cmd = payload;
+	cmd.cmd_len = MACHXO2_BUF_SIZE;
+	cmd.delay_us = MACHXO2_HIGH_DELAY_USEC;
+
 	memcpy(payload, &progincr, sizeof(progincr));
 	for (i = 0; i < count; i += MACHXO2_PAGE_SIZE) {
-		struct spi_transfer tx = {};
-
 		memcpy(&payload[sizeof(progincr)], &buf[i], MACHXO2_PAGE_SIZE);
 
-		tx.tx_buf = payload;
-		tx.len = MACHXO2_BUF_SIZE;
-		tx.delay.value = MACHXO2_HIGH_DELAY_USEC;
-		tx.delay.unit = SPI_DELAY_UNIT_USECS;
-		ret = spi_sync_transfer(spi, &tx, 1);
+		cmd.cmd = payload;
+		cmd.cmd_len = MACHXO2_BUF_SIZE;
+		cmd.delay_us = MACHXO2_HIGH_DELAY_USEC;
+		ret = machxo2_write_spi(spi, &cmd, 1);
 		if (ret) {
 			dev_err(&mgr->dev, "Error loading the bitstream.\n");
 			return ret;
@@ -274,18 +305,18 @@ static int machxo2_write_complete(struct fpga_manager *mgr,
 				  struct fpga_image_info *info)
 {
 	struct spi_device *spi = mgr->priv;
-	struct spi_transfer tx = {};
-	static const u8 progdone[] = ISC_PROGRAMDONE;
-	static const u8 refresh[] = LSC_REFRESH;
+	struct machxo2_cmd cmd = {};
+	u8 progdone[] = ISC_PROGRAMDONE;
+	u8 refresh[] = LSC_REFRESH;
 	u32 status;
 	int ret, refreshloop = 0;
 
-	tx.tx_buf = &progdone;
-	tx.len = sizeof(progdone);
-	ret = spi_sync_transfer(spi, &tx, 1);
+	cmd.cmd = progdone;
+	cmd.cmd_len = sizeof(progdone);
+	ret = machxo2_write_spi(spi, &cmd, 1);
 	if (ret)
 		goto fail;
-	ret = wait_until_not_busy(spi);
+	ret = machxo2_wait_until_not_busy(spi);
 	if (ret)
 		goto fail;
 
@@ -297,13 +328,12 @@ static int machxo2_write_complete(struct fpga_manager *mgr,
 		goto fail;
 	}
 
-	tx.tx_buf = &refresh;
-	tx.len = sizeof(refresh);
-	tx.delay.value = MACHXO2_REFRESH_USEC;
-	tx.delay.unit = SPI_DELAY_UNIT_USECS;
+	cmd.cmd = refresh;
+	cmd.cmd_len = sizeof(refresh);
+	cmd.delay_us = MACHXO2_REFRESH_USEC;
 
 	do {
-		ret = spi_sync_transfer(spi, &tx, 1);
+		ret = machxo2_write_spi(spi, &cmd, 1);
 		if (ret)
 			goto fail;
 
-- 
2.30.2

