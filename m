Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C94DF2E3B93
	for <lists+linux-fpga@lfdr.de>; Mon, 28 Dec 2020 14:51:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406990AbgL1Nvs (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 28 Dec 2020 08:51:48 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:9939 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406981AbgL1Nvr (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 28 Dec 2020 08:51:47 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4D4JpV5yKNzhyRP;
        Mon, 28 Dec 2020 21:50:26 +0800 (CST)
Received: from ubuntu.network (10.175.138.68) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.498.0; Mon, 28 Dec 2020 21:50:56 +0800
From:   Zheng Yongjun <zhengyongjun3@huawei.com>
To:     <mdf@kernel.org>, <linux-fpga@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <trix@redhat.com>, Zheng Yongjun <zhengyongjun3@huawei.com>
Subject: [PATCH -next] fpga: Use DEFINE_SPINLOCK() for spinlock
Date:   Mon, 28 Dec 2020 21:51:35 +0800
Message-ID: <20201228135135.28788-1-zhengyongjun3@huawei.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.138.68]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

spinlock can be initialized automatically with DEFINE_SPINLOCK()
rather than explicitly calling spin_lock_init().

Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
---
 drivers/fpga/fpga-bridge.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/fpga/fpga-bridge.c b/drivers/fpga/fpga-bridge.c
index 2deccacc3aa7..e9266b2a357f 100644
--- a/drivers/fpga/fpga-bridge.c
+++ b/drivers/fpga/fpga-bridge.c
@@ -17,7 +17,7 @@ static DEFINE_IDA(fpga_bridge_ida);
 static struct class *fpga_bridge_class;
 
 /* Lock for adding/removing bridges to linked lists*/
-static spinlock_t bridge_list_lock;
+static DEFINE_SPINLOCK(bridge_list_lock);
 
 /**
  * fpga_bridge_enable - Enable transactions on the bridge
@@ -479,8 +479,6 @@ static void fpga_bridge_dev_release(struct device *dev)
 
 static int __init fpga_bridge_dev_init(void)
 {
-	spin_lock_init(&bridge_list_lock);
-
 	fpga_bridge_class = class_create(THIS_MODULE, "fpga_bridge");
 	if (IS_ERR(fpga_bridge_class))
 		return PTR_ERR(fpga_bridge_class);
-- 
2.22.0

