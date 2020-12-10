Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 172FA2D62C7
	for <lists+linux-fpga@lfdr.de>; Thu, 10 Dec 2020 17:59:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390527AbgLJQ7p (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 10 Dec 2020 11:59:45 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44648 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392160AbgLJQ7A (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 10 Dec 2020 11:59:00 -0500
Received: by mail-pf1-f193.google.com with SMTP id f9so4649212pfc.11
        for <linux-fpga@vger.kernel.org>; Thu, 10 Dec 2020 08:58:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h2oSgYeQZxR87ohN6KF0gETYZLnwVlanqQCGgABmfao=;
        b=LMB69VwPWmboPvdPNRelgc6iWnFkRbmOfY2Y2SV2NAOv3Nj0IS1UvFCcOkbhAlVc9y
         aYPjmphfCZjfO4qsOqIm/aHxeANT0C8hUgj46D665t1r48liVzroMAx/GXUPQYB1vbxR
         R3CaTcKvIny2zlSzUu5KFUpwGOUpa8AAOpaFcrAAI1fV3byO1RRLLQOwgDJSK79pZ/7X
         HIztLTqSjT3m/cS6XfCAaZNXKAMTUxPNrWWpY/moRbcqCMXX1cvlkQ5Or5Fc2BATBn6e
         baim3LAgepSDHfnETJp7sl+Zv47wU2w3holckikbnBavdVgzI0xN6NwEzrWcF5Lw1nDD
         cIXQ==
X-Gm-Message-State: AOAM5322skqC6Bm7PBgh0s2QcASXcgHc4luVBgkK97TRd1u6kGkNRYcK
        lLJYrAy3ocGXWcGAR2uJDyk=
X-Google-Smtp-Source: ABdhPJwIbgwUEEch9Rksk4U2BL24NjlR5RyLMOhEfnA9gzxCmSs9LspZu/hrHqhgbAtGqiBsw12WJA==
X-Received: by 2002:a65:5b84:: with SMTP id i4mr7458053pgr.282.1607619499622;
        Thu, 10 Dec 2020 08:58:19 -0800 (PST)
Received: from localhost ([2601:647:5b00:1162:1ac0:17a6:4cc6:d1ef])
        by smtp.gmail.com with ESMTPSA id y19sm6784224pfp.211.2020.12.10.08.58.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Dec 2020 08:58:18 -0800 (PST)
From:   Moritz Fischer <mdf@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-fpga@vger.kernel.org, trix@redhat.com, hao.wu@intel.com,
        yilun.xu@intel.com, russell.h.weight@intel.com,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        Moritz Fischer <mdf@kernel.org>
Subject: [PATCH 2/8] fpga: dfl-pci: locate DFLs by PCIe vendor specific capability
Date:   Thu, 10 Dec 2020 08:57:58 -0800
Message-Id: <20201210165804.44234-3-mdf@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201210165804.44234-1-mdf@kernel.org>
References: <20201210165804.44234-1-mdf@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Matthew Gerlach <matthew.gerlach@linux.intel.com>

A PCIe vendor specific extended capability is introduced by Intel to
specify the start of a number of DFLs.

Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
Signed-off-by: Moritz Fischer <mdf@kernel.org>
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
2.29.2

