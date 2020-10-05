Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 171D3283D84
	for <lists+linux-fpga@lfdr.de>; Mon,  5 Oct 2020 19:38:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729086AbgJERiC (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 5 Oct 2020 13:38:02 -0400
Received: from mail-pg1-f173.google.com ([209.85.215.173]:39616 "EHLO
        mail-pg1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729096AbgJERh4 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 5 Oct 2020 13:37:56 -0400
Received: by mail-pg1-f173.google.com with SMTP id 22so2502098pgv.6;
        Mon, 05 Oct 2020 10:37:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XAgCk2Aj0EBQWC6lNsaJJy1FnlIlYx98oy4GqXugUsw=;
        b=K2dYj9yPB2Lvy70bUXKU6yGD0epYlSHBOfQtFo/Q+A8zfQWkh15WS+1eKsAwYtz7v8
         B8f5I4DJ0nIMrhBSfU1eOmIxOJxi/taXbv+iTJJkyLtQa/sdI2Fylq2mMxr1RERT6rep
         Tc9WCtoVIkBYudM/al5GGQGMyXjZDiPru9pCC31O9YbFVyOy7hNdV5+T2jocGdZldNVg
         8Q7xD/a9rwbUpNeLYl4wJyUllZx8/+6hex8r0Sykbpmn2JUElrZ6HKGEm7Na32ab0GXs
         IPeXsRKttLdKWK3uMqWEzZhrjA3ua/JjckpCNxtWogxdG16CijL3B23tIFvpRUXsihat
         HxtQ==
X-Gm-Message-State: AOAM532fyXrNXlIzYN0ovjYv/i2xYolZuWjGYN5TZbrvjocvO1Jc2/Bq
        v4ltkQdNVrh4g2j9WyxF0W+fuuucBRg=
X-Google-Smtp-Source: ABdhPJxvtbZsSqdj/IUfV+3xbG3z2hIR80XDqUCVjJ3wv+aLSOJddZ6DzLcotBHctSXzK3cQ46qH7g==
X-Received: by 2002:a63:8f18:: with SMTP id n24mr540732pgd.209.1601919476076;
        Mon, 05 Oct 2020 10:37:56 -0700 (PDT)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id e1sm534796pfd.198.2020.10.05.10.37.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2020 10:37:55 -0700 (PDT)
From:   Moritz Fischer <mdf@kernel.org>
To:     linux-fpga@vger.kernel.org
Cc:     trix@redhat.com, hao.wu@intel.com, michal.simek@xilinx.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        russell.h.weight@intel.com, matthew.gerlach@intel.com,
        Moritz Fischer <mdf@kernel.org>
Subject: [PATCH v2 10/10] fpga: fpga-mgr: altera-pr-ip: Simplify registration
Date:   Mon,  5 Oct 2020 10:37:35 -0700
Message-Id: <20201005173735.162408-11-mdf@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201005173735.162408-1-mdf@kernel.org>
References: <20201005173735.162408-1-mdf@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Simplify registration using new devm_fpga_mgr_register() API.

Signed-off-by: Moritz Fischer <mdf@kernel.org>
---

Changes from v1:
- Removed part that removes unused symbol

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
2.28.0

