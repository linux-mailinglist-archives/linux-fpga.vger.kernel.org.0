Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 766C9656377
	for <lists+linux-fpga@lfdr.de>; Mon, 26 Dec 2022 15:38:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbiLZOhH (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 26 Dec 2022 09:37:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232040AbiLZO3K (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 26 Dec 2022 09:29:10 -0500
Received: from mail.pr-group.ru (mail.pr-group.ru [178.18.215.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8550064E1;
        Mon, 26 Dec 2022 06:26:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
        d=metrotek.ru; s=mail;
        h=from:subject:date:message-id:to:cc:mime-version:content-transfer-encoding:
         in-reply-to:references;
        bh=5JXcj0PeS9btOTlGETvg46ikVRwJJJR3wMFmHeUulKw=;
        b=CPV0mLs6v62yt1a/s7bc7/CjKRh6mSzYO3qNJbBTEZ26+RIHygtIDjnGn4m7r8n/tv3wk4thqewry
         jM11M3zoiFQN/XSTqe/XZBUw0tOwADlNsCCzfn0joR85IOKaXNaSXGNfHfkVKvRCeKltADVxcHVaqJ
         /aSqQmJGSGhSbyRo1EgIOBLuofeKe0w51xbeATnhsB64kx7XwHR/bjd+bxx3791klPeNPqqobt0TOf
         zZSmbuLu1+GLSQVYr1ho50UBF1nORqO6mgcNN64TGY8EVKiRU8ycDX/lagmGs/VKcngdON2mGZXMLh
         +ASJ7tMblHbuTHQ8p88UByrUWq2fYYw==
X-Kerio-Anti-Spam:  Build: [Engines: 2.16.5.1460, Stamp: 3], Multi: [Enabled, t: (0.000011,0.012463)], BW: [Enabled, t: (0.000028,0.000002)], RTDA: [Enabled, t: (0.080016), Hit: No, Details: v2.42.0; Id: 15.52k1a9.1gl7d6ubp.3e; mclb], total: 0(700)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Level: 
X-Footer: bWV0cm90ZWsucnU=
Received: from localhost.localdomain ([78.37.162.181])
        (authenticated user i.bornyakov@metrotek.ru)
        by mail.pr-group.ru with ESMTPSA
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits));
        Mon, 26 Dec 2022 17:25:58 +0300
From:   Ivan Bornyakov <i.bornyakov@metrotek.ru>
To:     Conor Dooley <conor.dooley@microchip.com>,
        Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>
Cc:     Ivan Bornyakov <i.bornyakov@metrotek.ru>,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        system@metrotek.ru
Subject: [PATCH v2 2/3] fpga: microchip-spi: rewrite status polling in a time measurable way
Date:   Mon, 26 Dec 2022 17:23:25 +0300
Message-Id: <20221226142326.8111-3-i.bornyakov@metrotek.ru>
X-Mailer: git-send-email 2.38.2
In-Reply-To: <20221226142326.8111-1-i.bornyakov@metrotek.ru>
References: <20221226142326.8111-1-i.bornyakov@metrotek.ru>
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

Fixes: 5f8d4a900830 ("fpga: microchip-spi: add Microchip MPF FPGA manager")
Signed-off-by: Ivan Bornyakov <i.bornyakov@metrotek.ru>
---
 drivers/fpga/microchip-spi.c | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/drivers/fpga/microchip-spi.c b/drivers/fpga/microchip-spi.c
index e72fedd93a27..f3ddfab87499 100644
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
@@ -197,21 +198,17 @@ static int mpf_ops_parse_header(struct fpga_manager *mgr,
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
+				(!(status & MPF_STATUS_BUSY) &&
+				 (!mask || (status & mask))),
+				0, MPF_STATUS_POLL_TIMEOUT, false, priv);
+	if (ret < 0)
+		return ret;
 
-	return -EBUSY;
+	return status;
 }
 
 static int mpf_spi_write(struct mpf_priv *priv, const void *buf, size_t buf_size)
-- 
2.38.2


