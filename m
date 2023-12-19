Return-Path: <linux-fpga+bounces-75-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA707818E33
	for <lists+linux-fpga@lfdr.de>; Tue, 19 Dec 2023 18:32:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 069D21C21671
	for <lists+linux-fpga@lfdr.de>; Tue, 19 Dec 2023 17:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 222332E3E3;
	Tue, 19 Dec 2023 17:32:37 +0000 (UTC)
X-Original-To: linux-fpga@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3314E37D05
	for <linux-fpga@vger.kernel.org>; Tue, 19 Dec 2023 17:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rFdxE-0005xu-Aw; Tue, 19 Dec 2023 18:32:28 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rFdxC-0004HX-Pd; Tue, 19 Dec 2023 18:32:27 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rFdxD-000CqH-Ja; Tue, 19 Dec 2023 18:32:27 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Moritz Fischer <mdf@kernel.org>,
	Wu Hao <hao.wu@intel.com>,
	Xu Yilun <yilun.xu@intel.com>
Cc: Tom Rix <trix@redhat.com>,
	Michal Simek <michal.simek@amd.com>,
	linux-fpga@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kernel@pengutronix.de
Subject: [PATCH 12/13] fpga: xilinx-pr-decoupler: Convert to platform remove callback returning void
Date: Tue, 19 Dec 2023 18:32:10 +0100
Message-ID:  <3e37e7cf91749fbaba67619f4ffc6a9a7352a671.1703006638.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1890; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=HD/6zlCO1lu9B8VXZ6oLk+iu2jmeyH12ZxljOeV/mOQ=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlgdObRFk0XJZoxhnxMYEaKcT2BUO5aJx4F3v3/ HCtKxE2HH6JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZYHTmwAKCRCPgPtYfRL+ TmuVB/4nQ8wls1Qyc6lIvYs0y9ZeqUmYJH3XwctJgrk+wrvGJvRJaYfy+7I59qdmGRhM51A2q62 5ZyaqwT4wdnZp6Zec2vsTV2YeFbpljOKnoHCL2srFJ59c7kUQ3BNw7MFNk8U5z/UynosaRkqsCL J0nu8FtJLJaf9SukVSpIe7oWFSNehpaEbHn7+Uk086tP+1LlTfK1AM2IuVfAkyOgLCDJD4YH4R8 MYQbXmadCpB36N6j/Wfoox73fnhbedF6+LV9CgTza1LeZ91o+17o8sjPhWeLuB5Dwxryuow4YIW 0RfuryLjIpZEl/zNqDGacGEUHP+98uJ/MQk7JSvqL+MqdkmA
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
 drivers/fpga/xilinx-pr-decoupler.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/fpga/xilinx-pr-decoupler.c b/drivers/fpga/xilinx-pr-decoupler.c
index 68835896f180..788dd2f63a65 100644
--- a/drivers/fpga/xilinx-pr-decoupler.c
+++ b/drivers/fpga/xilinx-pr-decoupler.c
@@ -150,7 +150,7 @@ static int xlnx_pr_decoupler_probe(struct platform_device *pdev)
 	return err;
 }
 
-static int xlnx_pr_decoupler_remove(struct platform_device *pdev)
+static void xlnx_pr_decoupler_remove(struct platform_device *pdev)
 {
 	struct fpga_bridge *bridge = platform_get_drvdata(pdev);
 	struct xlnx_pr_decoupler_data *p = bridge->priv;
@@ -158,13 +158,11 @@ static int xlnx_pr_decoupler_remove(struct platform_device *pdev)
 	fpga_bridge_unregister(bridge);
 
 	clk_unprepare(p->clk);
-
-	return 0;
 }
 
 static struct platform_driver xlnx_pr_decoupler_driver = {
 	.probe = xlnx_pr_decoupler_probe,
-	.remove = xlnx_pr_decoupler_remove,
+	.remove_new = xlnx_pr_decoupler_remove,
 	.driver = {
 		.name = "xlnx_pr_decoupler",
 		.of_match_table = xlnx_pr_decoupler_of_match,
-- 
2.42.0


