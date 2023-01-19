Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F47E67323E
	for <lists+linux-fpga@lfdr.de>; Thu, 19 Jan 2023 08:16:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbjASHOT (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 19 Jan 2023 02:14:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbjASHOR (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 19 Jan 2023 02:14:17 -0500
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7791604A0;
        Wed, 18 Jan 2023 23:14:14 -0800 (PST)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxct.zte.com.cn (FangMail) with ESMTPS id 4NyDQD5dC0z501Ss;
        Thu, 19 Jan 2023 15:14:12 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.99.176])
        by mse-fl2.zte.com.cn with SMTP id 30J7E58d018922;
        Thu, 19 Jan 2023 15:14:05 +0800 (+08)
        (envelope-from ye.xingchen@zte.com.cn)
Received: from mapi (xaxapp01[null])
        by mapi (Zmail) with MAPI id mid31;
        Thu, 19 Jan 2023 15:14:07 +0800 (CST)
Date:   Thu, 19 Jan 2023 15:14:07 +0800 (CST)
X-Zmail-TransId: 2af963c8edbfffffffffcfd598c6
X-Mailer: Zmail v1.0
Message-ID: <202301191514074846351@zte.com.cn>
Mime-Version: 1.0
From:   <ye.xingchen@zte.com.cn>
To:     <yilun.xu@intel.com>
Cc:     <mdf@kernel.org>, <hao.wu@intel.com>, <trix@redhat.com>,
        <michal.simek@xilinx.com>, <linux-fpga@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIIGxpbnV4LW5leHRdIGZwZ2E6IHhpbGlueC1wci1kZWNvdXBsZXI6IFVzZcKgZGV2bV9wbGF0Zm9ybV9nZXRfYW5kX2lvcmVtYXBfcmVzb3VyY2UoKQ==?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 30J7E58d018922
X-Fangmail-Gw-Spam-Type: 0
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 63C8EDC4.000/4NyDQD5dC0z501Ss
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        T_SPF_PERMERROR,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: ye xingchen <ye.xingchen@zte.com.cn>

Convert platform_get_resource(), devm_ioremap_resource() to a single
call to devm_platform_get_and_ioremap_resource(), as this is exactly
what this function does.

Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
---
 drivers/fpga/xilinx-pr-decoupler.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/fpga/xilinx-pr-decoupler.c b/drivers/fpga/xilinx-pr-decoupler.c
index 2d9c491f7be9..0039cf11ddd5 100644
--- a/drivers/fpga/xilinx-pr-decoupler.c
+++ b/drivers/fpga/xilinx-pr-decoupler.c
@@ -108,7 +108,6 @@ static int xlnx_pr_decoupler_probe(struct platform_device *pdev)
 	struct xlnx_pr_decoupler_data *priv;
 	struct fpga_bridge *br;
 	int err;
-	struct resource *res;

 	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
@@ -122,8 +121,7 @@ static int xlnx_pr_decoupler_probe(struct platform_device *pdev)
 			priv->ipconfig = match->data;
 	}

-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	priv->io_base = devm_ioremap_resource(&pdev->dev, res);
+	priv->io_base = devm_platform_get_and_ioremap_resource(pdev, 0, NULL);
 	if (IS_ERR(priv->io_base))
 		return PTR_ERR(priv->io_base);

-- 
2.25.1
