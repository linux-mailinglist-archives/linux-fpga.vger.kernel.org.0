Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8280E2A3D64
	for <lists+linux-fpga@lfdr.de>; Tue,  3 Nov 2020 08:14:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727760AbgKCHOh (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 3 Nov 2020 02:14:37 -0500
Received: from mail-pg1-f177.google.com ([209.85.215.177]:40514 "EHLO
        mail-pg1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727529AbgKCHOh (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 3 Nov 2020 02:14:37 -0500
Received: by mail-pg1-f177.google.com with SMTP id x13so12960582pgp.7
        for <linux-fpga@vger.kernel.org>; Mon, 02 Nov 2020 23:14:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eHdU5oxW9fYEoWkH8yF79mOZPyoTqXNwEc+aAMEPYfM=;
        b=mxK7+daf0HGd825gB65hG5PxI5QVj6kd18obnNPqpV7jvGlVelz4eSF/Jxdkl6fJHg
         4l0FsT8hArYQA/jXeD9l5REfok2DG/GlR7BmklgGac3kz8kkpoB8z6s9m7WYoYZhaknv
         gc8/5t20rN8OKpw2zu58xnH5+F82PVcYWPnXP26670HCcnMQ1sbwgPEUzf3z3vxcRY2l
         2crnHlF9aaWJv2W+mffsAdo4IyJVq+Rxlii3gQaFW+aSvPst0RkJk3fVZQrM0llj1rnu
         IS3NUWmJfio1FKBYiHeIoihUV9mT1dLYNnGY//JL2siB1o1SbWwOwDFXCQ38Fmk1QRsg
         1bdA==
X-Gm-Message-State: AOAM5300+KF86MIQ6Mn8wH2S7qZIgln/kcVn+WX6Fzl52yp9SYVFlxxG
        gpNQ2NjXx6eobXLN95auDJH3HWPSP6g=
X-Google-Smtp-Source: ABdhPJwb7dpptOBSVF/bK+fYAVjOkr6Zynbu/kVPtngdaew2R8ObpKBBPWsnGsaSfkMDvwlQ7isgeA==
X-Received: by 2002:a63:4383:: with SMTP id q125mr16327992pga.30.1604387676300;
        Mon, 02 Nov 2020 23:14:36 -0800 (PST)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id e9sm5269333pgi.5.2020.11.02.23.14.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 23:14:35 -0800 (PST)
From:   Moritz Fischer <mdf@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-fpga@vger.kernel.org, Moritz Fischer <mdf@kernel.org>,
        Tom Rix <trix@redhat.com>
Subject: [PATCH 10/10] fpga: fpga-mgr: altera-pr-ip: Simplify registration
Date:   Mon,  2 Nov 2020 23:14:11 -0800
Message-Id: <20201103071411.11997-11-mdf@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201103071411.11997-1-mdf@kernel.org>
References: <20201103071411.11997-1-mdf@kernel.org>
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

