Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03C0E2EC966
	for <lists+linux-fpga@lfdr.de>; Thu,  7 Jan 2021 05:39:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726981AbhAGEjH (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 6 Jan 2021 23:39:07 -0500
Received: from mail-pl1-f174.google.com ([209.85.214.174]:39500 "EHLO
        mail-pl1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726507AbhAGEjD (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 6 Jan 2021 23:39:03 -0500
Received: by mail-pl1-f174.google.com with SMTP id x18so2853933pln.6;
        Wed, 06 Jan 2021 20:38:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NwmWunHGhkPrYk7MHr8GcLmC4MK/zPG197Zcurd95FY=;
        b=HgT3j+5HEfCdUJLm9gCAgF8UfxT9nMqhRD9IzTTdmTSJJTUxGvas+5coWNeQY0xoSD
         jTuMdGSFgdMZzbGAhvrZccFikaHUCxz1/75loHvYXSzDhRHFbnbnGa56Gf9YkOdbg4+q
         KZAKC4xh3m1x9hJ1ePvSEmcfMT3qEP+iawlfWJTneHPPT95OSIFhKmuYuas+iSTjCzRW
         mFenv3DHg31AulHZJHyy3FMABME1gVp3BCIghiE1PXFSAfzZxQEreeHcgaayuITZnOpM
         rJwxr1SXKJP8W5rt1tjRewjO5I0EX6uh+TlEtEi1NZ5Om2vuevNuSUz0YRuSK+9jSiSQ
         Zltw==
X-Gm-Message-State: AOAM5323pjSkjlGi/PcQ3LW84qghjh00GqVybB5ObZlbIbWrXxvmlBYJ
        DV08paRlj7aepOE+TiJ8hgw=
X-Google-Smtp-Source: ABdhPJwq0DH0ruhCLHSXwIHQrggZ9rAfy8TWY6+CmYy7t4GyB2KYW9D90rXD2eKhoehgdFFFBEq15A==
X-Received: by 2002:a17:90a:9707:: with SMTP id x7mr7616920pjo.72.1609994302067;
        Wed, 06 Jan 2021 20:38:22 -0800 (PST)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id ft19sm3538884pjb.44.2021.01.06.20.38.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jan 2021 20:38:21 -0800 (PST)
From:   Moritz Fischer <mdf@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        trix@redhat.com, moritzf@google.com,
        Moritz Fischer <mdf@kernel.org>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        Wu Hao <hao.wu@intel.com>
Subject: [PATCH 1/8] fpga: dfl: refactor cci_enumerate_feature_devs()
Date:   Wed,  6 Jan 2021 20:37:07 -0800
Message-Id: <20210107043714.991646-2-mdf@kernel.org>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210107043714.991646-1-mdf@kernel.org>
References: <20210107043714.991646-1-mdf@kernel.org>
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
2.30.0

