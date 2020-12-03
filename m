Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E3032CDC3C
	for <lists+linux-fpga@lfdr.de>; Thu,  3 Dec 2020 18:19:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731514AbgLCRRd (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 3 Dec 2020 12:17:33 -0500
Received: from mga17.intel.com ([192.55.52.151]:55799 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731536AbgLCRRc (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 3 Dec 2020 12:17:32 -0500
IronPort-SDR: 4YWPoOk3tos42SZwj2qPi3NjJ7jBfisEbYSBuV7edBQ0oNTGVNouLdffruENo/m4xdprH0KIHw
 KdDvNIB6CIpw==
X-IronPort-AV: E=McAfee;i="6000,8403,9824"; a="153060636"
X-IronPort-AV: E=Sophos;i="5.78,389,1599548400"; 
   d="scan'208";a="153060636"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2020 09:14:36 -0800
IronPort-SDR: SqsLwTO1sTrqfCrt46lbYdSb/uEal5pMBkA3pU+OZexka/5y3pE2bveJFX8/3UXcVPO/r1Q86p
 GWd6M8IT1hZw==
X-IronPort-AV: E=Sophos;i="5.78,390,1599548400"; 
   d="scan'208";a="336032787"
Received: from rhweight-wrk1.ra.intel.com ([137.102.106.140])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2020 09:14:35 -0800
From:   matthew.gerlach@linux.intel.com
To:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        mdf@kernel.org, hao.wu@intel.com, trix@redhat.com,
        linux-doc@vger.kernel.org, corbet@lwn.net
Cc:     Matthew Gerlach <matthew.gerlach@linux.intel.com>
Subject: [PATCH v4 1/2] fpga: dfl: refactor cci_enumerate_feature_devs()
Date:   Thu,  3 Dec 2020 09:15:47 -0800
Message-Id: <20201203171548.1538178-2-matthew.gerlach@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201203171548.1538178-1-matthew.gerlach@linux.intel.com>
References: <20201203171548.1538178-1-matthew.gerlach@linux.intel.com>
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
---
v4: add comment
    squash local variable definition

v3: no change

v2: remove spurious blank lines
    rename find_dfl_in_bar0 to find_dfls_by_default
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
2.25.2

