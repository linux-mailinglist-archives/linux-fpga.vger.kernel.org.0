Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1009E4671D0
	for <lists+linux-fpga@lfdr.de>; Fri,  3 Dec 2021 07:19:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244238AbhLCGWr (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 3 Dec 2021 01:22:47 -0500
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:45167 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232133AbhLCGWq (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 3 Dec 2021 01:22:46 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0UzEttwD_1638512359;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0UzEttwD_1638512359)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 03 Dec 2021 14:19:20 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     mdf@kernel.org
Cc:     hao.wu@intel.com, yilun.xu@intel.com, trix@redhat.com,
        rdunlap@infradead.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH -next RESEND] fpga: region: fix kernel-doc
Date:   Fri,  3 Dec 2021 14:19:13 +0800
Message-Id: <1638512353-103822-1-git-send-email-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Fix function name in of-fpga-region.c kernel-doc comment
to remove a warning found by running scripts/kernel-doc,
which is caused by using 'make W=1'.

drivers/fpga/of-fpga-region.c:451: warning: expecting prototype for
fpga_region_init(). Prototype was for of_fpga_region_init() instead.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/fpga/of-fpga-region.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/fpga/of-fpga-region.c b/drivers/fpga/of-fpga-region.c
index 9c662db..50b8305 100644
--- a/drivers/fpga/of-fpga-region.c
+++ b/drivers/fpga/of-fpga-region.c
@@ -444,7 +444,7 @@ static int of_fpga_region_remove(struct platform_device *pdev)
 };
 
 /**
- * fpga_region_init - init function for fpga_region class
+ * of_fpga_region_init - init function for fpga_region class
  * Creates the fpga_region class and registers a reconfig notifier.
  */
 static int __init of_fpga_region_init(void)
-- 
1.8.3.1

