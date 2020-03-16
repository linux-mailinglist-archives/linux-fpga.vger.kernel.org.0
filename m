Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5274E186424
	for <lists+linux-fpga@lfdr.de>; Mon, 16 Mar 2020 05:19:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729586AbgCPETV (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 16 Mar 2020 00:19:21 -0400
Received: from mga12.intel.com ([192.55.52.136]:63079 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728940AbgCPETV (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 16 Mar 2020 00:19:21 -0400
IronPort-SDR: 5A4rjyD6Dh70x28j3k9f01DFF6mCeJDL4G3Brxet31nHLnKcOIw122Mlu5U+mq3EclcEXBI/s9
 31ZG7UKgdb6A==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2020 21:19:19 -0700
IronPort-SDR: hyeQeyd7hG16QZOg/F8qqhXU1KU2KvJ6cHwQyCHwH+n3DoyzMMOucpC1FKJY9wNecl+XdW5b7t
 rUYJnjSc/4Cg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,559,1574150400"; 
   d="scan'208";a="417007232"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.141])
  by orsmga005.jf.intel.com with ESMTP; 15 Mar 2020 21:19:18 -0700
From:   Xu Yilun <yilun.xu@intel.com>
To:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Xu Yilun <yilun.xu@intel.com>, Luwei Kang <luwei.kang@intel.com>,
        Wu Hao <hao.wu@intel.com>
Subject: [PATCH v2 2/7] fpga: dfl: pci: add irq info for feature devices enumeration
Date:   Mon, 16 Mar 2020 12:16:57 +0800
Message-Id: <1584332222-26652-3-git-send-email-yilun.xu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1584332222-26652-1-git-send-email-yilun.xu@intel.com>
References: <1584332222-26652-1-git-send-email-yilun.xu@intel.com>
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
----
v2: put irq resources init code inside cce_enumerate_feature_dev()
    Some minor changes for Hao's comments.
---
 drivers/fpga/dfl-pci.c | 78 ++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 69 insertions(+), 9 deletions(-)

diff --git a/drivers/fpga/dfl-pci.c b/drivers/fpga/dfl-pci.c
index 5387550..0b1ee7d 100644
--- a/drivers/fpga/dfl-pci.c
+++ b/drivers/fpga/dfl-pci.c
@@ -39,6 +39,28 @@ static void __iomem *cci_pci_ioremap_bar(struct pci_dev *pcidev, int bar)
 	return pcim_iomap_table(pcidev)[bar];
 }
 
+static int cci_pci_alloc_irq(struct pci_dev *pcidev)
+{
+	int nvec = pci_msix_vec_count(pcidev);
+	int ret;
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
@@ -78,17 +100,33 @@ static void cci_remove_feature_devs(struct pci_dev *pcidev)
 
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
 
@@ -97,11 +135,32 @@ static int cci_enumerate_feature_devs(struct pci_dev *pcidev)
 	if (!info)
 		return -ENOMEM;
 
+	/* add irq info for enumeration if the device support irq */
+	nvec = cci_pci_alloc_irq(pcidev);
+	if (nvec < 0) {
+		dev_err(&pcidev->dev, "Fail to alloc irq %d.\n", nvec);
+		ret = nvec;
+		goto enum_info_free_exit;
+	}
+
+	if (nvec) {
+		irq_table = cci_pci_create_irq_table(pcidev, nvec);
+		if (!irq_table) {
+			ret = -ENOMEM;
+			goto error_free_irq;
+		}
+
+		ret = dfl_fpga_enum_info_add_irq(info, nvec, irq_table);
+		kfree(irq_table);
+		if (ret)
+			goto error_free_irq;
+	}
+
 	/* start to find Device Feature List from Bar 0 */
 	base = cci_pci_ioremap_bar(pcidev, 0);
 	if (!base) {
 		ret = -ENOMEM;
-		goto enum_info_free_exit;
+		goto error_free_irq;
 	}
 
 	/*
@@ -154,7 +213,7 @@ static int cci_enumerate_feature_devs(struct pci_dev *pcidev)
 		dfl_fpga_enum_info_add_dfl(info, start, len, base);
 	} else {
 		ret = -ENODEV;
-		goto enum_info_free_exit;
+		goto error_free_irq;
 	}
 
 	/* start enumeration with prepared enumeration information */
@@ -162,11 +221,14 @@ static int cci_enumerate_feature_devs(struct pci_dev *pcidev)
 	if (IS_ERR(cdev)) {
 		dev_err(&pcidev->dev, "Enumeration failure\n");
 		ret = PTR_ERR(cdev);
-		goto enum_info_free_exit;
+		goto error_free_irq;
 	}
 
 	drvdata->cdev = cdev;
 
+error_free_irq:
+	if (ret)
+		cci_pci_free_irq(pcidev);
 enum_info_free_exit:
 	dfl_fpga_enum_info_free(info);
 
@@ -211,12 +273,10 @@ int cci_pci_probe(struct pci_dev *pcidev, const struct pci_device_id *pcidevid)
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

