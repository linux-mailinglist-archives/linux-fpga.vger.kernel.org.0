Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 287623EB082
	for <lists+linux-fpga@lfdr.de>; Fri, 13 Aug 2021 08:41:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238729AbhHMGmP (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 13 Aug 2021 02:42:15 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:59874 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238622AbhHMGmP (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Fri, 13 Aug 2021 02:42:15 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0UirhzQK_1628836883;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0UirhzQK_1628836883)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 13 Aug 2021 14:41:47 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     mdf@kernel.org
Cc:     trix@redhat.com, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Subject: [PATCH] fpga: machxo2-spi: Fix missing error code in machxo2_write_complete()
Date:   Fri, 13 Aug 2021 14:40:42 +0800
Message-Id: <1628836842-82107-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

The error code is missing in this code scenario, add the error code
'-EINVAL' to the return value 'ret'.

Eliminate the follow smatch warning:

drivers/fpga/machxo2-spi.c:341 machxo2_write_complete() warn: missing
error code 'ret'.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Fixes: 88fb3a002330 ("fpga: lattice machxo2: Add Lattice MachXO2
support")
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/fpga/machxo2-spi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/fpga/machxo2-spi.c b/drivers/fpga/machxo2-spi.c
index b4a530a..ea2ec3c 100644
--- a/drivers/fpga/machxo2-spi.c
+++ b/drivers/fpga/machxo2-spi.c
@@ -338,6 +338,7 @@ static int machxo2_write_complete(struct fpga_manager *mgr,
 			break;
 		if (++refreshloop == MACHXO2_MAX_REFRESH_LOOP) {
 			machxo2_cleanup(mgr);
+			ret = -EINVAL;
 			goto fail;
 		}
 	} while (1);
-- 
1.8.3.1

