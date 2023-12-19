Return-Path: <linux-fpga+bounces-67-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48EF5818E29
	for <lists+linux-fpga@lfdr.de>; Tue, 19 Dec 2023 18:32:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03686287338
	for <lists+linux-fpga@lfdr.de>; Tue, 19 Dec 2023 17:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF1BB37D04;
	Tue, 19 Dec 2023 17:32:35 +0000 (UTC)
X-Original-To: linux-fpga@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46AB137D07
	for <linux-fpga@vger.kernel.org>; Tue, 19 Dec 2023 17:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rFdxC-0005vI-BP; Tue, 19 Dec 2023 18:32:26 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rFdxA-0004Gu-SC; Tue, 19 Dec 2023 18:32:25 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rFdxB-000CpW-MC; Tue, 19 Dec 2023 18:32:25 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Moritz Fischer <mdf@kernel.org>,
	Wu Hao <hao.wu@intel.com>,
	Xu Yilun <yilun.xu@intel.com>
Cc: Tom Rix <trix@redhat.com>,
	linux-fpga@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH 03/13] fpga: altera-hps2fpga: Convert to platform remove callback returning void
Date: Tue, 19 Dec 2023 18:32:01 +0100
Message-ID:  <7a56558f7e5aa34bf0b21d22f9036a136a2b7322.1703006638.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1931; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=F2MnFt/yPjA7nzwA5h/JxIGxY00gbHc4ttRT3fEMqB4=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlgdORhP5XSv5tyDR6nqmBhttWiUMKiUvkwCekb gy+K/gKdoOJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZYHTkQAKCRCPgPtYfRL+ ToRzCACLc51rOAnOYTUNWMRstZkdbRSgB3HGV8EO2SLexsIeL/YbyDUfGcGRT+xgi+oPL/+n/0+ HqTF18b8sDmkfkLsnpZHTlI5oYXNgKXU8wblQ6TFrKelgpLg+zoMb0PRn3DFUmt+jfQeT7M36Ei DsntnhZxFdHI2poVCUFslUTd2Cg22x5eAJAKAHCBkmMxIXtl+BGlBAp4D+2n5YsNy3PWtWWnXEQ C8iTqWBNTktOZdtvK9jGjPExe92Svyl7lSol9WGsyvgg29O6OYUO0MGTqdh1X4pkbPB/uSaHmNE vrLfO6aOITSbrx4r/XZjFaWxyH9EI3rVINEhkTRvyYoYRHAp
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
 drivers/fpga/altera-hps2fpga.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/fpga/altera-hps2fpga.c b/drivers/fpga/altera-hps2fpga.c
index 578663503297..6f8e24be19c6 100644
--- a/drivers/fpga/altera-hps2fpga.c
+++ b/drivers/fpga/altera-hps2fpga.c
@@ -191,7 +191,7 @@ static int alt_fpga_bridge_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int alt_fpga_bridge_remove(struct platform_device *pdev)
+static void alt_fpga_bridge_remove(struct platform_device *pdev)
 {
 	struct fpga_bridge *bridge = platform_get_drvdata(pdev);
 	struct altera_hps2fpga_data *priv = bridge->priv;
@@ -199,15 +199,13 @@ static int alt_fpga_bridge_remove(struct platform_device *pdev)
 	fpga_bridge_unregister(bridge);
 
 	clk_disable_unprepare(priv->clk);
-
-	return 0;
 }
 
 MODULE_DEVICE_TABLE(of, altera_fpga_of_match);
 
 static struct platform_driver alt_fpga_bridge_driver = {
 	.probe = alt_fpga_bridge_probe,
-	.remove = alt_fpga_bridge_remove,
+	.remove_new = alt_fpga_bridge_remove,
 	.driver = {
 		.name	= "altera_hps2fpga_bridge",
 		.of_match_table = of_match_ptr(altera_fpga_of_match),
-- 
2.42.0


