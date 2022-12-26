Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 224A9656376
	for <lists+linux-fpga@lfdr.de>; Mon, 26 Dec 2022 15:38:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbiLZOhG (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 26 Dec 2022 09:37:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232046AbiLZO3K (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 26 Dec 2022 09:29:10 -0500
Received: from mail.pr-group.ru (mail.pr-group.ru [178.18.215.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27B8464E6;
        Mon, 26 Dec 2022 06:26:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
        d=metrotek.ru; s=mail;
        h=from:subject:date:message-id:to:cc:mime-version:content-transfer-encoding:
         in-reply-to:references;
        bh=OPFaov/D+WEk0jxM8EJ2ri7LYnuA1DGPmJbwAx21UNU=;
        b=Hy78NZ8SqKHl8t6eaajQ7/qYdr5N2hZ73fPnyOtJzn1boVp3Asa2dn/LYrzqhvL/Fwcm0VbqO70xF
         Qe8ULUll2rLuz9CI/mEEqcYYGg0XgVY9hllvgjFVa/tztAf9tzABpyJGZ3WVoFCT/UWEqSyYvv8XRn
         aSDYBjC/43eos7wds50TX+TToG/BZyFQtj79XNGu6gYhsDZUuUTzkQkEiqJx3FWn4J0BkESM17okfK
         Fw9wBKcz/O5WxzoaGC2Nnf4ffx37F7Y9xDGIf8Wpvy82SwkQigzNy8mtYZnVXizb+ioeCCKATuExtV
         3N/3sPipGxQQjjx2amWHYk/bAuE9dpw==
X-Kerio-Anti-Spam:  Build: [Engines: 2.16.5.1460, Stamp: 3], Multi: [Enabled, t: (0.000008,0.010166)], BW: [Enabled, t: (0.000023,0.000001)], RTDA: [Enabled, t: (0.126371), Hit: No, Details: v2.42.0; Id: 15.52k53i.1gl7d6ud3.2p; mclb], total: 0(700)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Level: 
X-Footer: bWV0cm90ZWsucnU=
Received: from localhost.localdomain ([78.37.162.181])
        (authenticated user i.bornyakov@metrotek.ru)
        by mail.pr-group.ru with ESMTPSA
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits));
        Mon, 26 Dec 2022 17:25:59 +0300
From:   Ivan Bornyakov <i.bornyakov@metrotek.ru>
To:     Conor Dooley <conor.dooley@microchip.com>,
        Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>
Cc:     Ivan Bornyakov <i.bornyakov@metrotek.ru>,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        system@metrotek.ru
Subject: [PATCH v2 3/3] fpga: microchip-spi: separate data frame write routine
Date:   Mon, 26 Dec 2022 17:23:26 +0300
Message-Id: <20221226142326.8111-4-i.bornyakov@metrotek.ru>
X-Mailer: git-send-email 2.38.2
In-Reply-To: <20221226142326.8111-1-i.bornyakov@metrotek.ru>
References: <20221226142326.8111-1-i.bornyakov@metrotek.ru>
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
---
 drivers/fpga/microchip-spi.c | 36 +++++++++++++++++++++++-------------
 1 file changed, 23 insertions(+), 13 deletions(-)

diff --git a/drivers/fpga/microchip-spi.c b/drivers/fpga/microchip-spi.c
index f3ddfab87499..f8a6872c865b 100644
--- a/drivers/fpga/microchip-spi.c
+++ b/drivers/fpga/microchip-spi.c
@@ -275,9 +275,30 @@ static int mpf_ops_write_init(struct fpga_manager *mgr,
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
@@ -288,19 +309,8 @@ static int mpf_ops_write(struct fpga_manager *mgr, const char *buf, size_t count
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


