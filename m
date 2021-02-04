Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E20DD30F3AD
	for <lists+linux-fpga@lfdr.de>; Thu,  4 Feb 2021 14:09:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236207AbhBDNIr (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 4 Feb 2021 08:08:47 -0500
Received: from hostingweb31-40.netsons.net ([89.40.174.40]:60350 "EHLO
        hostingweb31-40.netsons.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236197AbhBDNIq (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 4 Feb 2021 08:08:46 -0500
X-Greylist: delayed 3222 seconds by postgrey-1.27 at vger.kernel.org; Thu, 04 Feb 2021 08:08:45 EST
Received: from [77.244.183.192] (port=62020 helo=melee.fritz.box)
        by hostingweb31.netsons.net with esmtpa (Exim 4.93)
        (envelope-from <luca@lucaceresoli.net>)
        id 1l7dWe-002S1d-Qu; Thu, 04 Feb 2021 13:14:20 +0100
From:   Luca Ceresoli <luca@lucaceresoli.net>
To:     linux-fpga@vger.kernel.org
Cc:     Moritz Fischer <mdf@kernel.org>, Tom Rix <trix@redhat.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Alan Tull <atull@kernel.org>,
        Anatolij Gustschin <agust@denx.de>,
        linux-kernel@vger.kernel.org, Luca Ceresoli <luca@lucaceresoli.net>
Subject: [PATCH] fpga: fpga-mgr: xilinx-spi: fix error messages on -EPROBE_DEFER
Date:   Thu,  4 Feb 2021 13:13:13 +0100
Message-Id: <20210204121313.24655-1-luca@lucaceresoli.net>
X-Mailer: git-send-email 2.30.0
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
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

The current code produces an error message on devm_gpiod_get() errors even
when the error is -EPROBE_DEFER, which should be silent.

This has been observed producing a significant amount of messages like:

    xlnx-slave-spi spi1.1: Failed to get PROGRAM_B gpio: -517

Fix and simplify code by using the dev_err_probe() helper function.

Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
Fixes: dd2784c01d93 ("fpga manager: xilinx-spi: check INIT_B pin during write_init")
Fixes: 061c97d13f1a ("fpga manager: Add Xilinx slave serial SPI driver")
---
 drivers/fpga/xilinx-spi.c | 24 +++++++++---------------
 1 file changed, 9 insertions(+), 15 deletions(-)

diff --git a/drivers/fpga/xilinx-spi.c b/drivers/fpga/xilinx-spi.c
index 27defa98092d..fee4d0abf6bf 100644
--- a/drivers/fpga/xilinx-spi.c
+++ b/drivers/fpga/xilinx-spi.c
@@ -233,25 +233,19 @@ static int xilinx_spi_probe(struct spi_device *spi)
 
 	/* PROGRAM_B is active low */
 	conf->prog_b = devm_gpiod_get(&spi->dev, "prog_b", GPIOD_OUT_LOW);
-	if (IS_ERR(conf->prog_b)) {
-		dev_err(&spi->dev, "Failed to get PROGRAM_B gpio: %ld\n",
-			PTR_ERR(conf->prog_b));
-		return PTR_ERR(conf->prog_b);
-	}
+	if (IS_ERR(conf->prog_b))
+		return dev_err_probe(&spi->dev, PTR_ERR(conf->prog_b),
+				     "Failed to get PROGRAM_B gpio\n");
 
 	conf->init_b = devm_gpiod_get_optional(&spi->dev, "init-b", GPIOD_IN);
-	if (IS_ERR(conf->init_b)) {
-		dev_err(&spi->dev, "Failed to get INIT_B gpio: %ld\n",
-			PTR_ERR(conf->init_b));
-		return PTR_ERR(conf->init_b);
-	}
+	if (IS_ERR(conf->init_b))
+		return dev_err_probe(&spi->dev, PTR_ERR(conf->init_b),
+				     "Failed to get INIT_B gpio\n");
 
 	conf->done = devm_gpiod_get(&spi->dev, "done", GPIOD_IN);
-	if (IS_ERR(conf->done)) {
-		dev_err(&spi->dev, "Failed to get DONE gpio: %ld\n",
-			PTR_ERR(conf->done));
-		return PTR_ERR(conf->done);
-	}
+	if (IS_ERR(conf->done))
+		return dev_err_probe(&spi->dev, PTR_ERR(conf->done),
+				     "Failed to get DONE gpio\n");
 
 	mgr = devm_fpga_mgr_create(&spi->dev,
 				   "Xilinx Slave Serial FPGA Manager",
-- 
2.30.0

