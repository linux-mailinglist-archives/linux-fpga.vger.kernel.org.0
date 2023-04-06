Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F49F6D8D85
	for <lists+linux-fpga@lfdr.de>; Thu,  6 Apr 2023 04:36:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234567AbjDFCez (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 5 Apr 2023 22:34:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233927AbjDFCep (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 5 Apr 2023 22:34:45 -0400
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10F445FDB;
        Wed,  5 Apr 2023 19:34:42 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VfR2SYv_1680748479;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0VfR2SYv_1680748479)
          by smtp.aliyun-inc.com;
          Thu, 06 Apr 2023 10:34:40 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     mdf@kernel.org
Cc:     hao.wu@intel.com, yilun.xu@intel.com, trix@redhat.com,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH -next 4/6] fpga: dfl: Use devm_platform_ioremap_resource()
Date:   Thu,  6 Apr 2023 10:34:30 +0800
Message-Id: <20230406023432.124792-4-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
In-Reply-To: <20230406023432.124792-1-yang.lee@linux.alibaba.com>
References: <20230406023432.124792-1-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.0 required=5.0 tests=ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Convert platform_get_resource(), devm_ioremap_resource() to a single
call to devm_platform_ioremap_resource(), as this is exactly what this
function does.

Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/fpga/dfl-fme-mgr.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/fpga/dfl-fme-mgr.c b/drivers/fpga/dfl-fme-mgr.c
index af0785783b52..ab228d8837a0 100644
--- a/drivers/fpga/dfl-fme-mgr.c
+++ b/drivers/fpga/dfl-fme-mgr.c
@@ -280,7 +280,6 @@ static int fme_mgr_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct fme_mgr_priv *priv;
 	struct fpga_manager *mgr;
-	struct resource *res;
 
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
@@ -290,8 +289,7 @@ static int fme_mgr_probe(struct platform_device *pdev)
 		priv->ioaddr = pdata->ioaddr;
 
 	if (!priv->ioaddr) {
-		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-		priv->ioaddr = devm_ioremap_resource(dev, res);
+		priv->ioaddr = devm_platform_ioremap_resource(pdev, 0);
 		if (IS_ERR(priv->ioaddr))
 			return PTR_ERR(priv->ioaddr);
 	}
-- 
2.20.1.7.g153144c

