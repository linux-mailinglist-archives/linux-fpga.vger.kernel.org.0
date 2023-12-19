Return-Path: <linux-fpga+bounces-68-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6A32818E2A
	for <lists+linux-fpga@lfdr.de>; Tue, 19 Dec 2023 18:32:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F3551F23371
	for <lists+linux-fpga@lfdr.de>; Tue, 19 Dec 2023 17:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA2DC37D12;
	Tue, 19 Dec 2023 17:32:35 +0000 (UTC)
X-Original-To: linux-fpga@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46A7937D06
	for <linux-fpga@vger.kernel.org>; Tue, 19 Dec 2023 17:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rFdxE-00060d-NN; Tue, 19 Dec 2023 18:32:28 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rFdxC-0004Hb-W4; Tue, 19 Dec 2023 18:32:28 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rFdxD-000CqL-Q6; Tue, 19 Dec 2023 18:32:27 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Moritz Fischer <mdf@kernel.org>,
	Wu Hao <hao.wu@intel.com>,
	Xu Yilun <yilun.xu@intel.com>
Cc: Tom Rix <trix@redhat.com>,
	Michal Simek <michal.simek@amd.com>,
	linux-fpga@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kernel@pengutronix.de
Subject: [PATCH 13/13] fpga: zynq-fpga: Convert to platform remove callback returning void
Date: Tue, 19 Dec 2023 18:32:11 +0100
Message-ID:  <e63d4155f96f3504f7e3d6a4775c3807c90dd6ce.1703006638.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1812; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=jbb9mztOMFAL7i/YnhzwmnK1JR3jM4tt5Y5ryqZlUMs=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlgdOca2nKiq7aD//nxu+ibdIF7crRGGAwhaZXE KKSkQWqnj6JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZYHTnAAKCRCPgPtYfRL+ TuQfB/9EZQbb++vmTVnmRaKWKUKE8XPC+Ie6ABunFtcF66SOXmE7NW3kuVDEfE50ciF2i/JX4S1 dWUs8DLIj82ZCUH6KukHxK9I98OzOP7OsUEUKdzr8MlPZ3pgkALDx5zby3WZieIwwNxWPyP3buF vyrpeNPCdFYjA8jitFBeD4ouHy2svtBKax2w3GNUl+1pV3WrV41gZ9xdxaqwvRkqaADfxyHUqrf B8nJxITxIrB4Rt8KvujR8L2xkfAAP42Ckf+W3jyO33L3fMO41zexCkr9bmMaI1xtqbw4gsTILQ5 Cws348vPPDs09Tupg4guVxd+/Ez01c1YNnQ9ic5LOr2BplI1
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
 drivers/fpga/zynq-fpga.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/fpga/zynq-fpga.c b/drivers/fpga/zynq-fpga.c
index 96611d424a10..0ac93183d201 100644
--- a/drivers/fpga/zynq-fpga.c
+++ b/drivers/fpga/zynq-fpga.c
@@ -618,7 +618,7 @@ static int zynq_fpga_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int zynq_fpga_remove(struct platform_device *pdev)
+static void zynq_fpga_remove(struct platform_device *pdev)
 {
 	struct zynq_fpga_priv *priv;
 	struct fpga_manager *mgr;
@@ -629,8 +629,6 @@ static int zynq_fpga_remove(struct platform_device *pdev)
 	fpga_mgr_unregister(mgr);
 
 	clk_unprepare(priv->clk);
-
-	return 0;
 }
 
 #ifdef CONFIG_OF
@@ -644,7 +642,7 @@ MODULE_DEVICE_TABLE(of, zynq_fpga_of_match);
 
 static struct platform_driver zynq_fpga_driver = {
 	.probe = zynq_fpga_probe,
-	.remove = zynq_fpga_remove,
+	.remove_new = zynq_fpga_remove,
 	.driver = {
 		.name = "zynq_fpga_manager",
 		.of_match_table = of_match_ptr(zynq_fpga_of_match),
-- 
2.42.0


