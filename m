Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA8A7535BBA
	for <lists+linux-fpga@lfdr.de>; Fri, 27 May 2022 10:40:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239855AbiE0Iis (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 27 May 2022 04:38:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350019AbiE0Ii1 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 27 May 2022 04:38:27 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88A6765D09;
        Fri, 27 May 2022 01:37:48 -0700 (PDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4L8dSF3f8qz1JCSM;
        Fri, 27 May 2022 16:36:13 +0800 (CST)
Received: from dggpemm500018.china.huawei.com (7.185.36.111) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 27 May 2022 16:37:46 +0800
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm500018.china.huawei.com (7.185.36.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 27 May 2022 16:37:45 +0800
From:   keliu <liuke94@huawei.com>
To:     <hao.wu@intel.com>, <trix@redhat.com>, <mdf@kernel.org>,
        <yilun.xu@intel.com>, <linux-fpga@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     keliu <liuke94@huawei.com>
Subject: [PATCH] fpga: Directly use ida_alloc()/free()
Date:   Fri, 27 May 2022 08:59:15 +0000
Message-ID: <20220527085915.2798928-1-liuke94@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500018.china.huawei.com (7.185.36.111)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Use ida_alloc()/ida_free() instead of deprecated
ida_simple_get()/ida_simple_remove() .

Signed-off-by: keliu <liuke94@huawei.com>
---
 drivers/fpga/dfl.c         | 4 ++--
 drivers/fpga/fpga-bridge.c | 6 +++---
 drivers/fpga/fpga-mgr.c    | 6 +++---
 drivers/fpga/fpga-region.c | 6 +++---
 4 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
index 599bb21d86af..2dff0c626cc6 100644
--- a/drivers/fpga/dfl.c
+++ b/drivers/fpga/dfl.c
@@ -342,7 +342,7 @@ static void release_dfl_dev(struct device *dev)
 	if (ddev->mmio_res.parent)
 		release_resource(&ddev->mmio_res);
 
-	ida_simple_remove(&dfl_device_ida, ddev->id);
+	ida_free(&dfl_device_ida, ddev->id);
 	kfree(ddev->irqs);
 	kfree(ddev);
 }
@@ -360,7 +360,7 @@ dfl_dev_add(struct dfl_feature_platform_data *pdata,
 	if (!ddev)
 		return ERR_PTR(-ENOMEM);
 
-	id = ida_simple_get(&dfl_device_ida, 0, 0, GFP_KERNEL);
+	id = ida_alloc(&dfl_device_ida, GFP_KERNEL);
 	if (id < 0) {
 		dev_err(&pdev->dev, "unable to get id\n");
 		kfree(ddev);
diff --git a/drivers/fpga/fpga-bridge.c b/drivers/fpga/fpga-bridge.c
index 16f2b164a178..727704431f61 100644
--- a/drivers/fpga/fpga-bridge.c
+++ b/drivers/fpga/fpga-bridge.c
@@ -342,7 +342,7 @@ fpga_bridge_register(struct device *parent, const char *name,
 	if (!bridge)
 		return ERR_PTR(-ENOMEM);
 
-	id = ida_simple_get(&fpga_bridge_ida, 0, 0, GFP_KERNEL);
+	id = ida_alloc(&fpga_bridge_ida, GFP_KERNEL);
 	if (id < 0) {
 		ret = id;
 		goto error_kfree;
@@ -375,7 +375,7 @@ fpga_bridge_register(struct device *parent, const char *name,
 	return bridge;
 
 error_device:
-	ida_simple_remove(&fpga_bridge_ida, id);
+	ida_free(&fpga_bridge_ida, id);
 error_kfree:
 	kfree(bridge);
 
@@ -407,7 +407,7 @@ static void fpga_bridge_dev_release(struct device *dev)
 {
 	struct fpga_bridge *bridge = to_fpga_bridge(dev);
 
-	ida_simple_remove(&fpga_bridge_ida, bridge->dev.id);
+	ida_free(&fpga_bridge_ida, bridge->dev.id);
 	kfree(bridge);
 }
 
diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
index d49a9ce34568..2955a21beebe 100644
--- a/drivers/fpga/fpga-mgr.c
+++ b/drivers/fpga/fpga-mgr.c
@@ -622,7 +622,7 @@ fpga_mgr_register_full(struct device *parent, const struct fpga_manager_info *in
 	if (!mgr)
 		return ERR_PTR(-ENOMEM);
 
-	id = ida_simple_get(&fpga_mgr_ida, 0, 0, GFP_KERNEL);
+	id = ida_alloc(&fpga_mgr_ida, GFP_KERNEL);
 	if (id < 0) {
 		ret = id;
 		goto error_kfree;
@@ -661,7 +661,7 @@ fpga_mgr_register_full(struct device *parent, const struct fpga_manager_info *in
 	return mgr;
 
 error_device:
-	ida_simple_remove(&fpga_mgr_ida, id);
+	ida_free(&fpga_mgr_ida, id);
 error_kfree:
 	kfree(mgr);
 
@@ -785,7 +785,7 @@ static void fpga_mgr_dev_release(struct device *dev)
 {
 	struct fpga_manager *mgr = to_fpga_manager(dev);
 
-	ida_simple_remove(&fpga_mgr_ida, mgr->dev.id);
+	ida_free(&fpga_mgr_ida, mgr->dev.id);
 	kfree(mgr);
 }
 
diff --git a/drivers/fpga/fpga-region.c b/drivers/fpga/fpga-region.c
index b0ac18de4885..18bcaa1926dd 100644
--- a/drivers/fpga/fpga-region.c
+++ b/drivers/fpga/fpga-region.c
@@ -202,7 +202,7 @@ fpga_region_register_full(struct device *parent, const struct fpga_region_info *
 	if (!region)
 		return ERR_PTR(-ENOMEM);
 
-	id = ida_simple_get(&fpga_region_ida, 0, 0, GFP_KERNEL);
+	id = ida_alloc(&fpga_region_ida, GFP_KERNEL);
 	if (id < 0) {
 		ret = id;
 		goto err_free;
@@ -234,7 +234,7 @@ fpga_region_register_full(struct device *parent, const struct fpga_region_info *
 	return region;
 
 err_remove:
-	ida_simple_remove(&fpga_region_ida, id);
+	ida_free(&fpga_region_ida, id);
 err_free:
 	kfree(region);
 
@@ -283,7 +283,7 @@ static void fpga_region_dev_release(struct device *dev)
 {
 	struct fpga_region *region = to_fpga_region(dev);
 
-	ida_simple_remove(&fpga_region_ida, region->dev.id);
+	ida_free(&fpga_region_ida, region->dev.id);
 	kfree(region);
 }
 
-- 
2.25.1

