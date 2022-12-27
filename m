Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C0F765694E
	for <lists+linux-fpga@lfdr.de>; Tue, 27 Dec 2022 11:09:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230492AbiL0KHc (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 27 Dec 2022 05:07:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiL0KHa (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 27 Dec 2022 05:07:30 -0500
Received: from mail.pr-group.ru (mail.pr-group.ru [178.18.215.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 159062FF;
        Tue, 27 Dec 2022 02:07:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
        d=metrotek.ru; s=mail;
        h=from:subject:date:message-id:to:cc:mime-version:content-transfer-encoding:
         in-reply-to:references;
        bh=7Fvs78gYqrEVBbbQ/K9bc20z+/joLO6qDiw854CBaFQ=;
        b=SLvWAWwm+e3kVkiocTYSH6yr8Rs4Gu5Kc7UcGaV7cR8Y2jyWu/puOUzaEXH20HRVtNx9mlnWJzec4
         zdOKRm6SM1RgM450cjqAla6xG9c0haKUEfj+zz3xCcarc1GcXMjEctepRhxzJ5kvfBUfewGJQqGeUt
         A1gEE7ClAEUMMcpJmE24UriX0i3Nr+sDyJKYGOFP4FIKCA3PJWUl2mbOAdPRDBnx9O5CbS5PPt3B+y
         3zkd5uhPxNRLBm7H5x5D1MNeQIIGR/vXoAx7okkvsGyQgyvHMRLoSKwh2j5+GKvL7dPY+29ZJXvJSu
         JdFwuUq63RVjs8cplssk17HQsG8u/RQ==
X-Kerio-Anti-Spam:  Build: [Engines: 2.16.5.1460, Stamp: 3], Multi: [Enabled, t: (0.000010,0.012862)], BW: [Enabled, t: (0.000031,0.000002)], RTDA: [Enabled, t: (0.094436), Hit: No, Details: v2.42.0; Id: 15.52ka2l.1gl9gppe8.3nj; mclb], total: 0(700)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Level: 
X-Footer: bWV0cm90ZWsucnU=
Received: from localhost.localdomain ([78.37.162.181])
        (authenticated user i.bornyakov@metrotek.ru)
        by mail.pr-group.ru with ESMTPSA
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits));
        Tue, 27 Dec 2022 13:07:10 +0300
From:   Ivan Bornyakov <i.bornyakov@metrotek.ru>
To:     Conor Dooley <conor.dooley@microchip.com>,
        Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     Ivan Bornyakov <i.bornyakov@metrotek.ru>,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        system@metrotek.ru
Subject: [PATCH v3 2/3] fpga: microchip-spi: rewrite status polling in a time measurable way
Date:   Tue, 27 Dec 2022 13:04:49 +0300
Message-Id: <20221227100450.2257-3-i.bornyakov@metrotek.ru>
X-Mailer: git-send-email 2.38.2
In-Reply-To: <20221227100450.2257-1-i.bornyakov@metrotek.ru>
References: <20221227100450.2257-1-i.bornyakov@metrotek.ru>
MIME-Version: 1.0
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
---
 drivers/fpga/microchip-spi.c | 24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

diff --git a/drivers/fpga/microchip-spi.c b/drivers/fpga/microchip-spi.c
index e72fedd93a27..8d1d9476d0cc 100644
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
@@ -197,21 +198,16 @@ static int mpf_ops_parse_header(struct fpga_manager *mgr,
 /* Poll HW status until busy bit is cleared and mask bits are set. */
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


