Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57C832D62BF
	for <lists+linux-fpga@lfdr.de>; Thu, 10 Dec 2020 17:59:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388961AbgLJQ7K (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 10 Dec 2020 11:59:10 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45516 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392155AbgLJQ66 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 10 Dec 2020 11:58:58 -0500
Received: by mail-pf1-f196.google.com with SMTP id q22so4644830pfk.12
        for <linux-fpga@vger.kernel.org>; Thu, 10 Dec 2020 08:58:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R5s8bOluMHY3VNyIJi/uGnyyvKSEAGl02n+N99993IY=;
        b=GcUodZJautuencAkDtWdpp0AOKlDtllSvDHNuRHOwHiNRegM0RzCCCT9qSab/J9B5t
         5Ae51xRMgXgbhLfyetiV5Gt3AsUEug75qqgYr1Sx0ZKFIrQW7WSwzpUReSwfw6yiJ4e9
         gs5F32YBQB9wMsXIAmTom7TN7JKhy+n5PsxF8jJ7mBqjvxxOE5SPRnotmvXKjh5vIDY0
         rXzNdEaro/B/xL+Vi0L9TYEU5O92RhEZ8I1s78f8B3pzBwMbN/Cwd96mezVXuUMZJclM
         QRpLjPUe5kvw1RUQ4zTMsW85aiRPOq3uj3p5VmIeZBxAifjg9s7KqcjP684h+0/F9gPS
         aV9A==
X-Gm-Message-State: AOAM533ILHVWOm8sEUGypdDioDgniDyOYNoJhQSJze+xLfi0ciBAzSnQ
        ZUecfvK7jFTmFunHMUi8GRI=
X-Google-Smtp-Source: ABdhPJzeGypVKgKVf6WqoLaU23TbWgO3rSj4Zt4whhZ3m/gLUQjkeboCUrGzIW2xPEJ6+fGQg+yKbQ==
X-Received: by 2002:a17:90a:db49:: with SMTP id u9mr8481783pjx.0.1607619497626;
        Thu, 10 Dec 2020 08:58:17 -0800 (PST)
Received: from localhost ([2601:647:5b00:1162:1ac0:17a6:4cc6:d1ef])
        by smtp.gmail.com with ESMTPSA id x10sm7036879pfc.179.2020.12.10.08.58.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Dec 2020 08:58:16 -0800 (PST)
From:   Moritz Fischer <mdf@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-fpga@vger.kernel.org, trix@redhat.com, hao.wu@intel.com,
        yilun.xu@intel.com, russell.h.weight@intel.com,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        Moritz Fischer <mdf@kernel.org>
Subject: [PATCH 1/8] fpga: dfl: refactor cci_enumerate_feature_devs()
Date:   Thu, 10 Dec 2020 08:57:57 -0800
Message-Id: <20201210165804.44234-2-mdf@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201210165804.44234-1-mdf@kernel.org>
References: <20201210165804.44234-1-mdf@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Matthew Gerlach <matthew.gerlach@linux.intel.com>

In preparation of looking for dfls based on a vendor specific pci
capability, move the code for the default method of finding the first
dfl at offset 0 of Bar 0 to its own function.

Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
Acked-by: Wu Hao <hao.wu@intel.com>
Signed-off-by: Moritz Fischer <mdf@kernel.org>
---
 drivers/fpga/dfl-pci.c | 84 +++++++++++++++++++++++-------------------
 1 file changed, 47 insertions(+), 37 deletions(-)

diff --git a/drivers/fpga/dfl-pci.c b/drivers/fpga/dfl-pci.c
index a2203d03c9e2..5100695e27cd 100644
--- a/drivers/fpga/dfl-pci.c
+++ b/drivers/fpga/dfl-pci.c
@@ -119,49 +119,20 @@ static int *cci_pci_create_irq_table(struct pci_dev *pcidev, unsigned int nvec)
 	return table;
 }
 
-/* enumerate feature devices under pci device */
-static int cci_enumerate_feature_devs(struct pci_dev *pcidev)
+/* default method of finding dfls starting at offset 0 of bar 0 */
+static int find_dfls_by_default(struct pci_dev *pcidev,
+				struct dfl_fpga_enum_info *info)
 {
-	struct cci_drvdata *drvdata = pci_get_drvdata(pcidev);
-	int port_num, bar, i, nvec, ret = 0;
-	struct dfl_fpga_enum_info *info;
-	struct dfl_fpga_cdev *cdev;
+	int port_num, bar, i, ret = 0;
 	resource_size_t start, len;
 	void __iomem *base;
-	int *irq_table;
 	u32 offset;
 	u64 v;
 
-	/* allocate enumeration info via pci_dev */
-	info = dfl_fpga_enum_info_alloc(&pcidev->dev);
-	if (!info)
-		return -ENOMEM;
-
-	/* add irq info for enumeration if the device support irq */
-	nvec = cci_pci_alloc_irq(pcidev);
-	if (nvec < 0) {
-		dev_err(&pcidev->dev, "Fail to alloc irq %d.\n", nvec);
-		ret = nvec;
-		goto enum_info_free_exit;
-	} else if (nvec) {
-		irq_table = cci_pci_create_irq_table(pcidev, nvec);
-		if (!irq_table) {
-			ret = -ENOMEM;
-			goto irq_free_exit;
-		}
-
-		ret = dfl_fpga_enum_info_add_irq(info, nvec, irq_table);
-		kfree(irq_table);
-		if (ret)
-			goto irq_free_exit;
-	}
-
-	/* start to find Device Feature List in Bar 0 */
+	/* start to find Device Feature List from Bar 0 */
 	base = cci_pci_ioremap_bar0(pcidev);
-	if (!base) {
-		ret = -ENOMEM;
-		goto irq_free_exit;
-	}
+	if (!base)
+		return -ENOMEM;
 
 	/*
 	 * PF device has FME and Ports/AFUs, and VF device only has one
@@ -208,12 +179,51 @@ static int cci_enumerate_feature_devs(struct pci_dev *pcidev)
 		dfl_fpga_enum_info_add_dfl(info, start, len);
 	} else {
 		ret = -ENODEV;
-		goto irq_free_exit;
 	}
 
 	/* release I/O mappings for next step enumeration */
 	pcim_iounmap_regions(pcidev, BIT(0));
 
+	return ret;
+}
+
+/* enumerate feature devices under pci device */
+static int cci_enumerate_feature_devs(struct pci_dev *pcidev)
+{
+	struct cci_drvdata *drvdata = pci_get_drvdata(pcidev);
+	struct dfl_fpga_enum_info *info;
+	struct dfl_fpga_cdev *cdev;
+	int nvec, ret = 0;
+	int *irq_table;
+
+	/* allocate enumeration info via pci_dev */
+	info = dfl_fpga_enum_info_alloc(&pcidev->dev);
+	if (!info)
+		return -ENOMEM;
+
+	/* add irq info for enumeration if the device support irq */
+	nvec = cci_pci_alloc_irq(pcidev);
+	if (nvec < 0) {
+		dev_err(&pcidev->dev, "Fail to alloc irq %d.\n", nvec);
+		ret = nvec;
+		goto enum_info_free_exit;
+	} else if (nvec) {
+		irq_table = cci_pci_create_irq_table(pcidev, nvec);
+		if (!irq_table) {
+			ret = -ENOMEM;
+			goto irq_free_exit;
+		}
+
+		ret = dfl_fpga_enum_info_add_irq(info, nvec, irq_table);
+		kfree(irq_table);
+		if (ret)
+			goto irq_free_exit;
+	}
+
+	ret = find_dfls_by_default(pcidev, info);
+	if (ret)
+		goto irq_free_exit;
+
 	/* start enumeration with prepared enumeration information */
 	cdev = dfl_fpga_feature_devs_enumerate(info);
 	if (IS_ERR(cdev)) {
-- 
2.29.2

