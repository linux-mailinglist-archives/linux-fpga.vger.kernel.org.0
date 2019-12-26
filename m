Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 77DDA12AC30
	for <lists+linux-fpga@lfdr.de>; Thu, 26 Dec 2019 13:16:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726060AbfLZMQ2 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 26 Dec 2019 07:16:28 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:34246 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725954AbfLZMQ2 (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 26 Dec 2019 07:16:28 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 7493925BD243905ADFDC;
        Thu, 26 Dec 2019 20:16:18 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.439.0; Thu, 26 Dec 2019
 20:16:07 +0800
From:   yu kuai <yukuai3@huawei.com>
To:     <hao.wu@intel.com>, <mdf@kernel.org>
CC:     <linux-fpga@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yukuai3@huawei.com>, <yi.zhang@huawe.com>, <zhengbin13@huawei.com>
Subject: [PATCH] fpga: dfl: afu: remove set but not used variable 'afu'
Date:   Thu, 26 Dec 2019 20:15:33 +0800
Message-ID: <20191226121533.6017-1-yukuai3@huawei.com>
X-Mailer: git-send-email 2.17.2
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/fpga/dfl-afu-main.c: In function ‘afu_dev_destroy’:
drivers/fpga/dfl-afu-main.c:816:18: warning: variable ‘afu’
set but not used [-Wunused-but-set-variable]

It is never used, and so can be removed.

Signed-off-by: yu kuai <yukuai3@huawei.com>
---
 drivers/fpga/dfl-afu-main.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/fpga/dfl-afu-main.c b/drivers/fpga/dfl-afu-main.c
index e4a34dc7947f..65437b6a6842 100644
--- a/drivers/fpga/dfl-afu-main.c
+++ b/drivers/fpga/dfl-afu-main.c
@@ -813,10 +813,8 @@ static int afu_dev_init(struct platform_device *pdev)
 static int afu_dev_destroy(struct platform_device *pdev)
 {
 	struct dfl_feature_platform_data *pdata = dev_get_platdata(&pdev->dev);
-	struct dfl_afu *afu;
 
 	mutex_lock(&pdata->lock);
-	afu = dfl_fpga_pdata_get_private(pdata);
 	afu_mmio_region_destroy(pdata);
 	afu_dma_region_destroy(pdata);
 	dfl_fpga_pdata_set_private(pdata, NULL);
-- 
2.17.2

