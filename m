Return-Path: <linux-fpga+bounces-76-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C117E818E34
	for <lists+linux-fpga@lfdr.de>; Tue, 19 Dec 2023 18:32:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5D701C21CA9
	for <lists+linux-fpga@lfdr.de>; Tue, 19 Dec 2023 17:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46B582E633;
	Tue, 19 Dec 2023 17:32:37 +0000 (UTC)
X-Original-To: linux-fpga@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80FB937D0F
	for <linux-fpga@vger.kernel.org>; Tue, 19 Dec 2023 17:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rFdxC-0005wA-Vj; Tue, 19 Dec 2023 18:32:26 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rFdxB-0004H7-G8; Tue, 19 Dec 2023 18:32:26 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rFdxC-000Cpj-A3; Tue, 19 Dec 2023 18:32:26 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Wu Hao <hao.wu@intel.com>,
	Moritz Fischer <mdf@kernel.org>,
	Xu Yilun <yilun.xu@intel.com>
Cc: Tom Rix <trix@redhat.com>,
	linux-fpga@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH 06/13] fpga: dfl-fme-main: Convert to platform remove callback returning void
Date: Tue, 19 Dec 2023 18:32:04 +0100
Message-ID:  <438bb4797984fbfd0cef501010a64fa1e42ad9f4.1703006638.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1665; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=qfB5i+dUHckThGJDxVawBxUYk6jLLVFxmgRke5aDk5g=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlgdOU73secTwGqydXpibi+xQrgc/9aeuncTw7m e1cc6XjucqJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZYHTlAAKCRCPgPtYfRL+ Tv5ACACYffed80Ns9oh/1aOfFBm6L+Xngs3B9JWXma3660ouHgK3qKXhYWoIiAkdUNP3TvH9ImO imZJ4xya2+xh1er6VWlhdD8ELyse5LosyJFYIIwHd4EAGIfUmdyQM+OWKs9hMKvNOS2VMnugfSC jlT4R1Ue/V5HEykfp3pR4lANSmuVqzsKZRXzmaWSGXgbCX8NUafCQbXe+5bIz0dzPqY6IWxtv54 3LcN3jyyqWwqMJ8D4KRMbOtUk9t7r5jgPWj3NKipUlD8WOZjTPBo98weHBqMlxUqYvhEHC/Edpl SQkFHX2/3dXjLhbBpBE98Cq4ZqiH6exRtnHFssMigsHUx884
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
 drivers/fpga/dfl-fme-main.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/fpga/dfl-fme-main.c b/drivers/fpga/dfl-fme-main.c
index 3dcf990bd261..a2b5da0093da 100644
--- a/drivers/fpga/dfl-fme-main.c
+++ b/drivers/fpga/dfl-fme-main.c
@@ -730,13 +730,11 @@ static int fme_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int fme_remove(struct platform_device *pdev)
+static void fme_remove(struct platform_device *pdev)
 {
 	dfl_fpga_dev_ops_unregister(pdev);
 	dfl_fpga_dev_feature_uinit(pdev);
 	fme_dev_destroy(pdev);
-
-	return 0;
 }
 
 static const struct attribute_group *fme_dev_groups[] = {
@@ -751,7 +749,7 @@ static struct platform_driver fme_driver = {
 		.dev_groups = fme_dev_groups,
 	},
 	.probe   = fme_probe,
-	.remove  = fme_remove,
+	.remove_new = fme_remove,
 };
 
 module_platform_driver(fme_driver);
-- 
2.42.0


