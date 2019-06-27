Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D667B5785A
	for <lists+linux-fpga@lfdr.de>; Thu, 27 Jun 2019 02:53:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727101AbfF0Awc (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 26 Jun 2019 20:52:32 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34026 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727756AbfF0Ad0 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 26 Jun 2019 20:33:26 -0400
Received: by mail-pf1-f196.google.com with SMTP id c85so301119pfc.1
        for <linux-fpga@vger.kernel.org>; Wed, 26 Jun 2019 17:33:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=t9hxeAIft4GeNwQ57ELlp04njjQpHvGUsvcIVUcZqi8=;
        b=WDEoJVBpIZLOEBjtcYD5iI5fXZC7wGiCUGH3DtflaJHj/io0Yr9h/+6Vo1U1toSarY
         2qTUwH56fU0x7jUSjTFqI9CH+DWOe9K16NmhIfzn+tEExgai8KofiHqN0HIWBlz3m+hb
         DRZ0x/aSKrvSMYonZC9qOoqiw3QiO2gvgPg0Lkys0K7aJZUHH+A9IlZUZj8xJfkVhTzB
         GIwH5x7sZbm6JvLrjHPTJvFcjeFOr1N+9oiFcmJmUG/h3W4zySMCfndWxR/0/ce19wHI
         pOpsEvfMaW1DGaiCndf55Dgjr4FejWUAOznAlSfxTNLvWw0OGIwn8s2yX/EIga0EpYqS
         x8FQ==
X-Gm-Message-State: APjAAAV3pgXKs2vFwuS0vJ7okTd0sU0x0lkE0ZAuw6ijN+SGsRcGlBYX
        CTVys6fedAsP2+pVPFAI2rxsgGch7Uk=
X-Google-Smtp-Source: APXvYqyJdg+XYYqogXxOt1f02dDkA791aTYlXwUKt6UHjg7m8a7h7JYXsynZP+RfY/UNAw6eAvDnqQ==
X-Received: by 2002:a17:90a:17c4:: with SMTP id q62mr2403128pja.104.1561595605450;
        Wed, 26 Jun 2019 17:33:25 -0700 (PDT)
Received: from localhost (c-76-21-109-208.hsd1.ca.comcast.net. [76.21.109.208])
        by smtp.gmail.com with ESMTPSA id f64sm430219pfa.115.2019.06.26.17.33.24
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 26 Jun 2019 17:33:24 -0700 (PDT)
From:   Moritz Fischer <mdf@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-fpga@vger.kernel.org, Moritz Fischer <mdf@kernel.org>
Subject: [PATCH] fpga: altera-pr-ip: Make alt_pr_unregister function void
Date:   Wed, 26 Jun 2019 17:33:09 -0700
Message-Id: <20190627003309.27595-1-mdf@kernel.org>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Make alt_pr_unregister function void, since it always returns 0,
and nothing would act on the value anyways.

Signed-off-by: Moritz Fischer <mdf@kernel.org>
---
 drivers/fpga/altera-pr-ip-core-plat.c  | 4 +++-
 drivers/fpga/altera-pr-ip-core.c       | 4 +---
 include/linux/fpga/altera-pr-ip-core.h | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/fpga/altera-pr-ip-core-plat.c b/drivers/fpga/altera-pr-ip-core-plat.c
index b293d83143f1..99b9cc0e70f0 100644
--- a/drivers/fpga/altera-pr-ip-core-plat.c
+++ b/drivers/fpga/altera-pr-ip-core-plat.c
@@ -32,7 +32,9 @@ static int alt_pr_platform_remove(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 
-	return alt_pr_unregister(dev);
+	alt_pr_unregister(dev);
+
+	return 0;
 }
 
 static const struct of_device_id alt_pr_of_match[] = {
diff --git a/drivers/fpga/altera-pr-ip-core.c b/drivers/fpga/altera-pr-ip-core.c
index a7a3bf0b5202..2cf25fd5e897 100644
--- a/drivers/fpga/altera-pr-ip-core.c
+++ b/drivers/fpga/altera-pr-ip-core.c
@@ -201,15 +201,13 @@ int alt_pr_register(struct device *dev, void __iomem *reg_base)
 }
 EXPORT_SYMBOL_GPL(alt_pr_register);
 
-int alt_pr_unregister(struct device *dev)
+void alt_pr_unregister(struct device *dev)
 {
 	struct fpga_manager *mgr = dev_get_drvdata(dev);
 
 	dev_dbg(dev, "%s\n", __func__);
 
 	fpga_mgr_unregister(mgr);
-
-	return 0;
 }
 EXPORT_SYMBOL_GPL(alt_pr_unregister);
 
diff --git a/include/linux/fpga/altera-pr-ip-core.h b/include/linux/fpga/altera-pr-ip-core.h
index 7d4664730d60..0b08ac20ab16 100644
--- a/include/linux/fpga/altera-pr-ip-core.h
+++ b/include/linux/fpga/altera-pr-ip-core.h
@@ -13,6 +13,6 @@
 #include <linux/io.h>
 
 int alt_pr_register(struct device *dev, void __iomem *reg_base);
-int alt_pr_unregister(struct device *dev);
+void alt_pr_unregister(struct device *dev);
 
 #endif /* _ALT_PR_IP_CORE_H */
-- 
2.22.0

