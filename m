Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C48692546F3
	for <lists+linux-fpga@lfdr.de>; Thu, 27 Aug 2020 16:33:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728079AbgH0OdW (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 27 Aug 2020 10:33:22 -0400
Received: from hostingweb31-40.netsons.net ([89.40.174.40]:42487 "EHLO
        hostingweb31-40.netsons.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728048AbgH0OdD (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 27 Aug 2020 10:33:03 -0400
Received: from [78.134.86.56] (port=49228 helo=melee.fritz.box)
        by hostingweb31.netsons.net with esmtpa (Exim 4.93)
        (envelope-from <luca@lucaceresoli.net>)
        id 1kBIxZ-0006H2-83; Thu, 27 Aug 2020 16:33:01 +0200
From:   Luca Ceresoli <luca@lucaceresoli.net>
To:     linux-fpga@vger.kernel.org
Cc:     Luca Ceresoli <luca@lucaceresoli.net>,
        Moritz Fischer <mdf@kernel.org>, Tom Rix <trix@redhat.com>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anatolij Gustschin <agust@denx.de>
Subject: [PATCH v2 3/5] fpga manager: xilinx-spi: rework write_complete loop implementation
Date:   Thu, 27 Aug 2020 16:32:47 +0200
Message-Id: <20200827143249.10973-3-luca@lucaceresoli.net>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200827143249.10973-1-luca@lucaceresoli.net>
References: <20200827143249.10973-1-luca@lucaceresoli.net>
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

In preparation to add error checking for gpiod_get_value(), rework
the loop to avoid the duplication of these lines:

	if (gpiod_get_value(conf->done))
		return xilinx_spi_apply_cclk_cycles(conf);

There is little advantage in this rework with current code. However
error checking will expand these two lines to five, making code
duplication more annoying.

Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>

---

This patch is new in v2
---
 drivers/fpga/xilinx-spi.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/fpga/xilinx-spi.c b/drivers/fpga/xilinx-spi.c
index 01f494172379..cfc933d70f52 100644
--- a/drivers/fpga/xilinx-spi.c
+++ b/drivers/fpga/xilinx-spi.c
@@ -151,22 +151,19 @@ static int xilinx_spi_write_complete(struct fpga_manager *mgr,
 				     struct fpga_image_info *info)
 {
 	struct xilinx_spi_conf *conf = mgr->priv;
-	unsigned long timeout;
+	unsigned long timeout = jiffies + usecs_to_jiffies(info->config_complete_timeout_us);
 	int ret;
 
-	if (gpiod_get_value(conf->done))
-		return xilinx_spi_apply_cclk_cycles(conf);
-
-	timeout = jiffies + usecs_to_jiffies(info->config_complete_timeout_us);
+	while (true) {
+		if (gpiod_get_value(conf->done))
+			return xilinx_spi_apply_cclk_cycles(conf);
 
-	while (time_before(jiffies, timeout)) {
+		if (time_after(jiffies, timeout))
+			break;
 
 		ret = xilinx_spi_apply_cclk_cycles(conf);
 		if (ret)
 			return ret;
-
-		if (gpiod_get_value(conf->done))
-			return xilinx_spi_apply_cclk_cycles(conf);
 	}
 
 	dev_err(&mgr->dev, "Timeout after config data transfer\n");
-- 
2.28.0

