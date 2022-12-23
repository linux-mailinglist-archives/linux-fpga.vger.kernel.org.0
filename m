Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65DB66550BF
	for <lists+linux-fpga@lfdr.de>; Fri, 23 Dec 2022 14:13:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbiLWNMI (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 23 Dec 2022 08:12:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbiLWNMH (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 23 Dec 2022 08:12:07 -0500
X-Greylist: delayed 1817 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 23 Dec 2022 05:12:02 PST
Received: from mail.pr-group.ru (mail.pr-group.ru [178.18.215.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85E0C27DC4
        for <linux-fpga@vger.kernel.org>; Fri, 23 Dec 2022 05:12:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
        d=metrotek.ru; s=mail;
        h=from:subject:date:message-id:to:cc:mime-version:content-transfer-encoding;
        bh=5rs080jU8HOw9fPaCutZbAKtsnfyAAH3tzJFpui62Dc=;
        b=UFtJvJZEOlCEnuSqv97FMOfNpS5wYTP6MpXfTiS36lTZCRIUasYVe5cE0Jmh+D0gm7PJ04F71zal6
         xvhftxMdto1aMOdF6Hf1bcbDMys28woZYVJZGb+vAH2mJEWI+YYC5uUJC0+CreFLFhtWAUBgvmNVNl
         AzRvBkajVe5mTUtAiXCEnsYaiYcj0ogqk8P5PGbuOoYKEkFWhKSs4zKpX2anMAulNOTUukSATuOK77
         85HB+q5zxHSEkAdMAkztUhqYVnzsCA8KgXBai24Pvmo1P9iWZr1VBNjOvU/4i3Xx5WUtejnzulsgvz
         v0SWdkDS04WxefszZDGsMt/eQ1q3Dfg==
X-Kerio-Anti-Spam:  Build: [Engines: 2.16.5.1460, Stamp: 3], Multi: [Enabled, t: (0.000010,0.035879)], BW: [Enabled, t: (0.000024,0.000002)], RTDA: [Enabled, t: (0.084619), Hit: No, Details: v2.42.0; Id: 15.52k09k.1gkvg1aha.iadb; mclb], total: 0(700)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Level: 
X-Footer: bWV0cm90ZWsucnU=
Received: from localhost.localdomain ([78.37.162.181])
        (authenticated user i.bornyakov@metrotek.ru)
        by mail.pr-group.ru with ESMTPSA
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits));
        Fri, 23 Dec 2022 15:41:23 +0300
From:   Ivan Bornyakov <i.bornyakov@metrotek.ru>
To:     linux-fpga@vger.kernel.org
Cc:     conor.dooley@microchip.com, mdf@kernel.org, hao.wu@intel.com,
        yilun.xu@intel.com, trix@redhat.com, linux-kernel@vger.kernel.org,
        system@metrotek.ru, Ivan Bornyakov <i.bornyakov@metrotek.ru>
Subject: [PATCH] fpga: microchip-spi: move SPI I/O buffers out of stack
Date:   Fri, 23 Dec 2022 15:38:54 +0300
Message-Id: <20221223123854.8023-1-i.bornyakov@metrotek.ru>
X-Mailer: git-send-email 2.38.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

As spi-summary doc says:
 > I/O buffers use the usual Linux rules, and must be DMA-safe.
 > You'd normally allocate them from the heap or free page pool.
 > Don't use the stack, or anything that's declared "static".

Replace spi_write() with spi_write_then_read(), which is dma-safe for
on-stack buffers. Use allocated buffers for transfers used in
spi_sync_transfer().

Although everything works OK with stack-located I/O buffers, better
follow the doc to be safe.

While at it, replace busy loop in mpf_poll_status() routine with
read_poll_timeout() macro. Original busy loop is not too reliable, as it
takes different times on different systems.

Fixes: 5f8d4a900830 ("fpga: microchip-spi: add Microchip MPF FPGA manager")
Signed-off-by: Ivan Bornyakov <i.bornyakov@metrotek.ru>
---
 drivers/fpga/microchip-spi.c | 145 +++++++++++++++++++----------------
 1 file changed, 80 insertions(+), 65 deletions(-)

diff --git a/drivers/fpga/microchip-spi.c b/drivers/fpga/microchip-spi.c
index 7436976ea904..dfb4e071db86 100644
--- a/drivers/fpga/microchip-spi.c
+++ b/drivers/fpga/microchip-spi.c
@@ -6,6 +6,7 @@
 #include <asm/unaligned.h>
 #include <linux/delay.h>
 #include <linux/fpga/fpga-mgr.h>
+#include <linux/iopoll.h>
 #include <linux/module.h>
 #include <linux/of_device.h>
 #include <linux/spi/spi.h>
@@ -33,7 +34,6 @@
 
 #define	MPF_BITS_PER_COMPONENT_SIZE	22
 
-#define	MPF_STATUS_POLL_RETRIES		10000
 #define	MPF_STATUS_BUSY			BIT(0)
 #define	MPF_STATUS_READY		BIT(1)
 #define	MPF_STATUS_SPI_VIOLATION	BIT(2)
@@ -42,46 +42,55 @@
 struct mpf_priv {
 	struct spi_device *spi;
 	bool program_mode;
+	u8 *tx;
+	u8 *rx;
 };
 
-static int mpf_read_status(struct spi_device *spi)
+static int mpf_read_status(struct mpf_priv *priv)
 {
-	u8 status = 0, status_command = MPF_SPI_READ_STATUS;
-	struct spi_transfer xfers[2] = { 0 };
-	int ret;
-
 	/*
 	 * HW status is returned on MISO in the first byte after CS went
 	 * active. However, first reading can be inadequate, so we submit
 	 * two identical SPI transfers and use result of the later one.
 	 */
-	xfers[0].tx_buf = &status_command;
-	xfers[1].tx_buf = &status_command;
-	xfers[0].rx_buf = &status;
-	xfers[1].rx_buf = &status;
-	xfers[0].len = 1;
-	xfers[1].len = 1;
-	xfers[0].cs_change = 1;
+	struct spi_transfer xfers[2] = {
+		{
+			.tx_buf = priv->tx,
+			.rx_buf = priv->rx,
+			.len = 1,
+			.cs_change = 1,
+		}, {
+			.tx_buf = priv->tx,
+			.rx_buf = priv->rx,
+			.len = 1,
+		},
+	};
+	u8 status;
+	int ret;
 
-	ret = spi_sync_transfer(spi, xfers, 2);
+	*priv->tx = MPF_SPI_READ_STATUS;
+
+	ret = spi_sync_transfer(priv->spi, xfers, 2);
+	if (ret)
+		return ret;
+
+	status = *priv->rx;
 
 	if ((status & MPF_STATUS_SPI_VIOLATION) ||
 	    (status & MPF_STATUS_SPI_ERROR))
-		ret = -EIO;
+		return -EIO;
 
-	return ret ? : status;
+	return status;
 }
 
 static enum fpga_mgr_states mpf_ops_state(struct fpga_manager *mgr)
 {
 	struct mpf_priv *priv = mgr->priv;
-	struct spi_device *spi;
 	bool program_mode;
 	int status;
 
-	spi = priv->spi;
 	program_mode = priv->program_mode;
-	status = mpf_read_status(spi);
+	status = mpf_read_status(priv);
 
 	if (!program_mode && !status)
 		return FPGA_MGR_STATE_OPERATING;
@@ -186,51 +195,47 @@ static int mpf_ops_parse_header(struct fpga_manager *mgr,
 }
 
 /* Poll HW status until busy bit is cleared and mask bits are set. */
-static int mpf_poll_status(struct spi_device *spi, u8 mask)
+static int mpf_poll_status(struct mpf_priv *priv, u8 mask)
 {
-	int status, retries = MPF_STATUS_POLL_RETRIES;
-
-	while (retries--) {
-		status = mpf_read_status(spi);
-		if (status < 0)
-			return status;
+	int ret, status;
 
-		if (status & MPF_STATUS_BUSY)
-			continue;
-
-		if (!mask || (status & mask))
-			return status;
-	}
+	ret = read_poll_timeout(mpf_read_status, status,
+				(status < 0) ||
+				(!(status & MPF_STATUS_BUSY) &&
+				 (!mask || (status & mask))),
+				0, 2 * USEC_PER_SEC, false, priv);
+	if (ret < 0)
+		return ret;
 
-	return -EBUSY;
+	return status;
 }
 
-static int mpf_spi_write(struct spi_device *spi, const void *buf, size_t buf_size)
+static int mpf_spi_write(struct mpf_priv *priv, const void *buf, size_t buf_size)
 {
-	int status = mpf_poll_status(spi, 0);
+	int status = mpf_poll_status(priv, 0);
 
 	if (status < 0)
 		return status;
 
-	return spi_write(spi, buf, buf_size);
+	return spi_write_then_read(priv->spi, buf, buf_size, NULL, 0);
 }
 
-static int mpf_spi_write_then_read(struct spi_device *spi,
+static int mpf_spi_write_then_read(struct mpf_priv *priv,
 				   const void *txbuf, size_t txbuf_size,
 				   void *rxbuf, size_t rxbuf_size)
 {
 	const u8 read_command[] = { MPF_SPI_READ_DATA };
 	int ret;
 
-	ret = mpf_spi_write(spi, txbuf, txbuf_size);
+	ret = mpf_spi_write(priv, txbuf, txbuf_size);
 	if (ret)
 		return ret;
 
-	ret = mpf_poll_status(spi, MPF_STATUS_READY);
+	ret = mpf_poll_status(priv, MPF_STATUS_READY);
 	if (ret < 0)
 		return ret;
 
-	return spi_write_then_read(spi, read_command, sizeof(read_command),
+	return spi_write_then_read(priv->spi, read_command, sizeof(read_command),
 				   rxbuf, rxbuf_size);
 }
 
@@ -242,7 +247,6 @@ static int mpf_ops_write_init(struct fpga_manager *mgr,
 	const u8 isc_en_command[] = { MPF_SPI_ISC_ENABLE };
 	struct mpf_priv *priv = mgr->priv;
 	struct device *dev = &mgr->dev;
-	struct spi_device *spi;
 	u32 isc_ret = 0;
 	int ret;
 
@@ -251,9 +255,7 @@ static int mpf_ops_write_init(struct fpga_manager *mgr,
 		return -EOPNOTSUPP;
 	}
 
-	spi = priv->spi;
-
-	ret = mpf_spi_write_then_read(spi, isc_en_command, sizeof(isc_en_command),
+	ret = mpf_spi_write_then_read(priv, isc_en_command, sizeof(isc_en_command),
 				      &isc_ret, sizeof(isc_ret));
 	if (ret || isc_ret) {
 		dev_err(dev, "Failed to enable ISC: spi_ret %d, isc_ret %u\n",
@@ -261,7 +263,7 @@ static int mpf_ops_write_init(struct fpga_manager *mgr,
 		return -EFAULT;
 	}
 
-	ret = mpf_spi_write(spi, program_mode, sizeof(program_mode));
+	ret = mpf_spi_write(priv, program_mode, sizeof(program_mode));
 	if (ret) {
 		dev_err(dev, "Failed to enter program mode: %d\n", ret);
 		return ret;
@@ -272,13 +274,32 @@ static int mpf_ops_write_init(struct fpga_manager *mgr,
 	return 0;
 }
 
+static int mpf_spi_frame_write(struct mpf_priv *priv, const char *buf)
+{
+	struct spi_transfer xfers[2] = {
+		{
+			.tx_buf = priv->tx,
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
+	*priv->tx = MPF_SPI_FRAME;
+
+	return spi_sync_transfer(priv->spi, xfers, ARRAY_SIZE(xfers));
+}
+
 static int mpf_ops_write(struct fpga_manager *mgr, const char *buf, size_t count)
 {
-	u8 spi_frame_command[] = { MPF_SPI_FRAME };
-	struct spi_transfer xfers[2] = { 0 };
 	struct mpf_priv *priv = mgr->priv;
 	struct device *dev = &mgr->dev;
-	struct spi_device *spi;
 	int ret, i;
 
 	if (count % MPF_SPI_FRAME_SIZE) {
@@ -287,19 +308,8 @@ static int mpf_ops_write(struct fpga_manager *mgr, const char *buf, size_t count
 		return -EINVAL;
 	}
 
-	spi = priv->spi;
-
-	xfers[0].tx_buf = spi_frame_command;
-	xfers[0].len = sizeof(spi_frame_command);
-
 	for (i = 0; i < count / MPF_SPI_FRAME_SIZE; i++) {
-		xfers[1].tx_buf = buf + i * MPF_SPI_FRAME_SIZE;
-		xfers[1].len = MPF_SPI_FRAME_SIZE;
-
-		ret = mpf_poll_status(spi, 0);
-		if (ret >= 0)
-			ret = spi_sync_transfer(spi, xfers, ARRAY_SIZE(xfers));
-
+		ret = mpf_spi_frame_write(priv, buf + i * MPF_SPI_FRAME_SIZE);
 		if (ret) {
 			dev_err(dev, "Failed to write bitstream frame %d/%zu\n",
 				i, count / MPF_SPI_FRAME_SIZE);
@@ -317,12 +327,9 @@ static int mpf_ops_write_complete(struct fpga_manager *mgr,
 	const u8 release_command[] = { MPF_SPI_RELEASE };
 	struct mpf_priv *priv = mgr->priv;
 	struct device *dev = &mgr->dev;
-	struct spi_device *spi;
 	int ret;
 
-	spi = priv->spi;
-
-	ret = mpf_spi_write(spi, isc_dis_command, sizeof(isc_dis_command));
+	ret = mpf_spi_write(priv, isc_dis_command, sizeof(isc_dis_command));
 	if (ret) {
 		dev_err(dev, "Failed to disable ISC: %d\n", ret);
 		return ret;
@@ -330,7 +337,7 @@ static int mpf_ops_write_complete(struct fpga_manager *mgr,
 
 	usleep_range(1000, 2000);
 
-	ret = mpf_spi_write(spi, release_command, sizeof(release_command));
+	ret = mpf_spi_write(priv, release_command, sizeof(release_command));
 	if (ret) {
 		dev_err(dev, "Failed to exit program mode: %d\n", ret);
 		return ret;
@@ -361,6 +368,14 @@ static int mpf_probe(struct spi_device *spi)
 	if (!priv)
 		return -ENOMEM;
 
+	priv->tx = devm_kmalloc(dev, 1, GFP_KERNEL);
+	if (!priv->tx)
+		return -ENOMEM;
+
+	priv->rx = devm_kmalloc(dev, 1, GFP_KERNEL);
+	if (!priv->rx)
+		return -ENOMEM;
+
 	priv->spi = spi;
 
 	mgr = devm_fpga_mgr_register(dev, "Microchip Polarfire SPI FPGA Manager",
-- 
2.38.2


