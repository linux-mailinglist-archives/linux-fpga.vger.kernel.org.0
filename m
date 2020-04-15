Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C656B1A9A04
	for <lists+linux-fpga@lfdr.de>; Wed, 15 Apr 2020 12:10:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2896242AbgDOKKb (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 15 Apr 2020 06:10:31 -0400
Received: from mga03.intel.com ([134.134.136.65]:27976 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2896233AbgDOKKY (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 15 Apr 2020 06:10:24 -0400
IronPort-SDR: BkKyg7pWZqoKbAKW8ctwAl9qwtbg6UF3HgOQbwecE92OkIX9V13fPP9l+qHZe8usxGPlNQHMVO
 Go42Vjv3YymA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2020 03:10:23 -0700
IronPort-SDR: RE2QLVsUalbFxLxOmYFP2HflNlOwfygQ00LDi6fvhM1Yp5geceooKi24OnUiw5wJhPSGyHCVUb
 X0X/7dcrqzUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,386,1580803200"; 
   d="scan'208";a="253482919"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.141])
  by orsmga003.jf.intel.com with ESMTP; 15 Apr 2020 03:10:21 -0700
From:   Xu Yilun <yilun.xu@intel.com>
To:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, bhu@redhat.com, Xu Yilun <yilun.xu@intel.com>,
        Luwei Kang <luwei.kang@intel.com>, Wu Hao <hao.wu@intel.com>
Subject: [PATCH v4 2/7] fpga: dfl: pci: add irq info for feature devices enumeration
Date:   Wed, 15 Apr 2020 18:07:30 +0800
Message-Id: <1586945255-30823-3-git-send-email-yilun.xu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1586945255-30823-1-git-send-email-yilun.xu@intel.com>
References: <1586945255-30823-1-git-send-email-yilun.xu@intel.com>
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Some DFL FPGA PCIe cards (e.g. Intel FPGA Programmable Acceleration
Card) support MSI-X based interrupts. This patch allows PCIe driver
to prepare and pass interrupt resources to DFL via enumeration API.
These interrupt resources could then be assigned to actual features
which use them.

Signed-off-by: Luwei Kang <luwei.kang@intel.com>
Signed-off-by: Wu Hao <hao.wu@intel.com>
Signed-off-by: Xu Yilun <yilun.xu@intel.com>
Acked-by: Wu Hao <hao.wu@intel.com>
----
v2: put irq resources init code inside cce_enumerate_feature_dev()
    Some minor changes for Hao's comments.
v3: Some minor fix for Hao's comments for v2.
v4: Some minor fix for Hao's comments for v3.
---
 drivers/fpga/dfl-pci.c | 80 ++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 71 insertions(+), 9 deletions(-)

diff --git a/drivers/fpga/dfl-pci.c b/drivers/fpga/dfl-pci.c
index 5387550..9e39d7a 100644
--- a/drivers/fpga/dfl-pci.c
+++ b/drivers/fpga/dfl-pci.c
@@ -39,6 +39,27 @@ static void __iomem *cci_pci_ioremap_bar(struct pci_dev *pcidev, int bar)
 	return pcim_iomap_table(pcidev)[bar];
 }
 
+static int cci_pci_alloc_irq(struct pci_dev *pcidev)
+{
+	int ret, nvec = pci_msix_vec_count(pcidev);
+
+	if (nvec <= 0) {
+		dev_dbg(&pcidev->dev, "fpga interrupt not supported\n");
+		return 0;
+	}
+
+	ret = pci_alloc_irq_vectors(pcidev, nvec, nvec, PCI_IRQ_MSIX);
+	if (ret < 0)
+		return ret;
+
+	return nvec;
+}
+
+static void cci_pci_free_irq(struct pci_dev *pcidev)
+{
+	pci_free_irq_vectors(pcidev);
+}
+
 /* PCI Device ID */
 #define PCIE_DEVICE_ID_PF_INT_5_X	0xBCBD
 #define PCIE_DEVICE_ID_PF_INT_6_X	0xBCC0
@@ -78,17 +99,38 @@ static void cci_remove_feature_devs(struct pci_dev *pcidev)
 
 	/* remove all children feature devices */
 	dfl_fpga_feature_devs_remove(drvdata->cdev);
+	cci_pci_free_irq(pcidev);
+}
+
+static int *cci_pci_create_irq_table(struct pci_dev *pcidev, unsigned int nvec)
+{
+	unsigned int i;
+	int *table;
+
+	table = kcalloc(nvec, sizeof(int), GFP_KERNEL);
+	if (table) {
+		for (i = 0; i < nvec; i++)
+			table[i] = pci_irq_vector(pcidev, i);
+	}
+
+	return table;
+}
+
+static void cci_pci_free_irq_table(int *table)
+{
+	kfree(table);
 }
 
 /* enumerate feature devices under pci device */
 static int cci_enumerate_feature_devs(struct pci_dev *pcidev)
 {
 	struct cci_drvdata *drvdata = pci_get_drvdata(pcidev);
+	int port_num, bar, i, nvec, ret = 0;
 	struct dfl_fpga_enum_info *info;
 	struct dfl_fpga_cdev *cdev;
 	resource_size_t start, len;
-	int port_num, bar, i, ret = 0;
 	void __iomem *base;
+	int *irq_table;
 	u32 offset;
 	u64 v;
 
@@ -97,11 +139,30 @@ static int cci_enumerate_feature_devs(struct pci_dev *pcidev)
 	if (!info)
 		return -ENOMEM;
 
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
+		cci_pci_free_irq_table(irq_table);
+		if (ret)
+			goto irq_free_exit;
+	}
+
 	/* start to find Device Feature List from Bar 0 */
 	base = cci_pci_ioremap_bar(pcidev, 0);
 	if (!base) {
 		ret = -ENOMEM;
-		goto enum_info_free_exit;
+		goto irq_free_exit;
 	}
 
 	/*
@@ -154,7 +215,7 @@ static int cci_enumerate_feature_devs(struct pci_dev *pcidev)
 		dfl_fpga_enum_info_add_dfl(info, start, len, base);
 	} else {
 		ret = -ENODEV;
-		goto enum_info_free_exit;
+		goto irq_free_exit;
 	}
 
 	/* start enumeration with prepared enumeration information */
@@ -162,11 +223,14 @@ static int cci_enumerate_feature_devs(struct pci_dev *pcidev)
 	if (IS_ERR(cdev)) {
 		dev_err(&pcidev->dev, "Enumeration failure\n");
 		ret = PTR_ERR(cdev);
-		goto enum_info_free_exit;
+		goto irq_free_exit;
 	}
 
 	drvdata->cdev = cdev;
 
+irq_free_exit:
+	if (ret)
+		cci_pci_free_irq(pcidev);
 enum_info_free_exit:
 	dfl_fpga_enum_info_free(info);
 
@@ -211,12 +275,10 @@ int cci_pci_probe(struct pci_dev *pcidev, const struct pci_device_id *pcidevid)
 	}
 
 	ret = cci_enumerate_feature_devs(pcidev);
-	if (ret) {
-		dev_err(&pcidev->dev, "enumeration failure %d.\n", ret);
-		goto disable_error_report_exit;
-	}
+	if (!ret)
+		return ret;
 
-	return ret;
+	dev_err(&pcidev->dev, "enumeration failure %d.\n", ret);
 
 disable_error_report_exit:
 	pci_disable_pcie_error_reporting(pcidev);
-- 
2.7.4

