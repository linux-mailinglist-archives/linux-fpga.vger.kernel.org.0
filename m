Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA7F72561AC
	for <lists+linux-fpga@lfdr.de>; Fri, 28 Aug 2020 21:58:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726446AbgH1T6Z (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 28 Aug 2020 15:58:25 -0400
Received: from hostingweb31-40.netsons.net ([89.40.174.40]:34422 "EHLO
        hostingweb31-40.netsons.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726395AbgH1T6W (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Fri, 28 Aug 2020 15:58:22 -0400
Received: from [78.134.86.56] (port=54992 helo=melee.dev.aim)
        by hostingweb31.netsons.net with esmtpa (Exim 4.93)
        (envelope-from <luca@lucaceresoli.net>)
        id 1kBkVx-0008I1-2h; Fri, 28 Aug 2020 21:58:21 +0200
From:   Luca Ceresoli <luca@lucaceresoli.net>
To:     linux-fpga@vger.kernel.org
Cc:     Luca Ceresoli <luca@lucaceresoli.net>,
        Moritz Fischer <mdf@kernel.org>, Tom Rix <trix@redhat.com>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anatolij Gustschin <agust@denx.de>
Subject: [PATCH v3 5/5] fpga manager: xilinx-spi: provide better diagnostics on programming failure
Date:   Fri, 28 Aug 2020 21:58:08 +0200
Message-Id: <20200828195808.27975-5-luca@lucaceresoli.net>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200828195808.27975-1-luca@lucaceresoli.net>
References: <20200828195808.27975-1-luca@lucaceresoli.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hostingweb31.netsons.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lucaceresoli.net
X-Get-Message-Sender-Via: hostingweb31.netsons.net: authenticated_id: luca+lucaceresoli.net/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: hostingweb31.netsons.net: luca@lucaceresoli.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

When the DONE pin does not go high after programming to confirm programming
success, the INIT_B pin provides some info on the reason. Use it if
available to provide a more explanatory error message.

Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>

---

Changes in v3: none.

Changes in v2:
 - also check for gpiod_get_value() errors (Tom Rix)
---
 drivers/fpga/xilinx-spi.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/fpga/xilinx-spi.c b/drivers/fpga/xilinx-spi.c
index 9488c8fbaefd..c2e0a42cd4f2 100644
--- a/drivers/fpga/xilinx-spi.c
+++ b/drivers/fpga/xilinx-spi.c
@@ -195,7 +195,21 @@ static int xilinx_spi_write_complete(struct fpga_manager *mgr,
 			return 0;
 	}
 
-	dev_err(&mgr->dev, "Timeout after config data transfer\n");
+	if (conf->init_b) {
+		ret = gpiod_get_value(conf->init_b);
+
+		if (ret < 0) {
+			dev_err(&mgr->dev, "Error reading INIT_B (%d)\n", ret);
+			return ret;
+		}
+
+		dev_err(&mgr->dev,
+			ret ? "CRC error or invalid device\n"
+			: "Missing sync word or incomplete bitstream\n");
+	} else {
+		dev_err(&mgr->dev, "Timeout after config data transfer\n");
+	}
+
 	return -ETIMEDOUT;
 }
 
-- 
2.28.0

