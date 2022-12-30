Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF5B36596CD
	for <lists+linux-fpga@lfdr.de>; Fri, 30 Dec 2022 10:34:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234829AbiL3JcS (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 30 Dec 2022 04:32:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234805AbiL3JcQ (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 30 Dec 2022 04:32:16 -0500
Received: from mail.pr-group.ru (mail.pr-group.ru [178.18.215.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A40B1A20F;
        Fri, 30 Dec 2022 01:32:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
        d=metrotek.ru; s=mail;
        h=from:subject:date:message-id:to:cc:mime-version:content-transfer-encoding:
         in-reply-to:references;
        bh=/ihIkO5snmzqBy+4+LJopWc7knE0i7yPw81w1MiqSmQ=;
        b=e/uOV8CpIKBh6A8A0UK17zK1onjA8l07TCIrdxGMNAmYX/YsXNUvFAFKZliDyUKTvjH3U6ga2ZNA7
         Mq4Zr2uMh4xB7fSEE+HcOuhJLmpVbHWETu2ZXmWHn4I6wsbMM6QmGKLqzCuuc6c/SXCPC4jcsGSZLl
         IT+oeWVUzREv0eCVcOIoKc21d1Zu/9OiY4q1j/DfOOpgc5eTyqH7ydvuDc1OpXLhUrUgBNpLAfKAwx
         U1bAtvyRCU1k9uhhSQRupAqPwlPtVY3/bz1/M5e8PaScSSy/h3tOaA62JLbfypCQGYWWKp968LMOvb
         yYzLxL9xfZ9AnRMzssj+F0E46Vy+79A==
X-Kerio-Anti-Spam:  Build: [Engines: 2.16.5.1460, Stamp: 3], Multi: [Enabled, t: (0.000010,0.010605)], BW: [Enabled, t: (0.000030,0.000002)], RTDA: [Enabled, t: (0.085502), Hit: No, Details: v2.42.0; Id: 15.52k84j.1glh5vaj6.26g; mclb], total: 0(700)
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLACK autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: 
X-Footer: bWV0cm90ZWsucnU=
Received: from localhost.localdomain ([78.37.162.181])
        (authenticated user i.bornyakov@metrotek.ru)
        by mail.pr-group.ru with ESMTPSA
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits));
        Fri, 30 Dec 2022 12:31:52 +0300
From:   Ivan Bornyakov <i.bornyakov@metrotek.ru>
To:     linux-fpga@vger.kernel.org
Cc:     Ivan Bornyakov <i.bornyakov@metrotek.ru>,
        Conor Dooley <conor.dooley@microchip.com>,
        Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        linux-kernel@vger.kernel.org, system@metrotek.ru
Subject: [PATCH v5 3/3] fpga: microchip-spi: separate data frame write routine
Date:   Fri, 30 Dec 2022 12:29:22 +0300
Message-Id: <20221230092922.18822-4-i.bornyakov@metrotek.ru>
X-Mailer: git-send-email 2.38.2
In-Reply-To: <20221230092922.18822-1-i.bornyakov@metrotek.ru>
References: <20221230092922.18822-1-i.bornyakov@metrotek.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

mpf_ops_write() function writes bitstream data to the FPGA by a smaller
frames. Introduce mpf_spi_frame_write() function which is for writing a
single data frame and use it in mpf_ops_write().

No functional changes intended.

Signed-off-by: Ivan Bornyakov <i.bornyakov@metrotek.ru>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Acked-by: Xu Yilun <yilun.xu@intel.com>
---
 drivers/fpga/microchip-spi.c | 36 +++++++++++++++++++++++-------------
 1 file changed, 23 insertions(+), 13 deletions(-)

diff --git a/drivers/fpga/microchip-spi.c b/drivers/fpga/microchip-spi.c
index 137fafdf57a6..d6070e7f5205 100644
--- a/drivers/fpga/microchip-spi.c
+++ b/drivers/fpga/microchip-spi.c
@@ -280,9 +280,30 @@ static int mpf_ops_write_init(struct fpga_manager *mgr,
 	return 0;
 }
 
+static int mpf_spi_frame_write(struct mpf_priv *priv, const char *buf)
+{
+	struct spi_transfer xfers[2] = {
+		{
+			.tx_buf = &priv->tx,
+			.len = 1,
+		}, {
+			.tx_buf = buf,
+			.len = MPF_SPI_FRAME_SIZE,
+		},
+	};
+	int ret;
+
+	ret = mpf_poll_status(priv, 0);
+	if (ret < 0)
+		return ret;
+
+	priv->tx = MPF_SPI_FRAME;
+
+	return spi_sync_transfer(priv->spi, xfers, ARRAY_SIZE(xfers));
+}
+
 static int mpf_ops_write(struct fpga_manager *mgr, const char *buf, size_t count)
 {
-	struct spi_transfer xfers[2] = { 0 };
 	struct mpf_priv *priv = mgr->priv;
 	struct device *dev = &mgr->dev;
 	int ret, i;
@@ -293,19 +314,8 @@ static int mpf_ops_write(struct fpga_manager *mgr, const char *buf, size_t count
 		return -EINVAL;
 	}
 
-	xfers[0].tx_buf = &priv->tx;
-	xfers[0].len = 1;
-
 	for (i = 0; i < count / MPF_SPI_FRAME_SIZE; i++) {
-		xfers[1].tx_buf = buf + i * MPF_SPI_FRAME_SIZE;
-		xfers[1].len = MPF_SPI_FRAME_SIZE;
-
-		ret = mpf_poll_status(priv, 0);
-		if (ret >= 0) {
-			priv->tx = MPF_SPI_FRAME;
-			ret = spi_sync_transfer(priv->spi, xfers, ARRAY_SIZE(xfers));
-		}
-
+		ret = mpf_spi_frame_write(priv, buf + i * MPF_SPI_FRAME_SIZE);
 		if (ret) {
 			dev_err(dev, "Failed to write bitstream frame %d/%zu\n",
 				i, count / MPF_SPI_FRAME_SIZE);
-- 
2.38.2


