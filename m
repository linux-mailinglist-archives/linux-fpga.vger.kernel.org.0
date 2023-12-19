Return-Path: <linux-fpga+bounces-74-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C32C818E32
	for <lists+linux-fpga@lfdr.de>; Tue, 19 Dec 2023 18:32:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD03B287423
	for <lists+linux-fpga@lfdr.de>; Tue, 19 Dec 2023 17:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C9A82D7A7;
	Tue, 19 Dec 2023 17:32:37 +0000 (UTC)
X-Original-To: linux-fpga@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A80337D02
	for <linux-fpga@vger.kernel.org>; Tue, 19 Dec 2023 17:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rFdxC-0005vH-8w; Tue, 19 Dec 2023 18:32:26 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rFdxA-0004Gr-MR; Tue, 19 Dec 2023 18:32:25 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rFdxB-000CpT-GI; Tue, 19 Dec 2023 18:32:25 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Moritz Fischer <mdf@kernel.org>,
	Wu Hao <hao.wu@intel.com>,
	Xu Yilun <yilun.xu@intel.com>
Cc: Tom Rix <trix@redhat.com>,
	linux-fpga@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH 02/13] fpga: altera-freeze-bridge: Convert to platform remove callback returning void
Date: Tue, 19 Dec 2023 18:32:00 +0100
Message-ID:  <7f4fcb23b25400c6711848105823081e032c5266.1703006638.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1711; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=xiSiCsZnqLmGC3n7yIqy4nLCQmQIom9WtygnyouKV5c=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlgdOQpusgm15GGAXfytldR9Eh16j1/NeUwEuSp 8djRXxRLP6JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZYHTkAAKCRCPgPtYfRL+ Tq5FB/4s2a49afCLXeZIHj9nCU0QPLGkM3ajyQHb26L3WPz8whY8A86sWLBYRMQ/5oeI6RfY5xZ xBz999sCyAXivYW1metycn2qpUMjsbHQGEWZ7G2c8SwtBqINyR26MNc1kkHAZP10GLZoW6vmPQt Uwq0eNve/UsJaflvJCcDK5N05E3GGvvtn+U6HwLUaAagWdm1Abpi/6HvRwelttBJfRhkNCVav8a AFWWGK4ROuobTg0CbmLRmaCOuVG1aKfvLC6J+7xmpM52G0dRz9h3gudqA3jQC+fRMz98+VYiJkr oVpDH84+017r+2bGVePxzEjUkeyzykAQdw+ew0IDyO0KWQ36
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
 drivers/fpga/altera-freeze-bridge.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/fpga/altera-freeze-bridge.c b/drivers/fpga/altera-freeze-bridge.c
index 0c3fb8226908..44061cb16f87 100644
--- a/drivers/fpga/altera-freeze-bridge.c
+++ b/drivers/fpga/altera-freeze-bridge.c
@@ -253,18 +253,16 @@ static int altera_freeze_br_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int altera_freeze_br_remove(struct platform_device *pdev)
+static void altera_freeze_br_remove(struct platform_device *pdev)
 {
 	struct fpga_bridge *br = platform_get_drvdata(pdev);
 
 	fpga_bridge_unregister(br);
-
-	return 0;
 }
 
 static struct platform_driver altera_freeze_br_driver = {
 	.probe = altera_freeze_br_probe,
-	.remove = altera_freeze_br_remove,
+	.remove_new = altera_freeze_br_remove,
 	.driver = {
 		.name	= "altera_freeze_br",
 		.of_match_table = altera_freeze_br_of_match,
-- 
2.42.0


