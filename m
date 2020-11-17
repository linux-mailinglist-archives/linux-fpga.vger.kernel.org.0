Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 835072B563E
	for <lists+linux-fpga@lfdr.de>; Tue, 17 Nov 2020 02:27:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731557AbgKQBYo (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 16 Nov 2020 20:24:44 -0500
Received: from mga07.intel.com ([134.134.136.100]:34910 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730966AbgKQBYm (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 16 Nov 2020 20:24:42 -0500
IronPort-SDR: q+kKG6HR9kG7altedAT1zNCCSZA4fULqBURvAQg81cEDxez/Lkpa7VhG0ybZIEeZZgioK+8MVb
 KJyDF/IAT0gw==
X-IronPort-AV: E=McAfee;i="6000,8403,9807"; a="234994420"
X-IronPort-AV: E=Sophos;i="5.77,484,1596524400"; 
   d="scan'208";a="234994420"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2020 17:24:37 -0800
IronPort-SDR: 0E3Y+YDZawR6b97yT7g10NIIhdek4kwRYDLUBKBhsQDiZzNlKkYkgZLwUhpDzLjYQt//mczPKm
 p1HkM4caH3MA==
X-IronPort-AV: E=Sophos;i="5.77,484,1596524400"; 
   d="scan'208";a="310060653"
Received: from rhweight-wrk1.ra.intel.com ([137.102.106.140])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2020 17:24:36 -0800
From:   matthew.gerlach@linux.intel.com
To:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        mdf@kernel.org, hao.wu@intel.com, trix@redhat.com,
        linux-doc@vger.kernel.org, corbet@lwn.net
Cc:     Matthew Gerlach <matthew.gerlach@linux.intel.com>
Subject: [PATCH 2/2] fpga: dfl: look for vendor specific capability
Date:   Mon, 16 Nov 2020 17:25:52 -0800
Message-Id: <20201117012552.262149-3-matthew.gerlach@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201117012552.262149-1-matthew.gerlach@linux.intel.com>
References: <20201117012552.262149-1-matthew.gerlach@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Matthew Gerlach <matthew.gerlach@linux.intel.com>

A DFL may not begin at offset 0 of BAR 0.  A PCIe vendor
specific capability can be used to specify the start of a
number of DFLs.

Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
---
 Documentation/fpga/dfl.rst | 10 +++++
 drivers/fpga/dfl-pci.c     | 88 +++++++++++++++++++++++++++++++++++++-
 2 files changed, 97 insertions(+), 1 deletion(-)

diff --git a/Documentation/fpga/dfl.rst b/Documentation/fpga/dfl.rst
index 0404fe6ffc74..c81ceb1e79e2 100644
--- a/Documentation/fpga/dfl.rst
+++ b/Documentation/fpga/dfl.rst
@@ -501,6 +501,16 @@ Developer only needs to provide a sub feature driver with matched feature id.
 FME Partial Reconfiguration Sub Feature driver (see drivers/fpga/dfl-fme-pr.c)
 could be a reference.
 
+Location of DFLs on PCI bus
+===========================
+The start of the DFL is assumed to be offset 0 of bar 0.
+Alternatively, a vendor specific capability structure can be used to
+specify the location of one or more DFLs.  Intel has reserved the
+vendor specific id of 0x43 for this purpose.  The vendor specific
+data begins with a 4 byte count of the number of DFLs followed 4 byte
+Offset/BIR fields for each DFL. Bits 2:0 of Offset/BIR field indicates
+the BAR, and bits 31:3 form the 8 byte aligned offset where bits 2:0 are
+zero.
 
 Open discussion
 ===============
diff --git a/drivers/fpga/dfl-pci.c b/drivers/fpga/dfl-pci.c
index b1b157b41942..5418e8bf2496 100644
--- a/drivers/fpga/dfl-pci.c
+++ b/drivers/fpga/dfl-pci.c
@@ -27,6 +27,13 @@
 #define DRV_VERSION	"0.8"
 #define DRV_NAME	"dfl-pci"
 
+#define PCI_VNDR_ID_DFLS 0x43
+
+#define PCI_VNDR_DFLS_CNT_OFFSET 8
+#define PCI_VNDR_DFLS_RES_OFFSET 0x0c
+
+#define PCI_VND_DFLS_RES_BAR_MASK 0x7
+
 struct cci_drvdata {
 	struct dfl_fpga_cdev *cdev;	/* container device */
 };
@@ -119,6 +126,82 @@ static int *cci_pci_create_irq_table(struct pci_dev *pcidev, unsigned int nvec)
 	return table;
 }
 
+static int find_dfl_in_cfg(struct pci_dev *pcidev,
+			   struct dfl_fpga_enum_info *info)
+{
+	u32 bar, offset, vndr_hdr, dfl_cnt, dfl_res;
+	int dfl_res_off, i, voff = 0;
+	resource_size_t start, len;
+
+	while ((voff = pci_find_next_ext_capability(pcidev, voff, PCI_EXT_CAP_ID_VNDR))) {
+
+		pci_read_config_dword(pcidev, voff + PCI_VNDR_HEADER, &vndr_hdr);
+
+		dev_dbg(&pcidev->dev,
+			"vendor-specific capability id 0x%x, rev 0x%x len 0x%x\n",
+			PCI_VNDR_HEADER_ID(vndr_hdr),
+			PCI_VNDR_HEADER_REV(vndr_hdr),
+			PCI_VNDR_HEADER_LEN(vndr_hdr));
+
+		if (PCI_VNDR_HEADER_ID(vndr_hdr) == PCI_VNDR_ID_DFLS)
+			break;
+	}
+
+	if (!voff) {
+		dev_dbg(&pcidev->dev, "%s no VSEC found\n", __func__);
+		return -ENODEV;
+	}
+
+	pci_read_config_dword(pcidev, voff + PCI_VNDR_DFLS_CNT_OFFSET, &dfl_cnt);
+	dev_info(&pcidev->dev, "dfl_cnt %d\n", dfl_cnt);
+	for (i = 0; i < dfl_cnt; i++) {
+		dfl_res_off = voff + PCI_VNDR_DFLS_RES_OFFSET +
+				      (i * sizeof(dfl_res));
+		pci_read_config_dword(pcidev, dfl_res_off, &dfl_res);
+
+		dev_dbg(&pcidev->dev, "dfl_res 0x%x\n", dfl_res);
+
+		bar = dfl_res & PCI_VND_DFLS_RES_BAR_MASK;
+
+		if (bar >= PCI_STD_NUM_BARS) {
+			dev_err(&pcidev->dev, "%s bad bar number %d\n",
+				__func__, bar);
+			return -EINVAL;
+		}
+
+		len = pci_resource_len(pcidev, bar);
+
+		if (len == 0) {
+			dev_err(&pcidev->dev, "%s unmapped bar number %d\n",
+				__func__, bar);
+			return -EINVAL;
+		}
+
+		offset = dfl_res & ~PCI_VND_DFLS_RES_BAR_MASK;
+
+		if (offset >= len) {
+			dev_err(&pcidev->dev, "%s bad offset %u >= %llu\n",
+				__func__, offset, len);
+			return -EINVAL;
+		}
+
+		dev_info(&pcidev->dev, "%s BAR %d offset 0x%x\n", __func__, bar, offset);
+
+		start = pci_resource_start(pcidev, bar) + offset;
+		len -= offset;
+
+		if (!PAGE_ALIGNED(start)) {
+			dev_err(&pcidev->dev, "%s unaliged start 0x%llx\n",
+				__func__, start);
+			return -EINVAL;
+		}
+
+		dfl_fpga_enum_info_add_dfl(info, start, len);
+	}
+
+	return 0;
+}
+
 static int find_dfl_in_bar0(struct pci_dev *pcidev,
 			    struct dfl_fpga_enum_info *info)
 {
@@ -221,7 +304,10 @@ static int cci_enumerate_feature_devs(struct pci_dev *pcidev)
 			goto irq_free_exit;
 	}
 
-	ret = find_dfl_in_bar0(pcidev, info);
+	ret = find_dfl_in_cfg(pcidev, info);
+
+	if (ret)
+		ret = find_dfl_in_bar0(pcidev, info);
 
 	if (ret)
 		goto irq_free_exit;
-- 
2.25.2

