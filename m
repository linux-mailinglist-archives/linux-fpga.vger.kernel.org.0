Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA5FD26C75B
	for <lists+linux-fpga@lfdr.de>; Wed, 16 Sep 2020 20:25:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727815AbgIPSZN (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 16 Sep 2020 14:25:13 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:42754 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727843AbgIPSYy (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 16 Sep 2020 14:24:54 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 3CE77694E5F374E610F5;
        Wed, 16 Sep 2020 22:25:46 +0800 (CST)
Received: from localhost (10.174.179.108) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.487.0; Wed, 16 Sep 2020
 22:25:38 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <hao.wu@intel.com>, <trix@redhat.com>, <mdf@kernel.org>,
        <yilun.xu@intel.com>
CC:     <linux-fpga@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] fpga: dfl: Make m10_n3000_info static
Date:   Wed, 16 Sep 2020 22:25:36 +0800
Message-ID: <20200916142536.28748-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.108]
X-CFilter-Loop: Reflected
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Fix sparse warning:

drivers/fpga/dfl-n3000-nios.c:392:23: warning:
 symbol 'm10_n3000_info' was not declared. Should it be static?

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/fpga/dfl-n3000-nios.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/fpga/dfl-n3000-nios.c b/drivers/fpga/dfl-n3000-nios.c
index 5088f8f0e0cd..686813b59d33 100644
--- a/drivers/fpga/dfl-n3000-nios.c
+++ b/drivers/fpga/dfl-n3000-nios.c
@@ -389,7 +389,7 @@ static int n3000_nios_init_done_check(struct n3000_nios *ns)
 	return ret;
 }
 
-struct spi_board_info m10_n3000_info = {
+static struct spi_board_info m10_n3000_info = {
 	.modalias = "m10-n3000",
 	.max_speed_hz = 12500000,
 	.bus_num = 0,
-- 
2.17.1

