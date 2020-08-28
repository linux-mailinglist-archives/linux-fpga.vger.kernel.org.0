Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39ACA2561BA
	for <lists+linux-fpga@lfdr.de>; Fri, 28 Aug 2020 21:59:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727043AbgH1T6x (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 28 Aug 2020 15:58:53 -0400
Received: from hostingweb31-40.netsons.net ([89.40.174.40]:35451 "EHLO
        hostingweb31-40.netsons.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726396AbgH1T6X (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Fri, 28 Aug 2020 15:58:23 -0400
Received: from [78.134.86.56] (port=54992 helo=melee.dev.aim)
        by hostingweb31.netsons.net with esmtpa (Exim 4.93)
        (envelope-from <luca@lucaceresoli.net>)
        id 1kBkVw-0008I1-8V; Fri, 28 Aug 2020 21:58:20 +0200
From:   Luca Ceresoli <luca@lucaceresoli.net>
To:     linux-fpga@vger.kernel.org
Cc:     Luca Ceresoli <luca@lucaceresoli.net>,
        Moritz Fischer <mdf@kernel.org>, Tom Rix <trix@redhat.com>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anatolij Gustschin <agust@denx.de>
Subject: [PATCH v3 2/5] fpga manager: xilinx-spi: remove final dot from dev_err() strings
Date:   Fri, 28 Aug 2020 21:58:05 +0200
Message-Id: <20200828195808.27975-2-luca@lucaceresoli.net>
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

Most dev_err messages in this file have no final dot. Remove the only two
exceptions to make them consistent.

Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>

---

Changes in v3: none.

Changes in v2:
 - move before the "provide better diagnostics on programming failure"
   patch for clarity
---
 drivers/fpga/xilinx-spi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/fpga/xilinx-spi.c b/drivers/fpga/xilinx-spi.c
index 502fae0d1d85..01f494172379 100644
--- a/drivers/fpga/xilinx-spi.c
+++ b/drivers/fpga/xilinx-spi.c
@@ -77,7 +77,7 @@ static int xilinx_spi_write_init(struct fpga_manager *mgr,
 	int err;
 
 	if (info->flags & FPGA_MGR_PARTIAL_RECONFIG) {
-		dev_err(&mgr->dev, "Partial reconfiguration not supported.\n");
+		dev_err(&mgr->dev, "Partial reconfiguration not supported\n");
 		return -EINVAL;
 	}
 
@@ -169,7 +169,7 @@ static int xilinx_spi_write_complete(struct fpga_manager *mgr,
 			return xilinx_spi_apply_cclk_cycles(conf);
 	}
 
-	dev_err(&mgr->dev, "Timeout after config data transfer.\n");
+	dev_err(&mgr->dev, "Timeout after config data transfer\n");
 	return -ETIMEDOUT;
 }
 
-- 
2.28.0

