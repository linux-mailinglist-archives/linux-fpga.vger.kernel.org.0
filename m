Return-Path: <linux-fpga+bounces-77-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EC05818E36
	for <lists+linux-fpga@lfdr.de>; Tue, 19 Dec 2023 18:32:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA2971F2388C
	for <lists+linux-fpga@lfdr.de>; Tue, 19 Dec 2023 17:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6D7931747;
	Tue, 19 Dec 2023 17:32:37 +0000 (UTC)
X-Original-To: linux-fpga@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8F424A03
	for <linux-fpga@vger.kernel.org>; Tue, 19 Dec 2023 17:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rFdxD-0005wL-Be; Tue, 19 Dec 2023 18:32:27 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rFdxB-0004HH-S3; Tue, 19 Dec 2023 18:32:26 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rFdxC-000Cpq-M5; Tue, 19 Dec 2023 18:32:26 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Moritz Fischer <mdf@kernel.org>,
	Wu Hao <hao.wu@intel.com>,
	Xu Yilun <yilun.xu@intel.com>
Cc: Peter Colberg <peter.colberg@intel.com>,
	Tom Rix <trix@redhat.com>,
	linux-fpga@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH 08/13] fpga: intel-m10-bmc-sec-update: Convert to platform remove callback returning void
Date: Tue, 19 Dec 2023 18:32:06 +0100
Message-ID:  <8d7b192ade744a70da4d7bc681ee4e00f9d04ba9.1703006638.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1922; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=x/91DhywnpZtlOuTo5ij49/8knaEiA9uKV9pkUBzyDw=; b=owGbwMvMwMXY3/A7olbonx/jabUkhtTGy9P5Utm2bjr5846Rp6cYy5LYCwnKX4LExBZ3vdo1T /nU3b88nYzGLAyMXAyyYoos9o1rMq2q5CI71/67DDOIlQlkCgMXpwBM5NRU9n9qkq/VY1Xc3GzX 69duTohTOSH8Y0OetpFlSbiau93cP3KmB877G4XMNd79NsmTI/BW2f50+22CMi0dfvl2vDbPqkr +N99malCpnplpw7bTub7T5WDAL9e53PsZpJbpzzPTnBy+9qQhQ5Os1dn3y+aYHd6y6bOxdt72lX EZdUyuS5asF7rBXlB6xz+e77Vx/FX3Y19vnrzygKfK7bOTiU4Y3w/+yCWf/tYUz3lX/OOF/NKaR RuCwnxCtNbdsJLqZdBUuHHl6vJsZ4/Cb7H3v7y7pzrJ4PHETy4BTl78ETsrPHL/h4rMXN+adjZV bY+PrXaymUJ0TVZQ5PKwQ3bcH57dabOLazzfvcPV5JQPAA==
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
 drivers/fpga/intel-m10-bmc-sec-update.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/fpga/intel-m10-bmc-sec-update.c b/drivers/fpga/intel-m10-bmc-sec-update.c
index 31af2e08c825..89851b133709 100644
--- a/drivers/fpga/intel-m10-bmc-sec-update.c
+++ b/drivers/fpga/intel-m10-bmc-sec-update.c
@@ -730,15 +730,13 @@ static int m10bmc_sec_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int m10bmc_sec_remove(struct platform_device *pdev)
+static void m10bmc_sec_remove(struct platform_device *pdev)
 {
 	struct m10bmc_sec *sec = dev_get_drvdata(&pdev->dev);
 
 	firmware_upload_unregister(sec->fwl);
 	kfree(sec->fw_name);
 	xa_erase(&fw_upload_xa, sec->fw_name_id);
-
-	return 0;
 }
 
 static const struct platform_device_id intel_m10bmc_sec_ids[] = {
@@ -760,7 +758,7 @@ MODULE_DEVICE_TABLE(platform, intel_m10bmc_sec_ids);
 
 static struct platform_driver intel_m10bmc_sec_driver = {
 	.probe = m10bmc_sec_probe,
-	.remove = m10bmc_sec_remove,
+	.remove_new = m10bmc_sec_remove,
 	.driver = {
 		.name = "intel-m10bmc-sec-update",
 		.dev_groups = m10bmc_sec_attr_groups,
-- 
2.42.0


