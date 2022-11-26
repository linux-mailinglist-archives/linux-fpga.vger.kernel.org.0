Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2B3F639429
	for <lists+linux-fpga@lfdr.de>; Sat, 26 Nov 2022 08:18:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbiKZHQl (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sat, 26 Nov 2022 02:16:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiKZHQl (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sat, 26 Nov 2022 02:16:41 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 226D327DDE;
        Fri, 25 Nov 2022 23:16:39 -0800 (PST)
Received: from kwepemi500013.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NK31F5gZSzRpTw;
        Sat, 26 Nov 2022 15:16:01 +0800 (CST)
Received: from huawei.com (10.175.112.208) by kwepemi500013.china.huawei.com
 (7.221.188.120) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Sat, 26 Nov
 2022 15:16:35 +0800
From:   Zheng Yongjun <zhengyongjun3@huawei.com>
To:     <mdf@kernel.org>, <hao.wu@intel.com>, <yilun.xu@intel.com>,
        <linux-fpga@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <trix@redhat.com>
Subject: [PATCH] fpga: stratix10-soc: Fix return value check in s10_ops_write_init()
Date:   Sat, 26 Nov 2022 07:14:30 +0000
Message-ID: <20221126071430.19540-1-zhengyongjun3@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.208]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemi500013.china.huawei.com (7.221.188.120)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

In case of error, the function stratix10_svc_allocate_memory()
returns ERR_PTR() and never returns NULL. The NULL test in the
return value check should be replaced with IS_ERR().

Fixes: e7eef1d7633a ("fpga: add intel stratix10 soc fpga manager driver")
Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
---
 drivers/fpga/stratix10-soc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/fpga/stratix10-soc.c b/drivers/fpga/stratix10-soc.c
index 357cea58ec98..f7f01982a512 100644
--- a/drivers/fpga/stratix10-soc.c
+++ b/drivers/fpga/stratix10-soc.c
@@ -213,9 +213,9 @@ static int s10_ops_write_init(struct fpga_manager *mgr,
 	/* Allocate buffers from the service layer's pool. */
 	for (i = 0; i < NUM_SVC_BUFS; i++) {
 		kbuf = stratix10_svc_allocate_memory(priv->chan, SVC_BUF_SIZE);
-		if (!kbuf) {
+		if (IS_ERR(kbuf)) {
 			s10_free_buffers(mgr);
-			ret = -ENOMEM;
+			ret = PTR_ERR(kbuf);
 			goto init_done;
 		}

--
2.17.1

