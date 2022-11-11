Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 616896253F7
	for <lists+linux-fpga@lfdr.de>; Fri, 11 Nov 2022 07:43:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232905AbiKKGlg (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 11 Nov 2022 01:41:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231300AbiKKGlf (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 11 Nov 2022 01:41:35 -0500
Received: from mxct.zte.com.cn (mxct.zte.com.cn [58.251.27.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F28F2CDF1
        for <linux-fpga@vger.kernel.org>; Thu, 10 Nov 2022 22:41:34 -0800 (PST)
Received: from mxde.zte.com.cn (unknown [10.35.20.165])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mxct.zte.com.cn (FangMail) with ESMTPS id 4N7pyN4FrLz1Dwb
        for <linux-fpga@vger.kernel.org>; Fri, 11 Nov 2022 14:41:32 +0800 (CST)
Received: from mxus.zte.com.cn (unknown [10.207.168.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mxde.zte.com.cn (FangMail) with ESMTPS id 4N7pyK0YFqz5TCG0
        for <linux-fpga@vger.kernel.org>; Fri, 11 Nov 2022 14:41:29 +0800 (CST)
Received: from mxhk.zte.com.cn (unknown [192.168.250.137])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mxus.zte.com.cn (FangMail) with ESMTPS id 4N7pyF3kGPzdmYkl;
        Fri, 11 Nov 2022 14:41:25 +0800 (CST)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4N7pyB1Tlwz8RV7R;
        Fri, 11 Nov 2022 14:41:22 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.40.50])
        by mse-fl1.zte.com.cn with SMTP id 2AB6fERK074210;
        Fri, 11 Nov 2022 14:41:14 +0800 (+08)
        (envelope-from ye.xingchen@zte.com.cn)
Received: from mapi (xaxapp02[null])
        by mapi (Zmail) with MAPI id mid31;
        Fri, 11 Nov 2022 14:41:16 +0800 (CST)
Date:   Fri, 11 Nov 2022 14:41:16 +0800 (CST)
X-Zmail-TransId: 2afa636dee8c66289f39
X-Mailer: Zmail v1.0
Message-ID: <202211111441162412524@zte.com.cn>
Mime-Version: 1.0
From:   <ye.xingchen@zte.com.cn>
To:     <mdf@kernel.org>
Cc:     <hao.wu@intel.com>, <yilun.xu@intel.com>, <trix@redhat.com>,
        <linux-fpga@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <chi.minghao@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIXSBmcGdhLW1hbmFnZXI6IHVzZSBkZXZtX3BsYXRmb3JtX2dldF9hbmRfaW9yZW1hcF9yZXNvdXJjZSgp?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl1.zte.com.cn 2AB6fERK074210
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.251.14.novalocal with ID 636DEE9B.000 by FangMail milter!
X-FangMail-Envelope: 1668148892/4N7pyN4FrLz1Dwb/636DEE9B.000/10.35.20.165/[10.35.20.165]/mxde.zte.com.cn/<ye.xingchen@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 636DEE9B.000/4N7pyN4FrLz1Dwb
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Minghao Chi <chi.minghao@zte.com.cn>

Convert platform_get_resource(), devm_ioremap_resource() to a single
call to devm_platform_get_and_ioremap_resource(), as this is exactly
what this function does.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
---
 drivers/fpga/socfpga-a10.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/fpga/socfpga-a10.c b/drivers/fpga/socfpga-a10.c
index ac8e89b8a5cc..dde2cb49e95d 100644
--- a/drivers/fpga/socfpga-a10.c
+++ b/drivers/fpga/socfpga-a10.c
@@ -479,8 +479,7 @@ static int socfpga_a10_fpga_probe(struct platform_device *pdev)
 		return -ENOMEM;

 	/* First mmio base is for register access */
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	reg_base = devm_ioremap_resource(dev, res);
+	reg_base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
 	if (IS_ERR(reg_base))
 		return PTR_ERR(reg_base);

-- 
2.25.1
