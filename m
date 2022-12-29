Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CA92658BFA
	for <lists+linux-fpga@lfdr.de>; Thu, 29 Dec 2022 11:51:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233170AbiL2KtY (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 29 Dec 2022 05:49:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233207AbiL2KtL (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 29 Dec 2022 05:49:11 -0500
Received: from mail.pr-group.ru (mail.pr-group.ru [178.18.215.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D033C12AD7;
        Thu, 29 Dec 2022 02:49:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
        d=metrotek.ru; s=mail;
        h=from:subject:date:message-id:to:cc:mime-version:content-type:
         content-transfer-encoding:in-reply-to:references;
        bh=die6ad0vYZHCb65m5Hf63s1td7LWEbm4RdnqouvV7iI=;
        b=WxPV0/QYen/zKibDP/wLAlVvTkEkr5ICx5bL6tXz656lTRn/ZEWTvExFV1x1ZKdyvp1yNoepPuWQt
         vYZ5fNBsmoNqKcw1apIdQfVE24Qt9YJm085ZegeAhOCWFAltNXk8HCS/TpSJEzuIbIFuUcWW1Ttcq1
         OZGhyt9roBeEZgQCDJkgSrmyr6Yusl4hsJ3QaIKYrAH9GRUqyIPhWtL0T2/ahrPaCceRxJD711We24
         93nTA5Zy9fNNpDNUZBKVT0bP2Po9hqG4yEGuCqy/qCbPVFhg9sjLhiH5Nk6jyETG9IuaO5M/9cbVwc
         6XQ2bcLcqFzlg4TjCDDXCafI8KnoVow==
X-Kerio-Anti-Spam:  Build: [Engines: 2.16.5.1460, Stamp: 3], Multi: [Enabled, t: (0.000011,0.013400)], BW: [Enabled, t: (0.000022,0.000001)], RTDA: [Enabled, t: (0.128619), Hit: No, Details: v2.42.0; Id: 15.52k5u3.1glenvb0e.j55e; mclb], total: 0(700)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Level: 
X-Footer: bWV0cm90ZWsucnU=
Received: from h-e2.ddg ([85.143.252.66])
        (authenticated user i.bornyakov@metrotek.ru)
        by mail.pr-group.ru with ESMTPSA
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits));
        Thu, 29 Dec 2022 13:48:44 +0300
From:   Ivan Bornyakov <i.bornyakov@metrotek.ru>
To:     linux-fpga@vger.kernel.org
Cc:     Ivan Bornyakov <i.bornyakov@metrotek.ru>,
        Conor Dooley <conor.dooley@microchip.com>,
        Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        linux-kernel@vger.kernel.org, system@metrotek.ru
Subject: [PATCH v4 2/3] fpga: microchip-spi: rewrite status polling in a time measurable way
Date:   Thu, 29 Dec 2022 13:46:03 +0300
Message-Id: <20221229104604.2496-3-i.bornyakov@metrotek.ru>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20221229104604.2496-1-i.bornyakov@metrotek.ru>
References: <20221229104604.2496-1-i.bornyakov@metrotek.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Original busy loop with retries count in mpf_poll_status() is not too
reliable, as it takes different times on different systems. Replace it
with read_poll_timeout() macro.

While at it, fix polling stop condition to met function's original
intention declared in the comment. The issue with original polling stop
condition is that it stops if any of mask bits is set, while intention
was to stop if all mask bits is set. This was not noticible because only
MPF_STATUS_READY is passed as mask argument and it is BIT(1).

Fixes: 5f8d4a900830 ("fpga: microchip-spi: add Microchip MPF FPGA manager")
Signed-off-by: Ivan Bornyakov <i.bornyakov@metrotek.ru>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
 drivers/fpga/microchip-spi.c | 32 +++++++++++++++++---------------
 1 file changed, 17 insertions(+), 15 deletions(-)

diff --git a/drivers/fpga/microchip-spi.c b/drivers/fpga/microchip-spi.c
index e72fedd93a27..995b1964e0fe 100644
--- a/drivers/fpga/microchip-spi.c
+++ b/drivers/fpga/microchip-spi.c
@@ -6,6 +6,7 @@
 #include <asm/unaligned.h>
 #include <linux/delay.h>
 #include <linux/fpga/fpga-mgr.h>
+#include <linux/iopoll.h>
 #include <linux/module.h>
 #include <linux/of_device.h>
 #include <linux/spi/spi.h>
@@ -33,7 +34,7 @@
 
 #define	MPF_BITS_PER_COMPONENT_SIZE	22
 
-#define	MPF_STATUS_POLL_RETRIES		10000
+#define	MPF_STATUS_POLL_TIMEOUT		(2 * USEC_PER_SEC)
 #define	MPF_STATUS_BUSY			BIT(0)
 #define	MPF_STATUS_READY		BIT(1)
 #define	MPF_STATUS_SPI_VIOLATION	BIT(2)
@@ -194,24 +195,25 @@ static int mpf_ops_parse_header(struct fpga_manager *mgr,
 	return 0;
 }
 
-/* Poll HW status until busy bit is cleared and mask bits are set. */
 static int mpf_poll_status(struct mpf_priv *priv, u8 mask)
 {
-	int status, retries = MPF_STATUS_POLL_RETRIES;
+	int ret, status;
 
-	while (retries--) {
-		status = mpf_read_status(priv);
-		if (status < 0)
-			return status;
-
-		if (status & MPF_STATUS_BUSY)
-			continue;
-
-		if (!mask || (status & mask))
-			return status;
-	}
+	/*
+	 * Busy poll HW status. Polling stops if any of the following
+	 * conditions are met:
+	 *  - timeout is reached
+	 *  - mpf_read_status() returns an error
+	 *  - busy bit is cleared AND mask bits are set
+	 */
+	ret = read_poll_timeout(mpf_read_status, status,
+				(status < 0) ||
+				((status & (MPF_STATUS_BUSY | mask)) == mask),
+				0, MPF_STATUS_POLL_TIMEOUT, false, priv);
+	if (ret < 0)
+		return ret;
 
-	return -EBUSY;
+	return status;
 }
 
 static int mpf_spi_write(struct mpf_priv *priv, const void *buf, size_t buf_size)
-- 
2.39.0


