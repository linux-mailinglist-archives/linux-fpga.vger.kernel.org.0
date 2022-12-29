Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DBDA658BF8
	for <lists+linux-fpga@lfdr.de>; Thu, 29 Dec 2022 11:51:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233120AbiL2KtY (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 29 Dec 2022 05:49:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbiL2KtL (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 29 Dec 2022 05:49:11 -0500
Received: from mail.pr-group.ru (mail.pr-group.ru [178.18.215.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFED912A9D;
        Thu, 29 Dec 2022 02:49:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
        d=metrotek.ru; s=mail;
        h=from:subject:date:message-id:to:cc:mime-version:content-transfer-encoding:
         in-reply-to:references;
        bh=GI2mMm/uGWkE5p1bnryw0SBqR2l3kOJ73Yw+GoVPPS8=;
        b=Ns25fgEfZqwQ0qPGTbBDXXH4yrc27AJGxDDF5VY9tiHLsYdQdGKCzx/YYnNTzcDcAoTQwg8Q+/8hW
         mXfbCClyshrSVJ1uGHBmeTGnB2MhKlVnJOZvgFPs8MWDYnkkltDtcWGb61A3TmFeSgKLY7WgPlRmIw
         diujQR3S1gaI3kQ2nx/S5Cc6iFulnMZI6Mn51355hdxu5GT56L73JCAeYny5fNtG8lvqNJZeYTheuH
         dxods8/DW+XcokBkAiOH858xK1Pbi70+eoGb2msb2kJn2f7sO6z0PDDD+1rTJ4YgkOiJa8haaDJC07
         g2/Rau2UFBuNhR5qKvIgeOHglx/qONg==
X-Kerio-Anti-Spam:  Build: [Engines: 2.16.5.1460, Stamp: 3], Multi: [Enabled, t: (0.000009,0.010010)], BW: [Enabled, t: (0.000021,0.000001)], RTDA: [Enabled, t: (0.090851), Hit: No, Details: v2.42.0; Id: 15.52k4ev.1glenvctm.3mn1; mclb], total: 0(700)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Level: 
X-Footer: bWV0cm90ZWsucnU=
Received: from h-e2.ddg ([85.143.252.66])
        (authenticated user i.bornyakov@metrotek.ru)
        by mail.pr-group.ru with ESMTPSA
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits));
        Thu, 29 Dec 2022 13:48:45 +0300
From:   Ivan Bornyakov <i.bornyakov@metrotek.ru>
To:     linux-fpga@vger.kernel.org
Cc:     Ivan Bornyakov <i.bornyakov@metrotek.ru>,
        Conor Dooley <conor.dooley@microchip.com>,
        Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        linux-kernel@vger.kernel.org, system@metrotek.ru
Subject: [PATCH v4 3/3] fpga: microchip-spi: separate data frame write routine
Date:   Thu, 29 Dec 2022 13:46:04 +0300
Message-Id: <20221229104604.2496-4-i.bornyakov@metrotek.ru>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20221229104604.2496-1-i.bornyakov@metrotek.ru>
References: <20221229104604.2496-1-i.bornyakov@metrotek.ru>
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
---
 drivers/fpga/microchip-spi.c | 36 +++++++++++++++++++++++-------------
 1 file changed, 23 insertions(+), 13 deletions(-)

diff --git a/drivers/fpga/microchip-spi.c b/drivers/fpga/microchip-spi.c
index 995b1964e0fe..8a541986f6f2 100644
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
2.39.0


