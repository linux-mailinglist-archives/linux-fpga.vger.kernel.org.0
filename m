Return-Path: <linux-fpga+bounces-133-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D58982E1AF
	for <lists+linux-fpga@lfdr.de>; Mon, 15 Jan 2024 21:22:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A4EE2838CE
	for <lists+linux-fpga@lfdr.de>; Mon, 15 Jan 2024 20:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 316B21A712;
	Mon, 15 Jan 2024 20:21:25 +0000 (UTC)
X-Original-To: linux-fpga@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42551A5A2
	for <linux-fpga@vger.kernel.org>; Mon, 15 Jan 2024 20:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rPTSD-0004fw-TL; Mon, 15 Jan 2024 21:21:05 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rPTSC-0005fx-VP; Mon, 15 Jan 2024 21:21:04 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rPTSC-000N76-2n;
	Mon, 15 Jan 2024 21:21:04 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Mark Brown <broonie@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Cc: linux-spi@vger.kernel.org,
	kernel@pengutronix.de,
	Moritz Fischer <mdf@kernel.org>,
	Wu Hao <hao.wu@intel.com>,
	Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>,
	linux-fpga@vger.kernel.org
Subject: [PATCH 01/33] fpga: ice40-spi: Follow renaming of SPI "master" to "controller"
Date: Mon, 15 Jan 2024 21:12:47 +0100
Message-ID:  <caef8566918e708daee60c211ab2d12b926f95a5.1705348269.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1705348269.git.u.kleine-koenig@pengutronix.de>
References: <cover.1705348269.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1103; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=fSgQPTezpGR5drXnUnq6i6N7m9qJ4nBuVl3s9l71bY4=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlpZHBzGVb3YfhNUzjTWynzV63cdWW87u++P0uQ zUzdyWau/GJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZaWRwQAKCRCPgPtYfRL+ TjRFCACkNvheXPy87TdwTjEKL3jBLF0liDyvOpTs3OFGmB/zZdwXj/VSRn9EYwnJJboNn25K2m/ XpeZ/jg5m3X3SOm9h2pGuMtwtwL8XyRupfE/8ev+dT4jzmYIPP3XUx9j1ANJpcVN10GGp/z43Tn Dku/Arx6G5PadrdD+RE6Jsn7mLQ98ba9GtXqpXhk7HasMs4nybqEd2kIETakC7l10HE06ZomQoV fcZLYz8eC/XJfcAqZ7A7aFYmyFWG64xJeGuUMcpksCm5xzV68hUpizzCfcncd+axKHdF3Uf8Q85 Le0bv+9Xwt5nRqWx1i8EOXv73Ns8gARo1JtWQ+lP0eC06XaA
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-fpga@vger.kernel.org

In commit 8caab75fd2c2 ("spi: Generalize SPI "master" to "controller"")
some functions and struct members were renamed. To not break all drivers
compatibility macros were provided.

To be able to remove these compatibility macros push the renaming into
this driver.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/fpga/ice40-spi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/fpga/ice40-spi.c b/drivers/fpga/ice40-spi.c
index 7cbb3558b844..c0028ae4c5b7 100644
--- a/drivers/fpga/ice40-spi.c
+++ b/drivers/fpga/ice40-spi.c
@@ -66,7 +66,7 @@ static int ice40_fpga_ops_write_init(struct fpga_manager *mgr,
 	}
 
 	/* Lock the bus, assert CRESET_B and SS_B and delay >200ns */
-	spi_bus_lock(dev->master);
+	spi_bus_lock(dev->controller);
 
 	gpiod_set_value(priv->reset, 1);
 
@@ -94,7 +94,7 @@ static int ice40_fpga_ops_write_init(struct fpga_manager *mgr,
 	ret = spi_sync_locked(dev, &message);
 
 fail:
-	spi_bus_unlock(dev->master);
+	spi_bus_unlock(dev->controller);
 
 	return ret;
 }
-- 
2.43.0


