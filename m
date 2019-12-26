Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 17C7F12AC33
	for <lists+linux-fpga@lfdr.de>; Thu, 26 Dec 2019 13:17:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726479AbfLZMR1 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 26 Dec 2019 07:17:27 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:35340 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725954AbfLZMR1 (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 26 Dec 2019 07:17:27 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id D1CA81CD06450C954626;
        Thu, 26 Dec 2019 20:17:19 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.439.0; Thu, 26 Dec 2019
 20:17:11 +0800
From:   yu kuai <yukuai3@huawei.com>
To:     <hao.wu@intel.com>, <mdf@kernel.org>
CC:     <linux-fpga@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yukuai3@huawei.com>, <yi.zhang@huawe.com>, <zhengbin13@huawei.com>
Subject: [PATCH] fpga: dfl: fme: remove set but not used variable 'fme'
Date:   Thu, 26 Dec 2019 20:16:38 +0800
Message-ID: <20191226121638.10507-1-yukuai3@huawei.com>
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

drivers/fpga/dfl-fme-main.c: In function ‘fme_dev_destroy’:
drivers/fpga/dfl-fme-main.c:678:18: warning: variable ‘fme’ set but not
used [-Wunused-but-set-variable]

It is never used and so can be removed.

Signed-off-by: yu kuai <yukuai3@huawei.com>
---
 drivers/fpga/dfl-fme-main.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/fpga/dfl-fme-main.c b/drivers/fpga/dfl-fme-main.c
index 7c930e6b314d..1d4690c99268 100644
--- a/drivers/fpga/dfl-fme-main.c
+++ b/drivers/fpga/dfl-fme-main.c
@@ -675,10 +675,8 @@ static int fme_dev_init(struct platform_device *pdev)
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
2.17.2

