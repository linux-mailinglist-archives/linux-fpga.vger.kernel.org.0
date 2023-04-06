Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 904C96D8D82
	for <lists+linux-fpga@lfdr.de>; Thu,  6 Apr 2023 04:36:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233726AbjDFCey (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 5 Apr 2023 22:34:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231406AbjDFCen (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 5 Apr 2023 22:34:43 -0400
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C53A5FC3;
        Wed,  5 Apr 2023 19:34:38 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VfR1.hw_1680748475;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0VfR1.hw_1680748475)
          by smtp.aliyun-inc.com;
          Thu, 06 Apr 2023 10:34:36 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     mdf@kernel.org
Cc:     hao.wu@intel.com, yilun.xu@intel.com, trix@redhat.com,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH -next 2/6] fpga: manager: Use devm_platform_ioremap_resource()
Date:   Thu,  6 Apr 2023 10:34:28 +0800
Message-Id: <20230406023432.124792-2-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
In-Reply-To: <20230406023432.124792-1-yang.lee@linux.alibaba.com>
References: <20230406023432.124792-1-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.0 required=5.0 tests=ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
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
 drivers/fpga/socfpga.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/fpga/socfpga.c b/drivers/fpga/socfpga.c
index 7e0741f99696..723ea0ad3f09 100644
--- a/drivers/fpga/socfpga.c
+++ b/drivers/fpga/socfpga.c
@@ -545,20 +545,17 @@ static int socfpga_fpga_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct socfpga_fpga_priv *priv;
 	struct fpga_manager *mgr;
-	struct resource *res;
 	int ret;
 
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	priv->fpga_base_addr = devm_ioremap_resource(dev, res);
+	priv->fpga_base_addr = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(priv->fpga_base_addr))
 		return PTR_ERR(priv->fpga_base_addr);
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
-	priv->fpga_data_addr = devm_ioremap_resource(dev, res);
+	priv->fpga_data_addr = devm_platform_ioremap_resource(pdev, 1);
 	if (IS_ERR(priv->fpga_data_addr))
 		return PTR_ERR(priv->fpga_data_addr);
 
-- 
2.20.1.7.g153144c

