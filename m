Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7E142CDC40
	for <lists+linux-fpga@lfdr.de>; Thu,  3 Dec 2020 18:19:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728750AbgLCRR6 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 3 Dec 2020 12:17:58 -0500
Received: from mga17.intel.com ([192.55.52.151]:56029 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731416AbgLCRR6 (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 3 Dec 2020 12:17:58 -0500
IronPort-SDR: w2ivBGOykBHnyrJm4CM9XvRIzMptEl0OjhkailVuVfKS7cR7F+9Hg+dwIAYGPWMrAgabEx2R2m
 WHZyQQf35GMQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9824"; a="153060637"
X-IronPort-AV: E=Sophos;i="5.78,389,1599548400"; 
   d="scan'208";a="153060637"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2020 09:14:36 -0800
IronPort-SDR: 2U/PH/zWXUMraBvOVHZ0Jy+1vTrDlfXHV3+NJLPPKjtnV8VwxC7gV6AOkGQntccCXodJPWLSp2
 /IQC1sInZfrA==
X-IronPort-AV: E=Sophos;i="5.78,390,1599548400"; 
   d="scan'208";a="336032790"
Received: from rhweight-wrk1.ra.intel.com ([137.102.106.140])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2020 09:14:35 -0800
From:   matthew.gerlach@linux.intel.com
To:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        mdf@kernel.org, hao.wu@intel.com, trix@redhat.com,
        linux-doc@vger.kernel.org, corbet@lwn.net
Cc:     Matthew Gerlach <matthew.gerlach@linux.intel.com>
Subject: [PATCH v4 2/2] fpga: dfl-pci: locate DFLs by PCIe vendor specific capability
Date:   Thu,  3 Dec 2020 09:15:48 -0800
Message-Id: <20201203171548.1538178-3-matthew.gerlach@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201203171548.1538178-1-matthew.gerlach@linux.intel.com>
References: <20201203171548.1538178-1-matthew.gerlach@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Matthew Gerlach <matthew.gerlach@linux.intel.com>

A PCIe vendor specific extended capability is introduced by Intel to
specify the start of a number of DFLs.

Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
---
v4: Clarify PCI vs. PCIe in documentation
    Various cleanup suggested by hao.wu@intel.com
    Document and enforce specifying a single DFL per BAR

v3: Add text and ascii art to documentation.
    Ensure not to exceed PCIe config space in loop.

v2: Update documentation for clarity.
    Clean up  macro names.
    Use GENMASK.
    Removed spurious blank lines.
    Changed some calls from dev_info to dev_dbg.
    Specifically check for VSEC not found, -ENODEV.
    Ensure correct pci vendor id.
    Remove check for page alignment.
    Rename find_dfl_in_cfg to find_dfls_by_vsec.
    Initialize target memory of pci_read_config_dword to invalid values before use.
---
 Documentation/fpga/dfl.rst | 27 ++++++++++++
 drivers/fpga/dfl-pci.c     | 87 +++++++++++++++++++++++++++++++++++++-
 2 files changed, 113 insertions(+), 1 deletion(-)

diff --git a/Documentation/fpga/dfl.rst b/Documentation/fpga/dfl.rst
index 0404fe6ffc74..ea8cefc18bdb 100644
--- a/Documentation/fpga/dfl.rst
+++ b/Documentation/fpga/dfl.rst
@@ -501,6 +501,33 @@ Developer only needs to provide a sub feature driver with matched feature id.
 FME Partial Reconfiguration Sub Feature driver (see drivers/fpga/dfl-fme-pr.c)
 could be a reference.
 
+Location of DFLs on a PCI Device
+===========================
+The original method for finding a DFL on a PCI device assumed the start of the
+first DFL to offset 0 of bar 0.  If the first node of the DFL is an FME,
+then further DFLs in the port(s) are specified in FME header registers.
+Alternatively, a PCIe vendor specific capability structure can be used to
+specify the location of all the DFLs on the device, providing flexibility
+for the type of starting node in the DFL.  Intel has reserved the
+VSEC ID of 0x43 for this purpose.  The vendor specific
+data begins with a 4 byte vendor specific register for the number of DFLs followed 4 byte
+Offset/BIR vendor specific registers for each DFL. Bits 2:0 of Offset/BIR register
+indicates the BAR, and bits 31:3 form the 8 byte aligned offset where bits 2:0 are
+zero.
+
+        +----------------------------+
+        |31     Number of DFLS      0|
+        +----------------------------+
+        |31     Offset     3|2 BIR  0|
+        +----------------------------+
+                      . . .
+        +----------------------------+
+        |31     Offset     3|2 BIR  0|
+        +----------------------------+
+
+Being able to specify more than one DFL per BAR has been considered, but it
+was determined the use case did not provide value.  Specifying a single DFL
+per BAR simplifies the implementation and allows for extra error checking.
 
 Open discussion
 ===============
diff --git a/drivers/fpga/dfl-pci.c b/drivers/fpga/dfl-pci.c
index 5100695e27cd..04e47e266f26 100644
--- a/drivers/fpga/dfl-pci.c
+++ b/drivers/fpga/dfl-pci.c
@@ -27,6 +27,14 @@
 #define DRV_VERSION	"0.8"
 #define DRV_NAME	"dfl-pci"
 
+#define PCI_VSEC_ID_INTEL_DFLS 0x43
+
+#define PCI_VNDR_DFLS_CNT 0x8
+#define PCI_VNDR_DFLS_RES 0xc
+
+#define PCI_VNDR_DFLS_RES_BAR_MASK GENMASK(2, 0)
+#define PCI_VNDR_DFLS_RES_OFF_MASK GENMASK(31, 3)
+
 struct cci_drvdata {
 	struct dfl_fpga_cdev *cdev;	/* container device */
 };
@@ -119,6 +127,80 @@ static int *cci_pci_create_irq_table(struct pci_dev *pcidev, unsigned int nvec)
 	return table;
 }
 
+static int find_dfls_by_vsec(struct pci_dev *pcidev, struct dfl_fpga_enum_info *info)
+{
+	u32 bir, offset, vndr_hdr, dfl_cnt, dfl_res;
+	int dfl_res_off, i, bars, voff = 0;
+	resource_size_t start, len;
+
+	while ((voff = pci_find_next_ext_capability(pcidev, voff, PCI_EXT_CAP_ID_VNDR))) {
+		vndr_hdr = 0;
+		pci_read_config_dword(pcidev, voff + PCI_VNDR_HEADER, &vndr_hdr);
+
+		if (PCI_VNDR_HEADER_ID(vndr_hdr) == PCI_VSEC_ID_INTEL_DFLS &&
+		    pcidev->vendor == PCI_VENDOR_ID_INTEL)
+			break;
+	}
+
+	if (!voff) {
+		dev_dbg(&pcidev->dev, "%s no DFL VSEC found\n", __func__);
+		return -ENODEV;
+	}
+
+	dfl_cnt = 0;
+	pci_read_config_dword(pcidev, voff + PCI_VNDR_DFLS_CNT, &dfl_cnt);
+	if (dfl_cnt > PCI_STD_NUM_BARS) {
+		dev_err(&pcidev->dev, "%s too many DFLs %d > %d\n",
+			__func__, dfl_cnt, PCI_STD_NUM_BARS);
+		return -EINVAL;
+	}
+
+	dfl_res_off = voff + PCI_VNDR_DFLS_RES;
+	if (dfl_res_off + (dfl_cnt * sizeof(u32)) > PCI_CFG_SPACE_EXP_SIZE) {
+		dev_err(&pcidev->dev, "%s DFL VSEC too big for PCIe config space\n",
+			__func__);
+		return -EINVAL;
+	}
+
+	for (i = 0, bars = 0; i < dfl_cnt; i++, dfl_res_off += sizeof(u32)) {
+		dfl_res = GENMASK(31, 0);
+		pci_read_config_dword(pcidev, dfl_res_off, &dfl_res);
+
+		bir = dfl_res & PCI_VNDR_DFLS_RES_BAR_MASK;
+		if (bir >= PCI_STD_NUM_BARS) {
+			dev_err(&pcidev->dev, "%s bad bir number %d\n",
+				__func__, bir);
+			return -EINVAL;
+		}
+
+		if (bars & BIT(bir)) {
+			dev_err(&pcidev->dev, "%s DFL for BAR %d already specified\n",
+				__func__, bir);
+			return -EINVAL;
+		}
+
+		bars |= BIT(bir);
+
+		len = pci_resource_len(pcidev, bir);
+		offset = dfl_res & PCI_VNDR_DFLS_RES_OFF_MASK;
+		if (offset >= len) {
+			dev_err(&pcidev->dev, "%s bad offset %u >= %pa\n",
+				__func__, offset, &len);
+			return -EINVAL;
+		}
+
+		dev_dbg(&pcidev->dev, "%s BAR %d offset 0x%x\n", __func__, bir, offset);
+
+		len -= offset;
+
+		start = pci_resource_start(pcidev, bir) + offset;
+
+		dfl_fpga_enum_info_add_dfl(info, start, len);
+	}
+
+	return 0;
+}
+
 /* default method of finding dfls starting at offset 0 of bar 0 */
 static int find_dfls_by_default(struct pci_dev *pcidev,
 				struct dfl_fpga_enum_info *info)
@@ -220,7 +302,10 @@ static int cci_enumerate_feature_devs(struct pci_dev *pcidev)
 			goto irq_free_exit;
 	}
 
-	ret = find_dfls_by_default(pcidev, info);
+	ret = find_dfls_by_vsec(pcidev, info);
+	if (ret == -ENODEV)
+		ret = find_dfls_by_default(pcidev, info);
+
 	if (ret)
 		goto irq_free_exit;
 
-- 
2.25.2

