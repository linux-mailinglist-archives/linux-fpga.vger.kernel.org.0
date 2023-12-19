Return-Path: <linux-fpga+bounces-71-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9783B818E2B
	for <lists+linux-fpga@lfdr.de>; Tue, 19 Dec 2023 18:32:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA4B51C2167E
	for <lists+linux-fpga@lfdr.de>; Tue, 19 Dec 2023 17:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 361A937D0B;
	Tue, 19 Dec 2023 17:32:36 +0000 (UTC)
X-Original-To: linux-fpga@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7158837D0A
	for <linux-fpga@vger.kernel.org>; Tue, 19 Dec 2023 17:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rFdxD-0005wF-62; Tue, 19 Dec 2023 18:32:27 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rFdxB-0004HD-ML; Tue, 19 Dec 2023 18:32:26 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rFdxC-000Cpn-G2; Tue, 19 Dec 2023 18:32:26 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Wu Hao <hao.wu@intel.com>,
	Moritz Fischer <mdf@kernel.org>,
	Xu Yilun <yilun.xu@intel.com>
Cc: Tom Rix <trix@redhat.com>,
	linux-fpga@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH 07/13] fpga: dfl-fme-region: Convert to platform remove callback returning void
Date: Tue, 19 Dec 2023 18:32:05 +0100
Message-ID:  <13187db1642f81f04e55be0a26045f09ccc95d37.1703006638.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1785; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=dBaTbnikILumgVfq0dE0u3xfKKC6APd7/tEpjPEswMA=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlgdOV+b4GsCu/7+cejuJ84AstdN1zJc+UtPhJt BIDT7LgExqJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZYHTlQAKCRCPgPtYfRL+ Tl+mB/9ae2NShiLTGcM6GiGfGq+8ets1CV9LC+taPkRkg15YAQ16wcq9JyQCvF2bEEyBDdA3PoJ 8C9c68VgqREZFu7iwHK7sqi6IoPBsbFzHwCGP5Iij2UZvkUjIbbqXeRevPTPcyEiw5Ymx0SsAoU HYzdkm/oJmlLdTWnzXATHZBgXmyH5gl5oSOT2uV1KY3FxtznD1wYGFgtwmzA5wuYT58pi0tqXxg ZpdZX5EdqqXAyNuFG2Wn7hg1C946koow35vSMW7NfjPYQx2T+94AEo1Llk3pRD9dB9CEzPEB5q9 ZvAUpRMA5Z+f69SSZi8qvajKKqq3K0MT07q6RBl+hxPmrYVv
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
 drivers/fpga/dfl-fme-region.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/fpga/dfl-fme-region.c b/drivers/fpga/dfl-fme-region.c
index 4aebde0a7f1c..71616f8b4982 100644
--- a/drivers/fpga/dfl-fme-region.c
+++ b/drivers/fpga/dfl-fme-region.c
@@ -61,15 +61,13 @@ static int fme_region_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int fme_region_remove(struct platform_device *pdev)
+static void fme_region_remove(struct platform_device *pdev)
 {
 	struct fpga_region *region = platform_get_drvdata(pdev);
 	struct fpga_manager *mgr = region->mgr;
 
 	fpga_region_unregister(region);
 	fpga_mgr_put(mgr);
-
-	return 0;
 }
 
 static struct platform_driver fme_region_driver = {
@@ -77,7 +75,7 @@ static struct platform_driver fme_region_driver = {
 		.name    = DFL_FPGA_FME_REGION,
 	},
 	.probe   = fme_region_probe,
-	.remove  = fme_region_remove,
+	.remove_new = fme_region_remove,
 };
 
 module_platform_driver(fme_region_driver);
-- 
2.42.0


