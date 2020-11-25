Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F8222C3940
	for <lists+linux-fpga@lfdr.de>; Wed, 25 Nov 2020 07:47:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbgKYGqU (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 25 Nov 2020 01:46:20 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:8401 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725817AbgKYGqT (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 25 Nov 2020 01:46:19 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Cgrxx2fxVz73CW;
        Wed, 25 Nov 2020 14:45:57 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.487.0; Wed, 25 Nov 2020 14:46:07 +0800
From:   Qinglang Miao <miaoqinglang@huawei.com>
To:     Wu Hao <hao.wu@intel.com>, Tom Rix <trix@redhat.com>,
        Moritz Fischer <mdf@kernel.org>
CC:     <linux-fpga@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Qinglang Miao" <miaoqinglang@huawei.com>
Subject: [PATCH] fpga: dfl: add missing platform_device_put in build_info_create_dev
Date:   Wed, 25 Nov 2020 14:50:30 +0800
Message-ID: <20201125065030.154074-1-miaoqinglang@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

platform_device_put is missing when it fails to set fdev->id. Set
a temp value to do sanity check.

Fixes: 543be3d8c999 ("fpga: add device feature list support")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>
---
 drivers/fpga/dfl.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
index b450870b7..8958f0860 100644
--- a/drivers/fpga/dfl.c
+++ b/drivers/fpga/dfl.c
@@ -877,10 +877,13 @@ build_info_create_dev(struct build_feature_devs_info *binfo,
 
 	INIT_LIST_HEAD(&binfo->sub_features);
 
-	fdev->id = dfl_id_alloc(type, &fdev->dev);
-	if (fdev->id < 0)
-		return fdev->id;
+	int tmp_id = dfl_id_alloc(type, &fdev->dev);
+	if (tmp_id < 0) {
+		platform_device_put(fdev);
+		return tmp_id;
+	}
 
+	fdev->id = tmp_id;
 	fdev->dev.parent = &binfo->cdev->region->dev;
 	fdev->dev.devt = dfl_get_devt(dfl_devs[type].devt_type, fdev->id);
 
-- 
2.23.0

