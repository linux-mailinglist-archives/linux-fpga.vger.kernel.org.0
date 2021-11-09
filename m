Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC02F44B08E
	for <lists+linux-fpga@lfdr.de>; Tue,  9 Nov 2021 16:41:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238194AbhKIPoR (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 9 Nov 2021 10:44:17 -0500
Received: from mga17.intel.com ([192.55.52.151]:1675 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237909AbhKIPoQ (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 9 Nov 2021 10:44:16 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10162"; a="213194792"
X-IronPort-AV: E=Sophos;i="5.87,220,1631602800"; 
   d="scan'208";a="213194792"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2021 07:41:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,220,1631602800"; 
   d="scan'208";a="669442248"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 09 Nov 2021 07:41:28 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 1338E155; Tue,  9 Nov 2021 17:41:29 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Moritz Fischer <mdf@kernel.org>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Wu Hao <hao.wu@intel.com>, Tom Rix <trix@redhat.com>,
        Xu Yilun <yilun.xu@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] fpga: dfl: pci: Use pci_find_vsec_capability() when looking for DFL
Date:   Tue,  9 Nov 2021 17:41:27 +0200
Message-Id: <20211109154127.18455-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Currently the find_dfls_by_vsec() opens code pci_find_vsec_capability().
Refactor the former to use the latter. No functional change intended.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/fpga/dfl-pci.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/drivers/fpga/dfl-pci.c b/drivers/fpga/dfl-pci.c
index 4d68719e608f..52b5e94db9c3 100644
--- a/drivers/fpga/dfl-pci.c
+++ b/drivers/fpga/dfl-pci.c
@@ -27,7 +27,7 @@
 #define DRV_VERSION	"0.8"
 #define DRV_NAME	"dfl-pci"
 
-#define PCI_VSEC_ID_INTEL_DFLS 0x43
+#define PCI_VSEC_ID_INTEL_DFLS	0x0043	/* FPGA Device Feature List */
 
 #define PCI_VNDR_DFLS_CNT 0x8
 #define PCI_VNDR_DFLS_RES 0xc
@@ -138,19 +138,12 @@ static int *cci_pci_create_irq_table(struct pci_dev *pcidev, unsigned int nvec)
 
 static int find_dfls_by_vsec(struct pci_dev *pcidev, struct dfl_fpga_enum_info *info)
 {
-	u32 bir, offset, vndr_hdr, dfl_cnt, dfl_res;
-	int dfl_res_off, i, bars, voff = 0;
+	u32 bir, offset, dfl_cnt, dfl_res;
 	resource_size_t start, len;
+	int dfl_res_off, i, bars;
+	u16 voff;
 
-	while ((voff = pci_find_next_ext_capability(pcidev, voff, PCI_EXT_CAP_ID_VNDR))) {
-		vndr_hdr = 0;
-		pci_read_config_dword(pcidev, voff + PCI_VNDR_HEADER, &vndr_hdr);
-
-		if (PCI_VNDR_HEADER_ID(vndr_hdr) == PCI_VSEC_ID_INTEL_DFLS &&
-		    pcidev->vendor == PCI_VENDOR_ID_INTEL)
-			break;
-	}
-
+	voff = pci_find_vsec_capability(dev, PCI_VENDOR_ID_INTEL, PCI_VSEC_ID_INTEL_DFLS);
 	if (!voff) {
 		dev_dbg(&pcidev->dev, "%s no DFL VSEC found\n", __func__);
 		return -ENODEV;
-- 
2.33.0

