Return-Path: <linux-fpga+bounces-70-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6F5B818E2F
	for <lists+linux-fpga@lfdr.de>; Tue, 19 Dec 2023 18:32:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3EBE6B2256C
	for <lists+linux-fpga@lfdr.de>; Tue, 19 Dec 2023 17:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D1F837D06;
	Tue, 19 Dec 2023 17:32:36 +0000 (UTC)
X-Original-To: linux-fpga@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BFF737D08
	for <linux-fpga@vger.kernel.org>; Tue, 19 Dec 2023 17:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rFdxC-0005vb-IJ; Tue, 19 Dec 2023 18:32:26 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rFdxB-0004Gx-2S; Tue, 19 Dec 2023 18:32:26 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rFdxB-000Cpb-Sp; Tue, 19 Dec 2023 18:32:25 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Wu Hao <hao.wu@intel.com>,
	Moritz Fischer <mdf@kernel.org>,
	Xu Yilun <yilun.xu@intel.com>
Cc: Tom Rix <trix@redhat.com>,
	linux-fpga@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH 04/13] fpga: dfl-afu-main: Convert to platform remove callback returning void
Date: Tue, 19 Dec 2023 18:32:02 +0100
Message-ID:  <351a4508a2feeba05b2c311fa8596ca1ad77f467.1703006638.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1707; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=kVuAt2Ig4hTe4gzLvGu3mX7rofPGIzf33UNjn1cPlLI=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlgdOSeeBIy4USyQFeqKYsi2JvkjU7UTzOoFmHp C5prLS+S1mJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZYHTkgAKCRCPgPtYfRL+ TsePCACnH86L9jrchEguUw3jCMPRGy8Ys5qpKBCdiO9YGTUdcd5HtMh0G/Oee1L0plGOuvJLmI0 dkq40l58+FSjVcPTFmsJgRq7SoITCorToGE0YmMqDZ6PY3Kf8mO51YMl9XN/eakBqa3pUYB9yvr rIXQes/hALEBLoTbLs7407qTn1nNVnyX8JbiMDg7iX0GqRxEif16RkXHVwPYRRYTm54dYs6D3r6 DA9hQe9jG+ISfKTffr4ekDdb0JyHjhCK197xzRyxbeTQgZ+/iggtXIe9G4vaGr2o6gPWpVOY0/b LAmcn5Gq81qb3ulHWkJ6VW0XGGl45vMTdKT8qSNVhgSt5AzY
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
 drivers/fpga/dfl-afu-main.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/fpga/dfl-afu-main.c b/drivers/fpga/dfl-afu-main.c
index 7f621e96d3b8..c0a75ca360d6 100644
--- a/drivers/fpga/dfl-afu-main.c
+++ b/drivers/fpga/dfl-afu-main.c
@@ -932,15 +932,13 @@ static int afu_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int afu_remove(struct platform_device *pdev)
+static void afu_remove(struct platform_device *pdev)
 {
 	dev_dbg(&pdev->dev, "%s\n", __func__);
 
 	dfl_fpga_dev_ops_unregister(pdev);
 	dfl_fpga_dev_feature_uinit(pdev);
 	afu_dev_destroy(pdev);
-
-	return 0;
 }
 
 static const struct attribute_group *afu_dev_groups[] = {
@@ -956,7 +954,7 @@ static struct platform_driver afu_driver = {
 		.dev_groups = afu_dev_groups,
 	},
 	.probe   = afu_probe,
-	.remove  = afu_remove,
+	.remove_new = afu_remove,
 };
 
 static int __init afu_init(void)
-- 
2.42.0


