Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BE14246D80
	for <lists+linux-fpga@lfdr.de>; Mon, 17 Aug 2020 19:00:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729682AbgHQRAI (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 17 Aug 2020 13:00:08 -0400
Received: from hostingweb31-40.netsons.net ([89.40.174.40]:43605 "EHLO
        hostingweb31-40.netsons.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388400AbgHQQ74 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 17 Aug 2020 12:59:56 -0400
Received: from [78.134.86.56] (port=44766 helo=melee.fritz.box)
        by hostingweb31.netsons.net with esmtpa (Exim 4.93)
        (envelope-from <luca@lucaceresoli.net>)
        id 1k7iTk-00015j-Ni; Mon, 17 Aug 2020 18:59:24 +0200
From:   Luca Ceresoli <luca@lucaceresoli.net>
To:     linux-fpga@vger.kernel.org
Cc:     Luca Ceresoli <luca@lucaceresoli.net>,
        Moritz Fischer <mdf@kernel.org>, Tom Rix <trix@redhat.com>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anatolij Gustschin <agust@denx.de>
Subject: [PATCH 3/3] fpga manager: xilinx-spi: remove final dot from dev_err() strings
Date:   Mon, 17 Aug 2020 18:59:11 +0200
Message-Id: <20200817165911.32589-3-luca@lucaceresoli.net>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817165911.32589-1-luca@lucaceresoli.net>
References: <20200817165911.32589-1-luca@lucaceresoli.net>
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

Most dev_err messages in this file have no final dot. Remove the only two
exceptions to make them consistent.

Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
---
 drivers/fpga/xilinx-spi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/fpga/xilinx-spi.c b/drivers/fpga/xilinx-spi.c
index 2aa942bb1114..557c66136400 100644
--- a/drivers/fpga/xilinx-spi.c
+++ b/drivers/fpga/xilinx-spi.c
@@ -77,7 +77,7 @@ static int xilinx_spi_write_init(struct fpga_manager *mgr,
 	int err;
 
 	if (info->flags & FPGA_MGR_PARTIAL_RECONFIG) {
-		dev_err(&mgr->dev, "Partial reconfiguration not supported.\n");
+		dev_err(&mgr->dev, "Partial reconfiguration not supported\n");
 		return -EINVAL;
 	}
 
@@ -176,7 +176,7 @@ static int xilinx_spi_write_complete(struct fpga_manager *mgr,
 			init_b_asserted ? "CRC error or invalid device\n"
 			: "Missing sync word or incomplete bitstream\n");
 	} else {
-		dev_err(&mgr->dev, "Timeout after config data transfer.\n");
+		dev_err(&mgr->dev, "Timeout after config data transfer\n");
 	}
 
 	return -ETIMEDOUT;
-- 
2.28.0

