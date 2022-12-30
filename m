Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1983A6596CC
	for <lists+linux-fpga@lfdr.de>; Fri, 30 Dec 2022 10:34:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234840AbiL3JcS (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 30 Dec 2022 04:32:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234825AbiL3JcR (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 30 Dec 2022 04:32:17 -0500
Received: from mail.pr-group.ru (mail.pr-group.ru [178.18.215.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24AF71A390;
        Fri, 30 Dec 2022 01:32:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
        d=metrotek.ru; s=mail;
        h=from:subject:date:message-id:to:cc:mime-version:content-type:
         content-transfer-encoding:in-reply-to:references;
        bh=PqfPOgB/H+V7BMAkAgppCtmusy/q2sCCkwNMJ1UA4RQ=;
        b=YOTXmBc3E2HaJKrrYoif2bESs6loympIFVF3Vb1uI/jZfpd1K5s6QijzTJkEjyGMt2YB9zvAYL4QO
         ALM9ynLqvSxd70oxDkmjhH6uiB3duLwWnvbISQH7Jcu2CdOfabVCRVotF/3bi43I3+1JY/4i1B6CTx
         VRrFKOuB7ViYd0NIvqtmc52/gML5GyT/smatsiJnfPxQ0tpuxFfhWEWuZpfNr4crzeQm+BnfHhQ+4M
         pBFiDg5GSQiZX8iK8lZ6TaDUxd3Zz8xZEVR5qfD7MtP3hIDxZ+Dj5R/fpLdZUPzq23Ex62fYMN4J4n
         zuEofRxTyBM+WwI5NHAb6r7HeU1ST8Q==
X-Kerio-Anti-Spam:  Build: [Engines: 2.16.5.1460, Stamp: 3], Multi: [Enabled, t: (0.000008,0.013650)], BW: [Enabled, t: (0.000025,0.000002)], RTDA: [Enabled, t: (0.080331), Hit: No, Details: v2.42.0; Id: 15.52k1i6.1glh5vaj9.15a61; mclb], total: 0(700)
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLACK autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: 
X-Footer: bWV0cm90ZWsucnU=
Received: from localhost.localdomain ([78.37.162.181])
        (authenticated user i.bornyakov@metrotek.ru)
        by mail.pr-group.ru with ESMTPSA
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits));
        Fri, 30 Dec 2022 12:31:51 +0300
From:   Ivan Bornyakov <i.bornyakov@metrotek.ru>
To:     linux-fpga@vger.kernel.org
Cc:     Ivan Bornyakov <i.bornyakov@metrotek.ru>,
        Conor Dooley <conor.dooley@microchip.com>,
        Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        linux-kernel@vger.kernel.org, system@metrotek.ru
Subject: [PATCH v5 2/3] fpga: microchip-spi: rewrite status polling in a time measurable way
Date:   Fri, 30 Dec 2022 12:29:21 +0300
Message-Id: <20221230092922.18822-3-i.bornyakov@metrotek.ru>
X-Mailer: git-send-email 2.38.2
In-Reply-To: <20221230092922.18822-1-i.bornyakov@metrotek.ru>
References: <20221230092922.18822-1-i.bornyakov@metrotek.ru>
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
Acked-by: Xu Yilun <yilun.xu@intel.com>
---
 drivers/fpga/microchip-spi.c | 32 +++++++++++++++++---------------
 1 file changed, 17 insertions(+), 15 deletions(-)

diff --git a/drivers/fpga/microchip-spi.c b/drivers/fpga/microchip-spi.c
index bb69f5beefe7..137fafdf57a6 100644
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
2.38.2


