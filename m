Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 871572B38E0
	for <lists+linux-fpga@lfdr.de>; Sun, 15 Nov 2020 20:51:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727913AbgKOTvo (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 15 Nov 2020 14:51:44 -0500
Received: from mail-pf1-f176.google.com ([209.85.210.176]:38350 "EHLO
        mail-pf1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727899AbgKOTvo (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sun, 15 Nov 2020 14:51:44 -0500
Received: by mail-pf1-f176.google.com with SMTP id 10so11372509pfp.5;
        Sun, 15 Nov 2020 11:51:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eHdU5oxW9fYEoWkH8yF79mOZPyoTqXNwEc+aAMEPYfM=;
        b=l0lUcbtDvKVI+Vhf62WvTL5I778jNxXDeb27or4k5vs4eAFRDZBKfhwBgEyiGbC3Gh
         V4/SrzCpBUn8/iyW94YOb/5aufG1zQB9jFyk40YImF9pkfO/gGCpmlf9wIojU1Z8ZNQS
         8EPvkH/jV9rEha7GqO6h4zNy/uUdkAsgmdKFYmPWoxHbIu6VE2kOKTFuXPAbqlvlRrRN
         nLFqnUw/hcob3A+H8Xv1wHdi1c94mLm95xhBHu6fiJSS5eFxSx3M7Hexx9Xb7Qg85LDP
         k3Wfbzrb/fO2BUlX5eCMDRal/Bvg2DswLJbB9CrGn5zSZQeti8QALGAapBqcCTtfUXUR
         v+Rg==
X-Gm-Message-State: AOAM530SfpUs5Nk+BeCC7/uGFfLE6vEiKcyusZoQm5iYuaOyUZ/4W0u4
        4Nay6mWaH0AfJ6nInbIzvGk=
X-Google-Smtp-Source: ABdhPJxnNurbeDGCpGCPLiL/9ifN4GMgcB3yzHosfd3RB5CxhkxvOA4De9E8dWX6j0SUvkbyed1QVg==
X-Received: by 2002:a05:6a00:1693:b029:155:abe5:caa2 with SMTP id k19-20020a056a001693b0290155abe5caa2mr11025955pfc.39.1605469903175;
        Sun, 15 Nov 2020 11:51:43 -0800 (PST)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id e9sm14879167pgi.5.2020.11.15.11.51.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2020 11:51:42 -0800 (PST)
From:   Moritz Fischer <mdf@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        trix@redhat.com, Moritz Fischer <mdf@kernel.org>
Subject: [RESEND PATCH 10/10] fpga: fpga-mgr: altera-pr-ip: Simplify registration
Date:   Sun, 15 Nov 2020 11:51:27 -0800
Message-Id: <20201115195127.284487-11-mdf@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201115195127.284487-1-mdf@kernel.org>
References: <20201115195127.284487-1-mdf@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Simplify registration using new devm_fpga_mgr_register() API.

Reviewed-by: Tom Rix <trix@redhat.com>
Signed-off-by: Moritz Fischer <mdf@kernel.org>
---
 drivers/fpga/altera-pr-ip-core-plat.c | 10 ----------
 drivers/fpga/altera-pr-ip-core.c      |  4 +---
 2 files changed, 1 insertion(+), 13 deletions(-)

diff --git a/drivers/fpga/altera-pr-ip-core-plat.c b/drivers/fpga/altera-pr-ip-core-plat.c
index 99b9cc0e70f0..b008a6b8d2d3 100644
--- a/drivers/fpga/altera-pr-ip-core-plat.c
+++ b/drivers/fpga/altera-pr-ip-core-plat.c
@@ -28,15 +28,6 @@ static int alt_pr_platform_probe(struct platform_device *pdev)
 	return alt_pr_register(dev, reg_base);
 }
 
-static int alt_pr_platform_remove(struct platform_device *pdev)
-{
-	struct device *dev = &pdev->dev;
-
-	alt_pr_unregister(dev);
-
-	return 0;
-}
-
 static const struct of_device_id alt_pr_of_match[] = {
 	{ .compatible = "altr,a10-pr-ip", },
 	{},
@@ -46,7 +37,6 @@ MODULE_DEVICE_TABLE(of, alt_pr_of_match);
 
 static struct platform_driver alt_pr_platform_driver = {
 	.probe = alt_pr_platform_probe,
-	.remove = alt_pr_platform_remove,
 	.driver = {
 		.name	= "alt_a10_pr_ip",
 		.of_match_table = alt_pr_of_match,
diff --git a/drivers/fpga/altera-pr-ip-core.c b/drivers/fpga/altera-pr-ip-core.c
index 2cf25fd5e897..5b130c4d9882 100644
--- a/drivers/fpga/altera-pr-ip-core.c
+++ b/drivers/fpga/altera-pr-ip-core.c
@@ -195,9 +195,7 @@ int alt_pr_register(struct device *dev, void __iomem *reg_base)
 	if (!mgr)
 		return -ENOMEM;
 
-	dev_set_drvdata(dev, mgr);
-
-	return fpga_mgr_register(mgr);
+	return devm_fpga_mgr_register(dev, mgr);
 }
 EXPORT_SYMBOL_GPL(alt_pr_register);
 
-- 
2.29.2

