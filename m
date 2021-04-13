Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 324D935D62B
	for <lists+linux-fpga@lfdr.de>; Tue, 13 Apr 2021 05:54:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344394AbhDMDwN (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 12 Apr 2021 23:52:13 -0400
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:18157 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241484AbhDMDwM (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 12 Apr 2021 23:52:12 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0UVPm0z._1618285894;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0UVPm0z._1618285894)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 13 Apr 2021 11:51:42 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     mdf@kernel.org
Cc:     trix@redhat.com, michal.simek@xilinx.com,
        linux-fpga@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Subject: [PATCH] fpga: xilinx-pr-decoupler: remove useless function
Date:   Tue, 13 Apr 2021 11:51:34 +0800
Message-Id: <1618285894-111432-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Fix the following gcc warning:

drivers/fpga/xilinx-pr-decoupler.c:32:19: warning: unused function
'xlnx_pr_decouple_read' [-Wunused-function].

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/fpga/xilinx-pr-decoupler.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/fpga/xilinx-pr-decoupler.c b/drivers/fpga/xilinx-pr-decoupler.c
index 7d69af2..f407cb2 100644
--- a/drivers/fpga/xilinx-pr-decoupler.c
+++ b/drivers/fpga/xilinx-pr-decoupler.c
@@ -29,12 +29,6 @@ static inline void xlnx_pr_decoupler_write(struct xlnx_pr_decoupler_data *d,
 	writel(val, d->io_base + offset);
 }
 
-static inline u32 xlnx_pr_decouple_read(const struct xlnx_pr_decoupler_data *d,
-					u32 offset)
-{
-	return readl(d->io_base + offset);
-}
-
 static int xlnx_pr_decoupler_enable_set(struct fpga_bridge *bridge, bool enable)
 {
 	int err;
-- 
1.8.3.1

