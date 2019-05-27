Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 887FE2B875
	for <lists+linux-fpga@lfdr.de>; Mon, 27 May 2019 17:39:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbfE0PjF (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 27 May 2019 11:39:05 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:48784 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726115AbfE0PjF (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 27 May 2019 11:39:05 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 0255BD75021223B635F8;
        Mon, 27 May 2019 23:38:56 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.439.0; Mon, 27 May 2019
 23:38:49 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <hao.wu@intel.com>, <atull@kernel.org>, <mdf@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-fpga@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] fpga: dfl: afu: Remove set but not used variable 'afu'
Date:   Mon, 27 May 2019 23:37:55 +0800
Message-ID: <20190527153755.7332-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/fpga/dfl-afu-main.c: In function afu_dev_destroy:
drivers/fpga/dfl-afu-main.c:529:18: warning: variable afu set but not used [-Wunused-but-set-variable]

It is never used since introduction in commit
857a26222ff7 ("fpga: dfl: afu: add afu sub feature support")

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/fpga/dfl-afu-main.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/fpga/dfl-afu-main.c b/drivers/fpga/dfl-afu-main.c
index 02baa6a227c0..5e166b81d14a 100644
--- a/drivers/fpga/dfl-afu-main.c
+++ b/drivers/fpga/dfl-afu-main.c
@@ -526,10 +526,8 @@ static int afu_dev_init(struct platform_device *pdev)
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
2.17.1


