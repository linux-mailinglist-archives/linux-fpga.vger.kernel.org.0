Return-Path: <linux-fpga+bounces-73-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFB5F818E31
	for <lists+linux-fpga@lfdr.de>; Tue, 19 Dec 2023 18:32:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5BD70B225D4
	for <lists+linux-fpga@lfdr.de>; Tue, 19 Dec 2023 17:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DD05249FE;
	Tue, 19 Dec 2023 17:32:36 +0000 (UTC)
X-Original-To: linux-fpga@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80FFB37D10
	for <linux-fpga@vger.kernel.org>; Tue, 19 Dec 2023 17:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rFdxD-0005wo-QO; Tue, 19 Dec 2023 18:32:27 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rFdxC-0004HP-B4; Tue, 19 Dec 2023 18:32:27 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rFdxD-000Cq9-4l; Tue, 19 Dec 2023 18:32:27 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Moritz Fischer <mdf@kernel.org>,
	Wu Hao <hao.wu@intel.com>,
	Xu Yilun <yilun.xu@intel.com>
Cc: Tom Rix <trix@redhat.com>,
	linux-fpga@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH 10/13] fpga: socfpga-a10: Convert to platform remove callback returning void
Date: Tue, 19 Dec 2023 18:32:08 +0100
Message-ID:  <da701d72522dde185becc15096342786a3a12153.1703006638.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1897; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=7DXUNhS7l7nG7QSr/74ukFmOeJyAE8NRE33EEE7rEH8=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlgdOZbmlx+ui4sisofnVENxINYWrIaKrv1Z3Qp Deszo42wIyJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZYHTmQAKCRCPgPtYfRL+ TqKqB/9g0YDdgNpfCNp7KAVfOV5LW3ePjfoN4mUL701VW5aV5scgswrpHwKxYz0Bf5NPX+5I/4r gTQhTcrm+Wni6BV0V6LRn5/Eb7H3xDrBOMjiu3vmX/EcW/j03xXT0ko2sq7btn6s6ETs559DNEg ITuAXiVtZzNtXM51kzaB+tHDqicYlsQZqg9BuiKk/7bSKKcfdgfsspjMifo2fzpBXbswdQkFF2l 2nqvD5N3OewUfDwM8vTCdR4iCVQ0F5GK/ZoJ6Bcx8TW/hQr2FLVhMJX4I2+XJcd0K21DB/Jl5CZ dL6dqV7bfswinl5h/Cq1e4jE5vNikZkxXIg9T4IOlHbcElT3
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
 drivers/fpga/socfpga-a10.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/fpga/socfpga-a10.c b/drivers/fpga/socfpga-a10.c
index cc4861e345c9..4c03513b8f03 100644
--- a/drivers/fpga/socfpga-a10.c
+++ b/drivers/fpga/socfpga-a10.c
@@ -517,15 +517,13 @@ static int socfpga_a10_fpga_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int socfpga_a10_fpga_remove(struct platform_device *pdev)
+static void socfpga_a10_fpga_remove(struct platform_device *pdev)
 {
 	struct fpga_manager *mgr = platform_get_drvdata(pdev);
 	struct a10_fpga_priv *priv = mgr->priv;
 
 	fpga_mgr_unregister(mgr);
 	clk_disable_unprepare(priv->clk);
-
-	return 0;
 }
 
 static const struct of_device_id socfpga_a10_fpga_of_match[] = {
@@ -537,7 +535,7 @@ MODULE_DEVICE_TABLE(of, socfpga_a10_fpga_of_match);
 
 static struct platform_driver socfpga_a10_fpga_driver = {
 	.probe = socfpga_a10_fpga_probe,
-	.remove = socfpga_a10_fpga_remove,
+	.remove_new = socfpga_a10_fpga_remove,
 	.driver = {
 		.name	= "socfpga_a10_fpga_manager",
 		.of_match_table = socfpga_a10_fpga_of_match,
-- 
2.42.0


