Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C46715A134A
	for <lists+linux-fpga@lfdr.de>; Thu, 25 Aug 2022 16:18:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233537AbiHYOQ4 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 25 Aug 2022 10:16:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237392AbiHYOOf (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 25 Aug 2022 10:14:35 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9674B69D1
        for <linux-fpga@vger.kernel.org>; Thu, 25 Aug 2022 07:14:20 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <jzi@pengutronix.de>)
        id 1oRDcg-0002yi-8W; Thu, 25 Aug 2022 16:14:18 +0200
Received: from [2a0a:edc0:0:1101:1d::39] (helo=dude03.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <jzi@pengutronix.de>)
        id 1oRDcf-001unV-9z; Thu, 25 Aug 2022 16:14:17 +0200
Received: from jzi by dude03.red.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <jzi@pengutronix.de>)
        id 1oRDcc-005xwO-2l; Thu, 25 Aug 2022 16:14:14 +0200
From:   Johannes Zink <j.zink@pengutronix.de>
To:     linux-fpga@vger.kernel.org
Cc:     devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, kernel@pengutronix.de,
        Johannes Zink <j.zink@pengutronix.de>
Subject: [PATCH 08/16] fpga: machxo2-spi: simplify with spi_sync_transfer()
Date:   Thu, 25 Aug 2022 16:13:35 +0200
Message-Id: <20220825141343.1375690-9-j.zink@pengutronix.de>
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

Use helper functions in order to improve readability.

Signed-off-by: Johannes Zink <j.zink@pengutronix.de>
---
 drivers/fpga/machxo2-spi.c | 96 ++++++++++++++------------------------
 1 file changed, 36 insertions(+), 60 deletions(-)

diff --git a/drivers/fpga/machxo2-spi.c b/drivers/fpga/machxo2-spi.c
index d1a8f28e04e7..7f7d1066ddee 100644
--- a/drivers/fpga/machxo2-spi.c
+++ b/drivers/fpga/machxo2-spi.c
@@ -64,22 +64,17 @@ static inline u8 get_err(u32 status)
 
 static int get_status(struct spi_device *spi, u32 *status)
 {
-	struct spi_message msg;
-	struct spi_transfer rx, tx;
+	struct spi_transfer transfers[2] = {};
 	static const u8 cmd[] = LSC_READ_STATUS;
 	__be32 tmp;
 	int ret;
 
-	memset(&rx, 0, sizeof(rx));
-	memset(&tx, 0, sizeof(tx));
-	tx.tx_buf = cmd;
-	tx.len = sizeof(cmd);
-	rx.rx_buf = &tmp;
-	rx.len = sizeof(tmp);
-	spi_message_init(&msg);
-	spi_message_add_tail(&tx, &msg);
-	spi_message_add_tail(&rx, &msg);
-	ret = spi_sync(spi, &msg);
+	transfers[0].tx_buf = cmd;
+	transfers[0].len = sizeof(cmd);
+	transfers[1].rx_buf = &tmp;
+	transfers[1].len = sizeof(tmp);
+
+	ret = spi_sync_transfer(spi, transfers, ARRAY_SIZE(transfers));
 	if (ret)
 		return ret;
 
@@ -131,18 +126,14 @@ static int wait_until_not_busy(struct spi_device *spi)
 static int machxo2_cleanup(struct fpga_manager *mgr)
 {
 	struct spi_device *spi = mgr->priv;
-	struct spi_message msg;
-	struct spi_transfer tx[2];
 	static const u8 erase[] = ISC_ERASE;
 	static const u8 refresh[] = LSC_REFRESH;
+	struct spi_transfer tx = {};
 	int ret;
 
-	memset(tx, 0, sizeof(tx));
-	spi_message_init(&msg);
-	tx[0].tx_buf = &erase;
-	tx[0].len = sizeof(erase);
-	spi_message_add_tail(&tx[0], &msg);
-	ret = spi_sync(spi, &msg);
+	tx.tx_buf = &erase;
+	tx.len = sizeof(erase);
+	ret = spi_sync_transfer(spi, &tx, 1);
 	if (ret)
 		goto fail;
 
@@ -150,13 +141,11 @@ static int machxo2_cleanup(struct fpga_manager *mgr)
 	if (ret)
 		goto fail;
 
-	spi_message_init(&msg);
-	tx[1].tx_buf = &refresh;
-	tx[1].len = sizeof(refresh);
-	tx[1].delay.value = MACHXO2_REFRESH_USEC;
-	tx[1].delay.unit = SPI_DELAY_UNIT_USECS;
-	spi_message_add_tail(&tx[1], &msg);
-	ret = spi_sync(spi, &msg);
+	tx.tx_buf = &refresh;
+	tx.len = sizeof(refresh);
+	tx.delay.value = MACHXO2_REFRESH_USEC;
+	tx.delay.unit = SPI_DELAY_UNIT_USECS;
+	ret = spi_sync_transfer(spi, &tx, 1);
 	if (ret)
 		goto fail;
 
@@ -190,8 +179,7 @@ static int machxo2_write_init(struct fpga_manager *mgr,
 			      const char *buf, size_t count)
 {
 	struct spi_device *spi = mgr->priv;
-	struct spi_message msg;
-	struct spi_transfer tx[3];
+	struct spi_transfer tx[2] = {};
 	static const u8 enable[] = ISC_ENABLE;
 	static const u8 erase[] = ISC_ERASE;
 	static const u8 initaddr[] = LSC_INITADDRESS;
@@ -206,18 +194,15 @@ static int machxo2_write_init(struct fpga_manager *mgr,
 
 	get_status(spi, &status);
 	dump_status_reg(status);
-	memset(tx, 0, sizeof(tx));
-	spi_message_init(&msg);
+
 	tx[0].tx_buf = &enable;
 	tx[0].len = sizeof(enable);
 	tx[0].delay.value = MACHXO2_LOW_DELAY_USEC;
 	tx[0].delay.unit = SPI_DELAY_UNIT_USECS;
-	spi_message_add_tail(&tx[0], &msg);
 
 	tx[1].tx_buf = &erase;
 	tx[1].len = sizeof(erase);
-	spi_message_add_tail(&tx[1], &msg);
-	ret = spi_sync(spi, &msg);
+	ret = spi_sync_transfer(spi, tx, ARRAY_SIZE(tx));
 	if (ret)
 		goto fail;
 
@@ -232,11 +217,9 @@ static int machxo2_write_init(struct fpga_manager *mgr,
 	}
 	dump_status_reg(status);
 
-	spi_message_init(&msg);
-	tx[2].tx_buf = &initaddr;
-	tx[2].len = sizeof(initaddr);
-	spi_message_add_tail(&tx[2], &msg);
-	ret = spi_sync(spi, &msg);
+	tx[0].tx_buf = &initaddr;
+	tx[0].len = sizeof(initaddr);
+	ret = spi_sync_transfer(spi, &tx[0], 1);
 	if (ret)
 		goto fail;
 
@@ -254,8 +237,6 @@ static int machxo2_write(struct fpga_manager *mgr, const char *buf,
 			 size_t count)
 {
 	struct spi_device *spi = mgr->priv;
-	struct spi_message msg;
-	struct spi_transfer tx;
 	static const u8 progincr[] = LSC_PROGINCRNV;
 	u8 payload[MACHXO2_BUF_SIZE];
 	u32 status;
@@ -269,15 +250,15 @@ static int machxo2_write(struct fpga_manager *mgr, const char *buf,
 	dump_status_reg(status);
 	memcpy(payload, &progincr, sizeof(progincr));
 	for (i = 0; i < count; i += MACHXO2_PAGE_SIZE) {
+		struct spi_transfer tx = {};
+
 		memcpy(&payload[sizeof(progincr)], &buf[i], MACHXO2_PAGE_SIZE);
-		memset(&tx, 0, sizeof(tx));
-		spi_message_init(&msg);
+
 		tx.tx_buf = payload;
 		tx.len = MACHXO2_BUF_SIZE;
 		tx.delay.value = MACHXO2_HIGH_DELAY_USEC;
 		tx.delay.unit = SPI_DELAY_UNIT_USECS;
-		spi_message_add_tail(&tx, &msg);
-		ret = spi_sync(spi, &msg);
+		ret = spi_sync_transfer(spi, &tx, 1);
 		if (ret) {
 			dev_err(&mgr->dev, "Error loading the bitstream.\n");
 			return ret;
@@ -293,19 +274,15 @@ static int machxo2_write_complete(struct fpga_manager *mgr,
 				  struct fpga_image_info *info)
 {
 	struct spi_device *spi = mgr->priv;
-	struct spi_message msg;
-	struct spi_transfer tx[2];
+	struct spi_transfer tx = {};
 	static const u8 progdone[] = ISC_PROGRAMDONE;
 	static const u8 refresh[] = LSC_REFRESH;
 	u32 status;
 	int ret, refreshloop = 0;
 
-	memset(tx, 0, sizeof(tx));
-	spi_message_init(&msg);
-	tx[0].tx_buf = &progdone;
-	tx[0].len = sizeof(progdone);
-	spi_message_add_tail(&tx[0], &msg);
-	ret = spi_sync(spi, &msg);
+	tx.tx_buf = &progdone;
+	tx.len = sizeof(progdone);
+	ret = spi_sync_transfer(spi, &tx, 1);
 	if (ret)
 		goto fail;
 	ret = wait_until_not_busy(spi);
@@ -320,14 +297,13 @@ static int machxo2_write_complete(struct fpga_manager *mgr,
 		goto fail;
 	}
 
+	tx.tx_buf = &refresh;
+	tx.len = sizeof(refresh);
+	tx.delay.value = MACHXO2_REFRESH_USEC;
+	tx.delay.unit = SPI_DELAY_UNIT_USECS;
+
 	do {
-		spi_message_init(&msg);
-		tx[1].tx_buf = &refresh;
-		tx[1].len = sizeof(refresh);
-		tx[1].delay.value = MACHXO2_REFRESH_USEC;
-		tx[1].delay.unit = SPI_DELAY_UNIT_USECS;
-		spi_message_add_tail(&tx[1], &msg);
-		ret = spi_sync(spi, &msg);
+		ret = spi_sync_transfer(spi, &tx, 1);
 		if (ret)
 			goto fail;
 
-- 
2.30.2

