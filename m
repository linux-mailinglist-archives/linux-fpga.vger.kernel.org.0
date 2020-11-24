Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39D5B2C2C12
	for <lists+linux-fpga@lfdr.de>; Tue, 24 Nov 2020 16:56:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389944AbgKXPzt (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 24 Nov 2020 10:55:49 -0500
Received: from mga02.intel.com ([134.134.136.20]:48016 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728411AbgKXPzs (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 24 Nov 2020 10:55:48 -0500
IronPort-SDR: GHWUwl2hYUKpjJXttbXvvpWnb2a75BrPcD1aHaE3qUXGkzbadECiW0w5Ph6eF27AU99FpoT9eO
 pqFF4GP5pPNA==
X-IronPort-AV: E=McAfee;i="6000,8403,9815"; a="159009678"
X-IronPort-AV: E=Sophos;i="5.78,366,1599548400"; 
   d="scan'208";a="159009678"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2020 07:55:43 -0800
IronPort-SDR: yD4PdLdmVNg1Jum32C6oqDO91RNWUuMHFEgf+QBuOjxRx7036OxzyX6y4hgVuNzEmn3jkH1aS5
 vuWwCTpN1ycQ==
X-IronPort-AV: E=Sophos;i="5.78,366,1599548400"; 
   d="scan'208";a="365051342"
Received: from rhweight-wrk1.ra.intel.com ([137.102.106.140])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2020 07:55:43 -0800
From:   matthew.gerlach@linux.intel.com
To:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        mdf@kernel.org, hao.wu@intel.com, trix@redhat.com,
        linux-doc@vger.kernel.org, corbet@lwn.net
Cc:     Matthew Gerlach <matthew.gerlach@linux.intel.com>
Subject: [PATCH v3 1/2] fpga: dfl: refactor cci_enumerate_feature_devs()
Date:   Tue, 24 Nov 2020 07:56:57 -0800
Message-Id: <20201124155658.700976-2-matthew.gerlach@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201124155658.700976-1-matthew.gerlach@linux.intel.com>
References: <20201124155658.700976-1-matthew.gerlach@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Matthew Gerlach <matthew.gerlach@linux.intel.com>

In preparation of looking for dfls based on a vendor
specific pcie capability, move code that assumes
Bar0/offset0 as start of DFL to its own function.

Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
---
v3: no change

v2: remove spurious blank lines
    rename find_dfl_in_bar0 to find_dfls_by_default
---
 drivers/fpga/dfl-pci.c | 84 +++++++++++++++++++++++-------------------
 1 file changed, 47 insertions(+), 37 deletions(-)

diff --git a/drivers/fpga/dfl-pci.c b/drivers/fpga/dfl-pci.c
index a2203d03c9e2..b27fae045536 100644
--- a/drivers/fpga/dfl-pci.c
+++ b/drivers/fpga/dfl-pci.c
@@ -119,49 +119,20 @@ static int *cci_pci_create_irq_table(struct pci_dev *pcidev, unsigned int nvec)
 	return table;
 }
 
-/* enumerate feature devices under pci device */
-static int cci_enumerate_feature_devs(struct pci_dev *pcidev)
+static int find_dfls_by_default(struct pci_dev *pcidev,
+				struct dfl_fpga_enum_info *info)
 {
-	struct cci_drvdata *drvdata = pci_get_drvdata(pcidev);
-	int port_num, bar, i, nvec, ret = 0;
-	struct dfl_fpga_enum_info *info;
-	struct dfl_fpga_cdev *cdev;
 	resource_size_t start, len;
+	int port_num, bar, i;
 	void __iomem *base;
-	int *irq_table;
+	int ret = 0;
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

