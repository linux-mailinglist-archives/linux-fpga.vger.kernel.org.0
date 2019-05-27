Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E33662B86F
	for <lists+linux-fpga@lfdr.de>; Mon, 27 May 2019 17:37:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726280AbfE0PhO (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 27 May 2019 11:37:14 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:17581 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726094AbfE0PhO (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 27 May 2019 11:37:14 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 1E972C8782A2DA0F2171;
        Mon, 27 May 2019 23:37:03 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.439.0; Mon, 27 May 2019
 23:36:56 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <hao.wu@intel.com>, <atull@kernel.org>, <mdf@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-fpga@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] fpga: dfl: fme: Remove set but not used variable 'fme'
Date:   Mon, 27 May 2019 23:34:24 +0800
Message-ID: <20190527153424.10268-1-yuehaibing@huawei.com>
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

drivers/fpga/dfl-fme-main.c: In function fme_dev_destroy:
drivers/fpga/dfl-fme-main.c:216:18: warning: variable fme set but not used [-Wunused-but-set-variable]

It's never used since introduction in commit 29de76240e86 ("fpga:
dfl: fme: add partial reconfiguration sub feature support")

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/fpga/dfl-fme-main.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/fpga/dfl-fme-main.c b/drivers/fpga/dfl-fme-main.c
index 086ad2420ade..cb7c4e258298 100644
--- a/drivers/fpga/dfl-fme-main.c
+++ b/drivers/fpga/dfl-fme-main.c
@@ -213,10 +213,8 @@ static int fme_dev_init(struct platform_device *pdev)
 static void fme_dev_destroy(struct platform_device *pdev)
 {
 	struct dfl_feature_platform_data *pdata = dev_get_platdata(&pdev->dev);
-	struct dfl_fme *fme;
 
 	mutex_lock(&pdata->lock);
-	fme = dfl_fpga_pdata_get_private(pdata);
 	dfl_fpga_pdata_set_private(pdata, NULL);
 	mutex_unlock(&pdata->lock);
 }
-- 
2.17.1


