Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E969AE71A
	for <lists+linux-fpga@lfdr.de>; Tue, 10 Sep 2019 11:37:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727838AbfIJJg7 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 10 Sep 2019 05:36:59 -0400
Received: from cmccmta2.chinamobile.com ([221.176.66.80]:2980 "EHLO
        cmccmta2.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727265AbfIJJg7 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 10 Sep 2019 05:36:59 -0400
X-Greylist: delayed 573 seconds by postgrey-1.27 at vger.kernel.org; Tue, 10 Sep 2019 05:36:58 EDT
Received: from spf.mail.chinamobile.com (unknown[172.16.121.13]) by rmmx-syy-dmz-app05-12005 (RichMail) with SMTP id 2ee55d776c71e10-df552; Tue, 10 Sep 2019 17:27:13 +0800 (CST)
X-RM-TRANSID: 2ee55d776c71e10-df552
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[223.105.0.243])
        by rmsmtp-syy-appsvr07-12007 (RichMail) with SMTP id 2ee75d776c6ed83-6fa8a;
        Tue, 10 Sep 2019 17:27:13 +0800 (CST)
X-RM-TRANSID: 2ee75d776c6ed83-6fa8a
From:   Ding Xiang <dingxiang@cmss.chinamobile.com>
To:     mdf@kernel.org, linux-fpga@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] fpga: remove redundant dev_err message
Date:   Tue, 10 Sep 2019 17:26:56 +0800
Message-Id: <1568107616-12755-1-git-send-email-dingxiang@cmss.chinamobile.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

devm_ioremap_resource already contains error message, so remove
the redundant dev_err message

Signed-off-by: Ding Xiang <dingxiang@cmss.chinamobile.com>
---
 drivers/fpga/ts73xx-fpga.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/fpga/ts73xx-fpga.c b/drivers/fpga/ts73xx-fpga.c
index 9a17fe9..2888ff0 100644
--- a/drivers/fpga/ts73xx-fpga.c
+++ b/drivers/fpga/ts73xx-fpga.c
@@ -119,10 +119,8 @@ static int ts73xx_fpga_probe(struct platform_device *pdev)
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	priv->io_base = devm_ioremap_resource(kdev, res);
-	if (IS_ERR(priv->io_base)) {
-		dev_err(kdev, "unable to remap registers\n");
+	if (IS_ERR(priv->io_base))
 		return PTR_ERR(priv->io_base);
-	}
 
 	mgr = devm_fpga_mgr_create(kdev, "TS-73xx FPGA Manager",
 				   &ts73xx_fpga_ops, priv);
-- 
1.9.1



