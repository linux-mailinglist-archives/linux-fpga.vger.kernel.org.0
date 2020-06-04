Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 580131EE037
	for <lists+linux-fpga@lfdr.de>; Thu,  4 Jun 2020 10:56:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728261AbgFDI4C (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 4 Jun 2020 04:56:02 -0400
Received: from mga05.intel.com ([192.55.52.43]:40369 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726664AbgFDI4B (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 4 Jun 2020 04:56:01 -0400
IronPort-SDR: p4pklDfjsusg4FZApqmYI0mPo69NIpFDFTGXaacl52NVoyhUO+gy7x/DrfxmlEnTwmKg+a1Hje
 OBSeeURD4X3Q==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2020 01:56:01 -0700
IronPort-SDR: NAdP+arg4xkvYmJHpG+Dw8IUIKfS9et5IrtXv7/jnpWvvhRbczTdZCAyPgAW5nBtqcXJxOjbsF
 9YtRbEMIOq9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,471,1583222400"; 
   d="scan'208";a="348039139"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.141])
  by orsmga001.jf.intel.com with ESMTP; 04 Jun 2020 01:55:58 -0700
From:   Xu Yilun <yilun.xu@intel.com>
To:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, bhu@redhat.com, mtosatti@redhat.com,
        gregkh@linuxfoundation.org, Xu Yilun <yilun.xu@intel.com>,
        Luwei Kang <luwei.kang@intel.com>, Wu Hao <hao.wu@intel.com>
Subject: [PATCH v6 2/7] fpga: dfl: pci: add irq info for feature devices enumeration
Date:   Thu,  4 Jun 2020 16:52:12 +0800
Message-Id: <1591260737-15211-3-git-send-email-yilun.xu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1591260737-15211-1-git-send-email-yilun.xu@intel.com>
References: <1591260737-15211-1-git-send-email-yilun.xu@intel.com>
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
Reviewed-by: Marcelo Tosatti <mtosatti@redhat.com>
Acked-by: Wu Hao <hao.wu@intel.com>
----
v2: put irq resources init code inside cce_enumerate_feature_dev()
    Some minor changes for Hao's comments.
v3: Some minor fix for Hao's comments for v2.
v4: Some minor fix for Hao's comments for v3.
v5: No change.
v6: Some minor fix for Moritz's comments.
---
 drivers/fpga/dfl-pci.c | 81 ++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 72 insertions(+), 9 deletions(-)

diff --git a/drivers/fpga/dfl-pci.c b/drivers/fpga/dfl-pci.c
index 5387550..e3dc4fc 100644
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
@@ -78,17 +99,39 @@ static void cci_remove_feature_devs(struct pci_dev *pcidev)
 
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
+	if (!table)
+		return table;
+
+	for (i = 0; i < nvec; i++)
+		table[i] = pci_irq_vector(pcidev, i);
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
 
@@ -97,11 +140,30 @@ static int cci_enumerate_feature_devs(struct pci_dev *pcidev)
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
@@ -154,7 +216,7 @@ static int cci_enumerate_feature_devs(struct pci_dev *pcidev)
 		dfl_fpga_enum_info_add_dfl(info, start, len, base);
 	} else {
 		ret = -ENODEV;
-		goto enum_info_free_exit;
+		goto irq_free_exit;
 	}
 
 	/* start enumeration with prepared enumeration information */
@@ -162,11 +224,14 @@ static int cci_enumerate_feature_devs(struct pci_dev *pcidev)
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
 
@@ -211,12 +276,10 @@ int cci_pci_probe(struct pci_dev *pcidev, const struct pci_device_id *pcidevid)
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

