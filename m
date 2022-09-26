Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69EE25EA980
	for <lists+linux-fpga@lfdr.de>; Mon, 26 Sep 2022 17:04:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235301AbiIZPCn (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 26 Sep 2022 11:02:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235284AbiIZPCI (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 26 Sep 2022 11:02:08 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FB7031218
        for <linux-fpga@vger.kernel.org>; Mon, 26 Sep 2022 06:33:02 -0700 (PDT)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Mbk9V6XHszlXCH;
        Mon, 26 Sep 2022 21:28:46 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 26 Sep 2022 21:33:00 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 26 Sep
 2022 21:33:00 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-fpga@vger.kernel.org>
CC:     <mdf@kernel.org>, <hao.wu@intel.com>, <yilun.xu@intel.com>
Subject: [PATCH -next] fpga: zynq: Switch to use dev_err_probe() helper
Date:   Mon, 26 Sep 2022 21:39:50 +0800
Message-ID: <20220926133950.1372089-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

In the probe path, dev_err() can be replaced with dev_err_probe()
which will check if error code is -EPROBE_DEFER and prints the
error name. It also sets the defer probe reason which can be
checked later through debugfs. It's more simple in error path.
---
 drivers/fpga/zynq-fpga.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/fpga/zynq-fpga.c b/drivers/fpga/zynq-fpga.c
index 426aa34c6a0d..ae0da361e6c6 100644
--- a/drivers/fpga/zynq-fpga.c
+++ b/drivers/fpga/zynq-fpga.c
@@ -582,11 +582,9 @@ static int zynq_fpga_probe(struct platform_device *pdev)
 		return priv->irq;
 
 	priv->clk = devm_clk_get(dev, "ref_clk");
-	if (IS_ERR(priv->clk)) {
-		if (PTR_ERR(priv->clk) != -EPROBE_DEFER)
-			dev_err(dev, "input clock not found\n");
-		return PTR_ERR(priv->clk);
-	}
+	if (IS_ERR(priv->clk))
+		return dev_err_probe(dev, PTR_ERR(priv->clk),
+				     "input clock not found\n");
 
 	err = clk_prepare_enable(priv->clk);
 	if (err) {
-- 
2.25.1

