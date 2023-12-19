Return-Path: <linux-fpga+bounces-66-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC70C818E28
	for <lists+linux-fpga@lfdr.de>; Tue, 19 Dec 2023 18:32:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 882FF2863D6
	for <lists+linux-fpga@lfdr.de>; Tue, 19 Dec 2023 17:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5038037D00;
	Tue, 19 Dec 2023 17:32:35 +0000 (UTC)
X-Original-To: linux-fpga@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7B037D02
	for <linux-fpga@vger.kernel.org>; Tue, 19 Dec 2023 17:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rFdxE-0005wy-7j; Tue, 19 Dec 2023 18:32:28 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rFdxC-0004HU-JY; Tue, 19 Dec 2023 18:32:27 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rFdxD-000CqD-DS; Tue, 19 Dec 2023 18:32:27 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Moritz Fischer <mdf@kernel.org>,
	Wu Hao <hao.wu@intel.com>,
	Xu Yilun <yilun.xu@intel.com>
Cc: Tom Rix <trix@redhat.com>,
	linux-fpga@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH 11/13] fpga: stratix10-soc: Convert to platform remove callback returning void
Date: Tue, 19 Dec 2023 18:32:09 +0100
Message-ID:  <ab8328e82109b6ef14b2ad59889aee5f99264435.1703006638.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1796; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=6RuvGPNITAvdADFAZXGPf/g8M8lBML2CI2o234ndobo=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlgdOaX6OcbM/RlIBw2Gt56rtZpfXHNSY8RBWOO 6YJ6qO3e4GJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZYHTmgAKCRCPgPtYfRL+ TjYMB/4p9zyfXUf3yXq4/FiqUueW2qy3OW44Bkc1iR3DY26R7TTmwuGKc1fu7x8rMaNdTyl678C 1linYKyT9hxcTkQUlGUML94PSCWM1I7U2+F4wR04r7Bv+L3sw5v2mvaQ/51Ggxg21CsvULBlU0+ wD3a1xWfBb65FIlvzPWyzL/OtMkgyGpIqudCTDT2YolJHnLSNNfShLBnW2rLERGHxzrwzMpQf5A pZeTwRBDQ7y+Cx7LQk46rFld3E91pPfxLy+Fe0YL385l2oyj27I8aPt4Pc8XME7Pow3XOTvrHfL 6jGyofmd7zuAWa+Pg/dvBkLbD8A3TFK3lkUhsbFbrsgh2+X9
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
 drivers/fpga/stratix10-soc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/fpga/stratix10-soc.c b/drivers/fpga/stratix10-soc.c
index cacb9cc5757e..2c0def7d7cbb 100644
--- a/drivers/fpga/stratix10-soc.c
+++ b/drivers/fpga/stratix10-soc.c
@@ -436,15 +436,13 @@ static int s10_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int s10_remove(struct platform_device *pdev)
+static void s10_remove(struct platform_device *pdev)
 {
 	struct fpga_manager *mgr = platform_get_drvdata(pdev);
 	struct s10_priv *priv = mgr->priv;
 
 	fpga_mgr_unregister(mgr);
 	stratix10_svc_free_channel(priv->chan);
-
-	return 0;
 }
 
 static const struct of_device_id s10_of_match[] = {
@@ -457,7 +455,7 @@ MODULE_DEVICE_TABLE(of, s10_of_match);
 
 static struct platform_driver s10_driver = {
 	.probe = s10_probe,
-	.remove = s10_remove,
+	.remove_new = s10_remove,
 	.driver = {
 		.name	= "Stratix10 SoC FPGA manager",
 		.of_match_table = of_match_ptr(s10_of_match),
-- 
2.42.0


