Return-Path: <linux-fpga+bounces-69-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3283F818E2D
	for <lists+linux-fpga@lfdr.de>; Tue, 19 Dec 2023 18:32:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6B2EB22635
	for <lists+linux-fpga@lfdr.de>; Tue, 19 Dec 2023 17:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06BAB37D07;
	Tue, 19 Dec 2023 17:32:36 +0000 (UTC)
X-Original-To: linux-fpga@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 715A737D0B
	for <linux-fpga@vger.kernel.org>; Tue, 19 Dec 2023 17:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rFdxC-0005vx-OT; Tue, 19 Dec 2023 18:32:26 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rFdxB-0004H0-8o; Tue, 19 Dec 2023 18:32:26 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rFdxC-000Cpf-2l; Tue, 19 Dec 2023 18:32:26 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Wu Hao <hao.wu@intel.com>,
	Moritz Fischer <mdf@kernel.org>,
	Xu Yilun <yilun.xu@intel.com>
Cc: Tom Rix <trix@redhat.com>,
	linux-fpga@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH 05/13] fpga: dfl-fme-br: Convert to platform remove callback returning void
Date: Tue, 19 Dec 2023 18:32:03 +0100
Message-ID:  <be0728ae8e047c6b443492dc563cf92f397b269d.1703006638.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1837; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=cpWEzlfs93oy0uzY4PczLW2WO9WfC9XcaQn9PxlqE0k=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlgdOT0ig7j0lfqiDXBD+ZQ8Dij8T+qElwdDVSA 8AQ9jVF9/KJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZYHTkwAKCRCPgPtYfRL+ TgrQB/901CVLrhIEKY/9UbvUaBicTdLopblwuegMqVaEY5SQpHuP5IaKrJAMWYlylSKdFZtNCRO Xk30MxUXAf6O+D+aABKBuGQT0bYh9ciSyFzpR1T/cXIhqU+fy2Xc71InByTiFSmAUTsKjijd8WD 7q5nDPWrHGQ7C0yacD+/QlyNWFztVdYpi9Kop3vq3imcBu6kaNPqGE8PqM04Xce72X2WfU+PKVG PYq0kZhQxnzE0qryU5V+ExXDrQmN7aZ2gFlF3tY5/TONt6XjYiR5Eu4mx2ndqfAd/b60Ows6M+V zuOCh8G47Cnful82FBV/BbXvWOUYp/ZfGA6P+LszFMRaasMK
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
 drivers/fpga/dfl-fme-br.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/fpga/dfl-fme-br.c b/drivers/fpga/dfl-fme-br.c
index 808d1f4d76df..0b01b3895277 100644
--- a/drivers/fpga/dfl-fme-br.c
+++ b/drivers/fpga/dfl-fme-br.c
@@ -78,7 +78,7 @@ static int fme_br_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int fme_br_remove(struct platform_device *pdev)
+static void fme_br_remove(struct platform_device *pdev)
 {
 	struct fpga_bridge *br = platform_get_drvdata(pdev);
 	struct fme_br_priv *priv = br->priv;
@@ -89,8 +89,6 @@ static int fme_br_remove(struct platform_device *pdev)
 		put_device(&priv->port_pdev->dev);
 	if (priv->port_ops)
 		dfl_fpga_port_ops_put(priv->port_ops);
-
-	return 0;
 }
 
 static struct platform_driver fme_br_driver = {
@@ -98,7 +96,7 @@ static struct platform_driver fme_br_driver = {
 		.name    = DFL_FPGA_FME_BRIDGE,
 	},
 	.probe   = fme_br_probe,
-	.remove  = fme_br_remove,
+	.remove_new = fme_br_remove,
 };
 
 module_platform_driver(fme_br_driver);
-- 
2.42.0


