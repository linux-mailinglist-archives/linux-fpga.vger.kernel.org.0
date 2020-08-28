Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9250C2561C0
	for <lists+linux-fpga@lfdr.de>; Fri, 28 Aug 2020 21:59:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbgH1T7G (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 28 Aug 2020 15:59:06 -0400
Received: from hostingweb31-40.netsons.net ([89.40.174.40]:54751 "EHLO
        hostingweb31-40.netsons.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725979AbgH1T6X (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Fri, 28 Aug 2020 15:58:23 -0400
Received: from [78.134.86.56] (port=54992 helo=melee.dev.aim)
        by hostingweb31.netsons.net with esmtpa (Exim 4.93)
        (envelope-from <luca@lucaceresoli.net>)
        id 1kBkVv-0008I1-Ur; Fri, 28 Aug 2020 21:58:20 +0200
From:   Luca Ceresoli <luca@lucaceresoli.net>
To:     linux-fpga@vger.kernel.org
Cc:     Luca Ceresoli <luca@lucaceresoli.net>,
        Moritz Fischer <mdf@kernel.org>, Tom Rix <trix@redhat.com>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anatolij Gustschin <agust@denx.de>
Subject: [PATCH v3 1/5] fpga manager: xilinx-spi: remove stray comment
Date:   Fri, 28 Aug 2020 21:58:04 +0200
Message-Id: <20200828195808.27975-1-luca@lucaceresoli.net>
X-Mailer: git-send-email 2.28.0
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

Remove comment committed by mistake.

Fixes: dd2784c01d93 ("fpga manager: xilinx-spi: check INIT_B pin during write_init")
Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>

---

Changes in v3: none.

Changes in v2: none.
---
 drivers/fpga/xilinx-spi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/fpga/xilinx-spi.c b/drivers/fpga/xilinx-spi.c
index 2967aa2a74e2..502fae0d1d85 100644
--- a/drivers/fpga/xilinx-spi.c
+++ b/drivers/fpga/xilinx-spi.c
@@ -57,7 +57,6 @@ static int wait_for_init_b(struct fpga_manager *mgr, int value,
 
 	if (conf->init_b) {
 		while (time_before(jiffies, timeout)) {
-			/* dump_state(conf, "wait for init_d .."); */
 			if (gpiod_get_value(conf->init_b) == value)
 				return 0;
 			usleep_range(100, 400);
-- 
2.28.0

