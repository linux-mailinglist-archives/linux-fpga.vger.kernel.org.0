Return-Path: <linux-fpga+bounces-72-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A014818E2E
	for <lists+linux-fpga@lfdr.de>; Tue, 19 Dec 2023 18:32:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF34E1F22CC9
	for <lists+linux-fpga@lfdr.de>; Tue, 19 Dec 2023 17:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50B8C23769;
	Tue, 19 Dec 2023 17:32:36 +0000 (UTC)
X-Original-To: linux-fpga@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 715E237D0C
	for <linux-fpga@vger.kernel.org>; Tue, 19 Dec 2023 17:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rFdxC-0005vG-8u; Tue, 19 Dec 2023 18:32:26 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rFdxA-0004Go-GL; Tue, 19 Dec 2023 18:32:25 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rFdxB-000CpP-AE; Tue, 19 Dec 2023 18:32:25 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Moritz Fischer <mdf@kernel.org>,
	Wu Hao <hao.wu@intel.com>,
	Xu Yilun <yilun.xu@intel.com>
Cc: Tom Rix <trix@redhat.com>,
	linux-fpga@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH 01/13] fpga: altera-fpga2sdram: Convert to platform remove callback returning void
Date: Tue, 19 Dec 2023 18:31:59 +0100
Message-ID:  <017b9e17a0c88b2a633467633d304639e7765926.1703006638.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1703006638.git.u.kleine-koenig@pengutronix.de>
References: <cover.1703006638.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1756; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=/O0zBG+j6BZWO8a8WR2bbHOJAzd+6kfq+RkQkZ+8ZWc=; b=owGbwMvMwMXY3/A7olbonx/jabUkhtTGy/1JflZCa684bV4i8aX33rZfd7bcNvsY+0fjzM5uH baHaUxPOxmNWRgYuRhkxRRZ7BvXZFpVyUV2rv13GWYQKxPIFAYuTgGYiEU4B8OE3Udj37TFzOmr F9AQ1N3BX8rKxccdWsitX6xz7UXWVE/TtFN//3qeWcYtf4ctUze03FFiT0PxvL2KFWkrV6Yuf3h XzyDXqdk17eB1nd1+lowmRU2/fya4nFSLZq9I2b6r3FP057VPf1IrNiXPrTm9Zd/DsNylNZy3OU Q7XYILg+on/XLunq8tI+eX8aeei9NW2KTE5stpz/MfTjF3PuEJ45jZ8EMl1d4wJj/D45R34jL1r 9GbSr7Lau1t2WelPtU1jTHhK98/ewmxfP2/lbocH6d01bwV9f3fpdHJsETuvmqHUMjv1ImHbm+u 6QzhuvHn84sHAtnl33Ui77zdeu6h3PXpmjVfpJm1d0cBAA==
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-fpga@vger.kernel.org

The .remove() callback for a platform driver returns an int which makes
many driver authors wrongly assume it's possible to do error handling by
returning an error code. However the value returned is ignored (apart
from emitting a warning) and this typically results in resource leaks.

To improve here there is a quest to make the remove callback return
void. In the first step of this quest all drivers are converted to
.remove_new(), which already returns void. Eventually after all drivers
are converted, .remove_new() will be renamed to .remove().

Trivially convert this driver from always returning zero in the remove
callback to the void returning variant.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/fpga/altera-fpga2sdram.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/fpga/altera-fpga2sdram.c b/drivers/fpga/altera-fpga2sdram.c
index 1fa2ccc321ab..6b60ca004345 100644
--- a/drivers/fpga/altera-fpga2sdram.c
+++ b/drivers/fpga/altera-fpga2sdram.c
@@ -147,20 +147,18 @@ static int alt_fpga_bridge_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int alt_fpga_bridge_remove(struct platform_device *pdev)
+static void alt_fpga_bridge_remove(struct platform_device *pdev)
 {
 	struct fpga_bridge *br = platform_get_drvdata(pdev);
 
 	fpga_bridge_unregister(br);
-
-	return 0;
 }
 
 MODULE_DEVICE_TABLE(of, altera_fpga_of_match);
 
 static struct platform_driver altera_fpga_driver = {
 	.probe = alt_fpga_bridge_probe,
-	.remove = alt_fpga_bridge_remove,
+	.remove_new = alt_fpga_bridge_remove,
 	.driver = {
 		.name	= "altera_fpga2sdram_bridge",
 		.of_match_table = of_match_ptr(altera_fpga_of_match),
-- 
2.42.0


