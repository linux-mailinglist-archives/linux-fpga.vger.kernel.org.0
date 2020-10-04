Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1743282907
	for <lists+linux-fpga@lfdr.de>; Sun,  4 Oct 2020 07:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725849AbgJDFPH (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 4 Oct 2020 01:15:07 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33144 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725857AbgJDFPA (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sun, 4 Oct 2020 01:15:00 -0400
Received: by mail-pg1-f194.google.com with SMTP id o25so3629311pgm.0;
        Sat, 03 Oct 2020 22:15:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KEIkOfJmCkr+mhT8bgXa4RUyoZrWLuARarkprMlR8hc=;
        b=OzyP89KzGNiBMLR3F+3dCT7FyS+OwNtCiVu+9jMaLZg5yUROePP+fc/2nR6SlFwQ5n
         b6XtfjpFv55EGkWdMN3EA5JPN23zHZIiZ7as5ZUjrPf7UYRcwVMJv0FR6X+CTuarRVbd
         IbUQuXUFgV1/dNnc/16PSanT0hlcBFwoiviOjaTsOzqw2iS3OxNVYhOyUsOuDRLoGhZQ
         gUCxZ5Ntv8qcfdfs3h1ilGcnVVn1rvdEZST0npugvcp/sFrejV8BmGy4/Ee6rWtQHD94
         ad/OpS9UJQ7IHtat1E6Fga82w4PzBAqqyXsCCLCUA0T+4Kpkeh6AbOyiLc5DXLAe2D8T
         ZRYw==
X-Gm-Message-State: AOAM532gSo/BM8ViewjwC210iDSy5TFrjVKArJ1ToQkUoVDNsSQgn8aw
        jYbF3m7Y9SOJhNJdeZwmuvdOUdK8KPs=
X-Google-Smtp-Source: ABdhPJxBFvc18Vo2CntFUWWe0qTHBP6EsWSvDe3RC70HKzn/p+q5e49ivi4n+Rtv76OD8E2enCUyiQ==
X-Received: by 2002:a62:2581:0:b029:13f:ba38:b113 with SMTP id l123-20020a6225810000b029013fba38b113mr10296040pfl.15.1601788499350;
        Sat, 03 Oct 2020 22:14:59 -0700 (PDT)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id q15sm6177964pjp.26.2020.10.03.22.14.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Oct 2020 22:14:58 -0700 (PDT)
From:   Moritz Fischer <mdf@kernel.org>
To:     linux-fpga@vger.kernel.org
Cc:     trix@redhat.com, hao.wu@intel.com, michal.simek@xilinx.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        russell.h.weight@intel.com, matthew.gerlach@intel.com,
        Moritz Fischer <mdf@kernel.org>
Subject: [PATCH 10/10] fpga: fpga-mgr: altera-pr-ip: Simplify registration
Date:   Sat,  3 Oct 2020 22:14:23 -0700
Message-Id: <20201004051423.75879-11-mdf@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201004051423.75879-1-mdf@kernel.org>
References: <20201004051423.75879-1-mdf@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Simplify registration using new devm_fpga_mgr_register() API.
Remove the now obsolete altera_pr_unregister() function.

Signed-off-by: Moritz Fischer <mdf@kernel.org>
---

We should take another look at this, IIRC correctly the point of
splitting this up into a separate driver was to make it useable by a
different (pci?) driver later on.

It doesn't seem like this happened, and I think we should just make this
a platform driver?

---
 drivers/fpga/altera-pr-ip-core-plat.c  | 10 ----------
 drivers/fpga/altera-pr-ip-core.c       | 14 +-------------
 include/linux/fpga/altera-pr-ip-core.h |  1 -
 3 files changed, 1 insertion(+), 24 deletions(-)

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
index 2cf25fd5e897..dfdf21ed34c4 100644
--- a/drivers/fpga/altera-pr-ip-core.c
+++ b/drivers/fpga/altera-pr-ip-core.c
@@ -195,22 +195,10 @@ int alt_pr_register(struct device *dev, void __iomem *reg_base)
 	if (!mgr)
 		return -ENOMEM;
 
-	dev_set_drvdata(dev, mgr);
-
-	return fpga_mgr_register(mgr);
+	return devm_fpga_mgr_register(dev, mgr);
 }
 EXPORT_SYMBOL_GPL(alt_pr_register);
 
-void alt_pr_unregister(struct device *dev)
-{
-	struct fpga_manager *mgr = dev_get_drvdata(dev);
-
-	dev_dbg(dev, "%s\n", __func__);
-
-	fpga_mgr_unregister(mgr);
-}
-EXPORT_SYMBOL_GPL(alt_pr_unregister);
-
 MODULE_AUTHOR("Matthew Gerlach <matthew.gerlach@linux.intel.com>");
 MODULE_DESCRIPTION("Altera Partial Reconfiguration IP Core");
 MODULE_LICENSE("GPL v2");
diff --git a/include/linux/fpga/altera-pr-ip-core.h b/include/linux/fpga/altera-pr-ip-core.h
index 0b08ac20ab16..a6b4c07858cc 100644
--- a/include/linux/fpga/altera-pr-ip-core.h
+++ b/include/linux/fpga/altera-pr-ip-core.h
@@ -13,6 +13,5 @@
 #include <linux/io.h>
 
 int alt_pr_register(struct device *dev, void __iomem *reg_base);
-void alt_pr_unregister(struct device *dev);
 
 #endif /* _ALT_PR_IP_CORE_H */
-- 
2.28.0

