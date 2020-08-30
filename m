Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91F81256F5F
	for <lists+linux-fpga@lfdr.de>; Sun, 30 Aug 2020 18:39:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbgH3QjK (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 30 Aug 2020 12:39:10 -0400
Received: from hostingweb31-40.netsons.net ([89.40.174.40]:55691 "EHLO
        hostingweb31-40.netsons.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726394AbgH3QjH (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Sun, 30 Aug 2020 12:39:07 -0400
Received: from [78.134.86.56] (port=34202 helo=melee.dev.aim)
        by hostingweb31.netsons.net with esmtpa (Exim 4.93)
        (envelope-from <luca@lucaceresoli.net>)
        id 1kCQMC-000E3G-Of; Sun, 30 Aug 2020 18:39:04 +0200
From:   Luca Ceresoli <luca@lucaceresoli.net>
To:     linux-fpga@vger.kernel.org
Cc:     Luca Ceresoli <luca@lucaceresoli.net>,
        Moritz Fischer <mdf@kernel.org>, Tom Rix <trix@redhat.com>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anatolij Gustschin <agust@denx.de>
Subject: [PATCH v4 4/5] fpga manager: xilinx-spi: add error checking after gpiod_get_value()
Date:   Sun, 30 Aug 2020 18:38:49 +0200
Message-Id: <20200830163850.8380-4-luca@lucaceresoli.net>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200830163850.8380-1-luca@lucaceresoli.net>
References: <20200830163850.8380-1-luca@lucaceresoli.net>
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

Current code calls gpiod_get_value() without error checking. Should the
GPIO controller fail, execution would continue without any error message.

Fix by checking for negative error values.

Reported-by: Tom Rix <trix@redhat.com>
Reviewed-by: Tom Rix <trix@redhat.com>
Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>

---

Changes in v4:
 - add Reviewed-by Tom Rix

Changes in v3:
 - rebase on previous patches

This patch is new in v2
---
 drivers/fpga/xilinx-spi.c | 35 +++++++++++++++++++++++++++--------
 1 file changed, 27 insertions(+), 8 deletions(-)

diff --git a/drivers/fpga/xilinx-spi.c b/drivers/fpga/xilinx-spi.c
index fba8eb4866a7..52aab5a1f0ba 100644
--- a/drivers/fpga/xilinx-spi.c
+++ b/drivers/fpga/xilinx-spi.c
@@ -27,11 +27,22 @@ struct xilinx_spi_conf {
 	struct gpio_desc *done;
 };
 
-static enum fpga_mgr_states xilinx_spi_state(struct fpga_manager *mgr)
+static int get_done_gpio(struct fpga_manager *mgr)
 {
 	struct xilinx_spi_conf *conf = mgr->priv;
+	int ret;
+
+	ret = gpiod_get_value(conf->done);
+
+	if (ret < 0)
+		dev_err(&mgr->dev, "Error reading DONE (%d)\n", ret);
 
-	if (!gpiod_get_value(conf->done))
+	return ret;
+}
+
+static enum fpga_mgr_states xilinx_spi_state(struct fpga_manager *mgr)
+{
+	if (!get_done_gpio(mgr))
 		return FPGA_MGR_STATE_RESET;
 
 	return FPGA_MGR_STATE_UNKNOWN;
@@ -57,10 +68,21 @@ static int wait_for_init_b(struct fpga_manager *mgr, int value,
 
 	if (conf->init_b) {
 		while (time_before(jiffies, timeout)) {
-			if (gpiod_get_value(conf->init_b) == value)
+			int ret = gpiod_get_value(conf->init_b);
+
+			if (ret == value)
 				return 0;
+
+			if (ret < 0) {
+				dev_err(&mgr->dev, "Error reading INIT_B (%d)\n", ret);
+				return ret;
+			}
+
 			usleep_range(100, 400);
 		}
+
+		dev_err(&mgr->dev, "Timeout waiting for INIT_B to %s\n",
+			value ? "assert" : "deassert");
 		return -ETIMEDOUT;
 	}
 
@@ -85,7 +107,6 @@ static int xilinx_spi_write_init(struct fpga_manager *mgr,
 
 	err = wait_for_init_b(mgr, 1, 1); /* min is 500 ns */
 	if (err) {
-		dev_err(&mgr->dev, "INIT_B pin did not go low\n");
 		gpiod_set_value(conf->prog_b, 0);
 		return err;
 	}
@@ -93,12 +114,10 @@ static int xilinx_spi_write_init(struct fpga_manager *mgr,
 	gpiod_set_value(conf->prog_b, 0);
 
 	err = wait_for_init_b(mgr, 0, 0);
-	if (err) {
-		dev_err(&mgr->dev, "INIT_B pin did not go high\n");
+	if (err)
 		return err;
-	}
 
-	if (gpiod_get_value(conf->done)) {
+	if (get_done_gpio(mgr)) {
 		dev_err(&mgr->dev, "Unexpected DONE pin state...\n");
 		return -EIO;
 	}
-- 
2.28.0

