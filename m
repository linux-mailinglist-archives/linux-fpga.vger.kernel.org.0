Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44D891F6F77
	for <lists+linux-fpga@lfdr.de>; Thu, 11 Jun 2020 23:30:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726277AbgFKVas (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 11 Jun 2020 17:30:48 -0400
Received: from hostingweb31-40.netsons.net ([89.40.174.40]:37156 "EHLO
        hostingweb31-40.netsons.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725869AbgFKVar (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 11 Jun 2020 17:30:47 -0400
Received: from [78.134.85.74] (port=40536 helo=melee.dev.aim)
        by hostingweb31.netsons.net with esmtpa (Exim 4.93)
        (envelope-from <luca@lucaceresoli.net>)
        id 1jjUUO-000C9m-KX; Thu, 11 Jun 2020 23:11:56 +0200
From:   Luca Ceresoli <luca@lucaceresoli.net>
To:     linux-fpga@vger.kernel.org
Cc:     Luca Ceresoli <luca@lucaceresoli.net>,
        Moritz Fischer <mdf@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Anatolij Gustschin <agust@denx.de>
Subject: [PATCH 3/5] fpga manager: xilinx-spi: remove unneeded, mistyped variables
Date:   Thu, 11 Jun 2020 23:11:42 +0200
Message-Id: <20200611211144.9421-3-luca@lucaceresoli.net>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200611211144.9421-1-luca@lucaceresoli.net>
References: <20200611211144.9421-1-luca@lucaceresoli.net>
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

Using variables does not add readability here: parameters passed
to udelay*() are obviously in microseconds and their meaning is clear
from the context.

The type is also wrong, udelay expects an unsigned long.

Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
---
 drivers/fpga/xilinx-spi.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/fpga/xilinx-spi.c b/drivers/fpga/xilinx-spi.c
index 79106626c3f8..799ae04301be 100644
--- a/drivers/fpga/xilinx-spi.c
+++ b/drivers/fpga/xilinx-spi.c
@@ -41,8 +41,6 @@ static int xilinx_spi_write_init(struct fpga_manager *mgr,
 				 const char *buf, size_t count)
 {
 	struct xilinx_spi_conf *conf = mgr->priv;
-	const size_t prog_latency_7500us = 7500;
-	const size_t prog_pulse_1us = 1;
 
 	if (info->flags & FPGA_MGR_PARTIAL_RECONFIG) {
 		dev_err(&mgr->dev, "Partial reconfiguration not supported.\n");
@@ -51,7 +49,7 @@ static int xilinx_spi_write_init(struct fpga_manager *mgr,
 
 	gpiod_set_value(conf->prog_b, 1);
 
-	udelay(prog_pulse_1us); /* min is 500 ns */
+	udelay(1); /* min is 500 ns */
 
 	gpiod_set_value(conf->prog_b, 0);
 
@@ -61,7 +59,7 @@ static int xilinx_spi_write_init(struct fpga_manager *mgr,
 	}
 
 	/* program latency */
-	usleep_range(prog_latency_7500us, prog_latency_7500us + 100);
+	usleep_range(7500, 7600);
 	return 0;
 }
 
-- 
2.27.0

