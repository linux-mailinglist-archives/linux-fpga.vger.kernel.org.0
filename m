Return-Path: <linux-fpga+bounces-78-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4173E818E35
	for <lists+linux-fpga@lfdr.de>; Tue, 19 Dec 2023 18:32:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3549287383
	for <lists+linux-fpga@lfdr.de>; Tue, 19 Dec 2023 17:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 402673174A;
	Tue, 19 Dec 2023 17:32:38 +0000 (UTC)
X-Original-To: linux-fpga@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B322737D11
	for <linux-fpga@vger.kernel.org>; Tue, 19 Dec 2023 17:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rFdxD-0005we-If; Tue, 19 Dec 2023 18:32:27 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rFdxC-0004HL-2j; Tue, 19 Dec 2023 18:32:27 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rFdxC-000Cpv-Sx; Tue, 19 Dec 2023 18:32:26 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Moritz Fischer <mdf@kernel.org>,
	Wu Hao <hao.wu@intel.com>,
	Xu Yilun <yilun.xu@intel.com>
Cc: Tom Rix <trix@redhat.com>,
	linux-fpga@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH 09/13] fpga: of-fpga-region: Convert to platform remove callback returning void
Date: Tue, 19 Dec 2023 18:32:07 +0100
Message-ID:  <1ff30f297310bf048af567924c0fd4cb7c6c3240.1703006638.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1749; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=bxdYhlr2wtrc/r6OuCAgVp0v9jvTWtFTPxIK2FVz2L4=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlgdOYdkgHYhY8SujRMyqkc1ZUgcvGrVQLOyRDC +jbouHdxYmJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZYHTmAAKCRCPgPtYfRL+ TvA1B/0faUTzllU14d/t0gfo862QZSUbOuneerK4WHRyR8ts6ssO3gGvdbEJefvX/+SiPPAOiIT 4xxYbfEbjUXCSs8LOrmW678jDQmWxH4MI94Dmjm5PzHBZA7MuSYJoIIhBgI5puY2WjAmlG4uAcT N8gH1hT+MmX8r0cVoSUrsTe2np6/wbwCCH9ZVVNHvE3j34nMPd9SQUGa5rrdoiv+TC4hoxXBYJb HW9kQKgr2E+CDdgAqveuOrdfpmrgcyE8AI7TaUh4SGodb7AycNUh+nZQrDJkNI5kMR7kmZ1nyTV 5heSZF3tFWPwowTtTbKD4ujCc8z6uh8CszcgaANY/P7VbDhr
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
 drivers/fpga/of-fpga-region.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/fpga/of-fpga-region.c b/drivers/fpga/of-fpga-region.c
index a6affd83f275..8526a5a86f0c 100644
--- a/drivers/fpga/of-fpga-region.c
+++ b/drivers/fpga/of-fpga-region.c
@@ -425,20 +425,18 @@ static int of_fpga_region_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int of_fpga_region_remove(struct platform_device *pdev)
+static void of_fpga_region_remove(struct platform_device *pdev)
 {
 	struct fpga_region *region = platform_get_drvdata(pdev);
 	struct fpga_manager *mgr = region->mgr;
 
 	fpga_region_unregister(region);
 	fpga_mgr_put(mgr);
-
-	return 0;
 }
 
 static struct platform_driver of_fpga_region_driver = {
 	.probe = of_fpga_region_probe,
-	.remove = of_fpga_region_remove,
+	.remove_new = of_fpga_region_remove,
 	.driver = {
 		.name	= "of-fpga-region",
 		.of_match_table = of_match_ptr(fpga_region_of_match),
-- 
2.42.0


